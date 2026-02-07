<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="net.sf.json.JSONArray"%>
<%	
   
	 class ClsStatusDAO {
	 ClsConnection con=new ClsConnection();
		ClsCommon cm=new ClsCommon();
		public JSONArray getEnqJobStatusCount(String from,String to, HttpServletRequest request,String branch,String salesman)throws SQLException{
			
			
			JSONArray RESULTDATA=new JSONArray();
				
			
			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			String sqltst="";
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
			sqlfromdate=cm.changeStringtoSqlDate(from);
			}
			if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
				sqltodate=cm.changeStringtoSqlDate(to);
				}
			
			if(!(branch.equalsIgnoreCase("undefined"))&&!(branch.equalsIgnoreCase(""))&&!(branch.equalsIgnoreCase("0"))){
				sqltst="and en.brhid="+branch;
				}
			
			if(!(salesman.equalsIgnoreCase("undefined"))&&!(salesman.equalsIgnoreCase(""))&&!(salesman.equalsIgnoreCase("0"))){
				sqltst+=" and en.sal_id="+salesman;
				}
		 	if((sqlfromdate==null)&&(sqltodate==null)){
	            return RESULTDATA;
	        } 
			try {
				conn = con.getMyConnection();
				stmt = conn.createStatement ();
				//System.out.println("=====loadTrafficdaily");
			    ArrayList<String> arr =new ArrayList<String>();
			    String temp="";  
				java.sql.Date sdate = null;
				String strSql="select m.doc_no,coalesce(bh.branchname,'') branch,m.sal_name salesman,coalesce(enq,0) enqs ,coalesce(cnt,0) jobs,coalesce(qts,0) qots,coalesce(round((coalesce(cnt,0)/coalesce(enq,0)*100),0),'0')perjob from my_salm m "
						+ "left join (select date,brhid,sal_id,count(*) enq from gl_enqm where status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"'  group by sal_id) en  on en.sal_id=m.doc_no left join my_brch bh on en.brhid=bh.doc_no "
						+ "left join (select count(*) cnt,sal_id from cm_srvcontrm e where status=3 and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' group by sal_id) cn on cn.sal_id=m.doc_no left join (select count(*) qts,sal_id from cm_srvqotm qt "
					    + "where status=3 and qt.date between '"+sqlfromdate+"' and '"+sqltodate+"' group by sal_id) qn on qn.sal_id=m.doc_no where m.status=3 "+sqltst+" and (coalesce(enq,0) or coalesce(cnt,0) or coalesce(qts,0) ) ";
		     	
		    	
						
				System.out.println("=enqjobstatus="+strSql);
				resultSet = stmt.executeQuery (strSql);
				int rowcount=1;
				
				while(resultSet.next()){
					 
						 
						temp=rowcount+"::"+resultSet.getString("branch")+"::"+resultSet.getString("salesman")+"::"+
								resultSet.getString("enqs")+"::"+resultSet.getString("qots")+"::"+resultSet.getString("jobs")+"::"+
								resultSet.getString("perjob");
						arr.add(temp);
						rowcount++;
		
						/* bean.setFirstarray(1); */
					
			          }
			    resultSet.beforeFirst();
				request.setAttribute("details", arr);
				RESULTDATA=cm.convertToJSON(resultSet);
				//getPrint(from,to,request,conn);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
		
		public void getPrint(String from,String to, HttpServletRequest request,Connection conn) throws SQLException {
			
			  
			try {
					

					  ClsAmountToWords c = new ClsAmountToWords();
					 
					Statement stmt = conn.createStatement ();
					
					java.sql.Date sqlfromdate=null,sqltodate=null;
					if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
					sqlfromdate=cm.changeStringtoSqlDate(from);
					}
					if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
						sqltodate=cm.changeStringtoSqlDate(to);
						}
					
						//System.out.println("=====loadTrafficdaily");
					    ArrayList<String> arr =new ArrayList<String>();
					    String temp="";  
						java.sql.Date sdate = null;
						String strSql="select m.doc_no,coalesce(bh.branchname,'') branch,m.sal_name salesman,coalesce(enq,0) enqs ,coalesce(cnt,0) jobs,coalesce(qts,0) qots,coalesce(round((coalesce(cnt,0)/coalesce(enq,0)*100),0),'0')perjob from my_salm m "
								+ "left join (select date,brhid,sal_id,count(*) enq from gl_enqm where status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"'  group by sal_id) en  on en.sal_id=m.doc_no left join my_brch bh on en.brhid=bh.doc_no "
								+ "left join (select count(*) cnt,sal_id from cm_srvcontrm e where status=3 and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' group by sal_id) cn on cn.sal_id=m.doc_no left join (select count(*) qts,sal_id from cm_srvqotm qt "
							    + "where status=3 and qt.date between '"+sqlfromdate+"' and '"+sqltodate+"' group by sal_id) qn on qn.sal_id=m.doc_no where m.status=3 ";
				     	
				    	
								
						System.out.println("=enqjobstatusDAO="+strSql);
						ResultSet	resultSet = stmt.executeQuery (strSql);
						int rowcount=1;
						
						while(resultSet.next()){
							 
								 
								temp=rowcount+"::"+resultSet.getString("branch")+"::"+resultSet.getString("salesman")+"::"+
										resultSet.getString("enqs")+"::"+resultSet.getString("qots")+"::"+resultSet.getString("jobs")+"::"+
										resultSet.getString("perjob");
								arr.add(temp);
								rowcount++;
				
								/* bean.setFirstarray(1); */
							
					          }
					             
						request.setAttribute("details", arr);
						stmt.close();
				
			}
			catch(Exception e){
				
				e.printStackTrace();
			}
			
			
		
		}
		
        public JSONArray getInstSalColRept(String from, HttpServletRequest request,String branch,String salesman)throws SQLException{
			
			
			JSONArray RESULTDATA=new JSONArray();
				
			
			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			
			try {
				conn = con.getMyConnection();
				stmt = conn.createStatement ();
				//System.out.println("=====loadTrafficdaily");
				String sqltst="",sqltst2="";
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
				sqlfromdate=cm.changeStringtoSqlDate(from);
				}
				if(!(branch.equalsIgnoreCase("undefined"))&&!(branch.equalsIgnoreCase(""))&&!(branch.equalsIgnoreCase("0"))){
					sqltst="and q.brhid="+branch;
					}
				
				if(!(salesman.equalsIgnoreCase("undefined"))&&!(salesman.equalsIgnoreCase(""))&&!(salesman.equalsIgnoreCase("0"))){
					sqltst+=" and m.sal_id="+salesman;
					}
				if(!(branch.equalsIgnoreCase("undefined"))&&!(branch.equalsIgnoreCase(""))&&!(branch.equalsIgnoreCase("0"))){
					sqltst2="and c.brhid="+branch;
					}
				
				if(!(salesman.equalsIgnoreCase("undefined"))&&!(salesman.equalsIgnoreCase(""))&&!(salesman.equalsIgnoreCase("0"))){
					sqltst2+=" and c.sal_id="+salesman;
					}
				/* if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
					sqltodate=cm.changeStringtoSqlDate(to);
					} */
				if((sqlfromdate==null)){
		            return RESULTDATA;
		        } 
					 ArrayList<String> arr =new ArrayList<String>();
					    String temp="";  
				java.sql.Date sdate = null;
				String strSql="select coalesce(brch,'') as brch, SALNAME, format(sum(lastjipvalue),2)lastinst, format(sum(curjipvalue),2)curinst, format(sum(curyrt),2)cursales, format(sum(lastyrt),2)lastsales from "
						       + "(select brch,salname,0 lastjipvalue,0 curjipvalue,round(coalesce(sum(curyr),0),2) curyrt,round(coalesce(sum(lastyr),0),2) lastyrt from "
						       + "(SELECT b.doc_no,m.date JOBDATE,m.netamount JOBAMOUNT, if(MONTH(M.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(M.date),"
						       + "m.netamount,0) lastyr, if(MONTH(M.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')=YEAR(M.date),m.netamount,0)  curyr ,B.BRANCHNAME brch,"
						       + "COALESCE(S.SAL_NAME,'') SALNAME FROM CM_SRVCONTRM M LEFT JOIN MY_BRCH B ON B.DOC_NO=m.BRHID "
						       + "LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' WHERE M.status=3 "+sqltst+" ) n  group by brch,salname having curyrt!=0 or lastyrt!=0 "
						       + "union all "
						       + "select coalesce(B.BRANCHNAME,'') brch,COALESCE(S.SAL_NAME,'') SALNAME,j.lastjipvalue, j.curjipvalue,0,0 from ( select brhid,sal_id,count(*) cn,sum(lastjipvalue) lastjipvalue,sum(curjipvalue) curjipvalue from " 
						       + "( select jobno,brhid, sal_id, ROUND(AMT*((max(curyr)-max(prevcuryr))/100),2) curjipvalue,ROUND(AMT*((max(lastyr)-max(prevlastyr))/100),2) lastjipvalue from "
						       + "( select c.doc_no jobno,c.sal_id,c.brhid,(m.wrkper) wrkper,rtrno, if(MONTH(d.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(d.date),d.wrkper,0)  lastyr ,"
						       + "if(d.date <= last_day(date_sub('"+sqlfromdate+"', interval 13 month)),d.wrkper,0)  prevlastyr , if(MONTH(d.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')=YEAR(d.date),d.wrkper,0)  curyr ," 
						       + "if(d.date <= last_day(date_sub('"+sqlfromdate+"', interval 1 month)),d.wrkper,0)  prevcuryr, ROUND(C.NETAMOUNT,2) AMT  from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno "
						       + "LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE where m.status=3 "+sqltst2+" ORDER BY M.DOC_NO,C.DOC_NO ) b group by b.jobno ) a group by brhid,sal_id ) j "
						       + "LEFT JOIN MY_BRCH B ON B.DOC_NO=j.BRHID LEFT JOIN my_salm S ON S.DOC_NO=j.SAL_ID where curjipvalue!=0 or lastjipvalue!=0 and j.sal_id!=0 ) a group by brch,salname";
		     	
		    	
						
				System.out.println("=instsalcolrept="+strSql);
				resultSet = stmt.executeQuery (strSql);
				int rowcount=1;
				
				while(resultSet.next()){
					 
						 
						temp=rowcount+"::"+resultSet.getString("brch")+"::"+resultSet.getString("salname")+"::"+
								resultSet.getString("lastsales")+"::"+resultSet.getString("cursales");
						arr.add(temp);
						rowcount++;
		
						/* bean.setFirstarray(1); */
					
			          }
				resultSet.beforeFirst();        
				request.setAttribute("instsalcoldetails", arr);
				RESULTDATA=cm.convertToJSON(resultSet);
				//getInstSalColReptPrint(from,request,conn);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
        
        public void getInstSalColReptPrint(String from, HttpServletRequest request,Connection conn) throws SQLException {
			
			  
			try {
					

					  ClsAmountToWords c = new ClsAmountToWords();
					 
					Statement stmt = conn.createStatement ();
					
					java.sql.Date sqlfromdate=null,sqltodate=null;
					if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
					sqlfromdate=cm.changeStringtoSqlDate(from);
					}
					/* if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
						sqltodate=cm.changeStringtoSqlDate(to);
						} */
					
						//System.out.println("=====loadTrafficdaily");
					    ArrayList<String> arr =new ArrayList<String>();
					    String temp="";  
						java.sql.Date sdate = null;
						String strSql="select brch, SALNAME, sum(lastjipvalue)lastinst, sum(curjipvalue)curinst, sum(curyrt)cursales, sum(lastyrt)lastsales from "
							       + "(select brch,salname,0 lastjipvalue,0 curjipvalue,coalesce(sum(curyr),0) curyrt,round(coalesce(sum(lastyr),0),2) lastyrt from "
							       + "(SELECT b.doc_no,m.salesbookdate JOBDATE,m.netamount JOBAMOUNT, if(MONTH(M.salesbookdate) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(M.salesbookdate),"
							       + "m.netamount,0) lastyr, if(MONTH(M.salesbookdate) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')=YEAR(M.salesbookdate),m.netamount,0)  curyr ,B.BRANCHNAME brch,"
							       + "COALESCE(S.SAL_NAME,'') SALNAME FROM CM_SRVCONTRM M left join cm_srvqotm q on q.tr_no=m.reftrno LEFT JOIN MY_BRCH B ON B.DOC_NO=q.BRHID "
							       + "LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' WHERE M.status=3 ) n  group by brch,salname having curyrt!=0 or lastyrt!=0 "
							       + "union all "
							       + "select B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') SALNAME,j.lastjipvalue, j.curjipvalue,0,0 from ( select brhid,sal_id,count(*) cn,sum(lastjipvalue) lastjipvalue,sum(curjipvalue) curjipvalue from " 
							       + "( select jobno,brhid, sal_id, ROUND(AMT*((max(curyr)-max(prevcuryr))/100),2) curjipvalue,ROUND(AMT*((max(lastyr)-max(prevlastyr))/100),2) lastjipvalue from "
							       + "( select c.doc_no jobno,c.sal_id,c.brhid,(m.wrkper) wrkper,rtrno, if(MONTH(d.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(d.date),d.wrkper,0)  lastyr ,"
							       + "if(d.date <= last_day(date_sub('"+sqlfromdate+"', interval 13 month)),d.wrkper,0)  prevlastyr , if(MONTH(d.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')=YEAR(d.date),d.wrkper,0)  curyr ," 
							       + "if(d.date <= last_day(date_sub('"+sqlfromdate+"', interval 1 month)),d.wrkper,0)  prevcuryr, ROUND(C.NETAMOUNT,2) AMT  from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno "
							       + "LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE where m.status=3  ORDER BY M.DOC_NO,C.DOC_NO ) b group by b.jobno ) a group by brhid,sal_id ) j "
							       + "LEFT JOIN MY_BRCH B ON B.DOC_NO=j.BRHID LEFT JOIN my_salm S ON S.DOC_NO=j.SAL_ID where curjipvalue!=0 or lastjipvalue!=0) a group by brch,salname";
				     	
				    	
								
						System.out.println("=instsalcolreptprint="+strSql);
						ResultSet	resultSet = stmt.executeQuery (strSql);
						int rowcount=1;
						
						while(resultSet.next()){
							 
								 
								temp=rowcount+"::"+resultSet.getString("brch")+"::"+resultSet.getString("salname")+"::"+
										resultSet.getString("curinst")+"::"+resultSet.getString("lastinst")+"::"+resultSet.getString("lastsales")+"::"+
										resultSet.getString("cursales");
								arr.add(temp);
								rowcount++;
				
								/* bean.setFirstarray(1); */
							
					          }
					             
						request.setAttribute("instsalcoldetails", arr);
						stmt.close();
				
			}
			catch(Exception e){
				
				e.printStackTrace();
			}
			
			
		
		}
        
        public JSONArray getCashFlow(String from, HttpServletRequest request,String branch)throws SQLException{
			
			
			JSONArray RESULTDATA=new JSONArray();
				
			
			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			
			try {
				conn = con.getMyConnection();
				stmt = conn.createStatement ();
				//System.out.println("=====loadTrafficdaily");
				java.sql.Date sqlfromdate=null,sqltodate=null;
				String sqltst="";
				if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
				sqlfromdate=cm.changeStringtoSqlDate(from);
				}
				if(!(branch.equalsIgnoreCase("undefined"))&&!(branch.equalsIgnoreCase(""))&&!(branch.equalsIgnoreCase("0"))){
					sqltst="and jv.brhid="+branch;
					}
				/* if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
					sqltodate=cm.changeStringtoSqlDate(to);
					} */
				if((sqlfromdate==null)){
		            return RESULTDATA;
		        }
			    ArrayList<String> arr =new ArrayList<String>();
			    String temp=""; 
				java.sql.Date sdate = null;
				String strSql="select  a.branchname,a.acno,a.date,format(sum(a.cashincurrent),2)cashincurrent,format(sum(a.cashinlast),2)cashinlast,format((sum(a.cashincurrent)-sum(a.cashinlast)),2)cashinDiff,"
						        + "format(sum(a.cashoutcurrent)*-1,2) cashoutcurrent,format(sum(a.cashoutlast)*-1,2) cashoutlast,format((sum(a.cashoutcurrent)-sum(a.cashoutlast)),2)cashoutDiff from(select jv.brhid,bh.branchname,"
								+ "jv.acno,jv.date,if(dramount>0,round(dramount,2),0) 'cashincurrent',if(dramount<0,round(dramount,2),0) 'cashoutcurrent',0 'cashinlast',0 'cashoutlast' from my_head h "
								+ "left join my_jvtran jv on h.doc_no=jv.acno left join my_brch bh on jv.brhid=bh.doc_no "
						        + "WHERE h.den=604 and h.m_s=0 and jv.status=3 "+sqltst+" and MONTH(jv.date) = MONTH('"+sqlfromdate+"') AND YEAR(jv.date) = YEAR('"+sqlfromdate+"') "
						        + "union all "
						        + "select jv.brhid,bh.branchname,jv.acno,jv.date,0 'cashincurrent',0 'cashoutcurrent',if(dramount>0,round(dramount,2),0) 'cashinlast',if(dramount<0,round(dramount,2),0) 'cashoutlast' from my_head h " 
						        + "left join my_jvtran jv on h.doc_no=jv.acno left join my_brch bh on jv.brhid=bh.doc_no "
						        + "WHERE h.den=604 and h.m_s=0 and jv.status=3 "+sqltst+" and MONTH(jv.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(jv.date))a group by a.brhid";
		     	
		    	
						
				System.out.println("=cashflow="+strSql);
				resultSet = stmt.executeQuery (strSql);
				int rowcount=1;
				
				while(resultSet.next()){
					 
						 
						temp=rowcount+"::"+resultSet.getString("branchname")+"::"+resultSet.getString("cashincurrent")+"::"+
								resultSet.getString("cashinlast")+"::"+resultSet.getString("cashindiff")+"::"+resultSet.getString("cashoutcurrent")+"::"+
								resultSet.getString("cashoutlast")+"::"+resultSet.getString("cashoutdiff");
						arr.add(temp);
						rowcount++;
		
						/* bean.setFirstarray(1); */
					
			          }
				resultSet.beforeFirst();         
				request.setAttribute("cshflw", arr);
				RESULTDATA=cm.convertToJSON(resultSet);
				//getCashFlowPrint(from,request,conn);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
        
        public void getCashFlowPrint(String from, HttpServletRequest request,Connection conn) throws SQLException {
			
			  
			try {
					

					  ClsAmountToWords c = new ClsAmountToWords();
					 
					Statement stmt = conn.createStatement ();
					
					java.sql.Date sqlfromdate=null,sqltodate=null;
					if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
					sqlfromdate=cm.changeStringtoSqlDate(from);
					}
					/* if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
						sqltodate=cm.changeStringtoSqlDate(to);
						} */
					
						//System.out.println("=====loadTrafficdaily");
					    ArrayList<String> arr =new ArrayList<String>();
					    String temp="";  
						java.sql.Date sdate = null;
						String strSql="select  a.branchname,a.acno,a.date,sum(a.cashincurrent)cashincurrent,sum(a.cashinlast)cashinlast,(sum(a.cashincurrent)-sum(a.cashinlast))cashinDiff,"
						        + "sum(a.cashoutcurrent)cashoutcurrent,sum(a.cashoutlast)cashoutlast,(sum(a.cashoutcurrent)-sum(a.cashoutlast))cashoutDiff from(select jv.brhid,bh.branchname,"
								+ "jv.acno,jv.date,if(dramount>0,round(dramount,2),0) 'cashincurrent',if(dramount<0,round(dramount,2),0) 'cashoutcurrent',0 'cashinlast',0 'cashoutlast' from my_head h "
								+ "left join my_jvtran jv on h.doc_no=jv.acno left join my_brch bh on jv.brhid=bh.doc_no "
						        + "WHERE h.den=604 and h.m_s=0 and jv.status=3 and MONTH(jv.date) = MONTH('"+sqlfromdate+"') AND YEAR(jv.date) = YEAR('"+sqlfromdate+"') "
						        + "union all "
						        + "select jv.brhid,bh.branchname,jv.acno,jv.date,0 'cashincurrent',0 'cashoutcurrent',if(dramount>0,round(dramount,2),0) 'cashinlast',if(dramount<0,round(dramount,2),0) 'cashoutlast' from my_head h " 
						        + "left join my_jvtran jv on h.doc_no=jv.acno left join my_brch bh on jv.brhid=bh.doc_no "
						        + "WHERE h.den=604 and h.m_s=0 and jv.status=3 and MONTH(jv.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(jv.date))a group by a.brhid";
				     	
				    	
								
						System.out.println("=cashflowprint="+strSql);
						ResultSet	resultSet = stmt.executeQuery (strSql);
						int rowcount=1;
						
						while(resultSet.next()){
							 
								 
								temp=rowcount+"::"+resultSet.getString("branchname")+"::"+resultSet.getString("cashincurrent")+"::"+
										resultSet.getString("cashinlast")+"::"+resultSet.getString("cashindiff")+"::"+resultSet.getString("cashoutcurrent")+"::"+
										resultSet.getString("cashoutlast")+"::"+resultSet.getString("cashoutdiff");
								arr.add(temp);
								rowcount++;
				
								/* bean.setFirstarray(1); */
							
					          }
					             
						request.setAttribute("cshflw", arr);
						stmt.close();
				
			}
			catch(Exception e){
				
				e.printStackTrace();
			}
			
			
		
		}
        
        public JSONArray getExpInstProg()throws SQLException{
			
			
			JSONArray RESULTDATA=new JSONArray();
				
			
			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			
			try {
				conn = con.getMyConnection();
				stmt = conn.createStatement ();
				//System.out.println("=====loadTrafficdaily");
			
				java.sql.Date sdate = null;
				String strSql="select name status,code,count(*) count  from cm_processlog m left join cm_status pd on m.statusid=pd.doc_no"
								+ " where m.outdatetime is null   and m.jobno=0  group by statusid";
		     	
		    	
						
				System.out.println("=enqjobstatus="+strSql);
				resultSet = stmt.executeQuery (strSql);
				RESULTDATA=cm.convertToJSON(resultSet);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
        public JSONArray getZonSalRept(String from, HttpServletRequest request,String branch,String amount1,String amount2)throws SQLException{
			
			
			JSONArray RESULTDATA=new JSONArray();
				
			
			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			
			try {
				conn = con.getMyConnection();
				stmt = conn.createStatement ();
			System.out.println("=====amount===="+amount1+"=======amount2====="+amount2);
				String sqltst="",sqltst2="";
				java.sql.Date sqlfromdate=null,sqltodate=null;
				if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
				sqlfromdate=cm.changeStringtoSqlDate(from);
				}
				if(!(branch.equalsIgnoreCase("undefined"))&&!(branch.equalsIgnoreCase(""))&&!(branch.equalsIgnoreCase("0"))){
					sqltst="and r.brhid="+branch;
					}
				
				if(!(amount1.equalsIgnoreCase(""))&&!(amount2.equalsIgnoreCase(""))){
					sqltst2=" where g.lastyearcurmonthamount between "+amount1+" and "+amount2+" or g.curyearcurmonthamount between "+amount1+" and "+amount2+"";
					}
				/* if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
					sqltodate=cm.changeStringtoSqlDate(to);
					} */
				if((sqlfromdate==null)){
		            return RESULTDATA;
		        } 
			   ArrayList<String> arr =new ArrayList<String>();
			   String temp="";
				java.sql.Date sdate = null;
				String strSql="select coalesce(g.zone,'') zone,g.branchname,format(g.curyearcurmonthamount,2)curyearcurmonthamount,format(g.lastyearcurmonthamount,2)lastyearcurmonthamount,format(g.diff,2)diff from(select f.city_name zone,f.branchname,f.area,round(sum(f.curyearcurmonthamount),2)curyearcurmonthamount,round(sum(f.lastyearcurmonthamount),2)lastyearcurmonthamount,round((sum(f.curyearcurmonthamount)-sum(f.lastyearcurmonthamount)),2)diff "
						+ "from(SELECT a1.city_id,ci.city_name,a.area area1,a1.area area2,r.brhid,r.date,bh.branchname,coalesce(a.area,a1.area) area,sum(netamount) curyearcurmonthamount,0 'lastyearcurmonthamount' FROM  my_servm r "
						+ "left join my_brch bh on r.brhid=bh.doc_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='crm'  left join my_area a1 on a.area_id=a1.doc_no left join my_acity ci on a1.city_id=ci.doc_no  "
						+ "where MONTH(r.date) = MONTH('"+sqlfromdate+"') AND YEAR(r.date) = YEAR('"+sqlfromdate+"') "+sqltst+" group by a1.city_id,r.brhid "
						+ "union all "
						+ "SELECT a1.city_id,ci.city_name,a.area area1,a1.area area2,r.brhid,r.date,bh.branchname,coalesce(a.area,a1.area) area,0 'curyearcurmonthamount',sum(netamount) lastyearcurmonthamount FROM  my_servm r " 
						+ "left join my_brch bh on r.brhid=bh.doc_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='crm'  left join my_area a1 on a.area_id=a1.doc_no left join my_acity ci on a1.city_id=ci.doc_no "
						+ "where MONTH(r.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(r.date) "+sqltst+" group by a1.city_id,r.brhid)f group by f.city_id,f.brhid)g "+sqltst2+"";
		     	
		    	
						
				System.out.println("=zonesql="+strSql);
				resultSet = stmt.executeQuery (strSql);
				int rowcount=1;
				
				while(resultSet.next()){
					 
						 
						temp=rowcount+"::"+resultSet.getString("branchname")+"::"+resultSet.getString("zone")+"::"+
								resultSet.getString("curyearcurmonthamount")+"::"+resultSet.getString("lastyearcurmonthamount")+"::"+resultSet.getString("diff");
								
						arr.add(temp);
						rowcount++;
		
						/* bean.setFirstarray(1); */
					
			          }
				resultSet.beforeFirst();        
				request.setAttribute("zone", arr);
				RESULTDATA=cm.convertToJSON(resultSet);
				//getZonSalReptPrint(from,request,conn);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
        
        public void getZonSalReptPrint(String from, HttpServletRequest request,Connection conn) throws SQLException {
			
			  
			try {
					

					  ClsAmountToWords c = new ClsAmountToWords();
					 
					Statement stmt = conn.createStatement ();
					
					java.sql.Date sqlfromdate=null,sqltodate=null;
					if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
					sqlfromdate=cm.changeStringtoSqlDate(from);
					}
					/* if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
						sqltodate=cm.changeStringtoSqlDate(to);
						} */
					
						//System.out.println("=====loadTrafficdaily");
					    ArrayList<String> arr =new ArrayList<String>();
					    String temp="";  
						java.sql.Date sdate = null;
						String strSql="select f.city_name zone,f.branchname,f.area,sum(f.curyearcurmonthamount)curyearcurmonthamount,sum(f.lastyearcurmonthamount)lastyearcurmonthamount,round((sum(f.curyearcurmonthamount)-sum(f.lastyearcurmonthamount)),2)diff "
								+ "from(SELECT a1.city_id,ci.city_name,a.area area1,a1.area area2,r.brhid,r.date,bh.branchname,coalesce(a.area,a1.area) area,sum(netamt) curyearcurmonthamount,0 'lastyearcurmonthamount' FROM  gl_rentreceipt r "
								+ "left join my_brch bh on r.brhid=bh.doc_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='crm'  left join my_area a1 on a.area_id=a1.doc_no left join my_acity ci on a1.city_id=ci.doc_no  "
								+ "where MONTH(r.date) = MONTH('"+sqlfromdate+"') AND YEAR(r.date) = YEAR('"+sqlfromdate+"')group by a1.city_id,r.brhid "
								+ "union all "
								+ "SELECT a1.city_id,ci.city_name,a.area area1,a1.area area2,r.brhid,r.date,bh.branchname,coalesce(a.area,a1.area) area,0 'curyearcurmonthamount',sum(netamt) lastyearcurmonthamount FROM  gl_rentreceipt r " 
								+ "left join my_brch bh on r.brhid=bh.doc_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='crm'  left join my_area a1 on a.area_id=a1.doc_no left join my_acity ci on a1.city_id=ci.doc_no "
								+ "where MONTH(r.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(r.date)group by a1.city_id,r.brhid)f group by f.city_id,f.brhid";
				     	
				    	
								
						System.out.println("=zonewisesalesprint="+strSql);
						ResultSet	resultSet = stmt.executeQuery (strSql);
						int rowcount=1;
						
						while(resultSet.next()){
							 
								 
								temp=rowcount+"::"+resultSet.getString("branchname")+"::"+resultSet.getString("zone")+"::"+
										resultSet.getString("curyearcurmonthamount")+"::"+resultSet.getString("lastyearcurmonthamount")+"::"+resultSet.getString("diff");
										
								arr.add(temp);
								rowcount++;
				
								/* bean.setFirstarray(1); */
							
					          }
					             
						request.setAttribute("zone", arr);
						stmt.close();
				
			}
			catch(Exception e){
				
				e.printStackTrace();
			}
			
			
		
		}
        
		public JSONArray getStatusCount(String from,String to, HttpServletRequest request,String branch,String salesman,String status)throws SQLException{
		
		
		JSONArray RESULTDATA=new JSONArray();
			
		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltst="";
		java.sql.Date sqlfromdate=null,sqltodate=null;
		 ArrayList<String> arr =new ArrayList<String>();
		    String temp="";  
		if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
		sqlfromdate=cm.changeStringtoSqlDate(from);
		}
		if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
			sqltodate=cm.changeStringtoSqlDate(to);
			}
		
		if(!(branch.equalsIgnoreCase("undefined"))&&!(branch.equalsIgnoreCase(""))&&!(branch.equalsIgnoreCase("0"))){
			sqltst="and en.brhid="+branch;
			}
		
		if(!(salesman.equalsIgnoreCase("undefined"))&&!(salesman.equalsIgnoreCase(""))&&!(salesman.equalsIgnoreCase("0"))){
			sqltst+=" and en.sal_id="+salesman;
			}
		
		if(!(status.equalsIgnoreCase("undefined"))&&!(status.equalsIgnoreCase(""))&&!(status.equalsIgnoreCase("0"))){
			sqltst+=" and m.statusid="+status;
			}
	 	if((sqlfromdate==null)&&(sqltodate==null)){
            return RESULTDATA;
        } 
		try {
			conn = con.getMyConnection();
			stmt = conn.createStatement ();
			//System.out.println("=====loadTrafficdaily");
		
			java.sql.Date sdate = null;
			String strSql="select bh.branchname branch,sm.sal_name salname,pd.name status,pd.code,count(*) count  from cm_processlog m "
					+ "left join gl_enqm en  on en.doc_no=m.enqno left join my_salm sm on sm.doc_no=en.sal_id left join my_brch bh on en.brhid=bh.doc_no "
					+ "left join cm_status pd on m.statusid=pd.doc_no where en.status=3 "+sqltst+" and m.outdatetime is null   and m.jobno=0 and en.date between '"+sqlfromdate+"' and '"+sqltodate+"' group by en.brhid,en.sal_id,statusid;";
	     	
	    	
					
			System.out.println("=Countgrid="+strSql);
			resultSet = stmt.executeQuery (strSql);
			int rowcount=1;
			
			while(resultSet.next()){
				 
					 
					temp=rowcount+"::"+resultSet.getString("branch")+"::"+resultSet.getString("salname")+"::"+
							resultSet.getString("status")+"::"+resultSet.getString("code")+"::"+resultSet.getString("count");
					arr.add(temp);
					rowcount++;
	
					/* bean.setFirstarray(1); */
				
		          }
			resultSet.beforeFirst();        
			request.setAttribute("enqcountdetails", arr);
			RESULTDATA=cm.convertToJSON(resultSet);
			//getEnqCountPrint(from,to,request,conn);
			
			//			System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
		
		public void getEnqCountPrint(String from,String to, HttpServletRequest request,Connection conn) throws SQLException {
			
			 
			try {
					  

					  ClsAmountToWords c = new ClsAmountToWords();
					 
					Statement stmt = conn.createStatement ();
					
					java.sql.Date sqlfromdate=null,sqltodate=null;
					if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
					sqlfromdate=cm.changeStringtoSqlDate(from);
					}
					if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
						sqltodate=cm.changeStringtoSqlDate(to);
						}
					
					
						//System.out.println("=====loadTrafficdaily");
					    ArrayList<String> arr =new ArrayList<String>();
					    String temp="";  
						java.sql.Date sdate = null;
						String strSql="select bh.branchname branch,sm.sal_name salname,pd.name status,pd.code,count(*) count  from cm_processlog m "
						+ "left join gl_enqm en  on en.doc_no=m.enqno left join my_salm sm on sm.doc_no=en.sal_id left join my_brch bh on en.brhid=bh.doc_no "
						+ "left join cm_status pd on m.statusid=pd.doc_no where en.status=3 and m.outdatetime is null   and m.jobno=0 and en.date between '"+sqlfromdate+"' and '"+sqltodate+"' group by en.brhid,en.sal_id,statusid";
				     	
				    	
								
						System.out.println("=enqcountDAO="+strSql);
						ResultSet	resultSet = stmt.executeQuery (strSql);
						int rowcount=1;
						
						while(resultSet.next()){
							 
								 
								temp=rowcount+"::"+resultSet.getString("branch")+"::"+resultSet.getString("salname")+"::"+
										resultSet.getString("status")+"::"+resultSet.getString("code")+"::"+resultSet.getString("count");
								arr.add(temp);
								rowcount++;
				
								/* bean.setFirstarray(1); */
							
					          }
					             
						request.setAttribute("enqcountdetails", arr);
						stmt.close();
				
			}
			catch(Exception e){
			
				e.printStackTrace();
			}
			
			
		
		}
		
		public JSONArray getJobStatusCount(String from,String to, HttpServletRequest request,String branch,String salesman,String status)throws SQLException{
			
			
			JSONArray RESULTDATA=new JSONArray();
				
			
			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			
			try {
				conn = con.getMyConnection();
				stmt = conn.createStatement ();
				//System.out.println("=====loadTrafficdaily");
			
				java.sql.Date sdate = null;
				java.sql.Date sqlfromdate=null,sqltodate=null;
				String sqltst="";
				if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
				sqlfromdate=cm.changeStringtoSqlDate(from);
				}
				if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
					sqltodate=cm.changeStringtoSqlDate(to);
					}
				if(!(branch.equalsIgnoreCase("undefined"))&&!(branch.equalsIgnoreCase(""))&&!(branch.equalsIgnoreCase("0"))){
					sqltst="and cn.brhid="+branch;
					}
				
				if(!(salesman.equalsIgnoreCase("undefined"))&&!(salesman.equalsIgnoreCase(""))&&!(salesman.equalsIgnoreCase("0"))){
					sqltst+=" and cn.sal_id="+salesman;
					}
				
				if(!(status.equalsIgnoreCase("undefined"))&&!(status.equalsIgnoreCase(""))&&!(status.equalsIgnoreCase("0"))){
					sqltst+=" and m.statusid="+status;
					}
				if((sqlfromdate==null)&&(sqltodate==null)){
		            return RESULTDATA;
		        } 
				 ArrayList<String> arr =new ArrayList<String>();
				    String temp="";  
				String strSql="select bh.branchname branch,sm.sal_name salname,pd.name status,pd.code,count(*) count  from cm_processlog m left join cm_status pd on m.statusid=pd.doc_no "
						+ "left join cm_srvcontrm cn on cn.tr_no=m.doc_no left join my_salm sm on sm.doc_no=cn.sal_id left join my_brch bh on cn.brhid=bh.doc_no "
						+ " where cn.status=3 "+sqltst+" and cn.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.outdatetime is null   and m.jobno!=0  group by cn.brhid,cn.sal_id,statusid";
     				
						
				System.out.println("=Countgrid="+strSql);
				resultSet = stmt.executeQuery (strSql);
				int rowcount=1;
				
				while(resultSet.next()){
					 
						 
						temp=rowcount+"::"+resultSet.getString("branch")+"::"+resultSet.getString("salname")+"::"+
								resultSet.getString("status")+"::"+resultSet.getString("code")+"::"+resultSet.getString("count");
						arr.add(temp);
						rowcount++;
		
						/* bean.setFirstarray(1); */
					
			          }
				resultSet.beforeFirst();         
				request.setAttribute("enqcountdetails", arr);
				RESULTDATA=cm.convertToJSON(resultSet);
				//getJobCountPrint(from,to,request,conn);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
		
		public void getJobCountPrint(String from,String to, HttpServletRequest request,Connection conn) throws SQLException {
			
			 
			try {
					  

					  ClsAmountToWords c = new ClsAmountToWords();
					 
					Statement stmt = conn.createStatement ();
					
					java.sql.Date sqlfromdate=null,sqltodate=null;
					if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
					sqlfromdate=cm.changeStringtoSqlDate(from);
					}
					if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
						sqltodate=cm.changeStringtoSqlDate(to);
						}
					
					
						//System.out.println("=====loadTrafficdaily");
					    ArrayList<String> arr =new ArrayList<String>();
					    String temp="";  
						java.sql.Date sdate = null;
						String strSql="select bh.branchname branch,sm.sal_name salname,pd.name status,pd.code,count(*) count  from cm_processlog m left join cm_status pd on m.statusid=pd.doc_no "
								+ "left join cm_srvcontrm cn on cn.tr_no=m.doc_no left join my_salm sm on sm.doc_no=cn.sal_id left join my_brch bh on cn.brhid=bh.doc_no "
								+ " where cn.status=3 and cn.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.outdatetime is null   and m.jobno!=0  group by cn.brhid,cn.sal_id,statusid";				     	
				    	
								
						System.out.println("=jobcountDAO="+strSql);
						ResultSet	resultSet = stmt.executeQuery (strSql);
						int rowcount=1;
						
						while(resultSet.next()){
							 
								 
								temp=rowcount+"::"+resultSet.getString("branch")+"::"+resultSet.getString("salname")+"::"+
										resultSet.getString("status")+"::"+resultSet.getString("code")+"::"+resultSet.getString("count");
								arr.add(temp);
								rowcount++;
				
								/* bean.setFirstarray(1); */
							
					          }
					             
						request.setAttribute("enqcountdetails", arr);
						stmt.close();
				
			}
			catch(Exception e){
			
				e.printStackTrace();
			}
			
			
		
		}
		
