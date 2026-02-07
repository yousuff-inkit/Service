package com.dashboard.projectexecution.jobprogressreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsjobProgressReportDAO {
	
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval,String type,String summtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

 
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqltest1="",sqltestt="";
		String sqldata="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	     	if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest1+=" and m.brhid="+barchval;
			}
	     	
//System.out.println(dtype);
	     	if(type.equalsIgnoreCase("All")){
				sqltest+=" AND 1=1  ";
			}
	     	else if(type.equalsIgnoreCase("Full")){
				sqltest+=" AND D.WRKPER=100 ";
			}
	     	else if(type.equalsIgnoreCase("Partial")){
				sqltest+=" AND D.WRKPER!=100 ";
			}
	     	else{
	     		
	     	}
	     	if(summtype.equalsIgnoreCase("job")){
	     		sqldata="select s.site,longitude,latittude,branchname,cname, jobno, jdate, salesman, max(cdate) cdate, Amount, DISPER, Discount, Net, max(installper) installper, max(installamt) INSTALLAMT , "
	     				+ " if(max(curmonth)-max(prev)<0,0,max(curmonth)-max(prev)) currentmnth,max(prev) prevmonth, if(ROUND(Net*((max(curmonth)-max(prev))/100),2)<0,0,ROUND(Net*((max(curmonth)-max(prev))/100),2)) curmnthinstlamt,ROUND(Net*(max(prev)/100),2) prevmnthinstlamt "
	     				+ " from (select m.longitude,m.latittude,b.branchname,A.REFNAME cname,C.DOC_NO jobno,c.DATE jdate,m1.sal_name salesman,"
	     				+ " d.date 'cdate',Q.AMOUNT 'Amount',round(coalesce(Q.DISPER,0),2) as DISPER, "
	     				+ " Q.DISCOUNT 'Discount',C.NETAMOUNT 'Net',D.WRKPER installper,"
	     				+ " ROUND(C.NETAMOUNT*(D.WRKPER/100),2) INSTALLAMT,IF( D.DATE between '"+sqlfromdate+"' and '"+sqltodate+"',d.wrkper,0) curmonth,IF( d.date< '"+sqlfromdate+"',d.wrkper,0 ) prev"
	     				+ " from CM_srvdetm m left join cm_srvreportstatus "
	     				+ " d on m.tr_no=d.rtrno LEFT JOIN MY_ACBOOK A ON M.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM' "
	     				+ " LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE "
	     				+ " LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO left join my_brch b on Q.brhid=b.doc_no left join my_salm m1 on m1.doc_no=c.sal_id  "
	     				+ "  left join cm_srvcsited s on m.siteId=s.rowno "
	     				+ " WHERE d.DATE <= '"+sqltodate+"' "+sqltest+" "+sqltest1+" ORDER BY M.DOC_NO,C.DOC_NO ) "
	     				+ " a   group by jobno  having currentmnth<>0 ";
	     	}
	     	else{
	     		
	     	
				 			 
//			     	 sqldata="select A.REFNAME cname,C.DOC_NO jobno,D.DATE jdate,Q.AMOUNT,round(coalesce(Q.DISPER,0),2) as DISPER,Q.DISCOUNT ,C.NETAMOUNT  NET,D.WRKPER 'INSTALLPER',ROUND(Q.NETAMOUNT*(D.WRKPER/100),2) INSTALLAMT from "
//			     			+ "CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN MY_ACBOOK A ON M.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM' "
//			     			+ "LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE "
//			     			+ "LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO "+sqltest+" "+sqltest1+" ORDER BY M.DOC_NO ";
				 	sqldata="select  s.site,m.longitude,m.latittude,b.branchname,A.REFNAME cname,C.DOC_NO jobno,concat(m.ref_type,'-',coalesce(ca.doc_no,c.doc_no)) refno,c.DATE jdate,m1.sal_name salesman,"
				 			+ " d.date 'cdate',Q.AMOUNT 'Amount',round(coalesce(Q.DISPER,0),2) as DISPER,"
				 			+ " Q.DISCOUNT 'Discount',C.NETAMOUNT 'Net',D.WRKPER installper,"
				 			+ " ROUND(C.NETAMOUNT*(D.WRKPER/100),2) INSTALLAMT from CM_srvdetm m "
				 			+ " left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN MY_ACBOOK A ON M.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM'"
				 			+ " left join cm_cuscallm ca on ca.tr_no=m.costid and m.ref_type in ('CREG') left join cm_srvcontrm c on (c.tr_no=m.costid and c.dtype=m.ref_type and m.ref_type in ('AMC','SJOB')) or (c.tr_no=ca.contractno ) "
				 			+ " LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO left join my_brch b on Q.brhid=b.doc_no left join my_salm m1 on m1.doc_no=c.sal_id "
				 			+ "  left join cm_srvcsited s on m.siteId=s.rowno "
				 			+ " WHERE   m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+" "+sqltest1+" ORDER BY M.DOC_NO,C.DOC_NO ";
	     	}
				 	//System.out.println("gridDETAILS"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToJSON(resultSet);
