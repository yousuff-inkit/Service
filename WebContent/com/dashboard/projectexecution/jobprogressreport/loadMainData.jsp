<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String contracttype=request.getParameter("contracttype")==null?"":request.getParameter("contracttype");

Connection conn=null;
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
JSONObject objdata=new JSONObject();
try{
	conn=objconn.getMyConnection();
	java.sql.Date sqlfromdate=null,sqltodate=null;
	if(!fromdate.equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	if(!todate.equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	Statement stmt=conn.createStatement();
	String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
	String strchecksalesman="select doc_no salesmandocno from my_salm where status=3 and salesuserlink="+userid;
	ResultSet rschecksalesman=stmt.executeQuery(strchecksalesman);
	int salesmandocno=0;
	while(rschecksalesman.next()){
		salesmandocno=rschecksalesman.getInt("salesmandocno");
	}
	String sqltest="";
	if(salesmandocno>0){
		sqltest+=" and A.sal_id="+salesmandocno;
	}
	if(contracttype.equalsIgnoreCase("1")){
		//Contracted
		sqltest+="";
	}
	else if(contracttype.equalsIgnoreCase("2")){
		//Not Contracted
		sqltest+="";
	}
	String sqldata="select enqdocno,area,clientmobile,date_format(jdate,'%d.%m.%Y') strjobdate,cname, jobno, jdate, salesman, max(cdate) cdate, Amount, DISPER, Discount, format(round(coalesce(Net,0),2),2) net, max(installper) installper, max(installamt) INSTALLAMT "
	+ "from (select coalesce(enq.doc_no,'') enqdocno,coalesce(area.area,'') area,A.REFNAME cname,A.per_mob clientmobile,C.DOC_NO jobno,c.DATE jdate,m1.sal_name salesman,"
	+ " d.date 'cdate',Q.AMOUNT 'Amount',round(coalesce(Q.DISPER,0),2) as DISPER, "
	+ "Q.DISCOUNT 'Discount',C.NETAMOUNT 'Net',D.WRKPER installper,"
	+ " ROUND(C.NETAMOUNT*(D.WRKPER/100),2) INSTALLAMT"
	+ " from cm_srvCONTRM C LEFT JOIN CM_srvdetm m  ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE left join cm_srvreportstatus "
	+ "d on m.tr_no=d.rtrno LEFT JOIN MY_ACBOOK A ON C.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM' left join my_area area on (A.area_id=area.doc_no and area.status=3) "
	+ " LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO left join my_salm m1 on m1.doc_no=c.sal_id "
	+ "left join gl_enqm enq on (q.refdocno=enq.doc_no and q.ref_type='ENQ') "
	+ "left join (select max(doc_no) doc_no,enqno from cm_processlog group by enqno) pm"
	+ " on (pm.enqno=enq.doc_no) left join cm_processlog pl on pm.doc_no=pl.doc_no  "
	+ " WHERE c.DATE <='"+sqltodate+"' and c.doc_no>0 "+sqltest+" and coalesce(C.installdate,'')='' and c.status=3 ORDER BY M.DOC_NO,C.DOC_NO ) "
	+ " a   group by jobno";
	// and pl.statusid<10
	
	if(contracttype.equalsIgnoreCase("2")){
		sqldata="select enq.doc_no enqdocno,enq.voc_no jobno,ac.refname cname,enq.date enqdate,date_format(enq.date,'%d.%m.%Y') strjobdate,"+
		" coalesce(area.area,'') area,'' net,coalesce(ac.per_mob,'') clientmobile from gl_enqm enq left join CM_SRVQOTM q on (enq.doc_no=q.refdocno "+
		" and q.ref_type='ENQ') left join cm_srvCONTRM C ON Q.TR_NO=C.REFTRNO left join my_acbook ac on (enq.cldocno=ac.cldocno and ac.dtype='CRM' "+
		" and ac.status=3) left join my_area area on (ac.area_id=area.doc_no and area.status=3) where c.doc_no is null and enq.date<='"+sqltodate+"'";
	}
	System.out.println("Main Data SQL:"+sqldata);
	
	ResultSet rsmaindata=stmt.executeQuery(sqldata);
	JSONArray maindataarray=new JSONArray(); 
	while(rsmaindata.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("clientname",rsmaindata.getString("cname"));
		objtemp.put("jobno", rsmaindata.getString("jobno"));
		objtemp.put("enqdocno", rsmaindata.getString("enqdocno"));
		objtemp.put("jobdate",rsmaindata.getString("strjobdate"));
		objtemp.put("clientmobile",rsmaindata.getString("clientmobile"));
		objtemp.put("area",rsmaindata.getString("area"));
		objtemp.put("netamount", rsmaindata.getString("net"));
		maindataarray.add(objtemp);
	}
	objdata.put("maindata",maindataarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>