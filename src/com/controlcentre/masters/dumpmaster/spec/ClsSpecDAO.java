package com.controlcentre.masters.dumpmaster.spec;



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

	public class ClsSpecDAO {
		Connection conn;
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		public int insert(String txtcode,String txtname , String txtdesc, HttpSession session,String mode,String formdetailcode) throws SQLException {

			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				int docno;
				
				CallableStatement stmtSpec = conn.prepareCall("{CALL specDML(?,?,?,?,?,?,?,?)}");
				
				stmtSpec.registerOutParameter(6, java.sql.Types.INTEGER);
				stmtSpec.setString(1,txtcode);
				stmtSpec.setString(2,txtname);
				stmtSpec.setString(3,txtdesc);
				stmtSpec.setString(4,session.getAttribute("USERID").toString());
				stmtSpec.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSpec.setString(7,mode);
				stmtSpec.setString(8, formdetailcode);
			    stmtSpec.executeQuery();    
			    docno=stmtSpec.getInt("docNo");
				if (docno > 0) {
					conn.commit();
					stmtSpec.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtSpec.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtSpec.close();
					conn.close();
					return docno;
				}
				
			  stmtSpec.close();
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
		
		public int edit(String txtcode,String txtname , String txtdesc,int docno, HttpSession session,String mode,String formdetailcode) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				   
				CallableStatement stmtSpec = conn.prepareCall("{CALL specDML(?,?,?,?,?,?,?,?)}");
				

				stmtSpec.setInt(6,docno);
				stmtSpec.setString(1,txtcode);
				stmtSpec.setString(2,txtname);
				stmtSpec.setString(3,txtdesc);
				stmtSpec.setString(4,session.getAttribute("USERID").toString());
				stmtSpec.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSpec.setString(7,mode);
				stmtSpec.setString(8, formdetailcode);
			    stmtSpec.executeUpdate();
			    	
			    
			    docno=stmtSpec.getInt("docNo");
				if (docno > 0) {
					conn.commit();
					stmtSpec.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtSpec.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtSpec.close();
					conn.close();
					return docno;
				}
				
			  stmtSpec.close();
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
				
CallableStatement stmtSpec = conn.prepareCall("{CALL specDML(?,?,?,?,?,?,?,?)}");
				

				stmtSpec.setInt(6,docno);
				stmtSpec.setString(1,null);
				stmtSpec.setString(2,null);
				stmtSpec.setString(3,null);
				stmtSpec.setString(4,session.getAttribute("USERID").toString());
				stmtSpec.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSpec.setString(7,mode);
				stmtSpec.setString(8, formdetailcode);
		
				int docNo = stmtSpec.executeUpdate();
				if (docNo > 0) {
					conn.commit();
					stmtSpec.close();
					conn.close();
					return true;
				}
			   stmtSpec.close();
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
		            	
						ResultSet resultSet = stmtVeh.executeQuery ("Select * from sk_spec where status <> 7");
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
		            	String sqldata="select * from sk_spec where status=3";
		            	
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
