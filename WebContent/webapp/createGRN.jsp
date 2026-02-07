<%@page import="java.util.ArrayList"%>
<%@page import="com.procurement.purchase.goodsreceiptnote.ClsgoodsreceiptnoteDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String strgrnarray[]=request.getParameterValues("grnarray[]");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
String location=request.getParameter("location")==null?"":request.getParameter("location").toString();
String vendor=request.getParameter("vendor")==null?"":request.getParameter("vendor").toString();
String desc=request.getParameter("desc")==null?"":request.getParameter("desc").toString();
JSONObject objdata=new JSONObject();
int errorstatus=0;
try{
	System.out.println("inside create grn");
	System.out.println("Array First:"+strgrnarray[0]);
	
	ClsgoodsreceiptnoteDAO grndao=new ClsgoodsreceiptnoteDAO();
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strmisc="select head.curid,head.rate,ac.acno,curdate() basedate from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.cldocno="+vendor+" and ac.dtype='VND' and ac.status=3";
	System.out.println(strmisc);
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	java.sql.Date sqldate=null;
	int vendoracno=0,curid=0;
	double currate=0.0;
	while(rsmisc.next()){
		sqldate=rsmisc.getDate("basedate");
		vendoracno=rsmisc.getInt("acno");
		curid=rsmisc.getInt("curid");
		currate=rsmisc.getDouble("rate");
	}
	conn.close();
	ArrayList<String> grnarray=new ArrayList();
	for(int i=0;i<strgrnarray.length;i++){
		grnarray.add(strgrnarray[i]);
	}
	int grndocno=grndao.insert(sqldate, sqldate, "", vendoracno, curid, currate, "","", desc, 0.0, 0.0, 
			0.0, 0.0, 0.0, 0.0, 0.0, 0, session, "A", "GRN", request, grnarray, "DIR", 
			"", 0.0, Integer.parseInt(location), sqldate, "INV_APP", 0, 0);
	if(grndocno<=0){
		errorstatus=0;
	}
	else{
		objdata.put("grndocno",grndocno);
	}
}
catch(Exception e){
	e.printStackTrace();
	errorstatus=1;
	conn.close();
}
finally{
	conn.close();
}
objdata.put("errorstatus",errorstatus);
response.getWriter().write(objdata+"");
%>