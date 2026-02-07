package com.dashboard.sales.consolidatedsales;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsConsolidatedSalesDAO {

	ClsConnection ClsConnection = new ClsConnection();
	ClsCommon ClsCommon = new ClsCommon();

	public JSONArray getData(String branchVal, String fromDate, String toDate,String cldocno,String category,String salesman) throws SQLException {
		JSONArray RESULTDATA = new JSONArray();
		
		Connection conn = null;
		try {
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;

			if (!fromDate.equalsIgnoreCase("") && !fromDate.equalsIgnoreCase("0")) {
				sqlfromdate = ClsCommon.changeStringtoSqlDate(fromDate);
			}
			if (!toDate.equalsIgnoreCase("") && !toDate.equalsIgnoreCase("0")) {
				sqltodate = ClsCommon.changeStringtoSqlDate(toDate);
			}
			  String sqltest="";
		        if(!(cldocno.equalsIgnoreCase("undefined"))&&!(cldocno.equalsIgnoreCase(""))&&!(cldocno.equalsIgnoreCase("0"))){
		            sqltest=sqltest+" and t.cldocno="+cldocno+"";
		        }
                 if(!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("") )&&!(category.equalsIgnoreCase("0"))){
                  sqltest=sqltest+" and t.catid="+category+"";
                  }
                 
		        if(!(salesman.equalsIgnoreCase("undefined"))&&!(salesman.equalsIgnoreCase(""))&&!(salesman.equalsIgnoreCase("0"))){
                    sqltest=sqltest+" and t.doc_no="+salesman+"";
                }
		       
			String sqlfilter = " and t.date between '" + sqlfromdate + "' and '" + sqltodate + "'";

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			 String strSql = "select @i:=@i+1 slno, a.* from(select* from(select cm.category,round(coalesce(d.amount,0)+coalesce(inr.amount,0),2) amount,round(coalesce(d.vatamt,0)+coalesce(inr.vatamt,0),2) vatamt,round(coalesce(d.nettotal,0)+coalesce(inr.nettotal,0),2) nettotal,a.catid,s.doc_no,a.cldocno,Convert(m.refno,Char(45)) refno,'INV' dtype,m.voc_no,m.date,a.refname,coalesce(s.sal_name,'')sal_name,m.status,m.brhid\r\n" + 
                     "from my_invm m\r\n" + 
                     "left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM'\r\n" + 
                     "left join my_salm s on s.doc_no=m.sal_id left join(select sum(coalesce(nettotal,0)) amount ,sum(coalesce(taxamount,0)) vatamt,sum(coalesce(nettaxamount,0)) nettotal,rdocno from my_invd group by rdocno )d on d.rdocno=m.doc_no left join (select sum(coalesce(nettotal,0)) amount ,sum(coalesce(taxamount,0)) vatamt,sum(coalesce(nettaxamount,0)) nettotal,rdocno,doc_no from my_invdser group by rdocno )inr on inr.rdocno=m.doc_no  left join my_clcatm cm on cm.doc_no=a.catid  group by m.doc_no \r\n" + 
                     "union all select cm.category,round(if(d.amount>0,d.amount*-1,d.amount),2) amount,round(if(d.vatamt>0,d.vatamt*-1,d.vatamt),2) vatamt,round(if(d.nettotal>0,d.nettotal*-1,d.nettotal),2) nettotal,a.catid,s.doc_no,a.cldocno,Convert(m.refno,Char(45)) refno,'INR' dtype,m.voc_no,m.date,a.refname,coalesce(s.sal_name,'')sal_name,m.status,m.brhid from my_invr m left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' left join my_salm s on s.doc_no=m.sal_id left join(select sum(nettotal) amount ,sum(taxamount) vatamt,sum(nettaxamount) nettotal,rdocno from my_inrd group by rdocno )d on d.rdocno=m.doc_no left join my_clcatm cm on cm.doc_no=a.catid group by m.doc_no union all select cm.category,round(m.netamount,2) amount,0 vatamt,round(m.netamount,2) nettotal,a.catid,s.doc_no,a.cldocno,Convert(m.refno,Char(45)) refno,'SRS' dtype,m.voc_no,m.date,h.description refname,coalesce(s.sal_name,'')sal_name,m.status,m.brhid\r\n" + 
                     "from my_srvsalem m \r\n" + 
                     "left join my_head h on h.doc_no=m.acno\r\n" + 
                     "left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' \r\n" + 
                     "left join my_salm s on s.doc_no=a.sal_id left join my_clcatm cm on cm.doc_no=a.catid group by m.doc_no \r\n" + 
                     "union all select cm.category,m.nettotal amount, m.taxamount vatamt, m.taxtotal nettotal,a.catid,s.doc_no,a.cldocno,Convert(m.refno,Char(45)) refno,'MNT' dtype,m.voc_no,m.date,a.refname,coalesce(s.sal_name,'')sal_name,m.status,m.brhid\r\n" + 
                     "from ws_invm m\r\n" + 
                     "left join ws_jobcard job on (m.reftype='JC' and m.refno=job.doc_no)\r\n" + 
                     "left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) \r\n" + 
                     "left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))\r\n" + 
                     "left join my_acbook a on (gate.cldocno=a.cldocno and a.dtype='CRM')\r\n" + 
                     "left join my_salm s on s.doc_no=a.sal_id  left join my_clcatm cm on cm.doc_no=a.catid  group by m.doc_no)t where status=3 "+sqlfilter +" "+sqltest +" order by dtype,date,voc_no)a,(select @i:=0)c";
        // System.out.println("strSql7===="+strSql);
			ResultSet resultSet = stmt.executeQuery(strSql);

			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
			return RESULTDATA;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {

		}
		return RESULTDATA;
	}
	
	public JSONArray groupbygrid(String fromdate, String todate,String groupby,String check,String cldocno,String category,String salesman) throws SQLException {
        JSONArray RESULTDATA = new JSONArray();
        
        Connection conn = null;
        try {
            java.sql.Date sqlfromdate = null;
            java.sql.Date sqltodate = null;

            if (!fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("0")) {
                sqlfromdate = ClsCommon.changeStringtoSqlDate(fromdate);
            }
            if (!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("0")) {
                sqltodate = ClsCommon.changeStringtoSqlDate(todate);
            }
            
            String sqltest="";
            if(!(cldocno.equalsIgnoreCase("undefined"))&&!(cldocno.equalsIgnoreCase(""))&&!(cldocno.equalsIgnoreCase("0"))){
                sqltest=sqltest+" and t.cldocno="+cldocno+"";
            }
             if(!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("") )&&!(category.equalsIgnoreCase("0"))){
              sqltest=sqltest+" and t.catid="+category+"";
              }
             
            if(!(salesman.equalsIgnoreCase("undefined"))&&!(salesman.equalsIgnoreCase(""))&&!(salesman.equalsIgnoreCase("0"))){
                sqltest=sqltest+" and t.doc_no="+salesman+"";
            }
          
              String sqlgrid="",sqlselect="";
             
              if(groupby.equalsIgnoreCase("client")){
                  sqlgrid=sqlgrid+" group by t.cldocno ";
              }
              else if(groupby.equalsIgnoreCase("salesman")){
                  sqlgrid=sqlgrid+" group by t.doc_no";
              }
              else if(groupby.equalsIgnoreCase("category")){
                  sqlgrid=sqlgrid+" group by t.catid ";
              }
              else{
              }
              
              if(groupby.equalsIgnoreCase("client")){
                  sqlselect=sqlselect+" refname refname, ";
              }
              else if(groupby.equalsIgnoreCase("salesman")){
                  sqlselect=sqlselect+" sal_name refname,";
              }
              else if(groupby.equalsIgnoreCase("category")){
                  sqlselect=sqlselect+" category refname, ";
              }
              else{
              }
              
             
               
            String sqlfilter = " and t.date between '" + sqlfromdate + "' and '" + sqltodate + "'";

            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String strSql = "select @i:=@i+1 slno, a.* from(select "+sqlselect +" sum(netamount) netamount,sum(retamount) retamount,voc_no refno,sum(workshopinv) workshopinv,sum(salesinv) salesinv from(select cm.category,a.catid,s.doc_no,a.cldocno,Convert(m.refno,Char(45)) refno,'INV' dtype,m.voc_no,m.date,a.refname,coalesce(d.amount,0)+coalesce(inr.amount,0) netamount,0 retamount,coalesce(d.amount,0)+coalesce(inr.amount,0) salesinv, 0 workshopinv,coalesce(s.sal_name,'')sal_name,m.status,m.brhid\r\n" + 
                    "from my_invm m\r\n" + 
                    "left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM'\r\n" + 
                    "left join my_salm s on s.doc_no=m.sal_id left join my_clcatm cm on cm.doc_no=a.catid left join(select sum(coalesce(nettotal,0)) amount,rdocno from my_invd group by rdocno )d on d.rdocno=m.doc_no  left join (select sum(coalesce(nettotal,0)) amount,rdocno from my_invdser group by rdocno )inr on inr.rdocno=m.doc_no group by m.doc_no \r\n" + 
                    "union all select cm.category,a.catid,s.doc_no,a.cldocno,Convert(m.refno,Char(45)) refno,'INR' dtype,m.voc_no,m.date,a.refname,0 netamount,d.amount retamount,d.amount salesinv, 0 workshopinv,coalesce(s.sal_name,'')sal_name,m.status,m.brhid from my_invr m left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' left join my_salm s on s.doc_no=m.sal_id  left join my_clcatm cm on cm.doc_no=a.catid left join(select sum(coalesce(nettotal,0)) amount,rdocno from my_inrd group by rdocno )d on d.rdocno=m.doc_no group by m.doc_no "
                    + "union all select cm.category,a.catid,s.doc_no,a.cldocno,Convert(m.refno,Char(45)) refno,'SRS' dtype,m.voc_no,m.date,h.description refname,m.netamount,0 retamount,m.netamount salesinv, 0 workshopinv,coalesce(s.sal_name,'')sal_name,m.status,m.brhid\r\n" + 
                    "from my_srvsalem m \r\n" + 
                    "left join my_head h on h.doc_no=m.acno\r\n" + 
                    "left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' \r\n" + 
                    "left join my_salm s on s.doc_no=a.sal_id left join my_clcatm cm on cm.doc_no=a.catid group by m.doc_no \r\n" + 
                    "union all select cm.category,a.catid,s.doc_no,a.cldocno,Convert(m.refno,Char(45)) refno,'MNT' dtype,m.voc_no,m.date,a.refname,coalesce(m.nettotal,0) netamount,0 retamount,0 salesinv, coalesce(m.nettotal,0) workshopinv,coalesce(s.sal_name,'')sal_name,m.status,m.brhid\r\n" + 
                    "from ws_invm m\r\n" + 
                    "left join ws_jobcard job on (m.reftype='JC' and m.refno=job.doc_no)\r\n" + 
                    "left join ws_estm est on (job.reftype='EST' and job.refno=est.doc_no) \r\n" + 
                    "left join ws_gateinpass gate on (if(job.reftype='GIP',job.refno=gate.doc_no,est.gipno=gate.doc_no))\r\n" + 
                    "left join my_acbook a on (gate.cldocno=a.cldocno and a.dtype='CRM')\r\n" + 
                    "left join my_salm s on s.doc_no=a.sal_id  left join my_clcatm cm on cm.doc_no=a.catid group by m.doc_no)t where status=3 "+sqlfilter +" "+sqltest +" "+sqlgrid +"  order by dtype,date,voc_no)a,(select @i:=0)c where netamount!=0";
      //  System.out.println("groupby7===="+strSql);
            ResultSet resultSet = stmt.executeQuery(strSql);

            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            stmt.close();
            conn.close();
            return RESULTDATA;
        } catch (Exception e) {
            e.printStackTrace();
            conn.close();
        } finally {

        }
        return RESULTDATA;
    }
	public JSONArray clientsearch(String cldocno) throws SQLException{


	    JSONArray RESULTDATA=new JSONArray();
	    
        Connection conn = null;
       
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String sql = "";
            sql="select cldocno,refname clname from my_acbook a where status=3 and dtype='CRM'";
            System.out.println("clientsearch==="+sql);
            ResultSet resultSet1 = stmt.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet1);

        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            conn.close();
        }


        return RESULTDATA;
    }

}
