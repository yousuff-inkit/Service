package com.dashboard.inkit.presalesmanagement;

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
	
	public JSONArray jobdetGridLoad(int enqdocno,String fromdate,String todate,String branchval) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		Statement stmt =null;
		String sqltest="";
		
		try {
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
				  java.sql.Date sqlfromdate=null,sqltodate=null;
				    String sqltesting="";
				    if((!fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("0") && !fromdate.equalsIgnoreCase("undefined"))){
				    	sqlfromdate=cmn.changeStringtoSqlDate(fromdate);
			            sqltest=sqltest+" and en.date >= '"+sqlfromdate+"'";
				    }
				    if((!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("0") && !todate.equalsIgnoreCase("undefined"))){
				    	sqltodate=cmn.changeStringtoSqlDate(todate);
				        sqltest=sqltest+" and en.date <= '"+sqltodate+"'";
					}

			
				   if(!branchval.equalsIgnoreCase("a") && !branchval.equalsIgnoreCase("0") && !branchval.equalsIgnoreCase(""))
					  {
					   sqltest+=" and en.brhid="+branchval;
					  }
				String sql= ("select bh.branchname brch,convert(coalesce(ctr.voc_no,''),char(20)) as jobno,en.brhid,jd.empid,COALESCE(em.name,'')employee,case when en.typess=3 then 'AMS' when en.typess=4 then 'Staffing' end enqtype,"
						+ "case when jd.typupdt=1 then 'Internal' when jd.typupdt=2 then 'Extrenal' end type,case when jd.statupdt=1 then 'Requested' when jd.statupdt=2 then 'CV Submitted' when jd.statupdt=3 then 'Approved' when jd.statupdt=4 then 'LPO Received' end status,"
						+"en.voc_no enq_id,en.doc_no,en.date,en.name,ser_id serviceid, comodity_id as comodityid, trade_id tradeid, jd.area_id as areaid, qty, descrptn as description, stdate as startdate, endate as enddate, "
						+"freq_id as frequencyid,c.description as commodity,s.service as services,t.trade as discipline,a.area area,f.frqncy_name as frequency,jd.doc_no jobdetno, ac.curId curid,"
						+"coalesce(ac.doc_no,0) as clientid,if(en.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),en.com_add1) details,"
						+"if(en.cpersonid>0,cn.mob,coalesce(en.mob,'')) as contmob, if(en.cpersonid>0,cn.cperson,coalesce(en.cperson,'')) as cperson,coalesce(cn.row_no,0) as cpersonid,coalesce(en.telno,'') as telno ,coalesce(en.email,'') as email,en.sal_id ,coalesce(en.sal_name,'')sal_name,jd.statupdt,"
						+"coalesce((select a.rowno from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no=en.doc_no and a.dtype='ENQ' and trim(at.type_name)='LPO' limit 1),0)lpoattach " 
						+ " from gl_enqjobdet jd left join is_comm c on(jd.comodity_id=c.doc_no) left join is_trade t on(jd.trade_id=t.doc_no) left join is_service s on(jd.ser_id=s.doc_no) left join my_area"
						+ " a on(jd.area_id=a.doc_no) left join gl_enqm en on jd.enq_id=en.doc_no  left join is_frequency f on(f.doc_no=freq_id) left join hr_empm em on em.doc_no=jd.empid "
						+" left join my_acbook ac on(en.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact cn on(cn.row_no=en.cpersonid) left join cm_staffcontrm ctr on ctr.refno=en.voc_no and ctr.reftype='ENQ' and ctr.brhid=en.brhid  left join my_brch bh on en.brhid=bh.doc_no where en.prcdcreate=1 and en.typess=4  "+sqltest+"   order by en.doc_no, jd.doc_no");

          	//System.out.println("jobgrid==>>"+sql);
				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=cmn.convertToJSON(resultSet);
				
			stmt.close();
  			conn.close();
		} catch(Exception e){
			e.printStackTrace();
		} finally {
  				stmt.close();
  				conn.close();
  			}
        return RESULTDATA;
	}
	
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
	    	 //System.out.println("sql3====="+sql1); 
	    	 ResultSet rs =stmtVeh.executeQuery(sql1);         
	    	 if(rs.next()){
	    		 sqltest+=" and ms.salesuserlink="+session.getAttribute("USERID");
	    	 }
			
	        
	              
	    	 String sql="select ar2.groupname enqtypenw,eb.name industry,qm.dtype,bh.branchname,us.doc_no userid,us.user_name user,qm.doc_no qotno,qm.netamount qotval,e.smapproval,e.enqstatus,'ENQ' as ftype,CONVERT(srm.voc_no,CHAR) surdoc,e.doc_no,if(e.qtype=1,'Kitchen','Closet') qtype,'ENQ' as ftype,ms.sal_id,ar.groupname,e.qottrno,e.voc_no,e.brhid , e.doc_no, e.date, e.remarks, e.name,ms.sal_name salm, e.mob, case when e.enqstatus<3 then 'Enquiry' when e.enqstatus=3 then 'Quoted' end  type, ce.txtname source,bv.fdate,fs.name fstatus,"
		         		+ "qf.name as priority, e.enqstatus enqstat,'VIEW' as view,e.com_add1 addr,e.telno,e.email,e.sourceid,"
		         		+ "e.sjobtype,e.contrmode,e.surtrno,e.enqtype,e.cldocno,e.cpersonid,e.cperson,st.site,round(TIMESTAMPDIFF(minute,datetime,now())/60,2) age, if(e.cldocno>0,ma.refname,e.name) as name,coalesce(ma.doc_no,0) as clientid,"
		         		+ "ma.address address,if(e.cldocno>0,ma.per_mob,e.mob)per_mob ,ma.per_tel pertel,if(e.cldocno>0,trim(ma.mail1),e.email) mail1, if(e.cldocno>0,concat(coalesce(ma.address,''),',',coalesce(ma.com_mob,'') ,',',coalesce(ma.mail1,'') ),com_add1) as details, if(e.cpersonid>0,c.cperson,coalesce(e.cperson,'')) as cperson,"
		         		+ "coalesce(c.row_no,0) as cpersonid, if(e.cpersonid>0,c.mob,coalesce(e.mob,'')) as contmob,e.esttrno,if(e.surveyed=1,'1','2') surveyed,surtrno,concat('MOB',':',c.mob,';','Email',':',c.email,';','Tele',':',c.tel) contactdet,if(ma.nontax=1,coalesce(tax.per,0.00),0.00) taxper  from gl_enqm e    "
		         		+ " left join cm_qotfollowstatus qf on e.priority=qf.doc_no left join my_brch bh on e.brhid=bh.doc_no left join cm_surveym srm on srm.refdocno=e.doc_no left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_user us on us.doc_no=e.userid left join my_salm ms on ms.doc_no=e.sal_id and ms.status=3 left join (select areaid,rdocno,group_concat(site) site from gl_enqsited group by rdocno) st on st.rdocno=e.doc_no "
		         		+ "left join my_groupvals ar on st.areaid=ar.grpno and ar.grptype='area' left join my_groupvals ar2 on e.sertypeid=ar2.grpno and ar2.grptype='service' left join gl_enqbuildtype eb on e.enqbtypeid=eb.doc_no left join my_crmcontact c on (c.row_no=e.cpersonid)    left join cm_srvqotm qm on qm.refdocno=e.doc_no and qm.ref_type='enq' left join gl_taxsubmaster tax on (tax.fromdate<='"+sqlfromdate+"' and tax.todate>='"+sqltodate+"' and tax.status=3 and tax.type=2 and tax.per>0) left join (select max(doc_no) doc_no,rdocno from gl_bqot where status=3 group by rdocno) sub on(sub.rdocno=qm.tr_no) left join gl_bqot bv on sub.doc_no = bv.doc_no left join cm_qotfollowstatus fs on fs.doc_no=bv.fstatus   where 1=1 and e.status=3  and e.confirm=0   and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+"  "+sql2+" "+sqlsalman+" group by e.doc_no order by e.doc_no,bv.fdate DESC";
		             System.out.println("--==presalemgmt--"+sql);
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
	  //System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	public JSONArray loadSubGridData(String trno) throws SQLException {

			JSONArray RESULTDATA=new JSONArray();


			Connection conn = null;
			Statement stmt =null;
			ResultSet resultSet=null;
			try {

				//System.out.println("=====loadTrafficdaily");
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
			 	
			
					
				String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bqot m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
						+ "and m.bibpid=(select rowno  from gl_bibp where bibdid=(select doc_no from gl_bibd where description='presales management') and process='Follow-UP') and m.status=3 group by m.doc_no order by m.fdate desc";
			
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

	public JSONArray employeeDetailsSearch(String empid,String empname,String check) throws SQLException {
	    	JSONArray RESULTDATA=new JSONArray();
	          
	    	if(!(check.equalsIgnoreCase("1"))){
				return RESULTDATA;
			}
	    	
	         Connection conn = null; 
	         
	        try {
	        	
	            conn = ClsConnection.getMyConnection();   
	            Statement stmtBDT = conn.createStatement();
	            String sql1="";
	           
	            if(!(empid.equalsIgnoreCase("") || empid.equalsIgnoreCase("0"))){
	            	sql1+=" and m.codeno="+empid+"";
	            }
	            
	            if(!(empname.equalsIgnoreCase("") || empname.equalsIgnoreCase("0"))){
	            	sql1+=" and m.name like '%"+empname+"%'";
	            }
	            
	            String sql="select m.doc_no,m.codeno,m.name,m.costperhour,m.desc_id desigid,dg.desc1 desig from hr_empm m left join hr_setdesig dg on m.desc_id=dg.doc_no where m.status=3 and m.active=1 "+sql1+"";
	            ResultSet resultSet = stmtBDT.executeQuery(sql);
	            RESULTDATA=cmn.convertToJSON(resultSet);
	           
	            stmtBDT.close();
	            conn.close();
	        } catch(Exception e){
	          e.printStackTrace();
	          conn.close();
	        } finally{
	      conn.close();
	     }
	          return RESULTDATA;
	     }
}
