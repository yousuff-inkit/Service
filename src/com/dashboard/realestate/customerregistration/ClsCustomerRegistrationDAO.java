package com.dashboard.realestate.customerregistration;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsCustomerRegistrationDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	public JSONArray getRegistrationData(String id,String fromdate,String todate) throws SQLException{                        
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{   
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			 java.sql.Date sqlfromdate = null;
		     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
		     	{
		     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		     	}
		     	java.sql.Date sqltodate = null;
		     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
		     	{
		     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		     	}
			String strsql="select m.doc_no docno, m.name, mob, email, type, roomno, p.purpose, date_format(date,'%d.%m.%Y') date, time, s.name status from rl_guestregm m left join rl_purposem p on p.doc_no=m.visit  left join rl_regstatus s on s.doc_no=m.sdocno where m.status<>7 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			System.out.println("RentalData--->>>"+strsql);                                                                
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
