package com.dashboard.gwinternal.companylist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCompanyListDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
  public JSONArray changesDoneGridLoading( String check) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	
	if(!(check.equalsIgnoreCase("1"))){
		return RESULTDATA;
	}
	
	Connection conn = null;  
	
	  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtCHNG = conn.createStatement();
	    
		     
	      	 String   sql = "select date,doc_no, comp_id, rapath, comp_code,indcode, company from gw_complist ";
			    
		    	
		    ResultSet resultSet = stmtCHNG.executeQuery(sql);
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtCHNG.close();
		    conn.close();
	  } catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  } finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}

  public JSONArray indSearch( HttpSession session) throws SQLException {
	JSONArray RESULTDATA=new JSONArray();
	
	
	
	Connection conn = null;  
	
	  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtCHNG = conn.createStatement();
	    
		     
	      	 String   sql = "select * from gw_industry ";
			    
		    	
		    ResultSet resultSet = stmtCHNG.executeQuery(sql);
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmtCHNG.close();
		    conn.close();
	  } catch(Exception e){
		  e.printStackTrace();
		  conn.close();
	  } finally{
		  conn.close();
	  }
	  return RESULTDATA;
	}

  
  
}
