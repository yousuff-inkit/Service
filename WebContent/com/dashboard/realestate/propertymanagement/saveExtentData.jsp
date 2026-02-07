<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>  
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>    
<%@page import="com.common.*"%>                   
<%   
	String extdate=request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");
	String amount=request.getParameter("amount")==null || request.getParameter("amount")==""?"0":request.getParameter("amount");   
	String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
	String rntldocno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString();
	String userid=session.getAttribute("USERID").toString();      
	ClsConnection objconn=new ClsConnection();    
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;
	int val=0,val1=0,propertyid=0,propertysrno=0; 
	String rntlmark="R",logdesc="";       
	java.sql.Date sqlfromdate=null;
	java.sql.Date sqltodate=null;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement(); 
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");  
		if(!extdate.equalsIgnoreCase("0")){
			sqltodate=ClsCommon.changeStringtoSqlDate(extdate);     
		}
		 String sqlget="select propertyid, propertysub,date_format(todate,'%d.%m.%Y') todate from rl_rental where doc_no="+rntldocno+"";                       
		 ResultSet rs = stmt.executeQuery(sqlget);
		 while(rs.next()) {
				sqlfromdate=ClsCommon.changeStringtoSqlDate(rs.getString("todate"));  
				propertyid=rs.getInt("propertyid");
				propertysrno=rs.getInt("propertysub");   
	     }   
		 String sql1="insert into rl_rentald(rdocno, prevtodate, extdate, totalval) values("+rntldocno+",'"+sqlfromdate+"','"+sqltodate+"',"+amount+")";        
		 //System.out.println("====sql1===="+sql1);      
		 val=stmt.executeUpdate(sql1); 
		if(val>0){ 
			 String sql="update rl_rental set todate='"+sqltodate+"' where doc_no="+rntldocno+"";           
			 //System.out.println("====sql===="+sql);   
			 val=stmt.executeUpdate(sql); 
			}
		 if(val>0){
			 Date stDate = sqlfromdate;       
			 Date startDate = new Date(stDate. getTime() + (1000 * 60 * 60 * 24));
			 Date enDate = sqltodate;  
			 Date endDate = new Date(enDate. getTime() + (1000 * 60 * 60 * 24));    
			 Calendar start = Calendar.getInstance();
			 start.setTime(startDate);
			 Calendar end = Calendar.getInstance();     
			 end.setTime(endDate);
			 for (Date date = start.getTime(); start.before(end); start.add(Calendar.MONTH, 1), date = start.getTime()) {
			     //System.out.println(ClsCommon.changeStringtoSqlDate(formatter.format(date)));          
			     String sqlinsert="insert into rl_rentaldays(propertyid, propertysrno, year, month) select m.doc_no docno,coalesce(s.srno,0) srno,year('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') year,month('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') month from rl_propertymaster m left join rl_propertysub s on s.propertyid=m.doc_no  left join rl_rentaldays rd on (coalesce(rd.propertysrno,0)=coalesce(s.srno,0) and rd.propertyid=m.doc_no and rd.month=month('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') and rd.year=year('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"')) where m.status<>7 and rd.rowno is null"; 
				 //System.out.println("sqlinsert--->>>"+sqlinsert);           
			     val=stmt.executeUpdate(sqlinsert);
			 }  
			 
			 stDate = sqlfromdate;              
			 startDate = new Date(stDate. getTime() + (1000 * 60 * 60 * 24));
			 enDate = sqltodate;  
			 endDate = new Date(enDate. getTime() + (1000 * 60 * 60 * 24));    
			 start = Calendar.getInstance();
			 start.setTime(startDate);
			 end = Calendar.getInstance();     
			 end.setTime(endDate);
			 for (Date date = start.getTime(); start.before(end); start.add(Calendar.DATE, 1), date = start.getTime()) {
			     //System.out.println(ClsCommon.changeStringtoSqlDate(formatter.format(date)));          
			     String sqlinsert="update rl_rentaldays set day"+start.get(Calendar.DAY_OF_MONTH)+"='"+rntlmark+"' where propertyid="+propertyid+" and propertysrno="+propertysrno+" and year=year('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') and month=month('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"')";     
				 //System.out.println("sqlinsert--->>>"+sqlinsert);                                 
			     val=stmt.executeUpdate(sqlinsert);
			  } 
			 
			 logdesc="Rental Extented - Rental Docno#"+rntldocno;            
			 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','PMT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                       
			 //System.out.println(val+"====sqllog===="+sqllog);
			 stmt.executeUpdate(sqllog);               
			 val1=1;                      
			 conn.commit(); 
		 }
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}   
	response.getWriter().print(val1);                 
%>