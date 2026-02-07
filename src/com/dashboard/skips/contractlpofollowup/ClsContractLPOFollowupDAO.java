package com.dashboard.skips.contractlpofollowup;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsContractLPOFollowupDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	public JSONArray clientConfirmData(HttpSession session,int id,int exp) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			 String  sql;
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			if(exp==1)
			{
			  sql="select replace(path,'\\\\\\\\',';') path,attach upload,coalesce(d.rowno,0) rowno,pono,date_format(m.startdt,'%d.%m.%Y') startdt,date_format(m.enddt,'%d.%m.%Y') enddt, date_format(d.date,'%d.%m.%Y') date, round(coalesce(amount,0),2) amount, date_format(validupto,'%d.%m.%Y') validupto, description, d.rdocno, d.qty ,m.doc_no contrno,date_format(m.date,'%d.%m.%Y') cdate,CASE WHEN m.cctype=1 THEN 'Open' WHEN m.cctype=2 THEN 'QTY Based' WHEN m.cctype=3 THEN 'Period' WHEN m.cctype=4 THEN 'QTY + Period based'  ELSE '' END AS cctype,m.cldocno,ac.refname,sd.wastetype wastedoc,sd.skiptype skipdoc,sd.nos,sd.rowno contdet ,sk.name skiptype, ds.name wastetype from sk_srvcontrd d left join sk_srvcontrm m  on d.rdocno=m.doc_no left join sk_srvcontrdet sd  on sd.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=sd.skiptype left join sk_dumptype ds on ds.doc_no=sd.wastetype  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' where validupto < now()";
			}
			else
			{
		     sql="select replace(path,'\\\\\\\\',';') path,attach upload,coalesce(d.rowno,0) rowno,pono,date_format(m.startdt,'%d.%m.%Y') startdt,date_format(m.enddt,'%d.%m.%Y') enddt, date_format(d.date,'%d.%m.%Y') date, round(coalesce(amount,0),2) amount, date_format(validupto,'%d.%m.%Y') validupto, description, d.rdocno, d.qty ,m.doc_no contrno,date_format(m.date,'%d.%m.%Y') cdate,CASE WHEN m.cctype=1 THEN 'Open' WHEN m.cctype=2 THEN 'QTY Based' WHEN m.cctype=3 THEN 'Period' WHEN m.cctype=4 THEN 'QTY + Period based'  ELSE '' END AS cctype,m.cldocno,ac.refname,sd.wastetype wastedoc,sd.skiptype skipdoc,sd.nos,sd.rowno contdet ,sk.name skiptype, ds.name wastetype from sk_srvcontrd d left join sk_srvcontrm m  on d.rdocno=m.doc_no left join sk_srvcontrdet sd  on sd.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=sd.skiptype left join sk_dumptype ds on ds.doc_no=sd.wastetype  left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM'";
	
			}
			// System.out.println("===sql===="+sql);  
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

		 
	public  JSONArray loadSubGridData(String contrno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;   
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = objconn.getMyConnection();
			stmt = conn.createStatement ();
				
			String sqldata = "select contno contrno,contdet,c.remarks remk,date_format(c.fdate,'%d.%m.%Y') fdate,u.user_id user,date_format(c.edate,'%d.%m.%Y') edate from sk_clpo c left join my_user u on u.doc_no=c.userrid where c.contno='"+contrno+"'";
			System.out.println("detail==="+sqldata);    
			 resultSet= stmt.executeQuery (sqldata);
			 RESULTDATA=objcommon.convertToJSON(resultSet);  
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
}
