package com.dashboard.realestate.propertymanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPropertyManagementDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	public JSONArray loadsplitGrid(String id,String docno) throws SQLException{     
		JSONArray data=new JSONArray();                          
		Connection conn=null; 
		 java.sql.Date edates = null;     
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();     
			        
			String strsql="select rowno,name,remarks,srno,status from rl_propertysub where propertyid='"+docno+"'";                        
			//System.out.println("splitGrid--->>>"+strsql);                                         
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
	public JSONArray getRentalData(String id,String docno,String srno) throws SQLException{                 
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();     
			        
			String strsql="select r.remarks,DATE_FORMAT(r.fromdate,'%d.%m.%Y') fromdate,DATE_FORMAT(r.todate,'%d.%m.%Y') todate,round(r.totalval,2) totalval,ac.refname from rl_rental r left join my_acbook ac on ac.cldocno=r.cldocno where r.propertyid='"+docno+"' and r.propertysub='"+srno+"' and r.cancelstatus=0";                    
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
	public JSONArray getRentalCancelData(String id,String docno,String srno) throws SQLException{                 
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql="select r.doc_no docno,'Cancel' cancelbtn,r.remarks,DATE_FORMAT(r.fromdate,'%d.%m.%Y') fromdate,DATE_FORMAT(r.todate,'%d.%m.%Y') todate,round(r.totalval,2) totalval,ac.refname from rl_rental r left join my_acbook ac on ac.cldocno=r.cldocno where r.propertyid='"+docno+"' and r.propertysub='"+srno+"' and r.cancelstatus=0";                    
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
	public JSONArray getPropertyData(String id,String year,String month) throws SQLException {     
		JSONArray RESULTDATA=new JSONArray();     
		if(id.equalsIgnoreCase("0")){
			return RESULTDATA;
		}
		Connection conn = null;
		String strsql="";
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();     
			 if(id.equalsIgnoreCase("2")){              
				 strsql="select coalesce(rd.rowno,0) rtlrowno,coalesce(s.srno,0) srno,s.name sub,m.voc_no vocno,m.doc_no docno,m.brhid,m.unitno,"
				 		+ "m.desc1,m.name,day1, day2, day3, day4, day5, day6, day7, day8, day9, day10, day11, day12, day13, day14, day15, day16, day17,"
				 		+ " day18, day19, day20, day21, day22, day23, day24, day25, day26, day27, day28, day29, day30, day31 from rl_propertymaster m "
				 		+ "left join rl_propertysub s on (s.propertyid=m.doc_no and s.status<>7)  left join rl_rentaldays rd on (rd.propertyid=m.doc_no and "
				 		+ "coalesce(s.srno,0)=coalesce(rd.propertysrno,0) and rd.month="+month+" and rd.year="+year+") where m.status<>7 and m.cnt_type is null and m.cnt_no>0"; 
			 }else{
				 strsql="select coalesce(rd.rowno,0) rtlrowno,coalesce(s.srno,0) srno,s.name sub,m.voc_no vocno,m.doc_no docno,m.brhid,m.unitno,m.desc1,m.name,day1,"
				 		+ " day2, day3, day4, day5, day6, day7, day8, day9, day10, day11, day12, day13, day14, day15, day16, day17, day18, day19, day20, day21, day22,"
				 		+ " day23, day24, day25, day26, day27, day28, day29, day30, day31 from rl_propertymaster m left join rl_propertysub s on (s.propertyid=m.doc_no and s.status<>7)"
				 		+ "  left join rl_rentaldays rd on (rd.propertyid=m.doc_no and coalesce(s.srno,0)=coalesce(rd.propertysrno,0) and rd.month="+month+" "
				 		+ "and rd.year="+year+") where m.status<>7";         
			 }
			//System.out.println("strsql---->>>"+strsql);             
			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray searchclient() throws SQLException {         
		JSONArray RESULTDATA=new JSONArray();     
		Connection conn = null;
		try {
			 conn = ClsConnection.getMyConnection();
			 Statement stmt = conn.createStatement();                
			 String strsql="select cldocno,refname,acno clacno from my_acbook  where dtype='CRM' and status<>7"; 
			//System.out.println("strsql---->>>"+strsql);
			ResultSet resultSet = stmt.executeQuery(strsql);     
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
}
