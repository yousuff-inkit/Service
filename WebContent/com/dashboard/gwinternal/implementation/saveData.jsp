<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.connection.*" %>
<%
ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
int data1=0;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String checklistarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
		String compid =request.getParameter("compid")==null?"":request.getParameter("compid");
		
		ArrayList<String> griddataarray=new ArrayList<String>();
		 String[] temparray=checklistarray.split(",");  
		 for(int i=0;i<temparray.length;i++){
			griddataarray.add(temparray[i]);    
		 }
		 
		 String delsql="delete from zt_compdetails where compid='"+compid+"'";        
		 //System.out.println("delsql--->>>"+delsql);
		 stmt.executeUpdate(delsql);
		 
		 for(int i=0;i< griddataarray.size();i++){       
				String[] contrtypedet=((String) griddataarray.get(i)).split("::");
				if(!(contrtypedet[0].trim().equalsIgnoreCase("undefined")|| contrtypedet[0].trim().equalsIgnoreCase("NaN")||contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty())){
					String checked=(contrtypedet[0].trim().equalsIgnoreCase("undefined") || contrtypedet[0].trim().equalsIgnoreCase("NaN")|| contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty()?"0":contrtypedet[0].trim());
					String remarks=(contrtypedet[1].trim().equalsIgnoreCase("undefined") || contrtypedet[1].trim().equalsIgnoreCase("NaN")|| contrtypedet[1].trim().equalsIgnoreCase("")|| contrtypedet[1].isEmpty()?"":contrtypedet[1].trim());
					String details=(contrtypedet[2].trim().equalsIgnoreCase("undefined") || contrtypedet[2].trim().equalsIgnoreCase("NaN")|| contrtypedet[2].trim().equalsIgnoreCase("")|| contrtypedet[2].isEmpty()?"":contrtypedet[2].trim());
					 
					String sql="insert into zt_compdetails(compid,checked,remarks,detail) values ('"+compid+"','"+checked+"','"+remarks+"','"+details+"')";    
					//System.out.println("sql==="+sql);
					  data1=stmt.executeUpdate(sql);
				}
		 }
		response.getWriter().print(data1);
}catch(Exception e){
 	e.printStackTrace();
 	conn.close();
}finally{
   conn.close();
}
%>