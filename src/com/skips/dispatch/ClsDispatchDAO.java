package com.skips.dispatch;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsDispatchDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		public JSONArray loadflwupgrid(String docno) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			Connection conn=null; 
			java.sql.Date edates = null; 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement(); 

			String strsql=" select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from an_taskcreationdets f left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
//			System.out.println("flwp--->>>"+strsql); 
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs); 
			} 
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
			return data;
		}
		public JSONArray disflwupgrid(String docno,String check) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			Connection conn=null;  
			java.sql.Date edates = null; 
			if(!check.equalsIgnoreCase("1")){
				return data;
			} 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement(); 

			String strsql=" select f.ass_date date,u.user_name asuser,r.user_name user,f.remarks remark,f.action_status status from in_dispatchcreationd f left join my_user u on u.doc_no=f.userid left join my_user r on r.doc_no=f.assnfrom_user where f.rdocno='"+docno+"'"; 
//			System.out.println("disflwp--->>>"+strsql); 
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs); 
			} 
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			conn.close(); 
			}
return data;
}

		
		public JSONArray disflwupgridsummary(String docno,String check) throws SQLException{ 
			JSONArray data=new JSONArray(); 
			Connection conn=null;  
			java.sql.Date edates = null; 
			if(!check.equalsIgnoreCase("1")){
				return data;
			} 
			try{
			conn=objconn.getMyConnection(); 
			Statement stmt=conn.createStatement(); 

			String strsql=" select  rdocno, rdtype, statusid , auserid, sd.date, receivedby, ackdate, remarks, userid, edate,ss.name status,u.user_id asuser,us.user_id userid from sk_dispatchlog sd "
					+ "left join sk_dispatchstatus ss on sd.statusid=ss.rowno "
					+ "left join my_user u on sd.auserid=u.doc_no "
					+ "left join my_user us on sd.userid=us.doc_no where sd.rdocno='"+docno+"' order by sd.edate desc"; 
			//System.out.println("disflwp--->>>"+strsql); 
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs); 
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
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();     
			        
			String strsql="select us.user_name  crtuser, u.user_name user,t.userid,ass_user,t.doc_no,ref_type,ref_no,strt_date,strt_time,description,act_status status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user us on us.doc_no=t.userid left join my_user u on u.doc_no=t.ass_user where  (t.userid='"+userid+"' or t.ass_user='"+userid+"') and t.close_status=0 and t.utype!='app' group by doc_no";        
//			System.out.println("pendingGrid--->>>"+strsql);                                 
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	} 
	
	public JSONArray dispatchGrid(String userid,String check,String fromdate,String todate) throws SQLException{  
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		java.sql.Date edates = null; 
		java.sql.Date sqlfromdate = null;
	     java.sql.Date sqltodate = null;

		if(!check.equalsIgnoreCase("1")){  
			return data;
		}   
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();     
			int status=0;
			String sqltest="";
			 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
					//System.out.println("fromdate------------->>>"+sqlfromdate);                                 

		      }else{}
		      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		      } else{}
			
			String strsql1="select * from my_user where role_id in(1,12) and doc_no='"+userid+"'";
