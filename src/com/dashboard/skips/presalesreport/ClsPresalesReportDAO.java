package com.dashboard.skips.presalesreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPresalesReportDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	 public JSONArray enquirylistsearch(HttpSession session,String brnchval,String chkfollowup,String followupdate,String fromdate,String todate,String areaid,String salesmanid,String id,String decstatus) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        //System.out.println("==id=="+id+"==fromdate=="+fromdate+"==todate=="+todate);
	        if(!id.equalsIgnoreCase("1")) {
	        	return RESULTDATA;
	        }
	 Connection conn = null;
	 String sqlpkp="";   
	 String sql2 = "";
	
	      String sqltest="",sqlsalman="",sqlappnd="";
	        java.sql.Date sqlfromdate = null;
	        java.sql.Date sqlFollowUpDate = null;
	       
	        try {
	          conn = ClsConnection.getMyConnection();
	          Statement stmtVeh = conn.createStatement ();
	    
	    if(decstatus.equalsIgnoreCase("1")) {
	    	sqlappnd="";
	    }
	    else if(decstatus.equalsIgnoreCase("2")) {
	    	sqlappnd=" and e.dropped=1";  
	    }
        else if(decstatus.equalsIgnoreCase("3")) {
        	sqlappnd=" and qm.quotstatus=1";
	    }
        else if(decstatus.equalsIgnoreCase("4")) { 
        	sqlappnd=" and e.dropped=0 and qm.quotstatus=0 ";
        }
        else {
        	sqlappnd="";
        }
	    
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

	  
	  
	  if(chkfollowup.equalsIgnoreCase("1")){
	   if(!(sqlFollowUpDate==null)){
	          sql2+=" and bv.fdate='"+sqlFollowUpDate+"'";
	   }
	  }
	  }
	  if(!(areaid.equalsIgnoreCase("")) && !(areaid.equalsIgnoreCase("0"))){
	         sqltest+=" and ma.area_id="+areaid+" ";
	        }
	     
	 if(brnchval.equalsIgnoreCase("a")||brnchval.equalsIgnoreCase("0")||brnchval.equalsIgnoreCase(""))
	     {
	   sqltest+="";
	     }
	  else
	  {
	   sqltest+=" and e.brhid="+brnchval;
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
	              
	    	 sqlpkp="select d.skipsize,d.wastetype,mm.doc_no jobno,d.amount jobval,eb.name industry,qm.dtype,bh.branchname,us.doc_no userid,us.user_name user,qm.doc_no qotno,dq.amount qotval,e.smapproval,CONVERT(srm.voc_no,CHAR) surdoc,e.doc_no,ms.sal_id,e.qottrno,e.voc_no,e.brhid,e.doc_no, e.date, e.remarks, e.name,ms.sal_name salm, e.mob, ce.txtname source,coalesce(bv1.fdate,bv.fdate)fdate,fs.name fstatus,ds.name dstatus,ds1.name dstatusnw,qf.name as priority, e.enqstatus enqstat,e.com_add1 addr,e.telno,e.email,e.sourceid,e.sjobtype,e.contrmode,e.surtrno,e.enqtype,e.cldocno,e.cpersonid,e.cperson,st.site,st.area,round(TIMESTAMPDIFF(minute,datetime,now())/60,2) age, if(e.cldocno>0,ma.refname,e.name) as name,coalesce(ma.doc_no,0) as clientid,ma.address address,if(e.cldocno>0,ma.per_mob,e.mob)per_mob ,ma.per_tel pertel,if(e.cldocno>0,trim(ma.mail1),e.email) mail1, if(e.cldocno>0,concat(coalesce(ma.address,''),',',coalesce(ma.com_mob,'') ,',',coalesce(ma.mail1,'') ),com_add1) as details, if(e.cpersonid>0,c.cperson,coalesce(e.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid, if(e.cpersonid>0,c.mob,coalesce(e.mob,'')) as contmob,e.esttrno,if(e.surveyed=1,'1','2') surveyed,surtrno,concat('MOB',':',c.mob,';','Email',':',c.email,';','Tele',':',c.tel) contactdet,if(ma.nontax=1,coalesce(tax.per,0.00),0.00) taxper from gl_enqm e    "
		         		+ " left join cm_qotfollowstatus qf on e.priority=qf.doc_no left join my_brch bh on e.brhid=bh.doc_no left join cm_surveym srm on srm.refdocno=e.doc_no left join  cm_enqsource ce on ce.doc_no=e.sourceid left join my_acbook ma on ma.cldocno=e.cldocno and ma.dtype='CRM' left join my_user us on us.doc_no=e.userid left join my_salm ms on ms.doc_no=e.sal_id and ms.status=3 left join (select st.areaid,st.rdocno,group_concat(site) site,group_concat(DISTINCT aa.area) area from gl_enqsited st left join my_area aa on aa.doc_no=st.areaid group by st.rdocno) st on st.rdocno=e.doc_no "
		         		+ " left join gl_enqbuildtype eb on e.enqbtypeid=eb.doc_no left join my_crmcontact c on (c.row_no=e.cpersonid) left join sk_srvqotm qm on qm.refdocno=e.doc_no and qm.refdtype='enq' left join (select sum(rate) amount,rdocno from sk_srvqotdet group by rdocno) dq on dq.rdocno=qm.tr_no left join sk_srvcontrm mm on mm.refdocno=e.doc_no and mm.refdtype='enq' left join (select sum(rate) amount,rdocno,dt.name wastetype,sk.name skipsize from sk_srvcontrdet dd left join sk_dumptype dt on dt.doc_no=dd.wastetype left join sk_skiptype sk on sk.doc_no=dd.skiptype group by rdocno) d on d.rdocno=mm.tr_no left join gl_taxsubmaster tax on (tax.fromdate<='"+sqlfromdate+"' and tax.todate>='"+sqltodate+"' and tax.status=3 and tax.type=2 and tax.per>0) left join gl_bqot bv on qm.tr_no = bv.rdocno and bv.rdtype='QOT' left join cm_qotfollowstatus fs on fs.doc_no=bv.fstatus left join cm_qotdeclinestatus ds1 on ds1.doc_no=bv.dstatus left join gl_bqot bv1 on e.doc_no = bv1.rdocno and bv1.rdtype='ENQ' left join cm_qotdeclinestatus ds on ds.doc_no=bv1.dstatus  where 1=1 and e.status=3  and e.confirm=0 "+sqlappnd+"  and e.DATE between '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+"  "+sql2+" "+sqlsalman+" group by e.doc_no order by e.doc_no,bv.fdate DESC";
	    	 //System.out.println("--==presales==--"+sqlpkp);     
	              ResultSet resultSet = stmtVeh.executeQuery(sqlpkp);
	              RESULTDATA=cmn.convertToJSON(resultSet);
	  }
	  catch(Exception e){
	   conn.close();
	  }
	  finally{
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
				////System.out.println("=====loadTrafficdaily");
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
				String sqldata = "select a.* from(select m.rdtype,m.date detdate,m.remarks remk,m.fdate,u.user_id user,fs.name status from gl_bqot m inner join my_user u on u.doc_no=m.userid left join cm_qotfollowstatus fs on fs.doc_no=m.fstatus where m.rdocno='"+trno+"' and m.rdtype='QOT' "
						+ "and m.bibpid=(select rowno  from gl_bibp where bibdid=(select doc_no from gl_bibd where description='Quotation Follow Up') and process='Follow-UP') and m.status=3 group by m.doc_no union all select m.rdtype,m.date detdate,m.remarks remk,m.fdate,u.user_id user,'' status from gl_bqot m inner join my_user u on u.doc_no=m.userid where m.rdocno='"+enqdocno+"' and m.status=3 and m.rdtype='ENQ' group by m.doc_no)a order by a.fdate desc";
			     //System.out.println("detail==="+sqldata);
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
	 
}
