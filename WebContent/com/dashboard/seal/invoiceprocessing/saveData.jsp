<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.project.execution.proformaInvoice.ClsProformaInvoiceAction"%>  
<%@page import="com.project.execution.proformaInvoice.ClsProformaInvoiceDAO"%>     
<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		ClsProformaInvoiceDAO DAO =new ClsProformaInvoiceDAO();      
		ClsProformaInvoiceAction masteraction = new ClsProformaInvoiceAction();  
		String tempdocno = request.getParameter("tempdocno")==null?"":request.getParameter("tempdocno").trim().toString();  
		String trno = request.getParameter("trno")==null || request.getParameter("trno").trim().equals("")?"0":request.getParameter("trno").trim().toString();
		String invdate = request.getParameter("invdate")==null?"":request.getParameter("invdate").trim().toString();
		String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();
		String invno = request.getParameter("invno")==null?"":request.getParameter("invno").trim().toString();
		String invdesc = request.getParameter("invdesc")==null?"":request.getParameter("invdesc").trim().toString();
		String payterms = request.getParameter("payterms")==null?"":request.getParameter("payterms").trim().toString();
		String gridarray = request.getParameter("gridarray")==null?"":request.getParameter("gridarray").trim().toString();
		String currate = request.getParameter("rate")==null || request.getParameter("rate").trim().equals("")?"0":request.getParameter("rate").trim().toString();
		String delterms = request.getParameter("delterms")==null?"":request.getParameter("delterms").trim().toString();
		String userid = session.getAttribute("USERID").toString();     
		java.sql.Date sqlDate=null;       
		java.sql.Date sqltoDate=null;     

	    if(!(invdate.equalsIgnoreCase("undefined"))&&!(invdate.equalsIgnoreCase(""))&&!(invdate.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(invdate);
		}
	    
	    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	    	sqltoDate=ClsCommon.changeStringtoSqlDate(todate);
		}   
		String vattype="",service="",headdoc="",description="",accdoc="", puraccname="", curr="", contracttype="", contractno="",branchids="";
		double nettotal=0.0, taxperc=5.0, amount=0.0, taxperamt=0.0, taxamount=0.0; 
		int srsvocno=0;
		
		ArrayList<String> descarray = new ArrayList<String>();
		String gridar[] = gridarray.split(",");
		for(int i=0;i<gridar.length;i++){
			descarray.add(gridar[i]);
		}
	    //System.out.println("tempdocno=="+tempdocno);  
	    System.out.println("descarray=="+descarray);       
		String sql = "SELECT COALESCE((SELECT per FROM gl_taxmaster WHERE status=3 AND type=2 AND '"+sqlDate+"' BETWEEN fromdate AND todate AND per>0),0) taxper,m.brhid,m.dtype,COALESCE(m.rate,0) rate,h.description,ac.acno,ROUND(SUM(amounttr),2) total,m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d.%m.%Y') date,c.code curr,m.curid,m.vattype,ac.refname,m.cldocno,DATE_FORMAT(m.validfrom,'%d.%m.%Y') validfrom,DATE_FORMAT(m.validupto,'%d.%m.%Y') validupto FROM cm_srvcontrm m LEFT JOIN my_acbook ac ON ac.cldocno=m.cldocno AND ac.dtype='crm' LEFT JOIN my_curr c ON c.doc_no=m.curid LEFT JOIN my_head h ON h.doc_no=ac.acno LEFT JOIN sa_srvcontrd d ON d.rdocno = m.tr_no WHERE IF(d.billtype=1,coalesce(d.invdate,m.validfrom)<='"+sqltoDate+"',d.invtrno=0) AND m.tr_no='"+trno+"' GROUP BY m.tr_no";
		//System.out.println("sql=="+sql);    
		ResultSet rs = stmt.executeQuery(sql);    
		while(rs.next()){   
			nettotal = rs.getDouble("total");
			puraccname = rs.getString("description");
			curr = rs.getString("curid");
			taxperc = rs.getDouble("taxper");
			contracttype = rs.getString("dtype");
			contractno = rs.getString("doc_no");
			branchids = rs.getString("brhid");  
			vattype = rs.getString("vattype");
			accdoc = rs.getString("acno");  
		}  
		session.setAttribute("BRANCHID", branchids);
	    
		int val = DAO.insert(sqlDate, sqlDate, contracttype, contractno, "AR", accdoc, puraccname, curr, currate, delterms, payterms, invdesc, session, "A", nettotal, descarray, "PINV", request, sqlDate, invno, "", 0, taxperc, masteraction);    
		int d1=0, d2=0, d3=0, d4=0, d5=0;
		if(val>0){
			//int trnno = Integer.parseInt(request.getAttribute("trans").toString());  
			srsvocno = Integer.parseInt(request.getAttribute("vocno").toString());     
			
			String sqlup="UPDATE cm_srvcontrm m INNER JOIN sa_srvcontrd d ON d.rdocno=m.tr_no SET d.invdate=DATE_ADD(IF(d.invdate IS NULL,m.validfrom,d.invdate),INTERVAL 1 YEAR) WHERE m.tr_no='"+trno+"' AND coalesce(d.invdate,m.validfrom)<='"+sqltoDate+"' AND d.billtype=1 AND d.doc_no in("+tempdocno+")";
			//System.out.println("sqlup=="+sqlup);     
			d1 = stmt.executeUpdate(sqlup);
		
			String sqlup3="UPDATE cm_srvcontrm m INNER JOIN sa_srvcontrd d ON d.rdocno=m.tr_no SET d.invdate=DATE_ADD(IF(d.invdate IS NULL,m.validfrom,d.invdate),INTERVAL 1 MONTH) WHERE m.tr_no='"+trno+"' AND coalesce(d.invdate,m.validfrom)<='"+sqltoDate+"' AND d.billtype=3 AND d.doc_no in("+tempdocno+")";
			//System.out.println("sqlup3=="+sqlup3);     
			d3 = stmt.executeUpdate(sqlup3);
			
			String sqlup4="UPDATE cm_srvcontrm m INNER JOIN sa_srvcontrd d ON d.rdocno=m.tr_no SET d.invdate=DATE_ADD(IF(d.invdate IS NULL,m.validfrom,d.invdate),INTERVAL 3 MONTH) WHERE m.tr_no='"+trno+"' AND coalesce(d.invdate,m.validfrom)<='"+sqltoDate+"' AND d.billtype=4 AND d.doc_no in("+tempdocno+")";
			//System.out.println("sqlup4=="+sqlup4);     
			d4 = stmt.executeUpdate(sqlup4);  
			
			String sqlup5="UPDATE cm_srvcontrm m INNER JOIN sa_srvcontrd d ON d.rdocno=m.tr_no SET d.invdate=DATE_ADD(IF(d.invdate IS NULL,m.validfrom,d.invdate),INTERVAL 6 MONTH) WHERE m.tr_no='"+trno+"' AND coalesce(d.invdate,m.validfrom)<='"+sqltoDate+"' AND d.billtype=5 AND d.doc_no in("+tempdocno+")";     
			//System.out.println("sqlup5=="+sqlup5);     
			d5 = stmt.executeUpdate(sqlup5);
			
		    String sqlup1="UPDATE sa_srvcontrd SET invtrno='"+val+"' WHERE rdocno='"+trno+"' AND invtrno=0 AND billtype=2 AND doc_no in("+tempdocno+")";
		    //System.out.println("sqlup1=="+sqlup1);      
		    d2 = stmt.executeUpdate(sqlup1);  
		    
		    String sqlup6="UPDATE my_srvsaleprom SET cnttrno='"+trno+"' WHERE doc_no='"+val+"'";            
			//System.out.println("sqlup6=="+sqlup6);     
			stmt.executeUpdate(sqlup6);
		}  
		  
		 if(d1>0 || d2>0 || d3>0 || d4>0 || d5>0){     
			 val=1;
			 conn.commit();
		 }else{
			 val=0;      
		 }
		 response.getWriter().print(val+"####"+srsvocno);    
	 	 stmt.close();
	 	 conn.close();  
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>