package com.controlcentre.settings.subdivision;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.settings.servicetype.ClsServiceTypeBean;

public class ClsSubDivisionDAO {

	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	public int insert(java.sql.Date date,String txtname,String mode,String formcode,HttpSession session,HttpServletRequest request){
		
		//name,mobile,email,address,descrption,dates
		
		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_subdivisionDML(?,?,?,?,?,?,?)}");    
			
			stmt.setDate(1,date);
			stmt.setString(2,txtname.toUpperCase());	
			stmt.setString(3,session.getAttribute("BRANCHID").toString());
			stmt.setString(4,session.getAttribute("USERID").toString());
			stmt.setString(5,mode);
			stmt.setString(6,formcode);
			stmt.registerOutParameter(7,java.sql.Types.INTEGER);       

			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");

			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		return aaa;
	}
	
	
public int edit(int docno,java.sql.Date date,String txtname,String mode,String formcode,HttpSession session,HttpServletRequest request){
		

		
		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_subdivisionDML(?,?,?,?,?,?,?)}");    
			
			stmt.setDate(1,date);
			stmt.setString(2,txtname.toUpperCase());	
			stmt.setString(3,session.getAttribute("BRANCHID").toString());
			stmt.setString(4,session.getAttribute("USERID").toString());
			stmt.setString(5,mode);
			stmt.setString(6,formcode);
			stmt.setInt(7,docno);
			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");

			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		return aaa;
	}

public int delete(int docno,java.sql.Date date,String txtname,String mode,String formcode,HttpSession session,HttpServletRequest request){
	
	Connection conn =null;    
	int aaa=0;
	int resultSetd=0;
	try{
		conn = conobj.getMyConnection();
		CallableStatement stmt = conn.prepareCall("{CALL Sr_subdivisionDML(?,?,?,?,?,?,?)}");    
	
		stmt.setDate(1,date);
		stmt.setString(2,txtname.toUpperCase());	
		stmt.setString(3,session.getAttribute("BRANCHID").toString());
		stmt.setString(4,session.getAttribute("USERID").toString());
		stmt.setString(5,mode);
		stmt.setString(6,formcode);
		stmt.setInt(7,docno);          
		int val = stmt.executeUpdate();
		aaa=stmt.getInt("docNo");

		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	
	return aaa;
}

	
	public JSONArray descLoad(HttpSession session) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		Connection conn =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt =conn.createStatement();

			ResultSet resultSet = stmt.executeQuery("select  doc_no, name , date from cm_subdivision where status=3");     

			RESULTDATA=com.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
}
