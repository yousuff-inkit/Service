package com.dashboard.project.newrequest;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsNewRequestDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray serviceScheduleGridLoad(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates,String assignstatus) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();
		
		if(id!=1){
			return RESULTDATA1;
		}
		
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="";
           
			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and x.cldocno in ("+clientid+")";
			}
			if(priority>0){
				sql11=sql11+" and p.priorno=1";
			}
			
			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and x.brhid in ("+branchid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and x.dtype='"+dtype+"'";
			}
			if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
				sql11=sql11+" and p.empgroupid in ("+grp+")";
			}
			
			if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
				sql11=sql11+" and p.empid in ("+emp+")";
			}
			
			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
				sql11=sql11+" and s.areaid in ("+area+")";
			}
			
			if(!(assignstatus.equals("0") || assignstatus.equals("") || assignstatus.equals("undefined"))){
				sql11=sql11+" and p.assignstatus="+assignstatus+"";
			}

			if(id>0){
				
				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
				   
				    sql="select x.nrstatusname,x.profomadate,x.profomarecievedate,x.tr_no as doctrno,me.menu_name as name,coalesce(u.user_name,'') as enuser,me.func path,p.dtype,p.assignstatus,coalesce(ast.description,'') status,'view' contr,'VIEW' view,'ATTACH' attach,p.refdocno,p.tr_no,p.sr_no,s.site,a.groupname,ac.refname,ac.doc_no docno2,ac.acno,ac.address claddress,"
						/*+ "coalesce(concat(CAST(DATE_FORMAT(sa.plannedon,'%d.%m.%Y') as CHAR(50)),' ',CAST(sa.pltime as CHAR(50))),CAST(DATE_FORMAT(p.entrydate,'%d.%m.%Y %H:%i') as CHAR(50))) pldate,"*/
						+ " CAST(DATE_FORMAT(x.entrydate,'%d.%m.%Y %H:%i') as CHAR(50)) pldate,"
						+ "p.plannedon pldte,priorno priority,coalesce (DATE_FORMAT(apprdate,'%d-%m-%Y %H:%i:%d'),concat(CAST(DATE_FORMAT(p.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(p.pltime as CHAR(50))) ) apprdate,"
						+ "convert(x.contracttrno,char(50)) contracttrno,p.siteid,x.contractdetails,s.areaid,'Service Report' sport ,"
						+ "coalesce(grpcode,'') as asgngrp,md.doc_no as teampid, m.doc_no grpid,coalesce(em.name,'') as emp,md.empid,"
						+ "coalesce(gr.groupname,'') asgnmode,gr.doc_no as asignid,if(x.dtype='CREG',gvd.groupname,ser.groupname) as sertype,ser.doc_no as serdocno,gv.groupname compl,x.brhid branch,coalesce(cd.description,'') description  "
						+ "from (select 0 nrstatus,'' nrstatusname,m.entrydate,tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, "
						+ "m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT c.nrstatus,nr.name nrstatusname,concat(c.calldate,' ',c.calltime) entrydate,tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate "
						+ "FROM cm_cuscallm c left join cm_nrstatus nr on (c.nrstatus=nr.rowno) where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype) "
						+ "left join cm_assignstatus ast on p.assignstatus=ast.doc_no left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ "left join my_user u on u.doc_no=p.userid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
						+" left join (select min(tr_no) trnos,refdocno from cm_srvassign group by refdocno) aa  on aa.refdocno=p.refdocno left join cm_srvassign sa on sa.tr_no=aa.trnos"
						+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status in(3,4) and ast.doc_no!=8 "+sql11+" and cd.cmplid in (749,750,751) group by p.tr_no order by x.entrydate";
				    System.out.println("Grid Load:"+sql);
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

	
	public JSONArray serviceScheduleGridLoadExcel(HttpSession session,String dtype,String date,String branchid,String clientid,int id,int priority,String grp,String emp,String mem,String area,String chkfromdate,String fromdates,String assignstatus) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="",sql11="";
			
			String comp="";



			if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
				sql11+=" and x.cldocno in ("+clientid+")";
			}
			if(priority>0){
				sql11=sql11+" and p.priorno=1";
			}

			if(!(branchid.equals("0") || branchid.equals("") || branchid.equals("undefined")|| branchid.equals("a"))){
				sql11=sql11+" and x.brhid in ("+branchid+")";
			}

			if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined"))){
				sql11=sql11+" and x.dtype='"+dtype+"'";
				if(dtype.equalsIgnoreCase("CREG"))
				{
					comp=comp+" ,gv.groupname complaint ";
				}
			}
			if(!(grp.equals("0") || grp.equals("") || grp.equals("undefined"))){
				sql11=sql11+" and p.empgroupid in ("+grp+")";
			}
			
			if(!(emp.equals("0") || emp.equals("") || emp.equals("undefined"))){
				sql11=sql11+" and p.empid in ("+emp+")";
			}
			
			if(!(area.equals("0") || area.equals("") || area.equals("undefined"))){
				sql11=sql11+" and s.areaid in ("+area+")";
			}
			if(!(assignstatus.equals("0") || assignstatus.equals("") || assignstatus.equals("undefined"))){
				sql11=sql11+" and p.assignstatus="+assignstatus+"";
			}

			if(id>0){

				String sql12="select m.serteamuserlink,md.serteamuserlink from cm_serteamm m left join cm_serteamd md on (md.rdocno=m.doc_no) where m.status=3 and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
				ResultSet resultSet12=stmt.executeQuery(sql12);
				   
			    while(resultSet12.next()){
			    	sql11=sql11+" and (m.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"' or md.serteamuserlink='"+session.getAttribute("USERID").toString().trim()+"')";
			    } 
            sql="select p.refdocno 'CREG NO',coalesce(concat(CAST(DATE_FORMAT(sa.plannedon,'%d.%m.%Y') as CHAR(50)),' ',CAST(sa.pltime as CHAR(50))),CAST(DATE_FORMAT(p.entrydate,'%d.%m.%Y %H:%i') as CHAR(50))) 'DATE',coalesce(u.user_name,'') 'ENTERED USER',coalesce(ast.description,'') 'STATUS',coalesce(if(x.dtype='CREG',"
			    		+ "gvd.groupname,ser.groupname),'') 'SERVICE TYPE',coalesce(gv.groupname,'') 'COMPLAINT',coalesce(cd.description,'') 'DESCRIPTION',coalesce(grpcode,'')'ASSIGN GROUP',coalesce(em.name,'') 'EMPLOYEE',coalesce(ac.refname,'') CLIENT "
						+ "from (select tr_no,dtype,m.brhid,0 as siteid,cldocno,m.date dates,validupto,m.doc_no,m.tr_no contracttrno,"
						+ " DATE_FORMAT(m.profomadate,'%d-%m-%Y') profomadate, "
						+ "m.refno contractdetails,ff.date profomarecievedate from cm_srvcontrm m left join gl_bpif ff on(ff.rdocno=m.tr_no and m.pstatus=2) where "
						+ "m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 union all "
						+ "SELECT tr_no,dtype,brhid,siteid,cldocno,c.date dates,'' validupto,c.doc_no,c.contractno contracttrno,'' profomadate,c.refno contractdetails,null profomarecievedate "
						+ "FROM cm_cuscallm c where c.status=3 and c.clstatus in (0,4) ) as x inner join cm_servplan p on(x.tr_no=p.doc_no and x.dtype=p.dtype)"
						+ "left join cm_assignstatus ast on p.assignstatus=ast.doc_no left join cm_srvcsited s on( p.siteid=s.rowno ) left join my_groupvals a on(a.doc_no=s.areaid and a.grptype='area')"
						+ "left join my_user u on u.doc_no=p.userid left join my_acbook ac on(ac.doc_no=x.cldocno and ac.dtype='CRM') "
						+ "left join cm_serteamm m on(p.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and p.empid=md.empid) "
						+ "left join hr_empm em on(md.empid=em.doc_no) left join my_groupvals gr on(gr.doc_no=p.asgnmode and gr.grptype='assignmode') left join "
						+ "(select max(apprdate) apprdate,doc_no,brhid,dtype from my_exdet where dtype='"+dtype+"'  group by doc_no ) e "
						+ "on(e.doc_no=x.doc_no and e.dtype=x.dtype and e.brhid=x.brhid)   left join my_groupvals ser on(p.servid=ser.doc_no and ser.grptype='service') "
						+ " left join cm_cuscalld cd on x.tr_no=cd.tr_no left join my_groupvals gv on cd.cmplId=gv.doc_no"
						+" left join (select min(tr_no) trnos,refdocno from cm_srvassign group by refdocno) aa  on aa.refdocno=p.refdocno left join cm_srvassign sa on sa.tr_no=aa.trnos"
						+ " left join my_groupvals gvd on cd.servid=gvd.doc_no left join my_menu me on(me.doc_type=p.dtype) where p.status in(3,4) and ast.doc_no!=8 "+sql11+" group by p.tr_no order by p.plannedon";
            	System.out.println(sql);
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA1=objcommon.convertToEXCEL(resultSet1);
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
}
