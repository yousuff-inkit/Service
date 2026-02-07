package com.dashboard.inkit.jobcostanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsJobCostAnalysisDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray jobCostAnalysisGridLoading(String branch,String fromdate,String todate,String contracttype,String contract,String cldocno,String salesmandocno,String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		if(check.equalsIgnoreCase("0")){
			return RESULTDATA;
		}
		Connection conn = null;

		Statement stmt =null;
		ResultSet resultSet=null;
		
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			java.sql.Date sqlFromDate = null;
			java.sql.Date sqlToDate = null;
			
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlFromDate=ClsCommon.changeStringtoSqlDate(fromdate);
	     	}

	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
	     	}
	     	
	     	String sqltest="",sqltest1="";
	     	
	     	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	     		sqltest+=" and m.brhid="+branch+"";
	     		sqltest1+=" and j.brhid="+branch+"";
    		}
	     	
	     	if(!(sqlFromDate==null)){
	     		sqltest+=" and m.date>='"+sqlFromDate+"'";
	     		sqltest1+=" and j.date>='"+sqlFromDate+"'";
			}
	     	
	     	if(!(sqlToDate==null)){
	     		sqltest+=" and m.date<='"+sqlToDate+"'";
	     		sqltest1+=" and j.date<='"+sqlToDate+"'";
			}
	     	
	     	if(!(contracttype.equalsIgnoreCase("0")) && !(contracttype.equalsIgnoreCase(""))){
	     		sqltest+=" and m.dtype='"+contracttype+"'";
            }
	     	
	     	if(!(contract.equalsIgnoreCase("0")) && !(contract.equalsIgnoreCase(""))){
	     		sqltest+=" and m.tr_no="+contract+"";
            }
	     	
	     	if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
	     		sqltest+=" and m.cldocno="+cldocno+"";
            }
	     	
	     	if(!(salesmandocno.equalsIgnoreCase("0")) && !(salesmandocno.equalsIgnoreCase(""))){
	     		sqltest+=" and m.sal_id="+salesmandocno+"";
            }

	     	String sqld="select db1,db2 from my_comp";
				
			ResultSet rs = stmt.executeQuery(sqld);
				
			String db1="";
			String db2="";
			while(rs.next()) {
				db1=rs.getString("db1");
				db2=rs.getString("db2");
			}
	    	
	    	String sqldata="select m.doc_no jobnumber, m.dtype doctype, coalesce(ac.refname,'') client, m.validfrom startdate, m.validupto enddate, coalesce(sm.sal_name,'') salesperson, m.jobvalue,round(coalesce(ie.incomeamount,0),2) incomeamount,"
	    			+" round(coalesce(ie.expamount,0),2) expenseamount,convert(coalesce(concat(es.labourhrs,':00'),'00:00'),char(200)) labourhrstime,round(coalesce(es.labourvalue,0),2) labourvalue,round((coalesce(es.labourvalue,0)+coalesce(ie.expamount,0)),2) actualtotal,"
	    			+" round(coalesce(ie.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ie.expamount,0)),2) actualprofit,round((coalesce(ie.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ie.expamount,0)))-m.jobvalue,2) variationprofit,"
	    			+" round(coalesce((m.jobvalue/((coalesce(ie.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ie.expamount,0)))-(coalesce(m.jobvalue,0))))*100,0),2) variationprofitperc from ("
	    			+" select doc_no, dtype, cldocno, validfrom, validupto, sal_id, round(coalesce(contractval,0),2) jobvalue, tr_no, costtype, brhid, date, status from cm_srvcontrm where status=3"
	    			+" union all select doc_no, 'STC', cldocno, fromdt, todt, salid, 0 jobvalue, doc_no, 11 costtype, brhid, date, status from cm_staffcontrm where status=3"
	    			+" union all select doc_no, 'AMS', cldocno, fromdt, todt, salid, round(coalesce(noofmonths*amount,0),2) jobvalue, doc_no, 13 costtype, brhid, date, status from cm_amscontrm where status=3) m"
	    			+" left join my_acbook ac on (ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) "
	    			+" left join (select co.costtype,co.jobid,sum(if(gr_type=5,co.amount*-1,0)) incomeamount,sum(if(gr_type=4,co.amount,0)) expamount"
	    			+" from my_costtran co  inner join my_jvtran j on co.tranid=j.tranid left join my_head h on (h.doc_no=co.acno) "
	    			+" where co.status=3 and h.gr_type in (4,5) and co.costtype in (3,4) "+sqltest1 +"group by co.jobid,co.costtype) ie on ie.jobid=m.doc_no and ie.costtype=m.costtype "
	    			+" left join  (select dbname, costtype, costcode, sum(labourhrs) labourhrs, sum(labourvalue) labourvalue"
	    			+" from (select ts.dbname,ts.costtype,ts.costcode,(ts.totdays) labourhrs,CONVERT((totdays*ts.costperhour),CHAR(100)) labourvalue"
	    			+" from "+db1+".hr_workdetails ts where ts.costtype in ('SJOB','AMC','STC','AMS') and dbname='"+db1+"'" 
	    			+" union all select ts.dbname,ts.costtype,ts.costcode,(ts.totdays) labourhrs,CONVERT((totdays*ts.costperhour),CHAR(100)) labourvalue" 
	    			+" from "+db2+".hr_workdetails ts where ts.costtype in ('SJOB','AMC','STC','AMS') and dbname='"+db2+"') a"
	    			+" group by costtype,costcode,dbname) es on es.costcode=m.tr_no and es.costtype=m.dtype where m.status=3 "+sqltest;
	    	
	    	
	    	//System.out.println("brcnh sqldata  "+sqldata);
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

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
	
	public JSONArray contractDetailsSearch(HttpSession session,String dtype,String contractno,String check) throws SQLException {

		  JSONArray RESULTDATA=new JSONArray();
		  
		  if(!(check.equalsIgnoreCase("1"))){
			  return RESULTDATA;
		  }
		  
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

		  String brhid=session.getAttribute("BRANCHID").toString();

		  Connection conn = null;

		  try {
			   conn = ClsConnection.getMyConnection();
			   Statement stmt = conn.createStatement ();
	
			   String sql11="";


			   if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined") || dtype.equals("ALL"))){
				   if(dtype.equals("AMC") || dtype.equals("SJOB") ) {
					   sql11=sql11+" and cm.dtype='"+dtype+"'";
				   }
			   }
			   if(!(brhid.equals("0") || brhid.equals("") || brhid.equals("undefined") || brhid.equals("ALL"))){
					  sql11=sql11+" and cm.brhid='"+brhid+"'";
				   }
			   if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined") || contractno.equals("ALL"))){
				  sql11=sql11+" and cm.doc_no='"+contractno+"'";
			   }
			   
			   String sql="";
				
			   if(dtype.equals("AMC") || dtype.equals("SJOB") ) {
				   sql= "select tr_no,doc_no,refno from cm_srvcontrm cm where status=3 "+sql11+" order by doc_no";
				   
			   }else if(dtype.equals("STC")){
				   sql= "select doc_no tr_no,doc_no,refno from cm_staffcontrm cm where status=3 "+sql11+" order by doc_no";
				   
			   }else if(dtype.equals("AMS")){
				   sql= "select doc_no tr_no,doc_no,refno from cm_amscontrm cm where status=3 "+sql11+" order by doc_no";
				   
			   }
			   
			   ResultSet resultSet = stmt.executeQuery(sql);
	
			   RESULTDATA=ClsCommon.convertToJSON(resultSet);
			   
			   stmt.close();
			   conn.close();
		  } catch(Exception e){
			  conn.close();
			  e.printStackTrace();
		  }
		  return RESULTDATA;
		 }
	
	public JSONArray clientDetailsSearch(HttpSession session,String clname,String mob,int id) throws SQLException {

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
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();

			if(id>0){
				String sql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);
				ResultSet resultSet = stmt.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
				stmt.close();
				conn.close();
			}
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return RESULTDATA;
	}
	
	public JSONArray salesManDetailsSearch(HttpSession session,String slname,String mob,int id) throws SQLException {

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

		if(!(slname.equalsIgnoreCase("undefined"))&&!(slname.equalsIgnoreCase(""))&&!(slname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and sal_name like '%"+slname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and mob_no like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();

			if(id>0){
				String sql= ("select sal_name,mob_no,doc_no from my_salm where status=3 " +sqltest);
				ResultSet resultSet = stmt.executeQuery(sql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			
				stmt.close();
				conn.close();
			}
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return RESULTDATA;
	}
}