public JSONArray getEnqSalCount()throws SQLException{
			
			
			JSONArray RESULTDATA=new JSONArray();
				
			
			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			
			try {
				conn = con.getMyConnection();
				stmt = conn.createStatement ();
				//System.out.println("=====loadTrafficdaily");
			
				java.sql.Date sdate = null;
		     	
		     	
		    	

				String strSql="select m.doc_no,m.sal_name salesman,coalesce(enq,0) enquiry ,coalesce(cnt,0) job from my_salm m left join"
						+ " (select sal_id,count(*) enq from gl_enqm where status=3  group by sal_id) en  on en.sal_id=m.doc_no left join"
						+ " (select count(*) cnt,sal_id from cm_srvcontrm e where status=3 group by sal_id) cn"
						 + " on cn.sal_id=m.doc_no where m.status=3 ";
				
						
				System.out.println("=Countgrid="+strSql);
				resultSet = stmt.executeQuery (strSql);
				RESULTDATA=cm.convertToJSON(resultSet);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
public JSONArray getJobSalCount()throws SQLException{
	
	
	JSONArray RESULTDATA=new JSONArray();
		
	
	Connection conn = null;
	Statement stmt =null;
	ResultSet resultSet=null;
	
	try {
		conn = con.getMyConnection();
		stmt = conn.createStatement ();
		//System.out.println("=====loadTrafficdaily");
	
		java.sql.Date sdate = null;
     	
     	
    	

		String strSql="select e.sal_id,m.sal_name ,count(*) count from cm_srvcontrm e left join my_salm m on e.sal_id=m.doc_no "
						+ " where e.status=3 and m.sal_name is not null group by e.sal_id";
		
				
		System.out.println("=Countgrid="+strSql);
		resultSet = stmt.executeQuery (strSql);
		RESULTDATA=cm.convertToJSON(resultSet);
		//			System.out.println("=====RESULTDATA"+RESULTDATA);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		stmt.close();
		conn.close();
	}
	return RESULTDATA;
}

public JSONArray getAreaCount(String from,HttpServletRequest request,String branch,String area )throws SQLException{
	
	
	JSONArray RESULTDATA=new JSONArray();
		
	
	Connection conn = null;
	Statement stmt =null;
	ResultSet resultSet=null;
	
	try {
		conn = con.getMyConnection();
		stmt = conn.createStatement ();
		//System.out.println("=====loadTrafficdaily");
		java.sql.Date sqlfromdate=null,sqltodate=null;
		String sqltst="";
		if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
		sqlfromdate=cm.changeStringtoSqlDate(from);
		}
		if(!(branch.equalsIgnoreCase("undefined"))&&!(branch.equalsIgnoreCase(""))&&!(branch.equalsIgnoreCase("0"))){
			sqltst="and r.brhid="+branch;
			}
		
		if(!(area.equalsIgnoreCase("undefined"))&&!(area.equalsIgnoreCase(""))&&!(area.equalsIgnoreCase("0"))){
			sqltst+=" and a.area_id="+area;
			}
		/* if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
			sqltodate=cm.changeStringtoSqlDate(to);
			} */
		java.sql.Date sdate = null;
		if((sqlfromdate==null)){
            return RESULTDATA;
        } 
     	
		  ArrayList<String> arr =new ArrayList<String>();
		    String temp="";  

		String strSql="select f.branchname,f.area,format(sum(f.curyearcurmonthamount),2)curyearcurmonthamount,format(sum(f.lastyearcurmonthamount),2)lastyearcurmonthamount,format((sum(f.curyearcurmonthamount)-sum(f.lastyearcurmonthamount)),2)diff from(SELECT a.area area1,"
				+ "a1.area area2,r.brhid,r.date,bh.branchname,coalesce(a.area,a1.area) area,sum(netamount) curyearcurmonthamount,0 'lastyearcurmonthamount' FROM  my_servm r left join my_brch bh on r.brhid=bh.doc_no left join my_acbook a on r.acno=a.acno and a.dtype='crm' " 
				+ "left join my_area a1 on a.area_id=a1.doc_no where  MONTH(r.date) = MONTH('"+sqlfromdate+"') AND YEAR(r.date) = YEAR('"+sqlfromdate+"') "+sqltst+" group by coalesce(a.area,a1.area),r.brhid "
				+ "union all "
				+ "SELECT a.area area1,a1.area area2,r.brhid,r.date,bh.branchname,coalesce(a.area,a1.area) area,0 'curyearcurmonthamount',sum(netamount) lastyearcurmonthamount FROM  my_servm r "
				+ "left join my_brch bh on r.brhid=bh.doc_no left join my_acbook a on r.acno=a.acno and a.dtype='crm'  left join my_area a1 on a.area_id=a1.doc_no "
				+ "where MONTH(r.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(r.date) "+sqltst+" group by coalesce(a.area,a1.area),r.brhid)f group by coalesce(f.area1,f.area2),f.brhid ";
		
				
		System.out.println("=Area="+strSql);
		resultSet = stmt.executeQuery (strSql);
		int rowcount=1;
		
		while(resultSet.next()){
			 
				 
				temp=rowcount+"::"+resultSet.getString("branchname")+"::"+resultSet.getString("area")+"::"+
						resultSet.getString("curyearcurmonthamount")+"::"+resultSet.getString("lastyearcurmonthamount")+"::"+resultSet.getString("diff");
						
				arr.add(temp);
				rowcount++;

				/* bean.setFirstarray(1); */
			
	          }
		resultSet.beforeFirst();         
		request.setAttribute("area", arr);
		RESULTDATA=cm.convertToJSON(resultSet);
		//getAreaCountPrint(from,request,conn);
		//			System.out.println("=====RESULTDATA"+RESULTDATA);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		stmt.close();
		conn.close();
	}
	return RESULTDATA;
}

public void getAreaCountPrint(String from, HttpServletRequest request,Connection conn) throws SQLException {
	
	  
	try {
			

			  ClsAmountToWords c = new ClsAmountToWords();
			 
			Statement stmt = conn.createStatement ();
			
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
			sqlfromdate=cm.changeStringtoSqlDate(from);
			}
			/* if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
				sqltodate=cm.changeStringtoSqlDate(to);
				} */
			
				//System.out.println("=====loadTrafficdaily");
			    ArrayList<String> arr =new ArrayList<String>();
			    String temp="";  
				java.sql.Date sdate = null;
				String strSql="select f.branchname,f.area,sum(f.curyearcurmonthamount)curyearcurmonthamount,sum(f.lastyearcurmonthamount)lastyearcurmonthamount,round((sum(f.curyearcurmonthamount)-sum(f.lastyearcurmonthamount)),2)diff from(SELECT a.area area1,"
						+ "a1.area area2,r.brhid,r.date,bh.branchname,coalesce(a.area,a1.area) area,sum(netamt) curyearcurmonthamount,0 'lastyearcurmonthamount' FROM  gl_rentreceipt r left join my_brch bh on r.brhid=bh.doc_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='crm' " 
						+ "left join my_area a1 on a.area_id=a1.doc_no where  MONTH(r.date) = MONTH('"+sqlfromdate+"') AND YEAR(r.date) = YEAR('"+sqlfromdate+"')group by coalesce(a.area,a1.area),r.brhid "
						+ "union all "
						+ "SELECT a.area area1,a1.area area2,r.brhid,r.date,bh.branchname,coalesce(a.area,a1.area) area,0 'curyearcurmonthamount',sum(netamt) lastyearcurmonthamount FROM  gl_rentreceipt r "
						+ "left join my_brch bh on r.brhid=bh.doc_no left join my_acbook a on r.cldocno=a.cldocno and a.dtype='crm'  left join my_area a1 on a.area_id=a1.doc_no "
						+ "where MONTH(r.date) = MONTH('"+sqlfromdate+"') and YEAR('"+sqlfromdate+"')-1=YEAR(r.date)group by coalesce(a.area,a1.area),r.brhid)f group by coalesce(f.area1,f.area2),f.brhid ";
						     	
		    	
						
				System.out.println("=areawisesalesprint="+strSql);
				ResultSet	resultSet = stmt.executeQuery (strSql);
				int rowcount=1;
				
				while(resultSet.next()){
					 
						 
						temp=rowcount+"::"+resultSet.getString("branchname")+"::"+resultSet.getString("area")+"::"+
								resultSet.getString("curyearcurmonthamount")+"::"+resultSet.getString("lastyearcurmonthamount")+"::"+resultSet.getString("diff");
								
						arr.add(temp);
						rowcount++;
		
						/* bean.setFirstarray(1); */
					
			          }
			             
				request.setAttribute("area", arr);
				stmt.close();
		
	}
	catch(Exception e){
		
		e.printStackTrace();
	}
	
	

}

