<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %> 

<%	
	Connection conn = null;
	try{
		ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();
		ClsJournalVouchersDAO JVDAO= new ClsJournalVouchersDAO();   
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO=new ClsCommon();
	 	conn = connDAO.getMyConnection();
	 	conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		String sql4="",sql ="",sql1="",invno="",invdate="",description="",prodtype="",sql2="",cldocno="",refname="",clacno="",taxamt="",sql3="",outacno="",sql7="";
		int val=0,billtype=0,tax=0,costtype=0,costcode=0,value=0,rowno=0;   
		double amount=0.0,vndtotal=0.0,total=0.0;
		ResultSet rs =null;    
		ResultSet rd =null;
		ResultSet rg =null;
		ResultSet rf =null;
		ResultSet rq =null;
		java.sql.Date fdate=null;
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");  
		java.util.Date curDate=new java.util.Date();
		java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));        
		java.sql.Date docdate=null;
		String jvdesc=request.getParameter("jvdesc")==null?"":request.getParameter("jvdesc").toString();
		String cashacno=request.getParameter("expcash")==null || request.getParameter("expcash")==""?"0":request.getParameter("expcash").toString();
		String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"":request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"":request.getParameter("brhid").toString();
		int vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?0:Integer.parseInt(request.getParameter("vocno"));
		int jobvndchk=request.getParameter("jobvndchk")=="" || request.getParameter("jobvndchk")==null?0:Integer.parseInt(request.getParameter("jobvndchk"));
		session.setAttribute("BRANCHID",brhid); 
		ArrayList<String> gridarray=new ArrayList<String>();
		ArrayList<String> vndarray=new ArrayList<String>();
		ArrayList<String> journalvouchersarray=new ArrayList<String>();
		sql2="select acno from cr_expense where rdocno="+docno+" and acno!=0 and type in('CREDIT','CASH-VAT') group by acno";
		//System.out.println("sql2vendor fetch========"+sql2);   
		 rd= stmt1.executeQuery(sql2);
		 while(rd.next()) {
			 vndarray.add(rd.getString("acno"));        
		 }   
		 //System.out.println("vndarray========"+vndarray);   
		for(int j=0;j<vndarray.size();j++){
			 vndtotal=0;
			 String vnd=vndarray.get(j);
			 gridarray= new ArrayList();
			 sql1="select coalesce(d.rowno,0) rowno,1 qty,d.costprice unitprice,coalesce(ac.cldocno,0) cldocno,coalesce(ac.refname,0) refname,coalesce(ac.acno,0) acno,'' costtype,s.exacno glacno,'' costcode,d.vatper tax,d.vatamt taxamt,d.remarks description,d.nettotal total,d.amount,d.invno,d.invdate from cr_expense d left join cr_srvtype s on d.srvdocno=s.doc_no left join my_acbook ac on d.acno=ac.acno and ac.dtype='VND' where d.rdocno="+docno+" and d.acno="+vnd;
			 //System.out.println("sql1vendordetail========"+sql1);     
			 rs= stmt.executeQuery(sql1);
			 while(rs.next()) {  
				rowno=rs.getInt("rowno");    
				invno=rs.getString("invno");
				invdate=rs.getString("invdate");  
				fdate=rs.getDate("invdate");
				amount=rs.getDouble("amount");  
				total=rs.getDouble("total");
				description=rs.getString("description");   
				tax=rs.getInt("tax");
				costtype=rs.getInt("costtype");
				costcode=rs.getInt("costcode");
				cldocno=rs.getString("cldocno");
				refname=rs.getString("refname");
				clacno=rs.getString("acno");
				taxamt=rs.getString("taxamt");
				outacno=rs.getString("glacno");
				gridarray.add(1+"::"+rs.getString("qty")+" :: "+description+" :: "+rs.getString("unitprice")+" :: "+amount+" :: "+0+" :: "+amount+" :: "+taxamt+" :: "+costtype+" :: "+costcode+" :: "+description+" :: "+rs.getString("glacno")+" :: "+""+" :: "+tax+" :: "+taxamt+" :: "+rs.getString("total")+" :: ");
				vndtotal=vndtotal+total; 	   													
			} 
		    if(tax>0){
				prodtype="1";
				billtype=1;
				//System.out.println("billtype====="+billtype);   
			}
			if(!(docno.equalsIgnoreCase(""))){
				//value=viewDAO.insert(fdate, fdate, "DIR", 0, "AP", clacno, refname, "1", "1", "", "", "", session, "A", vndtotal, gridarray, "CPU", request, fdate, invno,invdate, 1, 1, billtype, prodtype);
				
				value=viewDAO.insert(cdate, cdate, "DIR", 0, "AP", clacno, refname, "1", "1", "", "", "", session, "A", vndtotal, gridarray, "CPU", request, cdate, invno,invdate, 1,  0.0, vndtotal, 1);         

//System.out.println("value========="+value);   	   
			    if (value>0){   
					 sql1 = "update cm_srvcontrm set expcpu=1,docstatus='Job settled' where tr_no="+docno+"";                        
				     val= stmt.executeUpdate(sql1);                 
				        
				     sql4 = "update cr_expense set cpudocno="+value+" where rowno="+rowno+"";      
				     val= stmt.executeUpdate(sql4);           
				     
				     String logdesc="Ni Purchase created#"+value+"";                                     
	   	        	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
					 //System.out.println(val+"====sqllog===="+sqllog);   
					 stmt.executeUpdate(sqllog); 
					 
				}
			  }	 
		   }      
		 
		    Double cmaount=0.0,baseamt=0.0,advamount=0.0,expval=0.0,hramt=0.0,payamt=0.0;       
		    String desc="",advacno="0",acno="0",type="",expacno="0",payacno="0";    
		    int trnno=0,account=0,id=0,typeid=0,hrtypeid=0,paytypeid=0;
		    rowno=0;   
		    //sql1="select (select acno from my_account where codeno='PAYABLE ACCOUNT') payacno,coalesce(s.exacno,0) exacno,d.type,coalesce(bd.acno,0) cashacno,coalesce(bd.amount*-1,0) advamount,(select acno from my_account where codeno='JOBADVANCE') advacno,coalesce(d.rowno,0) rowno,coalesce(d.acno,0) acno,d.remarks description,coalesce(d.nettotal,0) total from cr_expense d left join cm_srvcontrm sm on sm.tr_no=d.rdocno left join my_cashbd bd on (bd.tr_no=sm.cpvtrno and bd.acno!=(select acno from my_account where codeno='JOBADVANCE')) left join cr_srvtype s on s.doc_no=d.srvdocno where d.rdocno="+docno+"  and d.type in('CASH-VAT','CASH','PAYABLE','HR') order by d.type";	  
			sql1="select (select acno from my_account where codeno='PAYABLE ACCOUNT') payacno,coalesce(s.exacno,0) exacno,d.type,coalesce(bd.totalamount,0) advamount,(select acno from my_account where codeno='JOBADVANCE') advacno,coalesce(d.rowno,0) rowno,coalesce(d.acno,0) acno,d.remarks description,coalesce(d.nettotal,0) total from cr_expense d left join cm_srvcontrm sm on sm.tr_no=d.rdocno left join my_cashbm bd on (bd.tr_no=sm.cpvtrno) left join cr_srvtype s on s.doc_no=d.srvdocno where d.rdocno="+docno+"  and d.type in('CASH-VAT','CASH','PAYABLE','HR') order by d.type";  
		    //System.out.println("sql1vendordetail========"+sql1);     
			rg= stmt.executeQuery(sql1);
			while(rg.next()) {
						type=rg.getString("type");  
						rowno=rg.getInt("rowno");    
						//cashacno=rg.getString("cashacno");
						expacno=rg.getString("exacno");
						payacno=rg.getString("payacno");
						advamount=rg.getDouble("advamount");          
						advacno=rg.getString("advacno");
						acno=rg.getString("acno");  
						baseamt=rg.getDouble("total");
						description=rg.getString("description");                   
						if(type.equalsIgnoreCase("CASH-VAT")){
							if(baseamt<0){
								baseamt=baseamt*-1;
							}
							if(baseamt!=0){
								journalvouchersarray.add(acno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+baseamt+" :: "+baseamt+" ::"+ 2 +" :: "+1+" ::  4 :: "+docno+"  :: ");
							}
							expval=expval+baseamt; 
							typeid=1;
						}
						if(type.equalsIgnoreCase("CASH")){
							if(baseamt<0){
								baseamt=baseamt*-1;
							}
							if(baseamt!=0){
								journalvouchersarray.add(expacno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+baseamt+" :: "+baseamt+" ::"+ 2 +" :: "+1+" ::  4 :: "+docno+"  :: ");
							}
							expval=expval+baseamt;  
							typeid=1;      
						}
						if(type.equalsIgnoreCase("HR")){   
							hramt=baseamt;  
							if(hramt!=0){
								journalvouchersarray.add(acno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+hramt*-1+" :: "+hramt*-1+" ::"+ 2 +" :: "+1*-1+" ::  4 :: "+docno+"  :: ");
								journalvouchersarray.add(expacno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+hramt+" :: "+hramt+" ::"+ 2 +" :: "+1+" :: 4 :: "+docno+"  :: ");
							}
							hrtypeid=2;      
						}
						if(type.equalsIgnoreCase("PAYABLE")){       
							payamt=baseamt; 
							if(payamt!=0){      
								journalvouchersarray.add(payacno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+payamt*-1+" :: "+payamt*-1+" ::"+ 2 +" :: "+1*-1+" ::  4 :: "+docno+"  :: ");
								journalvouchersarray.add(expacno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+payamt+" :: "+payamt+" ::"+ 2 +" :: "+1+" ::  4 :: "+docno+"  :: ");
							}
							paytypeid=3;               
						}
							cmaount=cmaount+baseamt; 
					}
		            if(typeid==1){ 
		            	if(jobvndchk==1){
		            		advamount=0.0;    
		            	}else{
		            		if(advamount>0){     
								advamount=advamount*-1;
							} 
			            	if(advamount!=0){
			            		journalvouchersarray.add(advacno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+advamount+" :: "+advamount+" ::"+ 2 +" :: "+1*-1+" :: 4 :: "+docno+" :: ");
			            	}	
		            	}
						expval=expval+advamount; 
						
					    if(expval!=0){     	
			                  //if(expval>0){     
							    expval=expval*-1;          
							 // }  
							 journalvouchersarray.add(cashacno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+expval+" :: "+expval+" ::"+ 2 +" :: "+(expval>0?1:-1)+" :: 4 :: "+docno+" :: ");
					    }
				     }  
		           /*  if(hrtypeid==2){
		            	if(hramt<0){     
		            		hramt=hramt*-1;
						} 
		            	cmaount=cmaount+hramt; 
						journalvouchersarray.add(expacno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+hramt+" :: "+hramt+" ::"+ 2 +" :: "+1+" :: "+""+" :: "+""+" :: ");
		            }
		            if(paytypeid==3){            
		            	if(payamt<0){     
		            		payamt=payamt*-1;
						} 
		            	cmaount=cmaount+payamt; 
						journalvouchersarray.add(expacno+" :: "+description+" :: "+ 1 +" :: "+ 1 +" :: "+payamt+" :: "+payamt+" ::"+ 2 +" :: "+1+" :: "+""+" :: "+""+" :: ");
		            } */
		      System.out.println("journalvouchersarray====="+journalvouchersarray);     
			  if(journalvouchersarray.size()>0){       
				int trno=JVDAO.insert(cdate,"JVT-27", vocno+"", desc, cmaount, cmaount, journalvouchersarray, session, request);          
				if(trno>0){                                      
					trnno=Integer.parseInt(request.getAttribute("tranno").toString());
					String strsql="update cm_srvcontrm set expjvtrno='"+trnno+"',docstatus='Job settled' where tr_no='"+docno+"'";                      	                         
					//System.out.println("====="+strsql);  
					val=stmt.executeUpdate(strsql); 
				}
				if(val>0){          
					 String logdesc="JV created Tr_no#"+trnno+"";                                          
			      	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
					 //System.out.println(val+"====sqllog===="+sqllog);     
					 value=stmt.executeUpdate(sqllog);    
				} 
			}        
		 
		 if(value>0){                   
	          conn.commit();       
	          conn.close();
		 }  
		//System.out.println("value========="+value);           	 
		response.getWriter().print(value);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  