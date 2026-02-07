package com.dashboard.marketing.salesactivitymanagement;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsSalesActivityManagementDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray prospectiveData(HttpSession session,String id,String brhid) throws SQLException{      
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
			           
				if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){        
					sqltest+=" and pc.brhid='"+brhid+"'";        
				}
				
				String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
				//System.out.println("--------underwriter----------"+sql1);
				String salesuser="";
				ResultSet resultSet1 = stmt.executeQuery(sql1) ;
				if(resultSet1.next()){
					salesuser=" and pc.sal_id='"+resultSet1.getString("doc_no")+"'";    
				} 
				
				String strsql="select pc.fax,pc.tel,pc.clientacid,b.branchname branch,pc.tr_no,pc.doc_no,pc.date,pc.brhid,pc.name,pc.mob,pc.email,pc.sal_id,pc.description,s.sal_name from cm_prosclientm pc left join my_salm s on s.doc_no=pc.sal_id left join my_brch b on b.doc_no=pc.brhid where pc.status=3 "+sqltest+" "+salesuser+"  group by pc.tr_no";
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
	
	public JSONArray enquiryData(HttpSession session,String id,String brhid) throws SQLException{      
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
				
				//String strsql="select b.branchname branch,s.site,m.doc_no docno,m.voc_no vocno,m.date,m.cldocno,ac.refname,sm.sal_name from  gl_enqm m left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) left join (select group_concat(site) site,rdocno from gl_enqsited group by rdocno) s on s.rdocno=m.doc_no left join my_brch b on b.doc_no=m.brhid where m.status=3 "+sqltest+""+salesuser+"";
				String strsql="select b.branchname branch,m.doc_no docno,m.voc_no vocno,m.date,m.cldocno,ac.refname,sm.sal_name,m.brhid from  gl_enqm m left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) left join my_brch b on b.doc_no=m.brhid where m.status=3 and m.enqstatus in(0,1)  and m.cntrtrno=0"+sqltest+""+salesuser+"";
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
	
	public JSONArray quoteData(HttpSession session,String id,String brhid) throws SQLException{      
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
				
				//String strsql="select b.branchname branch,s.site,m.doc_no docno,m.voc_no vocno,m.date,m.cldocno,ac.refname,sm.sal_name from  gl_enqm m left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) left join (select group_concat(site) site,rdocno from gl_enqsited group by rdocno) s on s.rdocno=m.doc_no left join my_brch b on b.doc_no=m.brhid where m.status=3 "+sqltest+""+salesuser+"";
				String strsql="select b.branchname branch,m.tr_no docno,m.doc_no vocno,m.date,m.cldocno,ac.refname,sm.sal_name,m.brhid from cm_srvqotm m left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_salm sm on(sm.doc_no=m.sal_id) left join my_brch b on b.doc_no=m.brhid  left join gl_enqm e on e.doc_no=m.refdocno and m.ref_type='ENQ' where m.status=3 and m.cntrtrno=0 and e.enqstatus=3 and m.quotstatus=0 "+sqltest+""+salesuser+"";
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
	public JSONArray clientData(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select refname,cldocno  from my_acbook where dtype='CRM' and status=3";  
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
	public JSONArray appointmentData(HttpSession session,String id) throws SQLException{      
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
			           
			String strsql="select ac.sal_id,s.sal_name,ap.ppctrno,ap.mob,ap.tel,ap.doc_no, ap.clienttype, ap.cldocno,if(ap.clienttype='New',ap.refname,ac.refname) refname, ap.appntdate, ap.appnttime, ap.meetdate, ap.meettime, ap.commmode, ap.venue, ap.cperson, ap.description,ac.per_mob clmob,ac.per_tel cltel,ac.fax1 fax,ac.mail1 mail,ac.address from cm_appoinment ap left join my_acbook ac on (ac.cldocno=ap.cldocno and ac.dtype='CRM') left join my_salm s on s.doc_no=ac.sal_id where cancelstatus=0"; 
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
	public JSONArray nextflwupData(HttpSession session,String id,String docno) throws SQLException{        
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
			           
			String strsql="select f.flwuptype, f.date, f.time, f.meetdate, f.meettime, f.remarks,u.user_name user from cm_appointmentflwup f left join my_user u on u.doc_no=f.userid where appntdocno='"+docno+"'";
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
	public   JSONArray contactpersonData(HttpSession session,String docno) throws SQLException {  

		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn =null;
		Statement cpstmt =null;

		try {
			conn = objconn.getMyConnection();
			cpstmt = conn.createStatement ();  

			String  cpsql=("select cperson,mob,email,tel from my_crmcontact c where c.cldocno="+docno+" and c.dtype='CRM'");  
//			System.out.println("------------------------------"+cpsql);

			ResultSet resultSet = cpstmt.executeQuery (cpsql);
			RESULTDATA=objcommon.convertToJSON(resultSet);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			cpstmt.close();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
}
