package com.dashboard.marketing.salesuserlink;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSalesUserLink  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray salesUserLinkGridLoading(String rpttype,String check,String type) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();     
		Connection conn = null;
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtSUL = conn.createStatement();
			    
			    if(check.equalsIgnoreCase("1")) {
			    
				    String sql = "",sql2= "",sql3= "";
				    
				    if(rpttype.equalsIgnoreCase("1")) {
				    	sql=sql+" and coalesce(m.salesuserlink,0)=0";
				    	sql2=sql2+" and m.userlink=0";
				    } else if(rpttype.equalsIgnoreCase("2")) {
				    	sql=sql+" and coalesce(m.salesuserlink,0)>0";
				    	sql2=sql2+" and m.userlink!=0";
				    }
				    
				  if(type.equalsIgnoreCase("DRV")) {
					  sql3 = "select m.sal_code code,m.sal_name name,m.mail email,m.mobile,m.doc_no docno,h.account,u.user_name,convert(concat(' Code: ',coalesce(m.sal_code,''), ' * ','Salesman  : ',coalesce(m.sal_name,'')," 
						    	 + "coalesce(CONCAT(' * ','User  : ',u.user_name),'')),char(1000)) salesmaninfo from my_salesman m left join my_head h on m.acc_no=h.doc_no left join my_user u on m.userlink=u.doc_no "  
						    	 + "where m.status=3 and m.sal_type='DRV' "+sql2;
					  
					 // System.out.println("sql1===>"+sql3);
				  }else {  
				    sql3 = "select m.sal_id code,m.sal_name name,m.mail email,m.mob_no mobile,m.doc_no docno,h.account,u.user_name,convert(concat(' Code: ',coalesce(m.sal_id,''), ' * ','Salesman  : ',coalesce(m.sal_name,'')," 
				    	 + "coalesce(CONCAT(' * ','User  : ',u.user_name),'')),char(1000)) salesmaninfo from my_salm m left join my_head h on m.acc_no=h.doc_no left join my_user u on m.salesuserlink=u.doc_no "  
				    	 + "where m.status=3"+sql;
				    
				    //System.out.println("sql2===>"+sql3);
				  }
				    
				    //System.out.println("sql77===>"+sql);
				    ResultSet resultSet = stmtSUL.executeQuery(sql3);
				                
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