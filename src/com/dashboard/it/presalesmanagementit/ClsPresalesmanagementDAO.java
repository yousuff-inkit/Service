package com.dashboard.it.presalesmanagementit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPresalesmanagementDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	 public JSONArray enquirylistsearch(HttpSession session,String branchval,String chkfollowup,String followupdate,String fromdate,String todate,String areaid,String salesmanid,String id) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        if(!id.equalsIgnoreCase("1")) {
	        	return RESULTDATA;
	        }
	 Connection conn = null;
	      
	  Statement stmtVeh =null;
	  ResultSet resultSet=null;
	      String sqltest="",sqlsalman="";
	        java.sql.Date sqlfromdate = null;
	        java.sql.Date sqlFollowUpDate = null;
	       
	        try {
	          conn = ClsConnection.getMyConnection();
	    stmtVeh = conn.createStatement ();
	      if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	      {
	       sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
	       
	      }
	      else{
	     
	      }
	      
	      
	      java.sql.Date sqltodate = null;
		      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	      {
	       sqltodate=cmn.changeStringtoSqlDate(todate);
	       
	      }
	      else{
	     
	      }
	      if(!(followupdate.equalsIgnoreCase("undefined")) && !(followupdate.equalsIgnoreCase("")) && !(followupdate.equalsIgnoreCase("0"))){
	   sqlFollowUpDate = cmn.changeStringtoSqlDate(followupdate);
	  }
	  
	  if(sqlfromdate!=null && sqltodate!=null){

	   String sql2 = "";
	  
	  if(chkfollowup.equalsIgnoreCase("1")){
	   if(!(sqlFollowUpDate==null)){
	          sql2+=" and bv.fdate='"+sqlFollowUpDate+"'";
	   }
	  }
	  
	  if(!(areaid.equalsIgnoreCase("")) && !(areaid.equalsIgnoreCase("0"))){
	         sqltest+=" and ma.area_id="+areaid+" ";
	        }
	     
	        
	        if(!branchval.equalsIgnoreCase("a") && !branchval.equalsIgnoreCase("0") && !branchval.equalsIgnoreCase(""))
	  {
	   sqltest+=" and e.brhid="+branchval;
	  }
	        if(!(salesmanid.equalsIgnoreCase("undefined"))&&!(salesmanid.equalsIgnoreCase(""))&&!(salesmanid.equalsIgnoreCase("0"))&&!(salesmanid.equalsIgnoreCase("a")))
	      {
	         sqlsalman+=" and  ms.doc_no="+salesmanid+" ";
	       
	      }
	      else{
	     
	      }
	        String sql1="select salesuserlink from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
	    	// System.out.println("sql3====="+sql1); 
	    	 ResultSet rs =stmtVeh.executeQuery(sql1);         
	    	 if(rs.next()){
	    		 sqltest+=" and ms.salesuserlink="+session.getAttribute("USERID");
	    	 } 
			
	        
	              
	         String sql="select qm.tr_no,bv1.fdate enqflwpdate, mm.doc_no jobno,mm.netamount jobval,case when e.typess=1 then 'Licensing' when e.typess=2 then 'Project' when e.typess=3 then 'AMS' when e.typess=4 then 'Staffing' end enqtypenw,eb.name industry,qm.dtype,bh.branchname,us.doc_no userid,us.user_name user,qm.doc_no qotno,qm.netamount qotval,e.smapproval,e.enqstatus,'ENQ' as ftype,CONVERT(srm.voc_no,CHAR) surdoc,e.doc_no,if(e.qtype=1,'Kitchen','Closet') qtype,'ENQ' as ftype,ms.sal_id,ar.groupname,e.qottrno,e.voc_no,e.brhid , e.doc_no, e.date, e.remarks, e.name,ms.sal_name salm, e.mob, case when e.enqstatus=1 then 'Layout Confirmed and Assigned' when e.enqstatus<1 then 'Enquiry' when e.enqstatus=3 then 'Quoted' when e.enqstatus=4 then 'Job Created' when e.enqstatus=5 then 'Site Verified' when e.enqstatus=6 then 'Production Drawing' when e.enqstatus=7 then 'Client Drawing Confirmed' when e.enqstatus=8 then 'CSA Updated' when e.enqstatus=9 then 'In Production Management' when e.enqstatus=10 then 'In Delivery' when e.enqstatus=11 then 'Design Approved' when e.enqstatus=12 then ' Design Handovered'  end type , ce.txtname source,coalesce(bv1.fdate,bv.fdate)fdate,fs.name fstatus,ds.name dstatus,"
	         		+ "qf.name as priority, e.enqstatus enqstat,'VIEW' as view,e.com_add1 addr,e.telno,e.email,e.sourceid,"
	         		+ "e.sjobtype,e.contrmode,e.surtrno,e.enqtype,e.cldocno,e.cpersonid,e.cperson,st.site,round(TIMESTAMPDIFF(minute,datetime,now())/60,2) age, if(e.cldocno>0,ma.refname,e.name) as name,coalesce(ma.doc_no,0) as clientid,"
	         		+ "ma.address address,if(e.cldocno>0,ma.per_mob,e.mob)per_mob ,ma.per_tel pertel,if(e.cldocno>0,trim(ma.mail1),e.email) mail1, if(e.cldocno>0,concat(coalesce(ma.address,''),',',coalesce(ma.com_mob,'') ,',',coalesce(ma.mail1,'') ),com_add1) as details, if(e.cpersonid>0,c.cperson,coalesce(e.cperson,'')) as cperson,"
	         		+ "coalesce(c.row_no,0) as cpersonid, if(e.cpersonid>0,c.mob,coalesce(e.mob,'')) as contmob,e.esttrno,if(e.surveyed=1,'1','2') surveyed,surtrno,concat('MOB',':',c.mob,';','Email',':',c.email,';','Tele',':',c.tel) contactdet,if(ma.nontax=1,coalesce(tax.per,0.00),0.00) taxper,e.typess enqtypechk  from gl_enqm e "
	         		+ " left join cm_qotfollowstatus qf on e.priority=qf.doc_no left join my_brch bh on e.brhid=bh.doc_no left join cm_surveym srm on srm.refdocno=e.doc_no left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_user us on us.doc_no=e.userid left join my_salm ms on ms.doc_no=e.sal_id and ms.status=3 left join (select areaid,rdocno,group_concat(site) site from gl_enqsited group by rdocno) st on st.rdocno=e.doc_no "
	         		+ "left join my_groupvals ar on st.areaid=ar.grpno and ar.grptype='area' left join my_groupvals ar2 on e.sertypeid=ar2.grpno and ar2.grptype='service' left join gl_enqbuildtype eb on e.enqbtypeid=eb.doc_no left join my_crmcontact c on (c.row_no=e.cpersonid)    left join cm_srvqotm qm on qm.refdocno=e.doc_no and qm.ref_type='enq' and qm.quotstatus=0 left join cm_srvcontrm mm on mm.reftrno=qm.tr_no left join gl_taxsubmaster tax on (tax.fromdate<='"+sqlfromdate+"' and tax.todate>='"+sqltodate+"' and tax.status=3 and tax.type=2 and tax.per>0) left join (select max(doc_no) doc_no,rdocno from gl_bqot where status=3 group by rdocno) sub on(sub.rdocno=qm.tr_no) left join gl_bqot bv on sub.doc_no = bv.doc_no left join cm_qotfollowstatus fs on fs.doc_no=bv.fstatus left join (select max(doc_no) doc_no,rdocno,rdtype from gl_bqot where status=3 group by rdocno) sub1 on(sub1.rdocno=e.doc_no and sub1.rdtype='ENQ') left join gl_bqot bv1 on sub1.doc_no = bv1.doc_no left join cm_qotdeclinestatus ds on ds.doc_no=bv1.dstatus  where 1=1 and e.status=3 and e.typess in (1,2,3,4)  and e.confirm=0  and e.dropped=0 and e.prcdcreate=0  and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+"  "+sql2+" "+sqlsalman+" group by e.doc_no order by e.doc_no,bv.fdate DESC";
	              //System.out.println("--==presalemgmtgridload--"+sql);
	              resultSet = stmtVeh.executeQuery(sql);
	               RESULTDATA=cmn.convertToJSON(resultSet);
	  }
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
	//  System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	
	 public JSONArray searchuser(HttpSession session) throws SQLException{
			JSONArray data=new JSONArray();                                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=ClsConnection.getMyConnection();  
				Statement stmt=conn.createStatement();
				        
				String strsql="select user_name user,doc_no from my_user";  
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
		}
	
		public JSONArray loadflwupgrid(String docno) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			Connection conn=null; 
			java.sql.Date edates = null; 
			try{
			conn=ClsConnection.getMyConnection(); 
			Statement stmt=conn.createStatement(); 

			String strsql=" select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
			//System.out.println("flwp--->>>"+strsql); 
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
}
	 
		public JSONArray pendingGrid(String userid) throws SQLException{  
			JSONArray data=new JSONArray();                      
			Connection conn=null; 
			 java.sql.Date edates = null;     
			try{
				conn=ClsConnection.getMyConnection();  
				Statement stmt=conn.createStatement();     
				        
				String strsql="select  u.user_name user,t.userid,ass_user,t.doc_no,ref_type,ref_no,strt_date,strt_time,description,act_status status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user u on u.doc_no=t.ass_user where  (t.userid='"+userid+"' or t.ass_user='"+userid+"') and t.close_status=0 and t.utype!='app' group by doc_no";        
				//System.out.println("pendingGrid--->>>"+strsql);                                 
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
		} 
	 
	 
	 public  JSONArray loadSubGridData(String trno,String enqdocno) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();


			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			try {

				//System.out.println("=====loadTrafficdaily");
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
			 	
			
					
				String sqldata = "select a.* from(select  m.rdtype,m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bqot m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
						+ "and m.bibpid=(select rowno  from gl_bibp where bibdid=(select doc_no from gl_bibd where description='presales management') and process='Follow-UP') and m.status=3 group by m.doc_no "
						+ "union all select m.rdtype,m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bqot m "
						+ "inner join my_user u on u.doc_no=m.userid where m.rdocno='"+enqdocno+"' and m.status=3 and m.rdtype='ENQ' group by m.doc_no)a order by a.fdate desc";
			
			//System.out.println("detail==="+sqldata);
					resultSet= stmt.executeQuery (sqldata);
				RESULTDATA=cmn.convertToJSON(resultSet);
				//			System.out.println("=====RESULTDATA"+RESULTDATA);

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
	 
	 public JSONArray presaleslogGridLoad(HttpSession session,String id,String work) throws SQLException{
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
				//System.out.println("strsql--->>>"+strsql);               
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
		}

}
