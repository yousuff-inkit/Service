package com.dashboard.skips.skipmanagement;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsSkipManagementDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray skipData(HttpSession session,String id) throws SQLException{      
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		 if(!id.equalsIgnoreCase("1")){        
			 return data;
		 } 
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			String sqltest="",strjoin="",sqlselect="";   
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;  
			    
			String strsql="select m.doc_no,m.code,m.name,m.typeid,t.name type from sk_skipm m left join sk_skiptype t on t.doc_no=m.typeid where m.status=3";
			//System.out.println("strsql--->>>"+strsql);                                                                                        
				ResultSet rs=stmt.executeQuery(strsql);    
				data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){  
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
}
