package com.dashboard.fixedasset.fixedassetissue;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;







import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsFixedAssetIssueDAO {
	
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray assetdetails() throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
        try {
        	conn = ClsConnection.getMyConnection();
        	Statement stmtBFAR = conn.createStatement();
   
            String sql="select sr_no asset_no,assetname from my_fixm where status=3";
            ResultSet resultSet = stmtBFAR.executeQuery(sql);
            
           RESULTDATA=ClsCommon.convertToJSON(resultSet);
           
           stmtBFAR.close();
           conn.close();
       
           }catch(Exception e){
        	   e.printStackTrace();
        	   conn.close();
           }finally{
   			conn.close();
   		}
        return RESULTDATA;
    }
	
	 public JSONArray groupdetails() throws SQLException {

	     JSONArray RESULTDATA=new JSONArray();
	     Connection conn = null;
	       
	     try {
	    	 conn = ClsConnection.getMyConnection();
	    	 Statement stmtBFAR = conn.createStatement();
	   
	    	 String sql="select grp_name gname,doc_no from my_fagrp where status=3";
	    	 ResultSet resultSet = stmtBFAR.executeQuery(sql);
	    	 
	         RESULTDATA=ClsCommon.convertToJSON(resultSet);
	         
	     stmtBFAR.close();
	     conn.close();
	 }catch(Exception e){
	   e.printStackTrace();
	   conn.close();
	  }finally{
			conn.close();
	  }
	      return RESULTDATA;
	}

	 public JSONArray accountSearch() throws SQLException {
		    
		    JSONArray RESULTDATA=new JSONArray();
		          
		          Connection conn = null; 
		         
		        try {
		           conn = ClsConnection.getMyConnection();
		           ClsCommon ClsCommon=new ClsCommon();
		           Statement stmtmain = conn.createStatement();
		           String sql="";
		           
		             sql="select description,account,doc_no from my_head where m_s=0 and atype='hr' ";
		           System.out.println("SQL ="+sql);
		           ResultSet resultSet = stmtmain.executeQuery(sql);
		           RESULTDATA=ClsCommon.convertToJSON(resultSet);
		           stmtmain.close();
		           conn.close();
		        } catch(Exception e){
		          e.printStackTrace();
		          conn.close();
		        } finally{
		      conn.close();
		     }
		          return RESULTDATA;
		     }

	 public JSONArray amcSjobSearch(HttpSession session,String typedocno,String refnames,String check,String dtype) throws SQLException {
		    
		    JSONArray RESULTDATA=new JSONArray();
		          
		          Connection conn = null; 
		         
		        try {
		           conn = ClsConnection.getMyConnection();
		           ClsCommon ClsCommon=new ClsCommon();
		           Statement stmtmain = conn.createStatement();
		           System.out.println("SQL amc sjob =");
		           String sql="";
		           String sqltest="";
		         /*  if(!refnames.equalsIgnoreCase("")&&!refnames.equalsIgnoreCase("null")){
		        	   sqltest+=" and ac.refname like '"+refnames+"' ";
		           }
		           if(!typedocno.equalsIgnoreCase("")&&!typedocno.equalsIgnoreCase("null")){
		        	   sqltest+=" and m.cldocno like '"+typedocno+"' ";
		           }*/
		           if(check.equalsIgnoreCase("1")) {
		        	   
		        	   
		               Statement stmt=conn.createStatement();
		               sql = "select m.doc_no,m.tr_no,m.dtype,convert(concat(m.ref_type,' ',m.refdocno),char(100)) prjname, "
		               		+ "ac.refname customer,m.cldocno from cm_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno "
		               		+ "and ac.dtype='CRM' where m.status=3 and m.JBAction in (0,4) and m.dtype='"+dtype+"' "+sqltest+" ;";           
		              stmt.close();
		             
		           System.out.println("SQL amc sjob ="+sql);
		           ResultSet resultSet = stmtmain.executeQuery(sql);
		           RESULTDATA=ClsCommon.convertToJSON(resultSet);
		              
		           stmtmain.close();
		           conn.close();
		           } 
		         stmtmain.close();
		         conn.close();
		        } catch(Exception e){
		          e.printStackTrace();
		          conn.close();
		        } finally{
		      conn.close();
		     }
		          return RESULTDATA;
		     }

	
	public JSONArray getAssetList(String issue_stat,String grpno) throws SQLException {
	    
	    
	    JSONArray RESULTDATA=new JSONArray();
	    Connection conn =null;
	    		
	    		try {
					conn=ClsConnection.getMyConnection();

					Statement stmtassetlist = conn.createStatement ();
	            	String sqltest="";
	            	if(!grpno.equalsIgnoreCase("")&&!grpno.equalsIgnoreCase("0")){
	            		sqltest=" and grp.doc_no="+grpno+"";
	            	}
	            	
	            	
					/*String strassetlist= "select asset.issue_status,asset.sr_no srno,asset.doc_no,asset.assetid,asset.assetname,coalesce(grp.grp_name,'') assetgrp,coalesce(loc.loc_name,'') assetloc,"+
							" coalesce(ac.refname,'') supplier,asset.purefno prefno,asset.purdate pdate,asset.totpurval totalpval,coalesce(fix.description,'') fixedassetac,"+
							" coalesce(accdep.description,'') accdeprac,coalesce(dep.description,'') deprac from my_fixm asset left join my_fagrp grp on"+
							" asset.assetgp=grp.doc_no left join my_faloc loc on asset.loc=loc.doc_no left join my_acbook ac on (asset.supacno=ac.acno and"+
							" ac.dtype='VND') left join my_head fix on asset.fixastacno=fix.doc_no left join my_head accdep on asset.accdepacno=accdep.doc_no left join"+
							" my_head dep on asset.depacno=dep.doc_no where asset.status=3 and issue_status='"+issue_stat+"' "+sqltest+" ";
				*/
	            	
	            	String strassetlist="select ret.type_no,ret.type type1,if(ret.type='emp','Employee',if(ret.type='amc','AMC','SJOB'))type ,ret.name,asset.issue_status,asset.issuedt,asset.sr_no srno,asset.doc_no,asset.assetid,asset.assetname,coalesce(grp.grp_name,'') assetgrp, "
						+ "coalesce(loc.loc_name,'') assetloc, coalesce(ac.refname,'') supplier,asset.purefno prefno,asset.purdate pdate, "
						+ "asset.totpurval totalpval,coalesce(fix.description,'') fixedassetac, coalesce(accdep.description,'') accdeprac, "
						+ "coalesce(dep.description,'') deprac from my_fixm asset left join my_fagrp grp on asset.assetgp=grp.doc_no left join my_faloc loc "
						+ " on asset.loc=loc.doc_no left join my_acbook ac on (asset.supacno=ac.acno and ac.dtype='VND') left join my_head fix on "
						+ " asset.fixastacno=fix.doc_no left join my_head accdep on asset.accdepacno=accdep.doc_no left join my_head dep on "
						+ " asset.depacno=dep.doc_no  "
						+ "left join(select max(doc_no)mdocno,asset_no from gl_bfai  group by asset_no) dc on dc.asset_no=asset.sr_no "
						+ " left join (select fa.doc_no fadoc,fa.type_no,m.doc_no,m.issue_status,m.issuedt,if(fa.type='emp',h.description,ac.refname)name ,fa.type from my_fixm m left join gl_bfai fa on m.sr_no=fa.asset_no "
						+ " left join my_head h on h.doc_no=fa.type_no and fa.type='emp' "
						+ " left join my_acbook ac on ac.cldocno=fa.type_no and fa.type in('sjob','amc')  where  fa.type in('sjob','amc','emp')) "
						+ " ret on ret.doc_no=asset.doc_no "
						+ " and ret.fadoc=dc.mdocno "
						+ " where asset.status=3 and asset.issue_status='"+issue_stat+"' "+sqltest;
	            	
	            	//System.out.println("fai grid load"+strassetlist);
					ResultSet resultSet = stmtassetlist.executeQuery(strassetlist);
					
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtassetlist.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
	    		finally{
	    			conn.close();
	    		}
	        return RESULTDATA;
	    
	}

}
