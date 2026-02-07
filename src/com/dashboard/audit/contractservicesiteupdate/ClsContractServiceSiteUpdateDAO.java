package com.dashboard.audit.contractservicesiteupdate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsContractServiceSiteUpdateDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon cm=new ClsCommon();
	
	public int insert(String docNo, ArrayList<String> sitelist, HttpSession session,HttpServletRequest request) throws SQLException{
		Connection conn = null;
		int val = 0;
		try{
		 	 conn = ClsConnection.getMyConnection();
			 Statement stmt=conn.createStatement();
			 String sql=null;
			
					List<String> listAllSites = new ArrayList<>();
					List<String> listAvailableNow = new ArrayList<>();
					
					String sitesql="select rowno from cm_srvcsited where tr_no="+docNo+"";
					ResultSet resultrowno = stmt.executeQuery(sitesql);
					while(resultrowno.next()){
						listAllSites.add(resultrowno.getString("rowno"));
					}

					for(int i=0;i<sitelist.size();i++){

						String[] surveydet=((String) sitelist.get(i)).split("::");
						if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()))
						{
						
							listAvailableNow.add(surveydet[4].trim());
							
							if(!(surveydet[4].trim().equalsIgnoreCase("undefined")|| surveydet[4].trim().equalsIgnoreCase("NaN")||surveydet[4].trim().equalsIgnoreCase("")|| surveydet[4].isEmpty()))
							{
							String sql3="update cm_srvcsited set site='"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
									+ "areaId='"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
									+ "siteadd='"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
									+ "contactid='"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
									+ "srvteamno='"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"'"
									+ " where tr_no='"+docNo+"' and rowno="+surveydet[4].trim()+" ";
							
							int result = stmt.executeUpdate(sql3);
							}
							else{
								
								String sqlsn="INSERT INTO cm_srvcsited(sr_no, site, areaId, siteadd, contactid,srvteamno,tr_no)VALUES"
										+ " ("+(i+1)+","
										+ "'"+(surveydet[0].trim().equalsIgnoreCase("undefined") || surveydet[0].trim().equalsIgnoreCase("NaN")|| surveydet[0].trim().equalsIgnoreCase("")|| surveydet[0].isEmpty()?0:surveydet[0].trim())+"',"
										+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
										+ "'"+(surveydet[2].trim().equalsIgnoreCase("undefined") || surveydet[2].trim().equalsIgnoreCase("NaN")|| surveydet[2].trim().equalsIgnoreCase("")|| surveydet[2].isEmpty()?0:surveydet[2].trim())+"',"
										+ "'"+(surveydet[3].trim().equalsIgnoreCase("undefined") || surveydet[3].trim().equalsIgnoreCase("NaN")|| surveydet[3].trim().equalsIgnoreCase("")|| surveydet[3].isEmpty()?0:surveydet[3].trim())+"',"
										+ "'"+(surveydet[5].trim().equalsIgnoreCase("undefined") || surveydet[5].trim().equalsIgnoreCase("NaN")|| surveydet[5].trim().equalsIgnoreCase("")|| surveydet[5].isEmpty()?0:surveydet[5].trim())+"',"
										+"'"+docNo+"')";

								int res = stmt.executeUpdate (sqlsn);
								if(res<=0)
								{
									conn.close();
									return 0;
								}
								
							}

						}

					}
					
					for (String item : listAllSites) {
					    if (listAvailableNow.contains(item)) {
					    	//Duplicates
					    } else {
					    	String delsite="delete from cm_srvcsited where tr_no='"+docNo+"' and rowno='"+item+"'";
							int delsiteval=stmt.executeUpdate (delsite);
					    	
					    }
					}
		
		 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docNo+"','"+session.getAttribute("BRANCHID").toString()+"','BCSU',now(),'"+session.getAttribute("USERID").toString()+"','E')";
		 val= stmt.executeUpdate(sql);
	     
	
	 	 stmt.close();
	 	 conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   }finally{
	   conn.close();
   }
		return val;
	}
	
	public JSONArray contractServiceSiteUpdateGridLoading(String branch,String fromdate,String todate,String contracttype,String contrctid,String clientid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="";
		try {

			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			
			java.sql.Date sqlfromdate = null;
			
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}

			if(branch.equalsIgnoreCase("a"))
        	{
				sqltest+="";
        	}
			else
			{
				sqltest+=" and cm.brhid="+branch;
			}
			
			if(!(contrctid.equalsIgnoreCase("")) && !(contrctid.equalsIgnoreCase("0"))){
	       		sqltest+=" and cm.tr_no="+contrctid+" ";
	       	}
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and ac.cldocno="+clientid+" ";
	       	}
			
			if(contracttype.equalsIgnoreCase("AMC")){
				sqltest+=" and cm.dtype='AMC' ";
			}
			 if(contracttype.equalsIgnoreCase("SJOB")){
					sqltest+=" and cm.dtype='SJOB' ";
				}
				
		String sqldata="select cm.tr_no,cm.doc_no,sm.sal_name,mm.grpcode,cm.dtype,ac.refname client,cm.ref_type refert,cm.refdocno referno,coalesce(mc.cperson,' ') cperson,ac.per_mob mobno,cm.validfrom sdate,"
				+ "cm.validupto edate,round(cm.contractval,2) cval, convert(group_concat(cs.site),char(200)) site,round(cm.legalchrg,2) lfee, cm.cldocno from cm_srvcontrm cm "
				+ "left join my_crmcontact mc on cm.cpersonid=mc.row_no left join my_acbook ac on cm.cldocno=ac.cldocno and ac.dtype='crm' left join cm_srvcsited cs on cs.tr_no=cm.tr_no "
				+ " left join my_salm sm on ac.sal_id=sm.doc_no left join cm_serteamm mm on cs.srvteamno=mm.doc_no where cm.date between '"+sqlfromdate+"'  and '"+sqltodate+"' and cm.status!=7 "+sqltest+" group by cm.tr_no ";
		System.out.println("grid load======"+sqldata);
			resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=cm.convertToJSON(resultSet);

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
	
	public JSONArray accountDetails(String type,String account,String partyname,String contact) throws SQLException {
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtClient = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.cldocno doc_no,t.account,t.description from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ " where a.dtype='crm' and a.status<>7  "+sql;
				
				ResultSet resultSet1 = stmtClient.executeQuery(sql);
				
				RESULTDATA1=cm.convertToJSON(resultSet1);
				
				stmtClient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray contractDetailsSearch(HttpSession session,String clientid,String dtype,String refno,String contractno) throws SQLException {

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
		  String sql11="";


		  java.sql.Date sqlStartDate=null;

		  /*select count(*) as count,if(m.status=1,'HOLD',if(m.status=2,'CLOSED',if(m.status=3,'COMPLETED',if(m.status=4,'STARTED','ENTERED')))) as statuss,status from cm_servplan m group by status;*/

		  //enqdate.trim();


		  String sqltest="";

		  
		  if(!(dtype.equals("0") || dtype.equals("") || dtype.equals("undefined") || dtype.equals("ALL"))){
		   sql11=sql11+" and cm.dtype='"+dtype+"'";
		  }

		  
		  if(!(contractno.equals("0") || contractno.equals("") || contractno.equals("undefined") || contractno.equals("ALL"))){
		   sql11=sql11+" and cm.doc_no='"+contractno+"'";
		  }
		  

		  Connection conn = null;

		  try {
		   conn = ClsConnection.getMyConnection();
		   Statement stmtenq1 = conn.createStatement ();

		   String clssql= "select tr_no,doc_no,refno from cm_srvcontrm cm where status=3 and 1=1 "+sql11+" order by doc_no";

		   ResultSet resultSet = stmtenq1.executeQuery(clssql);

		   RESULTDATA=cm.convertToJSON(resultSet);
		   stmtenq1.close();
		   conn.close();
		  }
		  catch(Exception e){
		   conn.close();
		   e.printStackTrace();
		  }
		  return RESULTDATA;
		 }
	
	public JSONArray serviceSiteGridLoading(HttpSession session,String doc_no,String dtype) throws SQLException{

		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select  groupname area,g.doc_no areaid,site,siteadd,cperson contper,tel contmob,contactid contid,d.rowno,d.srvteamno steamid,stm.grpcode serviceteam from  cm_srvcsited  d "
					+ "left join my_groupvals g on(d.areaid=g.doc_no and grptype='area') "
					+ "left join my_crmcontact c on(c.row_no=d.contactid) "
					+ "left join cm_serteamm stm on d.srvteamno=stm.doc_no  where tr_no="+doc_no+"";

			System.out.println("========site======   "+sql );
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=cm.convertToJSON(resultSet1);

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
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname area,codeno,doc_no areadocno from my_groupvals where grptype='area' and status=3";

			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=cm.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
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

			String sql= ("select cperson,c.tel as tel,area,row_no as cprowno from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientid+" and a.doc_no="+clientid+"" );
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=cm.convertToJSON(resultSet);
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
	
	public JSONArray serviceteamSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no docno,grpcode team from cm_serteamm where status=3";
			//			System.out.println("===sql===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=cm.convertToJSON(resultSet1);

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