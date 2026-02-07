package com.operations.marketing.enquiryfurniture;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.operations.marketing.enquiryfurniture.ClsEnquiryFurnitureBean;

import net.sf.json.JSONArray;

public class ClsEnquiryFurnitureDAO {
	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();
	Connection conn;
	public int insert(String sertype,String enqbtype,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client, 
			String remarks,String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype, String telno,HttpServletRequest request,
			int Sourceid,String contactperson,int cpersonid,String cnt,int cmbprocess,String cmbqtype,ArrayList<String> sitearray,int surveyed,String sal_id,String sal_name) throws SQLException {
		try{
			int docno;
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false); 
			
			
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEnquiry.registerOutParameter(14, java.sql.Types.INTEGER);
			stmtEnquiry.registerOutParameter(20, java.sql.Types.INTEGER);
			stmtEnquiry.setDate(1,sqlStartDate);
			stmtEnquiry.setString(2,clid);
			stmtEnquiry.setString(3,clname);
			stmtEnquiry.setString(4,address);
			stmtEnquiry.setString(5,mobile);
			stmtEnquiry.setInt(6,general);
			stmtEnquiry.setInt(7,client);
			stmtEnquiry.setString(8,remarks);
			stmtEnquiry.setString(9,clEmail);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,telno);
			stmtEnquiry.setString(15,mode);
			stmtEnquiry.setInt(16,Sourceid);
			stmtEnquiry.setString(17,contactperson);
			stmtEnquiry.setInt(18,cpersonid);
			stmtEnquiry.setString(19,cnt);
			stmtEnquiry.setInt(21,cmbprocess);
			stmtEnquiry.setInt(22,surveyed);
			stmtEnquiry.setString(23,sal_id==null||sal_id==""||sal_id.equalsIgnoreCase("")?"0":sal_id);
			stmtEnquiry.setString(24,sal_name);
			stmtEnquiry.setString(25,cmbqtype);
			stmtEnquiry.setString(26,enqbtype==null||enqbtype==""||enqbtype.equalsIgnoreCase("")?"0":enqbtype);
			stmtEnquiry.setString(27,sertype==null||sertype==""||sertype.equalsIgnoreCase("")?"0":sertype);
			stmtEnquiry.executeQuery();
			docno=stmtEnquiry.getInt("docNo");
			int vocno=stmtEnquiry.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
		  

