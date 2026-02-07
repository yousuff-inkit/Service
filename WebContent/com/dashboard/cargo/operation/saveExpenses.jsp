<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%	
ClsConnection ClsConnection=new ClsConnection();     
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection(); 
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();                      
		String expcash=request.getParameter("expcash")=="" || request.getParameter("expcash")==null?"0":request.getParameter("expcash");
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
		int vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?0:Integer.parseInt(request.getParameter("vocno"));
		String exparray=request.getParameter("exparray")=="" || request.getParameter("exparray")==null?"":request.getParameter("exparray");
  		int dat=0;          
		int val=0,temp=0,val1=0,val2=0,tranno=0; 
	//	System.out.println("exparray--->>>"+exparray+"==="+expcash+"===="+brhid+"===="+vocno+"==="+request.getParameterNames());
		             
			 ArrayList<String> creditarray=new ArrayList(); 
			 if (exparray.indexOf(",") != -1 || !"".equals(exparray)) {  
				 String temparray1[]=exparray.split(",");  
				 for(int i=0;i<temparray1.length;i++){
					 creditarray.add(temparray1[i]);      
				 }          
			 } else {
			 }       
			   
			 for(int i=0;i< creditarray.size();i++){    
						String[] pettycash=creditarray.get(i).split("::");                 
						if(!pettycash[1].trim().equalsIgnoreCase("undefined") && !pettycash[1].trim().equalsIgnoreCase("NaN")){
							 String costprice = pettycash[0].trim().equalsIgnoreCase("undefined") || pettycash[0].trim().equalsIgnoreCase("NaN") || pettycash[0].trim().equalsIgnoreCase("") || pettycash[0].trim().isEmpty()?"0.0":pettycash[0].trim().toString();
							 String srvdocno = pettycash[1].trim().equalsIgnoreCase("undefined") || pettycash[1].trim().equalsIgnoreCase("NaN") || pettycash[1].trim().equalsIgnoreCase("") || pettycash[1].trim().isEmpty()?"0":pettycash[1].trim().toString();
							 String amount = pettycash[2].trim().equalsIgnoreCase("undefined") || pettycash[2].trim().equalsIgnoreCase("NaN") || pettycash[2].trim().equalsIgnoreCase("") || pettycash[2].trim().isEmpty()?"0.0":pettycash[2].trim().toString();
							 String invno = pettycash[3].trim().equalsIgnoreCase("undefined") || pettycash[3].trim().equalsIgnoreCase("NaN") || pettycash[3].trim().equalsIgnoreCase("") || pettycash[3].trim().isEmpty()?"0":pettycash[3].trim().toString();
							 String invdate = pettycash[4].trim().equalsIgnoreCase("undefined") || pettycash[4].trim().equalsIgnoreCase("NaN") || pettycash[4].trim().equalsIgnoreCase("") || pettycash[4].trim().isEmpty()?"0":pettycash[4].trim().toString();     
							 String billing = pettycash[5].trim().equalsIgnoreCase("undefined") || pettycash[5].trim().equalsIgnoreCase("NaN") || pettycash[5].trim().equalsIgnoreCase("") || pettycash[5].trim().isEmpty()?"":pettycash[5].trim().toString();
							 String acno = pettycash[6].trim().equalsIgnoreCase("undefined") || pettycash[6].trim().equalsIgnoreCase("NaN") || pettycash[6].trim().equalsIgnoreCase("") || pettycash[6].trim().isEmpty()?"0":pettycash[6].trim().toString();
							 String type = pettycash[7].trim().equalsIgnoreCase("undefined") || pettycash[7].trim().equalsIgnoreCase("NaN") || pettycash[7].trim().equalsIgnoreCase("") || pettycash[7].trim().isEmpty()?"":pettycash[7].trim().toString();
							 String remarks = pettycash[8].trim().equalsIgnoreCase("undefined") || pettycash[8].trim().equalsIgnoreCase("NaN") || pettycash[8].trim().equalsIgnoreCase("") || pettycash[8].trim().isEmpty()?"":pettycash[8].trim().toString();
							 String vatper = pettycash[9].trim().equalsIgnoreCase("undefined") || pettycash[9].trim().equalsIgnoreCase("NaN") || pettycash[9].trim().equalsIgnoreCase("") || pettycash[9].trim().isEmpty()?"0.0":pettycash[9].trim().toString();
							 String vatamt = pettycash[10].trim().equalsIgnoreCase("undefined") || pettycash[10].trim().equalsIgnoreCase("NaN") || pettycash[10].trim().equalsIgnoreCase("") || pettycash[10].trim().isEmpty()?"0.0":pettycash[10].trim().toString();
							 String nettotal = pettycash[11].trim().equalsIgnoreCase("undefined") || pettycash[11].trim().equalsIgnoreCase("NaN") || pettycash[11].trim().equalsIgnoreCase("") || pettycash[11].trim().isEmpty()?"0.0":pettycash[11].trim().toString();
							 int rowno = pettycash[12].trim().equalsIgnoreCase("undefined") || pettycash[12].trim().equalsIgnoreCase("NaN") || pettycash[12].trim().equalsIgnoreCase("") || pettycash[12].trim().isEmpty()?0:Integer.parseInt(pettycash[12].trim().toString());       
							 java.sql.Date sqldate=null;
						     if(!invdate.equalsIgnoreCase("0")){          
						    	 sqldate=ClsCommon.changetstmptoSqlDate(invdate);           
						     } 
							 if(rowno>0){                      
								 //String sqlupdate="update cr_expense set costprice="+Double.parseDouble(costprice)+", srvdocno='"+srvdocno+"', amount="+Double.parseDouble(amount)+", invno='"+invno+"' , invdate='"+sqldate+"', billing='"+billing+"', acno='"+acno+"', type='"+type+"', remarks='"+remarks+"', vatper="+Double.parseDouble(vatper)+", vatamt="+Double.parseDouble(vatamt)+", nettotal="+Double.parseDouble(nettotal)+" where rowno="+rowno+"";                             
								 CallableStatement stmtexp= conn.prepareCall("update cr_expense set costprice=?, srvdocno=?, amount=?, invno=? , invdate=?, billing=? , acno=?, type=?, remarks=?, vatper=?, vatamt=? , nettotal=? where rowno=?");
								 stmtexp.setDouble(1, Double.parseDouble(costprice));
								 stmtexp.setString(2, srvdocno);
								 stmtexp.setDouble(3, Double.parseDouble(amount));
								 stmtexp.setString(4, invno);
								 stmtexp.setDate(5, sqldate);
								 stmtexp.setString(6, billing);
								 stmtexp.setString(7, acno);
								 stmtexp.setString(8, type);
								 stmtexp.setString(9, remarks);
								 stmtexp.setDouble(10, Double.parseDouble(vatper));
								 stmtexp.setDouble(11, Double.parseDouble(vatamt));
								 stmtexp.setDouble(12, Double.parseDouble(nettotal));
								 stmtexp.setInt(13, rowno);
								 System.out.println(val+"====sqlupdate===="+stmtexp);
								 stmtexp.executeUpdate();
								 //System.out.println(val+"====sqlupdate===="+sqlupdate);              
								 // stmt.executeUpdate(sqlupdate);         
							 }else{
								 String sqlinsert="insert into cr_expense(rdocno, srno, costprice, srvdocno, amount, invno, invdate, billing, acno, type, remarks, vatper, vatamt, nettotal) values ("+docno+", "+(i+1)+", "+Double.parseDouble(costprice)+",'"+srvdocno+"' ,"+Double.parseDouble(amount)+" ,'"+invno+"' ,'"+sqldate+"','"+billing+"','"+acno+"' ,'"+type+"' ,'"+remarks+"'  , "+Double.parseDouble(vatper)+","+Double.parseDouble(vatamt)+" ,"+Double.parseDouble(nettotal)+")";                             
								 CallableStatement stmtexp= conn.prepareCall("insert into cr_expense(rdocno, srno, costprice, srvdocno, amount, invno, invdate, billing, acno, type, remarks, vatper, vatamt, nettotal) values " 
										 +" (?, ?, ?, ? ,? ,? , ? ,?, ? , ? , ? , ?, ?, ? ) ");
								 stmtexp.setString(1, docno);
								 stmtexp.setInt(2, i+1);
								 stmtexp.setDouble(3, Double.parseDouble(costprice));
								 stmtexp.setString(4, srvdocno);
								 stmtexp.setDouble(5, Double.parseDouble(amount));
								 stmtexp.setString(6, invno);
								 stmtexp.setDate(7, sqldate);
								 stmtexp.setString(8, billing);
								 stmtexp.setString(9, acno);
								 stmtexp.setString(10, type);
								 stmtexp.setString(11, remarks);
								 stmtexp.setDouble(12, Double.parseDouble(vatper));
								 stmtexp.setDouble(13, Double.parseDouble(vatamt));
								 stmtexp.setDouble(14, Double.parseDouble(nettotal));
								 stmtexp.executeUpdate();
								 //System.out.println(val+"====sqlinsert===="+sqlinsert);              
								// val2=stmt.executeUpdate(sqlinsert);  
							 }
							                     
						}		      							
			  } 
			// if(val2>0){   
				 String strupdate2="update cm_srvcontrm set expense=1,docstatus='Job settled',expcashacno='"+expcash+"' where tr_no="+docno+"";                                                     
				 //System.out.println("strupdate2--->>>"+strupdate2);                                     
				 val2=stmt.executeUpdate(strupdate2);             
			 // }
			 // if(val2>0){                   
				 String logdesc="Expense Saved";                                        
   	        	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
				 //System.out.println(val+"====sqllog===="+sqllog);   
				 val1=stmt.executeUpdate(sqllog);  
			 // }
			 if(val1>0){                 
		          conn.commit();       
		          conn.close();
			 }      
			 response.getWriter().print(val1);                                         
 	stmt.close();  
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
