package com.controlcentre.masters.dumpmaster.skip;



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

	public class ClsSkipDAO {
		Connection conn;
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		public int insert(String txtcode,String txtname , String txttechspec,String mode, HttpSession session,String formdetailcode) throws SQLException {

			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				int docno;
				
				CallableStatement stmtSkip = conn.prepareCall("{CALL skipDML(?,?,?,?,?,?,?,?)}");
				
				stmtSkip.registerOutParameter(6, java.sql.Types.INTEGER);
				stmtSkip.setString(1,txtcode);
				stmtSkip.setString(2,txtname);
				stmtSkip.setString(3,txttechspec);
				stmtSkip.setString(4,session.getAttribute("USERID").toString());
				stmtSkip.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSkip.setString(7,mode);
				stmtSkip.setString(8, formdetailcode);
			    stmtSkip.executeQuery();    
			    docno=stmtSkip.getInt("docNo");
				if (docno > 0) {
					conn.commit();
					stmtSkip.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtSkip.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtSkip.close();
					conn.close();
					return docno;
				}
				
			  stmtSkip.close();
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
		
		public int edit(String txtcode,String txtname , String txttechspec,int docno,String mode, HttpSession session,String formdetailcode) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				   
				CallableStatement stmtSkip = conn.prepareCall("{CALL skipDML(?,?,?,?,?,?,?,?)}");
				

				stmtSkip.setInt(6,docno);
				stmtSkip.setString(1,txtcode);
				stmtSkip.setString(2,txtname);
				stmtSkip.setString(3,txttechspec);
				stmtSkip.setString(4,session.getAttribute("USERID").toString());
				stmtSkip.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSkip.setString(7,mode);
				stmtSkip.setString(8, formdetailcode);
			    stmtSkip.executeUpdate();
			    	
			    
			    docno=stmtSkip.getInt("docNo");
				if (docno > 0) {
					conn.commit();
					stmtSkip.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtSkip.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtSkip.close();
					conn.close();
					return docno;
				}
				
			  stmtSkip.close();
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
				
CallableStatement stmtSkip = conn.prepareCall("{CALL skipDML(?,?,?,?,?,?,?,?)}");
				

				stmtSkip.setInt(6,docno);
				stmtSkip.setString(1,null);
				stmtSkip.setString(2,null);
				stmtSkip.setString(3,null);
				stmtSkip.setString(4,session.getAttribute("USERID").toString());
				stmtSkip.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSkip.setString(7,mode);
				stmtSkip.setString(8, formdetailcode);
		
				int docNo = stmtSkip.executeUpdate();
				if (docNo > 0) {
					conn.commit();
					stmtSkip.close();
					conn.close();
					return true;
				}
			   stmtSkip.close();
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
		            	
						ResultSet resultSet = stmtVeh.executeQuery ("Select * from sk_skiptype where status <> 7");
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
		            	String sqldata="select * from sk_skiptype where status=3";
		            	
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
