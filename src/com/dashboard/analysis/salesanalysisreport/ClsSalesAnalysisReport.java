package com.dashboard.analysis.salesanalysisreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSalesAnalysisReport {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray analysisGrid(String branch,String fromdate,String todate,String summaryType,String hidsalesman,String hidcatid,String hideptid, String cmbfrequency,String noOfDays,String check,String hicashid,String hicreditid) throws SQLException {
		
		 JSONArray RESULTDATA=new JSONArray();
		 JSONArray ROWDATA=new JSONArray();
		 JSONArray COLUMNDATA=new JSONArray();
		 Connection conn =  null;
		 System.out.println("--no days--"+noOfDays);
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtsales = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 
		     java.sql.Date sqlFromDate = null;
		     java.sql.Date sqlToDate = null;
		     java.sql.Date analysisDate=null;
		     java.sql.Date analysisFromDate=null;
		     java.sql.Date analysisToDate=null;
		     String analysingDate="",analysingToDate="";
		     
		     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
	              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
	         }else if(fromdate.equalsIgnoreCase("0")){
	        	   String sqldate= "select DATE_SUB(LAST_DAY(CURDATE()),INTERVAL 1 MONTH) today";
				   ResultSet rs = stmtsales.executeQuery(sqldate);
				   
				   while(rs.next()){
					   sqlFromDate=rs.getDate("today");
				   }
	         }

		     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
	              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
	         }else if(todate.equalsIgnoreCase("0")){
	        	   String sqldate= "select CURDATE() today";
				   ResultSet rs = stmtsales.executeQuery(sqldate);
				   
				   while(rs.next()){
					   sqlToDate=rs.getDate("today");
				   }
	         }
		     
		     
		     
		     int amountLength=0,txtfrequency=0;
		     ArrayList<String> analysiscolumnarray= new ArrayList<String>();
		     ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<>();
		     
		     
		     analysiscolumnarray.add("Id::id::center::center::true:: :: :: ");
		     analysiscolumnarray.add("Description::description::left::left:: ::30%:: ::headClass");
			 analysiscolumnarray.add("Total::total::right::right:: ::15%::d2::violetClass");
			 
			 String sql="",sql1="",sql2="",sql3="",sql4="";
		     String xsql="",xsqls="";
		     String dayDiff="",monthDiff="";
		     
			 if(cmbfrequency.equalsIgnoreCase("2")){
		    	 
		    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		    	    ResultSet rs1 = stmtsales.executeQuery(sqls);
					
					while(rs1.next()) {
						txtfrequency=rs1.getInt("monthdiff");
					} 
					
					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
					
		     }else if(cmbfrequency.equalsIgnoreCase("3")){
		    	 
		    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
		    	    ResultSet rs1 = stmtsales.executeQuery(sqls);
					
					while(rs1.next()) {
						monthDiff=rs1.getString("monthdiff");
					} 
					
					String sqls1 = "select ("+monthDiff+"/3) monthdifference";
					ResultSet rs2 = stmtsales.executeQuery(sqls1);
					
					while(rs2.next()) {
						txtfrequency=rs2.getInt("monthdifference");
					} 
		    	    
					xsqls= "3 Month";
					
		     }else if (cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){

					String sqls = "select (YEAR('"+sqlToDate+"')-YEAR('"+sqlFromDate+"'))+1 yeardiff";
		    	 	ResultSet rs1 = stmtsales.executeQuery(sqls);
					
					while(rs1.next()) {
						txtfrequency=rs1.getInt("yeardiff");
					} 
					
					xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
		     }
			 //columnname
			 if(cmbfrequency.equalsIgnoreCase("2")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
						   ResultSet rs = stmtsales.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
							     
							     amountLength=amountLength+1;
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
						   }
						  
						   sql1+=", if(m.date>='"+sqlFromDate+"' and m.date<='"+analysisDate+"',d.total,0) amount"+i;
						   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
						   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
						   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
					  
					   }
					   else{
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
						   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
						 //  xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
							//   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
							   System.out.println("--xsql--"+xsql);
						   ResultSet rs = stmtsales.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisFromDate=rs.getDate("analysisFromDate");
							     analysisToDate=rs.getDate("analysisToDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
		
							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
							    	   analysisToDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
							     
							     amountLength=amountLength+1;
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
							     analysisDate=analysisToDate;
						   }
						   sql1+=", if(m.date>='"+analysisFromDate+"' and m.date<='"+analysisToDate+"',d.total,0) amount"+i;
						   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
						   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
						   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
					   }
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						   break;
					   }
					}
			 }
			 
			 
			/*  analysisFromDate=rs.getDate("analysisFromDate");
			     analysisToDate=rs.getDate("analysisToDate");
			     analysingDate=rs.getString("analysisDates");
			     analysingToDate=rs.getString("analysingDate");

			     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
			    	   analysisToDate=sqlToDate;
			    	   analysingDate=analysingToDate;
			      }
			     
			         sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
					 
			         sql4+=" 0 amount"+i+",";
			         
			         sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
			         
			         sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
			         
			         sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
			         
			         sql8+="if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
			         
				     amountLength=amountLength+1;
				     
				     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
			     
			         analysisDate=analysisToDate;*/
			 
			else if(cmbfrequency.equalsIgnoreCase("3")){
		     	
		     	analysisDate=sqlFromDate;
				for(int i=0;i<=txtfrequency;i++)
				{
				   
				   if(i==0){
					   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%b %Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)),'%b %Y')) analysisDates";
					   ResultSet rs = stmtsales.executeQuery(xsql);
					   
					   while(rs.next()){
						     analysisDate=rs.getDate("analysisDate");
						     analysingDate=rs.getString("analysisDates");
						     
						     amountLength=amountLength+1;
						     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
					     }
					   
					   sql1+=", if(m.date>='"+sqlFromDate+"' and m.date<='"+analysisDate+"',d.total,0) amount"+i;
					   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
					   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
					   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
					   
					}else{
						   
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
						   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%b %Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
						   		+ "DATE_FORMAT('"+sqlToDate+"','%b %Y')) analysingDate";
						   ResultSet rs = stmtsales.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisFromDate=rs.getDate("analysisFromDate");
							     analysisToDate=rs.getDate("analysisToDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
		
							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
							    	   analysisToDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
							             
							     amountLength=amountLength+1;
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
						         analysisDate=analysisToDate;
						     }
						   sql1+=", if(m.date>='"+analysisFromDate+"' and m.date<='"+analysisToDate+"',d.total,0) amount"+i;
						   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
						   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
						   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
					   }
				   
				   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
				    	 break;
				     }
				}
				
		     }
			else if(cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){
	     		
	     		analysisDate=sqlFromDate;
				for(int i=0;i<=txtfrequency;i++)
				{
				   
				   if(i==0){
					   String sqls = "SELECT YEAR('"+analysisDate+"') year";
					   ResultSet rs1 = stmtsales.executeQuery(sqls);
					   
					   int year=0;
					   while(rs1.next()){
						    year=rs1.getInt("year");
					   }
					   
					   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
					   ResultSet rss = stmtsales.executeQuery(sqls1);
					   
					   int noOfMonths=0;
					   while(rss.next()){
						     noOfMonths=rss.getInt("noofmonths");
					   }
					   
					   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,DATE_FORMAT('"+analysisDate+"','%Y') analysisDates";
					   System.out.println("--xsql---"+xsql);
					   
					   ResultSet rs = stmtsales.executeQuery(xsql);
					   
					   while(rs.next()){
						     analysisDate=rs.getDate("analysisDate");
						     analysingDate=rs.getString("analysisDates");
	
						     amountLength=amountLength+1;
						     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
					     }
					   
					   System.out.println("--analysisdate--"+analysisDate);
					   sql1+=", if(m.date>='"+sqlFromDate+"' and m.date<='"+analysisDate+"',d.total,0) amount"+i;
					   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
					   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
					   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
					}else{
						   
						   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,"
								+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%Y') analysingDate";
						   
						   ResultSet rs = stmtsales.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisFromDate=rs.getDate("analysisFromDate");
							     analysisToDate=rs.getDate("analysisToDate");
							     analysingDate=rs.getString("analysisDates");
							     analysingToDate=rs.getString("analysingDate");
		
							     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
							    	   analysisToDate=sqlToDate;
							    	   analysingDate=analysingToDate;
							      }
							     
							     amountLength=amountLength+1;
							     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: :: ::d2::yellowClass");
						         analysisDate=analysisToDate;
						   }
						   sql1+=", if(m.date>='"+analysisFromDate+"' and m.date<='"+analysisToDate+"',d.total,0) amount"+i;
						   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
						   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
						   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
					}
				   
				   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					   break;
				   }
				}
			}
			 String sqlref="",sqljoin="",sqlfilter="";
			 if(summaryType.equalsIgnoreCase("slm")){
	        		sqlref+=" s.doc_no refno,s.sal_name description,";
	        		sqljoin+=" left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm s on (s.doc_no=ac.sal_id and ac.dtype='CRM' )";
	        }
			 else if(summaryType.equalsIgnoreCase("dpt")){
	        		sqljoin+=" inner join my_main n on d.psrno=n.psrno inner join my_dept dt on dt.doc_no=n.deptId";
	        		sqlref+=" n.deptid refno,dt.department description,";
	        }
			 else if(summaryType.equalsIgnoreCase("ctg")){
	        		sqljoin+=" inner join my_main n on d.psrno=n.psrno inner join my_catm ct on ct.doc_no=n.catid";
	        		sqlref+=" n.catid refno,ct.category description,";
	        }
			 else if(summaryType.equalsIgnoreCase("csh")){
	        		/*sqljoin+="group by m.paymode";*/
	        		sqlref+=" m.paymode refno,if(paymode=1,'CASH','CREDIT') as description,";
	        }
			
			
			 if(!hidsalesman.equalsIgnoreCase("")){
	        		sqlfilter+=" and s.doc_no in ("+hidsalesman+")";
	        		if(!summaryType.equalsIgnoreCase("slm")){
	        			sqljoin+=" left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm s on (s.doc_no=ac.sal_id and ac.dtype='CRM' )";
		        	}
			 }
			 if(!hidcatid.equalsIgnoreCase("")){
	        		sqlfilter+=" and ct.doc_no in ("+hidcatid+")";
	        		if(!summaryType.equalsIgnoreCase("ctg")){
	        			if(!sqljoin.contains("my_main")){
	          				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
	           			}
	           			sqljoin+=" inner join my_catm ct on ct.doc_no=n.catid";
		        	}
			 }
			 if(!hideptid.equalsIgnoreCase("")){
	        		sqlfilter+=" and dt.doc_no in ("+hideptid+")";
	        		if(!summaryType.equalsIgnoreCase("dpt")){
	        			if(!sqljoin.contains("my_main")){
	          				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
	           			}
	           			sqljoin+=" left join my_dept dt on dt.doc_no=n.deptId ";
		        	}
			 }
			 if(!hicashid.equalsIgnoreCase("")){
				
					 
			        		sqlfilter+=" and m.paymode in ("+hicashid+") and m.ftype=0";
						 
				 
	        		
			 }
			  sql="select   @i:=@i+1 id,aa.description, round(sum(aa.sales)-sum(aa.retamt),2) nettotal "+sql4
					 +" from( select a.refno,a.description,sum(a.total) sales,0 retamt "+sql2
					 +" from ( select "+sqlref+"d.total ,0 retamt "+sql1
					 +" from my_invM m inner join my_inVd d on m.doc_no=d.rdocno "+sqljoin
					 +" where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sqlfilter+" ) a group by a.refno union all"
					 +" select a.refno,a.description, 0 sales,sum(a.total) retamt "+sql3
					 +" from ( select "+sqlref+"d.total ,0 retamt "+sql1
					 +" from my_invr m inner join my_inrd d on m.doc_no=d.rdocno "+sqljoin
 					 +" where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sqlfilter+") a  group by a.refno) aa "
 					 		+ "   , (SELECT @i:= 0) as i group by aa.refno";
			  
			  System.out.println("--gridsql---"+sql);
			  ResultSet resultSet = stmtsales.executeQuery(sql);
			  
			  while(resultSet.next()){
				  ArrayList<String> temp=new ArrayList<String>();
				  temp.add(resultSet.getString("id"));
				  temp.add(resultSet.getString("description"));
				  temp.add(resultSet.getString("nettotal"));
				  for (int l = 0; l < amountLength; l++) {
					  temp.add(resultSet.getString("amount"+l));
				  }
				  analysisrowarray.add(temp);
				  
			  }
			  
		     COLUMNDATA=convertColumnAnalysisArrayToJSON(analysiscolumnarray);
			 ROWDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
			 
			 JSONArray analysisarray=new JSONArray();
			 
			 analysisarray.addAll(COLUMNDATA);
			 analysisarray.addAll(ROWDATA);
			 RESULTDATA=analysisarray;
		     
			 }
		 }
		 catch(Exception e){
			 e.printStackTrace();
			 conn.close();
		 }
		 return RESULTDATA;
	}
	
	public JSONArray analysisGridExcelExport(String branch,String fromdate,String todate,String summaryType,String hidsalesman,String hidcatid,String hideptid, String cmbfrequency,String noOfDays,String check,String hicashid) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		 Connection conn =  null;
		
		 try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtsales = conn.createStatement();
			
			 if(check.equalsIgnoreCase("1")){
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
			     java.sql.Date analysisDate=null;
			     java.sql.Date analysisFromDate=null;
			     java.sql.Date analysisToDate=null;
			     String analysingDate="",analysingToDate="";
			     
			     if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		         }else if(fromdate.equalsIgnoreCase("0")){
		        	   String sqldate= "select DATE_SUB(LAST_DAY(CURDATE()),INTERVAL 1 MONTH) today";
					   ResultSet rs = stmtsales.executeQuery(sqldate);
					   
					   while(rs.next()){
						   sqlFromDate=rs.getDate("today");
					   }
		         }

			     if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		         }else if(todate.equalsIgnoreCase("0")){
		        	   String sqldate= "select CURDATE() today";
					   ResultSet rs = stmtsales.executeQuery(sqldate);
					   
					   while(rs.next()){
						   sqlToDate=rs.getDate("today");
					   }
		         }
			     int amountLength=0,txtfrequency=0;
			     ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<>();
			     
			     String sql="",sql1="",sql2="",sql3="",sql4="";
			     String xsql="",xsqls="";
			     String dayDiff="",monthDiff="";
			     
				 if(cmbfrequency.equalsIgnoreCase("2")){
			    	 
			    	 	String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtsales.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("monthdiff");
						} 
						
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
						
			     }else if(cmbfrequency.equalsIgnoreCase("3")){
			    	 
			    	    String sqls = "select TIMESTAMPDIFF(MONTH, '"+sqlFromDate+"', '"+sqlToDate+"') monthdiff";
			    	    ResultSet rs1 = stmtsales.executeQuery(sqls);
						
						while(rs1.next()) {
							monthDiff=rs1.getString("monthdiff");
						} 
						
						String sqls1 = "select ("+monthDiff+"/3) monthdifference";
						ResultSet rs2 = stmtsales.executeQuery(sqls1);
						
						while(rs2.next()) {
							txtfrequency=rs2.getInt("monthdifference");
						} 
			    	    
						xsqls= "3 Month";
						
			     }else if (cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){

						String sqls = "select (YEAR('"+sqlToDate+"')-YEAR('"+sqlFromDate+"'))+1 yeardiff";
			    	 	ResultSet rs1 = stmtsales.executeQuery(sqls);
						
						while(rs1.next()) {
							txtfrequency=rs1.getInt("yeardiff");
						} 
						
						xsqls=1 + (cmbfrequency.equalsIgnoreCase("2")?" Month ":" Year ");
			     }
				 //columnname
				 if(cmbfrequency.equalsIgnoreCase("2")){
				     	
				     	analysisDate=sqlFromDate;
						for(int i=0;i<=txtfrequency;i++)
						{
						   
						   if(i==0){
							   xsql= "Select LAST_DAY('"+analysisDate+"') analysisDate,DATE_FORMAT('"+analysisDate+"','%b %Y') analysisDates";
							   ResultSet rs = stmtsales.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisDate=rs.getDate("analysisDate");
								     analysingDate=rs.getString("analysisDates");
								     
								     amountLength=amountLength+1;
							   }
							  
							   sql1+=", if(m.date>='"+sqlFromDate+"' and m.date<='"+analysisDate+"',d.total,0) amount"+i;
							   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
							   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
							   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
						  
						   }
						   else{
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
							   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
							 //  xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day )) analysisToDate,"
								//   		+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%b %Y') analysingDate";
								   System.out.println("--xsql--"+xsql);
							   ResultSet rs = stmtsales.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								     
								     amountLength=amountLength+1;
								     analysisDate=analysisToDate;
							   }
							   sql1+=", if(m.date>='"+analysisFromDate+"' and m.date<='"+analysisToDate+"',d.total,0) amount"+i;
							   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
							   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
							   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
						   }
						   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
							   break;
						   }
						}
				 }
				 
				 
				/*  analysisFromDate=rs.getDate("analysisFromDate");
				     analysisToDate=rs.getDate("analysisToDate");
				     analysingDate=rs.getString("analysisDates");
				     analysingToDate=rs.getString("analysingDate");

				     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
				    	   analysisToDate=sqlToDate;
				    	   analysingDate=analysingToDate;
				      }
				     
				         sql3+=" if(k.amount"+i+"!=0,round(k.amount"+i+",2),'') amount"+i+",";
						 
				         sql4+=" 0 amount"+i+",";
				         
				         sql5+="if(gp_id is null,amount"+i+"*if(grpLevel=1,-1,1),amount"+i+"*drsign) amount"+i+",";
				         
				         sql6+="coalesce(sum(amount"+i+"),0) amount"+i+",";
				         
				         sql7+="coalesce(sum(x.amount"+i+"),0) amount"+i+",";
				         
				         sql8+="if(t.date>='"+analysisFromDate+"' and t.date<='"+analysisToDate+"',coalesce(round(ldramount,2),0),0) amount"+i+",";
				         
					     amountLength=amountLength+1;
					     
					     analysiscolumnarray.add(""+analysingDate+"::amount"+i+"::right::right:: ::15%::d2::yellowClass");
				     
				         analysisDate=analysisToDate;*/
				 
				else if(cmbfrequency.equalsIgnoreCase("3")){
			     	
			     	analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)) analysisDate,CONCAT(DATE_FORMAT('"+analysisDate+"','%b %Y'),' To ',DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 2 Month)),'%b %Y')) analysisDates";
						   ResultSet rs = stmtsales.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
							     
							     amountLength=amountLength+1;
						     }
						   
						   sql1+=", if(m.date>='"+sqlFromDate+"' and m.date<='"+analysisDate+"',d.total,0) amount"+i;
						   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
						   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
						   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
						   
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )) analysisToDate,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
							   		+ "DATE_FORMAT(LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 3 Month )),'%b %Y')) analysisDates,CONCAT(DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%b %Y'),' To ',"
							   		+ "DATE_FORMAT('"+sqlToDate+"','%b %Y')) analysingDate";
							   ResultSet rs = stmtsales.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								             
								     amountLength=amountLength+1;
							         analysisDate=analysisToDate;
							     }
							   sql1+=", if(m.date>='"+analysisFromDate+"' and m.date<='"+analysisToDate+"',d.total,0) amount"+i;
							   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
							   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
							   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
						   }
					   
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
					    	 break;
					     }
					}
					
			     }
				else if(cmbfrequency.equalsIgnoreCase("4") || cmbfrequency.equalsIgnoreCase("0")){
		     		
		     		analysisDate=sqlFromDate;
					for(int i=0;i<=txtfrequency;i++)
					{
					   
					   if(i==0){
						   String sqls = "SELECT YEAR('"+analysisDate+"') year";
						   ResultSet rs1 = stmtsales.executeQuery(sqls);
						   
						   int year=0;
						   while(rs1.next()){
							    year=rs1.getInt("year");
						   }
						   
						   String sqls1= "SELECT TIMESTAMPDIFF(MONTH, '"+analysisDate+"', '"+year+"-12-31') noofmonths";
						   ResultSet rss = stmtsales.executeQuery(sqls1);
						   
						   int noOfMonths=0;
						   while(rss.next()){
							     noOfMonths=rss.getInt("noofmonths");
						   }
						   
						   xsql= "Select LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL "+noOfMonths+" Month)) analysisDate,DATE_FORMAT('"+analysisDate+"','%Y') analysisDates";
						   System.out.println("--xsql---"+xsql);
						   
						   ResultSet rs = stmtsales.executeQuery(xsql);
						   
						   while(rs.next()){
							     analysisDate=rs.getDate("analysisDate");
							     analysingDate=rs.getString("analysisDates");
		
							     amountLength=amountLength+1;
						     }
						   
						   System.out.println("--analysisdate--"+analysisDate);
						   sql1+=", if(m.date>='"+sqlFromDate+"' and m.date<='"+analysisDate+"',d.total,0) amount"+i;
						   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
						   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
						   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
						}else{
							   
							   xsql= "Select DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ) analysisFromDate,LAST_DAY(DATE_ADD(date('"+analysisDate+"'),INTERVAL 12 Month )) analysisToDate,"
									+ "DATE_FORMAT(DATE_ADD(date('"+analysisDate+"'),INTERVAL 1 Day ),'%Y') analysisDates,DATE_FORMAT('"+sqlToDate+"','%Y') analysingDate";
							   
							   ResultSet rs = stmtsales.executeQuery(xsql);
							   
							   while(rs.next()){
								     analysisFromDate=rs.getDate("analysisFromDate");
								     analysisToDate=rs.getDate("analysisToDate");
								     analysingDate=rs.getString("analysisDates");
								     analysingToDate=rs.getString("analysingDate");
			
								     if(analysisToDate.after(sqlToDate) || analysisToDate.equals(sqlToDate)){
								    	   analysisToDate=sqlToDate;
								    	   analysingDate=analysingToDate;
								      }
								     
								     amountLength=amountLength+1;
							         analysisDate=analysisToDate;
							   }
							   sql1+=", if(m.date>='"+analysisFromDate+"' and m.date<='"+analysisToDate+"',d.total,0) amount"+i;
							   sql2+=", sum(a.amount"+i+") samount"+i+", 0 ramount"+i;
							   sql3+=", 0 samount"+i+",sum(a.amount"+i+") ramount"+i;
							   sql4+=", round(sum(aa.samount"+i+")-sum(aa.ramount"+i+"),2) amount"+i;
						}
					   
					   if(analysisDate.after(sqlToDate) || analysisDate.equals(sqlToDate)){
						   break;
					   }
					}
				}
				 String sqlref="",sqljoin="",sqlfilter="";
				 if(summaryType.equalsIgnoreCase("slm")){
		        		sqlref+=" s.doc_no refno,s.sal_name description,";
		        		sqljoin+="left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm s on (s.doc_no=ac.sal_id and ac.dtype='CRM' )";
		        }
				 else if(summaryType.equalsIgnoreCase("dpt")){
		        		sqljoin+=" inner join my_main n on d.psrno=n.psrno inner join my_dept dt on dt.doc_no=n.deptId";
		        		sqlref+=" n.deptid refno,dt.department description,";
		        }
				 else if(summaryType.equalsIgnoreCase("ctg")){
		        		sqljoin+=" inner join my_main n on d.psrno=n.psrno inner join my_catm ct on ct.doc_no=n.catid";
		        		sqlref+=" n.catid refno,ct.category description,";
		        }
				 else if(summaryType.equalsIgnoreCase("csh")){
		        		/*sqljoin+="group by m.paymode";*/
		        		sqlref+=" m.paymode refno,if(paymode=1,'CASH','CREDIT') as description,";
		        }
				 if(!hidsalesman.equalsIgnoreCase("")){
		        		sqlfilter+=" and s.doc_no in ("+hidsalesman+")";
		        		if(!summaryType.equalsIgnoreCase("slm")){
		        			sqljoin+=" left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm s on (s.doc_no=ac.sal_id and ac.dtype='CRM' )";
			        	}
				 }
				 if(!hidcatid.equalsIgnoreCase("")){
		        		sqlfilter+=" and ct.doc_no in ("+hidcatid+")";
		        		if(!summaryType.equalsIgnoreCase("ctg")){
		        			if(!sqljoin.contains("my_main")){
		          				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
		           			}
		           			sqljoin+=" inner join my_catm ct on ct.doc_no=n.catid";
			        	}
				 }
				 if(!hideptid.equalsIgnoreCase("")){
		        		sqlfilter+=" and dt.doc_no in ("+hideptid+")";
		        		if(!summaryType.equalsIgnoreCase("dpt")){
		        			if(!sqljoin.contains("my_main")){
		          				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
		           			}
		           			sqljoin+=" left join my_dept dt on dt.doc_no=n.deptId ";
			        	}
				 }
				 if(!hicashid.equalsIgnoreCase("")){
						
					 
		        		sqlfilter+=" and m.paymode in ("+hicashid+") and m.ftype=0";
					 
			 
     		
		 }
				  sql="select   @i:=@i+1 id,aa.description, round(sum(aa.sales)-sum(aa.retamt),2) nettotal "+sql4
						 +" from( select a.refno,a.description,sum(a.total) sales,0 retamt "+sql2
						 +" from ( select "+sqlref+"d.total ,0 retamt "+sql1
						 +" from my_invM m inner join my_inVd d on m.doc_no=d.rdocno "+sqljoin
						 +" where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sqlfilter+" ) a group by a.refno union all"
						 +" select a.refno,a.description, 0 sales,sum(a.total) retamt "+sql3
						 +" from ( select "+sqlref+"d.total ,0 retamt "+sql1
						 +" from my_invr m inner join my_inrd d on m.doc_no=d.rdocno "+sqljoin
	 					 +" where m.status=3 and m.date between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sqlfilter+") a  group by a.refno) aa "
	 					 		+ "   , (SELECT @i:= 0) as i group by aa.refno";
				  
				  System.out.println("--gridsqlexcel---"+sql);
				  ResultSet resultSet = stmtsales.executeQuery(sql);
				  
				  while(resultSet.next()){
					  ArrayList<String> temp=new ArrayList<String>();
					  temp.add(resultSet.getString("id"));
					  temp.add(resultSet.getString("description"));
					  temp.add(resultSet.getString("nettotal"));
					  for (int l = 0; l < amountLength; l++) {
						  temp.add(resultSet.getString("amount"+l));
					  }
					  analysisrowarray.add(temp);
				  }
				
				  RESULTDATA=convertArrayToExcel(analysisrowarray,cmbfrequency);
			 }
		 }catch(Exception e){
			    e.printStackTrace();
			    conn.close();
		  }
		return RESULTDATA;
	}
	public  JSONArray convertArrayToExcel(ArrayList<ArrayList<String>> arrayList,String cmbfrequency) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		String frequencytype=cmbfrequency.equalsIgnoreCase("1")?" Day ":cmbfrequency.equalsIgnoreCase("2")?" Month ":cmbfrequency.equalsIgnoreCase("3")?" Quarter ":" Year ";
		
		for (int i = 0; i < arrayList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> salesAnalysisRowArray=arrayList.get(i);
			int length = salesAnalysisRowArray.size();
				
			obj.put("Sr No.",salesAnalysisRowArray.get(0));
			obj.put("Description",salesAnalysisRowArray.get(1));
			obj.put("Total",salesAnalysisRowArray.get(2));
			
			for (int j = 3,k=1; j < length; j++,k++) {
				if(!(salesAnalysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put(frequencytype+" "+k,salesAnalysisRowArray.get(j));
				}
			}
			
			jsonArray.add(obj);

		}
		return jsonArray;
	}
	
	public  JSONArray convertColumnAnalysisArrayToJSON(ArrayList<String> columnsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < columnsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			String[] analysisColumnArray=columnsAnalysisList.get(i).split("::");
			
			obj.put("text",analysisColumnArray[0]);
			obj.put("datafield",analysisColumnArray[1]);
			obj.put("cellsAlign",analysisColumnArray[2]);
			obj.put("align",analysisColumnArray[3]);
			if(!(analysisColumnArray[4].trim().equalsIgnoreCase(""))){
				obj.put("hidden",analysisColumnArray[4]);
		    }
			if(!(analysisColumnArray[5].trim().equalsIgnoreCase(""))){
				obj.put("width",analysisColumnArray[5]);
		    }
			if(!(analysisColumnArray[6].trim().equalsIgnoreCase(""))){
			    obj.put("cellsFormat",analysisColumnArray[6]);
			}
			if(!(analysisColumnArray[7].trim().equalsIgnoreCase(""))){
			    obj.put("cellclassname",analysisColumnArray[7]);
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("columns",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		JSONArray jsonArray1 = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			int length = analysisRowArray.size();
			
			obj.put("id",analysisRowArray.get(0));
			obj.put("description",analysisRowArray.get(1));
			obj.put("total",analysisRowArray.get(2));
			
			for (int j = 3,k=0; j < length; j++,k++) {
				if(!(analysisRowArray.get(j).trim().equalsIgnoreCase(""))){
					obj.put("amount"+k,analysisRowArray.get(j));
				}
			}
			
			jsonArray.add(obj);
		}
		JSONObject obj1 = new JSONObject();
		obj1.put("rows",jsonArray);
		jsonArray1.add(obj1);
		return jsonArray1;
		}
		
	
	public JSONArray salesManSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsal=conn.createStatement();
			
			String strSql="select doc_no,sal_name from my_salm where status=3";
            
			ResultSet resultSet = stmtsal.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtsal.close();
			conn.close();
			
			return RESULTDATA;
  
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		
        return RESULTDATA;
    }
	
	public JSONArray deptSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select department dept, doc_no from my_dept where status<>7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray cshSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select if(paymode=1,'CASH','CREDIT')name,paymode as doc_no from my_invm group by paymode";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray cdtSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select sa.doc_no saldocno,sa.sal_name,ac.per_mob,m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,"
					+ "m.ref_type rrefno from my_invm m  left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sa on (sa.doc_no=ac.sal_id and ac.dtype='CRM' ) where m.status=3 and ftype=0 and paymode=2";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray catSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select category, doc_no from my_catm where status<>7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
}
