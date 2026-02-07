package com.controlcentre.masters.classificationsetup;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import net.sf.json.JSONArray;


public class ClsclassificationSetupDAO {
	ClsCommon clsCommon = new ClsCommon();
	ClsConnection clsConnection = new ClsConnection();
	
	public int insert(Date date, String formdet, String  formCode, String name, String mode) throws SQLException {
		Connection	conn = clsConnection.getMyConnection();
		conn.setAutoCommit(false);
		PreparedStatement stmt = null;
		int returns = 0;
		Statement statement2 = conn.createStatement();
		String sql1 = "select coalesce(max(doc_no)+1,1) doc_no from my_prodclassificationsetup";
		int docno = 0;
		ResultSet resultSet2 = statement2.executeQuery(sql1);
		if(resultSet2.next()) {
			docno=resultSet2.getInt("doc_no");
		}
		System.out.println("reched line 43");
		String sql2 = "insert into my_prodclassificationsetup(doc_no,name,date,status) values("+docno+",'"+name+"','"+date+"',3)";
		
		stmt = conn.prepareStatement(sql2);
		
		stmt.execute();
		System.out.println("executed insert statement");
		conn.commit();
		returns = docno;
		conn.close();
		return returns;
	}

	public int delete(int docno, HttpSession session, String name, String formdetailcode) throws SQLException {
		Connection conn;
		conn = clsConnection.getMyConnection();
		conn.setAutoCommit(false);
		PreparedStatement stmt = null;
		int returns = 0;
		try {
			String sql = "update my_prodclassificationsetup set status=7 where doc_no="+docno+";";
			stmt = conn.prepareStatement(sql);
			stmt.execute();
			conn.commit();
			returns=1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		} 
		return returns;
	}

	public int update(Date date, String formdetail, String formdetailcode, String name, String mode, int docno) throws SQLException {
		System.out.println(date);
		Connection conn;
		conn=clsConnection.getMyConnection();
		conn.setAutoCommit(false);
		PreparedStatement stmt = null;
		int returns = 0;
		try {
			Statement statement = conn.createStatement();
			String sql = "select name from my_prodclassicationsetup where status<>7 and name='"+name+"' and doc_no="+docno+"";
			/*
			 * ResultSet resultSet = statement.executeQuery(sql); if(resultSet.next()) {
			 * statement.close(); conn.close(); return -1; }
			 */
			System.out.println("Firing Update query");
			String sql1 = "update my_prodclassificationsetup set name='"+name+"', date='"+date+"' where doc_no="+docno+"";
			stmt = conn.prepareStatement(sql1);
			int update=statement.executeUpdate(sql1);
			
			//Validation for updation 
			if(update<=0) {
				conn.commit();
				returns = -2;
			} else {
				conn.commit();
				returns = docno;
			}
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		return returns;
	}
	
	public JSONArray specMasterLoad(HttpSession session) throws SQLException {
		JSONArray resultData= new JSONArray();
		Connection conn = null;
		try {
			conn = clsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select name,doc_no,date from my_prodclassificationsetup where status<>7;";
			ResultSet resultSet = stmt.executeQuery(sql);
			resultData = clsCommon.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return resultData;
	}
	
	public JSONArray specMasterSearchLoad(HttpSession session) throws SQLException {
		JSONArray resultData= new JSONArray();
		Connection conn = null;
		try {
			conn = clsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "select name,doc_no,date from my_prodclassificationsetup where status<>7;";
			ResultSet resultSet = stmt.executeQuery(sql);
			resultData = clsCommon.convertToJSON(resultSet);
			
			stmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return resultData;
	}
}
