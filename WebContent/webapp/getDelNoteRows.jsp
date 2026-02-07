<%@page import="webapp.ClsWebAppDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
String location=request.getParameter("location")==null?"":request.getParameter("location").toString();
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();
String delnotedocno=request.getParameter("delnotedocno")==null?"":request.getParameter("delnotedocno").toString();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsWebAppDAO dao=new ClsWebAppDAO();
	JSONArray delnotearray=new JSONArray();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	String strsql="select m.barcode,d.stockid as stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty,"+
	" sum(qty) as oldqty,round(sum(qty-out_qty),0) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,part_no,m.part_no productid,m.part_no as proid,"+
	" m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice, d.amount unitprice,d.total,"+
	" d.disper discper,d.discount dis,d.nettotal netotal from my_delm ma left join  my_deld d on d.rdocno=ma.doc_no left join my_main m "+
	" on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on "+
	" m.brandid=bd.doc_no where m.status=3 and d.rdocno in("+delnotedocno+") and ma.brhid="+branch+" and ma.locid="+location+" group by d.rdocno,d.psrno,d.unitid having sum(d.qty-d.out_qty)>0 order by d.rdocno,d.prdid,d.stockid";
	ResultSet rs=stmt.executeQuery(strsql);
	while(rs.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("brandname",rs.getString("barcode"));
		objtemp.put("stkid",rs.getString("stkid"));
		objtemp.put("specid",rs.getString("specid"));
		objtemp.put("doc_no",rs.getString("doc_no"));
		objtemp.put("rdocno",rs.getString("rdocno"));
		objtemp.put("psrno",rs.getString("psrno"));
		objtemp.put("prodoc",rs.getString("prodoc"));
		objtemp.put("totqty",rs.getString("totqty"));
		objtemp.put("oldqty",rs.getString("oldqty"));
		objtemp.put("qty",rs.getString("qty"));
		objtemp.put("outqty",rs.getString("outqty"));
		objtemp.put("balqty",rs.getString("balqty"));
		objtemp.put("part_no",rs.getString("part_no"));
		objtemp.put("productid",rs.getString("productid"));
		objtemp.put("proid",rs.getString("proid"));
		objtemp.put("productname",rs.getString("productname"));
		objtemp.put("proname",rs.getString("proname"));
		objtemp.put("unit",rs.getString("unit"));
		objtemp.put("unitdocno",rs.getString("unitdocno"));
		objtemp.put("totwtkg",rs.getString("totwtkg"));
		objtemp.put("kgprice",rs.getString("kgprice"));
		objtemp.put("unitprice",rs.getString("unitprice"));
		objtemp.put("total",rs.getString("total"));
		objtemp.put("discper",rs.getString("discper"));
		objtemp.put("dis",rs.getString("dis"));
		objtemp.put("netotal",rs.getString("netotal"));
		delnotearray.add(objtemp);
		
	}
	objdata.put("delnoterowdata",delnotearray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>