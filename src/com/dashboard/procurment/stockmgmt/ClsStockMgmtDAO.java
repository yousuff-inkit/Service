package com.dashboard.procurment.stockmgmt;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsStockMgmtDAO {
    
    ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
    
    public JSONArray stockLedgerSummary(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
            String hidsubcat,String hidproduct,String branchid,String hidept,String load) throws SQLException {


        JSONArray RESULTDATA=new JSONArray();
        if(!(load.equalsIgnoreCase("yes")))
        {
            return RESULTDATA;
        }
        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String minyom="",maxyom="";
            String sqljoin ="";
            String sql="";

            String sqlfrm="",sqlto="",sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

            String insqls1="";
            String insqls2="";
            java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

            java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

            if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
                sql7=" and bd.doc_no in ("+hidbrand+")";
            }

            if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
                sql8=" and pt.doc_no in ("+hidtype+")";
            }

            if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
                sql9=" and cat.doc_no in ("+hidcat+")";
            }
            if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
                sql10=" and sc.doc_no in ("+hidsubcat+")";
            }

            if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
                sql11=" and m.doc_no in ("+hidproduct+")";
            }
             if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equalsIgnoreCase("undefined")|| branchid.equalsIgnoreCase("a"))){
         sql12="and stks.brhid="+branchid+"  ";
                
                insqls2="and pin.brhid="+branchid+"  ";
                
                insqls1= " and brhid="+branchid+" ";
                
                
            } 
            if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
                sql13=" and dep.doc_no in ("+hidept+")";
            }
            sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
            sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + "left join my_brand bd on(m.brandid=bd.doc_no) "
                    + "left join my_dept dep on(dep.doc_no=m.deptid) "
                    + "left join my_catm cat on(m.catid=cat.doc_no)"
                    + "left join my_scatm sc on(m.scatid=sc.doc_no)";

/*          sqljoin = "left join my_main m on(b.psrno=m.psrno) "
                    + "left join my_prodsuit s on(m.doc_no=s.psrno) "
                    + "left join my_vehsuitmaster vs on(vs.doc_no=s.vehsuitid) "
                    + "left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + "left join my_brand bd on(m.brandid=bd.doc_no) "
                    + "left join my_dept dep on(dep.doc_no=m.deptid) "
                    + "left join my_catm cat on(m.catid=cat.doc_no)"
                    + "left join my_scatm sc on(m.scatid=sc.doc_no)";
*/
            /*                  sql="select b.pno,b.pname,b.psrno,b.specid,coalesce(if(d.opnqty<0,0,d.opnqty),0) as opnqty,coalesce(if(b.qty<0,0,b.qty),0) as inqty,coalesce(if(e.isqty<0,0,e.isqty),0) as isqty, "
                            + "coalesce(if(b.bqty<0,0,b.bqty),0) as balqty,b.date,(b.bqty*b.unit_price) as stv,((b.bqty*b.unit_price)/b.bqty) as cpu from ( "
                            + "(select part_no pno,productname  pname,a.psrno,a.specid,qty,sum(qty) as bqty,a.date,unit_price from ( "
                            + "select stockid stkid,p.psrno,specno specid,op_qty qty,p.date,unit_price from my_prddin p "
                            + "union all "
                            + "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date,0 unit_price from my_prddout p) as a"
                            + " left join my_main m on(a.psrno=m.psrno) where cast(a.date as date)>='"+frmdate+"' and "
                            + "cast(a.date as date)<='"+todate+"' group by a.psrno order by a.date) as b "
                            + "left join (select c.psrno,qty,sum(qty) as opnqty,c.date from "
                            + "(select stockid stkid,p.psrno,specno specid,op_qty qty,p.date from my_prddin p "
                            + "union all "
                            + "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date from my_prddout p) as c"
                            + "  where cast(c.date as date)<'"+frmdate+"' "
                            + "group by c.psrno order by c.date) as d "
                            + "on (b.psrno=d.psrno) "
                            + "left join ( select p.psrno,p.specid,sum(p.qty+p.rsv_qty+p.del_qty) isqty  from my_prddout p "
                            + "where cast(p.date as date)>='"+frmdate+"' and "
                            + "cast(date as date)<='"+todate+"' group by p.psrno) as e on(e.psrno=b.psrno)) "+sqljoin+" where 1=1 "+sqlfinal+" group by b.psrno";
             */
        /*//krish   sql="select b.pno,b.pname,b.psrno,b.specid,coalesce(if(d.opnqty<0,0,d.opnqty),0) as opnqty, "
                    + "coalesce(if(d.opnqty<0,0,d.opnqty),0)*b.unit_price as opnval, "
                    + "coalesce(if(b.iqty<0,0,b.iqty),0) as inqty, "
                    + "coalesce(if(b.iqty<0,0,b.iqty),0)*b.unit_price as inval, "
                    + "coalesce(if(e.isqty<0,0,e.isqty),0) as isqty, "
                    + "coalesce(if(e.isqty<0,0,e.isqty),0) *b.unit_price as isval, "
                    + "coalesce(if(b.bqty<0,0,b.bqty),0) as balqty,b.date,(b.bqty*b.unit_price) as stv, "
                    + "((b.bqty*b.unit_price)/b.bqty) as cpu from ( "
                    + "(select part_no pno,productname  pname,a.psrno,a.specid,sum(qty) as qty,sum(qty) as bqty,a.date,unit_price,sum(iqty) iqty from "
                    + "( select stockid stkid,p.psrno,specno specid,op_qty qty,p.date,unit_price,op_qty as iqty from my_prddin p "
                    + "union all "
                    + "select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date,0 unit_price,0 as iqty from my_prddout p) as a "
                    + "left join my_main m on(a.psrno=m.psrno) where cast(a.date as date)>='"+frmdate+"' and cast(a.date as date)<='"+todate+"' "
                    + "group by a.psrno order by a.date) as b "
                    + "left join (select c.psrno,qty,sum(qty) as opnqty,c.date from "
                    + "(select stockid stkid,p.psrno,specno specid,op_qty qty,p.date from my_prddin p "
                    + "union all select stockid stkid,p.psrno,p.specid,(qty*-1+rsv_qty*-1+del_qty*-1) qty,p.date from my_prddout p) as c "
                    + "where cast(c.date as date)<'"+frmdate+"' group by c.psrno order by c.date) as d on (b.psrno=d.psrno) "
                    + "left join ( select p.psrno,p.specid,sum(p.qty+p.rsv_qty+p.del_qty) isqty  from my_prddout p "
                    + "where cast(p.date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' group by p.psrno) as e on(e.psrno=b.psrno)) "+sqljoin+" where 1=1 "+sqlfinal+" group by b.psrno";

*/
/*          sql="select m.part_no pno,m.productname  pname,stks.* from (  "
                    + "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
                    + ",stk.stkqty inqty ,stk.stcost_price inval ,stk.issueqty isqty,stk.isscost isval,stk.stkqty-stk.issueqty balqty, "
                    + "stk.stcost_price-stk.isscost stv,pin.cost_price  cpu1 ,((stk.stcost_price-stk.isscost)/(stk.stkqty-stk.issueqty)) cpu from my_prddin pin  left join "
                    + " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
                    + "select date,(op_qty)-(out_qty+rsv_qty+del_qty) opqty ,((op_qty)-(out_qty+rsv_qty+del_qty))*cost_price "
                     + "cost_price,Stockid,prdid from my_prddin where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by Stockid "
                    + " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,sum(st.issueqty) issueqty, "
                     + " sum(st.isscost) isscost , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
                     + " (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid from my_prddin where "
                    + "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
                    + "  ) st group by st.prdid) stk on stk.prdid=pin.prdid where cast(pin.date as date)>='"+frmdate+"' "
                     + "  and cast(pin.date as date)<='"+todate+"' "+insqls2+"  group by pin.psrno) stks "
                   + "  left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1  "+sqlfinal+" " ;*/

