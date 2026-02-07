
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.json.JSONObject"%>
<%
JSONObject objdata=new JSONObject();
Connection conn=null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	int pordercount=0,salesordercount=0,delnotecount=0,grncount=0;
	Statement stmt=conn.createStatement();
	String strporder="SELECT count(*) pordercount  FROM my_ordm m LEFT JOIN my_ordd d ON m.TR_NO=d.TR_NO WHERE m.status=3 and (d.qty-d.out_qty>0 or d.qty-d.interOutQty>0) ";
	ResultSet rsporder=stmt.executeQuery(strporder);
	while(rsporder.next()){
		pordercount=rsporder.getInt("pordercount");
	}
	String strsalesorder="SELECT count(*) salesordercount FROM my_sorderm m LEFT JOIN my_sorderd d ON m.TR_NO=d.TR_NO WHERE m.status=3 and d.qty-d.out_qty>0";
	ResultSet rssalesorder=stmt.executeQuery(strsalesorder);
	while(rssalesorder.next()){
		salesordercount=rssalesorder.getInt("salesordercount");
	}
	
	String strdelnote="SELECT count(*) delnotecount FROM my_delm m LEFT JOIN my_deld d ON m.TR_NO=d.TR_NO WHERE m.status=3 and d.qty-d.out_qty>0";
	ResultSet rsdelnote=stmt.executeQuery(strdelnote);
	while(rsdelnote.next()){
		delnotecount=rsdelnote.getInt("delnotecount");
	}
	
	String strgrn="SELECT count(*) grncount FROM my_grnm m LEFT JOIN my_grnd d ON m.TR_NO=d.TR_NO WHERE m.status=3 and d.qty-d.out_qty>0";
	ResultSet rsgrn=stmt.executeQuery(strgrn);
	while(rsgrn.next()){
		grncount=rsgrn.getInt("grncount");
	}
	objdata.put("pordercount",pordercount);
	objdata.put("salesordercount",salesordercount);
	objdata.put("delnotecount",delnotecount);
	objdata.put("grncount",grncount);
}
catch(Exception e){
	e.printStackTrace();	
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>