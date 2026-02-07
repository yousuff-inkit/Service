<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="javax.servlet.http.HttpSession"%>
<% 
 String gridarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
 String pdate =request.getParameter("pdate")==null?"":request.getParameter("pdate").toString();
 String ptime =request.getParameter("ptime")==null?"":request.getParameter("ptime").toString();
 
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		int val=0;
		
		java.sql.Date idate=null;
		if(!(pdate.equalsIgnoreCase("0") || pdate.equalsIgnoreCase("undefined") || pdate.equalsIgnoreCase("a") )){
			idate = ClsCommon.changeStringtoSqlDate(pdate);
		}
		
		String userid=session.getAttribute("USERID").toString();
		
		ArrayList<String> newarray=new ArrayList();   
		String temparray[]=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
			newarray.add(temparray[i]);
		} 
		
		for(int i=0;i<newarray.size();i++){
			
			String temp[]=newarray.get(i).split("::");
			
			String dtype = temp[0];
			String refdocno = temp[1];
			String empid = temp[2];
			String dbname = temp[3];
			String brhid = temp[4];
			
			String strSql = "update cm_srvassign set inactive=1, inactivedate='"+idate+"', inactivetime='"+ptime+"' where dtype='"+dtype+"' and refdocno="+refdocno+" and empid="+empid+" and dbname='"+dbname+"';";
			val = stmt.executeUpdate(strSql);
		
			if(val>0){
				String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+refdocno+"','"+brhid+"','BREA',now(),'"+userid+"','E')";
				int datas= stmt.executeUpdate(sqls);
				if(datas<=0){
				 	stmt.close();
				 	conn.close();
				}
			}
		}
		
		response.getWriter().write(val+"###");

		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