//						System.out.println("=====RESULTDATA"+RESULTDATA);

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
	public  JSONArray loadGridExcel(String fromdate,String todate,String rds,String barchval,String type,String summtype) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		 
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqltest1="";
		String sqldata="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	    	if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest1+=" and m.brhid="+barchval;
			}
//System.out.println(dtype);
	     	if(type.equalsIgnoreCase("All")){
				sqltest+=" AND 1=1  ";
			}
	     	else if(type.equalsIgnoreCase("Full")){
				sqltest+=" AND D.WRKPER=100 ";
			}
	     	else if(type.equalsIgnoreCase("Partial")){
				sqltest+=" AND D.WRKPER!=100 ";
			}
	     	if(summtype.equalsIgnoreCase("job")){
	     		sqldata="select cname, jobno, jdate,branchname, salesman, max(cdate) cdate, Amount, DISPER, Discount, Net, max(installper) installper, max(installamt) INSTALLAMT,"
	     				+ " if(max(curmonth)-max(prev)<0,0,max(curmonth)-max(prev)) currentmnth,max(prev) prevmonth, if(ROUND(Net*((max(curmonth)-max(prev))/100),2)<0,0,ROUND(Net*((max(curmonth)-max(prev))/100),2)) curmnthinstlamt, ROUND(Net*(max(prev)/100),2)prevmnthinstlamt "
	     				+ "from (select b.branchname,A.REFNAME cname,C.DOC_NO jobno,c.DATE jdate,m1.sal_name salesman,"
	     				+ " d.date 'cdate',Q.AMOUNT 'Amount',round(coalesce(Q.DISPER,0),2) as DISPER, "
	     				+ "Q.DISCOUNT 'Discount',C.NETAMOUNT 'Net',D.WRKPER installper,"
	     				+ " ROUND(C.NETAMOUNT*(D.WRKPER/100),2) INSTALLAMT ,IF( D.DATE between '"+sqlfromdate+"' and '"+sqltodate+"',d.wrkper,0) curmonth,IF( d.date< '"+sqlfromdate+"',d.wrkper,0 ) prev"
	     				+ " from CM_srvdetm m left join cm_srvreportstatus "
	     				+ "d on m.tr_no=d.rtrno LEFT JOIN MY_ACBOOK A ON M.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM' "
	     				+ "LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE "
	     				+ "LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO left join my_brch b on Q.brhid=b.doc_no left join my_salm m1 on m1.doc_no=c.sal_id "
	     				+ "WHERE d.DATE <= '"+sqltodate+"' "+sqltest+" "+sqltest1+" ORDER BY M.DOC_NO,C.DOC_NO ) "
	     				+ " a   group by jobno  having currentmnth<>0 ";
	     	}
	     	else{
	     		
	     	
				 			 
//			     	 sqldata="select A.REFNAME cname,C.DOC_NO jobno,D.DATE jdate,Q.AMOUNT,round(coalesce(Q.DISPER,0),2) as DISPER,Q.DISCOUNT ,C.NETAMOUNT  NET,D.WRKPER 'INSTALLPER',ROUND(Q.NETAMOUNT*(D.WRKPER/100),2) INSTALLAMT from "
//			     			+ "CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN MY_ACBOOK A ON M.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM' "
//			     			+ "LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE "
//			     			+ "LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO "+sqltest+" "+sqltest1+" ORDER BY M.DOC_NO ";
				 	sqldata="select A.REFNAME cname,C.DOC_NO jobno,c.DATE jdate,b.branchname branch,m1.sal_name salesman,"
				 			+ " d.date 'cdate',Q.AMOUNT 'Amount',round(coalesce(Q.DISPER,0),2) as DISPER,"
				 			+ " Q.DISCOUNT 'Discount',C.NETAMOUNT 'Net',D.WRKPER installper,"
				 			+ " ROUND(C.NETAMOUNT*(D.WRKPER/100),2) INSTALLAMT from CM_srvdetm m "
				 			+ " left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN MY_ACBOOK A ON M.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM'"
				 			+ " LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO left join my_brch b on Q.brhid=b.doc_no left join my_salm m1 on m1.doc_no=c.sal_id WHERE   m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+" "+sqltest1+" ORDER BY M.DOC_NO,C.DOC_NO ";
	     	}
