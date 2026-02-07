package com.dashboard.inkit.amsinvoiceprocessing;      

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

public class ClsAmsInvoiceProcessingDAO {

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
		return RESULTDATA;
	}
 
	public JSONArray loadContractData(String uptodate, String branchid, String clientid, int id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray(); 
		if(id!=1) {
			return RESULTDATA;    
		}
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement();
			java.sql.Date sqltodate = null;

			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sqltest+=" and m.cldocno="+clientid+"";
			}
			
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sqltest+=" and m.brhid in ("+branchid+") ";
			}
			
			if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))){
				sqltodate=common.changeStringtoSqlDate(uptodate);  
			}
																																											   
			String sqldata="select 'Monthly' billfreq, m.billfrequency, m.voc_no, m.date, coalesce(ac.refname,'') client, group_concat(coalesce(d.site,''))site, m.supporthrs, m.extrahrsrate, m.fromdt, m.todt, sp.supportedhrs, sp.exthrs extrahrs, if(m.carryforwards=1,'Yes','No')cf,m.amount," + 
					"m.doc_no, m.brhid, m.cldocno, ac.acno clacno, (select acno from my_account where codeno='AMC INCOME')incomeacno, (select costtype from my_costunit where costgroup='AMS')costtype, ac.nontax, sp.supportedhrs hidsupportedhrs, coalesce(sp.rowno,0)rowno "+
					"from cm_amscontrm m " + 
					"left join my_acbook ac on ac.doc_no=m.cldocno and ac.dtype='CRM' " + 
					"left join cm_amssupdet sp on sp.rdocno=m.doc_no and sp.date='"+sqltodate+"' "+ 
					"left join cm_amssited d on d.RDOCNO=m.doc_no where m.status=3 and coalesce(sp.invtrno,0)=0 and m.billfrequency=1 and '"+sqltodate+"' between m.fromdt and m.todt "+sqltest+" group by m.doc_no "+
					"union all "+
				    "select 'Quarterly' billfreq, m.billfrequency, m.voc_no, m.date, coalesce(ac.refname,'') client, group_concat(coalesce(d.site,''))site, (m.supporthrs*count(sp.rowno)) supporthrs, m.extrahrsrate, m.fromdt, m.todt, sum(sp.supportedhrs)supportedhrs, sum(sp.exthrs)extrahrs, if(m.carryforwards=1,'Yes','No')cf,(m.amount*count(sp.rowno))amount," + 
					"m.doc_no, m.brhid, m.cldocno, ac.acno clacno, (select acno from my_account where codeno='AMC INCOME')incomeacno, (select costtype from my_costunit where costgroup='AMS')costtype, ac.nontax, sum(sp.supportedhrs) hidsupportedhrs, coalesce(sp.rowno,0)rowno "+
					"from cm_amscontrm m " + 
					"left join my_acbook ac on ac.doc_no=m.cldocno and ac.dtype='CRM' " + 
					"left join cm_amssupdet sp on sp.rdocno=m.doc_no and sp.date<='"+sqltodate+"' "+ 
					"left join cm_amssited d on d.RDOCNO=m.doc_no where m.status=3 and coalesce(sp.invtrno,0)=0 and m.billfrequency=2 "+sqltest+" and '"+sqltodate+"' between m.fromdt and m.todt  "+
				    " and if(last_day(date_add(coalesce(m.invdate,m.fromdt), interval if((m.invdate is null or m.invdate=m.fromdt), 2, 3) month))<m.todt, (last_day(date_add(coalesce(m.invdate,m.fromdt), interval if((m.invdate is null or m.invdate=m.fromdt), 2, 3) month))='"+sqltodate+"'), 1=1) group by m.doc_no";
			
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