public JSONArray getShowroomCount(String from,String to, HttpServletRequest request)throws SQLException{
	
	
	JSONArray RESULTDATA=new JSONArray();
		
	
	Connection conn = null;
	Statement stmt =null;
	ResultSet resultSet=null;
	
	try {
		conn = con.getMyConnection();
		stmt = conn.createStatement ();
		//System.out.println("=====loadTrafficdaily");
		java.sql.Date sqlfromdate=null,sqltodate=null;
		if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
		sqlfromdate=cm.changeStringtoSqlDate(from);
		}
		if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
			sqltodate=cm.changeStringtoSqlDate(to);
			}
		java.sql.Date sdate = null;
		if((sqlfromdate==null)&&(sqltodate==null)){
            return RESULTDATA;
        } 
     	
		ArrayList<String> arr =new ArrayList<String>();
	    String temp="";  

		String strSql="SELECT b.branchname showroom,format(sum(netamt),2) amount FROM  gl_rentreceipt r left join my_brch b on b.doc_no=r.brhid where r.date between '"+sqlfromdate+"' and '"+sqltodate+"' group by r.brhid ";
		
				
		System.out.println("=Showroom="+strSql);
		resultSet = stmt.executeQuery (strSql);
		int rowcount=1;
		
		while(resultSet.next()){
			 
				 
				temp=rowcount+"::"+resultSet.getString("showroom")+"::"+resultSet.getString("amount");
						
				arr.add(temp);
				rowcount++;

				/* bean.setFirstarray(1); */
			
	          }
		resultSet.beforeFirst();        
		request.setAttribute("shwrm", arr);
		RESULTDATA=cm.convertToJSON(resultSet);
		//getShowroomCountPrint(from,to,request,conn);
		//			System.out.println("=====RESULTDATA"+RESULTDATA);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		stmt.close();
		conn.close();
	}
	return RESULTDATA;
}

