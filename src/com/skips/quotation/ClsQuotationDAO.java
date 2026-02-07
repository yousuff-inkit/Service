package com.skips.quotation;  

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.skips.quotation.ClsQuotationBean;

import net.sf.json.JSONArray;

public class ClsQuotationDAO {  
	ClsConnection conobj= new ClsConnection();  
	ClsCommon com=new ClsCommon();
	ClsQuotationBean bean= new ClsQuotationBean();   
	Connection conn;
	public int insert(Date sqlStartDate,String enqdocno,String cldocno,String sourceid,String salid,String desc,ArrayList<String> enqarray,
			HttpSession session,String mode,String dtype,HttpServletRequest request,ArrayList<String> sitearray,String netamount,
			String billingmethod,String payterms,String cpersonid,String mob,String tel,String email,String cperson) throws SQLException {        
		try{  
			int docno;
			conn=conobj.getMyConnection();  
			conn.setAutoCommit(false);     
			//System.out.println("IN DAO");
			Double total=0.0;  
			if(netamount != null && netamount.length() > 0) {
				total=Double.parseDouble(netamount);   
			}else {
				total=0.0;   
			}
			if(cldocno != "" && cldocno != null && cldocno.length() > 0) {
				cldocno=cldocno;   
			}else {
				cldocno="0";      
			}
            CallableStatement stmtQuotation = conn.prepareCall("{call sk_QuotationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtQuotation.setDate(1,sqlStartDate);
			stmtQuotation.setString(2,enqdocno);
			stmtQuotation.setString(3,cldocno);
			stmtQuotation.setString(4,sourceid);
			stmtQuotation.setString(5,salid);
			stmtQuotation.setString(6,desc);  
			stmtQuotation.setDouble(7,total);   
			stmtQuotation.setString(8,dtype);
			stmtQuotation.setString(9,session.getAttribute("USERID").toString());
			stmtQuotation.setString(10,session.getAttribute("BRANCHID").toString());
			stmtQuotation.setString(11,mode);
		    stmtQuotation.registerOutParameter(12, java.sql.Types.INTEGER);
			stmtQuotation.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtQuotation.setString(14,billingmethod==null || billingmethod.equalsIgnoreCase("")?"0":billingmethod);   
			stmtQuotation.setString(15,payterms==null || payterms.equalsIgnoreCase("")?"0":payterms); 
			stmtQuotation.setString(16,cpersonid==null || cpersonid.equalsIgnoreCase("")?"0":cpersonid); 
			stmtQuotation.setString(17,mob);
			stmtQuotation.setString(18,tel);
			stmtQuotation.setString(19,email);   
			stmtQuotation.setString(20,cperson);      
			stmtQuotation.executeQuery();
			docno=stmtQuotation.getInt("docNo");
			int vocno=stmtQuotation.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(docno<=0){  
				conn.close(); 
				return 0;
			}
			int val=0;
			for(int i=0;i< enqarray.size();i++){       

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[0].trim().equalsIgnoreCase("undefined")|| enqiury[0].trim().equalsIgnoreCase("NaN")||enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()))
				{
					Double rate= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:Double.parseDouble(enqiury[10].trim());     
					Double tariff= enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:Double.parseDouble(enqiury[18].trim()); 
					if(rate<tariff) {
						val=1;  
					}
					String ratepercollection= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?"":enqiury[10].trim(); 
					String tippingfee= enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?"":enqiury[11].trim(); 
					String skiprent= enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?"":enqiury[13].trim(); 
					String tippingsecurity= enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?"":enqiury[16].trim();
					String addrate= enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?"":enqiury[21].trim(); 
					if(ratepercollection=="" || tippingfee=="" ||  skiprent=="" ||  tippingsecurity=="" || addrate=="" || ratepercollection=="0" || tippingfee=="0" ||  skiprent=="0" ||  tippingsecurity=="0" || addrate=="0") {   
						val=1;  
					}    
					String sql="INSERT INTO sk_srvqotdet(srno, site, skiptype, nos, wastetype, ownershipid, servicebyid, servicetermid, scheduledays, specid, collectionid, rate, tippingfee, foc, rent, securityval, tippingmethod, tippingsecurity, restricted, tariffrate, gatefee, addrate, ctypeid, rdocno)VALUES"
							+ " ("+(i+1)+","
							+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
							+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							+ "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
							+ "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
							+ "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
							+ "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:enqiury[6].trim())+"',"
							+ "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:enqiury[7].trim())+"',"
							+ "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
							+ "'"+(enqiury[9].trim().equalsIgnoreCase("undefined") || enqiury[9].trim().equalsIgnoreCase("NaN")||enqiury[9].trim().equalsIgnoreCase("")|| enqiury[9].isEmpty()?0:enqiury[9].trim())+"',"
							+ "'"+(enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:enqiury[10].trim())+"',"
							+ "'"+(enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?0:enqiury[11].trim())+"',"   
							+ "'"+(enqiury[12].trim().equalsIgnoreCase("undefined") || enqiury[12].trim().equalsIgnoreCase("NaN")||enqiury[12].trim().equalsIgnoreCase("")|| enqiury[12].isEmpty()?0:enqiury[12].trim())+"',"     
							+ "'"+(enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?0:Round(Double.parseDouble(enqiury[13].trim()),0))+"',"
							+ "'"+(enqiury[14].trim().equalsIgnoreCase("undefined") || enqiury[14].trim().equalsIgnoreCase("NaN")||enqiury[14].trim().equalsIgnoreCase("")|| enqiury[14].isEmpty()?0:Round(Double.parseDouble(enqiury[14].trim()),0))+"',"  
							+ "'"+(enqiury[15].trim().equalsIgnoreCase("undefined") || enqiury[15].trim().equalsIgnoreCase("NaN")||enqiury[15].trim().equalsIgnoreCase("")|| enqiury[15].isEmpty()?0:enqiury[15].trim())+"',"
							+ "'"+(enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?0:Round(Double.parseDouble(enqiury[16].trim()),0))+"',"  
							+ "'"+(enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?0:enqiury[17].trim())+"',"    		
							+ "'"+(enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:enqiury[18].trim())+"',"	
						    + "'"+(enqiury[20].trim().equalsIgnoreCase("undefined") || enqiury[20].trim().equalsIgnoreCase("NaN")||enqiury[20].trim().equalsIgnoreCase("")|| enqiury[20].isEmpty()?0:enqiury[20].trim())+"',"
						    + "'"+(enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?0:enqiury[21].trim())+"',"	
							+ "'"+(enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?0:enqiury[22].trim())+"',"
							+"'"+docno+"')";                   
  
					int resultSet2 = stmtQuotation.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}	

				}

			}
			for(int i=0;i< sitearray.size();i++){

				String[] sitestring=sitearray.get(i).split("::");
				
				if(!(sitestring[0].trim().equalsIgnoreCase("undefined")|| sitestring[0].trim().equalsIgnoreCase("NaN")||sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()))
				{
					String sql="INSERT INTO sk_servsited(sr_no, site, remarks, areaId, survid, route, gpsx, gpsy, description, tr_no)VALUES"    
							+ " ("+(i+1)+","
							+ "'"+(sitestring[0].trim().equalsIgnoreCase("undefined") || sitestring[0].trim().equalsIgnoreCase("NaN")|| sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()?0:sitestring[0].trim())+"',"
							+ "'"+(sitestring[1].trim().equalsIgnoreCase("undefined") || sitestring[1].trim().equalsIgnoreCase("NaN")|| sitestring[1].trim().equalsIgnoreCase("")|| sitestring[1].isEmpty()?0:sitestring[1].trim())+"',"
							+ "'"+(sitestring[2].trim().equalsIgnoreCase("undefined") || sitestring[2].trim().equalsIgnoreCase("NaN")||sitestring[2].trim().equalsIgnoreCase("")|| sitestring[2].isEmpty()?0:sitestring[2].trim())+"',"
							+ "'"+(sitestring[3].trim().equalsIgnoreCase("undefined") || sitestring[3].trim().equalsIgnoreCase("NaN")||sitestring[3].trim().equalsIgnoreCase("")|| sitestring[3].isEmpty()?0:sitestring[3].trim())+"',"
							+ "'"+(sitestring[4].trim().equalsIgnoreCase("undefined") || sitestring[4].trim().equalsIgnoreCase("NaN")||sitestring[4].trim().equalsIgnoreCase("")|| sitestring[4].isEmpty()?0:sitestring[4].trim())+"',"
							+ "'"+(sitestring[5].trim().equalsIgnoreCase("undefined") || sitestring[5].trim().equalsIgnoreCase("NaN")||sitestring[5].trim().equalsIgnoreCase("")|| sitestring[5].isEmpty()?0:sitestring[5].trim())+"',"
							+ "'"+(sitestring[6].trim().equalsIgnoreCase("undefined") || sitestring[6].trim().equalsIgnoreCase("NaN")||sitestring[6].trim().equalsIgnoreCase("")|| sitestring[6].isEmpty()?0:sitestring[6].trim())+"',"
							+ "'"+(sitestring[7].trim().equalsIgnoreCase("undefined") || sitestring[7].trim().equalsIgnoreCase("NaN")||sitestring[7].trim().equalsIgnoreCase("")|| sitestring[7].isEmpty()?0:sitestring[7].trim())+"',"
							+"'"+docno+"')";    

					int resultSetsite2 = stmtQuotation.executeUpdate (sql);
					if(resultSetsite2<=0)
					{
						conn.close();
						return 0;
					}	

				}

			} 
			
