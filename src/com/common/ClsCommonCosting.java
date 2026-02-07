package com.common;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
  
@SuppressWarnings("serial")  
public class ClsCommonCosting extends ActionSupport {
	
	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();
    
    public  JSONArray accountGridLoading(String branch,String dtype,String docno) throws SQLException {
    	Connection conn=null;
    	JSONArray RESULTDATA=new JSONArray();

        try {
		       conn = connDAO.getMyConnection();
		       Statement stmtCost = conn.createStatement();
		       
		       String  sql="select j.acno docno,h.account,h.description accountname,h.gr_type,j.id,if(j.dramount<0,round(j.dramount*j.id,2),round(j.dramount,2)) amount,if(j.id<0,true,false) cr,j.tr_no trno,j.tranid from my_jvtran j left join my_head h on j.acno=h.doc_no where h.gr_type in (4,5) and  j.dtype='"+dtype+"' and j.brhid="+branch+" and j.doc_no="+docno+"";

		       ResultSet resultSet = stmtCost.executeQuery(sql);
		       RESULTDATA=commonDAO.convertToJSON(resultSet);
		       
		       stmtCost.close();
		       conn.close();
		     } catch(Exception e){
					e.printStackTrace();
					conn.close();
			 } finally{
					conn.close();
			 }
           return RESULTDATA;
       }
    
    public  JSONArray costGridLoading(String tranid,String check) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    	    String sql = null;
	            
				conn = connDAO.getMyConnection();
				Statement stmtCost = conn.createStatement();
				
				if(!(tranid.equalsIgnoreCase("0"))){
					sql="select c.tr_no,c.costtype,c.jobid costcode,if(c.amount<0,round(c.amount*-1,2),round(c.amount,2)) amount,f.costgroup from my_costtran c left join my_jvtran j on (c.tranid=j.tranid) left join my_costunit f on c.costtype=f.costtype where c.tranid="+tranid+"";
				}
				
				if(check.equalsIgnoreCase("1")){
					ResultSet resultSet = stmtCost.executeQuery(sql);
					RESULTDATA=commonDAO.convertToJSON(resultSet);
				}
				else{
					stmtCost.close();
					conn.close();
					return RESULTDATA;
				}
				stmtCost.close();
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
