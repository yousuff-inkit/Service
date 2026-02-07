package com.dashboard.audit.stockcheck;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import net.sf.json.JSONArray;


public class ClsStockCheckGridDAO {

    ClsConnection connection= new ClsConnection();
    ClsCommon com=new ClsCommon();
    
    public JSONArray searchStock(String date, String chk) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!chk.equalsIgnoreCase("1")) {
            return RESULTDATA;
        }
        
        Connection conn =null;
        Statement stmt  =null;
        String joins="";
        String casestatement="";
        
        try {
            conn = connection.getMyConnection();
            stmt = conn.createStatement ();
            java.sql.Date sqlfromdate=null;
            String sqldatejoin="";
            if((!date.equalsIgnoreCase("")) && (!date.equalsIgnoreCase("undefined")) && (date!=null)){
                System.out.println(date);
                sqlfromdate=com.changeStringtoSqlDate(date);
                sqldatejoin = "and date>='"+sqlfromdate+"'";
            }
            
            String acno = "";
            String stocksql = "SELECT COALESCE(acno,0) acno FROM my_account WHERE codeno LIKE 'STOCK ACCOUNT'";
            ResultSet rs = stmt.executeQuery(stocksql);
            if(rs.next()) {
                acno = rs.getString("acno");
            }
            
            String decsql = "SELECT cvalue FROM my_system WHERE codeno='amtdec'";
            rs = stmt.executeQuery(decsql);
            String roundval = "0";
            if(rs.next()) {
                roundval = rs.getString("cvalue"); 
            }
            
            joins=com.getFinanceVocTablesJoins(conn);
            casestatement=com.getFinanceVocTablesCase(conn);
            
            
            String sql = "SELECT round(amt,"+roundval+") amt,a.tr_no,transType,round(pp,"+roundval+") pp,"+casestatement+" io, reason FROM (SELECT amt,a.tr_no,transType,transno,pp,io,brhid,IF(STATUS=7,'Deleted','') reason FROM (SELECT SUM(dramount) amt,tr_no,dtype transType,doc_no transno,STATUs,id FROM my_jvtran j WHERE acno="+acno+" "+sqldatejoin+" AND DATE<=CURDATE() AND STATUS=3 AND dtype IN ('GIS','PIR','INV') GROUP BY tr_no) a LEFT JOIN"
                    +" (SELECT ROUND(SUM(qty*cost_price),4) pp,tr_no,2 io,brhid FROM my_prddout WHERE  dtype IN ('GIS','PIR','INV') "+sqldatejoin+" AND DATE<=CURDATE()  GROUP BY tr_no) b ON a.tr_no=b.tr_no"
                    +" WHERE amt*id-pp NOT BETWEEN -1 AND 1"
                    +" UNION ALL "
                    +" SELECT COALESCE(amt,0) amt, a.tr_no,transType,transno,pp,io,brhid,IF(STATUS=7,'Deleted','') reason FROM (SELECT dtype,ROUND(SUM(qty*cost_price),4) pp,tr_no,2 io,brhid ,rdocno transno,dtype transType FROM my_prddout WHERE dtype IN ('GIS','PIR','INV')  "+sqldatejoin+" AND DATE<=CURDATE()  GROUP BY tr_no) a LEFT JOIN"
                    +" (SELECT SUM(dramount) amt,tr_no, status FROM my_jvtran j WHERE acno="+acno+" "+sqldatejoin+" AND DATE<=CURDATE() "
                    +" AND dtype IN ('GIS','PIR','INV') GROUP BY tr_no) b ON a.tr_no=b.tr_no"
                    +" WHERE b.tr_no IS NULL or status=7"
                    +" UNION ALL"
                    +" SELECT amt,a.tr_no,transType,transno,pp,io,brhid,IF(STATUS=7,'Deleted','') reason FROM (SELECT SUM(dramount*id) amt,tr_no,dtype transType,doc_no transno,status,id FROM my_jvtran j WHERE acno="+acno+" "+sqldatejoin+" AND DATE<=CURDATE() AND STATUS=3"
                    +" AND dtype IN ('PHK') GROUP BY tr_no) a LEFT JOIN (SELECT SUM(pp) pp, tr_no,io,brhid FROM (SELECT dtype,ROUND(SUM(op_qty*cost_price),4) pp, tr_no,1 io,brhid FROM my_prddin WHERE dtype='PHK' "+sqldatejoin+" AND DATE<=CURDATE() GROUP BY tr_no UNION ALL"
                    +" SELECT dtype,ROUND(SUM(qty*cost_price),4) pp, tr_no,2 io,brhid FROM my_prddout WHERE dtype='PHK' "+sqldatejoin+" AND DATE<=CURDATE() GROUP BY tr_no "
                    +" ) c GROUP BY tr_no) b ON a.tr_no=b.tr_no WHERE amt*id-pp NOT BETWEEN -1 AND 1"
                    +" UNION ALL "
                    +" SELECT amt,a.tr_no,transType,transno,pp,io,brhid,IF(STATUS=7,'Deleted','') reason FROM (SELECT SUM(pp) pp, tr_no,io,brhid,transno FROM (SELECT m.*,p.voc_no transno FROM (SELECT ROUND(SUM(op_qty*cost_price),4) pp, tr_no,1 io,brhid FROM my_prddin WHERE dtype='PHK' "+sqldatejoin+" AND DATE<=CURDATE() GROUP BY tr_no) m INNER JOIN my_phkm p ON p.tr_no=m.tr_no  UNION ALL"
                    +" SELECT ROUND(SUM(qty*cost_price),4) pp, tr_no,2 io,brhid,rdocno transno FROM my_prddout WHERE dtype='PHK' "+sqldatejoin+" AND DATE<=CURDATE() GROUP BY tr_no "
                    +") c GROUP BY tr_no) a LEFT JOIN  (SELECT SUM(dramount) amt,tr_no,dtype transType, status FROM my_jvtran j WHERE acno="+acno+" "+sqldatejoin+" AND DATE<=CURDATE() "
                    +" AND dtype IN ('PHK') GROUP BY tr_no) b ON a.tr_no=b.tr_no WHERE b.tr_no IS NULL or status=7"
                    +" UNION ALL"
                    +" SELECT amt,a.tr_no,transType,transno, pp,io,brhid,IF(STATUS=7,'Deleted','') reason FROM (SELECT SUM(dramount) amt,tr_no,dtype transType,doc_no transno,status,id FROM my_jvtran j WHERE acno="+acno+" "+sqldatejoin+" AND DATE<=CURDATE() AND STATUS=3"
                    +" AND dtype IN ('GIR','INR') GROUP BY tr_no) a LEFT JOIN"
                    +" (SELECT ROUND(SUM(op_qty*cost_price),4) pp,tr_no,1 io,brhid FROM my_prddin WHERE dtype IN ('GIR','INR') "+sqldatejoin+" AND DATE<=CURDATE() GROUP BY tr_no) b ON a.tr_no=b.tr_no"
                    +" WHERE amt*id-pp NOT BETWEEN -1 AND 1 "
                    +" UNION ALL"
                    +" SELECT amt,a.tr_no,transType,transno,pp,io, brhid,IF(STATUS=7,'Deleted','') reason FROM (SELECT ROUND(SUM(op_qty*cost_price),4) pp,tr_no,1 io,brhid FROM my_prddin WHERE dtype IN ('GIR','INR') "+sqldatejoin+" AND DATE<=CURDATE() GROUP BY tr_no) a LEFT JOIN"
                    +" (SELECT SUM(dramount) amt,tr_no,dtype transType,doc_no transno,status FROM my_jvtran j WHERE acno="+acno+" "+sqldatejoin+" AND DATE<=CURDATE() "
                    +" AND dtype IN ('GIR','INR') GROUP BY tr_no) b ON a.tr_no=b.tr_no"
                    +" WHERE b.tr_no IS NULL or status=7"
                    +" UNION ALL"
                    +" SELECT amt,a.tr_no,transType,transno,pp,io,brhid,IF(STATUS=7,'Deleted','') reason FROM (SELECT SUM(dramount) amt,tr_no,dtype transType,doc_no transno,status,id FROM my_jvtran j WHERE acno="+acno+" "+sqldatejoin+" AND DATE<=CURDATE() AND STATUS=3"
                    +" AND dtype IN ('PIV') GROUP BY doc_no) a LEFT JOIN"
                    +" (SELECT dtype,ROUND(SUM(op_qty*cost_price),4) pp,tr_no,1 io,invno ,brhid FROM my_prddin WHERE dtype IN ('PIV','GRN') "+sqldatejoin+" AND DATE<=CURDATE() GROUP BY invno) b ON a.transno=b.invno"
                    +" WHERE amt*id-pp NOT BETWEEN -1 AND 1 "
                    +" UNION ALL "
                    +" SELECT amt,a.tr_no,transType,transno,pp,io,brhid,IF(STATUS=7,'Deleted','') reason FROM (SELECT 'PIV' transType,ROUND(SUM(op_qty*cost_price),4) pp,tr_no,1 io,invno transno,brhid FROM my_prddin WHERE dtype IN ('PIV','GRN') "+sqldatejoin+" AND DATE<=CURDATE() GROUP BY transno) a LEFT JOIN"
                    +" (SELECT SUM(dramount) amt,tr_no,dtype,doc_no,status FROM my_jvtran j WHERE acno="+acno+" "+sqldatejoin+" AND DATE<=CURDATE() AND dtype IN ('PIV') GROUP BY doc_no)b ON b.doc_no=a.transno WHERE b.doc_no IS NULL or status=7) a"+ joins;
            System.out.println("------------------"+sql);
            ResultSet resultSet = stmt.executeQuery(sql) ;
            RESULTDATA=com.convertToJSON(resultSet);
            System.out.println(RESULTDATA);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            stmt.close();
            conn.close();

        }
        //  System.out.println(RESULTDATA);
        return RESULTDATA;

    }
}