			if(docno<=0)
			{
				conn.close();
				return 0;
			}	
			for(int i=0;i< enqarray.size();i++){

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
				{
					/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
					String sql="INSERT INTO gl_enqd(sr_no, desc1, qty, remarks,rdocno)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
							+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							+ "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
							+ "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
							+ "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
							+ "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:enqiury[6].trim())+"',"
							+ "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:enqiury[7].trim())+"',"
							+"'"+docno+"')";

					int resultSet2 = stmtEnquiry.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}	

				}

			}
			for(int i=0;i< sitearray.size();i++){

				String[] sitestring=sitearray.get(i).split("::");
				
				if(!(sitestring[0].trim().equalsIgnoreCase("undefined")|| sitestring[0].trim().equalsIgnoreCase("NaN")||sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()))
				{
					/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
					String sql="INSERT INTO gl_enqsited(sr_no, site, remarks, areaid,surv_id,rdocno,date)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(sitestring[0].trim().equalsIgnoreCase("undefined") || sitestring[0].trim().equalsIgnoreCase("NaN")|| sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()?0:sitestring[0].trim())+"',"
							+ "'"+(sitestring[1].trim().equalsIgnoreCase("undefined") || sitestring[1].trim().equalsIgnoreCase("NaN")|| sitestring[1].trim().equalsIgnoreCase("")|| sitestring[1].isEmpty()?0:sitestring[1].trim())+"',"
							+ "'"+(sitestring[2].trim().equalsIgnoreCase("undefined") || sitestring[2].trim().equalsIgnoreCase("NaN")||sitestring[2].trim().equalsIgnoreCase("")|| sitestring[2].isEmpty()?0:sitestring[2].trim())+"',"
							+ "'"+(sitestring[3].trim().equalsIgnoreCase("undefined") || sitestring[3].trim().equalsIgnoreCase("NaN")||sitestring[3].trim().equalsIgnoreCase("")|| sitestring[3].isEmpty()?0:sitestring[3].trim())+"',"
							+"'"+docno+"',NOW())";

					int resultSetsite2 = stmtEnquiry.executeUpdate (sql);
					if(resultSetsite2<=0)
					{
						conn.close();
						return 0;
					}	

				}

			}
			if (docno > 0) {
				conn.commit();
				stmtEnquiry.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}



	public boolean edit(String sertype,String enqbtype,int docno,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,String remarks,
			String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype,String telno,int sourceid,String cperson,int cpersonid,String cnt,int cmbprocess,String cmbqtype,ArrayList<String> sitearray,int surveyed,String sal_id,String sal_name) throws SQLException {

		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

		
			
			stmtEnquiry.setDate(1,sqlStartDate);
			stmtEnquiry.setString(2,clid);
			stmtEnquiry.setString(3,clname);
			stmtEnquiry.setString(4,address);
			stmtEnquiry.setString(5,mobile);
			stmtEnquiry.setInt(6,general);
			stmtEnquiry.setInt(7,client);
			stmtEnquiry.setString(8,remarks);
			stmtEnquiry.setString(9,clEmail);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,telno);
			stmtEnquiry.setInt(14,docno);
			stmtEnquiry.setString(15,mode);
			stmtEnquiry.setInt(16,sourceid);
			stmtEnquiry.setString(17,cperson);
			stmtEnquiry.setInt(18,cpersonid);
			stmtEnquiry.setString(19,cnt);
			stmtEnquiry.setInt(20,0);
			stmtEnquiry.setInt(21,cmbprocess);
			stmtEnquiry.setInt(22,surveyed);
			stmtEnquiry.setString(23,sal_id==null||sal_id==""||sal_id.equalsIgnoreCase("")?"0":sal_id);
			stmtEnquiry.setString(24,sal_name);
			stmtEnquiry.setString(25,cmbqtype);
			stmtEnquiry.setString(26,enqbtype==null||enqbtype==""||enqbtype.equalsIgnoreCase("")?"0":enqbtype);
			stmtEnquiry.setString(27,sertype==null||sertype==""||sertype.equalsIgnoreCase("")?"0":sertype);
			int aaa=stmtEnquiry.executeUpdate();
			docno=stmtEnquiry.getInt("docNo");

			if(aaa<=0){

				return false;

			}

			String delsql="Delete from gl_enqd where rdocno="+docno+"  ";
			stmtEnquiry.executeUpdate(delsql);
			for(int i=0;i< enqarray.size();i++){

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
				{

					String sql="INSERT INTO gl_enqd(sr_no, desc1, qty, remarks,rdocno)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
							+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							+ "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
							+ "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
							+ "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
							+ "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:enqiury[6].trim())+"',"
							+ "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:enqiury[7].trim())+"',"
							+"'"+docno+"')";

					int resultSet2 = stmtEnquiry.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return false;
					}	

				}

			}

			//site grid
			
			String delsitesql="Delete from gl_enqsited where rdocno="+docno+"  ";
			stmtEnquiry.executeUpdate(delsitesql);
			for(int i=0;i< sitearray.size();i++){

						String[] sitestring=sitearray.get(i).split("::");
				
				if(!(sitestring[0].trim().equalsIgnoreCase("undefined")|| sitestring[0].trim().equalsIgnoreCase("NaN")||sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()))
				{
					/* RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE*/
					String sql="INSERT INTO gl_enqsited(sr_no, site, remarks, areaid,surv_id,rdocno,date)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(sitestring[0].trim().equalsIgnoreCase("undefined") || sitestring[0].trim().equalsIgnoreCase("NaN")|| sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()?0:sitestring[0].trim())+"',"
							+ "'"+(sitestring[1].trim().equalsIgnoreCase("undefined") || sitestring[1].trim().equalsIgnoreCase("NaN")|| sitestring[1].trim().equalsIgnoreCase("")|| sitestring[1].isEmpty()?0:sitestring[1].trim())+"',"
							+ "'"+(sitestring[2].trim().equalsIgnoreCase("undefined") || sitestring[2].trim().equalsIgnoreCase("NaN")||sitestring[2].trim().equalsIgnoreCase("")|| sitestring[2].isEmpty()?0:sitestring[2].trim())+"',"
							+ "'"+(sitestring[3].trim().equalsIgnoreCase("undefined") || sitestring[3].trim().equalsIgnoreCase("NaN")||sitestring[3].trim().equalsIgnoreCase("")|| sitestring[3].isEmpty()?0:sitestring[3].trim())+"',"
							+"'"+docno+"',NOW())";

					int resultSetsiteedit2 = stmtEnquiry.executeUpdate (sql);
					if(resultSetsiteedit2<=0)
					{
						conn.close();
						return false;
					}	

				}

			}
			
			
			if (aaa > 0) {
				conn.commit();
				stmtEnquiry.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}

	public boolean delete(String sertype,String enqbtype,int docno,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,String remarks,
			String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype,String telno,int sourceid,String cperson,int cpersonid,String cnt,String sal_id,String sal_name,String cmbques) throws SQLException {

		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEnquiry.setDate(1,sqlStartDate);
			stmtEnquiry.setString(2,clid);
			stmtEnquiry.setString(3,clname);
			stmtEnquiry.setString(4,address);
			stmtEnquiry.setString(5,mobile);
			stmtEnquiry.setInt(6,general);
			stmtEnquiry.setInt(7,client);
			stmtEnquiry.setString(8,remarks);
			stmtEnquiry.setString(9,clEmail);
			stmtEnquiry.setString(10,session.getAttribute("USERID").toString());
			stmtEnquiry.setString(11,session.getAttribute("BRANCHID").toString());
			stmtEnquiry.setString(12,Dtype.trim());
			stmtEnquiry.setString(13,telno);
			stmtEnquiry.setInt(14,docno);
			stmtEnquiry.setString(15,mode);
			stmtEnquiry.setInt(16,sourceid);
			stmtEnquiry.setString(17,cperson);
			stmtEnquiry.setInt(18,cpersonid);
			stmtEnquiry.setString(19,cnt);
			stmtEnquiry.setInt(20,0);
			stmtEnquiry.setInt(21,0);
			stmtEnquiry.setInt(22,0);
			stmtEnquiry.setString(23,sal_id==null||sal_id==""||sal_id.equalsIgnoreCase("")?"0":sal_id);
			stmtEnquiry.setString(24,sal_name);
			stmtEnquiry.setString(25,cmbques);
			stmtEnquiry.setString(26,enqbtype);
			stmtEnquiry.setString(27,sertype);
			int aaa=stmtEnquiry.executeUpdate();
			docno=stmtEnquiry.getInt("docNo");

			if(aaa<=0){

				return false;

			}

			if (aaa > 0) {
				conn.commit();
				stmtEnquiry.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}


	public    JSONArray searchrelode(String docno,HttpSession session) throws SQLException {

		//JSONArray RESULTDATA=new JSONArray();

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brid=session.getAttribute("BRANCHID").toString();
		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtrelode = conn.createStatement ();

			/*String resql=("select eq.sr_no,eq.brdid,eq.modid,eq.spec specification,eq.clrid,eq.unit,eq.frmdate fromdate,eq.todate,DATE_FORMAT(frmdate,'%d.%m.%Y') AS"
						+ "    hidfromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS hidtodate,eq.rtype renttype,vb.brand_name brand,vm.vtype model,vc.color color"
						+ "    FROM gl_enqd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID"
						+ "    left join gl_vehmodel vm on vm.doc_no=eq.MODID"
						+ "     left join my_color vc on vc.doc_no=eq.clrid  where eq.rdocno='"+docno+"' ");*/

			String resql="select sr_no, desc1 descritpion, qty, remarks,rdocno from gl_enqd eq where eq.rdocno='"+docno+"'";
			System.out.println("resql==="+resql);
			ResultSet resultSet = stmtrelode.executeQuery(resql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmtrelode.close();
			conn.close();



		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return RESULTDATA;
	}
	/*public    JSONArray searchUnit() throws SQLException {

	    JSONArray RESULTDATA=new JSONArray();


		try {
				Connection conn = conobj.getMyConnection();
				Statement stmtunit = conn.createStatement ();

				ResultSet resultSet = stmtunit.executeQuery ("select unit,doc_no from my_unitm where status<>7;");

				RESULTDATA=com.convertToJSON(resultSet);
				stmtunit.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
	    return RESULTDATA;
	}*/
	public    JSONArray searchColor() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();

			ResultSet resultSet = stmtVehclr.executeQuery ("select  doc_no,color  from my_color  where status<>7 order by  doc_no;");

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVehclr.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public JSONArray searchSource(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();

			ResultSet resultSet = stmtVehclr.executeQuery ("SELECT txtname,doc_no FROM cm_enqsource c where status=3");

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVehclr.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}



	public    List<ClsEnquiryFurnitureBean> list4() throws SQLException {
		List<ClsEnquiryFurnitureBean> list1Bean = new ArrayList<ClsEnquiryFurnitureBean>();
		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt6 = conn.createStatement ();


			String tasql= ("select rentaltype from gl_tlistm where status=1;");
			//System.out.println("----------"+tasql);
			ResultSet resultSet5 = stmt6.executeQuery(tasql);
			while (resultSet5.next()) {

				ClsEnquiryFurnitureBean bean = new ClsEnquiryFurnitureBean();

				bean.setRentaltype(resultSet5.getString("rentaltype"));




				list1Bean.add(bean);
				//System.out.println(list1Bean);
			}
			stmt6.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return list1Bean;
	}




	public    JSONArray searchBrand() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh = conn.createStatement ();

			ResultSet resultSet = stmtVeh.executeQuery ("select brand,brand_name,doc_no from gl_vehbrand where status<>7;");

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public    JSONArray searchModel(String brandval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh3 = conn.createStatement ();

			String modelsql= ("select vtype,doc_no from gl_vehmodel where brandid='"+brandval+"' and status<>7;");

			//System.out.println("========"+modelsql);

			ResultSet resultSet = stmtVeh3.executeQuery(modelsql)  ;
			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh3.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brid=session.getAttribute("BRANCHID").toString();


		String sqltest="";

		if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and a.refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and a.per_mob like '%"+mob+"%'";
		}

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
				String clsql= (" select sc.txtname,sc.doc_no scid,c.cperson,c.row_no cprowno,a.per_tel pertel,a.cldocno,a.refname,trim(a.address) address,a.per_mob, "
						+ " trim(a.mail1) mail1,a.sal_id,coalesce(s.sal_name,'') sal_name from my_acbook a left join (select * from my_crmcontact c  group by cldocno) c on(a.cldocno=c.cldocno) "
						+ " left join my_salm s on a.sal_id=s.doc_no left join cm_enqsource sc on(sc.doc_no=a.sourceid and sc.status=3) where  a.dtype='CRM' and a.status<>7 "+sqltest+" order by cldocno ");   
                
			    System.out.println("-----clsql----"+clsql);
				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=com.convertToJSON(resultSet);
				stmtVeh1.close();
				conn.close();   
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}



		public JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String mobno,String enqdate,String enqtype,String Cl_site,String Cl_area,String cntrtype) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();
		java.sql.Date sqlStartDate=null;
		//enqdate.trim();
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
		}
		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.name like '%"+clnames+"%'";
		}
		if(!(mobno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.mob like '%"+mobno+"%'";
		}

		if(!(enqtype.equalsIgnoreCase(""))){
			String enqtypeval="";
			if(enqtype.equalsIgnoreCase("general"))
			{
				enqtypeval="0";
			}
			else if(enqtype.equalsIgnoreCase("client"))
			{
				enqtypeval="1";
			}
			else
			{
			}

			sqltest=sqltest+" and M.enqtype like '%"+enqtypeval+"%'";
		}
		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and M.date='"+sqlStartDate+"'";
		} 