//	     	System.out.println("gridDETAILS"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToEXCEL(resultSet);
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
	public  JSONArray sumloadGridData(String fromdate,String todate,String rds,String barchval,String summtype,String type) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

 
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqltest1="",sqltest2="",sqltestt="";
		String sqldata="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
//System.out.println(dtype);
	    	if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and brhid="+barchval;
			}
			
			if(type.equalsIgnoreCase("All")){
				sqltestt+=" AND 1=1  ";
			}
	     	else if(type.equalsIgnoreCase("Full")){
				sqltestt+=" AND D.WRKPER=100 ";
			}
	     	else if(type.equalsIgnoreCase("Partial")){
				sqltestt+=" AND D.WRKPER!=100 ";
			}
	     	else{
	     		
	     	}
	     	if(summtype.equalsIgnoreCase("sal")){
	     		
				sqltest1+=" group by a.sal_id  ";
				sqltest2+=" sal_name,ROUND((sum(disCOUNT)/SUM(AMOUNT))*100,2) disper,  ";
			}
	     	else if(summtype.equalsIgnoreCase("daily")){
				sqltest1+=" group by a.date";
				sqltest2+=" DATE_FORMAT(date,'%d.%m.%Y') jdate,";
			}
	     	else if(summtype.equalsIgnoreCase("weekly")){
				sqltest1+=" group by year(a.date),WEEK(a.date)";
				sqltest2+="convert(concat('WEEK','-',WEEK(date)), char(500)) jdate,";
			}
	     	else{
	     		
	     	}
					 sqldata="select "+sqltest2+" a.branchname,sum(amount) amount,sum(discount) discount,sum(net) net from "
							+ " (select b.branchname,m.date,m.brhid,s.sal_name,a.sal_id,A.REFNAME CLIENTNAME,C.DOC_NO jobno ,Q.AMOUNT,Q.DISPER,Q.DISCOUNT ,C.NETAMOUNT NET from "
							+ " (select  m.date,m.brhid,m.cldocno,m.costid,m.costtype,m.tr_no,m.doc_no from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno WHERE  m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltestt+" group by costid,costtype) m  LEFT JOIN MY_ACBOOK A ON M.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM' "
							+ "  LEFT JOIN MY_SALM S ON S.DOC_NO=A.SAL_ID LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO left join my_brch b on Q.brhid=b.doc_no"
							+ "  ORDER BY M.DOC_NO ) a "+sqltest+" "+sqltest1+" ";
				 
			     	System.out.println("sumgridDETAILS"+sqldata);
				resultSet= stmt.executeQuery(sqldata);
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
	public  JSONArray sumloadGridExcel(String fromdate,String todate,String rds,String barchval,String summtype,String type) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		 
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqltest1="",sqltest2="",sqltest3="",sqltestt="";
		String sqldata="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
