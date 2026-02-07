<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	JSONObject data=new JSONObject();
	JSONObject enqdetails=new JSONObject();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	JSONObject objdata=new JSONObject();  
	Connection conn=null;
	String brhid = request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").trim();  
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim(); 
    java.sql.Date sqlfromdate = null;
    java.sql.Date sqltodate = null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
	    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	    }else{}
	    
		if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
	       sqltodate=objcommon.changeStringtoSqlDate(todate);
	    } else{} 
		
		String salesuser="";
		/* String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
		ResultSet resultSet1 = stmt.executeQuery(sql1) ;
		if(resultSet1.next()){
			salesuser=" and sal_id='"+resultSet1.getString("doc_no")+"'";    
		} */ 
		System.out.println("brhid="+brhid);     
		if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("a")){        
			salesuser+=" and e.brhid='"+brhid+"'";             
		}
		String strenq="select (select count(*) from(select ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount,e.doc_no from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 and rtrim(ltrim(cd.attach))!='' group by cd.qotno) ckl on ckl.qotno=qm.tr_no where cm.tr_no is null and e.status=3 and e.amcconfirm=0 and e.returned=0 and coalesce(qm.quotstatus,0)=2 and ckl.qotno is not null and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+salesuser+" group by e.doc_no)a where realcount=mandcount) enq,(select count(*) from(select ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount,e.doc_no from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 and rtrim(ltrim(cd.attach))!='' group by cd.qotno) ckl on ckl.qotno=qm.tr_no where qm.tr_no is not null and cm.tr_no is null and e.status=3 and e.amcconfirm=0 and e.returned=0 and coalesce(qm.quotstatus,0)=2 and ckl.qotno is not null and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+salesuser+" group by e.doc_no)a where realcount=mandcount) quot,(select count(*) from(select ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount,e.doc_no from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 and rtrim(ltrim(cd.attach))!='' group by cd.qotno) ckl on ckl.qotno=qm.tr_no where e.cldocno=0 and e.status=3 and e.amcconfirm=0 and e.returned=0 and coalesce(qm.quotstatus,0)=2 and ckl.qotno is not null and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+salesuser+" group by e.doc_no)a where realcount=mandcount) newcrm,(select count(*) from(select ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount,e.doc_no from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 group by cd.qotno) ckl on ckl.qotno=qm.tr_no where cm.tr_no is not null and e.status=3 and e.amcconfirm=0 and e.returned=0 and coalesce(qm.quotstatus,0)=2 and ckl.qotno is not null and cm.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+salesuser+" group by e.doc_no)a ) amc";
			System.out.println("countcontr="+strenq);                
			String enqcount="0",newcrmcount="0",amccount="0",quotcount="0";         
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				enqcount=rsenq.getString("enq");
				newcrmcount=rsenq.getString("newcrm");
				amccount=rsenq.getString("amc");
				quotcount=rsenq.getString("quot");    
			}
			objdata.put("enqcount",enqcount);
			objdata.put("newcrmcount",newcrmcount); 
			objdata.put("amccount",amccount);
			objdata.put("quotcount",quotcount);  
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	//System.out.println(enqdetails);  
	response.getWriter().print(objdata);           
%>