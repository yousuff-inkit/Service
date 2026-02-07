package com.controlcentre.masters.salesmanmaster.helper;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsHelperDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	
	ClsHelperBean helperBean=new ClsHelperBean();
	Connection conn;

	public int insert( String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,String mobile,String mail,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;
			
			CallableStatement stmtHelper = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");
			stmtHelper.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtHelper.setString(1,code);
			stmtHelper.setString(2,name);
			stmtHelper.setDate(3, sqlStartDate);
			stmtHelper.setString(4, txtaccno);
			stmtHelper.setString(5,formdetailcode);
			stmtHelper.setString(6,session.getAttribute("USERID").toString());
			stmtHelper.setString(7,session.getAttribute("BRANCHID").toString());
			stmtHelper.setString(9,mode);
			stmtHelper.setString(10, mobile);
			stmtHelper.setString(11, mail);
			stmtHelper.executeQuery();
			
			docno=stmtHelper.getInt("docNo");
			helperBean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtHelper.close();
				conn.close();
				return docno;
			}
			else if (docno == -1){
				stmtHelper.close();
				conn.close();
				return docno;
			}
			else if (docno == -2){
				stmtHelper.close();
				conn.close();
				return docno;
			}
			else if (docno == -3){
				stmtHelper.close();
				conn.close();
				return docno;
			}
			stmtHelper.close();
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
	
	public int edit(String code, String name,Date sqlStartDate,String txtaccno,HttpSession session,String mode,int docno,String mobile,String mail,String formdetailcode) throws SQLException {
		
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtHelper = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtHelper.setInt(8, docno);
			stmtHelper.setString(1,code);
			stmtHelper.setString(2,name);
			stmtHelper.setDate(3, sqlStartDate);
			stmtHelper.setString(4, txtaccno);
			stmtHelper.setString(5,formdetailcode);
			stmtHelper.setString(6,session.getAttribute("USERID").toString());
			stmtHelper.setString(7,session.getAttribute("BRANCHID").toString());
			stmtHelper.setString(9,mode);
			stmtHelper.setString(10, mobile);
			stmtHelper.setString(11, mail);
			stmtHelper.executeUpdate();
			
			int documentNo=stmtHelper.getInt("docNo");
			if (documentNo>0) {
				conn.commit();
				stmtHelper.close();
				conn.close();
				return 1;
			}
			else if (documentNo == -1){
				stmtHelper.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -2){
				stmtHelper.close();
				conn.close();
				return documentNo;
			}
			else if (documentNo == -3){
				stmtHelper.close();
				conn.close();
				return documentNo;
			}
			stmtHelper.close();
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
	
	
	public boolean delete(String code, String name,Date sqlStartDate,int txtaccno,HttpSession session,String mode,int docno,String mobile,String mail,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtHelper = conn.prepareCall("{call salesDML(?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtHelper.setInt(8, docno);
			stmtHelper.setString(1,code);
			stmtHelper.setString(2,name);
			stmtHelper.setDate(3, sqlStartDate);
			stmtHelper.setInt(4, txtaccno);
			stmtHelper.setString(5,formdetailcode);
			stmtHelper.setString(6,session.getAttribute("USERID").toString());
			stmtHelper.setString(7,session.getAttribute("BRANCHID").toString());
			stmtHelper.setString(9,mode);
			stmtHelper.setString(10, mobile);
			stmtHelper.setString(11, mail);
	        stmtHelper.executeUpdate();
			
	        int documentNo=stmtHelper.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtHelper.close();
				return true;
			}	
			stmtHelper.close();
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
	
	public  List<ClsHelperBean> list() throws SQLException {
	    List<ClsHelperBean> listBean = new ArrayList<ClsHelperBean>();
	   
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtHelper = conn.createStatement();
	        	
				ResultSet resultSet = stmtHelper.executeQuery ("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.mail,m2.description "+
						" from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no where m1.status<>7 and m1.sal_type='SLA'");
	
				while (resultSet.next()) {
					
					ClsHelperBean bean = new ClsHelperBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
					bean.setName(resultSet.getString("sal_name"));
					bean.setCode(resultSet.getString("sal_code"));
					bean.setHelperdate(resultSet.getDate("date"));
					bean.setTxtaccno(resultSet.getInt("acc_no"));
					bean.setTxtaccname(resultSet.getString("description"));
					bean.setMobile(resultSet.getString("mobile"));
					bean.setMail(resultSet.getString("mail"));
					bean.setHidacno(resultSet.getString("acdoc"));
					listBean.add(bean);
				}
	
				stmtHelper.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}
	
	
	
	public  JSONArray searchDetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				conn=ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
            	String sqldata="select sal.doc_no,sal.sal_code code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description from my_salesman "+
            			" sal left join my_head head on (sal.acc_no=head.doc_no) where status=3 and sal_type='HLR'";
            	
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