if(!(cntrtype.equalsIgnoreCase("undefined"))&&!(cntrtype.equalsIgnoreCase(""))&&!(cntrtype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.contrmode like '%"+cntrtype+"%'";
		}
	
		if(!(Cl_site.equalsIgnoreCase("undefined"))&&!(Cl_site.equalsIgnoreCase(""))&&!(Cl_site.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ed.site like '%"+Cl_site+"%'";
		}
		if(!(Cl_area.equalsIgnoreCase("undefined"))&&!(Cl_area.equalsIgnoreCase(""))&&!(Cl_area.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and g.groupname like '%"+Cl_area+"%'";
		}

		
		
		Connection conn = null;

		try {
			conn = conobj.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();
			 String sql1="select salesuserlink from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
	    	 System.out.println("sql3====="+sql1); 
	    	 ResultSet rs =stmtenq1.executeQuery(sql1);         
	    	 if(rs.next()){
	    		 sqltest+=" and sm.salesuserlink="+session.getAttribute("USERID");
	    	 }
			String clssql= ("select m.sertypeid,sm.sal_id,sm.sal_name,telno,m.enqbtypeid,m.qtype,m.doc_no,voc_no,m.date,m.remarks,m.cldocno,name,com_add1,coalesce(ct.mob,m.mob)mob,coalesce(ct.email,m.email)email,enqtype,sourceid,txtname as source,"
					+ "m.cperson,cpersonid,contrmode,m.sjobtype,m.surveyed,m.enqstatus,ed.site,g.groupname area from gl_enqm m left join gl_enqsited ed on m.doc_no=ed.rdocno left join my_groupvals g on(ed.areaid=g.doc_no and g.grptype='area')  left join cm_enqsource s on(m.sourceid=s.doc_no) "
					+ "left join my_salm sm on sm.doc_no=m.sal_id left join my_crmcontact ct on (ct.row_no=m.cpersonid) where m.status=3 and m.brhid="+brid+" " +sqltest+" group by m.doc_no");
			System.out.println("====sql+++===="+clssql);   
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=com.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray siteGridLoad(HttpSession session,String docno) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select a.rdocno,eq.sr_no,eq.rowno, (SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
					+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.surv_id) order by doc_no) surtype,eq.site,grp.groupname area,eq.remarks, eq.areaid, "
					+ "eq.surv_id surid  from gl_enqsited eq  left  join (select eq.rdocno,eq.surv_id,eq.sr_no   "
					+ "from gl_enqsited eq where eq.rdocno="+docno+") a on (a.rdocno =eq.rdocno and a.sr_no=eq.sr_no) "
					+ "left join my_groupvals grp on grp.doc_no=eq.areaid and grp.grptype='area' where eq.rdocno="+docno+"";


			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public JSONArray areaSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";


//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public JSONArray searchSerType(HttpSession session,String sertype,String sertypeid,String id) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		String sqltest="";


		if(!(sertype.equalsIgnoreCase("undefined"))&&!(sertype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.name like '%"+sertype+"%'";
		}

		if(!(sertypeid.equalsIgnoreCase("undefined"))&&!(sertypeid.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no not in("+sertypeid+")";
		}


		Connection conn = null;
		ResultSet resultSet =null;
		try {
			if(Integer.parseInt(id)>0){
				conn = conobj.getMyConnection();
				Statement stmtenq1 = conn.createStatement ();

				String str1Sql=("select doc_no,name from cm_proptypem m where status=3 "+sqltest+"");

//				System.out.println("==searchSerType==="+str1Sql);


				resultSet = stmtenq1.executeQuery(str1Sql);


				RESULTDATA=com.convertToJSON(resultSet);
				stmtenq1.close();
				conn.close();
			}

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}

	public   ClsEnquiryFurnitureBean getPrint(int docno,HttpSession session) throws SQLException {
		ClsEnquiryFurnitureBean bean = new ClsEnquiryFurnitureBean();
		//  String brhid=session.getAttribute("BRANCHID").toString();
		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtprint = conn.createStatement ();

			String resql=("Select e.voc_no,DATE_FORMAT(e.date,'%d.%m.%Y') AS date,e.name,e.com_add1,e.mob,e.email,if(e.enqtype=1,'Client','General') enqtype,contrmode  from gl_enqm e where e.doc_no='"+docno+"'  ");

			ResultSet pintrs = stmtprint.executeQuery(resql);


			while(pintrs.next()){
				// cldatails

				/* setLblclient setLblclientaddress setLblmob setLblemail setLbldate setLbltypep setDocvals*/


				bean.setLblclient(pintrs.getString("name"));
				bean.setLblclientaddress(pintrs.getString("com_add1"));
				bean.setLblmob(pintrs.getString("mob"));
				bean.setLblemail(pintrs.getString("email"));
				//upper
				bean.setLbldate(pintrs.getString("date"));
				bean.setLbltypep(pintrs.getString("enqtype"));
				bean.setDocvals(pintrs.getInt("voc_no"));
				bean.setHidradio(pintrs.getString("contrmode"));
			}


			stmtprint.close();



			Statement stmtinvoice10 = conn.createStatement ();
			/*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_enqm r  "
					    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
					    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
			String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_enqm r inner join my_brch b on  "
					+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
					+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.doc_no='"+docno+"' ";
			//System.out.println("--------"+companysql);
			ResultSet resultsetcompany = stmtinvoice10.executeQuery(companysql); 

			while(resultsetcompany.next()){

				bean.setLblbranch(resultsetcompany.getString("branchname"));
				bean.setLblcompname(resultsetcompany.getString("company"));

				bean.setLblcompaddress(resultsetcompany.getString("address"));

				bean.setLblcomptel(resultsetcompany.getString("tel"));

				bean.setLblcompfax(resultsetcompany.getString("fax"));
				bean.setLbllocation(resultsetcompany.getString("location"));


				bean.setLblcstno(resultsetcompany.getString("cstno"));

				bean.setLblservicetax(resultsetcompany.getString("stcno"));
				bean.setLblpan(resultsetcompany.getString("pbno"));


				// setLblcstno setLblservicetax setLblpan

			} 
			stmtinvoice10.close();


			conn.close();




		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;


	}
	public  ArrayList<String> getPrintdetails(int docno,HttpSession session) throws SQLException {
		ArrayList<String> arr=new ArrayList<String>();
		Connection conn = null;
		// String brhid=session.getAttribute("BRANCHID").toString();
		try {
			conn = conobj.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSqldetail="";
			strSqldetail="select  desc1,qty,remarks   FROM gl_enqd eq   where eq.rdocno='"+docno+"' ";


			ResultSet rsdetail=stmtinvoice.executeQuery(strSqldetail);

			int rowcount=1;

			while(rsdetail.next()){

				String temp="";
				String spci="";
				
				temp=rowcount+"::"+rsdetail.getString("desc1")+"::"+rsdetail.getString("qty")+"::"+rsdetail.getString("remarks");

				arr.add(temp);
				rowcount++;



			}
			stmtinvoice.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return arr;
	}


	public JSONArray contactpersonSearch(HttpSession session,int clientid) throws SQLException
	{

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}


		String brcid=session.getAttribute("BRANCHID").toString();




		Connection conn =null;
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();


			String sql= ("select cperson,c.tel as tel,area,row_no as cprowno,convert(email,char(50)) email,c.mob from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientid+" and a.doc_no="+clientid+"" );
			System.out.println("-------contactpersonSearch----------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	public JSONArray salesManDetailsSearch(HttpSession session,String slname,String mob,int id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

		String brid=session.getAttribute("BRANCHID").toString();

		String sqltest="";

		if(!(slname.equalsIgnoreCase("undefined"))&&!(slname.equalsIgnoreCase(""))&&!(slname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and sal_name like '%"+slname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and mob_no like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();

			if(id>0){
				//String sql= ("select sal_name,mob_no,doc_no from my_salm where status=3 " +sqltest);
				
				String consql="",chksalmanid="",flag="0";
				
				String checksaleman="select sal_name,doc_no,mob_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" ";
				ResultSet chksalman=stmt.executeQuery(checksaleman);
				while(chksalman.next()){
							chksalmanid=chksalman.getString("salesuserlink");
							flag="1";
				}	
				if(flag.equalsIgnoreCase("1")){
					consql="select sal_name,doc_no,mob_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" "+sqltest;
				}
				else if(flag.equalsIgnoreCase("0")){
						consql="select sal_name,doc_no,mob_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" "+sqltest 
							+"union select sal_name,doc_no,mob_no,salesuserlink from my_salm "+sqltest ;
					}
				//ResultSet rsconfg = stmt.executeQuery(consql);
				
				System.out.println("*******salesManDetailsSearch*********"+consql);	
				
				ResultSet resultSet = stmt.executeQuery(consql);

				RESULTDATA=com.convertToJSON(resultSet);
			
				stmt.close();
				conn.close();
			}
		} catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return RESULTDATA;
	}
	
	public int insertCQ(int rdocno,int intro1,int intro2,int intro3,int intro4,int rep,int norep,int shape1,int shape2,int shape3,int shape4,int dtype1,int dtype2,int dtype3,int material1,int material2,int material3,String woodsel1,String woodsel2,String woodsel3,int hardwr1,int hardwr2,int light,int drawer1,int drawer2,int bboard1,int bboard2,int bsboard1,int bsboard2,int layout1,int layout2,String numofitem ,String ascode,String cbank) throws SQLException {
		int val=0;
		try{
			
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtcq = conn.createStatement ();
			//System.out.println("in DAO");
			String sql1="delete from gl_enqquestclo where rdocno='"+rdocno+"' ";
			stmtcq.executeUpdate(sql1);
			String sql="insert into gl_enqquestclo(rdocno, intro1, intro2, intro3, intro4, rep, norep, numofitem, shape1, shape2, shape3, shape4, dtype1, dtype2, dtype3, material1, material2, material3, woodsel1, woodsel2, woodsel3, hardwr1, hardwr2, light, ascode, drawer1, drawer2, bboard1, bboard2, bsboard1, bsboard2, layout1, layout2,bank) values('"+rdocno+"', '"+intro1+"','"+intro2+"', '"+intro3+"', '"+intro4+"', '"+rep+"', '"+norep+"','"+numofitem+"','"+shape1+"','"+shape2+"','"+shape3+"','"+shape4+"','"+dtype1+"','"+dtype2+"', '"+dtype3+"','"+material1+"','"+material2+"','"+material3+"','"+woodsel1+"','"+woodsel2+"','"+woodsel3+"','"+hardwr1+"','"+hardwr2+"','"+light+"','"+ascode+"','"+drawer1+"','"+drawer2+"','"+bboard1+"','"+bboard2+"','"+bsboard1+"','"+bsboard2+"','"+layout1+"','"+layout2+"','"+cbank+"')";
			//System.out.println("****************"+sql);	
			val=stmtcq.executeUpdate(sql);
			//System.out.println("val"+val);
			conn.commit();
			stmtcq.close();
			conn.close();
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return val;
	}
	public int insertKQ(int rdocno,int intro1,int intro2,int intro3,int intro4,int exist,int notexist,int numofitem,int shape1,int shape2,int shape3,int shape4,int ctype1,int ctype2,int ctype3,String other,int material1,int material2,int drawer1,int drawer2,int drawer3,int sp1,int sp2,int ls1,int ls2,int cor1,int cor2,int kstyle1,int kstyle2,int interest1,int interest2,int interest3,int interest4,String listitem,int appl1,int appl2,int appl3,int appl4,int appl5,int appl6,int appl7,int appl8,int appl9,int appl10,int counter1,int counter2,int counter3,int fwtw,int fwth,int fwtd,String dwash,int cooks,int cookw,int mwaves,int mwavew,int mwaveh,String mwaveftr,String mwavedet,int sinks,int sinkw,String brand,int applncs,int applncss,int layout1,int layout2,String bank) throws SQLException {
		int val=0;
		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmtcq = conn.createStatement ();
			System.out.println("in DAO");
			String sql1="delete from gl_enqquestkit where rdocno='"+rdocno+"' "; 
			stmtcq.executeUpdate(sql1);     
			String sql="insert into gl_enqquestkit(rdocno, intro1, intro2, intro3, intro4, exist1, exist2, numofitem, shape1, shape2, shape3, shape4, ctype1, ctype2, ctype3, other, material1, material2, drawer1, drawer2, drawer3, sp1, sp2, ls1, ls2, cor1, cor2, kstyle1, kstyle2, interest1, interest2, interest3, interest4, listitem, appl1, appl2, appl3, appl4, appl5, appl6, appl7, appl8, appl9, appl10, counter1, counter2, counter3, fwtw, fwth, fwtd, dwash, cooks, cookw, mwaves, mwavew, mwaveh, mwaveftr, mwavedet, sinks, sinkw, brand, applncs, applncss, layout1, layout2,bank) values('"+rdocno+"', '"+intro1+"','"+intro2+"', '"+intro3+"', '"+intro4+"', '"+exist+"', '"+notexist+"','"+numofitem+"','"+shape1+"','"+shape2+"','"+shape3+"','"+shape4+"','"+ctype1+"','"+ctype2+"', '"+ctype3+"','"+other+"','"+material1+"','"+material2+"','"+drawer1+"','"+drawer2+"','"+drawer3+"','"+sp1+"','"+sp2+"','"+ls1+"','"+ls2+"','"+cor1+"','"+cor2+"','"+kstyle1+"','"+kstyle2+"','"+interest1+"','"+interest2+"','"+interest3+"','"+interest4+"','"+listitem+"','"+appl1+"','"+appl2+"','"+appl3+"','"+appl4+"','"+appl5+"','"+appl6+"','"+appl7+"','"+appl8+"','"+appl9+"','"+appl10+"','"+counter1+"','"+counter2+"','"+counter3+"','"+fwtw+"','"+fwth+"','"+fwtd+"', '"+dwash+"','"+cooks+"','"+cookw+"','"+mwaves+"','"+mwavew+"','"+mwaveh+"','"+mwaveftr+"','"+mwavedet+"', '"+sinks+"','"+sinkw+"','"+brand+"','"+applncs+"','"+applncss+"','"+layout1+"','"+layout2+"','"+bank+"')";
			System.out.println("****************"+sql);	
			val=stmtcq.executeUpdate(sql);
			//System.out.println("val"+val);
			conn.commit();
			stmtcq.close();
			conn.close();
		}catch(Exception e){	  
			e.printStackTrace();
			conn.close();	
		}
		return val;     
	}
	
	
	public JSONArray skipSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select name skiptype,doc_no skipdoc from sk_skipm where status=3";


			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	
	public JSONArray wasteSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select name wastetype,doc_no wastedoc from sk_dumpsite where status=3";


			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=com.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	
	
	
}
