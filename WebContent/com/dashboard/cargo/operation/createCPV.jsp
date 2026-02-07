<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%@page import="com.finance.transactions.cashpayment.ClsCashPaymentDAO" %>              
<%	
ClsConnection ClsConnection=new ClsConnection();     
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();            
		Statement stmt = conn.createStatement();   
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
		String date=request.getParameter("date")=="" || request.getParameter("date")==null?"0":request.getParameter("date").trim();
		String cashdocno=request.getParameter("cashdocno")=="" || request.getParameter("cashdocno")==null?"0":request.getParameter("cashdocno");
		String jobadvdocno="0";   
		Double amount=request.getParameter("jobamount")=="" || request.getParameter("jobamount")==null?0.0:Double.parseDouble(request.getParameter("jobamount"));    
		String jobdesc=request.getParameter("jobdesc")==null?"":request.getParameter("jobdesc");            
		String vndchk=request.getParameter("vndchk")=="" || request.getParameter("vndchk")==null?"0":request.getParameter("vndchk");
		String vndacno=request.getParameter("vndacno")=="" || request.getParameter("vndacno")==null?"0":request.getParameter("vndacno");     
		int dat=0;         
		int val=0,temp=0,val1=0,tranno=0;   
		ClsCashPaymentDAO DAO=new ClsCashPaymentDAO();                                     
			 ArrayList<String> cparray= new ArrayList<String>();  
		     java.sql.Date sqlrefdate=null;
		     java.sql.Date sqldate=null;
		     if(!date.equalsIgnoreCase("0") && !date.equalsIgnoreCase("")){          
		    	 sqldate=ClsCommon.changeStringtoSqlDate(date);   
		     }   
		     ArrayList<String> casharray=new ArrayList<String>(); 
		     ArrayList<String> applyinvoicearray=new ArrayList<String>();     
			 session.setAttribute("BRANCHID",brhid);        
			 String strcountvnd="select acno from my_account where codeno='JOBADVANCE'";   
			 ResultSet rs5=stmt.executeQuery(strcountvnd);                                 
			 while(rs5.next()){     
				 jobadvdocno=rs5.getString("acno");   
			 }	   	
			 casharray.add(cashdocno+" :: "+1+" :: "+1.0+" :: "+ false+" :: "+amount*-1+" :: "+jobdesc+" :: "+amount*-1+" :: "+0+" :: "+0+" :: "+docno);
			 if(!vndchk.equalsIgnoreCase("0")){
				 casharray.add(vndacno+" :: "+1+" :: "+1.0+" :: "+ true+" :: "+amount+" :: "+jobdesc+" :: "+amount+" :: "+0+" :: "+0+" :: "+docno); 
			 }else{
				 casharray.add(0+" :: "+1+" :: "+1.0+" :: "+ true+" :: "+0.0+" :: "+jobdesc+" :: "+0.0+" :: "+0+" :: "+0+" :: "+docno);
				 casharray.add(jobadvdocno+" :: "+1+" :: "+1.0+" :: "+ true+" :: "+amount+" :: "+jobdesc+" :: "+amount+" :: "+0+" :: "+0+" :: "+docno); 
			 }
			                           
			 dat=DAO.insert(sqldate,"CPV","",1.0,"",amount,amount,casharray,applyinvoicearray,session,request,"A");              
			 //System.out.println("val--->>>"+dat);          
			 if(dat>0){ 
				 tranno=Integer.parseInt(request.getAttribute("tranno").toString());           
				 String strupdate="update cm_srvcontrm set cpvtrno="+tranno+",docstatus='Advance paid',jobvndchk="+vndchk+",jobvndacno="+vndacno+" where tr_no="+docno+"";                                     
				 //System.out.println("strupdate--->>>"+strupdate);                         
				 val1=stmt.executeUpdate(strupdate);    
				 String logdesc="Cash Payment created#"+dat+" contract tr_no is passing here";                             
   	        	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
				 //System.out.println(val+"====sqllog===="+sqllog);   
				 stmt.executeUpdate(sqllog);  
   	         }
			 response.getWriter().print(dat);                       
 	stmt.close();  
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
