package com.dashboard.inkit.invoiceprocessing;      

import java.sql.CallableStatement;
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

public class ClsInvoiceProcessingDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon common =new ClsCommon();


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

	public JSONArray invCountgrid(HttpSession session,String date,String branchid,String clientid,int id) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();
		if(id!=1){
			return RESULTDATA;
		}       

		java.sql.Date sqltodate=null;
		String sql11="",sqlcl="";

		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11+=" and m.cldocno in ("+clientid+") ";
		}else {}

		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
			sqltodate=common.changeStringtoSqlDate(date);
		}else {}
		
		if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
			sql11=sql11+" and m.brhid in ("+branchid+") ";  
		}else {}
		 

		Connection conn =null;
		Statement stmt =null;

		try {
			conn = ClsConnection.getMyConnection();  
			stmt = conn.createStatement ();  
			
			String dbSql="select db1,db2 from my_comp;";
			ResultSet dbRs = stmt.executeQuery(dbSql);	
			
			String db1="";
			String db2="";
			while(dbRs.next()){
				db1=dbRs.getString("db1");
				db2=dbRs.getString("db2");
			}
			
			String sql="select count(*) count,case when d.type=1 then 'Hourly' when d.type=2 then 'Daily' when d.type=3 then 'Monthly' else '' end type,d.type typeid  from cm_staffcontrm m left join cm_staffcontrd d on d.rdocno=m.doc_no "
			+"left join ( select sum(totdays) totalhrs,costcode,costtype from (select totdays,costcode,costtype from "+db1+".hr_workdetails where year=year('"+sqltodate+"') and month=month('"+sqltodate+"') and confirmed=1 and dbname='"+db1+"' union all  select totdays,costcode,costtype from "+db2+".hr_workdetails where year=year('"+sqltodate+"') and month=month('"+sqltodate+"') and confirmed=1 and dbname='"+db1+"')t group by costcode,costtype ) w on w.costcode=m.doc_no and w.costtype='STC' "
					+"where m.status=3 and w.totalhrs>0 and coalesce(d.invdate,m.fromdt)<'"+sqltodate+"' "+sql11+" group by d.type";
			//System.out.println("===Countgrid==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=common.convertToJSON(resultSet);
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
 
	public JSONArray loadContractData(String uptodate, String branchid, String clientid, int id, int type) throws SQLException {
		JSONArray RESULTDATA=new JSONArray(); 
		if(id!=1) {
			return RESULTDATA;    
		}
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql11="",sqlcl="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement();
			java.sql.Date sqltodate = null;

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11=sql11+" and m.cldocno="+clientid+"";
			}else {}

			if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))){
				sqltodate=common.changeStringtoSqlDate(uptodate);  
			}else {}
			
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and m.brhid in ("+branchid+") ";
			}else {}  
			 
			String dbSql="select db1,db2 from my_comp;";
			ResultSet dbRs = stmt.executeQuery(dbSql);	
			
			String db1="";
			String db2="";
			while(dbRs.next()){
				db1=dbRs.getString("db1");
				db2=dbRs.getString("db2");
			}

			String sqldata="select (select costtype from my_costunit where costgroup='STC') costtype,date_format(d.invdate,'%d.%m.%Y') invdate,d.rowno,ac.nontax,(select  acno from my_account where codeno='STC INCOME') incomeacno,ac.acno clacno,m.brhid,m.doc_no,m.voc_no,date_format(m.date,'%d.%m.%Y') date,ac.refname client,m.cldocno,round(d.rate,2) rate,round(d.clientbillrate,2) clientrate,round(coalesce(w.totalhrs,0),2) tothrs,round(coalesce(w.totalhrs,0)/8,2) days,"
					+"round(case when '"+type+"'='1' then coalesce(w.totalhrs,0)*coalesce(d.rate,0) when '"+type+"'='2' then (coalesce(w.totalhrs,0)/8)*coalesce(d.rate,0) when '"+type+"'='3' then ((coalesce(w.totalhrs,0)/8)/22)*coalesce(d.rate,0) else 0 end,2) invtotal, round(case when '"+type+"'='1' then coalesce(w.totalhrs,0)*coalesce(d.clientbillrate,0) when '"+type+"'='2' then (coalesce(w.totalhrs,0)/8)*coalesce(d.clientbillrate,0) when '"+type+"'='3' then ((coalesce(w.totalhrs,0)/8)/22)*coalesce(d.clientbillrate,0) else 0 end,2) clientinvtotal,cr.code curr,round(cb.rate,2) currate"
					+" from cm_staffcontrm m left join cm_staffcontrd d on d.rdocno=m.doc_no left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_curbook cb on (ac.curid=cb.curid) left join my_curr cr on(cr.doc_no=cb.curid) left join (select sum(totdays) totalhrs,costcode,costtype from (select totdays,costcode,costtype from "+db1+".hr_workdetails where year=year('"+sqltodate+"') and month=month('"+sqltodate+"') and confirmed=1 and dbname='"+db1+"' union all select totdays,costcode,costtype from "+db2+".hr_workdetails where year=year('"+sqltodate+"') and month=month('"+sqltodate+"') and confirmed=1 and dbname='"+db1+"')t group by costcode,costtype) w on w.costcode=m.doc_no and w.costtype='STC' where m.status=3 and coalesce(d.invdate,m.fromdt)<'"+sqltodate+"' and d.type='"+type+"' and w.totalhrs>0 "+sql11+"";
			//System.out.println("==loadContractData==="+sqldata);             
            resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=common.convertToJSON(resultSet);   
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
