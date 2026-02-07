package com.dashboard.project.callregisterfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClscallregisterFollowupDAO{

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();  
	public JSONArray estCenterdata(String fromdate,String todate,String branch,String complid,String userid,String ctype) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        
     	String sqltest="";
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
    	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=com.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

       
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=com.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}
     	
       
     	if(!(complid.equals("0") || complid.equals("") || complid.equals("undefined"))){
     		sqltest+=" and cd.cmplId="+complid+"";
		}
     	if(!(userid.equals("0") || userid.equals("") || userid.equals("undefined"))){
     		sqltest+=" and cus.userid="+userid+"";
		}
     	if(!(ctype.equals("0") || ctype.equals("") || ctype.equals("undefined"))){
     		if(ctype.equalsIgnoreCase("OPN"))
     		{
     			sqltest+=" and cus.clstatus!=3";
     		}
     		else if(ctype.equalsIgnoreCase("CLS"))
     		{
     			sqltest+=" and cus.clstatus=3";
     		}
     		
		}
       	if(branch.equalsIgnoreCase("a")||branch.equalsIgnoreCase("0"))
    	{
			sqltest+="";
    	}
		else
		{
			sqltest+=" and cus.brhid="+branch;
		}
     	Connection conn = null;
		Statement stmtVeh =null;
		ResultSet resultSet=null;
		try {
			
				 conn = conobj.getMyConnection();
				 stmtVeh = conn.createStatement ();
				String sql="select cus.brhid,cd.description,if(cus.clstatus=3,'CLOSED','OPEN') type,cus.doc_no docno,cus.calledby,cus.calledbymob,cr.doc_no contractno,s.site,ac.per_mob mob,ac.com_mob tel,DATE_FORMAT(cus.date,'%d-%m-%Y') date,convert(concat(DATE_FORMAT(cus.calldate,'%d.%m.%Y'),':',cus.calltime),char(20)) entereddate,us.user_name user,ac.refname,concat(DATE_FORMAT(ser.plannedon,'%d-%m-%Y'),':',if(ser.pltime=0,'00:00',ser.pltime)) pldate,gvd.groupname sertype,"
						+ "coalesce(m.grpcode,'') as asgngrp,coalesce(em.name,'') as emp,gv.groupname compl,"
						+ " CAST(CONCAT(TIMESTAMPDIFF(day,cus.entrydate, NOW()) , ':',MOD( TIMESTAMPDIFF(hour,cus.entrydate, NOW()), 24), ':',"
						+ "MOD( TIMESTAMPDIFF(minute,cus.entrydate, NOW()), 60)) AS CHAR) duration from cm_cuscallm cus "
						+ "left join cm_servplan ser on ser.reftrno=cus.tr_no and ser.dtype='CREG' left join my_user us on cus.userid=us.doc_no "
						+ "left join my_acbook ac on ac.cldocno=cus.cldocno and ac.dtype='CRM' left join cm_cuscalld cd on cus.tr_no=cd.tr_no "
						+ "left join my_groupvals gv on cd.cmplId=gv.doc_no left join my_groupvals gvd on cd.servid=gvd.doc_no left join cm_srvcontrm cr on cr.tr_no=cus.contractNo "
						+ "left join cm_servsited s on s.rowno=cus.siteid left join cm_serteamm m on(ser.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and ser.empid=md.empid)"
						+ " left join hr_empm em on(md.empid=em.doc_no) where DATE_FORMAT(cus.entrydate,'%Y-%m-%d') between '"+sqlfromdate+"'  and '"+sqltodate+"' "+sqltest+" and cus.status=3  group by cus.doc_no";
            		
         // System.out.println("--callregisterfollowup=--"+sql);
            		resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=com.convertToJSON(resultSet);
     			
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
	public  JSONArray loadSubGridData(String trno,String barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
		 	
		
				
			String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bcgf m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
					+ " and m.status=3 group by m.doc_no order by m.fdate desc";             
		
		//System.out.println(sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=com.convertToJSON(resultSet);   
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
}
