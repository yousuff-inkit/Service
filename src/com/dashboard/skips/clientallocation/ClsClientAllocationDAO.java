package com.dashboard.skips.clientallocation;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsClientAllocationDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
  public JSONArray searchTelesales(HttpSession session) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();

			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtVehclr = conn.createStatement (); 
                String sql="select doc_no,sal_name name from my_salesman where status=3 and sal_type='TEL' order by doc_no";       
                //System.out.println("sql==="+sql);
                ResultSet resultSet = stmtVehclr.executeQuery (sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtVehclr.close();
				conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}

	 public JSONArray loadClientData(HttpSession session,String type,String id) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return RESULTDATA;
			}
			Connection conn = null;
			try {
				conn = objconn.getMyConnection();
				Statement stmtVehclr = conn.createStatement (); 
				String sqltest="";
				if(type.equalsIgnoreCase("2")) {
					sqltest+=" and ac.telesalesid!=0";  
				}else if(type.equalsIgnoreCase("3")) {
					sqltest+=" and ac.telesalesid=0";  
				}else {}  
				
                String sql="select sm.sal_name telesales,ac.doc_no,ac.refname name,ac.per_mob mob,ac.per_tel telno,ac.mail1 email,coalesce(a1.name,'') grpcmp from my_acbook ac left join sk_clgroup a1 on (ac.grpcmp=a1.docno) left join my_salesman sm on sm.doc_no=ac.telesalesid and sm.sal_type='TEL' where ac.status<>7"+sqltest+"";
				//System.out.println("sql==="+sql);
                ResultSet resultSet = stmtVehclr.executeQuery (sql);   

				RESULTDATA=objcommon.convertToJSON(resultSet);     
				stmtVehclr.close();
				conn.close();

			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
			return RESULTDATA;
		}
}
