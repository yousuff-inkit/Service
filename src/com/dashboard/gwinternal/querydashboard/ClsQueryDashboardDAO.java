package com.dashboard.gwinternal.querydashboard;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsQueryDashboardDAO {
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
			//System.out.println(strsql);
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
	public JSONArray getQueryData(String id,String comprefid,String empdocno,String type) throws SQLException{
		JSONArray data=new JSONArray();
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!comprefid.equalsIgnoreCase("") && !comprefid.equalsIgnoreCase("a")){
				sqltest+=" and m.comprefid="+comprefid;
			}
			if(!empdocno.equalsIgnoreCase("") && !empdocno.equalsIgnoreCase("undefined")){
				sqltest+=" and m.empdocno="+empdocno;
			}
			if(!type.equalsIgnoreCase("") && !type.equalsIgnoreCase("undefined")){
				sqltest+=" and m.type="+type;
			}
			String strsql="select flw.entrydate maxfollowdate,convert(coalesce(m.priorityseqno,''),char(10)) priorityseqno,coalesce(st.description,'') assignstatus,concat(coalesce(emp.name,''),' ',coalesce(team.description,'')) assigneduser,case when m.priority='CS' then 'Complete Stoppage' when m.priority='RO' then 'Restricted Operation' when "+
			" m.priority='MI' then 'Minor Issue' when m.priority='DCUM' then 'Data Correction - User Mistake' when m.priority='DCSE' then 'Data Correction - System Error' when m.priority='NW' then 'New Request' when m.priority='SCR' then 'System Check Required' else m.priority end priority,m.processstatus,m.comprefid,"+
			" case when m.processstatus=1 then 'Entered' when m.processstatus=2 then 'Acknowledged' when m.processstatus=3 then 'Email Sent' when "+
			" m.processstatus=4 then 'Status Updated' else '' end currentstatus,m.postdate,m.doc_no,m.username,m.usermobile,m.usermail,m.formname,"+
			" m.shortdesc,m.query querytext,cmp.company,cmp.indcode,DATEDIFF(CURRENT_DATE,flw.entrydate) AS age,m.eddate,m.department deptypeid, case when m.department=1 then 'Development' "
			+ " when m.department=2 then 'Retification' when m.department=3 then 'Implementation' when department=4 then 'Traning' when department=5 then 'Presales' else '' end as deptype from gw_querym m "+
			" left join gw_complist cmp on m.comprefid=cmp.comp_id "+
			" left join cm_serteamm team on m.teamdocno=team.doc_no "+
			" left join hr_empm emp on m.empdocno=emp.doc_no "+
			" left join cm_assignstatus st on st.doc_no=m.statusdocno "+
			" left join (select max(doc_no) maxfollowdocno,rdocno from gw_queryfollowup group by rdocno) maxfollow on m.doc_no=maxfollow.rdocno"+
			" left join gw_queryfollowup flw on flw.doc_no=maxfollow.maxfollowdocno "+
			" where m.status=3 and m.statusdocno<8"+sqltest+" order by flw.entrydate desc";
			//System.out.println(strsql); 
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


    public JSONArray loadSubGridData() throws SQLException{
        JSONArray data=new JSONArray();
        Connection conn=null;
        try{
            conn=objconn.getMyConnection();
            Statement stmt=conn.createStatement();
            String sqltest="select coalesce(count,0) count,type from(select count(*) count,coalesce(s.type,'') type from gw_querym m "
                    + " left join gw_dept s on s.doc_no=m.department where m.status=3 and m.statusdocno<8 group by m.department "
                    + "union all select count(*) count,'ALL' type from gw_querym m where m.status=3 and m.statusdocno<8)a";
          
            System.out.println(sqltest);   
            ResultSet rs=stmt.executeQuery(sqltest);
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
