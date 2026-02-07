package com.it.staffingcontract;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.it.staffingcontract.ClsStaffingContractBean;

import net.sf.json.JSONArray;

public class ClsStaffingContractDAO {
	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();

	public JSONArray mainGridLoad(HttpSession session,String doc_no) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select d.rowno, d.rdocno, d.desigid, case when d.type=1 then 'Hourly' when d.type=2 then 'Daily' when d.type=3 then 'Monthly' else '' end type,d.rate, d.cost, h.desc1 desig , COALESCE(s.service,'') services, COALESCE(t.trade,'') discipline, COALESCE(c.description,'') commodity," 
+" d.comodityid, d.serviceid, d.tradeid, COALESCE(e.name,'') description, d.empid ,d.clientbillrate, d.clientcost,case when d.costtype=1 then 'Hourly' when d.costtype=2 then 'Daily' when d.costtype=3 then 'Monthly' else '' end costtype"
+" from cm_staffcontrd d left join hr_setdesig h on h.doc_no=d.desigid  left join is_comm c on d.comodityid=c.doc_no left join is_trade t on d.tradeid=t.doc_no left join is_service s on d.serviceid=s.doc_no left join hr_empm e on e.doc_no=d.empid"
+" where rdocno='"+doc_no+"'";

			//System.out.println("===sql==contractGridLoad=="+sql);

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
	
	public JSONArray mainGridLoadFromEnq(HttpSession session,String doc_no) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = (" select ser_id serviceid, comodity_id comodityid, trade_id tradeid, c.description commodity,s.service services,t.trade discipline,coalesce(e.name,'')description,coalesce(jd.empid,0)empid,coalesce(e.costperhour,0)cost,coalesce(dg.desc1,'')desig,coalesce(e.desc_id,0)desigid,'Hourly' costtype,0 rate"
+" from gl_enqjobdet jd left join is_comm c on(jd.comodity_id=c.doc_no) left join is_trade t on(jd.trade_id=t.doc_no)" 
+" left join is_service s on(jd.ser_id=s.doc_no) left join hr_empm e on e.doc_no=jd.empid left join hr_setdesig dg on e.desc_id=dg.doc_no where jd.enq_id="+doc_no);

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
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();

