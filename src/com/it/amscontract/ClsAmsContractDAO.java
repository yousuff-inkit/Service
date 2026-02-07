package com.it.amscontract;

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
import com.it.amscontract.ClsAmsContractBean;

import net.sf.json.JSONArray;

public class ClsAmsContractDAO {
	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();

	public JSONArray mainGridLoad(HttpSession session,String doc_no) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select a.rdocno,eq.sr_no,eq.rowno, (SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
					+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.surv_id) order by doc_no) surtype,eq.site,grp.groupname area,eq.remarks, eq.areaid,eq.steamid,m.grpcode serviceteam,  "
					+ "eq.surv_id surid  from cm_amssited eq  left  join (select eq.rdocno,eq.surv_id,eq.sr_no   "
					+ "from cm_amssited eq where eq.rdocno="+ doc_no+ ") a on (a.rdocno =eq.rdocno and a.sr_no=eq.sr_no) "
					+ "left join my_groupvals grp on grp.doc_no=eq.areaid and grp.grptype='area' left join cm_serteamm m on m.doc_no=eq.steamid where eq.rdocno="+ doc_no + "";

			System.out.println("===sql==contractGridLoad=="+sql);

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

			String sql = "select a.rdocno,eq.sr_no,eq.rowno, (SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
					+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.surv_id) order by doc_no) surtype,eq.site,grp.groupname area,eq.remarks, eq.areaid, "
					+ "eq.surv_id surid  from gl_enqsited eq  left  join (select eq.rdocno,eq.surv_id,eq.sr_no   "
					+ "from gl_enqsited eq where eq.rdocno="+ doc_no+ ") a on (a.rdocno =eq.rdocno and a.sr_no=eq.sr_no) "
					+ "left join my_groupvals grp on grp.doc_no=eq.areaid and grp.grptype='area'  where eq.rdocno="+ doc_no + "";

			//System.out.println(sql);
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

		str1Sql=("select if(m.typess=3,'AMS','')typess,m.date,m.doc_no,m.voc_no, if(m.cldocno>0,ac.refname,m.name) as name,coalesce(ac.doc_no,0) as clientid, "
					+ "if(m.cldocno>0,concat(coalesce(ac.address,''),',',coalesce(ac.com_mob,'') ,',',coalesce(ac.mail1,'') ),com_add1) as details, "
					+ "if(m.cpersonid>0,c.cperson,coalesce(m.cperson,'')) as cperson,coalesce(c.row_no,0) as cpersonid, "
					+ "if(m.cpersonid>0,c.mob,coalesce(m.mob,'')) as contmob,m.esttrno,if(m.surveyed=1,'1','2') surveyed,surtrno,concat('MOB',':',c.mob,';','Email',':',c.email,';','Tele',':',c.tel) contactdet, "
					+ "m.sal_id ,coalesce(m.sal_name,'')sal_name, coalesce(m.email,'') as email, coalesce(m.telno,'') as telno, ac.curId curid "
					+ "from gl_enqm m left join my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_crmcontact c on(c.row_no=m.cpersonid) "
					+ "left join cm_amscontrm ctr on ctr.refno=m.voc_no and ctr.reftype='ENQ' and ctr.brhid=m.brhid "
					+ "where m.status=3 and m.typess in(3) and ctr.doc_no is null and m.brhid="+brcid+" "+sqltest+" order by m.doc_no");
		
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

	public JSONArray mainSrearch(HttpSession session,String brcid, String sclname,String smob,String dcno,String refno,int check) throws SQLException {

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
  							+ "	coalesce(ac.mail1,coalesce(eq.email,'')) email,coalesce(ac.address,'') address,coalesce(s.sal_name,'') sal_name,c.cperson,m.curid, m.rate currate,"
  							+ " partnerclient, noofmonths, amount, billfrequency, extrahrsrate, supporthrs, carryforwards, cfmaxper, cfminper, m.taxper "
  							+ "	from cm_amscontrm m  left join my_acbook ac on ac.doc_no=m.cldocno "
  							+ "	left join my_salm s on s.doc_no=m.salid left join gl_enqm eq on m.refno=eq.voc_no and m.reftype='ENQ' and m.brhid=eq.brhid "
  							+ "	left join my_crmcontact c on c.row_no=m.cpersonid where ac.dtype='CRM' and m.status='3' and m.brhid="+brcid+" "+sqltest+" order by m.doc_no";
  				
  					System.out.println(str1Sql);
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

	public JSONArray areaSearch(HttpSession session) throws SQLException {

	JSONArray RESULTDATA1 = new JSONArray();

	Connection conn = null;
	try {
		conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();

		String sql = "select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";

		ResultSet resultSet1 = stmt.executeQuery(sql);
		RESULTDATA1 = com.convertToJSON(resultSet1);

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		conn.close();
	}

	return RESULTDATA1;
}

	public int insert(java.sql.Date stDate,String reftype,String refno,int clientid,String cpid,String salid,java.sql.Date frmdate,java.sql.Date todate,HttpSession session,String mode,String formcode,int curid, Double currate, String partnerclient, int noofmonths, Double amount, int billfrequency, Double extrahrsrate, Double supporthrs, int carryforwards, Double cfmaxper, Double cfminper, Double taxper, ArrayList<String> gridList,HttpServletRequest request,String brchid) throws SQLException{
			
			Connection conn=null;
			CallableStatement stmtStc=null;
			int docno=0;
			
			try {
				
				conn=conobj.getMyConnection();
				conn.setAutoCommit(false);
				
				stmtStc = conn.prepareCall("{CALL amscontractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
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
				stmtStc.setString(13,partnerclient);
				stmtStc.setInt(14,noofmonths);
				stmtStc.setDouble(15,amount);
				stmtStc.setInt(16,billfrequency);
				stmtStc.setDouble(17,extrahrsrate);
				stmtStc.setDouble(18,supporthrs);
				stmtStc.setInt(19,carryforwards);
				stmtStc.setDouble(20,cfmaxper);
				stmtStc.setDouble(21,cfminper);
				stmtStc.setDouble(22,taxper);
				stmtStc.registerOutParameter(23, java.sql.Types.INTEGER);
				stmtStc.setString(24,mode);
				stmtStc.setString(25,formcode);
				stmtStc.registerOutParameter(26, java.sql.Types.INTEGER);
				
				stmtStc.executeQuery();
				int docNo=stmtStc.getInt("docNo");
				int vocno=stmtStc.getInt("vocNo");
				request.setAttribute("docNo", docNo);
				request.setAttribute("vocno", vocno);
				docno=stmtStc.getInt("docNo");
			     
			     if(docNo>0) {
			    	 
			    	 for (int i = 0; i < gridList.size(); i++) {

						String[] sitestring = gridList.get(i).split("::");

						if (!(sitestring[0].trim().equalsIgnoreCase("undefined")
								|| sitestring[0].trim().equalsIgnoreCase("NaN")
								|| sitestring[0].trim().equalsIgnoreCase("") || sitestring[0]
									.isEmpty())) {
						
							String sql = "INSERT INTO cm_amssited(sr_no, site, remarks, areaid,surv_id,steamid,empgroupid,rdocno)VALUES"
									+ " ("
									+ (i + 1)
									+ ","
									+ "'"
									+ (sitestring[0].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[0].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[0].trim()
													.equalsIgnoreCase("")
											|| sitestring[0].isEmpty() ? 0
											: sitestring[0].trim())
									+ "',"
									+ "'"
									+ (sitestring[1].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[1].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[1].trim()
													.equalsIgnoreCase("")
											|| sitestring[1].isEmpty() ? 0
											: sitestring[1].trim())
									+ "',"
									+ "'"
									+ (sitestring[2].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[2].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[2].trim()
													.equalsIgnoreCase("")
											|| sitestring[2].isEmpty() ? 0
											: sitestring[2].trim())
									+ "',"
									+ "'"
									+ (sitestring[3].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[3].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[3].trim()
													.equalsIgnoreCase("")
											|| sitestring[3].isEmpty() ? 0
											: sitestring[3].trim())
									+ "',"
									+ "'"
									+ (sitestring[4].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[4].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[4].trim()
													.equalsIgnoreCase("")
											|| sitestring[4].isEmpty() ? 0
											: sitestring[4].trim())
									+ "',"
									+ "'"
									+ (sitestring[4].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[4].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[4].trim()
													.equalsIgnoreCase("")
											|| sitestring[4].isEmpty() ? 0
											: sitestring[4].trim())
									+ "',"
									+ "'"
									+ docNo + "')";

						
							int resultSetsite2 = stmtStc.executeUpdate(sql);
							if (resultSetsite2 <= 0) {
								conn.close();
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
			
	public int update(int sdocno,java.sql.Date stDate,String reftype,String refno,int clientid,String cpid,String salid,java.sql.Date frmdate,java.sql.Date todate,HttpSession session,String mode,String formcode,int curid, Double currate, String partnerclient, int noofmonths, Double amount, int billfrequency, Double extrahrsrate, Double supporthrs, int carryforwards, Double cfmaxper, Double cfminper, Double taxper, ArrayList<String> gridList,HttpServletRequest request,String brchid) throws SQLException{
		Connection conn=null;
		CallableStatement stmtStc=null;
		
		try {
			
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			
			stmtStc = conn.prepareCall("{CALL amscontractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
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
			
			stmtStc.setString(13,partnerclient);
			stmtStc.setInt(14,noofmonths);
			stmtStc.setDouble(15,amount);
			stmtStc.setInt(16,billfrequency);
			stmtStc.setDouble(17,extrahrsrate);
			stmtStc.setDouble(18,supporthrs);
			stmtStc.setInt(19,carryforwards);
			stmtStc.setDouble(20,cfmaxper);
			stmtStc.setDouble(21,cfminper);
			stmtStc.setDouble(22,taxper);
			stmtStc.setInt(23,sdocno);
			stmtStc.setString(24,mode);
			stmtStc.setString(25,formcode);
			stmtStc.registerOutParameter(26, 0);
			
			stmtStc.executeUpdate();
			int docNo=stmtStc.getInt("docNo");
			int vocno=stmtStc.getInt("vocNo");
			request.setAttribute("docNo", docNo);
		     
		     if(docNo>0) {
		    	 
				String delsitesql = "delete from cm_amssited where rdocno=" + docNo;
				stmtStc.executeUpdate(delsitesql);
					
		    	 for (int i = 0; i < gridList.size(); i++) {

						String[] sitestring = gridList.get(i).split("::");

						if (!(sitestring[0].trim().equalsIgnoreCase("undefined")
								|| sitestring[0].trim().equalsIgnoreCase("NaN")
								|| sitestring[0].trim().equalsIgnoreCase("") || sitestring[0]
									.isEmpty())) {
						
							String sql = "INSERT INTO cm_amssited(sr_no, site, remarks, areaid,surv_id,steamid,empgroupid,rdocno)VALUES"
									+ " ("
									+ (i + 1)
									+ ","
									+ "'"
									+ (sitestring[0].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[0].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[0].trim()
													.equalsIgnoreCase("")
											|| sitestring[0].isEmpty() ? 0
											: sitestring[0].trim())
									+ "',"
									+ "'"
									+ (sitestring[1].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[1].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[1].trim()
													.equalsIgnoreCase("")
											|| sitestring[1].isEmpty() ? 0
											: sitestring[1].trim())
									+ "',"
									+ "'"
									+ (sitestring[2].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[2].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[2].trim()
													.equalsIgnoreCase("")
											|| sitestring[2].isEmpty() ? 0
											: sitestring[2].trim())
									+ "',"
									+ "'"
									+ (sitestring[3].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[3].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[3].trim()
													.equalsIgnoreCase("")
											|| sitestring[3].isEmpty() ? 0
											: sitestring[3].trim())
									+ "',"
									+ "'"
									+ (sitestring[4].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[4].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[4].trim()
													.equalsIgnoreCase("")
											|| sitestring[4].isEmpty() ? 0
											: sitestring[4].trim())
									+ "',"
									+ "'"
									+ (sitestring[4].trim().equalsIgnoreCase(
											"undefined")
											|| sitestring[4].trim().equalsIgnoreCase(
													"NaN")
											|| sitestring[4].trim()
													.equalsIgnoreCase("")
											|| sitestring[4].isEmpty() ? 0
											: sitestring[4].trim())
									+ "',"
									+ "'"
									+ docNo + "')";

						
							int resultSetsite2 = stmtStc.executeUpdate(sql);
							if (resultSetsite2 <= 0) {
								conn.close();
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
				
				String sql="update cm_amscontrm set status=7 where doc_no="+docno+" ";
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
		
	public ClsAmsContractBean getViewDetails(HttpSession session,int docNo) throws SQLException {
			ClsAmsContractBean clsEnqBean = new ClsAmsContractBean();

			Connection conn =null;
	 		Statement stmtCPV0 =null;
	 		
	 		try {
	 		 
	 			conn = conobj.getMyConnection();
	 			stmtCPV0 = conn.createStatement ();
			
				String strSql = "select m.voc_no,m.date,m.reftype,m.refno,m.cldocno,m.cpersonid cpid,m.salid,m.fromdt,m.todt,"
						+ "coalesce(ac.refname,'') refname,coalesce(ac.per_tel,'') tel,coalesce(ac.per_mob,'') mob,"
						+ "coalesce(ac.mail1,'') email,coalesce(ac.address,'') address,s.sal_name,c.cperson ,m.curid, m.rate,"
						+ "partnerclient, noofmonths, amount, billfrequency, extrahrsrate, supporthrs, carryforwards, cfmaxper, cfminper  "
						+ "from cm_amscontrm m left join my_acbook ac on ac.doc_no=m.cldocno "
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
	
}
