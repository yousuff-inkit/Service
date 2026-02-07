package com.dashboard.cargo.operationmanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsOperationManagementDAO {
	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	Connection conn = null;         
	
	 public JSONArray revenueDataLoad(String enqdocno,String qotdocno,String docno,String id) throws SQLException {    
		 JSONArray RESULTDATA=new JSONArray();           
	        Connection conn = null;
	        if(!id.equalsIgnoreCase("1")){  
	        	return RESULTDATA;
	        }
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sql="select coalesce(d.doc_no,0) rowno,coalesce(d.tobebilled,0) tobebilled,cast(if(coalesce(s.tax,0)=1,5,0) as unsigned) vatper,coalesce(d.vatamt,0) vatamt,coalesce(d.nettotal,0) nettotal,coalesce(s.inacno,0) inacno,coalesce(s.tax,0) tax,s.srvtype sertype,d.typeid srvdocno,cr.code currency,d.curid,convert(d.rate,char(50)) rate,convert(d.price,char(50)) price, convert(d.qty,char(50)) qty,d.uom unitid,u.unit uom,convert(d.total,char(50)) total,convert(d.btotal,char(50))  basetotal,d.billing from "
						+ " cr_enqm em left join cr_enqd ed on em.doc_no=ed.rdocno left join cr_qotjobd d on ed.doc_no=d.refdocno left join cr_srvtype s on d.typeid=s.doc_no left join my_curr cr on cr.doc_no=d.curid left join my_unitm u on u.doc_no=d.uom left join my_acbook ac on ac.cldocno=d.vndid and ac.dtype='VND' where d.jobno="+docno+" and d.rdocno="+qotdocno+" and ed.doc_no="+enqdocno+" order by s.seqno"; 
				//System.out.println("==estmsql=="+sql);       
				ResultSet resultSet = stmtCRM.executeQuery (sql);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	 }
	 public JSONArray expensesDataLoad(String enqdocno,String qotdocno,String docno,String id) throws SQLException {    
		 JSONArray RESULTDATA=new JSONArray();           
	        Connection conn = null;
	        if(!id.equalsIgnoreCase("1")){  
	        	return RESULTDATA;
	        }
	        int exp=0;
	        String sql="";   
	        ResultSet resultSet =null;   
			try {
				conn = connDAO.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				   
				String sql1="select coalesce(expense,0) expense from cm_srvcontrm where status<>7 and tr_no="+docno+"";           
				//System.out.println("==estmsql=="+sql1);
				ResultSet rs = stmtCRM.executeQuery (sql1);         
				while(rs.next()){
					exp=rs.getInt("expense");   
				}
				if(exp>0){       
					 sql="select s.srvtype sertype,h.description account,e.rowno,convert(e.costprice,char(50)) costprice, e.srvdocno, convert(e.amount,char(50)) amount, e.invno, date_format(e.invdate,'%d.%m.%Y') invdate,e.billing, e.acno, e.type, e.remarks, convert(e.vatper,char(50)) vatper, convert(e.vatamt,char(50)) vatamt, convert(e.nettotal,char(50)) nettotal from cr_expense e left join cr_srvtype s on e.srvdocno=s.doc_no  left join my_head h on e.acno=h.doc_no where rdocno="+docno+" order by s.seqno";      
					 //System.out.println("==estmsql=="+sql);        
					 resultSet = stmtCRM.executeQuery (sql);
				}else{
					sql="select coalesce(s.tax,0) tax,cast(if(coalesce(s.tax,0)=1,5,0) as unsigned) vatper,convert(d.costprice,char(50)) costprice,s.srvtype sertype,d.typeid srvdocno,cr.code currency,d.curid,convert(d.rate,char(50)) rate,convert(d.price,char(50)) price, convert(d.qty,char(50)) qty,d.uom unitid,u.unit uom,convert(d.total,char(50)) total,convert(d.btotal,char(50))  basetotal,d.billing from "
					 		+ "  cr_enqm em left join cr_enqd ed on em.doc_no=ed.rdocno left join cr_qotjobd d on ed.doc_no=d.refdocno left join cr_srvtype s on d.typeid=s.doc_no left join my_curr cr on cr.doc_no=d.curid left join my_unitm u on u.doc_no=d.uom left join my_acbook ac on ac.cldocno=d.vndid and ac.dtype='VND' where  d.jobno="+docno+" and d.rdocno="+qotdocno+" and ed.doc_no="+enqdocno+" order by s.seqno"; 
					//System.out.println("==estmsql=="+sql);    
					resultSet = stmtCRM.executeQuery (sql);    
				}
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtCRM.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
			}finally{
				conn.close();
			}
			return RESULTDATA;
	 }
	public JSONArray gridDataLoad(String id) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 if(!id.equalsIgnoreCase("1")){
			 return RESULTDATA;  
		 }
	        Connection conn = null;
		try {
			conn = connDAO.getMyConnection();
			Statement stmtCRM = conn.createStatement();    
			
			String sql="select coalesce(sc.expcashacno,0) expcashacno,m.voc_no qvocno,coalesce(sc.cfidocno,0) cfidocno,m.confirm_refno confrefno,sc.date jobdate,sal.sal_name salesman,ed.remarks,if(coalesce(sc.expcpu,0)>0 or coalesce(sc.expjvtrno,0)>0,1,0) jobposted,coalesce(sc.cficonfirm,0) cficonfirm,ed.doc_no enqdocno,m.doc_no qotdocno,md.doc_no modeid,sm.doc_no smodeid,sp.doc_no shipid,coalesce(sc.docstatus,'') docstatus,coalesce(sc.mcpcredit,0) mcpcredit,coalesce(cc.subremarks,'') subdesc,coalesce(sc.cpu,0) cpudocno,coalesce(mp.posted,0) mcpposted,coalesce(mp.doc_no,0) mcpdocno,coalesce(sc.jvtrno,0) jvtrno,coalesce(mp.acno,0) mcpcashacno,coalesce(sc.mcptrno,0) mcptrno,coalesce(bm.totalAmount,0) cpvamount,coalesce(bm.tr_no,0) cpvtrno,sb.name substatus,sc.tr_no,sc.doc_no voc_no,cs.name status,case when cc.agtype=1 then acc.refname  when  cc.agtype=2 then s.sal_name  when cc.agtype=3 then u.user_name else '' end as  assigned,m.confirm_no confrmno,m.confirm_date confrmdate,coalesce(cc.doc_no,0) adocno,sc.brhid,em.voc_no enqno,sc.cldocno,ac.refname client,sc.refno,ed.pol,ed.pod,md.modename mode,sm.submode smode,sp.shipment from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno  left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno  left join cr_qotm m on m.rrefno=em.doc_no and m.reftype='ENQ' left join cr_assignment cc on l.jobno=cc.jobno left join my_salesman s on (s.doc_no=cc.agto and s.sal_type='STF') left join my_acbook acc on (acc.cldocno=cc.agto and acc.dtype='VND') left join cr_cstatus cs on cs.doc_no=cc.cur_status left join cr_substatus sb on sb.doc_no=cc.cur_substatus left join my_acbook ac on ac.cldocno=sc.cldocno and ac.dtype='CRM' left join cr_shipment sp on sp.doc_no=ed.shipid left join cr_mode md on md.doc_no=ed.modeid left join cr_smode sm on sm.doc_no=ed.smodeid left join my_cashbm bm on bm.tr_no=sc.cpvtrno left join my_mcpbm mp on mp.tr_no=sc.mcptrno left join my_user u on u.doc_no=cc.agto  left join my_salm sal on sal.doc_no=ac.sal_id where sc.confirm=0 and l.jobno>0 group by sc.tr_no";
		      	//coalesce(cc.cur_status,0)=0  and removed                          
		 	//System.out.println("--enqrysql--"+sql);
		    ResultSet resultSet = stmtCRM.executeQuery (sql);
			RESULTDATA=commonDAO.convertToJSON(resultSet);   
			stmtCRM.close();
			conn.close();   
		    
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray sLogData(String docno,String check,String brhid) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;   
        }
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
			
				String sqlnew="select a.* from(select u.user_name user,g.description status,date_format(g.edate,'%d.%m.%Y %H:%i:%s') date,g.srno from gl_biblog g left join my_user u on u.doc_no=g.userid where g.doc_no="+docno+" and g.brhid="+brhid+" and g.dtype='COPN' and g.entry='S' union all select u.user_name user,g.description status,date_format(g.edate,'%d.%m.%Y %H:%i:%s') date,g.srno from gl_biblog g left join my_user u on u.doc_no=g.userid where g.doc_no="+docno+" and g.brhid="+brhid+" and g.dtype='COPN' and g.entry='S')a group by a.srno;";               
				//System.out.println("==gridreloading--->>>"+sqlnew);                     
				
				ResultSet resultSet = stmtPC.executeQuery (sqlnew);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtPC.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	public JSONArray sWiseData(String check) throws SQLException {    
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;   
        }
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
			
				String sqlnew="select status status,sum(own) own,sum(vendor) vendor,sum(user) user from(select s.doc_no,s.name status,count(*) own,0 vendor,0 user from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_assignment c on l.jobno=c.jobno left join cr_cstatus s on s.doc_no=c.cur_status where sc.status<>7 and c.agtype=2 and sc.confirm=0 and l.jobno>0 group by s.doc_no union all select s.doc_no,s.name status,0 own,count(*) vendor,0 user from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_assignment c on l.jobno=c.jobno left join cr_cstatus s on s.doc_no=c.cur_status  where sc.status<>7 and c.agtype=1 and sc.confirm=0 and l.jobno>0 group by s.doc_no union all select s.doc_no,s.name status,0 own,0 vendor,count(*) user from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_assignment c on l.jobno=c.jobno left join cr_cstatus s on s.doc_no=c.cur_status  where  sc.status<>7 and c.agtype=3 and sc.confirm=0 and l.jobno>0 group by s.doc_no)a where a.status!='' group by a.doc_no";               
				//System.out.println("==gridreloading--->>>"+sqlnew);                       
				
				ResultSet resultSet = stmtPC.executeQuery (sqlnew);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtPC.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	public JSONArray mWiseData(String check) throws SQLException {    
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;   
        }
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
			
				String sqlnew="select md.modename mode,count(*) val from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_mode md on md.doc_no=ed.modeid where sc.status<>7 and sc.confirm=0 and l.jobno>0  group by md.doc_no";               
				//System.out.println("==gridreloading--->>>"+sqlnew);                       
				
				ResultSet resultSet = stmtPC.executeQuery (sqlnew);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtPC.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	public JSONArray dWiseData(String check) throws SQLException {    
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;   
        }
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
			
				String sqlnew="select a.* from (select cs.name status,sb.name substatus,coalesce(s.sal_name,'') driver,ed.pol,ed.pod,md.modename mode,sm.submode smode,sp.shipment from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqm em on l.enqdocno=em.doc_no left join cr_enqd ed on em.doc_no=ed.rdocno left join cr_mode md on md.doc_no=ed.modeid left join cr_smode sm on sm.doc_no=ed.modeid left join cr_shipment sp on sp.doc_no=ed.shipid  left join  cr_assignment cc on cc.jobno=sc.tr_no left join  my_salesman s on (s.doc_no=cc.agto and s.sal_type='STF' and cc.agtype=2) left join cr_cstatus cs on cs.doc_no=cc.cur_status left join cr_substatus sb on sb.doc_no=cc.cur_substatus where sc.status<>7 and sc.confirm=0 and l.jobno>0)a where a.driver!='' order by a.driver";               
				//System.out.println("==gridreloading--->>>"+sqlnew);                       
				
				ResultSet resultSet = stmtPC.executeQuery (sqlnew);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtPC.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
	public JSONArray vWiseData(String check) throws SQLException {    
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))) {
        	return RESULTDATA;   
        }
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtPC = conn.createStatement();
			
				String sqlnew="select a.* from (select cs.name status,sb.name substatus,concat(coalesce(v.flname,''),' - ',v.reg_no) vehicle,ed.pol,ed.pod,md.modename mode,sm.submode smode,sp.shipment from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqm em on l.enqdocno=em.doc_no left join cr_enqd ed on em.doc_no=ed.rdocno left join cr_mode md on md.doc_no=ed.modeid left join cr_smode sm on sm.doc_no=ed.modeid left join cr_shipment sp on sp.doc_no=ed.shipid  left join  cr_assignment cc on cc.jobno=sc.tr_no left join gl_vehmaster v on v.FLEET_NO=cc.equipment left join cr_cstatus cs on cs.doc_no=cc.cur_status left join cr_substatus sb on sb.doc_no=cc.cur_substatus where  sc.status<>7 and sc.confirm=0 and l.jobno>0)a where a.vehicle!='' order by a.vehicle;";               
				//System.out.println("==gridreloading--->>>"+sqlnew);                       
				
				ResultSet resultSet = stmtPC.executeQuery (sqlnew);
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				stmtPC.close();
				conn.close();

		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
		return RESULTDATA;
    }
}
