package com.controlcentre.masters.dumpmaster.skipmaster;



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

	public class ClsSkipmasterDAO {
		Connection conn;
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		public int insert(String txtcode,String txtname , String cmbtype,String mode, HttpSession session,String formdetailcode) throws SQLException {

			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				int docno;
				
				CallableStatement stmtSkipmaster = conn.prepareCall("{CALL skipMasterDML(?,?,?,?,?,?,?,?)}");
				
				stmtSkipmaster.registerOutParameter(6, java.sql.Types.INTEGER);
				stmtSkipmaster.setString(1,txtcode);
				stmtSkipmaster.setString(2,txtname);
				stmtSkipmaster.setString(3,cmbtype);
				stmtSkipmaster.setString(4,session.getAttribute("USERID").toString());
				stmtSkipmaster.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSkipmaster.setString(7,mode);
				stmtSkipmaster.setString(8, formdetailcode);
			    stmtSkipmaster.executeQuery();    
			    docno=stmtSkipmaster.getInt("docNo");
				if (docno > 0) {
					conn.commit();
					stmtSkipmaster.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtSkipmaster.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtSkipmaster.close();
					conn.close();
					return docno;
				}
				
			  stmtSkipmaster.close();
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
		
		public int edit(String txtcode,String txtname , String cmbtype,int docno,String mode, HttpSession session,String formdetailcode) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				   
				CallableStatement stmtSkipmaster = conn.prepareCall("{CALL skipMasterDML(?,?,?,?,?,?,?,?)}");
				

				stmtSkipmaster.setInt(6,docno);
				stmtSkipmaster.setString(1,txtcode);
				stmtSkipmaster.setString(2,txtname);
				stmtSkipmaster.setString(3,cmbtype);
				stmtSkipmaster.setString(4,session.getAttribute("USERID").toString());
				stmtSkipmaster.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSkipmaster.setString(7,mode);
				stmtSkipmaster.setString(8, formdetailcode);
			    stmtSkipmaster.executeUpdate();
			    	
			    
			    docno=stmtSkipmaster.getInt("docNo");
				if (docno > 0) {
					conn.commit();
					stmtSkipmaster.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtSkipmaster.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtSkipmaster.close();
					conn.close();
					return docno;
				}
				
			  stmtSkipmaster.close();
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
				
CallableStatement stmtSkipmaster = conn.prepareCall("{CALL skipMasterDML(?,?,?,?,?,?,?,?)}");
				

				stmtSkipmaster.setInt(6,docno);
				stmtSkipmaster.setString(1,null);
				stmtSkipmaster.setString(2,null);
				stmtSkipmaster.setString(3,null);
				stmtSkipmaster.setString(4,session.getAttribute("USERID").toString());
				stmtSkipmaster.setString(5,session.getAttribute("BRANCHID").toString());
				stmtSkipmaster.setString(7,mode);
				stmtSkipmaster.setString(8, formdetailcode);
		
				int docNo = stmtSkipmaster.executeUpdate();
				if (docNo > 0) {
					conn.commit();
					stmtSkipmaster.close();
					conn.close();
					return true;
				}
			   stmtSkipmaster.close();
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
		            	
						ResultSet resultSet = stmtVeh.executeQuery ("Select s.doc_no,s.name,s.code,m.name cmbtype from sk_skipm s left join sk_skiptype m on s.typeid=m.doc_no ");
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
		            	String sqldata="select s.doc_no,s.name,s.code,s.typeid,m.name cmbtype from sk_skipm s " + " left join sk_skiptype m on s.typeid=m.doc_no ";
		            	
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
