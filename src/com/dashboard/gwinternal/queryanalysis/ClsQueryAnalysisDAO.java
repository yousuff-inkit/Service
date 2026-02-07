package com.dashboard.gwinternal.queryanalysis;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsQueryAnalysisDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();
	
	public JSONArray queryLoad(HttpSession session,String fromdates,String todates,String id,String type,String statusdocno,String compid) throws SQLException{   
		JSONArray RESULTDATA1=new JSONArray();
		if(!id.equalsIgnoreCase("1")){    
			return RESULTDATA1;
		}
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();  
			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";                
			if(!fromdates.equalsIgnoreCase("")) {
				sqlfromdate=com.changeStringtoSqlDate(fromdates);
			}
			if(!todates.equalsIgnoreCase("")) {
				sqltodate=com.changeStringtoSqlDate(todates);
			}
			if(type.equalsIgnoreCase("1")) {
				sqltest+=" and m.statusdocno<8";    
			} 
			if(type.equalsIgnoreCase("2")) {
				sqltest+=" and m.statusdocno=8";    
			}   
			if(!statusdocno.equalsIgnoreCase("") && !statusdocno.equalsIgnoreCase("0")) {  
				sqltest+=" and m.statusdocno='"+statusdocno+"'";         
			}
			if(!compid.equalsIgnoreCase("9710001") && !compid.equalsIgnoreCase("")) {  
				sqltest+=" and m.comprefid='"+compid+"'";      
			}
			String sql="select TIMESTAMPDIFF(HOUR, m.postdate,ff.entrydate) totaltime,m.doc_no, m.username, m.usermobile, m.usermail, m.formname, m.shortdesc, m.query,DATE_FORMAT(m.postdate,'%d-%m-%Y %H:%i:%d') postdate,DATE_FORMAT(ff.entrydate,'%d-%m-%Y %H:%i:%d') deployedtime,s.description status from gw_querym m left join cm_assignstatus s on s.doc_no=m.statusdocno left join (select max(doc_no) docno,rdocno,statusdocno from gw_queryfollowup where statusdocno=7 group by rdocno) f on f.rdocno=m.doc_no left join (select entrydate,doc_no from gw_queryfollowup) ff on ff.doc_no=f.docno where m.status=3 and m.postdate>='"+sqlfromdate+"' and m.postdate<='"+sqltodate+"' "+sqltest+"";
			System.out.println("==strsql=="+sql);
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);    
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	
	public JSONArray serCountgrid(HttpSession session,String fromdates,String todates,String id,String type,String compid) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){   
			return RESULTDATA;
		}
		Connection conn =null;
		Statement stmt =null;

		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			String sqltest="";                
			if(!fromdates.equalsIgnoreCase("")) {
				sqlfromdate=com.changeStringtoSqlDate(fromdates);
			}
			if(!todates.equalsIgnoreCase("")) {
				sqltodate=com.changeStringtoSqlDate(todates);
			}
			if(type.equalsIgnoreCase("1")) {
				sqltest+=" and m.statusdocno<8";    
			} 
			if(type.equalsIgnoreCase("2")) {
				sqltest+=" and m.statusdocno=8";      
			}  
			if(!compid.equalsIgnoreCase("9710001") && !compid.equalsIgnoreCase("")) {  
				sqltest+=" and m.comprefid='"+compid+"'";      
			}
			String sql="select coalesce(count,0) count,status,coalesce(doc_no,0) doc_no from(select count(*) count,description status,m.statusdocno doc_no from gw_querym m left join cm_assignstatus s on s.doc_no=m.statusdocno where m.status=3 and m.postdate>='"+sqlfromdate+"' and m.postdate<='"+sqltodate+"' "+sqltest+" group by m.statusdocno union all select count(*) count,'ALL' status,0 doc_no from gw_querym m where m.status=3 and m.postdate>='"+sqlfromdate+"' and m.postdate<='"+sqltodate+"' "+sqltest+")a";
			System.out.println("Count Grid:"+sql);    

				ResultSet resultSet = stmt.executeQuery(sql);  
				RESULTDATA=com.convertToJSON(resultSet);
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
