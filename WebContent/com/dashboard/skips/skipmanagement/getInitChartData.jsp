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
	String fromdate=request.getParameter("fromdate")==null || request.getParameter("fromdate")==""?"0":request.getParameter("fromdate").toString();
	String todate=request.getParameter("todate")==null || request.getParameter("todate")==""?"0":request.getParameter("todate").toString();  
	String fdatechk=request.getParameter("fdatechk")==null || request.getParameter("fdatechk")==""?"0":request.getParameter("fdatechk").toString();
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").toString();  
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();  
		String sqltest="";  
		java.sql.Date sqlfromdate = null;
		java.sql.Date sqltodate = null;  
		
		if(fdatechk.equalsIgnoreCase("1")) {  
	    	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	     		sqltest+=" and m.date>='"+sqlfromdate+"'"; 
	        }
	    }
	    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	     		sqltest+=" and m.date<='"+sqltodate+"'";   
	    } 
	    if(!brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("a")){          
			sqltest+=" and m.brhid='"+brhid+"'";        
		}
	    String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
		ResultSet resultSet12=stmt.executeQuery(sql12);
		   
	    while(resultSet12.next()){     
	    	sqltest+=" and (mm.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
	    }
	    String strenq="select (select count(*) val from (select m.tr_no from cm_srvcontrm m left join (select sum(if(sm.confirm=0 or sm.confirm is null,1,0)) confirm,p.dtype,p.doc_no,p.workper,p.empid,p.empgroupid from cm_servplan p left join cm_srvdetm sm on sm.schrefdocno=p.tr_no group by p.doc_no,p.dtype) p on (m.tr_no=p.doc_no and m.dtype=p.dtype) left join cm_serteamm mm on(p.empgroupid=mm.doc_no) left join cm_serteamd md on(md.rdocno=mm.doc_no and p.empid=md.empid) where m.dtype='SJOB' and m.status=3 and m.jbaction in (0,4) and m.pstatus!=1 and p.confirm!=0  and (p.empid is null or p.empid='0') "+sqltest+" group by m.tr_no)a) notassigned,(select count(*) val from (select m.tr_no from cm_srvcontrm m left join (select sum(if(sm.confirm=0 or sm.confirm is null,1,0)) confirm,p.dtype,p.doc_no,p.workper,p.empid,p.empgroupid from cm_servplan p left join cm_srvdetm sm on sm.schrefdocno=p.tr_no group by p.doc_no,p.dtype) p on (m.tr_no=p.doc_no and m.dtype=p.dtype) left join cm_serteamm mm on(p.empgroupid=mm.doc_no) left join cm_serteamd md on(md.rdocno=mm.doc_no and p.empid=md.empid) where m.dtype='SJOB' and m.status=3 and m.jbaction in (0,4) and m.pstatus!=1 and p.confirm!=0  and (p.empid is not null and p.empid!='0') "+sqltest+" group by m.tr_no)a) assigned,(select count(*) val from (select m.tr_no from cm_srvcontrm m left join (select sum(if(sm.confirm=0 or sm.confirm is null,1,0)) confirm,p.dtype,p.doc_no,p.workper,p.empid,p.empgroupid from cm_servplan p left join cm_srvdetm sm on sm.schrefdocno=p.tr_no group by p.doc_no,p.dtype) p on (m.tr_no=p.doc_no and m.dtype=p.dtype) left join cm_serteamm mm on(p.empgroupid=mm.doc_no) left join cm_serteamd md on(md.rdocno=mm.doc_no and p.empid=md.empid) where m.dtype='SJOB' and m.status=3 and m.jbaction in (0,4) and m.pstatus!=1 and p.confirm!=0  and p.workper>0 "+sqltest+" group by m.tr_no)a) workstarted,(select count(*) val from (select m.tr_no from cm_srvcontrm m left join (select sum(if(sm.confirm=0 or sm.confirm is null,1,0)) confirm,p.dtype,p.doc_no,p.workper,p.empid,p.empgroupid from cm_servplan p left join cm_srvdetm sm on sm.schrefdocno=p.tr_no group by p.doc_no,p.dtype) p on (m.tr_no=p.doc_no and m.dtype=p.dtype) left join cm_serteamm mm on(p.empgroupid=mm.doc_no) left join cm_serteamd md on(md.rdocno=mm.doc_no and p.empid=md.empid) where m.dtype='SJOB' and m.status=3 and m.jbaction in (0,4) and m.pstatus!=1 and p.confirm!=0  "+sqltest+" group by m.tr_no)a) pndcnfrd";
	    //System.out.println(strenq);                    
			String notassignedcount="0",assignedcount="0",workstartedcount="0",pndcnfrdcount="0";      
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				notassignedcount=rsenq.getString("notassigned");  
				assignedcount=rsenq.getString("assigned");
				workstartedcount=rsenq.getString("workstarted");
				pndcnfrdcount=rsenq.getString("pndcnfrd");  
			}
			objdata.put("notassignedcount",notassignedcount);
			objdata.put("assignedcount",assignedcount);
			objdata.put("workstartedcount",workstartedcount);
			objdata.put("pndcnfrdcount",pndcnfrdcount);       
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