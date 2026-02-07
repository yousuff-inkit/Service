package com.dashboard.seal.contractrenewal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClscontractrenewalDAO {
	ClsConnection conobj = new ClsConnection();
	ClsCommon com = new ClsCommon(); 
	Connection conn;
    public JSONArray detailGridLoad(int id, int trno, String todate) throws SQLException {
    	JSONArray result = new JSONArray();
    	if(id==0) {
    		return result;
    	}
    	try {  
    		conn = conobj.getMyConnection();
    		Statement stmt = conn.createStatement();
    		java.sql.Date sqltodate = null;  
    		if(!todate.equalsIgnoreCase("") && todate!=null) {
    			sqltodate = com.changeStringtoSqlDate(todate);  
    		}
    		String sql = "SELECT a.*,ROUND((a.amounttr*a.taxper)/100,2) taxamt,ROUND(((a.amounttr*a.taxper)/100)+a.amounttr,2) nettotal  FROM(SELECT d.curid, cr.code curr, ROUND(d.amounttr,2) amounttr, ROUND(d.amountlc,2) amountlc, d.rate, s.doc_no servid,"
    				+ " s.service sername, s.billmethod, d.acno, d.description, d.doc_no, IF(m.vattype='LOCAL',IF((SELECT method FROM gl_config WHERE field_nme='DISBURSEMENTTAXZERO')='1' AND d.acno in(11160,11400,11403),0,5),0) taxper FROM cm_srvcontrm m "
    				+ "INNER JOIN sa_srvcontrd d ON d.rdocno=m.tr_no LEFT JOIN sa_service s ON s.doc_no=d.servid LEFT JOIN my_curr cr ON cr.doc_no=d.curid"
    				+ " WHERE m.validupto<='"+sqltodate+"' AND d.rdocno='"+trno+"'"
    				+ " AND d.billtype not in(2) UNION ALL SELECT d.curid, cr.code curr, ROUND(d.amounttr,2) amounttr, ROUND(d.amountlc,2) amountlc, d.rate, "
    				+ "s.doc_no servid, s.service sername, s.billmethod, d.acno, d.description, d.doc_no, IF(m.vattype='LOCAL',IF((SELECT method FROM gl_config WHERE field_nme='DISBURSEMENTTAXZERO')='1' AND d.acno in(11160,11400,11403),0,5),0) taxper FROM cm_srvcontrm m "
    				+ "INNER JOIN sa_srvcontrd d ON d.rdocno=m.tr_no LEFT JOIN sa_service s ON s.doc_no=d.servid LEFT JOIN my_curr cr ON cr.doc_no=d.curid "
    				+ "WHERE m.validupto<='"+sqltodate+"' AND d.rdocno='"+trno+"' AND d.billtype=2)a";
    	//System.out.println("Contractdetail==="+sql);        
    		ResultSet rs = stmt.executeQuery(sql);
    		result = com.convertToJSON(rs);   
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		conn.close();
    	}
    	return result;
    }
    public JSONArray invoiceGridLoad(int id, String brhid, String todate) throws SQLException {
    	JSONArray result = new JSONArray();
    	if(id==0) {
    		return result;
    	}
    	try {  
    		conn = conobj.getMyConnection();
    		Statement stmt = conn.createStatement();
    		String sqltest = "";
    		java.sql.Date sqltodate = null;  
    		if(!todate.equalsIgnoreCase("") && todate!=null) {
    			sqltodate = com.changeStringtoSqlDate(todate);  
    		}
    		if(!brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("0")) {
    			sqltest += " AND m.brhid='"+brhid+"'"; 
    		}
    		String sql = "SELECT m.rate,ROUND(SUM(amountlc),2) total,m.tr_no,m.doc_no,DATE_FORMAT(m.date,'%d.%m.%Y') date,"
    				+ "c.code curr,m.curid,m.vattype,ac.refname,m.cldocno,DATE_FORMAT(m.validfrom,'%d.%m.%Y') validfrom,"
    				+ "DATE_FORMAT(m.validupto,'%d.%m.%Y') validupto FROM cm_srvcontrm m LEFT JOIN my_acbook ac ON ac.cldocno=m.cldocno"
    				+ " AND ac.dtype='crm' LEFT JOIN my_curr c ON c.doc_no=m.curid LEFT JOIN sa_srvcontrd d ON d.rdocno = m.tr_no "
    				+ "WHERE m.status=3 AND  validupto<='"+sqltodate+"'"+sqltest+" GROUP BY m.tr_no";
    	//System.out.println("ContractGrid==="+sql);           
    		ResultSet rs = stmt.executeQuery(sql);
    		result = com.convertToJSON(rs);   
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		conn.close();
    	}
    	return result;
    }
}  
