package com.dashboard.nipurchase.nipurchaserequestfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsnipurchaserequestfollowupDAO {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commDAO=new ClsCommon();

	public JSONArray niPurchaseRequestSearch(String brcid, int id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		
		String str1Sql="";
		      	
		Connection conn =null;
		Statement stmt = null;
		try {
			conn = connDAO.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){
				str1Sql=("select m.doc_no, m.voc_no, m.brhid, m.date, m.requestedby, m.desc1 remark from my_srvreqm m inner join my_srvreqd d on d.rdocno=m.doc_no where m.status<>7 and d.qty>d.out_qty and m.brhid='"+brcid+"' group by m.doc_no order by m.doc_no");
				//System.out.println(str1Sql);
				ResultSet resultSet = stmt.executeQuery(str1Sql);
				RESULTDATA=commDAO.convertToJSON(resultSet);
				stmt.close();
				conn.close();
			}
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
	
	public JSONArray loadnireq(String nidoc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	   
	    Connection conn = null;
		try {
				conn = connDAO.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
				
	        	String pySql=("select d.desc1 description, d.qty-d.out_qty qty, d.qty-d.out_qty avlqty, d.rowno refrow,m.voc_no from my_srvreqd d inner join my_srvreqm m on m.doc_no=d.rdocno where d.qty>d.out_qty and d.rdocno in ("+nidoc+")");
				//System.out.println(pySql);
	        	ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return RESULTDATA;
	}
}
