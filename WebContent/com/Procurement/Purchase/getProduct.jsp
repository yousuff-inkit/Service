<%@page import="com.procurement.purchase.ClsProduct"%>
<%@page import="com.procurement.purchase.ClsGetProduct"%>
<%@page import="net.sf.json.JSONArray"%>

 
<%
	ClsProduct bean = new ClsProduct();
	ClsGetProduct product=new ClsGetProduct();
	System.out.println("test on jsp 0");
	try{
		JSONArray prdarray=new JSONArray();
		System.out.println("test on jsp");
		String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
		String cmbbilltype=request.getParameter("cmbbilltype")==null || request.getParameter("cmbbilltype")==""?"0":request.getParameter("cmbbilltype").trim();
		String acno=request.getParameter("acno")==null?"0":request.getParameter("acno")==""?"0":request.getParameter("acno").trim();
		String reqmasterdocno=(request.getParameter("reqmasterdocno")==null||request.getParameter("reqmasterdocno")=="")?"0":request.getParameter("reqmasterdocno").trim();
		String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
		String presulttype=request.getParameter("presulttype")==null?"0":request.getParameter("presulttype")==""?"0":request.getParameter("presulttype").trim();
		String loc=request.getParameter("loc")==null?"0":request.getParameter("loc").trim();
		String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();
		String brcid=session.getAttribute("BRANCHID").toString();
		System.out.println("acno : "+acno+"===dates==="+dates+"===cmbbilltype==="+cmbbilltype+"===acno==="+acno+"====reqmasterdocno==="+reqmasterdocno+"====dtype==="+dtype+"==reftype===="+reftype+"===loc==="+loc);


		
		bean.setAcno(acno);
		bean.setBilltype(cmbbilltype);
		bean.setDates(dates);
		bean.setMasterdocno(reqmasterdocno);
		bean.setDtype(dtype);
		bean.setPresulttype(presulttype);
		bean.setReftype(reftype);
		bean.setLoc(loc);
		
		prdarray=product.getProduct(bean, session);
		
		response.getWriter().print(prdarray);


		
	}catch(Exception e){
		e.printStackTrace();
	}
%>