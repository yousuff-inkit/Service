package com.dashboard.cargo.enquirylist;         

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsEnquiryListDAO {   
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon =new ClsCommon();
	
	
	public   JSONArray loadSumData(String fromdate,String todate,String id) throws SQLException {
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
			if(sqltodate!=null && sqlfromdate!=null){
				sqltest=sqltest+" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";          
			}
			String sql="select date_format(m.date,'%d-%m-%Y') date,m.doc_no,m.voc_no,m.cldocno,a.refname,"
					+ "trim(a.address) address,a.per_mob mob,trim(a.mail1) "
					+ "email,m.remarks from cr_enqm m "  
					+ "left join my_acbook a on a.cldocno=m.cldocno and a.dtype='CRM' WHERE m.status<>7 "+sqltest+"";
			//System.out.println("list Query:--->>>  "+sql);	        
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
	public   JSONArray loadDetData(String fromdate,String todate,String type,String id) throws SQLException {
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
			if(sqltodate!=null && sqlfromdate!=null){
				sqltest=sqltest+" and em.date between '"+sqlfromdate+"' and '"+sqltodate+"'";          
			}
			if(type.equalsIgnoreCase("2")){
				sqltest=sqltest+" and q.doc_no is null";                                                  
			}
			String sql=("select ac.refname,em.voc_no,m.submode chkmode,d.polid,d.podid,m.modename mode,d.modeid,sm.submode,d.smodeid,sh.shipment,"
        			+ " d.shipid,d.shipid shipmentid,d.termsid termid,t.terms,d.modeid,origin orgin,pol,pod,commodity comodity,"
        			+ " wight weight,noofpacks,dimension,volume,d.remarks,qty"
        			+ " from cr_enqm em left join cr_enqd d on em.doc_no=d.rdocno left join cr_mode m on m.doc_no=d.modeid "
        			+ " left join cr_smode sm on sm.doc_no=d.smodeid "             
        			+ " left join cr_shipment sh on sh.doc_no=d.shipid left join my_acbook ac on ac.cldocno=em.cldocno and ac.dtype='CRM'"    
        			+ " left join cr_terms t on t.doc_no=d.termsid left join cr_qotm q on (q.rrefno=em.doc_no and q.reftype='ENQ') where em.status<>7 "+sqltest+"");   
			//System.out.println("list Query:--->>>  "+sql);	        
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
