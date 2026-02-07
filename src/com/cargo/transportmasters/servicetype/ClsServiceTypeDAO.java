package com.cargo.transportmasters.servicetype;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.salesmanmaster.staff.ClsStaffBean;

public class ClsServiceTypeDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	ClsServiceTypeBean servicebean=new ClsServiceTypeBean();
	Connection conn;
	
	public int insert( int docno,String servicetype,Date sqlServiceDate,String cmbmode,String cmbsubmode,String cmbshipment,String mode,HttpSession session,String formdetailcode,String inaccid,String exaccid,String chktax,int seqno) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
			CallableStatement stmtService = conn.prepareCall("{call cr_serviceTypeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			System.out.println("cmbmode"+cmbmode);

			stmtService.registerOutParameter(10, java.sql.Types.INTEGER);
			stmtService.setString(1,servicetype);
			stmtService.setDate(2, sqlServiceDate);
			stmtService.setInt(3, Integer.parseInt(cmbmode));
			stmtService.setInt(4,Integer.parseInt(cmbsubmode));
			stmtService.setString(5,session.getAttribute("USERID").toString());
			stmtService.setString(6,session.getAttribute("BRANCHID").toString());
			stmtService.setInt(7,Integer.parseInt(cmbshipment));
			stmtService.setString(8, mode);
			stmtService.setString(9, formdetailcode);
			stmtService.setInt(11, Integer.parseInt(inaccid));
			stmtService.setInt(12, Integer.parseInt(exaccid));
			stmtService.setInt(13, Integer.parseInt(chktax));
			stmtService.setInt(14, seqno);
			stmtService.executeQuery();
			System.out.println("cmbmode"+cmbmode);
			
			
			docno=stmtService.getInt("docNo");
			servicebean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtService.close();
		        return docno;
			}
		  conn.close();
		}catch(Exception e){	
			 e.printStackTrace();
			 conn.close();
			 return 0;	
		}finally{
			conn.close();
		}
		return 0;
	   }
	
	public int edit( int docno,String servicetype,Date sqlServiceDate,String cmbmode,String cmbsubmode,String cmbshipment,String mode,HttpSession session,String formdetailcode,String inaccid,String exaccid,String chktax,int seqno) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
			CallableStatement stmtService = conn.prepareCall("{call cr_serviceTypeDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmtService.setInt(10, docno);
			stmtService.setString(1,servicetype);
			stmtService.setDate(2, sqlServiceDate);
			stmtService.setInt(3, Integer.parseInt(cmbmode));
			stmtService.setInt(4,Integer.parseInt(cmbsubmode));
			stmtService.setString(5,session.getAttribute("USERID").toString());
			stmtService.setString(6,session.getAttribute("BRANCHID").toString());
			stmtService.setInt(7,Integer.parseInt(cmbshipment));
			stmtService.setString(8, mode);
			stmtService.setString(9, formdetailcode);
			stmtService.setInt(11, Integer.parseInt(inaccid));
			stmtService.setInt(12, Integer.parseInt(exaccid));
			stmtService.setInt(13, Integer.parseInt(chktax));
			stmtService.setInt(14, seqno);
			stmtService.executeQuery();
			docno=stmtService.getInt("docNo");
			servicebean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtService.close();
		        return docno;
			}
		  conn.close();
		}catch(Exception e){	
			 e.printStackTrace();
			 conn.close();
			 return 0;	
		}finally{
			conn.close();
		}
		return 0;
	   }
	public boolean delete(int docno,String servicetype,Date sqlServiceDate,String cmbmode,String cmbsubmode,String cmbshipment,String mode,HttpSession session,String formdetailcode) throws SQLException {
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			CallableStatement stmtService = conn.prepareCall("{call cr_serviceTypeDML(?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmtService.setInt(10, docno);
			stmtService.setString(1,null);
			stmtService.setDate(2, null);
			stmtService.setInt(3, 0);
			stmtService.setInt(4,0);
			stmtService.setString(5,session.getAttribute("USERID").toString());
			stmtService.setString(6,session.getAttribute("BRANCHID").toString());
			stmtService.setInt(7,0);
			stmtService.setString(8, mode);
			stmtService.setString(9, formdetailcode);
			stmtService.setInt(11, 0);
			stmtService.setInt(12, 0);
			stmtService.setInt(13, 0);
			stmtService.setInt(14, 0);
			stmtService.executeQuery();
			docno=stmtService.getInt("docNo");
			servicebean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtService.close();
				return true;
			}
		  conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
			return false;
		}finally{
			conn.close();
		}
		return false;
	}
	
	public  JSONArray getServiceTypeGrid(String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        Connection conn = null;
        
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
            	
				String strsql="SELECT m.seqno,m.tax,h.description indesc,h1.description exdesc,m.inacno,m.exacno,m.doc_no,m.modeid,coalesce(m.smodeid,0)smodeid,m.shipid,m.srvtype,m.date,mo.modename,coalesce(sm.submode,0)submode,shm.shipment FROM cr_srvtype m "
						+ "left join my_head h on m.inacno=h.doc_no and h.den=110 left join my_head h1 on m.exacno=h1.doc_no and h1.den=115 left join cr_mode mo on mo.doc_no=m.modeid left join cr_smode sm on sm.doc_no=m.smodeid left join cr_shipment shm on "
						+ "shm.doc_no=m.shipid where m.status=3";
                              System.out.println("gridqry========"+strsql);
            	ResultSet resultSet = stmt.executeQuery (strsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	public  List<ClsServiceTypeBean> list() throws SQLException {
	    List<ClsServiceTypeBean> listBean = new ArrayList<ClsServiceTypeBean>();
	    Connection conn = null;
	    
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtService = conn.createStatement();
	        	
				ResultSet resultSet = stmtService.executeQuery ("SELECT m.seqno,m.tax,h.description indesc,h1.description exdesc,m.inacno,m.exacno,m.doc_no,m.modeid,m.smodeid,m.shipid,m.srvtype,m.date,mo.modename,coalesce(sm.submode,0)submode,shm.shipment FROM cr_srvtype m left join my_head h on m.inacno=h.doc_no and h.den=110 left join my_head h1 on m.exacno=h1.doc_no and h1.den=115 left join cr_mode mo on mo.doc_no=m.modeid left join cr_smode sm on sm.doc_no=m.smodeid left join cr_shipment shm on shm.doc_no=m.shipid where m.status=3");
                System.out.println(resultSet);
				while (resultSet.next()) {
					
					ClsServiceTypeBean bean = new ClsServiceTypeBean();
	            	bean.setDocno(resultSet.getInt("doc_no"));
	            	bean.setServicedate(resultSet.getString("date"));
	            	bean.setModeid(resultSet.getInt("modeid"));
	            	bean.setCmbmode(resultSet.getString("modename"));
	            	bean.setSmodeid(resultSet.getInt("smodeid"));
	            	bean.setCmbsubmode(resultSet.getString("submode"));
	            	bean.setShipid(resultSet.getInt("shipid"));
	            	bean.setCmbshipment(resultSet.getString("shipment"));
	            	bean.setServtype(resultSet.getString("srvtype"));
	            	bean.setInaccid(resultSet.getString("inacno"));
	            	bean.setIndesc(resultSet.getString("indesc"));
	            	bean.setExaccid(resultSet.getString("exacno"));
	            	bean.setExdesc(resultSet.getString("exdesc"));
	            	bean.setChkhidtax(resultSet.getString("tax"));
	            	bean.setSeqno(resultSet.getInt("seqno"));
	            	listBean.add(bean);
				}
				stmtService.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return listBean;
	}
	public   JSONArray accountsDetailsTo(String den) throws SQLException {
		
		JSONArray RESULTDATA=new JSONArray();
		
		if((den.equalsIgnoreCase(""))){
			return RESULTDATA;
		}
		
		Connection conn=null;

	  try {
		
	    String sql="",sqltest="";
	    
	    /*if((!(accno.equalsIgnoreCase(""))) && (!(accno.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and t.account like '%"+accno+"%'  ";
		}
		if((!(accname.equalsIgnoreCase(""))) && (!(accname.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and t.description like '%"+accname+"%'";
		}
		if(!(mobileno.equalsIgnoreCase("NA"))&&!(mobileno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and a.per_mob like '%"+mobileno+"%' ";
		}*/
		
		conn= ClsConnection.getMyConnection();
	    Statement stmtCPV = conn.createStatement ();
	
	    	sql="select t.doc_no,t.account,t.description from my_head t "
	            + "where  t.den="+den+"";
	    
	    System.out.println("--inacc---sql---"+sql);
	    ResultSet resultSet = stmtCPV.executeQuery (sql);
	    RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    
	    stmtCPV.close();
	    conn.close();
	  }
	  catch(Exception e){
	   e.printStackTrace();
	   conn.close();
	  }
	        return RESULTDATA;
	    }

	}
