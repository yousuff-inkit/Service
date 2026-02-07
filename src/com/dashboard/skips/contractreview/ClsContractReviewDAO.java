package com.dashboard.skips.contractreview;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsContractReviewDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
		 
	public JSONArray contractGridLoad(HttpSession session, int id, String fromdate, String todate, String type, String divname) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();   
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			
			java.sql.Date sqlfromdate = null, sqltodate = null;
		    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		    }  
		    
		    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		    	sqltodate=objcommon.changeStringtoSqlDate(todate);
		    }  
		    
			String sql1="select m.doc_no from my_salm m where m.status=3 and salesuserlink='"+session.getAttribute("USERID")+"'";
			String sqltest="",sqljoin="";
			ResultSet rs1 = stmt.executeQuery(sql1) ;
			if(rs1.next()){    
				sqltest+=" and m.sal_id='"+rs1.getString("doc_no")+"'";   
			} 
			
			/*if(sqlfromdate!=null && sqltodate!=null) {
			sqltest+=" and m1.date between '"+sqlfromdate+"' and '"+sqltodate+"'";   
			}*/   
			if(type.equalsIgnoreCase("REN")){
				sqltest+=" and m.status <= 3 and m.oldcnttrno>0 and m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' ";      
			}
		    if(divname.equalsIgnoreCase("rnew")) {      
		    	sqltest+=" and m.status=9 and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) between '"+sqlfromdate+"' and '"+sqltodate+"' "; 
		    	//sqljoin=" left join sk_srvcontrm m1 on m1.tr_no=m.oldcnttrno ";   
		    }
            if(type.equalsIgnoreCase("REV") || divname.equalsIgnoreCase("rev")) {  
		    	sqltest+=" and m.revision_no > 0 and m.status=3 and m.witheffect between '"+sqlfromdate+"' and '"+sqltodate+"' ";
		    }

            if(divname.equalsIgnoreCase("term")) {
		    	sqltest+=" and m.status=10 and m.closedate  between '"+sqlfromdate+"' and '"+sqltodate+"' ";   
		    }
            if(divname.equalsIgnoreCase("allvalid")) {           
		    	sqltest+=" and m.status not in (6,7) and if(m.status=10,'"+sqlfromdate+"'<=m.closedate,1=1) ";                
//		    	and m.revision_no = 0 
		    }
            if(divname.equalsIgnoreCase("new")) {    
		    	sqltest+=" and m.status <= 3 and m.revision_no = 0  and m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' ";       
		    }
            if(divname.equalsIgnoreCase("exp")) {       
		    	sqltest+="and m.status=3 and m.enddt<='"+sqltodate+"' and m.enddt>='"+sqlfromdate+"'";        
		    }    
		    if(!divname.equalsIgnoreCase("exp")) {   
		    	sqltest +=" and ('"+sqlfromdate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or '"+sqltodate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' or if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) between '"+sqlfromdate+"' and '"+sqltodate+"')";
		    }    
		    
		    String sql="select a.*,round((coalesce(round(nooftrips,0),0)*a.rate)+(coalesce(round(nooftrips,0),0)*a.tippingfee),0) cntvalue from(select "
		    		+ "CASE WHEN m.status in(10) THEN 'TER' WHEN (m.status=3 and m.revision_no>0) THEN 'REV' WHEN (m.status=3 and m.oldcnttrno>0 and m.revision_no=0) THEN 'REN' when m.status in(3) THEN 'NEW' when m.status in(0) THEN 'NOTAPPR' when m.status in(9) THEN 'EXP' when m.status in(6) THEN 'CLD' ELSE '' END srfstatus,"
		    		+ "if(m.status=10,u.user_name,rr.requser) closeduser, if(m.status=10,date_format(m.closedate,'%d.%m.%Y'),date_format(rr.witheffect,'%d.%m.%Y'))  closedate, if(m.status=10,m.closereason,rr.remarks) closereason,m.startdt startdt1,cast((case when m.billingmethod=1 then 1 when m.billingmethod=2 then 12 else 0 end)*d.scheduledays*d.nos*r3.tripsinmonth as decimal) nooftrips, if(m.inctipfee=1,'Yes','No') inctipfee,round(coalesce(d.addrate,0),2) addrate,r6.name ctype,m.billingmethod billingmethodid,case when m.billingmethod=1 then 'Monthly' when m.billingmethod=2 then 'Yearly' when m.billingmethod=3 then 'Adhoc' end billingmethod, CASE WHEN coalesce(dd.cnt,0)=0 and m.status!=10 THEN '' WHEN coalesce(dd.cnt,0)=0 and m.status=10 THEN 'Pull Out' WHEN coalesce(dd.cnt,0)>0 THEN 'On Site' ELSE '' END AS skipstatus,m.email,sm.sal_name salesman,coalesce(a1.name,'') groupcompanies,m.refno,m.remarks oldcontno,round(coalesce(d.tippingfee,0),2) tippingfee,round(coalesce(d.gatefee,0),2) gatefee, r5.name tippingmethod,round(coalesce(d.tippingsecurity,0),2) tippingsecurity,round(coalesce(d.tariffrate,0),2) tariffrate,dd.gpsx gpsx1,dd.gpsy gpsy1,dd.route,dd.skip,d.statusid,case when d.statusid=1 then 'Skip Assigned' when d.statusid=2 then 'Delivery Scheduled' when d.statusid=3 then 'Delivered' when d.statusid=4 then 'Route Assigned' when d.statusid=5 then 'Scheduled' when d.statusid=6 then 'Pull out requested' when d.statusid=7 then 'Terminated / Cancel job requested' else 'Entered' end as status,convert(case when m.status=10 then 'Terminated'  when d.hold=1 then 'Hold' when m.status=9 then 'Renewed' when (m.status=3 and m.enddt<=curdate()) then 'Expired' when m.status=0 then 'Not Approved' when m.status=3 then 'Approved' when m.status=6 then 'Closed' else m.status end,char(30)) as cntstatus,m.brhid,if(s.gpsx=0,'',s.gpsx) gpsx, if(s.gpsy=0,'',s.gpsy) gpsy,ac.refname,m.cldocno,d.rowno,m.tr_no,m.doc_no, date_format(m.date,'%d.%m.%Y') date,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, if(s.rowno is null,'',s.site) site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, round(coalesce(d.rate,0),2) rate, round(coalesce(d.securityval,0),2) security, round(coalesce(d.rent,0),2) rent, r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,if(s.rowno is null,0,s.rowno) siteid,date_format(m.enddt,'%d.%m.%Y') enddt,date_format(m.startdt,'%d.%m.%Y') startdt,m.remarks, m.revision_no,coalesce(dd.cnt,0) delqty,convert(coalesce(d.srdocno,''),char(45)) srdocno,d.srdesc,d.srno,r.pullqty,if(m.status=9,'R','N') cnttype,d.foc,dd.dlname,dd.dlmobile,dd.dlemail,dd.dldayshift,case when m.statusid=2 then 'Emailed' when m.statusid=3 then 'Acknowledgement Done' when m.statusid=4 then 'Final invoice raise' when m.statusid=5 then 'Account approved' when m.statusid=6 then 'Printed' else 'Entered' end as docstatus "
		            + "from sk_srvcontrm m inner join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION') left join sk_enqrelated r5 on (r5.srno=d.tippingmethod and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join (select group_concat(distinct del.gpsx) gpsx,group_concat(distinct del.gpsy) gpsy,group_concat(distinct r.name) route,group_concat(distinct m.name) skip,del.rdocno,del.srno,SUM(if(coalesce(del.doc_no,0)>0 and del.type!='P',1,if(coalesce(del.doc_no,0)>0 and del.type='P',0,1))) cnt,group_concat(distinct del.name) dlname,group_concat(distinct del.email) dlemail,group_concat(distinct del.mobile) dlmobile,group_concat(distinct del.dayshift) dldayshift from sk_srvcontrdel del left join sk_skipm m on m.doc_no=del.skipid left join sk_route r on r.doc_no=del.routeid group by del.rdocno,del.srno) dd on dd.rdocno=m.tr_no and dd.srno=d.srno LEFT JOIN (SELECT COUNT(*) pullqty, typeid, cnttrno, detsrno FROM sk_srvcontrrep WHERE typeid='P' GROUP BY cnttrno) r ON r.cnttrno=d.rdocno and r.detsrno=d.srno left join gl_enqm em on em.doc_no=m.refdocno left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (em.grpcmpid=a1.docno or ac.grpcmp=a1.docno) left join my_user u on u.doc_no=m.closeuserid left join (select max(doc_no) docno, rsrno, cnttrno from sk_srvcontrrenew where status=1 group by cnttrno,rsrno) cr on cr.rsrno=d.srno and cr.cnttrno=m.tr_no left join (select requser, remarks, witheffect, doc_no from sk_srvcontrrenew) rr on rr.doc_no=cr.docno "+sqljoin+" where 1=1 "+sqltest+" GROUP BY m.tr_no ORDER BY M.date desc)a"; 
		    //System.out.println("REVIEW GRID="+sql);               
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

	public JSONArray contractrenewalGrid(HttpSession session, String docno) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			int temp=0, trno=Integer.parseInt(docno);   
			
			String docnos="";
			
			boolean flg=true;
		    //System.out.println("Renewal History : 1");
			while(flg) {
				String sql1="select coalesce(tr_no,0) trno from sk_srvcontrm where oldcnttrno="+trno;
				//System.out.println("sql1==="+sql1);
				ResultSet rs1 = stmt.executeQuery(sql1);
				if(rs1.next()) {  
					temp = rs1.getInt("trno"); 
					trno = rs1.getInt("trno"); 
				}else{
					flg=false;
				}
				
				if(temp>0) {
					docnos+=temp+",";   
				}else{
					flg=false;
				}
				//System.out.println(temp);
			}
			 //System.out.println("Renewal History : "+docnos);
			if(docnos!="") {
				docnos = docnos.substring(0, docnos.length() - 1);
				
				String sql = "select m.doc_no, startdt, enddt, ds.name wastetype, sk.name skiptype, r1.name ownership, d.nos, r3.name serviceterm, d.scheduledays days from sk_srvcontrm m inner join sk_srvcontrdet d  on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE')  "
						+ "where m.tr_no in("+docnos+") order by m.doc_no desc";  
			    //System.out.println("Renewal History : "+sql);   
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=objcommon.convertToJSON(resultSet1);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	
	public JSONArray contractrevisionGrid(HttpSession session,String docno) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String sql = "select d.revision_no,r6.name ctype,d.ctypeid,r3.tripsinmonth,d.rowno,r5.name tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, s.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, d.tariffrate, d.addrate, d.tippingfee, d.rent, d.foc,r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,s.sr_no siteid,d.securityval, coalesce(d.tippingmethod,1) tippingmethodid, round(d.tippingsecurity,0) tippingsecurity, d.restricted, d.gatefee from sk_srvcontrdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION')  left join sk_enqrelated r5 on (r5.srno=coalesce(d.tippingmethod,1) and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where d.rdocno='"+docno+"' "
					+ "union all select d.revision_no,r6.name ctype,d.ctypeid,r3.tripsinmonth,d.rowno,r5.name tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, s.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, d.tariffrate, d.addrate, d.tippingfee, d.rent, d.foc,r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,s.sr_no siteid,d.securityval, coalesce(d.tippingmethod,1) tippingmethodid, round(d.tippingsecurity,0) tippingsecurity, d.restricted, d.gatefee from sk_srvcontrdetr d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsitedr s on s.rowno=d.siteid left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION')  left join sk_enqrelated r5 on (r5.srno=coalesce(d.tippingmethod,1) and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where d.rdocno='"+docno+"' ";
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
	public JSONArray dpLoad(HttpSession session, String contrno, int id) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql="";    
			 
			sql="select del.type,if(coalesce(del.doc_no,0)>0 and del.type!='P',1,if(coalesce(del.doc_no,0)>0 and del.type='P',0,0)) atsite,if(coalesce(del.doc_no,0)>0 and del.type='P',1,0) pullqty, del.podate pulldate, del.poremarks pullremarks, if(coalesce(del.doc_no,0)>0,1,0) delqty, 1 qty1, del.driverid, coalesce(del.doc_no,0) delid, del.deldate, del.deltime, del.remarks, e.* from(select @i:=@i+1 slno,a.*,n4.num*1000+n3.num*100+n2.num*10+n1.num qty2 from(select d.srno,d.rdocno,round(d.nos-d.balqty,0) balqty,d.skiptype skipdoc,sk.name skiptype, d.rowno, if(coalesce(d.nos,0)>=coalesce(del.delqty,0), d.nos, del.delqty) qty from sk_srvcontrdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join (select count(*) delqty, rdocno, srno from sk_srvcontrdel group by rdocno,srno) del on d.rdocno=del.rdocno and d.srno=del.srno where d.rdocno='"+contrno+"')a,(select @i:=0)c,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4 where 1=1 having qty2<=qty and qty2!=0)e left join sk_srvcontrdel del on e.rdocno=del.rdocno and e.srno=del.srno and del.slno=e.slno where 1=1 group by e.slno";
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
	public JSONArray hrLogLoad(HttpSession session, int id, String cldocno) throws SQLException{ 
        JSONArray RESULTDATA1=new JSONArray();
        if(id!=1) {
            return RESULTDATA1;    
        }
        Connection conn=null;  
        try {
            conn = objconn.getMyConnection();
            Statement stmt = conn.createStatement();

            String sql="select s.doc_no,date_format(r.date,'%d.%m.%Y') date,r.reason remarks,u.user_name user,r.status from sk_srvcontrhr r left join my_user u on u.doc_no=r.userid left join sk_srvcontrm s on s.tr_no=r.rdocno where s.cldocno='"+cldocno+"'"; 
            //System.out.println("===sql76===="+sql);                

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