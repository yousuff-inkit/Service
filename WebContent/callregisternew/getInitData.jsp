<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
ClsConnection objconn=new ClsConnection();
JSONObject objdata=new JSONObject();
try{
	conn=objconn.getMyConnection();	
	Statement stmt=conn.createStatement();
	String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
	String strgetuser="select user_name,doc_no from my_user where doc_no="+userid+" and status=3";
	ResultSet rsgetuser=stmt.executeQuery(strgetuser);
	while(rsgetuser.next()){
		objdata.put("userid",userid);		
		objdata.put("username",rsgetuser.getString("user_name"));
	}
	String cregcompid=session.getAttribute("CREGCOMPID").toString();
	String struserclause="";
	if(!cregcompid.equalsIgnoreCase("") && !cregcompid.equalsIgnoreCase("0")){
		struserclause=" and ac.cldocno="+cregcompid;
	}
	String strgetpersons="select coalesce(contact.cperson,'') contactperson,ac.refname company,coalesce(contact.mob,'') mobile,"+
	" coalesce(contact.email,'') email,contact.row_no contactid,ac.cldocno compid from my_acbook ac left join my_crmcontact contact on "+
	" (ac.cldocno=contact.cldocno) where ac.status=3 "+struserclause+" order by contact.cperson asc";
	JSONArray contactarray=new JSONArray();
	JSONArray companyarray=new JSONArray();
	ResultSet rsperson=stmt.executeQuery(strgetpersons);
	while(rsperson.next()){
		JSONObject objcontact=new JSONObject();
		JSONObject objcompany=new JSONObject();
		objcontact.put("contactperson", rsperson.getString("contactperson"));
		objcontact.put("company",rsperson.getString("company"));
		objcontact.put("mobile",rsperson.getString("mobile"));
		objcontact.put("email",rsperson.getString("email"));
		objcontact.put("contactid",rsperson.getString("contactid"));
		objcontact.put("compid",rsperson.getString("compid"));
		contactarray.add(objcontact);
		
		objcompany.put("company",rsperson.getString("company"));
		objcompany.put("compid",rsperson.getString("compid"));
		companyarray.add(objcompany);
	}
	
	String strgetcomplaints="select groupname name,doc_no id from my_groupvals where status=3 and grptype='complaints' order by seqno";
	ResultSet rsgetcomplaints=stmt.executeQuery(strgetcomplaints);
	JSONArray complaintarray=new JSONArray();
	while(rsgetcomplaints.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("id",rsgetcomplaints.getString("id"));
		objtemp.put("name",rsgetcomplaints.getString("name"));
		complaintarray.add(objtemp);
	}
	
	String strcregdetail="select x.doc_no creg,CAST(DATE_FORMAT(x.entrydate,'%d.%m.%Y %H:%i') as CHAR(50)) cregdate,case when x.calledby='' then"+
	" coalesce(u.user_name,'') else x.calledby end name,if(x.dtype='CREG',gvd.groupname,ser.groupname) as servicetype,gv.groupname complaint,coalesce(cd.description,'') description,coalesce(ast.description,'') status"+
	" from ("+
	" select '' calledby,0 nrstatus,m.entrydate,tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"+
	"  DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate,m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m left"+
	"  join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all"+
	" SELECT c.calledby,c.nrstatus,concat(c.calldate,' ',c.calltime) entrydate,tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,"+
	" c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate"+
	" FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4)"+
	" ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype)"+
	" left join cm_assignstatus ast on p.assignstatus=ast.doc_no left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"+
	" left join my_user u on u.doc_no=p.userid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "+
	" left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid)"+ 
	" left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join"+ 
	" (select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='0' group by doc_no ) e "+
	" on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')"+
	"  left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"+
	" left join (select min(tr_no) trnos,refdocno from cm_srvassign group by refdocno) aa  on aa.refdocno=p.refdocno left join cm_srvassign sa on sa.tr_no=aa.trnos"+
	" left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status in(3,4) and ast.doc_no!=8 and ((cd.cmplid in (749,750,751) and x.nrstatus=5) or (cd.cmplid not in (749,750,751))) "+struserclause+" group by p.tr_no order by x.entrydate";
	JSONArray cregarray=new JSONArray();
	ResultSet rscreg=stmt.executeQuery(strcregdetail);
	int cregserial=1;
	while(rscreg.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("serial",cregserial);
		objtemp.put("cregno",rscreg.getString("creg"));
		objtemp.put("cregdate",rscreg.getString("cregdate"));
		objtemp.put("name",rscreg.getString("name"));
		objtemp.put("servicetype",rscreg.getString("servicetype"));
		objtemp.put("complaint",rscreg.getString("complaint"));
		objtemp.put("description",rscreg.getString("description"));
		objtemp.put("status",rscreg.getString("status"));
		cregarray.add(objtemp);
		cregserial++;
	}
	objdata.put("cregdata",cregarray);
	objdata.put("persondata",contactarray);
	objdata.put("companydata",companyarray);
	objdata.put("complaintdata",complaintarray);
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>