//			System.out.println("dispatchGrid--->>>"+strsql1);                                 
			ResultSet rs1=stmt.executeQuery(strsql1);
			while(rs1.next()){
				status=rs1.getInt("doc_no");
			}
			if(status==0){        
				sqltest=" and (t.userid='"+userid+"' or t.ass_user='"+userid+"')";
			}
			//String strsql="select  u.user_name user,t.userid,ass_user,t.doc_no,ref_type,ref_no,strt_date,strt_time,description,act_status status from an_taskcreation t left join an_taskcreationdets a on t.doc_no=a.rdocno left join my_user u on u.doc_no=t.ass_user where  (t.userid='"+userid+"' or t.ass_user='"+userid+"') and t.close_status=0 and t.utype!='app' group by doc_no";
			String strsql="select  if(t.cltype='CRM',ac.refname,ma.refname) client,contact,us.user_name crtuser,u.user_name user,t.userid,ass_user,t.doc_no,t.date,t.time,message,t.location,collectdet,dispatchdet,t.address,act_status status from in_dispatchcreation t left join in_dispatchcreationd a on t.doc_no=a.rdocno left join my_user us on us.doc_no=t.userid left join my_user u on u.doc_no=t.ass_user left join my_acbook ma on ma.doc_no=t.cldocno and ma.dtype='VND' left join my_acbook ac on ac.doc_no=t.cldocno and ac.dtype='CRM' where convert(concat(substring(t.date , 7,4),'-',substring(t.date , 4,2),'-',substring(t.date , 1,2)) , date) between '"+sqlfromdate+"' and '"+sqltodate+"' and  t.close_status=0 "+sqltest+"  group by doc_no";
			//System.out.println("dispatchGrid--->>>"+strsql);                                 
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	} 
	public JSONArray salesmanGridLoad(HttpSession session,String id) throws SQLException{
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null; 
		 if(id.equalsIgnoreCase("0")){  
			 return data;
		 } 
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
//			System.out.println("--------underwriter----------"+sql1);
			String underwrtr="";
							ResultSet resultSet1 = stmt.executeQuery(sql1) ;
							if(resultSet1.next()){
								underwrtr=" and m.sal_id='"+resultSet1.getString("doc_no")+"'";
							}             
			String strsql="select sal_id, sal_name salm,count(*) count, sum(newcnt) cnew, sum(renewcnt) crenew, sum(cnt1) count1,sum(cnt2) count2,sum(cnt3) count3,sum(cnt4) count4 from ( select m.sal_id,s.sal_name,if(m.type='New',1,0) newcnt,if(m.type='Renewal',1,0) renewcnt, if((DATEDIFF(now(), e.date)<=7)=1,1,0) cnt1, if((DATEDIFF(now(), e.date)>=8 and DATEDIFF(now(),e.date)<=14)=1,1,0) cnt2, if((DATEDIFF(now(),e.date)>=15 and DATEDIFF(now(), e.date)<=21)=1,1,0) cnt3, if((DATEDIFF(now(),e.date)>21)=1,1,0) cnt4 from in_underwriterm m left join in_enqm e on e.doc_no=m.enqno left join my_salm s on m.sal_id=s.doc_no where  1=1 "+underwrtr+") a group by sal_id";        
			//System.out.println("strsql--->>>"+strsql);               
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	public JSONArray underwrtrGridLoad(HttpSession session,String id) throws SQLException{
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null; 
		 if(id.equalsIgnoreCase("0")){  
			 return data;
		 } 
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			String sql1="select e.doc_no from hi_employee e where e.status=3 and e.deptid=2 and userid='"+session.getAttribute("USERID")+"'";
			//System.out.println("--------underwriter----------"+sql1);  
			String underwrtr="";
							ResultSet resultSet1 = stmt.executeQuery(sql1) ;
							if(resultSet1.next()){ 
								underwrtr=" and m.underwtr='"+resultSet1.getString("doc_no")+"'";
							}          
    
			String strsql="select underwtr,status,count(*) count, sum(newcnt) cnew,sum(renewcnt) crenew,sum(cnt1) count1,sum(cnt2) count2,sum(cnt3) count3,sum(cnt4) count4 from ( select  m.underwtr,s.name status,if(m.type='New',1,0) newcnt,if(m.type='Renewal',1,0) renewcnt, if((DATEDIFF(now(), e.date)<=7)=1,1,0) cnt1, if((DATEDIFF(now(), e.date)>=8 and DATEDIFF(now(),e.date)<=14)=1,1,0) cnt2, if((DATEDIFF(now(),e.date)>=15 and DATEDIFF(now(), e.date)<=21)=1,1,0) cnt3, if((DATEDIFF(now(),e.date)>21)=1,1,0) cnt4 from in_underwriterm m left join in_enqm e on e.doc_no=m.enqno left join hi_employee s on m.underwtr=s.doc_no  where 1=1 "+underwrtr+") aa group by underwtr";        
			//System.out.println("strsql--->>>"+strsql);          
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
			}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public JSONArray searchuser(HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();                                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			        
			String strsql="select user_name user,doc_no from my_user";  
			//System.out.println("user======================"+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}

	
	public JSONArray searchclient(HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();                                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			   
			String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
			//System.out.println("--------underwriter----------"+sql1);
			String underwrtr="";
							ResultSet resultSet1 = stmt.executeQuery(sql1) ;
							if(resultSet1.next()){
								underwrtr=" and m.sal_id='"+resultSet1.getString("doc_no")+"'";
							}  
							String telesales="";
							/**
							 * removed on request from nsib 
							 * String sql="select e.doc_no from hi_employee e where e.status=3 and e.deptid=2 and userid='"+session.getAttribute("USERID")+"'";
							//System.out.println("--------underwriter----------"+sql1);  
							
											ResultSet resultSet = stmt.executeQuery(sql) ;
											if(resultSet.next()){ 
												telesales=" and m.telesales='"+resultSet.getString("doc_no")+"'";
											}*/    
							
			String strsql="select refname,doc_no,coalesce(address,'') address from my_acbook m where dtype='CRM' "+underwrtr+" "+telesales+"";  
//			System.out.println("strsql========== "+strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	
	public JSONArray searchvendor(HttpSession session) throws SQLException{
		JSONArray data=new JSONArray();                                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			   
			/*
			 * removed on 20-01-2020
			 * 
			 * String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
			//System.out.println("--------underwriter----------"+sql1);
			String underwrtr="";
			ResultSet resultSet1 = stmt.executeQuery(sql1) ;
			if(resultSet1.next()){
				underwrtr=" and m.sal_id='"+resultSet1.getString("doc_no")+"'";
			}  
			String sql="select e.doc_no from hi_employee e where e.status=3 and e.deptid=2 and userid='"+session.getAttribute("USERID")+"'";
			//System.out.println("--------underwriter----------"+sql1);  
			String telesales="";
							ResultSet resultSet = stmt.executeQuery(sql1) ;
							if(resultSet.next()){ 
								telesales=" and m.telesales='"+resultSet.getString("doc_no")+"'";
							}    */
				
			String strsql="select refname,doc_no,coalesce(address,'') address from my_acbook m where dtype='VND' and status=3 ;";
					/*+ " "+underwrtr+" "+telesales+"";*/  
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	
	public JSONArray statusGridLoad(HttpSession session,String id) throws SQLException{              
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null; 
		 if(id.equalsIgnoreCase("0")){  
			 return data;
		 } 
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();  
			String sql1="select e.doc_no from hi_employee e where e.status=3 and e.deptid=2 and userid='"+session.getAttribute("USERID")+"'";
//			System.out.println("--------underwriter----------"+sql1);  
			String underwrtr="";
							ResultSet resultSet1 = stmt.executeQuery(sql1) ;
							if(resultSet1.next()){ 
								underwrtr=" and m.underwtr='"+resultSet1.getString("doc_no")+"'";
							}        
      
		    String sql2="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
//						System.out.println("--------underwriter----------"+sql2);
							String salesmn="";
											ResultSet resultSet2 = stmt.executeQuery(sql2) ;
											if(resultSet2.next()){
												salesmn=" and m.sal_id='"+resultSet2.getString("doc_no")+"'";
											}             
								  		
	     
			String strsql="select estatus,status,count(*) count, sum(newcnt) cnew,sum(renewcnt) crenew,sum(cnt1) count1,sum(cnt2) count2,sum(cnt3) count3,sum(cnt4) count4 from ( select m.estatus,s.name status,if(m.type='New',1,0) newcnt,if(m.type='Renewal',1,0) renewcnt, if((DATEDIFF(now(), e.date)<=7)=1,1,0) cnt1, if((DATEDIFF(now(), e.date)>=8 and DATEDIFF(now(),e.date)<=14)=1,1,0) cnt2, if((DATEDIFF(now(),e.date)>=15 and DATEDIFF(now(), e.date)<=21)=1,1,0) cnt3, if((DATEDIFF(now(),e.date)>21)=1,1,0) cnt4 from in_underwriterm m left join in_enqm e on e.doc_no=m.enqno left join in_ustatus s on m.estatus=s.rowno where 1=1 "+salesmn+" "+underwrtr+") aa group by estatus ";        
			//System.out.println("strsql--->>>"+strsql);          
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	public  JSONArray loadGridData(String enqno) throws SQLException {
       
		JSONArray RESULTDATA=new JSONArray();  

 
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");     
			conn = objconn.getMyConnection();
			stmt = conn.createStatement ();        
				String sqldata="select q.tr_no qdocno,c.doc_no jdocno,e.doc_no edocno,e.voc_no enqno,q.doc_no qotno,c.doc_no jobno,ac.refname client,s.name process,DATE_FORMAT(m.indatetime,'%d.%m.%Y %H:%i:%s') fromdate, u.user_name fromuser, DATE_FORMAT(m.outdatetime,'%d.%m.%Y %H:%i:%s') todate, us.user_name touser,convert(TIMEDIFF(outdatetime,indatetime),char(100)) totaltime,m.remarks "
		     			+ " from in_processlog m left join in_enqm e on e.doc_no=m.enqno left join in_srvqotm q on q.tr_no=m.qotno left join in_contract c on c.doc_no=m.jobno left join cm_status s on s.doc_no=m.statusid left join  my_acbook ac on ac.cldocno=m.cldocno "
		     			+ " left join my_user u on u.doc_no=m.inuserid left join my_user us on us.doc_no=m.outuserid  where 1=1 and e.doc_no='"+enqno+"'";	     
		                    
		//System.out.println("gridDETAILS---->>>"+sqldata);  
		resultSet= stmt.executeQuery (sqldata);    
		RESULTDATA=objcommon.convertToJSON(resultSet);
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
			
		   /*   sql="select c.refno,m.dtype,case when m.statusid=1 then 'Hard copy submitted' when m.statusid=2 "
		      		+ "then 'Received acknowledgement' when e.edate!='' then 'Email send' else "
		      		+ "'Generated' end as status,m.brhid,m.doc_no,m.voc_no invno,"
		      		+ "date_format(m.date,'%d.%m.%Y') invdate,c.doc_no Cntno,c.remarks oldcntno,cs.site,"
		      		+ "CASE WHEN e.edate!='' THEN 'Sent' ELSE 'Not Sent' END AS emailstatus,a.refname client,"
		      		+ "coalesce(u.user_id,'') mailuser,coalesce(e.email,'') email,coalesce(a.per_mob,'') per_mob,"
		      		+ "coalesce(a.per_tel,'') per_tel,sm.sal_name,a.grpcmp,sk.name skipsize,sg.name groupcompany,"
		      		+ "coalesce(c.email,'') cntemail,sl.name dispatch,sp.auserid,coalesce(sp.receivedby,'') receivedby,"
		      		+ "coalesce(us.user_id,'') asuser,d.*  from "
						+ "sk_invm m left join emaillog e  on e.doc_no=m.doc_no and e.dtype in('sinv' ,'INVD','SINT') "
						+ "left join sk_srvcontrm c on c.doc_no=m.cnttrno left join my_acbook a on a.cldocno=c.cldocno and a.dtype='crm' left join my_salm sm on a.sal_id=sm.doc_no "
						+ "left join my_user u on u.doc_no=e.userid left join (select rdocno,sum(nettotal) totinv,sum(if(idno=1,nettotal,0)) wscoll,sum(if(idno=2,nettotal,0)) tip ,sum(if(idno=3,nettotal,0)) gate ,sum(if(idno=8,nettotal,0)) addsk ,sum(if(idno=9,nettotal,0)) skiprent from sk_invd group by rdocno) d on m.doc_no=d.rdocno "
						+ "left join sk_srvcsited cs on cs.tr_no=c.tr_no "
						+ "left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "
						+ "left join sk_skiptype sk on sk.doc_no=sd.skiptype "
						+ "left join sk_clgroup sg on sg.docno=a.grpcmp "
						+ "left join sk_dispatchstatus sl on sl.rowno=m.dispatchid "
                        + "left join (select max(rowno) rno,rdocno,rdtype from sk_dispatchlog group by rdocno,rdtype) dis on dis.rdocno=m.doc_no and dis.rdtype=m.dtype "
                        + "left join sk_dispatchlog sp on sp.rowno=dis.rno	"
						+ "left join my_user us on sp.auserid=us.doc_no "
						+ " where  m.date between '"+sqlfromdate+"' and '"+sqltodate+"'  and m.status=3  group by invno";	
			*/ 
		      sql="select c.refno,m.dtype,case when m.statusid=1 then 'Hard copy submitted' when m.statusid=2 "
			      		+ "then 'Received acknowledgement' when m.email=1 then 'Email send' else "
			      		+ "'Not Printed' end as status,m.brhid,m.doc_no,m.voc_no invno,"      
			      		+ "date_format(m.date,'%d.%m.%Y') invdate,c.doc_no Cntno,c.remarks oldcntno,cs.site,"
			      		+ "CASE WHEN m.email=1 THEN 'Sent' ELSE 'Not Sent' END AS emailstatus,a.refname client,"
			      		+ "coalesce('','') mailuser,coalesce(c.email,'') email,coalesce(a.per_mob,'') per_mob,"
			      		+ "coalesce(a.per_tel,'') per_tel,sm.sal_name,a.grpcmp,sk.name skipsize,sg.name groupcompany,"
			      		+ "coalesce(c.email,'') cntemail,sl.name dispatch,sp.auserid,coalesce(sp.receivedby,'') receivedby,"
			      		+ "coalesce(us.user_id,'') asuser,d.*  from "
							+ "sk_invm m  "
							+ "left join sk_srvcontrm c on c.doc_no=m.cnttrno left join my_acbook a on a.cldocno=c.cldocno and a.dtype='crm' left join my_salm sm on a.sal_id=sm.doc_no "
							+ "left join (select rdocno,sum(nettotal) totinv,sum(if(idno=1,nettotal,0)) wscoll,sum(if(idno=2,nettotal,0)) tip ,sum(if(idno=3,nettotal,0)) gate ,sum(if(idno=8,nettotal,0)) addsk ,sum(if(idno=9,nettotal,0)) skiprent from sk_invd group by rdocno) d on m.doc_no=d.rdocno "
							+ "left join sk_srvcsited cs on cs.tr_no=c.tr_no "
							+ "left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "
							+ "left join sk_skiptype sk on sk.doc_no=sd.skiptype "
							+ "left join sk_clgroup sg on sg.docno=a.grpcmp "
							+ "left join sk_dispatchstatus sl on sl.rowno=m.dispatchid "
	                        + "left join (select max(rowno) rno,rdocno,rdtype from sk_dispatchlog group by rdocno,rdtype) dis on dis.rdocno=m.doc_no and dis.rdtype=m.dtype "
	                        + "left join sk_dispatchlog sp on sp.rowno=dis.rno	"
							+ "left join my_user us on sp.auserid=us.doc_no "
							+ " where  m.date between '"+sqlfromdate+"' and '"+sqltodate+"'  and m.status=3  group by invno";	
				
		   //   System.out.println("===sql===="+sql);    
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
