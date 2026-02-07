package com.dashboard.marketing.amcmanagement;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsAmcManagementDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray projectData(HttpSession session,String id,String widgetname,String brhid,String fromdate,String todate,String fdatechk) throws SQLException{      
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		 if(!id.equalsIgnoreCase("1")){        
			 return data;
		 } 
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			String sqltest="",strjoin="",sqlselect="";   
			java.sql.Date sqlfromdate = null;
			java.sql.Date sqltodate = null;  
	           
				if(widgetname.equalsIgnoreCase("notassigned")){   
					sqltest=" and (dm.empid is null or dm.empid='0')";       
				}else if(widgetname.equalsIgnoreCase("assigned")){
					sqltest=" and (dm.empid is not null and dm.empid!='0')";    
				}else if(widgetname.equalsIgnoreCase("workstarted")){
					sqltest=" and dm.workper>0 ";    
				}
				/*
				 * else if(widgetname.equalsIgnoreCase("pndcnfrd")){
				 * sqltest=" and dm.confirm=0 "; }else{}
				 */     
				
				if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){        
					sqltest+=" and m.brhid='"+brhid+"'";        
				}
				
				if(fdatechk.equalsIgnoreCase("1")) {  
			    	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
			     		sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			     		sqltest+=" and m.date>='"+sqlfromdate+"'"; 
			        }
			    }
			    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
			     		sqltodate=objcommon.changeStringtoSqlDate(todate);
			     		sqltest+=" and m.date<='"+sqltodate+"'";   
			    } 
			    
				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){  
			    	sqltest=sqltest+" and (mm.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    }
			    
			    String strsql="select round(coalesce(p1.schedulecount,0)/coalesce(s.sitecount,0),0) servicecount,p1.schedulecount,p1.compschcountcount,s.sitecount,b.code,m.brhid,ac.acno,s.site,m.tr_no docno,m.doc_no vocno,m.date,m.cldocno,ac.refname,dm.refdocno,dm.tr_no,dm.dtype from  cm_srvcontrm m left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM')  left join (select group_concat(site) site,tr_no,count(*) sitecount from cm_srvcsited group by tr_no) s on s.tr_no=m.tr_no left join my_brch b on b.doc_no=m.brhid  left join (select sum(if(sm.confirm=0 or sm.confirm is null,1,0)) confirm,p.dtype,p.doc_no,p.refdocno,p.tr_no,p.empgroupid,p.empid,p.workper from cm_servplan p left join cm_srvdetm sm on sm.schrefdocno=p.tr_no group by p.doc_no,p.dtype) dm on (m.tr_no=dm.doc_no and m.dtype=dm.dtype) left join cm_serteamm mm on(dm.empgroupid=mm.doc_no) left join cm_serteamd md on(md.rdocno=mm.doc_no and dm.empid=md.empid)  left join (select count(*) schedulecount,doc_no,dtype,sum(if(status=5,1,0)) compschcountcount from cm_servplan group by doc_no,dtype) p1 on(m.tr_no=p1.doc_no and m.dtype=p1.dtype) where m.dtype='AMC' and m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 and dm.confirm!=0 "+sqltest+" group by m.tr_no";
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
	
	public JSONArray assignmode(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname assign,codeno,doc_no docno from my_groupvals where grptype='assignmode' and status=3";
//			System.out.println("===getassign===="+sql);
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
	
	public JSONArray assignfrm(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select grpcode,doc_no  from cm_serteamm where status=3";
//			System.out.println("===sql===="+sql);
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
	
	public JSONArray assignteam(HttpSession session,String assignid) throws SQLException{  
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();  
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select s.doc_no,s.rdocno,name,grpcode,s.empid from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) "
					+ "left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no='"+assignid+"'";
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
	
	public JSONArray userSearch(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no docno,user_name username from my_user where status=3 and block=0";

//			System.out.println("===getassign===="+sql);

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
	
	public  JSONArray subGridData(String id,String jobdocno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {
			conn = objconn.getMyConnection();
			stmt = conn.createStatement ();
				
			String sqldata="select a.doc_no,cast(budget as decimal(15,2)) budget,name  from(select rdocno doc_no,round(budget,2) budget,cm.name from cm_subdivm m left join cm_subdivision cm on cm.doc_no=m.rdocno and cm.status=3 where m.jobdocno="+jobdocno+" union all select doc_no,'' budget,name from cm_subdivision  where status=3)a group by a.doc_no";   
			//System.out.println("******++******"+sqldata);
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
	public JSONArray employeeDetailsSearch(String empid,String empname,String check) throws SQLException {
	    
    	JSONArray RESULTDATA=new JSONArray();
          
    	if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
    	
         Connection conn = null; 
         
        try {
        	
            conn = objconn.getMyConnection();   
            Statement stmtBDT = conn.createStatement();
            String sql1="";
           
            if(!(empid.equalsIgnoreCase("") || empid.equalsIgnoreCase("0"))){
            	sql1+=" and m.codeno="+empid+"";
            }
            
            if(!(empname.equalsIgnoreCase("") || empname.equalsIgnoreCase("0"))){
            	sql1+=" and m.name like '%"+empname+"%'";
            }
            
            String sql="select m.doc_no,m.codeno,m.name,m.costperhour from hr_empm m left join (select max(doc_no),catid,status,timesheet from hr_paycode where status=3 and timesheet=1 group by catid) c on (m.pay_catid=c.catid and c.timesheet=1) "
            		+ "left join hr_setdept d on m.dept_id=d.doc_no where m.status=3 and m.active=1 and c.status=3 and c.timesheet=1 and d.deploytech=1 "+sql1+"";
            
            ResultSet resultSet = stmtBDT.executeQuery(sql);
            RESULTDATA=objcommon.convertToJSON(resultSet);
           
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
	public JSONArray jobSearchGridLoading(HttpSession session,String typedocno,String refnames,String check,String dtype) throws SQLException {
	    
  	  JSONArray RESULTDATA=new JSONArray();
        
  	  if(!(check.equalsIgnoreCase("1"))) {
  		  return RESULTDATA;
  	  }
        Connection conn = null; 
       
      try {
         conn = objconn.getMyConnection();
         Statement stmtmain = conn.createStatement();

         String sql="";
         String sqltest="";
         
         if(!refnames.equalsIgnoreCase("") && !refnames.equalsIgnoreCase("0")){
      	   sqltest+=" and ac.refname like '%"+refnames+"%' ";
         }
         
         if(!typedocno.equalsIgnoreCase("") && !typedocno.equalsIgnoreCase("0")){
      	   sqltest+=" and m.doc_no like '%"+typedocno+"%' ";
         }
         
      	   
         sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname, "
         		+ "ac.refname customer,m.cldocno from cm_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno "
         		+ "and ac.dtype='CRM' where m.status=3 and m.JBAction in (0,4) and m.dtype='"+dtype+"' "+sqltest+" ;";           
           // System.out.println("sql==="+sql);
         ResultSet resultSet = stmtmain.executeQuery(sql);
         RESULTDATA=objcommon.convertToJSON(resultSet);  
            
       stmtmain.close();
       conn.close();
      } catch(Exception e){
        e.printStackTrace();
        conn.close();
      } finally{
       conn.close();
       }
      return RESULTDATA;
   }
	public JSONArray deployTechnicianDetailsGridLoading(HttpSession session,String costtype,String costcode,String check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		
		try {
				conn = objconn.getMyConnection();  
				Statement stmtBDT = conn.createStatement();
	
				if(costtype.contains("AMC") || costtype.contains("amc")) {
					costtype="3";
				} else if(costtype.contains("SJOB") || costtype.contains("sjob")) {
					costtype="4";
				}
				
				String sql="select d.date,m.codeno,m.name,d.intime,d.outtime,round(d.total,2) totalvalue from cm_deploytechd d left join hr_empm m on d.empid=m.doc_no where d.status=3 and d.date>=curdate() and d.costtype="+costtype+" and d.costcode="+costcode+"";
				
				ResultSet resultSet1 = stmtBDT.executeQuery(sql);
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
	public JSONArray manPowerAssignedOnDateGridLoading(HttpSession session,String date,String empdocno,String check) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();
		
		if(!(check.equalsIgnoreCase("1"))){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		
		try {
				conn = objconn.getMyConnection(); 
				Statement stmtBDT = conn.createStatement();
	
				java.sql.Date sqlDate=null;
				
				if(!(date.equalsIgnoreCase("undefined")) && !(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0"))){
					sqlDate = objcommon.changeStringtoSqlDate(date);
		        }
				
				if(sqlDate!=null && (!(empdocno.equalsIgnoreCase("")) && !(empdocno.equalsIgnoreCase("0")))) {
					
					String sql="select d.date,m.codeno,m.name,d.intime,d.outtime,round(d.total,2) totalvalue from cm_deploytechd d left join hr_empm m on d.empid=m.doc_no where d.status=3 and d.date='"+sqlDate+"' and d.empid="+empdocno+"";
					
					ResultSet resultSet1 = stmtBDT.executeQuery(sql);
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
	
	public JSONArray assignGridLoading(HttpSession session,String trno,String id) throws SQLException{  
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		
		if(!(id.equalsIgnoreCase("1"))){  
			return RESULTDATA1;
		}
		
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();  
 
			String sql = "select   round(coalesce(p.workper,0),2) workper,p.refdocno,p.tr_no,date_format(p.plannedon,'%d.%m.%Y') pldate,p.pltime,coalesce(mm.grpcode,'') as asgngrp,coalesce(em.name,'') as emp,case when p.status=3 then 'Not Assigned' when p.status=4 and p.workper=0 then 'Assigned' when p.status=4 and p.workper>0 then 'Started' when p.status=5 then 'Completed' else '' end as status,coalesce(m.budget) budget,p.dtype,p.refdocno,s.site from cm_srvcontrm m "
					+ "left join cm_servplan p on(m.tr_no=p.doc_no and m.dtype=p.dtype) left join cm_srvcsited s on(p.siteid=s.rowno) left join cm_serteamm mm on(p.empgroupid=mm.doc_no) "
					+ "left join cm_serteamd md on(md.rdocno=mm.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) where m.tr_no='"+trno+"'";
  
			//System.out.println("===Assign Grid sql===="+sql);    
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
	public JSONArray serviceGridLoading(HttpSession session,String trno,String id) throws SQLException{  
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		
		if(!(id.equalsIgnoreCase("1"))){  
			return RESULTDATA1;
		}
		
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();  
 
			String sql = "select  round(coalesce(p.workper,0),2) workper,ser.doc_no as serdocno,dm.tr_no srtrno,dm.doc_no srdocno,p.reftrno,p.siteid,s.areaid,p.refdocno,p.tr_no sheduleno,date_format(p.plannedon,'%d.%m.%Y') pldate,p.pltime,coalesce(mm.grpcode,'') as asgngrp,coalesce(em.name,'') as emp,case when p.status=3 then 'Not Assigned' when p.status=4 and p.workper=0 then 'Assigned' when p.status=4 and p.workper>0 then 'Started' when p.status=5 then 'Completed' else '' end as status,coalesce(m.budget) budget,p.dtype,p.refdocno,s.site from cm_srvcontrm m "
					+ "left join cm_servplan p on(m.tr_no=p.doc_no and m.dtype=p.dtype) left join cm_srvcsited s on(p.siteid=s.rowno) left join cm_serteamm mm on(p.empgroupid=mm.doc_no) "
					+ "left join cm_serteamd md on(md.rdocno=mm.doc_no and p.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') left join cm_srvdetm dm on dm.schrefdocno=p.tr_no  where m.tr_no='"+trno+"' and coalesce(dm.confirm,0)!=1";
			//System.out.println("===service Grid sql===="+sql);        
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
