package com.dashboard.seal.expensesinvoice;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
public class ClsExpensesInvoiceDAO {
	 ClsConnection conobj = new ClsConnection();
	 ClsCommon com = new ClsCommon(); 
	 Connection conn;
	 public JSONArray invoiceGridLoad(int id, String brhid, String todate) throws SQLException {
	    	JSONArray result = new JSONArray();
	    	if(id==0) {
	    		return result;
	    	}  
	    	try {  
	    		conn = conobj.getMyConnection();
	    		Statement stmt = conn.createStatement();
	    		String sqltest = "", sqltest1 = "", sqltest2 = "";
	    		java.sql.Date sqltodate = null;  
	    		if(!todate.equalsIgnoreCase("") && todate!=null) {
	    			sqltodate = com.changeStringtoSqlDate(todate);  
	    			sqltest += " AND j.date<='"+sqltodate+"'";  
	    			sqltest1 += " AND date<='"+sqltodate+"'";  
	    		}
	    		if(!brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("0")) {
	    			sqltest += " AND j.brhid='"+brhid+"'";
	    			sqltest2 += " AND s.brhid='"+brhid+"'";   
	    		}
	    		String sql = "SELECT CONVERT(DATE_FORMAT(b.date,'%d.%m.%Y'),CHAR(45)) date,b.type,b.brhid,b.taxper,b.account,b.accountname,b.description,b.amount,b.invamt,b.tranid,b.costtype,b.costcode,b.refname,ROUND((taxper*amount)/100,2) taxamt,ROUND(((taxper*amount)/100)+amount,2) nettotal,cnttrno  FROM(SELECT 'JV' type,j.date,j.brhid,IF((SELECT method FROM gl_config WHERE field_nme='DISBURSEMENTTAXZERO')='1' AND h.doc_no in(11160,11400,11403),0,5) taxper,h.account,h.description accountname,convert(j.description,char(1500)) description,ROUND(COALESCE(j.ldramount*j.id,0),2) amount,ROUND(COALESCE(j.ldramount*j.id,0),2) invamt,CONVERT(j.tranid,CHAR(45)) tranid,IF(j.costtype='3','AMC','') costtype,CONVERT(j.costcode,CHAR(45)) costcode, ac.refname, cm.tr_no cnttrno FROM my_jvtran j LEFT JOIN my_head h ON h.doc_no=j.acno LEFT JOIN sa_expenseinv ex ON ex.tranid=j.tranid LEFT JOIN cm_srvcontrm cm ON (cm.doc_no=j.costcode AND j.brhid=cm.brhid AND cm.costtype=j.costtype) LEFT JOIN my_acbook ac ON ac.cldocno=cm.cldocno AND ac.dtype='CRM' WHERE j.costtype=3 AND (j.costcode!=0 AND j.costcode!='' AND j.costcode IS NOT NULL) AND j.status=3 AND gr_type=4 AND COALESCE(ex.invtrno,0)=0"+sqltest+" UNION ALL SELECT 'HR' type,a.* FROM(SELECT s.date,s.brhid,IF((SELECT method FROM gl_config WHERE field_nme='DISBURSEMENTTAXZERO')='1' AND h.doc_no in(11160,11400,11403),0,5) taxper,h.account, h.description accountname, convert(CONCAT(e.name,' - ', ROUND(s.normalhr,2),'Hrs, Cost per Hour - ',ROUND(s.costperhour,2)),char(1500)) description, ROUND(s.amount,2) amount, ROUND(s.amount,2) invamt, CONVERT(CONCAT(empid,'/',s.costtype,'/',s.costcode),CHAR(45)) tranid, IF(s.costtype='3','AMC','') costtype, CONVERT(s.costcode,CHAR(45)) costcode,ac.refname, cm.tr_no cnttrno FROM (SELECT date,empid,SUM((normal/60)*costperhour) amount,costtype, costcode,sum(normal/60) normalhr, sum(costperhour) costperhour, brhid FROM hr_timesheethrs WHERE status=3 and invtrno=0"+sqltest1+" GROUP BY empid,costtype,costcode) s LEFT JOIN hr_empm e ON s.empid=e.doc_no LEFT JOIN my_head h ON h.doc_no=e.acno LEFT JOIN cm_srvcontrm cm ON (cm.doc_no=s.costcode AND s.brhid=cm.brhid AND cm.costtype=s.costtype) LEFT JOIN my_acbook ac ON ac.cldocno=cm.cldocno AND ac.dtype='CRM' WHERE s.costtype=3 AND (s.costcode!=0 AND s.costcode!='' AND s.costcode IS NOT NULL)"+sqltest2+")a WHERE a.amount!=0)b";
	    		//System.out.println("sql7==="+sql);               
	    		ResultSet rs = stmt.executeQuery(sql);
	    		result = com.convertToJSON(rs);   
	    	}catch(Exception e) {
	    		e.printStackTrace();
	    	}finally {
	    		conn.close();
	    	}
	    	return result;
	    }
	 public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Enumeration<String> Enumeration = session.getAttributeNames();
			int a=0;
			while(Enumeration.hasMoreElements()){
				if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
					a=1;
				}
			}
			if(a==0){
				return RESULTDATA;
			}


			String brid=session.getAttribute("BRANCHID").toString();


			String sqltest="";

			if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and refname like '%"+clname+"%'";
			}
			if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and per_mob like '%"+mob+"%'";
			}


			Connection conn = null;
			try {
				conn = conobj.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();    

				if(id>0){
					String clsql= ("select round(cr.rate,2) rate,ac.curid,tax,acno,per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,sal_name as salname,sm.doc_no as salid"
							+ " from my_acbook ac left join my_curbook cr on cr.curid=ac.curid  left join my_salm sm on(ac.sal_id=sm.doc_no) where  dtype='CRM' and ac.status=3 " +sqltest);
					ResultSet resultSet = stmtVeh1.executeQuery(clsql);

					RESULTDATA=com.convertToJSON(resultSet);
					stmtVeh1.close();
					conn.close();
				}
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			} finally{
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
	 public JSONArray currencySearch(String date,String brhid) throws SQLException  
		{
			JSONArray RESULTDATA=new JSONArray();
			Connection conn =null;
			Statement stmt =null;
			try {
				conn = conobj.getMyConnection();
				stmt = conn.createStatement ();
				java.sql.Date sqlDate = null;
				if(!date.equals("") && date!=null) {
					sqlDate = com.changeStringtoSqlDate(date);
				}  
				String sql = "select c.doc_no curid,c.code,cb.rate rate,cb.type from my_brch b inner join my_curr c on(c.doc_no=b.curId) inner join my_curbook cb on (b.curid=cb.curid) "
						+"inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and "
						+"frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where b.doc_no='"+brhid+"'";  
						//System.out.println("------------------"+sql);
				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=com.convertToJSON(resultSet);
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmt.close();
				conn.close();
			}
			//	System.out.println(RESULTDATA);
			return RESULTDATA;

		}
}
