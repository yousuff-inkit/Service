package com.dashboard.gwinternal.internalcomments;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsInternalCommentsDAO {


    ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
    
    public JSONArray internalCommentsGridLoading( String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
            return RESULTDATA;
        }
        
        Connection conn = null;  
        
          try {
                conn = ClsConnection.getMyConnection();
                Statement stmtCHNG = conn.createStatement();
                 
                 String   sql = "SELECT c.doc_no doc_no, l.comp_id, l.company company, c.comment, l.doc_no cldoc_no, u.USER_NAME username, c.date date FROM gw_compintcomments c INNER JOIN gw_complist l ON l.doc_no=c.cldoc_no INNER JOIN my_user u ON u.DOC_NO=c.userid where c.status<>7 order by l.comp_id";
                                        
                ResultSet resultSet = stmtCHNG.executeQuery(sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                
                stmtCHNG.close();
                conn.close();
          } catch(Exception e){
              e.printStackTrace();
              conn.close();
          } finally{
              conn.close();
          }
          return RESULTDATA;
        }
    
    public JSONArray searchCompany( HttpSession session) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        
        
        Connection conn = null;  
        
          try {
                conn = ClsConnection.getMyConnection();
                Statement stmtCHNG = conn.createStatement();
            
                 
                 String   sql = "SELECT comp_id,company company,doc_no cldoc_no FROM gw_complist ORDER BY comp_id";
                    
                    
                ResultSet resultSet = stmtCHNG.executeQuery(sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                
                stmtCHNG.close();
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
