package com.controlcentre.settings.productsettings.productmaster;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mysql.jdbc.PreparedStatement;

public class ClsProductMasterDAO {
    ClsCommon ClsCommon = new ClsCommon();
    ClsConnection ClsConnection = new ClsConnection();

    public int insert(java.sql.Date date, String formdet, String formcode,
            String productype, String mode) throws SQLException {

        Connection conn;
        conn = ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
        java.sql.PreparedStatement stmt = null;
        int returns = 0;
        try {

            Statement stmtTest = conn.createStatement();
            String testSql = "select PRODUCTTYPE from my_ptype where status<>7 and PRODUCTTYPE='"
                    + productype + "'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }

            Statement stmt1 = conn.createStatement();

            String sql1 = "select coalesce(max(doc_no)+1,1) docno from my_ptype ";
            int docno = 0;

            ResultSet rs = stmt1.executeQuery(sql1);
            if (rs.next()) {
                docno = rs.getInt("docno");
            }
            System.out.println("=== " + productype);
            String sql = "INSERT INTO my_ptype(doc_no,PRODUCTTYPE, date, status) VALUES ("
                    + docno + ",'" + productype + "','" + date + "',3)";

            stmt = conn.prepareStatement(sql);
            stmt.execute();
            conn.commit();
            returns = docno;
            /* int resultSet2 = stmt.executeUpdate(sql); */
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return returns;

    }

    public int insertdept(java.sql.Date date, String formdet, String formcode,
            String dept, String mode) throws SQLException {

        Connection conn;
        conn = ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
        java.sql.PreparedStatement stmt = null;
        int returns = 0;
        try {

            Statement stmtTest = conn.createStatement();
            String testSql = "select department from my_dept where status<>7 and department='"
                    + dept + "'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }

            Statement stmt1 = conn.createStatement();

            String sql1 = "select coalesce(max(doc_no)+1,1) docno from my_dept ";
            int docno = 0;

            ResultSet rs = stmt1.executeQuery(sql1);
            if (rs.next()) {
                docno = rs.getInt("docno");
            }

            String sql = "INSERT INTO my_dept(doc_no,department, dept ,date, status) VALUES ("
                    + docno + ",'" + dept + "','" + dept + "','" + date + "',3)";

            stmt = conn.prepareStatement(sql);
            stmt.execute();
            conn.commit();
            returns = docno;
            /* int resultSet2 = stmt.executeUpdate(sql); */
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return returns;

    }

    public int updatedept(java.sql.Date date, String formdet, String formcode,
            String dept, String mode, int docno) throws SQLException {

        Connection conn;
        conn = ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
        java.sql.PreparedStatement stmt = null;
        int returns = 0;
        try {

            Statement stmtTest = conn.createStatement();
            String testSql = "select department from my_dept where status<>7 and department='"
                    + dept + "' and doc_no<>" + docno + "";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }

            String sql = "update my_dept set department='" + dept + "',date='"
                    + date + "' where doc_no=" + docno + "";

            stmt = conn.prepareStatement(sql);
            stmt.execute();
            conn.commit();
            returns = docno;
            /* int resultSet2 = stmt.executeUpdate(sql); */
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return returns;

    }

    public int deletedept(java.sql.Date date, String formdet, String formcode,
            String dept, String mode, int docno) throws SQLException {

        Connection conn;
        conn = ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
        java.sql.PreparedStatement stmt = null;
        int returns = 0;
        try {

            String sql = "update my_dept set status=7 where doc_no=" + docno
                    + "";

            stmt = conn.prepareStatement(sql);
            stmt.execute();
            conn.commit();
            returns = 1;
            /* int resultSet2 = stmt.executeUpdate(sql); */
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return returns;

    }

    public int update(java.sql.Date date, String formdet, String formcode,
            String productype, String mode, int docno) throws SQLException {

        Connection conn;
        conn = ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
        java.sql.PreparedStatement stmt = null;
        int returns = 0;
        try {

            Statement stmtTest = conn.createStatement();
            String testSql = "select PRODUCTTYPE from my_ptype where status<>7 and PRODUCTTYPE='"
                    + productype + "' and doc_no<>" + docno + "";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }

            String sql = "update my_ptype set PRODUCTTYPE='" + productype
                    + "',date='" + date + "' where doc_no=" + docno + "";

            stmt = conn.prepareStatement(sql);
            stmt.execute();
            conn.commit();
            returns = docno;
            /* int resultSet2 = stmt.executeUpdate(sql); */
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return returns;

    }

    public int delete(java.sql.Date date, String formdet, String formcode,
            String productype, String mode, int docno) throws SQLException {

        Connection conn;
        conn = ClsConnection.getMyConnection();
        conn.setAutoCommit(false);
        java.sql.PreparedStatement stmt = null;
        int returns = 0;
        try {

            String sql = "update my_ptype set status=7 where doc_no=" + docno
                    + "";

            stmt = conn.prepareStatement(sql);
            stmt.execute();
            conn.commit();
            returns = 1;
            /* int resultSet2 = stmt.executeUpdate(sql); */
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return returns;

    }

    public JSONArray prdtypeLoad(HttpSession session) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select DOC_NO doc_no, PRODUCTTYPE prd_type, date from my_ptype where status=3";

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

    public JSONArray prdeptLoad(HttpSession session) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select department as dept,doc_no,date from my_dept where status=3";

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

    public JSONArray prdbrandLoad(HttpSession session) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select BRAND BRANDNAME,BRANDNAME desc1 , DOC_NO,DATE from my_brand where status=3 ";

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

    public int insert(Date date_brand, String brand, String desc, String mode,
            HttpSession session, String formdetailcode) throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            int aaa;

            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();

            String testSql = "select brand from my_brand where status<>7 and brand='"
                    + brand + "'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }
            CallableStatement stmtBrand = conn
                    .prepareCall("{CALL prodBrandDML(?,?,?,?,?,?,?,?)}");
            stmtBrand.registerOutParameter(6, java.sql.Types.INTEGER);
            stmtBrand.setString(1, brand);
            stmtBrand.setString(2, desc);
            stmtBrand.setDate(3, date_brand);
            stmtBrand.setString(4, session.getAttribute("BRANCHID").toString());
            stmtBrand.setString(5, session.getAttribute("USERID").toString());
            stmtBrand.setString(7, mode);
            stmtBrand.setString(8, formdetailcode);
            int val = stmtBrand.executeUpdate();
            aaa = stmtBrand.getInt("docNo");
            // System.out.println(aaa);

            if (val > 0) {
                // System.out.println("Sucess"+brandBean.getDocno());
                conn.commit();
                stmtBrand.close();
                stmtTest.close();
                conn.close();
                return aaa;
            }
            stmtBrand.close();
            stmtTest.close();

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return 0;
    }

    public int edit(int docno, java.sql.Date sqlStartDate, String brand,
            String desc, HttpSession session, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql = "select brand from my_brand where status<>7 and brand='"
                    + brand + "' and doc_no<>'" + docno + "'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }

            CallableStatement stmtBrand = conn
                    .prepareCall("{CALL prodBrandDML(?,?,?,?,?,?,?,?)}");
            stmtBrand.setString(1, brand);
            stmtBrand.setString(2, desc);
            stmtBrand.setDate(3, sqlStartDate);
            stmtBrand.setString(4, session.getAttribute("BRANCHID").toString());
            stmtBrand.setString(5, session.getAttribute("USERID").toString());
            stmtBrand.setInt(6, docno);
            stmtBrand.setString(7, "E");
            stmtBrand.setString(8, formdetailcode);
            stmtBrand.executeUpdate();
            int aaa = stmtBrand.getInt("docNo");
            // System.out.println(aaa);

            if (aaa > 0) {
                // System.out.println("Sucess");
                conn.commit();

                stmtBrand.close();
                conn.close();
                return aaa;
            }

            stmtBrand.close();

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return 0;
    }

    public int delete(int docno, HttpSession session, String brand,
            String formdetailcode) throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            conn.setAutoCommit(false);
            /*
             * Statement stmtTest=conn.createStatement (); String testsql2=
             * "select * from gl_vehbrand b inner join gl_vehmodel m on m.brandid=b.doc_no where b.brand='"
             * +brand+"'"; ResultSet resultSet2 = stmtTest.executeQuery
             * (testsql2); if(resultSet2.next()){ stmtTest.close();
             * conn.close(); return -2; } String testsql3=
             * "select m.doc_no from gl_vehbrand b inner join gl_vehmaster m on m.brdid=b.doc_no where b.brand='"
             * +brand+"'"; ResultSet resultSet3 = stmtTest.executeQuery
             * (testsql3); if(resultSet3.next()){ stmtTest.close();
             * conn.close(); return -2; }
             */
            CallableStatement stmtBrand = conn
                    .prepareCall("{CALL prodBrandDML(?,?,?,?,?,?,?,?)}");
            stmtBrand.setString(1, null);
            stmtBrand.setString(2, null);
            stmtBrand.setDate(3, null);
            stmtBrand.setString(4, session.getAttribute("BRANCHID").toString());
            stmtBrand.setString(5, session.getAttribute("USERID").toString());
            stmtBrand.setInt(6, docno);
            stmtBrand.setString(7, "D");
            stmtBrand.setString(8, formdetailcode);
            stmtBrand.executeUpdate();
            int aaa = stmtBrand.getInt("docNo");

            if (aaa > 0) {
                // System.out.println("Sucess");
                conn.commit();
                stmtBrand.close();

                conn.close();
                return aaa;
            }

            stmtBrand.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return 0;
    }

    public int insert(String unit, String unitdesc, HttpSession session,
            String mode, String formdetailcode) throws SQLException {

        Connection conn = ClsConnection.getMyConnection();
        try {
            int aaa;

            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql = "select unit from my_unitm where status<>7 and unit='"
                    + unit + "'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }
            // System.out.println("brandid"+brandid);
            // System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
            CallableStatement stmtUnit = conn
                    .prepareCall("{call prodUnitDML(?,?,?,?,?,?,?)}");
            // System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand
            // +")}");
            // CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire
            // 7 llc',1,@docNo);
            stmtUnit.registerOutParameter(5, java.sql.Types.INTEGER);
            stmtUnit.setString(1, unit);
            stmtUnit.setString(2, unitdesc);
            stmtUnit.setString(3, session.getAttribute("BRANCHID").toString());
            stmtUnit.setString(4, session.getAttribute("USERID").toString());
            stmtUnit.setString(6, mode);
            stmtUnit.setString(7, formdetailcode);

            stmtUnit.executeQuery();
            aaa = stmtUnit.getInt("docNo");
            // System.out.println("no====="+aaa);
            // unitBean.setDocno(aaa);
            if (aaa > 0) {

                // System.out.println("Success"+unitBean.getDocno());
                conn.commit();
                stmtTest.close();
                stmtUnit.close();
                conn.close();
                return aaa;
            }

            stmtTest.close();
            stmtUnit.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return 0;
    }

    public List<ClsProductMasterBean> unitlist() throws SQLException {
        List<ClsProductMasterBean> listBean = new ArrayList<ClsProductMasterBean>();
        Connection conn = ClsConnection.getMyConnection();
        try {

            Statement stmtUnit = conn.createStatement();

            ResultSet resultSet = stmtUnit
                    .executeQuery("select DOC_NO,unit,unit_desc from my_unitm where status<>7");

            while (resultSet.next()) {

                ClsProductMasterBean bean = new ClsProductMasterBean();
                bean.setDocno(resultSet.getInt("DOC_NO"));
                bean.setUnit(resultSet.getString("unit"));
                bean.setUnitdesc(resultSet.getString("unit_desc"));
                listBean.add(bean);
                // System.out.println(listBean);
            }
            stmtUnit.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        // System.out.println("nitin===="+listBean);
        return listBean;
    }

    public List<ClsProductMasterBean> modellist() throws SQLException {
        List<ClsProductMasterBean> listBean = new ArrayList<ClsProductMasterBean>();
        Connection conn = ClsConnection.getMyConnection();
        try {

            Statement stmt = conn.createStatement();

            ResultSet resultSet = stmt
                    .executeQuery(
                            "select m.model,m.date,m.doc_no,b.brand,m.brandid from my_model m inner join my_brand b on(m.brandid=b.doc_no) where m.status<>7");

            while (resultSet.next()) {

                ClsProductMasterBean bean = new ClsProductMasterBean();
                bean.setDocno(resultSet.getInt("DOC_NO"));
                bean.setUnit(resultSet.getString("unit"));
                bean.setUnitdesc(resultSet.getString("unit_desc"));
                listBean.add(bean);
                // System.out.println(listBean);
            }
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        // System.out.println("nitin===="+listBean);
        return listBean;
    }

    public JSONArray unitlists() throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select doc_no,unit,unit_desc from my_unitm where status<>7";

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

    public JSONArray hsncodelists() throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select doc_no,hs_code,description,date from my_hsncode where status<>7";

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

    public JSONArray modellist(HttpSession session) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select m.model,m.date,m.doc_no,b.brand,m.brandid from my_model m inner join my_brand b on(m.brandid=b.doc_no) where m.status<>7";

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

    public JSONArray prdcategoryLoad(HttpSession session) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select Category, DATE, doc_no from my_catm where status<>7";

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

    public JSONArray prdsubcategoryLoad(HttpSession session)
            throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select s.subCategory,s.date,s.catid,m.category,s.doc_no from  my_scatm s inner join my_catm m on(m.doc_no=s.catid) where s.status<>7";

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

    public int edit(String unit, int docno, String unitdesc, String mode,
            HttpSession session, String formdetailcode) throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            conn.setAutoCommit(false);
            // System.out.println(conn);
            Statement stmtTest = conn.createStatement();
            String testSql = "select unit from my_unitm where status<>7 and unit='"
                    + unit + "' and doc_no<>'" + docno + "'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }
            CallableStatement stmtUnit = conn
                    .prepareCall("{call prodUnitDML(?,?,?,?,?,?,?)}");
            // PreparedStatement stmtModel =
            // conn.prepareStatement("update gl_vehmodel set brandid=?, date=?,model=? where
            // doc_no=?");
            // System.out.println("update gl_vehmodel set
            // brandid='"+brandid+"',date='"+modeldate+"',model='"+model+"' where
            // doc_no='"+docno+"'");
            // System.out.println("after stm inside edit");
            // System.out.println("BRAND ID"+brandid);
            stmtUnit.setString(1, unit);
            stmtUnit.setString(2, unitdesc);
            stmtUnit.setString(3, session.getAttribute("BRANCHID").toString());
            stmtUnit.setString(4, session.getAttribute("USERID").toString());
            stmtUnit.setInt(5, docno);
            stmtUnit.setString(6, mode);
            stmtUnit.setString(7, formdetailcode);

            int aa = stmtUnit.executeUpdate();

            // System.out.println("inside DAO1");
            if (aa > 0) {
                // System.out.println("Success");
                conn.commit();
                stmtUnit.close();
                stmtTest.close();
                conn.close();
                return aa;
            }
            stmtUnit.close();
            stmtTest.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }

        return 0;
    }

    public boolean delete(String unit, int docno, String unitdesc, String mode,
            HttpSession session, String formdetailcode) throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            conn.setAutoCommit(false);
            // System.out.println(conn);
            CallableStatement stmtUnit = conn
                    .prepareCall("{call prodUnitDML(?,?,?,?,?,?,?)}");
            stmtUnit.setInt(5, docno);

            stmtUnit.setString(1, unit);
            stmtUnit.setString(2, unitdesc);

            stmtUnit.setString(3, session.getAttribute("BRANCHID").toString());
            stmtUnit.setString(4, session.getAttribute("USERID").toString());
            stmtUnit.setString(6, mode);
            stmtUnit.setString(7, formdetailcode);

            // PreparedStatement stmtModel =
            // conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
            // System.out.println("after stm inside delete");
            // System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
            // stmtModel.setInt(1,docno);
            int aa = stmtUnit.executeUpdate();
            if (aa > 0) {
                // System.out.println("Success");
                conn.commit();
                stmtUnit.close();

                conn.close();
                return true;
            }
            stmtUnit.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }

        return false;
    }

    public int insert1(String formdetailcode, String txtcategory, String mode,
            HttpSession session, Date date) throws SQLException {

        Connection conn = null;
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtCAT1 = conn.createStatement();

            String branch = session.getAttribute("BRANCHID").toString();
            String userid = session.getAttribute("USERID").toString();
            int docno;

            String sqls = "select * from my_catm where category='"
                    + txtcategory + "' and status<>7 ";
            ResultSet resultSet1 = stmtCAT1.executeQuery(sqls);

            while (resultSet1.next()) {
                return -1;
            }

            CallableStatement stmtCAT = conn
                    .prepareCall("{CALL prodCategoryDML(?,?,?,?,?,?)}");
            stmtCAT.registerOutParameter(6, java.sql.Types.INTEGER);
            stmtCAT.setString(1, txtcategory);
            stmtCAT.setString(2, formdetailcode);
            stmtCAT.setString(3, branch);
            stmtCAT.setString(4, userid);
            stmtCAT.setString(5, mode);
            stmtCAT.executeQuery();
            docno = stmtCAT.getInt("docNo");

            if (docno > 0) {
                Statement stmt1 = conn.createStatement();

                String sql1 = "update my_catm set date='" + date
                        + "' where doc_no=" + docno + "";
                System.out.println(".....sql date upd=" + sql1);
                stmt1.executeUpdate(sql1);

                stmtCAT.close();
                conn.close();
                return docno;
            }
            stmtCAT.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return 0;
    }

    public int edit1(String formdetailcode, int docno, String txtcategory,
            String mode, HttpSession session, Date date) throws SQLException {

        Connection conn = null;
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmtCAT1 = conn.createStatement();

            String branch = session.getAttribute("BRANCHID").toString();
            String userid = session.getAttribute("USERID").toString();

            String sql = "select * from my_catm where category='" + txtcategory
                    + "' and status<>7 and doc_no<>" + docno + " ";
            ResultSet resultSet1 = stmtCAT1.executeQuery(sql);

            while (resultSet1.next()) {
                return -1;
            }

            CallableStatement stmtCAT = conn
                    .prepareCall("{CALL prodCategoryDML(?,?,?,?,?,?)}");
            stmtCAT.setString(1, txtcategory);
            stmtCAT.setString(2, formdetailcode);
            stmtCAT.setString(3, branch);
            stmtCAT.setString(4, userid);
            stmtCAT.setString(5, mode);
            stmtCAT.setInt(6, docno);
            stmtCAT.executeQuery();
            docno = stmtCAT.getInt("docNo");

            if (docno > 0) {
                Statement stmt1 = conn.createStatement();

                String sql1 = "update my_catm set date='" + date
                        + "' where doc_no=" + docno + " ";
                System.out.println(".....sql date upd=" + sql1);
                stmt1.executeUpdate(sql1);

                stmtCAT.close();
                conn.close();
                return 1;
            }
            stmtCAT.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return 0;
    }

    public int delete1(int docno, String formdetailcode, String mode,
            HttpSession session) throws SQLException {

        Connection conn = null;
        try {
            conn = ClsConnection.getMyConnection();

            Statement stmtTest = conn.createStatement();
            String test = "select sc.SubCategory from my_scatm sc where catid='"
                    + docno + "' and status=3";
            System.out.println("ref check" + test);
            ResultSet resultSet3 = stmtTest.executeQuery(test);
            if (resultSet3.next()) {
                stmtTest.close();
                conn.close();
                System.out.println("refered");
                return -2;

            }

            String branch = session.getAttribute("BRANCHID").toString();
            String userid = session.getAttribute("USERID").toString();

            CallableStatement stmtCAT = conn
                    .prepareCall("{CALL prodCategoryDML(?,?,?,?,?,?)}");
            stmtCAT.setString(1, null);
            stmtCAT.setString(2, formdetailcode);
            stmtCAT.setString(3, branch);
            stmtCAT.setString(4, userid);
            stmtCAT.setString(5, mode);
            stmtCAT.setInt(6, docno);
            stmtCAT.executeQuery();
            docno = stmtCAT.getInt("docNo");

            if (docno > 0) {
                stmtCAT.close();
                conn.close();
                return 1;
            }
            stmtCAT.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        return -1;
    }

    public int insert(String model, String brandid, Date sqlStartDate,
            HttpSession session, String mode, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {
            int aaa;

            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql = "select model from my_model where status<>7 and model='"
                    + model + "'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }
            // System.out.println("brandid"+brandid);
            // System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
            CallableStatement stmtModel = conn
                    .prepareCall("{call prodModelDML(?,?,?,?,?,?,?,?)}");
            // System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand
            // +")}");
            // CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire
            // 7 llc',1,@docNo);
            stmtModel.registerOutParameter(6, java.sql.Types.INTEGER);
            stmtModel.setString(1, model);
            stmtModel.setDate(2, sqlStartDate);
            stmtModel.setString(3, brandid);
            // System.out.println("brandid"+brandid);
            stmtModel.setString(4, session.getAttribute("BRANCHID").toString());
            stmtModel.setString(5, session.getAttribute("USERID").toString());
            stmtModel.setString(7, mode);
            stmtModel.setString(8, formdetailcode);
            stmtModel.executeQuery();
            aaa = stmtModel.getInt("docNo");
            // System.out.println("no====="+aaa);
            if (aaa > 0) {

                conn.commit();
                stmtTest.close();
                stmtModel.close();
                conn.close();
                return aaa;
            }
            stmtTest.close();
            stmtModel.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return 0;
    }

    public int edit(String model, int docno, Date modeldate, String brandid,
            String mode, HttpSession session, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            // System.out.println(conn);
            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql = "select model from my_model where status<>7 and model='"
                    + model + "' and doc_no<>" + docno + " ";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }
            CallableStatement stmtModel = conn
                    .prepareCall("{call prodModelDML(?,?,?,?,?,?,?,?)}");
            // PreparedStatement stmtModel =
            // conn.prepareStatement("update gl_vehmodel set brandid=?, date=?,model=? where
            // doc_no=?");
            // System.out.println("update gl_vehmodel set
            // brandid='"+brandid+"',date='"+modeldate+"',model='"+model+"' where
            // doc_no='"+docno+"'");
            stmtModel.setInt(6, docno);
            stmtModel.setString(1, model);
            stmtModel.setDate(2, (Date) modeldate);
            stmtModel.setString(3, brandid);
            stmtModel.setString(4, session.getAttribute("BRANCHID").toString());
            stmtModel.setString(5, session.getAttribute("USERID").toString());
            stmtModel.setString(7, mode);
            stmtModel.setString(8, formdetailcode);

            // System.out.println("before date");
            // stmtModel.setDate(2,(Date)modeldate);
            // System.out.println("after date");
            // System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

            int aa = stmtModel.executeUpdate();

            // System.out.println("inside DAO1");
            if (aa > 0) {
                // System.out.println("Success");
                conn.commit();
                stmtTest.close();
                stmtModel.close();
                conn.close();
                return aa;
            }

            stmtTest.close();
            stmtModel.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }

        return 0;
    }

    public int delete(String model, int docno, Date modeldate, String brandid,
            String mode, HttpSession session, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            conn.setAutoCommit(false);
            // System.out.println(conn);
            Statement stmtTest = conn.createStatement();

            String testsql3 = "select m.doc_no from gl_vehmodel b inner join gl_vehmaster m on m.vmodid=b.doc_no where b.vtype='"
                    + model + "'";
            ResultSet resultSet3 = stmtTest.executeQuery(testsql3);
            if (resultSet3.next()) {
                stmtTest.close();
                conn.close();
                return -2;
            }
            CallableStatement stmtModel = conn
                    .prepareCall("{call prodModelDML(?,?,?,?,?,?,?,?)}");
            stmtModel.setString(1, model);
            stmtModel.setDate(2, (Date) modeldate);
            stmtModel.setString(3, brandid);
            stmtModel.setString(4, session.getAttribute("BRANCHID").toString());
            stmtModel.setString(5, session.getAttribute("USERID").toString());
            stmtModel.setInt(6, docno);
            stmtModel.setString(7, mode);
            stmtModel.setString(8, formdetailcode);

            // PreparedStatement stmtModel =
            // conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
            // System.out.println("after stm inside delete");
            // System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
            // stmtModel.setInt(1,docno);
            int aa = stmtModel.executeUpdate();
            if (aa > 0) {
                // System.out.println("Success");
                conn.commit();
                stmtModel.close();
                stmtTest.close();
                conn.close();
                return aa;
            }
            stmtTest.close();
            stmtModel.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }

        return 0;
    }

