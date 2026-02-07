package com.dashboard.marketing.presalesmanagement;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsPresalesManagementDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray presalesData(HttpSession session,String id,String widgetname,String brhid) throws SQLException{    
		JSONArray data=new JSONArray();                      
		Connection conn=null; 
		 java.sql.Date edates = null;     
		 if(!id.equalsIgnoreCase("1")){        
			 return data;
		 } 
		try{
			conn=objconn.getMyConnection();  
			Statement stmt=conn.createStatement();
			String sqltest="",strjoin="",sqlselect="";   
			           
				if(widgetname.equalsIgnoreCase("enqsch")){
					sqltest=" and m.enqstatus=0 and m.sh_empid=0 ";  
					sqlselect=",coalesce(round(datediff(curdate(),m.date),0),0) age";   
				}else if(widgetname.equalsIgnoreCase("schenq")){
					sqltest=" and m.enqstatus=0 and m.sh_empid!=0 ";
					sqlselect=",coalesce(round(datediff(curdate(),m.date),0),0) age";   
				}else if(widgetname.equalsIgnoreCase("sur")){
					sqltest=" and m.enqstatus=1 ";
					sqlselect=",if(sm.entrydate is null and bs.entrydate is null,coalesce(round(datediff(curdate(),m.date),0),0),coalesce(if(sm.entrydate is null,round(datediff(curdate(),bs.entrydate),0),round(datediff(curdate(),sm.entrydate),0)),0)) age";                 
				}else if(widgetname.equalsIgnoreCase("est")){  
					sqltest=" and m.enqstatus=2 ";
					//strjoin=" left join cm_prjestm pm on (pm.reftrno=m.doc_no and pm.ref_type='enq') ";
					sqlselect=",coalesce(round(datediff(curdate(),pm.entrydate),0),0) age";      
				}else if(widgetname.equalsIgnoreCase("quot")){
					sqltest=" and m.enqstatus=3 ";   
					//strjoin=" left join cm_srvqotm qm on (qm.refDocNo=m.doc_no and qm.ref_type='enq') ";  
					sqlselect=",coalesce(round(datediff(curdate(),qm.entrydate),0),0) age";    
				}else if(widgetname.equalsIgnoreCase("totalenq")){      
					sqltest=" and m.enqstatus<=3 ";
					sqlselect=",coalesce(round(datediff(curdate(),m.date),0),0) age";
				}else{}    
				
				if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){        
					sqltest+=" and m.brhid='"+brhid+"'";        
				}
				
				String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
				//System.out.println("--------underwriter----------"+sql1);
				String salesuser="";
				ResultSet resultSet1 = stmt.executeQuery(sql1) ;
				if(resultSet1.next()){
					salesuser=" and m.sal_id='"+resultSet1.getString("doc_no")+"'";    
				} 
				
				String strsql="select cp.mob cpersonmob,if(ac.nontax=1,coalesce(tax.per,0.00),0.00) taxper,m.sjobtype,concat('MOB',':',cp.mob,';','Email',':',cp.email,';','Tele',':',cp.tel) contactdet,m.cpersonid,m.cperson,coalesce(m.esttrno,0) esttrno,coalesce(s.doc_no,0) as salid,ac.per_tel pertel,ac.per_mob,trim(ac.mail1) mail1,coalesce(pm.tr_no,0) esttrno,coalesce(sm.doc_no,0) surtrno,ac.address,m.cldocno,m.brhid,coalesce(bs.tr_no,0) schtrno,sm.voc_no surno,pm.doc_no estno,qm.doc_no qotno,s.sal_name,m.doc_no docno,m.voc_no vocno,m.date date,ac.refname,m.contrmode contrtype"+sqlselect+" from gl_enqm m  left join my_salm s on m.sal_id=s.doc_no  left join my_acbook ac on (ac.cldocno=m.cldocno and ac.dtype='crm') left join cm_srvqotm qm on (qm.refDocNo=m.doc_no and qm.ref_type='enq' and qm.status=3) left join cm_prjestm pm on (pm.reftrno=m.doc_no and pm.ref_type='enq' and pm.status=3)  left join cm_surveym sm on (sm.refDocNo=m.doc_no and sm.ref_type='enq' and sm.status=3)  left join gl_beqs bs on (bs.rdocno=m.doc_no and bs.process='sur') left join my_crmcontact cp on cp.row_no=m.cpersonid left join gl_taxsubmaster tax on (tax.status=3 and tax.type=2 and tax.per>0) where m.status=3 "+sqltest+" "+salesuser+" group by m.doc_no";
				System.out.println("strsql--->>>"+strsql);                                   
				ResultSet rs=stmt.executeQuery(strsql);  
				data=objcommon.convertToJSON(rs);  
		}   
		catch(Exception e){  
			e.printStackTrace();
		}
		finally{
			conn.close();  
		}
		return data;
	}
	
	public JSONArray assignmode(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select groupname assign,codeno,doc_no docno from my_groupvals where grptype='assignmode' and status=3";
//			System.out.println("===getassign===="+sql);
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=objcommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	
	public JSONArray assignfrm(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select grpcode,doc_no  from cm_serteamm where status=3";
//			System.out.println("===sql===="+sql);
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=objcommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	
	public JSONArray assignteam(HttpSession session,String assignid) throws SQLException{  
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();  
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select s.doc_no,s.rdocno,name,grpcode,s.empid from cm_serteamd s left join hr_empm e on(s.empid=e.doc_no) "
					+ "left join cm_serteamm m on(m.doc_no=s.rdocno) where m.status=3 and m.doc_no='"+assignid+"'";
			System.out.println("===sql===="+sql);
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=objcommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA1;
	}
	
	public JSONArray userSearch(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select doc_no docno,user_name username from my_user where status=3 and block=0";

//			System.out.println("===getassign===="+sql);

			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=objcommon.convertToJSON(resultSet1);   

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
