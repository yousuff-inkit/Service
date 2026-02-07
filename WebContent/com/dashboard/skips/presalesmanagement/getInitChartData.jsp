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
		String sql1="select e.doc_no from my_salm e where e.status=3 and salesuserlink='"+session.getAttribute("USERID")+"'";
		ResultSet resultSet1 = stmt.executeQuery(sql1) ;
		if(resultSet1.next()){
			salesuser+=" and e.sal_id='"+resultSet1.getString("doc_no")+"'";    
		}      
		//System.out.println("brhid="+brhid);     
		if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("a")){         
			salesuser+=" and e.brhid='"+brhid+"'";             
		}
		String strenq="select (select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' where e.dropped=0 and e.status=3 and e.amcconfirm=0 and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' and qm.tr_no is null "+salesuser+") enq,(select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' where e.dropped=0 and e.cldocno=0 and coalesce(qm.quotstatus,0)!=1 and qm.status=3 and e.status=3 and e.amcconfirm=0 and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+salesuser+") newcrm,(select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where  e.dropped=0 and qm.tr_no is not null and cm.tr_no is null and e.status=3 and e.amcconfirm=0 and coalesce(qm.quotstatus,0)!=1 and qm.status=3 and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+salesuser+") quot,(select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno where e.dropped=0 and qm.tr_no is not null and cm.tr_no is null and qm.status<3 and e.status=3 and e.amcconfirm=0 and coalesce(qm.quotstatus,0)!=1 and apprstatus!=3 and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+salesuser+") unmgap,(select count(*) from gl_enqm e left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' where  e.dropped=0 and cm.tr_no is not null and coalesce(qm.quotstatus,0)!=1 and e.status=3 and e.amcconfirm=0 and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+salesuser+") amc";
		//System.out.println("count="+strenq);                    
			String enqcount="0",newcrmcount="0",amccount="0",quotcount="0",unmgapcount="";         
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				enqcount=rsenq.getString("enq");
				newcrmcount=rsenq.getString("newcrm");
				amccount=rsenq.getString("amc");
				quotcount=rsenq.getString("quot");  
				unmgapcount=rsenq.getString("unmgap");   
			}
			objdata.put("enqcount",enqcount);
			objdata.put("newcrmcount",newcrmcount); 
			objdata.put("amccount",amccount);
			objdata.put("quotcount",quotcount); 
			objdata.put("unmgapcount",unmgapcount); 
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