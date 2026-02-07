package com.dashboard.cargo.jobanalysis;         

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsJobAnalysisDAO {   
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon =new ClsCommon();
	
	
	public   JSONArray loadSumData(String fromdate,String todate,String type,String id) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){   
	    	return data;
	    }   
	    String sqltest="",sql1="",sql2="",sql3="";   
	    java.sql.Date sqltodate = null;
	    java.sql.Date sqlfromdate = null;
     	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	        }
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);    
	        }
			if(sqltodate!=null && sqlfromdate!=null){
				sqltest=sqltest+" and sc.date between '"+sqlfromdate+"' and '"+sqltodate+"'";          
			}
			if(type.equalsIgnoreCase("1")){
				sql1="ac.refname";
				sql2="left join my_acbook ac on (ac.cldocno=sc.cldocno and ac.dtype='CRM')";   
				sql3="group by sc.cldocno";  
			}else if(type.equalsIgnoreCase("2")){
				sql1="sal.sal_name";
				sql2="left join my_acbook ac on (ac.cldocno=sc.cldocno and ac.dtype='CRM') left join my_salm sal on sal.doc_no=ac.sal_id";   
				sql3="group by sal.doc_no";     
			}else if(type.equalsIgnoreCase("3")){
				sql1="concat(month(sc.date),'/',year(sc.date))";
				sql2="";   
				sql3="group by month(sc.date),year(sc.date)";     
			}else if(type.equalsIgnoreCase("4")){
				sql1="md.modename";
				sql2="left join cr_mode md on md.doc_no=ed.modeid";   
				sql3="group by md.doc_no";     
			}else if(type.equalsIgnoreCase("5")){
				sql1="sm.submode";
				sql2="left join cr_smode sm on sm.doc_no=ed.smodeid";   
				sql3="group by sm.doc_no";     
			}else if(type.equalsIgnoreCase("6")){
				sql1="sp.shipment";
				sql2="left join cr_shipment sp on sp.doc_no=ed.shipid";   
				sql3="group by sp.doc_no";     
			}else if(type.equalsIgnoreCase("7")){
				sql1="concat('Job No-',m.confirm_no,' ,Job refno-',m.confirm_refno,' ,Job date-',date_format(m.confirm_date ,'%d.%m.%Y')) ";
				sql2="left join cr_qotm m on m.rrefno=em.doc_no and m.reftype='ENQ'";   
				sql3="group by m.confirm_no";     
			}else{
				sql1="";   
				sql2="";
				sql3="";                    
			}
			String sql="";   
			if(type.equalsIgnoreCase("8")){      
				 sql="select cast(refdetails  as char(200)) refdetails,revenue,expense,coalesce(revenue-expense,0) margin,coalesce((coalesce(revenue-expense,0)/revenue)*100,0) marginper from(select ss.doc_no,ss.srvtype refdetails,coalesce(sum(d.tobebilled),0) revenue,0 expense from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno left join cr_qotjobd d on ed.doc_no=d.refdocno left join cr_srvtype ss on (ss.doc_no=d.typeid) where sc.status<>7  and sc.date between '2020-11-17' and '2020-12-17' group by ss.doc_no union all select ss.doc_no,ss.srvtype refdetails,0 revenue,coalesce(sum(ex.amount),0) expense from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno left join cr_expense ex on sc.tr_no=ex.rdocno left join cr_srvtype ss on (ss.doc_no=ex.srvdocno) where sc.status<>7 "+sqltest+" group by ss.doc_no)a";
			}else{
				 sql="select cast("+sql1+" as char(200)) refdetails,coalesce(sum(d.revsum),0) revenue,coalesce(sum(ex.expsum),0) expense,coalesce(coalesce(sum(d.revsum),0)-coalesce(sum(ex.expsum),0),0) margin,coalesce(((coalesce(sum(d.revsum),0)-coalesce(sum(ex.expsum),0))/coalesce(sum(d.revsum),0))*100,0) marginper from cm_srvcontrm sc "
						+ "left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on l.enqdocno=ed.doc_no "   
						+ "left join cr_enqm em on em.doc_no=ed.rdocno left join (select coalesce(sum(tobebilled),0) revsum,"
						+ "jobno refdocno from cr_qotjobd group by jobno)d on sc.tr_no=d.refdocno "
						+ "left join (select coalesce(sum(amount),0) expsum,rdocno from cr_expense group by rdocno)ex "
						+ "on sc.tr_no=ex.rdocno "+sql2+" where sc.status<>7 "+sqltest+" "+sql3+"";  
			}
			//System.out.println("Sum Query:--->>>  "+sql);	        
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
	public JSONArray loadDetData(String fromdate,String todate,String id, String chkinv) throws SQLException {
		JSONArray data=new JSONArray();
	    if(!id.equalsIgnoreCase("1")){   
	    	return data;
	    }
	    String sqltest="";  
	    java.sql.Date sqltodate = null;
	    java.sql.Date sqlfromdate = null;   
     	Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stm = conn.createStatement (); 
			if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
	     		sqltodate=objcommon.changeStringtoSqlDate(todate);
	        }
			if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);    
	        }
			if(sqltodate!=null && sqlfromdate!=null && chkinv.equalsIgnoreCase("0")){
				sqltest=sqltest+" and sc.date between '"+sqlfromdate+"' and '"+sqltodate+"'";          
			}   
			else if(sqltodate!=null && sqlfromdate!=null && chkinv.equalsIgnoreCase("0")){
				sqltest=sqltest+" and sc.date between '"+sqlfromdate+"' and '"+sqltodate+"'";          
			}
			
			String sql="select sc.doc_no voc_no,em.voc_no enqno,ac.refname client,m.confirm_no confrmno,ed.pol,ed.pod,md.modename mode,sm.submode smode,"
					+ "sp.shipment,m.confirm_refno confrefno,sal.sal_name salesman,sc.date jobdate,m.voc_no qvocno,m.confirm_date confrmdate"
					+ ",coalesce(d.revsum,0) revenue,coalesce(ex.expsum,0) expense,coalesce(coalesce(d.revsum,0)-coalesce(ex.expsum,0),0) margin,coalesce(((coalesce(d.revsum,0)-coalesce(ex.expsum,0))/coalesce(d.revsum,0))*100,0) marginper from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on "
					+ "l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno  left join cr_qotm m on m.rrefno=em.doc_no and m.reftype='ENQ' "
					+ "left join my_acbook ac on ac.cldocno=sc.cldocno and ac.dtype='CRM' left join cr_shipment sp on sp.doc_no=ed.shipid "
					+ "left join cr_mode md on md.doc_no=ed.modeid left join cr_smode sm on sm.doc_no=ed.smodeid left join my_salm sal on sal.doc_no=ac.sal_id "
					+ "left join (select coalesce(sum(tobebilled),0) revsum,jobno refdocno from cr_qotjobd group by jobno) d on sc.tr_no=d.refdocno "
					+ "left join (select coalesce(sum(amount),0) expsum,rdocno from cr_expense group by rdocno)ex on sc.tr_no=ex.rdocno where sc.status<>7 "+sqltest+" group by sc.tr_no";  
		    System.out.println("list Query:--->>>  "+sql);      	        
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
}
