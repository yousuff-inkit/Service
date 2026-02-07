package com.project.execution.industry;

import java.sql.CallableStatement;  
import java.sql.Connection;
import java.sql.Date;
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
import com.controlcentre.settings.activity.ClsActivityBean;
   
public class ClsIndustryDAO {        
	
	ClsConnection conobj= new ClsConnection();  
	ClsCommon com= new ClsCommon();
	
	public int insert(int docno1,java.sql.Date date,String name,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
	    int  docno=0;      
		Connection conn=null;
		try{   
			conn=conobj.getMyConnection();  
			 Statement stmt =conn.createStatement(); 
			     
			
				    String sql3="select coalesce(max(doc_no)+1,1) docNo from gl_enqbuildtype";
				    ResultSet rs = stmt.executeQuery(sql3);   
				    if(rs.next()){
                        docno=rs.getInt("docNo");       	   	  		    	
				    }
				    String sql4="insert into gl_enqbuildtype(DOC_NO, DATE, name, STATUS) values('"+docno+"','"+date+"','"+name+"','3')";
				    int val4 = stmt.executeUpdate(sql4); 
			        
			                   
			System.out.println("docno===="+docno);     
			stmt.close();
			conn.close();
			return docno;
			
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			}
		finally{
			conn.close();
		}
		return 0;
	}
	
	public int edit(int docno1,java.sql.Date date,String name,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
	    int  docno=0;      
		Connection conn=null;
		try{   
			conn=conobj.getMyConnection();  
			 Statement stmt =conn.createStatement(); 
			     
			 if(docno1>0){
				    docno=docno1;   
					String sql2="update gl_enqbuildtype set date='"+date+"', name='"+name+"' where doc_no='"+docno+"' and STATUS='3'";  
					int val2 = stmt.executeUpdate(sql2);                              
			 }        
			                   
			System.out.println("docno===="+docno);     
			stmt.close();
			conn.close();
			return docno;
			
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			}
		finally{
			conn.close();
		}
		return 0;
	}

	
	public int delete(int docno,java.sql.Date date,String name,String description,HttpSession session,HttpServletRequest request,String mode) throws SQLException{
		Connection conn=null;   
		try{   
			conn=conobj.getMyConnection();  
			 Statement stmt =conn.createStatement(); 
		  
					String sql2="update gl_enqbuildtype set STATUS='7' where  doc_no='"+docno+"'";
					//System.out.println("sql2==delete=="+sql2);
					int val2 = stmt.executeUpdate(sql2);   
			     
			//System.out.println("docno===="+docno);      
			stmt.close();
			conn.close();
			return docno;
			
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();
			}
		finally{
			conn.close();
		}
		return 0;
	}
	
	public  JSONArray indGridLoad(HttpSession session) throws SQLException {
		 JSONArray RESULTDATA = new JSONArray();
		 Connection conn=null;
			try {
				conn = conobj.getMyConnection();
			    Statement stmt =conn.createStatement();  
				String sql="";    
				sql="select  doc_no,date,name from gl_enqbuildtype where status=3";
					//System.out.println("sql==="+sql);   
					ResultSet resultSet = stmt.executeQuery (sql);   
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
