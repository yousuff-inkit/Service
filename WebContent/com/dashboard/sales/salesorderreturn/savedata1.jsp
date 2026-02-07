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

//java.sql.Date date=ClsCommon.changeStringtoSqlDate(dates);
 
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
	 
	   conn.setAutoCommit(false);
		
	    Statement st=conn.createStatement();
 
	    
	    
		
		
	 
		 
 
						
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
							
							int trnos=0;int  prdId=0;int  orddocno=0;int  psrno=0;String  batch_no="";Date  exp_date=null;
							double totqty=0;double out_qty=0;double totfoc=0;double out_foc=0;
							int  SpecNo=0;int  stockid=0;double fr=0;int  unitid=0;double unitprice=0;
							double total=0;double disper=0;double nettotal=0;double discount=0;
							double ret_qty=0;double ret_foc=0;
							
							String  ordsqls="select ret_qty,ret_foc,tr_no,orddocno,  psrno, prdId, batch_no, exp_date, qty totqty, fr, out_qty, amount, total, disper, discount, unitid, " 
									  +"  SpecNo,  StockId,  nettotal, foc totfoc, out_foc "
									  +"  from my_sorderddet   where rowno="+rowno+"   ";
				 
							
							 System.out.println("===ordsqls====="+ordsqls);
							
							
							ResultSet ar=st.executeQuery(ordsqls);
							
							
							if(ar.next())
							{
								ret_qty=ar.getDouble("ret_qty");
								ret_foc=ar.getDouble("ret_foc");
								
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
								trnos=ar.getInt("tr_no");
								
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
							
						 
							String sqlsss="insert into my_sorderretd(tr_no,sr_no,rdocno,StockId,SpecNo,  psrno, prdId,unitid, qty, fr,  amount, total, disper, discount,  nettotal, foc, BATCHNO,bExpiry,ref_row)VALUES"
									+ " ("+masterdocno+","+(i+1)+",'"+masterdocno+"',"
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
				
							  System.out.println("sqlsss--->>>>Sql"+sqlsss);
							int ss= stmt1.executeUpdate (sqlsss);
							 
						 
							
							
								String sqls="update my_sorderddet set out_qty="+(out_qty+qty)+",out_foc="+(out_foc+foc)+", ret_qty="+(ret_qty+qty)+",ret_foc="+(ret_foc+foc)+" where rowno="+rowno+" ";	
								 System.out.println("=====my_sorderddet---"+sqls);
				
								stmt1.executeUpdate(sqls);	
							 
				
								
								String  ordsqlss="select  out_qty,out_foc,ret_qty,ret_foc  from my_sorderd   where doc_no="+orddocno+"   ";
								
								 System.out.println("=====ordsqlss---"+ordsqlss);
								ResultSet ars=st.executeQuery(ordsqlss);
								if(ars.next())
								{
									String sqlsaaa="update my_sorderd set out_qty="+(ars.getDouble("out_qty")+qty)+",out_foc="+(ars.getDouble("out_foc")+foc)+",ret_qty="+(ars.getDouble("ret_qty")+qty)+",ret_foc="+(ars.getDouble("ret_foc")+foc)+" where doc_no="+orddocno+" ";	
							 System.out.println("=====my_sorderd---"+sqlsaaa);
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
				
							 	System.out.println("=1111111111111111111111   1stkSql=inside insert="+stkSql);
				
								ResultSet rsstk = stmtstk.executeQuery(stkSql);
				
								if(rsstk.next()) {
									
									   
								
									stkqty=rsstk.getDouble("stkqty");
							 
									rsv_qty=rsstk.getDouble("rsv_qty");
									
									
									prdout_qty=rsstk.getDouble("out_qty");
									 
									locid=rsstk.getInt("locid");
									
									qtyout=rsstk.getDouble("qtyout");
								 
									 
									masterqty=(qty+foc)*fr;
									
									
					 
									
									
									if(stkqty<(masterqty+prdout_qty))
									{ 
										
										
									 
										 
									 break;
									 
									 
								
									}
									
									
							 
									
									
									prdoutqty=masterqty;
									
									
									rsv_qty=rsv_qty-masterqty;
									
									
									if(rsv_qty<0)
									{
										rsv_qty=0;
									}
									
									masterqty=qtyout+masterqty;
									
								
							 
				
									Statement stmtstk12=conn.createStatement();
										
										
										String sql2s="update my_prddin set  rsv_qty="+rsv_qty+"   where stockid="+stockid+" ";
									//	System.out.println("--1---my_prddin---"+sql2s);
										stmtstk12.executeUpdate(sql2s);
						 
										
										double outres_qty=0;
										
										double outupres_qty=0;
										
										String sqloot=" select  rsv_qty from  my_prddout  where stockid="+stockid+" and psrno="+psrno+" and rdocno="+masterdocno+" and dtype='SOR' and tr_no="+trnos+" ";
										
										 System.out.println("--my_prddout---select---"+sqloot);
										ResultSet ors=stmtstk12.executeQuery(sqloot);
										
										if(ors.first())
										{
											outres_qty=ors.getDouble("rsv_qty");
											
										}
										
										outupres_qty=outres_qty-prdoutqty;
										
										 System.out.println("--outres_qty--- ---"+outres_qty);
										 System.out.println("--prdoutqty--- ---"+prdoutqty);
										 System.out.println("--outupres_qty--- ---"+outupres_qty);
										
										
										if(outupres_qty<0)
										{
											outupres_qty=0;
										}
										
										
										Statement stmtstk2=conn.createStatement();
										
										
										
										
										
										String sql111s="update my_prddout set rsv_qty="+outupres_qty+"   where stockid="+stockid+" and psrno="+psrno+" and rdocno="+masterdocno+" and dtype='SOR' and tr_no="+trnos+" ";
										 System.out.println("--my_prddout---save---"+sql111s);
										stmtstk2.executeUpdate(sql111s);
										
										
										 
				 
							  
										 
									
									
									
								}
							
				
						}
						
						 
							response.getWriter().print(1);
							//stmt.close();
						 	conn.commit();
							conn.close();
					 
						 
						 
						 
					
				   
		}			
	
   
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().print(0);
    }
	 	
	 	
	 	
%>



