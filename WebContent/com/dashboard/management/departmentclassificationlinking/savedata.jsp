<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
	
	ClsConnection ClsConnection=new ClsConnection();
	String list=request.getParameter("list")==null?"0":request.getParameter("list");
	list=list.replace("[","");
	list=list.replace("]","");
	list=list.replace("\"","");
	ArrayList<String> mainarray= new ArrayList<String>();
	 String aa[]=list.split(",");
	for(int i=0;i<aa.length;i++){
	 String bb[]=aa[i].split("::");
	
	 String temp="";
	 for(int j=0;j<bb.length;j++){		
		 temp=temp+bb[j]+"::";
	}
	 
	 
	 mainarray.add(temp);
	 
 } 
 	
	
	 Connection conn=null;
	    String sql="";
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		int resultSet4 =0;
		int count = 0;
		
		for(int k=0;k<mainarray.size();k++)
	{
		 String[] serarray=mainarray.get(k).split("::");
		 int counta=0;
		 String sql1="select count(*) count from my_deptlink where classid='"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"' "
	 				+" and deptid='"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"' and status<>7";
	 	 ResultSet resultset = stmt.executeQuery(sql1);
	 	 if(resultset.next()){
	 		 counta=resultset.getInt("count");
	 		 if(counta==0){
	 			 count++;
	 			String sql2="insert into my_deptlink set classid='"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"' "
	 	 				+" ,deptid='"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"' "+
	 	 				" , status=3";
	 				resultSet4=stmt.executeUpdate(sql2);
	 		 }
	 }
}
	
	 stmt.close();
	 conn.close();

	 response.getWriter().print(resultSet4);
	    }	
	    
	    catch(Exception e)
	    {
	    	response.getWriter().print(0);
	    	e.printStackTrace();
	    	conn.close();
	    } 
 	
%>
 