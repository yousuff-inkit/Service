package com.dashboard.gwinternal.queryreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsQueryReportDAO {
	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	
	public JSONArray getFollowupData(String docno,String id) throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!docno.equalsIgnoreCase("")){
				sqltest+=" and d.rdocno="+docno;
			}
			String strsql="select d.doc_no followupdocno,d.rdocno,pr.description assignstatus,d.description remarks,coalesce(d.username,'') clientuser,"+
			" coalesce(concat(e.name,' - ',m.grpcode),'') assigneduser,coalesce(usr.user_name,'') entereduser,d.entrydate from gw_queryfollowup d"+
			" left join cm_assignstatus pr on d.statusdocno=pr.doc_no"+
			" left join cm_serteamd s on d.memberdocno=s.doc_no left join hr_empm e on(s.empid=e.doc_no)"+
			" left join cm_serteamm m on(m.doc_no=s.rdocno) left join my_user usr on d.gwuserid=usr.doc_no where 1=1 "+sqltest;
			System.out.println(strsql);
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
	public JSONArray getQueryData(String id,String comprefid,String empdocno,String frmdate,String todate) throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			
			java.sql.Date sqlfromdate = null;
	     	if(!frmdate.equalsIgnoreCase("undefined") && !frmdate.equalsIgnoreCase("") &&!frmdate.equalsIgnoreCase("0"))
	     	{
	     		sqlfromdate=objcommon.changeStringtoSqlDate(frmdate);
				sqltest+=" and m.postdate>='"+sqlfromdate+"'";

	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("") && !todate.equalsIgnoreCase("0"))
	     	{
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqltest+=" and m.postdate<='"+sqltodate+"'";

	     	}
	     	else{
	     
	     	}
	     	
			if(!comprefid.equalsIgnoreCase("") && !comprefid.equalsIgnoreCase("a")){
				sqltest+=" and m.comprefid="+comprefid;
			}
			if(!empdocno.equalsIgnoreCase("") && !empdocno.equalsIgnoreCase("undefined")){ 
				sqltest+=" and m.empdocno="+empdocno;
			}
			String strsql="select convert(coalesce(m.priorityseqno,''),char(10)) priorityseqno,coalesce(st.description,'') assignstatus,concat(coalesce(emp.name,''),' ',coalesce(team.description,'')) assigneduser,case when m.priority='CS' then 'Complete Stoppage' when m.priority='RO' then 'Restricted Operation' when "+
			" m.priority='MI' then 'Minor Issue' when m.priority='MO' then 'Modification'  when m.priority='NW' then 'New Request' else m.priority  end priority,m.processstatus,m.comprefid,"+
			" case when m.processstatus=1 then 'Entered' when m.processstatus=2 then 'Acknowledged' when m.processstatus=3 then 'Email Sent' when "+
			" m.processstatus=4 then 'Status Updated' else '' end currentstatus,m.postdate,m.doc_no,m.username,m.usermobile,m.usermail,m.formname,"+
			" m.shortdesc,m.query querytext,cmp.company from gw_querym m "+
			" left join gw_complist cmp on m.comprefid=cmp.comp_id "+
			" left join cm_serteamm team on m.teamdocno=team.doc_no "+
			" left join hr_empm emp on m.empdocno=emp.doc_no "+
			" left join cm_assignstatus st on st.doc_no=m.statusdocno "+
			" where m.status=3  "+sqltest;
			System.out.println(strsql);
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
}
