package com.dashboard.skips.invoicetodispatch;     

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsInvoiceDispatchDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();

	public JSONArray invoicelist(String branchval,String fromdate,String todate,String cldocno,String contrno,String contractchk) throws SQLException {  
        JSONArray RESULTDATA=new JSONArray();
        java.sql.Date sqlfromdate = null;
        java.sql.Date sqltodate = null;
        if(!fromdate.equalsIgnoreCase(""))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);     
     	}
     	if(!todate.equalsIgnoreCase(""))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     	}
     
	    String sqltest="",sqlorderby="";
    	if(!cldocno.equalsIgnoreCase("")){
    		sqltest=sqltest+" and m.cldocno='"+cldocno+"'";
    	}
    	if(!contrno.equalsIgnoreCase("")){  
    		sqltest=sqltest+" and cm.tr_no='"+contrno+"'";  
    	}
    	if(!branchval.equalsIgnoreCase("") && !branchval.equalsIgnoreCase("a") && !branchval.equalsIgnoreCase("0")){
    		sqltest=sqltest+" and m.brhid='"+branchval+"'";
    	}
    	if(contractchk.equalsIgnoreCase("1")){
    		sqlorderby=" order by cm.tr_no";  
    	}else {
    		sqlorderby=" order by m.doc_no";   
    	}
    	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); //ac.mail1
				String sql ="select  m.email mailsend,coalesce(coalesce(cm.email,''),'') email,m.brhid,cm.doc_no contrno,m.doc_no,m.voc_no,h.description acname,h.account acno,br.branchname branch,date_format(m.fromdate,'%d.%m.%Y') fromdate,"
						+ " date_format(m.todate,'%d.%m.%Y') todate,round(d.netamount,2) netamount from sk_invm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' "
						+ "left join my_head h on h.doc_no=ac.acno  left join my_brch br on m.brhid=br.doc_no left join sk_srvcontrm cm on cm.tr_no=m.cnttrno and m.reftype=cm.dtype "
						+ "left join (select sum(nettotal) netamount,rdocno from sk_invd group by rdocno)d on d.rdocno=m.doc_no "
						+ "where m.status=3 and m.dispatch=0 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest+" "+sqlorderby+"";  
				//System.out.println("========sql===="+sql);   
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
         	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
         	stmtVeh.close();
 				conn.close();
		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
    
	
	
	
	public JSONArray agreementSearch(String branch, String sclname,String smob,String rno,String flno,String sregno,String rentaltype) throws SQLException {

    	JSONArray RESULTDATA=new JSONArray();
    	String sqltest="";
    	
    	if(rentaltype.equalsIgnoreCase("RAG"))
    	{

    		if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and r.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and r.fleet_no like '%"+flno+"%'";
        	}
    	}
    	else if(rentaltype.equalsIgnoreCase("LAG"))
    	{
    		
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" l.brhid="+branch+"";
    		}
        	
        
        	if(!(rno.equalsIgnoreCase(""))){
        		sqltest+=" and l.voc_no like '%"+rno+"%'";
        	}
        	if(!(flno.equalsIgnoreCase(""))){
        		sqltest+=" and (l.tmpfleet like '%"+flno+"%' or l.perfleet like '%"+flno+"%')";
        	}
        	
    		
    	}
    		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    			sqltest+=" and r.brhid="+branch+"";
    		}
        	
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
        	
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    
        	if(!(sclname.equalsIgnoreCase(""))){
        		sqltest+=" and a.RefName like '%"+sclname+"%'";
        	}
        	if(!(smob.equalsIgnoreCase(""))){
        		sqltest+=" and a.per_mob like '%"+smob+"%'";
        	}
    	
        	if(!(sregno.equalsIgnoreCase(""))){
        		sqltest+=" and v.reg_no like '%"+sregno+"%'";
        	}
    		
    
    	
    	Connection conn=null;
     
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtinv = conn.createStatement();
				if(rentaltype.equalsIgnoreCase("RAG"))
		    	{
				String sql=("select r.doc_no,r.voc_no,r.fleet_no,a.RefName,a.per_mob,v.reg_no from gl_ragmt r left join gl_vehmaster v on v.fleet_no=r.fleet_no "
						+ " left join my_acbook a on (r.cldocno=a.cldocno and a.dtype='CRM') where 1=1 "+sqltest+" group by doc_no");
			//	System.out.println(sql);
				ResultSet resultSet = stmtinv.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			
				
		    	}
				else if(rentaltype.equalsIgnoreCase("LAG"))
		    	{
					
					String sql=("select l.doc_no,l.voc_no,if(l.perfleet=0,l.tmpfleet,l.perfleet) fleet_no,a.RefName,a.per_mob,v.reg_no from gl_lagmt l left join gl_vehmaster v on v.fleet_no=if(l.perfleet=0,l.tmpfleet,l.perfleet)  "
							+ " left join my_acbook a on a.cldocno= l.cldocno and a.dtype='CRM' where 1=1 "+sqltest+" group by doc_no");	
					

					ResultSet resultSet = stmtinv.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
					
		    	}
				stmtinv.close();
				conn.close();
		    	
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }

	
	
	
	public JSONArray clientDetailsSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();
		    
		    String sql = "";
			
			sql = "select cldocno,refname from my_acbook where status=3 and dtype='CRM' order by refname";
			
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		                
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
	public JSONArray contractDetailsSearch() throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		    
		Connection conn = null;
	    
		  try {
		    conn = ClsConnection.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();
		    
		    String sql = "";
			
		    sql = "select m.tr_no,m.doc_no,ac.refname,s.site from sk_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join (select group_concat(site) site,tr_no from sk_srvcsited group by tr_no) s on s.tr_no=m.tr_no where m.status=3 order by m.tr_no";
			
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		                
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
}
