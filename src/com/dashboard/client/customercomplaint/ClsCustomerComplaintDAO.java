package com.dashboard.client.customercomplaint;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsCustomerComplaintDAO {

    ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
    
    public JSONArray GridLoading(String check,String type) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
         if(!(check.equalsIgnoreCase("1"))){
            
        return RESULTDATA;
        
    }
    try {
            conn = ClsConnection.getMyConnection();
            Statement stmtCRM = conn.createStatement();
            System.out.println(type);
            String sql = "";
            if(type.equalsIgnoreCase("2")){
            sql ="select rowno, name, mob, roomno, complaint, description, status, edate from rl_guestregd where status=3 and complete=1";
            //System.out.println(" ===1==== "+sql);         
            } else {
              sql ="select rowno, name, mob, roomno, complaint, description, status, edate from rl_guestregd where status=3 and complete=0";
              //System.out.println(" ===2==== "+sql);         
               }
              ResultSet resultSet = stmtCRM.executeQuery(sql);
           
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
           
           stmtCRM.close();
           conn.close();
   }catch(Exception e){
       e.printStackTrace();
       conn.close();
   }finally{
       conn.close();
   }
   return RESULTDATA;
}
    public JSONArray FollowUpGrid(String rdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        if(!(check.equalsIgnoreCase("1"))){
            return RESULTDATA;
        }
        try {
                conn = ClsConnection.getMyConnection();
                Statement stmtCRM = conn.createStatement();
                
                String sql = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bcuc m inner join my_user u on u.doc_no=m.userid where m.rdocno="+rdocno+" group by m.doc_no";
                //System.out.println("queryfollowup==========="+sql);
                ResultSet resultSet = stmtCRM.executeQuery(sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                
                stmtCRM.close();
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
