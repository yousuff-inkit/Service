package com.dashboard.project.jobwisedivision;

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

public class ClsJobWiseDivisionDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	public  JSONArray loadGridData(String fromdate,String todate,String rds,String barchval,String clientid,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     	}else{}
	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     	}else{}
			if(barchval.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+barchval;
			}
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and ac.cldocno="+clientid+" ";
	       	}
			if(rds.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(rds.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
				
		String sqldata="select cm.tr_no,case when cm.jbaction='0' then 'Open' when cm.jbaction='1' then 'Hold'  when   cm.jbaction='2' then 'Closed' when   cm.jbaction='3' then 'Completed' when  cm.jbaction='4' then 'Started' else '' end as Status,"
				+ "cm.doc_no,sm.sal_name,mm.grpcode,cm.dtype,ac.refname client,cm.ref_type refert,cm.refdocno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.validfrom sdate,"
				+ "cm.validupto edate,round(cm.contractval,2) cval, convert(group_concat(cs.site),char(200)) site,round(cm.legalchrg,2) lfee from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
				+ " left join my_salm sm on ac.sal_id=sm.doc_no left join cm_serteamm mm on cs.srvteamno=mm.doc_no where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+" group by cm.tr_no ";
		   
		//System.out.println("******++******"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			    RESULTDATA=cm.convertToJSON(resultSet);

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
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
				
			String sqldata="select a.doc_no,cast(budget as decimal(15,2)) budget,name  from(select rdocno doc_no,round(budget,2) budget,cm.name from cm_subdivm m left join cm_subdivision cm on cm.doc_no=m.rdocno and cm.status=3 where m.jobdocno="+jobdocno+" union all select doc_no,'' budget,name from cm_subdivision  where status=3)a group by a.doc_no";   
			//System.out.println("******++******"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			    RESULTDATA=cm.convertToJSON(resultSet);

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