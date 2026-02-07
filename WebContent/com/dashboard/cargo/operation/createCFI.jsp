<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%@page import="com.cargo.costingforinvoicing.ClsCostingForInvoicingDAO" %>                               
<%	
ClsConnection ClsConnection=new ClsConnection();     
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();            
		Statement stmt = conn.createStatement();   
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		int docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?0:Integer.parseInt(request.getParameter("docno").trim().toString());
		int vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?0:Integer.parseInt(request.getParameter("vocno").trim().toString());
		String date=request.getParameter("date")=="" || request.getParameter("date")==null?"0":request.getParameter("date");
		String gridarray=request.getParameter("gridarray")=="" || request.getParameter("gridarray")==null?"0":request.getParameter("gridarray");
		String revnuearray=request.getParameter("revnuearray")=="" || request.getParameter("revnuearray")==null?"0":request.getParameter("revnuearray");
		int dat=0,cfidocno=0;              
		int val=0,temp=0,val1=0,tranno=0;     
		ClsCostingForInvoicingDAO DAO =new  ClsCostingForInvoicingDAO();                                   
			 ArrayList<String> cparray= new ArrayList<String>();
		     java.sql.Date sqlrefdate=null;
		     java.sql.Date sqldate=null;
		     if(!date.equalsIgnoreCase("0")){          
		    	 sqldate=ClsCommon.changetstmptoSqlDate(date);       
		     }   
		     ArrayList<String> newarray=new ArrayList(); 
		     if (gridarray.indexOf(",") != -1 || !"".equals(gridarray)) {                    
		    	 String temparray[]=gridarray.split(",");              
				 for(int i=0;i<temparray.length;i++){
						newarray.add(temparray[i]);
				 }
			 } else {
			 }
		     ArrayList<String> revarray=new ArrayList(); 
		     if (revnuearray.indexOf(",") != -1 || !"".equals(revnuearray)) {                    
		    	 String temparray1[]=revnuearray.split(",");              
				 for(int i=0;i<temparray1.length;i++){   
					 revarray.add(temparray1[i]);    
				 }
			 } else {
			 }  
			 session.setAttribute("BRANCHID",brhid);  
			 for(int i=0;i< revarray.size();i++){    
					String[] pettycash=revarray.get(i).split("::");                       
					if(!pettycash[5].trim().equalsIgnoreCase("undefined") && !pettycash[5].trim().equalsIgnoreCase("NaN")){
						 int rowno = pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().equalsIgnoreCase("") || pettycash[0].trim().isEmpty()?0:Integer.parseInt(pettycash[0].trim().toString());
						 String tobebilled = pettycash[1].trim().equalsIgnoreCase("undefined") || pettycash[1].trim().equalsIgnoreCase("NaN") || pettycash[1].trim().equalsIgnoreCase("") || pettycash[1].trim().isEmpty()?"0.0":pettycash[1].trim().toString();
						 String vatper = pettycash[2].trim().equalsIgnoreCase("undefined") || pettycash[2].trim().equalsIgnoreCase("NaN") || pettycash[2].trim().equalsIgnoreCase("") || pettycash[2].trim().isEmpty()?"0.0":pettycash[2].trim().toString();
						 String vatamt = pettycash[3].trim().equalsIgnoreCase("undefined") || pettycash[3].trim().equalsIgnoreCase("NaN") || pettycash[3].trim().equalsIgnoreCase("") || pettycash[3].trim().isEmpty()?"0.0":pettycash[3].trim().toString();
						 String nettotal = pettycash[4].trim().equalsIgnoreCase("undefined") || pettycash[4].trim().equalsIgnoreCase("NaN") || pettycash[4].trim().equalsIgnoreCase("") || pettycash[4].trim().isEmpty()?"0.0":pettycash[4].trim().toString();
						 String srvdocno = pettycash[5].trim().equalsIgnoreCase("undefined") || pettycash[5].trim().equalsIgnoreCase("NaN") || pettycash[5].trim().equalsIgnoreCase("") || pettycash[5].trim().isEmpty()?"0":pettycash[5].trim().toString();
						 String curid = pettycash[6].trim().equalsIgnoreCase("undefined") || pettycash[6].trim().equalsIgnoreCase("NaN") || pettycash[6].trim().equalsIgnoreCase("") || pettycash[6].trim().isEmpty()?"0":pettycash[6].trim().toString();
						 String rate = pettycash[7].trim().equalsIgnoreCase("undefined") || pettycash[7].trim().equalsIgnoreCase("NaN") || pettycash[7].trim().equalsIgnoreCase("") || pettycash[7].trim().isEmpty()?"0.0":pettycash[7].trim().toString();
						 String price = pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().isEmpty()?"0.0":pettycash[8].trim().toString();
						 String qty = pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().equalsIgnoreCase("") || pettycash[9].trim().isEmpty()?"0.0":pettycash[9].trim().toString();
						 String uom = pettycash[10].trim().equalsIgnoreCase("undefined") || pettycash[10].trim().equalsIgnoreCase("NaN") || pettycash[10].trim().equalsIgnoreCase("") || pettycash[10].trim().isEmpty()?"0":pettycash[10].trim().toString();
						 String total = pettycash[11].trim().equalsIgnoreCase("undefined") || pettycash[11].trim().equalsIgnoreCase("NaN") || pettycash[11].trim().equalsIgnoreCase("") || pettycash[11].trim().isEmpty()?"0.0":pettycash[11].trim().toString();
						 String basetotal = pettycash[12].trim().equalsIgnoreCase("undefined") || pettycash[12].trim().equalsIgnoreCase("NaN") || pettycash[12].trim().equalsIgnoreCase("") || pettycash[12].trim().isEmpty()?"0.0":pettycash[12].trim().toString();
						 String billing = pettycash[13].trim().equalsIgnoreCase("undefined") || pettycash[13].trim().equalsIgnoreCase("NaN") || pettycash[13].trim().equalsIgnoreCase("") || pettycash[13].trim().isEmpty()?"":pettycash[13].trim().toString();
						 String rdocno = pettycash[14].trim().equalsIgnoreCase("undefined") || pettycash[14].trim().equalsIgnoreCase("NaN") || pettycash[14].trim().equalsIgnoreCase("") || pettycash[14].trim().isEmpty()?"0":pettycash[14].trim().toString();
						 String refdocno = pettycash[15].trim().equalsIgnoreCase("undefined") || pettycash[15].trim().equalsIgnoreCase("NaN") || pettycash[15].trim().equalsIgnoreCase("") || pettycash[15].trim().isEmpty()?"0":pettycash[15].trim().toString();
						 if(rowno>0){
							 String sqlupdate="update cr_qotjobd set  tobebilled="+Double.parseDouble(tobebilled)+", vatper="+Double.parseDouble(vatper)+", vatamt="+Double.parseDouble(vatamt)+", nettotal="+Double.parseDouble(nettotal)+" where doc_no="+rowno+"";                             
							 //System.out.println(val+"====sqlupdate===="+sqlupdate);         
							 dat=stmt.executeUpdate(sqlupdate);        
						 }else{
							 String sqlinsert="insert into cr_qotjobd(jobno, refdocno, rdocno, typeid, curid, rate, price, qty, uom, total, btotal, billing, tobebilled, vatper, vatamt, nettotal, rev) values('"+docno+"','"+refdocno+"','"+rdocno+"','"+srvdocno+"','"+curid+"',"+Double.parseDouble(rate)+","+Double.parseDouble(price)+",'"+qty+"','"+uom+"',"+Double.parseDouble(total)+","+Double.parseDouble(basetotal)+",'"+billing+"',"+Double.parseDouble(tobebilled)+","+Double.parseDouble(vatper)+","+Double.parseDouble(vatamt)+","+Double.parseDouble(nettotal)+",1)";                             
							 //System.out.println(val+"====sqlinsert===="+sqlinsert);             
							 dat=stmt.executeUpdate(sqlinsert); 
						 }
						                                     
					}	   	   							
		         } 
			 String strcountvnd="select coalesce(cfidocno,0) cfidocno from cm_srvcontrm where tr_no="+docno+"";       
			 ResultSet rs5=stmt.executeQuery(strcountvnd);                                 
			 while(rs5.next()){     
				 cfidocno=rs5.getInt("cfidocno");   
			 } 
			 if(cfidocno>0){                          
				 dat=DAO.saveData( cfidocno, docno, vocno, sqldate, "E", "CFI", "", vocno+"", session, request, newarray, 0, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
			 }else{
				 dat=DAO.saveData( 0, docno, vocno, sqldate, "A", "CFI", "", vocno+"", session, request, newarray, 0, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
			 }
			 //System.out.println("val--->>>"+dat); 
			 String logdesc="";   
			 if(dat>0){
				 if(cfidocno==0){      
					 String strupdate="update cm_srvcontrm set cfidocno="+dat+",docstatus='Job settled' where tr_no="+docno+"";                                           
					 //System.out.println("strupdate--->>>"+strupdate);                                  
					 val1=stmt.executeUpdate(strupdate);
					 logdesc="CFI Created#"+dat+""; 
				 }else{
					 logdesc="CFI Edited#"+cfidocno+""; 
				 }
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
