package com.project.execution.quotationmbl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.asprise.imaging.core.Request;
import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsQuotationDAO {

    ClsCommon com = new ClsCommon();
    ClsConnection conobj = new ClsConnection();
    ClsQuotationBean bean = new ClsQuotationBean();

    public JSONArray searchClient(HttpSession session, String clname, String mob, int id) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA;
        }

        String brid = session.getAttribute("BRANCHID").toString();

        String sqltest = "";

        if (!(clname.equalsIgnoreCase("undefined")) && !(clname.equalsIgnoreCase(""))
                && !(clname.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and refname like '%" + clname + "%'";
        }
        if (!(mob.equalsIgnoreCase("undefined")) && !(mob.equalsIgnoreCase("")) && !(mob.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and per_mob like '%" + mob + "%'";
        }

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmtVeh1 = conn.createStatement();

            if (id > 0) {
                String clsql = ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,sal_name as salname,sm.doc_no as salid"
                        + " from my_acbook ac left join my_salm sm on(ac.sal_id=sm.doc_no) where  dtype='CRM' and ac.status=3 "
                        + sqltest);

                ResultSet resultSet = stmtVeh1.executeQuery(clsql);

                RESULTDATA = com.convertToJSON(resultSet);
                stmtVeh1.close();
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }
        ////// System.out.println(RESULTDATA);
        return RESULTDATA;
    }

    public JSONArray scopeSearch(HttpSession session) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select doc_no,scode,sname from my_scope where status=3";

            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray unitSearch(HttpSession session) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select doc_no,unit,unit_desc from my_unitm where status=3";

            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray subServiceType(HttpSession session, int id) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

			/*
			 * String sql = "select doc_no,srvid,name from my_subsrvtype where srvid=" +
			 * srvid + " and status=3";
			 */
            String sql = "select doc_no,srvid,name from my_subsrvtype where srvid=" +id + " and status=3";
           //System.out.println("Sub service sql : "+sql);
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray contactpersonSearch(HttpSession session, int clientid) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA;
        }

        String brcid = session.getAttribute("BRANCHID").toString();

        Connection conn = null;
        Statement stmt = null;
        try {
            conn = conobj.getMyConnection();
            stmt = conn.createStatement();
            String sql = ("select cperson,concat('MOB',':',mob,';','Email',':',email,';','Tele',':',tel) contactdet,row_no as cprowno from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="
                    + clientid + " and a.doc_no=" + clientid + "");
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            stmt.close();
            conn.close();
        }

        return RESULTDATA;

    }

    public JSONArray areaSearch(HttpSession session) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";

            sql = "select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";


            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray assignfrm(HttpSession session) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";

            sql = "select grpcode,doc_no  from cm_serteamm where status=3";


            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray assignteam(HttpSession session, int assignid) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";

            sql = "select s.doc_no,s.rdocno,name,grpcode,s.empid from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) "
                    + "left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no=" + assignid + "";


            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray serviceType(HttpSession session) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";

            sql = "select groupname stype,codeno,doc_no docno from my_groupvals where grptype='service' and status=3";


            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray serviceSite(HttpSession session) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";

            sql = "select groupname site,codeno,doc_no docno from my_groupvals where grptype='site' and status=3";


            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray siteGridLoad(HttpSession session, String doc_no) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";
            String brhid = session.getAttribute("BRANCHID").toString();

            sql = "select  groupname area,g.doc_no areaid,site,d.rowno  from  cm_servsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
                    + " where tr_no='" + doc_no + "'";


            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray amcGridLoad(HttpSession session, String doc_no) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";
            String brhid = session.getAttribute("BRANCHID").toString();

            sql = "select amc.description desc1,amc.area area,u.unit unit,u.doc_no unitid,amc.rowno rowno from cm_srvqotdamc amc left join my_unitm u on amc.unitid=u.doc_no where amc.rdocno='"
                    + doc_no + "'";


            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray siteRefGridLoad(HttpSession session, String doc_no, int surveyed) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";
            String brhid = session.getAttribute("BRANCHID").toString();
            if (surveyed > 0) {
                sql = "select  groupname area,g.doc_no areaid,site from  cm_surveysid  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
                        + "left join cm_surveym m on(m.doc_no=d.rdocno) left join gl_enqm em on(em.doc_no=m.refdocno)"
                        + " where em.doc_no='" + doc_no + "' order by d.sr_no";
            } else {
                sql = "select  groupname area,g.doc_no areaid,site from  gl_enqsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
                        + " left join gl_enqm em on(em.doc_no=d.rdocno)"
                        + " where em.doc_no='" + doc_no + "' order by d.sr_no";
            }


            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray serviceGridLoad(HttpSession session, String doc_no, String reviseno) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";
            String brhid = session.getAttribute("BRANCHID").toString();

			 
            sql = "select d.rowno, d.discount, d.disper, site,s.sr_no siteid,groupname stype,g.doc_no stypeid, d.description desc1, Equips item, qty, d.Amount, total,u.unit as unit,unitid,d.revision_no,"
                    + "d.psrno,Equips as prdname,d.scopeid,d.scopeamount,d.stdprice,d.lbrchg,d.scopestdcost,sp.scode scope,subser.name subservname,subser.srvid subservid from "
                    + "cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') left join cm_servsited s on(s.rowno=d.sitesrno) "
                    + "left join my_unitm u on(u.doc_no=d.unitid) left join my_scope sp on sp.doc_no=d.scopeid left join my_subsrvtype subser on subser.doc_no=d.subservtypeid where d.tr_no='"
                    + doc_no + "' and d.revision_no='" + reviseno + "' ORDER BY D.SR_NO";
            
            //System.out.println("===enquiryLoad===2===="+sql);

            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray termsSearch(HttpSession session, String dtype) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select doc_no,voc_no,dtype,termsheader as header from my_termsm where dtype='" + dtype + "'";

            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);
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

    public JSONArray condtnSearch(HttpSession session, String dtype, String tdocno) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select doc_no, rdocno, termsfooter from my_termsd where  dtype='" + dtype + "' and rdocno="
                    + tdocno + "";


            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);
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

    public JSONArray termsGridLoad(HttpSession session, String dtype) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select m.doc_no,m.voc_no,m.dtype,termsheader terms,termsfooter conditions from MY_termsm m  inner join my_termsd d on(m.voc_no=d.rdocno) where d.status=3 and m.mand=1 and d.dtype='"
                    + dtype + "' order by m.doc_no";
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray termsGridReLoad(HttpSession session, String dtype, String qotdoc) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no) where  tr.dtype='"
                    + dtype + "' and tr.rdocno=" + qotdoc + " order by terms";
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }

    public JSONArray enquirySrearch(HttpSession session, String msdocno, String Cl_names, String Cl_mobno,
            String enqdate, String clientid, int id, String cntype, String reftype) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA;
        }

        String brcid = session.getAttribute("BRANCHID").toString();

        String sqltest = "";
        java.sql.Date sqlStartDate = null;
        String str1Sql = "";
        if (reftype.equalsIgnoreCase("ENQ")) {
            if (!(enqdate.equalsIgnoreCase("undefined")) && !(enqdate.equalsIgnoreCase(""))
                    && !(enqdate.equalsIgnoreCase("0"))) {
                sqlStartDate = com.changeStringtoSqlDate(enqdate);
                sqltest = sqltest + " and m.date<=" + sqlStartDate + "";
            }
            if (!(msdocno.equalsIgnoreCase("undefined")) && !(msdocno.equalsIgnoreCase(""))
                    && !(msdocno.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and m.voc_no like '%" + msdocno + "%'";
            }
            if (!(Cl_names.equalsIgnoreCase("undefined")) && !(Cl_names.equalsIgnoreCase(""))
                    && !(Cl_names.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and ac.refname like '%" + Cl_names + "%'";
            }
            if (!(Cl_mobno.equalsIgnoreCase("undefined")) && !(Cl_mobno.equalsIgnoreCase(""))
                    && !(Cl_mobno.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and ac.com_mob like '%" + Cl_mobno + "%'";
            }
            if (!(clientid.equalsIgnoreCase("undefined")) && !(clientid.equalsIgnoreCase(""))
                    && !(clientid.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and ac.cldocno=" + clientid + "";
            }
            if (!(cntype.equalsIgnoreCase("undefined")) && !(cntype.equalsIgnoreCase(""))
                    && !(cntype.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and m.contrmode='" + cntype + "'";
            }
        } else {
            if (!(enqdate.equalsIgnoreCase("undefined")) && !(enqdate.equalsIgnoreCase(""))
                    && !(enqdate.equalsIgnoreCase("0"))) {
                sqlStartDate = com.changeStringtoSqlDate(enqdate);
                sqltest = sqltest + " and sm.date<=" + sqlStartDate + "";
            }
            if (!(msdocno.equalsIgnoreCase("undefined")) && !(msdocno.equalsIgnoreCase(""))
                    && !(msdocno.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and sm.doc_no like '%" + msdocno + "%'";
            }
            if (!(Cl_names.equalsIgnoreCase("undefined")) && !(Cl_names.equalsIgnoreCase(""))
                    && !(Cl_names.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and ac.refname like '%" + Cl_names + "%'";
            }
            if (!(Cl_mobno.equalsIgnoreCase("undefined")) && !(Cl_mobno.equalsIgnoreCase(""))
                    && !(Cl_mobno.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and ac.com_mob like '%" + Cl_mobno + "%'";
            }
            if (!(clientid.equalsIgnoreCase("undefined")) && !(clientid.equalsIgnoreCase(""))
                    && !(clientid.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and ac.cldocno=" + clientid + "";
            }
            if (!(cntype.equalsIgnoreCase("undefined")) && !(cntype.equalsIgnoreCase(""))
                    && !(cntype.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and sm.ref_type='" + cntype + "'";
            }
        }

        Connection conn = null;
        Statement stmt = null;
        try {
            conn = conobj.getMyConnection();
            stmt = conn.createStatement();

            if (id > 0) {
                if (reftype.equalsIgnoreCase("ENQ")) {
                    str1Sql = ("select m.date,m.doc_no,m.voc_no, if(m.cldocno>0,ac.refname,m.name) as name,coalesce(ac.doc_no,0) as clientid, "
                            + "if(m.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),com_add1) as details, "
                            + "if(m.cpersonid>0,c.cperson,coalesce(m.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid, "
                            + "if(m.cpersonid>0,c.mob,coalesce(m.mob,'')) as contmob,m.esttrno,if(m.surveyed=1,'1','2') surveyed,surtrno,concat('MOB',':',c.mob,';','Email',':',c.email,';','Tele',':',c.tel) contactdet from gl_enqm m left join my_acbook ac "
                            + "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) where 1=1 and m.status=3 and qottrno=0 and m.brhid="
                            + brcid + " " + sqltest + "");
                } else {
                    str1Sql = "select sm.date,sm.tr_no doc_no,sm.doc_no voc_no,ac.refname name,coalesce(ac.doc_no,0) as clientid,"
                            + " concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ) as details from cm_srvdetm sm "
                            + "left join my_acbook ac on ac.cldocno=sm.cldocno and ac.dtype='CRM'"
                            + "left join (select refdocno,cldocno from cm_srvqotm where ref_type='SRVE') qtm on 1=1  "
                            + " where sm.chkrect=1 and qtm.refdocno!=sm.tr_no and sm.brhid=" + brcid + "  " + sqltest
                            + " group by sm.tr_no";
                }
              // System.out.println("str1Sql--"+str1Sql);
                ResultSet resultSet = stmt.executeQuery(str1Sql);
                RESULTDATA = com.convertToJSON(resultSet);
                stmt.close();
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            stmt.close();
            conn.close();
        }
        return RESULTDATA;
    }

    public int insert(java.sql.Date date, String txtrefno, int clientid, int cpersonid, String reftype, int enquiryid,
            String chkRdo, String dcdamount, String txtsubject, String txtdesc1,
            String clientref, String txtgrtotal, String txtdisper, String txtdisamt, String txttotalamt,
            String txttaxper, String txttaxamt, String txtnettotal, String txtsignedby, String formcode,
            String mode, ArrayList servlist, ArrayList sitelist, ArrayList termslist, HttpSession session,
            HttpServletRequest request, int salid, int cmbprocess, int txtrevise, int chklegal,
            String txtthresholdlimit, String txtpartlimitperc, String txtadditionalamt, String notes, ArrayList amclist,
            String discounttick) throws SQLException {

        Connection conn = null;
        int docno = 0;
        conn = conobj.getMyConnection();

        try {
            conn.setAutoCommit(false);

            CallableStatement stmt = conn.prepareCall(
                    "{CALL sr_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

            stmt.registerOutParameter(25, java.sql.Types.INTEGER);
            stmt.registerOutParameter(26, java.sql.Types.INTEGER);
            stmt.registerOutParameter(28, java.sql.Types.INTEGER);
            stmt.setDate(1, date);
            stmt.setString(2, txtrefno);
            stmt.setInt(3, clientid);
            stmt.setInt(4, cpersonid);
            stmt.setString(5, reftype);
            stmt.setInt(6, enquiryid);
            stmt.setString(7, chkRdo);
            stmt.setDouble(8, dcdamount == "" || dcdamount == null || dcdamount.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(dcdamount));
            stmt.setString(9, txtsubject);
            stmt.setString(10, txtdesc1);
            stmt.setString(11, clientref);
            stmt.setDouble(12, Double.parseDouble(txtgrtotal));
            stmt.setDouble(13, txtdisper == "" || txtdisper == null || txtdisper.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(txtdisper));
            stmt.setDouble(14, txtdisamt == "" || txtdisamt == null || txtdisamt.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(txtdisamt));
            stmt.setDouble(15, Double.parseDouble(txttotalamt));
            stmt.setDouble(16, Double.parseDouble(txttaxper));
            stmt.setDouble(17, Double.parseDouble(txttaxamt));
            stmt.setDouble(18, Double.parseDouble(txtnettotal));
            stmt.setString(19, mode);
            stmt.setString(20, formcode);
            stmt.setString(21, session.getAttribute("USERID").toString());
            stmt.setString(22, session.getAttribute("BRANCHID").toString());
            stmt.setString(23, session.getAttribute("COMPANYID").toString());
            stmt.setInt(24, salid);
            stmt.setInt(27, cmbprocess);
            stmt.setInt(29, chklegal);
            stmt.setString(30, txtthresholdlimit == null || txtthresholdlimit.trim().equalsIgnoreCase("") ? "0"
                    : txtthresholdlimit);
            stmt.setString(31,
                    txtpartlimitperc == null || txtpartlimitperc.trim().equalsIgnoreCase("") ? "0" : txtpartlimitperc);
            stmt.setString(32, txtsignedby);
            stmt.setDouble(33, txtadditionalamt == null || txtadditionalamt.equals("") ? 0.0
                    : Double.parseDouble(txtadditionalamt));
            stmt.setString(34, notes);
            stmt.setString(35, discounttick == null || discounttick.trim().equalsIgnoreCase("") ? "0" : discounttick);
            int val = stmt.executeUpdate();
            docno = stmt.getInt("docno");
            int vocno = stmt.getInt("vocno");
            request.setAttribute("vocno", vocno);
            txtrevise = stmt.getInt("revision");
            request.setAttribute("revision", txtrevise);

            if (docno > 0) {
                for (int i = 0; i < sitelist.size(); i++) {
                    String[] surveydet = ((String) sitelist.get(i)).split("::");
                    if (!(surveydet[0].trim().equalsIgnoreCase("undefined")
                            || surveydet[0].trim().equalsIgnoreCase("NaN") || surveydet[0].trim().equalsIgnoreCase("")
                            || surveydet[0].isEmpty())) {
                        String sql1 = "";
                        int refrowno = 0;
                        sql1 = "select coalesce(max(rowno)+1,1) as refrowno from cm_servsited";
                        ResultSet resultSet1 = stmt.executeQuery(sql1);
                        while (resultSet1.next()) {
                            refrowno = resultSet1.getInt("refrowno");
                        }

                        String sql = "INSERT INTO cm_servsited(sr_no, refrowno, site, areaId, amount, dtype, tr_no)VALUES"
                                + " (" + (i + 1) + ","
                                + "" + refrowno + ","
                                + "'"
                                + (surveydet[0].trim().equalsIgnoreCase("undefined")
                                        || surveydet[0].trim().equalsIgnoreCase("NaN")
                                        || surveydet[0].trim().equalsIgnoreCase("") || surveydet[0].isEmpty() ? 0
                                                : surveydet[0].trim())
                                + "',"
                                + "'"
                                + (surveydet[1].trim().equalsIgnoreCase("undefined")
                                        || surveydet[1].trim().equalsIgnoreCase("NaN")
                                        || surveydet[1].trim().equalsIgnoreCase("") || surveydet[1].isEmpty() ? 0
                                                : surveydet[1].trim())
                                + "',"
                                + "'"
                                + (surveydet[2].trim().equalsIgnoreCase("undefined")
                                        || surveydet[2].trim().equalsIgnoreCase("NaN")
                                        || surveydet[2].trim().equalsIgnoreCase("") || surveydet[2].isEmpty() ? 0
                                                : surveydet[2].trim())
                                + "',"
                                + " '" + formcode + "',"
                                + "'" + docno + "')";
                        int resultSet2 = stmt.executeUpdate(sql);
                        if (resultSet2 <= 0) {
                            conn.close();
                            return 0;
                        }
                    }
                }

                String sql1 = "";
                for (int i = 0; i < servlist.size(); i++) {
                    String[] surveydet = ((String) servlist.get(i)).split("::");
                    if ((!((surveydet[0].trim().equalsIgnoreCase("undefined")
                            || surveydet[0].trim().equalsIgnoreCase("NaN") || surveydet[0].trim().equalsIgnoreCase("")
                            || surveydet[0].isEmpty()))
                            || (!((surveydet[1].trim().equalsIgnoreCase("undefined")
                                    || surveydet[1].trim().equalsIgnoreCase("NaN")
                                    || surveydet[1].trim().equalsIgnoreCase("") || surveydet[1].isEmpty()))))) {
                        // System.out.println("Array of sub serv :
                        // "+(surveydet[9].trim().equalsIgnoreCase("undefined") ||
                        // surveydet[9].trim().equalsIgnoreCase("NaN")||
                        // surveydet[9].trim().equalsIgnoreCase("")||
                        // surveydet[9].isEmpty()?0:surveydet[9].trim()));
                        String sql = "INSERT INTO cm_srvqotd(sr_no, description, servid, unitid, qty, amount, discount, disper, total, revision_no, tr_no,subservtypeid) VALUES"
                                + " (" + (i + 1) + ","
                                + "'"
                                + (surveydet[0].trim().equalsIgnoreCase("undefined")
                                        || surveydet[0].trim().equalsIgnoreCase("NaN")
                                        || surveydet[0].trim().equalsIgnoreCase("") || surveydet[0].isEmpty() ? ""
                                                : surveydet[0].trim())
                                + "',"
                                + "'"
                                + (surveydet[1].trim().equalsIgnoreCase("undefined")
                                        || surveydet[1].trim().equalsIgnoreCase("NaN")
                                        || surveydet[1].trim().equalsIgnoreCase("") || surveydet[1].isEmpty() ? 0
                                                : surveydet[1].trim())
                                + "',"
                                + "'"
                                + (surveydet[2].trim().equalsIgnoreCase("undefined")
                                        || surveydet[2].trim().equalsIgnoreCase("NaN")
                                        || surveydet[2].trim().equalsIgnoreCase("") || surveydet[2].isEmpty() ? 0
                                                : surveydet[2].trim())
                                + "',"
                                + "'"
                                + (surveydet[3].trim().equalsIgnoreCase("undefined")
                                        || surveydet[3].trim().equalsIgnoreCase("NaN")
                                        || surveydet[3].trim().equalsIgnoreCase("") || surveydet[3].isEmpty() ? 0
                                                : surveydet[3].trim())
                                + "',"
                                + "'"
                                + (surveydet[4].trim().equalsIgnoreCase("undefined")
                                        || surveydet[4].trim().equalsIgnoreCase("NaN")
                                        || surveydet[4].trim().equalsIgnoreCase("") || surveydet[4].isEmpty() ? 0
                                                : surveydet[4].trim())
                                + "',"
                                + "'"
                                + (surveydet[5].trim().equalsIgnoreCase("undefined")
                                        || surveydet[5].trim().equalsIgnoreCase("NaN")
                                        || surveydet[5].trim().equalsIgnoreCase("") || surveydet[5].isEmpty() ? 0
                                                : surveydet[5].trim())
                                + "',"
                                + "'"
                                + (surveydet[6].trim().equalsIgnoreCase("undefined")
                                        || surveydet[6].trim().equalsIgnoreCase("NaN")
                                        || surveydet[6].trim().equalsIgnoreCase("") || surveydet[6].isEmpty() ? 0
                                                : surveydet[6].trim())
                                + "',"
                                + "'"
                                + (surveydet[7].trim().equalsIgnoreCase("undefined")
                                        || surveydet[7].trim().equalsIgnoreCase("NaN")
                                        || surveydet[7].trim().equalsIgnoreCase("") || surveydet[7].isEmpty() ? 0
                                                : surveydet[7].trim())
                                + "',"
                                + "'"
                                + (surveydet[8].trim().equalsIgnoreCase("undefined")
                                        || surveydet[8].trim().equalsIgnoreCase("NaN")
                                        || surveydet[8].trim().equalsIgnoreCase("") || surveydet[8].isEmpty() ? 0
                                                : surveydet[8].trim())
                                + "',"
                                + "'" + docno + "','"
                                + (surveydet[10].trim().equalsIgnoreCase("undefined")
                                        || surveydet[10].trim().equalsIgnoreCase("NaN")
                                        || surveydet[10].trim().equalsIgnoreCase("") || surveydet[10].isEmpty() ? 0
                                                : surveydet[10].trim())
                                + "')";
                        //// System.out.println("====sql====="+sql);
                        int resultSet2 = stmt.executeUpdate(sql);
                        if (resultSet2 <= 0) {
                            conn.close();
                            return 0;
                        }
                    }
                }

                for (int i = 0; i < termslist.size(); i++) {
                    String[] terms = ((String) termslist.get(i)).split("::");
                    if (!((terms[0].equalsIgnoreCase("0")) || (terms[0].equalsIgnoreCase("undefined")))) {
                        String termsql = "insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
                                + " ('" + docno + "',"
                                + "'"
                                + (terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("")
                                        || terms[0].trim().equalsIgnoreCase("NaN") || terms[0].isEmpty() ? 0
                                                : terms[0].trim())
                                + "',"
                                + "'"
                                + (terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("")
                                        || terms[3].trim().equalsIgnoreCase("NaN") || terms[3].isEmpty() ? 0
                                                : terms[3].trim())
                                + "',"
                                + "'3',"
                                + "'" + formcode + "')";
                        // //System.out.println("termsdet--->>>>Sql"+termsql);
                        int resultSet3 = stmt.executeUpdate(termsql);

                        if (resultSet3 <= 0) {
                            conn.close();
                            return 0;
                        }
                    }
                }
                for (int i = 0; i < amclist.size(); i++) {
                    String[] amc = ((String) amclist.get(i)).split("::");
                    if (!((amc[0].equalsIgnoreCase("0")) || (amc[0].equalsIgnoreCase("undefined")))) {
                        String termsql = "insert into cm_srvqotdamc(rdocno,description, area, unit, unitid)VALUES"
                                + " ('" + docno + "',"
                                + "'"
                                + (amc[0].equalsIgnoreCase("undefined") || amc[0].equalsIgnoreCase("")
                                        || amc[0].trim().equalsIgnoreCase("NaN") || amc[0].isEmpty() ? 0
                                                : amc[0].trim())
                                + "',"
                                + "'"
                                + (amc[1].equalsIgnoreCase("undefined") || amc[1].equalsIgnoreCase("")
                                        || amc[1].trim().equalsIgnoreCase("NaN") || amc[1].isEmpty() ? 0
                                                : amc[1].trim())
                                + "',"
                                + "'"
                                + (amc[2].equalsIgnoreCase("undefined") || amc[2].equalsIgnoreCase("")
                                        || amc[2].trim().equalsIgnoreCase("NaN") || amc[2].isEmpty() ? 0
                                                : amc[2].trim())
                                + "',"
                                + "'"
                                + (amc[3].equalsIgnoreCase("undefined") || amc[3].equalsIgnoreCase("")
                                        || amc[3].trim().equalsIgnoreCase("NaN") || amc[3].isEmpty() ? 0
                                                : amc[3].trim())
                                + "')";
                        // //System.out.println("termsdet--->>>>Sql"+termsql);
                        int resultSet4 = stmt.executeUpdate(termsql);

                        if (resultSet4 <= 0) {
                            conn.close();
                            return 0;
                        }
                    }
                }
            }
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }
        return docno;
    }

    public int edit(int docno, int vocno, java.sql.Date date, String txtrefno, int clientid, int cpersonid,
            String reftype, int enquiryid, String chkRdo, String dcdamount, String txtsubject, String txtdesc1,
            String clientref, String txtgrtotal, String txtdisper, String txtdisamt, String txttotalamt,
            String txttaxper, String txttaxamt, String txtnettotal, String txtsignedby, String formcode,
            String mode, ArrayList servlist, ArrayList sitelist, ArrayList termslist, HttpSession session,
            HttpServletRequest request, int salid, int cmbprocess, int txtrevise,
            int chklegal, String txtthresholdlimit, String txtpartlimitperc, String txtadditionalamt, String notes,
            ArrayList amclist, String discounttick) throws SQLException {

        Connection conn = null;

        conn = conobj.getMyConnection();

        try {
////System.out.println("---------------------------------------------------");
            conn.setAutoCommit(false);

            CallableStatement stmt = conn.prepareCall(
                    "{CALL sr_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

            stmt.setDate(1, date);
            stmt.setString(2, txtrefno);
            stmt.setInt(3, clientid);
            stmt.setInt(4, cpersonid);
            stmt.setString(5, reftype);
            stmt.setInt(6, enquiryid);
            stmt.setString(7, chkRdo);
            stmt.setDouble(8, dcdamount == "" || dcdamount == null || dcdamount.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(dcdamount));
            stmt.setString(9, txtsubject);
            stmt.setString(10, txtdesc1);
            stmt.setString(11, clientref);
            stmt.setDouble(12, Double.parseDouble(txtgrtotal));
            stmt.setDouble(13, txtdisper == "" || txtdisper == null || txtdisper.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(txtdisper));
            stmt.setDouble(14, txtdisamt == "" || txtdisamt == null || txtdisamt.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(txtdisamt));
            stmt.setDouble(15, Double.parseDouble(txttotalamt));
            stmt.setDouble(16, Double.parseDouble(txttaxper));
            stmt.setDouble(17, Double.parseDouble(txttaxamt));
            stmt.setDouble(18, Double.parseDouble(txtnettotal));
            stmt.setString(19, mode);
            stmt.setString(20, formcode);
            stmt.setString(21, session.getAttribute("USERID").toString());
            stmt.setString(22, session.getAttribute("BRANCHID").toString());
            stmt.setString(23, session.getAttribute("COMPANYID").toString());
            stmt.setInt(24, salid);
            stmt.setInt(25, docno);
            stmt.setInt(26, vocno);
            stmt.setInt(27, cmbprocess);
            stmt.setInt(28, txtrevise);
            stmt.setInt(29, chklegal);
            stmt.setString(30, txtthresholdlimit == null || txtthresholdlimit.trim().equalsIgnoreCase("") ? "0"
                    : txtthresholdlimit);
            stmt.setString(31,
                    txtpartlimitperc == null || txtpartlimitperc.trim().equalsIgnoreCase("") ? "0" : txtpartlimitperc);
            stmt.setString(32, txtsignedby);
            stmt.setDouble(33, txtadditionalamt == null || txtadditionalamt.equals("") ? 0.0
                    : Double.parseDouble(txtadditionalamt));
            stmt.setString(34, notes);
			/* stmt.setString(35, discounttick); */
            stmt.setString(35, discounttick == null || discounttick.trim().equalsIgnoreCase("") ? "0" : discounttick);
            //// System.out.println("========= "+stmt);
            int val = stmt.executeUpdate();
            docno = stmt.getInt("docno");
            vocno = stmt.getInt("vocno");
            request.setAttribute("vocno", vocno);
            txtrevise = stmt.getInt("revision");
            request.setAttribute("revision", txtrevise);
            if (docno > 0) {
////System.out.println("====docno=="+docno);
                for (int i = 0; i < sitelist.size(); i++) {
//					//System.out.println("====iii=="+i);
                    String[] surveydet = ((String) sitelist.get(i)).split("::");

                    if (!(surveydet[0].trim().equalsIgnoreCase("undefined")
                            || surveydet[0].trim().equalsIgnoreCase("NaN") || surveydet[0].trim().equalsIgnoreCase("")
                            || surveydet[0].isEmpty())) {
                        int refrowno = 0;
                        String sql = "";
                        refrowno = (surveydet[2].trim().equalsIgnoreCase("undefined")
                                || surveydet[2].trim().equalsIgnoreCase("NaN")
                                || surveydet[2].trim().equalsIgnoreCase("") || surveydet[2].isEmpty() ? 0
                                        : Integer.parseInt(surveydet[2].trim()));
                        if (refrowno > 0) {
                            sql = "UPDATE cm_servsited SET sr_no=" + (i + 1) + ", refrowno=" + refrowno + ", site='"
                                    + (surveydet[0].trim().equalsIgnoreCase("undefined")
                                            || surveydet[0].trim().equalsIgnoreCase("NaN")
                                            || surveydet[0].trim().equalsIgnoreCase("") || surveydet[0].isEmpty() ? 0
                                                    : surveydet[0].trim())
                                    + "', "
                                    + "areaId='"
                                    + (surveydet[1].trim().equalsIgnoreCase("undefined")
                                            || surveydet[1].trim().equalsIgnoreCase("NaN")
                                            || surveydet[1].trim().equalsIgnoreCase("") || surveydet[1].isEmpty() ? 0
                                                    : surveydet[1].trim())
                                    + "', "
                                    + "dtype='" + formcode + "' WHERE tr_no='" + docno + "' and rowno='" + refrowno
                                    + "'";
                        } else {
                            sql = "INSERT INTO cm_servsited(sr_no, refrowno, site, areaId, dtype, tr_no)VALUES"
                                    + " (" + (i + 1) + ","
                                    + "" + refrowno + ","
                                    + "'"
                                    + (surveydet[0].trim().equalsIgnoreCase("undefined")
                                            || surveydet[0].trim().equalsIgnoreCase("NaN")
                                            || surveydet[0].trim().equalsIgnoreCase("") || surveydet[0].isEmpty() ? 0
                                                    : surveydet[0].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[1].trim().equalsIgnoreCase("undefined")
                                            || surveydet[1].trim().equalsIgnoreCase("NaN")
                                            || surveydet[1].trim().equalsIgnoreCase("") || surveydet[1].isEmpty() ? 0
                                                    : surveydet[1].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[2].trim().equalsIgnoreCase("undefined")
                                            || surveydet[2].trim().equalsIgnoreCase("NaN")
                                            || surveydet[2].trim().equalsIgnoreCase("") || surveydet[2].isEmpty() ? 0
                                                    : surveydet[2].trim())
                                    + "',"
                                    + " '" + formcode + "',"
                                    + "'" + docno + "')";
                        }

                        //// System.out.println("==sitelist==="+sql);
                        int resultSet2 = stmt.executeUpdate(sql);
                        if (resultSet2 <= 0) {
                            conn.close();
                            return 0;
                        }
                        // conn.commit();

                    }

                }

                String sql1 = "";
                int siteid = 0;
                //// System.out.println("=====IN==== ");
                for (int i = 0; i < servlist.size(); i++) {

                    String[] surveydet = ((String) servlist.get(i)).split("::");
                    if ((!((surveydet[0].trim().equalsIgnoreCase("undefined")
                            || surveydet[0].trim().equalsIgnoreCase("NaN") || surveydet[0].trim().equalsIgnoreCase("")
                            || surveydet[0].isEmpty()))
                            || (!((surveydet[1].trim().equalsIgnoreCase("undefined")
                                    || surveydet[1].trim().equalsIgnoreCase("NaN")
                                    || surveydet[1].trim().equalsIgnoreCase("") || surveydet[1].isEmpty()))))) {

                        /*
                         * sql1="select rowno from cm_servsited where tr_no="+docno+" and sr_no="+siteid
                         * +"";
                         * ResultSet resultSet1 = stmt.executeQuery(sql1);
                         * while(resultSet1.next()){
                         * siteid=resultSet1.getInt("rowno");
                         * }
                         */
                        String sql = "";
                        int refrowno = 0;

                        refrowno = (surveydet[9].trim().equalsIgnoreCase("undefined")
                                || surveydet[9].trim().equalsIgnoreCase("NaN")
                                || surveydet[9].trim().equalsIgnoreCase("") || surveydet[9].isEmpty() ? 0
                                        : Integer.parseInt(surveydet[9].trim()));
                        if (refrowno > 0) {
                            sql = "UPDATE cm_srvqotd SET sr_no=" + (i + 1) + ", description='"
                                    + (surveydet[0].trim().equalsIgnoreCase("undefined")
                                            || surveydet[0].trim().equalsIgnoreCase("NaN")
                                            || surveydet[0].trim().equalsIgnoreCase("") || surveydet[0].isEmpty() ? ""
                                                    : surveydet[0].trim())
                                    + "',"
                                    + " servid='"
                                    + (surveydet[1].trim().equalsIgnoreCase("undefined")
                                            || surveydet[1].trim().equalsIgnoreCase("NaN")
                                            || surveydet[1].trim().equalsIgnoreCase("") || surveydet[1].isEmpty() ? 0
                                                    : surveydet[1].trim())
                                    + "', "
                                    + "unitid='"
                                    + (surveydet[2].trim().equalsIgnoreCase("undefined")
                                            || surveydet[2].trim().equalsIgnoreCase("NaN")
                                            || surveydet[2].trim().equalsIgnoreCase("") || surveydet[2].isEmpty() ? 0
                                                    : surveydet[2].trim())
                                    + "',"
                                    + " qty='"
                                    + (surveydet[3].trim().equalsIgnoreCase("undefined")
                                            || surveydet[3].trim().equalsIgnoreCase("NaN")
                                            || surveydet[3].trim().equalsIgnoreCase("") || surveydet[3].isEmpty() ? 0
                                                    : surveydet[3].trim())
                                    + "',"
                                    + " amount='"
                                    + (surveydet[4].trim().equalsIgnoreCase("undefined")
                                            || surveydet[4].trim().equalsIgnoreCase("NaN")
                                            || surveydet[4].trim().equalsIgnoreCase("") || surveydet[4].isEmpty() ? 0
                                                    : surveydet[4].trim())
                                    + "',"
                                    + " discount='"
                                    + (surveydet[5].trim().equalsIgnoreCase("undefined")
                                            || surveydet[5].trim().equalsIgnoreCase("NaN")
                                            || surveydet[5].trim().equalsIgnoreCase("") || surveydet[5].isEmpty() ? 0
                                                    : surveydet[5].trim())
                                    + "',"
                                    + " disper='"
                                    + (surveydet[6].trim().equalsIgnoreCase("undefined")
                                            || surveydet[6].trim().equalsIgnoreCase("NaN")
                                            || surveydet[6].trim().equalsIgnoreCase("") || surveydet[6].isEmpty() ? 0
                                                    : surveydet[6].trim())
                                    + "',"
                                    + " total='"
                                    + (surveydet[7].trim().equalsIgnoreCase("undefined")
                                            || surveydet[7].trim().equalsIgnoreCase("NaN")
                                            || surveydet[7].trim().equalsIgnoreCase("") || surveydet[7].isEmpty() ? 0
                                                    : surveydet[7].trim())
                                    + "',"
                                    + " revision_no='" + txtrevise + "',subservtypeid="
                                    + (surveydet[10].trim().equalsIgnoreCase("undefined")
                                            || surveydet[10].trim().equalsIgnoreCase("NaN")
                                            || surveydet[10].trim().equalsIgnoreCase("") || surveydet[10].isEmpty() ? 0
                                                    : surveydet[10].trim())
                                    + " WHERE tr_no='" + docno + "' AND  rowno='" + refrowno + "'";
                        } else {

                            sql = "INSERT INTO cm_srvqotd(sr_no, description, servid, unitid, qty, amount, discount, disper, total, revision_no, tr_no,subservtypeid) VALUES"
                                    + " (" + (i + 1) + ","
                                    + "'"
                                    + (surveydet[0].trim().equalsIgnoreCase("undefined")
                                            || surveydet[0].trim().equalsIgnoreCase("NaN")
                                            || surveydet[0].trim().equalsIgnoreCase("") || surveydet[0].isEmpty() ? ""
                                                    : surveydet[0].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[1].trim().equalsIgnoreCase("undefined")
                                            || surveydet[1].trim().equalsIgnoreCase("NaN")
                                            || surveydet[1].trim().equalsIgnoreCase("") || surveydet[1].isEmpty() ? 0
                                                    : surveydet[1].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[2].trim().equalsIgnoreCase("undefined")
                                            || surveydet[2].trim().equalsIgnoreCase("NaN")
                                            || surveydet[2].trim().equalsIgnoreCase("") || surveydet[2].isEmpty() ? 0
                                                    : surveydet[2].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[3].trim().equalsIgnoreCase("undefined")
                                            || surveydet[3].trim().equalsIgnoreCase("NaN")
                                            || surveydet[3].trim().equalsIgnoreCase("") || surveydet[3].isEmpty() ? 0
                                                    : surveydet[3].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[4].trim().equalsIgnoreCase("undefined")
                                            || surveydet[4].trim().equalsIgnoreCase("NaN")
                                            || surveydet[4].trim().equalsIgnoreCase("") || surveydet[4].isEmpty() ? 0
                                                    : surveydet[4].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[5].trim().equalsIgnoreCase("undefined")
                                            || surveydet[5].trim().equalsIgnoreCase("NaN")
                                            || surveydet[5].trim().equalsIgnoreCase("") || surveydet[5].isEmpty() ? 0
                                                    : surveydet[5].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[6].trim().equalsIgnoreCase("undefined")
                                            || surveydet[6].trim().equalsIgnoreCase("NaN")
                                            || surveydet[6].trim().equalsIgnoreCase("") || surveydet[6].isEmpty() ? 0
                                                    : surveydet[6].trim())
                                    + "',"
                                    + "'"
                                    + (surveydet[7].trim().equalsIgnoreCase("undefined")
                                            || surveydet[7].trim().equalsIgnoreCase("NaN")
                                            || surveydet[7].trim().equalsIgnoreCase("") || surveydet[7].isEmpty() ? 0
                                                    : surveydet[7].trim())
                                    + "',"
                                    + "'" + txtrevise + "',"
                                    + "'" + docno + "','"
                                    + (surveydet[10].trim().equalsIgnoreCase("undefined")
                                            || surveydet[10].trim().equalsIgnoreCase("NaN")
                                            || surveydet[10].trim().equalsIgnoreCase("") || surveydet[10].isEmpty() ? 0
                                                    : surveydet[10].trim())
                                    + "')";
                        }
                        // System.out.println("====cm_srvqotd====="+sql);
                        int resultSet2 = stmt.executeUpdate(sql);
                        if (resultSet2 <= 0) {
                            conn.close();
                            return 0;
                        }
                    }
                }
//System.out.println("AMC grid : "+amclist);
                for (int i = 0; i < amclist.size(); i++) {
                    String[] amc = ((String) amclist.get(i)).split("::");
                    //System.out.println("on amc : "+amc);

                    if (!((amc[0].equalsIgnoreCase("0")) || (amc[0].equalsIgnoreCase("undefined")))) {
                        //System.out.println("on if first");

                        String termsql = "";
                        int refrowno = 0;
                        refrowno = (amc[4].trim().equalsIgnoreCase("undefined") || amc[4].trim().equalsIgnoreCase("NaN")
                                || amc[4].trim().equalsIgnoreCase("") || amc[4].isEmpty() ? 0
                                        : Integer.parseInt(amc[4].trim()));
                        if (refrowno > 0) {
                            //System.out.println("on if ref row : "+refrowno);
                            termsql = "update cm_srvqotdamc set description='"
                                    + (amc[0].equalsIgnoreCase("undefined") || amc[0].equalsIgnoreCase("")
                                            || amc[0].trim().equalsIgnoreCase("NaN") || amc[0].isEmpty() ? 0
                                                    : amc[0].trim())
                                    + "',"
                                    + "area='"
                                    + (amc[1].equalsIgnoreCase("undefined") || amc[1].equalsIgnoreCase("")
                                            || amc[1].trim().equalsIgnoreCase("NaN") || amc[1].isEmpty() ? 0
                                                    : amc[1].trim())
                                    + "',"
                                    + "unit='"
                                    + (amc[2].equalsIgnoreCase("undefined") || amc[2].equalsIgnoreCase("")
                                            || amc[2].trim().equalsIgnoreCase("NaN") || amc[2].isEmpty() ? 0
                                                    : amc[2].trim())
                                    + "',"
                                    + "unitid='"
                                    + (amc[3].equalsIgnoreCase("undefined") || amc[3].equalsIgnoreCase("")
                                            || amc[3].trim().equalsIgnoreCase("NaN") || amc[3].isEmpty() ? 0
                                                    : amc[3].trim())
                                    + "' where rowno='" + refrowno + "'";
                        } else {
                            //System.out.println("on else ref row : "+refrowno);

                            termsql = "insert into cm_srvqotdamc(rdocno,description, area, unit, unitid)VALUES"
                                    + " ('" + docno + "',"
                                    + "'"
                                    + (amc[0].equalsIgnoreCase("undefined") || amc[0].equalsIgnoreCase("")
                                            || amc[0].trim().equalsIgnoreCase("NaN") || amc[0].isEmpty() ? 0
                                                    : amc[0].trim())
                                    + "',"
                                    + "'"
                                    + (amc[1].equalsIgnoreCase("undefined") || amc[1].equalsIgnoreCase("")
                                            || amc[1].trim().equalsIgnoreCase("NaN") || amc[1].isEmpty() ? 0
                                                    : amc[1].trim())
                                    + "',"
                                    + "'"
                                    + (amc[2].equalsIgnoreCase("undefined") || amc[2].equalsIgnoreCase("")
                                            || amc[2].trim().equalsIgnoreCase("NaN") || amc[2].isEmpty() ? 0
                                                    : amc[2].trim())
                                    + "',"
                                    + "'"
                                    + (amc[3].equalsIgnoreCase("undefined") || amc[3].equalsIgnoreCase("")
                                            || amc[3].trim().equalsIgnoreCase("NaN") || amc[3].isEmpty() ? 0
                                                    : amc[3].trim())
                                    + "')";
                        }

                        // //System.out.println("termsdet--->>>>Sql"+termsql);
                        int resultSet4 = stmt.executeUpdate(termsql);

                        if (resultSet4 <= 0) {
                            conn.close();
                            return 0;
                        }
                    }
                }

                for (int i = 0; i < termslist.size(); i++) {

                    String[] terms = ((String) termslist.get(i)).split("::");

                    if (!((terms[0].equalsIgnoreCase("0")) || (terms[0].equalsIgnoreCase("undefined")))) {

                        String termsql = "insert into my_trterms(rdocno, termsid, conditions, status, dtype)VALUES"
                                + " ('" + docno + "',"
                                + "'"
                                + (terms[0].equalsIgnoreCase("undefined") || terms[0].equalsIgnoreCase("")
                                        || terms[0].trim().equalsIgnoreCase("NaN") || terms[0].isEmpty() ? 0
                                                : terms[0].trim())
                                + "',"
                                + "'"
                                + (terms[3].equalsIgnoreCase("undefined") || terms[3].equalsIgnoreCase("")
                                        || terms[3].trim().equalsIgnoreCase("NaN") || terms[3].isEmpty() ? 0
                                                : terms[3].trim())
                                + "',"
                                + "'3',"
                                + "'" + formcode + "')";

                        // //System.out.println("termsdet--->>>>Sql"+termsql);
                        int resultSet3 = stmt.executeUpdate(termsql);

                        if (resultSet3 <= 0) {
                            conn.close();
                            return 0;
                        }
                    }
                }
                /*
                 * String sqlrevise="select revision_no from cm_srvqotm where tr_no="
                 * +docno+" and doc_no="+vocno+"";
                 * 
                 * //System.out.println("==sqlrevise==="+sqlrevise);
                 * 
                 * ResultSet rsrevise = stmt.executeQuery(sqlrevise);
                 * while(rsrevise.next()){
                 * reviseno=rsrevise.getInt("revision_no");
                 * request.setAttribute("revno", reviseno);
                 * }
                 */

            }

            conn.commit();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return docno;

    }

    public int delete(int docno, int vocno, java.sql.Date date, String txtrefno, int clientid, int cpersonid,
            String reftype, int enquiryid, String chkRdo, String dcdamount, String txtsubject, String txtdesc1,
            String clientref, String txtgrtotal, String txtdisper, String txtdisamt, String txttotalamt,
            String txttaxper, String txttaxamt, String txtnettotal, String formcode,
            String mode, ArrayList servlist, ArrayList sitelist, ArrayList termslist, HttpSession session,
            HttpServletRequest request, int salid, int cmbprocess, int txtrevise, int chklegal,
            String txtthresholdlimit, String txtpartlimitperc, String txtadditionalamt,String discounttick) throws SQLException {

        Connection conn = null;

        conn = conobj.getMyConnection();

        try {

            conn.setAutoCommit(false);

            CallableStatement stmt = conn.prepareCall(
                    "{CALL sr_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

            stmt.setDate(1, date);
            stmt.setString(2, txtrefno);
            stmt.setInt(3, clientid);
            stmt.setInt(4, cpersonid);
            stmt.setString(5, reftype);
            stmt.setInt(6, enquiryid);
            stmt.setString(7, chkRdo);
            stmt.setDouble(8, dcdamount == "" || dcdamount == null || dcdamount.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(dcdamount));
            stmt.setString(9, txtsubject);
            stmt.setString(10, txtdesc1);
            stmt.setString(11, clientref);
            stmt.setDouble(12, Double.parseDouble(txtgrtotal));
            stmt.setDouble(13, txtdisper == "" || txtdisper == null || txtdisper.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(txtdisper));
            stmt.setDouble(14, txtdisamt == "" || txtdisamt == null || txtdisamt.equalsIgnoreCase("") ? 0.0
                    : Double.parseDouble(txtdisamt));
            stmt.setDouble(15, Double.parseDouble(txttotalamt));
            stmt.setDouble(16, Double.parseDouble(txttaxper));
            stmt.setDouble(17, Double.parseDouble(txttaxamt));
            stmt.setDouble(18, Double.parseDouble(txtnettotal));
            stmt.setString(19, mode);
            stmt.setString(20, formcode);
            stmt.setString(21, session.getAttribute("USERID").toString());
            stmt.setString(22, session.getAttribute("BRANCHID").toString());
            stmt.setString(23, session.getAttribute("COMPANYID").toString());
            stmt.setInt(24, salid);
            stmt.setInt(25, docno);
            stmt.setInt(26, vocno);
            stmt.setInt(27, cmbprocess);
            stmt.setInt(28, txtrevise);
            stmt.setInt(29, chklegal);
            stmt.setString(30, "0");
            stmt.setString(31, "0");
            stmt.setString(32, null);
            stmt.setDouble(33, 0.0);
            stmt.setString(34, null);
            stmt.setString(35, null);
            int val = stmt.executeUpdate();
            docno = stmt.getInt("docno");
            vocno = stmt.getInt("vocno");
            request.setAttribute("vocno", vocno);

            if (docno > 0) {

                conn.commit();

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return docno;

    }

    public JSONArray templateSearchGridLoading(String code, String name, String check) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        if (!(check.equalsIgnoreCase("1"))) {
            return RESULTDATA1;
        }

        Connection conn = null;

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sqltest = "";

            if (!(code.equalsIgnoreCase("")) && !(code.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and code like '%" + code + "%'";
            }

            if (!(name.equalsIgnoreCase("")) && !(name.equalsIgnoreCase("0"))) {
                sqltest = sqltest + " and name like '%" + name + "%'";
            }

            String sql = "select doc_no,code,name from cm_templatem where dtype='STM' and status=3" + sqltest + "";

            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray searchMaster(HttpSession session, String msdocno, String Cl_names, String sereftype,
            String surdate, String cntrtype, int id, String Cl_site, String Cl_area, String Cl_amount, String refno,
            String revisionno) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
                a = 1;
            }
        }
        if (a == 0) {
            return RESULTDATA;
        }

        // //System.out.println("8888888888"+clnames);
        String brid = session.getAttribute("BRANCHID").toString();

        java.sql.Date sqlStartDate = null;

        String sqltest = "";
        if (!(surdate.equalsIgnoreCase("undefined")) && !(surdate.equalsIgnoreCase(""))
                && !(surdate.equalsIgnoreCase("0"))) {
            sqlStartDate = com.changeStringtoSqlDate(surdate);
            sqltest = sqltest + " and m.date<=" + sqlStartDate + "";
        }
        if (!(msdocno.equalsIgnoreCase("undefined")) && !(msdocno.equalsIgnoreCase(""))
                && !(msdocno.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and m.doc_no like '%" + msdocno + "%'";
        }
        if (!(Cl_names.equalsIgnoreCase("undefined")) && !(Cl_names.equalsIgnoreCase(""))
                && !(Cl_names.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and ac.refname like '%" + Cl_names + "%'";
        }
        if (!(sereftype.equalsIgnoreCase("undefined")) && !(sereftype.equalsIgnoreCase(""))
                && !(sereftype.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and m.ref_type like '%" + sereftype + "%'";
        }
        if (!(cntrtype.equalsIgnoreCase("undefined")) && !(cntrtype.equalsIgnoreCase(""))
                && !(cntrtype.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and m.cntr_type like '%" + cntrtype + "%'";
        }

        if (!(Cl_site.equalsIgnoreCase("undefined")) && !(Cl_site.equalsIgnoreCase(""))
                && !(Cl_site.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and sd.site like '%" + Cl_site + "%'";
        }
        if (!(Cl_area.equalsIgnoreCase("undefined")) && !(Cl_area.equalsIgnoreCase(""))
                && !(Cl_area.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and g.groupname like '%" + Cl_area + "%'";
        }
        if (!(Cl_amount.equalsIgnoreCase("undefined")) && !(Cl_amount.equalsIgnoreCase(""))
                && !(Cl_amount.equalsIgnoreCase("NA"))) {
            sqltest = sqltest + " and m.netamount like '%" + Cl_amount + "%'";
        }
        if (!(refno.equalsIgnoreCase("undefined")) && !(refno.equalsIgnoreCase("")) && !(refno.equalsIgnoreCase("0"))) {
            sqltest = sqltest + " and m.refno like '%" + refno + "%'";
        }
        Connection conn = null;

        try {
            if (id > 0) {

                conn = conobj.getMyConnection();
                Statement stmtenq1 = conn.createStatement();
                String str1Sql = "";
                if (!(revisionno.equalsIgnoreCase("undefined")) && !(revisionno.equalsIgnoreCase(""))) {
                    str1Sql = ("select d.revision_no,maxrev latestrevno,m.TR_NO tr_no, m.DOC_NO doc_no,m.refno, m.DATE date, m.refNo,m.dtype,m.ref_type reftype,refname,trim(address) address,per_mob,trim(mail1) mail1,"
                            + " m.subject, refDocNo, clrefNo, costType, cpersonid,m.cntr_type,ac.refname as name,"
                            + "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,cpersonid, "
                            + "trim(address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,round(coalesce(legalchrg,0.0),2) legalchrg,cntr_type,sm.sal_name as salname,sm.doc_no as salid,m.sjobtype,rv.maxrev,if(ex.dtype='SQOT' and m.status=3,1,0) appreditdis,sd.site,g.groupname area,round(coalesce(r.netamount,m.netamount),2) as netAmount,round(coalesce(r.taxper,m.taxper),2) taxPer,round(coalesce(r.tax,m.tax),2) as tax,round(coalesce(r.amount,m.amount),2) as amount,round(coalesce(r.discount,m.discount),2) discount, round(coalesce(r.disper,m.disper),2) disper,round(coalesce(r.total,m.total),2) as total,round(coalesce(r.total,m.total),2) as total,m.notes from cm_srvqotm m left join cm_srvqotmrev r on (r.qottrno=m.tr_no and r.revision_no='"
                            + revisionno
                            + "') left join cm_srvqotd d on d.tr_no=m.tr_no left join cm_servsited sd on m.tr_no=sd.tr_no left join my_groupvals g on(sd.areaid=g.doc_no and grptype='area')  left join my_acbook ac "
                            + "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact cn on(cn.cldocno=m.cpersonid and cn.row_no=m.cpersonid) left join my_salm sm on(sm.doc_no=m.sal_id)"
                            + "left join (select max(revision_no) maxrev,tr_no from cm_srvqotd group by tr_no) rv on rv.tr_no=m.tr_no"
                            + " left join my_exdoc ex on ex.dtype=m.dtype where m.status!=7 and m.brhid=" + brid
                            + " and d.revision_no = '" + revisionno + "' " + sqltest + " group by m.TR_NO ");
                } else {
                    str1Sql = ("select m.revision_no latestrevno,m.TR_NO tr_no, m.DOC_NO doc_no,m.refno, m.DATE date,round(coalesce(m.netAmount,0.0),2) as netAmount, m.refNo,m.dtype,m.ref_type reftype,refname,trim(address) address,per_mob,trim(mail1) mail1,"
                            + " subject, refDocNo, clrefNo,round(coalesce(m.taxPer,0.0),2) taxPer,round(coalesce(m.tax,0.0),2) as tax,round(coalesce(m.amount,0.0),2) as amount,round(coalesce(discount,0.0),2) discount, round(coalesce(disPer,0.0),2) disper, costType,round(coalesce(total,0.0),2) as total, cpersonid,m.cntr_type,ac.refname as name,"
                            + "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,cpersonid, "
                            + "trim(address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,round(coalesce(legalchrg,0.0),2) legalchrg,cntr_type,sm.sal_name as salname,sm.doc_no as salid,m.sjobtype,m.revision_no,rv.maxrev,if(ex.dtype='SQOT' and m.status=3,1,0) appreditdis,sd.site,g.groupname area,m.notes from  cm_srvqotm m left join cm_servsited sd on m.tr_no=sd.tr_no left join my_groupvals g on(sd.areaid=g.doc_no and grptype='area')  left join my_acbook ac "
                            + "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact cn on(cn.cldocno=m.cpersonid and cn.row_no=m.cpersonid) left join my_salm sm on(sm.doc_no=m.sal_id)"
                            + "left join (select max(revision_no) maxrev,doc_no from cm_srvqotm group by doc_no) rv on rv.doc_no=m.doc_no"
                            + " left join my_exdoc ex on ex.dtype=m.dtype where m.status!=7 and m.brhid=" + brid + "  "
                            + sqltest + " group by m.TR_NO ");
                }
                 //System.out.println("===mainsearch===="+str1Sql);
                ResultSet resultSet = stmtenq1.executeQuery(str1Sql);
                RESULTDATA = com.convertToJSON(resultSet);
                stmtenq1.close();
                conn.close();
            }

        } catch (Exception e) {
            conn.close();
            e.printStackTrace();
        }

        //// System.out.println(RESULTDATA);
        return RESULTDATA;
    }

    public ClsQuotationBean printMaster(HttpSession session, String msdocno, String brhid, String trno, String dtype,
            String revision) throws SQLException {

        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
                a = 1;
            }
        }

        String brid = session.getAttribute("BRANCHID").toString();
        java.sql.Date sqlStartDate = null;
        String sqltest = "", contrtype = "";
        Connection conn = null;
        ArrayList list = null;
        ArrayList amclist = null;
        ArrayList trlist = null;
        try {
            list = new ArrayList();
            trlist = new ArrayList();
            amclist = new ArrayList();
            ClsNumberToWord obj = new ClsNumberToWord();
            ClsAmountToWords obj1 = new ClsAmountToWords();
            double lfee = 0.0;

            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();
            int val = 0;
            String sql1 = "select coalesce(method,0) method from gl_config where field_nme='revisionConformation'";
            ResultSet resultset = stmt.executeQuery(sql1);
            if (resultset.next()) {
                val = resultset.getInt("method");
            }
            String Sql = "";
            if (val > 0 && (!(revision.equalsIgnoreCase("NaN")) && !(revision.equalsIgnoreCase("undefined"))
                    && !(revision.equalsIgnoreCase("")))) {
                Sql = ("select if(m.ref_type='SRVE',coalesce(cm.doc_no,''),'') contractvocno, if(m.ref_type='SRVE',coalesce(cm.refNo,''),'') refeNo,if(m.ref_type='ENQ',em.voc_no,if(m.ref_type='SRVE',srv.doc_no,m.refDocNo)) refVocNo,if(m.status!=3,'1','0') watermark_stat,m.sjobtype,coalesce(ac.interserv,0) interserv,coalesce(ac.tinno,'') cltinno,coalesce(b.tinno,'') brtinno,coalesce(concat(com.comp_code,'/',m.cntr_type,'/','QTN','/',m.doc_no),'') companyqtn,coalesce(concat(com.comp_code,'/',m.cntr_type,'/','QTN','/',m.doc_no),'') companybranchqtn,coalesce(concat('MMJ','/','QTN','/',m.cntr_type,'/',m.doc_no),'') mmjcomp,coalesce(concat('FIR','/','QTN','/',m.cntr_type,'/',m.doc_no),'') fircomp,"
                        + "m.revision_no,usr.user_name,coalesce(usr.per,'') usertel,coalesce(role.user_role,'') userole,if(m.status!=3,'Quotation (Sample)','Quotation') printname,m.TR_NO tr_no,concat( cntr_type,'/','QTN','/',m.DOC_NO) doc_no,concat( b.code ,'/', cntr_type,'/','QTN','/',m.DOC_NO) emiratedocno,DATE_FORMAT(m.date,'%d/%m/%Y') date,"
                        + "m.refNo,m.dtype,m.ref_type reftype,refname,trim(ac.address) address,if(CONCAT(if(ac.per_tel is null or trim(ac.per_tel)='',if(ac.per_mob is null or trim(ac.per_mob)='',if(ac.com_mob is null or trim(ac.com_mob)='',' NIL , ',CONCAT(ac.com_mob,' , ')),CONCAT(ac.per_mob,' , ')),CONCAT(ac.per_tel,' , ')),"
                        + "if(ac.fax1 is null or trim(ac.fax1)='',if(ac.fax2 is null or trim(ac.fax2)='','NIL',ac.fax2),ac.fax1))=' NIL , NIL','',CONCAT(if(ac.per_tel is null or trim(ac.per_tel)='',if(ac.per_mob is null or trim(ac.per_mob)='',if(ac.com_mob is null or trim(ac.com_mob)='',' NIL , ',CONCAT(ac.com_mob,' , ')),CONCAT(ac.per_mob,' , ')),CONCAT(ac.per_tel,' , ')),"
                        + "if(ac.fax1 is null or trim(ac.fax1)='',if(ac.fax2 is null or trim(ac.fax2)='','NIL',ac.fax2),ac.fax1))) as per_mob,trim(mail1) mail1,"
                        + " m.subject, m.refDocNo, clrefNo, m.costType, "
                        + " m.cpersonid,m.cntr_type,ac.refname as name,"
                        + "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,m.cpersonid, "
                        + "trim(ac.address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,coalesce(round(m.legalchrg,2),0.0) legalchrg,cntr_type,cur.code as code,b.branchname brch,b.address as baddress,usr.user_name preparedby,usr.user_id userprep,b.tel,b.fax,com.company comp,cur.code,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate,sm.sal_name as salnme,coalesce(sm.mob_no,'') as salmob ,per_mob mobile,coalesce(per_tel,'') telno, "
                        + " round(coalesce(m.legalchrg,0.0),2)+round(coalesce(r.total,m.total),2) as aitstotal, round(coalesce(r.amount,m.amount),2) as aitsamount,round(coalesce(m.legalchrg,0.0)+((coalesce(m.legalchrg,0.0)*5)/100),2) legtax,(round(coalesce(m.legalchrg,0.0),2)+round(coalesce(r.total,m.total),2)+round(coalesce(r.tax,m.tax),2)+round(((coalesce(m.legalchrg,0.0)*5)/100),2)) as lgltaxtot,round(coalesce(r.netAmount,m.netAmount),2) as netAmount,round(coalesce(r.taxPer,m.taxPer),2) taxPer,round(coalesce(r.tax,m.tax),2) as tax,(round(coalesce(m.legalchrg,0.0),2)+round(coalesce(r.amount,m.amount),2)) as amount,format(round(coalesce(r.discount,m.discount),2),2) discount, round(coalesce(r.disPer,m.disPer),2) disper, (round(coalesce(m.legalchrg,0.0),2)+round(coalesce(r.total,m.total),2)+round(coalesce(r.tax,m.tax),2)) as total, format(round(coalesce(r.amount,m.amount)+coalesce(m.legalchrg,0.0),2),2) fire7tot ,round(coalesce(r.total,m.total),2) fire7nettot ,format(round(coalesce(r.tax,m.tax),2),2) taxamount  ,if(coalesce(r.discount,m.discount)>0.0000,'1','0') discountstat ,format(round(coalesce(r.total,m.total)+coalesce(r.tax,m.tax),2),2) formattfire7nettot,round(coalesce(r.amount,m.amount)+coalesce(m.legalchrg,0.0)-coalesce(r.discount,m.discount)+(coalesce(r.amount,m.amount)+coalesce(m.legalchrg,0.0)-coalesce(r.discount,m.discount))*0.05,2) tfire7nettotal"
                        + ",m.signedby from cm_srvqotm m left join cm_srvqotd d on d.tr_no=m.tr_no left join (select netamount, taxper, tax, amount, discount, disper, additionalamt, total, qottrno from cm_srvqotmrev where revision_no='"
                        + revision
                        + "') r on (r.qottrno=m.tr_no) left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_curr cur on(cur.doc_no=ac.curid) left join my_crmcontact cn on(cn.cldocno=m.cldocno and cn.row_no=m.cpersonid)"
                        + "left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_salm sm on(sm.doc_no=m.sal_id) left join my_comp com on(com.doc_no=b.cmpid) left join  my_user usr on m.userId=usr.doc_no left join gl_enqm em on m.refdocno=em.doc_no and m.ref_type='ENQ' and em.status=3 left join cm_srvdetm srv on srv.TR_no=m.refdocno and m.ref_type='SRVE' left join cm_srvdetm mc on m.refdocno=mc.doc_no left join cm_Srvcontrm cm on cm.tr_no=mc.costid   left join my_urole role on usr.role_id=role.doc_no where m.status!=7 and m.doc_no="
                        + msdocno + " and m.tr_no=" + trno + " and m.brhid=" + brid + " and coalesce(d.revision_no,0)='"
                        + revision + "' group by m.tr_no");
            } else {
                Sql = ("select  if(m.ref_type='SRVE',coalesce(cm.doc_no,''),'') contractvocno, if(m.ref_type='SRVE',coalesce(cm.refNo,''),'') refeNo,if(m.ref_type='ENQ',em.voc_no,if(m.ref_type='SRVE',srv.doc_no,m.refDocNo)) refVocNo,if(m.status!=3,'1','0') watermark_stat,m.sjobtype,coalesce(ac.interserv,0) interserv,coalesce(ac.tinno,'') cltinno,coalesce(b.tinno,'') brtinno,round(coalesce(m.legalchrg,0.0),2)+round(coalesce(total,0.0),2) as aitstotal, round(coalesce(amount,0.0),2) as aitsamount,round(coalesce(m.legalchrg,0.0)+((coalesce(m.legalchrg,0.0)*5)/100),2) legtax,coalesce(concat(com.comp_code,'/',m.cntr_type,'/','QTN','/',m.doc_no),'') companyqtn,coalesce(concat(com.comp_code,'/',m.cntr_type,'/','QTN','/',m.doc_no),'') companybranchqtn,coalesce(concat('MMJ','/','QTN','/',m.cntr_type,'/',m.doc_no),'') mmjcomp,coalesce(concat('FIR','/','QTN','/',m.cntr_type,'/',m.doc_no),'') fircomp,"
                        + "(round(coalesce(m.legalchrg,0.0),2)+round(coalesce(total,0.0),2)+round(coalesce(m.tax,0.0),2)+round(((coalesce(m.legalchrg,0.0)*5)/100),2)) as lgltaxtot,m.revision_no,usr.user_name,coalesce(usr.per,'') usertel,coalesce(role.user_role,'') userole,if(m.status!=3,'Quotation (Sample)','Quotation') printname,m.TR_NO tr_no,concat( cntr_type,'/','QTN','/',m.DOC_NO) doc_no,concat( b.code ,'/', cntr_type,'/','QTN','/',m.DOC_NO) emiratedocno,DATE_FORMAT(m.date,'%d/%m/%Y') date,"
                        + "round(coalesce(m.netAmount,0.0),2) as netAmount, m.refNo,m.dtype,m.ref_type reftype,refname,trim(ac.address) address,if(CONCAT(if(ac.per_tel is null or trim(ac.per_tel)='',if(ac.per_mob is null or trim(ac.per_mob)='',if(ac.com_mob is null or trim(ac.com_mob)='',' NIL , ',CONCAT(ac.com_mob,' , ')),CONCAT(ac.per_mob,' , ')),CONCAT(ac.per_tel,' , ')),"
                        + "if(ac.fax1 is null or trim(ac.fax1)='',if(ac.fax2 is null or trim(ac.fax2)='','NIL',ac.fax2),ac.fax1))=' NIL , NIL','',CONCAT(if(ac.per_tel is null or trim(ac.per_tel)='',if(ac.per_mob is null or trim(ac.per_mob)='',if(ac.com_mob is null or trim(ac.com_mob)='',' NIL , ',CONCAT(ac.com_mob,' , ')),CONCAT(ac.per_mob,' , ')),CONCAT(ac.per_tel,' , ')),"
                        + "if(ac.fax1 is null or trim(ac.fax1)='',if(ac.fax2 is null or trim(ac.fax2)='','NIL',ac.fax2),ac.fax1))) as per_mob,trim(mail1) mail1,"
                        + " subject, m.refDocNo, clrefNo,round(coalesce(m.taxPer,0.0),2) taxPer,round(coalesce(m.tax,0.0),2) as tax,(round(coalesce(m.legalchrg,0.0),2)+round(coalesce(amount,0.0),2)) as amount,format(round(coalesce(discount,0.0),2),2) discount, round(coalesce(disPer,0.0),2) disper, m.costType, "
                        + "(round(coalesce(m.legalchrg,0.0),2)+round(coalesce(total,0.0),2)+round(coalesce(m.tax,0.0),2)) as total, m.cpersonid,m.cntr_type,ac.refname as name,"
                        + "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,m.cpersonid, "
                        + "trim(ac.address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,coalesce(round(m.legalchrg,2),0.0) legalchrg,cntr_type,cur.code as code,b.branchname brch,b.address as baddress,usr.user_name preparedby,usr.user_id userprep,b.tel,b.fax,com.company comp,cur.code,loc.loc_name,DATE_FORMAT(CURDATE(),'%d/%m/%Y') as finaldate,sm.sal_name as salnme,coalesce(sm.mob_no,'') as salmob ,per_mob mobile,coalesce(per_tel,'') telno, "
                        + "format(round(coalesce(amount,0.0)+coalesce(m.legalchrg,0.0),2),2) fire7tot ,round(coalesce(total,0.0),2) fire7nettot ,format(round(coalesce(m.tax,0),2),2) taxamount  ,if(m.discount>0.0000,'1','0') discountstat ,format(round(coalesce(total,0.0)+coalesce(m.tax,0.0),2),2) formattfire7nettot,round(coalesce(amount,0.0)+coalesce(m.legalchrg,0.0)-coalesce(m.discount,0.0)+(coalesce(amount,0.0)+coalesce(m.legalchrg,0.0)-coalesce(m.discount,0.0))*0.05,2) tfire7nettotal  "
                        + ",m.signedby from  cm_srvqotm m left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_curr cur on(cur.doc_no=ac.curid) left join my_crmcontact cn on(cn.cldocno=m.cldocno and cn.row_no=m.cpersonid)"
                        + "left join my_brch b on(b.doc_no=m.brhid) left join my_locm loc on(b.doc_no=loc.brhid) left join my_salm sm on(sm.doc_no=m.sal_id) left join my_comp com on(com.doc_no=b.cmpid) left join  my_user usr on m.userId=usr.doc_no left join gl_enqm em on m.refdocno=em.doc_no and m.ref_type='ENQ' and em.status=3 left join cm_srvdetm srv on srv.TR_no=m.refdocno and m.ref_type='SRVE'  left join cm_srvdetm mc on m.refdocno=mc.doc_no left join cm_Srvcontrm cm on cm.tr_no=mc.costid left join my_urole role on usr.role_id=role.doc_no where m.status!=7 and m.doc_no="
                        + msdocno + " and m.tr_no=" + trno + " and m.brhid=" + brid + "");
            }
          //  System.out.println("===Print Sql==="+Sql);
            ResultSet rs = stmt.executeQuery(Sql);
            while (rs.next()) {
                bean.setRefeNo(rs.getString("refeNo"));
                bean.setContractvocno(rs.getString("contractvocno"));
                bean.setLblusersales(rs.getString("userprep"));
                bean.setSecondlevelapproval(rs.getString("preparedby"));
                bean.setTxtenquiry(rs.getString("refvocno"));
                bean.setEmiratedocno(rs.getString("emiratedocno"));
                bean.setLblsignedby(rs.getString("signedby"));
                bean.setWatermarkstatus(rs.getString("watermark_stat"));
                bean.setCompanyqtn(rs.getString("companyqtn")); // city
                bean.setCompanybranchqtn(rs.getString("companybranchqtn")); // star
                bean.setQtnref(rs.getString("mmjcomp"));// MMJ
                bean.setComprefns(rs.getString("fircomp"));// FIR
                bean.setLblsjobtype(rs.getString("sjobtype"));
                bean.setUserroles(rs.getString("userole"));
                bean.setUsertels(rs.getString("usertel"));

                bean.setCompanytrno(rs.getString("brtinno"));
                bean.setTinno(rs.getString("cltinno"));

                bean.setTxtrevise(rs.getString("revision_no"));
                bean.setPrintname(rs.getString("printname"));
                bean.setMasterdoc_no(rs.getInt("tr_no"));
                bean.setDocno(rs.getString("doc_no"));
                bean.setDate(rs.getString("date"));
                bean.setTxtclient(rs.getString("refname"));
                bean.setTxtclientdet(rs.getString("address"));
                bean.setTxtmob(rs.getString("per_mob"));
                bean.setTxtemail(rs.getString("mail1"));
                bean.setTxttel(rs.getString("telno"));
                bean.setTxtcontact(rs.getString("cn.cperson"));
                bean.setTxtcontactdetails(rs.getString("contactdet"));
                bean.setTxtdcdamount(rs.getString("legalchrg"));
                bean.setTxtdesc1(rs.getString("remarks"));
                bean.setTxtsubject(rs.getString("subject"));
                bean.setTxtclientref(rs.getString("clrefNo"));
                bean.setTxtgrtotal(rs.getString("amount"));
                bean.setTxtdisper(rs.getString("disper"));
                bean.setTxtdisamt(rs.getString("discount"));
                bean.setTxttotalamt(rs.getString("amount"));
                bean.setTxttaxper(rs.getString("taxPer"));
                bean.setTxttaxamt(rs.getString("tax"));
                bean.setTxtnettotal(rs.getString("total"));
                bean.setContrtype(rs.getString("cntr_type"));
                bean.setLblbranch(rs.getString("brch"));
                bean.setLblcompaddress(rs.getString("baddress"));
                bean.setLblcompfax(rs.getString("fax"));
                bean.setLblcomptel(rs.getString("tel"));
                bean.setLbllocation(rs.getString("loc_name"));
                bean.setLblcompname(rs.getString("comp"));
                bean.setLblfinaldate(rs.getString("finaldate"));
                bean.setTxtsalman(rs.getString("salnme"));
                bean.setTxtrefno(rs.getString("refNo"));
                bean.setTxtsalmob(rs.getString("salmob"));

                /// fire 7telno,mobno
                bean.setFire7discountstat(rs.getString("discountstat"));
                bean.setFire7user(rs.getString("user_name"));
                bean.setFire7nettotal(rs.getString("fire7nettot"));
                bean.setFire7total(rs.getString("fire7tot"));
                bean.setF7mobno(rs.getString("mobile"));
                bean.setF7telno(rs.getString("tel"));
                bean.setTaxamount(rs.getString("taxamount"));
                // bean.setAmountwords(rs.getString("code")+"
                // "+obj1.convertAmountToWords(rs.getString("total")));
                bean.setAmountwords(obj1.convertAmountToWords(rs.getString("total")));

                bean.setAitsnetamount(rs.getString("aitsamount"));
                bean.setLeglfeewithtax(rs.getString("legtax")); // aits
                bean.setLegaltaxtot(rs.getString("lgltaxtot"));
                bean.setLegaltaxtotword(obj1.convertAmountToWords(rs.getString("lgltaxtot")));
                bean.setTaxtype(rs.getString("interserv"));

                // tax implement total amount fire7
                bean.setTfire7nettotal(rs.getString("formattfire7nettot"));
                bean.setTfire7nettotword(obj1.convertAmountToWords(rs.getString("tfire7nettotal")));
                bean.setStarnettotalword(obj1.convertAmountToWords(rs.getString("total")));
                // end
                lfee = Double.parseDouble(rs.getString("legalchrg"));
                contrtype = rs.getString("cntr_type");
                // //System.out.println(bean.getFire7nettotal());
                /// fire 7 tot amoun in word
                // bean.setFire7amountword(rs.getString("code")+"
                // "+obj1.convertAmountToWords(bean.getFire7total()));
                bean.setFire7amountword(obj1.convertAmountToWords(bean.getFire7nettotal()));
                //// System.out.println("setTxttotalamt="+bean.getFire7total()+"=="+bean.getFire7amountword());
            }

            // Approval Info

            /*
             * String
             * apprSql="select u.user_name preparedby,COALESCE(u1.user_name,'') verifiedappr,COALESCE(u2.user_name,'') approved,COALESCE(DATE_FORMAT(ext.apprDate,'%d-%m-%Y %H:%i'),'') verifiedapprdt from cm_srvqotm m left join my_exdet ext on (m.doc_no=ext.doc_no and m.dtype=ext.dtype "
             * +
             * "and ext.apprstatus=2) left join my_exdet ext1 on (m.doc_no=ext1.doc_no and m.dtype=ext1.dtype and ext1.apprstatus=3) left join my_user u on m.userid=u.doc_no left join my_user u1 on ext.userid=u1.doc_no "
             * +
             * "left join my_user u2 on ext1.userid=u2.doc_no where m.status<>7 and m.doc_no="
             * +msdocno+" and m.tr_no="+trno+" and m.brhid="+brid+"";
             * 
             * ResultSet rs1 = stmt.executeQuery(apprSql);
             * while(rs1.next()){
             * bean.setSecondlevelapproval(rs1.getString("verifiedappr"));
             * bean.setVerifiedapprdt(rs1.getString("verifiedapprdt"));
             * 
             * }
             */

            String apprSql = "select coalesce(u.user_name,'') preparedby,COALESCE(DATE_FORMAT(e.apprDate,'%d-%m-%Y %H:%i'),'') verifiedapprdt,h.pmmob,h.pmemail,d.desc1 designation from my_exdet e left join"
                    + " my_user u on e.userid=u.doc_no left join hr_empm h on h.empuserlink=u.doc_no left join hr_setdesig d on h.desc_id=d.doc_no where e.doc_no="
                    + msdocno + " and e.apprlevel=3 limit 1";

            //// System.out.println("approval"+apprSql);

            ResultSet rs1 = stmt.executeQuery(apprSql);
            while (rs1.next()) {
                bean.setSecondlevelapproval(rs1.getString("preparedby"));
                bean.setVerifiedapprdt(rs1.getString("verifiedapprdt"));
                bean.setApprdesgnation(rs1.getString("designation"));
                bean.setAppremail(rs1.getString("pmemail"));
                bean.setApprmobno(rs1.getString("pmmob"));
            }

            /// fire 7 site details
            String sitedetsql = "select  (concat(site,' ',g.groupname)) site  from  cm_servsited  d left join my_groupvals g on(d.areaid=g.doc_no and grptype='area')where tr_no="
                    + trno + " and sr_no=1 group by d.tr_no; ";
            ResultSet siters = stmt.executeQuery(sitedetsql);
            while (siters.next()) {
                bean.setFire7sitedetail(siters.getString("site"));
            }

            // end fire 7 site detail

            String sql = "select @id:=@id+1 as srno,a.* from(select d.sr_no,site,s.sr_no siteid,groupname stype,g.doc_no stypeid,coalesce(d.description,'') desc1, Equips item, round(qty,0) qty, round(d.Amount,2) as amount,round(d.total,2) total,u.unit as unit,unitid from "
                    + "cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') left join cm_servsited s on(s.rowno=d.sitesrno) left join my_unitm u on(u.doc_no=d.unitid) "
                    + "where d.tr_no=" + trno + " and d.revision_no=" + bean.getTxtrevise()
                    + " order by d.sr_no) a,(select @id:=0) r";
            //// System.out.println("==== "+sql);
            bean.setSitequery(sql);
            ResultSet rs2 = stmt.executeQuery(sql);
            int rowcount = 1;
            String oldsite = "";
            String newsite = "";
            String site = "";
            String temp = "";
            while (rs2.next()) {

                if (Double.parseDouble(rs2.getString("total")) > 0) {

                    temp = "";
                    newsite = rs2.getString("site") == null ? "" : rs2.getString("site");
                    if (oldsite.equalsIgnoreCase(newsite)) {
                        rowcount++;
                        site = "";

                    } else {
                        rowcount = 1;
                        site = rs2.getString("site");
                    }

                    temp = site + "::" + rowcount + "::" + rs2.getString("stype") + "::" + rs2.getString("desc1") + "::"
                            + rs2.getString("unit") + "::" + rs2.getString("qty") + "::" + rs2.getString("Amount")
                            + "::" + rs2.getString("total");

                    list.add(temp);

                    oldsite = newsite;

                }

            }
            if (contrtype.equalsIgnoreCase("AMC")) {
                if (lfee > 0) {
                    temp = "" + "::" + (rowcount + 1) + "::" + "CIVIL DEFENCE CONTRACT ATTESTATION" + "::"
                            + "CIVIL DEFENCE CONTRACT ATTESTATION" + "::" + "" + "::" + "" + "::" + lfee + "::" + lfee;
                    list.add(temp);
                }
            }

            bean.setList(list);

            String sqllist = "select distinct  groupname stype from "
                    + "cm_srvqotd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service')  "
                    + "where d.tr_no=" + trno + "";

            ResultSet rslist = stmt.executeQuery(sqllist);
            temp = "";
            rowcount = 1;
            while (rslist.next()) {

                temp = +(rowcount) + "::" + rslist.getString("stype") + "::" + "3 Months" + "::" + "4 Times";

                amclist.add(temp);
                rowcount++;
            }
            bean.setAmclist(amclist);

            String sql2 = "select m.voc_no,m.dtype,termsheader terms,conditions conditions from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no and m.dtype=tr.dtype) where "
                    + " tr.dtype='" + dtype + "-" + contrtype + "' and tr.rdocno=" + msdocno + " and tr.brhid=" + brid
                    + " and tr.status=3 and m.status=3  order by priorno";

            //// System.out.println("=====terms==="+sql2);

            ResultSet rs3 = stmt.executeQuery(sql2);

            int trcount = 1;
            String point = "*";
            String oldtrms = "";
            String newtrms = "";
            String testing = "";
            String cond = "";
            while (rs3.next()) {

                String temp1 = "";
                newtrms = rs3.getString("terms");
                if (oldtrms.equalsIgnoreCase(newtrms)) {
                    testing = "";
                    trcount++;
                } else {
                    trcount = 1;
                    testing = rs3.getString("terms");
                }
                cond = point + " " + rs3.getString("conditions");
                temp1 = testing + "::" + cond;

                trlist.add(temp1);
                oldtrms = newtrms;
            }
            bean.setTermlist(trlist);

            stmt.close();
            conn.close();
        }

        catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }
        //// System.out.println(RESULTDATA);
        return bean;
    }

    public JSONArray convertArrayToJSON(ArrayList<String> arrayList) throws Exception {
        JSONArray jsonArray = new JSONArray();

        for (int i = 0; i < arrayList.size(); i++) {

            JSONObject obj = new JSONObject();

            String[] Array = arrayList.get(i).split("::");

            obj.put("id", Array[0]);
            obj.put("description", Array[1]);
            obj.put("grpamt", Array[2]);
            obj.put("netamt", Array[3]);
            obj.put("childamt", Array[4]);
            obj.put("subchildamt", Array[5]);
            obj.put("parentid", Array[6]);
            obj.put("ordno", Array[7]);
            obj.put("groupno", Array[8]);
            obj.put("subac", Array[9]);
            obj.put("gp_id", Array[10]);

            jsonArray.add(obj);
        }
        return jsonArray;
    }

    public JSONArray searchProduct(HttpSession session, String prodsearchtype, String rdoc, String reftype,
            String clientid, String date,
            String prdname, String brandname, String id, String gridunit, String gridprdname, String scopeid,
            String servicetypeid) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();

        Connection conn = null;
        if (!(id.equalsIgnoreCase("1"))) {
            return RESULTDATA;
        }

        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();
            String sql = "";
            int method = 0;
            java.sql.Date estdate = null;
            String sqltest = "";
            /*
             * //System.out.println(clientid+"=="+date);
             * if(!(clientid.equals("0") || clientid.equals("") ||
             * clientid.equals("undefined"))){
             * sqltest=" and x.cldocno in ("+clientid+")";
             * }
             */

            if (!(date.equals("0") || date.equals("") || date.equals("undefined"))) {
                estdate = com.changeStringtoSqlDate(date);

            }

            String condtn = "";

            //// System.out.println("----prdname-sql---"+prdname);

            if (!(prdname.equalsIgnoreCase("")) && !(prdname.equalsIgnoreCase("undefined"))
                    && !(prdname.equalsIgnoreCase("0"))) {
                condtn = "  and m.part_no like '%" + prdname + "%' ";
            }

            if (!(brandname.equalsIgnoreCase("")) && !(brandname.equalsIgnoreCase("undefined"))
                    && !(brandname.equalsIgnoreCase("0"))) {
                condtn += "  and brd.brandname like '%" + brandname + "%' ";
            }

            if (!(gridprdname.equalsIgnoreCase("")) && !(gridprdname.equalsIgnoreCase("undefined"))
                    && !(gridprdname.equalsIgnoreCase("0"))) {
                condtn += "  and m.productname like '%" + gridprdname + "%' ";
            }

            if (!(gridunit.equalsIgnoreCase("")) && !(gridunit.equalsIgnoreCase("undefined"))
                    && !(gridunit.equalsIgnoreCase("0"))) {
                condtn += "  and u.unit like '%" + gridunit + "%' ";
            }

            String brcid = session.getAttribute("BRANCHID").toString();

            String strSql = "select method,field_nme from gl_config where field_nme in ('srvcPreSalesScope','ScopeCategorywise','srvcProductBranchAvailability')";
            ResultSet rs = stmt.executeQuery(strSql);

            String srvcPreSalesScope = "";
            String srvcProductBranchAvailability = "", ScopeCategorywise = "";

            while (rs.next()) {
                if (rs.getString("field_nme").equalsIgnoreCase("srvcPreSalesScope")) {
                    srvcPreSalesScope = rs.getString("method");
                }
                if (rs.getString("field_nme").equalsIgnoreCase("srvcProductBranchAvailability")) {
                    srvcProductBranchAvailability = rs.getString("method");
                }
                if (rs.getString("field_nme").equalsIgnoreCase("ScopeCategorywise")) {
                    ScopeCategorywise = rs.getString("method");
                }
            }

            if (srvcPreSalesScope.equalsIgnoreCase("1")) {
                if (ScopeCategorywise.equalsIgnoreCase("1")) {

                    if (!(servicetypeid.equalsIgnoreCase("")) && !(servicetypeid.equalsIgnoreCase("undefined"))
                            && !(servicetypeid.equalsIgnoreCase("0"))) {
                        condtn += "  and c.link in (0," + servicetypeid + ") ";
                    } else {
                        condtn += "  and c.link in (0) ";
                    }
                }

                if (srvcProductBranchAvailability.equalsIgnoreCase("1")) {

                    sql = "select at.mspecno as specid,m.part_no,m.productname,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
                            + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
                            + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
                            + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="
                            + scopeid + " left join my_catm c on c.doc_no=m.catid "
                            + "where m.status=3 " + condtn + " and if(de.brhid=0," + brcid + ",de.brhid)='" + brcid
                            + "' group by m.psrno  order by m.psrno";

                } else {

                    sql = "select at.mspecno as specid,m.part_no,m.productname,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,coalesce(m.fixingprice ,0) amount, "
                            + "coalesce(m.lbrchg,0) lbrchg,brd.brandname,m.brandid,m.stdprice, coalesce(spr.fprice,0) scopefprice , coalesce(spr.stdcost,0) scopestdcost "
                            + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
                            + "left join my_brand brd on brd.doc_no=m.brandid left join my_scopepr spr on spr.psrno=m.psrno and scpid="
                            + scopeid + " left join my_catm c on c.doc_no=m.catid "
                            + "where m.status=3 " + condtn + "  group by m.psrno  order by m.psrno";
                }

            } else {

                if (srvcProductBranchAvailability.equalsIgnoreCase("1")) {

                    sql = "select at.mspecno as specid,m.part_no,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,brd.brandname,m.brandid,m.stdprice,m.productname "
                            + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_brand brd on brd.doc_no=m.brandid "
                            + "left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
                            + "where m.status=3 " + condtn + "  group by m.psrno  order by m.psrno ";

                } else {

                    sql = "select at.mspecno as specid,m.part_no,m.productname prdname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,brd.brandname,m.brandid,m.stdprice,m.productname "
                            + "from my_main m left join my_unitm u on m.munit=u.doc_no left join my_brand brd on brd.doc_no=m.brandid "
                            + "left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 " + condtn
                            + "  group by m.psrno  order by m.psrno ";
                }

            }

            //// System.out.println("----searchProduct-sql---"+sql);

            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA = com.convertToJSON(resultSet);
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        }
////System.out.println(RESULTDATA);
        return RESULTDATA;
    }

    public JSONArray serviceRefGridLoad(HttpSession session, String doc_no, int surveyed) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";
            String brhid = session.getAttribute("BRANCHID").toString();
            if (surveyed > 0) {
                sql = "select s.sr_no siteid,site,s.doc_no,groupname stype,g.doc_no stypeid from cm_surveysd d left join my_groupvals g on(d.servid=g.doc_no and grptype='service') "
                        + "left join cm_surveysid s on(s.rdocno=d.rdocno) left join cm_surveym m on(m.doc_no=d.rdocno) left join gl_enqm em on(em.doc_no=m.refdocno)"
                        + " where em.doc_no='" + doc_no + "' ";

            } else {
                sql = "select  d.sr_no siteid,d.site from  gl_enqsited  d  where d.rdocno='" + doc_no + "'";
            }
            //// System.out.println("===service qot sql===="+sql);

            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray siteEstGridLoad(int surtrno, String reftype, String trno) throws SQLException {

        JSONArray RESULTDATA1 = new JSONArray();

        Connection conn = null;
        try {

            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";

            if (surtrno > 0 && !(reftype.equalsIgnoreCase("SRVE"))) {

                sql = "select sr_no sitesrno,site from cm_srvcsited where tr_no=" + surtrno + "";

            } else if (Integer.parseInt(trno) > 0 && reftype.equalsIgnoreCase("SRVE")) {

                sql = "select m.siteid sitesrno,st.site from cm_srvdetm m left join cm_srvcsited st on m.siteid=st.rowno where m.tr_no="
                        + trno + "";

            } else {
                return RESULTDATA1;
            }

            //// System.out.println("===sql==siteGridLoad=2="+sql);

            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray serviceEstLoad(HttpSession session, String enqno, String dtype) throws SQLException {
        JSONArray RESULTDATA1 = new JSONArray();
        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";
            String brhid = session.getAttribute("BRANCHID").toString();

            sql = "select d.site,d.sitesrno siteid,d.sertypeid stypeid,grp.groupname stype,concat(coalesce(d.description,''),' ',coalesce(m.part_no,'')) item,u.unit,"
                    + "d.unitid,d.qty,round(coalesce(d.nettotal/d.qty,0),2) amount,d.nettotal total,coalesce(d.description,'') desc1,d.psrno,d.scopeid,d.scopeamount,d.stdprice,"
                    + "d.lbrchg,d.scopestdcost,sp.scode scope from cm_estmprdd d "
                    + "left join cm_prjestm pm on pm.tr_no=d.tr_no left join my_main m on(d.psrno=m.doc_no and d.prdid=m.doc_no) "
                    + "left join my_unitm u on d.unitid=u.doc_no left join my_groupvals grp on grp.doc_no=d.sertypeid and grp.grptype='service' "
                    + "left join my_scope sp on sp.doc_no=d.scopeid where pm.reftrno='" + enqno + "' and pm.ref_type='"
                    + dtype + "' and pm.status=3 order by sr_no";

             //System.out.println("===serviceEstLoad===3===="+sql);

            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public JSONArray enquiryLoad(HttpSession session, String enqno, String dtype) throws SQLException {
        JSONArray RESULTDATA1 = new JSONArray();
        Connection conn = null;
        try {
            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql = "";
            String brhid = session.getAttribute("BRANCHID").toString();

            String resql = "select sr_no, desc1, qty, remarks,rdocno from gl_enqd eq where eq.rdocno='" + enqno + "'";
             //System.out.println("===enquiryLoad===1===="+resql);

            ResultSet resultSet1 = stmt.executeQuery(resql);
            RESULTDATA1 = com.convertToJSON(resultSet1);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return RESULTDATA1;
    }

    public ClsQuotationBean getViewDetails(HttpSession session, String msdocno, String brhid, String trno,
            String revision) throws SQLException {
        Enumeration<String> Enumeration = session.getAttributeNames();
        int a = 0;
        while (Enumeration.hasMoreElements()) {
            if (Enumeration.nextElement().equalsIgnoreCase("BRANCHID")) {
                a = 1;
            }
        }

        String brid = session.getAttribute("BRANCHID").toString();
        Connection conn = null;

        try {

            conn = conobj.getMyConnection();
            Statement stmt = conn.createStatement();
            int val = 0;
            String sql1 = "select coalesce(method,0) method from gl_config where field_nme='revisionConformation'";
            ResultSet resultset = stmt.executeQuery(sql1);
            if (resultset.next()) {
                val = resultset.getInt("method");
            }
            String Sql = "";
            if (val > 0 && (!(revision.equalsIgnoreCase("NaN")) && !(revision.equalsIgnoreCase("undefined"))
                    && !(revision.equalsIgnoreCase("")))) {
                Sql = ("select m.discounttick,m.TR_NO tr_no, m.DOC_NO doc_no, m.DATE date, m.refNo,m.dtype,m.ref_type reftype,refname,"
                        + "trim(ac.address) address,per_mob,trim(mail1) mail1,per_tel,m.subject,if(m.ref_type='ENQ',em.voc_no,if(m.ref_type='SRVE',srv.doc_no,m.refDocNo)) refVocNo,"
                        + "refDocNo, clrefNo,m.costType,m.cpersonid,"
                        + "m.cntr_type,ac.refname as name,"
                        + "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,m.cpersonid, "
                        + "trim(ac.address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,round(coalesce(legalchrg,0.0),2) legalchrg,cntr_type,"
                        + "sm.sal_name as salname,sm.doc_no as salid,m.revision_no,m.chklegal,m.sjobtype,m.thresholdlimit,m.partlimitperc,round(coalesce(r.netamount,m.netamount),2) as netAmount,round(coalesce(r.taxper,m.taxper),2) taxPer,round(coalesce(r.tax,m.tax),2) as tax,round(coalesce(r.amount,m.amount),2) as amount,round(coalesce(r.discount,m.discount),2) discount, round(coalesce(r.disper,m.disper),2) disper,round(coalesce(r.total,m.total),2) as total,round(coalesce(r.total,m.total),2) as total,round(coalesce(r.additionalamt,m.additionalamt),2) as additionalamt,m.notes from cm_srvqotm m left join cm_srvqotd d on d.tr_no=m.tr_no left join cm_srvqotmrev r on (r.qottrno=m.tr_no and r.revision_no='"
                        + revision + "') left join my_acbook ac "
                        + "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact cn on(cn.cldocno=m.cldocno and cn.row_no=m.cpersonid) left join gl_enqm em on "
                        + "m.refdocno=em.doc_no and m.ref_type='ENQ' and em.status=3 left join cm_srvdetm srv on srv.TR_no=m.refdocno and m.ref_type='SRVE' "
                        + "left join my_salm sm on(sm.doc_no=m.sal_id) where m.status!=7 and m.doc_no=" + msdocno
                        + " and m.brhid=" + brid + " and coalesce(d.revision_no,0)='" + revision + "'");
            } else {
                Sql = ("select m.discounttick,m.TR_NO tr_no, m.DOC_NO doc_no, m.DATE date,round(coalesce(m.netAmount,0.0),2) as netAmount, m.refNo,m.dtype,m.ref_type reftype,refname,"
                        + "trim(ac.address) address,per_mob,trim(mail1) mail1,per_tel,subject,if(m.ref_type='ENQ',em.voc_no,if(m.ref_type='SRVE',srv.doc_no,m.refDocNo)) refVocNo,"
                        + "refDocNo, clrefNo,round(coalesce(m.taxPer,0.0),2) taxPer,round(coalesce(m.tax,0.0),2) as tax,round(coalesce(amount,0.0),2) as amount,"
                        + "round(coalesce(discount,0.0),2) discount, round(coalesce(disPer,0.0),2) disper,m.costType,round(coalesce(total,0.0),2) as total,m.cpersonid,"
                        + "m.cntr_type,round(coalesce(m.additionalamt,0.0),2) additionalamt,ac.refname as name,"
                        + "ac.doc_no as clientid,cn.cperson,concat('MOB',':',cn.mob,';','Email',':',cn.email,';','Tele',':',cn.tel) contactdet,cn.row_no as cprowno,m.cpersonid, "
                        + "trim(ac.address) address,coalesce(per_mob,'') per_mob,trim(mail1) mail1,m.remarks remarks,round(coalesce(legalchrg,0.0),2) legalchrg,cntr_type,"
                        + "sm.sal_name as salname,sm.doc_no as salid,m.revision_no,m.chklegal,m.sjobtype,m.thresholdlimit,m.partlimitperc,m.notes from  cm_srvqotm m left join my_acbook ac "
                        + "on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact cn on(cn.cldocno=m.cldocno and cn.row_no=m.cpersonid) left join gl_enqm em on "
                        + "m.refdocno=em.doc_no and m.ref_type='ENQ' and em.status=3 left join cm_srvdetm srv on srv.TR_no=m.refdocno and m.ref_type='SRVE' "
                        + "left join my_salm sm on(sm.doc_no=m.sal_id) where m.status!=7 and m.doc_no=" + msdocno
                        + "  and m.brhid=" + brid + " ");

            }
//System.out.println("===getViewDetails===="+Sql);
            ResultSet rs = stmt.executeQuery(Sql);
            while (rs.next()) {
                bean.setMasterdoc_no(rs.getInt("tr_no"));
                bean.setClientid(rs.getInt("clientid"));
                bean.setTxtclient(rs.getString("name"));
                bean.setTxtclientdet(rs.getString("address"));
                bean.setTxtmob(rs.getString("per_mob"));
                bean.setTxtemail(rs.getString("mail1"));
                bean.setTxttel(rs.getString("per_tel"));
                bean.setCpersonid(rs.getInt("cpersonid"));
                bean.setTxtcontact(rs.getString("cperson"));
                bean.setTxtcontactdetails(rs.getString("contactdet"));
                bean.setCmbreftype(rs.getString("reftype"));
                bean.setHidcmbreftype(rs.getString("reftype"));
                bean.setTxtdcdamount(rs.getString("legalchrg"));
                bean.setTxtenquiry(rs.getString("refvocno"));
                bean.setEnquiryid(rs.getInt("refdocno"));
                bean.setHidradio(rs.getString("cntr_type"));
                bean.setTxtdesc1(rs.getString("remarks"));
                bean.setTxtsubject(rs.getString("subject"));
                bean.setTxtclientref(rs.getString("clrefno"));
                bean.setTxtgrtotal(rs.getString("amount"));
                bean.setTxtdisper(rs.getString("disper"));
                bean.setTxtdisamt(rs.getString("discount"));
                bean.setTxtadditionalamt(rs.getString("additionalamt"));
                bean.setTxttotalamt(rs.getString("total"));
                bean.setTxttaxper(rs.getString("taxper"));
                bean.setTxttaxamt(rs.getString("tax"));
                bean.setTxtnettotal(rs.getString("netamount"));
                bean.setTxtsalman(rs.getString("salname"));
                bean.setSalid(rs.getInt("salid"));
                bean.setHidradio(rs.getString("cntr_type"));
                bean.setTxtrefno(rs.getString("refno"));
                // bean.setTxtrevise(rs.getString("revision_no"));
                bean.setIslegaldoc(rs.getInt("chklegal"));
                bean.setHidcmbprocess(rs.getInt("sjobtype"));
                bean.setTxtthresholdlimit(rs.getString("thresholdlimit"));
                bean.setTxtpartlimitperc(rs.getString("partlimitperc"));
                bean.setTxtnotes(rs.getString("notes"));
                bean.setDiscounttick(rs.getString("discounttick"));
            }

        }

        catch (Exception e) {
            conn.close();
            e.printStackTrace();
        } finally {
            conn.close();
        }

        return bean;
    }

}
