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
		String tax = request.getParameter("tax")==null?"":request.getParameter("tax").trim().toString();
		String branchids = request.getParameter("brhid")==null || request.getParameter("brhid").equals("")?"0":request.getParameter("brhid").trim().toString();
		String contractno = request.getParameter("contractno")==null || request.getParameter("contractno").equals("")?"0":request.getParameter("contractno").trim().toString();
		String cnttrno = request.getParameter("cnttrno")==null || request.getParameter("cnttrno").equals("")?"0":request.getParameter("cnttrno").trim().toString();
		String curr = request.getParameter("curid")==null || request.getParameter("curid").equals("")?"0":request.getParameter("curid").trim().toString();
		String currate = request.getParameter("rate")==null || request.getParameter("rate").equals("")?"0":request.getParameter("rate").trim().toString();
		String accdoc = request.getParameter("clacno")==null?"":request.getParameter("clacno").trim().toString();
		String puraccname = request.getParameter("clname")==null?"":request.getParameter("clname").trim().toString();
		double nettotal = request.getParameter("netamount")==null || request.getParameter("netamount").trim().equals("")?0.0:Double.parseDouble(request.getParameter("netamount").trim().toString());
		String trnarray = request.getParameter("trno")==null || request.getParameter("trno").trim().equals("")?"0":request.getParameter("trno").trim().toString();
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
		String linedesc="",vattype="",service="",headdoc="",description="",linetype="",contracttype="AMC",remarks=""; 
		double taxperc1=0.0, taxperc=0.0, amount=0.0, taxperamt=0.0, taxamount=0.0; 
		int i=0, srsvocno=0, srsdocno=0, val=0;  
		//System.out.println("trnarray=="+trnarray);
		String temp[] = trnarray.split(",");        
		ArrayList<String> descarray = new ArrayList<String>();
		String sql = "SELECT COALESCE((SELECT per FROM gl_taxmaster WHERE status=3 AND type=2 AND '"+sqlDate+"' BETWEEN fromdate AND todate AND per>0),0) taxper,(SELECT acno FROM my_account WHERE codeno='AMC INCOME') acno";
		//System.out.println("sql=="+sql);  
		ResultSet rs = stmt.executeQuery(sql);      
		while(rs.next()){     
			//taxperc = rs.getDouble("taxper");  
			headdoc = rs.getString("acno");
		}    
		session.setAttribute("BRANCHID", branchids);
		for(int j=0;j<temp.length;j++){
			String trnsarray[] = temp[j].split("####");  
			amount = trnsarray[1]==null || trnsarray[1].trim().equals("")?0.00:Double.parseDouble(trnsarray[1].trim().toString());     
			taxperc1 = trnsarray[2]==null || trnsarray[2].trim().equals("")?0.00:Double.parseDouble(trnsarray[2].trim().toString());     
			taxperamt = trnsarray[3]==null || trnsarray[3].trim().equals("")?0.00:Double.parseDouble(trnsarray[3].trim().toString());     
			taxamount = trnsarray[4]==null || trnsarray[4].trim().equals("")?0.00:Double.parseDouble(trnsarray[4].trim().toString());            
			linetype = trnsarray[5];
			linedesc = trnsarray[6]==null?"":trnsarray[6].trim().toString(); 
			/* if(linetype.equalsIgnoreCase("HR")){   
				remarks = trnsarray[6]==null?"":trnsarray[6].trim().toString();   
			}else{
				remarks = "";   
			} */     
			if(taxperc1>0){     
				taxperc=taxperc1;     
			}
		    descarray.add(1+"::"+1+" :: "+linedesc+" :: "+amount+" :: "+amount+" :: "+0+" :: "+amount+" :: "+taxperc1+" :: "+taxperamt+" :: "+taxamount+" :: "+0+" :: "+3+" :: "+contractno+" :: "+remarks+" :: "+headdoc+" :: "+0+" :: ");
		}       
		
		System.out.println("descarray=="+descarray);         
		srsdocno = DAO.insert(sqlDate, sqlDate, contracttype, contractno, "AR", accdoc, puraccname, curr, currate, delterms, payterms, invdesc, session, "A", nettotal, descarray, "PINV", request, sqlDate, invno, "", 0, taxperc, masteraction); 
		if(srsdocno>0){  
			//int trnno = Integer.parseInt(request.getAttribute("trans").toString());  
			srsvocno = Integer.parseInt(request.getAttribute("vocno").toString()); 
			for(int j=0;j<temp.length;j++){
				String trnsarray[] = temp[j].split("####"); 
				linetype = trnsarray[5];  
				if(linetype.equalsIgnoreCase("HR")){   
					//System.out.println("trnsarray[0]=="+trnsarray[0]);     
					String linearray[] = trnsarray[0].split("/");            
					
					String sqlup1 = "UPDATE hr_timesheethrs SET invtrno='"+srsdocno+"', confirm=1 WHERE empid='"+linearray[0]+"' AND costtype='"+linearray[1]+"' AND costcode='"+linearray[2]+"'";   
					//System.out.println("sqlup1=="+sqlup1);              
					val = stmt.executeUpdate(sqlup1);  
					
					String sqlup = "INSERT INTO sa_expenseinv(tranid, invamt, costtype, costcode, invtrno, linetype) VALUES('"+linearray[0]+"', "+trnsarray[1]+", 3, '"+contractno+"', '"+srsdocno+"', '"+linetype+"')";
					//System.out.println("sqlup=="+sqlup);            
					val = stmt.executeUpdate(sqlup);
				}else{
					String sqlup = "INSERT INTO sa_expenseinv(tranid, invamt, costtype, costcode, invtrno, linetype) VALUES('"+trnsarray[0]+"', "+trnsarray[1]+", 3, '"+contractno+"', '"+srsdocno+"', '"+linetype+"')";   
					//System.out.println("sqlup=="+sqlup);            
					val = stmt.executeUpdate(sqlup); 
				}
			}
			String sqlup2 = "UPDATE my_srvsaleprom SET cnttrno='"+cnttrno+"' WHERE doc_no='"+srsdocno+"'";      
			//System.out.println("sqlup2=="+sqlup2);            
			stmt.executeUpdate(sqlup2);    
		}
		  
		 if(val>0 && srsdocno>0){     
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