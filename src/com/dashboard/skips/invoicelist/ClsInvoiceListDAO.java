package com.dashboard.skips.invoicelist;       
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsInvoiceListDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	public JSONArray SummaryData(HttpSession session,int id,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
	    java.sql.Date sqlfromdate = null;
		java.sql.Date sqltodate = null;

		try {
			 String  sql;
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		      }else{}
		      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		      } else{}
			
		      sql="select if(c.witheffect between m.fromdate and m.todate, 'YES', 'NO') revision,if(c.witheffect between m.fromdate and m.todate, 1, 0) datval,m.verifyremarks,u1.user_name verifyuser,c.refno,m.dtype,case when m.statusid=1 then 'Hard copy submitted' when m.statusid=2 then 'Received acknowledgement' when e.edate!='' then 'Email send' else 'Generated' end as status,m.brhid,m.doc_no,m.voc_no invno,date_format(m.date,'%d.%m.%Y') invdate,date_format(m.fromdate,'%d.%m.%Y') fromdate,date_format(m.todate,'%d.%m.%Y') todate,c.doc_no Cntno,c.remarks oldcntno,cs.site,CASE WHEN e.edate!='' THEN 'Sent' ELSE 'Not Sent' END AS emailstatus,a.refname client,coalesce(u.user_id,'') mailuser,coalesce(e.email,'') email,coalesce(a.per_mob,'') per_mob,coalesce(a.per_tel,'') per_tel,sm.sal_name,a.grpcmp,sk.name skipsize,sg.name groupcompany,coalesce(c.email,'') cntemail,d.* from "
						+ "sk_invm m left join emaillog e on e.doc_no=m.doc_no and e.dtype in('SINV' ,'INVD','SINT') "
						+ "left join sk_srvcontrm c on c.tr_no=m.cnttrno left join my_acbook a on a.cldocno=c.cldocno and a.dtype='crm' left join my_salm sm on a.sal_id=sm.doc_no "
						+ "left join my_user u on u.doc_no=e.userid left join my_user u1 on u1.doc_no=m.verifyuser left join (select rdocno,sum(nettotal) totinv,sum(if(idno=1,nettotal,0)) wscoll,sum(if(idno=2,nettotal,0)) tip ,sum(if(idno=3,nettotal,0)) gate ,sum(if(idno=8,nettotal,0)) addsk ,sum(if(idno=9,nettotal,0)) skiprent,sum(if(idno=10,nettotal,0)) adftfeemsw,sum(if(idno=11,nettotal,0)) adftfee,sum(if(idno=6,nettotal,0)) oth,sum(if(idno=4,nettotal,0)) extcl,sum(if(idno=5,nettotal,0)) skmnchrg,sum(if(idno=7,nettotal,0)) fixrenval,sum(if(idno>11,nettotal,0)) manualinv from sk_invd group by rdocno) d on m.doc_no=d.rdocno "
						+ "left join sk_srvcsited cs on cs.tr_no=c.tr_no "
						+ "left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "
						+ "left join sk_skiptype sk on sk.doc_no=sd.skiptype "
						+ "left join sk_clgroup sg on sg.docno=a.grpcmp where m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.status=3 group by invno order by m.doc_no desc";
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

	public JSONArray DetailData(HttpSession session,int id,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
	       java.sql.Date sqlfromdate = null;
		     java.sql.Date sqltodate = null;

		try {
			 String  sql;
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		      }else{}
		      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		      } else{}
			
		      sql="select if(c.witheffect between m.fromdate and m.todate, 'YES', 'NO') revision,if(c.witheffect between m.fromdate and m.todate, 1, 0) datval,c.refno,m.dtype,case when m.statusid=1 then 'Hard copy submitted' when m.statusid=2 then 'Received acknowledgement' when e.edate!='' then 'Email send' else 'Generated' end as status,m.brhid,m.doc_no,m.voc_no invno,date_format(m.date,'%d.%m.%Y') invdate,date_format(m.fromdate,'%d.%m.%Y') fromdate,date_format(m.todate,'%d.%m.%Y') todate,c.doc_no cntno,c.remarks oldcntno,cs.site,if(e.edate is null,'Not Sent','Sent')  AS emailstatus,a.refname client,coalesce(u.user_id,'') mailuser,coalesce(e.email,'') email,coalesce(a.per_mob,'') per_mob,coalesce(a.per_tel,'') per_tel,sm.sal_name, md.description remarks,round(d.qty,0) qty,round(d.rate,2) rate,d.total,taxamt,nettotal,dno,a.grpcmp,sk.name skipsize,sg.name groupcompany,coalesce(c.email,'') cntemail  from sk_invm m"
			      		+ " left join emaillog e  on e.doc_no=m.doc_no and e.dtype in('sinv' ,'INVD','SINT')"
			      		+ " left join sk_srvcontrm c on c.tr_no=m.cnttrno "
			      		+ "left join my_acbook a on a.cldocno=c.cldocno and a.dtype='crm'"
			      		+ " left join my_salm sm on a.sal_id=sm.doc_no "
			      		+ "left join my_user u on u.doc_no=e.userid left join my_user u1 on u1.doc_no=m.verifyuser "      
			      		+ "left join sk_invd  d on m.doc_no=d.rdocno "
			      		+ "left join sk_srvcsited cs on cs.tr_no=c.tr_no "
			      		+ "left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "
			      		+ "left join sk_skiptype sk on sk.doc_no=sd.skiptype "
			      		+ "left join sk_clgroup sg on sg.docno=a.grpcmp  "
			      		+ "left join (select invno,group_concat(distinct dno) dno from sk_tippingdet group by invno) i on i.invno=m.doc_no left join sk_invmode md on md.idno=d.idno where m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.status=3 group by d.rowno order by m.doc_no desc";  
	       System.out.println("===DETAIL===="+sql);          
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
