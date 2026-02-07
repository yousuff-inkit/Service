package com.dashboard.realestate.propertyinvoice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPropertyInvoiceDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	public JSONArray getRentalData(String id) throws SQLException{                    
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql="select a.* from(select r.invtrno,0 rowno,r.cancelstatus,s.name sub,m.name,m.brhid,m.voc_no pvocno,r.propertyid,r.propertysub,r.doc_no docno,r.remarks,DATE_FORMAT(r.fromdate,'%d.%m.%Y') fromdate,DATE_FORMAT(r.todate,'%d.%m.%Y') todate,round(r.totalval,2) totalval,ac.refname,r.voc_no,r.cldocno from rl_rental r left join my_acbook ac on ac.cldocno=r.cldocno and ac.dtype='CRM' left join rl_propertymaster m on m.doc_no=r.propertyid left join rl_propertysub s on s.propertyid=r.propertyid and coalesce(s.srno,0)=coalesce(r.propertysub,0) union all select d.invtrno,d.rowno,r.cancelstatus,s.name sub,m.name,m.brhid,m.voc_no pvocno,r.propertyid,r.propertysub,r.doc_no docno,'' remarks,DATE_FORMAT(d.prevtodate,'%d.%m.%Y') fromdate,DATE_FORMAT(d.extdate,'%d.%m.%Y') todate,round(d.totalval,2) totalval,ac.refname,r.voc_no,r.cldocno from rl_rentald d left join rl_rental r on r.doc_no=d.rdocno left join my_acbook ac on ac.cldocno=r.cldocno and ac.dtype='CRM' left join rl_propertymaster m on m.doc_no=r.propertyid left join rl_propertysub s on s.propertyid=r.propertyid and coalesce(s.srno,0)=coalesce(r.propertysub,0))a where a.cancelstatus=0 and a.invtrno=0 order by a.docno";
			//System.out.println("RentalData--->>>"+strsql);                                                             
			ResultSet rs=stmt.executeQuery(strsql);
			data=ClsCommon.convertToJSON(rs);  
		}   
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
}
