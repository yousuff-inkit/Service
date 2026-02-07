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
String grndocno=request.getParameter("grndocno")==null?"":request.getParameter("grndocno").toString();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsWebAppDAO dao=new ClsWebAppDAO();
	JSONArray grnarray=new JSONArray();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();int mulqty=0;
	Statement stmt31 = conn.createStatement (); 
	 
	String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
	ResultSet rss31=stmt31.executeQuery(chk311); 
	if(rss31.next())
	{

		mulqty=rss31.getInt("method");
	}
	
	String joinsqls="";
	String joinsqls1="";
	if(mulqty>0)
	{
		 joinsqls=",d.psrno,d.unitid,d.specno ";
		  joinsqls1=" and dd.unitid=d.unitid  ";
		
	}
		
	//pqty mainqty maxfoc    foc
	String pySql="select m.barcode,'pro' checktype,d.stockid,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,round(sum(d.qty),2) mainqty,sum(dd.foc-dd.foc_out) maxfoc,"
			+ " sum(dd.foc-dd.foc_out)/sum(dd.fr) foc,round(sum(d.out_qty),2) pqty, "
			+ " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,round(sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr),2)  qty,  "
			+ " round(sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr),2) qutval,round(sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr),2)  "
			+ " saveqty  from  my_grnm  mm left join my_grnd d  on mm.tr_no=d.tr_no  "
			+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "+joinsqls1+" "
			+ "  left join my_main m on m.doc_no=d.prdId  "
			+ " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no  "
			+ "  where  mm.doc_no in ("+grndocno+")     group by d.stockid"+joinsqls+"  having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0 ";
		ResultSet rs=stmt.executeQuery(pySql);
		while(rs.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("brandname",rs.getString("barcode"));
			objtemp.put("checktype",rs.getString("checktype"));
			objtemp.put("stockid",rs.getString("stockid"));
			objtemp.put("specid",rs.getString("specid"));
			objtemp.put("productid",rs.getString("productid"));
			objtemp.put("productname",rs.getString("productname"));
			objtemp.put("proid",rs.getString("proid"));
			objtemp.put("mainqty",rs.getString("mainqty"));
			objtemp.put("maxfoc",rs.getString("maxfoc"));
			objtemp.put("foc",rs.getString("foc"));
			objtemp.put("pqty",rs.getString("pqty"));
			objtemp.put("proname",rs.getString("proname"));
			objtemp.put("sr_no",rs.getString("sr_no"));
			objtemp.put("psrno",rs.getString("psrno"));
			objtemp.put("prodoc",rs.getString("prodoc"));
			objtemp.put("unit",rs.getString("unit"));
			objtemp.put("unitdocno",rs.getString("unitdocno"));
			objtemp.put("qty",rs.getString("qty"));
			objtemp.put("qutval",rs.getString("qutval"));
			objtemp.put("saveqty",rs.getString("saveqty"));
			
			grnarray.add(objtemp);
			
		}
	objdata.put("grnrowdata",grnarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>