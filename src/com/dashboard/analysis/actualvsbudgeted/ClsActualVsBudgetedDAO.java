package com.dashboard.analysis.actualvsbudgeted;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsActualVsBudgetedDAO {
	ClsConnection objconn = new ClsConnection();

	ClsCommon objcommon = new ClsCommon();

	public JSONArray actualvsbudgetedList(String fromdate, String todate, String load) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		if (!(load.equalsIgnoreCase("yes"))) {
			return RESULTDATA;
		}

		Connection conn = null;

		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
			if(fromdate!=null && !fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("undefined")) {
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			
			if(todate!=null && !todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("undefined")) {
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			/*String sql = "select coalesce(s.sal_name,'')salesman, sum(coalesce(mnt,0))mnt, sum(coalesce(inv,0))inv,\r\n" + 
					"sum(coalesce(mnt,0))+sum(coalesce(inv,0))total, sum(coalesce(targetval,0))budget,\r\n" + 
					"(sum(coalesce(mnt,0))+sum(coalesce(inv,0)))-sum(coalesce(targetval,0)) balance from(\r\n" + 
					"select a.sal_id, m.taxtotal mnt, 0 inv, 0 targetval, m.brhid, year(m.date)year, month(m.date)month \r\n" + 
					"from ws_invm m left join ws_jobcard job on (m.reftype='JC' and m.refno=job.doc_no)\r\n" + 
					"left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) \r\n" + 
					"left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))\r\n" + 
					"left join my_acbook a on (gate.cldocno=a.cldocno and a.dtype='CRM') where m.status=3\r\n" + 
					"union all select m.sal_id, 0 mnt, m.netamount inv,0 targetval, m.brhid, year(m.date)year, month(m.date)month \r\n" + 
					"from my_invm m where m.status=3\r\n" + 
					"union all select m.salid sal_id, 0 mnt, 0 inv, m.targetval, m.brhid, cast(m.year as UNSIGNED)year, cast(m.month as UNSIGNED)month from cm_monthsalem m where m.type=2)t\r\n" + 
					"inner join my_salm s on s.doc_no=t.sal_id where s.status=3 and t.year="+year+" and t.month="+month+" group by t.sal_id order by s.sal_name";
			*/
			
			String strsale="SELECT sal.SAL_NAME,sal.DOC_NO,COALESCE(mnt.nettotal,0) mnttotal,COALESCE(inv.netamount,0) invtotal FROM my_salm sal \r\n" + 
					"LEFT JOIN \r\n" + 
					"(SELECT ROUND(COALESCE(SUM(inv.nettotal),0),2) nettotal,ac.sal_id FROM ws_invm inv\r\n" + 
					" LEFT JOIN ws_jobcard job ON (inv.refno=job.doc_no AND inv.reftype='JC')\r\n" + 
					" LEFT JOIN ws_estm est ON (est.doc_no=job.refno AND job.reftype='EST')\r\n" + 
					" LEFT JOIN ws_gateinpass gate ON est.gipno=gate.doc_no\r\n" + 
					" LEFT JOIN my_acbook ac ON (gate.cldocno=ac.cldocno AND ac.dtype='CRM')\r\n" + 
					" WHERE inv.date>='"+sqlfromdate+"' AND inv.date<='"+sqltodate+"' AND inv.status=3 GROUP BY ac.sal_id) mnt ON sal.DOC_NO=mnt.sal_id\r\n" + 
					" \r\n" + 
					" LEFT JOIN \r\n" + 
					" (SELECT ROUND(COALESCE(SUM(inv.netamount),0),2) netamount,inv.sal_id FROM my_invm inv \r\n" + 
					" WHERE inv.date>='"+sqlfromdate+"' AND inv.date<='"+sqltodate+"' AND inv.status=3 GROUP BY inv.sal_id) inv ON sal.doc_no=inv.sal_id\r\n" + 
					" WHERE sal.status=3";
			//System.out.println(strsale);
			ResultSet rssale = stmt.executeQuery(strsale);
			
			while(rssale.next()) {
				JSONObject objtemp=new JSONObject();
				int saldocno=rssale.getInt("doc_no");
				objtemp.put("salesman",rssale.getString("sal_name"));
				objtemp.put("saldocno",saldocno);
				double target=calculateTarget(saldocno,sqlfromdate,sqltodate,conn);
				objtemp.put("mnt",rssale.getDouble("mnttotal"));
				objtemp.put("inv",rssale.getDouble("invtotal"));
				double total=rssale.getDouble("mnttotal")+rssale.getDouble("invtotal");
				objtemp.put("total", total);
				objtemp.put("budget",target);
				double balance=total-target;
				objtemp.put("balance",balance);
				RESULTDATA.add(objtemp);
			}
			stmt.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return RESULTDATA;
	}

	private double calculateTarget(int saldocno, Date sqlfromdate, Date sqltodate, Connection conn) {
		// TODO Auto-generated method stub
		double totaltarget=0.0;
		try {
			Statement stmt=conn.createStatement();
			String strsql="SELECT base.year,base.month,base.salid,SUM(ROUND(CASE \r\n" + 
					" when base.year=YEAR('"+sqlfromdate+"') and base.year=YEAR('"+sqltodate+"') AND base.month=MONTH('"+sqlfromdate+"') and month('"+sqlfromdate+"')=month('"+sqltodate+"') then (base.targetval/base.fromdatelast)*(timestampdiff(day,'"+sqlfromdate+"','"+sqltodate+"')+1) "+
					"WHEN base.year=YEAR('"+sqlfromdate+"') AND base.month=MONTH('"+sqlfromdate+"') THEN (base.targetval/base.fromdatelast)*(base.fromdatelast-DAY('"+sqlfromdate+"'))\r\n" + 
					"WHEN base.year=YEAR('"+sqltodate+"') AND base.month=MONTH('"+sqltodate+"') THEN (base.targetval/base.todatelast)*(DAY('"+sqltodate+"'))\r\n" + 
					"ELSE base.targetval END,2)) target FROM (\r\n" + 
					"SELECT tr.*,DAY(LAST_DAY('"+sqlfromdate+"')) fromdatelast,DAY(LAST_DAY('"+sqltodate+"')) todatelast FROM cm_monthsalem tr WHERE tr.type=2 AND tr.salid="+saldocno+" \r\n" + 
					"AND tr.month>=MONTH('"+sqlfromdate+"') AND tr.month<=MONTH('"+sqltodate+"') AND tr.year>=YEAR('"+sqlfromdate+"') AND tr.year<=YEAR('"+sqltodate+"')) base";
			//System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()) {
				totaltarget=rs.getDouble("target");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return totaltarget;
	}
	
	

}
