<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	
	int curprocessid=request.getParameter("curprocessid")==""?0:Integer.parseInt(request.getParameter("curprocessid"));
	
	
	
	System.out.println("=====curprocessid====="+request.getParameter("curprocessid"));
	String strSql ="",nxtprocess="",nxtprocessid="";
	
	strSql ="select nxtproces_id as nxtprocessid,p.status nxtproces from is_procstatus pr inner join is_pstatus p on(nxtproces_id=statusid and p.type='IENQ') where curproces_id="+curprocessid+" and pr.type='IENQ' ";	
	
	System.out.println("===strSql===="+strSql);
	
	ClsConnection ClsConnection=new ClsConnection();
	
 	Connection conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	ResultSet rs = stmt.executeQuery(strSql);
	
	while(rs.next()) {
		
		nxtprocessid+=rs.getString("nxtprocessid")+",";
		nxtprocess+=rs.getString("nxtproces")+",";
	}
		   
	String nxtprocid[]=nxtprocessid.split(",");
	String nxtproc[]=nxtprocess.split(",");
	nxtprocessid=nxtprocessid.substring(0, nxtprocessid.length()-1);
	nxtprocess=nxtprocess.substring(0, nxtprocess.length()-1);
       
    response.getWriter().write(nxtprocessid+"####"+nxtprocess);
	
   
	stmt.close();
	conn.close();
  %>
  
