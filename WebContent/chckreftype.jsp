<%@page import="com.connection.*" %>
<%@page import="javax.sql.*"%>
<%@page import="com.common.*" %>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%

Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
ResultSet rs=null;
ResultSet rs1=null;
String gate=null;
Statement st=null;
String dtype=request.getParameter("dtype").equalsIgnoreCase("0")||request.getParameter("dtype")==null || request.getParameter("dtype")==""?"0":request.getParameter("dtype");

try{
	JSONArray prdarray=new JSONArray();
	JSONObject objprd=new JSONObject(); 
	conn=ClsConnection.getMyConnection();
	int a=0;
	st=conn.createStatement();
	String table_sql="SELECT COUNT(*) AS table_exists FROM information_schema.tables WHERE table_schema = DATABASE() and table_name = 'my_reftype'";
	System.out.println("table_sql : "+table_sql);

	rs=st.executeQuery(table_sql);
	if(rs.next()){
		a=rs.getInt("table_exists");
	}
	System.out.println("a : "+a);

	if(a==1){
		String sql="select form_code from my_reftype where  dtype='"+dtype+"' and status=3 order by seqno asc";
		System.out.println("qwer : "+sql);
		rs1=st.executeQuery(sql);
		while(rs1.next()){
			JSONObject objsub=new JSONObject();
			//objsub.put("method",rs.getString("gate"));
			objsub.put("reftype",rs1.getString("form_code"));
			prdarray.add(objsub);
			//gate=rs.getString("gate");
		}
	}else{
		System.out.println("a else : "+a);

		prdarray.add(0);
	}
	
	objprd.put("refdata", prdarray);
	System.out.println("objprd : "+objprd);

	response.getWriter().print(objprd);
	 
	st.close();
	conn.close();
	
}catch(Exception e){
	e.printStackTrace();
	 
	st.close();
	conn.close();
}finally{
	 if(st != null){
		 st.close();
	 }
	 if(rs !=null){
		 rs.close();
	 }
	 if(rs1 !=null){
		 rs1.close();
	 }
	 if(conn !=null){
		 conn.close(); 
	 }
	
	
}
%>