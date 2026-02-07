package com.callibration.enquiry;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.callibration.enquiry.ClsEnquiryBean;
import com.cargo.costingforinvoicing.ClsCostingForInvoicingBean;

import net.sf.json.JSONArray;

public class ClsEnquiryDAO {
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();

	Connection conn;
	public int insert(Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client, 
			String remarks,String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype, String telno,HttpServletRequest request,
			int Sourceid,String contactperson,int cpersonid,String cnt,int cmbprocess,String labreq,String clbcnfrm,String spclinsts,String adjspec,String alwinst,String modreq,String paytrms,String hidexpdate,String expdate,String stmtcnfrm,String dispinst,String clbduedate,String clbprdacpt,String clbmthdusd) throws SQLException {
		try{
			int docno;
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false); 
			
			System.out.println("in DAO");
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
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
			stmtEnquiry.setString(19,"");
			stmtEnquiry.setInt(21,cmbprocess);
			stmtEnquiry.setInt(22,Integer.parseInt(labreq));
			stmtEnquiry.setInt(23,Integer.parseInt(clbcnfrm));
			stmtEnquiry.setString(24,spclinsts);
			stmtEnquiry.setInt(25,Integer.parseInt(adjspec));
			stmtEnquiry.setInt(26,Integer.parseInt(alwinst));
			stmtEnquiry.setInt(27,Integer.parseInt(modreq));
			stmtEnquiry.setInt(28,Integer.parseInt(paytrms));
			stmtEnquiry.setString(29,expdate);
			stmtEnquiry.setInt(30,Integer.parseInt(stmtcnfrm));
			stmtEnquiry.setInt(31,Integer.parseInt(dispinst));
			stmtEnquiry.setString(32,clbduedate);
			stmtEnquiry.setInt(33,Integer.parseInt(clbprdacpt));
			stmtEnquiry.setInt(34,Integer.parseInt(clbmthdusd));
			System.out.println(stmtEnquiry);
			stmtEnquiry.executeUpdate();
			
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
					String sql="INSERT INTO cl_enqd(sr_no,qty,remarks,makeid,modelid,rangeid,callibration,type,prodpsrno,prodspecid,make,model,ranges,equipmentname,rdocno)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
							+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							+ "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")|| enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
							+ "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")|| enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
							+ "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
							+ "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")|| enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:enqiury[6].trim())+"',"
							+ "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")|| enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
							+ "'"+(enqiury[9].trim().equalsIgnoreCase("undefined") || enqiury[9].trim().equalsIgnoreCase("NaN")||enqiury[9].trim().equalsIgnoreCase("")|| enqiury[9].isEmpty()?0:enqiury[9].trim())+"',"
							+ "'"+(enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")|| enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:enqiury[10].trim())+"',"
                            + "'"+(enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")|| enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?0:enqiury[11].trim())+"',"
                            + "'"+(enqiury[12].trim().equalsIgnoreCase("undefined") || enqiury[12].trim().equalsIgnoreCase("NaN")||enqiury[12].trim().equalsIgnoreCase("")|| enqiury[12].isEmpty()?0:enqiury[12].trim())+"',"
                            + "'"+(enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?0:enqiury[13].trim())+"',"
   							+"'"+docno+"')";
                    System.out.println("insertenqd==="+sql);
					int resultSet2 = stmtEnquiry.executeUpdate (sql);
					if(resultSet2<=0)
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
			conn = ClsConnection.getMyConnection();
			Statement stmtrelode = conn.createStatement ();

			/*String resql=("select eq.sr_no,eq.brdid,eq.modid,eq.spec specification,eq.clrid,eq.unit,eq.frmdate fromdate,eq.todate,DATE_FORMAT(frmdate,'%d.%m.%Y') AS"
						+ "    hidfromdate,DATE_FORMAT(todate,'%d.%m.%Y') AS hidtodate,eq.rtype renttype,vb.brand_name brand,vm.vtype model,vc.color color"
						+ "    FROM gl_enqd eq left join gl_vehbrand vb on vb.doc_no=eq.BRDID"
						+ "    left join gl_vehmodel vm on vm.doc_no=eq.MODID"
						+ "     left join my_color vc on vc.doc_no=eq.clrid  where eq.rdocno='"+docno+"' ");*/

			String resql="select sr_no,qty, remarks,rdocno,equipmentname,makeid brndid,modelid catid,rangeid scatid,callibration,make,model,ranges,prodspecid as tempspecid,prodpsrno as temppsrno,type from cl_enqd eq where eq.rdocno='"+docno+"'";
			System.out.println("resql==="+resql);
			ResultSet resultSet = stmtrelode.executeQuery(resql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtrelode.close();
			conn.close();



		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return RESULTDATA;
	}
	
	public ClsEnquiryBean getViewDetails(int docno, HttpSession session) throws SQLException {
		 
		ClsEnquiryBean bean= new ClsEnquiryBean(); 
		Connection conn=null;
		try
		{
			conn=ClsConnection.getMyConnection();
			
		Statement stmt=conn.createStatement();
		
		String sql="select telno,m.doc_no,voc_no,m.date,remarks,m.cldocno,m.callibration_method,m.callib_prd_acpt,m.callib_duedate,m.dispatch_instrns,m.stmt_cnfrm,m.exp_deldate,m.pay_trms,m.mod_req,m. allw_subcntrs,m.adjst_spec,m.spcl_instns,m.callib_understood,m.specreq_cpblty,name,com_add1,ct.mob,ct.email,m.cperson,cpersonid from cl_enqm m left join my_crmcontact ct on(ct.row_no=m.cpersonid) where m.status=3 and m.doc_no="+docno+" and m.brhid='"+session.getAttribute("BRANCHID").toString()+"'";
		System.out.println("view====="+sql);
		ResultSet rsss=stmt.executeQuery(sql);
		
		
		if(rsss.first())
		{
								 
			 
			bean.setLabreq(rsss.getString("specreq_cpblty"));
			bean.setClbcnfrm(rsss.getString("callib_understood"));
			bean.setSpclinsts(rsss.getString("spcl_instns"));
			bean.setAdjspec(rsss.getString("adjst_spec"));
			bean.setAlwinst(rsss.getString("allw_subcntrs"));
			bean.setModreq(rsss.getString("mod_req"));
			bean.setPaytrms(rsss.getString("pay_trms"));
			bean.setHidexpdate(rsss.getString("exp_deldate"));
			bean.setExpdate(rsss.getString("exp_deldate"));
			bean.setStmtcnfrm(rsss.getString("stmt_cnfrm"));
			bean.setDispinst(rsss.getString("dispatch_instrns"));
			bean.setClbduedate(rsss.getString("callib_duedate"));
			bean.setClbprdacpt(rsss.getString("callib_prd_acpt"));
			bean.setClbmthdusd(rsss.getString("callibration_method"));
			
			
		}
		
		conn.close();
				
				
		}
		catch(Exception e)
		{
			conn.close();
		}
		
		return bean;
	}
	
	
	public    JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String mobno,String enqdate,String enqtype) throws SQLException {


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
			sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
		}





System.out.println("msdocno==="+msdocno+"====clnames===="+clnames+"====mobno====="+mobno);
		String sqltest="";
		if(!(msdocno.equalsIgnoreCase("")) ){
			sqltest=sqltest+" and voc_no like '%"+msdocno+"%'";
		}
		if(!(clnames.equalsIgnoreCase("")) ){
			sqltest=sqltest+" and name like '%"+clnames+"%'";
		}
		if(!(mobno.equalsIgnoreCase("")) ){
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

			//sqltest=sqltest+" and enqtype like '%"+enqtypeval+"%'";
		}
		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and date='"+sqlStartDate+"'";
		} 



		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select telno,m.doc_no,voc_no,m.date,remarks,m.cldocno,m.callibration_method,m.callib_prd_acpt,m.callib_duedate,m.dispatch_instrns,m.stmt_cnfrm,m.exp_deldate,m.pay_trms,m.mod_req,m. allw_subcntrs,m.adjst_spec,m.spcl_instns,m.callib_understood,m.specreq_cpblty,name,com_add1,ct.mob,ct.email,m.cperson,cpersonid from cl_enqm m left join my_crmcontact ct on(ct.row_no=m.cpersonid) where m.status=3 and m.brhid="+brid+" " +sqltest);
			System.out.println("===mastersrch====="+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public boolean edit(int docno,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,String remarks,
			String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype,String telno,int sourceid,String cperson,int cpersonid,String cnt,int cmbprocess,String labreq,String clbcnfrm,String spclinsts,String adjspec,String alwinst,String modreq,String paytrms,String hidexpdate,String expdate,String stmtcnfrm,String dispinst,String clbduedate,String clbprdacpt,String clbmthdusd) throws SQLException {

		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);  
			/*CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

		
			
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
			stmtEnquiry.setString(22,labreq);
			stmtEnquiry.setString(23,clbcnfrm);
			stmtEnquiry.setString(24,spclinsts);
			stmtEnquiry.setString(25,adjspec);
			stmtEnquiry.setString(26,alwinst);
			stmtEnquiry.setString(27,modreq);
			stmtEnquiry.setString(28,paytrms);
			stmtEnquiry.setString(29,expdate);
			stmtEnquiry.setString(30,stmtcnfrm);
			stmtEnquiry.setString(31,dispinst);
			stmtEnquiry.setString(32,clbduedate);
			stmtEnquiry.setString(33,clbprdacpt);
			stmtEnquiry.setString(34,clbmthdusd);
			
			int aaa=stmtEnquiry.executeUpdate();*/
			
			
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEnquiry.setInt(14,docno);
			stmtEnquiry.setInt(20,0);
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
			stmtEnquiry.setInt(16,sourceid);
			stmtEnquiry.setString(17,cperson);
			stmtEnquiry.setInt(18,cpersonid);
			stmtEnquiry.setString(19,"");
			stmtEnquiry.setInt(21,cmbprocess);
			stmtEnquiry.setInt(22,Integer.parseInt(labreq));
			stmtEnquiry.setInt(23,Integer.parseInt(clbcnfrm));
			stmtEnquiry.setString(24,spclinsts);
			stmtEnquiry.setInt(25,Integer.parseInt(adjspec));
			stmtEnquiry.setInt(26,Integer.parseInt(alwinst));
			stmtEnquiry.setInt(27,Integer.parseInt(modreq));
			stmtEnquiry.setInt(28,Integer.parseInt(paytrms));
			stmtEnquiry.setString(29,expdate);
			stmtEnquiry.setInt(30,Integer.parseInt(stmtcnfrm));
			stmtEnquiry.setInt(31,Integer.parseInt(dispinst));
			stmtEnquiry.setString(32,clbduedate);
			stmtEnquiry.setInt(33,Integer.parseInt(clbprdacpt));
			stmtEnquiry.setInt(34,Integer.parseInt(clbmthdusd));
			System.out.println(stmtEnquiry);
			int aaa=stmtEnquiry.executeUpdate();
			
			
			
			docno=stmtEnquiry.getInt("docNo");

			if(aaa<=0){

				return false;

			}

			String delsql="Delete from cl_enqd where rdocno="+docno+"  ";
			stmtEnquiry.executeUpdate(delsql);
			for(int i=0;i< enqarray.size();i++){

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
				{

					String sql="INSERT INTO cl_enqd(sr_no,qty,remarks,makeid,modelid,rangeid,callibration,type,prodpsrno,prodspecid,make,model,ranges,equipmentname,rdocno)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
							+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							+ "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")|| enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
							+ "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")|| enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
							+ "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
							+ "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")|| enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:enqiury[6].trim())+"',"
							+ "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")|| enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
							+ "'"+(enqiury[9].trim().equalsIgnoreCase("undefined") || enqiury[9].trim().equalsIgnoreCase("NaN")||enqiury[9].trim().equalsIgnoreCase("")|| enqiury[9].isEmpty()?0:enqiury[9].trim())+"',"
							+ "'"+(enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")|| enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:enqiury[10].trim())+"',"
                            + "'"+(enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")|| enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?0:enqiury[11].trim())+"',"
                            + "'"+(enqiury[12].trim().equalsIgnoreCase("undefined") || enqiury[12].trim().equalsIgnoreCase("NaN")||enqiury[12].trim().equalsIgnoreCase("")|| enqiury[12].isEmpty()?0:enqiury[12].trim())+"',"
                            + "'"+(enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?0:enqiury[13].trim())+"',"
   							+"'"+docno+"')";

					int resultSet2 = stmtEnquiry.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return false;
					}	

				}

			}

			/*	for(int i=0;i<enqarray.size();i++){

			     String[] enqiury=enqarray.get(i).split("::");
			     System.out.println("sdf"+enqarray.get(i).split("::"));
			     if(!(enqiury[1].trim().equalsIgnoreCase("undefined")|| enqiury[1].trim().equalsIgnoreCase("NaN")||enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()))
			     {
			    	  RDOCNO,SR_NO,BRDID,MODID,SPEC,CLRID,UNIT,FRMDATE,TODATE,RTYPE
		     String sql="update  gl_enqd set SR_NO="+(i+1)+","
		     		   + "BRDID='"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
				       + "MODID='"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")|| enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
				       + "SPEC='"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
				       + "CLRID='"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
				       + "RTYPE='"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
				       + "FRMDATE='"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:ClsCommon.changeStringtoSqlDate(enqiury[6].trim()))+"',"
				       + "TODATE='"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:ClsCommon.changeStringtoSqlDate(enqiury[7].trim()))+"',"
				       + "UNIT='"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"' where rdocno="+docno+"";

		     //System.out.println(""+sql);
		     int resultSet4 = stmtEnquiry.executeUpdate(sql);
		     if(resultSet4<=0)
             {
                 return false;
                } 
			     }

				     }
			 */

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

	public boolean delete(int docno,Date sqlStartDate,String clid,String clname,String address,String mobile,int general,int client,String remarks,
			String clEmail,ArrayList<String> enqarray,HttpSession session,String mode,String Dtype,String telno,int sourceid,String cperson,int cpersonid,String cnt,int cmbprocess,String labreq,String clbcnfrm,String spclinsts,String adjspec,String alwinst,String modreq,String paytrms,String hidexpdate,String expdate,String stmtcnfrm,String dispinst,String clbduedate,String clbprdacpt,String clbmthdusd) throws SQLException {

		try{
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);  
			CallableStatement stmtEnquiry = conn.prepareCall("{call enquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtEnquiry.setInt(14,docno);
			stmtEnquiry.setInt(20,0);
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
			stmtEnquiry.setInt(16,sourceid);
			stmtEnquiry.setString(17,cperson);
			stmtEnquiry.setInt(18,cpersonid);
			stmtEnquiry.setString(19,"");
			stmtEnquiry.setInt(21,cmbprocess);
			stmtEnquiry.setInt(22,Integer.parseInt(labreq));
			stmtEnquiry.setInt(23,Integer.parseInt(clbcnfrm));
			stmtEnquiry.setString(24,spclinsts);
			stmtEnquiry.setInt(25,Integer.parseInt(adjspec));
			stmtEnquiry.setInt(26,Integer.parseInt(alwinst));
			stmtEnquiry.setInt(27,Integer.parseInt(modreq));
			stmtEnquiry.setInt(28,Integer.parseInt(paytrms));
			stmtEnquiry.setString(29,expdate);
			stmtEnquiry.setInt(30,Integer.parseInt(stmtcnfrm));
			stmtEnquiry.setInt(31,Integer.parseInt(dispinst));
			stmtEnquiry.setString(32,clbduedate);
			stmtEnquiry.setInt(33,Integer.parseInt(clbprdacpt));
			stmtEnquiry.setInt(34,Integer.parseInt(clbmthdusd));
			System.out.println(stmtEnquiry);
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
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();


			String sql= ("select cperson,c.tel as tel,area,row_no as cprowno,email,c.mob from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientid+" and a.doc_no="+clientid+"" );
			System.out.println("-------contactpersonSearch----------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public JSONArray typeSearch(HttpSession session) throws SQLException
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
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();


			String sql= ("select 'Callibration' as type union all select 'Repair or Service' as type union all select 'Both' as type" );
			System.out.println("-------typeSearch----------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
				String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1 from my_acbook where  dtype='CRM' and status<>7  " +sqltest);

				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public   JSONArray searchProduct(HttpSession session,String acno,String cmbbilltype,String dates,String clientid,String date,
			String prdname,String brandname,String id,String gridunit,String gridprdname,String scopeid,String category, String subcategory) throws SQLException {

	 	 JSONArray RESULTDATA=new JSONArray();
	 	  
	 	if(!(id.equalsIgnoreCase("1"))){
			return RESULTDATA;
		}
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
	 	   
	 	Connection conn = null;

		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
	     	
				int method=0;
           String condtn="";
				
				if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
					condtn ="  and m.part_no like '%"+prdname+"%' ";
				}
				
				if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
					condtn +="  and bd.brandname like '%"+brandname+"%' ";
				}
				
				gridprdname=gridprdname.replaceAll("@","%");
				if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
					condtn +="  and m.productname like '%"+gridprdname+"%' ";
				}
				
				if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
					condtn +="  and u.unit like '%"+gridunit+"%' ";
				}
				
				if(!(category.equalsIgnoreCase(""))&&!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("0"))){
					condtn +="  and c.category like '%"+category+"%' ";
				}
				
				if(!(subcategory.equalsIgnoreCase(""))&&!(subcategory.equalsIgnoreCase("undefined"))&&!(subcategory.equalsIgnoreCase("0"))){
					condtn +="  and sc.subcategory like '%"+subcategory+"%' ";
				}
				String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
				ResultSet rs=stmtVeh.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				
			    int method1=0;
				String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
				ResultSet rs1=stmtVeh.executeQuery(chk1); 
				if(rs1.next())
					{
								
					method1=rs1.getInt("method");
					}


				String sqlstest="";
							
			    if(method1>0)
				{
				  sqlstest=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  inner join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
				}
			
			    
			    

				int tax=0;
				Statement stmt3 = conn.createStatement (); 
			 
				String chk31="select method  from gl_prdconfig where field_nme='tax' ";
				ResultSet rss3=stmt3.executeQuery(chk31); 
				if(rss3.next())
				{

					tax=rss3.getInt("method");
				}
				
				int temptax=0;
				Statement stmt3111 = conn.createStatement (); 
				String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+acno+"' ";
			 // System.out.println("===sqlss======"+sqlss);
				ResultSet rsss=stmt3111.executeQuery(sqlss);
			    if(rsss.next())
			    {
			    	temptax=rsss.getInt("tax");
			    	
			    }
				if(temptax!=1)
				{
					tax=0;
				}
				String joinsql="";
				
				String fsql="";
				
				String outfsql="";
				
				
				if(tax>0)
				{
					
					java.sql.Date masterdate = null;
					if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			     	{
						masterdate=ClsCommon.changeStringtoSqlDate(dates);
			     		
			     	}
			     	else{
			     
			     	}
				
					
					if(Integer.parseInt(cmbbilltype)>0)
					{
						
						
						
						Statement pv=conn.createStatement();
						int prvdocno=0;
						String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
						ResultSet rs13=pv.executeQuery(dd); 
						if(rs13.next())
						{

							prvdocno=rs13.getInt("prvdocno");
						}
						
						
				/*	joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
					joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid   ";
				
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
					
					outfsql=outfsql+ " taxper ,taxdocno, ";
					
					}
					
				}
				int superseding=0;
				String chk11="select method  from gl_prdconfig where field_nme='superseding'";
				ResultSet rs11=stmtVeh.executeQuery(chk11); 
				if(rs11.next())
				{
					
					superseding=rs11.getInt("method");
				}
					
				if(superseding==1)
				{
					String sql=" select s.part_no,m.* from (  select  bd.doc_no brandid,c.doc_no catid,c.category,sc.doc_no scatid,sc.subcategory,bd.brandname, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
							+ "   left join my_desc de on(de.psrno=m.doc_no)  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
							+ "   where m.status=3 "+condtn+" and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  ) "
						    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;

					System.out.println("-----sql-ASD--"+sql);
		 
					ResultSet resultSet = stmtVeh.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtVeh.close();
				}
				
				else
				{    // left join my_desc de on(de.psrno=m.doc_no) and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'
					String sql="select  bd.doc_no brandid,c.doc_no catid,c.category,sc.doc_no scatid,sc.subcategory,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
							+ "      left join  my_brand bd on m.brandid=bd.doc_no  "
							+ "   where m.status=3 "+condtn+"  "	;
					System.out.println("-----sql-ASD--"+sql);
		 
					ResultSet resultSet = stmtVeh.executeQuery (sql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						stmtVeh.close();	
					
				}
		
				
		/*	String sql="select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
					+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
					+ "   left join my_desc de on(de.psrno=m.doc_no)   left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
					+ "   where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' "	;*/
	 
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
	 return RESULTDATA;
	}
	
	public   ClsEnquiryBean getPrint(int docno,HttpSession session) throws SQLException {
		ClsEnquiryBean bean = new ClsEnquiryBean();
		//  String brhid=session.getAttribute("BRANCHID").toString();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtprint = conn.createStatement ();

			String resql=("Select e.voc_no,DATE_FORMAT(e.date,'%d.%m.%Y') AS date,e.name,e.com_add1,e.mob,e.email  from cl_enqm e where e.doc_no='"+docno+"'  ");

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
				//bean.setLbltypep(pintrs.getString("enqtype"));
				bean.setDocvals(pintrs.getInt("voc_no"));
				//bean.setHidradio(pintrs.getString("contrmode"));
			}


			stmtprint.close();



			Statement stmtinvoice10 = conn.createStatement ();
			/*   String  companysql="select b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from gl_enqm r  "
					    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
					    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";*/
			String  companysql="select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from cl_enqm r inner join my_brch b on  "
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
			conn = ClsConnection.getMyConnection();
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
}
