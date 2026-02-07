<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.procurement.purchase.goodsreceiptnotereturn.ClsgoodsreceiptnotereturnDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
	Connection conn=null;
	String strgrnarray[]=request.getParameterValues("grnarray[]");
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
	String location=request.getParameter("location")==null?"":request.getParameter("location").toString();
	String vendor=request.getParameter("vendor")==null?"":request.getParameter("vendor").toString();
	String desc=request.getParameter("desc")==null?"":request.getParameter("desc").toString();
	String grndocno=request.getParameter("grndocno")==null?"":request.getParameter("grndocno").toString();
	
	int errorstatus=0;
	JSONObject objdata=new JSONObject();
	try{
		ClsConnection objconn=new ClsConnection();
		ClsgoodsreceiptnotereturnDAO retdao=new ClsgoodsreceiptnotereturnDAO();
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		String strmisc="select head.curid,head.rate,ac.acno,curdate() basedate from my_acbook ac left join my_head head on ac.acno=head.doc_no where ac.cldocno="+vendor+" and ac.dtype='VND' and ac.status=3";
		System.out.println(strmisc);
		ResultSet rsmisc=stmt.executeQuery(strmisc);
		java.sql.Date sqldate=null;
		int vendoracno=0,curid=0;
		double currate=0.0;
		while(rsmisc.next()){
			sqldate=rsmisc.getDate("basedate");
			vendoracno=rsmisc.getInt("acno");
			curid=rsmisc.getInt("curid");
			currate=rsmisc.getDouble("rate");
		}
		conn.close();
		ArrayList<String> grnarray=new ArrayList();
		for(int i=0;i<strgrnarray.length;i++){
			grnarray.add(strgrnarray[i]);
		}
		/* Date masterdate, Date deldate, String refno, int vendocno,
		int cmbcurr, double currate, String delterms, String payterms,
		String purdesc, double productTotal, double descPercentage,
		double descountVal, double roundOf, double netTotaldown,
		double servnettotal, double orderValue, int chkdiscount,
		HttpSession session, String mode,  
		String formdetailcode, HttpServletRequest request, 
		ArrayList <String> masterarray, String reftype, String rrefno, double prddiscount, int locationid */ 
		/* 2021-11-25::2021-11-25::::1316::1::1.0::::::desc::0.0::0.0::0.0::0.0::0.0::0.0::0.0::0::A::GRR::GRN::4::0.0::1 */
		conn.close();
		int retdocno=retdao.insert(sqldate, sqldate, "", vendoracno,curid, currate, "", "", desc, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, session, "A", "GRR", request, grnarray, "GRN", grndocno, 0.0, Integer.parseInt(location));
		if(retdocno<=0){
			errorstatus=0;
		}
		else{
			objdata.put("grnretdocno",retdocno);
		}
	}
	catch(Exception e){
		e.printStackTrace();
		errorstatus=1;
	}
	finally{
		conn.close();
	}
	objdata.put("errorstatus",errorstatus);
	response.getWriter().write(objdata+"");
%>