<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	String brch=request.getParameter("branch");
	int statusid=request.getParameter("statusid")==""?0:Integer.parseInt(request.getParameter("statusid"));
	String dtype=request.getParameter("dtype");
	String docno=request.getParameter("docno")==""?"0":request.getParameter("docno").trim();
	String formcode=request.getParameter("formcode");
	
	System.out.println("=====brch====="+request.getParameter("branch"));
	System.out.println("=====statusid====="+request.getParameter("statusid"));
	System.out.println("=====dtype====="+request.getParameter("dtype"));
	System.out.println("=====docno====="+request.getParameter("docno"));
	System.out.println("=====formcode====="+request.getParameter("formcode"));
	String strSql ="",status="";
	int curprocessid=0;
	/* if((docno=="")||(docno==null)){
		 strSql = "select pr.curproces_id as curprocessid,p.status as status from is_procstatus pr inner join is_pstatus p on(pr.curproces_id=p.statusid) where p.dtype='"+formcode+"' group by pr.curproces_id ";
	}
	else
	{ */
		 strSql ="select e.curproces_id as curprocessid,p.status as status from is_enqmaster e inner join is_pstatus p on(e.curproces_id=p.statusid) where e.doc_no="+docno+" and p.type='IENQ'";	
	//}
	System.out.println("===strSql===="+strSql);
	
	ClsConnection ClsConnection=new ClsConnection();
	
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	ResultSet rs = stmt.executeQuery(strSql);
	
	while(rs.next()) {
		
		curprocessid=rs.getInt("curprocessid");
		status=rs.getString("status");
		
	}
		   
   
	
       
    response.getWriter().write(curprocessid+"####"+status);
	
   
	stmt.close();
	conn.close();
  %>
  
