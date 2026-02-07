package com.dashboard.skips.presalesmanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPresalesmanagementDAO {
	
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
	       String sqltest="",sqlsalman="",sqlselect1="",sqlselect2="",sqljoin="";  
	       java.sql.Date sqlfromdate = null;
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
			      String sql1="select doc_no from my_salm where status=3 and salesuserlink='"+session.getAttribute("USERID")+"'";            
			      //System.out.println("sql3====="+sql1); 
			      ResultSet rs =stmtVeh.executeQuery(sql1);         
			      if(rs.next()){
			    	  sqltest+=" and e.sal_id='"+rs.getString("doc_no")+"'";    
			      }  
			      
			      if(widgetname.equalsIgnoreCase("enq")){   
						sqltest+=" and qm.tr_no is null";
						sqljoin=" left join my_user ue on ue.doc_no=e.userid ";
						sqlselect1="e.email email1,ue.user_name user1,0 qottrno,0 qotno,0 contrno,0 condocno,"; 
				  }else if(widgetname.equalsIgnoreCase("newcrm")){  
					    sqljoin=" left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) ";
						sqltest+=" and e.cldocno=0 and coalesce(qm.quotstatus,0)!=1 and qm.status=3 ";
						sqlselect1="qm.revision_no qotrevno,qm.email email1,ue.user_name user1,qm.date qotdate,qm.payterms,qm.billingmethod,qm.tr_no qottrno,qm.doc_no qotno,qm.netamount qotval,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,concat(coalesce(eb.user ,''),' ',coalesce(CASE WHEN apprStatus=5 THEN 'Forwarded' WHEN apprStatus=3 THEN 'Approved' WHEN apprStatus=2 THEN 'Returned' WHEN apprStatus=4 THEN 'Rejected' WHEN apprStatus=1 THEN 'Submitted' WHEN apprStatus=9 THEN 'Returned Records' WHEN apprStatus=8 THEN 'Old Records' ELSE 'Sent' END ,'')) apprstatus,";
				  }else if(widgetname.equalsIgnoreCase("quot")){
					    sqljoin=" left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) ";
						sqltest+=" and qm.tr_no is not null and cm.tr_no is null  and coalesce(qm.quotstatus,0)!=1 and qm.status=3 ";
						sqlselect1=" concat(coalesce(eb.user ,''),' ',coalesce(CASE WHEN apprStatus=5 THEN 'Forwarded' WHEN apprStatus=3 THEN 'Approved' WHEN apprStatus=2 THEN 'Returned' WHEN apprStatus=4 THEN 'Rejected' WHEN apprStatus=1 THEN 'Submitted' WHEN apprStatus=9 THEN 'Returned Records' WHEN apprStatus=8 THEN 'Old Records' ELSE 'Sent' END,'')) apprstatus, qm.revision_no qotrevno,qm.email email1,ue.user_name user1,qm.date qotdate,qm.payterms,qm.billingmethod,qm.tr_no qottrno,qm.doc_no qotno,qm.netamount qotval,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,";
				  }else if(widgetname.equalsIgnoreCase("amc")){  
						sqltest+=" and cm.tr_no is not null  and coalesce(qm.quotstatus,0)!=1 ";     
						sqlselect2=",round((coalesce(round(nooftrips,2),0)*a.rate)+(coalesce(round(nooftrips,2),0)*a.tfee),2) cntvalue";
						sqlselect1="qm.doc_no qotno,cm.cpemail email1,ue.user_name user1,cm.tr_no contrno,convert(coalesce(cm.doc_no,''),char(40)) condocno,cm.date cntdate,case when cm.status<3 then 'Draft' when cm.status=3 then 'Approved' when cd.statusid=6 then 'Printed' when cd.statusid=2 then 'Emailed' when cd.statusid=3 then 'Acknowledgement Done' else '' end as cntdocstatus,(case when cm.billingmethod=1 then 1 when cm.billingmethod=2 then 12 else 0 end)*cd.scheduledays*cd.nos*r2.tripsinmonth nooftrips,cd.nos skipqty,round(cd.scheduledays*r2.tripsinmonth,2) noofvisit,sk.name skipsize, round(cd.rate,2) rate, round(cd.rent,2) rent, round(cd.tippingfee,2) tfee,concat(date_format(cm.startdt,'%d.%m.%Y'),' - ',date_format(cm.enddt,'%d.%m.%Y')) contperiod,r1.name contctype,case when cm.billingmethod=1 then 'Monthly' when cm.billingmethod=2 then 'Yearly' when cm.billingmethod=3 then 'Adhoc' else '' end as cbillmethod,"; 
						sqljoin=" left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join sk_srvcontrdet cd on cd.rdocno=cm.tr_no left join my_user ue on ue.doc_no=cm.userid left join sk_enqrelated r1 on (r1.srno=cd.ctypeid and r1.type='CTYPE') left join sk_skiptype sk on sk.doc_no=cd.skiptype left join sk_enqrelated r2 on (r2.srno=cd.servicetermid and r2.type='SCHEDULE') ";
				  }else if(widgetname.equalsIgnoreCase("unmgap")){   
						sqltest+=" and qm.tr_no is not null and cm.tr_no is null and qm.status<3 and coalesce(qm.quotstatus,0)!=1 and apprStatus!=3 ";
						sqlselect1="qm.revision_no qotrevno,qm.email email1,ue.user_name user1,concat(coalesce(eb.user ,''),' ',coalesce(CASE WHEN apprStatus=5 THEN 'Forwarded' WHEN apprStatus=3 THEN 'Approved' WHEN apprStatus=2 THEN 'Returned' WHEN apprStatus=4 THEN 'Rejected' WHEN apprStatus=1 THEN 'Submitted' WHEN apprStatus=9 THEN 'Returned Records' WHEN apprStatus=8 THEN 'Old Records' ELSE 'Sent' END ,'')) apprstatus,qm.date qotdate,qm.payterms,qm.billingmethod,qm.tr_no qottrno,qm.doc_no qotno,qm.netamount qotval,case when qm.billingmethod=1 then 'Monthly' when qm.billingmethod=2 then 'Yearly' when qm.billingmethod=3 then 'Adhoc' else '' end as qbillmethod,0 contrno,0 condocno,";
						sqljoin=" left join sk_srvcontrm cm on cm.refdocno=e.doc_no and cm.refdtype='enq' left join my_user ue on ue.doc_no=qm.userid left join (select doc_no, dtype, brhid, max(sr_no) srno from my_exdet group by dtype,brhid,doc_no) ex on (ex.dtype=qm.dtype and ex.doc_no=qm.doc_no and ex.brhid=qm.brhid) left join my_exdet et on et.sr_no=ex.srno left join (select group_concat(DISTINCT u.user_name) user, b.doc_no, b.dtype, b.brhid from my_exeb b left join my_user u on u.doc_no=b.userid group by b.dtype, b.doc_no, b.brhid) eb on (eb.dtype=qm.dtype and eb.doc_no=qm.doc_no and eb.brhid=qm.brhid) ";  
				  }else{}              
			        
					    
			      String sql="select @i:=@i+1 slno, b.* from(select a.*"+sqlselect2+" from(select "+sqlselect1+"if(e.cldocno>0,'Existing','New') clienttype,bv1.remarks flwupremarks,qm.status qotstatus,e.returned,e.returnremk,coalesce(a1.name,'') groupcompanies,at.ay_name designation,e.cperson,e.cpersonid,case when e.presalesstatus=1 then 'Surveyed' when e.presalesstatus=2 then 'Quoted' when e.presalesstatus=3 then 'Checklist Updated' when e.presalesstatus=4 then 'Contracted'  when e.presalesstatus=5 then 'Quote Sent'  when e.presalesstatus=6 then 'Returned' else 'Entered' end as status,coalesce(e.cldocno,0) cldocno,e.voc_no,e.brhid , e.doc_no, e.date, e.remarks,ce.txtname source,if(e.cldocno>0,ma.refname,e.name) as name,coalesce(ma.doc_no,0) as clientid,if(e.cldocno>0,concat(coalesce(ma.address,''),',',coalesce(ma.per_mob,''),',',coalesce(ma.per_tel,'') ,',',coalesce(ma.mail1,'')),concat(coalesce(e.com_add1,''),',',coalesce(e.mob,''),',',coalesce(e.telno,'') ,',',coalesce(e.email,''))) as details,ms.sal_name salm,st.site,st.area,e.sourceid,coalesce(ma.address,e.com_add1) address,coalesce(ma.per_mob,e.mob) per_mob,coalesce(ma.per_tel,e.telno) pertel,coalesce(ma.mail1,e.email) mail1,e.sal_id,bv.fdate,fs.name fstatus,round(TIMESTAMPDIFF(minute,datetime,now())/60,2) age from gl_enqm e left join cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join sk_clgroup a1 on if(e.grpcmpid=0,ma.grpcmp,e.grpcmpid)=a1.docno left join my_salm ms on ms.doc_no=e.sal_id left join (select ee.areaid,ee.rdocno,group_concat(ee.site) site,group_concat(aa.area) area from gl_enqsited ee left join my_area aa on aa.doc_no=ee.areaid group by ee.rdocno) st on st.rdocno=e.doc_no left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join (select max(doc_no) doc_no,rdocno,rdtype from gl_bqot where status=3 group by rdocno) sub on(sub.rdocno=qm.tr_no and sub.rdtype='QOT') left join gl_bqot bv on sub.doc_no = bv.doc_no left join cm_qotfollowstatus fs on fs.doc_no=bv.fstatus left join (select max(doc_no) doc_no,rdocno,rdtype from gl_bqot where status=3 group by rdocno) sub1 on(sub1.rdocno=e.doc_no and sub1.rdtype='ENQ') left join gl_bqot bv1 on sub1.doc_no = bv1.doc_no left join my_activity at on at.doc_no=e.activityid "+sqljoin+" where e.status=3 and e.amcconfirm=0 and e.dropped=0 and e.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" order by e.doc_no desc)a)b,(select @i:=0)c";
			      //System.out.println("presalemgmt--->>>"+sql);                                                   
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
	 
	 public  JSONArray loadSubGridData(String trno,String enqdocno) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;   
			Statement stmt =null;
			ResultSet resultSet=null;
			try {

				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
					
				String sqldata = "select a.* from(select m.rdtype,m.date detdate,m.remarks remk,m.fdate,u.user_id user,fs.name status from gl_bqot m inner join my_user u on u.doc_no=m.userid left join cm_qotfollowstatus fs on fs.doc_no=m.fstatus where m.rdocno='"+trno+"' and m.rdtype='QOT' "
						+ "and m.bibpid=(select rowno  from gl_bibp where bibdid=(select doc_no from gl_bibd where description='Quotation Follow Up') and process='Follow-UP') and m.status=3 group by m.doc_no union all select m.rdtype,m.date detdate,m.remarks remk,m.fdate,u.user_id user,'' status from gl_bqot m inner join my_user u on u.doc_no=m.userid where m.rdocno='"+enqdocno+"' and m.status=3 and m.rdtype='ENQ' group by m.doc_no)a order by a.fdate desc";
				// System.out.println("detail==="+sqldata); 
				 resultSet= stmt.executeQuery (sqldata);
				 RESULTDATA=cmn.convertToJSON(resultSet);
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
	 
	/* public JSONArray presaleslogGridLoad(HttpSession session,String id,String work) throws SQLException{
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null; 
			 if(!id.equalsIgnoreCase("1")){  
				 return data;
			 } 
			try{
				conn=ClsConnection.getMyConnection();  
				Statement stmt=conn.createStatement();
				String strsql="select w.rdocno,u.user_name username,date_format (w.logdate,'%d-%m-%Y %H:%m')logdate,description from my_presaleslog w left join my_user u on w.userid=u.doc_no where rdocno="+work+" ";        
				System.out.println("strsql--->>>"+strsql);               
				ResultSet rs=stmt.executeQuery(strsql);
				data=cmn.convertToJSON(rs);  
			}   
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();  
			}
			return data;
		}*/
	 public JSONArray siteGridLoad(HttpSession session,String docno,String id) throws SQLException{
			JSONArray RESULTDATA1=new JSONArray();
			if(!id.equalsIgnoreCase("1")) {
				return RESULTDATA1;   
			}
			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql = "";

				sql="select eq.site,grp.groupname area,eq.remarks, eq.rowno sitedocno, eq.route, eq.gpsx, eq.gpsy, eq.description from gl_enqsited eq left join my_groupvals grp on grp.doc_no=eq.areaid and grp.grptype='area' where eq.rdocno="+docno+"";
				//System.out.println("===sites===="+sql); 
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
				//System.out.println("===checklist7===="+sql);         
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
		public   JSONArray areaSearch(HttpSession session) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			
			Enumeration<String> Enumeration = session.getAttributeNames();
			int a=0;
			while(Enumeration.hasMoreElements()){
				if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
					a=1;
				}
			}
			if(a==0){
				return RESULTDATA;
			}
			String brcid=session.getAttribute("BRANCHID").toString();

			Connection conn =null;
			Statement stmt  =null;
			ResultSet resultSet =null;

			try {
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();

				String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
				//String sql= ("select c.doc_no as citydocno,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_acity c left join my_acountry ac on(ac.doc_no=c.country_id) left join my_aregion r on(r.doc_no=ac.reg_id) where  c.status=3 and ac.status=3 and r.status=3" );
			//	System.out.println("------------------"+sql);
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
			//	System.out.println(RESULTDATA);
			return RESULTDATA;
		}
		public JSONArray clientData(int id) throws SQLException{ 
			JSONArray RESULTDATA1=new JSONArray();
			if(id!=1) {  
				return RESULTDATA1;   
			}
			Connection conn=null;
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement();  

				String sql="select refname, cldocno from my_acbook where dtype='crm' and status=3";
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
