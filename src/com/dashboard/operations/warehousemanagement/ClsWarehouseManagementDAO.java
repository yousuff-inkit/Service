package com.dashboard.operations.warehousemanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsWarehouseManagementDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	public JSONArray getFloorData(String id) throws SQLException{                       
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			String sql1="",sql2="";
			int i=1;
			for(i=1;i<=20;i++) {
				sql1+=",convert(if(b.srno="+i+",concat(b.doc_no,' ## ',b.name , ' ## ', if(coalesce(wh.qty,0)<=0,'E','F') ),''),char(100)) bin"+i+"";  
				sql2+=",max(bin"+i+") bin"+i+"";    
			}  
			
			String strsql="select floor, rack, qty"+sql2+" from (select f.name floor,r.name rack,wh.qty"+sql1+" from my_flbin b left join my_flrack r on r.doc_no=b.rck_id "  
					+ "left join my_floor f on f.doc_no=b.fl_id left join (select binid,sum(qty) qty from my_whm group by binid) wh on wh.binid=b.doc_no ) a group by floor,rack";
			System.out.println("MainData--->>>"+strsql);                                                             
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
	public JSONArray getStoringData(String id) throws SQLException{                    
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql ="select * from(select coalesce(m.bhno,'') bhno,coalesce(m.jdeno,'') jdeno,round((d.qty-d.binqty),2) balqty,mm.brhid rbrhid,mm.doc_no rdocno,mm.dtype rdtype,d.psrno,mm.voc_no,mm.date,m.part_no productid,m.productname,m.part_no proid ,d.qty,d.prdId prodoc, u.unit "
			 		+ " from  my_grnm  mm left join my_grnd d  on mm.tr_no=d.tr_no	left join my_head h on h.doc_no=mm.acno left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no"
			 		+ " where mm.status<>7 union all select coalesce(m.bhno,'') bhno,coalesce(m.jdeno,'') jdeno,round((d.qty-d.binqty),2) balqty,mm.brhid rbrhid,mm.doc_no rdocno,mm.dtype rdtype,d.psrno,mm.voc_no,mm.date, "
						+ " m.part_no productid,m.productname,m.part_no proid ,  "
						+ " d.qty,d.prdId prodoc, u.unit from  my_delrm  mm left join my_delrd d  on mm.doc_no=d.rdocno " 
			            + " left join my_head h on h.doc_no=mm.acno left join my_prddin dd "
			            + " on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "
			            + " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on "
			            + " d.unitid=u.doc_no where mm.status=3)a where a.balqty>0";
			//System.out.println("StoringData--->>>"+strsql);                                                                 
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
	
	public JSONArray getPickingData(String id) throws SQLException{                    
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql ="select * from(select coalesce(m.bhno,'') bhno,coalesce(m.jdeno,'') jdeno,round((d.qty-d.binqty),2) balqty,mm.brhid rbrhid,mm.doc_no rdocno,mm.dtype rdtype,d.psrno,mm.voc_no,mm.date,m.part_no productid,m.productname,m.part_no proid ,d.qty,d.prdId prodoc, u.unit "
			 		+ " from  my_grrm  mm left join my_grrd d  on mm.tr_no=d.tr_no	left join my_head h on h.doc_no=mm.acno left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no"
			 		+ " where mm.status<>7 union all select coalesce(m.bhno,'') bhno,coalesce(m.jdeno,'') jdeno,round((d.qty-d.binqty),2) balqty,mm.brhid rbrhid,mm.doc_no rdocno,mm.dtype rdtype,d.psrno,mm.voc_no,mm.date, "
						+ " m.part_no productid,m.productname,m.part_no proid ,  "
						+ " d.qty,d.prdId prodoc, u.unit from  my_delm  mm left join my_deld d  on mm.doc_no=d.rdocno " 
			            + " left join my_head h on h.doc_no=mm.acno left join my_prddin dd "
			            + " on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "
			            + " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on "
			            + " d.unitid=u.doc_no where mm.status=3)a where a.balqty>0";    
			//System.out.println("PickingData--->>>"+strsql);                                                                 
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
	public JSONArray getPickingSubData(String id,String prodoc,String psrno,String rdocno,String rdtype) throws SQLException{                    
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql ="select * from(select coalesce(mm.bhno,'') bhno,coalesce(mm.jdeno,'') jdeno,mm.part_no productid,mm.productname,sum(m.qty) binqty,f.name floor,r.name rack,b.name bin,m.binid from my_whm m left join my_flbin b on b.doc_no=m.binid left join my_flrack r on r.doc_no=b.rck_id left join my_floor f on f.doc_no=b.fl_id left join my_main mm on mm.doc_no=m.prdid where m.prdid='"+prodoc+"' and m.psrno='"+psrno+"' group by m.binid)a where a.binqty>0";  
			//System.out.println("PickingsubData--->>>"+strsql);                                                                          
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
	public JSONArray getTransferData(String id) throws SQLException{                      
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql ="select * from(select coalesce(mm.bhno,'') bhno,coalesce(mm.jdeno,'') jdeno,m.binid,sum(m.qty) qty,sum(m.qty) balqty,m.rbrhid,m.rdocno,m.rdtype,m.psrno,m.prdid prodoc,mm.part_no productid,mm.productname,b.name bin from my_whm m left join my_main mm on mm.doc_no=m.prdid left join my_flbin b on b.doc_no=m.binid group by m.prdid,m.binid)a where a.qty>0";    
			//System.out.println("TransferData--->>>"+strsql);                                                                 
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
	public JSONArray getProductData(String id) throws SQLException{                          
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql ="select * from(select coalesce(mm.bhno,'') bhno,coalesce(mm.jdeno,'') jdeno,mm.part_no productid,mm.productname,sum(m.qty) qty,f.name floor,r.name rack,b.name bin from my_whm m left join my_flbin b on b.doc_no=m.binid left join my_flrack r on r.doc_no=b.rck_id left join my_floor f on f.doc_no=b.fl_id left join my_main mm on mm.doc_no=m.prdid where 1=1 group by m.prdid,m.binid)a where a.qty>0";	
			//System.out.println("MainData--->>>"+strsql);                                                               
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
	public JSONArray getBinDetails(String binid,String id) throws SQLException{                            
		JSONArray data=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){       
			return data;         
		}
		Connection conn=null; 
		try{  
			conn=ClsConnection.getMyConnection();     
			Statement stmt=conn.createStatement();               
			        
			String strsql ="select * from(select coalesce(mm.bhno,'') bhno,coalesce(mm.jdeno,'') jdeno,mm.part_no productid,mm.productname,sum(m.qty) qty,f.name floor,r.name rack,b.name bin from my_whm m left join my_flbin b on b.doc_no=m.binid left join my_flrack r on r.doc_no=b.rck_id left join my_floor f on f.doc_no=b.fl_id left join my_main mm on mm.doc_no=m.prdid where m.binid='"+binid+"' group by m.prdid,m.binid)a where a.qty>0";	
			//System.out.println("BinData--->>>"+strsql);                                                                  
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
