<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%

	Connection conn=null;
	JSONObject objdata=new JSONObject();
	int errorstatus=0;
	String comprefid=request.getParameter("comprefid")==null ||request.getParameter("comprefid").equals("")?"0":request.getParameter("comprefid");
	try{
		ClsConnection objconn=new ClsConnection();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		JSONArray queryarray=new JSONArray();
		JSONArray changearray=new JSONArray();
		String strsql="select m.type,coalesce(pr.description,'Entered') assignstatus,m.comprefid,m.doc_no,m.username,m.usermobile,m.usermail,m.formname,m.shortdesc,m.query querytext,cmp.company from gw_querym m left join gw_complist cmp on m.comprefid=cmp.comp_id left join cm_assignstatus pr on m.statusdocno=pr.doc_no where m.status=3 and m.statusdocno<8 and m.comprefid="+comprefid;
		System.out.println("=strsql="+strsql);   
		ResultSet rs=stmt.executeQuery(strsql);
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rs.getString("doc_no"));
			objtemp.put("username",rs.getString("username"));
			objtemp.put("usermobile",rs.getString("usermobile"));
			objtemp.put("usermail",rs.getString("usermail"));
			objtemp.put("formname",rs.getString("formname"));
			objtemp.put("shortdesc",rs.getString("shortdesc"));
			objtemp.put("query",rs.getString("querytext"));
			objtemp.put("compname",rs.getString("company"));
			objtemp.put("comprefid",rs.getString("comprefid"));
			objtemp.put("assignstatus",rs.getString("assignstatus"));
			if(rs.getString("type").equalsIgnoreCase("1")){
				queryarray.add(objtemp);	
			}
			else{
				changearray.add(objtemp);
			}
			
		}
		JSONArray comparray=new JSONArray();
		if(comprefid.trim().equalsIgnoreCase("9710001")){
			String strcompdetails="select comp_id  comprefid,coalesce(company,'') companyname from gw_complist ";
			ResultSet rscompdetails=stmt.executeQuery(strcompdetails);
			while(rscompdetails.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("compname",rscompdetails.getString("companyname"));
				objtemp.put("comprefid",rscompdetails.getString("comprefid"));
				comparray.add(objtemp);
			}
		}
		objdata.put("querydata",queryarray);
		objdata.put("changedata",changearray);
		objdata.put("complist",comparray);
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
