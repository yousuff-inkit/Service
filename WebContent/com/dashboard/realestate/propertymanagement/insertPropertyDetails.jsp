<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>  
<%@page import="javax.servlet.http.HttpSession" %>
<%   
	ClsConnection objconn=new ClsConnection();    
	Connection conn=null;
	int val=0;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();  
		String sql="insert into rl_rentaldays(propertyid, propertysrno, year, month) select m.doc_no docno,coalesce(s.srno,0) srno,year(curdate()) year,month(curdate()) month from rl_propertymaster m left join rl_propertysub s on s.propertyid=m.doc_no  left join rl_rentaldays rd on (rd.propertyid=m.doc_no and coalesce(s.srno,0)=coalesce(rd.propertysrno,0) and rd.month=month(curdate()) and rd.year=year(curdate())) where m.status<>7 and rd.rowno is null"; 
		//System.out.println("sql--->>>"+sql);           
		val=stmt.executeUpdate(sql);    
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}   
	response.getWriter().print(val);              
%>