public JSONArray getUtilization(String from,String to,String jobno,String empid,String chk, HttpServletRequest request)throws SQLException{
	
	
	JSONArray RESULTDATA=new JSONArray();
		
	
	Connection conn = null;
	Statement stmt =null;
	ResultSet resultSet=null;
	
	try {
		conn = con.getMyConnection();
		stmt = conn.createStatement ();
		String sqltst="";
		if(!jobno.equalsIgnoreCase(""))
    	{
		  sqltst+=" and ts.costcode="+jobno+ " ";
    	}
		if(!empid.equalsIgnoreCase(""))
    	{
		  sqltst+=" and ts.empid="+empid+ " ";
    	}
		System.out.println("==job==="+jobno);
		java.sql.Date sqlfromdate=null,sqltodate=null;
		 if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
		sqlfromdate=cm.changeStringtoSqlDate(from);
		}
		if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
			sqltodate=cm.changeStringtoSqlDate(to);
			} 
		java.sql.Date sdate = null;
		/*  if(!chk.equalsIgnoreCase("1")){
            return RESULTDATA;
        } */  
		 if((sqlfromdate==null)&&(sqltodate==null)){
	            return RESULTDATA;
	        } 
		ArrayList<String> arr =new ArrayList<String>();
	    String temp="";  

		
		 String strSql="select coalesce(tp.name,'')name,tp.costcode,tp.costgroup costtype,sum(tp.labourhrs)labourhrs,CONVERT(concat(Floor(sum(tp.labourhrs)/60),':',(sum(tp.labourhrs)-(Floor(sum(tp.labourhrs)/60)*60))),CHAR(100)) labourhrstime,sum(tp.labourvalue) labourvalue,tp.empid from (select ts.empid,ts.costgroup,ts.costtype,ts.costcode, "
					+ "sum(ts.labourhrs) labourhrs,sum(ts.labourvalue) labourvalue, name from (select ts.empid,cu.costgroup,e.name,ts.costtype,ts.costcode,coalesce(normal,'0') labourhrs, round((SUBSTRING_INDEX(normalhrs,':',1) * ts.costperhour) + ((SUBSTRING_INDEX(normalhrs,':',-1)/60)*  ts.costperhour),2) labourvalue from  hr_timesheethrs ts "
							+ "left join hr_empm e on e.doc_no=ts.empid left join (select catid,max(doc_no) doc from hr_paycode where status=3 group by catid) c on e.pay_catid=c.catid  left join hr_paycode pc on e.pay_catid=pc.catid and pc.status=3 and c.doc=pc.doc_no left join my_costunit cu on ts.costtype=cu.costtype where ts.costtype in (3,4) "+sqltst+" and ts.date between '"+sqlfromdate+"' and '"+sqltodate+"') ts group by ts.costtype,ts.costcode,ts.empid)tp group by tp.empid,tp.costtype,tp.costcode";		     	
				
		System.out.println("=Utilization="+strSql);
		resultSet = stmt.executeQuery (strSql);
		    
		
		RESULTDATA=cm.convertToJSON(resultSet);
		getUtilizationPrint(from,to,jobno,empid,request,conn);
		//			System.out.println("=====RESULTDATA"+RESULTDATA);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		stmt.close();
		conn.close();
	}
	return RESULTDATA;
}


