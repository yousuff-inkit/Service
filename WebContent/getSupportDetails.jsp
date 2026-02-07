<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	String userid=request.getParameter("userid")==null?"":request.getParameter("userid");
	String compid=request.getParameter("compid")==null?"":request.getParameter("compid");
	Connection conn=null;
	JSONObject objdata=new JSONObject();
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String struserdetails="select coalesce(user_name,'') username,coalesce(mail,'') mail,coalesce(mobile,'') mobile from my_user where status=3 and doc_no="+userid;
		ResultSet rsuserdetails=stmt.executeQuery(struserdetails);
		while(rsuserdetails.next()){
			objdata.put("username",rsuserdetails.getString("username"));
			objdata.put("usermail",rsuserdetails.getString("mail"));
			objdata.put("usermobile",rsuserdetails.getString("mobile"));
		}
		int comprefid=0;
		String strcompdetails="select if(coalesce(comp_refid,'')='',0,comp_refid)  comprefid,coalesce(company,'') companyname from my_comp where status=3 and doc_no="+compid;
		ResultSet rscompdetails=stmt.executeQuery(strcompdetails);
		while(rscompdetails.next()){
			comprefid=rscompdetails.getInt("comprefid");
			objdata.put("compname",rscompdetails.getString("companyname"));
		}
		objdata.put("comprefid",comprefid);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>
