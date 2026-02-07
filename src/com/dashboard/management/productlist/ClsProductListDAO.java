package com.dashboard.management.productlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import net.sf.json.JSONArray;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsProductListDAO {
	 ClsCommon commonDAO= new ClsCommon();
	 ClsConnection connDAO =new ClsConnection();
	 Connection conn;
	 public JSONArray prdList(String chk) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 if(!chk.equalsIgnoreCase("load")){
			 return RESULTDATA;
		 }
		 Connection conn =  null;
		 try {
			    conn = connDAO.getMyConnection();
			    Statement stmtAC = conn.createStatement ();
				 
			    String sql=" Select dep.department,sc.subcategory,pt.producttype type,cat.category cat,bd.brandname brand, at.mspecno as specid, m.part_no productid,"
						+ "m.productname productname,m.doc_no,u.unit,m.munit,m.psrno,m.stdprice,m.fixingprice,m.jdeno,m.bhno, convert(if(m.lbrchg=0,'',m.lbrchg),char(100))  fixedcharge from "
						+ "my_main m left join my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
						+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_catm cat on(m.catid=cat.doc_no) "
						+ " left join my_scatm sc on(m.scatid=sc.doc_no) left join my_dept dep on(dep.doc_no=m.deptid)  "
						+ " left join my_ptype pt on(m.typeid=pt.doc_no) where m.status=3 group by m.doc_no";
				//System.out.println("----sql---"+sql);    
				ResultSet resultSet = stmtAC.executeQuery (sql);     
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				 
			    stmtAC.close();   
			    conn.close();   
		 }
		 catch(Exception e){
			
			 e.printStackTrace();
			 conn.close();
		 }
		 return RESULTDATA;
     }
	
	 public JSONArray prdExcel(String chk) throws SQLException {
		 JSONArray RESULTDATA=new JSONArray();
		 if(!chk.equalsIgnoreCase("load")){
			 return RESULTDATA;
		 }
		 Connection conn =  null;
		 try {
			 
			  conn = connDAO.getMyConnection();
			  Statement stmtAC = conn.createStatement ();
			  

				  String sql=" Select m.part_no 'Product', m.productname 'Product Name', u.unit 'Unit', bd.brandname 'Brand', cat.category 'Category', sc.subcategory 'Sub Category', dep.department 'Department' from "
							+ "my_main m left join my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "
							+ " left join  my_brand bd on m.brandid=bd.doc_no left join my_catm cat on(m.catid=cat.doc_no) "
							+ " left join my_scatm sc on(m.scatid=sc.doc_no) left join my_dept dep on(dep.doc_no=m.deptid)  "
							+ " left join my_ptype pt on(m.typeid=pt.doc_no) where m.status=3 group by m.doc_no";

			 ResultSet resultSet = stmtAC.executeQuery (sql);
			 RESULTDATA=commonDAO.convertToEXCEL(resultSet);
			 stmtAC.close();
			 conn.close();
		 }
		 catch(Exception e){
			
			 e.printStackTrace();
			 conn.close();
		 }
		 return RESULTDATA;
   
 }  
}