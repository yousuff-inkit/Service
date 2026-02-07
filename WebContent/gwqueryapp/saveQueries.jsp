<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

	String username=request.getParameter("username")==null?"":request.getParameter("username");
	String usermobile=request.getParameter("usermobile")==null?"":request.getParameter("usermobile");
	String usermail=request.getParameter("usermail")==null?"":request.getParameter("usermail");
	String formname=request.getParameter("formname")==null?"":request.getParameter("formname");
	String shortdesc=request.getParameter("shortdesc")==null?"":request.getParameter("shortdesc");
	String query=request.getParameter("query")==null?"":request.getParameter("query");
	String comprefid=request.getParameter("comprefid")==null?"":request.getParameter("comprefid");
	Connection conn=null;
	JSONObject objdata=new JSONObject();
	int errorstatus=0;
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement();
		int maxdocno=0,datechk=0;
		String strmaxdocno="select coalesce(max(doc_no),0)+1 maxdocno from gw_querym";
		ResultSet rsmaxdocno=stmt.executeQuery(strmaxdocno);
		while(rsmaxdocno.next()){
			maxdocno=rsmaxdocno.getInt("maxdocno");
		}
		String strcurdate="select if(curdate()>date,1,0) datechk from gw_complist where comp_id='"+comprefid+"'";
		ResultSet rscurdate=stmt.executeQuery(strcurdate);
		while(rscurdate.next()){
			datechk=rscurdate.getInt("datechk");
		}
		
		if(datechk!=1){
			String strinsert="insert into gw_querym(doc_no, username, usermobile, usermail, formname, shortdesc, "+
			" query, postdate, status, comprefid,statusdocno)values("+maxdocno+",'"+username+"','"+usermobile+"','"+usermail+"',"+
			" '"+formname+"','"+shortdesc+"','"+query+"',now(),3,"+comprefid+",1)";
			int insertvalue=stmt.executeUpdate(strinsert);
			if(insertvalue<=0){
				errorstatus=1;
			}
			String strfollowup="insert into gw_queryfollowup(rdocno, entrydate, comprefid,username, "+
			" processstatus, description)values("+maxdocno+",now(),"+comprefid+",'"+username+"',1,'"+shortdesc+"')";
			int followup=stmt.executeUpdate(strfollowup);
			if(followup<=0){
				errorstatus=1;
			}
		}
		if(errorstatus==0 || datechk==1){
			conn.commit();
		}
		
		if(datechk==1){
			errorstatus=-1;
		}
		objdata.put("errorstatus",errorstatus);
		objdata.put("querydocno",maxdocno);
	}
	catch(Exception e){
		errorstatus=1;
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>
