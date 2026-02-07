package com.dashboard.procurment.purchasemgmnt;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPurchasemgmntDAO {

    ClsConnection ClsConnection = new ClsConnection();
    ClsCommon ClsCommon = new ClsCommon();

    public JSONArray enquirylistsearch(HttpSession session, String brnchval, String fromdate, String todate, String id,
            String widgetname) throws Exception {
        JSONArray RESULTDATA = new JSONArray();
        if (!id.equalsIgnoreCase("1")) {
            return RESULTDATA;
        }
        Connection conn = null;
        Statement stmt = null;
        ResultSet resultSet = null;
        String sqltest = "", sqltest2 = "", sqlsalman = "", sqlselect1 = "", sqlselect2 = "", sqljoin = "";

        conn = ClsConnection.getMyConnection();
        stmt = conn.createStatement();
        java.sql.Date sqlfromdate = null;
        if (!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase(""))
                && !(fromdate.equalsIgnoreCase("0"))) {
            sqlfromdate = ClsCommon.changeStringtoSqlDate(fromdate);
        } else {
        }
        java.sql.Date sqltodate = null;
        if (!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase(""))
                && !(todate.equalsIgnoreCase("0"))) {
            sqltodate = ClsCommon.changeStringtoSqlDate(todate);
        } else {
        }
        if (!(brnchval.equalsIgnoreCase("a")) && !(brnchval.equalsIgnoreCase("0"))
                && !(brnchval.equalsIgnoreCase(""))) {
            sqltest += " and mm.brhid=" + brnchval;
        } else {
        }

        String sql = "";
        if (widgetname.equalsIgnoreCase("purchasereqsdiv")) {
            sql = "select   case when 1=1  then t1.per when 2=0  then t1.cstper else 0 end as  'hidtax' ,mm.brhid brhid,bb.branchname branchname, t1.taxdocno , 0 taxper, (d.qty-d.out_qty) chkqty,u.doc_no unitdoc,m.psrno,at.mspecno specid,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty   from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join   my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)     left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"
                    + sqlfromdate + "' and todate>='" + sqltodate
                    + "' and provid='1'  and type=1 and if(1=1,per,cstper)>0  group by typeid  ) t1 on  t1.typeid=m.typeid left  join my_brch bb on bb.doc_no=mm.brhid    where    mm.status=3  "
                    + sqltest + " and mm.DATE between '"+sqlfromdate+"' and '"+sqltodate+"'   having  chkqty>0 order by mm.voc_no";
            System.out.println("PR sql : "+sql);

            resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);

        } else if (widgetname.equalsIgnoreCase("purchaseordddiv")) {
            sql = "select mm.rrefno,mm.tr_no,mm.brhid brhid,bb.branchname branchname,mm.doc_no doc_no,0 foc,h.doc_no acno,at.mspecno specid,'pro' checktype ,d.psrno psrno,m.part_no proid ,m.productname proname,(d.qty-d.out_qty) saveqty,(d.qty-d.out_qty) qutval,d.rowno refrowno,d.amount unitprice,bd.brandname,case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype ,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus,   h.account,h.description acname,   m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper, d.taxamount, d.nettaxamount,   d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total total,convert(if(d.disper=0,'0.00',d.disper),char(30)) disper,  convert(if(d.discount=0,'0.00',d.discount),char(30)) discount,d.nettotal,coalesce(cancelamt,0) cancelamt    from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left  join my_brch bb on bb.doc_no=mm.brhid left join  my_brand bd on m.brandid=bd.doc_no  left join my_head h on h.doc_no=mm.acno left join( select psrno,rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d  where clstatus=1 group by rdocno,psrno)  ss on ss.rdocno=mm.doc_no and ss.psrno=d.psrno  left join my_prodattrib at on(at.mpsrno=m.doc_no) where mm.DATE between  '"+sqlfromdate+"' and  '" + sqltodate + "' " + sqltest +" and  mm.status=3 and d.out_qty=0 order by mm.doc_no";
            System.out.println("order : "+sql);
            resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
        } else if (widgetname.equalsIgnoreCase("grendiv")) {
            int mulqty=0;
            Statement stmt31 = conn.createStatement (); 
         
            String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
            ResultSet rss31=stmt31.executeQuery(chk311); 
            if(rss31.next())
            {

                mulqty=rss31.getInt("method");
            }
            
            String joinsqls="";
            String joinsqls1="";
            if(mulqty>0)
            {
                joinsqls=" group by d.unitid,d.specno ";
                joinsqls1=" and aa.unitid=d.unitid and  aa.specno=d.specno ";
                
            }
            
            String pySql="select mm.brhid brhid,bb.branchname branchname,d.stockid,mm.locid locid,bd.brandname,mm.brhid brhid,mm.voc_no voc_no,mm.doc_no doc_no,h.doc_no acno,h.account account,h.description acname,0 refrowno,at.mspecno as specid,mm.rdtype,mm.rrefno,m.part_no productid, "
                    + "  m.productname,dd.foc-dd.foc_out/dd.fr foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,  "
                    + " u.unit, d.unitid unitdocno,dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)/dd.fr qutval,  "
                    + " d.out_qty pqty,   dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out)/dd.fr saveqty, "
                    + " d.qty,d.amount unitprice,d.total,d.discount,d.disper, d.nettotal,d.prdid   from my_grnm mm  "
                    + " left join my_grnd d on mm.tr_no=d.tr_no   left join my_main m on m.doc_no=d.prdId  "
                    + "  left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_head h on h.doc_no=mm.acno left  join my_brch bb on bb.doc_no=mm.brhid  left join my_prddin dd on dd.tr_no=d.tr_no and dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid"
                    + " where mm.date between '"+ sqlfromdate +"' and  '" + sqltodate+"' "+sqltest+" and d.qty>0 and d.out_qty=0  "
                    + "      "+joinsqls+" order by mm.doc_no  ";
            
            
            
            
           /* String pySql="select mm.brhid brhid,bb.branchname branchname,d.stockid,mm.locid locid,bd.brandname,mm.brhid brhid,mm.voc_no doc_no,h.doc_no acno,h.account account,h.description acname,aa.rowno refrowno,at.mspecno as specid,mm.rdtype,mm.rrefno,m.part_no productid, "
                    + "  m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,  "
                    + " u.unit, d.unitid unitdocno,if(mm.rdtype='DIR',0,sum(coalesce(aa.qty,0)-coalesce(aa.out_qty,0))+d.qty) qutval,  "
                    + " if(mm.rdtype='DIR',0,(sum(coalesce(aa.out_qty,0))-d.qty)) pqty,   if(mm.rdtype='DIR',0,sum(coalesce(aa.out_qty,0))) saveqty, "
                    + " d.qty,d.amount unitprice,d.total,d.discount,d.disper, d.nettotal,d.prdid   from my_grnm mm  "
                    + " left join my_grnd d on mm.tr_no=d.tr_no   left join my_main m on m.doc_no=d.prdId  "
                    + "  left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_head h on h.doc_no=mm.acno left  join my_brch bb on bb.doc_no=mm.brhid"
                    + "  left join (select  prdid,amount,qty,out_qty,rowno,discount,disper,clstatus,unitid,specno from  my_ordd   where  clstatus=0 ) aa "
                    + "  on aa.prdid=d.prdid and aa.amount=d.amount and aa.disper=d.disper "+joinsqls1+"  where mm.date between '"+ sqlfromdate +"' and  '" + sqltodate+"' "+sqltest+" and d.qty>0 and d.out_qty=0  "
                    + "     group by d.prdid"+joinsqls+",aa.amount,aa.discount order by d.prdid,aa.rowno  ";*/
            
            
            
            /*
             * sql =
             * " select m1.locid locid,bb.branchname branchname,m1.brhid brhid,dd.foc_out focout,dd.foc focd,dd.rsv_qty rsvqty,(dd.op_qty-(dd.out_qty+dd.del_qty)) qty1,dd.op_qty,dd.out_qty,dd.del_qty, m1.voc_no doc_no,h.doc_no acno,h.account account,h.description acname,0 oldfoc,(dd.foc-dd.foc_out) maxfoc,'pro' checktype,d.stockid stockid,d.qty oldqty,sum(d.qty) mainqty,bd.brandname,aa.rowno refrowno,at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid,   m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,   u.unit, d.unitid unitdocno,(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/(dd.fr) qutval,(dd.foc-dd.foc_out)/(dd.fr) foc,sum(d.out_qty) pqty,  (dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/(dd.fr)saveqty, d.qty,d.amount unitprice,d.total,d.discount,d.disper, d.nettotal,d.prdid from my_grnm m1   left join my_grnd d on m1.tr_no=d.tr_no left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno left join my_main m on m.doc_no=d.prdId    left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_brch bb on bb.doc_no=m1.brhid left join  my_brand bd on m.brandid=bd.doc_no left join my_head h on h.doc_no=m1.acno   left join (select  prdid,amount,qty,out_qty,rowno,discount,disper,clstatus,unitid,specno from  my_ordd   where clstatus=0 ) aa   on aa.prdid=d.prdid and aa.amount=d.amount and aa.disper=d.disper and aa.unitid=d.unitid and  aa.specno=d.specno where '"
             * + sqlfromdate + "' and  '" + sqltodate+"' " + sqltest
             * +"  and  m1.status=3 and dd.pstatus=0 group by m1.doc_no  having (dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0"
             * ;
             */            System.out.println("GRN " + pySql);

            resultSet = stmt.executeQuery(pySql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);

        } else if (widgetname.equalsIgnoreCase("pivdiv")) {
            sql = "select h.description acname,mm.brhid brhid,mm.voc_no,bb.branchname branchname,mm.doc_no,h.description description,mm.acno,'pro' checktype,d.stockid, d.BATCHNO batch_no,d.bExpiry exp_date, bd.brandname,din.cost_price,aa.rowno refrowno,at.mspecno as specid,mm.rdtype,mm.rrefno,m.part_no productid,  m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,   u.unit, d.unitid unitdocno,sum(coalesce(aa.qty,0)-coalesce(aa.out_qty,0))+d.qty qutval, sum(coalesce(aa.out_qty,0))-d.qty pqty,  sum(coalesce(aa.out_qty,0)) saveqty, d.qty,d.amount unitprice,d.total,d.discount,d.disper discper,   d.nettotal,d.prdid,aa.disper orderdiscper,aa.amount orderamount,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount,d.taxdocno from my_srvm mm left join my_srvd d on mm.tr_no=d.tr_no  left join my_main m on m.doc_no=d.prdId   left join my_unitm u on d.unitid=u.doc_no   left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no      left join my_prddin din   on din.stockid=d.stockid and din.prdid=d.prdid and din.specno=d.specno  left join (select  prdid,amount,qty,out_qty,rowno,discount,disper,clstatus,unitid,specno  from  my_ordd    where clstatus=0 ) aa    on aa.prdid=d.prdid and aa.amount=d.amount    and aa.disper=d.disper left join my_grnd dd on dd.stockid=d.stockid and dd.prdid=d.prdid and dd.specno=d.specno left join my_head h on h.doc_no=mm.acno left  join my_brch bb on bb.doc_no=mm.brhid  "
                    + "where mm.date between '"+ sqlfromdate + "' and '" + sqltodate + "' " + sqltest+ "  and mm.status=3 and  din.op_qty>0 and din.out_qty=0  group by d.stockid order by mm.doc_no";
            System.out.println("PIV " + sql);

            resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);

        } else if (widgetname.equalsIgnoreCase("pirdiv")) {
            sql = "select bd.brandname,dd.dtype rdtype,if(dd.dtype='GRN',0,sum(dd.foc-dd.foc_out)+d.foc) maxfoc,dd.date,d.stockid,at.mspecno as specid,  mm.rrefno,m.part_no productid,m.productname,d.foc ,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,  u.unit, d.unitid unitdocno,   if(mm.rdtype='DIR',0,(pd.qty-pd.out_qty)+d.qty) qutval,  if(mm.rdtype='DIR',0,sum(((dd.out_qty+dd.del_qty+dd.rsv_qty-dd.foc_out)/dd.fr)-d.qty)) pqty,  if(mm.rdtype='DIR',0,(sum((dd.out_qty+dd.del_qty+dd.rsv_qty-dd.foc_out)/dd.fr))) saveqty,  if(mm.rdtype='DIR',0,(sum(dd.op_qty-dd.foc)/dd.fr)) mainqty,d.qty,d.qty oldqty,d.foc oldfoc,d.amount unitprice,d.disper discper,  d.total,d.discount,d.nettotal,d.taxper,d.taxamount taxperamt,d.nettaxamount taxamount from my_srrm mm  left join my_srrd d on mm.tr_no=d.tr_no  left join my_main m on m.doc_no=d.prdId left join my_srvd pd on pd.stockid=d.stockid  left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no   left join   my_prddin  dd on    dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and mm.brhid=dd.brhid    where mm.date between '"
                    + sqlfromdate + "' and '" + sqltodate + "' and mm.status=3 " + sqltest
                    + " group by   d.rowno,d.prdid order by mm.doc_no";
            
            System.out.println("PIR " + sql);

            resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);

        } else if (widgetname.equalsIgnoreCase("grrdiv")) {
            sql = "select bd.brandname,dd.date,d.stockid,dd.op_qty,dd.out_qty,if(dd.dtype='DIR',0,(sum(dd.foc-dd.foc_out)/sum(dd.fr))+d.foc) maxfoc,   at.mspecno as specid,mm.rdtype,mm.rrefno,m.part_no productid,m.productname,d.foc,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,    m.productname proname,   u.unit, d.unitid unitdocno,     if(mm.rdtype='DIR',0,(((sum((dd.op_qty)-(dd.out_qty+dd.del_qty+dd.rsv_qty+dd.foc-dd.foc_out)))/sum(dd.fr))+d.qty)) qutval,   if(mm.rdtype='DIR',0,((sum(dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out)/sum(dd.fr))-d.qty))  pqty,    if(mm.rdtype='DIR',0,(sum((dd.out_qty+dd.del_qty+dd.rsv_qty-foc_out))/sum(dd.fr))) saveqty,   if(mm.rdtype='DIR',0,(sum(dd.op_qty-dd.foc)/sum(dd.fr))) mainqty,  d.qty,d.qty oldqty,d.foc oldfoc,d.amount unitprice,d.total,d.discount,d.nettotal from my_grrm mm  left join my_grrd d on mm.tr_no=d.tr_no   left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no    left join   my_prddin  dd on   dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and mm.brhid=dd.brhid     where  mm.date between '"
                    + sqlfromdate + "' and '" + sqltodate + "' and mm.status=3 " + sqltest
                    + " group by  dd.stockid order by dd.date,d.rowno";
            System.out.println("GRR " + sql);

            resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
        }

        stmt.close();
        resultSet.close();
        conn.close();
        return RESULTDATA;

    }

    public JSONArray getPrDetails(String fromdate, String todate, String docno, String branchval, String prdid,String id,HttpSession session,String vndtax) throws Exception {


        JSONArray RESULTDATA = new JSONArray();
        if (!id.equalsIgnoreCase("1")) {
            return RESULTDATA;
        }
        Connection conn = null;
        Statement stmt = null;
        ResultSet resultSet = null;
        String sqltest = "";

        conn = ClsConnection.getMyConnection();
        stmt = conn.createStatement();
        try {
            java.sql.Date sqlfromdate = null;
            if (!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase(""))
                    && !(fromdate.equalsIgnoreCase("0"))) {
                sqlfromdate = ClsCommon.changeStringtoSqlDate(fromdate);
            } else {
            }
            java.sql.Date sqltodate = null;
            if (!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase(""))
                    && !(todate.equalsIgnoreCase("0"))) {
                sqltodate = ClsCommon.changeStringtoSqlDate(todate);
            } else {
            }
            if (!(branchval.equalsIgnoreCase("a")) && !(branchval.equalsIgnoreCase("0"))
                    && !(branchval.equalsIgnoreCase(""))) {
                sqltest += " and mm.brhid=" + branchval;
            } else {
            }

            int tax=0;
            Statement stmt3 = conn.createStatement (); 
         
            String chk31="select method  from gl_prdconfig where field_nme='tax' ";
            ResultSet rss3=stmt3.executeQuery(chk31); 
            if(rss3.next())
            {

                tax=rss3.getInt("method");
            }
            
            String joinsql="";
            
            String fsql="";
            
            String outfsql="";
            
            if(tax>0)
            {
                    
                    
                    
                    Statement pv=conn.createStatement();
                    int prvdocno=0;
                    String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
                    ResultSet rs13=pv.executeQuery(dd); 
                    if(rs13.next())
                    {

                        prvdocno=rs13.getInt("prvdocno");
                    }
                    

                    joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+fromdate+"' and todate>='"+fromdate+"' and provid='"+prvdocno+"'  and type=1 and if(1=1,per,cstper)>0  group by typeid  ) t1 on "
                            + " t1.typeid=m.typeid   ";
                
                    
                    fsql=fsql+" case when 1=1  then t1.per when 2=0  then t1.cstper else 0 end as  'hidtax' , t1.taxdocno , ";
                    
                    if(vndtax.equalsIgnoreCase("1")) {
                        fsql=fsql+"case when 1=1  then t1.per when 2=0  then t1.cstper else 0 end as taxper,";
                    }else {
                        fsql=fsql+"0 taxper,";
                    }
                    
                    outfsql=outfsql+ " taxper ,taxdocno, ";
                
                
                
            }
            String sql = "";

            sql = "select   "+fsql+"  (d.qty-d.out_qty) chkqty,u.doc_no unitdoc,m.psrno,at.mspecno specid,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty   from my_reqm mm left join my_reqd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join   my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)     left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"
                    + sqlfromdate + "' and todate>='" + sqltodate
                    + "' and provid='1'  and type=1 and if(1=1,per,cstper)>0  group by typeid  ) t1 on  t1.typeid=m.typeid     where    mm.status=3 and mm.tr_no in ("+docno+") and m.part_no in ("+prdid+")"
                    + sqltest + " having  chkqty>0";