/*          
            sql="select m.part_no pno,m.productname  pname,stks.* from (  "
                    + "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
                    + ",stk.stkqty inqty ,stk.stcost_price inval ,stk.issueqty isqty,stk.isscost isval, "
                    + " (coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0) balqty , "
                    + "  (coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
                    + " (((coalesce(stk.stcost_price,0)-coalesce(stk.isscost,0))+coalesce(ops.cost_price,0))/"
                    + " ((coalesce(stk.stkqty,0)-coalesce(stk.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
                    + "  from my_prddin pin  left join "
                    + " (select sum(op.opqty) opqty,sum(op.cost_price)  cost_price,op.Stockid,op.prdid from( "
                    + "select date,(op_qty)-(out_qty+rsv_qty+del_qty) opqty ,((op_qty)-(out_qty+rsv_qty+del_qty))*cost_price "
                     + "cost_price,Stockid,prdid from my_prddin where  cast(date as date)<'"+frmdate+"' "+insqls1+"  group by Stockid "
                    + " ) op group by op.prdid) ops on ops.prdid=pin.prdid left join (select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,"
                    + " sum(st.issueqty) issueqty, "
                     + " sum(st.isscost) isscost , st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
                     + " (out_qty+rsv_qty+del_qty) issueqty,(out_qty+rsv_qty+del_qty)*cost_price isscost, Stockid,prdid from my_prddin where "
                    + "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"  group by Stockid "
                    + "  ) st group by st.prdid) stk on stk.prdid=pin.prdid where  1=1  "+insqls2+"  group by pin.psrno) stks "
                   + "  left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and"
                        + "  (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)  "+sqlfinal+" " ;
            
            */
            
            int config=0;
            String strConfig="select method from gl_config where field_nme='Stocklederinout'";
            ResultSet rsconfig = stmt.executeQuery(strConfig);
            while(rsconfig.next()){
                config=rsconfig.getInt("method");
            }

            if(config==0){
            	sql="select m.part_no pno,m.productname  pname,stks.* from (  "
                        + "select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
                        + ",stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
                        + " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
                        + "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
                        + " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
                        + " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
                        + "  from my_prddin pin left join(select coalesce(inqty-outqty,0) opqty, coalesce(incost-outcost,0) cost_price, pin.stockid, pin.prdid, pin.brhid from(select sum(inqty) inqty, sum(incost) incost, stockid, prdid,brhid from(select sum(p.op_qty) inqty, sum(p.cost_price*op_qty) incost, stockid, prdid, dtype, brhid, date from my_prddin p where cast(p.date as date)<'"+frmdate+"' "+insqls1+" and dtype!='DLR' group by stockid)a) pin left join (select sum(outqty) outqty, sum(outcost) outcost, stockid, prdid from(select  sum(pin.qty) outqty, sum(coalesce(p.cost_price,0)*(qty)) outcost, pin.stockid, pin.prdid, pin.dtype from my_prddout pin left join my_prddin p on p.stockid=pin.stockid where cast(pin.date as date)<'"+frmdate+"' "+insqls2+" group by pin.stockid)a) pout on pout.stockid=pin.stockid)ops on ops.prdid=pin.prdid left join ( select sum(st.stkqty) stkqty,sum(st.stcost_price) stcost_price,"
                        + " st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
                        + "   Stockid,prdid from my_prddin where "
                        + "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' and dtype!='DLR' "+insqls1+"  group by Stockid "
                        + "  ) st group by st.prdid ) stk on stk.prdid=pin.prdid"
                        + " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid from   (select a.outqty ,a.outqty*p.cost_price outcost, a.prdid from "
                        + " (select sum(qty+del_qty) outqty,stockid,prdid from my_prddout where "
                        + " cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"   group by stockid) a "
                        + "     left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid ) iss on iss.prdid=pin.prdid "
                        + "  where  1=1  "+insqls2+"  group by pin.psrno) stks "
                        + "  left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and"
                        + "  (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)  "+sqlfinal+" " ;
            }
            else{
            	sql="select m.part_no pno,m.productname  pname,stks.* from (  "
                        + " select  pin.brhid,pin.psrno,date,coalesce(ops.opqty,0) opnqty,coalesce(ops.cost_price,0) opnval "
                        + " ,stk.stkqty inqty ,stk.stcost_price inval ,iss.issueqty isqty,iss.isscost isval, "
                        + " (coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0) balqty , "
                        + "  (coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0) stv,pin.cost_price  cpu1 , "
                        + " (((coalesce(stk.stcost_price,0)-coalesce(iss.isscost,0))+coalesce(ops.cost_price,0))/"
                        + " ((coalesce(stk.stkqty,0)-coalesce(iss.issueqty,0))+coalesce(ops.opqty,0))) cpu  "
                        + "  from my_prddin pin left join(select coalesce(inqty-outqty,0) opqty, coalesce(incost-outcost,0) cost_price, pin.stockid, pin.prdid, pin.brhid from(select sum(inqty) inqty, sum(incost) incost, stockid, prdid,brhid from(select sum(p.op_qty) inqty, sum(p.cost_price*op_qty) incost, stockid, prdid, dtype, brhid, date from my_prddin p where cast(p.date as date)<'"+frmdate+"' "+insqls1+" and dtype!='DLR' group by stockid)a) pin left join (select sum(outqty) outqty, sum(outcost) outcost, stockid, prdid from(select  sum(pin.qty) outqty, sum(coalesce(p.cost_price,0)*(qty)) outcost, pin.stockid, pin.prdid, pin.dtype from my_prddout pin left join my_prddin p on p.stockid=pin.stockid where cast(pin.date as date)<'"+frmdate+"' "+insqls2+" group by pin.stockid)a) pout on pout.stockid=pin.stockid)ops on ops.prdid=pin.prdid  left join ( select sum(st.stkqty) stkqty,sum(st.stcost_price)  stcost_price,"
                        + " st.Stockid,st.prdid from(select date,(op_qty) stkqty ,(op_qty)*cost_price stcost_price, "
                        + "   Stockid,prdid from my_prddin where "
                        + "  cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' and dtype!='DLR' "+insqls1+"  group by Stockid "
                        + "  ) st group by st.prdid ) stk on stk.prdid=pin.prdid"
                        + " left join (select sum(coalesce(a.outqty,0)) issueqty,sum(coalesce(outcost,0)) isscost,prdid from  "
                        + " (select a.outqty , outcost, a.prdid from "
                        + " (select sum(qty+del_qty) outqty,stockid,prdid,sum((qty+del_qty)*cost_price) outcost from my_prddout where "
                        + " cast(date as date)>='"+frmdate+"' and cast(date as date)<='"+todate+"' "+insqls1+"   group by stockid) a "
                        + "     left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid ) iss on iss.prdid=pin.prdid "
                        + "  where  1=1  "+insqls2+"  group by pin.psrno) stks "
                        + "  left  join my_main m on(stks.psrno=m.psrno) "+sqljoin+"  where 1=1 and"
                        + "  (opnqty!=0 or opnval!=0 or inqty!=0 or inval!=0 or isqty!=0 or isval!=0 or balqty!=0 or stv!=0)  "+sqlfinal+" " ;
            }
            
/*          
            select p.date,(p.op_qty)-(a.outqty) opqty
               ,((op_qty)-(a.outqty))*p.cost_price  cost_price,p.Stockid,p.prdid from my_prddin  p
                left join (select sum(qty) outqty,stockid from my_prddout where
                   cast(date as date)<'2017-01-01'    group by stockid) a
                   on a.stockid=p.stockid  where  cast(p.date as date)<'2017-01-01'   group by p.Stockid ;

        select sum(stkqty) stkqty ,sum(stcost_price) stkcost from (select p.date,(p.op_qty) stkqty ,(p.op_qty)*p.cost_price stcost_price,
           p.Stockid, prdid from my_prddin  p
                     where   cast(p.date as date)>='2017-01-01' and cast(p.date as date)<='2017-01-11'
                       group by p.Stockid) a group by a.prdid;

        select sum(a.outqty) outqty,sum(outcost) outcost from   (select a.outqty ,a.outqty*p.cost_price outcost, a.prdid from
        (select sum(qty) outqty,stockid,prdid from my_prddout where
        cast(date as date)>='2017-01-01' and cast(date as date)<='2017-01-11'    group by stockid) a
        left join my_prddin p on a.stockid=p.stockid )  a where 1=1 group by a.prdid;*/
            
            
            

          System.out.println("==sql=summary=========="+sql);

            ResultSet resultSet = stmt.executeQuery(sql);


            RESULTDATA=ClsCommon.convertToJSON(resultSet);


        }catch(Exception e){
            e.printStackTrace();

        }finally{
            conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray stockLedgerDetail(HttpSession session,String hidbrand,String fromDate,String toDate,String hidtype,String hidcat,
            String hidsubcat,String hidproduct,String branchid,String hidept,String load) throws SQLException {

//      System.out.println("load==============="+load);
        JSONArray RESULTDATA=new JSONArray();
        if(!(load.equalsIgnoreCase("yes")))
        {
            return RESULTDATA;
        }
        
        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String minyom="",maxyom="";
            String sqljoin ="";
            String sqljoin1 ="";
            String sqljoin2 ="";
            String wheresql="";

         String insql="";
         String outsql="";

            java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);

            java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);

            if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
                wheresql=wheresql+" and bd.doc_no in ("+hidbrand+")";
            }

            if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
                wheresql=wheresql+"  and pt.doc_no in ("+hidtype+")";
            }

            if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
                wheresql=wheresql+"  and cat.doc_no in ("+hidcat+")";
            }
            if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
                wheresql=wheresql+"  and sc.doc_no in ("+hidsubcat+")";
            }

            if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
                wheresql=wheresql+"  and m.doc_no in ("+hidproduct+")";
            }
            
            String opsql="",psql=" ";
         if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equals("undefined")|| branchid.equalsIgnoreCase("a"))){
                insql=" and pin.brhid in ("+branchid+")";
                outsql=" and pout.brhid in ("+branchid+")";
                opsql=" and brhid in ("+branchid+")";
                psql=" and p.brhid in ("+branchid+") ";
                
            } 
            if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
                wheresql=wheresql+"  and dep.doc_no in ("+hidept+")";
            }
             
             
/*
            sqljoin = "left join my_main m on(pin.psrno=m.psrno) "
                    + "left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + "left join my_brand bd on(m.brandid=bd.doc_no) "
                    + "left join my_dept dep on(dep.doc_no=m.deptid) "
                    + "left join my_catm cat on(m.catid=cat.doc_no)"
                    + "left join my_scatm sc on(m.scatid=sc.doc_no)"
                    + "left join my_brch brc on(e.brhid=brc.doc_no) "
                    + "left join my_locm lm on(e.locid=lm.doc_no)";
            */

            sqljoin = " left join my_main m on(pin.psrno=m.psrno) "
                    + " left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + " left join my_brand bd on(m.brandid=bd.doc_no) "
                    + " left join my_dept dep on(dep.doc_no=m.deptid) "
                    + " left join my_catm cat on(m.catid=cat.doc_no)"
                    + " left join my_scatm sc on(m.scatid=sc.doc_no)" ;
                 
            
            

            sqljoin1 = " left join my_main m on(pout.psrno=m.psrno) "
                    + " left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + " left join my_brand bd on(m.brandid=bd.doc_no) "
                    + " left join my_dept dep on(dep.doc_no=m.deptid) "
                    + " left join my_catm cat on(m.catid=cat.doc_no) "
                    + " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
            
            sqljoin2 = " left join my_main m on(ops.prdid=m.psrno) "
                    + " left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + " left join my_brand bd on(m.brandid=bd.doc_no) "
                    + " left join my_dept dep on(dep.doc_no=m.deptid) "
                    + " left join my_catm cat on(m.catid=cat.doc_no) "
                    + " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
 
            


            /*sql="select e.psrno,stockid,part_no pno,productname pname,inqty,inval,DATE_FORMAT(e.date,'%m-%d-%Y') date,docno,trans_type,outqty isqty,outval isval,inqty-outqty as balqty,inval-outval as balval,trtype from "
                    + "(select opqty inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(opqty*unit_price) as inval,0 as outval,1 as trtype from "
                    + "(select sum(a.qty) opqty,a.stockid,a.psrno,a.date,'OPN' trans_type,0 as docno,a.unit_price from  "
                    + "(select op_qty qty,stockid,psrno,date,dtype,brhid,locid,unit_price from my_prddin p "
                    + "union all select (p.qty*-1+del_qty*-1) qty,stockid,psrno,date,dtype,brhid,locid,0 as unit_price from my_prddout p) as a "
                    + "where cast(a.date as date)<'"+frmdate+"'  group by psrno order by psrno) as b union all select inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(inqty*unit_price) as inval,0 as outval,1 as trtype "
                    + "from (SELECT sum(op_qty) inqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRN' then mg.voc_no else (case when p.dtype='PIV' then sm.voc_no else (case when p.dtype='DLR' then dm.voc_no else "
                    + "(case when p.dtype='INR' then irm.voc_no else itm.voc_no end) end) end) end) as DOCNO, "
                    + "(p.dtype) as  trans_type,p.unit_price from my_prddin p left join my_grnd gn on(gn.psrno=p.psrno and gn.stockid=p.stockid) "
                    + "left join my_grnm mg on(mg.doc_no=gn.rdocno) left join my_srvd sd on(sd.psrno=p.psrno and sd.stockid=p.stockid) left join my_srvm sm on(sm.doc_no=sd.rdocno) left join my_delrd dd on (dd.psrno=p.psrno and dd.stockid=p.stockid) left join my_delrm dm on(dm.doc_no=dd.rdocno) "
                    + "left join my_inrd id on (id.psrno=p.psrno and id.stockid=p.stockid) left join my_invr irm  on(irm.doc_no=id.rdocno) left join my_invtranreceptd it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranreceptm itm on(itm.doc_no=it.rdocno) "
                    + "where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,p.psrno) as c union all select 0 as opnqty,stockid,psrno,date,DOCNO,trans_type,outqty,0 as inval,(outqty*unit_price) outval,2 as trtype from "
                    + "(select sum(p.qty+p.del_qty) outqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRR' then mg.voc_no else (case when p.dtype='DEL' then dm.voc_no else (case when p.dtype='PIR' then sm.voc_no else (case when p.dtype='INV' then im.voc_no else itm.voc_no end) end) end) end) as DOCNO,"
                    + "(p.dtype) as  trans_type,intb.unit_price "
                    + "from my_prddout p left join my_prddin intb on(p.psrno=intb.psrno and p.stockid=intb.stockid) "
                    +" left join my_grrd gr on(gr.psrno=p.psrno and gr.stockid=p.stockid) left join my_grrm mg on(mg.doc_no=gr.rdocno) left join my_deld dr on(dr.psrno=p.psrno and dr.stockid=p.stockid) left join my_delm dm on(dm.doc_no=dr.rdocno ) left join my_srrd sr on(sr.psrno=p.psrno and sr.stockid=p.stockid) "
                    + "left join my_srrm sm on(sm.doc_no=sr.rdocno ) left join my_invd ir on(ir.psrno=p.psrno and ir.stockid=p.stockid) left join my_invm im on(im.doc_no=ir.rdocno) left join my_invtranissued it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranissuem itm on(itm.doc_no=it.rdocno) "
                    + "where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,psrno)as d) as e  "+sqljoin+" where 1=1  "+sqlfinal+" order by e.psrno,trtype,cast(e.date as date)";*/
    //krish     