//System.out.println(dtype);
	    	if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" where brhid="+barchval;
			}
			
			if(type.equalsIgnoreCase("All")){
				sqltestt+=" AND 1=1  ";
			}
	     	else if(type.equalsIgnoreCase("Full")){
				sqltestt+=" AND D.WRKPER=100 ";
			}
	     	else if(type.equalsIgnoreCase("Partial")){
				sqltestt+=" AND D.WRKPER!=100 ";
			}
	     	else{
	     		
	     	}
	     	if(summtype.equalsIgnoreCase("sal")){
	     		
				sqltest1+=" group by a.sal_id  ";
				sqltest2+=" sal_name,ROUND((sum(disCOUNT)/SUM(AMOUNT))*100,2) disper,  ";
			}
	     	else if(summtype.equalsIgnoreCase("daily")){
				sqltest1+=" group by a.date";
				sqltest2+=" DATE_FORMAT(date,'%d.%m.%Y') jdate,";
			}
	     	else if(summtype.equalsIgnoreCase("weekly")){
				sqltest1+=" group by year(a.date),WEEK(a.date)";
				sqltest2+="convert(concat('WEEK','-',WEEK(date)), char(500)) jdate,";
			}
	     	else{
	     		
	     	}
				 
					 sqldata="select "+sqltest2+" a.branchname,sum(amount) amount,sum(discount) discount,sum(net) net from "
							+ " (select b.branchname,m.date,m.brhid,s.sal_name,a.sal_id,A.REFNAME CLIENTNAME,C.DOC_NO jobno ,Q.AMOUNT,Q.DISPER,Q.DISCOUNT ,C.NETAMOUNT NET from "
							+ " (select  m.date,m.brhid,m.cldocno,m.costid,m.costtype,m.tr_no,m.doc_no from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno WHERE  m.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltestt+" group by costid,costtype) m  LEFT JOIN MY_ACBOOK A ON M.CLDOCNO=A.CLDOCNO AND A.DTYPE='CRM' "
							+ "  LEFT JOIN MY_SALM S ON S.DOC_NO=A.SAL_ID LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE LEFT JOIN CM_SRVQOTM Q ON Q.TR_NO=C.REFTRNO left join my_brch b on Q.brhid=b.doc_no "
							+ "  ORDER BY M.DOC_NO ) a "+sqltest+" "+sqltest1+" ";
				 
				 
