package com.dashboard.realestate.customercomplaint;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsCustomerComplaintDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	public JSONArray getComplaintData(String id) throws SQLException{                    
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql="select rowno docno, name, mob, roomno, complaint, description from rl_guestregd where status<>7";   
			//System.out.println("---->>>"+strsql);                                                             
			ResultSet rs=stmt.executeQuery(strsql);
			data=ClsCommon.convertToJSON(rs);  
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