public void getUtilizationPrint(String from,String to,String jobno,String empid, HttpServletRequest request,Connection conn) throws SQLException {
	
	  
	try {
			

			  ClsAmountToWords c = new ClsAmountToWords();
			 
			Statement stmt = conn.createStatement ();
			String sqltst="";
			if(!jobno.equalsIgnoreCase(""))
	    	{
			  sqltst+=" and ts.costcode="+jobno+ " ";
	    	}
			if(!empid.equalsIgnoreCase(""))
	    	{
			  sqltst+=" and ts.empid="+empid+ " ";
	    	}
			java.sql.Date sqlfromdate=null,sqltodate=null;
			if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
			sqlfromdate=cm.changeStringtoSqlDate(from);
			}
			if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
				sqltodate=cm.changeStringtoSqlDate(to);
				}
			
				//System.out.println("=====loadTrafficdaily");
			    ArrayList<String> arr =new ArrayList<String>();
			    String temp="";  
				java.sql.Date sdate = null;
				 String strSql="select ts.costgroup costtype,ts.costcode,sum(ts.labourhrs) labourhrs,CONVERT(concat(Floor(sum(ts.labourhrs)/60),':',(sum(ts.labourhrs)-(Floor(sum(ts.labourhrs)/60)*60))),CHAR(100)) labourhrstime,sum(ts.labourvalue) labourvalue, "
							+ "name from (select ts.empid,cu.costgroup,e.name,ts.costtype,ts.costcode,coalesce(normal,'0') labourhrs, round((SUBSTRING_INDEX(normalhrs,':',1) * ts.costperhour) + ((SUBSTRING_INDEX(normalhrs,':',-1)/60)*  ts.costperhour),2) labourvalue from  hr_timesheethrs ts "
						   + "left join hr_empm e on e.doc_no=ts.empid left join (select catid,max(doc_no) doc from hr_paycode where status=3 group by catid) c on e.pay_catid=c.catid  left join hr_paycode pc on e.pay_catid=pc.catid and pc.status=3 and c.doc=pc.doc_no left join my_costunit cu on ts.costtype=cu.costtype where ts.costtype in (3,4) "+sqltst+" and ts.date between '"+sqlfromdate+"' and '"+sqltodate+"' and ts.empid is not null and ts.empid!=0) ts group by ts.empid,ts.costtype,ts.costcode"; 
		    	
						
				System.out.println("=utilizationprint="+strSql);
				ResultSet	resultSet = stmt.executeQuery (strSql);
				int rowcount=1;
				
				while(resultSet.next()){
					 
					 
					temp=rowcount+"::"+resultSet.getString("name")+"::"+resultSet.getString("costtype")+"::"+resultSet.getString("costcode")+"::"+resultSet.getString("labourhrs")+"::"+resultSet.getString("labourhrstime")+"::"+resultSet.getString("labourvalue");
							
					arr.add(temp);
					rowcount++;

					/* bean.setFirstarray(1); */
				
		          }
			             
				request.setAttribute("utlzn", arr);
				stmt.close();
		
	}
	catch(Exception e){
		
		e.printStackTrace();
	}
	
	

}

