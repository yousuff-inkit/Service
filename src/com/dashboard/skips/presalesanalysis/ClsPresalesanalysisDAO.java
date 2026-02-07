package com.dashboard.skips.presalesanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPresalesanalysisDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	 public JSONArray enquirylistsearch(HttpSession session, String brnchval, String fromdate, String todate, String id, String widgetname, String type, String salid) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();  
	        if(!id.equalsIgnoreCase("1")) {
	        	return RESULTDATA;
	        }
	       Connection conn = null;
		   Statement stmtVeh =null;
		   ResultSet resultSet=null;
	       String sqltest="",sqltest2="",sqlsalman="",sqlselect1="",sqlselect2="",sqljoin="";  
	        try {
	             conn = ClsConnection.getMyConnection();
			     stmtVeh = conn.createStatement (); 
			     java.sql.Date sqlfromdate = null;
			      if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
			    	  sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
			      }else{}
			     java.sql.Date sqltodate = null;
			      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
			       sqltodate=cmn.changeStringtoSqlDate(todate);
			      } else{}
			  
			      if(!(brnchval.equalsIgnoreCase("a"))&&!(brnchval.equalsIgnoreCase("0"))&&!(brnchval.equalsIgnoreCase("")))  {
			    	  sqltest+=" and e.brhid="+brnchval;
			      } else {}
			      
			      if(!(salid.equalsIgnoreCase("0"))&&!(salid.equalsIgnoreCase("")))  {   
			    	  sqltest+=" and e.sal_id="+salid;    
			      } else {}   
			      
			      if(type.equalsIgnoreCase("enq")){
                      sqltest+=" and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";    
                    }else if(type.equalsIgnoreCase("qot")){
                        sqltest+=" and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' "; 
                    }else if(type.equalsIgnoreCase("cnt")){
                        sqltest+=" and cm.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' ";   
                    }else{} 
			      
			      /* String sql1="select doc_no from my_salm where status=3 and salesuserlink='"+session.getAttribute("USERID")+"'";            
			      ResultSet rs =stmtVeh.executeQuery(sql1);         
			      if(rs.next()){
			    	  sqltest+=" and e.sal_id='"+rs.getString("doc_no")+"'";    
			      } */     
			         
			      if(widgetname.equalsIgnoreCase("allitem")){   
			    	    sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) cntvalue,round((coalesce(round(nooftripsqot,2),0)*a.rateqot)+(coalesce(round(nooftripsqot,2),0)*a.tfeeqot),2) qotval";
			    	    sqlselect1=" r3.name tfeemethodqot,r33.name tfeemethod,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*qd.scheduledays*qd.nos*r22.tripsinmonth nooftripsqot,qd.nos skipqtyqot,round(qd.scheduledays*r22.tripsinmonth,2) noofvisitqot,sk1.name skipsizeqot, round(qd.rate,2) rateqot, round(qd.rent,2) rentqot, round(qd.tippingfee,2) tfeeqot,qm.doc_no qotno,qm.tr_no qottrno ,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod, qm.revision_no qotrevno,qm.date qotdate,cm.cpemail email1,ue.user_name user1,cm.tr_no contrno,convert(coalesce(cm.doc_no,''),char(40)) condocno,cm.date cntdate,case when cm.status<3 then 'Draft' when cm.status=3 then 'Approved' when cd.statusid=6 then 'Printed' when cd.statusid=2 then 'Emailed' when cd.statusid=3 then 'Acknowledgement Done' else '' end as cntdocstatus,(case when cm.billingmethod=1 then 1 when cm.billingmethod=2 then 12 else 0 end)*cd.scheduledays*cd.nos*r2.tripsinmonth nooftrips,cd.nos skipqty,round(cd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(cd.rate,2) rate, round(cd.rent,2) rent, round(cd.tippingfee,2) tfee,concat(date_format(cm.startdt,'%d.%m.%Y'),' - ',date_format(cm.enddt,'%d.%m.%Y')) contperiod,r1.name contctype,case when cm.billingmethod=1 then 'Monthly' when cm.billingmethod=2 then 'Yearly' when cm.billingmethod=3 then 'Adhoc' else '' end as cbillmethod,concat(coalesce(eb.user ,''),' ',coalesce(if(apprStatus=5,'Forwarded ',if(apprStatus=3,'Approved',if(apprStatus=2,'Returned ',if(apprStatus=4,'Rejected ', if(apprStatus=1,'Submitted ',' Sent'))))) ,'')) apprstatus, ";
			    	    sqljoin=" left join sk_srvqotdet qd on qd.rdocno=qm.tr_no left join sk_enqrelated r3 on (r3.srno=qd.tippingmethod and r3.type='TIPPINGFEEMETHOD') left join sk_srvcontrdet cd on cd.rdocno=cm.tr_no left join sk_enqrelated r33 on (r33.srno=cd.tippingmethod and r33.type='TIPPINGFEEMETHOD') left join my_user ue on ue.doc_no=cm.userid left join sk_enqrelated r1 on (r1.srno=cd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=cd.skiptype left join sk_enqrelated r2 on (r2.srno=cd.servicetermid and r2.type='SCHEDULE') left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) left join sk_skiptype sk1 on sk1.doc_no=qd.skiptype left join sk_enqrelated r22 on (r22.srno=qd.servicetermid and r22.type='SCHEDULE') ";
			    	    sqltest+=" ";                     
				  }else if(widgetname.equalsIgnoreCase("enq")){            
						sqltest+=" and e.dropped=0 and qm.tr_no is null ";      
						sqljoin=" left join my_user ue on ue.doc_no=e.userid ";
						sqlselect1="e.email email1,ue.user_name user1,0 qottrno,0 qotno,0 contrno,0 condocno,"; 
				  }else if(widgetname.equalsIgnoreCase("enqdcld")){     
						sqltest+=" and e.dropped=1  and qm.tr_no is null ";   
						sqljoin=" left join my_user ue on ue.doc_no=e.userid ";
						sqlselect1="e.email email1,ue.user_name user1,0 qottrno,0 qotno,0 contrno,0 condocno,"; 
				  }else if(widgetname.equalsIgnoreCase("newcrm")){ 
					    sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) qotval";
					    sqljoin=" left join sk_srvqotdet qd on qd.rdocno=qm.tr_no left join sk_enqrelated r3 on (r3.srno=qd.tippingmethod and r3.type='TIPPINGFEEMETHOD') left join sk_enqrelated r1 on (r1.srno=qd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=qd.skiptype left join sk_enqrelated r2 on (r2.srno=qd.servicetermid and r2.type='SCHEDULE') left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) ";
						sqltest+="  and cm.tr_no is null and e.cldocno=0 and e.dropped=0 ";
						sqlselect1=" r3.name tfeemethod,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*qd.scheduledays*qd.nos*r2.tripsinmonth nooftrips,qd.nos skipqty,round(qd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(qd.rate,2) rate, round(qd.rent,2) rent, round(qd.tippingfee,2) tfee,qm.revision_no qotrevno,qm.email email1,ue.user_name user1,qm.date qotdate,qm.payterms,qm.billingmethod,qm.status qotstatus,qm.tr_no qottrno,qm.doc_no qotno,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,concat(coalesce(eb.user ,''),' ',coalesce(if(apprStatus=5,'Forwarded ',if(apprStatus=3,'Approved',if(apprStatus=2,'Returned ',if(apprStatus=4,'Rejected ', if(apprStatus=1,'Submitted ',' Sent'))))) ,'')) apprstatus,";
				  }else if(widgetname.equalsIgnoreCase("quot")){ 
					    sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) qotval";
					    sqljoin=" left join sk_srvqotdet qd on qd.rdocno=qm.tr_no left join sk_enqrelated r3 on (r3.srno=qd.tippingmethod and r3.type='TIPPINGFEEMETHOD') left join sk_enqrelated r1 on (r1.srno=qd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=qd.skiptype left join sk_enqrelated r2 on (r2.srno=qd.servicetermid and r2.type='SCHEDULE') left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) ";
						sqltest+=" and qm.tr_no is not null and cm.tr_no is null  and coalesce(qm.quotstatus,0) not in(1,2) and e.cldocno>0  and qm.status=3 ";  
						sqlselect1=" r3.name tfeemethod,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*qd.scheduledays*qd.nos*r2.tripsinmonth nooftrips,qd.nos skipqty,round(qd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(qd.rate,2) rate, round(qd.rent,2) rent, round(qd.tippingfee,2) tfee,concat(coalesce(eb.user ,''),' ',coalesce(if(apprStatus=5,'Forwarded ',if(apprStatus=3,'Approved',if(apprStatus=2,'Returned ',if(apprStatus=4,'Rejected ', if(apprStatus=1,'Submitted ',' Sent'))))) ,'')) apprstatus, qm.revision_no qotrevno,qm.email email1,ue.user_name user1,qm.date qotdate,qm.payterms,qm.billingmethod,qm.status qotstatus,qm.tr_no qottrno,qm.doc_no qotno,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,";
				  }else if(widgetname.equalsIgnoreCase("qotdcld")){     
					    sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) qotval";
					    sqljoin=" left join sk_srvqotdet qd on qd.rdocno=qm.tr_no left join sk_enqrelated r3 on (r3.srno=qd.tippingmethod and r3.type='TIPPINGFEEMETHOD') left join sk_enqrelated r1 on (r1.srno=qd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=qd.skiptype left join sk_enqrelated r2 on (r2.srno=qd.servicetermid and r2.type='SCHEDULE') left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) left join (select max(doc_no) doc_no,rdocno,rdtype from gl_bqot where status=7 group by rdocno) qds on(qds.rdocno=qm.tr_no and qds.rdtype='QOT') left join gl_bqot qds1 on qds.doc_no = qds1.doc_no left join my_user du on du.doc_no = qds1.userid  ";
						sqltest+=" and qm.tr_no is not null and cm.tr_no is null  and coalesce(qm.quotstatus,0)=1 ";  
						sqlselect1=" coalesce(du.user_name,'') qotdclduser, r3.name tfeemethod,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*qd.scheduledays*qd.nos*r2.tripsinmonth nooftrips,qd.nos skipqty,round(qd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(qd.rate,2) rate, round(qd.rent,2) rent, round(qd.tippingfee,2) tfee,concat(coalesce(eb.user ,''),' ',coalesce(if(apprStatus=5,'Forwarded ',if(apprStatus=3,'Approved',if(apprStatus=2,'Returned ',if(apprStatus=4,'Rejected ', if(apprStatus=1,'Submitted ',' Sent'))))) ,'')) apprstatus, qm.revision_no qotrevno,qm.email email1,ue.user_name user1,qm.date qotdate,qm.payterms,qm.billingmethod,qm.status qotstatus,qm.tr_no qottrno,qm.doc_no qotno,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,";
				  }else if(widgetname.equalsIgnoreCase("appr")){  
					    sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) qotval";
					    sqljoin=" left join sk_srvqotdet qd on qd.rdocno=qm.tr_no left join sk_enqrelated r3 on (r3.srno=qd.tippingmethod and r3.type='TIPPINGFEEMETHOD') left join sk_enqrelated r1 on (r1.srno=qd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=qd.skiptype left join sk_enqrelated r2 on (r2.srno=qd.servicetermid and r2.type='SCHEDULE') left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) ";
						sqltest+=" and qm.tr_no is not null and cm.tr_no is null  and coalesce(qm.quotstatus,0)=2 and e.cldocno>0  and qm.status=3 ";  
						sqlselect1=" r3.name tfeemethod,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*qd.scheduledays*qd.nos*r2.tripsinmonth nooftrips,qd.nos skipqty,round(qd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(qd.rate,2) rate, round(qd.rent,2) rent, round(qd.tippingfee,2) tfee,concat(coalesce(eb.user ,''),' ',coalesce(if(apprStatus=5,'Forwarded ',if(apprStatus=3,'Approved',if(apprStatus=2,'Returned ',if(apprStatus=4,'Rejected ', if(apprStatus=1,'Submitted ',' Sent'))))) ,'')) apprstatus, qm.revision_no qotrevno,qm.email email1,ue.user_name user1,qm.date qotdate,qm.payterms,qm.billingmethod,qm.status qotstatus,qm.tr_no qottrno,qm.doc_no qotno,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,";
				  }else if(widgetname.equalsIgnoreCase("amc")){        
						sqltest+=" and cm.tr_no is not null and coalesce(qm.quotstatus,0) not in(1) and e.dropped=0 and cm.status<>7 ";          
						sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) cntvalue";
						sqlselect1="r33.name tfeemethod,qm.doc_no qotno,qm.date qotdate,cm.cpemail email1,ue.user_name user1,cm.tr_no contrno,convert(coalesce(cm.doc_no,''),char(40)) condocno,cm.date cntdate,case when cm.status<3 then 'Draft' when cm.status=3 then 'Approved' when cd.statusid=6 then 'Printed' when cd.statusid=2 then 'Emailed' when cd.statusid=3 then 'Acknowledgement Done' else '' end as cntdocstatus,(case when cm.billingmethod=1 then 1 when cm.billingmethod=2 then 12 else 0 end)*cd.scheduledays*cd.nos*r2.tripsinmonth nooftrips,cd.nos skipqty,round(cd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(cd.rate,2) rate, round(cd.rent,2) rent, round(cd.tippingfee,2) tfee,concat(date_format(cm.startdt,'%d.%m.%Y'),' - ',date_format(cm.enddt,'%d.%m.%Y')) contperiod,r1.name contctype,case when cm.billingmethod=1 then 'Monthly' when cm.billingmethod=2 then 'Yearly' when cm.billingmethod=3 then 'Adhoc' else '' end as cbillmethod,"; 
						sqljoin=" left join sk_srvcontrdet cd on cd.rdocno=cm.tr_no left join sk_enqrelated r33 on (r33.srno=cd.tippingmethod and r33.type='TIPPINGFEEMETHOD') left join my_user ue on ue.doc_no=cm.userid left join sk_enqrelated r1 on (r1.srno=cd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=cd.skiptype left join sk_enqrelated r2 on (r2.srno=cd.servicetermid and r2.type='SCHEDULE') ";
				  }else if(widgetname.equalsIgnoreCase("unmgap")){
					    sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) qotval";
						sqltest+=" and e.cldocno>0 and qm.tr_no is not null and cm.tr_no is null and qm.status<3 and coalesce(qm.quotstatus,0)not in(1) and apprStatus=1";
						sqlselect1=" r3.name tfeemethod,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*qd.scheduledays*qd.nos*r2.tripsinmonth nooftrips,qd.nos skipqty,round(qd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(qd.rate,2) rate, round(qd.rent,2) rent, round(qd.tippingfee,2) tfee,qm.revision_no qotrevno,qm.email email1,ue.user_name user1,concat(coalesce(eb.user ,''),' ',coalesce(if(apprStatus=5,'Forwarded ',if(apprStatus=3,'Approved',if(apprStatus=2,'Returned ',if(apprStatus=4,'Rejected ', if(apprStatus=1,'Submitted ',' Sent'))))) ,'')) apprstatus,qm.date qotdate,qm.payterms,qm.billingmethod,qm.status qotstatus,qm.tr_no qottrno,qm.doc_no qotno,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,";
						sqljoin=" left join sk_srvqotdet qd on qd.rdocno=qm.tr_no left join sk_enqrelated r3 on (r3.srno=qd.tippingmethod and r3.type='TIPPINGFEEMETHOD') left join sk_enqrelated r1 on (r1.srno=qd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=qd.skiptype left join sk_enqrelated r2 on (r2.srno=qd.servicetermid and r2.type='SCHEDULE') left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) ";  
				  }else if(widgetname.equalsIgnoreCase("chklist")){
					    sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) qotval";
                        sqltest+=" and coalesce(qm.quotstatus,0) not in(1,2) and ckl.qotno is not null and cm.tr_no is null and e.cldocno>0 ";      
                        sqltest2+=" and realcount=mandcount";
                        sqljoin=" left join sk_srvqotdet qd on qd.rdocno=qm.tr_no left join sk_enqrelated r3 on (r3.srno=qd.tippingmethod and r3.type='TIPPINGFEEMETHOD') left join sk_enqrelated r1 on (r1.srno=qd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=qd.skiptype left join sk_enqrelated r2 on (r2.srno=qd.servicetermid and r2.type='SCHEDULE') ";   
                        sqlselect1=" r3.name tfeemethod,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*qd.scheduledays*qd.nos*r2.tripsinmonth nooftrips,qd.nos skipqty,round(qd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(qd.rate,2) rate, round(qd.rent,2) rent, round(qd.tippingfee,2) tfee,qm.revision_no qotrevno,qm.email email1, qm.date qotdate,qm.payterms,qm.billingmethod,qm.status qotstatus,qm.tr_no qottrno,qm.doc_no qotno,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,";
                  }else if(widgetname.equalsIgnoreCase("allqot")){ 
					    sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) qotval";
					    sqljoin=" left join sk_srvqotdet qd on qd.rdocno=qm.tr_no left join sk_enqrelated r3 on (r3.srno=qd.tippingmethod and r3.type='TIPPINGFEEMETHOD') left join sk_enqrelated r1 on (r1.srno=qd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=qd.skiptype left join sk_enqrelated r2 on (r2.srno=qd.servicetermid and r2.type='SCHEDULE') left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) ";
					    sqltest+=" and e.dropped=0 and qm.tr_no is not null and cm.tr_no is null ";  
					    sqlselect1=" r3.name tfeemethod,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*qd.scheduledays*qd.nos*r2.tripsinmonth nooftrips,qd.nos skipqty,round(qd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(qd.rate,2) rate, round(qd.rent,2) rent, round(qd.tippingfee,2) tfee,concat(coalesce(eb.user ,''),' ',coalesce(if(apprStatus=5,'Forwarded ',if(apprStatus=3,'Approved',if(apprStatus=2,'Returned ',if(apprStatus=4,'Rejected ', if(apprStatus=1,'Submitted ',' Sent'))))) ,'')) apprstatus, qm.revision_no qotrevno,qm.email email1,ue.user_name user1,qm.date qotdate,qm.payterms,qm.billingmethod,qm.status qotstatus,qm.tr_no qottrno,qm.doc_no qotno,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,";
				  }else{}    
			      
			      String sql="select ROUND(@i:=@i+1 ,0) slno,a.* from(select a.*"+sqlselect2+" from(select "+sqlselect1+"if(e.cldocno>0,'Existing','New') clienttype,bv1.remarks flwupremarks,e.returned,e.returnremk,coalesce(a1.name,'') groupcompanies,at.ay_name designation,e.cperson,e.cpersonid,case when e.presalesstatus=1 then 'Surveyed'  when e.presalesstatus=2 and coalesce(qm.quotstatus,0)!=1 then if(e.cldocno=0 and qm.doc_no is not null,'Quoted',if(qm.status<3,'Under Management',if(coalesce(qm.quotstatus,0)=2,'Approved','Quoted'))) when e.presalesstatus=3 then if(e.cldocno=0 and qm.doc_no is not null,'Quoted',if(qm.status<3,'Under Management',if(coalesce(qm.quotstatus,0)=2,'Approved','Checklist Updated'))) when e.presalesstatus=4 then 'Contracted'  when e.presalesstatus=5 then 'Quote Sent' when e.presalesstatus=6 then 'Returned' when e.presalesstatus=2 and coalesce(qm.quotstatus,0)=1 then 'Declined Quote'  else 'Entered' end as status,coalesce(e.cldocno,0) cldocno,e.voc_no,e.brhid , e.doc_no, e.date, e.remarks,ce.txtname source,if(e.cldocno>0,ma.refname,e.name) as name,coalesce(ma.doc_no,0) as clientid,if(e.cldocno>0,concat(coalesce(ma.address,''),',',coalesce(ma.per_mob,''),',',coalesce(ma.per_tel,'') ,',',coalesce(ma.mail1,'')),concat(coalesce(e.com_add1,''),',',coalesce(e.mob,''),',',coalesce(e.telno,'') ,',',coalesce(e.email,''))) as details,ms.sal_name salm,st.site,st.area,e.sourceid,coalesce(ma.address,e.com_add1) address,coalesce(ma.per_mob,e.mob) per_mob,coalesce(ma.per_tel,e.telno) pertel,coalesce(ma.mail1,e.email) mail1,e.sal_id,bv.fdate,fs.name fstatus,round(TIMESTAMPDIFF(minute,datetime,now())/60,2) age,ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount from gl_enqm e left join cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join sk_clgroup a1 on (ma.grpcmp=a1.docno or e.grpcmpid=a1.docno) left join my_salm ms on ms.doc_no=e.sal_id left join (select ee.areaid,ee.rdocno,group_concat(ee.site) site,group_concat(aa.area) area from gl_enqsited ee left join my_area aa on aa.doc_no=ee.areaid group by ee.rdocno) st on st.rdocno=e.doc_no left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq'  left join (select max(doc_no) doc_no,rdocno,rdtype from gl_bqot where status=3 group by rdocno) sub on(sub.rdocno=qm.tr_no and sub.rdtype='QOT') left join gl_bqot bv on sub.doc_no = bv.doc_no left join cm_qotfollowstatus fs on fs.doc_no=bv.fstatus left join (select max(doc_no) doc_no,rdocno,rdtype from gl_bqot where status=3 group by rdocno) sub1 on(sub1.rdocno=e.doc_no and sub1.rdtype='ENQ') left join gl_bqot bv1 on sub1.doc_no = bv1.doc_no left join my_activity at on at.doc_no=e.activityid left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 group by cd.qotno) ckl on ckl.qotno=qm.tr_no "+sqljoin+" where e.status=3 and e.amcconfirm=0 "+sqltest+" group by e.doc_no order by e.doc_no desc)a)a,(select @i:=0)b where 1=1  "+sqltest2+""; 
					 //     System.out.println("presalemgmt--->>>"+sql);                                                         
	              resultSet = stmtVeh.executeQuery(sql);  
	              RESULTDATA=cmn.convertToJSON(resultSet);
				  stmtVeh.close();
				  conn.close();
	  }
	  catch(Exception e){
	   conn.close();
	  }
	  finally{
	   stmtVeh.close();  
	   conn.close();
	  }
	   return RESULTDATA;
	}   
	 public JSONArray checklistData(HttpSession session,String docno,String id) throws SQLException{
			JSONArray RESULTDATA1=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return RESULTDATA1;   
			}
			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();  

				String sql="select * from(select replace(path,'\\\\\\\\',';') path,attach upload,d.checksrno,c.desc1,c.mandatory,d.remarks,true chk,d.qotno,d.rowno from sk_checklistdet d left join sk_checklist c on c.srno=d.checksrno where d.qotno='"+docno+"' union all select '' path,'' upload,srno checksrno, desc1, mandatory,'' remarks,false chk,0 qotno,0 rowno from sk_checklist where status<>7)a group by checksrno order by checksrno";
				//System.out.println("===checklist===="+sql);         
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=cmn.convertToJSON(resultSet1);

			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return RESULTDATA1;
		}
		public JSONArray salesmanwiseData(int id, String brhid, String fromdate, String todate) throws SQLException{    
			JSONArray RESULTDATA1=new JSONArray();
			if(id!=1) {  
				return RESULTDATA1;   
			}
			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement(); 
				String sqltest="";     
				 java.sql.Date sqlfromdate = null;
			      if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
			    	  sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
			      }else{}
			     java.sql.Date sqltodate = null;
			      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
			       sqltodate=cmn.changeStringtoSqlDate(todate);
			      } else{}
			  
			      if(!(brhid.equalsIgnoreCase("a"))&&!(brhid.equalsIgnoreCase("0"))&&!(brhid.equalsIgnoreCase("")))  {   
			    	  sqltest+=" and brhid="+brhid;  
			      } else {}  
			      
			      String sql="select * from(select s.sal_name,e.enqcnt,q.quotcnt,c.amccnt from my_salm s left join(select count(*) enqcnt,sal_id from gl_enqm e where e.status=3 and e.dropped=0 and date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" group by sal_id) e on e.sal_id=s.doc_no  left join(select count(*) quotcnt,sal_id from sk_srvqotm e where e.status=3 and coalesce(e.quotstatus,0) not in(1,2) and date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" group by sal_id) q on q.sal_id=s.doc_no left join(select count(*) amccnt,sal_id from sk_srvcontrm e where e.status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" group by sal_id) c on c.sal_id=s.doc_no)a where enqcnt>0 or quotcnt>0 or amccnt>0"; 
			      ResultSet resultSet1 = stmt.executeQuery(sql); 
				RESULTDATA1=cmn.convertToJSON(resultSet1);
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