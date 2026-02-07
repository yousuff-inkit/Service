package com.dashboard.skips.callregister;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.ibm.icu.text.SimpleDateFormat;

import net.sf.json.JSONArray;

public class ClsCallRegisterDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	public JSONArray callregisterData(HttpSession session, int id, String brhid) throws SQLException { 
		JSONArray RESULTDATA=new JSONArray();
		 if(id==0) {
			 return RESULTDATA;   
		 }
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sqltest="";
            if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase("a")) {
            	sqltest=" and m.brhid='"+brhid+"'";   
            }   
            String sql="select cm.doc_no,cm.tr_no,dm.name wastetype,date_format(m.date,'%d.%m.%Y') date,m.time from sk_callregm m left join sk_srvcontrm cm on cm.tr_no=m.cnttrno left join sk_dumptype dm on dm.doc_no=m.wasteid";
            //System.out.println("======relodsql===="+sql);    
			ResultSet resultSet = stmt.executeQuery(sql);  
			RESULTDATA=cmn.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray contractDetailsSearch(int id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql = "select d.wastetype wasteid,m.tr_no,m.doc_no,ac.refname,s.site,st.name skipsize,dt.name wastetype from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_dumptype dt on dt.doc_no=d.wastetype left join sk_skiptype st on st.doc_no=d.skiptype left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join sk_srvcsited s on s.rowno=d.siteid where m.status=3 and curdate() between m.startdt and m.enddt "+sqltest+" group by m.tr_no order by m.tr_no";
		    //System.out.println("sql==="+sql);     
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=cmn.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public JSONArray wastetypeSearch(int id) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql="select name, doc_no from sk_dumptype where status=3";  
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=cmn.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
}
