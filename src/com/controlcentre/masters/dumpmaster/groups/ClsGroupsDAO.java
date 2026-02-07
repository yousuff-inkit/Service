package com.controlcentre.masters.dumpmaster.groups;



	import java.sql.CallableStatement;
	import java.sql.Connection;
	import java.sql.Date;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;

	import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;

	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	public class ClsGroupsDAO {
		Connection conn;
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		public int insert(String txtname , HttpSession session,String mode,String formdetailcode) throws SQLException {

			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				int docno;
				
				CallableStatement stmtGroup = conn.prepareCall("{CALL groupDML(?,?,?,?,?,?)}");
				
				stmtGroup.registerOutParameter(4, java.sql.Types.INTEGER);
				stmtGroup.setString(1,txtname);
				stmtGroup.setString(2,session.getAttribute("USERID").toString());
				stmtGroup.setString(3,session.getAttribute("BRANCHID").toString());
				stmtGroup.setString(5,mode);
				stmtGroup.setString(6, formdetailcode);
			    stmtGroup.executeQuery();    
			    docno=stmtGroup.getInt("vdocno");
				if (docno > 0) {
					conn.commit();
					stmtGroup.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtGroup.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtGroup.close();
					conn.close();
					return docno;
				}
				
			  stmtGroup.close();
			  conn.close();
			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
			    return 0;
			}finally{
				conn.close();
			}
			return 0;
		}
		
		public int edit(String txtname ,int docno, HttpSession session,String mode,String formdetailcode) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				   
				CallableStatement stmtGroup = conn.prepareCall("{CALL groupDML(?,?,?,?,?,?)}");
				

				stmtGroup.setInt(4,docno);
				stmtGroup.setString(1,txtname);
				stmtGroup.setString(2,session.getAttribute("USERID").toString());
				stmtGroup.setString(3,session.getAttribute("BRANCHID").toString());
				stmtGroup.setString(5,mode);
				stmtGroup.setString(6, formdetailcode);
			    stmtGroup.executeUpdate();
			    	
			    
			    docno=stmtGroup.getInt("vdocno");
				if (docno > 0) {
					conn.commit();
					stmtGroup.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtGroup.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtGroup.close();
					conn.close();
					return docno;
				}
				
			  stmtGroup.close();
			  conn.close();
			}catch(Exception e){
			    e.printStackTrace();
			    conn.close();
			    return 0;
			}finally{
				conn.close();
			}
			return 0;
		}

		public boolean delete(int docno, HttpSession session,String mode,String formdetailcode) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
CallableStatement stmtGroup = conn.prepareCall("{CALL groupDML(?,?,?,?,?,?)}");
				

				stmtGroup.setInt(4,docno);
				stmtGroup.setString(1,null);
				stmtGroup.setString(2,session.getAttribute("USERID").toString());
				stmtGroup.setString(3,session.getAttribute("BRANCHID").toString());
				stmtGroup.setString(5,mode);
				stmtGroup.setString(6, formdetailcode);
		
				int docNo = stmtGroup.executeUpdate();
				if (docNo > 0) {
					conn.commit();
					stmtGroup.close();
					conn.close();
					return true;
				}
			   stmtGroup.close();
			   conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
				return false;
			}finally{
				conn.close();
			}
			return false;
		}

		 public   JSONArray list() throws SQLException {
		        
			    JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null;

		        try {
						conn = ClsConnection.getMyConnection();
						Statement stmtVeh = conn.createStatement();
		            	
						ResultSet resultSet = stmtVeh.executeQuery ("Select * from sk_clgroup where status <> 7");
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmtVeh.close();
						conn.close();
				}catch(Exception e){
					e.printStackTrace();
					conn.close();
				}finally{
					conn.close();
				}
		        return RESULTDATA;
		    }
		 
		 
		 public   JSONArray searchDetails() throws SQLException {

		        JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null;
				try {
						conn=ClsConnection.getMyConnection();
						Statement stmtVeh1 = conn.createStatement ();
		            	String sqldata="select * from sk_clgroup where status=3";
		            	
						ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmtVeh1.close();
						conn.close();
						 return RESULTDATA;

				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }
	

	
}
