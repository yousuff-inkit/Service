package com.dashboard.management.departmentclassificationlinking;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.poi.hdf.extractor.SEP;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDepartmentClassificationLinkingDAO {
    ClsConnection ClsConnection=new ClsConnection();

    ClsCommon ClsCommon=new ClsCommon();
    
    public JSONArray deptclassgrid() throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        try {
                conn = ClsConnection.getMyConnection();
                Statement statement = conn.createStatement ();
            /*
             * String
             * sql="SELECT c.doc_no doc_no, c.name NAME FROM my_prodclassificationsetup c  WHERE c.status<>7"
             * ;
             */
                String sql="SELECT m.doc_no mid, m.description description, s.name name, s.doc_no  FROM my_prodclassificationmaster m  left join my_prodclassificationsetup s on m.csdoc_no = s.doc_no WHERE m.status=3"; 
                ResultSet resultSet = statement.executeQuery(sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                statement.close();
                conn.close();
            } catch(Exception e) {
                e.printStackTrace();
                conn.close();
            }
        return RESULTDATA;
    }
    
public JSONArray deptclassgridvd() throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        try {
                conn = ClsConnection.getMyConnection();
                Statement statement = conn.createStatement ();
            /*
             * String
             * sql="SELECT m.rowno, c.name NAME,c.doc_no doc_no, d.department, d.doc_no deptid FROM my_deptlink m INNER JOIN my_prodclassificationsetup c ON m.`classid`=c.`doc_no` INNER JOIN  my_dept d ON m.`deptid`=d.`doc_no` where m.status<>7"
             * +
             * "";
             */
                
                String sql = "SELECT d.rowno, s.doc_no,s.name AS name,m.doc_no, m.description AS description, t.doc_no,t.department AS department "+ 
                             " FROM my_prodclassificationsetup s JOIN my_prodclassificationmaster m ON s.doc_no = m.csdoc_no JOIN " + 
                             " my_deptlink d ON d.classid = m.doc_no JOIN my_dept t ON d.deptid = t.doc_no WHERE d.status<>7";
                ResultSet resultSet = statement.executeQuery(sql);
                RESULTDATA=ClsCommon.convertToJSON(resultSet);
                statement.close();
                conn.close();
            } catch(Exception e) {
                e.printStackTrace();
                conn.close();
            }
        return RESULTDATA;
    }
    
    
    public JSONArray deptSearch(HttpSession session, String department, String docno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null; 
       
         try {
           
               conn = ClsConnection.getMyConnection();
               Statement stmt = conn.createStatement();
               String sqlcond="";
               
               if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
                   sqlcond+=sqlcond+"and d.doc_no like '%"+docno+"%'";
               }
               if(!(department.equalsIgnoreCase("0")) && !(department.equalsIgnoreCase(""))){
                  sqlcond+=sqlcond+" and d.department like '%"+department+"%'";
               }
               
               
               String sql = "select d.department, d.doc_no from my_dept d where d.status<>7 "+sqlcond+" ";
               System.out.println(sql);
               ResultSet resultSet = stmt.executeQuery(sql);
               RESULTDATA=ClsCommon.convertToJSON(resultSet);
               stmt.close();   
             } catch(Exception e){
                 e.printStackTrace();
                 conn.close();
             }finally{
                 conn.close();
             }
         return RESULTDATA;
      }
    
     
}
