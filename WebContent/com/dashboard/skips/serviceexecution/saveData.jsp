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
	 	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
	 	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno").trim()==""?"0":request.getParameter("contrno").trim();
	 	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();
	 	//String rowno=request.getParameter("rowno")==null || request.getParameter("rowno").trim()==""?"0":request.getParameter("rowno").trim();
		String skipid=request.getParameter("skipid")==null || request.getParameter("skipid").trim()==""?"0":request.getParameter("skipid").trim();  
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		String gpsx=request.getParameter("gpsx")==null || request.getParameter("gpsx").trim()==""?"":request.getParameter("gpsx").trim();
		String gpsy=request.getParameter("gpsy")==null || request.getParameter("gpsy").trim()==""?"":request.getParameter("gpsy").trim();
		String deldate=request.getParameter("deldate")==null?"":request.getParameter("deldate").trim();
		String deltime=request.getParameter("deltime")==null?"":request.getParameter("deltime").trim();	
		String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray").trim(); 	
		String deldocno=request.getParameter("delid")==null || request.getParameter("delid").trim()==""?"0":request.getParameter("delid").trim();
		String driverid=request.getParameter("driverid")==null || request.getParameter("driverid").trim()==""?"0":request.getParameter("driverid").trim();
		String helperid=request.getParameter("helperid")==null || request.getParameter("helperid").trim()==""?"0":request.getParameter("helperid").trim(); 
		String routeid=request.getParameter("routeid")==null || request.getParameter("routeid").trim()==""?"0":request.getParameter("routeid").trim(); 
		String ownership=request.getParameter("ownership")==null?"":request.getParameter("ownership").trim(); 
		String holddate=request.getParameter("holddate")==null?"":request.getParameter("holddate").trim();
		String remarks=request.getParameter("reason")==null?"":request.getParameter("reason").trim();  
		String vehicleid=request.getParameter("vehicleid")==null || request.getParameter("vehicleid").trim()==""?"0":request.getParameter("vehicleid").trim();  
		
		String name=request.getParameter("name")==null?"":request.getParameter("name").trim();  
		String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile").trim();  
		String email=request.getParameter("email")==null?"":request.getParameter("email").trim();  
		String dayshift=request.getParameter("dayshift")==null?"":request.getParameter("dayshift").trim(); 
		String locmap=request.getParameter("locmap")==null?"":request.getParameter("locmap").trim(); 
		
		String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno").trim();  
		String cperson=request.getParameter("cperson")==null?"":request.getParameter("cperson").trim();  
		String cpersonid=request.getParameter("cpersonid")==null || request.getParameter("cpersonid")==""?"0":request.getParameter("cpersonid").trim();  
		String invoicemail=request.getParameter("invoicemail")==null?"":request.getParameter("invoicemail").trim();  
		String refno=request.getParameter("refno")==null?"":request.getParameter("refno").trim();  
		String site=request.getParameter("site")==null?"":request.getParameter("site").trim();  
		String areaid=request.getParameter("areaid")==null || request.getParameter("areaid")==""?"0":request.getParameter("areaid").trim(); 
		String statusid=request.getParameter("statusid")==null || request.getParameter("statusid")==""?"0":request.getParameter("statusid").trim(); 
		
		String renewalreqdate=request.getParameter("renewalreqdate")==null?"":request.getParameter("renewalreqdate").trim(); 
		String requesteduser=request.getParameter("requesteduser")==null?"":request.getParameter("requesteduser").trim(); 
		String renewreqremarks=request.getParameter("renewreqremarks")==null?"":request.getParameter("renewreqremarks").trim(); 
		
		String poskipno=request.getParameter("poskipno")==null || request.getParameter("poskipno")==""?"0":request.getParameter("poskipno").trim();
		String podate=request.getParameter("podate")==null?"":request.getParameter("podate").trim();
		String skiparr=request.getParameter("skiparr")==null?"":request.getParameter("skiparr").trim();
		String delarr=request.getParameter("delarr")==null?"":request.getParameter("delarr").trim();
		System.out.println("process--->>>"+processid);               
	    
		String sql="",sqlsub="",sql1="",rowno="0",srdocnos="0";       
		String temp="";
		int val=0;
		java.sql.Date sqldate = null;
		java.sql.Date sqlholddate = null;
		java.sql.Date sqlrenewaldate = null;
		java.sql.Date sqlpodate = null;  
		
		String strsql="select d.rowno, d.srdocno from sk_srvcontrdet d where d.rdocno='"+contrno+"' and d.srno='"+srno+"'"; 
		//System.out.println("strsql==="+strsql);  
		ResultSet rs = stmt.executeQuery(strsql);         
		while(rs.next()) {  
			rowno=rs.getString("rowno");
			srdocnos=rs.getString("srdocno");   
		}  
		
		 /*Submit */
		if(processid.equalsIgnoreCase("Skip")){  
			  ArrayList<String> newarray=new ArrayList();   
	 		  String temparray[]=gridarray.split(",");
	 		  for(int i=0;i<temparray.length;i++){
	 			newarray.add(temparray[i]);
	 		  }
	 		  for(int i=0;i<newarray.size();i++){   
		 			String temp1[]=newarray.get(i).split("::");  
		 			if(!temp1[0].trim().equalsIgnoreCase("undefined") && !temp1[0].trim().equalsIgnoreCase("NaN") && !temp1[0].trim().equalsIgnoreCase("")){
		 				java.sql.Date sqlstartdate = null;  
		 				skipid = temp1[0].trim().equalsIgnoreCase("undefined") || temp1[0].trim().equalsIgnoreCase("NaN") || temp1[0].trim().equalsIgnoreCase("") || temp1[0].trim().isEmpty()?"0":temp1[0].trim().toString();    
		 				int rownos = temp1[1].trim().equalsIgnoreCase("undefined") || temp1[1].trim().equalsIgnoreCase("NaN") || temp1[1].trim().equalsIgnoreCase("") || temp1[1].trim().isEmpty()?0:Integer.parseInt(temp1[1].trim().toString());
		 				
		 				 String inssql="insert into sk_srvcontrdel(skipid, rdocno, srno) values('"+skipid+"', '"+contrno+"', '"+srno+"')";                       
		 				 // System.out.println("inssql--->>>"+inssql);
		 				 val= stmt.executeUpdate(inssql); 
		 				 if(val>0){  
		 					 String upsql1="update sk_skipm set skipstatus=2 where doc_no='"+skipid+"'";                      
		 					 // System.out.println("upsql1--->>>"+upsql1);
		 					 val= stmt.executeUpdate(upsql1);  
		 				 }
		 			}
		     }
			 if(val>0){  
				 String upsql="update sk_srvcontrdet set balqty=balqty+1,statusid=1 where rowno='"+rowno+"'";            
				 // System.out.println("upsql--->>>"+upsql);
				 val= stmt.executeUpdate(upsql);
						 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Skip Assigned')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	      }else if(processid.equalsIgnoreCase("Delivery")){
			 if(!(deldate.equalsIgnoreCase("undefined"))&&!(deldate.equalsIgnoreCase(""))&&!(deldate.equalsIgnoreCase("0"))) {
				 sqldate=ClsCommon.changeStringtoSqlDate(deldate);  
		      }else{}
			 if(ownership.equalsIgnoreCase("OWN SKIP")){
				 String inssql="update sk_srvcontrdel set gpsx='"+gpsx+"', gpsy='"+gpsy+"', deldate='"+sqldate+"', deltime='"+deltime+"',statusid=2 where doc_no='"+deldocno+"'";                   
				 // System.out.println("inssql--->>>"+inssql);
				 val= stmt.executeUpdate(inssql);
			 }else{
				 if(deldocno.equalsIgnoreCase("0")){
					 int slno=0;
					 String strsql1="select coalesce(max(slno)+1,1) slno from sk_srvcontrdel d where d.rdocno='"+contrno+"' and d.srno='"+srno+"'";         
					 ResultSet rs1 = stmt.executeQuery(strsql1);  
					 while(rs1.next()) {
						 slno=rs1.getInt("slno");    
					 }
					 String inssql="insert into sk_srvcontrdel(slno, rdocno, srno, gpsx, gpsy, statusid) values('"+slno+"', '"+contrno+"', '"+srno+"', '"+gpsx+"', '"+gpsy+"', 2)";                     
					 // System.out.println("inssql--->>>"+inssql);      
					 val= stmt.executeUpdate(inssql);
				 }else{
					 String upsql="update sk_srvcontrdel set gpsx='"+gpsx+"', gpsy='"+gpsy+"',statusid=2 where doc_no='"+deldocno+"'";                   
					 // System.out.println("upsql--->>>"+upsql);    
					 val= stmt.executeUpdate(upsql);
				 }
			 }   
			 if(val>0){   
				 String upsql="update sk_srvcontrdet set statusid=3 where rowno='"+rowno+"'";                
				 // System.out.println("upsql--->>>"+upsql);
				 val= stmt.executeUpdate(upsql);
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Delivery and Location Updated')";   
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Schedule")){  
	    	  Statement stmt2 = conn.createStatement();
	    	  ArrayList<String> newarray=new ArrayList();   
	 		  String temparray[]=gridarray.split(",");
	 		  for(int i=0;i<temparray.length;i++){
	 			newarray.add(temparray[i]);
	 		  }
	 		 int delid=0, driveridsch=0, helperidsch=0, routeidsch=0, fleetnosch=0;   
	 		 String strsql1="select doc_no, driverid, helperid, routeid, fleetno from sk_srvcontrdel d where d.rdocno='"+contrno+"' and d.srno='"+srno+"'";    
			 System.out.println("strsql1==="+strsql1);
			 ResultSet rs1 = stmt2.executeQuery(strsql1);  
			 while(rs1.next()) {
					 delid = rs1.getInt("doc_no"); 
					 driveridsch = rs1.getInt("driverid");
					 helperidsch = rs1.getInt("helperid");
					 routeidsch = rs1.getInt("routeid");
					 fleetnosch = rs1.getInt("fleetno");
			 		 for(int i=0;i<newarray.size();i++){ 
			 			String temp1[]=newarray.get(i).split("::");  
			 			if(!temp1[0].trim().equalsIgnoreCase("undefined") && !temp1[0].trim().equalsIgnoreCase("NaN") && !temp1[0].trim().equalsIgnoreCase("")){
			 				java.sql.Date sqlstartdate = null;  
			 				sqlstartdate = temp1[0].trim().equalsIgnoreCase("undefined") || temp1[0].trim().equalsIgnoreCase("NaN") || temp1[0].trim().equalsIgnoreCase("") || temp1[0].trim().isEmpty()?null:ClsCommon.changeStringtoSqlDate(temp1[0].trim().toString());    
			 				String time = temp1[1].trim().equalsIgnoreCase("undefined") || temp1[1].trim().equalsIgnoreCase("NaN") || temp1[1].trim().equalsIgnoreCase("") || temp1[1].trim().isEmpty()?"":temp1[1].trim().toString();
			 				String days = temp1[2].trim().equalsIgnoreCase("undefined") || temp1[2].trim().equalsIgnoreCase("NaN") || temp1[2].trim().equalsIgnoreCase("") || temp1[2].trim().isEmpty()?"":temp1[2].trim().toString();
			 				
			 				 String inssql="insert into sk_srvcontrsch(rdocno, brhid, delid, date, time, days, driverid, helperid, routeid, fleetno) values('"+rowno+"','"+brhid+"','"+delid+"','"+sqlstartdate+"','"+time+"','"+days+"','"+driveridsch+"','"+helperidsch+"','"+routeidsch+"','"+fleetnosch+"')";                  
			 				 System.out.println("inssql--->>>"+inssql);  
			 				 val= stmt.executeUpdate(inssql); 
			 			}
			 		  }  
			 }
			 if(val>0){     
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Service Schedule Updated')";  
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Schedule Delivery")){  
			 if(!(deldate.equalsIgnoreCase("undefined"))&&!(deldate.equalsIgnoreCase(""))&&!(deldate.equalsIgnoreCase("0"))) {
				 sqldate=ClsCommon.changeStringtoSqlDate(deldate);  
		      }else{}
			 int slno=0;
			 
			 ArrayList<String> newarray=new ArrayList();   
	 		 String temparray[]=skiparr.split(",");
	 		 for(int i=0;i<temparray.length;i++){
	 			newarray.add(temparray[i]);
	 		 }
	 		 //System.out.println("skiparr--->>>"+newarray);
	 		 for(int i=0;i<newarray.size();i++){   
		 			String temp1[] = newarray.get(i).split("::");  
		 			if(!temp1[0].trim().equalsIgnoreCase("undefined") && !temp1[0].trim().equalsIgnoreCase("NaN") && !temp1[0].trim().equalsIgnoreCase("")){
		 				int delskipid = temp1[0].trim().equalsIgnoreCase("undefined") || temp1[0].trim().equalsIgnoreCase("NaN") || temp1[0].trim().equalsIgnoreCase("") || temp1[0].trim().isEmpty()?0:Integer.parseInt(temp1[0].trim().toString());    
		 				int deliveryid = temp1[1].trim().equalsIgnoreCase("undefined") || temp1[1].trim().equalsIgnoreCase("NaN") || temp1[1].trim().equalsIgnoreCase("") || temp1[1].trim().isEmpty()?0:Integer.parseInt(temp1[1].trim().toString());
		 				if(deliveryid==0){
		 					 String strsql1="select coalesce(max(slno)+1,1) slno from sk_srvcontrdel d where d.rdocno='"+contrno+"' and d.srno='"+srno+"'";         
		 					 ResultSet rs1 = stmt.executeQuery(strsql1);  
		 					 while(rs1.next()) {
		 						 slno=rs1.getInt("slno");    
		 					 }
		 					 String inssql="insert into sk_srvcontrdel(slno, skipid, rdocno, srno, driverid, helperid, schdate, schtime, fleetno, name, mobile, email, dayshift, location, statusid, routeid, remarks) values('"+slno+"', '"+delskipid+"', '"+contrno+"', '"+srno+"', '"+driverid+"', '"+helperid+"', '"+sqldate+"', '"+deltime+"', '"+vehicleid+"', '"+name+"', '"+mobile+"', '"+email+"', '"+dayshift+"', '"+locmap+"', 1, '"+routeid+"', '"+remarks+"')";                         
		 	 				 //System.out.println("inssql--->>>"+inssql);  
		 	 				 val= stmt.executeUpdate(inssql); 
		 	 				 if(val>0){  
		 	 					 String upsql1="update sk_skipm set skipstatus=2 where doc_no='"+delskipid+"'";                      
		 	 					 //System.out.println("upsql1--->>>"+upsql1);
		 	 					 val= stmt.executeUpdate(upsql1);
		 	 					 
		 	 					 String upsql="update sk_srvcontrdet set balqty=balqty+1,statusid=2 where rowno='"+rowno+"'";            
		 	 					 //System.out.println("upsql--->>>"+upsql);
		 	 					 val= stmt.executeUpdate(upsql);
		 	 				 }
		 				 }else{
		 					 String inssql="update sk_srvcontrdel set  skipid='"+delskipid+"',driverid='"+driverid+"', helperid='"+helperid+"', schdate='"+sqldate+"', schtime='"+deltime+"',fleetno='"+vehicleid+"', name='"+name+"', mobile='"+mobile+"', email='"+email+"', dayshift='"+dayshift+"', location='"+locmap+"', statusid=1, routeid='"+routeid+"', remarks='"+remarks+"' where doc_no='"+deliveryid+"'";                   
		 					 //System.out.println("upsql--->>>"+inssql);       
		 					 val= stmt.executeUpdate(inssql); 
		 					 if(val>0){  
		 						 String upsql1="update sk_skipm set skipstatus=2 where doc_no='"+delskipid+"'";                      
		 	 					 //System.out.println("upsql1--->>>"+upsql1);
		 	 					 val= stmt.executeUpdate(upsql1);
		 	 					 
		 						 String upsql="update sk_srvcontrdet set statusid=2 where rowno='"+rowno+"'";              
		 						 //System.out.println("upsql--->>>"+upsql);
		 						 val= stmt.executeUpdate(upsql);
		 					 }
		 				 } 
		 			}
	 		 }		
			 if(val>0){   
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Schedule Delivery')";
				 //System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);          
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Route")){
	    	 ArrayList<String> newarray=new ArrayList();   
	 		 String temparray[]=delarr.split(",");
	 		 for(int i=0;i<temparray.length;i++){
	 			newarray.add(temparray[i]);
	 		 }
	 		 //System.out.println("skiparr--->>>"+newarray);
	 		 for(int i=0;i<newarray.size();i++){   
		 			String temp1[] = newarray.get(i).split("::");  
		 			if(!temp1[0].trim().equalsIgnoreCase("undefined") && !temp1[0].trim().equalsIgnoreCase("NaN") && !temp1[0].trim().equalsIgnoreCase("")){
		 				 int deliveryid = temp1[0].trim().equalsIgnoreCase("undefined") || temp1[0].trim().equalsIgnoreCase("NaN") || temp1[0].trim().equalsIgnoreCase("") || temp1[0].trim().isEmpty()?0:Integer.parseInt(temp1[0].trim().toString());    
		 				
						 String inssql="update sk_srvcontrdel set routeid='"+routeid+"',statusid=3 where doc_no='"+deliveryid+"'";                   
						 //System.out.println("inssql--->>>"+inssql);    
						 val= stmt.executeUpdate(inssql);    
		 	       }
	 		 }  
			 if(val>0){   
				 String upsql="update sk_srvcontrdet set statusid=4 where rowno='"+rowno+"'";                
				 // System.out.println("upsql--->>>"+upsql);
				 val= stmt.executeUpdate(upsql);
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Route updated')";
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
	     }else if(processid.equalsIgnoreCase("Close Job")){  
	    	 if(!(holddate.equalsIgnoreCase("undefined"))&&!(holddate.equalsIgnoreCase(""))&&!(holddate.equalsIgnoreCase("0"))) {   
				 sqlholddate=ClsCommon.changeStringtoSqlDate(holddate);  
		      }else{}
			 String inssql="update sk_srvcontrm set status=6,closedate='"+sqlholddate+"',closereason='"+remarks+"' where tr_no='"+contrno+"'";                        
			 //System.out.println("inssql--->>>"+inssql);    
			 val= stmt.executeUpdate(inssql);    
			 
			 if(val>0){      
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Terminated / Cancel job')";
				// System.out.println("logsql--->>>"+logsql);    
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Service Request")){
	    	 int srdocno=0;
	    	 String strsql1="select coalesce(max(srdocno)+1,10001) srdocno from sk_srvcontrdet";    
			 ResultSet rss = stmt.executeQuery(strsql1);    
			 while(rss.next()) {
				 srdocno=rss.getInt("srdocno");   
			 }
			 String inssql="update sk_srvcontrdet set srdocno="+srdocno+",srdesc='"+remarks+"' where rowno='"+rowno+"'";                      
			 //System.out.println("inssql--->>>"+inssql);    
			 val= stmt.executeUpdate(inssql);      
			 
			 if(val>0){   
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Service Request')";
				// System.out.println("logsql--->>>"+logsql);      
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Contract Update")){   
	    	 String upsql="update sk_srvcontrm cm left join sk_srvcsited s on s.tr_no=cm.tr_no and s.sr_no=1 left join sk_srvcontrdet d on d.rdocno=cm.tr_no and d.siteid=s.rowno set cm.cldocno='"+cldocno+"', cm.cpersonid='"+cpersonid+"', cm.cperson='"+cperson+"', cm.mob='"+mobile+"', cm.cpemail='"+email+"', cm.email='"+invoicemail+"', cm.refno='"+refno+"', cm.remarks='"+remarks+"', s.site='"+site+"', s.areaid='"+areaid+"',d.site='"+site+"' where cm.tr_no='"+contrno+"'";
	    	 //System.out.println("upsql--->>>"+upsql);      
			 val= stmt.executeUpdate(upsql);        
			 
			 if(val>0){   
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Contract Details Updated')";
				// System.out.println("logsql--->>>"+logsql);        
				 val= stmt.executeUpdate(logsql);       
			 }
			 if(val>0){
				 temp="1";  
			 }
	     }else if(processid.equalsIgnoreCase("Status Update")){           
	    	 String upsql="update sk_srvcontrm set statusid='"+statusid+"' where tr_no='"+contrno+"'"; 
	    	 //System.out.println("upsql--->>>"+upsql);      
			 val= stmt.executeUpdate(upsql);        
			 
			 if(val>0){     
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Status Updated')";
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
	    	 String upsql="insert into sk_srvcontrrenew(cnttrno, rsrno, requser, remarks, date) values('"+contrno+"','"+srno+"','"+requesteduser+"','"+renewreqremarks+"','"+sqlrenewaldate+"')";         
	    	 //System.out.println("upsql--->>>"+upsql);      
			 val= stmt.executeUpdate(upsql);              
			 
			 if(val>0){       
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Contract Revise Request')";   
				// System.out.println("logsql--->>>"+logsql);          
				 val= stmt.executeUpdate(logsql);          
			 }
			 if(val>0){
				 temp="1";    
			 }
	     }else if(processid.equalsIgnoreCase("Pull Out")){      
	    	 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))) {     
	    		 sqlpodate=ClsCommon.changeStringtoSqlDate(podate);    
		      }else{}
	    	 String upsql="insert into sk_srvcontrsch(rdocno, srno, brhid, delid, date, pskipno, status) values('"+contrno+"','"+srno+"','"+brhid+"','"+deldocno+"','"+sqlpodate+"','"+poskipno+"',2)";                 
	    	 //System.out.println("upsql--->>>"+upsql);       
			 val= stmt.executeUpdate(upsql);              
			 
			 if(val>0){       
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Pull Out')";   
				// System.out.println("logsql--->>>"+logsql);          
				 val= stmt.executeUpdate(logsql);          
			 }
			 if(val>0){
				 temp="1";    
			 }
	     }else if(processid.equalsIgnoreCase("Confirm")){
			 String inssql="update sk_srvcontrm set srfconfirm=1 where tr_no='"+contrno+"'";                   
			 //System.out.println("inssql--->>>"+inssql);    
			 val= stmt.executeUpdate(inssql);    
			 
			 String inssql2="update sk_srvcontrsrf set confirm=1 where doc_no='"+srdocnos+"'";                      
			 //System.out.println("inssql2--->>>"+inssql2);    
			 val= stmt.executeUpdate(inssql2);
			 if(val>0){   
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+contrno+"','"+brhid+"','CNM',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Confirmed')";
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
