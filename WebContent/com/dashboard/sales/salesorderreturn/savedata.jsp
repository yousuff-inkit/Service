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
 
	    
	    int trno=0;
	  ResultSet rs3=st.executeQuery("select coalesce(max(trno)+1,1) trno from my_trno");
	 if(rs3.first())
	 {
		 trno=rs3.getInt("trno");
	 }
		
	 String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+branchvals+"','"+session.getAttribute("USERID").toString()+"','"+trno+"')";
		
		 st.executeUpdate(trnosql);
	      
 
						
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
							
 
										
							
							double   out_qty=0;
							double   out_foc=0;
							
							int prddid=0;
							int prdtr_no=0;
							
							Statement stmt=conn.createStatement();
							
							 
							String delsqls1="select out_qty,out_foc,psrno,tr_no from  my_sorderd   where doc_no="+rowno+"   ";
							
							  System.out.println("----delsqls1-----"+delsqls1);
							ResultSet rssss=stmt.executeQuery(delsqls1);
							if(rssss.first())
							{
								out_qty=rssss.getDouble("out_qty");
								out_foc=rssss.getDouble("out_foc");
								prddid=rssss.getInt("psrno");
								prdtr_no=rssss.getInt("tr_no");
							}
							//System.out.println("--out_qtys---"+out_qty);
							//System.out.println("--rqty---"+rqty);
							 
							out_qty=out_qty+qty;
							out_foc=out_foc+foc;
							 
							
							String delsqls="update my_sorderd set out_qty="+out_qty+",out_foc="+out_foc+" ,ret_qty=ret_qty+"+qty+",ret_foc=ret_foc+"+foc+",clstatus=1   where doc_no="+rowno+"   ";
							 System.out.println("--1---sqls---"+delsqls);

							stmt.executeUpdate(delsqls);
							 
						 	
									
								
							String sqlsss="insert into my_sorderretd(tr_no,sr_no,rdocno,StockId,SpecNo,  psrno, prdId,unitid, qty, fr,  amount, total, disper, discount,  nettotal, foc,ref_row,brhid,userid)VALUES"
									+ " ("+trno+","+(i+1)+",'"+masterdocno+"',"
									+ "'0' ,"
									+ "'0',"
									+ "'"+prddid+"',"
									+ "'"+prddid+"',"
									+ "'0',"
									+ "'"+qty+"',"
											+ "'0' ,"
													+ "'0' ,"
															+ "'0' ,"
																	+ "'0' ,"
																			+ "'0' ,"
									+ "'0','"+foc+"',"+rowno+","+branchvals+",'"+session.getAttribute("USERID").toString()+"')";
				
							  System.out.println("sqlsss--->>>>Sql"+sqlsss);
							int ss= stmt1.executeUpdate (sqlsss);
						
							  
								int sodocno=0;
								
								   String sqlssg="select max(doc_no) maxdoc from  my_sorderretd";
								   ResultSet rv1ss=stmt.executeQuery(sqlssg);
								     if(rv1ss.next())
								     {
								    	 sodocno=rv1ss.getInt("maxdoc"); 
								     }
						    	 
								 
							int locid=0;
							int stockid=0;
							double rsv_qty=0;
							double rsv_qty1=0;
							double op_qty=0;
							double qtyout=0;
							double prdoutqty=0;
							double prdout_qty=0;
							double saveqty=0;
							double stkqty=0,masterqty=0,remqty=0;
					 
						 masterqty=(qty+foc);
						Statement stmtstk=conn.createStatement();
						 
						
						String sqlssss="select pin.locid,d.rsv_qty-coalesce(d.rsvout_qty,0)  rsv_qty,pin.stockid,pin.op_qty ,(pin.out_qty+pin.del_qty) out_qty from my_sorderst d "
								 +" inner join my_prddin pin on pin.stockid=d.stockid  "
								 +" where d.psrno="+prddid+"  and d.tr_no="+prdtr_no+"  and    (d.rsv_qty-coalesce(d.rsvout_qty,0))>0 and pin.rsv_qty>0   ";
						
					 
											
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
									
									op_qty=-1;
									remqty=0;
									
									
									 
								}
								
								else if(masterqty>rsv_qty)
								{
									remqty=masterqty-rsv_qty;
									masterqty=rsv_qty;
									 
									
									
								}
								
						 
							 
							//	System.out.println("---masterqty-----"+masterqty);
								
			
									Statement stmtstk12=conn.createStatement();
									
									String sql2s="update my_prddin set rsv_qty=rsv_qty-"+masterqty+"   where stockid="+stockid+" ";
								 	System.out.println("--1---my_prddin---"+sql2s);
									stmtstk12.executeUpdate(sql2s);
									
						 
			 
								String prodoutsql="";
								String cost_prices="0";
								String unitprice="0";
								int SpecNo=0;
								Statement stmtstk1=conn.createStatement();
			
								String stkSql1="select  cost_price,unit_price,specno  from my_prddin where stockid='"+stockid+"'";
			
								System.out.println("=stkSql1 select cost_price insert="+stkSql1);
			
								ResultSet rsstk1 = stmtstk1.executeQuery(stkSql1);
			
								if(rsstk1.next()) {
									cost_prices=rsstk1.getString("cost_price");
									unitprice=rsstk1.getString("unit_price");
									SpecNo=rsstk1.getInt("specno");
								}
								
			 
									
									
									 prodoutsql="insert into my_prddout(sr_no,TR_NO, dtype, rdocno,stockid,date, specid, psrno,qty,rsv_qty,prdid,brhid,locid,unit_price,cost_price) Values"
											+ " ("+(i+1)+",'"+trno+"','SRR',"+sodocno+","
											+ "'"+stockid+"',"
											+ "curdate(),"
											+ "'"+SpecNo+"',"
											+ "'"+prddid+"',"
											+ "'0',"
											+ "'"+(masterqty*-1)+"',"
											+ "'"+prddid+"',"
											+"'"+branchvals+"','"+locid+"',"+unitprice+",'"+cost_prices+"')";
									 
										  System.out.println("== =========prodoutsql==OUT============="+prodoutsql);
									int df= stmt1.executeUpdate(prodoutsql);
									
									
									
									String sql2s11="update my_sorderst set rsvout_qty=rsvout_qty+"+masterqty+"     where stockid="+stockid+" and psrno="+prddid+"  and tr_no="+prdtr_no+"   ";
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
				
						
				 
						}
						 
							 
						System.out.println("-result---"+result);
 
							if(result==0)
							{  
							response.getWriter().print(1);
							//stmt.close();
						 conn.commit();
							   }
							else
							{
								response.getWriter().print(0);
							}  
							
						 
							conn.close();
					 
						 
						 
						 
					
				   
		}			
	
   
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().print(0);
    }
	 	
	 	
	 	
%>



 