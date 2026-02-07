package com.operations.clientrelations.clientsubcategory;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientSubCategoryDAO {

	ClsConnection connDAO = new ClsConnection();  
	ClsCommon commonDAO= new ClsCommon();
	ClsClientSubCategoryBean clientCategoryBean = new ClsClientSubCategoryBean();
	Connection conn = null;
	
	public int insert(String formdetailcode, String catid, String cmbsubcategory, HttpSession session, String mode) throws SQLException {

		try{
			conn=connDAO.getMyConnection();
			Statement stmtCAT1 = conn.createStatement();
			
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			int docno;
			
			 String sqls="select * from my_clsubcatm where subcategory='"+cmbsubcategory.toUpperCase()+"' and status<>7 and catid='"+catid+"'";
			   ResultSet resultSet1 = stmtCAT1.executeQuery(sqls);
			   
			   while (resultSet1.next()) {
			        return -1;
			    }
			 
			CallableStatement stmtCAT = conn.prepareCall("{CALL clientSubCategoryDML(?,?,?,?,?,?,?)}");
			
			stmtCAT.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtCAT.setString(1,catid);
			stmtCAT.setString(2,cmbsubcategory.toUpperCase());
			stmtCAT.setString(3,formdetailcode);
			stmtCAT.setString(4,branch);
			stmtCAT.setString(5,userid);
			stmtCAT.setString(6,mode);
			stmtCAT.executeQuery();
			docno=stmtCAT.getInt("docNo");
			
			clientCategoryBean.setDocno(docno);                                               
			if (docno > 0) {
				stmtCAT.close();
				conn.close();
				return docno;
			}
		 stmtCAT.close();
		 conn.close();
		}catch(Exception e){	
		   e.printStackTrace();
		   conn.close();
		}finally{
			conn.close();
		}
		return 0;
	}
	
	public int edit(int docno,String formdetailcode,  String catid,String cmbsubcategory, HttpSession session, String mode) throws SQLException {
		try{
		     conn=connDAO.getMyConnection();
		     Statement stmtCAT1 = conn.createStatement();
		    
			 String branch = session.getAttribute("BRANCHID").toString();
			 String userid = session.getAttribute("USERID").toString();
			
			 String sqls="select * from my_clsubcatm where subcategory='"+cmbsubcategory.toUpperCase()+"' and status<>7 and catid='"+catid+"'";
			   ResultSet resultSet1 = stmtCAT1.executeQuery(sqls);
			   
			   while (resultSet1.next()) {
			        return -1;
			    }
			   
			CallableStatement stmtCAT = conn.prepareCall("{CALL clientSubCategoryDML(?,?,?,?,?,?,?)}");
			
			stmtCAT.setInt(7,docno);
			stmtCAT.setString(1,catid);
			stmtCAT.setString(2,cmbsubcategory.toUpperCase());
			stmtCAT.setString(3,formdetailcode);
			stmtCAT.setString(4,branch);
			stmtCAT.setString(5,userid);
			stmtCAT.setString(6,mode);
			int aaa= stmtCAT.executeUpdate();
			
			if(aaa<=0){
				conn.close();
				return 0;
			}
			
			
			if (aaa > 0) {
				stmtCAT.close();
				conn.close();
				return 1;
		    }
		stmtCAT.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}finally{
		conn.close();
	}
		return 0;
	}

	public boolean delete(int docno, String formdetailcode, HttpSession session, String mode) throws SQLException {
		try{
			conn=connDAO.getMyConnection();
			String branch = session.getAttribute("BRANCHID").toString();
			String userid = session.getAttribute("USERID").toString();
			
			CallableStatement stmtCAT = conn.prepareCall("{CALL clientSubCategoryDML(?,?,?,?,?,?,?)}");

			stmtCAT.setInt(7,docno);
			stmtCAT.setString(1,"0");
			stmtCAT.setString(2,"");
			stmtCAT.setString(3,formdetailcode);
			stmtCAT.setString(4,"0");
			stmtCAT.setString(5,"0");
			stmtCAT.setString(6,mode);
			int aaa= stmtCAT.executeUpdate();
			
			 if(aaa<=0){ 
				 conn.close();
				 return false; }
			 
			
			if (aaa > 0) {
				stmtCAT.close();
				conn.close();
				return true;
			}
			
		  stmtCAT.close();
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return false;
	}

	
   public List<ClsClientSubCategoryBean> list() throws SQLException {
        List<ClsClientSubCategoryBean> listBean = new ArrayList<ClsClientSubCategoryBean>();

        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtCAT = conn.createStatement();
				ResultSet resultSet = stmtCAT.executeQuery ("select c.subcategory,m.category,m.doc_no catid,c.doc_no subcatid from my_clsubcatm c left join my_clcatm m  on m.doc_no=c.catid where c.status<>7");
				while (resultSet.next()) {
					
					ClsClientSubCategoryBean bean = new ClsClientSubCategoryBean();
					
					  bean.setCmbcategory(resultSet.getString("category"));
					  bean.setCmbsubcategory(resultSet.getString("subcategory"));
					  bean.setDocno(resultSet.getInt("subcatid"));
					  bean.setCatid(resultSet.getInt("catid"));
					 
	            	listBean.add(bean);
				}
			stmtCAT.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return listBean;
    }
   
      public JSONArray category() throws SQLException {
       JSONArray RESULTDATA=new JSONArray();
       
       Connection conn = null;
		
       try {
				conn = connDAO.getMyConnection();
				Statement stmtCAT = conn.createStatement();
           	    
				String sql="select c.subcategory,m.category,m.doc_no catid,c.doc_no subcatid from my_clsubcatm c left join my_clcatm m  on m.doc_no=c.catid where c.status<>7";
				//System.out.println("strsql71234====="+sql);
           	    
				ResultSet resultSet = stmtCAT.executeQuery(sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
			stmtCAT.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
       return RESULTDATA;
   }
}
