package com.dashboard.marketing.opaccounting;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.project.execution.projectInvoice.ClsProjectInvoiceDAO;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsOpAccountingDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray presalesData(HttpSession session,String id,String widgetname,String brhid) throws SQLException{    
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		 if(!id.equalsIgnoreCase("1")){        
			 return data;
		 } 
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			String sqltest="",strjoin="",sqlselect="";   
			           
	           
				if(widgetname.equalsIgnoreCase("proforma")){  
					sqltest=" and m.pstatus=1 and coalesce(m.pinvno,0)=0 and d.dueafser=98 ";    
				}else if(widgetname.equalsIgnoreCase("notrcvd")){
					sqltest=" and m.pstatus=1 and coalesce(m.pinvno,0)!=0 and d.dueafser=98 ";
				}else if(widgetname.equalsIgnoreCase("invpro")){
					sqltest=" and ((d.dueafser=98 and d.invtrno=0) or (d.dueafser=99 and d.invtrno=0 and m.pstatus!=1) or (d.dueafser not in (98,99) and d.serviceno>0 and d.invtrno=0 and s.workper=100 and s.status=5) or (d.dueafser=0 and d.invtrno=0 and m.pstatus!=1 and coalesce(serviceno,0)=0)) ";
					strjoin="left join cm_servplan s on d.tr_no=s.doc_no and s.sr_no=d.serviceno and s.dtype='sjob'";         
				}else if(widgetname.equalsIgnoreCase("tobecnfmed")){  
					sqltest=" and d.invtrno>0 and d.confirm=0 ";           
				}else{}         
				
				if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){          
					sqltest+=" and m.brhid='"+brhid+"'";        
				}  
				
				/*String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
				//System.out.println("--------underwriter----------"+sql1);
				String salesuser="";
				ResultSet resultSet1 = stmt.executeQuery(sql1) ;
				if(resultSet1.next()){
					salesuser=" and m.sal_id='"+resultSet1.getString("doc_no")+"'";    
				} */  
				
				String strsql="select round(coalesce(pj.retAmount,0),2) retamount,round(coalesce(pj.retLegalCharge,0),2) retlegalcharge,round(coalesce(pj.atotal,0)-coalesce(pj.retAmount,0),2) retbalamt,round(coalesce(pj.legalchrg,0)-coalesce(pj.retLegalCharge,0),2) retballegchrg,d.invtrno pjivtrno,coalesce(c.doc_no,0) ccdocno,m.invprog,m.brhid,m.dtype,coalesce(m.pinvno,0) pinvno,coalesce(m.pstatus,0) pstatus,coalesce(d.dueafser,0) dueafser,coalesce(c.desc1,'') certydesc,round(coalesce(c.certper,0),2) certyper,round(coalesce(c.inv,0),2) invoiced,round(coalesce(m.progper,0),2) reten,coalesce(d.rowno,0) pdrowno,if(d.terms='SERVICE',d.dueafser,0) payservice,d.terms payterms,d.description paydesc,round(d.amount,2) amount,d.duedate,b.branchname branch,s.site,m.tr_no docno,m.doc_no vocno,m.date,round(m.netAmount,2) as netAmount,m.cldocno,round(coalesce(contractval,0),2) as contractval,ac.refname,sm.sal_name from  cm_srvcontrm m left join cm_srvcontrpd d on d.tr_no=m.tr_no left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) left join (select group_concat(site) site,tr_no from cm_srvcsited group by tr_no) s on s.tr_no=m.tr_no left join my_brch b on b.doc_no=m.brhid left join cm_compcert c on (m.tr_no=c.rdocno and c.dtype=m.dtype) left join my_servm pj on pj.pdrowno=d.rowno "+strjoin+" where m.dtype='SJOB' and m.status=3 and m.jbaction in (0,4)  "+sqltest+"";
				//System.out.println("strsql--->>>"+strsql);                                                                                             
				ResultSet rs=stmt.executeQuery(strsql);       
				data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){  
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}


	public int insert(HttpSession session,HttpServletRequest request ,java.sql.Date date,String formcode,String mode,ArrayList invList,String descp) throws SQLException{
		ArrayList retList=new  ArrayList();     
		Connection conn=null;
		CallableStatement stmt =null;
		int docNo=0,vocno=0,tr_no=0,doc_no=0,clientid=0,cpersonid=0,clacno=0,brch=0;
		String dtype="",refdtype="",otype="",client="";
		double contramt=0.0,legalfee=0.0;

		java.sql.Date duedate,sdate,edate;
		try{
			ClsProjectInvoiceDAO invDAO=new ClsProjectInvoiceDAO();
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt1 = conn.createStatement ();
			
			for(int i=0;i< invList.size();i++){

				String[] surveydet=((String) invList.get(i)).split("::");
				if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
				{
					tr_no=(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:Integer.parseInt(surveydet[0].trim()));
					doc_no=(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:Integer.parseInt(surveydet[1].trim()));
					dtype=(String) (surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim().toString());
					refdtype=(String) (surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim().toString());
					sdate= (Date) (surveydet[4].trim().equalsIgnoreCase("undefined") || surveydet[4].trim().equalsIgnoreCase("NaN")|| surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()?0:objcommon.changeStringtoSqlDate(surveydet[4].toString().trim()));
					edate= (Date) (surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:objcommon.changeStringtoSqlDate(surveydet[5].toString().trim()));
					contramt=(surveydet[6].trim().equalsIgnoreCase("undefined") || surveydet[6].trim().equalsIgnoreCase("NaN")|| surveydet[6].trim().equalsIgnoreCase("")|| surveydet[6].isEmpty()?0:Double.parseDouble(surveydet[6].trim().toString()));
					duedate=(Date) (surveydet[7].trim().equalsIgnoreCase("undefined") || surveydet[7].trim().equalsIgnoreCase("NaN")|| surveydet[7].trim().equalsIgnoreCase("")|| surveydet[7].isEmpty()?0:objcommon.changeStringtoSqlDate(surveydet[7].trim()));
					legalfee=(surveydet[8].trim().equalsIgnoreCase("undefined") || surveydet[8].trim().equalsIgnoreCase("NaN")|| surveydet[8].trim().equalsIgnoreCase("")|| surveydet[8].isEmpty()?0:Double.parseDouble(surveydet[8].trim().toString()));
					clientid=(surveydet[9].trim().equalsIgnoreCase("undefined") || surveydet[9].trim().equalsIgnoreCase("NaN")|| surveydet[9].trim().equalsIgnoreCase("")|| surveydet[9].isEmpty()?0:Integer.parseInt(surveydet[9].trim()));
					cpersonid=(surveydet[10].trim().equalsIgnoreCase("undefined") || surveydet[10].trim().equalsIgnoreCase("NaN")|| surveydet[10].trim().equalsIgnoreCase("")|| surveydet[10].isEmpty()?0:Integer.parseInt(surveydet[10].trim()));
					brch=(surveydet[11].trim().equalsIgnoreCase("undefined") || surveydet[11].trim().equalsIgnoreCase("NaN")|| surveydet[11].trim().equalsIgnoreCase("")|| surveydet[11].isEmpty()?0:Integer.parseInt(surveydet[11].trim()));
					clacno=(surveydet[12].trim().equalsIgnoreCase("undefined") || surveydet[12].trim().equalsIgnoreCase("NaN")|| surveydet[12].trim().equalsIgnoreCase("")|| surveydet[12].isEmpty()?0:Integer.parseInt(surveydet[12].trim()));
					client=(String) (surveydet[13].trim().equalsIgnoreCase("undefined") || surveydet[13].trim().equalsIgnoreCase("NaN")|| surveydet[13].trim().equalsIgnoreCase("")|| surveydet[13].isEmpty()?0:surveydet[13].trim().toString());
					String cltax="0",inctax="0";
					ArrayList taxlist=new ArrayList();
					
					double nettotal=contramt+legalfee;
					
					String inctaxsql="select coalesce(inctax,0) inctax from cm_srvcontrm where tr_no='"+tr_no+"'";
					ResultSet rsinctax = stmt1.executeQuery(inctaxsql);

					while (rsinctax.next()) {
						inctax=rsinctax.getString("inctax");
					}
					
					taxlist=invDAO.getTax(session,nettotal,date,"0",clientid);
					
					if(inctax.equalsIgnoreCase("1")) {
						double taxamount=0.00;
						for(int m=0;m< taxlist.size();m++){

							String[] surveydets=((String) taxlist.get(m)).split("::");
							if(!(surveydets[0].trim().equalsIgnoreCase("undefined")|| surveydets[0].trim().equalsIgnoreCase("NaN")||surveydets[0].trim().equalsIgnoreCase("")|| surveydets[0].isEmpty()))
							{
								taxamount=((surveydets[3].equalsIgnoreCase("undefined") || surveydets[3].equalsIgnoreCase("NaN") || surveydets[3].isEmpty()?0.0:Double.parseDouble(surveydets[3])));
							}
						}
						contramt=contramt-taxamount;
					}
					
					stmt = conn.prepareCall("{CALL Sr_profinvDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					stmt.registerOutParameter(20, java.sql.Types.INTEGER);
					stmt.registerOutParameter(21, java.sql.Types.INTEGER);
					stmt.registerOutParameter(22, java.sql.Types.VARCHAR);
					stmt.setDate(1,date);
					stmt.setInt(2,tr_no);
					stmt.setInt(3, doc_no);
					stmt.setString(4,dtype);
					stmt.setString(5,refdtype);
					stmt.setDate(6,sdate);
					stmt.setDate(7,edate);
					stmt.setDouble(8,contramt);
					stmt.setDate(9,duedate);
					stmt.setDouble(10,legalfee);
					stmt.setInt(11,clientid);
					stmt.setInt(12,cpersonid);
					stmt.setInt(13,brch);
					stmt.setInt(14,clacno);
					stmt.setString(15, session.getAttribute("USERID").toString());
					stmt.setString(16,formcode);
					stmt.setString(17,mode);
					stmt.setString(18,client);
					stmt.setString(19,descp);
					int val = stmt.executeUpdate();
					docNo=stmt.getInt("docNo");
					vocno=stmt.getInt("vocNo");
					otype=stmt.getString("otype");

					request.setAttribute("docNo", docNo);

					//retList.add(otype+":"+vocno);
					
					String clsql="select nontax from my_acbook where dtype='CRM' and cldocno='"+clientid+"'";
					ResultSet rscltax = stmt.executeQuery(clsql);

					while (rscltax.next()) {
						cltax=rscltax.getString("nontax");
					}

					if(cltax.equalsIgnoreCase("1")){
						
						for(int j=0;j< taxlist.size();j++){

							String[] surveydets=((String) taxlist.get(j)).split("::");
							if(!(surveydets[0].trim().equalsIgnoreCase("undefined")|| surveydets[0].trim().equalsIgnoreCase("NaN")||surveydets[0].trim().equalsIgnoreCase("")|| surveydets[0].isEmpty()))
							{

							
								String sql="INSERT INTO my_pinvtaxdet( rdocno, taxid,acno, per, amount)VALUES"
										+ " ("+(docNo)+","
										+ "'"+(surveydets[4].trim().equalsIgnoreCase("undefined") || surveydets[4].trim().equalsIgnoreCase("NaN")|| surveydets[4].trim().equalsIgnoreCase("")|| surveydets[4].isEmpty()?0:surveydets[4].trim())+"',"
										+ "'"+(surveydets[1].trim().equalsIgnoreCase("undefined") || surveydets[1].trim().equalsIgnoreCase("NaN")|| surveydets[1].trim().equalsIgnoreCase("")|| surveydets[1].isEmpty()?0:surveydets[1].trim())+"',"
										+ "'"+(surveydets[2].trim().equalsIgnoreCase("undefined") || surveydets[2].trim().equalsIgnoreCase("NaN")|| surveydets[2].trim().equalsIgnoreCase("")|| surveydets[2].isEmpty()?0:surveydets[2].trim())+"',"
										+ "'"+(surveydets[3].trim().equalsIgnoreCase("undefined") || surveydets[3].trim().equalsIgnoreCase("NaN")|| surveydets[3].trim().equalsIgnoreCase("")|| surveydets[3].isEmpty()?0:surveydets[3].trim())+"')";
								
								int rest = stmt.executeUpdate (sql);
								if(rest<=0)
								{
									conn.close();
								}

							}

						}
						
					}
				}

			}
		conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return vocno;       
	}
	
	public  JSONArray loadSubGridData(String trno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = objconn.getMyConnection();
			stmt = conn.createStatement ();
			
				
			String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bpif m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
					+ "and m.bibpid=203 and m.status=3 group by m.doc_no order by m.fdate desc";
		
		//System.out.println(sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=objcommon.convertToJSON(resultSet);   
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

}  