		   if(val>0) { 
			/*String sql="update sk_srvqotm set status=0 where tr_no='"+docno+"'"; int
			   resultSetsite3 = stmtQuotation.executeUpdate (sql); if(resultSetsite3<=0){
			   conn.close(); return 0; } */ 
		   }
			 
			
			if (docno > 0) {
				 String sql="UPDATE sk_srvqotm q LEFT JOIN gl_enqm e ON (e.doc_no=q.refdocno AND q.refdtype='ENQ') LEFT JOIN sk_servsited qs ON qs.tr_no=q.tr_no INNER JOIN gl_enqsited es ON es.rdocno=e.doc_no AND es.sr_no=qs.sr_no LEFT JOIN gl_enqdet ed on ed.rdocno=e.doc_no SET es.site=qs.site, es.areaid=qs.areaid, ed.site=qs.site WHERE q.tr_no='"+docno+"' AND (qs.site!=es.site OR qs.areaid!=es.areaid)"; 
				 stmtQuotation.executeUpdate (sql);
				   
				 String sql2="INSERT INTO gl_enqsited(rdocno, sr_no, site, areaid) SELECT e.doc_no, qs.sr_no, qs.site, qs.areaid FROM sk_srvqotm q LEFT JOIN gl_enqm e ON (e.doc_no=q.refdocno AND q.refdtype='ENQ') LEFT JOIN sk_servsited qs ON qs.tr_no=q.tr_no AND qs.revision_no=q.revision_no LEFT JOIN gl_enqsited es ON es.rdocno=e.doc_no AND es.sr_no=qs.sr_no WHERE q.doc_no='"+docno+"' AND es.rowno IS NULL"; 
				 stmtQuotation.executeUpdate (sql2);  
				 
				 String sql3="UPDATE sk_srvqotm q LEFT JOIN gl_enqm e ON (e.doc_no=q.refdocno AND q.refdtype='ENQ') SET e.cperson='"+cperson+"', e.mob='"+mob+"', e.telno='"+tel+"', e.email='"+email+"' WHERE q.tr_no='"+docno+"'";    
				 stmtQuotation.executeUpdate (sql3);    
				 
				 conn.commit();
				 stmtQuotation.close();
				 conn.close();
				 return docno;
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}

