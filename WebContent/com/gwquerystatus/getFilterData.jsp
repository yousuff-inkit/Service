<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.connection.*"%>
<%@page import="com.common.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
Connection conn=null;
String compid=request.getParameter("compid")==null?"":request.getParameter("compid");
JSONObject objdata=new JSONObject();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String sqltest="",sqlbranch="";
	if(!compid.equalsIgnoreCase("") && !compid.equalsIgnoreCase("a") && !compid.equalsIgnoreCase("undefined")){
		sqltest+=" and m.comprefid="+compid;
		/* sqlbranch+=" and brhid="+brhid; */
	}
	//getting card data
	
	String strgetcarddata="select count(*) totalcount,sum(if(m.processstatus=1,1,0)) entercount,sum(if(m.processstatus in(2),1,0)) ackcount,sum(if(m.processstatus=3,1,0)) mailcount,sum(if(m.processstatus=4,1,0))"+
	" statuscount from gw_querym m where m.statusdocno<>8 and m.status=3"+sqltest;
	ResultSet rsgetcarddata=stmt.executeQuery(strgetcarddata);
	while(rsgetcarddata.next()){
		objdata.put("totalcount",rsgetcarddata.getInt("totalcount"));
		objdata.put("entercount",rsgetcarddata.getInt("entercount"));
		objdata.put("ackcount",rsgetcarddata.getInt("ackcount"));
		objdata.put("mailcount",rsgetcarddata.getInt("mailcount"));
		objdata.put("statuscount",rsgetcarddata.getInt("statuscount"));
	}
	
	//Getting GIP List
	String strgetcardlist="select coalesce(ass.description,'') laststatus,round(timestampdiff(hour,m.postdate,now()),2) totaltime,round(timestampdiff(hour,q.entrydate,now()),2) laststatustime,m.processstatus,m.doc_no,comp.company,m.username,m.formname,m.shortdesc from gw_querym m"+
	" left join gw_complist comp on m.comprefid=comp.comp_id left join"+
	" (select max(doc_no) maxdocno,rdocno from gw_queryfollowup where status=3 group by rdocno) maxquery on (maxquery.rdocno=m.doc_no)"+
	" left join gw_queryfollowup q on q.doc_no=maxquery.maxdocno left join cm_assignstatus ass on m.statusdocno=ass.doc_no where m.statusdocno<>8 and m.status=3"+sqltest+" group by m.doc_no";
	ResultSet rsgetcardlist=stmt.executeQuery(strgetcardlist);
	JSONArray entercardarray=new JSONArray();
	JSONArray ackcardarray=new JSONArray();
	JSONArray mailcardarray=new JSONArray();
	JSONArray statuscardarray=new JSONArray();
	while(rsgetcardlist.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("docno", rsgetcardlist.getString("doc_no"));
		objtemp.put("company", rsgetcardlist.getString("company"));
		objtemp.put("username", rsgetcardlist.getString("username"));
		objtemp.put("formname", rsgetcardlist.getString("formname"));
		objtemp.put("shortdesc", rsgetcardlist.getString("shortdesc"));
		objtemp.put("totaltime", rsgetcardlist.getString("totaltime"));
		objtemp.put("laststatustime", rsgetcardlist.getString("laststatustime"));
		objtemp.put("laststatus", rsgetcardlist.getString("laststatus"));
		if(rsgetcardlist.getInt("processstatus")==1){
			entercardarray.add(objtemp);
		}
		else if(rsgetcardlist.getInt("processstatus")==2){
			ackcardarray.add(objtemp);
		}
		else if(rsgetcardlist.getInt("processstatus")==3){
			mailcardarray.add(objtemp);
		}
		else if(rsgetcardlist.getInt("processstatus")==4){
			statuscardarray.add(objtemp);
		}
	}
	String strcompwise="select comp.company,count(*) querycount from gw_querym m left join gw_complist comp on m.comprefid=comp.comp_id where m.statusdocno<8 and status=3 group by m.comprefid";	
	JSONArray compwisearray=new JSONArray();
	ResultSet rscompwise=stmt.executeQuery(strcompwise);
	while(rscompwise.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("compname",rscompwise.getString("company"));
		objtemp.put("count",rscompwise.getInt("querycount"));
		compwisearray.add(objtemp);
	}
	objdata.put("entercarddata",entercardarray);
	objdata.put("ackcarddata",ackcardarray);
	objdata.put("mailcarddata",mailcardarray);
	objdata.put("statuscarddata",statuscardarray);
	objdata.put("compwisedata",compwisearray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
System.out.println(objdata);
response.getWriter().write(objdata+"");
%>