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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
int resultSet4 =0;
String list=request.getParameter("list")==null?"0":request.getParameter("list");
String list1=request.getParameter("list1")==null?"0":request.getParameter("list1");




String duedate=request.getParameter("duedate")==null?"0":request.getParameter("duedate");
 
String dates=request.getParameter("date")==null?"0":request.getParameter("date");
String masterdocno=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
String branchvals=request.getParameter("branchvals")==null?"0":request.getParameter("branchvals");
String refnos=request.getParameter("refnos")==null?"0":request.getParameter("refnos");
String description=request.getParameter("description")==null?"0":request.getParameter("description");
String locationid=request.getParameter("locationid")==null?"1":request.getParameter("locationid");

/*   System.out.println("===list====="+list);
  System.out.println("===list1====="+list1);

System.out.println("===dates====="+dates);
System.out.println("===masterdocno====="+masterdocno);
System.out.println("===branchvals====="+branchvals);
System.out.println("===refnos====="+refnos);
System.out.println("===description====="+description);
System.out.println("===locationid====="+locationid);  */ 

ArrayList<String> mainarray= new ArrayList<String>();
String aa[]=list.split(",");

java.sql.Date date=ClsCommon.changeStringtoSqlDate(dates);

java.sql.Date duedate1=ClsCommon.changeStringtoSqlDate(duedate);


 
String doc="0"; 

int cmbbilltype=1;



for(int k=0;k<aa.length;k++){
	 
	 String bb[]=aa[k].split("::");
	  
	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
		 
	 
		 temp=temp+bb[j]+"::";
		 
	}
	 mainarray.add(temp);
	 
} 

ArrayList<String> mainarray1= new ArrayList<String>();
String aa1[]=list1.split(",");