	public boolean edit(int docno,String vocno,Date sqlStartDate,String enqdocno,String cldocno,String sourceid,String salid,String desc,ArrayList<String> enqarray,
			HttpSession session,String mode,String dtype,HttpServletRequest request,ArrayList<String> sitearray,String netamount,
			String billingmethod,String payterms,String cpersonid,String mob,String tel,String email,String cperson) throws SQLException {  

		try{    
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);  
			Double total=0.0;  
			if(netamount != null && netamount.length() > 0) {
				total=Double.parseDouble(netamount);   
			}else {
				total=0.0;   
			}
			if(cldocno != "" && cldocno != null && cldocno.length() > 0) {
				cldocno=cldocno;   
			}else {
				cldocno="0";      
			}
			String branchid = session.getAttribute("BRANCHID").toString();
            CallableStatement stmtQuotation = conn.prepareCall("{call sk_QuotationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");      
			
			stmtQuotation.setDate(1,sqlStartDate);
			stmtQuotation.setString(2,enqdocno);
			stmtQuotation.setString(3,cldocno);
			stmtQuotation.setString(4,sourceid);
			stmtQuotation.setString(5,salid);
			stmtQuotation.setString(6,desc);  
			stmtQuotation.setDouble(7,total);  
			stmtQuotation.setString(8,dtype);
			stmtQuotation.setString(9,session.getAttribute("USERID").toString());
			stmtQuotation.setString(10,branchid);
			stmtQuotation.setString(11,mode);
		    stmtQuotation.setInt(12, docno);
			stmtQuotation.setString(13, "0");
			stmtQuotation.setString(14,billingmethod==null || billingmethod.equalsIgnoreCase("")?"0":billingmethod);   
			stmtQuotation.setString(15,payterms==null || payterms.equalsIgnoreCase("")?"0":payterms);  
			stmtQuotation.setString(16,cpersonid==null || cpersonid.equalsIgnoreCase("")?"0":cpersonid);
			stmtQuotation.setString(17,mob);
			stmtQuotation.setString(18,tel);
			stmtQuotation.setString(19,email);  
			stmtQuotation.setString(20,cperson);    
			int aaa=stmtQuotation.executeUpdate();
			docno=stmtQuotation.getInt("docNo");  

			if(aaa<=0){
				return false;
			}

			//String delsql="Delete from sk_srvqotdet where rdocno="+docno+""; 
			//stmtQuotation.executeUpdate(delsql); 
			int val=0;
			for(int i=0;i< enqarray.size();i++){

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[0].trim().equalsIgnoreCase("undefined")|| enqiury[0].trim().equalsIgnoreCase("NaN")||enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()))  
				{

					Double rate= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:Double.parseDouble(enqiury[10].trim());     
					Double tariff= enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:Double.parseDouble(enqiury[18].trim()); 
					if(rate<tariff) {
						val=1;  
					}
					String ratepercollection= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?"":enqiury[10].trim(); 
					String tippingfee= enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?"":enqiury[11].trim(); 
					String skiprent= enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?"":enqiury[13].trim(); 
					String tippingsecurity= enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?"":enqiury[16].trim();
					String addrate= enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?"":enqiury[21].trim(); 
//					System.out.println(ratepercollection+"="+tippingfee+"="+skiprent+"="+tippingsecurity+"="+addrate);  
					if(ratepercollection=="" || tippingfee=="" ||  skiprent=="" ||  tippingsecurity=="" || addrate=="" || ratepercollection=="0" || tippingfee=="0" ||  skiprent=="0" ||  tippingsecurity=="0" || addrate=="0") {  
						val=1;  
					}  
					int rowno=  (enqiury[19].trim().equalsIgnoreCase("undefined") || enqiury[19].trim().equalsIgnoreCase("NaN")||enqiury[19].trim().equalsIgnoreCase("")|| enqiury[19].isEmpty()?0:Integer.parseInt(enqiury[19].trim()));      
					if(rowno>0) {  
						String sql="update sk_srvqotdet set srno="+(i+1)+", site='"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"', "
								+ " skiptype='"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
								+ " nos='"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
								+ " wastetype='"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"', "
								+ " ownershipid='"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"', "
								+ " servicebyid='"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
								+ " servicetermid='"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:enqiury[6].trim())+"',"
								+ " scheduledays='"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:enqiury[7].trim())+"',"
								+ " specid='"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
								+ " collectionid='"+(enqiury[9].trim().equalsIgnoreCase("undefined") || enqiury[9].trim().equalsIgnoreCase("NaN")||enqiury[9].trim().equalsIgnoreCase("")|| enqiury[9].isEmpty()?0:enqiury[9].trim())+"',"
								+ " rate='"+(enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:enqiury[10].trim())+"',"
								+ " tippingfee='"+(enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?0:enqiury[11].trim())+"',"   
								+ " foc='"+(enqiury[12].trim().equalsIgnoreCase("undefined") || enqiury[12].trim().equalsIgnoreCase("NaN")||enqiury[12].trim().equalsIgnoreCase("")|| enqiury[12].isEmpty()?0:enqiury[12].trim())+"', "
								+ " rent='"+(enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?0:Round(Double.parseDouble(enqiury[13].trim()),0))+"', "
								+ " securityval='"+(enqiury[14].trim().equalsIgnoreCase("undefined") || enqiury[14].trim().equalsIgnoreCase("NaN")||enqiury[14].trim().equalsIgnoreCase("")|| enqiury[14].isEmpty()?0:Round(Double.parseDouble(enqiury[14].trim()),0))+"', "
								+ " tippingmethod='"+(enqiury[15].trim().equalsIgnoreCase("undefined") || enqiury[15].trim().equalsIgnoreCase("NaN")||enqiury[15].trim().equalsIgnoreCase("")|| enqiury[15].isEmpty()?0:enqiury[15].trim())+"', "
								+ " tippingsecurity='"+(enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?0:Round(Double.parseDouble(enqiury[16].trim()),0))+"', "  
								+ " restricted='"+(enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?0:enqiury[17].trim())+"', "
								+ " tariffrate='"+(enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:enqiury[18].trim())+"', "
								+ " gatefee='"+(enqiury[20].trim().equalsIgnoreCase("undefined") || enqiury[20].trim().equalsIgnoreCase("NaN")||enqiury[20].trim().equalsIgnoreCase("")|| enqiury[20].isEmpty()?0:enqiury[20].trim())+"', "
								+ " addrate='"+(enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?0:enqiury[21].trim())+"', "
								+ " ctypeid='"+(enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?0:enqiury[22].trim())+"'"
								+ " where rowno='"+rowno+"'";        
//                        System.out.println("Up sql="+sql);
						int resultSet2 = stmtQuotation.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return false;
						}
					}else {
						String sql="INSERT INTO sk_srvqotdet(srno, site, skiptype, nos, wastetype, ownershipid, servicebyid, servicetermid, scheduledays, specid, collectionid, rate, tippingfee, foc, rent, securityval, tippingmethod, tippingsecurity, restricted, tariffrate, gatefee, addrate, ctypeid, rdocno)VALUES"
								+ " ("+(i+1)+","
								+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
								+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
								+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
								+ "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
								+ "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
								+ "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
								+ "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:enqiury[6].trim())+"',"
								+ "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:enqiury[7].trim())+"',"
								+ "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
								+ "'"+(enqiury[9].trim().equalsIgnoreCase("undefined") || enqiury[9].trim().equalsIgnoreCase("NaN")||enqiury[9].trim().equalsIgnoreCase("")|| enqiury[9].isEmpty()?0:enqiury[9].trim())+"',"
								+ "'"+(enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:enqiury[10].trim())+"',"
								+ "'"+(enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?0:enqiury[11].trim())+"',"
								+ "'"+(enqiury[12].trim().equalsIgnoreCase("undefined") || enqiury[12].trim().equalsIgnoreCase("NaN")||enqiury[12].trim().equalsIgnoreCase("")|| enqiury[12].isEmpty()?0:enqiury[12].trim())+"',"     
								+ "'"+(enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?0:Round(Double.parseDouble(enqiury[13].trim()),0))+"',"
								+ "'"+(enqiury[14].trim().equalsIgnoreCase("undefined") || enqiury[14].trim().equalsIgnoreCase("NaN")||enqiury[14].trim().equalsIgnoreCase("")|| enqiury[14].isEmpty()?0:Round(Double.parseDouble(enqiury[14].trim()),0))+"',"  
								+ "'"+(enqiury[15].trim().equalsIgnoreCase("undefined") || enqiury[15].trim().equalsIgnoreCase("NaN")||enqiury[15].trim().equalsIgnoreCase("")|| enqiury[15].isEmpty()?0:enqiury[15].trim())+"',"
								+ "'"+(enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?0:Round(Double.parseDouble(enqiury[16].trim()),0))+"',"  
								+ "'"+(enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?0:enqiury[17].trim())+"',"    		
								+ "'"+(enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:enqiury[18].trim())+"',"	
							    + "'"+(enqiury[20].trim().equalsIgnoreCase("undefined") || enqiury[20].trim().equalsIgnoreCase("NaN")||enqiury[20].trim().equalsIgnoreCase("")|| enqiury[20].isEmpty()?0:enqiury[20].trim())+"',"
							    + "'"+(enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?0:enqiury[21].trim())+"',"	
								+ "'"+(enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?0:enqiury[22].trim())+"',"
								+"'"+docno+"')";      

						int resultSet2 = stmtQuotation.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return false;
						}
					}
				}

			}

			//site grid
			
			String delsitesql="Delete from sk_servsited where tr_no="+docno+"";  
			stmtQuotation.executeUpdate(delsitesql);
			for(int i=0;i< sitearray.size();i++){

						String[] sitestring=sitearray.get(i).split("::");
				
				if(!(sitestring[0].trim().equalsIgnoreCase("undefined")|| sitestring[0].trim().equalsIgnoreCase("NaN")||sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()))
				{
					String sql="INSERT INTO sk_servsited(sr_no, site, remarks, areaId, survid, route, gpsx, gpsy, description, tr_no)VALUES"    
							+ " ("+(i+1)+","
							+ "'"+(sitestring[0].trim().equalsIgnoreCase("undefined") || sitestring[0].trim().equalsIgnoreCase("NaN")|| sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()?0:sitestring[0].trim())+"',"
							+ "'"+(sitestring[1].trim().equalsIgnoreCase("undefined") || sitestring[1].trim().equalsIgnoreCase("NaN")|| sitestring[1].trim().equalsIgnoreCase("")|| sitestring[1].isEmpty()?0:sitestring[1].trim())+"',"
							+ "'"+(sitestring[2].trim().equalsIgnoreCase("undefined") || sitestring[2].trim().equalsIgnoreCase("NaN")||sitestring[2].trim().equalsIgnoreCase("")|| sitestring[2].isEmpty()?0:sitestring[2].trim())+"',"
							+ "'"+(sitestring[3].trim().equalsIgnoreCase("undefined") || sitestring[3].trim().equalsIgnoreCase("NaN")||sitestring[3].trim().equalsIgnoreCase("")|| sitestring[3].isEmpty()?0:sitestring[3].trim())+"',"
							+ "'"+(sitestring[4].trim().equalsIgnoreCase("undefined") || sitestring[4].trim().equalsIgnoreCase("NaN")||sitestring[4].trim().equalsIgnoreCase("")|| sitestring[4].isEmpty()?0:sitestring[4].trim())+"',"
							+ "'"+(sitestring[5].trim().equalsIgnoreCase("undefined") || sitestring[5].trim().equalsIgnoreCase("NaN")||sitestring[5].trim().equalsIgnoreCase("")|| sitestring[5].isEmpty()?0:sitestring[5].trim())+"',"
							+ "'"+(sitestring[6].trim().equalsIgnoreCase("undefined") || sitestring[6].trim().equalsIgnoreCase("NaN")||sitestring[6].trim().equalsIgnoreCase("")|| sitestring[6].isEmpty()?0:sitestring[6].trim())+"',"
							+ "'"+(sitestring[7].trim().equalsIgnoreCase("undefined") || sitestring[7].trim().equalsIgnoreCase("NaN")||sitestring[7].trim().equalsIgnoreCase("")|| sitestring[7].isEmpty()?0:sitestring[7].trim())+"',"
							+"'"+docno+"')"; 

					int resultSetsiteedit2 = stmtQuotation.executeUpdate (sql);
					if(resultSetsiteedit2<=0)
					{
						conn.close();
						return false;
					}	

				}

			} 
			
			/*if(val>0) {  
				String sql="update sk_srvqotm set status=0 where tr_no='"+docno+"'";   
				int resultSetsite3 = stmtQuotation.executeUpdate (sql);
				if(resultSetsite3<=0){  
					conn.close();
					return false;   
				}	
			}*/ 
			
			if (aaa > 0) {
				 String sql="UPDATE sk_srvqotm q LEFT JOIN gl_enqm e ON (e.doc_no=q.refdocno AND q.refdtype='ENQ') LEFT JOIN sk_servsited qs ON qs.tr_no=q.tr_no INNER JOIN gl_enqsited es ON es.rdocno=e.doc_no AND es.sr_no=qs.sr_no LEFT JOIN gl_enqdet ed on ed.rdocno=e.doc_no SET es.site=qs.site, es.areaid=qs.areaid, ed.site=qs.site WHERE q.tr_no='"+docno+"' AND (qs.site!=es.site OR qs.areaid!=es.areaid)"; 
				 stmtQuotation.executeUpdate (sql);
					
				 String sql2="INSERT INTO gl_enqsited(rdocno, sr_no, site, areaid) SELECT e.doc_no, qs.sr_no, qs.site, qs.areaid FROM sk_srvqotm q LEFT JOIN gl_enqm e ON (e.doc_no=q.refdocno AND q.refdtype='ENQ') LEFT JOIN sk_servsited qs ON qs.tr_no=q.tr_no AND qs.revision_no=q.revision_no LEFT JOIN gl_enqsited es ON es.rdocno=e.doc_no AND es.sr_no=qs.sr_no WHERE q.doc_no='"+docno+"' AND es.rowno IS NULL"; 
				 stmtQuotation.executeUpdate (sql2);
				 
				 String sql3="UPDATE sk_srvqotm q LEFT JOIN gl_enqm e ON (e.doc_no=q.refdocno AND q.refdtype='ENQ') SET e.cperson='"+cperson+"', e.mob='"+mob+"', e.telno='"+tel+"', e.email='"+email+"' WHERE q.tr_no='"+docno+"'";    
				 stmtQuotation.executeUpdate (sql3);   
				 
				int aprcount = 0;
				String sqlcnt = "select count(*) count from my_exdet where dtype='QOT' and doc_no='"+vocno+"' and brhid='"+branchid+"' and apprstatus in(1,3)";
				ResultSet rss = stmtQuotation.executeQuery(sqlcnt);
				while(rss.next()) {
					aprcount = rss.getInt("count");
				}  
				if(aprcount>1) {        
					String sqlup = "update my_exdet set apprstatus=8 where dtype='QOT' and doc_no='"+vocno+"' and brhid='"+branchid+"' and apprstatus not in(8,9)";
					stmtQuotation.executeUpdate(sqlup);
				}
				int apruserid = 0, countval = 0;   
				String sqlcnt2 = "select b.userid apruser from(select count(*) as count, max(apprlevel) apprlevel, dtype, brhid from my_exdoc where dtype='QOT' and brhid='"+branchid+"')a left join my_exdoc b on b.dtype=a.dtype and b.brhid=a.brhid and b.apprlevel=a.apprlevel";
                ResultSet rss2 = stmtQuotation.executeQuery(sqlcnt2);    
                while(rss2.next()) {
                    apruserid = rss2.getInt("apruser");  
                }  
                String sqlcnt3 = "select d.sr_no countchk from sk_srvcontrm m left join my_exdet d on d.dtype=m.dtype and m.doc_no=d.doc_no and m.brhid=d.brhid where m.tr_no='"+docno+"' and d.apprstatus not in(8,9) and d.userid='"+apruserid+"'";
                ResultSet rss3 = stmtQuotation.executeQuery(sqlcnt3);  
                while(rss3.next()) {
                    countval = rss3.getInt("countchk");          
                }
                if(aprcount>1) {  
                    String sqlup = "update my_exdet set apprstatus=8 where dtype='QOT' and doc_no='"+vocno+"' and brhid='"+branchid+"' and apprstatus not in(8,9)";
                    stmtQuotation.executeUpdate(sqlup);
                }else if(countval>0) {
                    String sqlup = "update my_exdet set apprstatus=8 where dtype='QOT' and doc_no='"+vocno+"' and brhid='"+branchid+"' and apprstatus not in(8,9)";
                    stmtQuotation.executeUpdate(sqlup);     
                }else {} 
                
				conn.commit();
				stmtQuotation.close();
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

	public boolean delete(int docno, Date sqlStartDate, String mode, String dtype, HttpSession session) throws SQLException {	   

		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);  
			
			CallableStatement stmtQuotation = conn.prepareCall("{call sk_QuotationDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				
				stmtQuotation.setDate(1,sqlStartDate);
				stmtQuotation.setString(2,"0");
				stmtQuotation.setString(3,"0");
				stmtQuotation.setString(4,"0");
				stmtQuotation.setString(5,"0");
				stmtQuotation.setString(6,"0");
				stmtQuotation.setDouble(7,0.00);    
				stmtQuotation.setString(8,dtype);     
				stmtQuotation.setString(9,session.getAttribute("USERID").toString());
			    stmtQuotation.setString(10,session.getAttribute("BRANCHID").toString());  
				stmtQuotation.setString(11,mode);
			    stmtQuotation.setInt(12, docno);
				stmtQuotation.setString(13, "0"); 
				stmtQuotation.setString(14, "0");   
				stmtQuotation.setString(15,"0"); 
				stmtQuotation.setString(16,"0");
				stmtQuotation.setString(17,"0");    
				stmtQuotation.setString(18,"0"); 
				stmtQuotation.setString(19,"0"); 
				stmtQuotation.setString(20,"");    
			   int aaa=stmtQuotation.executeUpdate();
			   docno=stmtQuotation.getInt("docNo");

			if(aaa<=0){

				return false;

			}

			if (aaa > 0) {
				conn.commit();
				stmtQuotation.close();
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

	public boolean revise(Date sqlStartDate,int docno,String vocno,HttpSession session,HttpServletRequest request,ArrayList<String> sitearray,ArrayList<String> enqarray,String desc,
			String billingmethod,String payterms,String cpersonid,String mob,String tel,String email,String cperson) throws SQLException {
		try{  
			conn=conobj.getMyConnection();  
			conn.setAutoCommit(false);      
            Statement stmtQuotation=conn.createStatement();    
            int revisionno=0,aaa=0,qotbrhid=0;
            String sqls="select coalesce(revision_no+1,1) revision,brhid from sk_srvqotm where tr_no='"+docno+"'";     
			ResultSet rs = stmtQuotation.executeQuery(sqls);
            while(rs.next()) {
            	revisionno=rs.getInt("revision");  
            	qotbrhid=rs.getInt("brhid");    
            }
            if(cpersonid.trim().equals("") || cpersonid==null) {   
            	cpersonid="0";
            }
            String upsql="update sk_srvqotm set revision_no="+revisionno+", cpersonid='"+cpersonid+"', mob='"+mob+"', tel='"+tel+"', email='"+email+"', cperson='"+cperson+"', remarks='"+desc+"', billingmethod='"+billingmethod+"', payterms='"+payterms+"',Date='"+sqlStartDate+"' where tr_no='"+docno+"'";    
            aaa = stmtQuotation.executeUpdate (upsql); 
			if(aaa<=0){  
				conn.close();
				return false;     
			}  
			request.setAttribute("revisionno", revisionno);  
			int val=0;
			for(int i=0;i< enqarray.size();i++){       

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[0].trim().equalsIgnoreCase("undefined")|| enqiury[0].trim().equalsIgnoreCase("NaN")||enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()))
				{
					Double rate= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:Double.parseDouble(enqiury[10].trim());     
					Double tariff= enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:Double.parseDouble(enqiury[18].trim()); 
					if(rate<tariff) {
						val=1;  
					}
					String ratepercollection= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?"":enqiury[10].trim(); 
					String tippingfee= enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?"":enqiury[11].trim(); 
					String skiprent= enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?"":enqiury[13].trim(); 
					String tippingsecurity= enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?"":enqiury[16].trim();
					String addrate= enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?"":enqiury[21].trim(); 
					if(ratepercollection=="" || tippingfee=="" ||  skiprent=="" ||  tippingsecurity=="" || addrate=="" || ratepercollection=="0" || tippingfee=="0" ||  skiprent=="0" ||  tippingsecurity=="0" || addrate=="0") {   
						val=1;  
					}    
					String sql="INSERT INTO sk_srvqotdet(srno, revision_no, site, skiptype, nos, wastetype, ownershipid, servicebyid, servicetermid, scheduledays, specid, collectionid, rate, tippingfee, foc, rent, securityval, tippingmethod, tippingsecurity, restricted, tariffrate, gatefee, addrate, ctypeid, rdocno)VALUES"
							+ " ("+(i+1)+","
							+ " "+revisionno+","
							+ "'"+(enqiury[0].trim().equalsIgnoreCase("undefined") || enqiury[0].trim().equalsIgnoreCase("NaN")|| enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()?0:enqiury[0].trim())+"',"
							+ "'"+(enqiury[1].trim().equalsIgnoreCase("undefined") || enqiury[1].trim().equalsIgnoreCase("NaN")|| enqiury[1].trim().equalsIgnoreCase("")|| enqiury[1].isEmpty()?0:enqiury[1].trim())+"',"
							+ "'"+(enqiury[2].trim().equalsIgnoreCase("undefined") || enqiury[2].trim().equalsIgnoreCase("NaN")||enqiury[2].trim().equalsIgnoreCase("")|| enqiury[2].isEmpty()?0:enqiury[2].trim())+"',"
							+ "'"+(enqiury[3].trim().equalsIgnoreCase("undefined") || enqiury[3].trim().equalsIgnoreCase("NaN")||enqiury[3].trim().equalsIgnoreCase("")|| enqiury[3].isEmpty()?0:enqiury[3].trim())+"',"
							+ "'"+(enqiury[4].trim().equalsIgnoreCase("undefined") || enqiury[4].trim().equalsIgnoreCase("NaN")||enqiury[4].trim().equalsIgnoreCase("")|| enqiury[4].isEmpty()?0:enqiury[4].trim())+"',"
							+ "'"+(enqiury[5].trim().equalsIgnoreCase("undefined") || enqiury[5].trim().equalsIgnoreCase("NaN")||enqiury[5].trim().equalsIgnoreCase("")|| enqiury[5].isEmpty()?0:enqiury[5].trim())+"',"
							+ "'"+(enqiury[6].trim().equalsIgnoreCase("undefined") || enqiury[6].trim().equalsIgnoreCase("NaN")||enqiury[6].trim().equalsIgnoreCase("")|| enqiury[6].isEmpty()?0:enqiury[6].trim())+"',"
							+ "'"+(enqiury[7].trim().equalsIgnoreCase("undefined") || enqiury[7].trim().equalsIgnoreCase("NaN")||enqiury[7].trim().equalsIgnoreCase("")|| enqiury[7].isEmpty()?0:enqiury[7].trim())+"',"
							+ "'"+(enqiury[8].trim().equalsIgnoreCase("undefined") || enqiury[8].trim().equalsIgnoreCase("NaN")||enqiury[8].trim().equalsIgnoreCase("")|| enqiury[8].isEmpty()?0:enqiury[8].trim())+"',"
							+ "'"+(enqiury[9].trim().equalsIgnoreCase("undefined") || enqiury[9].trim().equalsIgnoreCase("NaN")||enqiury[9].trim().equalsIgnoreCase("")|| enqiury[9].isEmpty()?0:enqiury[9].trim())+"',"
							+ "'"+(enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:enqiury[10].trim())+"',"
							+ "'"+(enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?0:enqiury[11].trim())+"',"   
							+ "'"+(enqiury[12].trim().equalsIgnoreCase("undefined") || enqiury[12].trim().equalsIgnoreCase("NaN")||enqiury[12].trim().equalsIgnoreCase("")|| enqiury[12].isEmpty()?0:enqiury[12].trim())+"',"     
							+ "'"+(enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?0:Round(Double.parseDouble(enqiury[13].trim()),0))+"',"
							+ "'"+(enqiury[14].trim().equalsIgnoreCase("undefined") || enqiury[14].trim().equalsIgnoreCase("NaN")||enqiury[14].trim().equalsIgnoreCase("")|| enqiury[14].isEmpty()?0:Round(Double.parseDouble(enqiury[14].trim()),0))+"',"  
							+ "'"+(enqiury[15].trim().equalsIgnoreCase("undefined") || enqiury[15].trim().equalsIgnoreCase("NaN")||enqiury[15].trim().equalsIgnoreCase("")|| enqiury[15].isEmpty()?0:enqiury[15].trim())+"',"
							+ "'"+(enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?0:Round(Double.parseDouble(enqiury[16].trim()),0))+"',"  
							+ "'"+(enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?0:enqiury[17].trim())+"',"    		
							+ "'"+(enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:enqiury[18].trim())+"',"	
						    + "'"+(enqiury[20].trim().equalsIgnoreCase("undefined") || enqiury[20].trim().equalsIgnoreCase("NaN")||enqiury[20].trim().equalsIgnoreCase("")|| enqiury[20].isEmpty()?0:enqiury[20].trim())+"',"
						    + "'"+(enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?0:enqiury[21].trim())+"',"	
							+ "'"+(enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?0:enqiury[22].trim())+"',"
							+"'"+docno+"')";                   
  
					int resultSet2 = stmtQuotation.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return false;
					}	

				}

			}
			for(int i=0;i< sitearray.size();i++){

				String[] sitestring=sitearray.get(i).split("::");
				
				if(!(sitestring[0].trim().equalsIgnoreCase("undefined")|| sitestring[0].trim().equalsIgnoreCase("NaN")||sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()))
				{
					String sql="INSERT INTO sk_servsited(sr_no, revision_no, site, remarks, areaId, survid, route, gpsx, gpsy, description, tr_no)VALUES"    
							+ " ("+(i+1)+","
						    + " "+revisionno+","  
							+ "'"+(sitestring[0].trim().equalsIgnoreCase("undefined") || sitestring[0].trim().equalsIgnoreCase("NaN")|| sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()?0:sitestring[0].trim())+"',"
							+ "'"+(sitestring[1].trim().equalsIgnoreCase("undefined") || sitestring[1].trim().equalsIgnoreCase("NaN")|| sitestring[1].trim().equalsIgnoreCase("")|| sitestring[1].isEmpty()?0:sitestring[1].trim())+"',"
							+ "'"+(sitestring[2].trim().equalsIgnoreCase("undefined") || sitestring[2].trim().equalsIgnoreCase("NaN")||sitestring[2].trim().equalsIgnoreCase("")|| sitestring[2].isEmpty()?0:sitestring[2].trim())+"',"
							+ "'"+(sitestring[3].trim().equalsIgnoreCase("undefined") || sitestring[3].trim().equalsIgnoreCase("NaN")||sitestring[3].trim().equalsIgnoreCase("")|| sitestring[3].isEmpty()?0:sitestring[3].trim())+"',"
							+ "'"+(sitestring[4].trim().equalsIgnoreCase("undefined") || sitestring[4].trim().equalsIgnoreCase("NaN")||sitestring[4].trim().equalsIgnoreCase("")|| sitestring[4].isEmpty()?0:sitestring[4].trim())+"',"
							+ "'"+(sitestring[5].trim().equalsIgnoreCase("undefined") || sitestring[5].trim().equalsIgnoreCase("NaN")||sitestring[5].trim().equalsIgnoreCase("")|| sitestring[5].isEmpty()?0:sitestring[5].trim())+"',"
							+ "'"+(sitestring[6].trim().equalsIgnoreCase("undefined") || sitestring[6].trim().equalsIgnoreCase("NaN")||sitestring[6].trim().equalsIgnoreCase("")|| sitestring[6].isEmpty()?0:sitestring[6].trim())+"',"
							+ "'"+(sitestring[7].trim().equalsIgnoreCase("undefined") || sitestring[7].trim().equalsIgnoreCase("NaN")||sitestring[7].trim().equalsIgnoreCase("")|| sitestring[7].isEmpty()?0:sitestring[7].trim())+"',"
							+"'"+docno+"')";    

					int resultSetsite2 = stmtQuotation.executeUpdate (sql);
					if(resultSetsite2<=0)
					{
						conn.close();
						return false;
					}	

				}

			} 
			/*if(val>0) {  
				String sql="update sk_srvqotm set status=0 where tr_no='"+docno+"'";   
				int resultSetsite3 = stmtQuotation.executeUpdate (sql);
				if(resultSetsite3<=0){  
					conn.close();
					return false;
				}	
			}*/  
			if(aaa > 0) {
				 String sql="UPDATE sk_srvqotm q LEFT JOIN gl_enqm e ON (e.doc_no=q.refdocno AND q.refdtype='ENQ') LEFT JOIN sk_servsited qs ON qs.tr_no=q.tr_no AND qs.revision_no=q.revision_no INNER JOIN gl_enqsited es ON es.rdocno=e.doc_no AND es.sr_no=qs.sr_no LEFT JOIN gl_enqdet ed on ed.rdocno=e.doc_no SET es.site=qs.site, es.areaid=qs.areaid, ed.site=qs.site WHERE q.tr_no='"+docno+"' AND (qs.site!=es.site OR qs.areaid!=es.areaid)"; 
				 stmtQuotation.executeUpdate (sql); 
				 
				 String sql2="INSERT INTO gl_enqsited(rdocno, sr_no, site, areaid) SELECT e.doc_no, qs.sr_no, qs.site, qs.areaid FROM sk_srvqotm q LEFT JOIN gl_enqm e ON (e.doc_no=q.refdocno AND q.refdtype='ENQ') LEFT JOIN sk_servsited qs ON qs.tr_no=q.tr_no AND qs.revision_no=q.revision_no LEFT JOIN gl_enqsited es ON es.rdocno=e.doc_no AND es.sr_no=qs.sr_no WHERE q.doc_no='"+docno+"' AND es.rowno IS NULL"; 
				 stmtQuotation.executeUpdate (sql2);  
					   
				int icount = 0, iapprovalStatus = 3;
				String sqlstr1="select count(*) icount from my_apprmaster where status=3 and dtype='QOT'";              
				ResultSet rs1 = stmtQuotation.executeQuery(sqlstr1);  
				while(rs1.next()){
						icount = rs1.getInt("icount");
				} 
				if(icount>0){
					iapprovalStatus = 0;
			    }     
				String upsql1="update sk_srvqotm set status="+iapprovalStatus+" where tr_no='"+docno+"'";
				stmtQuotation.executeUpdate (upsql1);  
				
				int aprcount = 0;
				String sqlcnt = "select count(*) count from my_exdet where dtype='QOT' and doc_no='"+vocno+"' and brhid='"+qotbrhid+"' and apprstatus in(1,3)";
				ResultSet rss = stmtQuotation.executeQuery(sqlcnt);
				while(rss.next()) {
					aprcount = rss.getInt("count");
				}  
				if(aprcount>1) { 
					String sqlup = "update my_exdet set apprstatus=8 where dtype='QOT' and doc_no='"+vocno+"' and brhid='"+qotbrhid+"' and apprstatus not in(8,9)";
					stmtQuotation.executeUpdate(sqlup); 
				}
				int apruserid = 0, countval = 0;   
                String sqlcnt2 = "select b.userid apruser from(select count(*) as count, max(apprlevel) apprlevel, dtype, brhid from my_exdoc where dtype='QOT' and brhid='"+qotbrhid+"')a left join my_exdoc b on b.dtype=a.dtype and b.brhid=a.brhid and b.apprlevel=a.apprlevel";
                ResultSet rss2 = stmtQuotation.executeQuery(sqlcnt2);    
                while(rss2.next()) {
                    apruserid = rss2.getInt("apruser");  
                }  
                String sqlcnt3 = "select d.sr_no countchk from sk_srvcontrm m left join my_exdet d on d.dtype=m.dtype and m.doc_no=d.doc_no and m.brhid=d.brhid where m.tr_no='"+docno+"' and d.apprstatus not in(8,9) and d.userid='"+apruserid+"'";
                ResultSet rss3 = stmtQuotation.executeQuery(sqlcnt3);  
                while(rss3.next()) {
                    countval = rss3.getInt("countchk");          
                }
                if(aprcount>1) {  
                    String sqlup = "update my_exdet set apprstatus=8 where dtype='QOT' and doc_no='"+vocno+"' and brhid='"+qotbrhid+"' and apprstatus not in(8,9)";
                    stmtQuotation.executeUpdate(sqlup);
                }else if(countval>0) {
                    String sqlup = "update my_exdet set apprstatus=8 where dtype='QOT' and doc_no='"+vocno+"' and brhid='"+qotbrhid+"' and apprstatus not in(8,9)";
                    stmtQuotation.executeUpdate(sqlup);     
                }else {} 
			}
			if (aaa > 0) {
				conn.commit();
				stmtQuotation.close();
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


	public JSONArray searchSource(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVehclr = conn.createStatement ();

			ResultSet resultSet = stmtVehclr.executeQuery ("SELECT txtname,doc_no FROM cm_enqsource c where status=3");

			RESULTDATA=com.convertToJSON(resultSet);
			stmtVehclr.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	 public JSONArray searchEnquiry(HttpSession session,String clnames,String docno,int id) throws SQLException {    
			JSONArray RESULTDATA=new JSONArray();  
			if(id==0){  
				return RESULTDATA;
			}  
			String sqltest="";
			if(!(docno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";  
			}
			if(!(clnames.equalsIgnoreCase(""))){
				sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";  
			}
			Connection conn = null;

			try {
				 conn = conobj.getMyConnection();
				 Statement stmtenq1 = conn.createStatement ();
				 String clsql= "select  at.ay_name,m.cperson,cp.row_no cpersonid,coalesce(a1.name,'') groupcompanies,m.com_add1, m.mob, m.telno, m.email,m.remarks,m.voc_no,m.doc_no,m.name refname,sc.txtname source,m.sourceid,sm.sal_name,m.sal_id,m.cldocno from gl_enqm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_enqsource sc on sc.doc_no=m.sourceid left join my_salm sm on sm.doc_no=m.sal_id left join sk_srvqotm q on q.refdocno=m.doc_no and q.refdtype='ENQ' left join sk_clgroup a1 on (ac.grpcmp=a1.docno or m.grpcmpid=a1.docno) left join my_crmcontact cp on cp.cldocno=ac.cldocno left join my_activity at on m.activityid = at.doc_no where m.status<>7 and q.tr_no is null and m.dropped=0 "+sqltest+" group by m.doc_no order by m.doc_no";
				  //System.out.println("====Enquiry Search===="+clsql);                 
				ResultSet resultSet = stmtenq1.executeQuery(clsql);  

				RESULTDATA=com.convertToJSON(resultSet);
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


	  public JSONArray searchMaster(HttpSession session,String msdocno,String msenqno,String clnames,String enqdate,String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();  
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}  
		java.sql.Date sqlStartDate=null;
		//enqdate.trim();
		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(enqdate);
		}
		String sqltest="";
		if(!(msenqno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and em.voc_no like '%"+msenqno+"%'";   
		}
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and em.name like '%"+clnames+"%'";
		}
		if(sqlStartDate!=null) {
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";   
		}
		Connection conn = null;

		try {
			 conn = conobj.getMyConnection();
			 Statement stmtenq1 = conn.createStatement ();
			/* String sql1="select salesuserlink from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
	    	 System.out.println("sql3====="+sql1); 
	    	 ResultSet rs =stmtenq1.executeQuery(sql1);         
	    	 if(rs.next()){
	    		 sqltest+=" and sm.salesuserlink="+session.getAttribute("USERID");
	    	 }*/     
			 String clsql= "select at.ay_name,m.cperson,cp.row_no cpersonid,d.revision_no,m.payterms,m.billingmethod,coalesce(a1.name,'') groupcompanies,round(coalesce(m.netamount,0),2) netamount,date_format(m.date,'%d.%m.%Y') date,em.com_add1, m.mob, m.tel telno, m.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,em.name refname,sc.txtname source,m.source_id,sm.sal_name,m.sal_id,m.cldocno from sk_srvqotm m left join sk_srvqotdet d on d.rdocno=m.tr_no left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) left join cm_enqsource sc on sc.doc_no=m.source_id left join my_salm sm on sm.doc_no=m.sal_id left join my_crmcontact cp on cp.row_no=m.cpersonid left join my_activity at on em.activityid = at.doc_no where m.status<>7 "+sqltest+" group by d.rdocno,d.revision_no";
			 //System.out.println("====Main Search===="+clsql);                    
			ResultSet resultSet = stmtenq1.executeQuery(clsql);  

			RESULTDATA=com.convertToJSON(resultSet);
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
	public JSONArray siteGridLoad(HttpSession session,String docno,int id,String revisionno) throws SQLException{ 
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			if(id==1) {   
				sql="select a.rdocno,eq.sr_no,eq.rowno,(SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
						+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.surv_id) order by doc_no) surtype,eq.site,aa.area,eq.remarks, eq.areaid, "
						+ "eq.surv_id surid, eq.route, eq.gpsx, eq.gpsy, eq.description from gl_enqsited eq left join (select eq.rdocno,eq.surv_id,eq.sr_no   "
						+ "from gl_enqsited eq where eq.rdocno="+docno+") a on (a.rdocno =eq.rdocno and a.sr_no=eq.sr_no) "
						+ "left join my_area aa on aa.doc_no=eq.areaid where eq.rdocno="+docno+"  group by eq.rowno";
			}else if(id==2) {
			    if(revisionno.equals("999999")){   
                    String strsql = "select revision_no from sk_srvqotm where tr_no='"+docno+"'";   
                    ResultSet rs1 = stmt.executeQuery(strsql);
                    while(rs1.next()){
                        revisionno = rs1.getString("revision_no");
                    }
                }
				sql="select a.tr_no rdocno,eq.sr_no,eq.rowno,(SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
						+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.survid) order by doc_no) surtype,eq.site,aa.area,eq.remarks, eq.areaid, "
						+ "eq.survid surid, eq.route, eq.gpsx, eq.gpsy, eq.description  from sk_servsited eq  left  join (select eq.tr_no,eq.survid,eq.sr_no   "
						+ "from sk_servsited eq where eq.tr_no="+docno+") a on (a.tr_no =eq.tr_no and a.sr_no=eq.sr_no) "
						+ "left join my_area aa on aa.doc_no=eq.areaid where eq.tr_no="+docno+" and eq.revision_no='"+revisionno+"' group by eq.rowno";           
			}else {}    
		    //System.out.println("===sql===="+sql);

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
	public JSONArray quoteGridLoad(HttpSession session,String docno,int id,String revisionno) throws SQLException{  
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();
			//System.out.println("===revisionno===="+revisionno); 
			String sql = ""; 
			if(id==1) {
				sql="select '' ctype,0 ctypeid,r3.tripsinmonth,0 rowno,'FIXED' tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, d.site, d.nos, d.servmethod ownershipid,d.servmethod servicebyid, d.scheduletype servicetermid, d.scheduledays days, d.sepcid specid, d.collection collectionid,tf.tariff rate,tf.tariff tariffrate,tf.tariff addrate,0 tippingfee, 0 rent, '' foc,r2.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,0 securityval,1 tippingmethodid,0 tippingsecurity,0 restricted,sk.value gatefee from gl_enqdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_enqrelated r1 on (r1.srno=d.method and r1.type='METHOD') left join sk_enqrelated r2 on (r2.srno=d.servmethod and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.scheduletype and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.sepcid) left join sk_enqrelated r4 on (r4.srno=d.collection and r4.type='COLLECTION') left join (select d.rowno,if(r.name='CLIENT SKIP',t.client,t.own) tariff from gl_enqdet d left join sk_skiptarif t on t.skiptypeid=d.skiptype left join sk_enqrelated r on (r.srno=d.servmethod and r.type='SERVICEBY')  where d.scheduledays between t.from and t.to)tf on tf.rowno=d.rowno where d.rdocno='"+docno+"'";
			}else if(id==2) {
			    if(revisionno.equals("999999")){   
			        String strsql = "select revision_no from sk_srvqotm where tr_no='"+docno+"'";   
	                ResultSet rs1 = stmt.executeQuery(strsql);
	                while(rs1.next()){
	                    revisionno = rs1.getString("revision_no");
	                }
			    }
				sql="select r6.name ctype,d.ctypeid,r3.tripsinmonth,d.rowno,r5.name tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, d.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, d.tariffrate, d.addrate, d.tippingfee, d.rent, d.foc,r2.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,d.securityval, coalesce(d.tippingmethod,1) tippingmethodid, round(d.tippingsecurity,0) tippingsecurity, d.restricted, d.gatefee from sk_srvqotdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='METHOD') left join sk_enqrelated r2 on (r2.srno=d.ownershipid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION') left join sk_enqrelated r5 on (r5.srno=coalesce(d.tippingmethod,1) and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where d.rdocno='"+docno+"' and d.revision_no='"+revisionno+"'";  
			}else {}     
			//System.out.println("===sql===="+sql);    

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
	public JSONArray areaSearch(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql= ("select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3" );
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
	public  JSONArray SalesgentSearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh = conn.createStatement (); 

			String salsql="select doc_no,sal_name from my_salm where  status<>7 ";

			ResultSet resultSet = stmtVeh.executeQuery(salsql);
			RESULTDATA=com.convertToJSON(resultSet);
			stmtVeh.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray searchSerType(HttpSession session,String sertype,String sertypeid,String id) throws SQLException {


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


		String sqltest="";


		if(!(sertype.equalsIgnoreCase("undefined"))&&!(sertype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.name like '%"+sertype+"%'";
		}

		if(!(sertypeid.equalsIgnoreCase("undefined"))&&!(sertypeid.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no not in("+sertypeid+")";
		}


		Connection conn = null;
		ResultSet resultSet =null;
		try {
			if(Integer.parseInt(id)>0){
				conn = conobj.getMyConnection();
				Statement stmtenq1 = conn.createStatement ();

				String str1Sql=("select doc_no,name from cm_proptypem m where status=3 "+sqltest+"");

//				System.out.println("==searchSerType==="+str1Sql);


				resultSet = stmtenq1.executeQuery(str1Sql);


				RESULTDATA=com.convertToJSON(resultSet);
				stmtenq1.close();
				conn.close();
			}

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}

		return RESULTDATA;
	}
	
	
	public JSONArray skipSearch(HttpSession session) throws SQLException{


		JSONArray RESULTDATA1=new JSONArray();

		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";

			sql="select name skiptype,doc_no skipdoc,round(value,2) value from sk_skiptype where status=3";


			//System.out.println("===sql===="+sql);

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
	
	public JSONArray wasteSearch(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			sql="select name wastetype,doc_no wastedoc from sk_dumptype where status=3";
			//System.out.println("===sql===="+sql);
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
	public JSONArray specSearch(HttpSession session) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "";
			sql="select doc_no,name spec from sk_spec where status=3";
			//System.out.println("===sql===="+sql);
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
	public JSONArray otherDetailSearch(HttpSession session,String type) throws SQLException{  
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select srno, name, srno doc_no,tripsinmonth from sk_enqrelated where status=3 and type='"+type+"'";
			//System.out.println("===sql===="+sql);
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
	public ClsQuotationBean getViewDetails(HttpSession session,String docno) throws SQLException {      
		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();   
			String branchid=session.getAttribute("BRANCHID").toString(); 
			String Sql= "select  at.ay_name,m.cperson,cp.row_no cpersonid,m.payterms,m.billingmethod,coalesce(a1.name,'') groupcompanies,round(coalesce(m.netamount,0),2) netamount,"
					+ "date_format(m.date,'%d.%m.%Y') fdate,m.date date,em.com_add1, m.mob, m.tel telno, m.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,"
					+ "m.tr_no,em.name refname,sc.txtname source,m.source_id,sm.sal_name,m.sal_id,m.cldocno from sk_srvqotm m left join gl_enqm em on em.doc_no=m.refdocno "
					+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) "
					+ "left join cm_enqsource sc on sc.doc_no=m.source_id left join my_salm sm on sm.doc_no=m.sal_id left join my_crmcontact cp on cp.row_no=m.cpersonid left join my_activity at on em.activityid = at.doc_no "
					+ " where m.status<>7 and m.doc_no='"+docno+"' and m.brhid='"+branchid+"'";  
			//System.out.println("===getViewDetails===="+Sql);      
			ResultSet rs = stmt.executeQuery(Sql);
			while(rs.next()){
				bean.setDate(rs.getDate("date"));
				bean.setTxtdesig(rs.getString("ay_name"));        
				bean.setHidenqdocno(rs.getString("enqdocno"));
				bean.setHidcldocno(rs.getString("cldocno"));
				bean.setSourceid(rs.getString("source_id"));
				bean.setTxtsalesmandocno(rs.getString("sal_id"));
				bean.setTxtdesc(rs.getString("remarks"));  
				bean.setTxtenquiry(rs.getString("enqvocno"));
				bean.setTxtclient(rs.getString("refname"));
				bean.setTxtsource(rs.getString("source"));  
				bean.setTxtsalesman(rs.getString("sal_name"));
				bean.setTxtaddress(rs.getString("com_add1"));
				bean.setTxtmail(rs.getString("email"));
				bean.setTxtmob(rs.getString("mob"));
				bean.setTxttele(rs.getString("telno"));  
				bean.setTxtgroupcompanies(rs.getString("groupcompanies"));
				bean.setHidcmbbillingmethod(rs.getString("billingmethod"));        
				bean.setCmbbillingmethod(rs.getString("billingmethod"));
				bean.setCmbpayterm(rs.getString("payterms"));   
				bean.setHidcmbpayterm(rs.getString("payterms"));
				bean.setMasterdoc_no(rs.getInt("tr_no"));    
				bean.setDocno(rs.getString("doc_no"));  
				bean.setTxtcperson(rs.getString("cperson"));
				bean.setHidcpersonid(rs.getString("cpersonid"));    
			}
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return bean;
	}
	public JSONArray otherContractsLoad(String cldocno) throws SQLException{   
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select m.date, m.startdt, m.enddt,r6.name ctype,d.ctypeid, d.addrate,r3.tripsinmonth,d.rowno,r5.name tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, s.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, d.tariffrate, d.tippingfee, d.rent, d.foc,r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,s.rowno siteid,d.securityval, coalesce(d.tippingmethod,1) tippingmethodid, round(d.tippingsecurity,0) tippingsecurity, d.restricted, d.gatefee from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION')  left join sk_enqrelated r5 on (r5.srno=coalesce(d.tippingmethod,1) and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where m.cldocno='"+cldocno+"'";
			//System.out.println("===sql===="+sql);          

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
	public JSONArray pendingqoutesLoad(String cldocno) throws SQLException{    
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select date_format(qm.date,'%d.%m.%Y') date,qm.doc_no,r6.name ctype,d.ctypeid, d.addrate,r3.tripsinmonth,d.rowno,r5.name tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, d.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, d.tariffrate, d.tippingfee, d.rent, d.foc,r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,d.securityval, coalesce(d.tippingmethod,1) tippingmethodid, round(d.tippingsecurity,0) tippingsecurity, d.restricted, d.gatefee from sk_srvqotm qm left join sk_srvqotdet d on d.rdocno=qm.tr_no left join sk_srvcontrm m on (m.refdocno=qm.refdocno and m.refdtype=qm.refdtype) left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION')  left join sk_enqrelated r5 on (r5.srno=coalesce(d.tippingmethod,1) and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where qm.cldocno='"+cldocno+"' and m.tr_no is null";
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
	 public double Round(double value,int deci) throws SQLException {
	    	Connection conn=null;
	    	try{
	    		
	    		conn=conobj.getMyConnection();  
	    		Statement stmt=conn.createStatement();
	    		BigDecimal bd = new BigDecimal(value).setScale(deci, RoundingMode.HALF_EVEN);
	    	      value = bd.doubleValue();
	    	      stmt.close();
	    	      conn.close();
	    	      
	    	}
	    	catch(Exception e){
	    		e.printStackTrace();
	    		conn.close();
	    	}
	    	finally{
	    		conn.close();
	    	}
	    	return value; 
	   }
	 public  JSONArray contactSearch(String cldocno) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn=null;
			try {
				conn = conobj.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

				String salsql="select e.mob,e.email,e.tel,e.cperson,e.row_no cpersonid,e.actvty_id ,ac.ay_name,ac.doc_no aydocno from my_crmcontact e  left join my_activity ac on e.actvty_id=ac.doc_no where e.cldocno='"+cldocno+"' ";
				System.out.println("contactSearch="+salsql); 
				ResultSet resultSet = stmtVeh.executeQuery(salsql);
				RESULTDATA=com.convertToJSON(resultSet);
				stmtVeh.close();
				conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			return RESULTDATA;
		}
}
