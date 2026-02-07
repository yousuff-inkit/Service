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
	String salid = request.getParameter("salid")==null || request.getParameter("salid").equals("")?"0":request.getParameter("salid").trim();    
	String brhid = request.getParameter("brhid")==null || request.getParameter("brhid").equals("")?"0":request.getParameter("brhid").trim();  
	String type = request.getParameter("type")==null || request.getParameter("type").equals("")?"0":request.getParameter("type").trim(); 
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
		
		/* String sql1="select e.doc_no from my_salm e where e.status=3 and salesuserlink='"+session.getAttribute("USERID")+"'";
		ResultSet resultSet1 = stmt.executeQuery(sql1) ;
		if(resultSet1.next()){
			salesuser+=" and e.sal_id='"+resultSet1.getString("doc_no")+"'";    
		} */      
		
		//System.out.println("brhid="+brhid);     
		if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("a")){         
			salesuser+=" and e.brhid='"+brhid+"'";             
		}
		
		if(!(salid.equalsIgnoreCase("0")) && !(salid.equalsIgnoreCase("")))  {   
			salesuser+=" and e.sal_id="+salid;      
	      } else {} 
		
		
		 if(type.equalsIgnoreCase("enq")){
	    	salesuser+=" and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";    
	    }else if(type.equalsIgnoreCase("qot")){
	    	salesuser+=" and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' "; 
	    }else if(type.equalsIgnoreCase("cnt")){
	    	salesuser+=" and cm.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' "; 
	    }else{}  
		 
		 String strenq="select (select count(*) from(select ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount,e.doc_no from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 group by cd.qotno) ckl on ckl.qotno=qm.tr_no where cm.tr_no is null and e.dropped=0 and e.status=3 and e.amcconfirm=0  and coalesce(qm.quotstatus,0)not in(1,2) and ckl.qotno is not null and e.cldocno>0 "+salesuser+" group by e.doc_no)a where realcount=mandcount) cklist, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where  e.dropped=0 and e.status=3 and e.amcconfirm=0 and qm.tr_no is null "+salesuser+") enq, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where  e.dropped=1 and e.status=3 and e.amcconfirm=0 and qm.tr_no is null "+salesuser+") enqdcld, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where  e.dropped=0 and e.cldocno=0  and e.status=3 and e.amcconfirm=0 and cm.tr_no is null "+salesuser+") newcrm, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where  e.dropped=0 and qm.tr_no is not null and cm.tr_no is null and e.status=3 and e.amcconfirm=0 and coalesce(qm.quotstatus,0)not in(1,2) and e.cldocno>0 and qm.status=3 "+salesuser+") quot, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where  e.dropped=0 and qm.tr_no is not null and cm.tr_no is null and e.status=3 and e.amcconfirm=0 and coalesce(qm.quotstatus,0)=1 "+salesuser+") quotdcld, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where  e.dropped=0 and qm.tr_no is not null and cm.tr_no is null and e.status=3 and e.amcconfirm=0 and coalesce(qm.quotstatus,0)=2 and e.cldocno>0 and qm.status=3 "+salesuser+") appr, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno where e.dropped=0 and qm.tr_no is not null and cm.tr_no is null and qm.status<3 and e.status=3 and e.amcconfirm=0 and coalesce(qm.quotstatus,0)not in(1) and apprstatus=1 and e.cldocno>0 "+salesuser+") unmgap, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where e.dropped=0 and cm.tr_no is not null and coalesce(qm.quotstatus,0) not in(1) and e.status=3 and e.amcconfirm=0 and cm.status<>7 "+salesuser+") amc, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where e.status=3 and e.amcconfirm=0 "+salesuser+") allitem, (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where e.dropped=0 and qm.tr_no is not null and cm.tr_no is null and e.status=3 and e.amcconfirm=0 "+salesuser+") allqot";
				//System.out.println("count123="+strenq);                                                      
			String allqotcount="",allitemcount="0",enqcount="0",newcrmcount="0",amccount="0",quotcount="0",unmgapcount="0",cklist="0",enqdcldcount="0",qotdcldcount="0",apprcount="0";            
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				allitemcount=rsenq.getString("allitem");
				enqcount=rsenq.getString("enq");
				newcrmcount=rsenq.getString("newcrm");
				amccount=rsenq.getString("amc");
				quotcount=rsenq.getString("quot");  
				unmgapcount=rsenq.getString("unmgap");
				cklist=rsenq.getString("cklist");
				enqdcldcount=rsenq.getString("enqdcld");  
				qotdcldcount=rsenq.getString("quotdcld");
				apprcount=rsenq.getString("appr"); 
				allqotcount=rsenq.getString("allqot");                    
			}
			objdata.put("allitemcount",allitemcount);
			objdata.put("enqcount",enqcount);
			objdata.put("newcrmcount",newcrmcount); 
			objdata.put("amccount",amccount);
			objdata.put("quotcount",quotcount); 
			objdata.put("unmgapcount",unmgapcount); 
			objdata.put("cklist",cklist);
			objdata.put("enqdcldcount",enqdcldcount);
			objdata.put("qotdcldcount",qotdcldcount);   
			objdata.put("apprcount",apprcount);
			objdata.put("allqotcount",allqotcount);   
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