<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>   
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement(); 
	 	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
	 	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno").trim()==""?"0":request.getParameter("contrno").trim();
	 	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		String holddate=request.getParameter("holddate")==null?"":request.getParameter("holddate").trim();
		String time=request.getParameter("time")==null?"":request.getParameter("time").trim();
		String remarks=request.getParameter("reason")==null?"":request.getParameter("reason").trim();  
		String renewalreqdate=request.getParameter("renewalreqdate")==null?"":request.getParameter("renewalreqdate").trim(); 
		String requesteduser=request.getParameter("requesteduser")==null?"":request.getParameter("requesteduser").trim(); 
		String renewreqremarks=request.getParameter("renewreqremarks")==null?"":request.getParameter("renewreqremarks").trim();
		String qty=request.getParameter("qty")==null || request.getParameter("qty").trim()==""?"0":request.getParameter("qty").trim();
		String delid=request.getParameter("delid")==null || request.getParameter("delid").trim()==""?"0":request.getParameter("delid").trim(); 
		String type=request.getParameter("type")==null?"":request.getParameter("type").trim();
		//System.out.println("process--->>>"+processid);                        
	    
		String sql="", sqlsub="", sql1="", rowno="0", revisionno="0", oldcnttrno="0";        
		String temp="";
		int val=0;
		java.sql.Date sqlholddate = null;
		java.sql.Date sqlrenewaldate = null;     
		
		String strsql="select d.rowno, d.revision_no, m.oldcnttrno from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no where d.rdocno='"+contrno+"' and d.srno='"+srno+"'"; 
		//System.out.println("strsql==="+strsql);  
		ResultSet rs = stmt.executeQuery(strsql);         
		while(rs.next()) {  
			rowno=rs.getString("rowno");
			revisionno=rs.getString("revision_no");  
			oldcnttrno = rs.getString("oldcnttrno");  
		}  
		
		 /*Submit */
		if(processid.equalsIgnoreCase("Close Job")){  
	    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {   
				 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
		      }else{}
	    	 
	    	 //, status=10 removed on 2023-11-08 for requesting operation SRF
			 String inssql="update sk_srvcontrm set closedate='"+sqlholddate+"',closereason='"+remarks+"', closeuserid='"+session.getAttribute("USERID").toString()+"' where tr_no='"+contrno+"'";                        
			 //System.out.println("inssql--->>>"+inssql);         
			 val= stmt.executeUpdate(inssql);    
			 
			 if(val>0){  
				 String upsql="update sk_srvcontrdet set statusid=7 where rowno='"+rowno+"'";                       
				 // System.out.println("upsql--->>>"+upsql);
				 val= stmt.executeUpdate(upsql);
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNR',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Terminated / Cancel job')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";    
			 }
	     }else if(processid.equalsIgnoreCase("Service Request")){    
	    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {   
				 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
		      }else{}
	    	 int srdocno=0;
	    	 String strsql1="select coalesce(max(doc_no)+1,10001) srdocno from sk_srvcontrsrf";    
			 ResultSet rss = stmt.executeQuery(strsql1);    
			 while(rss.next()) {
				 srdocno=rss.getInt("srdocno");   
			 }
			 String inssql="update sk_srvcontrdet set srdocno="+srdocno+",srdesc='"+remarks+"' where rowno='"+rowno+"'";                      
			 //System.out.println("inssql--->>>"+inssql);    
			 val= stmt.executeUpdate(inssql); 
			 
			 String inssql2="INSERT INTO sk_srvcontrsrf(doc_no, cnttrno, detsrno, date, type, requser, remarks, entrydate, entrytime, revision_no) VALUES("+srdocno+", '"+contrno+"', '"+srno+"', now(), '"+type+"', '"+session.getAttribute("USERID")+"', '"+remarks+"', '"+sqlholddate+"', '"+time+"', '"+revisionno+"')";                      
			 //System.out.println("inssql2--->>>"+inssql2);    
			 val= stmt.executeUpdate(inssql2); 
			 
			 if(val>0){ 
				 /* if(type.equalsIgnoreCase("REN")){
					 String delsql = "insert into sk_srvcontrdel(slno, skipid, rdocno, srno, driverid, helperid, schdate, schtime, fleetno, name, mobile, email, dayshift, location) select slno, skipid, '"+contrno+"', '"+srno+"', driverid, helperid, schdate, schtime, fleetno, name, mobile, email, dayshift, location from sk_srvcontrdel where rdocno='"+oldcnttrno+"'";                            
	 				 System.out.println("delsql--->>>"+delsql);  
	 				 val = stmt.executeUpdate(delsql);
				 } */    
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNR',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Service Request')";
				// System.out.println("logsql--->>>"+logsql);      
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Renewal Request")){      
		    	 if(!(renewalreqdate.equalsIgnoreCase("undefined"))&&!(renewalreqdate.equalsIgnoreCase(""))&&!(renewalreqdate.equalsIgnoreCase("0"))) {   
		    		 sqlrenewaldate=ClsCommon.changeStringtoSqlDate(renewalreqdate);    
			      }else{}
		    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {
					 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
			      }else{}
		    	 String upsql="insert into sk_srvcontrrenew(cnttrno, rsrno, requser, remarks, date, witheffect) values('"+contrno+"','"+srno+"','"+requesteduser+"','"+renewreqremarks+"','"+sqlrenewaldate+"','"+sqlholddate+"')";         
		    	 //System.out.println("upsql--->>>"+upsql);      
				 val= stmt.executeUpdate(upsql);               
				 
				 if(val>0){       
					 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNR',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Contract Revise Request')";   
					// System.out.println("logsql--->>>"+logsql);          
					 val= stmt.executeUpdate(logsql);          
				 }
				 if(val>0){
					 temp="1";    
				 }
	     }else if(processid.equalsIgnoreCase("delivery")){ 
	    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {
				 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
		      }else{}
	    	 
	    	 int slno=0;
			 String strsql1="select coalesce(max(slno)+1,1) slno from sk_srvcontrdel d where d.rdocno='"+contrno+"' and d.srno='"+srno+"'";           
			 ResultSet rs1 = stmt.executeQuery(strsql1);  
			 while(rs1.next()) {
				 slno=rs1.getInt("slno");    
			 }
			 
			 String inssql="insert into sk_srvcontrdel(slno, deldate, deltime, rdocno, srno, remarks, skipid, gpsx, gpsy, driverid, helperid, schdate, schtime, routeid, fleetno, name, mobile, email, dayshift, location, helperid2) values('"+slno+"', '"+sqlholddate+"', '"+time+"', '"+contrno+"', '"+srno+"', '"+remarks+"', 0, '', '', 0, 0, '"+sqlholddate+"', '"+time+"', 0, 0, '', '', '', '', '', 0)";  
			 // System.out.println("inssql--->>>"+inssql);     
			 val= stmt.executeUpdate(inssql);        
			 
			 if(val>0){   
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNR',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Delivery')";  
				// System.out.println("logsql--->>>"+logsql);      
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("add delivery")){      
	    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {
				 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
		      }else{}
	    	 int slno=0;
	    	 int addqty = Integer.parseInt(qty);  
	    	 while(addqty>0){   
	    		 String strsql1="select coalesce(max(slno)+1,1) slno from sk_srvcontrdel d where d.rdocno='"+contrno+"' and d.srno='"+srno+"'";           
				 ResultSet rs1 = stmt.executeQuery(strsql1);  
				 while(rs1.next()) {
					 slno=rs1.getInt("slno");    
				 }
				 
				 String inssql="insert into sk_srvcontrdel(slno, deldate, deltime, rdocno, srno, remarks, skipid, gpsx, gpsy, driverid, helperid, schdate, schtime, routeid, fleetno, name, mobile, email, dayshift, location, helperid2) values('"+slno+"', '"+sqlholddate+"', '"+time+"', '"+contrno+"', '"+srno+"', '"+remarks+"', 0, '', '', 0, 0, '"+sqlholddate+"', '"+time+"', 0, 0, '', '', '', '', '', 0)";  
				 // System.out.println("inssql--->>>"+inssql);     
				 val= stmt.executeUpdate(inssql);   
				 
	    		 addqty--;    
	    	 }
			 
			 if(val>0){   
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNR',now(),'"+session.getAttribute("USERID").toString()+"','A', 'add delivery')";  
				// System.out.println("logsql--->>>"+logsql);      
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("pull out")){           
	    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {  
				 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
		      }else{}
				 
			 String upsql="UPDATE sk_srvcontrdel SET poremarks='"+remarks+"', type='P', podate='"+sqlholddate+"' WHERE doc_no='"+delid+"'";       
			 // System.out.println("upsql--->>>"+upsql);           
			 val= stmt.executeUpdate(upsql);            
			 
			 if(val>0){        
				 String inssql="insert into sk_srvcontrsch(rdocno, srno, brhid, delid, date, pskipno, status, statusid, time, days, remarks, calldate, calltime) values('"+contrno+"', '"+srno+"', '"+brhid+"', '"+delid+"', '"+sqlholddate+"', 0, 4, 1, '00:00', dayname('"+sqlholddate+"'), '"+remarks+"', '"+sqlholddate+"', '00:00')";                                   
		    	 //System.out.println("inssql--->>>"+inssql);                
				 val= stmt.executeUpdate(inssql);   
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNR',now(),'"+session.getAttribute("USERID").toString()+"','A', 'add delivery')";  
				// System.out.println("logsql--->>>"+logsql);      
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Hold")){
	    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {
				 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
		      }else{}
			 String inssql="update sk_srvcontrdet set hold=1 where rowno='"+rowno+"'";                   
			 //System.out.println("inssql--->>>"+inssql);    
			 val= stmt.executeUpdate(inssql);    
			 
			 if(val>0){   
				 String upsql="insert into sk_srvcontrhr( date, reason, userid, rdocno,  srno, status) values('"+sqlholddate+"', '"+remarks+"', '"+session.getAttribute("USERID").toString()+"', '"+contrno+"', '"+srno+"', '"+processid+"')";        
				 // System.out.println("upsql--->>>"+upsql);
				 val= stmt.executeUpdate(upsql);
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Hold')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Release")){
	    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {
				 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
		      }else{}
			 String inssql="update sk_srvcontrdet set hold=0 where rowno='"+rowno+"'";                   
			 //System.out.println("inssql--->>>"+inssql);    
			 val= stmt.executeUpdate(inssql);    
			 
			 if(val>0){   
				 String upsql="insert into sk_srvcontrhr( date, reason, userid, rdocno, srno, status) values('"+sqlholddate+"', '"+remarks+"', '"+session.getAttribute("USERID").toString()+"', '"+contrno+"', '"+srno+"', '"+processid+"')";        
				 // System.out.println("upsql--->>>"+upsql);
				 val= stmt.executeUpdate(upsql);
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Release')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else {}      
		 
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
