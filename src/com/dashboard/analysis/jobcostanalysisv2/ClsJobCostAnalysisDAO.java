package com.dashboard.analysis.jobcostanalysisv2;

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

	public JSONArray jobCostAnalysisGridLoading(String branch,String fromdate,String todate,String contracttype,String contract,String cldocno,String salesmandocno,String type,String check) throws SQLException {
		//System.out.println("type==="+type);    	
		JSONArray RESULTDATA=new JSONArray();

		if(!check.equalsIgnoreCase("1")){
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
	     	
	     	String sqltest="",sqltest1="", sqldata="";
	     	
	     	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	     		sqltest+=" and m.brhid="+branch+"";
	     		sqltest1+=" and j.brhid="+branch+"";
    		}
	     	
	     	if(!(sqlFromDate==null)){
	     		//sqltest+=" and m.date>='"+sqlFromDate+"'";
	     		sqltest1+=" and j.date>='"+sqlFromDate+"'";
			}
	     	
	     	if(!(sqlToDate==null)){
	     		//sqltest+=" and m.date<='"+sqlToDate+"'";
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
	     	//String sqldata="select ic.jobid,m.doc_no,ic.costtype,m.costtype,m.doc_no jobnumber,m.dtype doctype,m.validfrom startdate,m.validupto enddate,CASE WHEN m.jbaction=0 THEN 'OPEN' WHEN m.jbaction=1 THEN 'HOLD' WHEN m.jbaction=2 THEN 'CLOSED' WHEN m.jbaction=3 THEN 'COMPLETED' WHEN m.jbaction=4 THEN 'STARTED' ELSE '' END AS status,coalesce(ac.refname,'') client,coalesce(sm.sal_name,'') salesperson,round(coalesce(m.contractval,0),2) jobvalue,round(coalesce(ic.incomeamount,0),2) incomeamount,round(coalesce(ec.expenseamount,0),2) actualmaterialamount,round(coalesce(ec.materialexpenseamount,0),2) actualmaterialexpenseamount,coalesce(es.labourhrs,0) labourhrs,coalesce(labourhrstime,'00:00') labourhrstime,round(coalesce(es.labourvalue,0),2) labourvalue,round((coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)),2) actualtotal,round(coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)),2) actualprofit,round((coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)))-(coalesce(m.contractval,0)),2) variationprofit,round(coalesce(((coalesce(m.contractval,0))/((coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)))-(coalesce(m.contractval,0))))*100,0),2) variationprofitperc from cm_srvcontrm m left join cm_srvqotm sq on sq.tr_no=m.reftrno and sq.status=3 left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 left join cm_srvdetm sr on sr.tr_no=sq.refdocno and sq.ref_type='SRVE' left join cm_prjestm est on ((eq.doc_no=est.refdocno and est.ref_type ='ENQ' and eq.brhid=est.brhid) or (sr.doc_no=est.refdocno and est.ref_type ='SRVE'  and sr.brhid=est.brhid)) and est.status=3 left join (select co.costtype,j.costcode jobid,sum(COALESCE(IF('"+type+"'='base',j.dramount,j.ldramount),0)*-1) incomeamount,h.description,j.brhid from my_costtran co  inner join my_jvtran j on co.tranid=j.tranid  left join my_head h on (h.doc_no=co.acno) where co.status=3 and  h.gr_type=5 and co.costtype in (3,4)  "+sqltest1+"  group by co.jobid,co.costtype,j.brhid) ic on ic.jobid=m.doc_no and ic.costtype=m.costtype  and ic.brhid=m.brhid  left join (select ea.costtype,ea.jobid,sum(ea.amount) expenseamount,sum(ea.materialamount) materialexpenseamount,brhid from (select co.costtype,j.costcode jobid,if(it.acno is null,COALESCE(IF('"+type+"'='base',j.dramount,j.ldramount),0),0) amount,if(it.acno is not null,COALESCE(IF('"+type+"'='base',j.dramount,j.ldramount),0),0) materialamount,j.brhid from my_costtran co  inner join my_jvtran j on co.tranid=j.tranid  left join my_head h on (h.doc_no=co.acno) left join my_issuetype it on (it.acno=co.acno) where co.status=3 and h.gr_type=4 and co.costtype in (3,4)  "+sqltest1+" )  ea group by ea.jobid,ea.costtype,brhid) ec on ec.jobid=m.doc_no and ec.costtype=m.costtype  and ec.brhid=m.brhid  left join (select ts.costtype,ts.costcode,sum(ts.labourhrs) labourhrs,CONVERT(concat(Floor(sum(ts.labourhrs)/60),':',(sum(ts.labourhrs)-(Floor(sum(ts.labourhrs)/60)*60))),CHAR(100)) labourhrstime,sum(ts.labourvalue) labourvalue from (select ts.costtype,ts.costcode,coalesce(normal,'0') labourhrs, round((SUBSTRING_INDEX(normalhrs,':',1)*ts.costperhour) + ((SUBSTRING_INDEX(normalhrs,':',-1)/60)*ts.costperhour),2) labourvalue from  hr_timesheethrs ts  left join hr_empm e on e.doc_no=ts.empid left join (select catid,max(doc_no) doc from hr_paycode where status=3 group by catid) c on e.pay_catid=c.catid  left join hr_paycode pc on e.pay_catid=pc.catid and pc.status=3 and c.doc=pc.doc_no where ts.costtype in (3,4)) ts group by ts.costtype,ts.costcode) es on es.costcode=m.doc_no and es.costtype=m.costtype left join my_acbook ac on (ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) where m.status=3 "+sqltest+" order by m.doc_no ";
	     	//String sqldata="select ic.jobid,m.doc_no,ic.costtype,m.costtype,m.doc_no jobnumber,m.dtype doctype,m.validfrom startdate,m.validupto enddate,CASE WHEN m.jbaction=0 THEN 'OPEN' WHEN m.jbaction=1 THEN 'HOLD' WHEN m.jbaction=2 THEN 'CLOSED' WHEN m.jbaction=3 THEN 'COMPLETED' WHEN m.jbaction=4 THEN 'STARTED' ELSE '' END AS status,coalesce(ac.refname,'') client,coalesce(sm.sal_name,'') salesperson,round(coalesce(m.contractval,0),2) jobvalue,round(coalesce(ic.incomeamount,0),2) incomeamount,round(coalesce(ec.expenseamount,0),2) actualmaterialamount,round(coalesce(ec.materialexpenseamount,0),2) actualmaterialexpenseamount,coalesce(es.labourhrs,0) labourhrs,coalesce(labourhrstime,'00:00') labourhrstime,round(coalesce(es.labourvalue,0),2) labourvalue,round((coalesce(ec.expenseamount,0)),2) actualtotal,round(coalesce(ic.incomeamount,0)-(coalesce(ec.expenseamount,0)),2) actualprofit,round((coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)))-(coalesce(m.contractval,0)),2) variationprofit,round(coalesce(((coalesce(m.contractval,0))/((coalesce(ic.incomeamount,0)-(coalesce(es.labourvalue,0)+coalesce(ec.materialexpenseamount,0)+coalesce(ec.expenseamount,0)))-(coalesce(m.contractval,0))))*100,0),2) variationprofitperc from cm_srvcontrm m left join cm_srvqotm sq on sq.tr_no=m.reftrno and sq.status=3 left join gl_enqm eq on eq.doc_no=sq.refdocno and sq.ref_type='ENQ' and eq.status=3 left join cm_srvdetm sr on sr.tr_no=sq.refdocno and sq.ref_type='SRVE' left join cm_prjestm est on ((eq.doc_no=est.refdocno and est.ref_type ='ENQ' and eq.brhid=est.brhid) or (sr.doc_no=est.refdocno and est.ref_type ='SRVE'  and sr.brhid=est.brhid)) and est.status=3 left join (select co.costtype,j.costcode jobid,sum(COALESCE(IF('"+type+"'='base',j.dramount,j.ldramount),0)*-1) incomeamount,h.description,j.brhid from my_costtran co  inner join my_jvtran j on co.tranid=j.tranid  left join my_head h on (h.doc_no=co.acno) where co.status=3 and  h.gr_type=5 and co.costtype in (3,4)  "+sqltest1+"  group by co.jobid,co.costtype,j.brhid) ic on ic.jobid=m.doc_no and ic.costtype=m.costtype  and ic.brhid=m.brhid  left join (select ea.costtype,ea.jobid,sum(ea.amount) expenseamount,sum(ea.materialamount) materialexpenseamount,brhid from (select co.costtype,j.costcode jobid,if(it.acno is null,COALESCE(IF('"+type+"'='base',j.dramount,j.ldramount),0),0) amount,if(it.acno is not null,COALESCE(IF('"+type+"'='base',j.dramount,j.ldramount),0),0) materialamount,j.brhid from my_costtran co  inner join my_jvtran j on co.tranid=j.tranid  left join my_head h on (h.doc_no=co.acno) left join my_issuetype it on (it.acno=co.acno) where co.status=3 and h.gr_type=4 and co.costtype in (3,4)  "+sqltest1+" )  ea group by ea.jobid,ea.costtype,brhid) ec on ec.jobid=m.doc_no and ec.costtype=m.costtype  and ec.brhid=m.brhid  left join (select ts.costtype,ts.costcode,sum(ts.labourhrs) labourhrs,CONVERT(concat(Floor(sum(ts.labourhrs)/60),':',(sum(ts.labourhrs)-(Floor(sum(ts.labourhrs)/60)*60))),CHAR(100)) labourhrstime,sum(ts.labourvalue) labourvalue from (select ts.costtype,ts.costcode,coalesce(normal,'0') labourhrs, round((SUBSTRING_INDEX(normalhrs,':',1)*ts.costperhour) + ((SUBSTRING_INDEX(normalhrs,':',-1)/60)*ts.costperhour),2) labourvalue from  hr_timesheethrs ts  left join hr_empm e on e.doc_no=ts.empid left join (select catid,max(doc_no) doc from hr_paycode where status=3 group by catid) c on e.pay_catid=c.catid  left join hr_paycode pc on e.pay_catid=pc.catid and pc.status=3 and c.doc=pc.doc_no where ts.costtype in (3,4)) ts group by ts.costtype,ts.costcode) es on es.costcode=m.doc_no and es.costtype=m.costtype left join my_acbook ac on (ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) where m.status=3 "+sqltest+" order by m.doc_no ";
	     	if(type.equalsIgnoreCase("client")) {  
                sqldata="select b.branchname brhid,ic.descs desc1,round(m.rate,2) rate,c.code currency,ic.jobid,m.doc_no,ic.costtype,m.costtype,m.doc_no jobnumber,m.dtype doctype,m.validfrom startdate,m.validupto enddate,CASE WHEN m.jbaction=0 THEN 'OPEN' WHEN m.jbaction=1 THEN 'HOLD' WHEN m.jbaction=2 THEN 'CLOSED' WHEN m.jbaction=3 THEN 'COMPLETED' WHEN m.jbaction=4 THEN 'STARTED' ELSE '' END AS status,coalesce(ac.refname,'') client,coalesce(sm.sal_name,'') salesperson,round(coalesce(m.contractval,0),2) jobvalue,case when ic.dtype='SRS' then round(coalesce(ic.incomeamount,0)/coalesce(md.rate,0),2) when ic.dtype='CPU' then round(coalesce(ic.incomeamount,0)/coalesce(sd.rate,0),2) when ic.dtype!='SRS' then round(coalesce(ic.incomeamount,0)/coalesce(m.rate,0),2) else 0 end incomeamount,case when ic.dtype='SRS' then round(coalesce(ic.expenseamount,0)/coalesce(md.rate,0),2) when ic.dtype='CPU' then round(coalesce(ic.expenseamount,0)/coalesce(sd.rate,0),2) when ic.dtype!='SRS' then round(coalesce(ic.expenseamount,0)/coalesce(m.rate,0),2)  else 0 end actualmaterialamount,(case when ic.dtype='SRS' then round(coalesce(ic.incomeamount,0)/coalesce(md.rate,0),2) when ic.dtype='CPU' then round(coalesce(ic.incomeamount,0)/coalesce(sd.rate,0),2) when ic.dtype!='SRS' then round(coalesce(ic.incomeamount,0)/coalesce(m.rate,0),2) else 0 end)-(case when ic.dtype='SRS' then round(coalesce(ic.expenseamount,0)/coalesce(md.rate,0),2) when ic.dtype='CPU' then round(coalesce(ic.expenseamount,0)/coalesce(sd.rate,0),2) when ic.dtype!='SRS' then round(coalesce(ic.expenseamount,0)/coalesce(m.rate,0),2) else 0 end) actualprofit from cm_srvcontrm m left join my_brch b on b.doc_no=m.brhid left join my_curr c on c.doc_no=m.curid inner join (select j.description descs,j.doc_no, j.dtype, co.costtype,j.costcode jobid,SUM(IF(h.gr_type=5,COALESCE(j.ldramount,0)*-1,0)) incomeamount,SUM(IF(h.gr_type=4,COALESCE(j.ldramount,0),0)) expenseamount,h.description,j.brhid from my_costtran co inner join my_jvtran j on co.tranid=j.tranid  left join my_head h on (h.doc_no=co.acno) where co.status=3 and h.gr_type in(5,4) and co.costtype in (3,4)"+sqltest1+" group by co.jobid,co.costtype,j.brhid) ic on ic.jobid=m.doc_no and ic.costtype=m.costtype and ic.brhid=m.brhid left join my_acbook ac on (ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) left join my_srvsalem md on md.doc_no=ic.doc_no and md.dtype=ic.dtype left join my_srvpurm sd on sd.doc_no=ic.doc_no and sd.dtype=ic.dtype where m.status=3"+sqltest+" order by m.doc_no";
            }else {
               sqldata="select b.branchname brhid,ic.descs desc1,round(m.rate,2) rate,c.code currency,ic.jobid,m.doc_no,ic.costtype,m.costtype,m.doc_no jobnumber,m.dtype doctype,m.validfrom startdate,m.validupto enddate,CASE WHEN m.jbaction=0 THEN 'OPEN' WHEN m.jbaction=1 THEN 'HOLD' WHEN m.jbaction=2 THEN 'CLOSED' WHEN m.jbaction=3 THEN 'COMPLETED' WHEN m.jbaction=4 THEN 'STARTED' ELSE '' END AS status,coalesce(ac.refname,'') client,coalesce(sm.sal_name,'') salesperson,round(coalesce(m.contractval,0),2) jobvalue,round(coalesce(ic.incomeamount,0),2) incomeamount,round(coalesce(ic.expenseamount,0),2) actualmaterialamount,round(coalesce(ic.incomeamount,0),2)-round(coalesce(ic.expenseamount,0),2) actualprofit from cm_srvcontrm m  left join my_brch b on b.doc_no=m.brhid left join my_curr c on c.doc_no=m.curid inner join (select j.description descs,j.doc_no, j.dtype, co.costtype,j.costcode jobid,SUM(IF(h.gr_type=5,COALESCE(j.ldramount,0)*-1,0)) incomeamount,SUM(IF(h.gr_type=4,COALESCE(j.ldramount,0),0)) expenseamount,h.description,j.brhid from my_costtran co inner join my_jvtran j on co.tranid=j.tranid   left join my_head h on (h.doc_no=co.acno) where co.status=3 and h.gr_type in(5,4) and co.costtype in (3,4)"+sqltest1+" group by co.jobid,co.costtype,j.brhid) ic on ic.jobid=m.doc_no and ic.costtype=m.costtype and ic.brhid=m.brhid left join my_acbook ac on (ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) where m.status=3"+sqltest+" order by m.doc_no";
            }
	     	//System.out.println("JOB COST="+sqldata);            
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
				  sql11=sql11+" and cm.dtype='"+dtype+"'";
			   }
			   if(!(brhid.equals("0") || brhid.equals("") || brhid.equals("undefined") || brhid.equals("ALL"))){
					  sql11=sql11+" and cm.brhid='"+brhid+"'";
				   }
			   if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined") || contractno.equals("ALL"))){
				  sql11=sql11+" and cm.doc_no='"+contractno+"'";
			   }
				  
			   String sql= "select tr_no,doc_no,refno from cm_srvcontrm cm where status=3 and 1=1 "+sql11+" order by doc_no";
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
				String sql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest+" order by refname" );
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
		 
		if(id!=1){   
			return RESULTDATA;
		}

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

			 
				String sql= ("select sal_name,mob_no,doc_no from my_salm where status=3 " +sqltest);
				//System.out.println(sql);
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
}