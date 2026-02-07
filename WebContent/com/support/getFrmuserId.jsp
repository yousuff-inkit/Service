<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*" %>

<%	
Connection conn =null;
Statement stmt =null;
Statement ucheckstmt =null;
Statement uinsertstmt =null;
Statement ucompstmt =null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();


try{
//String userfrmid=request.getParameter("userfrmid")==null?"0":request.getParameter("userfrmid").toString().trim();
String username=request.getParameter("username")==null?"":request.getParameter("username").toString().trim();
String compname=request.getParameter("compname")==null?"":request.getParameter("compname").toString().trim();
//System.out.println("=22222======username=compname= "+username+" "+compname+"");
conn =ClsConnection.getMyConnection();
String strSql ="",user="",userid="",compcode="",uchecksql="",uinsertsql="",ucompsql="",ucomp_id="",uapath="";
int usercount=0;

		uchecksql="select count(*) as usercheck from gw_userlist u inner join gw_complist c on(c.doc_no=u.comp_id) where c.comp_id='"+compname+"' and u.user_id='"+username+"'";
		
		//System.out.println("==uchecksql===="+uchecksql);
		
		ucheckstmt =conn.createStatement ();
		ResultSet rsucheck = ucheckstmt.executeQuery(uchecksql);
		while(rsucheck.next()) {
			usercount=rsucheck.getInt("usercheck");
			//System.out.println("usercount===="+usercount);
		}
		//System.out.println("==usercount===="+usercount);
		if(usercount==0){
			//System.out.println("==usercount=YESS===");
			ucompsql="select doc_no,rapath  from gw_complist where comp_id='"+compname+"'";
			//System.out.println("ucompsql======="+ucompsql);
			
			ucompstmt =conn.createStatement ();
			ResultSet rsucomp = ucompstmt.executeQuery(ucompsql);
			while(rsucomp.next()) {
				ucomp_id=rsucomp.getString("doc_no");
				uapath=rsucomp.getString("rapath");
				
			}
			java.util.Date date=new java.util.Date();
			   //System.out.println("==date====="+date);
			   java.sql.Date sd=ClsCommon.getSqlDate(date);
			
			 uinsertsql = "insert into gw_userlist(USER_ID,PASSWRD,DATE, USER_NAME,status, comp_id, aPath) values('"+username+"','1234','"+sd+"','"+username+"',3,'"+ucomp_id+"','"+uapath+"')";
			//System.out.println("uinsertsql======"+uinsertsql);
			uinsertstmt = conn.createStatement ();
			int rs = uinsertstmt.executeUpdate(uinsertsql);
			
			//System.out.println("==rs==="+rs);
		}

	
	strSql ="select user_id as user,company,u.doc_no as userid,c.comp_code as cmcode from gw_userlist u inner join gw_complist c on(c.doc_no=u.comp_id) where c.comp_id='"+compname+"' and u.user_id='"+username+"'";	
	
	//System.out.println("===strSql==getfrmuserid=="+strSql);
	
	stmt =conn.createStatement ();
	ResultSet rs = stmt.executeQuery(strSql);
	
	while(rs.next()) {
		
			user=rs.getString("user");
			userid=rs.getString("userid");
			compcode=rs.getString("cmcode");
	}
	

	
    response.getWriter().write(user+"####"+userid+"####"+compcode);
    
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	stmt.close();
	conn.close();
}
	
	
  %>
  
