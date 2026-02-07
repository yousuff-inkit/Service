<%@page import="callregisterreport.ClsCallRegisterReportDAO"%>
<%@page import="net.sf.json.JSONArray"%>   
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>   
<%
String dtype=request.getParameter("dtype")==null || request.getParameter("dtype")==""?"0":request.getParameter("dtype");
String clientid=request.getParameter("clientid")==null || request.getParameter("clientid")==""?"0":request.getParameter("clientid");
String statusid=request.getParameter("statusid")==null || request.getParameter("statusid")==""?"0":request.getParameter("statusid");
String asgngrpid=request.getParameter("asgngrpid")==null || request.getParameter("asgngrpid")==""?"0":request.getParameter("asgngrpid");
String asgnmembrid=request.getParameter("asgnmembrid")==null || request.getParameter("asgnmembrid")==""?"0":request.getParameter("asgnmembrid");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");   
Connection conn=null;  
ClsConnection objconn=new ClsConnection();          
ClsCommon objcommon=new ClsCommon();
ClsCallRegisterReportDAO dao=new ClsCallRegisterReportDAO();   
JSONObject objdata=new JSONObject();
try{
	conn=objconn.getMyConnection();
	java.sql.Date sqltodate=null,sqlfromdate=null;
	if(!todate.equalsIgnoreCase("")){
		sqltodate=objcommon.changeStringtoSqlDate(todate);
	}
	if(!fromdate.equalsIgnoreCase("")){
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	}
	String sqltest="";
	
	if(!clientid.equalsIgnoreCase("") && !clientid.equalsIgnoreCase("0")){                                
		sqltest+=" and x.cldocno='"+clientid+"'";                  
	}
	if(!statusid.equalsIgnoreCase("") && !statusid.equalsIgnoreCase("0")){
		if(statusid.equalsIgnoreCase("OPEN")){
			sqltest+=" and p.status in(3,4)";   
		}else if(statusid.equalsIgnoreCase("CLOSE")){
			sqltest+=" and p.status not in(3,4)";  
		}else{
		}  
	}                      
	if(!asgngrpid.equalsIgnoreCase("") && !asgngrpid.equalsIgnoreCase("0")){                   
		sqltest+=" and p.empgroupid='"+asgngrpid+"'";      
	}
	if(!asgnmembrid.equalsIgnoreCase("") && !asgnmembrid.equalsIgnoreCase("0")){                       
		sqltest+=" and p.empid='"+asgnmembrid+"'";                                                   
	}
	if(!statusid.equalsIgnoreCase("OPEN")){            
		if(sqlfromdate!=null){                                                  
			sqltest+=" and x.calldate>='"+sqlfromdate+"'";                                                         
		}    
	}
	if(sqltodate!=null){                                         
		sqltest+=" and x.calldate<='"+sqltodate+"'";                                                                                                              
	}
	Statement stmt=conn.createStatement();
	JSONArray maindataarray=new JSONArray();   
	JSONArray datearray=new JSONArray();  
	JSONArray statusarray=new JSONArray();
	//String strsql="select DATE_FORMAT(p.date,'%d-%m-%Y') date,coalesce(dayname(p.date),'') days,coalesce(u.user_name,'') as enuser,coalesce(ast.description,'') status,p.refdocno,ac.refname,coalesce(grpcode,'') as asgngrp,coalesce(em.name,'') as emp,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,coalesce(cd.description,'') description,CAST(DATE_FORMAT(x.entrydate,'%d.%m.%Y %H:%i') as CHAR(50)) pldate,round(TIMESTAMPDIFF(hour,x.entrydate,now())/24,2) age  from (select m.entrydate,tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno, DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all SELECT concat(c.calldate,' ',c.calltime) entrydate,tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4)) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) left join cm_assignstatus ast on p.assignstatus=ast.doc_no left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')left join my_user u on u.doc_no=p.userid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join (select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')  left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no left join (select min(tr_no) trnos,refdocno from cm_srvassign group by refdocno) aa  on aa.refdocno=p.refdocno left join cm_srvassign sa on sa.tr_no=aa.trnos left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where 1=1 "+sqltest+"  group by p.tr_no order by p.date";		
	String strsql1="select COUNT(*) val,'OPEN' status from cm_cuscallm x inner join cm_servplan p on (x.tr_no=p.doc_no and x.dtype=p.dtype) where x.status=3 and x.clstatus in (0,3,4) and p.status in(3,4) "+sqltest+" group by status UNION ALL select COUNT(*) val,'CLOSE' status from cm_cuscallm x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) where x.status=3 and x.clstatus in (0,3,4) and p.status not in(3,4) "+sqltest+" group by status UNION ALL select COUNT(*) val,'ALL' status from cm_cuscallm x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) where x.status=3 and x.clstatus in (0,3,4) "+sqltest+"  group by status";	       
	//System.out.println("report2----------->>>"+strsql1);                                           
	ResultSet rsmaindata1=stmt.executeQuery(strsql1);        
	while(rsmaindata1.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("count",rsmaindata1.getString("val")==null?"":rsmaindata1.getString("val"));   
		objtemp.put("status",rsmaindata1.getString("status")==null?"":rsmaindata1.getString("status"));
		statusarray.add(objtemp);         
	}
	String strsql2="select COUNT(*) val,DATE_FORMAT(x.calldate,'%d.%m.%Y') date from cm_cuscallm x inner join cm_servplan p on (x.tr_no=p.doc_no and x.dtype=p.dtype) where x.status=3 and x.clstatus in (0,3,4) "+sqltest+" group by x.calldate";	       
	//System.out.println("report3----------->>>"+strsql2);                                                           
	ResultSet rsmaindata2=stmt.executeQuery(strsql2);                        
	while(rsmaindata2.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("count",rsmaindata2.getString("val")==null?"":rsmaindata2.getString("val"));                           
		objtemp.put("date",rsmaindata2.getString("date")==null?"":rsmaindata2.getString("date"));
		datearray.add(objtemp);                              
	}                           
	
	String date="",days="";                         
	int datecount=0;
	String strsql="select if(p.status=3 or p.status=4,'OPEN','CLOSE') refstatus,coalesce(u.user_name,'') as enuser,coalesce(ast.description,'') status,coalesce(p.refdocno,0) refdocno,ac.refname,coalesce(grpcode,'') as asgngrp,coalesce(em.name,'') as emp,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,coalesce(cd.description,'') description,CAST(DATE_FORMAT(x.entrydate,'%d.%m.%Y %H:%i') as CHAR(50)) pldate,round(TIMESTAMPDIFF(hour,x.entrydate,now())/24,2) age,coalesce(x.brhid,0) branch,x.calldate from (SELECT c.calldate,concat(c.calldate,' ',c.calltime) entrydate,tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,3,4)) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) left join cm_assignstatus ast on p.assignstatus=ast.doc_no  left join my_user u on u.doc_no=p.userid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')  left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gvd on cd.servid=gvd.doc_no where 1=1 "+sqltest+" group by p.tr_no order by x.calldate";	       
	System.out.println("report1----------->>>"+strsql);                                                                                                
	ResultSet rsmaindata=stmt.executeQuery(strsql);        
	while(rsmaindata.next()){   
		JSONObject objtemp=new JSONObject();
		/* if(date.equalsIgnoreCase(rsmaindata.getString("date"))){                                                
			datecount++;
		}else{
			if(!date.equalsIgnoreCase("")){
				JSONObject objdate=new JSONObject();      
				objdate.put("date", date+" "+days);	
				objdate.put("count",datecount);
				datearray.add(objdate);
			}
			date=rsmaindata.getString("date");      
			days=rsmaindata.getString("days");
			datecount=1;   
		} */
		objtemp.put("enuser",rsmaindata.getString("enuser")==null?"":rsmaindata.getString("enuser"));   
		objtemp.put("status",rsmaindata.getString("status")==null?"":rsmaindata.getString("status"));
		objtemp.put("refdocno", rsmaindata.getString("refdocno")==null?"":rsmaindata.getString("refdocno"));
		objtemp.put("refname",rsmaindata.getString("refname")==null?"":rsmaindata.getString("refname"));
		objtemp.put("asgngrp", rsmaindata.getString("asgngrp")==null?"":rsmaindata.getString("asgngrp"));
		objtemp.put("emp",rsmaindata.getString("emp")==null?"":rsmaindata.getString("emp"));
		objtemp.put("sertype",rsmaindata.getString("sertype")==null?"":rsmaindata.getString("sertype"));                          
		objtemp.put("description",rsmaindata.getString("description")==null?"":rsmaindata.getString("description"));
		objtemp.put("pldate",rsmaindata.getString("pldate")==null?"":rsmaindata.getString("pldate"));
		objtemp.put("age",rsmaindata.getString("age")==null?"":rsmaindata.getString("age"));
		objtemp.put("branch",rsmaindata.getString("branch")==null?"0":rsmaindata.getString("branch"));
		objtemp.put("refstatus",rsmaindata.getString("refstatus")==null?"0":rsmaindata.getString("refstatus"));
		objtemp.put("detaildata",dao.loadSubGridData(rsmaindata.getString("refdocno"), rsmaindata.getString("branch")));          
		//System.out.println(objtemp);            
		maindataarray.add(objtemp);  
	}  
	objdata.put("maindata",maindataarray);                                                                                                                        
	objdata.put("datedata",datearray);
	objdata.put("statusdata",statusarray);                     
	//System.out.println(objdata);   
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>