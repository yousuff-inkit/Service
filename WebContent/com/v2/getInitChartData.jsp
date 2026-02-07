<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="com.dashboard.ClsDashBoardNewDAO"%>
<%@page import="java.sql.*"%>

<%
	JSONObject data=new JSONObject();
	JSONObject enqdetails=new JSONObject();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	JSONObject objdata=new JSONObject();  
	ClsDashBoardNewDAO dao=new ClsDashBoardNewDAO();
	String widgetname=request.getParameter("enqtype")==null?"":request.getParameter("enqtype");
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
	String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
	String divname=request.getParameter("divname")==null?"":request.getParameter("divname");
	Connection conn=null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		java.sql.Date sqlfromdate=null,sqltodate=null;
		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		sqltodate=objcommon.changeStringtoSqlDate(todate);
		String sqltest="";
		System.out.println(widgetname+"=="+divname);   
		if(divname.equalsIgnoreCase("enquirylist")){  
			String strenq="select (select count(*) from gl_enqm where enqstatus=0 and sh_empid=0 and status=3) enqsur,(select count(*) from gl_enqm where enqstatus=0 and sh_empid!=0 and status=3) schenq,(select count(*) from gl_enqm where enqstatus=1 and status=3) sur,(select count(*) from gl_enqm where enqstatus=2 and status=3) est,(select count(*) from gl_enqm where enqstatus=3 and status=3) quot,(select count(*) from gl_enqm where enqstatus<=3 and status=3) total";
			System.out.println(strenq);    
			String totalcount="0",enqsurcount="0",schenqcount="0",surcount="0",estcount="0",quotcount="0";      
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				totalcount=rsenq.getString("total");  
				enqsurcount=rsenq.getString("enqsur");
				schenqcount=rsenq.getString("schenq");
				surcount=rsenq.getString("sur");
				estcount=rsenq.getString("est");
				quotcount=rsenq.getString("quot");  
			}
			objdata.put("enqschcount",enqsurcount);
			objdata.put("schenqcount",schenqcount);
			objdata.put("surcount",surcount);
			objdata.put("estcount",estcount);
			objdata.put("quotcount",quotcount);
			objdata.put("totalcount",totalcount);  
			
			enqdetails=dao.getChartCountData(widgetname,conn); 
		}
		if(divname.equalsIgnoreCase("enquirylist2")){ 
			if(sqlfromdate!=null){
				sqltest+=" and date>='"+sqlfromdate+"'";    
			}
			if(sqltodate!=null){
				sqltest+=" and date<='"+sqltodate+"'";  
			}  
			String strcount="select (select count(*) from gl_enqm where status=3"+sqltest+") enqcount,(select count(*) from cm_surveym where status=3"+sqltest+") surcount,(select count(*) from cm_prjestm where status=3"+sqltest+") estcount,(select count(*) from cm_srvqotm where status=3"+sqltest+") quotcount,(select count(*) from cm_srvcontrm where status=3"+sqltest+") contrcount";    
			System.out.println(strcount);    
			String enquiry="0",survey="0",estimation="0",quotation="0",contract="0";         
			ResultSet rsdet=stmt.executeQuery(strcount);
			while(rsdet.next()){
				enquiry=rsdet.getString("enqcount");  
				survey=rsdet.getString("surcount");
				estimation=rsdet.getString("estcount");
				quotation=rsdet.getString("quotcount");
				contract=rsdet.getString("contrcount");                  
			}
			data.put("enquiry",enquiry);
			data.put("survey",survey);
			data.put("estimation",estimation);
			data.put("quotation",quotation);
			data.put("contract",contract);         
		}		
		                
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	//System.out.println(enqdetails);  
	response.getWriter().write(data+"***"+enqdetails+"***"+objdata);       
%>