package com.dashboard.skips.contractcreation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsContractCreationDAO {
	
	 ClsConnection ClsConnection=new ClsConnection();
	 ClsCommon cmn=new ClsCommon();
	
	 public JSONArray enquirylistsearch(HttpSession session,String brnchval,String fromdate,String todate,String id,String widgetname) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();  
	        if(!id.equalsIgnoreCase("1")) {
	        	return RESULTDATA;
	        }
	       Connection conn = null;
	      
		   Statement stmtVeh =null;
		   ResultSet resultSet=null;
	       String sqltest="",sqlsalman="",sqlselect2="", sqlselect1="", sqljoin="";
	       java.sql.Date sqlfromdate = null;
	       String sqltest1="";
	        try {
	             conn = ClsConnection.getMyConnection();
			     stmtVeh = conn.createStatement ();  
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
			     /* String sql1="select salesuserlink from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
			    	 System.out.println("sql3====="+sql1); 
			    	 ResultSet rs =stmtVeh.executeQuery(sql1);         
			    	 if(rs.next()){
			    		 sqltest+=" and ms.salesuserlink="+session.getAttribute("USERID");
			     }*/  
			      if(widgetname.equalsIgnoreCase("chklist")){
                      sqljoin+=" left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 and rtrim(ltrim(cd.attach))!='' group by cd.qotno) ckl on ckl.qotno=qm.tr_no left join sk_srvqotdet q on q.rdocno=qm.tr_no and q.revision_no=qm.revision_no left join my_user ue on ue.doc_no=qm.userid left join sk_enqrelated rs on (rs.srno=q.ctypeid and rs.type='CTYPE') left join sk_skiptype sk on sk.doc_no=q.skiptype left join sk_enqrelated qr on (qr.srno=q.servicetermid and qr.type='SCHEDULE')  "; 
                      sqlselect1+="ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*q.scheduledays*q.nos*qr.tripsinmonth nooftripz,round(q.tippingfee,2) tfeee,round(q.rate,2) ratee,";
                      sqlselect2=",round((coalesce(round(nooftripz,2),0)*a.ratee)+(coalesce(round(nooftripz,2),0)*a.tfeee),0) qntvalue";
                      sqltest1=" and realcount=mandcount";
                      sqltest+=" and ckl.qotno is not null and cm.tr_no is null and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";      
                   }else if(widgetname.equalsIgnoreCase("newcrm")){
                       sqljoin+=" left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 and rtrim(ltrim(cd.attach))!='' group by cd.qotno) ckl on ckl.qotno=qm.tr_no  left join sk_srvqotdet q on q.rdocno=qm.tr_no and q.revision_no=qm.revision_no left join my_user ue on ue.doc_no=qm.userid left join sk_enqrelated rs on (rs.srno=q.ctypeid and rs.type='CTYPE') left join sk_skiptype sk on sk.doc_no=q.skiptype left join sk_enqrelated qr on (qr.srno=q.servicetermid and qr.type='SCHEDULE')"; 
                       sqlselect1+="ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*q.scheduledays*q.nos*qr.tripsinmonth nooftripz,round(q.tippingfee,2) tfeee,round(q.rate,2) ratee,";
                       sqlselect2=",round((coalesce(round(nooftripz,2),0)*a.ratee)+(coalesce(round(nooftripz,2),0)*a.tfeee),0) qntvalue";sqltest1=" and realcount=mandcount";
                       sqltest+=" and ckl.qotno is not null and e.cldocno=0  and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
                    }else if(widgetname.equalsIgnoreCase("quot")){
                        sqljoin+=" left join (select count(*) realcount,cd.qotno from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno where ck.mandatory=1 and rtrim(ltrim(cd.attach))!='' group by cd.qotno) ckl on ckl.qotno=qm.tr_no left join sk_srvqotdet q on q.rdocno=qm.tr_no and q.revision_no=qm.revision_no left join my_user ue on ue.doc_no=qm.userid left join sk_enqrelated rs on (rs.srno=q.ctypeid and rs.type='CTYPE') left join sk_skiptype sk on sk.doc_no=q.skiptype left join sk_enqrelated qr on (qr.srno=q.servicetermid and qr.type='SCHEDULE') "; 
                        sqlselect1+="ckl.realcount,(select count(*) mandcount from sk_checklist where mandatory=1 and status=3) mandcount,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*q.scheduledays*q.nos*qr.tripsinmonth nooftripz,round(q.tippingfee,2) tfeee,round(q.rate,2) ratee,";
                        sqlselect2=",round((coalesce(round(nooftripz,2),0)*a.ratee)+(coalesce(round(nooftripz,2),0)*a.tfeee),0) qntvalue";sqltest1=" and realcount=mandcount";
                        sqltest+=" and ckl.qotno is not null and qm.tr_no is not null and cm.tr_no is null  and qm.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
                  }else if(widgetname.equalsIgnoreCase("amc")){     
                      sqltest+=" and cm.tr_no is not null  and cm.date between '"+sqlfromdate+"' and '"+sqltodate+"' ";
                      sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),0) cntvalue,round((coalesce(round(nooftripz,2),0)*a.ratee)+(coalesce(round(nooftripz,2),0)*a.tfeee),0) qntvalue";
                      sqlselect1="if(e.cldocno>0,'Existing','New') clienttype,cm.cpemail email1,ue.user_name user1,cm.date cntdate,case when cm.status<3 then 'Draft' when cm.status=3 then 'Approved' when d.statusid=6 then 'Printed' when d.statusid=2 then 'Emailed' when d.statusid=3 then 'Acknowledgement Done' else '' end as cntdocstatus,(case when cm.billingmethod=1 then 1 when cm.billingmethod=2 then 12 else 0 end)*d.scheduledays*d.nos*r2.tripsinmonth nooftrips,(case when qm.billingmethod=1 then 1 when qm.billingmethod=2 then 12 else 0 end)*q.scheduledays*q.nos*qr.tripsinmonth nooftripz,d.nos skipqty,round(d.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(d.rate,2) rate, round(q.rate,2) ratee,round(d.rent,2) rent, round(d.tippingfee,2) tfee,round(q.tippingfee,2) tfeee,date_format(cm.startdt,'%d.%m.%Y') strtdate,date_format(cm.enddt,'%d.%m.%Y') enddate,r1.name contctype,case when cm.billingmethod=1 then 'Monthly' when cm.billingmethod=2 then 'Yearly' when cm.billingmethod=3 then 'Adhoc' else '' end as cbillmethod,"; 
                      sqljoin=" left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join sk_srvqotdet q on q.rdocno=qm.tr_no and q.revision_no=qm.revision_no left join my_user ue on ue.doc_no=cm.userid left join sk_enqrelated r1 on (r1.srno=d.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_enqrelated r2 on (r2.srno=d.servicetermid and r2.type='SCHEDULE') left join sk_enqrelated qr on (qr.srno=q.servicetermid and qr.type='SCHEDULE') ";
                      
                  }else{}                  
			      String sql="select @i:=@i+1 slno, a.* from(select a.*"+sqlselect2+" from(select "+sqlselect1+"coalesce(qm.revision_no,0) qotrevno,qm.payterms,qm.billingmethod,coalesce(a1.name,'') groupcompanies,qm.status qotstatus,at.ay_name designation,qm.cperson,qm.cpersonid,case when e.presalesstatus=1 then 'Surveyed' when e.presalesstatus=2 then 'Quoted' when e.presalesstatus=3 then 'Checklist Updated' when e.presalesstatus=4 then 'Contracted'  when e.presalesstatus=5 then 'Quote Send' else 'Entered' end as status,cm.tr_no contrno,convert(coalesce(cm.doc_no,''),char(40)) condocno,qm.tr_no qottrno,coalesce(e.cldocno,0) cldocno,e.voc_no,e.brhid , e.doc_no, e.date, e.remarks,qm.doc_no qotno,qm.netamount qotval,b.branchname,ce.txtname source,if(e.cldocno>0,ma.refname,e.name) as name,coalesce(e.cldocno,0) as clientid,concat(coalesce(ma.address,''),',',coalesce(qm.mob,''),',',coalesce(qm.tel,'') ,',',coalesce(qm.email,'')) as details,ms.sal_name salm,st.site,e.sourceid,coalesce(ma.address,e.com_add1) address,coalesce(qm.mob,'') per_mob,coalesce(qm.tel,'') pertel,coalesce(qm.email,'') mail1,e.sal_id,bv.fdate,fs.name fstatus,round(TIMESTAMPDIFF(minute,datetime,now())/60,2) age,st.area from gl_enqm e left join my_brch b on e.brhid=b.doc_no left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join sk_clgroup a1 on if(e.grpcmpid=0,ma.grpcmp,e.grpcmpid)=a1.docno left join my_salm ms on ms.doc_no=e.sal_id left join (select ee.areaid,ee.rdocno,group_concat(ee.site) site,aa.area from gl_enqsited ee left join my_area aa on aa.doc_no=ee.areaid group by ee.rdocno) st on st.rdocno=e.doc_no left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join (select max(doc_no) doc_no,rdocno,rdtype from gl_bqot where status=3 and rdtype='QOT' group by rdocno) sub on(sub.rdocno=qm.tr_no) left join gl_bqot bv on sub.doc_no = bv.doc_no left join cm_qotfollowstatus fs on fs.doc_no=bv.fstatus  left join my_activity at on at.doc_no=e.activityid "+sqljoin+" where e.status=3 and e.amcconfirm=0 and e.returned=0 and qm.quotstatus=2 "+sqltest+" group by e.doc_no order by e.doc_no desc)a where 1=1"+sqltest1+")a,(select @i:=0)c"; 
			     // System.out.println("contractcreation--->>>"+sql);                                                        
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
	  System.out.println(RESULTDATA);
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
	 public JSONArray areaSearch(String id) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			if(!id.equals("1")){
				return RESULTDATA;
			}
			Connection conn =null;
			Statement stmt  =null;
			ResultSet resultSet =null;

			try {
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();

				String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
				resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=cmn.convertToJSON(resultSet);   
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				resultSet.close();
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
}
