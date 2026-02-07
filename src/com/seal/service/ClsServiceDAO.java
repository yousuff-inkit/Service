package com.seal.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.project.execution.callRegister.ClsCallRegisterBean;
import com.skips.servicecontract.ClsServiceContractBean;


public class ClsServiceDAO {
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	ClsServiceBean pintbean= new ClsServiceBean(); 
	
	ClsServiceBean serviceBean = new ClsServiceBean();
	
	public int insert(Date sqlStartDate,String service,String billmethod,String acc,String description,HttpSession session,String mode,HttpServletRequest request, String dtype) throws SQLException {
		Connection conn;
		conn=conobj.getMyConnection(); 
		Statement stmt =conn.createStatement();
		conn.setAutoCommit(false);     
	    int docno=0,vocno=0;
		CallableStatement smtService = conn.prepareCall("{call sa_serviceDML(?,?,?,?,?,?,?,?,?,?,?)}");    
		
		smtService.setDate(1,sqlStartDate);
		smtService.setString(2,service);
		smtService.setString(3,billmethod);
		smtService.setString(4,acc);
		smtService.setString(5,description);
		smtService.setString(6,session.getAttribute("USERID").toString());
		smtService.setString(7,session.getAttribute("BRANCHID").toString());
		smtService.setString(8,mode);
		smtService.setString(9,dtype);
		smtService.registerOutParameter(10, java.sql.Types.INTEGER);
		smtService.registerOutParameter(11, java.sql.Types.INTEGER);  
		smtService.executeQuery();     
		 docno=smtService.getInt("docNo");
		 vocno=smtService.getInt("vocno");	
		request.setAttribute("vocno", vocno);
		if(docno<=0){  
			conn.close(); 
			return 0;
		}
		if(docno>0){
			conn.commit();
			conn.close();
			smtService.close();
			return docno;
		} 
		
		return 0;
	}
	
	public boolean edit(Date sqlStartDate,String service,String billmethod,String acc,String description,HttpSession session,String mode,HttpServletRequest request, String dtype,int docno,int vocno) throws SQLException {

    Connection conn = null;
	
try {
	
	    conn=conobj.getMyConnection(); 

		conn.setAutoCommit(false);     
	   System.out.println("dtype==="+dtype);
		CallableStatement smtService = conn.prepareCall("{call sa_serviceDML(?,?,?,?,?,?,?,?,?,?,?)}");

		smtService.setDate(1,sqlStartDate);
		smtService.setString(2,service);
		smtService.setString(3,billmethod);
		smtService.setString(4,acc);
		smtService.setString(5,description);
		smtService.setString(6,session.getAttribute("USERID").toString());
		smtService.setString(7,session.getAttribute("BRANCHID").toString());
		smtService.setString(8,mode);
		smtService.setString(9,dtype);
		smtService.setInt(10, docno);
		smtService.setInt(11, vocno);  
	    int data=smtService.executeUpdate();
		if(data<=0){
			smtService.close();
			conn.close();
			return false;
		}
		 
		if(data>0){
			conn.commit();
			conn.close();
			smtService.close();
			return true;
	}
		}catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return false;
	 }finally{
		 conn.close();
	 }
		
		return false;

		}
	
	
	
	public boolean delete(Date sqlStartDate,String service,String billmethod,String acc,String description,HttpSession session,String mode,HttpServletRequest request, String dtype,int docno,int vocno) throws SQLException {

	    Connection conn = null;
		
	try {
		conn=conobj.getMyConnection(); 

		conn.setAutoCommit(false);     
	   System.out.println("dtype==="+dtype);
		CallableStatement smtService = conn.prepareCall("{call sa_serviceDML(?,?,?,?,?,?,?,?,?,?,?)}");

		smtService.setDate(1,sqlStartDate);
		smtService.setString(2,service);
		smtService.setString(3,billmethod);
		smtService.setString(4,acc);
		smtService.setString(5,description);
		smtService.setString(6,session.getAttribute("USERID").toString());
		smtService.setString(7,session.getAttribute("BRANCHID").toString());
		smtService.setString(8,mode);
		smtService.setString(9,dtype);
		smtService.setInt(10, docno);
		smtService.setInt(11, vocno); 
		smtService.executeQuery();     

		request.setAttribute("vocno", vocno);
		if(docno<=0){  
			conn.close(); 
			return false;
		}
		if(docno>0){
			conn.commit();
			conn.close();
			smtService.close();
			return true;
		} 	
	}catch(Exception e){	
	 	e.printStackTrace();
	 	conn.close();
	 	return false;
 }finally{
	 conn.close();
 }
	
	return false;

	}

		
	
	
	public   JSONArray accountsearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();

		Connection conn=null; 
		Statement stmt  =null;
		ResultSet resultSet =null;
		try {
			conn = conobj.getMyConnection();
			 stmt = conn.createStatement ();

			String salsql="select description,account,doc_no docno,atype from my_head where atype='GL' ;";

			 resultSet = stmt.executeQuery(salsql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray ServiceMainSearch(HttpSession session, String docno, String date, String service,String check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        Statement stmt  =null;
		ResultSet resultSet =null;
		try {
			conn = conobj.getMyConnection();
			 stmt = conn.createStatement ();
			 
			 java.sql.Date sqldate=null;
			 if(check.equalsIgnoreCase("1")){
		    	   
			        String sqltest="";
			        
			       
			        if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and s.doc_no like '%"+docno+"%'";
				    }
			        
			        if(!date.equals("undefined") && !(date.equalsIgnoreCase("0")) && !(date.equalsIgnoreCase(""))){
			        	sqldate=com.changeStringtoSqlDate(date);
				         sqltest=sqltest+" and s.date='"+sqldate+"'";
				    }
			        
			        if(!(service.equalsIgnoreCase("0")) && !(service.equalsIgnoreCase(""))){
			            sqltest=sqltest+" and s.service like '%"+service+"%'";
			        }

			String salsql="select s.date,s.doc_no docno,s.voc_no,s.service,s.billmethod,s.acno,s.brhid,s.userid,s.dtype,h.description accname from sa_service s left join my_head h on h.doc_no=s.acno where s.status=3"+sqltest;
            //System.out.println("salsql=="+salsql);
			 resultSet = stmt.executeQuery(salsql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();
			
		    }
			 
		}			 
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	
	}
	
	public ClsServiceBean getViewDetails(HttpSession session,int docno) throws SQLException {
		ClsServiceBean Bean= new ClsServiceBean();
		
		 Connection conn = null;
		 Statement stmt  =null;
	     ResultSet rs =null;
		try {
			conn = conobj.getMyConnection();
			 stmt = conn.createStatement ();
			 String salsql="select s.date,s.doc_no,s.voc_no,s.service,s.billmethod,s.acno,h.description accname,s.description from sa_service s left join my_head h on h.doc_no=s.acno where s.status=3 and s.doc_no="+docno+"";
			 rs = stmt.executeQuery(salsql);
			 
			 while (rs.next()) {
				 Bean.setHiddate(rs.getString("date"));
				 Bean.setAccdocno(rs.getString("acno"));
				 Bean.setTxtservice(rs.getString("service"));
				 Bean.setHidtxtbillmethod(rs.getString("billmethod"));
				 Bean.setTxtdescription(rs.getString("description"));
				 Bean.setTxtacc(rs.getString("accname"));
				 
			 }

		}			 
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return Bean;
	

         }
	}	