/*          sql="select e.psrno,stockid,part_no pno,productname pname,inqty,inval,DATE_FORMAT(e.date,'%d-%m-%Y') date,"
              + "docno,trans_type,outqty isqty, outval isval,inqty-outqty as balqty,inval-outval as balval,trtype,ACNO,if(trans_type='ITR' or trans_type='ITI',concat(brc.branchname,' : ',lm.loc_name), h.description ) as desc1,e.brhid,e.locid,e.tr_no from "
              + "(select opqty inqty,stockid,psrno,date,DOCNO,trans_type, "
              + "0 as outqty,(opqty*unit_price) as inval,0 as outval,1 as trtype,ACNO,brhid,locid,tr_no from (select sum(a.qty) opqty,a.stockid,a.psrno,a.date, "
              + "'OPN' trans_type,0 as docno,a.unit_price,0 as ACNO,brhid,locid,tr_no from "
              + "(select op_qty qty,stockid,psrno,date,dtype,brhid,locid,unit_price,tr_no from my_prddin p union all "
              + "select (p.qty*-1+del_qty*-1) qty,stockid,psrno,date,dtype,brhid,locid,0 as unit_price,tr_no from my_prddout p) as a "
              + "where cast(a.date as date)<'"+frmdate+"'  group by psrno order by psrno) as b union all "
              + "select inqty,stockid,psrno,date,DOCNO,trans_type,0 as outqty,(inqty*unit_price) as inval,0 as outval,1 as trtype,ACNO,brhid,locid,tr_no from (SELECT sum(op_qty) inqty,p.stockid,p.psrno,p.date, "
              + "(case when p.dtype='GRN' then mg.voc_no else (case when p.dtype='PIV' then sm.voc_no else (case when p.dtype='DLR' then dm.voc_no else "
              + "(case when p.dtype='INR' then irm.voc_no else itm.voc_no end) end) end) end) as DOCNO,(case when p.dtype='GRN' then mg.acno else(case when p.dtype='PIV' then sm.acno else "
              + "(case when p.dtype='DLR' then dm.acno else (case when p.dtype='INR' then irm.acno else itm.acno end) end) end) end) as ACNO,(p.dtype) as  trans_type,p.unit_price,p.brhid,p.locid,p.tr_no from my_prddin p left join my_grnd gn "
              + "on(gn.psrno=p.psrno and gn.stockid=p.stockid) left join my_grnm mg on(mg.doc_no=gn.rdocno) left join my_srvd sd on(sd.psrno=p.psrno and sd.stockid=p.stockid) left join my_srvm sm on(sm.doc_no=sd.rdocno) left join my_delrd dd on (dd.psrno=p.psrno and dd.stockid=p.stockid) "
              + "left join my_delrm dm on(dm.doc_no=dd.rdocno) left join my_inrd id on (id.psrno=p.psrno and id.stockid=p.stockid) left join my_invr irm  on(irm.doc_no=id.rdocno) left join my_invtranreceptd it on(it.psrno=p.psrno and it.stockid=p.stockid) "
              + "left join my_invtranreceptm itm on(itm.doc_no=it.rdocno) where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,p.psrno) as c "
              + "union all select 0 as opnqty,stockid,psrno,date,DOCNO,trans_type,outqty,0 as inval,(outqty*unit_price) outval,2 as trtype,ACNO,brhid,locid,tr_no from (select sum(p.qty+p.del_qty) outqty,p.stockid,p.psrno,p.date,(case when p.dtype='GRR' then mg.voc_no else(case when p.dtype='DEL' then dm.voc_no else "
              + "(case when p.dtype='PIR' then sm.voc_no else (case when p.dtype='INV' then im.voc_no else itm.voc_no end) end) end) end) as DOCNO,(case when p.dtype='GRR' then mg.acno else(case when p.dtype='DEL' then dm.acno else (case when p.dtype='PIR' then sm.acno else(case when p.dtype='INV' then im.acno else itm.acno end) end) end) end) as ACNO, "
              + "(p.dtype) as  trans_type,intb.unit_price,p.brhid,p.locid,p.tr_no from my_prddout p left join my_prddin intb on(p.psrno=intb.psrno and p.stockid=intb.stockid)  left join my_grrd gr "
              + "on(gr.psrno=p.psrno and gr.stockid=p.stockid) left join my_grrm mg on(mg.doc_no=gr.rdocno) left join my_deld dr "
              + "on(dr.psrno=p.psrno and dr.stockid=p.stockid) left join my_delm dm on(dm.doc_no=dr.rdocno ) left join my_srrd sr on(sr.psrno=p.psrno and sr.stockid=p.stockid) left join my_srrm sm on(sm.doc_no=sr.rdocno ) left join my_invd ir "
              + "on(ir.psrno=p.psrno and ir.stockid=p.stockid) left join my_invm im on(im.doc_no=ir.rdocno) left join my_invtranissued it on(it.psrno=p.psrno and it.stockid=p.stockid) left join my_invtranissuem itm on(itm.doc_no=it.rdocno) where cast(p.date as date)<='"+todate+"' and cast(p.date as date)>='"+frmdate+"' group by p.dtype,psrno)as d) as e "
              + "left join my_head h on(h.doc_no=e.acno) "+sqljoin+" where 1=1 and trans_type not in('SOR') "+sqlfinal+"  order by e.psrno,tr_no,cast(e.date as date)";
            
*/
            
            
            
            
/*          
        String  sql="   select * from (select 0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
                + "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, "
                     + "    ins.isval,ins.balqty,ins.balcost,ins.cpu from  "
                     + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
                     + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  "
                     + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
                     + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
                     + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
                     + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
                     + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
                     + " ' ' isqty, ' '  isval,  "
                     + " ' ' balqty, ' ' balcost,  "
                     + " cost_price cpu  from my_prddin pin  "
                      + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
                      + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
                      + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
                      + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
                      + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
                      + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
                      + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
                      + "group by pin.stockid order by pin.stockid) ins  "
                      + "left join my_head h on(h.doc_no=ins.acno)  "
                      + " union all  "
                     + " select outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
                     + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty*outs.issuecostprice isval ,  "
                      + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
                      + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
                      + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
                      + "   when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  "
                      + "   when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
                      + "   when  pout.dtype='GIS' then GIS.voc_no  "
                      + "   else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
                      + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno   when  pout.dtype='INV' then INV.cldocno  "
                      + "   when  pout.dtype='GIS' then GIS.cldocno     else ''  end as cldocno , "
                      + "   case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
                     + "    when pout.dtype='SOR' then SOR.acno  "
                     + "    when  pout.dtype='DEL' then DEL.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
                     + "    when  pout.dtype='GIS' then GIS.acno  "
                     + "    else ''  end as acno, case when  pout.dtype='DEL' then  "
                     + "    de.del_qty  "
                     + "    when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
                     + "     rs.rsv_qty  "
                     + "    else pout.qty end as issqty, p.cost_price issuecostprice  "
                     + "    from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and (pout.dtype!='SOR'  or pout.dtype!='JOR')  "
                     + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
                     + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
                     + "    left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
                     + "    left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
                     + "    left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
                     + "    left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
                     + "    left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
                     + "    left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype='INV'  "
                     + "    left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
                     + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
                     + "    where 1=1  and (pout.dtype!='SOR' or pout.dtype!='JOR') and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
                     + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on(ac.doc_no=outs.cldocno and ac.dtype='CRM') ) res order by res.date  ";

                      ;*/
            
/*          
            obj.put("date",stldarray[0]);
            obj.put("docno",stldarray[1]);
            obj.put("trans_type",stldarray[2]);
            obj.put("inqty",stldarray[3]);
            obj.put("inval",stldarray[4]);
            obj.put("isqty",stldarray[5]);
            obj.put("isval",stldarray[6]);
            obj.put("balqty",stldarray[7]);
            obj.put("balval",stldarray[8]);
            obj.put("trtype",stldarray[9]);
            obj.put("cpu", stldarray[10]);
            obj.put("desc1",stldarray[11]);
            obj.put("sl",stldarray[12]);//DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) date
            obj.put("psrno",stldarray[13]);
            */
            
