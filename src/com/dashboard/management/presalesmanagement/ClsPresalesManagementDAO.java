package com.dashboard.management.presalesmanagement;
          
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
public class ClsPresalesManagementDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray presalesENQData(HttpSession session,String id) throws SQLException{    
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
			           
				
				String strsql=" select m.brhid,bd.brandname,mm.doc_no psrno,mm.doc_no as prodoc,qty,size,mm.part_no,mm.part_no productid,mm.productname,u.unit,u.doc_no unitdocno,d.specno specid,m.sal_id,sa.sal_name,m.shipdetid,ac1.refname clname, sh.claddress, sh.contactperson, sh.tel telno, sh.mob mobno , sh.email emailid, sh.fax faxno,  m.voc_no vocno,m.DOC_NO, m.DATE date,coalesce(if(m.clientid<=0,m.clientname,ac.refname),0) name,coalesce(if(m.clientid<=0,'',ac.address),0) cladd, coalesce(if(m.clientid<=0,ac.doc_no,m.clientid),0) cldocno, m.mob, m.email, cltype, payterms, delterms, description from my_cusenqm m left join my_cusenqd d on d.rdocno=m.doc_no  left join my_main mm on(d.psrno=mm.doc_no)   left join  my_brand bd on mm.brandid=bd.doc_no left join  my_unitm u on(d.unitid=u.doc_no)left join my_acbook ac on(m.clientid=ac.cldocno and ac.dtype='CRM')  left join my_shipdetails sh on sh.doc_no=m.shipdetid  and sh.type>0  left join my_acbook ac1 on(sh.cldocno=ac1.cldocno and ac1.dtype='CRM' and sh.type>0) left join my_salm sa on sa.doc_no=m.sal_id    where m.status<>7  ";
				//System.out.println("strsql6--->>>"+strsql);                                   
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
	public JSONArray presalesQotData(HttpSession session,String id) throws SQLException{    
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
			           
				
			String strsql="select m.brhid,m.description,m.doc_no,d.qty, round(d.amount,2) unitprice, round(d.disper,2) discper, round(d.total,2) total, round(d.discount,2) dis, round(d.nettotal,2) netotal, round(d.taxper,2) taxper, round(d.taxamount,2) taxperamt, round(d.nettaxamount,2) taxamount,bd.brandname,mm.doc_no psrno,mm.doc_no as prodoc,mm.part_no,mm.part_no productid,mm.productname,u.unit,u.doc_no unitdocno, ac.per_mob,sa.doc_no saldocno,sa.sal_name,m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,m.ref_type,rrefno from my_qotm m left join my_qotd d on d.rdocno=m.doc_no left join my_acbook ac on(ac.cldocno=m.cldocno and ac.dtype='CRM') left join my_salm sa on sa.doc_no=ac.sal_id left join my_main mm on(d.psrno=mm.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_brand bd on mm.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=mm.doc_no) where m.status<>7";
				//System.out.println("strsql7--->>>"+strsql);                                       
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
	 public  JSONArray loadSubGridData(String reftype, String rdocno) throws SQLException {
         JSONArray RESULTDATA=new JSONArray();
         Connection conn = null;   
         Statement stmt =null;
         ResultSet resultSet=null;
         try {

             conn = objconn.getMyConnection();
             stmt = conn.createStatement ();
                 
             String sqldata = "select m.reftype,m.date,m.remarks,m.fdate,u.user_id user from gl_bqot m inner join my_user u on u.doc_no=m.userid where rdocno='"+rdocno+"' and reftype='"+reftype+"'";    
             //System.out.println("detail75==="+sqldata); 
              resultSet= stmt.executeQuery (sqldata);
              RESULTDATA=objcommon.convertToJSON(resultSet);
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
