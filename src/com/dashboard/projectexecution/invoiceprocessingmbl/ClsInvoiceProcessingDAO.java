package com.dashboard.projectexecution.invoiceprocessingmbl;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.project.execution.projectInvoice.ClsProjectInvoiceDAO;

import java.sql.*;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsInvoiceProcessingDAO {  

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
			String sqltest="",strjoin="",sqlselect="", sqlgroup="";   
			           
	           
				if(widgetname.equalsIgnoreCase("proforma")){  
					sqltest=" and m.pstatus=1 and coalesce(m.pinvno,0)=0 and d.dueafser=98 ";
					sqlgroup=" GROUP BY m.tr_no ";
				}else if(widgetname.equalsIgnoreCase("notrcvd")){
					sqltest=" and m.pstatus=1 and coalesce(m.pinvno,0)!=0 and d.dueafser=98 ";
					sqlgroup=" GROUP BY m.tr_no ";
				}else if(widgetname.equalsIgnoreCase("invpro")){
					sqltest=" and ((d.dueafser=98 and d.invtrno=0 and pstatus=2) or (d.dueafser=99 and d.invtrno=0 and m.pstatus!=1) or (d.dueafser not in (98,99) and d.serviceno>0 and d.invtrno=0 and s.workper=100 and s.status=5) or (d.dueafser=0 and d.invtrno=0 and m.pstatus!=1 and coalesce(serviceno,0)=0)) ";
					strjoin="left join cm_servplan s on d.tr_no=s.doc_no and s.sr_no=d.serviceno and s.dtype='sjob'";         
				}else if(widgetname.equalsIgnoreCase("tobecnfmed")){  
					sqltest=" and d.invtrno>0 and d.confirm=0 ";              
				}else{}         
				
				if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){          
					sqltest+=" and m.brhid='"+brhid+"'";        
				}  
				
				/*String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
				//System.out.println("--------underwriter----------"+sql1);
				String salesuser="";
				ResultSet resultSet1 = stmt.executeQuery(sql1) ;
				if(resultSet1.next()){
					salesuser=" and m.sal_id='"+resultSet1.getString("doc_no")+"'";    
				} */  
				
				String strsql="select round(coalesce(pj.retAmount,0),2) retamount,round(coalesce(pj.retLegalCharge,0),2) retlegalcharge,round(coalesce(pj.atotal,0)-coalesce(pj.retAmount,0),2) retbalamt,"
						+ "round(coalesce(pj.legalchrg,0)-coalesce(pj.retLegalCharge,0),2) retballegchrg,d.invtrno pjivtrno,coalesce(c.doc_no,0) ccdocno,m.invprog,m.brhid,m.dtype,"
						+ "coalesce(m.pinvno,0) pinvno,coalesce(m.pstatus,0) pstatus,coalesce(d.dueafser,0) dueafser,coalesce(c.desc1,'') certydesc,round(coalesce(c.certper,0),2) certyper,"
						+ "round(coalesce(c.inv,0),2) invoiced,round(coalesce(m.progper,0),2) reten,coalesce(d.rowno,0) pdrowno,if(d.terms='SERVICE',d.dueafser,0) payservice,d.terms payterms,"
						+ "d.description paydesc,round(d.amount,2) amount,d.duedate,b.branchname branch,s.site,m.tr_no docno,m.doc_no vocno,m.date,round(m.netAmount,2) as netAmount,m.cldocno,"
						+ "round(coalesce(contractval,0),2) as contractval,ac.refname,sm.sal_name from  cm_srvcontrm m left join cm_srvcontrpd d on d.tr_no=m.tr_no left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
						+ "left join my_salm sm on(sm.doc_no=m.sal_id) left join (select group_concat(site) site,tr_no from cm_srvcsited group by tr_no) s on s.tr_no=m.tr_no left join my_brch b on b.doc_no=m.brhid "
						+ "left join cm_compcert c on (m.tr_no=c.rdocno and c.dtype=m.dtype) left join my_servm pj on pj.pdrowno=d.rowno "+strjoin+" where  m.status=3 and m.jbaction in (0,4)  "+sqltest+" "+sqlgroup+"";
				//System.out.println("strsql--->>>"+strsql);                                                                                               
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


	public  JSONArray loadSubGridData(String trno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		
		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = objconn.getMyConnection();
			stmt = conn.createStatement ();
			
				
			String sqldata = "select m.date detdate,m.remarks remk,m.fdate,u.user_id user from gl_bpif m inner join my_user u on u.doc_no=m.userid where m.rdocno="+trno+" "
					+ "and m.bibpid=(select rowno from gl_bibp where bibdid=(select doc_no from gl_bibd where description='Proforma Invoice Follow Up') and process='Follow-Up') and m.status=3 group by m.doc_no order by m.fdate desc";
		
		//System.out.println(sqldata);  
				resultSet= stmt.executeQuery (sqldata);
			RESULTDATA=objcommon.convertToJSON(resultSet);   
			//			System.out.println("=====RESULTDATA"+RESULTDATA);   

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
}  