    public int insertSubCat(String subCat, String catid, Date date,
            HttpSession session, String mode, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {
            int aaa;
            /*
             * System.out.println(subCat+"===="+catid+"===="+date+"==="+mode+"==="
             * +formdetailcode);
             */
            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql = "select SubCategory from my_scatm where status<>7 and SubCategory='"
                    + subCat + "' and catid="+catid+"";
            System.out.println("sub cat chk sql : "+testSql);
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }

            CallableStatement stmtsubCat = conn
                    .prepareCall("{call prodSubCatDML(?,?,?,?,?,?,?,?)}");
            System.out
                    .println("catid=asdasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss===="
                            + catid);
            stmtsubCat.registerOutParameter(6, java.sql.Types.INTEGER);
            stmtsubCat.setString(1, subCat);
            stmtsubCat.setDate(2, date);
            stmtsubCat.setString(3, catid);
            stmtsubCat
                    .setString(4, session.getAttribute("BRANCHID").toString());
            stmtsubCat.setString(5, session.getAttribute("USERID").toString());
            stmtsubCat.setString(7, mode);
            stmtsubCat.setString(8, formdetailcode);
            stmtsubCat.executeQuery();
            aaa = stmtsubCat.getInt("docNo");
            // System.out.println("no====="+aaa);
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

    public int editSubCat(String subCat, int docno, Date date, String catid,
            String mode, HttpSession session, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            // System.out.println(conn);
            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql = "select subCategory from my_scatm where status<>7 and subCategory='"
                    + subCat + "' and doc_no<>" + docno + " and catid="+catid+"";
            System.out.println("Test sub sql : "+testSql);
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }
            CallableStatement stmtSubCat = conn
                    .prepareCall("{call prodSubCatDML(?,?,?,?,?,?,?,?)}");
            // PreparedStatement stmtModel =
            // conn.prepareStatement("update gl_vehmodel set catid=?, date=?,model=? where
            // doc_no=?");
            // System.out.println("update gl_vehmodel set
            // catid='"+catid+"',date='"+modeldate+"',model='"+model+"' where
            // doc_no='"+docno+"'");
            stmtSubCat.setInt(6, docno);
            stmtSubCat.setString(1, subCat);
            stmtSubCat.setDate(2, date);
            stmtSubCat.setString(3, catid);
            stmtSubCat
                    .setString(4, session.getAttribute("BRANCHID").toString());
            stmtSubCat.setString(5, session.getAttribute("USERID").toString());
            stmtSubCat.setString(7, mode);
            stmtSubCat.setString(8, formdetailcode);

            // System.out.println("before date");
            // stmtModel.setDate(2,(Date)modeldate);
            // System.out.println("after date");
            // System.out.println(catid+":"+docno+":"+model+":"+modeldate);

            int aa = stmtSubCat.executeUpdate();

            // System.out.println("inside DAO1");
            if (aa > 0) {
                // System.out.println("Success");
                conn.commit();
                stmtTest.close();
                stmtSubCat.close();
                conn.close();
                return aa;
            }

            stmtTest.close();
            stmtSubCat.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }

