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
	String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
	String docno=request.getParameter("docno")==null || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();
	String delsrno=request.getParameter("delsrno")==null || request.getParameter("delsrno")==""?"0":request.getParameter("delsrno");
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();
	String cnttrno=request.getParameter("cnttrno")==null || request.getParameter("cnttrno").trim()==""?"0":request.getParameter("cnttrno").trim();
	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
	String sccnttrno=request.getParameter("sccnttrno")==null || request.getParameter("sccnttrno")==""?"0":request.getParameter("sccnttrno");
    String sccntsrno=request.getParameter("sccntsrno")==null || request.getParameter("sccntsrno")==""?"0":request.getParameter("sccntsrno");
    String podate=request.getParameter("podate")==null || request.getParameter("podate")==""?"0":request.getParameter("podate");
    String poremarks=request.getParameter("poremarks")==null?"":request.getParameter("poremarks");  
    String potime=request.getParameter("potime")==null || request.getParameter("potime")==""?"0":request.getParameter("potime");
    String scdate=request.getParameter("scdate")==null || request.getParameter("scdate")==""?"0":request.getParameter("scdate");
    String sctime=request.getParameter("sctime")==null || request.getParameter("sctime")==""?"0":request.getParameter("sctime");
    String scwasteid=request.getParameter("scwasteid")==null || request.getParameter("scwasteid")==""?"0":request.getParameter("scwasteid");
    String name=request.getParameter("name")==null?"":request.getParameter("name");
    String mobno=request.getParameter("mobno")==null?"":request.getParameter("mobno");
    String email=request.getParameter("email")==null?"":request.getParameter("email");
    String location=request.getParameter("location")==null?"":request.getParameter("location");
    String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
    int qty=request.getParameter("qty")==null || request.getParameter("qty").trim()==""?0:Integer.parseInt(request.getParameter("qty").trim());
  	
    try{       
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();  
	 	String temp="";
		int val=0;
		java.sql.Date sqldate = null;  
		java.sql.Date sqlcldate = null;
	 	
    	if(processid.equalsIgnoreCase("Schedule on call basis")){    
   	 		Statement stmt1 = conn.createStatement(); 	 
   			if(!(scdate.equalsIgnoreCase("undefined"))&&!(scdate.equalsIgnoreCase(""))&&!(scdate.equalsIgnoreCase("0"))) {
	    		sqldate=ClsCommon.changeStringtoSqlDate(scdate);     
		 		} else{}
   	 		if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))) {     
   		 		sqlcldate=ClsCommon.changeStringtoSqlDate(podate);      
	     	}else{}      
			int scdelid=0; 
			String sqltest="",days="";
			/* if(!delsrno.equalsIgnoreCase("All")) {   
				sqltest+=" and dl.slno='"+delsrno+"'";           
		 	} */
			int availqty = qty, id=1;
		    while(availqty>0){
		    	String strsql1="select dl.doc_no,cm.brhid,dayname('"+sqldate+"') dayname from sk_srvcontrdel dl left join sk_srvcontrm cm on cm.tr_no=dl.rdocno where dl.rdocno='"+sccnttrno+"' and dl.srno='"+sccntsrno+"' and dl.slno='"+id+"' group by dl.doc_no";             
				//System.out.println("strsql1==="+strsql1);  
				ResultSet rs1 = stmt.executeQuery(strsql1);    
				while(rs1.next()) {
					scdelid=rs1.getInt("doc_no");
					brhid = rs1.getString("brhid"); 
					days = rs1.getString("dayname");   
					String inssql="insert into sk_srvcontrsch(rdocno, srno, brhid, delid, date, time, days, name, mobile, email, location, calldate, calltime, remarks) values('"+sccnttrno+"', '"+sccntsrno+"', '"+brhid+"', '"+scdelid+"', '"+sqldate+"', '"+sctime+"', '"+days+"', '"+name+"', '"+mobno+"', '"+email+"', '"+location+"', '"+sqlcldate+"', '"+potime+"','"+remarks+"')";        
					System.out.println("inssql--->>>"+inssql);      
					val= stmt1.executeUpdate(inssql);       
					 System.out.println(val);
				}
				id++;
				availqty--;
			}
			String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+docno+"','"+brhid+"','BSS',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Schedule Changed')";    
			//System.out.println("logsql--->>>"+logsql);      
			stmt.executeUpdate(logsql);
			if(val>0){
			 	temp="1";    
			}    
		}else if(processid.equalsIgnoreCase("Replacement Request")){                
	    	 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))) {     
	    		 sqldate=ClsCommon.changeStringtoSqlDate(podate);      
		      }else{} 
	    	 int rpdelid=0,oldskipidrp=0;
	    	 String strsql1="select dl.doc_no from sk_srvcontrdel dl where dl.rdocno='"+cnttrno+"' and dl.srno='"+srno+"' and dl.slno='"+delsrno+"' group by dl.doc_no";               
			 //System.out.println("strsql1==="+strsql1);    
			 ResultSet rs1 = stmt.executeQuery(strsql1);    
			 while(rs1.next()) {   
				 rpdelid=rs1.getInt("doc_no");   
             }
	    	 String inssql="insert into sk_replacereq(delid, cnttrno, srno, date, time, entrydatetime, userid, remarks) values('"+rpdelid+"', '"+cnttrno+"','"+srno+"','"+sqldate+"','"+potime+"',now(),'"+session.getAttribute("USERID").toString()+"','"+poremarks+"')";                       
	    	 //System.out.println("inssql--->>>"+inssql);                  
			 val= stmt.executeUpdate(inssql);   
			 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+docno+"','"+brhid+"','BSS',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Schedule Changed')";    
			 //System.out.println("logsql--->>>"+logsql);      
			 stmt.executeUpdate(logsql);
			 if(val>0){
				 temp="1";    
			 }
	    } else if (processid.equalsIgnoreCase("Cancel Request")){
	    	if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))) {     
	    		 sqldate=ClsCommon.changeStringtoSqlDate(podate);      
		      }else{} 
	    	String upsql = "update sk_replacereq set status=7, canceldate='"+sqldate+"', canceltime='"+potime+"', cancelremarks='"+poremarks+"', canceluserid='"+session.getAttribute("USERID").toString()+"' where doc_no ='"+docno+"' and cnttrno='"+cnttrno+"' and srno='"+srno+"'";
	    	//System.out.println("updql--->>>"+upsql);
	    	val=stmt.executeUpdate(upsql);
	    	//System.out.println(val);
	    	String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+docno+"','"+brhid+"','BSS',now(),'"+session.getAttribute("USERID").toString()+"','E', 'Replacement Request')";    
			//System.out.println("logsql--->>>"+logsql); 
			stmt.executeUpdate(logsql);
			if(val>0){
				 temp="1";    
			 }
	    }
  		if(temp.equalsIgnoreCase("1")){     
			conn.commit();
		}
  		//System.out.println(temp);
  		response.getWriter().print(temp);
 		stmt.close();
 		conn.close();
	} catch (Exception e){
	 	e.printStackTrace();
	 	conn.close();
    }finally{
	   conn.close();
    }
    
  %>