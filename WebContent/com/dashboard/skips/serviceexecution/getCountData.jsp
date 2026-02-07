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
String widgetname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
Connection conn=null;
try{
	conn=objconn.getMyConnection();   
	Statement stmt=conn.createStatement();
	String sqltest="";
	if(widgetname.equalsIgnoreCase("all")){ 
        sqltest+=" and m.status in(3,6,10) ";      
	}else if(widgetname.equalsIgnoreCase("new")){ 
	        sqltest+=" and m.status in(3,6) and m.oldcnttrno=0 and m.revision_no=0 and d.hold=0";      
	}else if(widgetname.equalsIgnoreCase("renew")){
			sqltest+=" and m.status in(3,6) and m.oldcnttrno>0 and m.revision_no=0 and d.hold=0";  
	}else if(widgetname.equalsIgnoreCase("rev")){
			sqltest+=" and m.status in(3,6) and m.revision_no>0 and d.hold=0";
	}else if(widgetname.equalsIgnoreCase("ter")){  
			sqltest+=" and m.status in(10) and d.hold=0 ";       
	}else if(widgetname.equalsIgnoreCase("hold")){
			sqltest+=" and d.hold>0 and m.status in(3,6,10)";
	}else{} 
	
	//String strcountdata="SELECT SUM(COALESCE(d.nos-dd.ds,0)) ds, SUM(COALESCE(d.nos-dd.ra,0)) ra, SUM(COALESCE(d.nos-dd.cs,0)) cs, SUM(COALESCE(dd.po,0)) po FROM sk_srvcontrm m inner join sk_srvcontrdet d ON d.rdocno=m.tr_no INNER JOIN (SELECT SUM(IF(COALESCE(del.statusid,0)>=1,1,0)) ds, SUM(IF(COALESCE(del.statusid,0)>=3,1,0)) ra, SUM(IF(COALESCE(del.statusid,0)>=4,1,0)) cs,SUM(IF(COALESCE(del.statusid,0)=5,1,0)) po, d.rdocno FROM sk_srvcontrdet d LEFT JOIN sk_srvcontrdel del ON del.rdocno=d.rdocno AND del.srno=d.srno GROUP BY d.rdocno) dd ON dd.rdocno=m.tr_no WHERE m.srfconfirm=0 and d.srdocno>0 AND ((m.status=3 AND m.oldcnttrno=0 AND m.revision_no=0) OR m.status=10 OR (m.status=3 AND m.oldcnttrno>0 AND m.revision_no=0) OR (m.status=3 AND m.revision_no>0)) "+sqltest+""; 
	String strcountdata="SELECT COALESCE(SUM(COALESCE(d.nos-dd.ds,0)),0) ds, COALESCE(SUM(COALESCE(d.nos-dd.ra,0)),0) ra, sum(if(sch.schdate is not null and m.enddt>sch.schdate,COALESCE(d.nos,0),IF(COALESCE(d.nos-dd.cs,0)=0 or d.collectionid=2,0,COALESCE(d.nos,0)))) cs, COALESCE(SUM(COALESCE(dd.po,0)),0) po FROM sk_srvcontrm m inner join sk_srvcontrdet d ON d.rdocno=m.tr_no INNER JOIN (SELECT SUM(IF(COALESCE(del.statusid,0)>=1,1,0)) ds, SUM(IF(COALESCE(del.statusid,0)>=3,1,0)) ra, SUM(IF(COALESCE(del.statusid,0)>=4,1,0)) cs,SUM(IF(COALESCE(del.statusid,0)=5,1,0)) po, d.rdocno FROM sk_srvcontrdet d LEFT JOIN sk_srvcontrdel del ON del.rdocno=d.rdocno AND del.srno=d.srno GROUP BY d.rdocno) dd ON dd.rdocno=m.tr_no left join sk_srvcontrsrf sf on sf.doc_no=d.srdocno left join (select max(date) schdate, rdocno, srno from sk_srvcontrsch sch group by rdocno,srno) sch on sch.rdocno=m.tr_no and sch.srno=d.srno WHERE coalesce(sf.confirm,0)=0 and d.srdocno>0 "+sqltest+""; 
	System.out.println("=count="+strcountdata);
	ResultSet rs=stmt.executeQuery(strcountdata);  
	if(rs.next()){       
		result=rs.getString("ds")+"::"+rs.getString("ra")+"::"+rs.getString("cs")+"::"+rs.getString("po");                  
	}else{
		result=0+"::"+0+"::"+0+"::"+0;
	}
	 
	String strenq="SELECT (SELECT COUNT(*) val FROM sk_srvcontrm m INNER JOIN sk_srvcontrdet d ON d.rdocno=m.tr_no left join sk_srvcontrsrf sf on sf.doc_no=d.srdocno WHERE  coalesce(sf.confirm,0)=0 and d.srdocno>0 and m.status in(3,6,10)) allcnt,(SELECT COUNT(*) val FROM sk_srvcontrm m INNER JOIN sk_srvcontrdet d ON d.rdocno=m.tr_no left join sk_srvcontrsrf sf on sf.doc_no=d.srdocno WHERE  coalesce(sf.confirm,0)=0 and d.srdocno>0  and m.status in(3,6) and m.oldcnttrno=0 and m.revision_no=0 and d.hold=0) newcnt, (SELECT COUNT(*) val FROM sk_srvcontrm m INNER JOIN sk_srvcontrdet d ON d.rdocno=m.tr_no left join sk_srvcontrsrf sf on sf.doc_no=d.srdocno WHERE  coalesce(sf.confirm,0)=0 and d.srdocno>0 and m.status in(10) and d.hold=0) tercnt, (SELECT COUNT(*) val FROM sk_srvcontrm m INNER JOIN sk_srvcontrdet d ON d.rdocno=m.tr_no left join sk_srvcontrsrf sf on sf.doc_no=d.srdocno WHERE  coalesce(sf.confirm,0)=0 and d.srdocno>0 and m.status in(3,6) and m.revision_no>0 and d.hold=0) revcnt, (SELECT COUNT(*) val FROM sk_srvcontrm m INNER JOIN sk_srvcontrdet d ON d.rdocno=m.tr_no left join sk_srvcontrsrf sf on sf.doc_no=d.srdocno WHERE  coalesce(sf.confirm,0)=0 and d.srdocno>0 and m.status in(3,6) and m.oldcnttrno>0 and m.revision_no=0 and d.hold=0) rencnt, (SELECT COUNT(*) val FROM sk_srvcontrm m INNER JOIN sk_srvcontrdet d ON d.rdocno=m.tr_no left join sk_srvcontrsrf sf on sf.doc_no=d.srdocno WHERE  coalesce(sf.confirm,0)=0 and d.srdocno>0 AND d.hold>0 and status in(3,6,10)) hldcnt";
	//System.out.println("=count="+strenq);                       
	String newcount="0", renewcount="0", revcount="0", tercount="0", holdcount="0", allcount="0";         
	ResultSet rsenq=stmt.executeQuery(strenq);
	while(rsenq.next()){
		newcount=rsenq.getString("newcnt");
		renewcount=rsenq.getString("rencnt");
		revcount=rsenq.getString("revcnt");
		tercount=rsenq.getString("tercnt");  
		holdcount=rsenq.getString("hldcnt");      
		allcount=rsenq.getString("allcnt");      
	}
	objdata.put("newcount",newcount);
	objdata.put("renewcount",renewcount); 
	objdata.put("revcount",revcount);
	objdata.put("tercount",tercount); 
	objdata.put("holdcount",holdcount);  
	objdata.put("allcount",allcount);  
	conn.close();
}
catch(Exception e){
	conn.close();
	e.printStackTrace();   
}finally{
	conn.close();
}
response.getWriter().write(result+"####"+objdata);    
%>