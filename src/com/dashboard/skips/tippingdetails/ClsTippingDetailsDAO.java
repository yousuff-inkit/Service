package com.dashboard.skips.tippingdetails;       
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsTippingDetailsDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	public JSONArray tippingSummaryData(HttpSession session,int id,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
	    java.sql.Date sqlfromdate = null;
		java.sql.Date sqltodate = null;

		try {
			 String  sql="",sqltest="";
			 conn = objconn.getMyConnection();
			 Statement stmt = conn.createStatement();
			 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		     }else{}
		     if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		     } else{}  
			 if(id==2) {
				 sqltest+=" and m.doc_no is not null"; 
			 }else if(id==3) {   
				 sqltest+=" and m.doc_no is null";
			 }else {} 
			 
			 sql="select sum(td.weight) weight,sum(price) price,cm.refno,cm.doc_no,cm.remarks,group_concat(distinct dno) dno,date_format(ddate,'%d.%m.%Y') ddate,sum(td.qty) qty,sum(td.qty*td.rate) total,group_concat(distinct st.name) skipsize,group_concat(distinct wastetype) wastetype,convert(group_concat(distinct m.voc_no),char(100)) invno, case when cm.billingmethod=1 then 'Monthly' when cm.billingmethod=2 then 'Yearly' when cm.billingmethod=3 then 'Adhoc' else '' end as billingmethod,round(d.tippingfee,2) tippingfee, case when cm.advinvmethod=1 then 'Yes' when cm.advinvmethod=0 then 'No' else '' end as advinvmethod from sk_triptotal t "
			     		+ "left join sk_tippingdet td on t.srno=td.totsrno left join sk_skiptype st on st.doc_no=td.skipsizeid "
			     		+ "left join sk_srvcontrm cm on cm.tr_no=t.contractno left join (select sum(tippingfee) tippingfee,rdocno from sk_srvcontrdet group by rdocno) d on d.rdocno=cm.tr_no "           
			     		+ "left join sk_invm m on m.doc_no=td.invno where  ddate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" group by cm.tr_no"; 
			 //System.out.println("===SUMMARY===="+sql);         
			ResultSet resultSet1 = stmt.executeQuery(sql);    
			RESULTDATA1=objcommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public JSONArray tippingDetailData(HttpSession session,int id,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
	    java.sql.Date sqlfromdate = null;
		java.sql.Date sqltodate = null;

		try {
			  String  sql="",sqltest="";  
			  conn = objconn.getMyConnection();
			  Statement stmt = conn.createStatement();
			  if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		      }else{}
		      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		      } else{}  
		      if(id==2) {
					 sqltest+=" and m.doc_no is not null"; 
			  }else if(id==3) {   
					 sqltest+=" and m.doc_no is null";
			  }else {} 
		      sql="select td.weight,td.price,t.contractno contrno,td.ddate dodate,td.wasteid,td.skipsizeid,cm.refno,st.name skipsize,td.srno tipdetsrno,cm.doc_no,cm.remarks,dno,date_format(ddate,'%d.%m.%Y') ddate,td.qty,coalesce(td.rate,0) rate,coalesce(td.qty*td.rate,0) total,wastetype,m.voc_no invno, case when cm.billingmethod=1 then 'Monthly' when cm.billingmethod=2 then 'Yearly' when cm.billingmethod=3 then 'Adhoc' else '' end as billingmethod,round(d.tippingfee,2) tippingfee, case when cm.advinvmethod=1 then 'Yes' when cm.advinvmethod=0 then 'No' else '' end as advinvmethod from sk_triptotal t"
			     		+ " left join sk_tippingdet td on t.srno=td.totsrno left join sk_skiptype st on st.doc_no=td.skipsizeid "
			     		+ "left join sk_srvcontrm cm on cm.tr_no=t.contractno left join (select sum(tippingfee) tippingfee,rdocno from sk_srvcontrdet group by rdocno) d on d.rdocno=cm.tr_no "    
			     		+ "left join sk_invm m on m.doc_no=td.invno where  ddate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+"";
		      //System.out.println("===DETAIL===="+sql);         
			ResultSet resultSet1 = stmt.executeQuery(sql);    
			RESULTDATA1=objcommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	public JSONArray wastetypeSearch(int id) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql="select name, doc_no from sk_dumptype where status=3";  
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);  
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public JSONArray skipsizeSearch(int id) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql="select name, doc_no from sk_skiptype where status=3";    
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);  
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public JSONArray contractnoSearch() throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql="select tr_no,doc_no from sk_srvcontrm where status=3";    
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);  
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
}
