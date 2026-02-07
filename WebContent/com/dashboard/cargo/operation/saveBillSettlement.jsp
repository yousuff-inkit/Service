<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%@page import="com.finance.transactions.multiplecashpurchase.ClsmultipleCashPurchaseDAO" %>                  
<%	
ClsConnection ClsConnection=new ClsConnection();     
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection(); 
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();   
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
		String date=request.getParameter("date")=="" || request.getParameter("date")==null?"0":request.getParameter("date");
		int cashdocno=request.getParameter("cashdocno")=="" || request.getParameter("cashdocno")==null?0:Integer.parseInt(request.getParameter("cashdocno"));
		String mcparray=request.getParameter("mcparray")=="" || request.getParameter("mcparray")==null?"":request.getParameter("mcparray");
		String mcpcreditarray=request.getParameter("mcpcreditarray")=="" || request.getParameter("mcpcreditarray")==null?"":request.getParameter("mcpcreditarray");
		Double amount=request.getParameter("amount")=="" || request.getParameter("amount")==null?0.0:Double.parseDouble(request.getParameter("amount"));
		Double stlamount=request.getParameter("stlamount")=="" || request.getParameter("stlamount")==null?0.0:Double.parseDouble(request.getParameter("stlamount"));
		Double advamount=request.getParameter("advamount")=="" || request.getParameter("advamount")==null?0.0:Double.parseDouble(request.getParameter("advamount"));
		Double billamount=request.getParameter("billamount")=="" || request.getParameter("billamount")==null?0.0:Double.parseDouble(request.getParameter("billamount"));
		int dat=0;          
		int val=0,temp=0,val1=0,val2=0,tranno=0; 
		//System.out.println("mcparray--->>>"+mcparray); 
		//System.out.println("mcpcreditarray--->>>"+mcpcreditarray);    
		ClsmultipleCashPurchaseDAO DAO=new ClsmultipleCashPurchaseDAO();                                    
		     java.sql.Date sqldate=null;
		     if(!date.equalsIgnoreCase("0")){          
		    	 sqldate=ClsCommon.changetstmptoSqlDate(date);       
		     }   
		     ArrayList<String> newarray=new ArrayList(); 
		     if (mcparray.indexOf(",") != -1 || !"".equals(mcparray)) {                    
		    	 String temparray[]=mcparray.split(",");      
				 for(int i=0;i<temparray.length;i++){
						newarray.add(temparray[i]);
				 }
			 } else {
			 }
			 ArrayList<String> creditarray=new ArrayList(); 
			 if (mcpcreditarray.indexOf(",") != -1 || !"".equals(mcpcreditarray)) {
				 String temparray1[]=mcpcreditarray.split(",");  
				 for(int i=0;i<temparray1.length;i++){
					 creditarray.add(temparray1[i]);      
				 }          
			 } else {
			 }       
			       
			 session.setAttribute("BRANCHID",brhid);           
			 //System.out.println(newarray.size()+"<<<---newarray.size()         creditarray.size()--->>>"+creditarray.size());      
			 String strupdate1="update cm_srvcontrm set billamount="+billamount+",advanceamount="+advamount+",settlementamount="+stlamount+" where tr_no="+docno+"";                                 
			 //System.out.println("strupdate1--->>>"+strupdate1);                           
			 val1=stmt.executeUpdate(strupdate1);                 
			 if(newarray.size()>0){            
				 dat=DAO.insert(sqldate, "MCP","",1.0,amount,"",newarray,session,request,"A","","","",null,"","",cashdocno,0.0,0.0);                     
				 //System.out.println("val--->>>"+dat); 
			 }
			 if(dat>0){
				 tranno=Integer.parseInt(request.getAttribute("tranno").toString());           
				 String strupdate="update cm_srvcontrm set mcptrno="+tranno+",docstatus='Bill settled' where tr_no="+docno+"";                                           
				 //System.out.println("strupdate--->>>"+strupdate);                           
				 val1=stmt.executeUpdate(strupdate);
			  }
			 for(int i=0;i< creditarray.size();i++){    
						String[] pettycash=creditarray.get(i).split("::");              
						if(!pettycash[13].trim().equalsIgnoreCase("undefined") && !pettycash[13].trim().equalsIgnoreCase("NaN")){
							 String srno = pettycash[1].trim().equalsIgnoreCase("undefined") || pettycash[1].trim().equalsIgnoreCase("NaN") || pettycash[1].trim().equalsIgnoreCase("") || pettycash[1].trim().isEmpty()?"0":pettycash[1].trim().toString();
							 String rate = pettycash[2].trim().equalsIgnoreCase("undefined") || pettycash[2].trim().equalsIgnoreCase("NaN") || pettycash[2].trim().equalsIgnoreCase("") || pettycash[2].trim().isEmpty()?"0":pettycash[2].trim().toString();
							 String curid = pettycash[3].trim().equalsIgnoreCase("undefined") || pettycash[3].trim().equalsIgnoreCase("NaN") || pettycash[3].trim().equalsIgnoreCase("") || pettycash[3].trim().isEmpty()?"0":pettycash[3].trim().toString();
							 String acno = pettycash[4].trim().equalsIgnoreCase("undefined") || pettycash[4].trim().equalsIgnoreCase("NaN") || pettycash[4].trim().equalsIgnoreCase("") || pettycash[4].trim().isEmpty()?"0":pettycash[4].trim().toString();
							 String costtype = pettycash[5].trim().equalsIgnoreCase("undefined") || pettycash[5].trim().equalsIgnoreCase("NaN") || pettycash[5].trim().equalsIgnoreCase("") || pettycash[5].trim().isEmpty()?"0":pettycash[5].trim().toString();
							 String costcode = pettycash[6].trim().equalsIgnoreCase("undefined") || pettycash[6].trim().equalsIgnoreCase("NaN") || pettycash[6].trim().equalsIgnoreCase("") || pettycash[6].trim().isEmpty()?"0":pettycash[6].trim().toString();
							 String qty = pettycash[7].trim().equalsIgnoreCase("undefined") || pettycash[7].trim().equalsIgnoreCase("NaN") || pettycash[7].trim().equalsIgnoreCase("") || pettycash[7].trim().isEmpty()?"0":pettycash[7].trim().toString();
							 String unitamount = pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().isEmpty()?"0":pettycash[8].trim().toString();
							 String total = pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().equalsIgnoreCase("") || pettycash[9].trim().isEmpty()?"0":pettycash[9].trim().toString();
							 String taxper = pettycash[10].trim().equalsIgnoreCase("undefined") || pettycash[10].trim().equalsIgnoreCase("NaN") || pettycash[10].trim().equalsIgnoreCase("") || pettycash[10].trim().isEmpty()?"0":pettycash[10].trim().toString();
							 String taxamount = pettycash[11].trim().equalsIgnoreCase("undefined") || pettycash[11].trim().equalsIgnoreCase("NaN") || pettycash[11].trim().equalsIgnoreCase("") || pettycash[11].trim().isEmpty()?"0":pettycash[11].trim().toString();
							 String nettotal = pettycash[12].trim().equalsIgnoreCase("undefined") || pettycash[12].trim().equalsIgnoreCase("NaN") || pettycash[12].trim().equalsIgnoreCase("") || pettycash[12].trim().isEmpty()?"0":pettycash[12].trim().toString();
							 String vndid = pettycash[13].trim().equalsIgnoreCase("undefined") || pettycash[13].trim().equalsIgnoreCase("NaN") || pettycash[13].trim().equalsIgnoreCase("") || pettycash[13].trim().isEmpty()?"0":pettycash[13].trim().toString();
							 String invno = pettycash[14].trim().equalsIgnoreCase("undefined") || pettycash[14].trim().equalsIgnoreCase("NaN") || pettycash[14].trim().equalsIgnoreCase("") || pettycash[14].trim().isEmpty()?"0":pettycash[14].trim().toString();
							 String invdate = pettycash[15].trim().equalsIgnoreCase("undefined") || pettycash[15].trim().equalsIgnoreCase("NaN") || pettycash[15].trim().equalsIgnoreCase("") || pettycash[15].trim().isEmpty()?"0":pettycash[15].trim().toString();
							 //String tinno = pettycash[16].trim().equalsIgnoreCase("undefined") || pettycash[16].trim().equalsIgnoreCase("NaN") || pettycash[16].trim().equalsIgnoreCase("") || pettycash[16].trim().isEmpty()?"0":pettycash[16].trim().toString();   
    						 String tinno = "0";      	      
							 String sqlinsert="insert into cr_mcpcredit(sr_no, rate, curid, acno, costtype, costcode, qty, unitprice, amount, taxper, taxamount, nettotal, vndid, invno, invdate, tinno,rdocno) values ('"+srno+"', "+Double.parseDouble(rate)+",'"+curid+"' ,'"+acno+"' ,'"+costtype+"' ,'"+costcode+"' ,'"+qty+"' , "+Double.parseDouble(unitamount)+","+Double.parseDouble(total)+" ,"+Double.parseDouble(taxper)+" ,"+Double.parseDouble(taxamount)+" ,"+Double.parseDouble(nettotal)+" , '"+vndid+"', '"+invno+"','"+ClsCommon.changeStringtoSqlDate(invdate)+"' ,'"+tinno+"',"+docno+" )";                             
							 //System.out.println(val+"====sqlinsert===="+sqlinsert);   
							 val2=stmt.executeUpdate(sqlinsert);                  
						}		   							
			  } 
			 if(val2>0){
				 String strupdate2="update cm_srvcontrm set mcpcredit=1,docstatus='Bill settled' where tr_no="+docno+"";                                                     
				 //System.out.println("strupdate2--->>>"+strupdate2);                                 
				 val2=stmt.executeUpdate(strupdate2);    
			 }
			 if(val1>0 || val2>0){                 
				 String logdesc="Multiple Cash Payment created#"+dat+", Credit created#"+val2+" contract tr_no is passing here";                                     
   	        	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
				 //System.out.println(val+"====sqllog===="+sqllog);   
				 val1=stmt.executeUpdate(sqllog);  
			 }
			 if(val1>0){                 
		          conn.commit();       
		          conn.close();
			 }      
			 response.getWriter().print(val1+"###"+dat);                                  
 	stmt.close();  
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
