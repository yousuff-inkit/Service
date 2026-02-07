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

 
String dates=request.getParameter("date")==null?"0":request.getParameter("date");
String masterdocno=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
String branchvals=request.getParameter("branchvals")==null?"0":request.getParameter("branchvals");
String refnos=request.getParameter("refnos")==null?"0":request.getParameter("refnos");
String description=request.getParameter("description")==null?"0":request.getParameter("description");
String locationid=request.getParameter("locationid")==null?"1":request.getParameter("locationid");

/* System.out.println("===list====="+list);


System.out.println("===dates====="+dates);
System.out.println("===masterdocno====="+masterdocno);
System.out.println("===branchvals====="+branchvals);
System.out.println("===refnos====="+refnos);
System.out.println("===description====="+description);
System.out.println("===locationid====="+locationid); */

ArrayList<String> mainarray= new ArrayList<String>();
String aa[]=list.split(",");

java.sql.Date date=ClsCommon.changeStringtoSqlDate(dates);
 
String doc="0"; 




for(int k=0;k<aa.length;k++){
	 
	 String bb[]=aa[k].split("::");
	  
	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
		 
	 
		 temp=temp+bb[j]+"::";
		 
	}
	 mainarray.add(temp);
	 
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
			stmt.setDate(24,null);
			stmt.setString(25,locationid);
			stmt.setInt(26,tranid);
			int val = stmt.executeUpdate();
			sodocno=stmt.getInt("sodocno");
			int vocno=stmt.getInt("vdocNo");
			int trno=stmt.getInt("strno");
			int claccno=stmt.getInt("tmpacno");
			request.setAttribute("vdocNo", vocno);
			// System.out.println("===vocno====="+vocno);
	

		
		if(vocno>0)
		{
			
		
						
						//	 System.out.println("===mainarray==="+mainarray);
								
				              Statement stmt1=conn.createStatement();
						
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
							
							int  prdId=0;int  orddocno=0;int  psrno=0;String  batch_no="";Date  exp_date=null;
							double totqty=0;double out_qty=0;double totfoc=0;double out_foc=0;
							int  SpecNo=0;int  stockid=0;double fr=0;int  unitid=0;double unitprice=0;
							double total=0;double disper=0;double nettotal=0;double discount=0;
							
							
							String  ordsqls="select orddocno,  psrno, prdId, batch_no, exp_date, qty totqty, fr, out_qty, amount, total, disper, discount, unitid, " 
									  +"  SpecNo,  StockId,  nettotal, foc totfoc, out_foc "
									  +"  from my_sorderddet   where rowno="+rowno+"   ";
				 
							
							//System.out.println("===ordsqls====="+ordsqls);
							
							
							ResultSet ar=st.executeQuery(ordsqls);
							
							
							if(ar.next())
							{
								
								orddocno=ar.getInt("orddocno");
								prdId=ar.getInt("prdId");
								psrno=ar.getInt("psrno");
								batch_no=ar.getString("batch_no");
								exp_date=ar.getDate("exp_date");
								totqty=ar.getDouble("totqty");
								out_qty=ar.getDouble("out_qty");
								totfoc=ar.getDouble("totfoc");
								out_foc=ar.getDouble("out_foc");
								
								SpecNo=ar.getInt("SpecNo");
								stockid=ar.getInt("StockId");
								unitid=ar.getInt("unitid");
								fr=ar.getDouble("fr");
								
								
								unitprice=ar.getDouble("amount");
								
								total=qty*unitprice;
							
								disper=ar.getDouble("disper");
								 
								discount=(total*disper)/100;
								nettotal=total-discount;
							
								
								
								
						/* 		total=ar.getDouble("total");
								disper=ar.getDouble("disper");
								discount=ar.getDouble("discount");
								nettotal=ar.getDouble("nettotal"); */
								
							}
							
						 
							String sqlsss="insert into my_invd(tr_no,sr_no,rdocno,StockId,SpecNo,  psrno, prdId,unitid, qty, fr,  amount, total, disper, discount,  nettotal, foc, BATCHNO,bExpiry,ref_row)VALUES"
									+ " ("+trno+","+(i+1)+",'"+sodocno+"',"
									+ "'"+stockid+"' ,"
									+ "'"+SpecNo+"',"
									+ "'"+prdId+"',"
									+ "'"+psrno+"',"
									+ "'"+unitid+"',"
									+ "'"+qty+"',"
									+ "'"+fr+"',"
							 		+ "'"+unitprice+"',"
									+ "'"+total+"',"
									+ "'"+disper+"',"
									+ "'"+discount+"',"
									+ "'"+nettotal+"','"+foc+"','"+batch_no+"','"+exp_date+"',"+rowno+")";
				
							// System.out.println("sqlsss--->>>>Sql"+sqlsss);
							int ss= stmt1.executeUpdate (sqlsss);
							 
						 
							
							
								String sqls="update my_sorderddet set out_qty="+(out_qty+qty)+",out_foc="+(out_foc+foc)+" where rowno="+rowno+" ";	
								//System.out.println("=====my_sorderddet---"+sqls);
				
								stmt1.executeUpdate(sqls);	
							 
				
								
								String  ordsqlss="select  out_qty,out_foc  from my_sorderd   where doc_no="+orddocno+"   ";
								
								//System.out.println("=====ordsqlss---"+ordsqlss);
								ResultSet ars=st.executeQuery(ordsqlss);
								if(ars.next())
								{
									String sqlsaaa="update my_sorderd set out_qty="+(ars.getDouble("out_qty")+qty)+",out_foc="+(ars.getDouble("out_foc")+foc)+" where doc_no="+orddocno+" ";	
								//	System.out.println("=====my_sorderd---"+sqlsaaa);
									stmt1.executeUpdate(sqlsaaa);	
								}
								
								
								int locid=0;
								double rsv_qty=0;
								double prdout_qty=0;
								double qtyout=0;
								double prdoutqty=0;
								double masterqty=0;
								
								
								double stkqty=0;
								
							 
								Statement stmtstk=conn.createStatement();
				
								String stkSql="select batch_no,exp_date,locid,stockid,psrno,specno,(op_qty) stkqty,rsv_qty,(out_qty+del_qty) out_qty,out_qty qtyout  from my_prddin  where   stockid="+stockid+" and brhid="+branchvals+" ";
				
							//	System.out.println("=1111111111111111111111   1stkSql=inside insert="+stkSql);
				
								ResultSet rsstk = stmtstk.executeQuery(stkSql);
				
								if(rsstk.next()) {
									
									   
								
									stkqty=rsstk.getDouble("stkqty");
							 
									rsv_qty=rsstk.getDouble("rsv_qty");
									
									
									prdout_qty=rsstk.getDouble("out_qty");
									 
									locid=rsstk.getInt("locid");
									
									qtyout=rsstk.getDouble("qtyout");
								 
									 
									masterqty=(qty+foc)*fr;
									
									
								//	System.out.println("---stkqty-----"+stkqty);
									//System.out.println("---masterqty-----"+masterqty);
									//System.out.println("---prdout_qty-----"+prdout_qty);
									
									
									if(stkqty<(masterqty+prdout_qty))
									{ 
										
										
										// System.out.println("-=== ") ; 
										  tempval=1;
									 break;
									 
									 
								
									}
									
									
							 
									
									
									prdoutqty=masterqty;
									
									
									rsv_qty=rsv_qty-masterqty;
									
									
									if(rsv_qty<0)
									{
										rsv_qty=0;
									}
									
									masterqty=qtyout+masterqty;
									
								
								 
								//	System.out.println("---masterqty-----"+masterqty);
									
								 
								  
				
				
									Statement stmtstk12=conn.createStatement();
										
										
										String sql2s="update my_prddin set out_qty="+masterqty+",rsv_qty="+rsv_qty+"   where stockid="+stockid+" ";
									//	System.out.println("--1---my_prddin---"+sql2s);
										stmtstk12.executeUpdate(sql2s);
						 
										Statement stmtstk2=conn.createStatement();
										
										String sql111s="update my_invd set locid="+locid+"   where stockid="+stockid+" and psrno="+psrno+" and rdocno="+sodocno+" ";
										//System.out.println("--my_invd---sql111s---"+sql111s);
										stmtstk2.executeUpdate(sql111s);
										
										
										 
				
				 
				 
				 
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
												+ "'"+prdoutqty+"',"
												+ "'"+(prdoutqty*-1)+"',"
												+ "'"+prdId+"',"
												+"'"+branchvals+"','"+locid+"',"+unitprice+",'"+cost_prices+"')";
										 
											//System.out.println("== =========prodoutsql==OUT============="+prodoutsql);
										int df= stmt1.executeUpdate(prodoutsql);
										
										 
										 
									
									
									
								}
							
				
								
							//	System.out.println("== =========br==============");
							 
							 
								
							
						}
				 
						
	 
					 
				if(tempval==0)	
				{
					 
					 
								double finalamount=0;
								String sqlsval="select sum(total) total,sum(discount) discount,sum(nettotal) nettotal  from my_invd where  rdocno="+sodocno+" ";
								
								ResultSet rsstl=st.executeQuery(sqlsval);
								
								if(rsstl.next())
								{
									finalamount=rsstl.getDouble("nettotal");
									String sql2s="update my_invm set amount="+rsstl.getDouble("total")+",discount="+rsstl.getDouble("discount")+",netamount="+rsstl.getDouble("nettotal")+",grantamt="+rsstl.getDouble("nettotal")+" where  doc_no="+sodocno+"     ";
									
									//System.out.println("---- my_invm -sql2s----"+sql2s) ;
									stmt1.executeUpdate(sql2s);
										
								}
								
								
						
						
						
						
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
										System.out.println("---adjustsql----"+adjustsql) ;
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
						
						if(vocno>0 && tempval==0){
							response.getWriter().print(vocno);
							//stmt.close();
						 	conn.commit();
							conn.close();
						}
						else
						{
							response.getWriter().print(0);
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



