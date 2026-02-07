package com.dashboard.skips.revisionrequestapproval;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsRevisionRequestApprovalDAO {

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray contractGridLoad(HttpSession session,int id,String status) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		String sqltest="";
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
		//	System.out.println("status"+status);	
			if(!status.equalsIgnoreCase("undefined") && !status.equalsIgnoreCase("") ) {  
				sqltest+=" where s.status='"+status+"' ";                    
			}
			String  sql="select s.apprdate,s.reason,s.witheffect witheffectdate,s.doc_no,s.cnttrno contractno,m.cldocno,m.brhid,ac.refname client,m.startdt fromdate,m.enddt todate,"
					+ "case when m.billingmethod=1 then 'Monthly' when m.billingmethod=2 then 'Yearly' when m.billingmethod=3 "
					+ "then 'Adhoc' end invmthd,sk.name skipsize,r.name ownership,s.remarks reqremarks,s.requser,"
					+ "s.date reqdate,s.status,u.user_id ,case when s.status=0 then 'Requested' when s.status=1 then 'Approved' when s.status=2 then 'Rejected' else '' end as stat "
					+ "from  sk_srvcontrrenew s left join sk_srvcontrm m  on s.cnttrno=m.tr_no "
					+ "left join sk_srvcontrdet d  on d.rdocno=m.tr_no "
					+ "left join sk_skiptype sk on sk.doc_no=d.skiptype "
					+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' "
					+ "left join sk_enqrelated r on (r.srno=d.ownershipid and r.type='SERVICEBY') "
					+ " left join gl_biblog b on (b.doc_no=s.doc_no and b.dtype='RRA')"
					+ " left join my_user u on u.doc_no=b.userId "+sqltest+" group by s.doc_no";      
			//System.out.println("===sql===="+sql);                

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
	
	
}
