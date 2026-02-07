package com.dashboard.skips.tippingdetailsimport;

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

public class ClsTippingDetailsImportDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cmn=new ClsCommon();
	
	public JSONArray tippingData(HttpSession session,int id,String brhid) throws SQLException { 
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
            String sql="select if(m.tipping='YES' and coalesce(m.skipsize,'')!='' and coalesce(st.doc_no,0)=0,1,0) valid1,coalesce(disposalfee,0) rate,if(m.tipping='YES' and coalesce(m.wastetype,'')!='' and coalesce(dm.wastetypeid,0)=0,1,0) valid,m.contno, m.oldcontno, m.dono, date_format(m.dodate,'%d.%m.%Y') dodate, m.visitno qty, m.wastetype, m.skipsize, m.brhid,coalesce(dm.wastetypeid,0) wastetypeid,coalesce(st.doc_no,0) skipsizeid,m.weight,m.price from sk_tippingdetexcel m left join sk_dumptypedet dm on upper(replace(dm.wastename,' ',''))=upper(replace(m.wastetype,' ','')) left join sk_skiptype st on upper(replace(st.name,' ',''))=upper(replace(m.skipsize,' ','')) left join sk_tippingtariff tt on tt.wastetypeid=dm.wastetypeid and tt.skipsizeid=st.doc_no where 1=1 "+sqltest+"  group by m.doc_no";
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
