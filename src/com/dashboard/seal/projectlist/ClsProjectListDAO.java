package com.dashboard.seal.projectlist;


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

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class ClsProjectListDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval,String cldocno,int id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(id==0) {
			return RESULTDATA;	
		}

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqluptodate = null;
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cmn.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}

			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and m.brhid="+barchval;
			}
			
			if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
				sqltest+=" and ac.cldocno="+cldocno+"";
	        }
			if(id==2) {
				sqltest+=" and  m.validupto<'"+sqltodate+"'";
			}	
		
		String sqldata="SELECT d.totalyr, d.totalot, m.dtype, m.rate,m.date,m.validfrom sdate, m.validupto edate,m.tr_no,m.doc_no,m.cldocno,ac.per_tel pertel,ac.cldocno,ac.refname client,"
				+ "trim(ac.address) address,ac.per_mob,trim(ac.mail1) mail1,sm.sal_name,sm.doc_no as salid, cc.cperson, m.cpersonid, m.curid, m.vattype type, cr.code currency FROM cm_srvcontrm m "
				+ "LEFT JOIN my_acbook ac ON ac.cldocno=m.cldocno AND ac.dtype='crm' left join my_salm sm ON(ac.sal_id=sm.doc_no) LEFT JOIN my_crmcontact cc ON cc.row_no=m.cpersonid LEFT JOIN my_curr cr ON cr.doc_no=m.curid "
				+ "left join(select SUM(if(billtype=1,amountlc,0)) totalyr, SUM(if(billtype=2,amountlc,0)) totalot,rdocno from sa_srvcontrd GROUP BY rdocno) d  ON d.rdocno=m.tr_no "
				+ "WHERE m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+"";   
		  
		//System.out.println("================================"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
	
	public JSONArray clentdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmtVeh = conn.createStatement ();
			
			String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM'";
			 ResultSet resultSet = stmtVeh.executeQuery(sql);
        	
			RESULTDATA=cmn.convertToJSON(resultSet);
 			
			stmtVeh.close();
 			conn.close();
       
	} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public JSONArray getStatusCount(String fromdate,String todate,String barchval) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sdate=cmn.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date edate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		edate=cmn.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
			if(!barchval.equalsIgnoreCase("a"))
        	{
				sqltest+=" and brhid="+barchval;
        	}
			
			
			String sqldata="select count(*) val,'Under Follow-Up' stat,'UF' rds from cm_srvcontrm where dtype='AMC' and renstatus=0 "
					+ "and validupto between '"+sdate+"' and '"+edate+"' "+sqltest+" "
					+ "union select count(*) val,'Renewed' stat,'RE' rds from cm_srvcontrm where dtype='AMC' and renstatus=2 "
					+ "and validupto between '"+sdate+"' and '"+edate+"' "+sqltest+" union "
					+ "select count(*) val,'Declined' stat,'DE' rds from cm_srvcontrm where dtype='AMC' and renstatus=1 and validupto between '"+sdate+"' and '"+edate+"' "+sqltest+"  ";
	//	System.out.println("====m"+sqldata);
			resultSet = stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
	}	public  JSONArray loadDetailData(String fromdate,String todate,String rds,String barchval,String cldocno,int id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(id==0) {
			return RESULTDATA;	
		}

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqluptodate = null;
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cmn.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}

			if(barchval.equalsIgnoreCase("a")||barchval.equalsIgnoreCase("0"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and m.brhid="+barchval;
			}
			
			if(!(cldocno.equalsIgnoreCase("0")) && !(cldocno.equalsIgnoreCase(""))){
				sqltest+=" and ac.cldocno="+cldocno+"";
	        }
			if(id==2) {
				sqltest+=" and  m.validupto<'"+sqltodate+"'";
			}	
		
			String sqldata="SELECT d.description,s.service sername,s.billmethod,bm.name billmethodname,if(billtype=1,amountlc,0) totalyr, if(billtype=2,amountlc,0) totalot,d.rdocno, m.dtype, m.rate,m.date,m.validfrom sdate, m.validupto edate,m.tr_no,m.doc_no,m.cldocno,ac.per_tel pertel,ac.cldocno,ac.refname client,"
					+ "trim(ac.address) address,ac.per_mob,trim(ac.mail1) mail1,sm.sal_name,sm.doc_no as salid, cc.cperson, m.cpersonid, m.curid, m.vattype type, cr.code currency FROM cm_srvcontrm m "
					+ "LEFT JOIN my_acbook ac ON ac.cldocno=m.cldocno AND ac.dtype='crm' left join my_salm sm ON(ac.sal_id=sm.doc_no) LEFT JOIN my_crmcontact cc ON cc.row_no=m.cpersonid LEFT JOIN my_curr cr ON cr.doc_no=m.curid "
					+ "left join sa_srvcontrd d  ON d.rdocno=m.tr_no LEFT JOIN sa_service s ON s.doc_no=d.servid LEFT JOIN sa_billmethod bm ON bm.doc_no=s.billmethod WHERE m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+""; 
			//System.out.println("===============dddddd================="+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cmn.convertToJSON(resultSet);
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
}