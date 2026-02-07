 <%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsEncrypt" %>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%        
//System.out.println("Location innnnnnnnn====");
      
	JSONObject objdata=new JSONObject();
	 String pass_wordss=request.getParameter("pass_wordss")==null?"0":request.getParameter("pass_wordss");
	 String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid");
	   
		String location="",docno="";


 	Connection conn = null;
try{	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement ();
	int val=0;
	//String brhid = session.getAttribute("BRANCHID").toString(); 
	System.out.println("brnch===="+brhid);
	
	
	String strSql = "select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="+brhid+" order by m.doc_no asc";
	
	System.out.println("--locatioset--"+strSql);
	
	ResultSet rs = stmt.executeQuery(strSql);
	int userid=0;
	JSONArray locarray=new JSONArray();
	
	while(rs.next ()) {
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno",rs.getString("doc_no"));
		objtemp.put("location",rs.getString("location"));
		locarray.add(objtemp);
		docno+=rs.getString("doc_no")+",";
		location+=rs.getString("location")+",";
		 
	}
	objdata.put("locdata",locarray);
	
	
	
	
	stmt.close();
	conn.close();

	response.getWriter().print(docno+"###"+location+"###"+objdata);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>