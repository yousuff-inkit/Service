package com.controlcentre.settings.subservicetype;

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

public class ClsSubServicetypeDAO {

	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	public int insert(java.sql.Date date,String txtname,int sertype,String desc1,String mode,String formcode,HttpSession session,HttpServletRequest request){
		
		//name,mobile,email,address,descrption,dates
		
		Connection conn =null;
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_subSertypeDML(?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(9,java.sql.Types.INTEGER);
			stmt.setDate(1,date);
			stmt.setString(2,txtname.toUpperCase());	
			stmt.setInt(3,sertype);
			stmt.setString(4,desc1);
			stmt.setString(5,session.getAttribute("BRANCHID").toString());
			stmt.setString(6,session.getAttribute("USERID").toString());
			stmt.setString(7,mode);
			stmt.setString(8,formcode);

			int val = stmt.executeUpdate();
			aaa=stmt.getInt("docNo");

			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		return aaa;
	}
	
	
public int edit(int docno,java.sql.Date date,String txtname,int sertype,String desc1,String mode,String formcode,HttpSession session,HttpServletRequest request){
		Connection conn =null;   
		int aaa=0;
		int resultSetd=0;
		try{
			conn = conobj.getMyConnection();
			CallableStatement stmt = conn.prepareCall("{CALL Sr_subSertypeDML(?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(9,docno);    
			stmt.setDate(1,date);
			stmt.setString(2,txtname.toUpperCase());	
			stmt.setInt(3,sertype);
			stmt.setString(4,desc1);
			stmt.setString(5,session.getAttribute("BRANCHID").toString());
			stmt.setString(6,session.getAttribute("USERID").toString());
			stmt.setString(7,mode);
			stmt.setString(8,formcode);
			aaa = stmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return aaa;
	}

public int delete(int docno,java.sql.Date date,String txtname,int sertype,String desc1,String mode,String formcode,HttpSession session,HttpServletRequest request){
	

	
	Connection conn =null;
	int aaa=0;
	int resultSetd=0;
	try{
		conn = conobj.getMyConnection();
		CallableStatement stmt = conn.prepareCall("{CALL Sr_subSertypeDML(?,?,?,?,?,?,?,?,?)}");
		stmt.setInt(9,docno);
		stmt.setDate(1,null);
		stmt.setString(2,txtname.toUpperCase());	
		stmt.setInt(3,sertype);
		stmt.setString(4,desc1);
		stmt.setString(5,session.getAttribute("BRANCHID").toString());
		stmt.setString(6,session.getAttribute("USERID").toString());
		stmt.setString(7,mode);
		stmt.setString(8,formcode);
		aaa = stmt.executeUpdate();

		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	
	return aaa;   
}

	
	public JSONArray descLoad(HttpSession session) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		List<ClsServiceTypeBean> listBean = new ArrayList<ClsServiceTypeBean>();
		Connection conn =null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt =conn.createStatement();
			ResultSet resultSet = stmt.executeQuery("select sv.doc_no, sv.srvid, sv.name, sv.date, sv.description, sv.brhid, gs.groupname servicetype from my_subsrvtype sv left join my_groupvals gs on gs.doc_no=sv.srvid  where sv.status=3 ");
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
	
	public JSONArray serviceType(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname stype,codeno,doc_no docno from my_groupvals where grptype='service' and status=3";



					//System.out.println("===sql7654===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

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