public JSONArray client(HttpSession session) throws SQLException{
	
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		//String brhid=session.getAttribute("BRANCHID").toString();

		sql="select p.enqno,c.doc_no jobno,ac.cldocno,ac.refname client from my_acbook ac left join cm_processlog p on p.cldocno=ac.cldocno left join cm_srvcontrm c on c.tr_no=p.jobno where  ac.dtype='CRM'  and enqno is not null group by enqno";
			System.out.println("===client===="+sql);
     
		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}
public JSONArray branch(HttpSession session) throws SQLException{
	
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		//String brhid=session.getAttribute("BRANCHID").toString();

		sql="select doc_no,branchname from my_brch";
			System.out.println("===bramch===="+sql);
     
		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}

public JSONArray employee(HttpSession session) throws SQLException{
	
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		//String brhid=session.getAttribute("BRANCHID").toString();

		sql="select doc_no,name from hr_empm";
			System.out.println("===bramch===="+sql);
     
		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}

public JSONArray status(HttpSession session) throws SQLException{
	
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		//String brhid=session.getAttribute("BRANCHID").toString();

		sql="select doc_no,name from cm_status";
			System.out.println("===status===="+sql);
     
		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}

public JSONArray jobnos(HttpSession session) throws SQLException{
	
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		//String brhid=session.getAttribute("BRANCHID").toString();

		sql="select doc_no,tr_no from cm_srvcontrm";
			System.out.println("===jonos===="+sql);
     
		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}


