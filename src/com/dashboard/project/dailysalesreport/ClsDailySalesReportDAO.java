package com.dashboard.project.dailysalesreport;
 
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sun.org.apache.bcel.internal.generic.DCONST;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class ClsDailySalesReportDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	Statement stmt =null;
	String sql="";
	int val=0;    
	
	
	public  JSONArray loadcollectionGridData(HttpSession session,String fromdate,String todate,String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null,rs=null;
		String sqltest="",sql1="",sqluser="",sqltest2="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}  
					if(!branch.equalsIgnoreCase("a")){
						sqltest+=" and r.brhid="+branch;
		        	}

					 sqluser="select doc_no from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
			    	 //System.out.println("sqluser====="+sqluser); 
			    	 rs =stmt.executeQuery(sqluser);         
			    	 if(rs.next()){
			    		 sqltest2=" where s.doc_no="+rs.getString("doc_no");
			    	 }        
					
		 /*String sqldata="select cash, card, cheque,coalesce((cash+card+cheque),0) jipvalue, B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') salname,ms.targetval "
								+ " from  (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from "
								+ " (select m.doc_no, coalesce(m.SAL_ID,ac.sal_id) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash,"
								+ " card, cheque from (SELECT r.cldocno,r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card,"
								+ " sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.status=3 and date between '"+sqlfromdate+"' "
								+ " and '"+sqltodate+"' "+sqltest+" group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO LEFT JOIN "
								+ " my_acbook ac ON ac.cldocNO=a.cldocno and ac.dtype='crm' ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c LEFT JOIN "    
								+ " MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID LEFT JOIN cm_monthsalem ms ON ms.salid=c.SAL_ID and ms.year=year('"+sqlfromdate+"') and ms.month=month('"+sqlfromdate+"') "+sqltest2+"";
*/			    	
		   String sqldata="select cash, card, cheque,coalesce((cash+card+cheque),0) jipvalue, B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') salname"
								+ " from  (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from "
								+ " (select m.doc_no, coalesce(m.SAL_ID,ac.sal_id) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash,"
								+ " card, cheque from (SELECT r.cldocno,r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card,"
								+ " sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.status=3 and date between '"+sqlfromdate+"' "
								+ " and '"+sqltodate+"' "+sqltest+" group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO LEFT JOIN "
								+ " my_acbook ac ON ac.cldocNO=a.cldocno and ac.dtype='crm' ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c LEFT JOIN "    
								+ " MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID "+sqltest2+"";
    	 
			//System.out.println("=collection Grid==="+sqldata);   
			resultSet= stmt.executeQuery (sqldata);     
			RESULTDATA=cmn.convertToJSON(resultSet);  
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
	public  JSONArray loadcollectionexcelData(HttpSession session,String fromdate,String todate,String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null,rs=null;  
		String sqltest="",sql1="",sqluser="",sqltest2="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
		
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
			}
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqltodate = cmn.changeStringtoSqlDate(todate);
			}
					if(!branch.equalsIgnoreCase("a"))
		        	{
						sqltest+=" and r.brhid="+branch;
		        	}
					sqluser="select doc_no from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
			    	 //System.out.println("sqluser====="+sqluser); 
			    	 rs =stmt.executeQuery(sqluser);         
			    	 if(rs.next()){
			    		 sqltest2=" where s.doc_no="+rs.getString("doc_no");
			    	 }          
					String sqldata="select cash, card, cheque,coalesce((cash+card+cheque),0) jipvalue, B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') salname "
							+ " from  (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from "
							+ " (select m.doc_no, coalesce(m.SAL_ID,ac.sal_id) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash,"
							+ " card, cheque from (SELECT r.cldocno,r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card,"
							+ " sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.status=3 and date between '"+sqlfromdate+"' "
							+ " and '"+sqltodate+"' "+sqltest+" group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO LEFT JOIN "
							+ " my_acbook ac ON ac.cldocNO=a.cldocno and ac.dtype='crm' ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c LEFT JOIN "
							+ " MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID "+sqltest2+"";    
			//System.out.println("=collection excel==="+sqldata);
			resultSet= stmt.executeQuery (sqldata);   
			RESULTDATA=cmn.convertToEXCEL(resultSet);  
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
	public  JSONArray loadJobsGridData(HttpSession session,String fromdate,String todate,String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;   
		Statement stmt =null;
		ResultSet resultSet=null,rs=null;      
		String sqltest="",sql1="",sqluser="",sqltest2="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
		
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
			}
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqltodate = cmn.changeStringtoSqlDate(todate);
			}
					if(!branch.equalsIgnoreCase("a"))
		        	{
						sqltest+=" and q.brhid="+branch;
		        	}
					sqluser="select doc_no from my_salm where status=3 and salesuserlink like '"+session.getAttribute("USERID")+"'";            
			    	 //System.out.println("sqluser====="+sqluser); 
			    	 rs =stmt.executeQuery(sqluser);         
			    	 if(rs.next()){
			    		 sqltest2=" and s.doc_no="+rs.getString("doc_no");   
			    	 } 	  
			    	 String sqldata="SELECT m.date olddate,m.date date,m.netamount,m.dtype,M.DOC_NO jobno,A.refname,B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') salname,coalesce(ms.targetval,0) targetval"
								+ " FROM  CM_SRVCONTRM M left join cm_srvqotm q on q.tr_no=m.reftrno LEFT JOIN MY_BRCH B ON B.DOC_NO=m.BRHID"  
								+ " LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON  A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' LEFT JOIN cm_monthsalem ms ON ms.salid=m.SAL_ID and ms.year=year('"+sqlfromdate+"')"
			                    + " and ms.month=month('"+sqlfromdate+"') WHERE M.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" "+sqltest2+"";				
			System.out.println("=jobs Grid==="+sqldata);         
			resultSet= stmt.executeQuery (sqldata);  
			RESULTDATA=cmn.convertToJSON(resultSet);          
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
	public  JSONArray loadJobsExcelData(HttpSession session,String fromdate,String todate,String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
   
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null,rs=null;
		String sqltest="",sql1="",sqluser="",sqltest2="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
		try {      

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
		
			if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
			}
			if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
				sqltodate = cmn.changeStringtoSqlDate(todate);
			}
					if(!branch.equalsIgnoreCase("a"))
		        	{
						sqltest+=" and q.brhid="+branch;
		        	}
					sqluser="select doc_no from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
			    	 //System.out.println("sqluser====="+sqluser); 
			    	 rs =stmt.executeQuery(sqluser);         
			    	 if(rs.next()){
			    		 sqltest2=" and s.doc_no="+rs.getString("doc_no");
			    	 } 
			    	 String sqldata="SELECT M.DOC_NO JOBNO,m.salesbookdate 'JOB DATE',A.REFNAME,B.BRANCHNAME,COALESCE(S.SAL_NAME,'') SALNAME,m.netamount 'JOB AMOUNT',coalesce(ms.targetval,0) 'TARGET VALUE'"
								+ " FROM  CM_SRVCONTRM M left join cm_srvqotm q on q.tr_no=m.reftrno LEFT JOIN MY_BRCH B ON B.DOC_NO=q.BRHID"
								+ " LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON  A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' LEFT JOIN cm_monthsalem ms ON ms.salid=m.SAL_ID and ms.year=year('"+sqlfromdate+"')"
						        + " and ms.month=month('"+sqlfromdate+"') WHERE M.status=3 and m.salesbookdate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" "+sqltest2+"";				
			//System.out.println("=jobs excel Grid==="+sqldata);    
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToEXCEL(resultSet);         
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
	public  JSONArray loadProgressGridData(HttpSession session,String fromdate,String todate,String branch) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null,rs=null;      
		String sqltest="",sql1="",sqluser="",sqltest2="";  
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
		
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}  
					if(!branch.equalsIgnoreCase("a")){
						sqltest+=" and m.brhid="+branch;       
		        	}
					sqluser="select doc_no from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
			    	 //System.out.println("sqluser====="+sqluser); 
			    	 rs =stmt.executeQuery(sqluser);         
			    	 if(rs.next()){
			    		 sqltest2=" and s.doc_no="+rs.getString("doc_no");
			    	 } 
		/*	String sqldata="select cash, card, cheque, coalesce(jipvalue,0) jipvalue, B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') salname"
					+ " from (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from (select m.doc_no,"
					+ " coalesce(m.SAL_ID,0) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash, card, cheque from"
					+ " (SELECT r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card,"
					+ " sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" "
					+ " group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c"
					+ " left join (select brhid,sal_id,sum(jipvalue) jipvalue from (select m.sal_id,m.brhid,max(wrkper) wrkper,rtrno,"
					+ " round(coalesce(netamount,0)*(coalesce(max(wrkper),0)/100),2) jipvalue from cm_srvreportstatus s left join"
					+ " CM_SRVCONTRM m on m.tr_no=s.rtrno where s.date between '"+sqlfromdate+"' and '"+sqltodate+"' group by rtrno) a group by brhid,sal_id) j"
					+ " on c.sal_id=j.sal_id and j.brhid=c.brhid LEFT JOIN MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID where jipvalue!=0";
			        */
					String sqldata=" select j.*,B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') salname from ( "
							+ " select brhid,sal_id,count(*) cn,sum(jipvalue) jipvalue from ( "
							+ " select jobno,brhid, sal_id, ROUND(AMT*((max(curmonth)-max(prev))/100),2) jipvalue from ( "
							+ " select c.doc_no jobno,c.sal_id,c.brhid,(m.wrkper) wrkper,rtrno,IF(D.DATE between '"+sqlfromdate+"' and '"+sqltodate+"',d.wrkper,0) curmonth, ROUND(C.NETAMOUNT,2) AMT, "
							+ " IF( d.date< '"+sqlfromdate+"',d.wrkper,0 ) prev  from "
							+ " CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID"
							+ " AND M.COSTTYPE=C.COSTTYPE where m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" ORDER BY M.DOC_NO,C.DOC_NO ) b group by b.jobno ) a"
							+ " group by brhid,sal_id ) j "
							+ " LEFT JOIN MY_BRCH B ON B.DOC_NO=j.BRHID LEFT JOIN my_salm S ON S.DOC_NO=j.SAL_ID where jipvalue!=0 "+sqltest2+"";   	
					  
		    System.out.println("=job progress Grid==="+sqldata);
			resultSet= stmt.executeQuery (sqldata);   
			RESULTDATA=cmn.convertToJSON(resultSet);  
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