System.out.println("PR sql : "+sql);
            resultSet = stmt.executeQuery(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);

        } catch (SQLException e) {

            e.printStackTrace();
            resultSet.close();
            stmt.close();
            conn.close();
        }
        resultSet.close();
        stmt.close();
        conn.close();
        return RESULTDATA;

    }
    public   JSONArray reqgridreload(String doc,HttpSession session,String dates,String cmbbilltype,String acno) throws SQLException {
       System.out.println("Test"); 
        JSONArray RESULTDATA=new JSONArray();
        
         Enumeration<String> Enumeration = session.getAttributeNames();
            int a=0;
            while(Enumeration.hasMoreElements()){
             if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
              a=1;
             }
            }
            if(a==0){
          return RESULTDATA;
             }
            String brcid = session.getAttribute("BRANCHID").toString(); 
         
        Connection conn = null;
        try {
                 conn = ClsConnection.getMyConnection();
                Statement stmt = conn.createStatement ();      
                String pySql="";
               
                    
                    java.sql.Date masterdate = null;
                    if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
                    {
                        masterdate=ClsCommon.changeStringtoSqlDate(dates);
                        
                    }
                    else{
                 
                    }
                
                    
                    

                    int tax=0;
                    Statement stmt3 = conn.createStatement (); 
                 
                    String chk31="select method  from gl_prdconfig where field_nme='tax' ";
                    ResultSet rss3=stmt3.executeQuery(chk31); 
                    if(rss3.next())
                    {

                        tax=rss3.getInt("method");
                    }
                    
                    
                    int temptax=0;
                    Statement stmt3111 = conn.createStatement (); 
                    String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+acno+"' ";
                //  System.out.println("===check======"+sqlss);
                    ResultSet rsss=stmt3111.executeQuery(sqlss);
                    if(rsss.next())
                    {
                        temptax=rsss.getInt("tax");
                        
                    }
                    if(temptax!=1)
                    {
                        tax=0;
                    }
                    
                    
                    
                    String joinsql="";
                    
                    String fsql="";
                    
                    String outfsql="";
                    
                    
                    if(tax>0)
                    {
                        System.out.println("Tax on DAO====="+tax);
                        if(Integer.parseInt(cmbbilltype)>0)
                        {
                            System.out.println("cmbbilltype on DAO====="+cmbbilltype);
 
                            
                            
                            Statement pv=conn.createStatement();
                            int prvdocno=0;
                            String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
                            ResultSet rs13=pv.executeQuery(dd); 
                            if(rs13.next())
                            {

                                prvdocno=rs13.getInt("prvdocno");
                            }
                            
                            
                    /*  joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
                                + " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
                        
                        fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
                        
                        outfsql=outfsql+ " taxper , ";*/
                        

                            joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) pivtaxdocno, sum(per) pivper,sum(cstper) pivcstper,typeid pivtypeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
                                    + " t1.pivtypeid=m.typeid   ";
                        
                            
                            fsql=fsql+" case when 1="+cmbbilltype+"  then t1.pivper when 2="+cmbbilltype+"  then t1.pivcstper else 0 end as  'pivtaxper' ,t1.pivtaxdocno pivtaxdocno, ";
                            
                            outfsql=outfsql+ " taxper ,taxdocno, ";
                        
                        }
                        
                    }
                    
                    
                    
                    
                    int mulqty=0;
                    Statement stmt31 = conn.createStatement (); 
                 
                    String chk311="select method  from gl_prdconfig where field_nme='multiqty' ";
                    ResultSet rss31=stmt31.executeQuery(chk311); 
                    if(rss31.next())
                    {

                        mulqty=rss31.getInt("method");
                    }
                    
                    String joinsqls="";
                    String joinsqls1="";
                    if(mulqty>0)
                    {
                     
                        joinsqls1=",d.unitid pivunitid,d.specno pivspecno ";
                    }
                        
                    String pivtestsql="";
                    if(tax>0) {
                        pivtestsql=" (t1.pivper/100)";
                    }else {
                        pivtestsql=" 1";
                    }
                    
                    
               
                    
             pySql=("select  "+fsql+" mm.curid pivcurid,mm.brhid brhid,mm.rate pivrate,bd.brandname pivbrandname,'pro' pivchecktype ,d.stockid pivstockid,at.mspecno pivspecid,m.part_no pivproductid,m.productname pivproductname,m.part_no pivproid ,   m.productname pivproname,d.sr_no pivsr_no,d.psrno pivsrno,d.prdId pivprodoc, u.unit pivunit, d.unitid pivunitdocno,sum(d.qty-d.out_qty)  pivqty,  sum(d.qty-d.out_qty) pivqutval,sum(d.qty-d.out_qty) pivsaveqty,d.amount pivunitprice,d.amount*sum(d.qty-d.out_qty)    pivtotal,d.amount*sum(d.qty-d.out_qty)* d.disper/100 pivdiscount, d.disper pivdiscper,  (d.amount*sum(d.qty-d.out_qty))-(d.amount*sum(d.qty-d.out_qty)*d.disper/100) pivnettotal,round((d.amount*sum(d.qty-d.out_qty))*"+pivtestsql+",2)      pivtaxperamt,round(((d.amount*sum(d.qty-d.out_qty))-(d.amount*sum(d.qty-d.out_qty)*d.disper/100))+((d.amount*sum(d.qty-d.out_qty))* "+pivtestsql+"),2) pivtaxamount "
                                + ""
                                + "from my_grnm mm  "
                                + " left join  my_grnd d on d.tr_no=mm.tr_no  left join my_main m on m.doc_no=d.prdId  "
                                + " left join my_unitm u on d.unitid=u.doc_no   left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
                                + " "+joinsql+"  where  mm.doc_no in ("+doc+")    group by d.stockid having sum(d.qty-d.out_qty)>0");
                     
                     System.out.println("----pySql--GRN--"+pySql);
                            
                     ResultSet resultSet = stmt.executeQuery(pySql);

                        RESULTDATA=ClsCommon.convertToJSON(resultSet);
                    
                
                
            /*  else
                {
                 pySql=("  select 'entry' checktype ,m.part_no productid,m.productname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,d.qty  qty,d.qty qutval,sum(d.qty) saveqty  from my_reqd d " + 
                        "     left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no where d.tr_no in ("+doc+") ");
                
                
                
                System.out.println("----pySql----"+pySql);
                }
                
                */
    
             
                stmt.close();
                conn.close();

        }
        catch(Exception e){
            e.printStackTrace();
            conn.close();
        }
    //  System.out.println(RESULTDATA);
        return RESULTDATA;
    }

}
