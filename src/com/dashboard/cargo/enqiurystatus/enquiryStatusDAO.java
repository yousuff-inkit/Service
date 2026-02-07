package com.dashboard.cargo.enqiurystatus;


import java.sql.Connection;
import java.sql.Date;
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
import java.util.Properties;
import java.util.Set;
import java.util.Vector;
import java.util.concurrent.TimeUnit;

public class enquiryStatusDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon objcommon=new ClsCommon();
	public   JSONArray loadDetData(String fromdate,String todate,String brhid,String rds,String id) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){   
	    	return data;
	    }
	    String sqltest="";  
	    java.sql.Date sqltodate = null;
	    java.sql.Date sqlfromdate = null;
     	Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stm = conn.createStatement (); 
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	        }
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);    
	        }
			if(sqltodate!=null && sqlfromdate!=null){
				sqltest=sqltest+" and em.date between '"+sqlfromdate+"' and '"+sqltodate+"'";          
			}
			if(rds.equalsIgnoreCase("1")){
				sqltest=sqltest+" and q.doc_no is null";                                                  
			} else if(rds.equalsIgnoreCase("2")){
				sqltest=sqltest+" and q.doc_no is not null and q.confirm=0 ";                                                  
			} else if(rds.equalsIgnoreCase("3")){
				sqltest=sqltest+" and q.doc_no is not null and q.confirm=1 and jl.jobno is null ";                                                  
			} else if(rds.equalsIgnoreCase("4")){
				sqltest=sqltest+" and q.doc_no is not null and q.confirm=1 and jl.jobno is not null and docstatus is null ";                                                  
			}  else if(rds.equalsIgnoreCase("5")){
				sqltest=sqltest+" and cm.docstatus ='Advance Paid'";                                                  
			} else if(rds.equalsIgnoreCase("6")){
				sqltest=sqltest+" and cm.docstatus ='Job settled'";                                                  
			}
			
			
			String sql=("select ac.refname,em.voc_no,m.submode chkmode,d.polid,d.podid,m.modename mode,d.modeid,sm.submode,d.smodeid,sh.shipment,"
        			+ " d.shipid,d.shipid shipmentid,d.termsid termid,t.terms,d.modeid,origin orgin,pol,pod,commodity comodity,"
        			+ " wight weight,noofpacks,dimension,volume,d.remarks,qty"
        			+ " from cr_enqm em left join cr_enqd d on em.doc_no=d.rdocno left join cr_mode m on m.doc_no=d.modeid "
        			+ " left join cr_smode sm on sm.doc_no=d.smodeid "             
        			+ " left join cr_shipment sh on sh.doc_no=d.shipid left join my_acbook ac on ac.cldocno=em.cldocno and ac.dtype='CRM'"    
        			+ " left join cr_terms t on t.doc_no=d.termsid left join cr_qotm q on (q.rrefno=em.doc_no and q.reftype='ENQ') "
        			+ " left join cr_joblist jl on jl.enqdocno=d.doc_no  left join cm_srvcontrm cm on jl.jobno=cm.tr_no  where em.status<>7 "+sqltest+"");   
//			System.out.println(rds+ " list Query:--->>>  "+sql);	        
            ResultSet resultSet = stm.executeQuery(sql);       
            data=objcommon.convertToJSON(resultSet);
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();           
		}
		finally{
			conn.close();
		}
		// System.out.println(data);
        return data;
    }

	
	public JSONArray getStatusCount(String fromdate,String todate,String barchval) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null,resultSetperc=null;
		String sqltest="";
		
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sdate=objcommon.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date edate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		edate=objcommon.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
			if(!barchval.equalsIgnoreCase("a"))
        	{
				sqltest+=" and e.brhid="+barchval;
        	}
			int percount=0;	
			/*String sqlperc="select count(*) cnt from cm_srvqotm cq where cq.date between '"+sdate+"' and '"+edate+"' "+sqltest+" ";
			resultSetperc = stmt.executeQuery (sqlperc);
			
			while(resultSetperc.next()){
				
				percount=resultSetperc.getInt("cnt");
			}*/
			String sqldata=" select count(*) val,substring(status,2,length(status)) stat,substring(status,1,1) rds from (select if(q.doc_no is null, '1Entered',if(q.doc_no is not null and q.confirm=0,'2Quoted', "
					+ " if(q.doc_no is not null and q.confirm=1 and jl.jobno is null,'3Quote Approved/Job Created', "
					+ " if(q.doc_no is not null and q.confirm=1 and jl.jobno is not null and docstatus is null ,'4Sub Job Created',concat(if(docstatus='Advance Paid',5,6),docstatus))))) status from cr_enqm e left join cr_enqd ed on e.doc_no=ed.rdocno "
					+ " left join cr_qotm q on q.rrefno=e.doc_no and q.status=3  left join cr_joblist jl on jl.enqdocno=ed.doc_no left join cm_srvcontrm cm on jl.jobno=cm.tr_no where e.status=3 "
					+ " and e.date between '"+sdate+"' and '"+edate+"'  "+sqltest+" ) a group by status ";
			
		
//		System.out.println("====qot status=="+sqldata);
			resultSet = stmt.executeQuery (sqldata);
			RESULTDATA=objcommon.convertToJSON(resultSet);
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