/*          String  sql="   select ord,valtype trtype,DATE_FORMAT(date,'%d-%m-%Y') date,convert(docno,char(100)) docno,convert(dtype,char(100)) trans_type,"
                    + " convert(inqty,char(100)) inqty,convert(inval,char(100)) inval ,convert(isqty,char(20)) isqty,convert(isval,char(100)) isval,"
                    + " convert(if(valtype!='out',cpu,''),char(100)) cpu,convert(description,char(100))  desc1,coalesce(round(@i:=@i+(inqty-isqty),2),0) balqty ,coalesce(round(@j:=@j+(inval-isval),2),0)  balval"
                    + "  from ("
                    + " select 0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) as date) date, "
                    + " 'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty, '' isval, '' balqty, '' balcost, "
                    + " ops.inval/ops.inqty cpu from (select sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from "
                    + "  (select (p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price  "
                    + " cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p  left join (select sum(qty) outqty,stockid from my_prddout where "
                    + "     cast(date as date)<'"+frmdate+"' "+opsql+"   group by stockid) a      on a.stockid=p.stockid "
                            + " where  cast(p.date as date)<'"+frmdate+"'  "+opsql+"  group by p.Stockid)  op group by op.prdid ) ops  "+sqljoin2+" where 1=1 "+wheresql+""
                                    + " union all  "
                    + "select 1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
                    + "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, "
                         + "    ins.isval,ins.balqty,ins.balcost,ins.cpu from  "
                         + "(select pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
                         + "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  "
                         + "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
                         + "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
                         + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
                         + "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
                         + "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
                         + " ' ' isqty, ' '  isval,  "
                         + " ' ' balqty, ' ' balcost,  "
                         + " cost_price cpu  from my_prddin pin  "
                          + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
                          + "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV'  "
                          + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  "
                          + "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  "
                          + "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
                          + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and "
                          + "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"  "
                          + "group by pin.stockid order by pin.stockid) ins  "
                          + "left join my_head h on(h.doc_no=ins.acno)  "
                          + " union all  "
                         + " select 2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,ac.refname description,outs.Stockid,outs.dtype,outs.docno,  "
                         + " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty*outs.issuecostprice isval ,  "
                          + "' 'balqty,' ' balcost, outs.issuecostprice cpu  "
                          + "from (select case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
                          + "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
                          + "   when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  "
                          + "   when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
                          + "   when  pout.dtype='GIS' then GIS.voc_no  "
                          + "   else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
                          + " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno   when  pout.dtype='INV' then INV.cldocno  "
                          + "   when  pout.dtype='GIS' then GIS.cldocno     else ''  end as cldocno , "
                          + "   case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
                         + "    when pout.dtype='SOR' then SOR.acno  "
                         + "    when  pout.dtype='DEL' then DEL.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
                         + "    when  pout.dtype='GIS' then GIS.acno  "
                         + "    else ''  end as acno, case when  pout.dtype='DEL' then  "
                         + "    de.del_qty  "
                         + "    when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
                         + "     rs.rsv_qty  "
                         + "    else pout.qty end as issqty, p.cost_price issuecostprice  "
                         + "    from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR'  "
                         + " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
                         + " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
                         + "    left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  "
                         + "    left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  "
                         + "    left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
                         + "    left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
                         + "    left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
                         + "    left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype='INV'  "
                         + "    left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
                         + "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
                         + "    where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs  "
                         + "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on(ac.doc_no=outs.cldocno and ac.dtype='CRM') ) "
                         + "  res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no ";
*/
            
            
            int config=0;
            String  sql="";
            String strConfig="select method from gl_config where field_nme='Stocklederinout'";
          //  System.out.println("====configval===="+strConfig);
            ResultSet rsconfig = stmt.executeQuery(strConfig);
            while(rsconfig.next()){
                config=rsconfig.getInt("method");
                //System.out.println("===configmethod==="+config);
            }

            if(config==0){
            
                /*
                 * sql="   select branchname,loc_name,ord,valtype trtype,DATE_FORMAT(date,'%d-%m-%Y') date,convert(docno,char(100)) docno,convert(dtype,char(100)) trans_type,"
                 * +
                 * " convert(inqty,char(100)) inqty,convert(inval,char(100)) inval ,convert(isqty,char(20)) isqty,convert(isval,char(100)) isval,"
                 * +
                 * " convert(if(valtype!='out',cpu,''),char(100)) cpu,convert(description,char(100))  desc1,coalesce(round(@i:=@i+(inqty-issqty1),2),0) balqty ,coalesce(round(@j:=@j+(inval-isval1),2),0)  balval"
                 * + "  from (" +
                 * " select ops.branchname,ops.loc_name,0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"
                 * +frmdate+"', INTERVAL -1 DAY) as date) date, " +
                 * " 'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty,'' issqty1, '' isval, '' isval1, '' balqty, '' balcost, "
                 * +
                 * " ops.inval/ops.inqty cpu from (select op.branchname,op.loc_name,sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from "
                 * +
                 * "  (select bh.branchname,lm.loc_name,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price  "
                 * +
                 * " cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p left join (select sum(qty+del_qty+rsv_qty) outqty,stockid from my_prddout where "
                 * + "     cast(date as date)<'"+frmdate+"' "
                 * +opsql+"   group by stockid) a      on a.stockid=p.stockid left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no "
                 * + " where  cast(p.date as date)<'"+frmdate+"'  "
                 * +psql+"  group by p.Stockid)  op group by op.prdid ) ops  "
                 * +sqljoin2+" where 1=1 "+wheresql+"" + " union all  " +
                 * "select ins.branchname,ins.loc_name,1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
                 * +
                 * "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, ins.isqty issqty1, "
                 * + "  ins.isval,ins.isval isval1,ins.balqty,ins.balcost,ins.cpu from  " +
                 * "(select bh.branchname,lm.loc_name,pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
                 * +
                 * "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  when pin.dtype='PHK' then PHK.voc_no  "
                 * +
                 * "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
                 * +
                 * "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
                 * + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
                 * +
                 * "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
                 * +
                 * "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
                 * + " ' ' isqty,' ' isqty1, ' '  isval, ' '  isval1,  " +
                 * " ' ' balqty, ' ' balcost,  " +
                 * " cost_price cpu  from my_prddin pin left join my_brch bh on pin.brhid=bh.doc_no left join my_locm lm on  pin.locid=lm.doc_no  "
                 * + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  " +
                 * "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV' left join my_phkm PHK on PHK.tr_no=pin.tr_no and pin.dtype='PHK'  "
                 * + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  " +
                 * "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  " +
                 * "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
                 * + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "
                 * +sqljoin+" where 1=1  and " +
                 * "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"
                 * +todate+"'  "+insql+" "+wheresql+"  " +
                 * "group by pin.stockid order by pin.stockid) ins  " +
                 * "left join my_head h on(h.doc_no=ins.acno)  " + " union all  " +
                 * " select branchname,loc_name,2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,if(outs.dtypess='GIS',outs.description,ac.refname) description,outs.Stockid,outs.dtype,outs.docno,  "
                 * +
                 * " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty1,outs.issqty*outs.issuecostprice isval , "
                 * + " outs.issqty1*outs.issuecostprice isval1,  " +
                 * "' 'balqty,' ' balcost, outs.issuecostprice cpu  " +
                 * "from (select GIS.description,pout.dtype dtypess,bh.branchname,lm.loc_name,case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
                 * +
                 * "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
                 * +
                 * "    when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  when pout.dtype='PHK' then PHK.voc_no  "
                 * +
                 * "    when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INC' then INV.voc_no  when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
                 * + "  when  pout.dtype='GIS' then GIS.voc_no  " +
                 * "    else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
                 * +
                 * " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno  when  pout.dtype='INC' then INV.cldocno   when  pout.dtype='INV' then INV.cldocno  "
                 * + "  when  pout.dtype='GIS' then GIS.cldocno     else ''  end as cldocno , "
                 * +
                 * "    case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
                 * + "    when pout.dtype='SOR' then SOR.acno  " +
                 * "    when  pout.dtype='DEL' then DEL.acno when  pout.dtype='INC' then INV.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
                 * + "  when  pout.dtype='GIS' then GIS.acno  " +
                 * "    else ''  end as acno, case when  pout.dtype='DEL' then  " +
                 * "    de.del_qty  " + "   when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
                 * + "   rs.rsv_qty  " +
                 * "    else pout.qty end as issqty, case when  pout.dtype='DEL' then  " +
                 * "    de.del_qty  " + "   when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
                 * + "   rs.rsv_qty  " +
                 * "    else pout.qty+pout.del_qty end as issqty1, p.cost_price issuecostprice "
                 * +
                 * "    from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR' left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no  "
                 * +
                 * " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
                 * +
                 * " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
                 * + "  left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  " +
                 * "    left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  " +
                 * "    left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
                 * +
                 * "    left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
                 * + "  left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
                 * +
                 * "    left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype in ('INV','INC')  left join my_phkm PHK on PHK.tr_no=pout.tr_no and pout.dtype='PHK'  "
                 * +
                 * "    left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
                 * +
                 * "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "
                 * +sqljoin1+" " +
                 * "    where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"
                 * +frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "
                 * +wheresql+"   order by stockid,pout.doc_no) outs  " +
                 * "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on ((ac.doc_no=outs.cldocno and ac.dtype='CRM' and outs.dtype!='PIR') or ((ac.doc_no=outs.cldocno and ac.dtype='VND' and outs.dtype='PIR')) ) ) "
                 * +
                 * "  res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no "
                 * ;
                 */
                sql="select branchname,loc_name,ord,valtype trtype,DATE_FORMAT(date,'%d-%m-%Y') date,convert(docno,char(100)) docno,convert(acno,char(100)) acno,convert(dtype,char(100)) trans_type,convert(inqty,char(100)) inqty,convert(inval,char(100)) inval ,convert(isqty,char(20)) isqty,convert(isval,char(100)) isval, convert(if(valtype!='out',cpu,''),char(100)) cpu,convert(description,char(100))  desc1,coalesce(round(@i:=@i+(inqty-issqty1),2),0) balqty ,coalesce(round(@j:=@j+(inval-isval1),2),0)  balval from"
                         + "( select ops.branchname,ops.loc_name,0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) as date) date,'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty,'' issqty1, '' isval, '' isval1, '' balqty, '' balcost,ops.inval/ops.inqty cpu from (select op.branchname,op.loc_name,sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from"
                         + "(select bh.branchname,lm.loc_name,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p    left join (select sum(qty+del_qty+rsv_qty) outqty,stockid from my_prddout where cast(date as date)<'"+frmdate+"' "+opsql+"   group by stockid) a      on a.stockid=p.stockid left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no where  cast(p.date as date)<'"+frmdate+"'  "+psql+"  group by p.Stockid)  op group by op.prdid ) ops  "+sqljoin2+" where 1=1 "+wheresql+" "
                        + " union all  select ins.branchname,ins.loc_name,1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description,ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, ins.isqty issqty1, ins.isval,ins.isval isval1,ins.balqty,ins.balcost,ins.cpu from (select "
                        + " bh.branchname,lm.loc_name,pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  when pin.dtype='PHK' then PHK.voc_no when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno when pin.dtype='PHK' then PHK.acno when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno, pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval , ' ' isqty,' ' isqty1, ' '  isval, ' '  isval1,   ' ' balqty, ' ' balcost,cost_price cpu  from my_prddin pin left join my_brch bh on pin.brhid=bh.doc_no "
                        + " left join my_locm lm on  pin.locid=lm.doc_no left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
                        + " left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV' left join my_phkm PHK on PHK.tr_no=pin.tr_no and pin.dtype='PHK'  left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR' "
                        + " left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR' left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'"
                        + " left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"group by pin.stockid order by pin.stockid) ins left join my_head h on(h.doc_no=ins.acno) "
                         + " union all select branchname,loc_name,2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno,outs.date,if(outs.dtype='PHK' and outs.cldocno=0,outs.description,ac.refname) description,outs.Stockid,outs.dtype,outs.docno,  outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty1,outs.issqty*outs.issuecostprice isval ,outs.issqty1*outs.issuecostprice isval1,' 'balqty,' ' balcost, outs.issuecostprice cpu from (select PHK.description,pout.dtype dtypess,bh.branchname,lm.loc_name,case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  when pout.dtype='PHK' then PHK.voc_no when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INC' then INV.voc_no  when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  when  pout.dtype='GIS' then GIS.voc_no else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno  when  pout.dtype='PHK' then PHK.cldocno  when  pout.dtype='DEL'  then DEL.cldocno  when  pout.dtype='INC' then INV.cldocno   when  pout.dtype='INV' then INV.cldocno when  pout.dtype='GIS' then GIS.cldocno      else ''  end as cldocno ,case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  when pout.dtype='SOR' then SOR.acno  when pout.dtype='PHK' then PHK.acno when  pout.dtype='DEL' then DEL.acno when  pout.dtype='INC' then INV.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno when  pout.dtype='GIS' then GIS.acno else ''  end as acno, case when  pout.dtype='DEL' then de.del_qty  when  pout.dtype='SOR' ||  pout.dtype='JOR' then  rs.rsv_qty   else pout.qty end as issqty, case when  pout.dtype='DEL' then de.del_qty  when  pout.dtype='SOR' ||  pout.dtype='JOR' then rs.rsv_qty   else pout.qty+pout.del_qty end as issqty1, p.cost_price issuecostprice  "
                         + "from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR' left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR' "
                        + "left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR' left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR' left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype in ('INV','INC')  left join my_phkm PHK on PHK.tr_no=pout.tr_no and pout.dtype='PHK' left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
                        + " where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs   left join my_head h on(h.doc_no=outs.acno) left join my_acbook ac on ((ac.doc_no=outs.cldocno and ac.dtype='CRM' and outs.dtype!='PIR') or ((ac.doc_no=outs.cldocno and ac.dtype='VND' and outs.dtype='PIR')) ) ) res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no ";  
            
                System.out.println("==stockLedgerDe---if---tail=111=="+sql);
                
            }
            else{
                
                /*
                 * sql="   select branchname,loc_name,ord,valtype trtype,DATE_FORMAT(date,'%d-%m-%Y') date,convert(docno,char(100)) docno,convert(dtype,char(100)) trans_type,"
                 * +
                 * " convert(inqty,char(100)) inqty,convert(inval,char(100)) inval ,convert(isqty,char(20)) isqty,convert(isval,char(100)) isval,"
                 * +
                 * " convert(if(valtype!='out',cpu,''),char(100)) cpu,convert(description,char(100))  desc1,coalesce(round(@i:=@i+(inqty-issqty1),2),0) balqty ,coalesce(round(@j:=@j+(inval-isval1),2),0)  balval"
                 * + "  from (" +
                 * " select ops.branchname,ops.loc_name,0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"
                 * +frmdate+"', INTERVAL -1 DAY) as date) date, " +
                 * " 'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty,'' issqty1, '' isval, '' isval1, '' balqty, '' balcost, "
                 * +
                 * " ops.inval/ops.inqty cpu from (select op.branchname,op.loc_name,sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from "
                 * +
                 * "  (select bh.branchname,lm.loc_name,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty*p.cost_price )-(coalesce(a.cost_price,0)))  "
                 * +
                 * " cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p left join (select sum(qty+del_qty+rsv_qty) outqty,stockid,sum((qty+del_qty+rsv_qty)*cost_price) cost_price from my_prddout where "
                 * + "     cast(date as date)<'"+frmdate+"' "
                 * +opsql+"   group by stockid) a      on a.stockid=p.stockid left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no "
                 * + " where  cast(p.date as date)<'"+frmdate+"'  and p.brhid in ("
                 * +branchid+")  group by p.Stockid)  op group by op.prdid ) ops  "
                 * +sqljoin2+" where 1=1 "+wheresql+"" + " union all  " +
                 * "select ins.branchname,ins.loc_name,1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description, "
                 * +
                 * "ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, ins.isqty issqty1, "
                 * + "  ins.isval,ins.isval isval1,ins.balqty,ins.balcost,ins.cpu from  " +
                 * "(select  bh.branchname,lm.loc_name,pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no  "
                 * +
                 * "when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  when pin.dtype='PHK' then PHK.voc_no  "
                 * +
                 * "when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,  "
                 * +
                 * "case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno  "
                 * + "when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno  "
                 * +
                 * "when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno,  "
                 * +
                 * "pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval ,  "
                 * + " ' ' isqty,' ' isqty1, ' '  isval, ' '  isval1,  " +
                 * " ' ' balqty, ' ' balcost,  " +
                 * " cost_price cpu  from my_prddin pin left join my_brch bh on pin.brhid=bh.doc_no left join my_locm lm on  pin.locid=lm.doc_no  "
                 * + "left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  " +
                 * "left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV' left join my_phkm PHK on PHK.tr_no=pin.tr_no and pin.dtype='PHK'  "
                 * + "left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR'  " +
                 * "left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR'  " +
                 * "left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'  "
                 * + "left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "
                 * +sqljoin+" where 1=1  and " +
                 * "  cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"
                 * +todate+"'  "+insql+" "+wheresql+"  " +
                 * "group by pin.stockid order by pin.stockid) ins  " +
                 * "left join my_head h on(h.doc_no=ins.acno)  " + " union all  " +
                 * " select branchname,loc_name,2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,if(outs.dtypess='GIS',outs.description,ac.refname) description,outs.Stockid,outs.dtype,outs.docno,  "
                 * +
                 * " outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty1,outs.issqty*outs.issuecostprice isval , "
                 * + " outs.issqty1*outs.issuecostprice isval1,  " +
                 * "' 'balqty,' ' balcost, outs.issuecostprice cpu  " +
                 * "from (select GIS.description,pout.dtype dtypess,bh.branchname,lm.loc_name,case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,  "
                 * +
                 * "case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no  "
                 * +
                 * "    when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  when pout.dtype='PHK' then PHK.voc_no  "
                 * +
                 * "    when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INC' then INV.voc_no  when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  "
                 * + "  when  pout.dtype='GIS' then GIS.voc_no  " +
                 * "    else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  "
                 * +
                 * " then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno    when  pout.dtype='DEL'  then DEL.cldocno  when  pout.dtype='INC' then INV.cldocno   when  pout.dtype='INV' then INV.cldocno  "
                 * + "  when  pout.dtype='GIS' then GIS.cldocno     else ''  end as cldocno , "
                 * +
                 * "    case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  "
                 * + "    when pout.dtype='SOR' then SOR.acno  " +
                 * "    when  pout.dtype='DEL' then DEL.acno when  pout.dtype='INC' then INV.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno  "
                 * + "  when  pout.dtype='GIS' then GIS.acno  " +
                 * "    else ''  end as acno, case when  pout.dtype='DEL' then  " +
                 * "    de.del_qty  " + "   when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
                 * + "   rs.rsv_qty  " +
                 * "    else pout.qty end as issqty, case when  pout.dtype='DEL' then  " +
                 * "    de.del_qty  " + "   when  pout.dtype='SOR' ||  pout.dtype='JOR' then  "
                 * + "   rs.rsv_qty  " +
                 * "    else pout.qty+pout.del_qty end as issqty1, pout.cost_price issuecostprice "
                 * +
                 * "    from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR' left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no  "
                 * +
                 * " left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no "
                 * +
                 * " left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
                 * + "  left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR'  " +
                 * "    left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  " +
                 * "    left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  "
                 * +
                 * "    left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR'  "
                 * + "  left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  "
                 * +
                 * "    left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype in ('INV','INC')  left join my_phkm PHK on PHK.tr_no=pout.tr_no and pout.dtype='PHK'  "
                 * +
                 * "    left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  "
                 * +
                 * "    left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "
                 * +sqljoin1+" " +
                 * "    where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"
                 * +frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "
                 * +wheresql+"   order by stockid,pout.doc_no) outs  " +
                 * "    left join my_head h on(h.doc_no=outs.acno)     left join my_acbook ac on ((ac.doc_no=outs.cldocno and ac.dtype='CRM' and outs.dtype!='PIR') or ((ac.doc_no=outs.cldocno and ac.dtype='VND' and outs.dtype='PIR')) ) ) "
                 * +
                 * "  res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no "
                 * ;
                 */
                sql="select branchname,loc_name,ord,valtype trtype,DATE_FORMAT(date,'%d-%m-%Y') date,convert(docno,char(100)) docno,convert(acno,char(100)) acno,convert(dtype,char(100)) trans_type,convert(inqty,char(100)) inqty,convert(inval,char(100)) inval ,convert(isqty,char(20)) isqty,convert(isval,char(100)) isval, convert(if(valtype!='out',cpu,''),char(100)) cpu,convert(description,char(100))  desc1,coalesce(round(@i:=@i+(inqty-issqty1),2),0) balqty ,coalesce(round(@j:=@j+(inval-isval1),2),0)  balval from "
                         + " (select ops.branchname,ops.loc_name,0 ord, 0 minus,'OP' valtype, 0  tr_no,ops.prdid psrno,cast(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) as date) date,'OPENING' description,0 stockid,'OPN' dtype, '' docno, '' acno,ops.inqty, ops.inval,'' isqty,'' issqty1, '' isval, '' isval1, '' balqty, '' balcost,ops.inval/ops.inqty cpu from (select op.branchname,op.loc_name,sum(op.opqty) inqty,sum(op.cost_price)  inval,op.prdid from"
                         + " (select bh.branchname,lm.loc_name,(p.op_qty)-(coalesce(a.outqty,0)) opqty ,((op_qty)-(coalesce(a.outqty,0)))*p.cost_price cost_price,p.Stockid,p.prdid,p.brhid from my_prddin  p   left join (select sum(qty+del_qty+rsv_qty) outqty,stockid from my_prddout where cast(date as date)<'"+frmdate+"' "+opsql+"   group by stockid) a      on a.stockid=p.stockid left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no where  cast(p.date as date)<'"+frmdate+"'  "+psql+"  group by p.Stockid)  op group by op.prdid ) ops  "+sqljoin2+" where 1=1 "+wheresql+" "
                        + " union all  select ins.branchname,ins.loc_name,1 ord,0 minus,'in' valtype, ins.tr_no, ins.psrno,ins.date,h.description,ins.stockid,ins.dtype,ins.docno,ins.acno,ins.inqty,ins.inval,ins.isqty, ins.isqty issqty1, ins.isval,ins.isval isval1,ins.balqty,ins.balcost,ins.cpu from (select "
                        + " bh.branchname,lm.loc_name,pin.tr_no,pin.stockid, case when pin.dtype='GRN' then GRN.voc_no   when pin.dtype='PIV' then PIV.voc_no when pin.dtype='DLR' then DLR.voc_no  when pin.dtype='INR' then INR.voc_no  when pin.dtype='PHK' then PHK.voc_no when  pin.dtype='ITR' then ITR.voc_no   when  pin.dtype='GIR' then GIR.voc_no  else ''  end as DOCNO,case when pin.dtype='GRN' then GRN.acno   when pin.dtype='PIV' then PIV.acno when pin.dtype='DLR' then DLR.acno  when pin.dtype='INR' then INR.acno when pin.dtype='PHK' then PHK.acno when  pin.dtype='ITR' then ITR.acno   when  pin.dtype='GIR' then GIR.acno  else ''  end as acno, pin.dtype, pin.brhid,pin.psrno,pin.date ,pin.op_qty inqty ,pin.op_qty*pin.cost_price inval , ' ' isqty,' ' isqty1, ' '  isval, ' '  isval1,   ' ' balqty, ' ' balcost,cost_price cpu  from my_prddin pin left join my_brch bh on pin.brhid=bh.doc_no "
                        + " left join my_locm lm on  pin.locid=lm.doc_no left join my_grnm GRN on GRN.tr_no=pin.tr_no and pin.dtype='GRN'  "
                        + " left join my_srvm piv on PIV.tr_no=pin.tr_no and pin.dtype='PIV' left join my_phkm PHK on PHK.tr_no=pin.tr_no and pin.dtype='PHK'  left join my_delrm DLR on DLR.tr_no=pin.tr_no and pin.dtype='DLR' "
                        + " left join   my_invr  INR on INR.tr_no=pin.tr_no and pin.dtype='INR' left join   my_invtranreceptm  ITR on ITR.tr_no=pin.tr_no and pin.dtype='ITR'"
                        + " left join   my_girm  GIR on GIR.tr_no=pin.tr_no and pin.dtype='GIR' "+sqljoin+" where 1=1  and cast(pin.date as date)>='"+frmdate+"' and cast(pin.date as date)<='"+todate+"'  "+insql+" "+wheresql+"group by pin.stockid order by pin.stockid) ins left join my_head h on(h.doc_no=ins.acno) "
                         + " union all select branchname,loc_name,2 ord,outs.minus ,'out' valtype, outs.tr_no,outs.psrno, outs.date,if(outs.dtype='PHK' and outs.cldocno=0,outs.description,ac.refname) description,outs.Stockid,outs.dtype,outs.docno, outs.acno,' ' inqty,' ' inval,outs.issqty isqty,outs.issqty1,outs.issqty*outs.issuecostprice isval ,  outs.issqty1*outs.issuecostprice isval1,' 'balqty,' ' balcost, outs.issuecostprice cpu from "
                         + "(select PHK.description ,pout.dtype dtypess,bh.branchname,lm.loc_name,case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,case when pout.dtype='GRR' then GRR.voc_no   when pout.dtype='PIR' then PIR.voc_no when pout.dtype='SOR' then SOR.voc_no  when pout.dtype='JOR' then JOR.voc_no  when pout.dtype='PHK' then PHK.voc_no when  pout.dtype='DEL' then DEL.voc_no   when  pout.dtype='INC' then INV.voc_no  when  pout.dtype='INV' then INV.voc_no  when  pout.dtype='ITI' then ITI.voc_no  when  pout.dtype='GIS' then GIS.voc_no else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when pout.dtype='SOR'  then SOR.cldocno  when pout.dtype='JOR' then JOR.cldocno  when  pout.dtype='PHK' then PHK.cldocno  when  pout.dtype='DEL'  then DEL.cldocno  when  pout.dtype='INC' then INV.cldocno   when  pout.dtype='INV' then INV.cldocno when  pout.dtype='GIS' then GIS.cldocno     else ''  end as cldocno ,case when pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  when pout.dtype='SOR' then SOR.acno  when pout.dtype='PHK' then PHK.acno when  pout.dtype='DEL' then DEL.acno when  pout.dtype='INC' then INV.acno   when  pout.dtype='INV' then INV.acno  when  pout.dtype='ITI' then ITI.acno when  pout.dtype='GIS' then GIS.acno else ''  end as acno, case when  pout.dtype='DEL' then de.del_qty  when  pout.dtype='SOR' ||  pout.dtype='JOR' then  rs.rsv_qty   else pout.qty end as issqty, case when  pout.dtype='DEL' then de.del_qty  when  pout.dtype='SOR' ||  pout.dtype='JOR' then rs.rsv_qty   else pout.qty+pout.del_qty end as issqty1, p.cost_price issuecostprice  "
                         + "from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR' left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no left join (select rsv_qty,stockid,doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no left join (select del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR' "
                        + "left join my_srrm PIR on PIR.tr_no=pout.tr_no and pout.dtype='PIR'  left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR' left join   my_joborderm  JOR on JOR.tr_no=pout.tr_no and pout.dtype='JOR' left join   my_delm  DEL on DEL.tr_no=pout.tr_no and pout.dtype='DEL'  left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype in ('INV','INC')  left join my_phkm PHK on PHK.tr_no=pout.tr_no and pout.dtype='PHK' left join   my_invtranissuem ITI on ITI.tr_no=pout.tr_no and pout.dtype='ITI'  left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'  "+sqljoin1+" "
                        + " where 1=1  and  pout.dtype!='SOR' and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+"  "+wheresql+"   order by stockid,pout.doc_no) outs   left join my_head h on(h.doc_no=outs.acno) left join my_acbook ac on ((ac.doc_no=outs.cldocno and ac.dtype='CRM' and outs.dtype!='PIR') or ((ac.doc_no=outs.cldocno and ac.dtype='VND' and outs.dtype='PIR')) ) ) res,(select @i:=0) as i,(select @j:=0) as j order by res.psrno, res.date,res.tr_no ";  
                System.out.println("==stockLedgerDe---else---tail=111=="+sql);
                
            }
    System.out.println("==stockLedgerDetail=111=="+sql);
            
            
    /*       left join (select sum(del_qty) del_qty,stockid,doc_no from my_prddout group by stockid) de
               on de.Stockid=pout.stockid*/

        //  ArrayList<String> stldarray= new ArrayList<String>();
            ResultSet rs = stmt.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(rs);
            
            
            
        /*  
            String valtype="";
            
            String  psrno="";
            String  trtype="";
            String  docno="";
            String  date="";
            String  trans_type="";
            String  desc1="";
            
            String totalqty1="",issueqty1="",balqty1="",remqty1 ="";
            
            String  cpu1="",inval1="",isval1="",totbalval1="";
            
            
            double totalqty=0,issueqty=0,balqty=0,remqty = 0;
            
            double cpu=0,inval=0,isval=0,totbalval=0;
            int i=0;
            int j=0;
            int k=0;

            int minus=0;
            while(rs.next()){
                
                valtype=rs.getString("valtype");
                if(valtype.equalsIgnoreCase("in"))
                {
                    totalqty=rs.getDouble("inqty");
                    remqty=totalqty;
                    issueqty=0;
                    i=i+1;
                    j=0;
                }
                else if(valtype.equalsIgnoreCase("out"))
                {
                    totalqty=0;
                    issueqty=rs.getDouble("isqty");
                    
                    minus=rs.getInt("minus");
        //          System.out.println("======minus======"+minus);
                    
                    if(minus>=0)
                    {
                    remqty=remqty-issueqty;
                    }
                    j=j+1;
                }
                
                balqty=remqty;
            
            
            
            psrno=rs.getString("psrno");
            trtype=valtype;
            docno=rs.getString("docno");
            date=rs.getString("date");
            trans_type=rs.getString("dtype");
            desc1=rs.getString("description");
            
    
            cpu=rs.getDouble("cpu");
            
            if(totalqty>0)
            {
                inval=totalqty*cpu;
                totalqty1=totalqty+"";
                inval1=inval+"";
                cpu1=cpu+"";
            }
            else
            {
                cpu1="";
                totalqty1="";
                inval1="";
            }
            if(issueqty>0)
            {
            isval=issueqty*cpu;
            issueqty1=issueqty+"";
            isval1=isval+"";
            }
            else
            {
                
                 if(valtype.equalsIgnoreCase("out"))
                    {
                     
                    issueqty1="0";
                    isval1="0";
                    }
                 else
                 {
                issueqty1="";
                isval1="";
                 }
                
            }
            if(balqty>=0 && minus>=0)
            {
            totbalval=balqty*cpu;
            balqty1=balqty+"";
            totbalval1=totbalval+"";
            }
            else
            {
                
                balqty1="";
                totbalval1="";  
            }
            
            
            if(valtype.equalsIgnoreCase("in"))
            {
              k=i;
            }
            else if(valtype.equalsIgnoreCase("out"))
            {
                  k=j;
            }
         
            stldarray.add(date+"::"+docno+"::"+trans_type+"::"+totalqty1+"::"+inval1+"::"+issueqty1+"::"+isval1+"::"+balqty1+"::"+totbalval1+"::"+trtype+"::"+cpu1+"::"+desc1+"::"+k+"::"+psrno);
            
            }
            
        //  System.out.println("==============="+stldarray);


            String psrno="0",prvpsrno="0",pno="",pname="",docno="",trans_type="",trtype="",date="",desc1="";
            double inqty=0.00,inval=0.00,isqty=0.00,isval=0.00,balqty=0.00,balval=0.00,totinqty=0.0,totinval=0.0,totisqty=0.0,totisval=0.0,totbalqty=0.0,totbalval=0.0,cpu=0.0;
            int i=0;
            int k=1;
            while(rs.next()){
                psrno=rs.getString("psrno");
                trtype=rs.getString("trtype");
                docno=rs.getString("docno");
                date=rs.getString("date");
                trans_type=rs.getString("trans_type");
                desc1=rs.getString("desc1");
                if(!(prvpsrno.equalsIgnoreCase(psrno))){
                    k=1;
                    if(i!=0){
                        cpu=totbalval/totbalqty;
                    stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+cpu+"::"+pname+"::"+""+"::"+psrno);
                    }
                    inqty=0.00;inval=0.00;isqty=0.00;isval=0.00;balqty=0.00;balval=0.00;totinqty=0.0;totinval=0.0;totisqty=0.0;totisval=0.0;totbalqty=0.0;totbalval=0.0;
                    pno=rs.getString("pno");
                    pname=rs.getString("pname");
                    psrno=rs.getString("psrno");
                    trtype=rs.getString("trtype");
                    docno=rs.getString("docno");
                    date=rs.getString("date");
                    trans_type=rs.getString("trans_type");
                    desc1=rs.getString("desc1");
                }
                
                inqty=Double.parseDouble(rs.getString("inqty"));inval=Double.parseDouble(rs.getString("inval"));
                isqty=Double.parseDouble(rs.getString("isqty"));isval=Double.parseDouble(rs.getString("isval"));
                balqty=Double.parseDouble(rs.getString("balqty"));balval=Double.parseDouble(rs.getString("balval"));
                totinqty=totinqty+inqty;
                totisqty=totisqty+isqty;
                totinval=totinval+inval;
                totisval=totisval+isval;
                totbalqty=totbalqty+balqty;
                totbalval=totbalval+balval;
                if(trtype.equalsIgnoreCase("2")){
                    balqty=totinqty-totisqty;
                    balval=totinval-totisval;
                            
                }
                
                prvpsrno=psrno;
                
                stldarray.add(date+"::"+docno+"::"+trans_type+"::"+inqty+"::"+inval+"::"+isqty+"::"+isval+"::"+totbalqty+"::"+totbalval+"::"+trtype+"::"+" "+"::"+desc1+"::"+k+"::"+psrno);
                
                i++;
                k++;
    
            }
            cpu=totbalval/totbalqty;
            stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+cpu+"::"+pname+"::"+""+"::"+psrno);
            //stldarray.add(""+"::"+pno+"::"+""+"::"+totinqty+"::"+totinval+"::"+totisqty+"::"+totisval+"::"+totbalqty+"::"+totbalval+"::0"+"::"+pname+"::"+"");
            */
        //  RESULTDATA=convertArrayToJSON(stldarray);


        }catch(Exception e){
            e.printStackTrace();

        }finally{
            conn.close();
        }
        return RESULTDATA;
    }
    public JSONArray stockDetailInfo(HttpSession session,String fromDate,String toDate,String branchid,String load) throws SQLException {
        
//      System.out.println("load==============="+load);
        JSONArray RESULTDATA=new JSONArray();
        if(!(load.equalsIgnoreCase("yes")))
        {
            return RESULTDATA;
        }
        
        Connection conn = null;
        
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String minyom="",maxyom="";
            String sqljoin ="";
            String sqljoin1 ="";
            String sqljoin2 ="";
            String wheresql="";
            String sql="";
            String insql="";
            String outsql="";
            
            java.sql.Date frmdate=ClsCommon.changeStringtoSqlDate(fromDate);
            
            java.sql.Date todate=ClsCommon.changeStringtoSqlDate(toDate);
            
         
            
            String opsql="",psql=" ";
            if(!(branchid.equalsIgnoreCase("0") || branchid.equalsIgnoreCase("") || branchid.equals("undefined")|| branchid.equalsIgnoreCase("a"))){
                insql=" and pin.brhid in ("+branchid+")";
                outsql=" and pout.brhid in ("+branchid+")";
                opsql=" and brhid in ("+branchid+")";
                psql=" and p.brhid in ("+branchid+") ";
                
            } 
            sqljoin = " left join my_main m on(pin.psrno=m.psrno) "
                    + " left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + " left join my_brand bd on(m.brandid=bd.doc_no) "
                    + " left join my_dept dep on(dep.doc_no=m.deptid) "
                    + " left join my_catm cat on(m.catid=cat.doc_no)"
                    + " left join my_scatm sc on(m.scatid=sc.doc_no)" ;
            sqljoin1 = " left join my_main m on(pout.psrno=m.psrno) "
                    + " left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + " left join my_brand bd on(m.brandid=bd.doc_no) "
                    + " left join my_dept dep on(dep.doc_no=m.deptid) "
                    + " left join my_catm cat on(m.catid=cat.doc_no) "
                    + " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
            sqljoin2 = " left join my_main m on(ops.prdid=m.psrno) "
                    + " left join my_ptype pt on(m.typeid=pt.doc_no) "
                    + " left join my_brand bd on(m.brandid=bd.doc_no) "
                    + " left join my_dept dep on(dep.doc_no=m.deptid) "
                    + " left join my_catm cat on(m.catid=cat.doc_no) "
                    + " left join my_scatm sc on(m.scatid=sc.doc_no) " ;
               
                /*sql="select * from(SELECT branchname AS branchname, loc_name AS loc_name, SUM(ord) AS ord, valtype AS valtype, psrno AS psrno, date AS "
                        + "date, description AS description, SUM(stockid) AS stockid, 'OPN' AS dtype, docno AS docno, acno AS acno, SUM(inqty) AS inqty,"
                        + " SUM(account) AS account FROM (SELECT op.branchname AS branchname, op.loc_name AS loc_name, 0 AS ord, 'OP' AS valtype, "
                        + "'' AS psrno, CAST(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) AS DATE) AS date, 'OPENING' AS description, 0 AS stockid, 'OPN' "
                        + "AS dtype, '' AS docno, '' AS acno, SUM(op.opqty) AS inqty,   0 AS account FROM (SELECT bh.branchname, lm.loc_name, "
                        + "(p.op_qty - COALESCE(a.outqty, 0)) AS opqty, (p.op_qty - COALESCE(a.outqty, 0)) * p.cost_price AS cost_price, "
                        + "p.Stockid, p.prdid, p.brhid FROM my_prddin p LEFT JOIN (SELECT SUM(qty + del_qty + rsv_qty) AS outqty, stockid FROM "
                        + "my_prddout WHERE CAST(date AS DATE) < '"+frmdate+"' "+opsql+" GROUP BY stockid) a ON a.stockid = p.stockid LEFT JOIN "
                        + "my_brch bh ON p.brhid = bh.doc_no LEFT JOIN my_locm lm ON p.locid = lm.doc_no WHERE CAST(p.date AS DATE) "
                        + "< '"+frmdate+"' "+psql+" GROUP BY p.Stockid) op GROUP BY op.prdid UNION ALL SELECT '' AS branchname, '' "
                        + "AS loc_name, 0 AS ord, '' AS valtype, '' AS psrno, '' AS date, '' AS description, 0 AS stockid, 'OPN' "
                        + "AS dtype, '' AS docno, '' AS acno, 0 AS inqty,  SUM(ldramount) AS account FROM my_jvtran jv WHERE "
                        + "jv.acno IN (SELECT acno FROM my_account WHERE codeno = 'STOCK ACCOUNT') AND jv.date < '"+todate+"') combined UNION ALL  "
                        + "SELECT ins.branchname, ins.loc_name, 1 AS ord,  '' AS valtype,  '' AS psrno, '' AS date, description AS description, '' "
                        + "AS stockid, CASE WHEN ins.dtype = 'GRN' THEN 'PIV' ELSE ins.dtype END AS dtype, '' AS docno, '' AS acno,SUM(ins.inqty) AS "
                        + "inqty,  SUM(ins.inval) account FROM (select bh.branchname, lm.loc_name,  pin.stockid, CASE WHEN pin.dtype = 'GRN' THEN "
                        + "GRN.voc_no WHEN pin.dtype = 'PIV' THEN PIV.voc_no  WHEN pin.dtype = 'DLR' THEN DLR.voc_no WHEN pin.dtype = 'INR' THEN "
                        + "INR.voc_no  WHEN pin.dtype = 'GIR' THEN GIR.voc_no ELSE '' END AS docno,CASE WHEN pin.dtype = 'GRN' THEN GRN.acno WHEN "
                        + "pin.dtype = 'PIV' THEN PIV.acno WHEN pin.dtype = 'DLR' THEN DLR.acno WHEN pin.dtype = 'INR' THEN INR.acno WHEN pin.dtype = "
                        + "'PHK' THEN PHK.acno WHEN pin.dtype = 'GIR' THEN GIR.acno ELSE '' END AS acno,CASE WHEN pin.dtype = 'GRN' THEN 'Purchase' WHEN "
                        + "pin.dtype = 'PIV' THEN 'Purchase' WHEN pin.dtype = 'DLR' THEN 'Delivary Note Return' WHEN pin.dtype = 'INR' THEN 'Sales "
                        + "Invoice Return' WHEN pin.dtype = 'PHK' THEN 'Physical Adjustment' WHEN pin.dtype = 'GIR' THEN 'Goods Issue Retrun' ELSE '' "
                        + "END AS description,CASE WHEN pin.dtype = 'GRN' THEN 'PIV' ELSE pin.dtype END AS dtype, pin.brhid, pin.psrno, pin.date, "
                        + "pin.op_qty AS inqty, pin.op_qty * pin.cost_price AS inval  FROM my_prddin pin LEFT JOIN my_brch bh ON pin.brhid = bh.doc_no "
                        + "LEFT JOIN my_locm lm ON pin.locid = lm.doc_no  LEFT JOIN my_grnm GRN ON GRN.tr_no = pin.tr_no AND pin.dtype = 'GRN' LEFT JOIN "
                        + "my_srvm piv ON PIV.tr_no = pin.tr_no AND pin.dtype = 'PIV' LEFT JOIN my_phkm PHK ON PHK.tr_no = pin.tr_no AND pin.dtype = 'PHK'"
                        + " LEFT JOIN my_delrm DLR ON DLR.tr_no = pin.tr_no AND pin.dtype = 'DLR' LEFT JOIN my_invr INR ON INR.tr_no = pin.tr_no AND "
                        + "pin.dtype = 'INR' LEFT JOIN my_girm GIR ON GIR.tr_no = pin.tr_no AND pin.dtype = 'GIR' "+sqljoin+"  WHERE CAST(pin.date AS DATE) >= '"+frmdate+"' AND CAST(pin.date AS DATE)"
                        + " <= '"+todate+"' "+insql+" GROUP BY pin.stockid, pin.dtype ORDER BY pin.stockid) ins GROUP BY ins.dtype)a ORDER BY "
                        + "FIELD(dtype, 'OPN', 'PIV', 'INR', 'GIR', 'PHK', 'DLR')";*/
            sql="select branchname AS branchname, loc_name AS loc_name, SUM(ord) AS ord, valtype AS valtype, psrno AS psrno, date AS date,"
                + " description AS description, SUM(stockid) AS stockid,  dtype, docno AS docno, acno AS acno, SUM(inqty) AS inqty,sum(inval) "
                + "as inval, SUM(account) AS account, cpu, CASE         WHEN SUM(account) < 0 THEN SUM(inval) + SUM(account) ELSE SUM(inval) - "
                + "SUM(account)     END AS difference from (SELECT branchname AS branchname, loc_name AS loc_name, SUM(ord) AS ord, "
                + "valtype AS valtype, psrno AS psrno, date AS date, description AS description, SUM(stockid) AS stockid, 'OPN' AS dtype, "
                + "docno AS docno, acno AS acno, SUM(inqty) AS inqty,sum(inval) as inval, SUM(account) AS account,ops.inval/ops.inqty cpu "
                + "FROM (SELECT op.branchname AS branchname, op.loc_name AS loc_name, 0 AS ord, 'OP' AS valtype, '' AS psrno, "
                + "CAST(DATE_ADD('"+frmdate+"', INTERVAL -1 DAY) AS DATE) AS date, 'OPENING' AS description, 0 AS stockid, 'OPN' AS dtype, '' "
                + "AS docno, '' AS acno, SUM(op.opqty) AS inqty,sum(op.cost_price)  inval,   '' AS account,'' cpu FROM "
                + "(SELECT bh.branchname, lm.loc_name, (p.op_qty - COALESCE(a.outqty, 0)) AS opqty, (p.op_qty - COALESCE(a.outqty, 0)) * "
                + "p.cost_price AS cost_price, p.Stockid, p.prdid, p.brhid FROM my_prddin p LEFT JOIN (SELECT SUM(qty + del_qty + rsv_qty) AS "
                + "outqty, stockid FROM my_prddout WHERE CAST(date AS DATE) < '"+frmdate+"' "+opsql+" GROUP BY stockid) a ON a.stockid = "
                + "p.stockid LEFT JOIN my_brch bh ON p.brhid = bh.doc_no LEFT JOIN my_locm lm ON p.locid = lm.doc_no WHERE CAST"
                + "(p.date AS DATE) < '"+frmdate+"'  "+psql+"  GROUP BY p.Stockid) op GROUP BY op.prdid UNION ALL SELECT '' AS "
                + "branchname, '' AS loc_name, 0 AS ord, '' AS valtype, '' AS psrno, '' AS date, '' AS description,0 AS stockid, dtype AS "
                + "dtype, '' AS docno, '' AS acno,0 AS inqty, 0 AS inval, SUM(ldramount) AS account,0 AS cpu FROM my_jvtran jv WHERE jv.acno IN "
                + "(SELECT acno FROM my_account WHERE codeno = 'STOCK ACCOUNT') AND status=3 AND jv.date < '"+frmdate+"') ops UNION ALL SELECT "
                + "ins.branchname, ins.loc_name, 1 AS ord,  '' AS valtype,  '' AS psrno, '' AS date, description AS description, '' AS stockid, "
                + "CASE WHEN ins.dtype = 'GRN' THEN 'PIV' ELSE ins.dtype END AS dtype, '' AS docno, '' AS acno,SUM(ins.inqty) AS inqty,  "
                + "SUM(ins.inval) inval,'' account,ins.cpu FROM (select bh.branchname, lm.loc_name,  pin.stockid, CASE WHEN pin.dtype = 'GRN' "
                + "THEN GRN.voc_no WHEN pin.dtype = 'PIV' THEN PIV.voc_no  WHEN pin.dtype = 'DLR' THEN DLR.voc_no WHEN pin.dtype = 'INR' THEN "
                + "INR.voc_no  WHEN pin.dtype = 'GIR' THEN GIR.voc_no ELSE '' END AS docno,CASE WHEN pin.dtype = 'GRN' THEN GRN.acno "
                + "WHEN pin.dtype = 'PIV' THEN PIV.acno WHEN pin.dtype = 'DLR' THEN DLR.acno WHEN pin.dtype = 'INR' THEN INR.acno "
                + "WHEN pin.dtype = 'PHK' THEN PHK.acno WHEN pin.dtype = 'GIR' THEN GIR.acno ELSE '' END AS acno,CASE WHEN pin.dtype = 'GRN' "
                + "THEN 'Purchase' WHEN pin.dtype = 'PIV' THEN 'Purchase' WHEN pin.dtype = 'DLR' THEN 'Delivary Note Return' WHEN pin.dtype = "
                + "'INR' THEN 'Sales Invoice Return' WHEN pin.dtype = 'PHK' THEN 'Physical Adjustment' WHEN pin.dtype = 'GIR' THEN 'Goods Issue "
                + "Retrun' ELSE '' END AS description,CASE WHEN pin.dtype = 'GRN' THEN 'PIV' ELSE pin.dtype END AS dtype, pin.brhid, pin.psrno, "
                + "pin.date, pin.op_qty AS inqty, pin.op_qty * pin.cost_price AS inval,cost_price cpu  FROM my_prddin pin LEFT JOIN my_brch bh "
                + "ON pin.brhid = bh.doc_no LEFT JOIN my_locm lm ON pin.locid = lm.doc_no  LEFT JOIN my_grnm GRN ON GRN.tr_no = pin.tr_no AND "
                + "pin.dtype = 'GRN' LEFT JOIN my_srvm piv ON PIV.tr_no = pin.tr_no AND pin.dtype = 'PIV' LEFT JOIN my_phkm PHK ON PHK.tr_no = "
                + "pin.tr_no AND pin.dtype = 'PHK' LEFT JOIN my_delrm DLR ON DLR.tr_no = pin.tr_no AND pin.dtype = 'DLR' LEFT JOIN my_invr INR "
                + "ON INR.tr_no = pin.tr_no AND pin.dtype = 'INR' LEFT JOIN my_girm GIR ON GIR.tr_no = pin.tr_no AND pin.dtype = "
                + "'GIR'  "+sqljoin+"  WHERE CAST(pin.date AS DATE) >= '"+frmdate+"' AND CAST(pin.date AS DATE) <= '"+todate+"' "+insql+" "
                + "GROUP BY pin.stockid, pin.dtype ORDER BY pin.stockid) ins GROUP BY ins.dtype union all select branchname,loc_name,2 "
                + "ord,'out' valtype,outs.psrno,outs.date,outs.description as description,outs.Stockid,outs.dtype,outs.docno,  outs.acno,outs.issqty "
                + "inqty,-1 *(outs.issqty*outs.issuecostprice) inval,'' account, outs.issuecostprice cpu from ( select pout.dtype dtypess,"
                + "bh.branchname,lm.loc_name,case when pout.dtype='INV' then if(pout.rsv_qty<0,pout.rsv_qty,pout.del_qty) else 0 end as minus,"
                + "pout.tr_no,pout.psrno,pout.Stockid,pout.dtype,cast(pout.date as date) date,case when pout.dtype='GRR' then GRR.voc_no   "
                + "when pout.dtype='PIR' then PIR.voc_no when pout.dtype='SOR' then SOR.voc_no    when  pout.dtype='DEL' then DEL.voc_no   "
                + "when  pout.dtype='INC' then INV.voc_no  when  pout.dtype='INV' then INV.voc_no   when  pout.dtype='GIS' then GIS.voc_no "
                + "else ''  end as DOCNO,   case when pout.dtype='GRR' then GRR.cldocno   when pout.dtype='PIR' then PIR.cldocno    when "
                + "pout.dtype='SOR'  then SOR.cldocno  when  pout.dtype='DEL'  then DEL.cldocno  when  pout.dtype='INC' then INV.cldocno   "
                + "when  pout.dtype='INV' then INV.cldocno when  pout.dtype='GIS' then GIS.cldocno      else ''  end as cldocno ,case when "
                + "pout.dtype='GRR' then GRR.acno   when pout.dtype='PIR' then PIR.acno  when pout.dtype='SOR' then SOR.acno   when  "
                + "pout.dtype='DEL' then DEL.acno when  pout.dtype='INC' then INV.acno   when  pout.dtype='INV' then INV.acno   when  "
                + "pout.dtype='GIS' then GIS.acno else ''  end as acno,CASE WHEN pout.dtype = 'INV' THEN 'Sales Invoice' WHEN pout.dtype = 'PIR'"
                + " THEN 'Purchase Invoice Retrun' WHEN pout.dtype = 'GIS' THEN 'Goods Issue Note' WHEN pout.dtype = 'JVT' THEN '' WHEN "
                + "pout.dtype = 'DEL' THEN 'Delivary Note' ELSE '' END AS description, case when  pout.dtype='DEL' then de.del_qty  when  "
                + "pout.dtype='SOR' ||  pout.dtype='JOR' then  rs.rsv_qty   else pout.qty end as issqty,  p.cost_price issuecostprice  "
                + "from my_prddout pout left join  my_prddin p     on pout.stockid=p.stockid and pout.dtype!='SOR'  and pout.dtype!='JOR' "
                + "left join my_brch bh on p.brhid=bh.doc_no left join my_locm lm on  p.locid=lm.doc_no left join (select rsv_qty,stockid,"
                + "doc_no from my_prddout group by stockid,doc_no) rs on rs.Stockid=pout.stockid and rs.doc_no=pout.doc_no left join (select "
                + "del_qty,stockid,doc_no from my_prddout group by stockid,doc_no) de on de.Stockid=pout.stockid and de.doc_no=pout.doc_no "
                + "left join my_grrm GRR on GRR.tr_no=pout.tr_no and pout.dtype='GRR' left join my_srrm PIR on PIR.tr_no=pout.tr_no and "
                + "pout.dtype='PIR'  left join my_sorderm SOR on SOR.tr_no=pout.tr_no and pout.dtype='SOR'  left join   my_delm  DEL on "
                + "DEL.tr_no=pout.tr_no and pout.dtype='DEL'  left join   my_invm  INV on INV.tr_no=pout.tr_no and pout.dtype in ('INV','INC')"
                + " left join   my_gism  GIS on GIS.tr_no=pout.tr_no and GIS.dtype='GIS'   "+sqljoin1+"   where 1=1  and  pout.dtype!='SOR' "
                + "and pout.dtype!='JOR' and cast(pout.date as date)>='"+frmdate+"' and cast(pout.date as date)<='"+todate+"'   "+outsql+" "
                + "group by dtypess order by stockid) outs   left join my_head h on(h.doc_no=outs.acno) left join my_acbook ac "
                + "on ((ac.doc_no=outs.cldocno and ac.dtype='CRM' and outs.dtype!='PIR') or ((ac.doc_no=outs.cldocno and ac.dtype='VND' "
                + "and outs.dtype='PIR')) ) union all SELECT '' AS branchname, '' AS loc_name, 0 AS ord, '' AS valtype, '' AS psrno, '' "
                + "AS date, '' AS description,0 AS stockid, dtype AS dtype, '' AS docno, '' AS acno,0 AS inqty, 0 AS inval, SUM(ldramount) "
                + "AS account,0 AS cpu FROM my_jvtran jv WHERE jv.acno IN (SELECT acno FROM my_account WHERE codeno = 'STOCK ACCOUNT') and status=3 AND "
                + "jv.date < '"+todate+"' group by dtype )a GROUP BY a.dtype ORDER BY   CASE dtype     WHEN 'OPN' THEN 1     WHEN 'PIV' "
                + "THEN 2     WHEN 'PIR' THEN 3     WHEN 'INV' THEN 4     WHEN 'INR' THEN 5     WHEN 'GIS' THEN 6     WHEN 'GIR' THEN 7 "
                + " WHEN 'PHK' THEN 8     WHEN 'DLR' THEN 9     ELSE 10 END";
                
                System.out.println("==stockLedgerDetailinfo=111=="+sql);
            
            
            ResultSet rs = stmt.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(rs);
            
            
            
         
            
            
        }catch(Exception e){
            e.printStackTrace();
            
        }finally{
            conn.close();
        }
        return RESULTDATA;
    }

}
