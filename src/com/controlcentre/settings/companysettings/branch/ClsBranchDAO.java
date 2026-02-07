package com.controlcentre.settings.companysettings.branch;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.common.ClsCommon;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.connection.ClsConnection;
public class ClsBranchDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	ClsBranchBean branchBean=new ClsBranchBean();
	public int insert(String compid,String txtbranchid,String txtbranchname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
			String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbbranchcurr,String txttinno,
			String txtcstno,String txtstcno,HttpSession session,String mode,String formdetailcode,int txtdocno) throws SQLException {
	Connection conn=null;
		try{
		int aaa;
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
	//	System.out.println(cmbbranchcurr);
		
		CallableStatement stmtBranch = conn.prepareCall("{call vehBranchDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtBranch.registerOutParameter(21, java.sql.Types.INTEGER);
		//stmtBranch.setString(1,);
		int temp=0;
		stmtBranch.setString(1, compid);
		stmtBranch.setString(2, txtbranchid);
		stmtBranch.setString(3, txtbranchname);
		stmtBranch.setString(4, txtaddress);
		stmtBranch.setString(5, txtpbno);
		stmtBranch.setString(6, txttel1);
		stmtBranch.setString(7, txttel2);
		stmtBranch.setString(8, txtfax1);
		stmtBranch.setString(9, txtfax2);
		stmtBranch.setString(10, txtemail1);
		stmtBranch.setString(11, txtwebsite);
		stmtBranch.setString(12, txttinno);
		stmtBranch.setString(13, txtstcno);
		stmtBranch.setString(14,txtcstno);
		stmtBranch.setInt(15,temp);
		stmtBranch.setDate(16, sqlAccdate1);
		stmtBranch.setDate(17, sqlAccdate2);
		stmtBranch.setString(18, cmbbranchcurr);
//System.out.println(cmbbranchcurr);
		stmtBranch.setString(20,session.getAttribute("BRANCHID").toString());
//		System.out.println("BRANCHID"+session.getAttribute("BRANCHID").toString());
		stmtBranch.setString(19,session.getAttribute("USERID").toString());
		stmtBranch.setString(22,mode);
		stmtBranch.setString(23, formdetailcode);
		stmtBranch.setInt(24, txtdocno);
		
		stmtBranch.executeQuery();
		aaa=stmtBranch.getInt("docNo");
//		System.out.println("no====="+aaa);
		branchBean.setDocno(aaa);
		
		if (aaa > 0) {
			conn.commit();

			stmtBranch.close();
			conn.close();
//			System.out.println("Success"+branchBean.getDocno());
			return aaa;
			
			
		}

		stmtBranch.close();
		conn.close();
	}catch(Exception e){	
	e.printStackTrace();
	conn.close();
	}
		finally{
			conn.close();
		}
	
	return 0;
	
}
	public   JSONArray provincesearch(HttpSession session) throws SQLException
	{
		
		JSONArray RESULTDATA=new JSONArray();
    	
        Connection conn =null;
        Statement stmt  =null;
        ResultSet resultSet =null;
        
  			try {
				  conn = ClsConnection.getMyConnection();
				 stmt = conn.createStatement ();
            	
				String sql= ("select code Code,name Name,doc_no from my_province where status=3" );
				
				 //String sql= ("select c.doc_no as citydocno,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_acity c left join my_acountry ac on(ac.doc_no=c.country_id) left join my_aregion r on(r.doc_no=ac.reg_id) where  c.status=3 and ac.status=3 and r.status=3" );
				 System.out.println("------------------"+sql);
				 resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
  			finally{
  				resultSet.close();
  				stmt.close();
  				conn.close();
  				
  				
  			}
	//	System.out.println(RESULTDATA);
        return RESULTDATA;
   
	}
	
public boolean edit(String compid,String txtbranchid,String txtbranchname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
		String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbbranchcurr,String txttinno,
		String txtcstno,String txtstcno,HttpSession session,String mode,int docno,String formdetailcode,int doc_no) throws SQLException {
		Connection conn=null;
		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
//			System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
			CallableStatement stmtBranch = conn.prepareCall("{call vehBranchDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//			System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//			CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
			stmtBranch.setInt(21,docno);
			//stmtBranch.setString(1,);
			int temp=0;
			stmtBranch.setString(1, compid);
			
			stmtBranch.setString(2, txtbranchid);
			stmtBranch.setString(3, txtbranchname);
			stmtBranch.setString(4, txtaddress);
			stmtBranch.setString(5, txtpbno);
			stmtBranch.setString(6, txttel1);
			stmtBranch.setString(7, txttel2);
			stmtBranch.setString(8, txtfax1);
			stmtBranch.setString(9, txtfax2);
			stmtBranch.setString(10, txtemail1);
			stmtBranch.setString(11, txtwebsite);
			stmtBranch.setString(12, txttinno);
			stmtBranch.setString(13, txtstcno);
			stmtBranch.setString(14,txtcstno);
			stmtBranch.setInt(15,temp);
			stmtBranch.setDate(16, sqlAccdate1);
			stmtBranch.setDate(17, sqlAccdate2);
			stmtBranch.setString(18, cmbbranchcurr);
	//System.out.println(cmbbranchcurr);
			stmtBranch.setString(20,session.getAttribute("BRANCHID").toString());
			stmtBranch.setString(19,session.getAttribute("USERID").toString());
			stmtBranch.setString(22,mode);
			stmtBranch.setString(23, formdetailcode);
			stmtBranch.setInt(24,doc_no);
			
			
//			System.out.println("before date");
			//stmtDealer.setDate(2,(Date)modeldate);
//			System.out.println("after date");
	//System.out.println(brandid+":"+docno+":"+model+":"+modeldate);

			int aa = stmtBranch.executeUpdate();
			
//			System.out.println("inside DAO1");
			
			if (aa>0) {
				conn.commit();
				stmtBranch.close();
				conn.close();	
//				System.out.println("Success");
				return true;
			}
			stmtBranch.close();
			conn.close();	
		}catch(Exception e){
		e.printStackTrace();
		conn.close();
		}
		finally{
			conn.close();
		}
		
		return false;
	}
public int delete(String compid,String txtbranchid,String txtbranchname,String txtaddress,String txtemail1,String txtwebsite,String txtfax1,
		String txtfax2,String txttel1,String txttel2,String txtpbno,Date sqlAccdate1,Date sqlAccdate2,String cmbbranchcurr,String txttinno,
		String txtcstno,String txtstcno,HttpSession session,String mode,int docno,String formdetailcode) throws SQLException {
	Connection conn=null;
	try{
		conn=ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmtTest=conn.createStatement ();
		String testSql="select brhid from my_locm where brhid='"+docno+"' and status<>7";
		ResultSet resultSet1 = stmtTest.executeQuery (testSql);
		if(resultSet1.next()){
			return -1;
		}
//		System.out.println("ssssssss="+session.getAttribute("BRANCHNAME"));
		CallableStatement stmtBranch = conn.prepareCall("{call vehBranchDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
//		System.out.println("{call vehbrandinsert(AA,"+brand+","+(Date)date_brand +")}");
//		CALL vehPlateCodeinsert( 'aaa','Demo','2014-10-20','dubai','fire 7 llc',1,@docNo);
		stmtBranch.setInt(21,docno);
		//stmtBranch.setString(1,);
		int temp=0;
		stmtBranch.setString(1, compid);
		
		stmtBranch.setString(2, txtbranchid);
		stmtBranch.setString(3, txtbranchname);
		stmtBranch.setString(4, txtaddress);
		stmtBranch.setString(5, txtpbno);
		stmtBranch.setString(6, txttel1);
		stmtBranch.setString(7, txttel2);
		stmtBranch.setString(8, txtfax1);
		stmtBranch.setString(9, txtfax2);
		stmtBranch.setString(10, txtemail1);
		stmtBranch.setString(11, txtwebsite);
		stmtBranch.setString(12, txttinno);
		stmtBranch.setString(13, txtstcno);
		stmtBranch.setString(14,txtcstno);
		stmtBranch.setInt(15,temp);
		stmtBranch.setDate(16, sqlAccdate1);
		stmtBranch.setDate(17, sqlAccdate2);
		stmtBranch.setString(18, cmbbranchcurr);
//System.out.println(cmbbranchcurr);
		stmtBranch.setString(20,session.getAttribute("BRANCHID").toString());
		stmtBranch.setString(19,session.getAttribute("USERID").toString());
		stmtBranch.setString(22,mode);
		stmtBranch.setString(23, formdetailcode);
		//PreparedStatement stmtDealer = conn.prepareStatement("update gl_vehmodel set status=7 where doc_no=?");
//		System.out.println("after stm inside delete");
		//System.out.println("update gl_vehmodel set status=7 where doc_no="+docno);
		//stmtDealer.setInt(1,docno);
		int aa = stmtBranch.executeUpdate();
	
		if (aa>0) {
//			System.out.println("Success");
			conn.commit();
			stmtBranch.close();
			conn.close();	
			return aa;
		}
		stmtBranch.close();
		conn.close();	
	}catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	
	return 0;
}
public  List<ClsBranchBean> list() throws SQLException {
    List<ClsBranchBean> listBean = new ArrayList<ClsBranchBean>();
    Connection conn=null;
	try {
			conn = ClsConnection.getMyConnection();
			Statement stmtBranch = conn.createStatement ();
        	
			ResultSet resultSet = stmtBranch.executeQuery ("select b.prvdocno,p.name,b.branch, b.branchname, b.address, b.tel, b.fax, b.accyear_f, "
					+ " b.accyear_t, b.email, b.doc_no, b.curid, b.tel2, b.fax2, b.web, b.cmpid, b.pbno, b.stcno, b.cstno, b.tinno from my_brch b  "
					+ "left join my_province p on p.doc_no=b.prvdocno where b.status<>7;");
			while (resultSet.next()) {
				
				ClsBranchBean bean = new ClsBranchBean();
				
				
				bean.setTxtdocno(resultSet.getInt("prvdocno"));
				bean.setTxtprovince(resultSet.getString("name"));
				
				
            	bean.setDocno(resultSet.getInt("doc_no"));
				bean.setTxtbranchid(resultSet.getString("branch"));
				bean.setTxtbranchname(resultSet.getString("branchname"));
				bean.setTxtaddress(resultSet.getString("address"));
				bean.setTxttel1(resultSet.getString("tel"));
				bean.setTxtfax1(resultSet.getString("fax"));
				bean.setBranchaccdate1(resultSet.getDate("accyear_f"));
				bean.setBranchaccdate2(resultSet.getDate("accyear_t"));
				bean.setTxtemail1(resultSet.getString("email"));
				bean.setCmbbranchcurr(resultSet.getString("curid"));
				bean.setTxttel2(resultSet.getString("tel2"));
				bean.setTxtfax2(resultSet.getString("fax2"));
				bean.setTxtwebsite(resultSet.getString("web"));
				bean.setCmbcompname(resultSet.getString("cmpid"));
				bean.setTxtpbno(resultSet.getString("pbno"));
				bean.setTxtcstno(resultSet.getString("cstno"));
				bean.setTxtstcno(resultSet.getString("stcno"));
				bean.setTxttinno(resultSet.getString("tinno"));
				listBean.add(bean);
//            	System.out.println(listBean);
				
			}
			stmtBranch.close();
			conn.close();
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
//System.out.println("nitin===="+listBean);
    return listBean;
}
}
