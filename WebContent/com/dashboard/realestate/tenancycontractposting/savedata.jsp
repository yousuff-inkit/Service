 
 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.project.execution.ServiceSale.*"%>
<%@page import="com.finance.transactions.cashreceipt.*"%>
<%@page import="com.finance.transactions.bankreceipt.*"%>
<%@page import="com.finance.transactions.journalvouchers.ClsJournalVouchersDAO"%>


<%@page import="com.dashboard.realestate.tenancycontractposting.ClsTenancyContractPostingDAO"%>
 
<%	
	String docno=request.getParameter("docno");
	String branchids=request.getParameter("branchids");
	String podate=request.getParameter("podate");
	
	
 
	String list=request.getParameter("listss")==null?"0":request.getParameter("listss");
	String list1=request.getParameter("listss1")==null?"0":request.getParameter("listss1");
	 System.out.println("==list="+list);
	 System.out.println("==list1="+list1);
	ClsJournalVouchersDAO journalVouchersDAO= new ClsJournalVouchersDAO();
	ClsServiceSaleDAO purchaseDAO= new ClsServiceSaleDAO(); 
	ClsCashReceiptDAO cashReceiptDAO=new ClsCashReceiptDAO();
	ClsBankReceiptDAO bankReceiptDAO=new ClsBankReceiptDAO();
	ClsTenancyContractPostingDAO save = new ClsTenancyContractPostingDAO();
	String refrowno="0";
	 Connection conn=null;
	 try{
		 ClsConnection ClsConnection =new ClsConnection();
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlprocessdate=null;

	 String upsql=null;
	 int val=0;
	 int id1=0;
	 int id2=0;
	 int id3=0;
 	conn = ClsConnection.getMyConnection();
 	conn.setAutoCommit(false);
 	
	Statement stmt = conn.createStatement ();
	int docval=0;
	
 
	 	 
			   int brhid=0,curId=1;
			   int cldocno=0,acno=0;
			   String atype="AR",desc1="",invdate="";
			   double taxper=0,rate=1;
			   int voc_no=0;
			  String remarks="";
			  
			  
			  int clacno=0;
			  int clcurId=1;
			  double clrate=1;
			  java.sql.Date cdate=null;
				java.sql.Date dates=null;
				
				
				

				   java.sql.Date podates=null;
				   
				   if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0")))
					{
					   cdate=ClsCommon.changeStringtoSqlDate(podate);
					   dates=ClsCommon.changeStringtoSqlDate(podate);
						
					}
					else{
		
					}
				
				
				String mastersql="  select  curdate() cudate,  m.brhid,date_format(m.date,'%d.%m.%Y') invdate,coalesce(t.per,0) per,m.voc_no,h.curid,h.rate, h.atype, "
						+ "   m.date,m.ttype,m.acno ,  m.cldocno,a.refname,concat(pm.name,'-',m.voc_no) description, m.prtype, m.Period, "
						+ "  m.Period_no, m.Period_from, m.Period_to, m.not_Period  "
						+ " from rl_tncm  m  left join rl_propertymaster pm on pm.doc_no=m.prtype "
						+ " left join my_acbook a on a.acno=m.acno left join my_head h on h.doc_no=m.acno   left join gl_taxmaster t on t.type=2 and per>0 and m.date between t.fromdate "
								+ "   and t.todate and a.tax=1 and m.ttype=2  where m.status=3 and m.doc_no='"+docno+"'";
						
						
						
						System.out.println("==mastersql="+mastersql);
						
				ResultSet rsmatersel=stmt.executeQuery(mastersql);
					if(rsmatersel.next())
					{
						
						brhid=rsmatersel.getInt("brhid");
						cldocno=rsmatersel.getInt("cldocno");
						voc_no=rsmatersel.getInt("voc_no");
						/* dates=rsmatersel.getDate("date");
						cdate=rsmatersel.getDate("cudate"); */
						taxper=rsmatersel.getDouble("per");
						
						desc1=rsmatersel.getString("description");
						 
						atype=rsmatersel.getString("atype");
						
						rate=rsmatersel.getDouble("rate");	
					 
						curId=rsmatersel.getInt("curid");	
						acno=rsmatersel.getInt("acno");	
						invdate=rsmatersel.getString("invdate");
						
						clacno=rsmatersel.getInt("acno");	
						clcurId=rsmatersel.getInt("curid");	
						clrate=rsmatersel.getDouble("rate");	
						
					 
						
						remarks=desc1;
					
					}
					
					
					if(clcurId==0){clcurId=1;	}
					if(clrate==0){clrate=1;	}
					
					
					  
					  upsql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+brhid+"','BTNC',now(),'"+session.getAttribute("USERID").toString()+"','A')";
					  System.out.println("==upsql="+upsql);
						 
						 int aaa= stmt.executeUpdate(upsql);	
					  
					  int owacno=0;
					  int owcurId=1;
					  double owrate=1;
					
				String sqlval="select  h.curid,h.rate, h.atype ,o.acno from rl_tncm  m   "
						+ "  left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner o on o.doc_no=pm.owid "
						+ "  left join my_head h on h.doc_no=o.acno  "
						+ " where m.status=3  and m.doc_no='"+docno+"' and pm.mgprpty=1  group by m.doc_no ";	
				System.out.println("==sqlval="+sqlval);
					ResultSet  rsmatersel1=stmt.executeQuery(sqlval);
					if(rsmatersel1.first())
					{
			 
						atype=rsmatersel1.getString("atype");
						
						rate=rsmatersel1.getInt("rate");	
					 
						curId=rsmatersel1.getInt("curid");	
						acno=rsmatersel1.getInt("acno");	
						
					}
					
					
					if(rate==0){rate=1;	}
					if(curId==0){curId=1;	}
					
					
					
					
					String sqlval1="select  h.curid,h.rate, h.atype ,o.acno from rl_tncm  m   "
							+ "  left join rl_propertymaster pm on pm.doc_no=m.prtype left join rl_propertryowner o on o.doc_no=pm.owid "
							+ "  left join my_head h on h.doc_no=o.acno  "
							+ " where m.status=3  and m.doc_no='"+docno+"'  group by m.doc_no ";	
					System.out.println("==sqlval1="+sqlval1);
						ResultSet  rsmatersel11=stmt.executeQuery(sqlval1);
						if(rsmatersel11.first())
						{
			
					
					owrate=rsmatersel11.getInt("rate");	
		 			owcurId=rsmatersel11.getInt("curid");	
			     owacno=rsmatersel11.getInt("acno");	
						}
					
						if(owcurId==0){owcurId=1;	}
						if(owrate==0){owrate=1;	}
						
					
					
					
					 String rem="temp";
			   session.setAttribute("BRANCHID", brhid);
				ArrayList<String> proday= new ArrayList<String>();
				String aa[]=list.split(",");
					for(int i=0;i<aa.length;i++){
						 String bb[]=aa[i].split("::");
						 String temp="";
						 for(int j=0;j<bb.length;j++){ 
							 temp=temp+bb[j]+"::";
						}
						 proday.add(temp);
					  } 
					
					
					ArrayList<String> proday1= new ArrayList<String>();
					String aa1[]=list1.split(",");
						for(int i1=0;i1<aa1.length;i1++){
							 String bb1[]=aa1[i1].split("::");
							 String temp1="";
							 for(int j1=0;j1<bb1.length;j1++){ 
								 temp1=temp1+bb1[j1]+"::";
							}
							 proday1.add(temp1);
						  } 
						
					
  
					ArrayList<String> masterarray= new ArrayList<String>();
					
					
				
					ArrayList<String> tarr= new ArrayList<String>();
					 

					
					for(int k1=0;k1<proday1.size();k1++)
					{
						String[] prod1=((String) proday1.get(k1)).split("::"); 
						 
						
			 
						 java.sql.Date mdate=null ;
						          
						      	System.out.println("==prod1[1]="+prod1[1]);
						 
						 mdate=ClsCommon.changeStringtoSqlDate(prod1[1]);
				 
						 
						 System.out.println("=prod1[10]="+prod1[10]);
						if(prod1[10].equalsIgnoreCase("111"))
						{	ArrayList<String> cashreceiptarray= new ArrayList<String>();
							 cashreceiptarray.add(prod1[7]+"::"+prod1[8]+"::"+prod1[9]+"::false::"+prod1[2]+"::"+prod1[0]+"::"+prod1[2]+"::0::0::0");
							 cashreceiptarray.add(clacno+"::"+clcurId+"::"+clrate+"::true::"+Double.parseDouble(prod1[2])*-1+"::"+prod1[0]+"::"+Double.parseDouble(prod1[2])*-1+"::0::0::0");
							//client	
							
 					int docnos=save.insert(conn,cdate,"CRV","",1.0,prod1[0],Double.parseDouble(prod1[2]),0.0,cashreceiptarray,tarr,session,request,"A");
							cashreceiptarray.clear();
							if(docnos<=0)
							{
								id1=1;
							}
							
							
							if(docnos>0)
							{
								String ssq11="update rl_tncpayment set refno="+request.getAttribute("tranno1").toString()+"  where doc_no="+prod1[11]+" ";
								
								System.out.println("=main 1="+ssq11);
								stmt.executeUpdate(ssq11);
							}
							
							
							
						}
						
						
					else if(prod1[10].equalsIgnoreCase("222"))
						{
							ArrayList<String> bankreceiptarray= new ArrayList<String>();
        
							 int chckpdc=0;
							 int no=0;
							 String sqlss=" select   DATEDIFF( '"+cdate+"','"+mdate+"') val     "  ;
							 System.out.println("==sqlss=="+sqlss);
							ResultSet rs111 = stmt.executeQuery(sqlss);
							if(rs111.next()) {
								no=rs111.getInt("val");
								} 
							 if(no<0)
							 {
								 chckpdc=1;
								 System.out.println("====="+chckpdc);
							 }

							 int pdcacno=0;
							 String sqlpdc=" select acno from my_account where codeno='PDCRV' "  ;
							 // System.out.println("==sqlss=="+sqlpdc);
							ResultSet rspdc = stmt.executeQuery(sqlpdc);
							if(rspdc.next()) {
							 	pdcacno=rspdc.getInt("acno");
							}
								bankreceiptarray.add(prod1[7]+"::"+prod1[8]+"::"+prod1[9]+"::false::"+Double.parseDouble(prod1[2])+"::"+prod1[0]+"::"+Double.parseDouble(prod1[2])+"::0::0::0::"+chckpdc+"::"+pdcacno);
								bankreceiptarray.add(clacno+"::"+clcurId+"::"+clrate+"::true::"+Double.parseDouble(prod1[2])*-1+"::"+prod1[0]+"::"+Double.parseDouble(prod1[2])*-1+"::"+0+"::0::0::"+chckpdc+"::"+pdcacno);
							 
							
						//	DOCDATE<CHQDATE THEN 1;
							
							
										int doc=bankReceiptDAO.insert(conn,cdate,"BRV","",1.0,mdate,prod1[4],"",chckpdc,prod1[0],Double.parseDouble(prod1[2]),clacno,0,bankreceiptarray,tarr,session,request,"A");
										
									
										/*   public int insert(Connection conn,Date bankReceiptDate, String formdetailcode, String txtrefno, double txtfromrate, Date chequeDate, String txtchequeno, 
												  String txtfromaccname,
												 int chckpdc, String txtdescription, double txtdrtotal, int txttodocno, double txtapplyinvoiceapply, ArrayList<String> bankreceiptarray,
												 ArrayList<String> applyinvoicearray, HttpSession session,HttpServletRequest request,String mode) throws SQLException { */
										bankreceiptarray.clear();
										
										if(doc<=0)
										{
											id2=1;
										}		 
							if(doc>0)
							{
								String ssq111="update rl_tncpayment set refno="+request.getAttribute("tranno").toString()+"  where doc_no="+prod1[11]+" ";
								
								System.out.println("=main 2="+ssq111);
								
								stmt.executeUpdate(ssq111);
							}
							
							
							
						}
					  			else if(prod1[10].equalsIgnoreCase("333"))
						{
							ArrayList<String> labarray= new ArrayList<String>();
							
							 
							//System.out.println("------lbrtotalcost--"+lbrtotalcost);
						 
							labarray.add(owacno+"::"+prod1[0]+"::"+session.getAttribute("CURRENCYID").toString()+"::"+owrate+"::"+prod1[2]
									+"::"+Double.parseDouble(prod1[2])*owrate+"::"+"1"+"::"+"1"+"::0::0::");;
							
							 
				 	
							 labarray.add(clacno+"::"+prod1[0]+"::"+session.getAttribute("CURRENCYID").toString()+"::"+clrate+"::"+Double.parseDouble(prod1[2])*-1
										+"::"+Double.parseDouble(prod1[2])*clrate*-1+"::"+"1"+"::"+"-1"+"::0::0::");
							
							//System.out.println("------------"+labarray);
					
						Double garrageval=Double.parseDouble(prod1[2])*-1;
						
			
					int jvmdoc=save.insertjv(conn,cdate,"TNC",""+docno,desc1,garrageval,garrageval,labarray,session,request);
					if(jvmdoc<=0)
					{
						id3=1;
					}
					if(jvmdoc>0)
					{
						String ssq1111="update rl_tncpayment set refno="+request.getAttribute("tranno2").toString()+"  where doc_no="+prod1[11]+" ";
						System.out.println("=main 3="+ssq1111);
						stmt.executeUpdate(ssq1111);
						 
					}
					
							
							
						}  
						
								 
								 
 
					}
					
					
					for(int k=0;k<proday.size();k++)
					{
						String[] prod=((String) proday.get(k)).split("::"); 
						System.out.println("== proday.get(k)="+ proday.get(k));
 
		 
						
						if(prod[8].equalsIgnoreCase("102"))
						{
							
						
							
							masterarray.add((k+1)+"::"+1+" :: "+prod[0]+" :: "
									 +prod[2]+" :: "+prod[2]+" :: "+0+" :: "+prod[2]+" :: "
									 +0+" :: "+0+" :: "+prod[5]+" :: "+prod[2]+" :: "
									 +0+" :: "+0+"  :: "+rem+" :: "+prod[7]+" :: "+aa+" :: ");
							
							int acnoss=0;
							Statement stm=conn.createStatement();
							String sql="select acno from my_account where codeno='COMEXP' ";
							System.out.println("==sql="+sql);
							
							ResultSet rss12=stm.executeQuery(sql);
							
							
							if(rss12.first())
							{
								acnoss=rss12.getInt("acno");
							}
							 
							
							if(acnoss>0)
							{
								
							 
								
								masterarray.add((k+1)+"::"+1+" :: "+prod[0]+" :: "
										 +Double.parseDouble(prod[2])*-1+" :: "+Double.parseDouble(prod[2])*-1+" :: "+0+" :: "+Double.parseDouble(prod[2])*-1+" :: "
										 +0+" :: "+0+" :: "+Double.parseDouble(prod[5])*-1+" :: "+prod[2]+" :: "
										 +0+" :: "+0+" :: "+rem+" :: "+acnoss+" :: "+aa+" :: ");
								
							}
							
							
						}
						else
						{
							masterarray.add((k+1)+"::"+prod[1]+" :: "+prod[0]+" :: "
									 +prod[2]+" :: "+prod[2]+" :: "+0+" :: "+prod[2]+" :: "
									 +prod[3]+" :: "+prod[4]+" :: "+prod[5]+" :: "+prod[2]+" :: "
									 +0+" :: "+0+" :: "+remarks+" :: "+prod[7]+" :: "+aa+" :: ");
						}
						
								 
								 
 
					}
					
					double nettotal=0;
					String sqls="select sum(amount)  amount from rl_tncterms where rdocno='"+docno+"' ";
					
					System.out.println("=====sqls==="+sqls);
					
					ResultSet ty=stmt.executeQuery(sqls);
					if(ty.first())
					{
						nettotal=ty.getDouble("amount");
					}
					
					
					
					
					
					int res=save.insert(conn,dates,dates,""+0,""+0,atype,""+acno,"",""+curId,""+rate,"","",desc1,session,"A",nettotal,masterarray,"SRS", 
							 request,dates,""+voc_no,invdate,0,taxper);
					
					
					 
					
					
					if(res>0  && id1==0 && id2==0 && id3==0)
					{
					
					String ssq="delete from  my_srvsaled where rdocno="+res+" and remarks='temp'";
					System.out.println("==ssq="+ssq);
					stmt.executeUpdate(ssq);
					 
					
					
					String ssq1="update rl_tncm set pstatus="+res+"  where doc_no="+docno+" ";
					System.out.println("==ssq1="+ssq1);
					stmt.executeUpdate(ssq1);
					 conn.commit();
					 response.getWriter().print(res);
					 	stmt.close();
					 	conn.close();
					}
					
					
	 
			 
		
						 
					  
			   
		   
	 		
		
	 	  
	 }

	 catch(Exception e){
		 response.getWriter().print(0);
	 	 conn.close();
	 	 e.printStackTrace();
	 		}
	 
	 
	 
		

	
	%>
