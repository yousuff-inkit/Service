package com.skips.invoice;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import com.common.*;
import com.connection.ClsConnection;     

public class ClsManualInvoiceDAO1 {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
    ClsManualInvoiceBean bean = new ClsManualInvoiceBean();
	 public int insert(Connection conn, Date sqlStartDate,Date startdate,Date enddate,String reftype,String cntrno,String cldocno,String ledgernote,String invoicenote,ArrayList<String> invarray,HttpSession session,String mode,String dtype,HttpServletRequest request,String remarks) throws SQLException {
		 try{      
			int docno;
			//conn=objconn.getMyConnection(); 
			Statement stmt =conn.createStatement();    
			//conn.setAutoCommit(false);     
			//System.out.println("IN DAO");             
            CallableStatement stmtInvoice = conn.prepareCall("{call sk_invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");      
			
            stmtInvoice.setDate(1,sqlStartDate);    
			stmtInvoice.setString(2,reftype);   
			stmtInvoice.setString(3,cldocno==null || cldocno.equalsIgnoreCase("")?"0":cldocno);  
			stmtInvoice.setString(4,cntrno==null || cntrno.equalsIgnoreCase("")?"0":cntrno);
			stmtInvoice.setString(5,ledgernote);  
			stmtInvoice.setString(6,invoicenote);
		    stmtInvoice.setDate(7,startdate);
			stmtInvoice.setDate(8,enddate);			
			stmtInvoice.setString(9,dtype);
			stmtInvoice.setString(10,session.getAttribute("USERID").toString());
			stmtInvoice.setString(11,session.getAttribute("BRANCHID").toString());
			stmtInvoice.setString(12,mode);
	        stmtInvoice.registerOutParameter(13, java.sql.Types.INTEGER);
			stmtInvoice.registerOutParameter(14, java.sql.Types.INTEGER);
	        stmtInvoice.registerOutParameter(15, java.sql.Types.INTEGER);	
	    	stmtInvoice.setString(16,remarks);  
			stmtInvoice.executeQuery();   
			docno=stmtInvoice.getInt("docNo");
			int vocno=stmtInvoice.getInt("voucher");  
			int testtrno=stmtInvoice.getInt("vtrNo");  
			request.setAttribute("vocno", vocno);
			if(docno<=0){  
				//conn.close(); 
				return 0;
			}	
			System.out.println("invarray="+invarray);
			String clacno="0";
			String trsql="SELECT acno clacno FROM my_acbook where cldocno='"+cldocno+"' and dtype='crm'";
			ResultSet tass = stmtInvoice.executeQuery (trsql);  
			while (tass.next()) {
				clacno=tass.getString("clacno");		
		     }
			int count=0;
			int iapprovalStatus=3;
			String refdetails="INV"+""+vocno; 
			String appsql="select count(*) icount from my_apprmaster where status=3 and dtype='"+dtype+"'";  
			ResultSet appsqlrs = stmtInvoice.executeQuery(appsql);  
			if (appsqlrs.next()) {
				count=appsqlrs.getInt("icount");		
		     }
			if(count==0){
				iapprovalStatus=3;
			}else{
				iapprovalStatus=0;  
			}
			
			
			/** to update 3 columns to load in invoice print*/			
			
			String sitesql="UPDATE sk_invm m inner join sk_srvcontrdet d on d.rdocno=m.cnttrno left join sk_srvcsited s on d.siteid=s.rowno left join (select count(*) skipatsiteqty, rdocno, srno from sk_srvcontrdel del where type='N' group by del.rdocno,del.srno) dd on dd.rdocno=m.cnttrno SET m.atsiteqty = coalesce(skipatsiteqty,0), m.skiptype = d.skiptype, m.siteid = d.siteid,m.site=s.site WHERE m.status=3 and m.doc_no="+docno;
			int siteupd = stmtInvoice.executeUpdate(sitesql);
			
			
			Double nettaxtot=0.0,taxtotal=0.0;    
			for(int i=0;i< invarray.size();i++){  

				String[] invstring=invarray.get(i).split("::");   
				String netamt=""+(invstring[8].trim().equalsIgnoreCase("undefined") || invstring[8].trim().equalsIgnoreCase("NaN")||invstring[8].trim().equalsIgnoreCase("")|| invstring[8].isEmpty()?0:invstring[8].trim());
				nettaxtot+=Double.parseDouble(netamt);
				if(i==invarray.size()-1){  
					    double dramt=objcommon.sqlRound(nettaxtot,2);    
						String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "        
						 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+clacno+"','"+ledgernote+"',1,1,"+objcommon.sqlRound(dramt, 2)+","+objcommon.sqlRound(dramt,2)+",0,1,5,0,0,"+cldocno+",0,0,0,'"+dtype+"','"+session.getAttribute("BRANCHID").toString()+"',"+testtrno+",'"+iapprovalStatus+"')";
   			            System.out.println("client account sql ="+sql1);        
						 int ss = stmtInvoice.executeUpdate(sql1);
					     if(ss<=0) {
								//conn.close();
								return 0;  
							}
						
				 }
				if(!(invstring[0].trim().equalsIgnoreCase("undefined")|| invstring[0].trim().equalsIgnoreCase("NaN")||invstring[0].trim().equalsIgnoreCase("")|| invstring[0].isEmpty()))
				{
					 
					String amounts=""+(invstring[5].trim().equalsIgnoreCase("undefined") || invstring[5].trim().equalsIgnoreCase("NaN")||invstring[5].trim().equalsIgnoreCase("")|| invstring[5].isEmpty()?0:invstring[5].trim());
					double dramount=Double.parseDouble(amounts);
					String idno = (invstring[0].trim().equalsIgnoreCase("undefined") || invstring[0].trim().equalsIgnoreCase("NaN")|| invstring[0].trim().equalsIgnoreCase("")|| invstring[0].isEmpty()?0:invstring[0].trim()).toString();
					String remarkss = (invstring[2].trim().equalsIgnoreCase("undefined") || invstring[2].trim().equalsIgnoreCase("NaN")||invstring[2].trim().equalsIgnoreCase("")|| invstring[2].isEmpty()?0:invstring[2].trim()).toString();
					if(remarkss.equalsIgnoreCase("A D F- TIPPING FEE MSW (MUNICIPAL SOLID WASTE)")){
					    idno = "10";
					} else if(remarkss.equalsIgnoreCase("A D F- TIPPING FEE CONSTRUCTION & DEMOLITION WASTE")) {
					    idno = "11";
					}					
					System.out.println("IDNO= "+idno+" REMARKS= "+remarkss);
					if(dramount>0) {
						String sql="INSERT INTO sk_invd(sr_no, rdocno, idno, acno, remarks, qty, rate, total, taxper, taxamt, nettotal) VALUES("          
								+ " "+(i+1)+","
								+ " "+docno+","   
								+ "'"+idno+"',"
								+ "'"+(invstring[1].trim().equalsIgnoreCase("undefined") || invstring[1].trim().equalsIgnoreCase("NaN")|| invstring[1].trim().equalsIgnoreCase("")|| invstring[1].isEmpty()?0:invstring[1].trim())+"',"
						      //+ "'"+(invstring[2].trim().equalsIgnoreCase("undefined") || invstring[2].trim().equalsIgnoreCase("NaN")||invstring[2].trim().equalsIgnoreCase("")|| invstring[2].isEmpty()?0:invstring[2].trim())+"',"
								+"'"+remarkss+"',"
								+ "'"+(invstring[3].trim().equalsIgnoreCase("undefined") || invstring[3].trim().equalsIgnoreCase("NaN")||invstring[3].trim().equalsIgnoreCase("")|| invstring[3].isEmpty()?0:invstring[3].trim())+"',"
								+ "'"+(invstring[4].trim().equalsIgnoreCase("undefined") || invstring[4].trim().equalsIgnoreCase("NaN")||invstring[4].trim().equalsIgnoreCase("")|| invstring[4].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[4].trim().toString()),2))+"',"  
								+ "'"+(invstring[5].trim().equalsIgnoreCase("undefined") || invstring[5].trim().equalsIgnoreCase("NaN")||invstring[5].trim().equalsIgnoreCase("")|| invstring[5].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[5].trim().toString()),2))+"',"
							    + "'"+(invstring[6].trim().equalsIgnoreCase("undefined") || invstring[6].trim().equalsIgnoreCase("NaN")||invstring[6].trim().equalsIgnoreCase("")|| invstring[6].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[6].trim().toString()),2))+"',"
								+ "'"+(invstring[7].trim().equalsIgnoreCase("undefined") || invstring[7].trim().equalsIgnoreCase("NaN")||invstring[7].trim().equalsIgnoreCase("")|| invstring[7].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[7].trim().toString()),2))+"',"
								+ "'"+(invstring[8].trim().equalsIgnoreCase("undefined") || invstring[8].trim().equalsIgnoreCase("NaN")||invstring[8].trim().equalsIgnoreCase("")|| invstring[8].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[8].trim().toString()),2))+"')";             
	                    System.out.println("Manualsql--->>>"+sql);  
						int resultSetsite2 = stmtInvoice.executeUpdate (sql);
						if(resultSetsite2<=0)
						{
							//conn.close();
							return 0;  
						}
						double amt=Double.parseDouble((invstring[5].trim().equalsIgnoreCase("undefined") || invstring[5].trim().equalsIgnoreCase("NaN")||invstring[5].trim().equalsIgnoreCase("")|| invstring[5].isEmpty()?"0":invstring[5].trim()))*-1;
						String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
							 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(invstring[1].trim().equalsIgnoreCase("undefined") || invstring[1].trim().equalsIgnoreCase("NaN")|| invstring[1].trim().equalsIgnoreCase("")|| invstring[1].isEmpty()?0:invstring[1].trim())+"', "
					 				+ "'"+(invstring[2].trim().equalsIgnoreCase("undefined") || invstring[2].trim().equalsIgnoreCase("NaN")||invstring[2].trim().equalsIgnoreCase("")|| invstring[2].isEmpty()?0:invstring[2].trim())+"', 1, 1,"+objcommon.sqlRound(amt,2)+","+objcommon.sqlRound(amt,2)+",0,-1,5,"+(i+1)+",0,0,0,'"+dtype+"', "
									+ "'"+session.getAttribute("BRANCHID").toString()+"',"+testtrno+",'"+iapprovalStatus+"',0,0)";     
						System.out.println("Gridline account sql ="+don);  	
						int samp=stmtInvoice.executeUpdate(don);  
						if(samp<=0) {
							//conn.close();
							return 0;
						}
					}
					String nettaxamt=""+(invstring[7].trim().equalsIgnoreCase("undefined") || invstring[7].trim().equalsIgnoreCase("NaN")||invstring[7].trim().equalsIgnoreCase("")|| invstring[7].isEmpty()?0:invstring[7].trim());
					taxtotal+=Double.parseDouble(nettaxamt);  
				    if(i==invarray.size()-1){  
				    	 long taxacno=0;
		    			 String upsql1=" select acno from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		 		    	 ResultSet resultSet4 = stmtInvoice.executeQuery(upsql1);   
		 		    	 while(resultSet4.next()){
		 		    		taxacno=resultSet4.getLong("acno");
		 		    	 }
						 double dramt=taxtotal*-1;   
						 if(taxtotal>0) {
						     // System.out.println(objcommon.sqlRound(dramt,2)+"===="+taxtotal);
							 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
								 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+taxacno+"', "  
						 				+ "'"+(invstring[2].trim().equalsIgnoreCase("undefined") || invstring[2].trim().equalsIgnoreCase("NaN")||invstring[2].trim().equalsIgnoreCase("")|| invstring[2].isEmpty()?0:invstring[2].trim())+"', 1, 1,"+objcommon.sqlRound(dramt,2)+","+objcommon.sqlRound(dramt,2)+",0,-1,5,"+(i+1)+",0,0,0,'"+dtype+"', "  
										+ "'"+session.getAttribute("BRANCHID").toString()+"',"+testtrno+",'"+iapprovalStatus+"',0,0)";     
				   			 System.out.println("tax account sql ="+sql1);            
							 int ss = stmtInvoice.executeUpdate(sql1);
							 if(ss<=0) {
									 //conn.close();
									 return 0;  
							 } 
						 }
					  } 
				   }
			    }  
			
			    ArrayList<String> arr=new ArrayList<String>(); 
				ClsVatInsert ClsVatInsert=new ClsVatInsert();
				Statement newStatement=conn.createStatement();
				String selectsqls= "select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3, "
						+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
						+" sum(a.total9) total9,sum(a.total10) total10, "
						+" sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,sum(a.tax6) tax6, "
						+" sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
						+" from ( "
					    +" select d.total+coalesce(d.taxamt,0) nettaxamount,if(coalesce(d.taxamt,0)>0,d.total,0) total1, "
						+" if(coalesce(d.taxamt,0)=0,d.total,0) total2 ,0 total3, "
						+" 0 total4,0 total5, "
						+" 0 total6,0 total7, "
						+" 0 total8,0 total9, "
						+" 0 total10, "
						+" if(d.taxamt>0,d.taxamt,0) tax1,  0 tax2, "
						+" 0 tax3,  0 tax4, "
						+" 0 tax5, 0 tax6, "
						+" 0 tax7,  0 tax8, "
						+" 0 tax9,  0 tax10 "
						+" from sk_invd d where rdocno="+docno+" ) a" ;    
			    //System.out.println("===VAT===="+selectsqls);   
				
				ResultSet rss101=newStatement.executeQuery(selectsqls);
				if(rss101.first())
					{
					arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
							rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
							rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
							rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
							rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
							rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
							rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
					}   
				
					int result=ClsVatInsert.vatinsert(1,2,conn,testtrno,Integer.parseInt(clacno),vocno,sqlStartDate,dtype,session.getAttribute("BRANCHID").toString(),""+vocno,1,arr,mode)	;
				    if(result==0){
						//conn.close();
						return 0;
					}  
						
       if (docno > 0) {
    	   double total=0.0;
   		   String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+testtrno+"";
   		   ResultSet rsJv = stmtInvoice.executeQuery(sql1);
   		   while (rsJv.next()) {
   			 total=rsJv.getDouble("jvtotal");   
   		   }
   		 
   		 String sql12="select acno,ldramount from my_jvtran where tr_no="+testtrno+"";
         ResultSet rsJv2 = stmtInvoice.executeQuery(sql12);
         while (rsJv2.next()) {
           System.out.println(rsJv2.getDouble("acno")+"===="+rsJv2.getDouble("ldramount"));
         }
   		   if(total == 0){
	   			String sqlss10="delete from my_jvtran where dramount=0 and tr_no='"+testtrno+"'";
	   			stmtInvoice.executeUpdate(sqlss10);
	   			//conn.commit();
	   			stmtInvoice.close();
	   			//conn.close();
	   			return docno;
   		   }else{
   		        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
   		        stmtInvoice.close();
   		        //conn.close();
   			    return 0;
   		    }  
		 }
		}catch(Exception e){	
			e.printStackTrace();
			//conn.close();	
		}
		return 0;
	}

	 public boolean edit(Connection conn, int docno,Date sqlStartDate,Date startdate,Date enddate,String reftype,String cntrno,String cldocno,String ledgernote,String invoicenote,ArrayList<String> invarray,HttpSession session,String mode,String dtype,HttpServletRequest request,String remarks) throws SQLException {
		try{  
			//conn=objconn.getMyConnection();  
			Statement stmt =conn.createStatement();
			//conn.setAutoCommit(false);  
            CallableStatement stmtInvoice = conn.prepareCall("{call sk_invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");        
			
            stmtInvoice.setDate(1,sqlStartDate);    
			stmtInvoice.setString(2,reftype);   
			stmtInvoice.setString(3,cldocno==null || cldocno.equalsIgnoreCase("")?"0":cldocno);
			stmtInvoice.setString(4,cntrno==null || cntrno.equalsIgnoreCase("")?"0":cntrno);
			stmtInvoice.setString(5,ledgernote);  
			stmtInvoice.setString(6,invoicenote);
		    stmtInvoice.setDate(7,startdate);
			stmtInvoice.setDate(8,enddate);			
			stmtInvoice.setString(9,dtype);
			stmtInvoice.setString(10,session.getAttribute("USERID").toString());
			stmtInvoice.setString(11,session.getAttribute("BRANCHID").toString());
			stmtInvoice.setString(12,mode);
	        stmtInvoice.setInt(13, docno);    
			stmtInvoice.setString(14, "0");
	        stmtInvoice.setString(15, "0");	
	        stmtInvoice.setString(16,remarks); 
			int aaa=stmtInvoice.executeUpdate();           

			if(aaa<=0){
				return false;
			}else{
				int applydelete=0,tranno=0;
				String trsql1="select tr_no from sk_invm where doc_no='"+docno+"'";  
				ResultSet rs1 = stmtInvoice.executeQuery (trsql1);     
				while (rs1.next()) {
				   tranno=rs1.getInt("tr_no");       
			    }
				ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, tranno);
			    if(applydelete<0){
			    	System.out.println("*** ERROR IN APPLY DELETE ***");
			    	stmtInvoice.close();   
			        //conn.close();
			        return false;
			    }      
			}  
			String clacno="0",vocno="0",testtrno="0";
			String trsql="SELECT ac.acno clacno,m.voc_no,m.tr_no FROM sk_invm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' where m.doc_no='"+docno+"'";  
			ResultSet tass = stmtInvoice.executeQuery (trsql);  
			while (tass.next()) {
				clacno=tass.getString("clacno");
				vocno=tass.getString("voc_no"); 
				testtrno=tass.getString("tr_no");    
		     }
			String delsql="delete from my_jvtran where tr_no='"+testtrno+"'";    
			stmtInvoice.executeUpdate(delsql);      
			int count=0;
			int iapprovalStatus=3;
			String refdetails="INV"+""+vocno; 
			String appsql="select count(*) icount from my_apprmaster where status=3 and dtype='"+dtype+"'";  
			ResultSet appsqlrs = stmtInvoice.executeQuery(appsql);  
			if (appsqlrs.next()) {
				count=appsqlrs.getInt("icount");		
		     }
			if(count==0){
				iapprovalStatus=3;
			}else{
				iapprovalStatus=0;  
			}
			Double nettaxtot=0.0,taxtotal=0.0;  
			for(int i=0;i< invarray.size();i++){  
				String[] invstring=invarray.get(i).split("::");  
				String netamt=""+(invstring[8].trim().equalsIgnoreCase("undefined") || invstring[8].trim().equalsIgnoreCase("NaN")||invstring[8].trim().equalsIgnoreCase("")|| invstring[8].isEmpty()?0:invstring[8].trim());
				nettaxtot+=Double.parseDouble(netamt);
				if(i==invarray.size()-1){  
					    double dramt = objcommon.sqlRound(nettaxtot,2);    
						String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "        
						 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+clacno+"','"+ledgernote+"',1,1,"+objcommon.sqlRound(dramt,2)+","+objcommon.sqlRound(dramt,2)+",0,1,5,0,0,"+cldocno+",0,0,0,'"+dtype+"','"+session.getAttribute("BRANCHID").toString()+"',"+testtrno+",'"+iapprovalStatus+"')";
   			            //System.out.println("client account sql ="+sql1);        
						 int ss = stmtInvoice.executeUpdate(sql1);
					     if(ss<=0) {
								//conn.close();
								return false;  
							}
						
				 }
				if(!(invstring[0].trim().equalsIgnoreCase("undefined")|| invstring[0].trim().equalsIgnoreCase("NaN")||invstring[0].trim().equalsIgnoreCase("")|| invstring[0].isEmpty()))
				{
					String amounts=""+(invstring[5].trim().equalsIgnoreCase("undefined") || invstring[5].trim().equalsIgnoreCase("NaN")||invstring[5].trim().equalsIgnoreCase("")|| invstring[5].isEmpty()?0:invstring[5].trim());
					double dramount=Double.parseDouble(amounts);
					if(dramount>0) {   
						int rowno=invstring[9].trim().equalsIgnoreCase("undefined") || invstring[9].trim().equalsIgnoreCase("NaN")||invstring[9].trim().equalsIgnoreCase("")|| invstring[9].isEmpty()?0:Integer.parseInt(invstring[9].trim()); 
						if(rowno>0) {  
							String upsql="update sk_invd set idno='"+(invstring[0].trim().equalsIgnoreCase("undefined") || invstring[0].trim().equalsIgnoreCase("NaN")|| invstring[0].trim().equalsIgnoreCase("")|| invstring[0].isEmpty()?0:invstring[0].trim())+"',"
									+ "acno='"+(invstring[1].trim().equalsIgnoreCase("undefined") || invstring[1].trim().equalsIgnoreCase("NaN")|| invstring[1].trim().equalsIgnoreCase("")|| invstring[1].isEmpty()?0:invstring[1].trim())+"',"
									+ "remarks='"+(invstring[2].trim().equalsIgnoreCase("undefined") || invstring[2].trim().equalsIgnoreCase("NaN")||invstring[2].trim().equalsIgnoreCase("")|| invstring[2].isEmpty()?0:invstring[2].trim())+"',"
									+ "qty='"+(invstring[3].trim().equalsIgnoreCase("undefined") || invstring[3].trim().equalsIgnoreCase("NaN")||invstring[3].trim().equalsIgnoreCase("")|| invstring[3].isEmpty()?0:invstring[3].trim())+"',"
									+ "rate='"+(invstring[4].trim().equalsIgnoreCase("undefined") || invstring[4].trim().equalsIgnoreCase("NaN")||invstring[4].trim().equalsIgnoreCase("")|| invstring[4].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[4].trim().toString()),2))+"',"
									+ "total='"+(invstring[5].trim().equalsIgnoreCase("undefined") || invstring[5].trim().equalsIgnoreCase("NaN")||invstring[5].trim().equalsIgnoreCase("")|| invstring[5].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[5].trim().toString()),2))+"',"
								    + "taxper='"+(invstring[6].trim().equalsIgnoreCase("undefined") || invstring[6].trim().equalsIgnoreCase("NaN")||invstring[6].trim().equalsIgnoreCase("")|| invstring[6].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[6].trim().toString()),2))+"',"   
									+ "taxamt='"+(invstring[7].trim().equalsIgnoreCase("undefined") || invstring[7].trim().equalsIgnoreCase("NaN")||invstring[7].trim().equalsIgnoreCase("")|| invstring[7].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[7].trim().toString()),2))+"',"
									+ "nettotal='"+(invstring[8].trim().equalsIgnoreCase("undefined") || invstring[8].trim().equalsIgnoreCase("NaN")||invstring[8].trim().equalsIgnoreCase("")|| invstring[8].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[8].trim().toString()),2))+"' where rowno='"+rowno+"'";           
		                    //System.out.println("upsql--->>>"+upsql);  
							int resultSetsite2 = stmtInvoice.executeUpdate (upsql);
							if(resultSetsite2<=0)
							{
								//conn.close();
								return false;   
							}	
						}else {
							String insql="INSERT INTO sk_invd(sr_no, rdocno, idno, acno, remarks, qty, rate, total, taxper, taxamt, nettotal) VALUES("          
									+ " "+(i+1)+","
									+ " "+docno+","
									+ "'"+(invstring[0].trim().equalsIgnoreCase("undefined") || invstring[0].trim().equalsIgnoreCase("NaN")|| invstring[0].trim().equalsIgnoreCase("")|| invstring[0].isEmpty()?0:invstring[0].trim())+"',"
									+ "'"+(invstring[1].trim().equalsIgnoreCase("undefined") || invstring[1].trim().equalsIgnoreCase("NaN")|| invstring[1].trim().equalsIgnoreCase("")|| invstring[1].isEmpty()?0:invstring[1].trim())+"',"
									+ "'"+(invstring[2].trim().equalsIgnoreCase("undefined") || invstring[2].trim().equalsIgnoreCase("NaN")||invstring[2].trim().equalsIgnoreCase("")|| invstring[2].isEmpty()?0:invstring[2].trim())+"',"
									+ "'"+(invstring[3].trim().equalsIgnoreCase("undefined") || invstring[3].trim().equalsIgnoreCase("NaN")||invstring[3].trim().equalsIgnoreCase("")|| invstring[3].isEmpty()?0:invstring[3].trim())+"',"
									+ "'"+(invstring[4].trim().equalsIgnoreCase("undefined") || invstring[4].trim().equalsIgnoreCase("NaN")||invstring[4].trim().equalsIgnoreCase("")|| invstring[4].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[4].trim().toString()),2))+"',"  
									+ "'"+(invstring[5].trim().equalsIgnoreCase("undefined") || invstring[5].trim().equalsIgnoreCase("NaN")||invstring[5].trim().equalsIgnoreCase("")|| invstring[5].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[5].trim().toString()),2))+"',"
								    + "'"+(invstring[6].trim().equalsIgnoreCase("undefined") || invstring[6].trim().equalsIgnoreCase("NaN")||invstring[6].trim().equalsIgnoreCase("")|| invstring[6].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[6].trim().toString()),2))+"',"
									+ "'"+(invstring[7].trim().equalsIgnoreCase("undefined") || invstring[7].trim().equalsIgnoreCase("NaN")||invstring[7].trim().equalsIgnoreCase("")|| invstring[7].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[7].trim().toString()),2))+"',"
									+ "'"+(invstring[8].trim().equalsIgnoreCase("undefined") || invstring[8].trim().equalsIgnoreCase("NaN")||invstring[8].trim().equalsIgnoreCase("")|| invstring[8].isEmpty()?0.0:objcommon.Round(Double.parseDouble(invstring[8].trim().toString()),2))+"')";             
		                    //System.out.println("insql--->>>"+insql);  
							int resultSetsite2 = stmtInvoice.executeUpdate (insql);  
							if(resultSetsite2<=0)
							{
								//conn.close();
								return false;   
							}	
						}
						
						double amt=Double.parseDouble((invstring[5].trim().equalsIgnoreCase("undefined") || invstring[5].trim().equalsIgnoreCase("NaN")||invstring[5].trim().equalsIgnoreCase("")|| invstring[5].isEmpty()?"0":invstring[5].trim()))*-1;
						String don="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
						 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+(invstring[1].trim().equalsIgnoreCase("undefined") || invstring[1].trim().equalsIgnoreCase("NaN")|| invstring[1].trim().equalsIgnoreCase("")|| invstring[1].isEmpty()?0:invstring[1].trim())+"', "   
				 				+ "'"+(invstring[2].trim().equalsIgnoreCase("undefined") || invstring[2].trim().equalsIgnoreCase("NaN")||invstring[2].trim().equalsIgnoreCase("")|| invstring[2].isEmpty()?0:invstring[2].trim())+"', 1, 1,"+objcommon.sqlRound(amt,2)+","+objcommon.sqlRound(amt,2)+",0,1,5,"+(i+1)+",0,0,0,'"+dtype+"', "
								+ "'"+session.getAttribute("BRANCHID").toString()+"',"+testtrno+",'"+iapprovalStatus+"',0,0)"; 
						//System.out.println("Gridline account sql ="+don);  	
						int samp=stmtInvoice.executeUpdate(don);  
						if(samp<=0) {
							//conn.close();
							return false;
										
						}
					}  
					String nettaxamt=""+(invstring[7].trim().equalsIgnoreCase("undefined") || invstring[7].trim().equalsIgnoreCase("NaN")||invstring[7].trim().equalsIgnoreCase("")|| invstring[7].isEmpty()?0:invstring[7].trim());
					taxtotal+=Double.parseDouble(nettaxamt);
				    if(i==invarray.size()-1){  
				    	 long taxacno=0;
		    			 String upsql1=" select acno from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0";
		 		    	 ResultSet resultSet4 = stmtInvoice.executeQuery(upsql1);   
		 		    	 while(resultSet4.next()){
		 		    		taxacno=resultSet4.getLong("acno");
		 		    	 }
						 double dramt=taxtotal*-1;   
						 if(taxtotal>0) {  
							 String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,dTYPE,brhId,tr_no,STATUS,costtype,costcode)   "
								 		+ "values('"+sqlStartDate+"','"+refdetails+"',"+docno+",'"+taxacno+"', "  
						 				+ "'"+(invstring[2].trim().equalsIgnoreCase("undefined") || invstring[2].trim().equalsIgnoreCase("NaN")||invstring[2].trim().equalsIgnoreCase("")|| invstring[2].isEmpty()?0:invstring[2].trim())+"', 1, 1,"+objcommon.sqlRound(dramt,2)+","+objcommon.sqlRound(dramt,2)+",0,-1,5,"+(i+1)+",0,0,0,'"+dtype+"', "  
										+ "'"+session.getAttribute("BRANCHID").toString()+"',"+testtrno+",'"+iapprovalStatus+"',0,0)";     
				   			//System.out.println("tax account sql ="+sql1);              
							 int ss = stmtInvoice.executeUpdate(sql1);
							 if(ss<=0) {
									 //conn.close();
									 return false;    
							 }   
						 }
					 }
				}
			}  
			 ArrayList<String> arr=new ArrayList<String>(); 
				ClsVatInsert ClsVatInsert=new ClsVatInsert();
				Statement newStatement=conn.createStatement();
				String selectsqls= "select sum(a.nettaxamount) nettaxamount,sum(a.total1) total1,sum(a.total2) total2,sum(a.total3) total3, "
						+" sum(a.total4) total4,sum(a.total5) total5,sum(a.total6) total6,sum(a.total7) total7,sum(a.total8) total8, "
						+" sum(a.total9) total9,sum(a.total10) total10, "
						+" sum(a.tax1) tax1,sum(a.tax2) tax2,sum(a.tax3) tax3,sum(a.tax4) tax4,sum(a.tax5) tax5,sum(a.tax6) tax6, "
						+" sum(a.tax7) tax7,sum(a.tax8) tax8,sum(a.tax9) tax9,sum(a.tax10) tax10 "
						+" from ( "
					    +" select d.total+coalesce(d.taxamt,0) nettaxamount,if(coalesce(d.taxamt,0)>0,d.total,0) total1, "
						+" if(coalesce(d.taxamt,0)=0,d.total,0) total2 ,0 total3, "
						+" 0 total4,0 total5, "
						+" 0 total6,0 total7, "
						+" 0 total8,0 total9, "
						+" 0 total10, "
						+" if(d.taxamt>0,d.taxamt,0) tax1,  0 tax2, "
						+" 0 tax3,  0 tax4, "
						+" 0 tax5, 0 tax6, "
						+" 0 tax7,  0 tax8, "
						+" 0 tax9,  0 tax10 "
						+" from sk_invd d where rdocno="+docno+" ) a" ;    
			    //System.out.println("===VAT===="+selectsqls);   
				
				ResultSet rss101=newStatement.executeQuery(selectsqls);
				if(rss101.first())
					{
					arr.add(rss101.getDouble("nettaxamount")+"::"+rss101.getDouble("total1")+"::"+rss101.getDouble("total2")+"::"+
							rss101.getDouble("total3")+"::"+rss101.getDouble("total4")+"::"+rss101.getDouble("total5")+"::"+
							rss101.getDouble("total6")+"::"+rss101.getDouble("total7")+"::"+rss101.getDouble("total8")+"::"+
							rss101.getDouble("total9")+"::"+rss101.getDouble("total10")+"::"+rss101.getDouble("tax1")+"::"+
							rss101.getDouble("tax2")+"::"+rss101.getDouble("tax3")+"::"+rss101.getDouble("tax4")+"::"+
							rss101.getDouble("tax5")+"::"+rss101.getDouble("tax6")+"::"+rss101.getDouble("tax7")+"::"+
							rss101.getDouble("tax8")+"::"+rss101.getDouble("tax9")+"::"+rss101.getDouble("tax10")+"::"+"0");
					}   
				
					int result=ClsVatInsert.vatinsert(1,2,conn,Integer.parseInt(testtrno),Integer.parseInt(clacno),Integer.parseInt(vocno),sqlStartDate,dtype,session.getAttribute("BRANCHID").toString(),""+vocno,1,arr,mode)	;
				    if(result==0){  
						//conn.close();
						return false;
					}
			if (aaa > 0) {  
				   double total=0.0;
		   		   String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+testtrno+"";
		   		   ResultSet rsJv = stmtInvoice.executeQuery(sql1);
		   		   while (rsJv.next()) {
		   			 total=rsJv.getDouble("jvtotal");   
		   		   } 
		   		 
		   		   if(total == 0){
			   			String sqlss10="delete from my_jvtran where dramount=0 and tr_no='"+testtrno+"'";
			   			stmtInvoice.executeUpdate(sqlss10);
			   			//conn.commit();
			   			stmtInvoice.close();
			   			//conn.close();
			   			return true;
		   		   }else{
		   		        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
		   		        stmtInvoice.close();
		   		        //conn.close();       
		   			    return false;   
		   		    }
			}
		}catch(Exception e){
			e.printStackTrace();
			//conn.close();
		}
		return false;
	}

	public boolean delete(Connection conn, int docno,Date sqlStartDate,String mode,Date sqlStDate,Date sqlEdDate) throws SQLException {   	   

		try{
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);  
			Statement stmt=conn.createStatement();
			String testtrno="0";
			String trsql="SELECT  m.tr_no FROM sk_invm m  where m.doc_no='"+docno+"'";  
			ResultSet tass = stmt.executeQuery (trsql);  
			while (tass.next()) {
				testtrno=tass.getString("tr_no");    
		     }
            CallableStatement stmtInvoice = conn.prepareCall("{call sk_invoiceDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");      
			
            stmtInvoice.setDate(1,sqlStartDate);    
			stmtInvoice.setString(2,"0");   
			stmtInvoice.setString(3,"0");
			stmtInvoice.setString(4,"0");
			stmtInvoice.setString(5,"0");  
			stmtInvoice.setString(6,"0");
		    stmtInvoice.setDate(7,null);
			stmtInvoice.setDate(8,null);			
			stmtInvoice.setString(9,"0");
			stmtInvoice.setString(10,"0");
			stmtInvoice.setString(11,"0");  
			stmtInvoice.setString(12,mode);
	        stmtInvoice.setInt(13, docno);    
			stmtInvoice.setString(14, "0");
	        stmtInvoice.setString(15, "0");	
	        stmtInvoice.setString(16,"");     
			int aaa=stmtInvoice.executeUpdate();
			if(aaa<=0){
				return false;
			}else{
				int applydelete=0,tranno=0;
				String trsql1="select tr_no from sk_invm where doc_no='"+docno+"'";  
				ResultSet rs1 = stmtInvoice.executeQuery (trsql1);     
				while (rs1.next()) {
				   tranno=rs1.getInt("tr_no");       
			    }
				ClsApplyDelete applyDelete = new ClsApplyDelete();
				applydelete=applyDelete.getFinanceApplyDelete(conn, tranno);
			    if(applydelete<0){
			    	System.out.println("*** ERROR IN APPLY DELETE ***");
			    	stmtInvoice.close();   
			        //conn.close();
			        return false;
			    }      
			}   
			if (aaa > 0) {
				String delsql="update my_jvtran set status=7 where tr_no='"+testtrno+"'";    
				stmt.executeUpdate(delsql);    
			}
			ArrayList<String> arr=new ArrayList<String>(); 
			ClsVatInsert ClsVatInsert=new ClsVatInsert();  
			int result=ClsVatInsert.vatinsert(1,2,conn,Integer.parseInt(testtrno),0,0,null,"","1","",1,arr,"D")	;
//			System.out.println("result"+result);
			if(result==0)	
			        {
					//conn.close();
					return false;
					}
			if (aaa > 0) {
				//conn.commit();
				stmtInvoice.close();
				//conn.close();
				System.out.println("Sucess");  
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			//conn.close();
		}
		return false;
	}
 public JSONArray accountSearch() throws SQLException {   
		JSONArray RESULTDATA=new JSONArray();
		String strSql="";
		Connection conn = null;
		try {
			conn=objconn.getMyConnection();

			Statement stmtmanual = conn.createStatement ();
			strSql="select idno,acno,description,if(tax=1,5,0) taxper from sk_invmode where status=1";      
			//System.out.println(strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		return RESULTDATA;
	}

	public   JSONArray mainSearch(String client,String cmbagmttype,String agmtno,String searchdate,String docno,String branch,String id,String site) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		System.out.println("Id:"+id);
		if(!id.equalsIgnoreCase("1")){  
			return RESULTDATA;
		}

		String sqltest=""; 
		java.sql.Date sqldate=null;
		if(!(searchdate.equalsIgnoreCase(""))){
			sqldate=objcommon.changeStringtoSqlDate(searchdate);	
		}

		if(!(client.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+client+"%'";
		}
		if(!(site.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.site like '%"+site+"%'";
		}
		if(!(cmbagmttype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and inv.reftype='"+cmbagmttype+"'";
		}
		if(!(agmtno.equalsIgnoreCase(""))){
				sqltest=sqltest+" and cm.doc_no like '%"+agmtno+"%'";  
		}

		if(!(docno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and inv.voc_no like '%"+docno+"%'";
		}

		if(!branch.equalsIgnoreCase("")){
			sqltest=sqltest+" and inv.brhid="+branch+"";
		}
		if(sqldate!=null){
			sqltest=sqltest+" and inv.date='"+sqldate+"'";
		}
		Connection conn =null;

		try {
			conn= objconn.getMyConnection();
			Statement stmtsearch = conn.createStatement ();
			String str1Sql="select coalesce(s.site,'') site,inv.reftype,inv.doc_no,inv.voc_no,inv.date,inv.ldgrnote,inv.fromdate,inv.todate,inv.invnote,cm.tr_no cnttrno,cm.doc_no cntdocno,inv.cldocno,"
					+ "ac.refname,ac.address,coalesce(ac.per_mob,'') per_mob,ac.acno,coalesce(ac.mail1,'') as email from sk_invm inv "
					+ " left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"  
					+ " left join sk_srvcontrm cm on cm.tr_no=inv.cnttrno left join (select min(rowno) rowno,rdocno from sk_srvcontrdet group  by rdocno) d on d.rdocno=cm.tr_no left join sk_srvcontrdet dd on dd.rowno=d.rowno left join sk_srvcsited s on s.rowno=dd.siteid  where inv.status=3 "+sqltest+""; 
			//System.out.println("str1Sql="+str1Sql);  
			ResultSet resultSet = stmtsearch.executeQuery(str1Sql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtsearch.close();
			conn.close();
			return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		conn.close();
		return RESULTDATA;
	}

	public   JSONArray getInvoiceGridData(String docno) throws SQLException {  
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection  conn = null;
		try {

			conn=objconn.getMyConnection();
			Statement stmtmanual = conn.createStatement ();
			strSql="select rowno, acno account, idno, qty, round(rate,2) rate, round(total,2) total, round(taxper,2) taxper, round(taxamt,2) taxamt, round(nettotal,2) nettotal, remarks description from sk_invd where rdocno='"+docno+"' ";   
			//System.out.println(strSql);    
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		return RESULTDATA;
	}
	public   JSONArray invoiceSearch() throws SQLException {
		List<ClsManualInvoiceBean> invoicebean = new ArrayList<ClsManualInvoiceBean>();
		String strSql="";
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
		try {
			conn=objconn.getMyConnection();

			Statement stmtmanual = conn.createStatement ();
			strSql="select inv.doc_no,inv.rano,inv.date,inv.ratype agmttype,ac.refname from gl_invm inv left join my_acbook ac on"+
					" (inv.cldocno=ac.cldocno and ac.dtype='CRM') where inv.status<>7";
			//	System.out.println(strSql);
			ResultSet resultSet = stmtmanual.executeQuery (strSql);
			RESULTDATA=objcommon.convertToJSON(resultSet);
			stmtmanual.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		//System.out.println("RESULTDATA=========>"+RESULTDATA);
		return RESULTDATA;
	}
	
	public ClsManualInvoiceBean getViewDetails(int docno) throws SQLException {   
		//List<ClsVehicleBean> listBean = new ArrayList<ClsVehicleBean>();
	//	ClsManualInvoiceBean bean = new ClsManualInvoiceBean();
		Connection  conn =null;
		try {
			conn= objconn.getMyConnection();
			Statement stmtinvoice = conn.createStatement ();
			String strSql="select inv.reftype,inv.doc_no invdoc,inv.voc_no voucherno,inv.date,inv.ldgrnote,inv.fromdate,inv.todate,inv.invnote,cm.tr_no cnttrno,cm.doc_no cntdocno,inv.cldocno,"
					+ "ac.refname,ac.address,coalesce(ac.per_mob,'') per_mob,ac.acno,coalesce(ac.mail1,'') as email,inv.remarks from sk_invm inv "
					+ " left join my_acbook ac on (inv.cldocno=ac.cldocno and ac.dtype='CRM')"
					+ " left join sk_srvcontrm cm on cm.tr_no=inv.cnttrno where inv.doc_no='"+docno+"' and inv.status=3";  
			//System.out.println("View Sql:"+strSql);  
			ResultSet rs = stmtinvoice.executeQuery (strSql);
			while (rs.next()) {
				 bean.setCmbreftype(rs.getString("reftype"));     
				 bean.setHidcmbreftype(rs.getString("reftype"));  
				 bean.setHidcntrno(rs.getString("cnttrno"));
				 bean.setTxtclient(rs.getString("refname"));
				 bean.setTxtcontract(rs.getString("cntdocno"));     
				 bean.setHiddate(rs.getString("date"));  
				 bean.setHidfromdate(rs.getString("fromdate"));
				 bean.setHidtodate(rs.getString("todate")); 
				 bean.setLedgernote(rs.getString("ldgrnote")); 
				 bean.setInvoicenote(rs.getString("invnote")); 
				 bean.setTxtremarks(rs.getString("remarks"));  
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			conn.close();
		}
		return bean;
	}
			
	public JSONArray searchClient(HttpSession session,String clnames,String docno,int id) throws SQLException {    
		JSONArray RESULTDATA=new JSONArray();  
		if(id==0){  
			return RESULTDATA;
		}  
		String sqltest="";
		if(!(docno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.cldocno like '%"+docno+"%'";    
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";  
		}
		Connection conn = null;

		try {
			 conn = objconn.getMyConnection();
			 Statement stmtenq1 = conn.createStatement ();  
			 String clsql= "select ac.address com_add1, ac.per_mob mob, ac.per_tel telno, ac.mail1 email,ac.refname,ac.sal_id,ac.cldocno from my_acbook ac  where ac.dtype='crm' and ac.status<>7 "+sqltest+" order by ac.refname";
			 //System.out.println("====Client Search===="+clsql);                            
			ResultSet resultSet = stmtenq1.executeQuery(clsql);  

			RESULTDATA=objcommon.convertToJSON(resultSet);  
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
	public JSONArray searchContract(HttpSession session,String clnames,String cntdocno,int id) throws SQLException {      
		JSONArray RESULTDATA=new JSONArray();  
		if(id==0){  
			return RESULTDATA;
		}  
		String sqltest="";
		if(!(cntdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.doc_no like '%"+cntdocno+"%'";    
		}
		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";  
		}
		Connection conn = null;

		try {
			 conn = objconn.getMyConnection();
			 Statement stmtenq1 = conn.createStatement ();  
			 String clsql= "select m.tr_no,m.doc_no,m.cldocno,ac.refname,m.refdocno from sk_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' where m.status<>7  "+sqltest+"";                
			 //System.out.println("====Contract Search===="+clsql);                                   
			ResultSet resultSet = stmtenq1.executeQuery(clsql);  

			RESULTDATA=objcommon.convertToJSON(resultSet);  
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
}