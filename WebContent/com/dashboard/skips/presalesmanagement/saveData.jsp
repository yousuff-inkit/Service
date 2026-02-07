<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.email.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();    
	 	Statement stmt1 = conn.createStatement();   
	 	String qottrno=request.getParameter("qottrno")==null || request.getParameter("qottrno").trim()==""?"0":request.getParameter("qottrno").trim();
		String docno=request.getParameter("docno")==null || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();  
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		String siteid=request.getParameter("siteid")==null || request.getParameter("siteid").trim()==""?"0":request.getParameter("siteid").trim();
		String route=request.getParameter("route")==null || request.getParameter("route").trim()==""?"":request.getParameter("route").trim();
		String gpsx=request.getParameter("gpsx")==null || request.getParameter("gpsx").trim()==""?"":request.getParameter("gpsx").trim();
		String gpsy=request.getParameter("gpsy")==null || request.getParameter("gpsy").trim()==""?"":request.getParameter("gpsy").trim();
		String desc=request.getParameter("desc")==null || request.getParameter("desc").trim()==""?"":request.getParameter("desc").trim();
		String saldocno=request.getParameter("saldocno")==null?"":request.getParameter("saldocno").trim();
		String salname=request.getParameter("salname")==null?"":request.getParameter("salname").trim();  
		String proname=request.getParameter("proname")==null?"":request.getParameter("proname").trim();
		String prdocno=request.getParameter("prdocno")==null?"":request.getParameter("prdocno").trim();
		String prname=request.getParameter("prname")==null?"":request.getParameter("prname").trim();
		String checklistarray=request.getParameter("checklist")==null?"":request.getParameter("checklist").trim();
		String date=request.getParameter("date")==null?"":request.getParameter("date").trim();
		String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").trim(); 
		String rdtype=request.getParameter("rdtype")==null?"":request.getParameter("rdtype").trim(); 
		String reason=request.getParameter("reason")==null || request.getParameter("reason")==""?"0":request.getParameter("reason").trim();   
		String enqprocess=request.getParameter("enqprocess")==null?"":request.getParameter("enqprocess").trim();   
		//System.out.println("process--->>>"+processid+"===docno==="+docno);       
		
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0;
		 /*Submit */
		if(processid.equalsIgnoreCase("Survery Update")){    
			 String upsql="update gl_enqsited set route='"+route+"', gpsx='"+gpsx+"', gpsy='"+gpsy+"', description='"+desc+"' where rowno='"+siteid+"' and rdocno='"+docno+"'";      
			 //System.out.println("upsql--->>>"+upsql);
			 val= stmt.executeUpdate(upsql);
			 if(val>0) { 
				 String upsql1="update gl_enqm set presalesstatus=1 where doc_no='"+docno+"'";            
				 //System.out.println("upsql1--->>>"+upsql1);
				 val= stmt.executeUpdate(upsql1);  
				 
				 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"','Survey Updated',now())";
				 //System.out.println("logsql--->>>"+logsql);  
				 val= stmt.executeUpdate(logsql);      
			 }
			 if(val>0){
				 temp="1";  
			 }
		}else if(processid.equalsIgnoreCase("Quotation")){
				 String upsql1="update gl_enqm set presalesstatus=2 where doc_no='"+docno+"'";           
				 //System.out.println("upsql1--->>>"+upsql1);
				 val= stmt.executeUpdate(upsql1);
				 if(val>0) { 
					 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"','Quotation Created',now())";
					 //System.out.println("logsql--->>>"+logsql);  
					 val= stmt.executeUpdate(logsql);        
				 }
				 if(val>0){
					 temp="1";    
				 }
		}else if(processid.equalsIgnoreCase("Contract")){  
				 String upsql1="update gl_enqm set presalesstatus=4 where doc_no='"+docno+"'";           
				 //System.out.println("upsql1--->>>"+upsql1);       
				 val= stmt.executeUpdate(upsql1);
				
				 if(val>0){    
					 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"','Service Contract Created',now())";
					 //System.out.println("logsql--->>>"+logsql);  
					 val= stmt.executeUpdate(logsql);      
				 }
				 if(val>0){   
					 temp="1";  
				 }
		}else if(processid.equalsIgnoreCase("Confirm")){    
			 String upsql="update gl_enqm set amcconfirm=1 where doc_no='"+docno+"'";        
			 //System.out.println("upsql--->>>"+upsql);
			 val= stmt.executeUpdate(upsql);
			 if(val>0){     
				 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"','Confirmed',now())";
				 //System.out.println("logsql--->>>"+logsql);  
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Checklist")){  
	    	 ArrayList<String> griddataarray=new ArrayList<String>();
	 		 String[] temparray=checklistarray.split(",");  
	 		 for(int i=0;i<temparray.length;i++){
	 			griddataarray.add(temparray[i]);    
	 		 }
			
			 String delsql="delete from sk_checklistdet where qotno='"+qottrno+"'";        
			 //System.out.println("delsql--->>>"+delsql);
			 val= stmt.executeUpdate(delsql);   
			 
			 for(int i=0;i< griddataarray.size();i++){       
					String[] contrtypedet=((String) griddataarray.get(i)).split("::");
					if(!(contrtypedet[0].trim().equalsIgnoreCase("undefined")|| contrtypedet[0].trim().equalsIgnoreCase("NaN")||contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty())){
						String checksrno=(contrtypedet[0].trim().equalsIgnoreCase("undefined") || contrtypedet[0].trim().equalsIgnoreCase("NaN")|| contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty()?"0":contrtypedet[0].trim());
						String checkremarks=(contrtypedet[1].trim().equalsIgnoreCase("undefined") || contrtypedet[1].trim().equalsIgnoreCase("NaN")|| contrtypedet[1].trim().equalsIgnoreCase("")|| contrtypedet[1].isEmpty()?"":contrtypedet[1].trim());
						String filepath=(contrtypedet[2].trim().equalsIgnoreCase("undefined") || contrtypedet[2].trim().equalsIgnoreCase("NaN")|| contrtypedet[2].trim().equalsIgnoreCase("")|| contrtypedet[2].isEmpty()?"":contrtypedet[2].trim());
						String filename=(contrtypedet[3].trim().equalsIgnoreCase("undefined") || contrtypedet[3].trim().equalsIgnoreCase("NaN")|| contrtypedet[3].trim().equalsIgnoreCase("")|| contrtypedet[3].isEmpty()?"":contrtypedet[3].trim());
						if(filepath.equals("") || filepath==null){
							filename = "";     
						}
						String upsql="insert into sk_checklistdet(qotno, checksrno, remarks, path, attach, status) values('"+qottrno+"','"+checksrno+"','"+checkremarks+"','"+filepath+"','"+filename+"',3)";            
						 //System.out.println("upsql--->>>"+upsql);  
						 val= stmt.executeUpdate(upsql);
					}
			 }   
			 if(val>0) {   
				 String strenq="select sum(if(d.attach!='',0,1)) chlist from sk_checklist s left join sk_checklistdet d on d.checksrno=s.srno and d.qotno='"+qottrno+"' where s.mandatory=1";   
				 //System.out.println("strenq--->>>"+strenq);     
				 ResultSet rs = stmt.executeQuery(strenq);  
				 while(rs.next()){
					 int tempval = rs.getInt("chlist");
					 if(tempval == 0){
						 String upsql1="update gl_enqm set presalesstatus=3,returned=0 where doc_no='"+docno+"'";              
						 //System.out.println("upsql1--->>>"+upsql1);   
						 val = stmt1.executeUpdate(upsql1);    
					 }    
				 }  
				 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"','Checklist Updated',now())";  
				 //System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);      
			 }
			 if(val>0){
				 temp="1";  
			 }
		}else if(processid.equalsIgnoreCase("CHECKLIST AUTOSAVE")){  
			 int listno = 0;
	            String path="", filename="",checksrno="";    
	            
	            String sql71="select rowno from sk_checklistdet where qotno='"+qottrno+"' and checksrno in(1,2,4)";         
	             // System.out.println("sql71--->>>"+sql71);     
				 ResultSet rs4 = stmt.executeQuery(sql71);    
				 while(rs4.next()){
					 listno = rs4.getInt("rowno");
				 }
				 
				 if(!docno.equals("0")){   
					 String sql7="select f.path, f.filename, f.descpt,c.srno from my_fileattach f left join sk_checklist c on upper(replace(c.desc1,' ',''))=upper(replace(f.descpt,' ','')) where f.dtype='crm' and f.doc_no='"+docno+"' and upper(replace(f.descpt,' ','')) in('TRADELICENSE','VATCERTIFICATE','IDPROOF') group by upper(replace(f.descpt,' ',''));";   
		             //System.out.println("sql7--->>>"+sql7);     
					 ResultSet rs3 = stmt.executeQuery(sql7);  
					 while(rs3.next()){
						  checksrno = rs3.getString("srno");
						  path = rs3.getString("path");
						  filename =rs3.getString("filename");
						   System.out.println(docno+"----"+listno);      
						  if(listno == 0){    
								 String upsql="insert into sk_checklistdet(qotno, checksrno, path, attach, status) values('"+qottrno+"','"+checksrno+"','"+path+"','"+filename+"',3)";            
								 //System.out.println("upsql--->>>"+upsql);  
								 val= stmt1.executeUpdate(upsql);       
					      }
					 }
				 }   
	           
				 temp="1";  
		}else if(processid.equalsIgnoreCase("Enquiry Followup")){
			java.sql.Date sqlDate=null;
		    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
			     sqlDate=ClsCommon.changeStringtoSqlDate(date);
			}
			if(enqprocess.equalsIgnoreCase("2")){ 
				 String upsql1="update gl_enqm set dropped=1 where doc_no='"+docno+"'";             
				 //System.out.println("upsql1--->>>"+upsql1);   
				 val= stmt.executeUpdate(upsql1);  
				 
				sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, brhid, userid, dstatus) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+brhid+", "+session.getAttribute("USERID").toString()+", '"+reason+"')";    
				 //System.out.println("followup=="+sql);
				 val= stmt.executeUpdate(sql);
				 if(val>0) { 
					 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"', 'Enquiry Dropped', now())";    
					 //System.out.println("logsql--->>>"+logsql);  
					 val= stmt.executeUpdate(logsql);        
				 }
			}else{
				sql="insert into gl_bqot( date, rdocno, rdtype, fdate, remarks, brhid, userid) values( now(), "+docno+", '"+rdtype+"', '"+sqlDate+"', '"+remarks+"', "+brhid+", "+session.getAttribute("USERID").toString()+")";      
				 //System.out.println("followup=="+sql);
				 val= stmt.executeUpdate(sql);
				 if(val>0) { 
					 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"', 'Enquiry Followup Done', now())";  
					 //System.out.println("logsql--->>>"+logsql);  
					 val= stmt.executeUpdate(logsql);        
				 }
			}
			 if(val>0){
				 temp="1";    
			 }
	     }else if(processid.equalsIgnoreCase("Client Update")){        
			 String upsql="update gl_enqm set name='"+proname+"', cldocno='"+prdocno+"' where doc_no='"+docno+"'";       
			 //System.out.println("upsql--->>>"+upsql);
			 val= stmt.executeUpdate(upsql);
			 if(val>0) { 
				 String logsql="insert into sk_presaleslog(doc_no, brhid, userid, description, entrydate) values ('"+docno+"','"+brhid+"','"+session.getAttribute("USERID").toString()+"','Client Updated',now())";
				 //System.out.println("logsql--->>>"+logsql);  
				 val= stmt.executeUpdate(logsql);      
			 }
			 if(val>0){
				 temp="1";  
			 }
		}else{}      
		 
		if(temp.equalsIgnoreCase("1")){  
			conn.commit();
		}
		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