        return 0;
    }

    public int deleteSubCat(String subCat, int docno, Date date, String catid,
            String mode, HttpSession session, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            conn.setAutoCommit(false);
            System.out.println(docno);
            Statement stmtTest = conn.createStatement();

            /*
             * String testsql3=
             * "select m.doc_no from my_catm b inner join my_scatm m on m.vmodid=b.doc_no where b.vtype='"
             * +subCat+"'"; ResultSet resultSet3 = stmtTest.executeQuery
             * (testsql3); if(resultSet3.next()){ stmtTest.close();
             * conn.close(); return -2; }
             */
            System.out.println(docno);
            CallableStatement stmtSubCat = conn
                    .prepareCall("{call prodSubCatDML(?,?,?,?,?,?,?,?)}");
            stmtSubCat.setString(1, subCat);
            stmtSubCat.setDate(2, date);
            stmtSubCat.setString(3, catid);
            stmtSubCat
                    .setString(4, session.getAttribute("BRANCHID").toString());
            stmtSubCat.setString(5, session.getAttribute("USERID").toString());
            stmtSubCat.setInt(6, docno);
            stmtSubCat.setString(7, mode);
            stmtSubCat.setString(8, formdetailcode);

            // PreparedStatement stmtModel =
            // conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
            // System.out.println("after stm inside delete");
            // System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
            // stmtModel.setInt(1,docno);
            int aa = stmtSubCat.executeUpdate();
            if (aa > 0) {
                // System.out.println("Success");
                conn.commit();
                stmtSubCat.close();
                stmtTest.close();
                conn.close();
                return aa;
            }
            stmtTest.close();
            stmtSubCat.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }

        return 0;
    }

    public JSONArray prdsubfamilyLoad(HttpSession session) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select m.name AS subfamily,m.date,m.typeid,"
                    + "case " + "when m.typeid = 2 then 'Sub Family 2' "
                    + "when m.typeid = 3 then 'Sub Family 3' "
                    + "when m.typeid = 4 then 'Sub Family 4' " + "ELSE '' "
                    + "END AS type"
                    + ",m.doc_no from my_subfamily m where m.status<>7";
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

    public int insertSubFamily(String subfamilyname, String subfamilytype, Date date,
            HttpSession session, String mode, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {
            int aaa;
            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql = "select name from my_subfamily where status<>7 and name='" + subfamilyname + "'";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }

            CallableStatement stmtsubFam = conn.prepareCall("{call prodSubFamilyDML(?,?,?,?,?,?,?,?)}");
            stmtsubFam.registerOutParameter(6, java.sql.Types.INTEGER);
            stmtsubFam.setString(1, subfamilyname);
            stmtsubFam.setDate(2, date);
            stmtsubFam.setString(3, subfamilytype);
            stmtsubFam.setString(4, session.getAttribute("BRANCHID").toString());
            stmtsubFam.setString(5, session.getAttribute("USERID").toString());
            stmtsubFam.setString(7, mode);
            stmtsubFam.setString(8, formdetailcode);
            stmtsubFam.executeQuery();
            aaa = stmtsubFam.getInt("docNo");
            if (aaa > 0) {
                conn.commit();
                stmtTest.close();
                stmtsubFam.close();
                conn.close();
                return aaa;
            }
            stmtTest.close();
            stmtsubFam.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return 0;
    }

    public int editSubFamily(String subfamilyname, int docno, Date date, String subfamilytype,
            String mode, HttpSession session, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {
            conn.setAutoCommit(false);
            Statement stmtTest = conn.createStatement();
            String testSql = "select name from my_subfamily where status<>7 and name='" + subfamilyname
                    + "' and doc_no<>" + docno + "";
            ResultSet resultSet1 = stmtTest.executeQuery(testSql);
            if (resultSet1.next()) {
                stmtTest.close();
                conn.close();
                return -1;
            }
            CallableStatement stmtsubFam = conn.prepareCall("{call prodSubFamilyDML(?,?,?,?,?,?,?,?)}");
            stmtsubFam.setInt(6, docno);
            stmtsubFam.setString(1, subfamilyname);
            stmtsubFam.setDate(2, date);
            stmtsubFam.setString(3, subfamilytype);
            stmtsubFam.setString(4, session.getAttribute("BRANCHID").toString());
            stmtsubFam.setString(5, session.getAttribute("USERID").toString());
            stmtsubFam.setString(7, mode);
            stmtsubFam.setString(8, formdetailcode);

            int aa = stmtsubFam.executeUpdate();

            if (aa > 0) {
                conn.commit();
                stmtTest.close();
                stmtsubFam.close();
                conn.close();
                return aa;
            }

            stmtTest.close();
            stmtsubFam.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }

        return 0;
    }

    public int deleteSubFamily(String subfamilyname, int docno, Date date, String subfamilytype,
            String mode, HttpSession session, String formdetailcode)
            throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {

            conn.setAutoCommit(false);
            System.out.println(docno);
            Statement stmtTest = conn.createStatement();

            CallableStatement stmtSubCat = conn.prepareCall("{call prodSubFamilyDML(?,?,?,?,?,?,?,?)}");
            stmtSubCat.setString(1, subfamilyname);
            stmtSubCat.setDate(2, date);
            stmtSubCat.setString(3, subfamilytype);
            stmtSubCat
                    .setString(4, session.getAttribute("BRANCHID").toString());
            stmtSubCat.setString(5, session.getAttribute("USERID").toString());
            stmtSubCat.setInt(6, docno);
            stmtSubCat.setString(7, mode);
            stmtSubCat.setString(8, formdetailcode);

            int aa = stmtSubCat.executeUpdate();
            if (aa > 0) {
                conn.commit();
                stmtSubCat.close();
                stmtTest.close();
                conn.close();
                return aa;
            }
            stmtTest.close();
            stmtSubCat.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }

        return 0;
    }

    public int inserthsncode(int docno, String hscode, String hsndate, String description, HttpSession session,
            String mode, String formdetailcode) throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {
            int aaa;
            conn.setAutoCommit(false);
            Statement stmt = conn.createStatement();
            String sql = "select hs_code from my_hsncode where status<>7 and hs_code='"
                    + hscode + "'";
            ResultSet resultSet = stmt.executeQuery(sql);
            if (resultSet.next()) {
                stmt.close();
                conn.close();
                return -1;
            }
            CallableStatement callableStatement = conn.prepareCall("{call hsncodeDML(?,?,?,?,?,?,?,?)}");
            callableStatement.registerOutParameter(6, java.sql.Types.INTEGER);
            callableStatement.setString(1, hscode);
            callableStatement.setString(2, description);
            callableStatement.setString(3, hsndate);
            callableStatement.setString(4, session.getAttribute("USERID").toString());
            callableStatement.setString(5, session.getAttribute("BRANCHID").toString());
            callableStatement.setString(7, mode);
            callableStatement.setString(8, formdetailcode);
            callableStatement.executeQuery();
            aaa = callableStatement.getInt("docno");
            if (aaa > 0) {

                conn.commit();
                stmt.close();
                callableStatement.close();
                conn.close();
                return aaa;
            }
            stmt.close();
            callableStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return 0;
    }

    public boolean deletehsncode(String description, String hscode, String hsndate, int docno, String mode,
            HttpSession session, String formdetailcode) throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {
            int aaa;
            conn.setAutoCommit(false);
            Statement stmt = conn.createStatement();
            String sql = "select hs_code from my_hsncode where status<>7 and hs_code='" + hscode + "' and doc_no<>"
                    + docno + "";
            System.out.println("VERIFICATION OF SQL QUERY OF HSNCODE=======>" + sql);
            ResultSet resultSet = stmt.executeQuery(sql);
            if (resultSet.next()) {
                stmt.close();
                conn.close();
                return false;
            }
            CallableStatement callableStatement = conn.prepareCall("{call hsncodeDML(?,?,?,?,?,?,?,?)}");
            callableStatement.setInt(6, docno);
            callableStatement.setString(1, hscode);
            callableStatement.setString(2, description);
            callableStatement.setString(3, hsndate);
            callableStatement.setString(4, session.getAttribute("USERID").toString());
            callableStatement.setString(5, session.getAttribute("BRANCHID").toString());
            callableStatement.setString(7, mode);
            callableStatement.setString(8, formdetailcode);
            callableStatement.executeQuery();
            System.out.println("EXECUTED THE DELETE QUERY");
            aaa = callableStatement.getInt("docno");
            System.out.println("This is the DOCNO OF DELETED HSNO    " + aaa);
            if (aaa > 0) {

                conn.commit();
                stmt.close();
                callableStatement.close();
                conn.close();
                return true;
            }
            stmt.close();
            callableStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return false;
    }

    public int edithsncode(String hscode, String description, int docno, String hsndate, String mode,
            HttpSession session,
            String formdetailcode) throws SQLException {
        Connection conn = ClsConnection.getMyConnection();
        try {
            int aaa;
            conn.setAutoCommit(false);
            Statement stmt = conn.createStatement();
            String sql = "select hs_code from my_hsncode where status<>7 and hs_code='" + hscode + "' and doc_no<>"
                    + docno + "";
            System.out.println("VERIFICATION OF SQL QUERY OF HSNCODE=======>" + sql);
            ResultSet resultSet = stmt.executeQuery(sql);
            if (resultSet.next()) {
                stmt.close();
                conn.close();
                return -1;
            }
            CallableStatement callableStatement = conn.prepareCall("{call hsncodeDML(?,?,?,?,?,?,?,?)}");
            callableStatement.setInt(6, docno);
            callableStatement.setString(1, hscode);
            callableStatement.setString(2, description);
            callableStatement.setString(3, hsndate);
            callableStatement.setString(4, session.getAttribute("USERID").toString());
            callableStatement.setString(5, session.getAttribute("BRANCHID").toString());
            callableStatement.setString(7, mode);
            callableStatement.setString(8, formdetailcode);
            callableStatement.executeQuery();
            System.out.println("EXECUTED THE UPDATE QUERY");
            aaa = callableStatement.getInt("docno");
            System.out.println("This is the DOCNO OF UPDATED HSNO    " + aaa);
            if (aaa > 0) {

                conn.commit();
                stmt.close();
                callableStatement.close();
                conn.close();
                return aaa;
            }
            stmt.close();
            callableStatement.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
        return 0;
    }

    public JSONArray hsncodesearch(HttpSession session) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();

        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String sql = "select doc_no, hs_code from my_hsncode where status<>7";
            ResultSet resultSet = stmt.executeQuery(sql);
            System.out.println("SQL CODE EXECUTED------------------"+sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
            }catch(Exception e){
            e.printStackTrace();
            }finally{
                conn.close();
            }
            return RESULTDATA;
        }
     
}