//				 System.out.println("gridDETAILS"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToEXCEL(resultSet);
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
	
	public JSONArray getJobProgressDetailData(java.sql.Date sqltodate,String contracttype,HttpSession session,String salesman,String branch) throws SQLException{
		JSONArray dataarray=new JSONArray();
		Connection conn=null;
		try{
			if(sqltodate==null){
				return dataarray;
			}
			conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			String userid=session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString();
			String strchecksalesman="select doc_no salesmandocno from my_salm where status=3 and salesuserlink="+userid;
			ResultSet rschecksalesman=stmt.executeQuery(strchecksalesman);
			int salesmandocno=0;
			while(rschecksalesman.next()){
				salesmandocno=rschecksalesman.getInt("salesmandocno");
			}
			String sqltest="";
			System.out.println(salesmandocno+"::"+salesman);
			if(salesmandocno>0){
				sqltest+=" and ac.sal_id="+salesmandocno;
			}
			else{
				if(!salesman.equalsIgnoreCase("")){
					sqltest+=" and ac.sal_id="+salesman;
				}
			}
			
			if(contracttype.equalsIgnoreCase("1")){
				//Contracted
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a") && branch!=null && !branch.equalsIgnoreCase("null")){
					sqltest+=" and m.brhid="+branch;
				}
			}
			else if(contracttype.equalsIgnoreCase("2")){
				//Not Contracted
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a") && branch!=null && !branch.equalsIgnoreCase("null")){
					sqltest+=" and enq.brhid="+branch;
				}
			}
			String strsql="select coalesce(pd.name,'') currentstatus,m.doc_no jobno,ac.refname,ac.address,ac.per_mob,date_format(m.date,'%d.%m.%Y') jobdate,coalesce(format(round(m.netamount,2),2),'') netamount,coalesce(format(round(qot.discount,2),2),'') discount,"+
			" coalesce(format(round(qot.amount,2),2),'') amount,coalesce(round(qot.disper,2),'') discountpercent,coalesce(enq.voc_no,'') enqvocno,"+
			" coalesce(date_format(enq.date,'%d.%m.%Y'),'') enqdate,coalesce(concat(enquser.user_name,' on ',date_format(enq.date,'%d.%m.%Y')),'') leadcreation,"+
			" coalesce(concat(qotuser.user_name,' on ',date_format(qot.date,'%d.%m.%Y')),'') qotcreation,"+
			" coalesce(concat(jobuser.user_name,' on ',date_format(m.date,'%d.%m.%Y')),'') jobcreation,"+
			" coalesce(datediff(qot.date,enq.date),'') qotdaystaken,coalesce(datediff(m.date,qot.date),'') jobdaystaken,"+
			" coalesce(if(qot.date is null,datediff(curdate(),enq.date),''),'') enqdaystaken from cm_srvCONTRM m left join my_acbook ac on"+
			" (m.cldocno=ac.cldocno and ac.dtype='CRM') left join CM_SRVQOTM qot on (m.reftrno=qot.tr_no and m.ref_type='SQOT') left join"+
			" gl_enqm enq on (qot.refdocno=enq.doc_no and qot.ref_type='ENQ') left join my_user enquser on (enq.userid=enquser.doc_no and"+
			" enquser.status=3) left join my_user qotuser on (qot.userid=qotuser.doc_no and qotuser.status=3) left join my_user jobuser on"+
			" (m.userid=jobuser.doc_no and jobuser.status=3) left join (select max(doc_no) doc_no,enqno from cm_processlog group by enqno) pm"+
			" on (pm.enqno=enq.doc_no) left join cm_processlog pl on pm.doc_no=pl.doc_no left join cm_status pd on pl.statusid=pd.doc_no "+
			" where m.DATE <='"+sqltodate+"' and m.doc_no>0 "+sqltest+" and coalesce(m.installdate,'')='' and m.status=3";
			if(contracttype.equalsIgnoreCase("2")){
				strsql="select case when enq.enqstatus=0 then 'Entered' when enq.enqstatus=1 then 'Layout confirmation and Assignment' else coalesce(pd.name,'') end as currentstatus,'' jobno,ac.refname,ac.address,ac.per_mob,'' jobdate,coalesce(format(round(m.netamount,2),2),'') netamount,coalesce(format(round(qot.discount,2),2),'') discount,"+
				" coalesce(format(round(qot.amount,2),2),'') amount,coalesce(round(qot.disper,2),'') discountpercent,enq.voc_no enqvocno,"+
				" date_format(enq.date,'%d.%m.%Y') enqdate,concat(enquser.user_name,' on ',date_format(enq.date,'%d.%m.%Y')) leadcreation,"+
				" coalesce(concat(qotuser.user_name,' on ',date_format(qot.date,'%d.%m.%Y')),'') qotcreation,"+
				" coalesce(concat(jobuser.user_name,' on ',date_format(m.date,'%d.%m.%Y')),'') jobcreation,"+
				" coalesce(datediff(qot.date,enq.date),'') qotdaystaken,coalesce(datediff(m.date,qot.date),'') jobdaystaken,"+
				" coalesce(if(qot.date is null,datediff(curdate(),enq.date),''),'') enqdaystaken from gl_enqm enq"+
				" left join CM_SRVQOTM qot on (enq.doc_no=qot.refdocno and qot.ref_type='ENQ')"+
				" left join cm_srvCONTRM m on (qot.tr_no=m.reftrno and m.ref_type='SQOT')"+
				" left join my_acbook ac on (enq.cldocno=ac.cldocno and ac.dtype='CRM')"+
				" left join my_user enquser on (enq.userid=enquser.doc_no and enquser.status=3)"+
				" left join my_user qotuser on (qot.userid=qotuser.doc_no and qotuser.status=3)"+
				" left join my_user jobuser on (m.userid=jobuser.doc_no and jobuser.status=3)"+
				" left join (select max(doc_no) doc_no,enqno,max(qotno) mqotno from cm_processlog group by enqno,qotno) pm on ((pm.enqno=enq.voc_no and qot.doc_no is null) or (pm.enqno=enq.voc_no and pm.mqotno=qot.tr_no)) and pm.mqotno<>0 "+
				" left join cm_processlog pl on pm.doc_no=pl.doc_no"+
				" left join cm_status pd on pl.statusid=pd.doc_no where m.doc_no is null and enq.date<='"+sqltodate+"'"+sqltest;
			}
			System.out.println(strsql);
			ResultSet rsmain=stmt.executeQuery(strsql);
			
			while(rsmain.next()){
				JSONObject objdata=new JSONObject();
				objdata.put("jobno", rsmain.getString("jobno"));
				objdata.put("clientname", rsmain.getString("refname"));
				objdata.put("clientaddress", rsmain.getString("address"));
				objdata.put("clientmobile", rsmain.getString("per_mob"));
				objdata.put("jobdate", rsmain.getString("jobdate"));
				objdata.put("netamount", rsmain.getString("netamount"));
				objdata.put("discount", rsmain.getString("discount"));
				objdata.put("amount", rsmain.getString("amount"));
				objdata.put("discountpercent", rsmain.getString("discountpercent"));
				objdata.put("enqvocno", rsmain.getString("enqvocno"));
				objdata.put("enqdate", rsmain.getString("enqdate"));
				objdata.put("leadcreation", rsmain.getString("leadcreation"));
				objdata.put("qotcreation", rsmain.getString("qotcreation"));
				objdata.put("jobcreation", rsmain.getString("jobcreation"));
				objdata.put("qotdaystaken", rsmain.getString("qotdaystaken"));
				objdata.put("jobdaystaken", rsmain.getString("jobdaystaken"));
				objdata.put("enqdaystaken", rsmain.getString("enqdaystaken"));
				objdata.put("currentstatus",rsmain.getString("currentstatus"));
				JSONArray progressarray=new JSONArray();
				if(contracttype.equalsIgnoreCase("1")){
					progressarray=getJobProgressArrayData(rsmain.getString("jobno"),conn,contracttype);
				}
				objdata.put("progressarray", progressarray);
				dataarray.add(objdata);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			if(conn!=null){
				conn.close();
			}
				
		}
		
		return dataarray;
	}
	public JSONArray getJobProgressArrayData(String jobno,Connection conn,String contracttype) {
		// TODO Auto-generated method stub
		JSONArray dataarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			String strsql="";
				strsql="select date_format(D.date,'%d.%m.%Y') installdate,D.WRKPER installpercent,format(ROUND(C.NETAMOUNT*(D.WRKPER/100),2),2) installamt "+
				" from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND "+
				" M.COSTTYPE=C.COSTTYPE where c.doc_no="+jobno;
			ResultSet rs=stmt.executeQuery(strsql);
			int serial=1;
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("serial", serial);
				objtemp.put("installdate",rs.getString("installdate"));
				objtemp.put("installpercent", rs.getString("installpercent"));
				objtemp.put("installamt", rs.getString("installamt"));
				dataarray.add(objtemp);
				serial++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return dataarray;
	}
	public JSONArray getRemarksArrayData(String jobno,Connection conn) {
		// TODO Auto-generated method stub
		JSONArray dataarray=new JSONArray();
		try{
			String qotno="0",enqno="0";
			Statement stmt=conn.createStatement();
			String strsql="select m.tr_no,q.tr_no,e.doc_no enqno from cm_srvcontrm m left join cm_srvqotm q on m.reftrno=q.tr_no and m.ref_type='sqot' left join gl_enqm e on q.refdocno=e.doc_no and q.ref_type='enq' where m.tr_no="+jobno;
			System.out.println("strsql   ==== "+strsql);
			
			String strsql1="select 'Layout confirmation and Assignment' form,m.date cdate,m.remarks remarks,m.fdate,u.user_id user from gl_benq m inner join my_user u on u.doc_no=m.userid where m.rdocno="+enqno+" and m.status=3 group by m.doc_no order by m.fdate desc "
					+ "	union all select 'Design Handover' form,ef.fdate,ef.date cdate,ef.description remarks,u.user_id user from gl_enqfollowup ef inner join my_user u on u.doc_no=ef.userid where ef.rdocno="+enqno+" and ef.type=1 "
					+ " union all select 'Design Approval' form, m.date cdate,m.fdate,description remarks,u.user_id user from gl_enqaprfup m inner join my_user u on u.doc_no=m.userid where rdocno="+enqno+" "
					+ " union all select 'Quotation Follow Up' form,m.date cdate,m.remarks,m.fdate,u.user_id user from gl_bqot m inner join my_user u on u.doc_no=m.userid where m.rdocno="+qotno+" and m.bibpid=88 and m.status=3 group by m.doc_no order by m.fdate desc "
					+ "	union all select 'Site Verification' form,m.description remarks,m.date fdate,u.user_id user from gl_sitefollowup m inner join my_user u on u.doc_no=m.userid left join cm_srvcontrm s on s.tr_no=m.rdocno where s.doc_no="+jobno+" and  m.status=3 group by m.doc_no order by m.date desc "
					+ " union all select 'Production Drawing' form,pd.fdate ,pd.date cdate,pd.description remarks,u.user_id user from gl_prddraw pd inner join my_user u on u.doc_no=pd.userid left join cm_srvcontrm s on s.tr_no=pd.rdocno where s.doc_no="+jobno+" and pd.type=1 "
					+ "	union all select 'Client Drawing Confirmation' form,ef.date cdate,ef.fdate,ef.description remarks,u.user_id user from gl_cldrawconfirm ef inner join my_user u on u.doc_no=ef.userid left join cm_srvcontrm s on s.tr_no=ef.rdocno where s.doc_no="+jobno+" and type=1 "
					+ "	union all select 'Installation Request' form,u.user_name user,d.remarks,d.date fdate from gl_bssf d left join my_user u on (u.doc_no=d.userid) where d.doc_no='"+qotno+"' "
					+ " union all select 'Production Scheduler' form,ef.date fdate,ef.remarks from cm_instschfollow ef left join cm_srvcontrm s on s.tr_no=ef.rdocno where s.doc_no="+jobno+" "
					+ "	union all select 'Delivery Note Followup' form,u.user_name user,d.remarks,d.date fdate from cm_delnoteflwup d left join my_user u on (u.doc_no=d.userid) left join cm_delnotem m on m.rowno=d.doc_no where m.cntdocno='"+jobno+"' "
					+ "	union all select 'Customer FeedBack' form,u.user_name user,d.remarks,d.date fdate from gl_bccf d left join my_user u on (u.doc_no=d.userid) where d.doc_no='"+jobno+"'";  
			System.out.println("strsql1   ==== "+strsql1);
			ResultSet rs=stmt.executeQuery(strsql);
			int serial=1;
			while(rs.next()){
				JSONObject objtemp=new JSONObject();
				objtemp.put("serial", serial);
				objtemp.put("installdate",rs.getString("installdate"));
				objtemp.put("installpercent", rs.getString("installpercent"));
				objtemp.put("installamt", rs.getString("installamt"));
				dataarray.add(objtemp);
				serial++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return dataarray;
	}	
	
	
	
	
}
