package com.dashboard.client.clientmgmt;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;


 
public class ClsClientManagementDAO

{
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray clientListGridLoading(String check) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;  
		
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCRM = conn.createStatement ();   
			    
			    ResultSet resultSet = stmtCRM.executeQuery ("SELECT cl.brhid,cl.sal_id,cl.cldocno,cl.date date,cl.codeno code,cl.acno acno,category,h.description accgroup,cl.period2 crmaxdays,cl.per_tel tel,ar.area area,cl.bnkcity city,cn.country_name country,refname,per_mob,sal_name,concat(coalesce(address,''),'  ',coalesce(address2,'')) as address,mail1,"
			    		+ "period crdprd,credit crdlmt,tinno trnnumber FROM my_acbook CL left JOIN "
			    		+ "my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no left join my_head h on h.doc_no=cat.acc_group and h.dtype='CRM' left join my_area ar on ar.doc_no=cl.area_id left join my_acountry cn on cn.doc_no=cl.bnkcountryid  where cl.dtype='CRM' and cl.status=3 order by cl.cldocno");
			    
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCRM.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
}




