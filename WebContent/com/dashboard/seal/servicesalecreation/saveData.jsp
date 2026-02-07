<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleAction"%>  
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO"%>       
<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		ClsServiceSaleDAO DAO =new ClsServiceSaleDAO();         
		ClsServiceSaleAction masteraction = new ClsServiceSaleAction();  
		String trno = request.getParameter("trno")==null || request.getParameter("trno").trim().equals("")?"0":request.getParameter("trno").trim().toString();
		String invdate = request.getParameter("invdate")==null?"":request.getParameter("invdate").trim().toString();
		String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();
		String invno = request.getParameter("invno")==null?"":request.getParameter("invno").trim().toString();
		String invdesc = request.getParameter("invdesc")==null?"":request.getParameter("invdesc").trim().toString();
		String payterms = request.getParameter("payterms")==null?"":request.getParameter("payterms").trim().toString();
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
		String vattype="",service="",headdoc="",description="",accdoc="", puraccname="", curr="", currate="", contracttype="", contractno="",branchids="", costtype="", costcode="";
		double taxperc1 = 0.0, nettotal=0.0, taxperc=0.0, amount=0.0, taxperamt=0.0, taxamount=0.0, total=0.0,discount=0.0,subtotal=0.0; 
		int i=0,srsvocno=0,qty=0;
		ArrayList<String> descarray = new ArrayList<String>();
		String sql = "SELECT ROUND(m.netamount,2) total, h.description, m.acno, m.curid, m.rate, m.brhid, IF(d.costtype=3,'AMC','') dtype, d.costcode doc_no, ROUND(if(tax>0,5,0),2) taxper FROM my_srvsaleprom m LEFT JOIN my_head h ON h.doc_no=m.acno LEFT JOIN(SELECT costtype, costcode, rdocno, sum(if(taxper>0,1,0)) tax FROM my_srvsaleprod GROUP BY rdocno)d ON d.rdocno=m.doc_no WHERE m.doc_no='"+trno+"'";
		//System.out.println("sql=="+sql);    
		ResultSet rs = stmt.executeQuery(sql);    
		while(rs.next()){         
			//nettotal = rs.getDouble("total");
			puraccname = rs.getString("description");
			curr = rs.getString("curid");
			currate = rs.getString("rate");
			taxperc = rs.getDouble("taxper");
			contracttype = rs.getString("dtype");
			contractno = rs.getString("doc_no");
			branchids = rs.getString("brhid");  
			accdoc = rs.getString("acno");  
		}  
		session.setAttribute("BRANCHID", branchids);
		
		String sql2 = "SELECT ROUND(d.total,2) total, d.qty, d.desc1 service, ROUND(d.unitprice,2) amount, d.taxper, ROUND(d.tax,2) tax, ROUND(d.nettaxamount,2) nettaxamount, d.costtype, d.costcode, d.remarks description, d.acno, ROUND(d.discount,2) discount, ROUND(d.nettotal,2) nettotal FROM my_srvsaleprod d WHERE d.rdocno='"+trno+"'";
		System.out.println("sql2=="+sql2);    
		ResultSet rs2 = stmt.executeQuery(sql2);      
		while(rs2.next()){   
			amount = rs2.getDouble("amount");
			description = rs2.getString("description");
			headdoc = rs2.getString("acno");
			service = rs2.getString("service");
			taxperc1 = rs2.getDouble("taxper");
			if(taxperc1>0){   
				taxperc = taxperc1;        
			}
			taxperamt = rs2.getDouble("tax");
			taxamount = rs2.getDouble("nettaxamount");
			costtype = rs2.getString("costtype");
			costcode = rs2.getString("costcode");  
			qty = rs2.getInt("qty");  
			total = rs2.getDouble("total");
			discount = rs2.getDouble("discount");
			subtotal = rs2.getDouble("nettotal");  
			nettotal+=subtotal;     
			descarray.add(i+"::"+qty+" :: "+service+" :: "+amount+" :: "+total+" :: "+discount+" :: "+subtotal+" :: "+taxperc+" :: "+taxperamt+" :: "+taxamount+" :: "+0+" :: "+costtype+" :: "+costcode+" :: "+description+" :: "+headdoc+" :: "+0+" :: ");
			i++;  
			//System.out.println("=in="+subtotal);       
		}    
		//System.out.println("=nettotal="+nettotal);   
		//System.out.println(nettotal+"==descarray=="+descarray);        
		int val = DAO.insert(sqlDate, sqlDate, contracttype, contractno, "AR", accdoc, puraccname, curr, currate, delterms, payterms, invdesc, session, "A", nettotal, descarray, "SRS", request, sqlDate, invno, "", 0, taxperc, masteraction);    
		if(val>0){  
			int trnno = Integer.parseInt(request.getAttribute("trans").toString());  
			srsvocno = Integer.parseInt(request.getAttribute("vocno").toString());       
		    String sqlup1="UPDATE my_srvsaleprom SET srstrno='"+trnno+"' WHERE doc_no='"+trno+"'";  
		    //System.out.println("sqlup1=="+sqlup1);            
		    val = stmt.executeUpdate(sqlup1);  
		}
		  
		 if(val>0){
			 conn.commit();
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