<%@page import="webapp.ClsWebAppDAO"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
JSONObject objdata=new JSONObject();
String filtertype=request.getParameter("filtertype")==null?"":request.getParameter("filtertype").toString();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
String location=request.getParameter("location")==null?"":request.getParameter("location").toString();
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();
try{
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsWebAppDAO dao=new ClsWebAppDAO();
	JSONArray customersarray=new JSONArray();
	JSONArray vendorsarray=new JSONArray();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	if(filtertype.trim().equalsIgnoreCase("delnote")){
		String strgetdelnotes="select * from (select date_format(m.date,'%d.%m.%Y') strdate,sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_delm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_deld d on(d.rdocno=m.doc_no)  where m.status=3 and m.cldocno="+cldocno+"  and m.brhid='"+branch+"' and m.locid='"+location+"' group by m.doc_no) as a having qty>0";
		ResultSet rsgetdelnotes=stmt.executeQuery(strgetdelnotes);
		JSONArray delnotearray=new JSONArray();
		while(rsgetdelnotes.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsgetdelnotes.getString("doc_no"));
			objtemp.put("date",rsgetdelnotes.getString("strdate"));
			delnotearray.add(objtemp);
		}
		objdata.put("delnotedata",delnotearray);
	}
	else if(filtertype.trim().equalsIgnoreCase("grn")){
		String strgetacno="select acno from my_acbook ac where ac.cldocno="+cldocno+" and ac.dtype='VND' and ac.status=3";
		ResultSet rsgetacno=stmt.executeQuery(strgetacno);
		int acno=0;
		while(rsgetacno.next()){
			acno=rsgetacno.getInt("acno");
		}
		String strgetgrn="select * from (select date_format(m.date,'%d.%m.%Y') strdate,sum(dd.op_qty-(dd.out_qty+dd.del_qty)) qty,d.prdid,m.doc_no,m.voc_no,m.date,m.description,m.refno,0 'chk'   from my_grnm m  left join    	my_grnd d on d.tr_no=m.tr_no    left join my_prddin dd on dd.tr_no=d.tr_no and dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid 	 where m.status=3  and m.acno="+acno+" and m.brhid="+branch+"     group by m.doc_no) as a  having  qty>0";
		ResultSet rsgetgrn=stmt.executeQuery(strgetgrn);
		JSONArray grnarray=new JSONArray();
		while(rsgetgrn.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsgetgrn.getString("doc_no"));
			objtemp.put("date",rsgetgrn.getString("strdate"));
			grnarray.add(objtemp);
		}
		objdata.put("grndata",grnarray);
	}
	else{
		String strcustomers="select ac.cldocno,ac.refname,head.curid,head.rate from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.status=3 and ac.dtype='CRM'";
		ResultSet rscustomers=stmt.executeQuery(strcustomers);
		while(rscustomers.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rscustomers.getString("cldocno"));
			objtemp.put("refname",rscustomers.getString("refname"));
			objtemp.put("curid",rscustomers.getString("curid"));
			objtemp.put("rate",rscustomers.getString("rate"));
			
			customersarray.add(objtemp);
		}
		String strvendors="select ac.cldocno,ac.refname,head.curid,head.rate from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.status=3 and ac.dtype='VND'";
		ResultSet rsvendors=stmt.executeQuery(strvendors);
		while(rsvendors.next()){
			JSONObject objtemp=new JSONObject();
			objtemp.put("docno",rsvendors.getString("cldocno"));
			objtemp.put("refname",rsvendors.getString("refname"));
			objtemp.put("curid",rsvendors.getString("curid"));
			objtemp.put("rate",rsvendors.getString("rate"));
			
			vendorsarray.add(objtemp);
		}
		String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
		JSONArray stockarray=dao.getStockData(userid,conn);
		objdata.put("stockdata", stockarray);
		JSONArray brancharray=dao.getBranch(session,conn);	
		objdata.put("branchdata",brancharray);
		objdata.put("customerdata",customersarray);	
		objdata.put("vendordata",vendorsarray);	
	}
	
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>