for(int k1=0;k1<aa1.length;k1++){
	
	
 
	 String bb1[]=aa1[k1].split("::");
	  
	 String temp1="";
	 for(int j1=0;j1<bb1.length;j1++){ 
		 
	 
		 temp1=temp1+bb1[j1]+"::";
		 
	}
	 mainarray1.add(temp1);
	 
} 




	  Connection conn=null;
	    String sql="";
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
	 
		
		
	    Statement st=conn.createStatement();
	    
	    int acnom=0;
	    int curr=1;
	    int clientid=0;
	    double currate=0;
	    String ordsql="select  acno,cldocno,curid,rate from my_sorderm where doc_no="+masterdocno+" ";
	  //  System.out.println("===ordsql====="+ordsql);
	    ResultSet rss=st.executeQuery(ordsql);
	    
	    if(rss.next())
	    {
	    	clientid=rss.getInt("cldocno");
	    	curr=rss.getInt("curid");
	    	acnom=rss.getInt("acno");
	    	currate=rss.getInt("rate");
	    }
	    
	    
	    
	    
	    
	    int tempval=0;
	    	 
	    		
		
		
		int sodocno=0;
		int tranid=0;
		 
         String modepay="credit";
 
			
			if(modepay.equalsIgnoreCase("cash")){
				tranid=1;
			}
			else if(modepay.equalsIgnoreCase("credit")){
				tranid=2;
			}

			conn.setAutoCommit(false);

			CallableStatement stmt = conn.prepareCall("{CALL saleInvoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(28, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(29, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(30, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refnos);
			stmt.setInt(3, clientid);
			stmt.setInt(4, curr);
			stmt.setDouble(5, currate);
			stmt.setInt(6, 0);
			stmt.setString(7,"SOR"); 
			stmt.setString(8,masterdocno);
			stmt.setString(9,null);
			stmt.setString(10,description);
			stmt.setDouble(11,0);
			stmt.setDouble(12,0);
			stmt.setDouble(13,0);
			stmt.setString(14,"A");
			stmt.setString(15,"INV");
			stmt.setString(16, session.getAttribute("USERID").toString());
			stmt.setString(17, branchvals);
			stmt.setString(18, session.getAttribute("COMPANYID").toString());
			stmt.setDouble(19, 0);
			stmt.setDouble(20, 0);
			stmt.setDouble(21, 0);
			stmt.setDouble(22, 0);
			stmt.setInt(23,0);
			stmt.setDate(24,duedate1);
			stmt.setString(25,locationid);
			stmt.setInt(26,tranid);
			int val = stmt.executeUpdate();
			sodocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			int claccno=stmt.getInt("tmpacno");
			request.setAttribute("vdocNo", vocno);
		  System.out.println("===sodocno====="+sodocno+"====");
	

		
		if(vocno>0)
		{
			
			
			  int prvdocno=0;
			 int stacno=0;
			 int stacno1=0;
			 int tax1acno=0;
			 int tax2acno=0;
			 int tax3acno=0;
			 
			 int taxmethod=1;
			 
			 Statement stmtss=conn.createStatement();
			  if(taxmethod>0)
			  {
				 
			
			
				  Statement pv=conn.createStatement();
					
					String dd="select prvdocno from my_brch where doc_no="+branchvals+" ";
					
				//	System.out.println("=======dd========"+dd);
					
					
					ResultSet rs13=pv.executeQuery(dd); 
					if(rs13.next())
					{

						prvdocno=rs13.getInt("prvdocno");
					}
					//System.out.println("======prvdocno========"+prvdocno);

					 
				 
					Statement ssss10=conn.createStatement();
					  
		 
					  String sql10="  select acno,value from gl_taxmaster where   fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and provid='"+prvdocno+"'   "
									+ "  and status=3 and type=2 and provid='"+prvdocno+"' and  if(1="+cmbbilltype+",per,cstper)>0  " ;
									 
									// System.out.println("====sql10========"+sql10);
									 
									 int mm=0;
								
									 ResultSet rstaxxx101=ssss10.executeQuery(sql10); 
									 while(rstaxxx101.next())
									 {
										 if(mm==0)
										 {
										 stacno=rstaxxx101.getInt("acno");
										 }

										 if(mm==1)
										 {
											 stacno1=rstaxxx101.getInt("acno");
										 } 
										 mm=mm+1;
																 	
									 	
									 }

		
				  
				   
				  
				  	Statement ssss=conn.createStatement();
			  
					 String sql100=" select s.acno,s.value "
							 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
							 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"'  ) "
							 		+ "  and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"'  " ;
			//	System.out.println("=====sql======"+sql100);
					 ResultSet rstaxxx=ssss.executeQuery(sql100); 
					 if(rstaxxx.next())
					 {
						 String typeoftax="0";
						 tax1acno=rstaxxx.getInt("acno");
						 	typeoftax=rstaxxx.getString("value");
						 
						 String sqltax11= " update my_invm set typeoftax='"+typeoftax+"'    where doc_no='"+sodocno+"' ";
							  
							  //System.out.println("======sqltax11========="+sqltax11);
							  
							  stmtss.executeUpdate(sqltax11);						 	
					 	
					 }

					  	Statement ssss1=conn.createStatement();
				  
						 String sql166=" select s.acno"
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and seqno=2 and provid='"+prvdocno+"'  ) and status=3 and type=2 and seqno=2 and provid='"+prvdocno+"'  " ;
					
						 ResultSet rstaxxx1=ssss1.executeQuery(sql166); 
						 if(rstaxxx1.next())
						 {
							 
							 tax2acno=rstaxxx1.getInt("acno");
													 	
						 	
						 }
			  
							Statement ssss3=conn.createStatement();
							  
							 String sql311=" select s.acno "
									 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
									 +"  fromdate<='"+date+"' and todate>='"+date+"' and status=3 and type=2 and seqno=3 and provid='"+prvdocno+"'  ) and status=3 and type=2 and seqno=3 and provid='"+prvdocno+"'  " ;
						
							 ResultSet rstaxxx3=ssss3.executeQuery(sql311); 
							 if(rstaxxx3.next())
							 {
								 
								 tax3acno=rstaxxx3.getInt("acno");
														 	
							 	
							 }
				  
			  
			  
			  }
			 
					  int sal_id=0;
				String sqlsss9111111="select coalesce(sal_id,0) sal_id   from my_acbook where cldocno="+clientid+" and dtype='CRM' ";
				 
				ResultSet rss911111=stmt.executeQuery(sqlsss9111111);
				if(rss911111.next())
				{
					sal_id=rss911111.getInt("sal_id");
				}
			  if(sal_id>0)
			  {
				  String sqlupdate1="update my_invm set sal_id='"+sal_id+"'  where doc_no="+sodocno+" ";
				  
				  stmt.executeUpdate(sqlupdate1);
				  
			  }
		
						
						//	 System.out.println("===mainarray==="+mainarray);
								
				              Statement stmt1=conn.createStatement();
						int result=0;
						for(int i=0;i<mainarray.size();i++)
						{
							
					 
							
						//	System.out.println("===mainarray=== size ==================================================================*********=="+mainarray.size());
							
						
							String[] prod=((String) mainarray.get(i)).split("::");
							
							int temp=0;
				
							
							String rowno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String qtys=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
							String focs=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double qty=Double.parseDouble(qtys);
							double foc=Double.parseDouble(focs);
							
							int tr_no=0;int  prdId=0;int  orddocno=0;int  psrno=0;String  batch_no="";Date  exp_date=null;
							double totqty=0;double out_qty=0;double totfoc=0;double out_foc=0;
							int  SpecNo=0;int  stockid=0;int  unitid=0; 
							 double disper=0; double discount=0;
							
							
							
							
							String unitprice=""+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].trim().equalsIgnoreCase("")|| prod[3].isEmpty()?0:prod[3].trim())+"";
							String nettotal=""+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].trim().equalsIgnoreCase("")|| prod[4].isEmpty()?0:prod[4].trim())+"";
							
							String taxper=""+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].trim().equalsIgnoreCase("")|| prod[5].isEmpty()?0:prod[5].trim())+"";
							String taxamount=""+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].trim().equalsIgnoreCase("")|| prod[6].isEmpty()?0:prod[6].trim())+"";
							
							
							String taxperamt=""+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].trim().equalsIgnoreCase("")|| prod[7].isEmpty()?0:prod[7].trim())+"";
							 
							
							 
							
							
							
						 
							
							
							String  ordsqls="select tr_no, psrno,unitid , SpecNo   from my_sorderd   where doc_no="+rowno+"   ";
				 
							
							//System.out.println("===ordsqls====="+ordsqls);
							
							
							ResultSet ar=st.executeQuery(ordsqls);
							
							
							if(ar.next())
							{
								
								psrno=ar.getInt("psrno");
								SpecNo=ar.getInt("SpecNo");
				 
								unitid=ar.getInt("unitid");
								tr_no=ar.getInt("tr_no");
	 
								 
								
							}
							
							
						    
						     double fr=1;
						     String slss=" select fr from my_unit where psrno="+psrno+" and unit='"+unitid+"' ";
						     
						 //    System.out.println("====slss==="+slss);
						     ResultSet rv1=stmt.executeQuery(slss);
						     if(rv1.next())
						     {
						    	 fr=rv1.getDouble("fr"); 
						     }
				    	 
					
						

							
							
							
							
						 
							String sqlsss="insert into my_invd(tr_no,sr_no,rdocno,StockId,SpecNo,  psrno, prdId,unitid, qty, fr,  amount, total, disper, discount,  nettotal, foc, ref_row,taxper,taxamount,nettaxamount)VALUES"
									+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
									+ "'0' ,"
									+ "'"+SpecNo+"',"
									+ "'"+psrno+"',"
									+ "'"+psrno+"',"
									+ "'"+unitid+"',"
									+ "'"+qty+"',"
									+ "'"+fr+"',"
							 		+ "'"+unitprice+"',"
									+ "'"+nettotal+"',"
									+ "'"+disper+"',"
									+ "'"+discount+"',"
									+ "'"+nettotal+"','"+foc+"' ,"+rowno+","+taxper+","+taxperamt+","+taxamount+")";
				
							//  System.out.println("sqlsss--->>>>Sql"+sqlsss);
							int ss= stmt1.executeUpdate (sqlsss);
							 
						 
							
							
								String sqls="update my_sorderd set out_qty=out_qty+"+qty+",out_foc=out_foc+"+foc+" where doc_no="+rowno+" ";	
								// System.out.println("=====my_sorderddet---"+sqls);
				
								stmt1.executeUpdate(sqls);	
							 
				
			 
								
								int locid=0;
								double rsv_qty=0;
								double rsv_qty1=0;
								double op_qty=0;
								double qtyout=0;
								double prdoutqty=0;
								double prdout_qty=0;
								double saveqty=0;
								double stkqty=0,masterqty=0,remqty=0;
								 masterqty=(qty+foc)*fr;
								
								 	System.out.println("=======masterqty======"+masterqty);
								
								Statement stmtstk=conn.createStatement();
								
								
								
				
								//String stkSql="select batch_no,exp_date,locid,stockid,psrno,specno,sum(op_qty) stkqty,rsv_qty,sum(out_qty+del_qty) out_qty,out_qty qtyout  from my_prddin  where   stockid="+stockid+" and brhid="+branchvals+" ";
				
							//	System.out.println("=1111111111111111111111   1stkSql=inside insert="+stkSql);
							
							
			 
									 
									 
										String sqlssss="select pin.locid,d.rsv_qty-coalesce(d.rsvout_qty,0)  rsv_qty,pin.stockid,pin.op_qty ,(pin.out_qty+pin.del_qty) out_qty from my_sorderst d "
												 +" inner join my_prddin pin on pin.stockid=d.stockid  "
												 +" where d.psrno="+psrno+"  and d.tr_no="+tr_no+"  and    (d.rsv_qty-coalesce(d.rsvout_qty,0))>0 and pin.rsv_qty>0   ";
									 
												
			  				System.out.println("============="+sqlssss);
								ResultSet rsstk = stmtstk.executeQuery(sqlssss);
				
								while(rsstk.next()) {
									
									   								
								 
							 
									rsv_qty=rsstk.getDouble("rsv_qty");
																	
									prdout_qty=rsstk.getDouble("out_qty");
							 
									stockid=rsstk.getInt("stockid");
									locid=rsstk.getInt("locid");
									
									
									 if(remqty>0)
									 {
										 masterqty=remqty;
									 }
									 
									 
									
									if(masterqty<=rsv_qty)
									{
										remqty=0;
										op_qty=-1;
										
										
										
										 
									}
									
									else if(masterqty>rsv_qty)
									{
										remqty=masterqty-rsv_qty;
										masterqty=rsv_qty;
										 
										
										
									}
									
							 
									
									 
									
								
								 
								//	System.out.println("---masterqty-----"+masterqty);
									
								 
								  
				
				
											Statement stmtstk12=conn.createStatement();
										
										String sql2s="update my_prddin set out_qty=out_qty+"+masterqty+",rsv_qty=rsv_qty-"+masterqty+"   where stockid="+stockid+" ";
									 //	System.out.println("--1---my_prddin---"+sql2s);
										stmtstk12.executeUpdate(sql2s);
										
										
										
										
										
										
									
						 
										 
										 
				
				 
				 
				 
									String prodoutsql="";
				                    
									String cost_prices="0";
				
									Statement stmtstk1=conn.createStatement();
				
									String stkSql1="select  cost_price  from my_prddin where stockid='"+stockid+"'";
				
									System.out.println("=stkSql1 select cost_price insert="+stkSql1);
				
									ResultSet rsstk1 = stmtstk1.executeQuery(stkSql1);
				
									if(rsstk1.next()) {
										cost_prices=rsstk1.getString("cost_price");
									}
									
				 
										
										
										 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,rsv_qty,prdid,brhid,locid,unit_price,cost_price) Values"
												+ " ("+(i+1)+",'"+trno+"','INV',"+sodocno+","
												+ "'"+stockid+"',"
												+ "'"+date+"',"
												+ "'"+SpecNo+"',"
												+ "'"+psrno+"',"
												+ "'"+masterqty+"',"
												+ "'"+(masterqty*-1)+"',"
												+ "'"+psrno+"',"
												+"'"+branchvals+"','"+locid+"',"+unitprice+",'"+cost_prices+"')";
										 
											  System.out.println("== =========prodoutsql==OUT============="+prodoutsql);
										int df= stmt1.executeUpdate(prodoutsql);
										
										 
										String sql2s11="update my_sorderst set rsvout_qty=rsvout_qty+"+masterqty+"     where stockid="+stockid+" and psrno="+psrno+"  and tr_no="+tr_no+"   ";
									 	System.out.println("--1---my_sorderst---"+sql2s11);
										stmtstk12.executeUpdate(sql2s11);	
										 
										 
									
										 if(op_qty<0)
										 {
											 break;
										 }
									
								}
							
								if(remqty>0)
								 {
									result=1;
									break;
									
								 }
								
							//	System.out.println("== =========br==============");
							 
							
								
							
						}
						
						
						
						for(int i=0;i< mainarray1.size();i++){

							 
							

							String[] shiparrays=((String) mainarray1.get(i)).split("::");

					 

							 if(!(shiparrays[0].trim().equalsIgnoreCase("undefined")|| shiparrays[0].trim().equalsIgnoreCase("NaN")||shiparrays[0].trim().equalsIgnoreCase("")|| shiparrays[0].isEmpty()))
						     {


								String shipsql="insert into my_deldetaild (rdocno,shipdetid,refno,desc1,brhid,status,dtype)VALUES"
										+ " ('"+sodocno+"','"+0+"',"
										+ "'"+(shiparrays[0].trim().equalsIgnoreCase("undefined") || shiparrays[0].trim().equalsIgnoreCase("") || shiparrays[0].trim().equalsIgnoreCase("NaN")|| shiparrays[0].isEmpty()?0:shiparrays[0].trim())+"',"
										+ "'"+(shiparrays[1].trim().equalsIgnoreCase("undefined") || shiparrays[1].trim().equalsIgnoreCase("") || shiparrays[1].trim().equalsIgnoreCase("NaN")|| shiparrays[1].isEmpty()?0:shiparrays[1].trim())+"',"
									   + "'"+session.getAttribute("BRANCHID").toString()+"',"
										+ "'3',"
										+ "'INV')";


						 	System.out.println("shipsql--->>>>Sql"+shipsql);
							int	retdoc = stmt.executeUpdate(shipsql);
								
								 if(retdoc<=0)
									{
										conn.close();
										 
										
									}

							}
						}
						
				 
						
						
						
						
	 
					 
				if(tempval==0)	
				{
					  	
					double finalamount=0,taxper=0,taxper1=0,taxper2=0;
					
					java.sql.Date masterdate=date;
					
					double stss=0;
					double producttotal=0;
					
					Statement sts=conn.createStatement();
					
					
					String sqlsval="select sum(total) total,sum(discount) discount,sum(nettotal) nettotal, sum(taxamount) totalamts  from my_invd where  rdocno="+sodocno+" ";
					
					ResultSet rsstl=sts.executeQuery(sqlsval);
					
					if(rsstl.next())
					{
						  finalamount=rsstl.getDouble("nettotal");
						String sql2s="update my_invm set amount="+rsstl.getDouble("total")+",netamount="+rsstl.getDouble("nettotal")+",grantamt="+rsstl.getDouble("nettotal")+" where  doc_no="+sodocno+"     ";
						
						//System.out.println("---- my_invm -sql2s----"+sql2s) ;
						stmt1.executeUpdate(sql2s);  
						stss=rsstl.getDouble("totalamts");
						producttotal=rsstl.getDouble("nettotal");
					}
					
					
					 
						 
						 String sqlssss=" select value,case when 1="+cmbbilltype+"   then s.per when  2="+cmbbilltype+"  then s.cstper else 0 end as  'taxper' ,  s.tax_name,s.per,s.cstper "
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"' ) " 
								  + " and status=3 and type=2 and seqno=1 and provid='"+prvdocno+"'  " ;
						 
						 
						 
						 
						// System.out.println("=====sqlssss====="+sqlssss);
						 
						 
						 ResultSet rs1=stmt.executeQuery(sqlssss); 
						 if(rs1.next())
						 {
							  
							 
							 taxper=rs1.getDouble("taxper");
							 val=rs1.getInt("value");
						 	
						 	
						 }
					
						 
						 String sqls=" select case when 1="+cmbbilltype+"   then s.per when  2="+cmbbilltype+"  then s.cstper else 0 end as  'taxper' ,  s.tax_name,s.per,s.cstper "
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=2 and seqno=2 and provid='"+prvdocno+"' )  " 
								  +" and status=3 and type=2 and seqno=2 and provid='"+prvdocno+"' " ;
						 
						// System.out.println("=====sqls====="+sqls);
						 
						 ResultSet rs2=stmt.executeQuery(sqls); 
						 if(rs2.next())
						 {
							 
							 taxper1=rs2.getDouble("taxper"); 
							 
						 	
						 	
						 }
					
						 
						 String sqlss=" select case when 1="+cmbbilltype+"   then s.per when  2="+cmbbilltype+"  then s.cstper else 0 end as  'taxper' ,  s.tax_name,s.per,s.cstper "
								 +" from  gl_taxsubmaster s where s.doc_no=(select max(doc_no) tdocno from gl_taxsubmaster  where "
								 +"  fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and status=3 and type=2 and seqno=3 and provid='"+prvdocno+"' )  " 
								  +" and status=3 and type=2 and seqno=3 and provid='"+prvdocno+"' " ;
						 
						// System.out.println("=====sqlss====="+sqlss);
						 
						 ResultSet rs21=stmt.executeQuery(sqlss); 
						 if(rs21.next())
						 {
							 
							 taxper2=rs21.getDouble("taxper");
							 
						 	
						 	
						 }
					
						double tax1=taxper;
						double tax2=taxper1;
						
						double tax3=taxper2;
						
						int typeoftaken=val;
						 
						 
						double tax1val=0;
						double tax2val=0;
						double tax3val=0;
						double finaltax=0;
						
						if(typeoftaken==-1)
							{
							if(tax1>0)
								{
								tax1val=producttotal*(tax1/100);
								
								
								if(tax2>0)
								{
								tax2val=tax1val*(tax2/100);
								}
								else
									{
									tax2val=0;
									}
								
								
										if(tax3>0)
										{
											tax3val=tax2val*(tax3/100);
										}
										else
											{
											tax3val=0;
											}
								
								
								
								
								finaltax=stss+tax1val+tax2val+tax3val;
								
								
								
								}
							}
							
							else {
								
								if(tax1>0)
								{
								tax1val=stss*(tax1/100);
								if(tax2>0)
								{
								tax2val=tax1val*(tax2/100);
								}
								else
									{
									tax2val=0;
									}
								

								if(tax3>0)
								{
									tax3val=tax2val*(tax3/100);
								}
								else
									{
									tax3val=0;
									}
						
						
						
								
								finaltax=stss+tax1val+tax2val+tax3val;
								
			 
								
								
								}
							}
						tax1=0;	tax2=0;tax3=0;
						double stval=stss;
						  tax1=tax1val;
						  tax2=tax2val;
						  tax3=tax3val;
						double nettax=finaltax;
						
						
							
								String sqltax1= " update my_invm set totaltax='"+stval+"',tax1='0',tax2='0',tax3='0',"
								  		+ "nettotaltax='"+stval+"' ,billtype='"+cmbbilltype+"'   where doc_no='"+sodocno+"' ";
								  
								 // System.out.println("======sqltax1========="+sqltax1);
								  
								  stmtss.executeUpdate(sqltax1);
							
					
					
					
					
					 
							
						
						
						
						
								String descs="Sales INV-"+""+vocno+""+":-Dated :- "+date; 
						
								String refdetails="INV"+""+vocno;
						
				
				
				//===--------------==1
				
									int	clientaccount=claccno;
							
							
							
									String vendorcur="1"; 
									double venrate=1;
									
									if(modepay.equalsIgnoreCase("cash")){
										
									String sql29="select  acno from my_account where codeno='CASHACSALES' ";
							//	System.out.println("-----4--sql2----"+sql29) ;
							
									ResultSet tass19 = stmt.executeQuery (sql29);
							
									if (tass19.next()) {
							
										clientaccount=tass19.getInt("acno");		
							
									}
									}
									
							
									String sqls10="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
									//System.out.println("---1----sqls10----"+sqls10) ;
									ResultSet tass11 = stmt.executeQuery (sqls10);
									if(tass11.next()) {
							
										vendorcur=tass11.getString("curid");	
							
							
									}
							
							
									String currencytype="";
									String sqlvenselect = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
											+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
								//	 System.out.println("-----2--sqlvenselect----"+sqlvenselect) ;
									ResultSet resultSet33 = stmt.executeQuery(sqlvenselect);
							
									while (resultSet33.next()) {
										venrate=resultSet33.getDouble("rate");
										currencytype=resultSet33.getString("type");
									}
							
									double	dramount=finalamount; 
							
							
									double ldramount=0;
									if(currencytype.equalsIgnoreCase("D"))
									{
							
							
										ldramount=dramount/venrate ;  
									}
							
									else
									{
										ldramount=dramount*venrate ;  
									}
							
							
							
									String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramount+","+ldramount+",0,1,4,0,0,'"+clientid+"','"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
							
									 	System.out.println("--sql1- client---"+sql1);
									int ss = stmt.executeUpdate(sql1);
							
									if(ss<=0)
									{
										conn.close();
										 
							
									}
									
									
									
									int acnos1=0;
									String curris1="1";
									double rates1=1;
							
									String sql21="";
									if(modepay.equalsIgnoreCase("credit")){
										 sql21="select  acno from my_account where codeno='SALESCR' ";
									}
									if(modepay.equalsIgnoreCase("cash")){
										 sql21="select  acno from my_account where codeno='SALESCH' ";
									}
									
									//System.out.println("-----4--sql21----"+sql21) ;
							
									ResultSet tass111 = stmt.executeQuery (sql21);
							
									if (tass111.next()) {
							
										acnos1=tass111.getInt("acno");		
							
									}
							
							
							
									String sqls31="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos1+"'";
									//System.out.println("-----5--sqls31----"+sqls31) ;
									ResultSet tass31 = stmt.executeQuery (sqls31);
							
									if (tass31.next()) {
							
										curris1=tass31.getString("curid");	
							
							
									}
									String currencytype11="";
									String sqlveh1 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
											+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris1+"'";
									//System.out.println("-----6--sqlveh1----"+sqlveh1) ;
									ResultSet resultSet441 = stmt.executeQuery(sqlveh1);
							
									while (resultSet441.next()) {
										rates1=resultSet441.getDouble("rate");
										currencytype11=resultSet441.getString("type");
									} 
							
									double pricetottal1=(finalamount*-1);
									double ldramounts1=0 ;     
									if(currencytype11.equalsIgnoreCase("D"))
									{
							
										ldramounts1=pricetottal1/venrate ;  
									}
							
									else
									{
										ldramounts1=pricetottal1*venrate ;  
									}
							
									String sql111="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos1+"','"+descs+"','"+curris1+"','"+rates1+"',"+pricetottal1+","+ldramounts1+",0,-1,4,0,0,0,'"+rates1+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
							
							
									//  System.out.println("---sql11 credit----"+sql111) ; 
							
									int ss11 = stmt.executeUpdate(sql111);
							
									if(ss11<=0)
									{
										conn.close();
										 
							
									}
									
									
									String totalcostval="0";
									String s="select sum(a.totalvals) totalvals,a.tr_no from (select cost_price*qty totalvals,tr_no from my_prddout where  tr_no="+trno+" group by doc_no) a group by a.tr_no ";
							
								//	System.out.println("-totalvalsssssssssssssssssssssssssss----"+s) ;
							
									ResultSet tcosts = stmt.executeQuery (s);
							
									if (tcosts.next()) {
							
										totalcostval=tcosts.getString("totalvals");		
							
									}
							
							
									
									
									//=====4
									int acnos=0;
									String curris="1";
									double rates=1;
							
							
							
									String sql2="select  acno from my_account where codeno='STOCK ACCOUNT' ";
									//System.out.println("-----4--sql2----"+sql2) ;
							
									ResultSet tass1 = stmt.executeQuery (sql2);
							
									if (tass1.next()) {
							
										acnos=tass1.getInt("acno");		
							
									}
							
							
							
									String sqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos+"'";
									//System.out.println("-----5--sqls3----"+sqls3) ;
									ResultSet tass3 = stmt.executeQuery (sqls3);
							
									if (tass3.next()) {
							
										curris=tass3.getString("curid");	
							
							
									}
									String currencytype1="";
									String sqlveh = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
											+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris+"'";
									//System.out.println("-----6--sqlveh----"+sqlveh) ;
									ResultSet resultSet44 = stmt.executeQuery(sqlveh);
							
									while (resultSet44.next()) {
										rates=resultSet44.getDouble("rate");
										currencytype1=resultSet44.getString("type");
									} 
							
									double pricetottal=Double.parseDouble(totalcostval)*-1;
									double ldramounts=0 ;     
									if(currencytype1.equalsIgnoreCase("D"))
									{
							
										ldramounts=pricetottal/venrate ;  
									}
							
									else
									{
										ldramounts=pricetottal*venrate ;  
									}
							
									String sql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos+"','"+descs+"','"+curris+"','"+rates+"',"+pricetottal+","+ldramounts+",0,-1,4,0,0,0,'"+rates+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
							
							
									// System.out.println("---Stock----"+sql11) ; 
							
									int ss1 = stmt.executeUpdate(sql11);
							
									if(ss1<=0)
									{
										conn.close();
										 
							
									}
							//==5
									int acnos2=0;
									String curris2="1";
									double rates2=1;
							
							
							
									String sql22="select  acno from my_account where codeno='COST OF GOODS SOLD' ";
									//System.out.println("-----4--sql22----"+sql22) ;
							
									ResultSet tass12 = stmt.executeQuery (sql22);
							
									if (tass12.next()) {
							
										acnos2=tass12.getInt("acno");		
							
									}
							
							
							
									String sqls32="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+acnos2+"'";
									//System.out.println("-----5--sqls32----"+sqls32) ;
									ResultSet tass312 = stmt.executeQuery (sqls32);
							
									if (tass312.next()) {
							
										curris2=tass312.getString("curid");	
							
							
									}
									String currencytype12="";
									String sqlveh12 = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
											+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+curris2+"'";
									//System.out.println("-----6--sqlveh12----"+sqlveh12) ;
									ResultSet resultSet442 = stmt.executeQuery(sqlveh12);
							
									while (resultSet442.next()) {
										rates2=resultSet442.getDouble("rate");
										currencytype12=resultSet442.getString("type");
									} 
							
									double pricetottal2=Double.parseDouble(totalcostval);
									double ldramounts2=0 ;     
									if(currencytype12.equalsIgnoreCase("D"))
									{
							
										ldramounts2=pricetottal2/venrate ;  
									}
							
									else
									{
										ldramounts2=pricetottal2*venrate ;  
									}
							
									String sql112="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
											+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+acnos2+"','"+descs+"','"+curris2+"','"+rates2+"',"+pricetottal2+","+ldramounts2+",0,1,4,0,0,0,'"+rates2+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
							
							
									// System.out.println("---Goods sold----"+sql112) ; 
							
									int ss12 = stmt.executeUpdate(sql112);
							
									if(ss12<=0)
									{
										conn.close();
										 
							
									}
									taxmethod=1;
							
									
							 
										
								    	 double taxtotals=0;
								    	 
								    	 
								    	 String sqlsss="select sum(taxamount) taxamount  from my_invd where rdocno= "+sodocno+" ";
											
								    	 ResultSet mrs= stmt.executeQuery (sqlsss);
								    	 if(mrs.next())
								    	 {
								    		 
								    		 taxtotals=mrs.getDouble("taxamount");
								    		 
								    	 }
								    		 
								    		 
								    	 nettax=taxtotals;
								    	 stval=taxtotals;
											
										
										
										
										
										//client part

										String ggg="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+clientaccount+"'";
										//System.out.println("---1----sqls10----"+sqls10) ;
										ResultSet tax1sql = stmt.executeQuery (ggg);
										if(tax1sql.next()) {

											vendorcur=tax1sql.getString("curid");	


										}

					     
										String taxcurrencytype1="";
										String dddd = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
												+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
										 System.out.println("-----2--dddd----"+dddd) ;
										ResultSet resultSet = stmt.executeQuery(dddd);

										while (resultSet.next()) {
											venrate=resultSet.getDouble("rate");
											taxcurrencytype1=resultSet.getString("type");
										}

										double	dramounts=nettax; 


										double ldramountss=0;
										if(taxcurrencytype1.equalsIgnoreCase("D"))
										{


											ldramountss=dramounts/venrate ;  
										}

										else
										{
											ldramountss=dramounts*venrate ;  
										}

										String sqlss111="update   my_jvtran set  dramount=dramount+"+dramounts+",ldramount=ldramount+"+ldramountss+" where tr_no="+trno+" and acno="+clientaccount+"   ";
										 int ss1111 = stmt.executeUpdate(sqlss111);


									/* 	String rdse="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
												+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+clientaccount+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramounts+","+ldramountss+",0,1,4,0,0,'"+clientid+"','"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

										//	System.out.println("--sql1----"+sql1);
										int ss1111 = stmt.executeUpdate(rdse);

										if(ss1111<=0)
										{
											conn.close();
											 

										} */
										
										
										
										
										
										
										
										
										// total tax amount  int stacno=0;
										int divdval=1;
										if(stacno1>0)
										{
											divdval=2;
										}
										
										
										
										
										
										
										
										// total tax amount  int stacno=0;
										//System.out.println("=========================stacno===================================="+stacno);
										
										
										String lll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno+"'";
										//System.out.println("---1----sqls10----"+sqls10) ;
										ResultSet t1sql1 = stmt.executeQuery(lll);
										if(t1sql1.next()) {

											vendorcur=t1sql1.getString("curid");	


										}

					     
										String taxcurre="";
										String ppp = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
												+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
										// System.out.println("-----2--ppp----"+ppp) ;
										ResultSet r1 = stmt.executeQuery(ppp);

										while (r1.next()) {
											venrate=r1.getDouble("rate");
											taxcurre=r1.getString("type");
										}

										double	dramt=(stval/divdval)*-1; 


										double ldramt=0;
										if(taxcurre.equalsIgnoreCase("D"))
										{


											ldramt=dramt/venrate;  
										}

										else
										{
											ldramt=dramt*venrate;  
										}



										String sltax11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
												+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+stacno+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramt+","+ldramt+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

										//	System.out.println("--sql1----"+sql1);
										int aa111 = stmt.executeUpdate(sltax11);

										if(aa111<=0)
										{
											conn.close();
										 

										}
										
										
										
										// tax1acno tax 1

										
										// total tax amount  int stacno1=0;
										//stacno1
										
										
										 
										
									//	System.out.println("=========================stacno1===================================="+stacno1);
										
										if(stacno1>0)
										{
											
											
											
											String sslll="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+stacno1+"'";
											//System.out.println("---1----sqls10----"+sqls10) ;
											ResultSet sst1sql1 = stmt.executeQuery(sslll);
											if(sst1sql1.next()) {

												vendorcur=sst1sql1.getString("curid");	


											}

						     
											String taxcurress="";
											String pppss = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
													+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+vendorcur+"'";
											// System.out.println("-----2--pppss----"+pppss) ;
											ResultSet r1ss = stmt.executeQuery(pppss);

											while (r1ss.next()) {
												venrate=r1ss.getDouble("rate");
												taxcurress=r1ss.getString("type");
											}

											double	dramtss=(stval/divdval)*-1; 


											double ldramtss=0;
											if(taxcurress.equalsIgnoreCase("D"))
											{


												ldramtss=dramtss/venrate;  
											}

											else
											{
												ldramtss=dramtss*venrate;  
											}



											String sltax11ss="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
													+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+stacno1+"','"+descs+"','"+vendorcur+"','"+venrate+"',"+dramtss+","+ldramtss+",0,-1,4,0,0,0,'"+venrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";

											//	System.out.println("--sql1----"+sql1);
											int aass = stmt.executeUpdate(sltax11ss);

											if(aass<=0)
											{
												conn.close();
												 

											}
											
											
											
											
											
											
											
										}
									
							 
									
									
									double jvdramount=0;
									int id=0;
									int adjustacno=0;
							
									String adjustcurrid="1";
							
							
									double adjustcurrate=1;
							
									String jvselect="SELECT sum(dramount) dramount from my_jvtran where tr_no='"+trno+"'";
									//System.out.println("-----5--sqls3----"+sqls3) ;
									ResultSet jvrs = stmt.executeQuery (jvselect);
							
									if (jvrs.next()) {
							
										jvdramount=jvrs.getDouble("dramount");	
							
							
									}
									System.out.println("--jvdramount----"+jvdramount) ;
									if(jvdramount>0 || jvdramount<0)
									{
							
										//System.out.println("--iiiiiiiinnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn---") ;
										if(jvdramount>0)
										{
											id=1;
							
							
										}
							
										else
										{
							
											id=-1;
										}
							
							
							
							
										String sqls2="select  acno from my_account where codeno='STOCK ADJUSTMENT ACCOUNT' ";
									// System.out.println("---STOCK ADJUSTMENT ACCO--4--sql22----"+sql2) ;
							
										ResultSet adjaccount = stmt.executeQuery (sqls2);
							
										if (adjaccount.next()) {
							
											adjustacno=adjaccount.getInt("acno");		
							
										}
							
							
							
										String expsqls3="select h.curid,round(c.c_rate,2) rate from my_head h left join my_curr c on c.doc_no=h.curid where h.doc_no='"+adjustacno+"'";
										//System.out.println("-----5--sqls3----"+sqls3) ;
										ResultSet exptass3 = stmt.executeQuery (expsqls3);
							
										if (exptass3.next()) {
							
											adjustcurrid=exptass3.getString("curid");	
							
							
										}
										String adjustcurrencytype1="";
										String adjustsql = "select a.rate,a.type from my_curbook a inner join (select max(cb.doc_no) doc_no,cb.curid curid,cb.toDate,cb.frmDate from my_curbook cb "
												+"where  coalesce(toDate,curdate())>='"+date+"' and frmDate<='"+date+"' group by cb.curid) as b on(a.doc_no=b.doc_no and a.curid=b.curid) where a.curid='"+adjustcurrid+"'";
									//	System.out.println("---adjustsql----"+adjustsql) ;
										ResultSet resultadj = stmt.executeQuery(adjustsql);
							
										while (resultadj.next()) {
											adjustcurrate=resultadj.getDouble("rate");
											adjustcurrencytype1=resultadj.getString("type");
										} 
							
							
										double adjustldramounts=0 ;     
										if(adjustcurrencytype1.equalsIgnoreCase("D"))
										{
							
											adjustldramounts=jvdramount/adjustcurrate ;  
										}
							
										else
										{
											adjustldramounts=jvdramount*adjustcurrate ;  
										}
							
							
							
							
							
										String adjustsql11="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
												+ "values('"+date+"','"+refdetails+"',"+sodocno+",'"+adjustacno+"','"+descs+"','"+adjustcurrid+"','"+adjustcurrate+"',"+jvdramount+","+adjustldramounts+",0,'"+id+"',4,0,0,0,'"+adjustcurrate+"',0,0,'INV','"+session.getAttribute("BRANCHID").toString()+"',"+trno+",3)";
							
							
										// System.out.println("---sql11----"+sql11) ; 
							
										int result1 = stmt.executeUpdate(adjustsql11);
							
										if(result1<=0)
										{
											conn.close();
										 
							
										}
							
							
									}
				   }			
						
				
						String sqlss="update my_jvtran set duedate='"+duedate1+"' where tr_no="+trno+"";
						stmt.executeUpdate(sqlss);
						String jvselect111="delete  from my_jvtran where tr_no='"+trno+"' and dramount=0 ";
						
						stmt.executeUpdate(jvselect111);
						
						String ssss=" update my_jvtran set dramount=round(dramount,2),ldramount=round(ldramount,2) where tr_no='"+trno+"' ";
					    System.out.println("=========sqlsss91====99999======="+ssss);
						stmt.executeUpdate(ssss);
						
						String sqlsss91="select sum(dramount) dramount from my_jvtran where tr_no='"+trno+"' group by  tr_no having  sum(dramount)!=0 ";
						System.out.println("=========sqlsss91==========="+sqlsss91);
						ResultSet rss91=stmt.executeQuery(sqlsss91);
						if(rss91.next())
						{
							result=1;
							System.out.println("=========dramount!=0===========");
						}
				
						if(vocno>0 && tempval==0){
 
							if(result==0)
							{ 
							 response.getWriter().print(vocno);
							//stmt.close();
						     conn.commit();
							  }
							else
							{
								response.getWriter().print(0);
							}  
							conn.close();
						}
						 
						 
						 
					
				   
		}			
	
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().print(0);
    }
	 	
	 	
	 	
%>



 