package com.aviation.port;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.connection.ClsConnection;
import com.controlcentre.settings.areamaster.region.ClsRegionBean;

public class ClsPortDAO {
ClsConnection conobj=new ClsConnection();
	
	Connection conn=conobj.getMyConnection();
	ClsPortBean portBean = new ClsPortBean();
	
	public int insert(ClsPortBean bean,HttpSession session){
		
		
		try{
			int aaa;
			System.out.println("ClsPortBean");
			CallableStatement stmtport = conn.prepareCall("{CALL PortDML(?,?,?,?,?,?,?,?)}");
			stmtport.registerOutParameter(7,java.sql.Types.INTEGER);
//			stmtport.setInt(5, 1);
			stmtport.setString(1,bean.getPort().toString());	
			stmtport.setString(2,bean.getPortname().toString());
			stmtport.setString(3,bean.getCountry().toString());
			stmtport.setDate(4,(Date) bean.getPortDate());
			stmtport.setString(5,session.getAttribute("USERID").toString());
			stmtport.setString(6,session.getAttribute("BRANCHID").toString());
			stmtport.setString(8,bean.getMode());
			System.out.println("test for CallableStatement "+stmtport);
			int val = stmtport.executeUpdate();
			aaa=stmtport.getInt("docNo");
			System.out.println(aaa);
			portBean.setDocno(aaa);
			stmtport.close();
			conn.close();
			if (val > 0) {
				System.out.println("Sucess"+portBean.getDocno());
				return aaa;
			}
		
		}catch(Exception e){	
			e.printStackTrace();	
			}
		
		return 0;
	}
	
	public boolean edit(ClsPortBean bean,HttpSession session){
		try{
			int aaa;
			CallableStatement stmtport = conn.prepareCall("{CALL PortDML(?,?,?,?,?,?,?,?)}");
			
//			stmtregion.registerOutParameter(5, java.sql.Types.INTEGER);
			stmtport.setString(1,bean.getPort().toString());	
			stmtport.setString(2,bean.getPortname().toString());
			stmtport.setString(3,bean.getCountry().toString());
			stmtport.setDate(4,(Date) bean.getPortDate());
			stmtport.setString(5,session.getAttribute("USERID").toString());
			stmtport.setString(6,session.getAttribute("BRANCHID").toString());
			stmtport.setInt(7,bean.getDocno());
			stmtport.setString(8,bean.getMode());
			stmtport.executeUpdate();
			System.out.println("test for CallableStatement edit "+stmtport);
			aaa=stmtport.getInt("docNo");
			System.out.println(aaa);
			portBean.setDocno(aaa);
			stmtport.close();
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
	public boolean delete(ClsPortBean bean,HttpSession session) {
		try{
			int aaa;
			CallableStatement stmtport = conn.prepareCall("{CALL PortDML(?,?,?,?,?,?,?,?)}");
			stmtport.setString(1,null);
			stmtport.setDate(2,null);
			stmtport.setString(3,null);
			stmtport.setDate(4,null);
			stmtport.setString(5,session.getAttribute("USERID").toString());
			stmtport.setString(6,session.getAttribute("BRANCHID").toString());
			stmtport.setInt(7,bean.getDocno());
			stmtport.setString(8,bean.getMode());
			stmtport.executeUpdate();
			aaa=stmtport.getInt("docNo");
			portBean.setDocno(aaa);
			stmtport.close();
			conn.close();
			if (aaa > 0) {
				System.out.println("Sucess");
				return true;
			}	
		
		
          }catch(Exception e){
			
		}
		return false;
	 }

	
	 public  List<ClsPortBean> list() throws SQLException {
	        List<ClsPortBean> listBean = new ArrayList<ClsPortBean>();
			try {
					Connection conn = conobj.getMyConnection();
				Statement stmtPort =conn.createStatement();            	
					ResultSet resultSet = stmtPort.executeQuery ("select desc1, DOC_NO,DATE,port,country from my_port where status<>7");

					while (resultSet.next()) {
						
						ClsPortBean bean = new ClsPortBean();
		            	bean.setDocno(resultSet.getInt("DOC_NO"));
						bean.setPort(resultSet.getString("port"));
						bean.setPortname(resultSet.getString("desc1"));
						bean.setCountry(resultSet.getString("country"));
						bean.setPortDate(resultSet.getDate("DATE"));
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