public JSONArray area(HttpSession session) throws SQLException{
	
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		//String brhid=session.getAttribute("BRANCHID").toString();

		sql="select doc_no,area from my_area";
			System.out.println("===area===="+sql);
     
		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}

public JSONArray salesman(HttpSession session) throws SQLException{
	
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql = "";
		//String brhid=session.getAttribute("BRANCHID").toString();

		sql="select doc_no,sal_name from my_salm";
			System.out.println("===salesman===="+sql);
     
		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}
public JSONArray searchenq(HttpSession session,String cldocno) throws SQLException{
	System.out.println("===enq1***====");
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		System.out.println("===try***====");                                                                                                
		String sql = "";      
		String sqltest1 = "";   
		//String brhid=session.getAttribute("BRANCHID").toString();
		if(!cldocno.equalsIgnoreCase("0"))
    	{
		  sqltest1+=" and p.cldocno="+cldocno+ " ";
    	}
		sql="select p.enqno,p.enqno enqnoid from my_acbook ac left join cm_processlog p on p.cldocno=ac.cldocno  where  dtype='CRM' "+sqltest1+" and enqno is not null group by enqno";
			System.out.println("===enq***===="+sql);   

		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);
   
	}  
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}
public JSONArray searchjob(HttpSession session,String cldocno) throws SQLException{
	System.out.println("===name***====");
	JSONArray RESULTDATA1=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		System.out.println("===try2***====");
		String sql = "";
		//String brhid=session.getAttribute("BRANCHID").toString();
		String sqltest1="";
		if(!cldocno.equalsIgnoreCase("0"))
    	{
		  sqltest1+=" and p.cldocno="+cldocno+ " ";
    	}
		sql="select c.doc_no jobno,c.doc_no jobnoid from my_acbook ac left join cm_processlog p on p.cldocno=ac.cldocno left join cm_srvcontrm c on c.tr_no=p.jobno where  ac.dtype='CRM' "+sqltest1+" and enqno is not null group by enqno ";
		System.out.println("===Name***===="+sql);   

		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1=cm.convertToJSON(resultSet1);

	}   
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}


	return RESULTDATA1;
}
public  JSONArray loadGridData(HttpSession session,String cldocno,String jobno,String enqno,String from,String to, HttpServletRequest request) throws SQLException {

	JSONArray RESULTDATA=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sqltest1="";
		java.sql.Date sqlfromdate=null,sqltodate=null;
		 ArrayList<String> arr =new ArrayList<String>();
		 String temp="";  
		if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
		sqlfromdate=cm.changeStringtoSqlDate(from);
		}
		if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
			sqltodate=cm.changeStringtoSqlDate(to);
			}
		
		if((sqlfromdate==null)&&(sqltodate==null)){
            return RESULTDATA;
        } 
		if(!cldocno.equalsIgnoreCase("0") && !cldocno.equalsIgnoreCase(""))
    	{
		  sqltest1+=" and  m.cldocno="+cldocno+" ";
			System.out.println("in cldocno=======");
     	}else if(!(jobno.equalsIgnoreCase("0") || jobno.equalsIgnoreCase("")) && (cldocno.equalsIgnoreCase("0")) || cldocno.equalsIgnoreCase("") && (enqno.equalsIgnoreCase("0")) || enqno.equalsIgnoreCase(""))
		    	{
		 		  sqltest1+=" and  c.doc_no ="+jobno+ " ";   
		 			System.out.println("in jobno nocl======="+jobno);
		     	}
     	else if(!(enqno.equalsIgnoreCase("0") || enqno.equalsIgnoreCase("")) && (cldocno.equalsIgnoreCase("0")) || cldocno.equalsIgnoreCase("") && (jobno.equalsIgnoreCase("0")) || jobno.equalsIgnoreCase(""))
    	{
 		  sqltest1+=" and  m.enqno="+enqno+ " ";
 			System.out.println("in enqno nocl=======");
     	}
     	else{
     		
		}
		 if(!(jobno.equalsIgnoreCase("0") || jobno.equalsIgnoreCase("")) && !(cldocno.equalsIgnoreCase("0") || cldocno.equalsIgnoreCase(""))){
			 
		 			sqltest1+=" and  c.doc_no ="+jobno+ " ";
		 			System.out.println("in both jobno======="+jobno);   
		 	}  
		 if(!(enqno.equalsIgnoreCase("0") || enqno.equalsIgnoreCase("")) && !(cldocno.equalsIgnoreCase("0") || cldocno.equalsIgnoreCase(""))){
	 			sqltest1+=" and  m.enqno="+enqno+ " ";
	 			System.out.println("in both enqno=======");   
	 	}
		 else if(!(enqno.equalsIgnoreCase("0") || enqno.equalsIgnoreCase("")) && !(jobno.equalsIgnoreCase("0") || jobno.equalsIgnoreCase(""))){
	 			sqltest1+=" and  m.enqno="+enqno+ " ";
	 			System.out.println("in both enqno2=======");   
	 	}else{
	 		   
	 	}

		 
		 String sqldata="select  e.voc_no enqno,q.doc_no qotno,c.doc_no jobno,ac.refname client,s.name process,DATE_FORMAT(m.indatetime,'%d.%m.%Y %H:%i:%s') fromdate, u.user_name fromuser, DATE_FORMAT(m.outdatetime,'%d.%m.%Y %H:%i:%s') todate, us.user_name touser,convert(TIMEDIFF(outdatetime,indatetime),char(100)) totaltime,m.remarks "
     			+ " from cm_processlog m left join gl_enqm e on e.doc_no=m.enqno left join cm_srvqotm q on q.tr_no=m.qotno left join cm_srvcontrm c on c.tr_no=m.jobno left join cm_status s on s.doc_no=m.statusid left join  my_acbook ac on ac.cldocno=m.cldocno left join my_user u on u.doc_no=m.inuserid left join my_user us on us.doc_no=m.outuserid  where 1=1 and cast(m.indatetime as date)>='"+sqlfromdate+"' and cast(m.outdatetime as date)<= '"+sqltodate+"' "+sqltest1+"";	 
		System.out.println("gridDETAILS---->>>"+sqldata);
		ResultSet resultSet= stmt.executeQuery (sqldata);
        int rowcount=1;
		
		while(resultSet.next()){
			 
				 
				temp=rowcount+"::"+resultSet.getString("enqno")+"::"+resultSet.getString("qotno")+"::"+
						resultSet.getString("jobno")+"::"+resultSet.getString("client")+"::"+resultSet.getString("process")+"::"+resultSet.getString("fromdate")+"::"+resultSet.getString("fromuser")+"::"+resultSet.getString("todate")+"::"+resultSet.getString("touser")+"::"+resultSet.getString("totaltime")+"::"+resultSet.getString("remarks");
						
				arr.add(temp);
				rowcount++;

				/* bean.setFirstarray(1); */
			
	          }
		resultSet.beforeFirst();        
		request.setAttribute("prcslgsts", arr);
		RESULTDATA=cm.convertToJSON(resultSet);
		//loadGridDataPrint(session,cldocno,jobno,enqno,from,to,request);
		/* if(cldocno.equalsIgnoreCase("0") || enqno.equalsIgnoreCase("0") || jobno.equalsIgnoreCase("0") || cldocno.equalsIgnoreCase("") || enqno.equalsIgnoreCase("") || jobno.equalsIgnoreCase("")){
			System.out.println("in all=======");     		
		}else{
		     			String sqldata="select  e.voc_no enqno,q.doc_no qotno,c.doc_no jobno,ac.refname client,s.name process,DATE_FORMAT(m.indatetime,'%d.%m.%Y %H:%i:%s') fromdate, u.user_name fromuser, DATE_FORMAT(m.outdatetime,'%d.%m.%Y %H:%i:%s') todate, us.user_name touser,convert(TIMEDIFF(outdatetime,indatetime),char(100)) totaltime,m.remarks "
				     			+ " from cm_processlog m left join gl_enqm e on e.doc_no=m.enqno left join cm_srvqotm q on q.tr_no=m.qotno left join cm_srvcontrm c on c.tr_no=m.jobno left join cm_status s on s.doc_no=m.statusid left join  my_acbook ac on ac.cldocno=m.cldocno left join my_user u on u.doc_no=m.inuserid left join my_user us on us.doc_no=m.outuserid  where 1=1 "+sqltest1+"";	 
			System.out.println("gridDETAILS---->>>"+sqldata);
				ResultSet resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=cm.convertToJSON(resultSet);
			
		     		} */
		//			System.out.println("=====RESULTDATA"+RESULTDATA);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return RESULTDATA;
}

