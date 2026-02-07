package com.cargo.place;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.aviation.port.ClsPortBean;
import com.connection.ClsConnection;

public class ClsPlaceDAO {
	ClsConnection conobj=new ClsConnection();
	Connection conn=conobj.getMyConnection();
	ClsPlaceBean placeBean = new ClsPlaceBean();
	
public int insert(ClsPlaceBean bean,HttpSession session){
		
		
		try{
			int aaa;
			System.out.println("ClsPlaceBean");
			CallableStatement stmtplace = conn.prepareCall("{CALL PlaceDML(?,?,?,?,?,?,?,?)}");
			stmtplace.registerOutParameter(7,java.sql.Types.INTEGER);
//			stmtplace.setInt(5, 1);
			stmtplace.setString(1,bean.getCode().toString());	
			stmtplace.setString(2,bean.getName().toString());
			stmtplace.setString(3,bean.getCmbcountry().toString());
			stmtplace.setDate(4,(Date) bean.getPlaceDate());
			stmtplace.setString(5,session.getAttribute("USERID").toString());
			stmtplace.setString(6,session.getAttribute("BRANCHID").toString());
			stmtplace.setString(8,bean.getMode());
			System.out.println("test for CallableStatement "+stmtplace);
			int val = stmtplace.executeUpdate();
			aaa=stmtplace.getInt("docNo");
			System.out.println(aaa);
			placeBean.setDocno(aaa);
			stmtplace.close();
			conn.close();
			if (val > 0) {
				System.out.println("Sucess"+placeBean.getDocno());
				return aaa;
			}
		
		}catch(Exception e){	
			e.printStackTrace();	
			}
		
		return 0;
	}
	
	public boolean edit(ClsPlaceBean bean,HttpSession session){
		try{
			int aaa;
			CallableStatement stmtplace = conn.prepareCall("{CALL PlaceDML(?,?,?,?,?,?,?,?)}");
			
//			stmtregion.registerOutParameter(5, java.sql.Types.INTEGER);
			stmtplace.setString(1,bean.getCode().toString());	
			stmtplace.setString(2,bean.getName().toString());
			stmtplace.setString(3,bean.getCmbcountry().toString());
			stmtplace.setDate(4,(Date) bean.getPlaceDate());
			stmtplace.setString(5,session.getAttribute("USERID").toString());
			stmtplace.setString(6,session.getAttribute("BRANCHID").toString());
			stmtplace.setInt(7,bean.getDocno());
			stmtplace.setString(8,bean.getMode());
			stmtplace.executeUpdate();
			System.out.println("test for CallableStatement edit "+stmtplace);
			aaa=stmtplace.getInt("docNo");
			System.out.println(aaa);
			placeBean.setDocno(aaa);
			stmtplace.close();
			conn.close();
			
			if (aaa > 0) {
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){	
			e.printStackTrace();	
			}
		
		return false;
	}
	public boolean delete(ClsPlaceBean bean,HttpSession session) {
		try{
			int aaa;
			CallableStatement stmtplace = conn.prepareCall("{CALL PlaceDML(?,?,?,?,?,?,?,?)}");
			stmtplace.setString(1,null);
			stmtplace.setDate(2,null);
			stmtplace.setString(3,null);
			stmtplace.setDate(4,null);
			stmtplace.setString(5,session.getAttribute("USERID").toString());
			stmtplace.setString(6,session.getAttribute("BRANCHID").toString());
			stmtplace.setInt(7,bean.getDocno());
			stmtplace.setString(8,bean.getMode());
			stmtplace.executeUpdate();
			aaa=stmtplace.getInt("docNo");
			placeBean.setDocno(aaa);
			stmtplace.close();
			conn.close();
			if (aaa > 0) {
				System.out.println("Sucess");
				return true;
			}	
		
		
          }catch(Exception e){
			
		}
		return false;
	 }

	
	 public  List<ClsPlaceBean> list() throws SQLException {
	        List<ClsPlaceBean> listBean = new ArrayList<ClsPlaceBean>();
			try {
					Connection conn = conobj.getMyConnection();
				Statement stmtPort =conn.createStatement();            	
					ResultSet resultSet = stmtPort.executeQuery ("select n.nation,place, c.DOC_NO,DATE,code,country_id from aa_cargoplace c left join my_natm n on c.country_id=n.doc_no where status<>7");

					while (resultSet.next()) {
						
						ClsPlaceBean bean = new ClsPlaceBean();
		            	bean.setDocno(resultSet.getInt("DOC_NO"));
						bean.setCode(resultSet.getString("code"));
						bean.setName(resultSet.getString("place"));
						bean.setCmbcountry(resultSet.getString("country_id"));
						bean.setPlaceDate(resultSet.getDate("DATE"));
						bean.setSrchcountry(resultSet.getString("nation"));
		            	listBean.add(bean);
//		            	System.out.println(listBean);
					}
			}
			catch(Exception e){
				e.printStackTrace();
			}
//	//System.out.println("nitin===="+listBean);
	        return listBean;
	    }
}
