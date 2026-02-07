package com.dashboard.inkit.amssupportedhrsreport;      

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

public class ClsAmsSupportedHrsDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
 
	public JSONArray contractDetailsSearch(HttpSession session, String contractno, String type, String todate, String check) throws SQLException {
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
			
			   java.sql.Date sqlToDate = null;
			   if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
				   sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
		       }
				
			   String sqltest="",sqltest2="";

			   if(!(brhid.equals("0") || brhid.equals("") || brhid.equals("undefined") || brhid.equals("ALL"))){
				   sqltest+=" and m.brhid='"+brhid+"'";
			   }
			   
			   if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined") || contractno.equals("ALL"))){
				   sqltest+=" and m.voc_no='"+contractno+"'";
			   }
			   
			   if(!(type.equals("0") || type.equals("1") || type.equals("") || type.equals("undefined") || type.equals("ALL"))){
				   sqltest+=" and coalesce(sp.invtrno,0)=0 and '"+sqlToDate+"' between m.fromdt and m.todt ";
				   sqltest2=" left join cm_amssupdet sp on sp.rdocno=m.doc_no and sp.date='"+sqlToDate+"' ";
			   }
				  
			   String sql= "select m.brhid, m.doc_no, m.voc_no, ac.RefName client, coalesce(m.partnerclient,'')partnerclient,m.refno from cm_amscontrm m left join my_acbook ac on ac.doc_no=m.cldocno and ac.dtype='CRM' "+sqltest2+" where m.status=3 "+sqltest+" order by doc_no";
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
	
	public JSONArray loadSupHrsGrid(String branch,String fromdate,String todate,String contract,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray(); 
		
		if(check.equalsIgnoreCase("0")){
			return RESULTDATA;
		}
		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement();
	
			java.sql.Date sqlFromDate = null;
			java.sql.Date sqlToDate = null;
			
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	     		sqlFromDate=ClsCommon.changeStringtoSqlDate(fromdate);
	     	}

	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqlToDate=ClsCommon.changeStringtoSqlDate(todate);
	     	}
	     	
	     	String sqltest="";
	     	
	     	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	     		sqltest+=" and m.brhid="+branch+"";
    		}
	     	
	     	if(!(contract.equalsIgnoreCase("0")) && !(contract.equalsIgnoreCase(""))){
	     		sqltest+=" and m.doc_no="+contract+"";
            }
	     	
			String sqldata="select invtrno, brhid, doc_no, voc_no, client, partnerclient, fromdt, todt, convert(concat(monthname(date), '-', year(date)),char(50))month, supporthrs+prevcf actual, supportedhrs, if(((supporthrs+prevcf)-supportedhrs) < 0, 0 ,(supporthrs+prevcf)-supportedhrs) balance, exthrs, cfhrs, supporthrs minbilling from (" + 
					"select d.invtrno,m.brhid,m.doc_no,m.voc_no, ac.RefName client, coalesce(m.partnerclient,'')partnerclient, m.fromdt, m.todt, d.date, m.supporthrs, d.supportedhrs, d.cfhrs, d.exthrs," + 
					"coalesce((select cfhrs from cm_amssupdet where rdocno=m.doc_no and  date_format(date,'%Y-%m')= date_format(d.date - INTERVAL 1 MONTH,'%Y-%m')),0) prevcf " + 
					"from cm_amscontrm m left join my_acbook ac on ac.doc_no=m.cldocno and ac.dtype='CRM' inner join cm_amssupdet d on d.rdocno=m.doc_no " + 
					"where date(d.date) between '"+sqlFromDate+"' and '"+sqlToDate+"' "+sqltest+")t order by voc_no, date;";
			
			//System.out.println("supHrsReport--->"+sqldata);             
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

}
