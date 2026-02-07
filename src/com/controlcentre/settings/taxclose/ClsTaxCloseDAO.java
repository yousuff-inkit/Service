package com.controlcentre.settings.taxclose;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTaxCloseDAO {

    ClsCommon ClsCommon=new ClsCommon();
    ClsConnection ClsConnection=new ClsConnection();
    Connection conn;
    PreparedStatement ps;
    ResultSet rs;
    
    public int insert(Date date, Date dateupto, Date tclosedate, HttpSession session, int brhid, String mode, int doc_no, String formCode) throws SQLException {
        int docno=0;
        int vocno=0;
        try {
            System.out.println("@DAO");
            conn=ClsConnection.getMyConnection();
            conn.setAutoCommit(false);
            java.sql.Date sqldate = null;
            String stdate= session.getAttribute("STYEAR").toString();
            if(!(stdate.equalsIgnoreCase("undefined"))&&!(stdate.equalsIgnoreCase(""))&&!(stdate.equalsIgnoreCase("0")))
            {
                sqldate=ClsCommon.changeStringtoSqlDate2(stdate);
            }
            
            CallableStatement stmtTclose=conn.prepareCall("call taxCloseDML (?,?,?,?,?,?,?,?,?)");
            stmtTclose.registerOutParameter(8, java.sql.Types.INTEGER);
            stmtTclose.registerOutParameter(9, java.sql.Types.INTEGER);
            stmtTclose.setDate(1, date);
            stmtTclose.setDate(2, dateupto);
            stmtTclose.setDate(3, tclosedate);
            stmtTclose.setString(4, session.getAttribute("USERID").toString());
            stmtTclose.setInt(5, brhid);
            stmtTclose.setString(6, mode);
            stmtTclose.setString(7, formCode);
            stmtTclose.execute();
            docno=stmtTclose.getInt("docNo");
            vocno=stmtTclose.getInt("voc_no");
           
            
            if(docno>0){
                conn.commit();
                stmtTclose.close();
                conn.close();
                return docno;
            }else{
                stmtTclose.close();
                conn.close();
                return 0;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }finally{
            conn.close();
        }        
        
        return 0;
    }
    
    public  JSONArray getSearchDetails(String branch) throws SQLException{
        Connection conn=null;
        JSONArray RESULTDATA=new JSONArray();
        try {
        conn=ClsConnection.getMyConnection();
        Statement stmtSearch=conn.createStatement();
        
            JSONArray jsonArray = new JSONArray();
             String strSql = "select doc_no,vdate,vdateupto,vtclosedate from my_taxclose where status=3 and brhid="+branch;
                ResultSet rsagmtno = stmtSearch.executeQuery(strSql);
                RESULTDATA=ClsCommon.convertToJSON(rsagmtno);
                stmtSearch.close();
                System.out.println("sql :"+strSql);
                
                conn.close();
        }
        catch(Exception e){
            e.printStackTrace();
            conn.close();
            return RESULTDATA;

        }
        finally{
            conn.close();
        }
        
        return RESULTDATA;
}

    public boolean delete(Date date, Date dateupto, Date tclosedate, HttpSession session, int branch, String mode, int docno, int voc, String formCode)throws SQLException {
        
        conn = ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
        try {
            int del=0;
            System.out.println("docno : "+docno);
            System.out.println("Branch : "+branch);
            CallableStatement stmtTclose=conn.prepareCall("call taxCloseDML (?,?,?,?,?,?,?,?,?)");
           
            stmtTclose.setDate(1, date);
            stmtTclose.setDate(2, dateupto);
            stmtTclose.setDate(3, tclosedate);
            stmtTclose.setString(4, session.getAttribute("USERID").toString());
            stmtTclose.setInt(5, branch);
            stmtTclose.setString(6, mode);
            stmtTclose.setString(7, formCode);
            stmtTclose.setInt(8, docno);
            stmtTclose.setInt(9, voc);
            int i=stmtTclose.executeUpdate();
            System.out.println("sql  :"+stmtTclose);
            if(i>0){
                conn.commit();
                stmtTclose.close();
                conn.close();
                return true;
            }else{
                stmtTclose.close();
                conn.close();
                return false;
            }

                   } catch (Exception e) {
            e.printStackTrace();
        }finally{
            conn.close();
        }
        return false;
    }

 /*   public int edit(Date date, Date dateupto, Date tclosedate, HttpSession session, int brchName, String mode,
            int doc_no, int vocno) throws SQLException {
        
        conn = ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
        int docno=0;
        try {
            
            java.sql.Date sqldate = null;
            String stdate= session.getAttribute("STYEAR").toString();
            if(!(stdate.equalsIgnoreCase("undefined"))&&!(stdate.equalsIgnoreCase(""))&&!(stdate.equalsIgnoreCase("0")))
            {
                sqldate=ClsCommon.changeStringtoSqlDate2(stdate);
            } 
            CallableStatement stmtTclose=conn.prepareCall("call taxCloseDML (?,?,?,?,?,?,?,?)");
            stmtTclose.setDate(1, date);
            stmtTclose.setDate(2, dateupto);
            stmtTclose.setDate(3, tclosedate);
            stmtTclose.setString(4, session.getAttribute("USERID").toString());
            stmtTclose.setInt(5, brchName);
            stmtTclose.setString(6, mode);
            stmtTclose.setInt(7, doc_no);
            stmtTclose.setInt(8, vocno);
            stmtTclose.execute();
            docno=stmtTclose.getInt("docNo");
            if(docno>0){
                conn.commit();
                stmtTclose.close();
                conn.close();
                return docno;
            }else{
                stmtTclose.close();
                conn.close();
                return docno;
            }            
            
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }finally{
            stmtTclose.close();
            conn.close();
        }
        return 0;
    }*/

}
