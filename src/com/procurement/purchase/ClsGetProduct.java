package com.procurement.purchase;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsGetProduct {

    public JSONArray getProduct(ClsProduct bean, HttpSession session) throws SQLException {

        ClsCommon ClsCommon = new ClsCommon();
        ClsConnection ClsConnection = new ClsConnection();
        Connection conn = null;
        JSONArray prdarray = new JSONArray();
        JSONObject objprd = new JSONObject();
        System.out.println("on java");
        // Declaring Variables
        String acno = bean.getAcno();
        String dates = bean.getDates();
        String cmbbilltype = bean.getBilltype();
        String masterdocno = bean.getMasterdocno();
        String dtype = bean.getDtype();
        String reftype = bean.getReftype();
        String brcid = session.getAttribute("BRANCHID").toString();
        String presulttype = bean.getPresulttype();
        String loc = bean.getLoc();
        System.out.println("acno====" + acno);
        System.out.println("dates====" + dates);
        System.out.println("cmbbilltype====" + cmbbilltype);
        System.out.println("masterdocno====" + masterdocno);
        System.out.println("dtype====" + dtype);
        System.out.println("reftype====" + reftype);
        System.out.println("presulttype====" + presulttype);
        System.out.println("loc====" + loc);

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            Statement stmt1 = conn.createStatement();
            Statement stmtVeh = conn.createStatement();
            java.sql.Date masterdate = null;
            /*****Start Common***/
            if (!(dates.equalsIgnoreCase("undefined")) && !(dates.equalsIgnoreCase(""))
                    && !(dates.equalsIgnoreCase("0"))) {
                masterdate = ClsCommon.changeStringtoSqlDate(dates);

            }

            int method = 0, productconcat = 0;
            String sqltest = "";
            String chk4 = "select method  from gl_prdconfig where field_nme='productnameconcat'";
            ResultSet rs33 = stmtVeh.executeQuery(chk4);
            if (rs33.next()) {

                productconcat = rs33.getInt("method");
            }
            if (productconcat > 0) {
                sqltest = "concat(TRIM(m.productname),'-',bd.brandname,'-',dt.department)productname";
            } else {
                sqltest = "m.productname";
            }
            String chk = "select method  from gl_prdconfig where field_nme='Prosearch'";
            ResultSet rs = stmtVeh.executeQuery(chk);
            if (rs.next()) {

                method = rs.getInt("method");
            }

            int mulqty = 0;
            Statement stmt31 = conn.createStatement();

            String chk311 = "select method  from gl_prdconfig where field_nme='multiqty' ";
            ResultSet rss31 = stmt31.executeQuery(chk311);
            if (rss31.next()) {

                mulqty = rss31.getInt("method");
            }

            int tax = 0;
            Statement stmt3 = conn.createStatement();

            String chk31 = "select method  from gl_prdconfig where field_nme='tax' ";
            System.out.println("chk31==tax==" + chk31);

            ResultSet rss3 = stmt3.executeQuery(chk31);
            if (rss3.next()) {

                tax = rss3.getInt("method");
            }
            int temptax = 0;
            Statement stmt3111 = conn.createStatement();
            String sqlss = "select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"
                    + acno + "' ";
            System.out.println("===sqlss======" + sqlss);
            ResultSet rsss = stmt3111.executeQuery(sqlss);
            if (rsss.next()) {
                temptax = rsss.getInt("tax");

            }
            if (temptax != 1) {
                tax = 0;
            }

            String joinsql = "";
            String joinsql1 = "";

            String fsql = "";

            String outfsql = "";

            if (tax > 0) {
                if (Integer.parseInt(cmbbilltype) > 0) {

                    Statement pv = conn.createStatement();
                    int prvdocno = 0;
                    String dd = "select prvdocno from my_brch where doc_no='"
                            + session.getAttribute("BRANCHID").toString() + "' ";
                    System.out.println("===dd======" + dd);

                    ResultSet rs13 = pv.executeQuery(dd);
                    if (rs13.next()) {

                        prvdocno = rs13.getInt("prvdocno");
                    }

                    /*
                     * joinsql=
                     * joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"
                     * +masterdate+"' and todate>='"+masterdate+"' and provid='"
                     * +prvdocno+"' group by typeid  ) t1 on "
                     * +
                     * " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"
                     * +prvdocno+"'    ";
                     * 
                     * fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="
                     * +cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
                     * 
                     * outfsql=outfsql+ " taxper , ";
                     */

                    joinsql = joinsql
                            + " left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"
                            + masterdate + "' and todate>='" + masterdate + "' and provid='" + prvdocno
                            + "'   and type=1  and if(1=" + cmbbilltype + ",per,per)>0 group by typeid  ) t1 on "
                            + " t1.typeid=m.typeid   ";

                    fsql = fsql + " case when 1=" + cmbbilltype + "  then t1.per when 2=" + cmbbilltype
                            + "  then t1.per else 0 end as  'taxper' ,t1.taxdocno , ";

                    outfsql = outfsql + " taxper ,taxdocno, ";
                } else {
                    fsql = fsql + " 0 taxper ,0 taxdocno,'' tax_name,0 per,0 cstper, ";
                }

            } else {
                fsql = fsql + " 0 taxper ,0 taxdocno,'' tax_name,0 per,0 cstper, ";
            }

            int joinchk = 0;
            Statement stmt322 = conn.createStatement();

            String chk31111 = "select method  from gl_prdconfig where field_nme='prdjoinchk' ";
            ResultSet rss3111 = stmt322.executeQuery(chk31111);
            if (rss3111.next()) {

                joinchk = rss3111.getInt("method");
            }

            int superseding = 0;
            String chk11 = "select method  from gl_prdconfig where field_nme='superseding'";
            ResultSet rs11 = stmtVeh.executeQuery(chk11);
            if (rs11.next()) {

                superseding = rs11.getInt("method");
            }
            String sql001 = "";
            String sql002 = "";
            if (superseding == 1) {

                sql001 = " select s.part_no,m.* from (  ";
                sql002 = "  ) "
                        + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority ";

            }

            String sqjoin1 = "";
            String sqjoin2 = "";
            String joinsql2 = "";

            if (joinchk > 0) {
                sqjoin1 = " left join my_desc de on(de.psrno=m.doc_no)";
                sqjoin2 = " and de.discontinued=0  and  if(de.brhid=0," + brcid + ",de.brhid)='" + brcid + "' ";
            }

            String sql = "";
            if (mulqty > 0) {
                joinsql1 = ",d.unitid,d.specno ";
                joinsql2 = ",d.unitid,d.specno ";

            }
            
            
            int method1=0;
            String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
            ResultSet rs1=stmtVeh.executeQuery(chk1); 
            if(rs1.next())
                {
                            
                method1=rs1.getInt("method");
                }


            String sqlstest="";
                        
            if(method1>0)
            {
              sqlstest=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
            }
            /*****END Common***/
            if (dtype.equalsIgnoreCase("PIV")) {
                if (reftype.equalsIgnoreCase("GRN")) {
                    sql = "select taxper,taxdocno,method,brandname,specid,part_no,productname,doc_no,unit,unitdocno,psrno,unitprice,allowdiscount,qty,qutval,pqty,saveqty,foc,focqutval,focsaveqty,focpqty,discount,disper,nettotal,total,nettotal*taxper/100 taxperamt,nettotal+(nettotal*taxper/100) taxamount,orderdiscper,orderamount,stockid "
                            +
                            "from (" + sql001 + " select  " + fsql + " " + method
                            + " method,bd.brandname, at.mspecno as specid, m.part_no," + sqltest
                            + ",m.doc_no,u.unit,m.munit unitdocno,m.psrno,0 as allowdiscount,"
                            + " d.stockid,  sum(d.qty-d.out_qty)  qty,0 pqty,  sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty,d.amount unitprice,d.amount*sum(d.qty-d.out_qty) total,"
                            + " d.amount*sum(d.qty-d.out_qty)* d.disper/100 discount, d.disper, (d.amount*sum(d.qty-d.out_qty))-(d.amount*sum(d.qty-d.out_qty)*d.disper/100) nettotal,"
                            + " 0 foc, 0 focqutval, 0 focpqty, 0 focsaveqty, 0 orderdiscper, 0 orderamount "
                            + " from my_grnm m1 left join my_grnd d on d.tr_no=m1.tr_no left join my_main m on d.prdid=m.doc_no "
                            + " left join my_unitm u on m.munit=u.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
                            + " " + sqjoin1 + " " + joinsql + " where m.status=3 " + sqjoin2 + " " + sql002
                            + " and m1.brhid=" + brcid + " and m1.doc_no in (" + masterdocno + ")"
                            + " group by d.stockid having sum(d.qty-d.out_qty)>0)a";
                    System.out.println("PIV====GRN====" + sql);

                } else if (reftype.equalsIgnoreCase("PO")) {
                    sql = "select taxper,taxdocno,method,brandname,specid,part_no,productname,doc_no,unit,unitdocno,psrno,unitprice,allowdiscount,qty,qutval,pqty,saveqty,foc,focqutval,focsaveqty,focpqty,discount,disper,nettotal,total,nettotal*taxper/100 taxperamt,nettotal+(nettotal*taxper/100) taxamount,orderdiscper,orderamount,stockid\r\n"
                            +
                            "\r\n" +
                            "\r\n" +
                            " from (" + sql001 + " select  " + fsql + " " + method
                            + " method,bd.brandname, at.mspecno as specid, m.part_no," + sqltest
                            + ",m.doc_no,u.unit,m.munit unitdocno,m.psrno,if(rd.amount=0 or rd.amount IS NULL,case when '"
                            + masterdate
                            + "' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end,rd.amount) as unitprice,0 as allowdiscount,"
                            + " coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qty,coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qutval,  coalesce(sum(rd.out_qty),0) pqty,"
                            + " coalesce(sum(rd.qty-rd.out_qty),0) saveqty, coalesce(sum(rd.foc),0)-coalesce(sum(rd.foc_out),0) foc,coalesce(sum(rd.foc),0)-coalesce(sum(rd.foc_out),0) focqutval, coalesce(sum(rd.foc_out),0) focpqty,"
                            + " coalesce(sum(rd.foc-rd.foc_out),0) focsaveqty, (coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0))*rd.amount*rd.disper/100 discount,rd.disper,"
                            + " ((sum(rd.qty-rd.out_qty)*rd.amount)-(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100) nettotal,sum(rd.qty-rd.out_qty)*rd.amount total ,rd.disper orderdiscper,rd.amount orderamount,"
                            + " 0 stockid "
                            + " from my_ordm m1 left join my_ordd rd on rd.tr_no=m1.tr_no left join my_grnd d on m1.tr_no=d.tr_no left join my_main m  on rd.prdid=m.doc_no "
                            + " left join my_unitm u on m.munit=u.doc_no  left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
                            + " " + sqjoin1 + " " + joinsql + " where m.status=3 and m1.status=3 and rd.clstatus=0 "
                            + sqjoin2 + " " + sql002 + " and m1.brhid=" + brcid + " and rd.tr_no in (" + masterdocno
                            + ") and rd.qty-rd.out_qty>0"
                            + " group by rd.prdid,rd.amount,rd.disper order by rd.prdid,rd.rowno)a";

                    System.out.println("PIV====PO====" + sql);

                } else {
                    sql = "" + sql001 + " select  " + fsql + " " + method
                            + " method,bd.brandname, at.mspecno as specid, m.part_no," + sqltest
                            + ",m.doc_no,u.unit,m.munit unitdocno,m.psrno,case when '" + masterdate
                            + "' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice,0 as allowdiscount,"
                            + " 0 stockid, 0 qty, 0 pqty, 0 qutval, 0 saveqty, 0 total, 0 disper, 0 discount, 0 nettotal, 0 foc, 0 focqutval, 0 focpqty, 0 focsaveqty, 0 orderdiscper, 0 orderamount,0 taxamount,0 taxperamt "
                            + " from my_main m left join my_unitm u on m.munit=u.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
                            + " " + sqjoin1 + " " + joinsql + " where m.status=3 " + sqjoin2 + " " + sql002;
                    System.out.println("PIV====DIR====" + sql);

                }

                ResultSet rss = stmt.executeQuery(sql);
                if (presulttype.equalsIgnoreCase("1")) {
                    while (rss.next()) {
                        JSONObject objpro = new JSONObject();
                        objpro.put("part_no", rss.getString("part_no"));
                        objpro.put("brandname", rss.getString("brandname"));
                        objpro.put("psrno", rss.getString("psrno"));
                        objpro.put("specid", rss.getString("specid"));
                        objpro.put("unitdocno", rss.getString("unitdocno"));

                        objpro.put("unitprice", rss.getString("unitprice"));

                        objpro.put("taxdocno", rss.getString("taxdocno"));
                        objpro.put("taxper", rss.getString("taxper"));
                        objpro.put("unit", rss.getString("unit"));
                        objpro.put("productname", rss.getString("productname"));
                        objpro.put("allowdiscount", rss.getString("allowdiscount"));

                        objpro.put("stockid", rss.getString("stockid"));
                        objpro.put("qty", rss.getString("qty"));
                        objpro.put("pqty", rss.getString("pqty"));
                        objpro.put("qutval", rss.getString("qutval"));
                        objpro.put("saveqty", rss.getString("saveqty"));
                        objpro.put("total", rss.getString("total"));
                        objpro.put("disper", rss.getString("disper"));
                        objpro.put("discount", rss.getString("discount"));
                        objpro.put("nettotal", rss.getString("nettotal"));
                        objpro.put("foc", rss.getString("foc"));
                        objpro.put("focqutval", rss.getString("focqutval"));
                        objpro.put("focpqty", rss.getString("focpqty"));
                        objpro.put("focsaveqty", rss.getString("focsaveqty"));
                        objpro.put("orderdiscper", rss.getString("orderdiscper"));
                        objpro.put("orderamount", rss.getString("orderamount"));
                        objpro.put("taxamount", rss.getString("taxamount"));
                        objpro.put("taxperamt", rss.getString("taxperamt"));

                        prdarray.add(objpro);

                    }
                } else {
                    prdarray = ClsCommon.convertToJSON(rss);
                }

            } else if (dtype.equalsIgnoreCase("GRN")) {
                if (reftype.equalsIgnoreCase("DIR")) {

                    if (superseding == 1) {
                        /*
                         * String fleetsql="select s.part_no,m.* from( select  "
                         * +method+" method,bd.brandname,dt.department, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno"
                         * +joinsql+" from my_main m left join  "
                         * +
                         * " my_unitm u on m.munit=u.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
                         * +
                         * "   left join my_desc de on(de.psrno=m.doc_no)    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"
                         * +brcid+",de.brhid)='"+brcid+"'  ) "
                         * +
                         * "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "
                         * ;
                         */

                        sql = "select s.part_no,m.* from( select " + fsql + "  " + method
                                + " method,bd.brandname,0 qty,dt.department, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno"
                                + joinsql + " from my_main m left join  "
                                + " my_unitm u on m.munit=u.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
                                + "   left join my_desc de on(de.psrno=m.doc_no)    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"
                                + brcid + ",de.brhid)='" + brcid + "'  ) "
                                + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno " + joinsql
                                + "  where   s.discontinued=0   order by s.psrno,s.priority  ";

                        System.out.println("----main1---" + sql);

                        stmtVeh.close();
                    }

                    else {
                        sql = "select " + fsql + " " + method
                                + " method,bd.brandname,dt.department,0 qty, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno"
                                + joinsql
                                + ",'' checktype,'' refrowno,m.part_no proid,m.part_no productid,m.productname proname,0 sr_no,m.part_no prodoc,u.doc_no unitdocno,0 qutval,0 saveqty,0 unitprice,0 discount,0 disper from my_main m left join  "
                                + " my_unitm u on m.munit=u.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_desc de on(de.psrno=m.doc_no) "
                                + joinsql + "  "
                                + " where m.status=3 and de.discontinued=0  and  if(de.brhid=0," + brcid
                                + ",de.brhid)='" + brcid + "' group by m.psrno  ";

                        System.out.println("-----fleetsql---" + sql);

                        stmtVeh.close();
                    }
                } else {
                    System.out.println("fsql : " + fsql);
                    sql = "select " + fsql + " " + method
                            + " method,dt.department, bd.brandname,d.rowno refrowno, 'pro' checktype ,at.mspecno as specid,m.part_no productid,m.munit,m.doc_no,m.productname,m.part_no proid ,m.part_no,m.productname proname "
                            + joinsql + ",d.sr_no,d.psrno,\r\n" +
                            "d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,\r\n"
                            +
                            "sum(d.qty-d.out_qty) saveqty,\r\n" +
                            "d.amount unitprice,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discount,d.disper from my_ordd d\r\n"
                            +
                            " left join my_main m on m.doc_no=d.prdId left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on d.unitid=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
                            + " where d.tr_no in (" + masterdocno + ") and  d.clstatus=0 group by d.prdid" + joinsql1
                            + ",d.amount,d.discount having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno ";
                    System.out.println("PO sql : " + sql);
                }
                ResultSet rss = stmt.executeQuery(sql);
                if (presulttype.equalsIgnoreCase("1")) {
                    while (rss.next()) {
                        JSONObject objpro = new JSONObject();
                        objpro.put("method", rss.getString("method"));
                        objpro.put("brandname", rss.getString("brandname"));
                        objpro.put("department", rss.getString("department"));
                        objpro.put("specid", rss.getString("specid"));
                        objpro.put("part_no", rss.getString("part_no"));
                        objpro.put("productname", rss.getString("productname"));
                        objpro.put("doc_no", rss.getString("doc_no"));
                        objpro.put("unit", rss.getString("unit"));
                        objpro.put("munit", rss.getString("munit"));
                        objpro.put("psrno", rss.getString("psrno"));
                        objpro.put("taxper", rss.getString("taxper"));
                        objpro.put("taxdocno", rss.getString("taxdocno"));
                        objpro.put("tax_name", rss.getString("tax_name"));
                        // objpro.put("per", rss.getString("per"));
                        // objpro.put("cstper", rss.getString("cstper"));
                        objpro.put("checktype", rss.getString("checktype"));
                        objpro.put("refrowno", rss.getString("refrowno"));
                        objpro.put("proid", rss.getString("proid"));
                        objpro.put("productid", rss.getString("productid"));
                        objpro.put("proname", rss.getString("proname"));
                        objpro.put("prodoc", rss.getString("prodoc"));
                        objpro.put("unitdocno", rss.getString("unitdocno"));
                        objpro.put("qutval", rss.getString("qutval"));
                        objpro.put("saveqty", rss.getString("saveqty"));
                        objpro.put("unitprice", rss.getString("unitprice"));
                        objpro.put("discount", rss.getString("discount"));
                        objpro.put("disper", rss.getString("disper"));
                        objpro.put("qty", rss.getString("qty"));
                        prdarray.add(objpro);
                    }
                } else {
                    prdarray = ClsCommon.convertToJSON(rss);
                }
            } else if (dtype.equalsIgnoreCase("GRR")) {
                sql = "select  " + method
                        + " method,bd.brandname,dt.department,mm.brhid,d.stockid,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,d.unitid munit,m.psrno, "
                        + "   sum(d.qty)/sum(dd.fr) mainqty,sum(dd.foc-dd.foc_out)/sum(dd.fr) foc,sum(dd.foc-dd.foc_out)/sum(dd.fr) maxfoc,"
                        + "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr)  qty,  "
                        + "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr) qutval,sum(d.out_qty)  pqty, "
                        + "  sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/sum(dd.fr) saveqty"
                        + joinsql1 + "  "
                        + "  from  my_grnm  mm left join  my_grnd d on mm.tr_no=d.tr_no left join my_prddin dd  "
                        + "  on dd.tr_no=d.tr_no and dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid "
                        + joinsql2 + " "
                        + "  and mm.brhid=dd.brhid  left join my_main m on m.doc_no=d.prdId left join my_dept dt on m.deptid=dt.doc_no and dt.status=3  left join my_unitm u on d.unitid=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
                        + "  left join my_prodattrib at    on(at.mpsrno=m.doc_no)   where mm.status=3 and mm.brhid='"
                        + brcid + "' and  mm.doc_no in (" + masterdocno + ")  "
                        + "  group by d.stockid,d.prdId" + joinsql1
                        + " having sum(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0  order by dd.date,d.rowno";
                System.out.println("GRR sql : " + sql);
                ResultSet rss = stmt.executeQuery(sql);
                if (presulttype.equalsIgnoreCase("1")) {
                    System.out.println("test on grr");
                    while (rss.next()) {
                        JSONObject objpro = new JSONObject();
                        objpro.put("part_no", rss.getString("part_no"));
                        objpro.put("productname", rss.getString("productname"));
                        objpro.put("doc_no", rss.getString("doc_no"));
                        objpro.put("unit", rss.getString("unit"));
                        objpro.put("unitdocno", rss.getString("munit"));
                        objpro.put("psrno", rss.getString("psrno"));
                        objpro.put("specid", rss.getString("specid"));
                        objpro.put("brandname", rss.getString("brandname"));
                        objpro.put("qty", rss.getString("qty"));
                        objpro.put("qutval", rss.getString("qutval"));
                        objpro.put("stockid", rss.getString("stockid"));
                        prdarray.add(objpro);

                    }
                } else {
                    prdarray = ClsCommon.convertToJSON(rss);

                }

            }else if(dtype.equalsIgnoreCase("PIR")) {
                sql="select productid part_no,taxper,taxdocno,brandname,checktype,maxfoc,stockid,specid,productid,productname,proid,rdtype,proname,sr_no,psrno,prodoc,unit,unitdocno,pqty,mainqty,qty,qutval,saveqty,unitprice,total,discount,discper,total*taxper/100 taxamount,(total+(total*taxper/100)) taxamountstotal,nettotal from (select "+fsql+" bd.brandname,'pro' checktype,if(mm.rdtype='GRN',0,d.foc-d.foc_out) maxfoc,d.stockid,at.mspecno specid,m.part_no productid,m.productname,m.part_no proid ,dd.dtype rdtype,  "
                        + " m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.out_qty) pqty,sum(d.qty) mainqty, "
                        + " sum(d.qty)-sum(d.out_qty)  qty, "
                        + " sum(d.qty)-sum(d.out_qty) qutval,sum(d.qty)-sum(d.out_qty)  saveqty,d.amount unitprice,d.amount*(sum(d.qty)-sum(d.out_qty))   total, "
                        + "d.amount*(sum(d.qty)-sum(d.out_qty))*d.disper/100 discount, "
                        + " d.disper discper,(d.amount*(sum(d.qty)-sum(d.out_qty)))-(d.amount*(sum(d.qty)-sum(d.out_qty))*d.disper/100) nettotal "
                        + "   from  my_srvm  mm left join my_srvd d  on mm.tr_no=d.tr_no  left join my_prddin dd on dd.stockid=d.stockid   "
                        + " and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno left join my_main m on m.doc_no=d.prdId  "
                        + " left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no   "
                        + "     "+joinsql+"   where  mm.doc_no in ("+masterdocno+")     group by d.stockid"+joinsql1+"   having sum(d.qty)-(sum(d.out_qty))>0)a  ";
                System.out.println("PIR : "+sql);
                ResultSet rss = stmt.executeQuery(sql);
                if (presulttype.equalsIgnoreCase("1")) {
                    while (rss.next()) {
                        JSONObject objpro = new JSONObject();
                        objpro.put("taxper", rss.getString("taxper"));
                        objpro.put("brandname", rss.getString("brandname"));
                        objpro.put("checktype", rss.getString("checktype"));
                        objpro.put("maxfoc", rss.getString("maxfoc"));
                        objpro.put("stockid", rss.getString("stockid"));
                        objpro.put("specid", rss.getString("specid"));
                        objpro.put("productid", rss.getString("productid"));
                        objpro.put("productname", rss.getString("productname"));
                        objpro.put("proid", rss.getString("proid"));
                        objpro.put("rdtype", rss.getString("rdtype"));
                        objpro.put("proname", rss.getString("proname"));
                        objpro.put("psrno", rss.getString("psrno"));
                        objpro.put("prodoc", rss.getString("prodoc"));
                        objpro.put("unit", rss.getString("unit"));
                        objpro.put("unitdocno", rss.getString("unitdocno"));
                        objpro.put("pqty", rss.getString("pqty"));
                        objpro.put("mainqty", rss.getString("mainqty"));
                        objpro.put("qty", rss.getString("qty"));
                        objpro.put("qutval", rss.getString("qutval"));
                        objpro.put("saveqty", rss.getString("saveqty"));
                        objpro.put("unitprice", rss.getString("unitprice"));
                        objpro.put("total", rss.getString("total"));
                        objpro.put("nettotal", rss.getString("nettotal"));
                        objpro.put("discount", rss.getString("discount"));
                        objpro.put("discper", rss.getString("discper"));
                        objpro.put("taxamount", rss.getString("taxamount"));
                        objpro.put("taxamountstotal", rss.getString("taxamountstotal"));
                        prdarray.add(objpro);
                    }
                } else {
                    prdarray = ClsCommon.convertToJSON(rss);
                }
                System.out.println("PrdArray : "+prdarray);
            }else if(dtype.equalsIgnoreCase("PR")) {
                sql="select  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from  my_main m left join  my_unitm u on m.munit=u.doc_no  left join my_catm c on c.doc_no=m.catid left join my_prodattrib at on(at.mpsrno=m.doc_no)    left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no  left join my_scatm sc on m.scatid=sc.doc_no   where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' ";
                System.out.println("PR : "+sql);
                ResultSet rss = stmt.executeQuery(sql);
                if (presulttype.equalsIgnoreCase("1")) {
                    while(rss.next()) {
                        JSONObject objpro = new JSONObject();
                        objpro.put("method", rss.getString("method"));
                        objpro.put("brandname", rss.getString("brandname"));
                        objpro.put("specid", rss.getString("specid"));
                        objpro.put("part_no", rss.getString("part_no"));
                        objpro.put("productname", rss.getString("productname"));
                        objpro.put("doc_no", rss.getString("doc_no"));
                        objpro.put("unit", rss.getString("unit"));
                        objpro.put("munit", rss.getString("munit"));
                        objpro.put("psrno", rss.getString("psrno"));
                        prdarray.add(objpro);
                    }
                }else {
                    prdarray = ClsCommon.convertToJSON(rss);
                }

            }else if(dtype.equalsIgnoreCase("PO")) {
                if(reftype.equalsIgnoreCase("DIR")) {
                    if(superseding==1) {
                        sql=" select s.part_no,m.* from (  select  "+fsql+" "+method+" method,bd.brandname,'' checktype,m.part_no productid,0 qty,0 unitprice,m.part_no proid,m.productname proname,0 sr_no, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit unitdocno,m.psrno,0 prodoc,0 unitdocno,0 qutval,0 saveqty from my_main m left join  "
                                + " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
                                + "   left join my_desc de on(de.psrno=m.doc_no)  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
                                + "   where m.status=3  and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  ) "
                                + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "    ;

                    }else {
                        sql="select  "+fsql+" "+method+" method,bd.brandname,'' checktype,m.part_no productid,m.part_no proid,m.productname proname, at.mspecno as specid,0 qty,0 unitprice,0 sr_no, m.part_no,m.productname,m.doc_no,u.unit,m.munit unitdocno,m.psrno,0 prodoc,0 unitdocno,0 qutval,0 saveqty from my_main m left join  "
                                + " my_unitm u on m.munit=u.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
                                + "      left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
                                + "   where m.status=3 "    ;

                    }
                    System.out.println("PO====DIR===:"+sql);
                }else if(reftype.equalsIgnoreCase("PR")) {
                    sql="select "+fsql+" bd.brandname,'pro' checktype,'' doc_no,at.mspecno specid,m.part_no productid,m.part_no part_no,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty  from my_reqd d " + 
                            "left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)"
                            + " left join  my_brand bd on m.brandid=bd.doc_no  "+sqlstest+"    "+joinsql+"   where d.tr_no in ("+masterdocno+")  group by d.prdId"+joinsql1+"  having sum(d.qty-d.out_qty)>0";
                            System.out.println("PO====PR===:"+sql);

                }
                ResultSet rss = stmt.executeQuery(sql);
                if(presulttype.equalsIgnoreCase("1")) {
                    while(rss.next()) {
                        JSONObject objpro = new JSONObject();
                        objpro.put("taxper", rss.getString("taxper"));
                        objpro.put("taxdocno", rss.getString("taxdocno"));
                        objpro.put("brandname", rss.getString("brandname"));
                        objpro.put("specid", rss.getString("specid"));
                        objpro.put("part_no", rss.getString("part_no"));
                        objpro.put("productname", rss.getString("productname"));
                        objpro.put("doc_no", rss.getString("doc_no"));
                        objpro.put("unit", rss.getString("unit"));
                        objpro.put("psrno", rss.getString("psrno"));
                        objpro.put("qty", rss.getString("qty"));
                        objpro.put("checktype", rss.getString("checktype"));
                        objpro.put("productid", rss.getString("productid"));
                        objpro.put("proid", rss.getString("proid"));
                        objpro.put("proname", rss.getString("proname"));
                        objpro.put("sr_no", rss.getString("sr_no"));
                        objpro.put("prodoc", rss.getString("prodoc"));
                        objpro.put("unitdocno", rss.getString("unitdocno"));
                        objpro.put("qutval", rss.getString("qutval"));
                        objpro.put("saveqty", rss.getString("saveqty"));
                        prdarray.add(objpro);
                    }
                }else {
                    prdarray = ClsCommon.convertToJSON(rss);
                }
                //System.out.println("prdddata : "+prdarray);
            }

        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {
            conn.close();
        }

        return prdarray;

    }

}
