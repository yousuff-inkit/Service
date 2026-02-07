package com.controlcentre.masters.classificationmaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsclassificationMasterDAO {
    ClsCommon ClsCommon = new ClsCommon();
    ClsConnection ClsConnection = new ClsConnection();
    
    public JSONArray classificationMasterLoad(HttpSession session)
            throws SQLException {
            
            JSONArray RESULTDATA = new JSONArray();
            
            Connection conn = null;
            
            try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            
            String sql =
            "select s.description,s.date,s.csdoc_no,m.name,s.doc_no from  my_prodclassificationmaster s inner join my_prodclassificationsetup m on(m.doc_no=s.csdoc_no) where s.status<>7 order by s.doc_no asc"
            ;
            
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            
            stmt.close();
            conn.close();
            } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            } finally {
            conn.close();
            }
            return RESULTDATA;
            }
            
            
            
            public int insertClassificationMaster(String desc, int csdocno, Date date,
            HttpSession session, String mode, String formdetailcode)
            throws SQLException {
            Connection conn = ClsConnection.getMyConnection();
            try {
            System.out.println(desc+"   "+csdocno);
            int aaa;
            
            System.out.println(desc+"===="+csdocno+"===="+date+"==="+mode+"==="
            +formdetailcode);
            
            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql =
            "select description from my_prodclassificationmaster where status<>7 and description='"
            + desc + "' and csdoc_no='"+csdocno+"'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
            stmtTest.close();
            conn.close();
            return -1;
            }
            
            CallableStatement stmtsubCat = conn
            .prepareCall("{call prodclassificationmasterDML(?,?,?,?,?,?,?,?)}");
            System.out
            .println(
            "csdocno = "
            + csdocno+"--"+desc+"---"+date+"---"+mode);
            stmtsubCat.registerOutParameter(6, java.sql.Types.INTEGER);
            stmtsubCat.setString(1, desc);
            stmtsubCat.setDate(2, date);
            stmtsubCat.setInt(3, csdocno);
            stmtsubCat
            .setString(4, session.getAttribute("BRANCHID").toString());
            stmtsubCat.setString(5, session.getAttribute("USERID").toString());
            stmtsubCat.setString(7, mode);
            stmtsubCat.setString(8, formdetailcode);
            stmtsubCat.executeQuery();
            aaa = stmtsubCat.getInt("docNo");
            System.out.println("no====="+aaa);
            if (aaa > 0) {
            
            conn.commit();
            stmtTest.close();
            stmtsubCat.close();
            conn.close();
            return aaa;
            }
            stmtTest.close();
            stmtsubCat.close();
            conn.close();
            } catch (Exception e) {
            e.printStackTrace();
            conn.close();
            }
            return 0;
            }

       


        public int editclassificationMaster(String desc, int csdocno, int docno, Date date, String mode, HttpSession session, String formdetailcode) throws SQLException {
            Connection conn = ClsConnection.getMyConnection();
            try {
                int aaa=0;
                System.out.println(docno+"===="+desc+"===="+csdocno+"===="+date+"==="+mode+"==="+formdetailcode);
                conn.setAutoCommit(false);
                Statement stmtTest = conn.createStatement();
                String testSql ="select doc_no from my_prodclassificationmaster where status<>7 and doc_no='"+docno+"'";
                System.out.println("update validation query = "+testSql);
                ResultSet resultSet1 = stmtTest.executeQuery(testSql); 
                int docFound=0;
                while(resultSet1.next()) {
                    docFound++;
                }
                System.out.println(docFound);
                if(docFound==0) {
                    System.out.println("IN IF BLOCK");
                    stmtTest.close();
                    conn.close();
                    return -1;
                }
            
                CallableStatement stmtsubCat = conn
                .prepareCall("{call prodclassificationmasterDML(?,?,?,?,?,?,?,?)}");
                System.out
                .println(
                "csdocno = "
                + csdocno+"--"+desc+"---"+date+"---"+mode+"---"+docno);
                stmtsubCat.setInt(6, docno);
                stmtsubCat.setString(1, desc);
                stmtsubCat.setDate(2, date);
                stmtsubCat.setInt(3, csdocno);
                stmtsubCat.setString(4, session.getAttribute("BRANCHID").toString());
                stmtsubCat.setString(5, session.getAttribute("USERID").toString());
                stmtsubCat.setString(7, mode);
                stmtsubCat.setString(8, formdetailcode);
                //stmtsubCat.executeQuery();
                aaa=stmtsubCat.executeUpdate();
                System.out.println(aaa+"======"+docno);
                if (aaa > 0) {
                    conn.commit();
                    stmtTest.close();
                    stmtsubCat.close();
                    conn.close();
                    return aaa;
                }
                stmtTest.close();
                stmtsubCat.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return 0;
        }



        public int deleteClassificationMaster(String desc, int csdocno, int docno, Date date, String mode,
                HttpSession session, String formdetailcode) {
            Connection conn = ClsConnection.getMyConnection();
            try {
                int aaa=0;
                System.out.println(docno+"===="+desc+"===="+csdocno+"===="+date+"==="+mode+"==="+formdetailcode);
                conn.setAutoCommit(false);
                Statement stmtTest = conn.createStatement();
                String testSql ="select doc_no from my_prodclassificationmaster where status<>7 and description='"+ desc + "' and doc_no='"+docno+"'";
                System.out.println("DELETE validation query = "+testSql);
                ResultSet resultSet1 = stmtTest.executeQuery(testSql); 
                int docFound=0;
                while(resultSet1.next()) {
                    docFound++;
                }
                
                if(docFound==0) {
                    System.out.println("IN IF BLOCK");
                    stmtTest.close();
                    conn.close();
                    return -1;
                }
            
                CallableStatement stmtsubCat = conn
                .prepareCall("{call prodclassificationmasterDML(?,?,?,?,?,?,?,?)}");
                System.out
                .println(
                "csdocno = "
                + csdocno+"--"+desc+"---"+date+"---"+mode+"---"+docno);
                stmtsubCat.setInt(6, docno);
                stmtsubCat.setString(1, desc);
                stmtsubCat.setDate(2, date);
                stmtsubCat.setInt(3, csdocno);
                stmtsubCat.setString(4, session.getAttribute("BRANCHID").toString());
                stmtsubCat.setString(5, session.getAttribute("USERID").toString());
                stmtsubCat.setString(7, mode);
                stmtsubCat.setString(8, formdetailcode);
                aaa=stmtsubCat.executeUpdate();
                System.out.println(aaa+"======"+docno);
                if (aaa > 0) {
                    conn.commit();
                    stmtTest.close();
                    stmtsubCat.close();
                    conn.close();
                    return aaa;
                }
                stmtTest.close();
                stmtsubCat.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return 0;
        }
}
