package com.dashboard.gwinternal.implementation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsImplementationDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cmn=new ClsCommon();
	public JSONArray projectData(HttpSession session,String id,String comp) throws SQLException{      
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		 if(!id.equalsIgnoreCase("1")){        
			 return data;
		 } 
		try{
			conn=ClsConnection.getMyConnection();  
			Statement stmt=conn.createStatement();
			String sqltest="";
			
		    if(!comp.equalsIgnoreCase("") && comp!=null){
				   sqltest+=" and c.compid='"+comp+"'"; 
			}
			 
		    String strsql="select a.*, coalesce(checked,'') checked, coalesce(remarks,'') remarks, coalesce(c.compid,'') company from(SELECT seqid, details FROM zt_setupmaster z union all SELECT rdocno seqid, descriptions details FROM zt_setupdetail s)a left join zt_compdetails c on c.detail=a.details "+sqltest+"  order by seqid";
		    System.out.println("strsql--->>>"+strsql);                                                                                          
			ResultSet rs=stmt.executeQuery(strsql);       
		    data=cmn.convertToJSON(rs);    
		}   
		catch(Exception e){  
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	
    public JSONArray loadGrid(String id) throws SQLException{
    	JSONArray jsarray = new JSONArray();
    	if(!id.equals("1")){
    		return jsarray;
    	}
    	Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
				
		    String sqldata="SELECT 'SAVE' save,mno ,menu_name menuname,pmenu pmenu,func path,printpath printpath1,printpath2,gate FROM MY_MENU";
	//	System.out.println(sqldata);
			resultSet= stmt.executeQuery (sqldata);
			jsarray=cmn.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
    	return jsarray;
    }
}
