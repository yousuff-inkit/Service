<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>

<%	
	ClsConnection ClsConnection=new ClsConnection();   
    String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno");  
	Connection conn = null;
	int estrevno=0,qotrevno=0;
	String reftype="",refdocno="0";  
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		
		String sql="select ref_type,refdocno,coalesce(revision_no,0) revision_no from cm_srvqotm where tr_no="+trno+"";
		//System.out.println("sql==="+sql);
		ResultSet rs = stmt.executeQuery(sql);  
		while(rs.next()){
			reftype=rs.getString("ref_type");
			refdocno=rs.getString("refdocno");
			qotrevno=rs.getInt("revision_no");       
		}
		
		String sql1="select coalesce(revision_no,0) revision_no from cm_prjestm where ref_type='"+reftype+"' and reftrno="+refdocno+"";
		//System.out.println("sql1==="+sql1);
		ResultSet rs1 = stmt.executeQuery(sql1);  
		while(rs1.next()){
			estrevno=rs1.getInt("revision_no");
		}
		System.out.println(estrevno+"####"+qotrevno);
		response.getWriter().write(estrevno+"####"+qotrevno);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}
  %>
  
