package com.dashboard.skips.contractrenewalfollowup;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsContractRenewalFollowupDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray contractGridLoad(HttpSession session,int id,String todate) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			java.sql.Date sqltodate = null;
		      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		      } else{}     
		      
		      String  sql=" select case when renewalstatusid=0 then 'Entered' when renewalstatusid=1 then 'Draft Send' when renewalstatusid=2 then 'Client Approved'  when renewalstatusid=3 then 'Invoiced' end renewalstatusid ,sm.sal_name ,m.sal_id,m.cldocno,ac.address com_add1, ac.per_mob mob, ac.per_tel telno, ac.mail1 email,m.remarks,date_format(m.date,'%d.%m.%Y') date,date_format(m.startdt,'%d.%m.%Y') startdt,date_format(m.enddt,'%d.%m.%Y') enddt,m.payterms,m.billingmethod,m.typeid,coalesce(a1.refname,'') groupcompanies,round(coalesce(d.tippingfee,0),2) tippingfee, r5.name tippingmethod,round(coalesce(d.tippingsecurity,0),2) tippingsecurity,round(coalesce(d.tariffrate,0),2) tariffrate,dd.gpsx gpsx1,dd.gpsy gpsy1,dd.route,dd.skip,d.statusid,case when d.statusid=1 then 'Skip Assigned' when d.statusid=2 then 'Delivery Scheduled' when d.statusid=3 then 'Delivery Updated' when d.statusid=4 then 'Route Assigned' else 'Entered' end as status,m.brhid,if(s.gpsx=0,'',s.gpsx) gpsx, if(s.gpsy=0,'',s.gpsy) gpsy,ac.refname,d.rowno,m.tr_no,m.doc_no,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, round(coalesce(d.rate,0),2) rate, round(coalesce(d.securityval,0),2) security, round(coalesce(d.rent,0),2) rent, d.foc,r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,if(s.rowno is null,0,s.rowno) siteid,date_format(m.enddt,'%d.%m.%Y') enddt,date_format(m.startdt,'%d.%m.%Y') startdt,date_format(bv.fdate,'%d.%m.%Y') fdate from sk_srvcontrm m left join sk_srvcontrdet d  on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.site=d.site and s.tr_no=d.rdocno left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION') left join sk_enqrelated r5 on (r5.srno=d.tippingmethod and r5.type='TIPPINGFEEMETHOD') left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join my_acbook a1 on ac.grpcmp=a1.cldocno and a1.dtype='CRM' left join (select group_concat(distinct del.gpsx) gpsx,group_concat(distinct del.gpsy) gpsy,group_concat(distinct r.name) route,group_concat(distinct m.name) skip,rdocno from sk_srvcontrdel del left join sk_skipm m on m.doc_no=del.skipid left join sk_route r on r.doc_no=del.routeid group by rdocno) dd on dd.rdocno=d.rowno left join (select max(doc_no) doc_no,rrowno from gl_bamc where status=3 group by rrowno) sub on(sub.rrowno=d.rowno) left join gl_bamc bv on sub.doc_no = bv.doc_no left join my_salm sm on sm.doc_no=m.sal_id where m.status=3 and m.enddt<='"+sqltodate+"'  order by m.tr_no desc";
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
	public  JSONArray loadSubGridData(String rowno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;   
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			conn = objconn.getMyConnection();
			stmt = conn.createStatement ();
				
			String sqldata = "select date_format(m.date,'%d.%m.%Y') detdate,m.remarks remk,date_format(m.fdate,'%d.%m.%Y') fdate,u.user_id user from gl_bamc m left join my_user u on u.doc_no=m.userid where m.rrowno='"+rowno+"' order by fdate desc";
			//System.out.println("detail==="+sqldata);    
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
