
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>


<%
ClsConnection ClsConnection=new ClsConnection();


	Connection conn = null;


	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String mno=request.getParameter("mno");
		String menuname =request.getParameter("menuname");
		String pmenu =request.getParameter("pmenu");
		String path=request.getParameter("path");
		String printpath1=request.getParameter("printpath1");
		
		String printpath2=request.getParameter("printpath2");
		String gate=request.getParameter("gate");
		System.out.println("reached");
		String sql="update my_menu set menu_name='"+menuname+"', pmenu='"+pmenu+"' ,func='"+path+"', printpath='"+printpath1+"',printpath2='"+printpath2+"',gate='"+gate+"' where mno='"+mno+"'";  
		//System.out.println("sql==="+sql);
		int data1=stmt.executeUpdate(sql);		
		//mno, menu_name, pmenu, param, func, printpath, printpath2, prg, mtitle, gate, doc_type, exebag, trtype, mtbl

		response.getWriter().print(data1);
}catch(Exception e){
 	e.printStackTrace();
 	conn.close();
}finally{
   conn.close();
}
%>