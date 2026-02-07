package customerlogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.login.ClsLogin;

public class ClsCustomerLoginDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLogin objlogin=new ClsLogin();
	ClsEncrypt ClsEncrypt=new ClsEncrypt();
	public boolean clientLogin(String clientusername, String clientpassword,   
			HttpSession session, HttpServletRequest request) throws SQLException {   
		System.out.println("in dao");
		Connection conn=null;
		try{
			int userid=0;
			String username="";
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
		//	clientpassword=ClsEncrypt.getInstance().encrypt(clientpassword);
			
			String str="select * from my_acbook where clientusername='"+clientusername+"' and clientpassword='"+clientpassword+"' and status=3 and dtype='CRM'";
			System.out.println(str);
			ResultSet rs=stmt.executeQuery(str);     
			while(rs.next()){
				userid=rs.getInt("cldocno");
				username=rs.getString("refname");        
			}   
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(userid>0){      
		    	session.setAttribute("CLDOCNO", userid);  
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("USERID",userid);
		    	session.setAttribute("COMPANYID","1");
		    	session.setAttribute("USERNAME",username);          
				session.setAttribute("CLIENTNAME", username);          
				String strlog = "insert into gc_clientlog (cldocno,clientname,WIN_USER,win_cmp,WIN_MAC,DATE_IN) values ("+userid+",'"+username+"','"+xuser+"','"+xcomp+"','"+mac+"',now())";
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert<=0){
					conn.close();
					return false;
				}
				else{
					conn.commit();
					return true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	public JSONArray getContractData(String cldocno, String cnttype, String fromdate, String todate, Connection conn){    
		JSONArray contractarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1; 
            String strsql="";
            java.sql.Date sqlfromdate=null;
            java.sql.Date sqltodate=null;
            
            if(!cnttype.equalsIgnoreCase("") && !cnttype.equalsIgnoreCase("undefined") && cnttype!=null) {
            	strsql+=" and cm.dtype='"+cnttype+"'";   
            }else {}
            
            if(!fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("undefined") && fromdate!=null) {
            	sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);      
            }else {}  
            
            if(!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("undefined") && todate!=null) {      
            	sqltodate = objcommon.changeStringtoSqlDate(todate);      
            }else {}  
            
            String strmaster="select date_format(cm.date,'%d.%m.%Y') date,cm.doc_no,coalesce(cms.site,'') site,cm.dtype,ac.refname,coalesce(mc.cperson,' ') cperson,cm.ref_type refdtype,"
            		+ "cm.refno,date_format(cm.validfrom,'%d.%m.%Y') sdate,date_format(cm.validupto,'%d.%m.%Y') edate,round(coalesce(cm.contractval,0),2) cval, round(coalesce(cm.legalchrg,0),2) lfee,cm.brhid,"
            		+ "cm.tr_no from cm_srvcontrm cm left join my_crmcontact mc on cm.cpersonid=mc.row_no left join cm_srvcsited cms on cms.tr_no=cm.tr_no "   
            		+ "left join my_acbook ac on (cm.cldocno=ac.cldocno and ac.dtype='CRM') where cm.status=3 and cm.cldocno='"+cldocno+"' and cm.date between '"+sqlfromdate+"' and '"+sqltodate+" '"+strsql+"";  
            //System.out.println("Contract List--->>>"+strmaster);                  
			ResultSet rsmaster=stmt.executeQuery(strmaster);
			while(rsmaster.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("srno", srno);
				objsub.put("docno", rsmaster.getString("doc_no"));
				objsub.put("dtype", rsmaster.getString("dtype"));
				objsub.put("cperson", rsmaster.getString("cperson"));
				objsub.put("refname", rsmaster.getString("refname"));
				objsub.put("site", rsmaster.getString("site"));
				objsub.put("stdate", rsmaster.getString("sdate"));
				objsub.put("enddate", rsmaster.getString("edate"));
				objsub.put("cvalue", rsmaster.getString("cval"));
				objsub.put("lfee", rsmaster.getString("lfee")); 
				objsub.put("date", rsmaster.getString("date")); 
				objsub.put("tr_no", rsmaster.getString("tr_no")); 
				objsub.put("brhid", rsmaster.getString("brhid"));   
				srno++;
				contractarray.add(objsub);  
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return contractarray;
	}
	
	public JSONArray getScheduleData(String cldocno, String status, String fromdate, String todate, Connection conn){
		JSONArray contractarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1; 
            String strsql="";
            java.sql.Date sqlfromdate=null;
            java.sql.Date sqltodate=null;
            
            if(!status.equalsIgnoreCase("") && !status.equalsIgnoreCase("undefined") && status!=null) {
            	strsql+=" and p.status='"+status+"'";         
            }else {}  
            
            if(!fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("undefined") && fromdate!=null) {
            	sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);      
            }else {}  
            
            if(!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("undefined") && todate!=null) {      
            	sqltodate = objcommon.changeStringtoSqlDate(todate);      
            }else {}
            
            String strmaster="select coalesce(dm.tr_no,0) sertrno,x.profomadate,x.profomarecievedate,x.brhid branch,x.tr_no as doctrno,p.dtype,p.refdocno,p.tr_no,p.sr_no,"
            		+ "s.site,a.groupname,ac.refname,coalesce(sm.sal_name,'')sal_name,DATE_FORMAT(p.plannedon,'%d-%m-%Y') as  pldate,p.plannedon pldte,"
            		+ "priorno priority,DATE_FORMAT(x.validupto,'%d-%m-%Y') as validupto,x.doc_no,dates,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,"
            		+ "gv.groupname compl,coalesce(tm.grpcode,'') asngroup,p.EMPGROUPID grpid,coalesce(cd.description,'') description ,"
            		+ "x.refno from (select sal_id,tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate,"
            		+ "ff.date profomarecievedate,m.doc_no,sjobtype,refno from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) "
            		+ "where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all SELECT sal_id,tr_no,dtype,brhid,siteid,cldocno,c.date dates,"
            		+ "'' validupto,'' profomadate,null profomarecievedate,c.doc_no,'' sjobtype,'' refno FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4)) as x "
            		+ "inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) left join cm_srvdetm dm on dm.schrefdocno=p.tr_no left join cm_serteamm m on(p.empgroupid=m.doc_no) "
            		+ "left join cm_serteamd md on (md.rdocno=m.doc_no and p.empid=md.empid) left join cm_srvcsited s on( p.siteid=s.rowno ) "
            		+ "left join cm_servsited st1 on st1.rowno=p.siteid left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area') "
            		+ "left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') left join my_salm sm on sm.doc_no=x.sal_id "
            		+ "left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service')  left join cm_cuscalld cd on x.tr_no=cd.tr_no "
            		+ "left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no "
            		+ "LEFT JOIN cm_serteamm tm on p.EMPGROUPID=tm.doc_no where p.date between '"+sqlfromdate+"' "
            		+ "and '"+sqltodate+"'and x.cldocno='"+cldocno+"' "+strsql+" group by p.tr_no order by p.plannedon";        
            //System.out.println("Schedule List--->>>"+strmaster);                   
			ResultSet rsmaster=stmt.executeQuery(strmaster);
			while(rsmaster.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("srno", srno);
				objsub.put("contrno", rsmaster.getString("refdocno"));
				objsub.put("contrtype", rsmaster.getString("dtype"));
				objsub.put("schno", rsmaster.getString("tr_no"));
				objsub.put("area", rsmaster.getString("groupname"));
				objsub.put("site", rsmaster.getString("site"));
				objsub.put("salesman", rsmaster.getString("sal_name"));
				objsub.put("assigngrp", rsmaster.getString("asngroup"));
				objsub.put("pldate", rsmaster.getString("pldate"));
				objsub.put("desc1", rsmaster.getString("description"));  
				objsub.put("sertrno", rsmaster.getString("sertrno"));   
				srno++;
				contractarray.add(objsub);  
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return contractarray;
	}
	
	public JSONArray getInvoiceData(String cldocno,String fromdate,String todate, Connection conn){   
		JSONArray contractarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1;  
            String strsql="";
            java.sql.Date sqlfromdate=null;
            java.sql.Date sqltodate=null;
            
            if(!fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("undefined") && fromdate!=null) {
            	sqlfromdate = objcommon.changeStringtoSqlDate(fromdate);      
            }else {}  
            
            if(!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("undefined") && todate!=null) {      
            	sqltodate = objcommon.changeStringtoSqlDate(todate);      
            }else {} 
            
            String strmaster="select m.dtype,m.brhid,m.tr_no,m.doc_no,m.date,m.refno,m.ref_type as contrtype,cm.doc_no as contrNo,ac.refname,"
            		+ "m.description as desc1,round(m.atotal,2) as invamt, round(m.legalchrg,2) as lfee,round(if(cm.inctax=1,m.netamount,"
            		+ "(m.atotal+m.taxamt)),2) as total,sdd.site, round(m.taxamt,2) taxamt from my_servm m left join cm_srvcontrm cm  "
            		+ "on(cm.tr_no=m.costid) left join (select GROUP_CONCAT(distinct site) site,tr_no from cm_srvcsited group by tr_no order by sr_no)"
            		+ " sdd on sdd.tr_no=cm.tr_no left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') where m.status=3 "
            		+ "and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.cldocno='"+cldocno+"' "+strsql+" order by m.doc_no";
            //System.out.println("Invoice List--->>>"+strmaster);               
			ResultSet rsmaster=stmt.executeQuery(strmaster);
			while(rsmaster.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("srno", srno);
				objsub.put("doc_no", rsmaster.getString("doc_no"));
				objsub.put("dtype", rsmaster.getString("dtype"));
				objsub.put("desc1", rsmaster.getString("desc1"));
				objsub.put("refname", rsmaster.getString("refname"));
				objsub.put("site", rsmaster.getString("site"));
				objsub.put("contrtype", rsmaster.getString("contrtype"));
				objsub.put("contrno", rsmaster.getString("contrno"));
				objsub.put("taxamt", rsmaster.getString("taxamt"));
				objsub.put("invamt", rsmaster.getString("invamt"));
				objsub.put("lfee", rsmaster.getString("lfee"));
				objsub.put("total", rsmaster.getString("total"));				
				objsub.put("date", rsmaster.getString("date")); 
				objsub.put("tr_no", rsmaster.getString("tr_no"));    
				objsub.put("brhid", rsmaster.getString("brhid"));  
				srno++;
				contractarray.add(objsub);  
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return contractarray;
	}
	
	public JSONArray getWorkdetailsData(String trno, Connection conn){        
		JSONArray contractarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1;  
            
            String sql= "select mu.user_name,sr.date,sr.wrkper from cm_srvreportstatus sr "
		       		+ "left join my_user mu on mu.doc_no=sr.userid where sr.rtrno='"+trno+"'";
           // System.out.println("Workdetails List--->>>"+sql);                       
			ResultSet rsmaster=stmt.executeQuery(sql);
			while(rsmaster.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("srno", srno);
				objsub.put("user_name", rsmaster.getString("user_name"));
				objsub.put("date", rsmaster.getString("date"));
				objsub.put("wrkper", rsmaster.getString("wrkper"));    
				srno++;
				contractarray.add(objsub);  
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return contractarray;
	}
	
	public JSONArray getAccountStatement(String accdocno, String fromdate, String todate, Connection conn){            
		JSONArray contractarray=new JSONArray();  
		try{
			Statement stmt=conn.createStatement();
            int srno=1;  
            java.sql.Date sqlFromDate=null;   
            java.sql.Date sqlToDate=null;
            String sqltest="";
            if(!fromdate.equalsIgnoreCase("") && !fromdate.equalsIgnoreCase("undefined") && fromdate!=null) {
            	sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);      
            }else {}  
            
            if(!todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("undefined") && todate!=null) {      
            	sqlToDate = objcommon.changeStringtoSqlDate(todate);      
            }else {}  
            String joins=objcommon.getFinanceVocTablesJoins(conn);
            String casestatement=objcommon.getFinanceVocTablesCase(conn);   
			
            String sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select date_format(a.trdate,'%d.%m.%Y') trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
				    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
					+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
					+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
					+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
					+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sqltest+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
					+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
					+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sqltest+" "
					+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
					+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
            //System.out.println("Account Statement--->>>"+sql);                            
			ResultSet rsmaster=stmt.executeQuery(sql);
			while(rsmaster.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("srno", srno);
                objsub.put("trdate", rsmaster.getString("trdate"));
				objsub.put("transtype", rsmaster.getString("transtype"));
				objsub.put("transno", rsmaster.getString("transno"));
				objsub.put("branchname", rsmaster.getString("branchname"));
				objsub.put("description", rsmaster.getString("description"));
				objsub.put("dr", rsmaster.getString("dr"));
				objsub.put("cr", rsmaster.getString("cr"));
				objsub.put("Balance", rsmaster.getString("Balance"));
				srno++;
				contractarray.add(objsub);  
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return contractarray;
	}
}
