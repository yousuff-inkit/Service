<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%
String result="";
int errorstatus=0;
JSONObject objdata=new JSONObject(); 
ClsConnection objconn=new ClsConnection();
ClsCommon objcommon=new ClsCommon();
String widgetname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim().toString(); 
String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();   
String routeid=request.getParameter("routeid")==null?"":request.getParameter("routeid").trim().toString(); 
String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim().toString();  
String frmdtchk=request.getParameter("frmdtchk")==null?"":request.getParameter("frmdtchk").trim().toString(); 
Connection conn=null;
try{
	conn=objconn.getMyConnection();   
	Statement stmt=conn.createStatement();
	java.sql.Date sqlfromdate = null;
	java.sql.Date sqltodate = null;
	String sqltest="", sqltest1="";
	if(!fromdate.equalsIgnoreCase("undefined") && !fromdate.equalsIgnoreCase("")) {
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);  
	}
	if(!todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("")) {
		sqltodate=objcommon.changeStringtoSqlDate(todate);         
	}
	if(!routeid.equalsIgnoreCase("undefined") && !routeid.equalsIgnoreCase("") && !routeid.equalsIgnoreCase("0")) {  
		sqltest+=" and sc.routeid='"+routeid+"' ";  
		sqltest1+=" and dl.routeid='"+routeid+"' ";  
	}
	if(frmdtchk.equalsIgnoreCase("1")) {  
		sqltest+=" and sc.date between '"+sqlfromdate+"' and '"+sqltodate+"'";             
	}else {
		sqltest+=" and sc.date<='"+sqltodate+"'";            
	} 
	
	if(!cldocno.equalsIgnoreCase("undefined") && !cldocno.equalsIgnoreCase("") && !cldocno.equalsIgnoreCase("0")) {  
		sqltest+=" and cm.cldocno='"+cldocno+"'"; 
		sqltest1+=" and cm.cldocno='"+cldocno+"'"; 
	}
	
	String delpcount="0", popcount="0", comschpcount="0", ldschpcount="0", totpcount="0", delccount="0", poccount="0", comschccount="0", ldschccount="0", totccount="0";  
	
	String strcnt1 = "select (select count(*) val from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno left join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.delid=dl.doc_no and sc.srno=d.srno where cm.status=3 and sc.doc_no is null and dl.statusid<2 "+sqltest1+") delcnt, (select count(*) val from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno inner join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.srno=d.srno and sc.delid=dl.doc_no where cm.status=3 and sc.status=2 and sc.statusid=0 "+sqltest+") pocnt, (select count(*) val from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno inner join sk_srvcontrsch sc on cm.tr_no=sc.rdocno and sc.srno=d.srno and sc.delid=dl.doc_no left join sk_skiptype sk on sk.doc_no=d.skiptype where cm.status=3 and sk.exchange=0 and sc.status not in(2,4) and sc.statusid=0 "+sqltest+") comschcnt, (select count(*) val from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno inner join sk_srvcontrsch sc on cm.tr_no=sc.rdocno and sc.srno=d.srno and sc.delid=dl.doc_no left join sk_skiptype sk on sk.doc_no=d.skiptype where cm.status=3 and sk.exchange=1 and sc.status not in(2,4) and sc.statusid=0 "+sqltest+") ldschcnt, (select sum(val) val from (select count(*) val, 1 type from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.srno=d.srno and dl.rdocno=cm.tr_no left join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.delid=dl.doc_no and sc.srno=d.srno where cm.status=3 and sc.doc_no is null  and dl.statusid<2 "+sqltest1+" union all select count(*) val, 1 type from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno inner join sk_srvcontrsch sc on cm.tr_no=sc.rdocno and sc.srno=d.srno and sc.delid=dl.doc_no left join sk_skiptype sk on sk.doc_no=d.skiptype where cm.status=3 and ((sk.exchange in(0,1) and sc.status not in(2,4)) or sc.status in(2)) and sc.statusid=0 "+sqltest+")a group by type) totcnt";
	//System.out.println("=count="+strcnt1);                  
	ResultSet rscnt1=stmt.executeQuery(strcnt1);  
	while(rscnt1.next()){
		delpcount = rscnt1.getString("delcnt");
		popcount = rscnt1.getString("pocnt"); 
		comschpcount = rscnt1.getString("comschcnt"); 
		ldschpcount = rscnt1.getString("ldschcnt");   
		totpcount = rscnt1.getString("totcnt");     
	}
	
	String strcnt2 = "select (select count(*) val from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno left join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.delid=dl.doc_no and sc.srno=d.srno where cm.status=3 and sc.doc_no is null and dl.statusid>=2 "+sqltest1+") delcnt, (select count(*) val from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno inner join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.srno=d.srno and sc.delid=dl.doc_no where cm.status=3 and sc.status=2 and sc.statusid>0 "+sqltest+") pocnt, (select count(*) val from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno inner join sk_srvcontrsch sc on cm.tr_no=sc.rdocno and sc.srno=d.srno and sc.delid=dl.doc_no left join sk_skiptype sk on sk.doc_no=d.skiptype where cm.status=3 and sk.exchange=0 and sc.status not in(2,4) and sc.statusid>0 "+sqltest+") comschcnt, (select count(*) val from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno inner join sk_srvcontrsch sc on cm.tr_no=sc.rdocno and sc.srno=d.srno and sc.delid=dl.doc_no left join sk_skiptype sk on sk.doc_no=d.skiptype where cm.status=3 and sk.exchange=1 and sc.status not in(2,4) and sc.statusid>0 "+sqltest+") ldschcnt, (select sum(val) val from (select count(*) val, 1 type from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.srno=d.srno and dl.rdocno=cm.tr_no left join sk_srvcontrsch sc on sc.rdocno=cm.tr_no and sc.delid=dl.doc_no and sc.srno=d.srno where cm.status=3 and sc.doc_no is null and dl.statusid>=2  "+sqltest1+" union all select count(*) val, 1 type from sk_srvcontrm cm inner join sk_srvcontrdet d on d.rdocno=cm.tr_no inner join sk_srvcontrdel dl on dl.rdocno=cm.tr_no and dl.srno=d.srno inner join sk_srvcontrsch sc on cm.tr_no=sc.rdocno and sc.srno=d.srno and sc.delid=dl.doc_no left join sk_skiptype sk on sk.doc_no=d.skiptype where cm.status=3 and ((sk.exchange in(0,1) and sc.status not in(2,4)) or sc.status in(2)) and sc.statusid>0 "+sqltest+")a group by type) totcnt";
	//System.out.println("=count="+strcnt2);                  
	ResultSet rscnt2=stmt.executeQuery(strcnt2);  
	while(rscnt2.next()){
		delccount = rscnt2.getString("delcnt");
		poccount = rscnt2.getString("pocnt"); 
		comschccount = rscnt2.getString("comschcnt"); 
		ldschccount = rscnt2.getString("ldschcnt");   
		totccount = rscnt2.getString("totcnt");     
	}
	
	objdata.put("delpcount",delpcount);
	objdata.put("popcount",popcount); 
	objdata.put("comschpcount",comschpcount);
	objdata.put("ldschpcount",ldschpcount); 
	objdata.put("totpcount",totpcount); 
	
	objdata.put("delccount",delccount);
	objdata.put("poccount",poccount); 
	objdata.put("comschccount",comschccount);
	objdata.put("ldschccount",ldschccount); 
	objdata.put("totccount",totccount);
	conn.close();
}
catch(Exception e){
	conn.close();
	e.printStackTrace();   
}finally{
	conn.close();
}
response.getWriter().print(objdata);    
%>