			if(id>0){
				String clsql= ("select per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,sal_name as salname,sm.doc_no as salid, ac.curId curid"
						+ " from my_acbook ac left join my_salm sm on(ac.sal_id=sm.doc_no) where  dtype='CRM' and ac.status=3 " +sqltest);

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
		finally{ 
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public JSONArray contactPersonDetailsSearch(String clientdocno,String contactpersonsname,String contactpersonsmobile,String contactpersonsdocno,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    		conn = conobj.getMyConnection();
	    		Statement stmt = conn.createStatement();
			
	    	    String sql = null;
	    	    String sql1 = "";
				
	            if(!((contactpersonsname.equalsIgnoreCase("")) || (contactpersonsname.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and cperson like '%"+contactpersonsname+"%'";
	            }
	            if(!((contactpersonsmobile.equalsIgnoreCase("")) || (contactpersonsmobile.equalsIgnoreCase("0")))){
	                sql1=sql1+" and c.tel like '%"+contactpersonsmobile+"%'";
	            }
	            if(!((contactpersonsdocno.equalsIgnoreCase("")) || (contactpersonsdocno.equalsIgnoreCase("0")))){
	                sql1=sql1+" and row_no like '%"+contactpersonsdocno+"%'";
	            }
				
				sql = "select cperson,c.tel as tel,ar.area,row_no as cprowno,c.mob,c.email from my_crmcontact c left join my_acbook a on (a.doc_no=c.cldocno) left join my_area ar on(c.area_id=ar.doc_no) where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientdocno+" and a.doc_no="+clientdocno+""+sql1;
			//	System.out.println("=========================="+sql);
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=com.convertToJSON(resultSet);
				}
				else{
					stmt.close();
					conn.close();
					return RESULTDATA;
				}
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
	
	public JSONArray enquirySrearch(HttpSession session,String brcid,String msdocno,String Cl_names,String Cl_mobno,String enqdate,String clientid,int id,String cntype,String reftype) throws SQLException {

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

		//String brcid=session.getAttribute("BRANCHID").toString();

		String sqltest="";
		java.sql.Date sqlStartDate=null;
String str1Sql="";
if(reftype.equalsIgnoreCase("ENQ"))
		{
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
			sqltest=sqltest+" and m.date<="+sqlStartDate+"";
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}
		if(!(Cl_mobno.equalsIgnoreCase("undefined"))&&!(Cl_mobno.equalsIgnoreCase(""))&&!(Cl_mobno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.com_mob like '%"+Cl_mobno+"%'";
		}
		if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.cldocno="+clientid+"";
		}
		if(!(cntype.equalsIgnoreCase("undefined"))&&!(cntype.equalsIgnoreCase(""))&&!(cntype.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.contrmode='"+cntype+"'";
		}
}
		else{
			if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
			{
				sqlStartDate = com.changeStringtoSqlDate(enqdate);
				sqltest=sqltest+" and sm.date<="+sqlStartDate+"";
			}
			if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and sm.doc_no like '%"+msdocno+"%'";
			}
			if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
			}
			if(!(Cl_mobno.equalsIgnoreCase("undefined"))&&!(Cl_mobno.equalsIgnoreCase(""))&&!(Cl_mobno.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and ac.com_mob like '%"+Cl_mobno+"%'";
			}
			if(!(clientid.equalsIgnoreCase("undefined"))&&!(clientid.equalsIgnoreCase(""))&&!(clientid.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and ac.cldocno="+clientid+"";
			}
			if(!(cntype.equalsIgnoreCase("undefined"))&&!(cntype.equalsIgnoreCase(""))&&!(cntype.equalsIgnoreCase("0"))){
				sqltest=sqltest+" and sm.ref_type='"+cntype+"'";
			}
		}

		Connection conn =null;
		Statement stmt = null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();

			if(id>0){

		str1Sql=("select if(m.typess=3,'AMS','Staffing')typess,m.date,m.doc_no,m.voc_no, if(m.cldocno>0,ac.refname,m.name) as name,coalesce(ac.doc_no,0) as clientid, "
					+ "if(m.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),com_add1) as details, "
					+ "if(m.cpersonid>0,c.cperson,coalesce(m.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid, "
					+ "if(m.cpersonid>0,c.mob,coalesce(m.mob,'')) as contmob,m.esttrno,if(m.surveyed=1,'1','2') surveyed,surtrno,concat('MOB',':',c.mob,';','Email',':',c.email,';','Tele',':',c.tel) contactdet, "
					+ "m.sal_id ,coalesce(m.sal_name,'')sal_name, coalesce(m.email,'') as email, coalesce(m.telno,'') as telno, ac.curId curid "
					+ "from gl_enqm m left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) "
					+ "left join cm_staffcontrm ctr on ctr.refno=m.voc_no and ctr.reftype='ENQ' and ctr.brhid=m.brhid "
					+ "left join gl_enqjobdet jd on jd.enq_id=m.doc_no left join my_fileattach a on a.doc_no=m.doc_no and a.status=3 and a.dtype='ENQ' left join my_attach_type at on(at.doc_no=a.ref_id) "
					+ "where m.prcdcreate=1 and m.status=3 and m.typess=4 and jd.statupdt=4 and trim(at.type_name)='LPO' and ctr.doc_no is null and m.brhid="+brcid+" "+sqltest+" group by m.doc_no order by m.doc_no");
		
		//System.out.println("======enqsearch===="+str1Sql);

				ResultSet resultSet = stmt.executeQuery(str1Sql);
				RESULTDATA=com.convertToJSON(resultSet);
				stmt.close();
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
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
					
					//System.out.println("*******salesManDetailsSearch*********"+consql);	
					
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

	public JSONArray desigSearch(HttpSession session) throws SQLException{


			JSONArray RESULTDATA1=new JSONArray();

			Connection conn=null;
			try {
				conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement();

				String sql = "";

				sql="select doc_no desigid,desc1 desig from hr_setdesig where status=3 order by desc1";


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

	public int insert(java.sql.Date stDate,String reftype,String refno,int clientid,String cpid,String salid,java.sql.Date frmdate,java.sql.Date todate,HttpSession session,String mode,String formcode,int curid, Double currate, int pholiday, Double taxper, ArrayList<String> gridList,HttpServletRequest request,String brchid) throws SQLException{
			
			Connection conn=null;
			CallableStatement stmtStc=null;
			int  docno=0;
			int jobresultSet=0;
			
			try {
				
				conn=conobj.getMyConnection();
				conn.setAutoCommit(false);
				
				stmtStc = conn.prepareCall("{CALL  staffcontractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
			      // main
				stmtStc.setDate(1,stDate);
				stmtStc.setString(2,reftype);
				stmtStc.setString(3,refno==""||refno==null?"0":refno);
				stmtStc.setInt(4,clientid);
				stmtStc.setString(5,cpid.equalsIgnoreCase("")?"0":cpid);
				stmtStc.setString(6,salid.equalsIgnoreCase("")||salid==null?"0":salid);
				stmtStc.setDate(7,frmdate);
				stmtStc.setDate(8,todate);
				stmtStc.setString(9,session.getAttribute("USERID").toString());
				stmtStc.setString(10,brchid);
				stmtStc.setInt(11,curid);
				stmtStc.setDouble(12,currate);
				stmtStc.setInt(13,pholiday);
				stmtStc.setDouble(14,taxper);
				stmtStc.registerOutParameter(15, java.sql.Types.INTEGER);
				stmtStc.setString(16,mode);
				stmtStc.setString(17,formcode);
				stmtStc.registerOutParameter(18, java.sql.Types.INTEGER);

				stmtStc.executeQuery();
				int docNo=stmtStc.getInt("docNo");
				int vocno=stmtStc.getInt("vocNo");
				request.setAttribute("docNo", docNo);
				request.setAttribute("vocno", vocno);
				docno=stmtStc.getInt("docNo");
			     
			     if(docNo>0) {
			    	 
					   for(int i=0;i< gridList.size() ;i++){
							  String[] jobdetgridarray=((String) gridList.get(i)).split("::");
							  if(!(jobdetgridarray[0].trim().equalsIgnoreCase("undefined")|| jobdetgridarray[0].trim().equalsIgnoreCase("NaN")||jobdetgridarray[0].trim().equalsIgnoreCase("")||jobdetgridarray[0].trim().equalsIgnoreCase("null")|| jobdetgridarray[0].isEmpty()))
								{
							   String sql="";
							   int j=1;
							   
									   
							   sql="INSERT INTO cm_staffcontrd(rdocno, desigid, type, rate, cost, serviceid, tradeid, comodityid, empid, clientbillrate, costtype, clientcost) values('"+docNo+"',"
									      + "'"+(jobdetgridarray[0].trim().equalsIgnoreCase("undefined")||jobdetgridarray[0]==null  || jobdetgridarray[0].trim().equalsIgnoreCase("") || jobdetgridarray[0].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[0].isEmpty()?0:jobdetgridarray[0].trim())+"',"
										  + "'"+(jobdetgridarray[1].trim().equalsIgnoreCase("undefined")||jobdetgridarray[1]==null  || jobdetgridarray[1].trim().equalsIgnoreCase("") || jobdetgridarray[1].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[1].isEmpty()?0:jobdetgridarray[1].trim())+"',"
										  + "'"+(jobdetgridarray[2].trim().equalsIgnoreCase("undefined")||jobdetgridarray[2]==null  || jobdetgridarray[2].trim().equalsIgnoreCase("") || jobdetgridarray[2].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[2].isEmpty()?0:jobdetgridarray[2].trim())+"',"
										  + "'"+(jobdetgridarray[3].trim().equalsIgnoreCase("undefined")||jobdetgridarray[3]==null  || jobdetgridarray[3].trim().equalsIgnoreCase("") || jobdetgridarray[3].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[3].isEmpty()?0:jobdetgridarray[3].trim())+"',"
										  + "'"+(jobdetgridarray[6].trim().equalsIgnoreCase("undefined")||jobdetgridarray[6]==null  || jobdetgridarray[6].trim().equalsIgnoreCase("") || jobdetgridarray[6].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[6].isEmpty()?0:jobdetgridarray[6].trim())+"',"
										  + "'"+(jobdetgridarray[7].trim().equalsIgnoreCase("undefined")||jobdetgridarray[7]==null  || jobdetgridarray[7].trim().equalsIgnoreCase("") || jobdetgridarray[7].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[7].isEmpty()?0:jobdetgridarray[7].trim())+"',"
										  + "'"+(jobdetgridarray[8].trim().equalsIgnoreCase("undefined")||jobdetgridarray[8]==null  || jobdetgridarray[8].trim().equalsIgnoreCase("") || jobdetgridarray[8].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[8].isEmpty()?0:jobdetgridarray[8].trim())+"',"
										  + "'"+(jobdetgridarray[9].trim().equalsIgnoreCase("undefined")||jobdetgridarray[9]==null  || jobdetgridarray[9].trim().equalsIgnoreCase("") || jobdetgridarray[9].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[9].isEmpty()?0:jobdetgridarray[9].trim())+"',"
										  + "'"+(jobdetgridarray[10].trim().equalsIgnoreCase("undefined")||jobdetgridarray[10]==null  || jobdetgridarray[10].trim().equalsIgnoreCase("") || jobdetgridarray[10].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[10].isEmpty()?0:jobdetgridarray[10].trim())+"',"
										  + "'"+(jobdetgridarray[11].trim().equalsIgnoreCase("undefined")||jobdetgridarray[11]==null  || jobdetgridarray[11].trim().equalsIgnoreCase("") || jobdetgridarray[11].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[11].isEmpty()?0:jobdetgridarray[11].trim())+"',"
										  + "'"+(jobdetgridarray[12].trim().equalsIgnoreCase("undefined")||jobdetgridarray[12]==null  || jobdetgridarray[12].trim().equalsIgnoreCase("") || jobdetgridarray[12].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[12].isEmpty()?0:jobdetgridarray[12].trim())+"')";
									//	  System.out.println("==arraysql===+"+sql);
										  
										  jobresultSet = stmtStc.executeUpdate (sql);
										  j=j+1;
										  if(jobresultSet<=0)
										     {
										    	 return 0; 
										     }
								}
							   
					   }
				   }
			     conn.commit();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				stmtStc.close();
				conn.close();
			}
			return docno;
		}
			
	public int update(int sdocno,java.sql.Date stDate,String reftype,String refno,int clientid,String cpid,String salid,java.sql.Date frmdate,java.sql.Date todate,HttpSession session,String mode,String formcode,int curid, Double currate, int pholiday, Double taxper, ArrayList<String> gridList,HttpServletRequest request,String brchid) throws SQLException{
		Connection conn=null;
		CallableStatement stmtStc=null;
		int  docno=0;
		int jobresultSet=0;
		
		try {
			
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			
			stmtStc = conn.prepareCall("{CALL  staffcontractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
		      // main
			stmtStc.setDate(1,stDate);
			stmtStc.setString(2,reftype);
			stmtStc.setString(3,refno=="" || refno==null?"0":refno);
			stmtStc.setInt(4,clientid);
			stmtStc.setString(5,cpid.equalsIgnoreCase("")?"0":cpid);
			stmtStc.setString(6,salid.equalsIgnoreCase("")||salid==null?"0":salid);
			stmtStc.setDate(7,frmdate);
			stmtStc.setDate(8,todate);
			stmtStc.setString(9,session.getAttribute("USERID").toString());
			stmtStc.setString(10,brchid);
			stmtStc.setInt(11,curid);
			stmtStc.setDouble(12,currate);
			stmtStc.setInt(13,pholiday);
			stmtStc.setDouble(14,taxper);
			stmtStc.setInt(15,sdocno);
			stmtStc.setString(16,mode);
			stmtStc.setString(17,formcode);
			stmtStc.setInt(18, 0);
			stmtStc.executeUpdate();
			int docNo=stmtStc.getInt("docNo");
			int vocno=stmtStc.getInt("vocNo");
			request.setAttribute("docNo", docNo);
		     
		     if(docNo>0) {
		    	 
				   for(int i=0;i< gridList.size() ;i++){
						  String[] jobdetgridarray=((String) gridList.get(i)).split("::");
						  String sql="";
						  if(!(jobdetgridarray[0].trim().equalsIgnoreCase("undefined")|| jobdetgridarray[0].trim().equalsIgnoreCase("NaN")||jobdetgridarray[0].trim().equalsIgnoreCase("")||jobdetgridarray[0].trim().equalsIgnoreCase("null")|| jobdetgridarray[0].isEmpty()))
							{
						  if(!(jobdetgridarray[4].trim().equalsIgnoreCase("undefined")|| jobdetgridarray[4].trim().equalsIgnoreCase("NaN")||jobdetgridarray[4].trim().equalsIgnoreCase("")||jobdetgridarray[4].trim().equalsIgnoreCase("null")|| jobdetgridarray[4].isEmpty()))
							{
										
						   sql="update cm_staffcontrd set "
								    + "desigid='"+(jobdetgridarray[0].trim().equalsIgnoreCase("undefined")||jobdetgridarray[0]==null  || jobdetgridarray[0].trim().equalsIgnoreCase("") || jobdetgridarray[0].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[0].isEmpty()?0:jobdetgridarray[0].trim())+"',"
									+ "type='"+(jobdetgridarray[1].trim().equalsIgnoreCase("undefined")||jobdetgridarray[1]==null  || jobdetgridarray[1].trim().equalsIgnoreCase("") || jobdetgridarray[1].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[1].isEmpty()?0:jobdetgridarray[1].trim())+"',"
								    + "rate='"+(jobdetgridarray[2].trim().equalsIgnoreCase("undefined")||jobdetgridarray[2]==null  || jobdetgridarray[2].trim().equalsIgnoreCase("") || jobdetgridarray[2].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[2].isEmpty()?0:jobdetgridarray[2].trim())+"',"
									+ "cost='"+(jobdetgridarray[3].trim().equalsIgnoreCase("undefined")||jobdetgridarray[3]==null  || jobdetgridarray[3].trim().equalsIgnoreCase("") || jobdetgridarray[3].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[3].isEmpty()?0:jobdetgridarray[3].trim())+"',"
									+ "serviceid='"+(jobdetgridarray[6].trim().equalsIgnoreCase("undefined")||jobdetgridarray[6]==null  || jobdetgridarray[6].trim().equalsIgnoreCase("") || jobdetgridarray[6].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[6].isEmpty()?0:jobdetgridarray[6].trim())+"',"
									+ "tradeid='"+(jobdetgridarray[7].trim().equalsIgnoreCase("undefined")||jobdetgridarray[7]==null  || jobdetgridarray[7].trim().equalsIgnoreCase("") || jobdetgridarray[7].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[7].isEmpty()?0:jobdetgridarray[7].trim())+"',"
									+ "comodityid='"+(jobdetgridarray[8].trim().equalsIgnoreCase("undefined")||jobdetgridarray[8]==null  || jobdetgridarray[8].trim().equalsIgnoreCase("") || jobdetgridarray[8].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[8].isEmpty()?0:jobdetgridarray[8].trim())+"',"
									+ "empid='"+(jobdetgridarray[9].trim().equalsIgnoreCase("undefined")||jobdetgridarray[9]==null  || jobdetgridarray[9].trim().equalsIgnoreCase("") || jobdetgridarray[9].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[9].isEmpty()?0:jobdetgridarray[9].trim())+"',"
									+ "clientbillrate='"+(jobdetgridarray[10].trim().equalsIgnoreCase("undefined")||jobdetgridarray[10]==null  || jobdetgridarray[10].trim().equalsIgnoreCase("") || jobdetgridarray[10].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[10].isEmpty()?0:jobdetgridarray[10].trim())+"',"
									+ "costtype='"+(jobdetgridarray[11].trim().equalsIgnoreCase("undefined")||jobdetgridarray[11]==null  || jobdetgridarray[11].trim().equalsIgnoreCase("") || jobdetgridarray[11].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[11].isEmpty()?0:jobdetgridarray[11].trim())+"',"
									+ "clientcost='"+(jobdetgridarray[12].trim().equalsIgnoreCase("undefined")||jobdetgridarray[12]==null  || jobdetgridarray[12].trim().equalsIgnoreCase("") || jobdetgridarray[12].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[12].isEmpty()?0:jobdetgridarray[12].trim())+"'"
									+ " where rdocno='"+docNo+"' and rowno='"+jobdetgridarray[4].trim()+"' ";
									  //System.out.println("==arrayupdatesql===+"+sql);
							}else{
								 sql="INSERT INTO cm_staffcontrd(rdocno, desigid, type, rate, cost, serviceid, tradeid, comodityid, empid, clientbillrate, costtype, clientcost) values('"+docNo+"',"
									      + "'"+(jobdetgridarray[0].trim().equalsIgnoreCase("undefined")||jobdetgridarray[0]==null  || jobdetgridarray[0].trim().equalsIgnoreCase("") || jobdetgridarray[0].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[0].isEmpty()?0:jobdetgridarray[0].trim())+"',"
										  + "'"+(jobdetgridarray[1].trim().equalsIgnoreCase("undefined")||jobdetgridarray[1]==null  || jobdetgridarray[1].trim().equalsIgnoreCase("") || jobdetgridarray[1].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[1].isEmpty()?0:jobdetgridarray[1].trim())+"',"
										  + "'"+(jobdetgridarray[2].trim().equalsIgnoreCase("undefined")||jobdetgridarray[2]==null  || jobdetgridarray[2].trim().equalsIgnoreCase("") || jobdetgridarray[2].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[2].isEmpty()?0:jobdetgridarray[2].trim())+"',"
										  + "'"+(jobdetgridarray[3].trim().equalsIgnoreCase("undefined")||jobdetgridarray[3]==null  || jobdetgridarray[3].trim().equalsIgnoreCase("") || jobdetgridarray[3].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[3].isEmpty()?0:jobdetgridarray[3].trim())+"',"
										  + "'"+(jobdetgridarray[6].trim().equalsIgnoreCase("undefined")||jobdetgridarray[6]==null  || jobdetgridarray[6].trim().equalsIgnoreCase("") || jobdetgridarray[6].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[6].isEmpty()?0:jobdetgridarray[6].trim())+"',"
										  + "'"+(jobdetgridarray[7].trim().equalsIgnoreCase("undefined")||jobdetgridarray[7]==null  || jobdetgridarray[7].trim().equalsIgnoreCase("") || jobdetgridarray[7].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[7].isEmpty()?0:jobdetgridarray[7].trim())+"',"
										  + "'"+(jobdetgridarray[8].trim().equalsIgnoreCase("undefined")||jobdetgridarray[8]==null  || jobdetgridarray[8].trim().equalsIgnoreCase("") || jobdetgridarray[8].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[8].isEmpty()?0:jobdetgridarray[8].trim())+"',"
										  + "'"+(jobdetgridarray[9].trim().equalsIgnoreCase("undefined")||jobdetgridarray[9]==null  || jobdetgridarray[9].trim().equalsIgnoreCase("") || jobdetgridarray[9].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[9].isEmpty()?0:jobdetgridarray[9].trim())+"',"
										  + "'"+(jobdetgridarray[10].trim().equalsIgnoreCase("undefined")||jobdetgridarray[10]==null  || jobdetgridarray[10].trim().equalsIgnoreCase("") || jobdetgridarray[10].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[10].isEmpty()?0:jobdetgridarray[10].trim())+"',"
										  + "'"+(jobdetgridarray[11].trim().equalsIgnoreCase("undefined")||jobdetgridarray[11]==null  || jobdetgridarray[11].trim().equalsIgnoreCase("") || jobdetgridarray[11].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[11].isEmpty()?0:jobdetgridarray[11].trim())+"',"
										  + "'"+(jobdetgridarray[12].trim().equalsIgnoreCase("undefined")||jobdetgridarray[12]==null  || jobdetgridarray[12].trim().equalsIgnoreCase("") || jobdetgridarray[12].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[12].isEmpty()?0:jobdetgridarray[12].trim())+"')";
											 // System.out.println("==arraysql===+"+sql);
						    }
//									  jobresultSet = stmtStc.execute(sql);
									  if(stmtStc.execute(sql))
									     {
										  conn.close();
									     }
							} 
						   
				   }
			   }
		     conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			
			stmtStc.close();
			conn.close();
			
		}
		return 1;
		}
		
	public int delete(int docno,HttpSession session) throws SQLException{
			
			int result=0;
	        Connection conn=null;
	        Statement cpstmt =null;
	        int tranentry=0;
			
	        try {
				
				conn=conobj.getMyConnection();
				conn.setAutoCommit(false);
				cpstmt = conn.createStatement ();
				
				String sql="update cm_staffcontrm set status=7 where doc_no="+docno+" ";
				int resultSet = cpstmt.executeUpdate(sql);
				
				if(resultSet>0) {
					result=1;
					conn.commit();
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
				cpstmt.close();
			}
			return result;
		}
		
	public ClsStaffingContractBean getViewDetails(HttpSession session,int docNo) throws SQLException {
			ClsStaffingContractBean clsEnqBean = new ClsStaffingContractBean();

			Connection conn =null;
	 		Statement stmtCPV0 =null;
	 		
	 		try {
	 		 
	 			conn = conobj.getMyConnection();
	 			stmtCPV0 = conn.createStatement ();
			
				String strSql = "select m.voc_no,m.date,m.reftype,m.refno,m.cldocno,m.cpersonid cpid,m.salid,m.fromdt,m.todt,"
						+ "coalesce(ac.refname,'') refname,coalesce(ac.per_tel,'') tel,coalesce(ac.per_mob,'') mob,"
						+ "coalesce(ac.mail1,'') email,coalesce(ac.address,'') address,s.sal_name,c.cperson ,m.curid, m.rate "
						+ "from cm_staffcontrm m  left join my_acbook ac on ac.doc_no=m.cldocno "
						+ "left join my_salm s on s.doc_no=m.salid "
						+ "left join my_crmcontact c on c.row_no=m.cpersonid where ac.dtype='CRM'";
				ResultSet resultSet = stmtCPV0.executeQuery(strSql);
	
				while (resultSet.next()) {
					
					clsEnqBean.setDocno(docNo);
					clsEnqBean.setTxtrefno(resultSet.getString("refno"));
					clsEnqBean.setJqxIenqDate(resultSet.getString("date"));
					clsEnqBean.setHidjqxIenqDate(resultSet.getString("date"));
					clsEnqBean.setTxtclientname(resultSet.getString("cldocno"));
					clsEnqBean.setTxtclientdet(resultSet.getString("refname"));
					clsEnqBean.setTxtcontactperson(resultSet.getString("cperson"));
					clsEnqBean.setClientid(resultSet.getInt("cldocno"));
				    clsEnqBean.setCptrno(resultSet.getString("cpid"));
					clsEnqBean.setTxtaddress(resultSet.getString("address"));
					clsEnqBean.setTxtsalesman(resultSet.getString("sal_name"));
					clsEnqBean.setTxtsalesmandocno(resultSet.getString("salid"));
					clsEnqBean.setTxtmobile(resultSet.getString("mob"));
					clsEnqBean.setTxttelno(resultSet.getString("tel"));
					clsEnqBean.setTxtemail(resultSet.getString("mail"));
					clsEnqBean.setJqxIfrmDate(resultSet.getString("fromdt"));
					clsEnqBean.setHidjqxIfrmDate(resultSet.getString("fromdt"));
					clsEnqBean.setJqxItoDate(resultSet.getString("todt"));
					clsEnqBean.setHidjqxItoDate(resultSet.getString("todt"));
					clsEnqBean.setClientcurid(resultSet.getInt("curid"));
					clsEnqBean.setClientcurrate(resultSet.getDouble("rate"));
					
				}
			}
			catch(Exception e){
			e.printStackTrace();
			}
	 		finally{
	 			stmtCPV0.close();
				conn.close();
				}
			
			return clsEnqBean;
			}

	public JSONArray mainSrearch(HttpSession session,String brcid,String sclname,String smob,String dcno,String refno,int check) throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	    	    	
	        //String brcid=session.getAttribute("BRANCHID").toString();

	    	String sqltest="";
	    	
	    	if(!(sclname.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and ac.refname like '"+sclname+"%'";
	    	}
	    	if(!(smob.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and ac.per_mob like '"+smob+"'";
	    	}
	    	if(!(dcno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and m.voc_no like '"+dcno+"%'";
	    	}
	    	if(!(refno.equalsIgnoreCase(""))){
	    		sqltest=sqltest+" and m.refno='"+refno+"%'";
	    	}
	 
	    	Connection conn =null;
	  		Statement stmtEnq =null;
	  		
	  		try {
	  		 
	  				conn = conobj.getMyConnection();
	  				stmtEnq = conn.createStatement();
	  			
	  				if(check>0){
					
	  					String str1Sql="select m.doc_no,m.voc_no,m.date,m.reftype,m.refno,if(m.refno!=0,if(eq.typess=3,'AMS','Staffing'),'')txtenqtype,m.cldocno,m.cpersonid cpid,m.salid,m.fromdt,m.todt, "
	  							+ "	coalesce(ac.refname,'') refname,coalesce(ac.per_tel,coalesce(eq.telno,'')) tel, coalesce(ac.per_mob,coalesce(eq.mob,'')) mob, "
	  							+ "	coalesce(ac.mail1,coalesce(eq.email,'')) email,coalesce(ac.address,'') address,coalesce(s.sal_name,'') sal_name,c.cperson,m.curid, m.rate currate, m.pholiday, m.taxper  "
	  							+ "	from cm_staffcontrm m  left join my_acbook ac on ac.doc_no=m.cldocno "
	  							+ "	left join my_salm s on s.doc_no=m.salid left join gl_enqm eq on m.refno=eq.voc_no and m.reftype='ENQ' and m.brhid=eq.brhid "
	  							+ "	left join my_crmcontact c on c.row_no=m.cpersonid where ac.dtype='CRM' and m.status='3' and m.brhid="+brcid+" "+sqltest+" order by m.doc_no";
	  					//System.out.println("=========="+str1Sql);
	         		ResultSet resultSet = stmtEnq.executeQuery (str1Sql);
	  					RESULTDATA=com.convertToJSON(resultSet);
	  				
	  				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
	  		finally{
	  			stmtEnq.close();
				conn.close();
				}
	        return RESULTDATA;
	    }

	public JSONArray comodityDetailsSearch(String docno, String service,
				String discipline, String comodities, String chk)
				throws SQLException {
			JSONArray RESULTDATA = new JSONArray();
			Connection conn = null;
			Statement stmt = null;
			try {
				conn = conobj.getMyConnection();
				stmt = conn.createStatement();
				String sql = null;
				String sql1 = "";

				if (!((docno.equalsIgnoreCase("")) || (docno.equalsIgnoreCase("0")))) {
					sql1 = sql1 + " and c.doc_no='" + docno + "'";
				}
				if (!((service.equalsIgnoreCase("")) || (service
						.equalsIgnoreCase("0")))) {
					sql1 = sql1 + " and service like '%" + service + "%'";
				}
				if (!((discipline.equalsIgnoreCase("")) || (discipline
						.equalsIgnoreCase("0")))) {
					sql1 = sql1 + " and trade like '%" + discipline + "%'";
				}
				if (!((comodities.equalsIgnoreCase("")) || (comodities
						.equalsIgnoreCase("0")))) {
					sql1 = sql1 + " and description like '%" + comodities + "%'";
				}

				sql = "select c.doc_no as doc_no,description as comodity,trade as discipline,service,serid,tradeid from is_comm c inner join is_trade t on(t.doc_no=c.tradeId) inner join is_service s on(s.doc_no=c.serId) where 1=1"
						+ sql1;

				if (chk.equalsIgnoreCase("1")) {
					ResultSet resultSet1 = stmt.executeQuery(sql);
					RESULTDATA = com.convertToJSON(resultSet1);
				} else {
					stmt.close();
					conn.close();
					return RESULTDATA;
				}
				stmt.close();
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
				conn.close();
			} finally {
				stmt.close();
				conn.close();
			}
			return RESULTDATA;
		}
		
	public JSONArray employeeDetailsSearch(String empid,String empname,String check) throws SQLException {
	    	JSONArray RESULTDATA=new JSONArray();
	          
	    	if(!(check.equalsIgnoreCase("1"))){
				return RESULTDATA;
			}
	    	
	         Connection conn = null; 
	         
	        try {
	        	
	            conn = conobj.getMyConnection();   
	            Statement stmtBDT = conn.createStatement();
	            String sql1="";
	           
	            if(!(empid.equalsIgnoreCase("") || empid.equalsIgnoreCase("0"))){
	            	sql1+=" and m.codeno="+empid+"";
	            }
	            
	            if(!(empname.equalsIgnoreCase("") || empname.equalsIgnoreCase("0"))){
	            	sql1+=" and m.name like '%"+empname+"%'";
	            }
	            
	            String sql="select m.doc_no,m.codeno,m.name,m.costperhour,m.desc_id desigid,dg.desc1 desig from hr_empm m left join hr_setdesig dg on m.desc_id=dg.doc_no where m.status=3 and m.active=1 "+sql1+"";
	            
	            ResultSet resultSet = stmtBDT.executeQuery(sql);
	            RESULTDATA=com.convertToJSON(resultSet);
	           
	            stmtBDT.close();
	            conn.close();
	        } catch(Exception e){
	          e.printStackTrace();
	          conn.close();
	        } finally{
	      conn.close();
	     }
	          return RESULTDATA;
	     }
			
}
