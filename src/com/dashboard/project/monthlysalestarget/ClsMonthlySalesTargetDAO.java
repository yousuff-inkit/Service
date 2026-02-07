package com.dashboard.project.monthlysalestarget;
 
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
import java.util.Enumeration;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class ClsMonthlySalesTargetDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	Statement stmt =null;
	String sql="";
	int val=0;    

	public  JSONArray loadGridData(String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
       if(!check.equalsIgnoreCase("1")){
	     return RESULTDATA;
        }
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql1="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();         
					                                         
			String sqldata="select m.gpper percent,brhid,rowno, year, month, targetval,b.branchname branch from cm_monthsalem m left join my_brch b on b.doc_no=m.brhid where m.type=1";
					                 
			////System.out.println("Grid----->>>"+sqldata);     
			resultSet= stmt.executeQuery (sqldata);   
			RESULTDATA=cmn.convertToJSON(resultSet);      
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
	
	 
	public  JSONArray loadGridDatasm(String check) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
       if(!check.equalsIgnoreCase("1")){
	     return RESULTDATA;
        }
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sql1="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();         
					                                         
			String sqldata="select  m.gpper percent,rowno, year, month, targetval,s.sal_name salesman,m.salid from cm_monthsalem m left join my_salm s on s.doc_no=m.salid where m.type=2";
			////System.out.println("Grid----->>>"+sqldata);        
			resultSet= stmt.executeQuery (sqldata);   
			RESULTDATA=cmn.convertToJSON(resultSet);      
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