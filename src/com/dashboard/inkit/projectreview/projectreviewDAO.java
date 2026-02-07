package com.dashboard.inkit.projectreview;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sun.org.apache.bcel.internal.generic.DCONST;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class projectreviewDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval,String clientid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqltest1="",sqltest2="",sqltest11="",sqltest12="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	    	
	    	

	     	if(!barchval.equalsIgnoreCase("a") && !barchval.equalsIgnoreCase(""))
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase(null))){
	       		sqltest11+=" and ac.cldocno="+clientid+" ";
	       		  
			}
		if(!rds.equalsIgnoreCase("")){
					sqltest1+=" and cm.dtype='"+rds+"' ";  
					sqltest2+=" and a.dtype='"+rds+"' ";       
				}
		String sqldata="select case when cm.jbaction='0' then 'Open' when cm.jbaction='1' then 'Hold'  when   cm.jbaction='2' then 'Closed' when   cm.jbaction='3' then 'Completed' when  cm.jbaction='4' then 'Started' else '' end as Status,cm.doc_no,sm.sal_name,cs.grpcode,cm.dtype,ac.refname client,cm.ref_type refert,cm.refdocno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval,cs.site from cm_srvcontrm cm left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join (select group_concat(distinct site) site,group_concat(distinct grpcode) grpcode,tr_no from cm_srvcsited cs left join cm_serteamm mm on cs.srvteamno=mm.doc_no group by cs.tr_no)cs on cs.tr_no=cm.tr_no   left join my_salm sm on ac.sal_id=sm.doc_no  where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+" "+sqltest11+" "+sqltest1+" group by cm.tr_no UNION ALL select * from(select '' status,cm.doc_no,sm.sal_name,'' grpcode,'STC' dtype,ac.refname client,cm.reftype refert,cm.refno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.fromdt sdate,cm.todt edate,0 cval, '' site from cm_staffcontrm cm left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm'   left join my_salm sm on ac.sal_id=sm.doc_no  where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest11+" "+sqltest+")a  where 1=1  "+sqltest2+" group by a.doc_no UNION ALL select * from(select '' status,cm.doc_no,sm.sal_name,'' grpcode,'AMS' dtype,ac.refname client,cm.reftype refert,cm.refno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.fromdt sdate,cm.todt edate,0 cval, cs.site from cm_amscontrm cm left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm'     left join (select group_concat(distinct site) site,rdocno from gl_enqsited group by rdocno) cs on cs.rdocno=cm.doc_no   left join my_salm sm on ac.sal_id=sm.doc_no  where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest11+" "+sqltest+" )a  where 1=1  "+sqltest2+" group by a.doc_no";
								//System.out.println("gridload+++======"+sqldata);
			
			resultSet= stmt.executeQuery (sqldata);
			    RESULTDATA=cm.convertToJSON(resultSet);
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
	
	
	public  JSONArray loadGridExcel(String fromdate,String todate,String rds,String barchval,String clientid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqltest1="",sqltest2="",sqltest11="",sqltest12="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	    	
	    	

			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest11+=" and ac.cldocno="+clientid+" ";
	       		  
			}
		if(!rds.equalsIgnoreCase("")){
					sqltest1+=" and cm.dtype='"+rds+"' ";  
					sqltest2+=" and a.dtype='"+rds+"' ";     
				}
		String sqldata="select case when cm.jbaction='0' then 'Open' when cm.jbaction='1' then 'Hold'  when   cm.jbaction='2' then 'Closed' when   cm.jbaction='3' then 'Completed' when  cm.jbaction='4' then 'Started' else '' end as Status,cm.doc_no,sm.sal_name,cs.grpcode,cm.dtype,ac.refname client,cm.ref_type refert,cm.refdocno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.validfrom sdate,cm.validupto edate,round(cm.contractval,2) cval,cs.site from cm_srvcontrm cm left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join (select group_concat(distinct site) site,group_concat(distinct grpcode) grpcode,tr_no from cm_srvcsited cs left join cm_serteamm mm on cs.srvteamno=mm.doc_no group by cs.tr_no)cs on cs.tr_no=cm.tr_no   left join my_salm sm on ac.sal_id=sm.doc_no  where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+" "+sqltest11+" "+sqltest1+" group by cm.tr_no UNION ALL select * from(select '' status,cm.doc_no,sm.sal_name,'' grpcode,'STC' dtype,ac.refname client,cm.reftype refert,cm.refno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.fromdt sdate,cm.todt edate,0 cval, '' site from cm_staffcontrm cm left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm'   left join my_salm sm on ac.sal_id=sm.doc_no  where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest11+" "+sqltest+")a  where 1=1  "+sqltest2+" group by a.doc_no UNION ALL select * from(select '' status,cm.doc_no,sm.sal_name,'' grpcode,'AMS' dtype,ac.refname client,cm.reftype refert,cm.refno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.fromdt sdate,cm.todt edate,0 cval, cs.site from cm_amscontrm cm left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm'     left join (select group_concat(distinct site) site,rdocno from gl_enqsited group by rdocno) cs on cs.rdocno=cm.doc_no   left join my_salm sm on ac.sal_id=sm.doc_no  where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest11+" "+sqltest+" )a  where 1=1  "+sqltest2+" group by a.doc_no";
			//System.out.println("************"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToEXCEL(resultSet);
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

	public JSONArray accountDetails(String type,String account,String partyname,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtClient = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.cldocno doc_no,t.account,t.description from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ " where a.dtype='crm' and a.status<>7  "+sql;
				
				ResultSet resultSet1 = stmtClient.executeQuery(sql);
				
				RESULTDATA1=cm.convertToJSON(resultSet1);
				
				stmtClient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}