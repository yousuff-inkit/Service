package com.dashboard.skips.tippingfeetariff;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsTippingfeetariffDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
	
	
	
	public JSONArray tippingTariffGridLoading(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
       
        Connection conn = null;
       
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				
				
			    	
			String sql = " select st.doc_no,st.skipsizeid skiptypeid,st.wastetypeid,st.disposalfee,st.weight,sk.name skipsize,dt.name wastetype  from sk_tippingtariff st "
						+ "left join sk_skiptype sk on sk.doc_no=st.skipsizeid "
						+ "left join sk_dumptype dt on dt.doc_no=st.wastetypeid where 1=1 order by st.doc_no";
			//	System.out.println("Grid:"+sql);
				ResultSet resultSet = stmtCRM.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				
				
				stmtCRM.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }

	
	public JSONArray skipSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select name skipsize,doc_no skiptypeid from sk_skiptype where status=3";


		//	System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public JSONArray wastetypeSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select name wastetype,doc_no wastetypeid from sk_dumptype where status=3";


		//	System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=ClsCommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}


}
