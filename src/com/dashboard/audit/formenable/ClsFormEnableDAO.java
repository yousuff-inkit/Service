package com.dashboard.audit.formenable;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsFormEnableDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray menuGridLoading(String rpttype,String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSUL = conn.createStatement();
			    
			    if(check.equalsIgnoreCase("1")) {
			    
				    String sql = "";
				    
				  if(rpttype.equalsIgnoreCase("1"))
				  {
				    sql = "select mno,menu_name,func path,printpath,printpath2,gate,doc_type from my_menu ";
				  }
				  else
				  {
	                  sql = "select doc_no mno,description menu_name, path,printpath,'' printpath2,status gate,dtype doc_type from gl_bibd ";

				  }
				    ResultSet resultSet = stmtSUL.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    }
			    
			    stmtSUL.close();
			    conn.close();
		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	   public JSONArray biGridLoading(String rpttype,String check) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	           
	          try {
	                conn = ClsConnection.getMyConnection();
	                Statement stmtSUL = conn.createStatement();
	                
	                if(check.equalsIgnoreCase("1")) {
	                
	                    String sql = "";
	                    
	                  
	                    sql = "select doc_no,description,path,printpath,status,dtype from gl_bibd ";
	                    ResultSet resultSet = stmtSUL.executeQuery(sql);
	                                
	                    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	                
	                }
	                
	                stmtSUL.close();
	                conn.close();
	          } catch(Exception e){
	           e.printStackTrace();
	           conn.close();
	          } finally{
	              conn.close();
	          }
	          return RESULTDATA;
	        }

	public JSONArray userDetails(String username, String userrole, String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSUL = conn.createStatement();
			    
			    if(chk.equalsIgnoreCase("1")) {
			    	
				    String sql = "";
				    
				    if(!((username.equalsIgnoreCase("")) || (username.equalsIgnoreCase("0")))){
		                sql=sql+" and u.user_name like '%"+username+"%'";
		            }
				    
		            if(!((userrole.equalsIgnoreCase("")) || (userrole.equalsIgnoreCase("0")))){
		             sql=sql+" and r.user_role like '%"+userrole+"%'";
		            }
		            
				    sql = "select u.user_name,u.doc_no,r.user_role from my_user u left join my_urole r on u.role_id=r.doc_no where u.status=3 and r.status=3"+sql;
				    
				    ResultSet resultSet = stmtSUL.executeQuery(sql);
				                
				    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    }
			    
			    stmtSUL.close();
			    conn.close();
		  } catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  } finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
		
}