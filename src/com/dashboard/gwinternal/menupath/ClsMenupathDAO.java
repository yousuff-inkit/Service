package com.dashboard.gwinternal.menupath;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsMenupathDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cmn=new ClsCommon();
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
