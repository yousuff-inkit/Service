<%@page import="com.dashboard.analysis.pendingcontract.ClsPendingContractBean"%>
<%@page import="com.dashboard.analysis.pendingcontract.ClsPendingContract"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%	
ClsPendingContract prd=new ClsPendingContract();
ClsPendingContractBean bean=new ClsPendingContractBean();
	try{
		JSONArray prdarray=new JSONArray();
		JSONObject objprd=new JSONObject(); 
		
		/* tring barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	  	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
	  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
	  	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
	  	String locid = request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
	  	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
		String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
		String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
		String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
		String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
		String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
		String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
		String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
		String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
		String acno = request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
		String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
		String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); */
		
		 String date =request.getParameter("date")==null?"0":request.getParameter("date").trim();
		 String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").trim();
		 String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
		 String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
		 int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").trim());
		 String cstatus =request.getParameter("cstatus")==null?"0":request.getParameter("cstatus").trim(); 

		bean.setDate(date);
		bean.setBranch(branch);
		bean.setClientid(clientid);
		bean.setDtype(dtype);
		bean.setId(id);
		bean.setCstatus(cstatus);
		prdarray = prd.pendingContractGridLoad(bean, session);          
		// System.out.println("prdarray==="+prdarray);
		
		
		response.getWriter().print(prdarray);
		
	}catch(Exception e){
	 	e.printStackTrace();
	 	
	}finally{
		
	}
  %>
  
