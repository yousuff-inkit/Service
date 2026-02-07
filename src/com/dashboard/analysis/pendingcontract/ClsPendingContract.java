package com.dashboard.analysis.pendingcontract;


import java.sql.CallableStatement;
import net.sf.json.JSONObject;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import net.sf.json.JSONArray;

public class ClsPendingContract {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon common =new ClsCommon();
	ClsPendingContractBean bean = new ClsPendingContractBean();
	JSONArray prdarray=new JSONArray();
    JSONObject objprd=new JSONObject();

	
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
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
			String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM'  " +sqltest);

			ResultSet resultSet = stmtVeh1.executeQuery(clsql);

			RESULTDATA=common.convertToJSON(resultSet);
			stmtVeh1.close();
			conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	
	

	public JSONArray pendingContractGridLoad(ClsPendingContractBean bean, HttpSession session) throws SQLException
	{
		JSONArray RESULTDATA=new JSONArray();
		//String session = bean.getSession(); 
        String dtype=bean.getDtype();
        String date=bean.getDate();
        String branchid=bean.getBranch();
        String clientid=bean.getClientid();
        int id=bean.getId();  
        String cstatus=bean.getCstatus();
        
		if(id!=1) {
			return RESULTDATA;  
		}

		String brcid=branchid.toString();   


		String sql11="";
		   
     
		if(!(clientid.trim().equalsIgnoreCase("0") || clientid.trim().equalsIgnoreCase("") || clientid.trim().equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.cldocno="+clientid+"";
		}
		 if(!(date.equalsIgnoreCase("0") || date.equalsIgnoreCase("") || date.equalsIgnoreCase("undefined"))){
			java.sql.Date todate=common.changeStringtoSqlDate(date);
			sql11=sql11+" and m.date<='"+todate+"'"; 
		}

	  if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+")";
		}
		 if(!(dtype.equalsIgnoreCase("0") || dtype.equalsIgnoreCase("") || dtype.equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.dtype='"+dtype+"'";
		}
		



		Connection conn =null;
		Statement stmt =null;
		try {
			conn = ClsConnection.getMyConnection();   
			stmt = conn.createStatement ();
			

			/*String sql="select dtype,docno,client,status,DATE_FORMAT(sdate,'%d-%m-%Y') as sdate,DATE_FORMAT(edate,'%d-%m-%Y') as edate,convert(concat(coalesce(pend,0),'/',coun),char(50)) as dueno,cntramt,coalesce(round(dueamt,2),0) as dueamt,site from "
					+ "(select m.dtype,m.doc_no docno,ac.refname as client,if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) as status,"
					+ "validfrom sdate,validupto as edate,pd.pend,coalesce(p.cnt,0) as coun,m.contractval as cntramt,sum(pd.amount) as dueamt,sd.site from cm_srvcontrm m "
					+ "  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
					+ "left join (select  c.doc_no,c.cnt cnt,siteid from ( select count(*) as cnt,tr_no as doc_no,'' siteid from cm_srvcontrpd  group by tr_no "
					+ "union all select count(*) as cnt,doc_no,siteid from cm_servplan where serinv=1  group by doc_no) c group by doc_no) as p on p.doc_no=m.tr_no "
					+ "left join (select count(tr_no) as pend,tr_no,sum(amount) amount from cm_srvcontrpd  where invamt<=0 and invtrno<=0 group by tr_no union all "
					+ "select count(doc_no) as pend,doc_no as tr_no,sum(servamt) as amount from cm_servplan  where  invtrno<=0 and serinv=1 group by doc_no) as pd on pd.tr_no=m.tr_no "
					+ " left join cm_srvcsited sd on p.siteid=sd.rowno where jbaction!=3 and m.status=3 "+sql11+" "
					+ "group by m.tr_no order by validupto) as a";*/
			
			////site added/////
			String sql="select dtype,docno,client,status,coalesce(DATE_FORMAT(sdate,'%d-%m-%Y'),'' ) as sdate,coalesce(DATE_FORMAT(edate,'%d-%m-%Y'),'' ) as edate,convert(concat(coalesce(pend,0),'/',coun),char(50)) as dueno,cntramt,coalesce(round(dueamt,2),0) as dueamt,site,sal_id,refno,sal_name from "
					+ "(select m.dtype,m.doc_no docno,ac.refname as client,if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) as status,"
					+ "validfrom sdate,validupto as edate,pd.pend,coalesce(p.cnt,0) as coun,m.contractval as cntramt,sum(pd.amount) as dueamt,sd.site,m.sal_id,m.refno,s.sal_name from cm_srvcontrm m "
					+ "  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
					+ "left join (select  c.doc_no,c.cnt cnt from ( select count(*) as cnt,tr_no as doc_no from cm_srvcontrpd  group by tr_no "
					+ "union all select count(*) as cnt,doc_no from cm_servplan where serinv=1  group by doc_no) c group by doc_no) as p on p.doc_no=m.tr_no "
					+ "left join (select count(tr_no) as pend,tr_no,sum(amount) amount from cm_srvcontrpd  where invamt<=0 and invtrno<=0 group by tr_no union all "
					+ "select count(doc_no) as pend,doc_no as tr_no,sum(servamt) as amount from cm_servplan  where  invtrno<=0 and serinv=1 group by doc_no) as pd on pd.tr_no=m.tr_no "
					+ " left join ( select GROUP_CONCAT(site) site,tr_no from cm_srvcsited group by tr_no order by sr_no) sd on sd.tr_no=m.tr_no " 
					+ " left join my_salm s on s.sal_id=m.sal_id "
					+ " where jbaction not in(2,3) and m.status=3 "+sql11+" "
					+ "group by m.tr_no order by validupto) as a";
			//System.out.println("==pendingContractGridLoad==="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql) ;
			//RESULTDATA=common.convertToJSON(resultSet);
			
			while(resultSet.next()){
				 JSONObject objsub=new JSONObject();
				 objsub.put("dtype", resultSet.getString("dtype"));
				 objsub.put("docno", resultSet.getString("docno"));
				 objsub.put("cntramt", resultSet.getString("cntramt"));
				 objsub.put("status", resultSet.getString("status"));
				 objsub.put("client", resultSet.getString("client"));
				 objsub.put("site", resultSet.getString("site"));
				 objsub.put("sdate", resultSet.getString("sdate"));
				 objsub.put("edate", resultSet.getString("edate"));
				 objsub.put("dueno", resultSet.getString("dueno"));
				 objsub.put("dueamt", resultSet.getString("dueamt"));
				 objsub.put("sal_name", resultSet.getString("sal_name"));    
				 objsub.put("sal_id", resultSet.getString("sal_id"));
				 objsub.put("refno", resultSet.getString("refno"));
                 prdarray.add(objsub);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return prdarray;

	}
	
	
	/*public JSONArray pendingContractGridLoadExcel(HttpSession session,String dtype,String date,String branchid,String clientid,int id,String cstatus) throws SQLException
	{

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


		String brcid=branchid.toString();


		String sql11="";
		
     
		if(!(clientid.trim().equalsIgnoreCase("0") || clientid.trim().equalsIgnoreCase("") || clientid.trim().equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.cldocno="+clientid+"";
		}
		 if(!(date.equalsIgnoreCase("0") || date.equalsIgnoreCase("") || date.equalsIgnoreCase("undefined"))){
			java.sql.Date todate=common.changeStringtoSqlDate(date);
			sql11=sql11+" and m.date<='"+todate+"'"; 
		}

	  if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+")";
		}
		 if(!(dtype.equalsIgnoreCase("0") || dtype.equalsIgnoreCase("") || dtype.equalsIgnoreCase("undefined"))){
			sql11=sql11+" and m.dtype='"+dtype+"'";
		}
		



		Connection conn =null;
		Statement stmt =null;
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			

			String sql="select  dtype 'CONTR. TYPE', docno 'CONTRACT NO', cntramt 'CONTRACT AMOUNT', status 'STATUS',client 'CLIENT NAME',site 'SITE',coalesce(DATE_FORMAT(sdate,'%d-%m-%Y'),'' ) as 'START DATE',coalesce(DATE_FORMAT(edate,'%d-%m-%Y'),'' )as 'END DATE',convert(concat(coalesce(pend,0),'/',coun),char(50)) as 'PENDING DUES',coalesce(round(dueamt,2),0) as 'PENDING DUE AMOUNT',sal_name 'SALESMAN',refno 'PO NO'  from "
					+ "(select m.refno,s.sal_name,m.dtype,m.doc_no docno,ac.refname as client,if(m.jbaction=1,'HOLD',if(m.jbaction=2,'CLOSED',if(m.jbaction=3,'COMPLETED',if(m.jbaction=4,'STARTED','ENTERED')))) as status,"
					+ "validfrom sdate,validupto as edate,pd.pend,coalesce(p.cnt,0) as coun,m.contractval as cntramt,sum(pd.amount) as dueamt,sd.site from cm_srvcontrm m "
					+ "  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
					+ "left join (select  c.doc_no,c.cnt cnt from ( select count(*) as cnt,tr_no as doc_no from cm_srvcontrpd  group by tr_no "
					+ "union all select count(*) as cnt,doc_no from cm_servplan where serinv=1  group by doc_no) c group by doc_no) as p on p.doc_no=m.tr_no "
					+ "left join (select count(tr_no) as pend,tr_no,sum(amount) amount from cm_srvcontrpd  where invamt<=0 and invtrno<=0 group by tr_no union all "
					+ "select count(doc_no) as pend,doc_no as tr_no,sum(servamt) as amount from cm_servplan  where  invtrno<=0 and serinv=1 group by doc_no) as pd on pd.tr_no=m.tr_no "
					+ " left join ( select GROUP_CONCAT(site) site,tr_no from cm_srvcsited group by tr_no order by sr_no) sd on sd.tr_no=m.tr_no "
					+ " left join my_salm s on s.sal_id=m.sal_id "
					+ " where jbaction!=3 and m.status=3 "+sql11+" "
					+ "group by m.tr_no order by validupto) as a";
			
		//	System.out.println("==pendingContractGridLoadExcel==="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=common.convertToEXCEL(resultSet);
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

	}*/
	

}