public  JSONArray loadGridDataPrint(HttpSession session,String cldocno,String jobno,String enqno,String from,String to, HttpServletRequest request) throws SQLException {

	JSONArray RESULTDATA=new JSONArray();
	Connection conn=null;
	try {
		conn = con.getMyConnection();
		Statement stmt = conn.createStatement();
		String sqltest1="";
		java.sql.Date sqlfromdate=null,sqltodate=null;
		 ArrayList<String> arr =new ArrayList<String>();
		    String temp="";  
		if(!(from.equalsIgnoreCase("undefined"))&&!(from.equalsIgnoreCase(""))&&!(from.equalsIgnoreCase("0"))){
		sqlfromdate=cm.changeStringtoSqlDate(from);
		}
		if(!(to.equalsIgnoreCase("undefined"))&&!(to.equalsIgnoreCase(""))&&!(to.equalsIgnoreCase("0"))){
			sqltodate=cm.changeStringtoSqlDate(to);
			}
		
		if((sqlfromdate==null)&&(sqltodate==null)){
            return RESULTDATA;
        } 
		if(!cldocno.equalsIgnoreCase("0") && !cldocno.equalsIgnoreCase(""))
    	{
		  sqltest1+=" and  m.cldocno="+cldocno+" ";
			System.out.println("in cldocno=======");
     	}else if(!(jobno.equalsIgnoreCase("0") || jobno.equalsIgnoreCase("")) && (cldocno.equalsIgnoreCase("0")) || cldocno.equalsIgnoreCase("") && (enqno.equalsIgnoreCase("0")) || enqno.equalsIgnoreCase(""))
		    	{
		 		  sqltest1+=" and  c.doc_no ="+jobno+ " ";   
		 			System.out.println("in jobno nocl======="+jobno);
		     	}
     	else if(!(enqno.equalsIgnoreCase("0") || enqno.equalsIgnoreCase("")) && (cldocno.equalsIgnoreCase("0")) || cldocno.equalsIgnoreCase("") && (jobno.equalsIgnoreCase("0")) || jobno.equalsIgnoreCase(""))
    	{
 		  sqltest1+=" and  m.enqno="+enqno+ " ";
 			System.out.println("in enqno nocl=======");
     	}
     	else{
     		
		}
		 if(!(jobno.equalsIgnoreCase("0") || jobno.equalsIgnoreCase("")) && !(cldocno.equalsIgnoreCase("0") || cldocno.equalsIgnoreCase(""))){
			 
		 			sqltest1+=" and  c.doc_no ="+jobno+ " ";
		 			System.out.println("in both jobno======="+jobno);   
		 	}  
		 if(!(enqno.equalsIgnoreCase("0") || enqno.equalsIgnoreCase("")) && !(cldocno.equalsIgnoreCase("0") || cldocno.equalsIgnoreCase(""))){
	 			sqltest1+=" and  m.enqno="+enqno+ " ";
	 			System.out.println("in both enqno=======");   
	 	}
		 else if(!(enqno.equalsIgnoreCase("0") || enqno.equalsIgnoreCase("")) && !(jobno.equalsIgnoreCase("0") || jobno.equalsIgnoreCase(""))){
	 			sqltest1+=" and  m.enqno="+enqno+ " ";
	 			System.out.println("in both enqno2=======");   
	 	}else{
	 		   
	 	}

		 
		 String sqldata="select  e.voc_no enqno,q.doc_no qotno,c.doc_no jobno,ac.refname client,s.name process,DATE_FORMAT(m.indatetime,'%d.%m.%Y %H:%i:%s') fromdate, u.user_name fromuser, DATE_FORMAT(m.outdatetime,'%d.%m.%Y %H:%i:%s') todate, us.user_name touser,convert(TIMEDIFF(outdatetime,indatetime),char(100)) totaltime,m.remarks "
     			+ " from cm_processlog m left join gl_enqm e on e.doc_no=m.enqno left join cm_srvqotm q on q.tr_no=m.qotno left join cm_srvcontrm c on c.tr_no=m.jobno left join cm_status s on s.doc_no=m.statusid left join  my_acbook ac on ac.cldocno=m.cldocno left join my_user u on u.doc_no=m.inuserid left join my_user us on us.doc_no=m.outuserid  where 1=1 and coalesce(cast(m.indatetime as date),'')>='"+sqlfromdate+"' and coalesce(cast(m.outdatetime as date),'')<= '"+sqltodate+"' "+sqltest1+"";	 
		System.out.println("gridDETAILS---->>>"+sqldata);
		ResultSet resultSet= stmt.executeQuery (sqldata);
		
		int rowcount=1;
		
		while(resultSet.next()){
			 
				 
				temp=rowcount+"::"+resultSet.getString("enqno")+"::"+resultSet.getString("qotno")+"::"+
						resultSet.getString("jobno")+"::"+resultSet.getString("client")+"::"+resultSet.getString("process")+"::"+resultSet.getString("fromdate")+"::"+resultSet.getString("fromuser")+"::"+resultSet.getString("todate")+"::"+resultSet.getString("touser")+"::"+resultSet.getString("totaltime")+"::"+resultSet.getString("remarks");
						
				arr.add(temp);
				rowcount++;

				/* bean.setFirstarray(1); */
			
	          }
	             
		request.setAttribute("prcslgsts", arr);
		stmt.close();
		/* if(cldocno.equalsIgnoreCase("0") || enqno.equalsIgnoreCase("0") || jobno.equalsIgnoreCase("0") || cldocno.equalsIgnoreCase("") || enqno.equalsIgnoreCase("") || jobno.equalsIgnoreCase("")){
			System.out.println("in all=======");     		
		}else{
		     			String sqldata="select  e.voc_no enqno,q.doc_no qotno,c.doc_no jobno,ac.refname client,s.name process,DATE_FORMAT(m.indatetime,'%d.%m.%Y %H:%i:%s') fromdate, u.user_name fromuser, DATE_FORMAT(m.outdatetime,'%d.%m.%Y %H:%i:%s') todate, us.user_name touser,convert(TIMEDIFF(outdatetime,indatetime),char(100)) totaltime,m.remarks "
				     			+ " from cm_processlog m left join gl_enqm e on e.doc_no=m.enqno left join cm_srvqotm q on q.tr_no=m.qotno left join cm_srvcontrm c on c.tr_no=m.jobno left join cm_status s on s.doc_no=m.statusid left join  my_acbook ac on ac.cldocno=m.cldocno left join my_user u on u.doc_no=m.inuserid left join my_user us on us.doc_no=m.outuserid  where 1=1 "+sqltest1+"";	 
			System.out.println("gridDETAILS---->>>"+sqldata);
				ResultSet resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=cm.convertToJSON(resultSet);
			
		     		} */
		//			System.out.println("=====RESULTDATA"+RESULTDATA);

	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	return RESULTDATA;
}

}
  %>
  