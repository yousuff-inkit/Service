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
	String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
	String rntldocno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString();
	String userid=session.getAttribute("USERID").toString();      
	ClsConnection objconn=new ClsConnection();    
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;
	int val=0,val1=0,propertyid=0,propertysrno=0;   
	String avlmark="",logdesc="";   
	java.sql.Date sqlfromdate=null;
	java.sql.Date sqltodate=null;
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement(); 
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");  
		
		String sql="update rl_rental set cancelstatus=1 where doc_no="+rntldocno+"";   
		//System.out.println("====sql===="+sql);   
		val=stmt.executeUpdate(sql);    
		if(val>0){ 
			 String sqlget="select propertyid, propertysub,date_format(fromdate,'%d.%m.%Y') fromdate,date_format(todate,'%d.%m.%Y') todate from rl_rental where doc_no="+rntldocno+"";                       
			 ResultSet rs = stmt.executeQuery(sqlget);
				while(rs.next()) {
					sqltodate=ClsCommon.changeStringtoSqlDate(rs.getString("todate"));
					sqlfromdate=ClsCommon.changeStringtoSqlDate(rs.getString("fromdate"));  
					propertyid=rs.getInt("propertyid");
					propertysrno=rs.getInt("propertysub");   
				}
			 Date startDate = sqlfromdate;   
			 Date enDate = sqltodate;  
			 Date endDate = new Date(enDate. getTime() + (1000 * 60 * 60 * 24));    
			 Calendar start = Calendar.getInstance();
			 start.setTime(startDate);
			 Calendar end = Calendar.getInstance();     
			 end.setTime(endDate);
			 for (Date date = start.getTime(); start.before(end); start.add(Calendar.DATE, 1), date = start.getTime()) {
			     //System.out.println(ClsCommon.changeStringtoSqlDate(formatter.format(date)));          
			     String sqlinsert="update rl_rentaldays set day"+start.get(Calendar.DAY_OF_MONTH)+"='"+avlmark+"' where propertyid="+propertyid+" and propertysrno="+propertysrno+" and year=year('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') and month=month('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"')";     
				 //System.out.println("sqlinsert--->>>"+sqlinsert);                    
			     val=stmt.executeUpdate(sqlinsert);
			  } 
			}
		 if(val>0){ 
			 logdesc="Rental cancelled - Rental Docno#"+rntldocno;            
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