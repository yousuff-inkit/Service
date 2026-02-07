<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%	


Connection conn =null;
Statement stmt =null;
ClsConnection ClsConnection=new ClsConnection();

  try{
	  
 
	//String brch=request.getParameter("branch");
	 String userfrmid=request.getParameter("userfrmid").toString().trim();
	//String userfrmid=session.getAttribute("USERID").toString().trim();
	//System.out.println("======userfrmid==="+userfrmid);
	String strSql ="",user="";
	int msgcnt=0;
	int cnt=0;
		 strSql ="select distinct coalesce(concat(c.comp_code,':',u.user_id),'')  as user,(select count(*) from gw_mesngr n left join gw_userlist v on(n.userfrm=v.doc_no) inner join gw_complist co on(v.comp_id=co.doc_no) where n.is_read=0 and userto='"+userfrmid+"') as  msgcount from gw_mesngr m inner join gw_userlist u on(m.userfrm=u.doc_no) inner join gw_complist c on(u.comp_id=c.doc_no)   where m.is_read=0 and userto='"+userfrmid+"' ";	
	
	//System.out.println("===strSql===="+strSql);
 	 conn = ClsConnection.getMyConnection();
	 stmt = conn.createStatement ();
	ResultSet rs = stmt.executeQuery(strSql);
	
	while(rs.next()) {
		
			if(cnt==0){
				user=rs.getString("user");
				msgcnt=rs.getInt("msgcount");
			}
			else{
				user=user+","+rs.getString("user");
				msgcnt=rs.getInt("msgcount");
			}
			cnt++;
	}
	

	
    response.getWriter().write(user+"####"+msgcnt);
  }
catch(Exception e){
	e.printStackTrace();
}
finally{
	stmt.close();
	conn.close();
}
   
	
	
  %>
  
