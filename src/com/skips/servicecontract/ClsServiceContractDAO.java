package com.skips.servicecontract;  

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
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
import com.skips.servicecontract.ClsServiceContractBean;

import net.sf.json.JSONArray;

public class ClsServiceContractDAO {   
	ClsConnection conobj= new ClsConnection();  
	ClsCommon com=new ClsCommon();
	ClsServiceContractBean bean= new ClsServiceContractBean(); 
	Connection conn;
	public int insert(Date sqlStartDate,String enqdocno,String cldocno,String salid,String desc,ArrayList<String> enqarray,
			HttpSession session,String mode,String dtype,HttpServletRequest request,ArrayList<String> sitearray,String netamount,
			Date startdate,Date enddate,String type,ArrayList<String> thirdarray,String billingmethod,String payterms,String reftype,
			String cctype,String invmethod,String advinvvalue,ArrayList<String> termsarray, String refno,String chkmergedinv,
			String cpersonid, String mob, String tel, String email, String advtype, String inctipfee, String invstart,String cperson,String invoicemail,String cnttrno,String intremarks,String extremarks,String manualinv) throws SQLException {   
		try{  
			int docno;
			conn=conobj.getMyConnection(); 
			Statement stmt =conn.createStatement();
			conn.setAutoCommit(false);     
			//System.out.println("IN DAO");
			Double total=0.0;  
			if(netamount != null && netamount.length() > 0) {  
				total=Double.parseDouble(netamount);   
			}else {
				total=0.0;   
			}
			String mergedinvoice="No";
			if(chkmergedinv.equalsIgnoreCase("1")) {   
				mergedinvoice="Yes";
			}else {
				mergedinvoice="No";
			}
			
			if(manualinv.trim().equalsIgnoreCase("") || manualinv==null) {
				manualinv="0";
			}   
			
            CallableStatement smtContract = conn.prepareCall("{call sk_serviceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");    
			
			smtContract.setDate(1,sqlStartDate);
			smtContract.setString(2,enqdocno==null || enqdocno.equalsIgnoreCase("")?"0":enqdocno);   
			smtContract.setString(3,cldocno);
			smtContract.setString(4,salid);
			smtContract.setString(5,desc);  
			smtContract.setDouble(6,total);   
			smtContract.setString(7,dtype);
			smtContract.setString(8,session.getAttribute("USERID").toString());
			smtContract.setString(9,session.getAttribute("BRANCHID").toString());
			smtContract.setString(10,mode);
			smtContract.setDate(11,startdate);
			smtContract.setDate(12,enddate);  
		    smtContract.registerOutParameter(13, java.sql.Types.INTEGER);
			smtContract.registerOutParameter(14, java.sql.Types.INTEGER);  
			smtContract.setString(15,type); 
			smtContract.setString(16,billingmethod==null || billingmethod.equalsIgnoreCase("")?"0":billingmethod);   
			smtContract.setString(17,payterms==null || payterms.equalsIgnoreCase("")?"0":payterms);     
			smtContract.setString(18,reftype); 
			smtContract.setString(19,cctype==null || cctype.equalsIgnoreCase("")?"0":cctype);
			smtContract.setString(20,invmethod==null || invmethod.equalsIgnoreCase("")?"0":invmethod); 
			smtContract.setString(21,advinvvalue==null || advinvvalue.equalsIgnoreCase("")?"0":advinvvalue);
			smtContract.setString(22,refno); 
			smtContract.setString(23,mergedinvoice); 
			smtContract.setString(24,cpersonid==null || cpersonid.equalsIgnoreCase("")?"0":cpersonid); 
			smtContract.setString(25,mob);
			smtContract.setString(26,tel);
			smtContract.setString(27,email); 
			smtContract.setString(28,advtype==null || advtype.equalsIgnoreCase("")?"0":advtype);
			smtContract.setString(29,inctipfee==null || inctipfee.equalsIgnoreCase("")?"0":inctipfee);
			smtContract.setString(30,invstart==null || invstart.equalsIgnoreCase("")?"0":invstart);   
			smtContract.setString(31,cperson);  
			smtContract.setString(32,invoicemail);   
			smtContract.setString(33,intremarks); 
			smtContract.setString(34,extremarks); 
			smtContract.setString(35,manualinv==null || manualinv.equalsIgnoreCase("")?"0":manualinv); 
			smtContract.executeQuery();     
			docno=smtContract.getInt("docNo");
			int vocno=smtContract.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			if(docno<=0){  
				conn.close(); 
				return 0;
			}	
			//System.out.println(enqarray+"=IN DAO="+sitearray); 
			for(int i=0;i< sitearray.size();i++){  

				String[] sitestring=sitearray.get(i).split("::");
				
				if(!(sitestring[0].trim().equalsIgnoreCase("undefined")|| sitestring[0].trim().equalsIgnoreCase("NaN")||sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()))
				{
					String sql1 = "";
					int refrowno=0;
					sql1="select coalesce(max(rowno)+1,1) as refrowno from sk_srvcsited ";  
					//System.out.println("==sql1=cm_srvcsited==="+sql1);
					ResultSet resultSet1 = stmt.executeQuery(sql1);
					while(resultSet1.next()){
						refrowno=resultSet1.getInt("refrowno");
					}
					String sql="INSERT INTO sk_srvcsited(rowno, sr_no, site, remarks, areaId, survid, route, gpsx, gpsy, description, tr_no) VALUES("        
							+ " "+refrowno+","
							+ " "+(i+1)+","
							+ "'"+(sitestring[0].trim().equalsIgnoreCase("undefined") || sitestring[0].trim().equalsIgnoreCase("NaN")|| sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()?0:sitestring[0].trim())+"',"
							+ "'"+(sitestring[1].trim().equalsIgnoreCase("undefined") || sitestring[1].trim().equalsIgnoreCase("NaN")|| sitestring[1].trim().equalsIgnoreCase("")|| sitestring[1].isEmpty()?0:sitestring[1].trim())+"',"
							+ "'"+(sitestring[2].trim().equalsIgnoreCase("undefined") || sitestring[2].trim().equalsIgnoreCase("NaN")||sitestring[2].trim().equalsIgnoreCase("")|| sitestring[2].isEmpty()?0:sitestring[2].trim())+"',"
							+ "'"+(sitestring[3].trim().equalsIgnoreCase("undefined") || sitestring[3].trim().equalsIgnoreCase("NaN")||sitestring[3].trim().equalsIgnoreCase("")|| sitestring[3].isEmpty()?0:sitestring[3].trim())+"',"
							+ "'"+(sitestring[4].trim().equalsIgnoreCase("undefined") || sitestring[4].trim().equalsIgnoreCase("NaN")||sitestring[4].trim().equalsIgnoreCase("")|| sitestring[4].isEmpty()?0:sitestring[4].trim())+"',"
							+ "'"+(sitestring[5].trim().equalsIgnoreCase("undefined") || sitestring[5].trim().equalsIgnoreCase("NaN")||sitestring[5].trim().equalsIgnoreCase("")|| sitestring[5].isEmpty()?0:sitestring[5].trim())+"',"
						    + "'"+(sitestring[6].trim().equalsIgnoreCase("undefined") || sitestring[6].trim().equalsIgnoreCase("NaN")||sitestring[6].trim().equalsIgnoreCase("")|| sitestring[6].isEmpty()?0:sitestring[6].trim())+"',"
							+ "'"+(sitestring[7].trim().equalsIgnoreCase("undefined") || sitestring[7].trim().equalsIgnoreCase("NaN")||sitestring[7].trim().equalsIgnoreCase("")|| sitestring[7].isEmpty()?0:sitestring[7].trim())+"',"
							+"'"+docno+"')";    
                    //System.out.println("sql--->>>"+sql);  
					int resultSetsite2 = smtContract.executeUpdate (sql);
					if(resultSetsite2<=0)
					{
						conn.close();
						return 0;
					}	

				}

			}
			int siteid=0,siterowno=0,val=0;       
			String sql1 = "", sitename = "";
			for(int i=0;i< enqarray.size();i++){         

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[0].trim().equalsIgnoreCase("undefined")|| enqiury[0].trim().equalsIgnoreCase("NaN")||enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()))
				{
					siteid=enqiury[14].trim().equalsIgnoreCase("undefined") || enqiury[14].trim().equalsIgnoreCase("NaN")|| enqiury[14].trim().equalsIgnoreCase("")|| enqiury[14].isEmpty()?0:Integer.parseInt(enqiury[14].trim());
					sql1="select rowno, site from  sk_srvcsited where tr_no="+docno+" and sr_no="+siteid+"";        
					//System.out.println("sql1==="+sql1);  
					ResultSet resultSet1 = stmt.executeQuery(sql1);
					while(resultSet1.next()){
						siterowno = resultSet1.getInt("rowno");
						sitename = resultSet1.getString("site");
					}  
					
					Double rate= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:Double.parseDouble(enqiury[10].trim());     
					Double tariff= enqiury[19].trim().equalsIgnoreCase("undefined") || enqiury[19].trim().equalsIgnoreCase("NaN")||enqiury[19].trim().equalsIgnoreCase("")|| enqiury[19].isEmpty()?0:Double.parseDouble(enqiury[19].trim()); 
					//System.out.println(rate+"==="+tariff);
					if(rate<tariff) {
						val=1;  
					}
					String ratepercollection= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?"":enqiury[10].trim(); 
					String tippingfee= enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?"":enqiury[11].trim(); 
					String skiprent= enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?"":enqiury[13].trim(); 
					String tippingsecurity= enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?"":enqiury[17].trim();
					String addrate= enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?"":enqiury[22].trim(); 
					//System.out.println(ratepercollection+"=="+tariff+"=="+tippingfee+"=="+skiprent+"=="+tippingsecurity+"=="+addrate);
					if(ratepercollection=="" || tippingfee=="" ||  skiprent=="" ||  tippingsecurity=="" || addrate=="" || ratepercollection=="0" || tippingfee=="0" ||  skiprent=="0" ||  tippingsecurity=="0" || addrate=="0") {   
						val=1;  
					}    
					
					String sql="INSERT INTO sk_srvcontrdet(siteid, srno, site, skiptype, nos, wastetype, ownershipid, servicebyid, servicetermid, scheduledays, specid, collectionid, rate, tippingfee, foc, rent, securityval, tippingmethod, tippingsecurity, restricted, tariffrate, gatefee, addrate, ctypeid, rdocno)VALUES"   
							+ " ('"+siterowno+"',"        
							+ ""+(i+1)+","
							+ "'"+sitename+"',"   
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
							+ "'"+(enqiury[15].trim().equalsIgnoreCase("undefined") || enqiury[15].trim().equalsIgnoreCase("NaN")||enqiury[15].trim().equalsIgnoreCase("")|| enqiury[15].isEmpty()?0:Round(Double.parseDouble(enqiury[15].trim()),0))+"',"
							+ "'"+(enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?0:enqiury[16].trim())+"',"
							+ "'"+(enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?0:Round(Double.parseDouble(enqiury[17].trim()),0))+"',"    
							+ "'"+(enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:enqiury[18].trim())+"',"
							+ "'"+(enqiury[19].trim().equalsIgnoreCase("undefined") || enqiury[19].trim().equalsIgnoreCase("NaN")||enqiury[19].trim().equalsIgnoreCase("")|| enqiury[19].isEmpty()?0:enqiury[19].trim())+"',"
							+ "'"+(enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?0:enqiury[21].trim())+"',"
							+ "'"+(enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?0:enqiury[22].trim())+"',"
							+ "'"+(enqiury[23].trim().equalsIgnoreCase("undefined") || enqiury[23].trim().equalsIgnoreCase("NaN")||enqiury[23].trim().equalsIgnoreCase("")|| enqiury[23].isEmpty()?0:enqiury[23].trim())+"',"
							+ "'"+docno+"')";                      
                    //System.out.println("sql==="+sql);  
					int resultSet2 = smtContract.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}	

				}

			}
			
			for(int i=0;i< thirdarray.size();i++){          
				String[] third=thirdarray.get(i).split("::");
				if(!(third[0].trim().equalsIgnoreCase("undefined")|| third[0].trim().equalsIgnoreCase("NaN")||third[0].trim().equalsIgnoreCase("")|| third[0].isEmpty()))
				{
					PreparedStatement prepare = conn.prepareStatement("INSERT INTO sk_srvcontrd(pono, date, amount, validupto, description, qty, rdocno) VALUES(?, ?, ?, ?, ?, ?, ?)");          
					prepare.setString(1, (third[0].trim().equalsIgnoreCase("undefined") || third[0].trim().equalsIgnoreCase("NaN")|| third[0].trim().equalsIgnoreCase("")|| third[0].isEmpty()?"":third[0].trim()));
					prepare.setDate(2, (third[1].trim().equalsIgnoreCase("undefined") || third[1].trim().equalsIgnoreCase("NaN")|| third[1].trim().equalsIgnoreCase("")|| third[1].isEmpty()?null:com.changeStringtoSqlDate(third[1].trim())));  
					prepare.setString(3, (third[2].trim().equalsIgnoreCase("undefined") || third[2].trim().equalsIgnoreCase("NaN")||third[2].trim().equalsIgnoreCase("")|| third[2].isEmpty()?"0":third[2].trim()));
					prepare.setDate(4, (third[3].trim().equalsIgnoreCase("undefined") || third[3].trim().equalsIgnoreCase("NaN")||third[3].trim().equalsIgnoreCase("")|| third[3].isEmpty()?null:com.changeStringtoSqlDate(third[3].trim())));
					prepare.setString(5, (third[4].trim().equalsIgnoreCase("undefined") || third[4].trim().equalsIgnoreCase("NaN")||third[4].trim().equalsIgnoreCase("")|| third[4].isEmpty()?"0":third[4].trim()));
					prepare.setString(6, (third[6].trim().equalsIgnoreCase("undefined") || third[6].trim().equalsIgnoreCase("NaN")||third[6].trim().equalsIgnoreCase("")|| third[6].isEmpty()?"0":third[6].trim()));
					prepare.setInt(7, docno);
					int resultSet2 = prepare.executeUpdate ();
					if(resultSet2<=0){   
						conn.close();
						return 0;
					} 	
				}
			} 
			
			for(int i=0;i< termsarray.size();i++){               
				String[] terms=termsarray.get(i).split("::");
				if(!(terms[0].trim().equalsIgnoreCase("undefined")|| terms[0].trim().equalsIgnoreCase("NaN")||terms[0].trim().equalsIgnoreCase("")|| terms[0].isEmpty()))
				{
					String sql="INSERT INTO sk_cterms(seqno, terms, conditions, rdocno)VALUES("          
							+ "'"+(i+1)+"'," 
							+ "'"+(terms[0].trim().equalsIgnoreCase("undefined") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].trim().equalsIgnoreCase("")|| terms[0].isEmpty()?"":terms[0].trim())+"',"      
							+ "'"+(terms[1].trim().equalsIgnoreCase("undefined") || terms[1].trim().equalsIgnoreCase("NaN")|| terms[1].trim().equalsIgnoreCase("")|| terms[1].isEmpty()?"":terms[1].trim())+"',"  
							+ "'"+docno+"')";                     
                    //System.out.println("sql--->>>"+sql);  
					int resultSet2 = smtContract.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}	
				}
			}
			if(docno > 0) {
				if(!cnttrno.equalsIgnoreCase("") && !cnttrno.equalsIgnoreCase("0") && !cnttrno.equalsIgnoreCase("undefined") && !cnttrno.equalsIgnoreCase("NaN")) {      
					String sqlup1="update sk_srvcontrm set oldcnttrno='"+cnttrno+"' where tr_no='"+docno+"'";
					//System.out.println("sqlup1==="+sqlup1);   
					int val1 = smtContract.executeUpdate (sqlup1);   
					if(val1<=0){     
						conn.close();
						return 0;
					}
					String sqlup2="update sk_srvcontrm set status=9 where tr_no='"+cnttrno+"'";      
					//System.out.println("sqlup2==="+sqlup2);   
					int val2 = smtContract.executeUpdate (sqlup2);       
					if(val2<=0){      
						conn.close();
						return 0;
					}
					
					String sqlins1="INSERT INTO sk_srvcontrdel(slno, rdocno, srno, skipid, gpsx, gpsy, deldate, deltime, driverid, helperid, schdate, schtime, routeid, fleetno,"
							+ " name, mobile, email, dayshift, location, helperid2, remarks, type, podate, poremarks) SELECT dl.slno, b.tr_no, dl.srno, dl.skipid, dl.gpsx, "
							+ "dl.gpsy, dl.deldate, dl.deltime, dl.driverid, dl.helperid, dl.schdate, dl.schtime, dl.routeid, dl.fleetno, dl.name, dl.mobile, dl.email, "
							+ "dl.dayshift, dl.location, dl.helperid2, dl.remarks, dl.type, dl.podate, dl.poremarks FROM(SELECT @i:=@i+1 slno,a.*,n4.num*1000+n3.num*100+n2.num*10+n1.num qty2 "
							+ "FROM(SELECT cm.tr_no, cd.nos qty, cd.srno, cm.oldcnttrno FROM sk_srvcontrm cm LEFT JOIN sk_srvcontrm om ON om.tr_no=cm.oldcnttrno LEFT JOIN sk_srvcontrdet cd ON cd.rdocno=cm.tr_no "
							+ "WHERE cm.tr_no='"+docno+"')a,(select @i:=0)c,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 "
							+ "UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 "
							+ "UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,"
						    + "(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 "
							+ "UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 "
							+ "UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4 WHERE 1=1 "
							+ "HAVING qty2<=qty AND qty2!=0)b INNER JOIN sk_srvcontrdel dl ON dl.rdocno=b.oldcnttrno AND dl.slno=b.slno AND dl.srno=b.srno order by dl.slno";
					//System.out.println("sqlins1==="+sqlins1);   
					int val3 = smtContract.executeUpdate (sqlins1);         
				}
			}
		/*
		 * COMMENTED AS REQUESTED BY CLIENT 
		 * 	if(val>0) {  
				String sql="update sk_srvcontrm set status=0 where tr_no='"+docno+"'";   
				int resultSetsite3 = smtContract.executeUpdate (sql);
				if(resultSetsite3<=0){  
					conn.close();
					return 0;
				}	
			}*/
			if (docno > 0) {
				conn.commit();
				smtContract.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}

	public boolean edit(int docno, String vocno, Date sqlStartDate, String enqdocno, String cldocno, String salid, String desc, ArrayList<String> enqarray,
			HttpSession session, String mode, String dtype, HttpServletRequest request, ArrayList<String> sitearray, String netamount, 
			Date startdate, Date enddate, String type, ArrayList<String> thirdarray, String billingmethod, String payterms, String reftype, 
			String cctype, String invmethod, String advinvvalue, ArrayList<String> termsarray, String refno, String chkmergedinv,
			String cpersonid, String mob, String tel, String email, String advtype, String inctipfee, String invstart,String cperson,String invoicemail,String intremarks,String extremarks,String manualinv) throws SQLException {    

		try{  
			conn=conobj.getMyConnection();
			Statement stmt =conn.createStatement();
			conn.setAutoCommit(false);  
			Double total=0.0;  
			if(netamount != null && netamount.length() > 0) {    
				total=Double.parseDouble(netamount);   
			}else {
				total=0.0;   
			}
			String mergedinvoice="No";
			if(chkmergedinv.equalsIgnoreCase("1")) {   
				mergedinvoice="Yes";
			}else {
				mergedinvoice="No";   
			}
			
			if(manualinv.trim().equalsIgnoreCase("") || manualinv==null) {
				manualinv="0";
			}
			String branchid = session.getAttribute("BRANCHID").toString();
			
            CallableStatement smtContract = conn.prepareCall("{call sk_serviceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");          
			
			smtContract.setDate(1,sqlStartDate);  
			smtContract.setString(2,enqdocno==null || enqdocno.equalsIgnoreCase("")?"0":enqdocno);   
			smtContract.setString(3,cldocno);
			smtContract.setString(4,salid);
			smtContract.setString(5,desc);  
			smtContract.setDouble(6,total);  
			smtContract.setString(7,dtype);
			smtContract.setString(8,session.getAttribute("USERID").toString());
			smtContract.setString(9,branchid);
			smtContract.setString(10,mode);
			smtContract.setDate(11,startdate);
			smtContract.setDate(12,enddate);
		    smtContract.setInt(13, docno);
			smtContract.setString(14, "0");
			smtContract.setString(15,type); 
			smtContract.setString(16,billingmethod==null || billingmethod.equalsIgnoreCase("")?"0":billingmethod);   
			smtContract.setString(17,payterms==null || payterms.equalsIgnoreCase("")?"0":payterms);     
			smtContract.setString(18,reftype);
			smtContract.setString(19,cctype==null || cctype.equalsIgnoreCase("")?"0":cctype);
			smtContract.setString(20,invmethod==null || invmethod.equalsIgnoreCase("")?"0":invmethod); 
			smtContract.setString(21,advinvvalue==null || advinvvalue.equalsIgnoreCase("")?"0":advinvvalue); 
			smtContract.setString(22,refno);  
			smtContract.setString(23,mergedinvoice);
			smtContract.setString(24,cpersonid==null || cpersonid.equalsIgnoreCase("")?"0":cpersonid); 
			smtContract.setString(25,mob);
			smtContract.setString(26,tel);
			smtContract.setString(27,email);  
			smtContract.setString(28,advtype==null || advtype.equalsIgnoreCase("")?"0":advtype);
			smtContract.setString(29,inctipfee==null || inctipfee.equalsIgnoreCase("")?"0":inctipfee);
			smtContract.setString(30,invstart==null || invstart.equalsIgnoreCase("")?"0":invstart);   
			smtContract.setString(31,cperson);
			smtContract.setString(32,invoicemail);
			smtContract.setString(33,intremarks); 
			smtContract.setString(34,extremarks);
			smtContract.setString(35,manualinv==null || manualinv.equalsIgnoreCase("")?"0":manualinv);
			int aaa=smtContract.executeUpdate();    
			docno=smtContract.getInt("docNo");  

			if(aaa<=0){
				return false;
			}

			//site grid
			String delsitesql="Delete from sk_srvcsited where tr_no="+docno+"";    
			smtContract.executeUpdate(delsitesql);
			for(int i=0;i< sitearray.size();i++){

						String[] sitestring=sitearray.get(i).split("::");
				
				if(!(sitestring[0].trim().equalsIgnoreCase("undefined")|| sitestring[0].trim().equalsIgnoreCase("NaN")||sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()))
				{
					String sql="INSERT INTO sk_srvcsited(sr_no, site, remarks, areaId, survid, route, gpsx, gpsy, description, tr_no)VALUES"    
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

					int resultSetsiteedit2 = smtContract.executeUpdate (sql); 
					if(resultSetsiteedit2<=0)
					{
						conn.close();
						return false;
					}	

				}

			} 
			
			//String delsql="Delete from sk_srvcontrdet where rdocno="+docno+""; 
			//smtContract.executeUpdate(delsql);  
			int siteid=0,siterowno=0,val=0;      
			String sql1="", sitename = "";
			for(int i=0;i< enqarray.size();i++){         

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[0].trim().equalsIgnoreCase("undefined")|| enqiury[0].trim().equalsIgnoreCase("NaN")||enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()))
				{
					siteid=enqiury[14].trim().equalsIgnoreCase("undefined") || enqiury[14].trim().equalsIgnoreCase("NaN")|| enqiury[14].trim().equalsIgnoreCase("")|| enqiury[14].isEmpty()?0:Integer.parseInt(enqiury[14].trim());
					sql1="select rowno, site from sk_srvcsited where tr_no="+docno+" and sr_no="+siteid+"";      
					//System.out.println("sql1==="+sql1);  
					ResultSet resultSet1 = stmt.executeQuery(sql1);  
					while(resultSet1.next()){
						siterowno=resultSet1.getInt("rowno");
						sitename = resultSet1.getString("site");   
					}
					
					Double rate= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:Double.parseDouble(enqiury[10].trim());     
					Double tariff= enqiury[19].trim().equalsIgnoreCase("undefined") || enqiury[19].trim().equalsIgnoreCase("NaN")||enqiury[19].trim().equalsIgnoreCase("")|| enqiury[19].isEmpty()?0:Double.parseDouble(enqiury[19].trim()); 
					//System.out.println(rate+"==="+tariff);
					if(rate<tariff) {
						val=1;  
					}
					String ratepercollection= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?"":enqiury[10].trim(); 
					String tippingfee= enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?"":enqiury[11].trim(); 
					String skiprent= enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?"":enqiury[13].trim(); 
					String tippingsecurity= enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?"":enqiury[17].trim();
					String addrate= enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?"":enqiury[22].trim(); 
					//System.out.println(ratepercollection+"=="+tariff+"=="+tippingfee+"=="+skiprent+"=="+tippingsecurity+"=="+addrate);
					if(ratepercollection=="" || tippingfee=="" ||  skiprent=="" ||  tippingsecurity=="" || addrate=="" || ratepercollection=="0" || tippingfee=="0" ||  skiprent=="0" ||  tippingsecurity=="0" || addrate=="0") {   
						val=1;   
					}
					
					int rowno=  (enqiury[20].trim().equalsIgnoreCase("undefined") || enqiury[20].trim().equalsIgnoreCase("NaN")||enqiury[20].trim().equalsIgnoreCase("")|| enqiury[20].isEmpty()?0:Integer.parseInt(enqiury[20].trim()));   
					if(rowno>0) { 
						String sql="update sk_srvcontrdet set siteid='"+siterowno+"',srno="+(i+1)+", site='"+sitename+"', "   
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
								+ " securityval='"+(enqiury[15].trim().equalsIgnoreCase("undefined") || enqiury[15].trim().equalsIgnoreCase("NaN")||enqiury[15].trim().equalsIgnoreCase("")|| enqiury[15].isEmpty()?0:Round(Double.parseDouble(enqiury[15].trim()),0))+"', "
								+ " tippingmethod='"+(enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?0:enqiury[16].trim())+"', "
								+ " tippingsecurity='"+(enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?0:Round(Double.parseDouble(enqiury[17].trim()),0))+"', "   
								+ " restricted='"+(enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:enqiury[18].trim())+"', "
								+ " tariffrate='"+(enqiury[19].trim().equalsIgnoreCase("undefined") || enqiury[19].trim().equalsIgnoreCase("NaN")||enqiury[19].trim().equalsIgnoreCase("")|| enqiury[19].isEmpty()?0:enqiury[19].trim())+"', "  
								+ " gatefee='"+(enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?0:enqiury[21].trim())+"', "
								+ " addrate='"+(enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?0:enqiury[22].trim())+"', "
								+ " ctypeid='"+(enqiury[23].trim().equalsIgnoreCase("undefined") || enqiury[23].trim().equalsIgnoreCase("NaN")||enqiury[23].trim().equalsIgnoreCase("")|| enqiury[23].isEmpty()?0:enqiury[23].trim())+"' "
								+ " where rowno='"+rowno+"'";             
						       //System.out.println("Up sql="+sql); 
							   int resultSet2 = smtContract.executeUpdate (sql);      
							   if(resultSet2<=0) {
								conn.close();
								return false;
							   }  
					}else {
						String sql="INSERT INTO sk_srvcontrdet(siteid, srno, site, skiptype, nos, wastetype, ownershipid, servicebyid, servicetermid, scheduledays, specid, collectionid, rate, tippingfee, foc, rent, securityval, tippingmethod, tippingsecurity, restricted, tariffrate, gatefee, addrate, ctypeid, rdocno)VALUES"   
								+ " ('"+siterowno+"',"        
								+ ""+(i+1)+","
								+ "'"+sitename+"',"  
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
								+ "'"+(enqiury[15].trim().equalsIgnoreCase("undefined") || enqiury[15].trim().equalsIgnoreCase("NaN")||enqiury[15].trim().equalsIgnoreCase("")|| enqiury[15].isEmpty()?0:Round(Double.parseDouble(enqiury[15].trim()),0))+"',"
								+ "'"+(enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?0:enqiury[16].trim())+"',"
								+ "'"+(enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?0:Round(Double.parseDouble(enqiury[17].trim()),0))+"',"    
								+ "'"+(enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:enqiury[18].trim())+"',"
								+ "'"+(enqiury[19].trim().equalsIgnoreCase("undefined") || enqiury[19].trim().equalsIgnoreCase("NaN")||enqiury[19].trim().equalsIgnoreCase("")|| enqiury[19].isEmpty()?0:enqiury[19].trim())+"',"
								+ "'"+(enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?0:enqiury[21].trim())+"',"
								+ "'"+(enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?0:enqiury[22].trim())+"',"
								+ "'"+(enqiury[23].trim().equalsIgnoreCase("undefined") || enqiury[23].trim().equalsIgnoreCase("NaN")||enqiury[23].trim().equalsIgnoreCase("")|| enqiury[23].isEmpty()?0:enqiury[23].trim())+"',"
								+ "'"+docno+"')";                
						 //System.out.println("sql==="+sql);       
						int resultSet2 = smtContract.executeUpdate (sql);    
						if(resultSet2<=0)
						{
							conn.close();
							return false;
						}
					}
				}
			}
			
			for(int i=0;i< thirdarray.size();i++){          
				String[] third=thirdarray.get(i).split("::");
				if(!(third[0].trim().equalsIgnoreCase("undefined")|| third[0].trim().equalsIgnoreCase("NaN")||third[0].trim().equalsIgnoreCase("")|| third[0].isEmpty()))
				{
					int rowno=third[5].trim().equalsIgnoreCase("undefined") || third[5].trim().equalsIgnoreCase("NaN")|| third[5].trim().equalsIgnoreCase("")|| third[5].isEmpty()?0:Integer.parseInt(third[5].trim());
					if(rowno>0){    
						PreparedStatement prepare = conn.prepareStatement("update sk_srvcontrd set pono=?, date=?, amount=?, validupto=?, description=?,qty=? where rowno=?");          
						prepare.setString(1, (third[0].trim().equalsIgnoreCase("undefined") || third[0].trim().equalsIgnoreCase("NaN")|| third[0].trim().equalsIgnoreCase("")|| third[0].isEmpty()?"":third[0].trim()));
						prepare.setDate(2, (third[1].trim().equalsIgnoreCase("undefined") || third[1].trim().equalsIgnoreCase("NaN")|| third[1].trim().equalsIgnoreCase("")|| third[1].isEmpty()?null:com.changeStringtoSqlDate(third[1].trim())));  
						prepare.setString(3, (third[2].trim().equalsIgnoreCase("undefined") || third[2].trim().equalsIgnoreCase("NaN")||third[2].trim().equalsIgnoreCase("")|| third[2].isEmpty()?"0":third[2].trim()));
						prepare.setDate(4, (third[3].trim().equalsIgnoreCase("undefined") || third[3].trim().equalsIgnoreCase("NaN")||third[3].trim().equalsIgnoreCase("")|| third[3].isEmpty()?null:com.changeStringtoSqlDate(third[3].trim())));
						prepare.setString(5, (third[4].trim().equalsIgnoreCase("undefined") || third[4].trim().equalsIgnoreCase("NaN")||third[4].trim().equalsIgnoreCase("")|| third[4].isEmpty()?"0":third[4].trim()));
						prepare.setString(6, (third[6].trim().equalsIgnoreCase("undefined") || third[6].trim().equalsIgnoreCase("NaN")||third[6].trim().equalsIgnoreCase("")|| third[6].isEmpty()?"0":third[6].trim()));
						prepare.setInt(7, rowno);
						int resultSet2 = prepare.executeUpdate ();
						if(resultSet2<=0){   
							conn.close();
							return false;
						} 
					}else {
						PreparedStatement prepare = conn.prepareStatement("INSERT INTO sk_srvcontrd(pono, date, amount, validupto, description, qty, rdocno) VALUES(?, ?, ?, ?, ?, ?, ?)");          
						prepare.setString(1, (third[0].trim().equalsIgnoreCase("undefined") || third[0].trim().equalsIgnoreCase("NaN")|| third[0].trim().equalsIgnoreCase("")|| third[0].isEmpty()?"":third[0].trim()));
						prepare.setDate(2, (third[1].trim().equalsIgnoreCase("undefined") || third[1].trim().equalsIgnoreCase("NaN")|| third[1].trim().equalsIgnoreCase("")|| third[1].isEmpty()?null:com.changeStringtoSqlDate(third[1].trim())));  
						prepare.setString(3, (third[2].trim().equalsIgnoreCase("undefined") || third[2].trim().equalsIgnoreCase("NaN")||third[2].trim().equalsIgnoreCase("")|| third[2].isEmpty()?"0":third[2].trim()));
						prepare.setDate(4, (third[3].trim().equalsIgnoreCase("undefined") || third[3].trim().equalsIgnoreCase("NaN")||third[3].trim().equalsIgnoreCase("")|| third[3].isEmpty()?null:com.changeStringtoSqlDate(third[3].trim())));
						prepare.setString(5, (third[4].trim().equalsIgnoreCase("undefined") || third[4].trim().equalsIgnoreCase("NaN")||third[4].trim().equalsIgnoreCase("")|| third[4].isEmpty()?"0":third[4].trim()));
						prepare.setString(6, (third[6].trim().equalsIgnoreCase("undefined") || third[6].trim().equalsIgnoreCase("NaN")||third[6].trim().equalsIgnoreCase("")|| third[6].isEmpty()?"0":third[6].trim()));
						prepare.setInt(7, docno);
						int resultSet2 = prepare.executeUpdate ();
						if(resultSet2<=0){   
							conn.close();
							return false;
						}       
				  }
				}
			}
			//System.out.println("termsarray--->>>"+termsarray);
			String deltermssql="Delete from sk_cterms where rdocno="+docno+"";      
			smtContract.executeUpdate(deltermssql);
			for(int i=0;i< termsarray.size();i++){               
				String[] terms=termsarray.get(i).split("::");
				if(!(terms[0].trim().equalsIgnoreCase("undefined")|| terms[0].trim().equalsIgnoreCase("NaN")||terms[0].trim().equalsIgnoreCase("")|| terms[0].isEmpty()))
				{
				 
						String sql="INSERT INTO sk_cterms(seqno, terms, conditions, rdocno) VALUES("          
								+ "'"+(i+1)+"'," 
								+ "'"+(terms[0].trim().equalsIgnoreCase("undefined") || terms[0].trim().equalsIgnoreCase("NaN")|| terms[0].trim().equalsIgnoreCase("")|| terms[0].isEmpty()?"":terms[0].trim())+"',"      
								+ "'"+(terms[1].trim().equalsIgnoreCase("undefined") || terms[1].trim().equalsIgnoreCase("NaN")|| terms[1].trim().equalsIgnoreCase("")|| terms[1].isEmpty()?"":terms[1].trim())+"',"  
								+ "'"+docno+"')";                     
	                    //System.out.println("sql--->>>"+sql);  
						int resultSet2 = smtContract.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return false;    
						}
					 
				}
			}
			/* COMMENTED AS REQUESTED BY CLIENT 
			 * if(val>0) {  
				String sql="update sk_srvcontrm set status=0 where tr_no='"+docno+"'";   
				int resultSetsite3 = smtContract.executeUpdate (sql);
				if(resultSetsite3<=0){  
					conn.close();
					return false;   
				}	
			}*/
			if (aaa > 0) {
				int aprcount = 0, apruserid = 0, detuserid = 0, countval = 0;     
				String sqlcnt = "select count(*) count from my_exdet where dtype='AMC' and doc_no='"+vocno+"' and brhid='"+branchid+"' and apprstatus in(1,3)";
				ResultSet rss = smtContract.executeQuery(sqlcnt);
				while(rss.next()) {
					aprcount = rss.getInt("count");
				}  
				if(aprcount>1) {  
					String sqlup = "update my_exdet set apprstatus=8 where dtype='AMC' and doc_no='"+vocno+"' and brhid='"+branchid+"' and apprstatus not in(8,9)";
				    smtContract.executeUpdate(sqlup);    
				}
				
				String sqlcnt2 = "select b.userid apruser from(select count(*) as count, max(apprlevel) apprlevel, dtype, brhid from my_exdoc where dtype='AMC' and brhid='"+branchid+"')a left join my_exdoc b on b.dtype=a.dtype and b.brhid=a.brhid and b.apprlevel=a.apprlevel";
				ResultSet rss2 = stmt.executeQuery(sqlcnt2);    
				while(rss2.next()) {
					apruserid = rss2.getInt("apruser");  
				}  
				String sqlcnt3 = "select d.sr_no countchk from sk_srvcontrm m left join my_exdet d on d.dtype=m.dtype and m.doc_no=d.doc_no and m.brhid=d.brhid where m.tr_no='"+docno+"' and d.apprstatus not in(8,9) and d.userid='"+apruserid+"'";
				ResultSet rss3 = stmt.executeQuery(sqlcnt3);  
				while(rss3.next()) {
					countval = rss3.getInt("countchk");          
				}
				if(aprcount>1) {  
					String sqlup = "update my_exdet set apprstatus=8 where dtype='AMC' and doc_no='"+vocno+"' and brhid='"+branchid+"' and apprstatus not in(8,9)";
					stmt.executeUpdate(sqlup);
				}else if(countval>0) {
					String sqlup = "update my_exdet set apprstatus=8 where dtype='AMC' and doc_no='"+vocno+"' and brhid='"+branchid+"' and apprstatus not in(8,9)";
					stmt.executeUpdate(sqlup);     
				}else {}  
				
				conn.commit();
				smtContract.close();
				conn.close();
				//System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno,Date sqlStartDate,String mode,Date sqlStDate,Date sqlEdDate, String dtype, HttpSession session) throws SQLException {   	   

		try{
			  conn=conobj.getMyConnection();
			  conn.setAutoCommit(false);  
			
			  CallableStatement smtContract = conn.prepareCall("{call sk_serviceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");     
				
			  smtContract.setDate(1,sqlStartDate);
			  smtContract.setString(2,"0");
			  smtContract.setString(3,"0");
			  smtContract.setString(4,"0");
			  smtContract.setString(5,"0");
			  smtContract.setDouble(6,0.00);    
			  smtContract.setString(7,dtype);
			  smtContract.setString(8,session.getAttribute("USERID").toString());
			  smtContract.setString(9,session.getAttribute("BRANCHID").toString());
			  smtContract.setString(10,mode);
			  smtContract.setDate(11,sqlStDate);     
			  smtContract.setDate(12,sqlEdDate);
		      smtContract.setInt(13, docno);
			  smtContract.setString(14, "0");  
			  smtContract.setString(15,"0"); 
			  smtContract.setString(16,"0");
			  smtContract.setString(17,"0");
			  smtContract.setString(18,""); 
			  smtContract.setString(19,"0");
			  smtContract.setString(20,"0");
			  smtContract.setString(21,"0"); 
			  smtContract.setString(22,""); 
			  smtContract.setString(23,""); 
			  smtContract.setString(24,"0"); 
			  smtContract.setString(25,"");
			  smtContract.setString(26,"");
			  smtContract.setString(27,"");  
			  smtContract.setString(28,"0");
			  smtContract.setString(29,"0");
			  smtContract.setString(30,"0");  
			  smtContract.setString(31,"");  
			  smtContract.setString(32,"");  
			  smtContract.setString(33,""); 
			  smtContract.setString(34,""); 
			  smtContract.setString(35,"0");   
			  int aaa=smtContract.executeUpdate();  
			  docno=smtContract.getInt("docNo");

			if(aaa<=0){
				return false;
			}

			if (aaa > 0) {
				conn.commit();
				smtContract.close();
				conn.close();
				//System.out.println("Sucess");  
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}

	public boolean revise(int docno, String vocno, String desc, String intremarks, String extremarks, HttpSession session,HttpServletRequest request,ArrayList<String> sitearray,ArrayList<String> enqarray, Date witheffectdt, Date sqlStDate, Date sqlEdDate, String billingmethod, String payterms, String invmethod, String advinvvalue, String advtype, String inctipfee, String cmbtype,ArrayList<String> thirdarray) throws SQLException {
		try{  
			conn=conobj.getMyConnection();    
			conn.setAutoCommit(false);      
            Statement stmt=conn.createStatement();    
            int revisionno=0,aaa=0;
            String cntdocno="0",cntbrhid="0";
            String sqls="select coalesce(revision_no+1,1) revision,doc_no,brhid from sk_srvcontrm where tr_no='"+docno+"'";     
			ResultSet rs = stmt.executeQuery(sqls);
            while(rs.next()) {
            	revisionno=rs.getInt("revision");  
            	cntdocno=rs.getString("doc_no");
            	cntbrhid=rs.getString("brhid");      
            }
            String upsql="update sk_srvcontrm set revision_no="+revisionno+",witheffect='"+witheffectdt+"',remarks='"+desc+"',intremarks='"+intremarks+"',extremarks='"+extremarks+"', startdt='"+sqlStDate+"', enddt='"+sqlEdDate+"', billingmethod='"+billingmethod+"', payterms='"+payterms+"', advinvmethod='"+invmethod+"', advinvvalue='"+advinvvalue+"', advtype='"+advtype+"', inctipfee='"+inctipfee+"', typeid='"+cmbtype+"' where tr_no='"+docno+"'"; 
            //System.out.println("upsql==="+upsql);   
            aaa = stmt.executeUpdate (upsql); 
			if(aaa<=0){  
				conn.close();
				return false;     
			}  
			request.setAttribute("revisionno", revisionno);    
			int val=0;
			int siteid=0;      
			String sql1="";
			
			for(int i=0;i< thirdarray.size();i++){          
				String[] third=thirdarray.get(i).split("::");
				if(!(third[0].trim().equalsIgnoreCase("undefined")|| third[0].trim().equalsIgnoreCase("NaN")||third[0].trim().equalsIgnoreCase("")|| third[0].isEmpty()))
				{
					/*String sql="INSERT INTO sk_srvcontrd(pono, date, amount, validupto, description, qty, attach, path, rdocno, revision_no)VALUES("
							+ "'"+(third[0].trim().equalsIgnoreCase("undefined") || third[0].trim().equalsIgnoreCase("NaN")|| third[0].trim().equalsIgnoreCase("")|| third[0].isEmpty()?0:third[0].trim())+"',"
							+ "'"+(third[1].trim().equalsIgnoreCase("undefined") || third[1].trim().equalsIgnoreCase("NaN")|| third[1].trim().equalsIgnoreCase("")|| third[1].isEmpty()?null:com.changeStringtoSqlDate(third[1].trim()))+"',"  
							+ "'"+(third[2].trim().equalsIgnoreCase("undefined") || third[2].trim().equalsIgnoreCase("NaN")||third[2].trim().equalsIgnoreCase("")|| third[2].isEmpty()?0:third[2].trim())+"',"
							+ "'"+(third[3].trim().equalsIgnoreCase("undefined") || third[3].trim().equalsIgnoreCase("NaN")||third[3].trim().equalsIgnoreCase("")|| third[3].isEmpty()?null:com.changeStringtoSqlDate(third[3].trim()))+"',"  
							+ "'"+(third[4].trim().equalsIgnoreCase("undefined") || third[4].trim().equalsIgnoreCase("NaN")||third[4].trim().equalsIgnoreCase("")|| third[4].isEmpty()?"":third[4].trim())+"',"
							+ "'"+(third[6].trim().equalsIgnoreCase("undefined") || third[6].trim().equalsIgnoreCase("NaN")||third[6].trim().equalsIgnoreCase("")|| third[6].isEmpty()?0:third[6].trim())+"',"
							+ "'"+(third[7].trim().equalsIgnoreCase("undefined") || third[7].trim().equalsIgnoreCase("NaN")||third[7].trim().equalsIgnoreCase("")|| third[7].isEmpty()?"":third[7].trim())+"',"
							+ "'"+(third[8].trim().equalsIgnoreCase("undefined") || third[8].trim().equalsIgnoreCase("NaN")||third[8].trim().equalsIgnoreCase("")|| third[8].isEmpty()?"":third[8].trim())+"',"
							+"'"+docno+"','"+revisionno+"')";    */           
					
					PreparedStatement prepare = conn.prepareStatement("INSERT INTO sk_srvcontrd(pono, date, amount, validupto, description, qty, attach, path, rdocno, revision_no) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");      
					prepare.setString(1, (third[0].trim().equalsIgnoreCase("undefined") || third[0].trim().equalsIgnoreCase("NaN")|| third[0].trim().equalsIgnoreCase("")|| third[0].isEmpty()?"":third[0].trim()));
					prepare.setDate(2, (third[1].trim().equalsIgnoreCase("undefined") || third[1].trim().equalsIgnoreCase("NaN")|| third[1].trim().equalsIgnoreCase("")|| third[1].isEmpty()?null:com.changeStringtoSqlDate(third[1].trim())));  
					prepare.setString(3, (third[2].trim().equalsIgnoreCase("undefined") || third[2].trim().equalsIgnoreCase("NaN")||third[2].trim().equalsIgnoreCase("")|| third[2].isEmpty()?"":third[2].trim()));
					prepare.setDate(4, (third[3].trim().equalsIgnoreCase("undefined") || third[3].trim().equalsIgnoreCase("NaN")||third[3].trim().equalsIgnoreCase("")|| third[3].isEmpty()?null:com.changeStringtoSqlDate(third[3].trim())));
					prepare.setString(5, (third[4].trim().equalsIgnoreCase("undefined") || third[4].trim().equalsIgnoreCase("NaN")||third[4].trim().equalsIgnoreCase("")|| third[4].isEmpty()?"":third[4].trim()));
					prepare.setString(6, (third[6].trim().equalsIgnoreCase("undefined") || third[6].trim().equalsIgnoreCase("NaN")||third[6].trim().equalsIgnoreCase("")|| third[6].isEmpty()?"0":third[6].trim()));
					prepare.setString(7, (third[7].trim().equalsIgnoreCase("undefined") || third[7].trim().equalsIgnoreCase("NaN")||third[7].trim().equalsIgnoreCase("")|| third[7].isEmpty()?"":third[7].trim()));
					prepare.setString(8, (third[8].trim().equalsIgnoreCase("undefined") || third[8].trim().equalsIgnoreCase("NaN")||third[8].trim().equalsIgnoreCase("")|| third[8].isEmpty()?"":third[8].trim()));
					prepare.setInt(9, docno);
					prepare.setInt(10,revisionno);  
					int resultSet2 = prepare.executeUpdate ();
					if(resultSet2<=0){
						conn.close();
						return false;
					}
				}
			}    
			
			String insertsql1="insert into sk_srvcsitedr(sr_no, tr_no, site, areaId, remarks, survid, route, gpsx, gpsy, description, revision_no) select sr_no, tr_no, site, areaId, remarks, survid, route, gpsx, gpsy, description, revision_no from sk_srvcsited where tr_no='"+docno+"'"; 
			//System.out.println("insertsql1="+insertsql1);  
			aaa = stmt.executeUpdate (insertsql1);    
			if(aaa<=0){  
					conn.close();
					return false;     
			}  
			
			String deletesql3="delete from sk_srvcsited where tr_no='"+docno+"'";  
			//System.out.println("deletesql3="+deletesql3);   
            aaa = stmt.executeUpdate (deletesql3);    
			if(aaa<=0){  
				conn.close();
				return false;     
			}
			
			for(int i=0;i< sitearray.size();i++){  

				String[] sitestring=sitearray.get(i).split("::");
				
				if(!(sitestring[0].trim().equalsIgnoreCase("undefined")|| sitestring[0].trim().equalsIgnoreCase("NaN")||sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()))
				{
					int refrowno=0;  
					sql1="select coalesce(max(rowno)+1,1) as refrowno from sk_srvcsited ";  
					//System.out.println("==sql1=cm_srvcsited==="+sql1);
					ResultSet resultSet1 = stmt.executeQuery(sql1);
					while(resultSet1.next()){
						refrowno=resultSet1.getInt("refrowno");
					}
					String sql="INSERT INTO sk_srvcsited(revision_no, rowno, sr_no, site, remarks, areaId, survid, route, gpsx, gpsy, description, tr_no) VALUES("        
							+ " '"+revisionno+"',"+refrowno+","  
							+ " "+(i+1)+","
							+ "'"+(sitestring[0].trim().equalsIgnoreCase("undefined") || sitestring[0].trim().equalsIgnoreCase("NaN")|| sitestring[0].trim().equalsIgnoreCase("")|| sitestring[0].isEmpty()?0:sitestring[0].trim())+"',"
							+ "'"+(sitestring[1].trim().equalsIgnoreCase("undefined") || sitestring[1].trim().equalsIgnoreCase("NaN")|| sitestring[1].trim().equalsIgnoreCase("")|| sitestring[1].isEmpty()?0:sitestring[1].trim())+"',"
							+ "'"+(sitestring[2].trim().equalsIgnoreCase("undefined") || sitestring[2].trim().equalsIgnoreCase("NaN")||sitestring[2].trim().equalsIgnoreCase("")|| sitestring[2].isEmpty()?0:sitestring[2].trim())+"',"
							+ "'"+(sitestring[3].trim().equalsIgnoreCase("undefined") || sitestring[3].trim().equalsIgnoreCase("NaN")||sitestring[3].trim().equalsIgnoreCase("")|| sitestring[3].isEmpty()?0:sitestring[3].trim())+"',"
							+ "'"+(sitestring[4].trim().equalsIgnoreCase("undefined") || sitestring[4].trim().equalsIgnoreCase("NaN")||sitestring[4].trim().equalsIgnoreCase("")|| sitestring[4].isEmpty()?0:sitestring[4].trim())+"',"
							+ "'"+(sitestring[5].trim().equalsIgnoreCase("undefined") || sitestring[5].trim().equalsIgnoreCase("NaN")||sitestring[5].trim().equalsIgnoreCase("")|| sitestring[5].isEmpty()?0:sitestring[5].trim())+"',"
						    + "'"+(sitestring[6].trim().equalsIgnoreCase("undefined") || sitestring[6].trim().equalsIgnoreCase("NaN")||sitestring[6].trim().equalsIgnoreCase("")|| sitestring[6].isEmpty()?0:sitestring[6].trim())+"',"
							+ "'"+(sitestring[7].trim().equalsIgnoreCase("undefined") || sitestring[7].trim().equalsIgnoreCase("NaN")||sitestring[7].trim().equalsIgnoreCase("")|| sitestring[7].isEmpty()?0:sitestring[7].trim())+"',"
							+"'"+docno+"')";    
                    //System.out.println("sql--->>>"+sql);  
					int resultSetsite2 = stmt.executeUpdate (sql);
					if(resultSetsite2<=0)
					{
						conn.close();
						return false;
					}	
				}
			} 

			String insertsql="insert into sk_srvcontrdetr(rdocno, srno, site, skiptype, nos, wastetype, ownershipid, servicebyid, servicetermid, scheduledays, specid, siteid, collectionid, rate, tippingfee, rent, foc, skipid, gpsx, gpsy, deldate, deltime, statusid, balqty, securityval, tippingmethod, tippingsecurity, restricted, tariffrate, gatefee, invdate, addrate, ctypeid, revision_no) select rdocno, srno, site, skiptype, nos, wastetype, ownershipid, servicebyid, servicetermid, scheduledays, specid, siteid, collectionid, rate, tippingfee, rent, foc, skipid, gpsx, gpsy, deldate, deltime, statusid, balqty, securityval, tippingmethod, tippingsecurity, restricted, tariffrate, gatefee, invdate, addrate, ctypeid, revision_no from sk_srvcontrdet where rdocno='"+docno+"'";      
			//System.out.println("insertsql="+insertsql); 
			aaa = stmt.executeUpdate (insertsql);    
			if(aaa<=0){  
					conn.close();
					return false;     
			}  
			
			String deletesql2="delete from sk_srvcontrdet where rdocno='"+docno+"'";  
			//System.out.println("deletesql2="+deletesql2); 
            aaa = stmt.executeUpdate (deletesql2);  
			if(aaa<=0){  
				conn.close();
				return false;     
			}
			int siterowno=0,val1=0; 
			String sitename = "";  
			for(int i=0;i< enqarray.size();i++){         

				String[] enqiury=enqarray.get(i).split("::");
				if(!(enqiury[0].trim().equalsIgnoreCase("undefined")|| enqiury[0].trim().equalsIgnoreCase("NaN")||enqiury[0].trim().equalsIgnoreCase("")|| enqiury[0].isEmpty()))
				{
					siteid=enqiury[14].trim().equalsIgnoreCase("undefined") || enqiury[14].trim().equalsIgnoreCase("NaN")|| enqiury[14].trim().equalsIgnoreCase("")|| enqiury[14].isEmpty()?0:Integer.parseInt(enqiury[14].trim());
					sql1="select rowno, site from  sk_srvcsited where tr_no="+docno+" and sr_no="+siteid+"";        
					//System.out.println("sql1==="+sql1);  
					ResultSet resultSet1 = stmt.executeQuery(sql1);  
					while(resultSet1.next()){
						siterowno=resultSet1.getInt("rowno");
						sitename = resultSet1.getString("site");  
					}  
					
					Double rate= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?0:Double.parseDouble(enqiury[10].trim());     
					Double tariff= enqiury[19].trim().equalsIgnoreCase("undefined") || enqiury[19].trim().equalsIgnoreCase("NaN")||enqiury[19].trim().equalsIgnoreCase("")|| enqiury[19].isEmpty()?0:Double.parseDouble(enqiury[19].trim()); 
					//System.out.println(rate+"==="+tariff);
					if(rate<tariff) {
						val1=1;  
					}
					String ratepercollection= enqiury[10].trim().equalsIgnoreCase("undefined") || enqiury[10].trim().equalsIgnoreCase("NaN")||enqiury[10].trim().equalsIgnoreCase("")|| enqiury[10].isEmpty()?"":enqiury[10].trim(); 
					String tippingfee= enqiury[11].trim().equalsIgnoreCase("undefined") || enqiury[11].trim().equalsIgnoreCase("NaN")||enqiury[11].trim().equalsIgnoreCase("")|| enqiury[11].isEmpty()?"":enqiury[11].trim(); 
					String skiprent= enqiury[13].trim().equalsIgnoreCase("undefined") || enqiury[13].trim().equalsIgnoreCase("NaN")||enqiury[13].trim().equalsIgnoreCase("")|| enqiury[13].isEmpty()?"":enqiury[13].trim(); 
					String tippingsecurity= enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?"":enqiury[17].trim();
					String addrate= enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?"":enqiury[22].trim(); 
					//System.out.println(ratepercollection+"=="+tariff+"=="+tippingfee+"=="+skiprent+"=="+tippingsecurity+"=="+addrate);
					if(ratepercollection=="" || tippingfee=="" ||  skiprent=="" ||  tippingsecurity=="" || addrate=="" || ratepercollection=="0" || tippingfee=="0" ||  skiprent=="0" ||  tippingsecurity=="0" || addrate=="0") {   
						val1=1;  
					} 
					
					String sql="INSERT INTO sk_srvcontrdet(revision_no, siteid, srno, site, skiptype, nos, wastetype, ownershipid, servicebyid, servicetermid, scheduledays, specid, collectionid, rate, tippingfee, foc, rent, securityval, tippingmethod, tippingsecurity, restricted, tariffrate, gatefee, addrate, ctypeid, rdocno)VALUES"   
							+ " ('"+revisionno+"','"+siterowno+"',"          
							+ ""+(i+1)+","
							+ "'"+sitename+"',"
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
							+ "'"+(enqiury[15].trim().equalsIgnoreCase("undefined") || enqiury[15].trim().equalsIgnoreCase("NaN")||enqiury[15].trim().equalsIgnoreCase("")|| enqiury[15].isEmpty()?0:Round(Double.parseDouble(enqiury[15].trim()),0))+"',"
							+ "'"+(enqiury[16].trim().equalsIgnoreCase("undefined") || enqiury[16].trim().equalsIgnoreCase("NaN")||enqiury[16].trim().equalsIgnoreCase("")|| enqiury[16].isEmpty()?0:enqiury[16].trim())+"',"
							+ "'"+(enqiury[17].trim().equalsIgnoreCase("undefined") || enqiury[17].trim().equalsIgnoreCase("NaN")||enqiury[17].trim().equalsIgnoreCase("")|| enqiury[17].isEmpty()?0:Round(Double.parseDouble(enqiury[17].trim()),0))+"',"    
							+ "'"+(enqiury[18].trim().equalsIgnoreCase("undefined") || enqiury[18].trim().equalsIgnoreCase("NaN")||enqiury[18].trim().equalsIgnoreCase("")|| enqiury[18].isEmpty()?0:enqiury[18].trim())+"',"
							+ "'"+(enqiury[19].trim().equalsIgnoreCase("undefined") || enqiury[19].trim().equalsIgnoreCase("NaN")||enqiury[19].trim().equalsIgnoreCase("")|| enqiury[19].isEmpty()?0:enqiury[19].trim())+"',"
							+ "'"+(enqiury[21].trim().equalsIgnoreCase("undefined") || enqiury[21].trim().equalsIgnoreCase("NaN")||enqiury[21].trim().equalsIgnoreCase("")|| enqiury[21].isEmpty()?0:enqiury[21].trim())+"',"
							+ "'"+(enqiury[22].trim().equalsIgnoreCase("undefined") || enqiury[22].trim().equalsIgnoreCase("NaN")||enqiury[22].trim().equalsIgnoreCase("")|| enqiury[22].isEmpty()?0:enqiury[22].trim())+"',"
							+ "'"+(enqiury[23].trim().equalsIgnoreCase("undefined") || enqiury[23].trim().equalsIgnoreCase("NaN")||enqiury[23].trim().equalsIgnoreCase("")|| enqiury[23].isEmpty()?0:enqiury[23].trim())+"',"
							+ "'"+docno+"')";                      
                    //System.out.println("sql==="+sql);  
					int resultSet2 = stmt.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return false;
					}	

				}

			}
			String upsql3="update sk_srvcontrdetr r left join sk_srvcsitedr s on (s.tr_no=r.rdocno and s.site=r.site and r.revision_no=s.revision_no) set r.siteid=s.rowno where s.tr_no='"+docno+"' and r.rdocno='"+docno+"'";      
			//System.out.println("upsql3==="+upsql3);  
			aaa = stmt.executeUpdate (upsql3);
			if(aaa<=0){  
				conn.close();
				return false;     
			}
			String upsql4="update sk_srvcontrdet d left join (select max(revision_no) revno,rdocno,srno from sk_srvcontrdetr group by rdocno,srno) rv on d.rdocno=rv.rdocno and d.srno=rv.srno left join sk_srvcontrdetr r on d.rdocno=r.rdocno and d.srno=r.srno and r.revision_no=rv.revno set d.skipid=r.skipid, d.gpsx=r.gpsx, d.gpsy=r.gpsy, d.deldate=r.deldate, d.deltime=r.deltime, d.statusid=r.statusid, d.balqty=r.balqty, d.invdate=r.invdate where d.rdocno='"+docno+"'";
			//System.out.println("upsql4==="+upsql4);      
			int val4 = stmt.executeUpdate (upsql4);   
			
			/*COMMENTED AS REQUESTED BY CLIENT 
			 * 
			 * if(val1>0) {  
				String sql="update sk_srvcontrm set status=0 where tr_no='"+docno+"'";   
				int resultSetsite3 = stmt.executeUpdate (sql);   
				if(resultSetsite3<=0){  
					conn.close();
					return false;   
				}	
			}*/
			if (aaa > 0) {
				int icount = 0, iapprovalStatus = 3;
				String sqlstr1="select count(*) icount from my_apprmaster where status=3 and dtype='AMC'";        
				ResultSet rs1 = stmt.executeQuery(sqlstr1);  
				while(rs1.next()){
						icount = rs1.getInt("icount");
				} 
				if(icount>0){
					iapprovalStatus = 0;
			    }     
				String upsql1="update sk_srvcontrm set status="+iapprovalStatus+" where tr_no='"+docno+"'";
				stmt.executeUpdate (upsql1);     
				
				int aprcount = 0, apruserid = 0, detuserid = 0, countval = 0;  
				String sqlcnt = "select count(*) count from my_exdet where dtype='AMC' and doc_no='"+vocno+"' and brhid='"+cntbrhid+"' and apprstatus in(1,3)";
				ResultSet rss = stmt.executeQuery(sqlcnt);
				while(rss.next()) {
					aprcount = rss.getInt("count");
				}  
				String sqlcnt2 = "select b.userid apruser from(select count(*) as count, max(apprlevel) apprlevel, dtype, brhid from my_exdoc where dtype='AMC' and brhid='"+cntbrhid+"')a left join my_exdoc b on b.dtype=a.dtype and b.brhid=a.brhid and b.apprlevel=a.apprlevel";
				ResultSet rss2 = stmt.executeQuery(sqlcnt2);    
				while(rss2.next()) {
					apruserid = rss2.getInt("apruser");  
				}  
				String sqlcnt3 = "select d.sr_no countchk from sk_srvcontrm m left join my_exdet d on d.dtype=m.dtype and m.doc_no=d.doc_no and m.brhid=d.brhid where m.tr_no='"+docno+"' and d.apprstatus not in(8,9) and d.userid='"+apruserid+"'";
				ResultSet rss3 = stmt.executeQuery(sqlcnt3);  
				while(rss3.next()) {
					countval = rss3.getInt("countchk");       
				}
				if(aprcount>1) {  
					String sqlup = "update my_exdet set apprstatus=8 where dtype='AMC' and doc_no='"+vocno+"' and brhid='"+cntbrhid+"' and apprstatus not in(8,9)";
					stmt.executeUpdate(sqlup);
				}else if(countval>0) {
					String sqlup = "update my_exdet set apprstatus=8 where dtype='AMC' and doc_no='"+vocno+"' and brhid='"+cntbrhid+"' and apprstatus not in(8,9)";
					stmt.executeUpdate(sqlup);     
				}else {}
			    
				String sql="update sk_srvcontrsch set statusid=2 where rdocno='"+docno+"'";
				//System.out.println("sql==="+sql);  
				stmt.executeUpdate (sql);  
				
				String sql2="update sk_srvcontrrenew set revision_no='"+revisionno+"',witheffect='"+witheffectdt+"' where cnttrno='"+docno+"' and status=1 and revision_no=0";
				//System.out.println("sql2==="+sql2);            
				stmt.executeUpdate (sql2);    
				
				String inssql="insert into datalog (doc_no, brhId, dtype, activity, edate, userId, ENTRY) values ('"+cntdocno+"', '"+cntbrhid+"', 'AMC', '"+revisionno+"', now(), '"+session.getAttribute("USERID").toString()+"', 'R')"; 
				//System.out.println("inssql==="+inssql);  
				stmt.executeUpdate (inssql);     
			}
			if (aaa > 0) {
				conn.commit();
				stmt.close();
				conn.close();
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
	public JSONArray searchClient(HttpSession session,String clnames,String docno,int id) throws SQLException {    
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
			 String clsql= "select cp.cperson,cp.row_no cpersonid,coalesce(a1.name,'') groupcompanies,ac.address com_add1, ac.per_mob mob, ac.per_tel telno, ac.mail1 email,ac.refname,sm.sal_name,ac.sal_id,ac.cldocno from my_acbook ac left join my_salm sm on sm.doc_no=ac.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno) left join my_crmcontact cp on cp.cldocno=ac.cldocno where ac.dtype='crm' and ac.status<>7 "+sqltest+" order by ac.refname";
			 //System.out.println("====Client Search===="+clsql);                          
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
				 String clsql= "select q.revision_no qotrevno, q.cpersonid, q.mob, q.tel telno, q.email, q.cperson, coalesce(a1.name,'') groupcompanies,q.tr_no qottrno,ac.address com_add1,m.remarks,m.voc_no,m.doc_no,ac.refname,sm.sal_name,m.sal_id,m.cldocno,q.billingmethod,q.payterms from gl_enqm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join my_salm sm on sm.doc_no=m.sal_id left join sk_srvqotm q on q.refdocno=m.doc_no and q.refdtype='ENQ' left join sk_clgroup a1 on (ac.grpcmp=a1.docno or m.grpcmpid=a1.docno) left join sk_srvcontrm cm on cm.refdocno=m.doc_no and cm.refdtype='ENQ' left join my_crmcontact cp on cp.row_no=q.cpersonid where m.status<>7 and q.tr_no is not null and coalesce(q.quotstatus,0)!=1 and coalesce(m.cldocno,0)>0 and cm.tr_no is null "+sqltest+" order by m.doc_no";
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

	  public JSONArray searchMaster(HttpSession session,String msdocno,String msenqno,String clnames,String enqdate,String remarks,String id) throws SQLException {
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
				sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
			}
			if(!(remarks.equalsIgnoreCase(""))){
				sqltest=sqltest+" and m.remarks like '%"+remarks+"%'";  
			}
			if(sqlStartDate!=null) {
				sqltest=sqltest+" and m.date='"+sqlStartDate+"'";   
			}
			Connection conn = null;

			try {
				 conn = conobj.getMyConnection();
				 Statement stmtenq1 = conn.createStatement ();
				 String sql1="select m.doc_no from my_salm m where m.status=3 and salesuserlink='"+session.getAttribute("USERID")+"'";
				 //System.out.println("--------salesuserlink----------"+sql1);
				 ResultSet resultSet1 = stmtenq1.executeQuery(sql1) ;   
				 if(resultSet1.next()){
					 sqltest +=" and m.sal_id='"+resultSet1.getString("doc_no")+"'";   
				 }    
				 String clsql= "select a.* from(select m.cctype,m.manualinv,m.extremarks,m.intremarks,date_format(m.witheffect,'%d.%m.%Y') witheffect,m.cpemail, m.advtype, m.inctipfee, m.invstart, m.cperson,m.cpersonid,if(m.mergedinvoice='Yes',1,0) mergedinvoice,m.refno,d.revision_no,m.advinvvalue,m.advinvmethod,m.refdtype,m.payterms,m.billingmethod,coalesce(a1.name,'') groupcompanies,date_format(m.date,'%d.%m.%Y') date,date_format(m.startdt,'%d.%m.%Y') startdt,date_format(m.enddt,'%d.%m.%Y') enddt,ac.address com_add1, m.mob, m.tel telno, m.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,ac.refname,sm.sal_name,m.sal_id,m.cldocno,m.typeid from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) left join my_crmcontact cp on cp.row_no=m.cpersonid where m.status<>7"+sqltest+" group by d.rdocno,d.revision_no union all select m.cctype,m.manualinv,m.extremarks,m.intremarks,date_format(m.witheffect,'%d.%m.%Y') witheffect,m.cpemail, m.advtype, m.inctipfee, m.invstart, m.cperson,m.cpersonid,if(m.mergedinvoice='Yes',1,0) mergedinvoice,m.refno,d.revision_no,m.advinvvalue,m.advinvmethod,m.refdtype,m.payterms,m.billingmethod,coalesce(a1.name,'') groupcompanies,date_format(m.date,'%d.%m.%Y') date,date_format(m.startdt,'%d.%m.%Y') startdt,date_format(m.enddt,'%d.%m.%Y') enddt,ac.address com_add1, m.mob, m.tel telno, m.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,ac.refname,sm.sal_name,m.sal_id,m.cldocno,m.typeid from sk_srvcontrm m inner join sk_srvcontrdetr d on d.rdocno=m.tr_no left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) left join my_crmcontact cp on cp.row_no=m.cpersonid where m.status<>7"+sqltest+" group by d.rdocno,d.revision_no)a order by a.tr_no,a.revision_no";
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
				sql="select a.tr_no rdocno,eq.sr_no,eq.rowno,(SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
						+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.survid) order by doc_no) surtype,eq.site,aa.area,eq.remarks, eq.areaid, "
						+ "eq.survid surid, eq.route, eq.gpsx, eq.gpsy, eq.description  from sk_servsited eq  left  join (select eq.tr_no,eq.survid,eq.sr_no   "
						+ "from sk_servsited eq where eq.tr_no='"+docno+"' and eq.revision_no='"+revisionno+"') a on (a.tr_no =eq.tr_no and a.sr_no=eq.sr_no) "
						+ "left join my_area aa on aa.doc_no=eq.areaid where eq.tr_no='"+docno+"' and eq.revision_no='"+revisionno+"'";  
			}else if(id==2) {
				sql="select a.tr_no rdocno,eq.sr_no,eq.rowno,(SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
						+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.survid) order by doc_no) surtype,eq.site,aa.area,eq.remarks, eq.areaid, "
						+ "eq.survid surid, eq.route, eq.gpsx, eq.gpsy, eq.description  from sk_srvcsited eq  left  join (select eq.tr_no,eq.survid,eq.sr_no   "
						+ "from sk_srvcsited eq where eq.tr_no="+docno+" and eq.revision_no='"+revisionno+"') a on (a.tr_no =eq.tr_no and a.sr_no=eq.sr_no) "
						+ "left join my_area aa on aa.doc_no=eq.areaid where eq.tr_no="+docno+" and eq.revision_no='"+revisionno+"' union all select a.tr_no rdocno,eq.sr_no,eq.rowno,(SELECT GROUP_CONCAT(name ORDER BY cm_proptypem.doc_no) nam  FROM cm_proptypem "
						+ "WHERE FIND_IN_SET(cm_proptypem.doc_no, a.survid) order by doc_no) surtype,eq.site,aa.area,eq.remarks, eq.areaid, "
						+ "eq.survid surid, eq.route, eq.gpsx, eq.gpsy, eq.description  from sk_srvcsitedr eq  left  join (select eq.tr_no,eq.survid,eq.sr_no   "
						+ "from sk_srvcsitedr eq where eq.tr_no="+docno+" and eq.revision_no='"+revisionno+"') a on (a.tr_no =eq.tr_no and a.sr_no=eq.sr_no) "
						+ "left join my_area aa on aa.doc_no=eq.areaid where eq.tr_no="+docno+" and eq.revision_no='"+revisionno+"'";       
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

			String sql = "";
			if(id==1) {
				sql="select UPPER(r6.name) ctype,d.ctypeid,r3.tripsinmonth,0 rowno,UPPER(r5.name) tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, if(s.rowno is null,'',s.site) site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, d.tariffrate, d.addrate, d.tippingfee, d.rent, d.foc,UPPER(r1.name) ownership,UPPER(r2.name) serviceby,UPPER(r3.name) serviceterm,UPPER(sp.name) spec,UPPER(r4.name) collection,if(s.rowno is null,0,s.sr_no) siteid,d.securityval, coalesce(d.tippingmethod,1) tippingmethodid, round(d.tippingsecurity,0) tippingsecurity, d.restricted, d.gatefee from sk_srvqotdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_servsited s on s.site=d.site and s.tr_no=d.rdocno and s.revision_no=d.revision_no left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION')  left join sk_enqrelated r5 on (r5.srno=coalesce(d.tippingmethod,1) and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where d.rdocno='"+docno+"' and d.revision_no='"+revisionno+"'";
			}else if(id==2) {  
				 sql="select UPPER(r6.name) ctype,d.ctypeid,r3.tripsinmonth,d.rowno,UPPER(r5.name) tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, s.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, d.tariffrate, d.addrate, d.tippingfee, d.rent, d.foc,UPPER(r1.name) ownership,UPPER(r2.name) serviceby,UPPER(r3.name) serviceterm,UPPER(sp.name) spec,UPPER(r4.name) collection,s.sr_no siteid,d.securityval, coalesce(d.tippingmethod,1) tippingmethodid, round(d.tippingsecurity,0) tippingsecurity, d.restricted, d.gatefee from sk_srvcontrdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION')  left join sk_enqrelated r5 on (r5.srno=coalesce(d.tippingmethod,1) and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where d.rdocno='"+docno+"'  and d.revision_no='"+revisionno+"' union all select r6.name ctype,d.ctypeid,r3.tripsinmonth,d.rowno,r5.name tippingmethod,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, s.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, d.tariffrate, d.addrate, d.tippingfee, d.rent, d.foc,r1.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection,s.sr_no siteid,d.securityval, coalesce(d.tippingmethod,1) tippingmethodid, round(d.tippingsecurity,0) tippingsecurity, d.restricted, d.gatefee from sk_srvcontrdetr d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsitedr s on s.rowno=d.siteid left join sk_enqrelated r1 on (r1.srno=d.ownershipid and r1.type='SERVICEBY') left join sk_enqrelated r2 on (r2.srno=d.servicebyid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.srno=d.collectionid and r4.type='COLLECTION')  left join sk_enqrelated r5 on (r5.srno=coalesce(d.tippingmethod,1) and r5.type='TIPPINGFEEMETHOD') left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where d.rdocno='"+docno+"'  and d.revision_no='"+revisionno+"'";
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
	public JSONArray clientConfirmData(HttpSession session,String docno,int id,String revisionno) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();

			 String  sql="select replace(path,'\\\\\\\\',';') path,attach upload,coalesce(rowno,0) rowno,pono, DATE_FORMAT(date,'%d.%m.%Y') date, round(coalesce(amount,0),2) amount, DATE_FORMAT(validupto,'%d.%m.%Y') validupto, description, rdocno, qty from sk_srvcontrd d where d.rdocno='"+docno+"' and d.revision_no='"+revisionno+"'";
			 //System.out.println("===sql4536===="+sql);  
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

			String sql="select srno, UPPER(name) name, srno doc_no,tripsinmonth from sk_enqrelated where status=3 and type='"+type+"'";  
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
	public ClsServiceContractBean getViewDetails(HttpSession session,String docno) throws SQLException {  
		Connection conn = null;
		try {

			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement ();       
            String branchid=session.getAttribute("BRANCHID").toString();       
            String Sql= "select m.manualinv,m.extremarks,m.intremarks,m.witheffect,m.oldcnttrno,m.cpemail,m.advtype, m.inctipfee, m.invstart, m.cperson,m.cpersonid,if(m.mergedinvoice='Yes',1,0) mergedinvoice,m.refno,"
					+ "m.revision_no,m.refdtype,m.advinvvalue,m.advinvmethod,m.payterms,m.billingmethod,coalesce(a1.name,'') groupcompanies,m.date,m.startdt,"
					+ "m.enddt,ac.address com_add1, m.mob, m.tel telno, m.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,"
					+ "ac.refname,sm.sal_name,m.sal_id,m.cldocno,m.typeid,m.cctype from sk_srvcontrm m left join gl_enqm em on em.doc_no=m.refdocno "
					+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno)"
					+ " left join my_crmcontact cp on cp.row_no=m.cpersonid where m.status<>7 and m.doc_no='"+docno+"' and m.brhid='"+branchid+"'";
            System.out.println("===getViewDetails===="+Sql);           
			ResultSet rs = stmt.executeQuery(Sql);  
			while(rs.next()){
                bean.setMasterdoc_no(rs.getInt("tr_no"));				
				bean.setHidcmbtype(rs.getString("typeid"));  
				bean.setHidchkmanualinv(rs.getString("manualinv"));      
				bean.setTxtextremarks(rs.getString("extremarks"));      
				bean.setTxtintremarks(rs.getString("intremarks"));
				bean.setHidwitheffectDate(rs.getString("witheffect"));    
				bean.setHidcnttrno(rs.getString("oldcnttrno"));     
				bean.setTxttobeinvoicedmail(rs.getString("email"));                     
				bean.setCmbadvtype(rs.getString("advtype"));
				bean.setCmbinctipfee(rs.getString("inctipfee"));      
				bean.setCmbinvstart(rs.getString("invstart"));
				bean.setHidchkmergedinv(rs.getString("mergedinvoice"));   
				bean.setQuoteDate(rs.getString("date"));
				bean.setStartDate(rs.getString("startdt"));   
				bean.setEndDate(rs.getString("enddt"));
				bean.setTxtrefno(rs.getString("refno"));    
				bean.setTxtadvinvvalue(rs.getString("advinvvalue"));    
				bean.setCmbinvmethod(rs.getString("advinvmethod"));
				bean.setHidenqdocno(rs.getString("enqdocno"));
				bean.setHidcldocno(rs.getString("cldocno"));
				bean.setTxtsalesmandocno(rs.getString("sal_id"));
				bean.setTxtdesc(rs.getString("remarks"));  
				bean.setTxtenquiry(rs.getString("enqvocno"));
				bean.setTxtclient(rs.getString("refname"));
				bean.setTxtsalesman(rs.getString("sal_name"));
				bean.setTxtaddress(rs.getString("com_add1"));
				bean.setTxtmail(rs.getString("cpemail"));
				bean.setTxtmob(rs.getString("mob"));
				bean.setTxttele(rs.getString("telno"));  
				bean.setTxtgroupcompanies(rs.getString("groupcompanies"));
				bean.setHidcmbbillingmethod(rs.getString("billingmethod"));        
				bean.setCmbbillingmethod(rs.getString("billingmethod"));
				bean.setCmbpayterm(rs.getString("payterms"));   
				bean.setHidcmbpayterm(rs.getString("payterms"));  
				bean.setCmbreftype(rs.getString("refdtype"));
				bean.setTxtrevise(rs.getString("revision_no")); 
				bean.setTxtcperson(rs.getString("cperson"));
				bean.setHidcpersonid(rs.getString("cpersonid"));  
				bean.setHidcmbcctype(rs.getString("cctype"));     
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
	 public JSONArray termsDetails(HttpSession session,String trno,String typeid,int id) throws SQLException{      
			JSONArray RESULTDATA1=new JSONArray();
			Connection conn=null;
			try {
				conn = conobj.getMyConnection();
				Statement stmt = conn.createStatement();
				String sql="";      
				if(id==2) {
					 sql="select seqno,heading terms, details conditions from sk_qterms where typeid='"+typeid+"' and dtype='AMC'";
				}else {
					 sql="select rowno, seqno, terms, conditions, rdocno from sk_cterms where rdocno='"+trno+"'"; 
				}
				//System.out.println(id+"===sql===="+sql);
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
	 public  JSONArray contactSearch(String cldocno) throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn=null;
			try {
				conn = conobj.getMyConnection();
				Statement stmtVeh = conn.createStatement ();

				String salsql="select e.mob,e.email,e.tel,e.cperson,e.row_no cpersonid,e.actvty_id ,ac.ay_name,ac.doc_no aydocno from my_crmcontact e  left join my_activity ac on e.actvty_id=ac.doc_no where e.cldocno='"+cldocno+"' ";
				//System.out.println("contactSearch="+salsql); 
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
