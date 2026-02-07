package com.controlcentre.settings.clientdocuments;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;


import net.sf.json.JSONArray;

public class ClsClientdocumentsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsClientdocumentsBean clientdocBean=new ClsClientdocumentsBean();

	public int insert(ClsClientdocumentsBean bean,HttpSession session,String txtdocument) throws SQLException{
		int aaa;
		Connection conn=null; 
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			
			 String sqls="select * from rl_setdoc where desc1='"+txtdocument+"' and status<>7";
			   ResultSet resultSet1 = stmt.executeQuery(sqls);
			   
			   while (resultSet1.next()) {
			        return -1;
			    }
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			
			CallableStatement stmtclientdoc = conn.prepareCall("{CALL ClientDocumentsDML(?,?,?,?,?,?,?)}");
			stmtclientdoc.registerOutParameter(6,java.sql.Types.INTEGER);
			stmtclientdoc.setString(1,bean.getTxtdocument().toUpperCase());	
			stmtclientdoc.setString(2,bean.getRemarks().toUpperCase());
			stmtclientdoc.setDate(3,(Date) bean.getDate());
			stmtclientdoc.setString(4,userid);
			stmtclientdoc.setString(5,branch);
			stmtclientdoc.setString(7,bean.getMode());
			stmtclientdoc.executeUpdate();
			aaa=stmtclientdoc.getInt("docNo");
			if(aaa>0) {
			conn.commit();
			clientdocBean.setDocno(aaa);
			stmt.close();
			stmtclientdoc.close();
			conn.close();
			return aaa;
			}
			conn.commit();
			stmtclientdoc.close();
			stmt.close();
			conn.close();
		}catch(Exception e){	
			e.printStackTrace();	
			conn.close();
			}

		finally{
			conn.close();
		}
		return 0;
	}
	
	public int edit(ClsClientdocumentsBean bean,HttpSession session,int docno,String txtdocument) throws SQLException{
		Connection conn=null;
		try{
			int aaa;
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
		
			Statement stmt = conn.createStatement();
			
		    String sql="select * from rl_setdoc where desc1='"+txtdocument+"' and status<>7 and doc_no!="+docno;
		     ResultSet resultSet1 = stmt.executeQuery(sql);
		   
		     while (resultSet1.next()) {
		        return -1;
		     }
			CallableStatement stmtclientdoc = conn.prepareCall("{CALL ClientDocumentsDML(?,?,?,?,?,?,?)}");
			stmtclientdoc.setString(1,bean.getTxtdocument());	
			stmtclientdoc.setString(2,bean.getRemarks());
			stmtclientdoc.setDate(3,(Date) bean.getDate());
			stmtclientdoc.setString(4,userid);
			stmtclientdoc.setString(5,branch);
			stmtclientdoc.setInt(6,bean.getDocno());
			stmtclientdoc.setString(7,bean.getMode());
			stmtclientdoc.executeUpdate();
			aaa=stmtclientdoc.getInt("docNo");
			clientdocBean.setDocno(aaa);
			
			if (aaa > 0) {
				conn.commit();
				stmtclientdoc.close();
				stmt.close();
				conn.close();
				return aaa;
			}
			stmtclientdoc.close();
			stmt.close();
			conn.close();
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			}
		finally{
			conn.close();
		}
		
		return 0;
	}
	
	public int delete(ClsClientdocumentsBean bean,HttpSession session,int docno) throws SQLException {
		Connection conn=null;
		try{
			int aaa;
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
            Statement stmt = conn.createStatement();
			
		    String sql="select count(*) countss from rl_cldoc where docIdnum='"+docno+"' ";
		     ResultSet resultSet1 = stmt.executeQuery(sql);
		     int countss=0;
		     while (resultSet1.next()) {
		    	 countss=resultSet1.getInt("countss");
		     }
		     if(countss>0) {
		    	 return -1; 
		     }
			
			String branch=session.getAttribute("BRANCHID").toString().trim();
			String userid=session.getAttribute("USERID").toString().trim();
			 
			CallableStatement stmtclientdoc = conn.prepareCall("{CALL ClientDocumentsDML(?,?,?,?,?,?,?)}");
			stmtclientdoc.setString(1,bean.getTxtdocument());	
			stmtclientdoc.setString(2,bean.getRemarks());
			stmtclientdoc.setDate(3,(Date) bean.getDate());
			stmtclientdoc.setString(4,userid);
			stmtclientdoc.setString(5,branch);
			stmtclientdoc.setInt(6,bean.getDocno());
			stmtclientdoc.setString(7,bean.getMode());
			stmtclientdoc.executeUpdate();
			aaa=stmtclientdoc.getInt("docNo");
			clientdocBean.setDocno(aaa);
			
			if (aaa > 0) {
				conn.commit();
				stmtclientdoc.close();
				conn.close();
				return aaa;
			}	
			   stmtclientdoc.close();
	           conn.close();
		 }catch(Exception e){
			 e.printStackTrace();	
			 conn.close();
			}finally{
				conn.close();
			}
		return 0;
	 }

	
	public  JSONArray searchDetails() throws SQLException {
		Connection conn=null;
		JSONArray RESULTDATA = new JSONArray();
	        List<ClsClientdocumentsBean> listBean = new ArrayList<ClsClientdocumentsBean>();
			try {
				 
				conn = ClsConnection.getMyConnection();
				Statement stmtclientdoc =conn.createStatement();            	
					ResultSet resultSet = stmtclientdoc.executeQuery ("select desc1 description,remarks,date,doc_no from rl_setdoc where status<>7");
					//System.out.println("select desc1 description,remarks,date,doc_no from rl_setdoc where status<>7");
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtclientdoc.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}finally{
				conn.close();
			}
	        return RESULTDATA;
	    }
}
