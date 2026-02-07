package com.dashboard.skips.invoiceproessingnew;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import net.sf.json.JSONArray;
import java.util.*;
import com.skips.invoice.ClsManualInvoiceDAO1;   

public class ClsInvoiceProcessingDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsManualInvoiceDAO1 InvoiceDAO=new ClsManualInvoiceDAO1();   
	Connection conn;
	public JSONArray countData(String todate,String brhid,String id,String cldocno) throws SQLException{  
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqlfilters="";
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqlfilters+=" and brhid="+brhid; 
			}
			if(!cldocno.equalsIgnoreCase("") && !cldocno.equalsIgnoreCase("0")){
				sqlfilters+=" and cldocno="+cldocno;       
			}
			conn=objconn.getMyConnection();
			String strsql="select count(*) count,'Zero Billing(adv)' name,1 val from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno "
					+ "inner join sk_srvcontrdet d on d.rowno=t.contdetno left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,sum(qty) totqty,totsrno "
					+ "from sk_tippingdet group by totsrno) td on td.totsrno=t.srno left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' "
					+ "where m.status  not in (6,7,8)  and m.advinvmethod=1 and t.invoicetrip=t.tottrips and (t.chargedtrip-t.invoicetrip)=0  and "
					+ "coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+" "
					+ "union all select count(*) count,'Tipping Fee Only(adv)' name,2 val from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno "
					+ "inner join sk_srvcontrdet d on d.rowno=t.contdetno left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,sum(qty) totqty,totsrno "
					+ "from sk_tippingdet group by totsrno) td on td.totsrno=t.srno left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' "
					+ "where m.status  not in (6,7,8)  and m.advinvmethod=1  and t.chargedtrip=t.tottrips and (t.chargedtrip-t.invoicetrip)=0 and "
					+ "((coalesce(td.totqty,0)-tippinginvoiced)>0  or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0)) and coalesce(td.hazrdous,0)=0 "
					+ "and m.billingmethod!=3 and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+" union all select count(*) count,"
					+ "'Extra Services(adv)' name,3 val from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d "
					+ "on d.rowno=t.contdetno left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,sum(qty) totqty,totsrno from sk_tippingdet "
					+ "group by totsrno) td on td.totsrno=t.srno left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' where m.status  "
					+ "not in (6,7,8)  and m.advinvmethod=1 and t.executedtrip>t.tottrips and ((t.chargedtrip-t.invoicetrip)>0 or (coalesce(td.totqty,0)-t.tippinginvoiced)>0 or "
					+ "((coalesce(td.totqty,0)-t.gateinvoiced)>0 and d.gatefee>0))  and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3  and month('"+sqltodate+"')=month "
					+ "and year('"+sqltodate+"')=year "+sqlfilters+" union all select count(*) count,'Rental Without Services' name,4 val from sk_triptotal t "
					+ "inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d on d.rowno=t.contdetno left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,"
					+ "sum(qty) totqty,totsrno from sk_tippingdet group by totsrno) td on td.totsrno=t.srno left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' "
					+ "where m.status  not in (6,7,8)  and m.advinvmethod=0 and r1.name='RENT'  and t.executedtrip=0 and (t.chargedtrip-t.invoicetrip)>0  "
					+ "and coalesce(td.hazrdous,0)=0  and m.billingmethod!=3  and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+" "
					+ "union all select count(*) count,'Rental Without Extra Services' name,5 val from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno "
					+ "inner join sk_srvcontrdet d on d.rowno=t.contdetno left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,"
					+ "sum(qty) totqty,totsrno from sk_tippingdet group by totsrno) td on td.totsrno=t.srno where m.status  not in (6,7,8)  and m.advinvmethod=0 and r1.name='RENT' "
					+ "and t.executedtrip<=t.tottrips and t.executedtrip!=0  and ((t.chargedtrip-t.invoicetrip)>0 or (coalesce(td.totqty,0)-t.tippinginvoiced)>0 or ((coalesce(td.totqty,0)-t.gateinvoiced)>0 and d.gatefee>0)) "
					+ "and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+" "
					+ "union all select count(*) count,'Rental With Extra Services' name,6 val from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d on d.rowno=t.contdetno "
					+ "left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,sum(qty) totqty,totsrno "
					+ "from sk_tippingdet group by totsrno) td on td.totsrno=t.srno where m.status  not in (6,7,8)  and m.advinvmethod=0 and r1.name='RENT'  and t.executedtrip>t.tottrips "
					+ "and ((t.chargedtrip-t.invoicetrip)>0 or (coalesce(td.totqty,0)-t.tippinginvoiced)>0 or ((coalesce(td.totqty,0)-t.gateinvoiced)>0 and d.gatefee>0)) and d.rate=d.addrate and  "
					+ "coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+" union all select count(*) count,'Trip Based' name,7 val "
					+ "from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d on d.rowno=t.contdetno left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' "
					+ "left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,sum(qty) totqty,totsrno from sk_tippingdet group by totsrno) td on td.totsrno=t.srno where m.status  "
					+ "not in (6,7,8)  and ((t.chargedtrip-t.invoicetrip)>0 or (coalesce(td.totqty,0)-t.tippinginvoiced)>0 or ((coalesce(td.totqty,0)-t.gateinvoiced)>0 and d.gatefee>0)) "
					+ "and r1.name='TRIP BASIS'  and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+" "
					+ "union all select count(*) count,'Adhoc' name,8 val from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d "
					+ "on d.rowno=t.contdetno left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,sum(qty) totqty,totsrno from sk_tippingdet group by totsrno) td on td.totsrno=t.srno "
					+ "where m.status  not in (6,7,8)  and ((t.chargedtrip-t.invoicetrip)>0 or (coalesce(td.totqty,0)-t.tippinginvoiced)>0 or ((coalesce(td.totqty,0)-t.gateinvoiced)>0 and d.gatefee>0)) "
					+ "and m.billingmethod=3 and coalesce(td.hazrdous,0)=0  and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+" union all select count(*) count,'Extra Services(Diff. rate)' name,9 val "
					+ "from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d on d.rowno=t.contdetno "
					+ "left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,sum(qty) totqty,totsrno "
					+ "from sk_tippingdet group by totsrno) td on td.totsrno=t.srno where m.status  not in (6,7,8)  and m.advinvmethod=0 and r1.name='RENT'  "
					+ "and t.executedtrip>t.tottrips  and ((t.chargedtrip-t.invoicetrip)>0 or (coalesce(td.totqty,0)-t.tippinginvoiced)>0 or "
					+ "((coalesce(td.totqty,0)-t.gateinvoiced)>0 and d.gatefee>0)) and d.rate!=d.addrate and coalesce(td.hazrdous,0)=0 and month('"+sqltodate+"')=month "
					+ "and year('"+sqltodate+"')=year "+sqlfilters+" union all select count(*) count,'Weight Based' name,10 val from sk_triptotal t"
					+ " inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d on d.rowno=t.contdetno left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' "
					+ "left join (select sum(if(wasteid=1 or wasteid=6,1,0)) hazrdous,sum(qty) totqty,totsrno from sk_tippingdet  where price!=0 group by totsrno) td on td.totsrno=t.srno"
					+ " where m.status  not in (6,7,8) and coalesce(td.hazrdous,0)>0 and ((t.chargedtrip-t.invoicetrip)>0 or (coalesce(td.totqty,0)-t.tippinginvoiced)>0 or"
					+ " ((coalesce(td.totqty,0)-t.gateinvoiced)>0 and d.gatefee>0)) and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+"";
			System.out.println("Count ="+strsql);                                    
			ResultSet rs=conn.createStatement().executeQuery(strsql);
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
						
	public JSONArray invoiceData(String todate,String brhid,String id,String cldocno,String type) throws SQLException{       
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqlfilters="",sqltest="";
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+brhid;
			}
			if(!cldocno.equalsIgnoreCase("") && !cldocno.equalsIgnoreCase("0")){
				sqlfilters+=" and m.cldocno="+cldocno;       
			}
			String strsql="";
			conn=objconn.getMyConnection();
			
			if(type.equalsIgnoreCase("1")){  
				sqltest+=" and m.advinvmethod=1 and t.invoicetrip=t.tottrips and (t.chargedtrip-t.invoicetrip)=0 and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 ";    
			}else if(type.equalsIgnoreCase("2")){  
				sqltest+=" and m.advinvmethod=1 and t.chargedtrip=t.tottrips and (t.chargedtrip-t.invoicetrip)=0 and ((coalesce(td.totqty,0)-tippinginvoiced)>0  or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0)) and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 ";  
			}else if(type.equalsIgnoreCase("3")){  
				sqltest+=" and m.advinvmethod=1 and t.executedtrip>t.tottrips and ((chargedtrip-invoicetrip)>0 or (coalesce(td.totqty,0)-tippinginvoiced)>0 or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0)) and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 ";  
			}else if(type.equalsIgnoreCase("4")){  
				sqltest+=" and m.advinvmethod=0 and r1.name='RENT' and t.executedtrip=0 and (t.chargedtrip-t.invoicetrip)>0 and coalesce(td.hazrdous,0)=0  and m.billingmethod!=3 ";       
			}else if(type.equalsIgnoreCase("5")){  
				sqltest+=" and m.advinvmethod=0 and r1.name='RENT' and t.executedtrip<=t.tottrips and t.executedtrip!=0  and ((chargedtrip-invoicetrip)>0 or (coalesce(td.totqty,0)-tippinginvoiced)>0 or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0)) and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 ";       
			}else if(type.equalsIgnoreCase("6")){  
				sqltest+=" and m.advinvmethod=0 and r1.name='RENT' and t.executedtrip>t.tottrips and ((chargedtrip-invoicetrip)>0 or (coalesce(td.totqty,0)-tippinginvoiced)>0 or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0)) and d.rate=d.addrate and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 ";       
			}else if(type.equalsIgnoreCase("7")){           
				sqltest+=" and ((chargedtrip-invoicetrip)>0 or (coalesce(td.totqty,0)-tippinginvoiced)>0 or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0)) and r1.name='TRIP BASIS' and coalesce(td.hazrdous,0)=0 and m.billingmethod!=3 ";       
			}else if(type.equalsIgnoreCase("8")){  
				sqltest+=" and ((chargedtrip-invoicetrip)>0 or (coalesce(td.totqty,0)-tippinginvoiced)>0 or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0)) and m.billingmethod=3 and coalesce(td.hazrdous,0)=0  ";       
			}else if(type.equalsIgnoreCase("9")){      
				sqltest+=" and m.advinvmethod=0  and r1.name='RENT' and t.executedtrip>t.tottrips  and ((chargedtrip-invoicetrip)>0 or (coalesce(td.totqty,0)-tippinginvoiced)>0 or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0))  and d.rate!=d.addrate and coalesce(td.hazrdous,0)=0 ";       
			}else if(type.equalsIgnoreCase("10")){    
				sqltest+=" and coalesce(td.hazrdous,0)>0 and coalesce(td.totrate,0)>0 and ((chargedtrip-invoicetrip)>0 or (coalesce(td.totqty,0)-tippinginvoiced)>0 or ((coalesce(td.totqty,0)-gateinvoiced)>0 and d.gatefee>0)) ";       
			}else {
				sqltest="";   
			}    
			
			strsql="select a.*,if('"+type+"'=1,0,coalesce(rpcrate*totaltrips,0)) rpctotal,if('"+type+"'=1,0,if(totaltrips2>0,coalesce(tiptotal,0),0)) tftotal,if('"+type+"'=1,0,coalesce(gfrate*totaltrips3,0)) gftotal,if('"+type+"'=1,0,coalesce(rpcrate*totaltrips,0)+if(totaltrips2>0,coalesce(tiptotal,0),0)+coalesce(gfrate*totaltrips3,0)) nettotal from(select td.tiptotal,td.hazrdous,td.dno,td.totrate tfrate,if('"+type+"'=9,d.addrate,d.rate) rpcrate, d.gatefee gfrate,m.advinvvalue,r3.tripsinmonth,d.nos,d.scheduledays,invoicetrip,if((coalesce(td.totqty,0)-tippinginvoiced)>0,round((coalesce(td.totqty,0)-tippinginvoiced),0),0) totaltrips2,if((coalesce(td.totqty,0)-gateinvoiced)>0,round((coalesce(td.totqty,0)-gateinvoiced),0),0) totaltrips3,round((chargedtrip-invoicetrip),0) totaltrips,(chargedtrip-invoicetrip) chargedtrip,tottrips, executedtrip, s.site,d.siteid,ac.refname,m.cldocno,t.srno rowno,m.tr_no,m.doc_no,m.date,d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype,m.brhid,coalesce(m.mergedinvoice,'') mergedinvoice,m.manualinv,m.remarks,m.refno,coalesce(a1.name,'') groupcompanies,if(m.witheffect='"+sqltodate+"',1,0) datval from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d on d.rowno=t.contdetno left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumptype ds on ds.doc_no=d.wastetype left join sk_srvcsited s on s.rowno=d.siteid left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join gl_enqm em on em.doc_no=m.refdocno left join sk_clgroup a1 on if(ac.grpcmp=0,em.grpcmpid,ac.grpcmp)=a1.docno left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') left join sk_enqrelated r1 on r1.srno=d.ctypeid and r1.type='CTYPE' left join (select group_concat(dt.dno ,' ' ) dno,sum(if(dt.wasteid=1 or dt.wasteid=6,1,0)) hazrdous,sum(if('"+type+"'=10,if(dt.wasteid=1 or dt.wasteid=6,coalesce(coalesce(price,0)/coalesce(weight,0),0),if(dt.wasteid=dd.wastetype,dd.tippingfee,dt.rate)),if(dt.wasteid=dd.wastetype,dd.tippingfee,dt.rate))) totrate,sum(coalesce(dt.qty,0)) totqty,dt.totsrno,sum(if(dt.wasteid=1 or dt.wasteid=6,coalesce(price,0),dt.qty*dt.rate)) tiptotal from sk_tippingdet dt left join sk_srvcontrdet dd on dd.rdocno=dt.contno and dd.rowno=dt.contdet group by dt.totsrno) td on td.totsrno=t.srno where m.status not in (6,7,8) and month('"+sqltodate+"')=month and year('"+sqltodate+"')=year "+sqlfilters+" "+sqltest+" ORDER BY M.DOC_NO)a";
			System.out.println("Main Grid= "+strsql);                           
			ResultSet rs=conn.createStatement().executeQuery(strsql);
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

	 public JSONArray clentdetails() throws SQLException {

	        JSONArray RESULTDATA=new JSONArray();
	        
	        Connection conn =null;
	        try {
				 conn = objconn.getMyConnection();
				 Statement stmtVeh = conn.createStatement ();
				
				String sql="select cldocno,refname from my_acbook where status=3 and dtype='CRM'";  
				 ResultSet resultSet = stmtVeh.executeQuery(sql);
	        	
				RESULTDATA=objcommon.convertToJSON(resultSet);  
	 			
				stmtVeh.close();
	 			conn.close();
	       
		} catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 public int insert(Date sqlStartDate, HttpSession session, HttpServletRequest request, String rowno, String type, String servchargechk, String tippingfeechk, String gatefeechk) throws SQLException {       
		 try{      
			int docno=0;  
			conn=objconn.getMyConnection(); 
			Statement stmt =conn.createStatement();  
			Statement stmt2 =conn.createStatement();
			Statement stmttip =conn.createStatement(); 
			ArrayList<String> invoiceList=new ArrayList<String>();  
			conn.setAutoCommit(false);        
			//System.out.println("===IN INV===");  
			String strsql="",descsql1="",descsql2="",doctype="SINV";  
			int cnt=0,advinvmethod=0;  
			String strsql1="select msg from sk_msgsettings where dtype='SINV' and status=3";  
			ResultSet rs1=stmt.executeQuery(strsql1);      
			while(rs1.next()) {
				descsql1=rs1.getString("msg");    
			}
			String invno="0",tripsrno="0",drowno="",description="",cldocno="0",tr_no="0",doc_no="0",periodfrom="",periodto="",rpcacno="0",tfacno="0",gfacno="0",rpcdesc="",tfdesc="",gfdesc="",vocnos="";
			Double rpcrate2=0.0,rpctax=0.0,tftax=0.0,gftax=0.0,rpcrate=0.0,tfrate=0.0,gfrate=0.0,rpctotal=0.0,tftotal=0.0,gftotal=0.0,rpctaxper=0.0,tftaxper=0.0,gftaxper=0.0,rpctaxamt=0.0,tftaxamt=0.0,gftaxamt=0.0,rpcnet=0.0,tfnet=0.0,gfnet=0.0,tottrips=0.0,executedtrip=0.0,chargeabletrips=0.0,invoicedtrips=0.0;
			double qty=0,qty2=0,qty3=0;  
			int skipsizeid=0, siteid=0, atsiteqty=0;       
			strsql="select a.*,round(coalesce(rpcrate*qty,0),2) rpctotal,round(coalesce(tfrate*qty2,0),2) tftotal,round(coalesce(gfrate*qty3,0),2) gftotal, if(rpctax=1,5,0) rpctaxper,if(tftax=1,5,0) tftaxper,if(gftax=1,5,0) gftaxper,round(if(rpctax=1,(5*coalesce(rpcrate*qty,0))/100,0),2) rpctaxamt,round(if(tftax=1,(5*coalesce(tfrate*qty2,0))/100,0),2) tftaxamt,round(if(gftax=1,(5*coalesce(gfrate*qty3,0))/100,0),2) gftaxamt,round(if(rpctax=1,(5*coalesce(rpcrate*qty,0))/100,0)+coalesce(rpcrate*qty,0),2) rpcnet,round(if(tftax=1,(5*coalesce(tfrate*qty2,0))/100,0)+coalesce(tfrate*qty2,0),2) tfnet,round(if(gftax=1,(5*coalesce(gfrate*qty3,0))/100,0)+coalesce(gfrate*qty3,0),2) gfnet from(select d.skiptype, d.siteid, coalesce(dd.skipatsiteqty,0) skipatsiteqty, t.srno,d.rowno,m.cldocno,m.tr_no, m.doc_no, DATE_FORMAT(concat(t.year,'-',t.month,'-01'),'%d.%m.%Y') periodfrom, DATE_FORMAT(LAST_DAY(concat(t.year,'-',t.month,'-01')),'%d.%m.%Y') periodto, (select acno from sk_invmode where idno=1) rpcacno, (select tax from sk_invmode where idno=1) rpctax, (select acno from sk_invmode where idno=2) tfacno, (select tax from sk_invmode where idno=2) tftax,(select acno from sk_invmode where idno=3) gfacno, (select tax from sk_invmode where idno=3) gftax,(select description from sk_invmode where idno=1) rpcdesc,(select description from sk_invmode where idno=2) tfdesc,(select description from sk_invmode where idno=3) gfdesc, (chargedtrip-invoicetrip) qty,(chargedtrip-tippinginvoiced) qty2,(chargedtrip-gateinvoiced) qty3, d.addrate rpcrate2,d.rate rpcrate, d.tippingfee tfrate, d.gatefee gfrate,t.tottrips, t.executedtrip, t.chargedtrip,t.invoicetrip,m.advinvmethod from sk_triptotal t inner join sk_srvcontrm m on m.tr_no=t.contractno inner join sk_srvcontrdet d on d.rowno=t.contdetno left join (select count(*) skipatsiteqty, rdocno, srno from sk_srvcontrdel del where type='N' group by del.rdocno,del.srno) dd on dd.rdocno=t.contractno left join sk_enqrelated r3 on (r3.srno=d.servicetermid and r3.type='SCHEDULE') where m.status not in (6,7,8) and t.srno in ("+rowno.substring(0, rowno.length()-1)+") order by m.tr_no)a";
			//System.out.println("strsql==="+strsql);                                     
			ResultSet rs=stmt.executeQuery(strsql);           
			while(rs.next()) {  
				cnt++;
				advinvmethod=rs.getInt("advinvmethod");  
				invoicedtrips=rs.getDouble("invoicetrip");   
				chargeabletrips=rs.getDouble("chargedtrip");  
				executedtrip=rs.getDouble("executedtrip");     
				tottrips=rs.getDouble("tottrips");  
				tripsrno=rs.getString("srno");   
				drowno=rs.getString("rowno");
				rpcdesc=rs.getString("rpcdesc");
				tfdesc=rs.getString("tfdesc");
				gfdesc=rs.getString("gfdesc");  
				cldocno=rs.getString("cldocno");
				tr_no=rs.getString("tr_no");
				doc_no=rs.getString("doc_no");
				periodfrom=rs.getString("periodfrom");  
				periodto=rs.getString("periodto");
				rpcacno=rs.getString("rpcacno");
				tfacno=rs.getString("tfacno");
				gfacno=rs.getString("gfacno");
				qty=rs.getDouble("qty");  
				qty2=rs.getDouble("qty2");   
				qty3=rs.getDouble("qty3");   
				rpctax=rs.getDouble("rpctax");
				tftax=rs.getDouble("tftax");
				gftax=rs.getDouble("gftax");
				rpcrate=rs.getDouble("rpcrate");
				rpcrate2=rs.getDouble("rpcrate2");  
				tfrate=rs.getDouble("tfrate");
				gfrate=rs.getDouble("gfrate");
				rpctotal=rs.getDouble("rpctotal");
				tftotal=rs.getDouble("tftotal");
				gftotal=rs.getDouble("gftotal");
				rpctaxper=rs.getDouble("rpctaxper");
				tftaxper=rs.getDouble("tftaxper");
				gftaxper=rs.getDouble("gftaxper");
				rpctaxamt=rs.getDouble("rpctaxamt");
				tftaxamt=rs.getDouble("tftaxamt");
				gftaxamt=rs.getDouble("gftaxamt");
				rpcnet=rs.getDouble("rpcnet");
				tfnet=rs.getDouble("tfnet");
				gfnet=rs.getDouble("gfnet");   
				
				skipsizeid = rs.getInt("skiptype");  
				siteid = rs.getInt("siteid");   
				atsiteqty = rs.getInt("skipatsiteqty");                
				
				java.sql.Date sqlperiodfrom=objcommon.changeStringtoSqlDate(periodfrom);  
				java.sql.Date sqlperiodto=objcommon.changeStringtoSqlDate(periodto);
				
				if(!descsql1.equalsIgnoreCase("")) {
					descsql2=descsql1.replace("documentno",drowno); 
					//System.out.println("descsql2="+descsql2);
					ResultSet rs2=stmt2.executeQuery(descsql2);      
					while(rs2.next()) {
						description=rs2.getString("remarks");     
					}
				}    
				
				if(servchargechk.equalsIgnoreCase("1")) {
					    int seridno = 1;   
						if(type.equalsIgnoreCase("7")) {   // trip based  
							rpcdesc="WASTE COLLECTION CHARGES";  
							seridno = 1;   
						}else if(advinvmethod==1) {
							rpcdesc="ADDITIONAL WASTE COLLECTION CHARGES"; 
							seridno = 8;   
						}else {
							//(advinvmethod==0 && (type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4") || type.equalsIgnoreCase("5"))) {
							rpcdesc="SKIP RENTAL CHARGES";  
							seridno = 9;      
						} 
						double sqty=0.0;
						if(executedtrip>tottrips) {  
							double sctotal1=0.0,sctotal2=0.0,sctaxamt1=0.0,sctaxamt2=0.0,scnet1=0.0,scnet2=0.0;
							String servdesc="";
							sctotal1=objcommon.sqlRound((tottrips-invoicedtrips)*rpcrate,2);
							sctaxamt1=objcommon.sqlRound((5*((tottrips-invoicedtrips)*rpcrate))/100,2);
							scnet1=objcommon.sqlRound(sctotal1+sctaxamt1,2);  
							if((tottrips-invoicedtrips)>0) {         
								invoiceList.add(seridno+" :: "+rpcacno+" :: "+rpcdesc+" :: "+(tottrips-invoicedtrips)+" :: "+rpcrate+" :: "+sctotal1+" :: "+rpctaxper+" :: "+sctaxamt1+" :: "+scnet1+" :: "+0);
								sqty+=(tottrips-invoicedtrips);
							}
							//servdesc=rpcdesc+" - Extra"; 
							servdesc="ADDITIONAL WASTE COLLECTION CHARGES";
							seridno = 8;   
							if(type.equalsIgnoreCase("9")) {
								rpcrate=rpcrate2;  
							}
							sctotal2=objcommon.sqlRound((executedtrip-tottrips)*rpcrate,2);
							sctaxamt2=objcommon.sqlRound((5*((executedtrip-tottrips)*rpcrate))/100,2);
							scnet2=objcommon.sqlRound(sctotal2+sctaxamt2,2);      
							invoiceList.add(seridno+" :: "+rpcacno+" :: "+servdesc+" :: "+(executedtrip-tottrips)+" :: "+rpcrate+" :: "+sctotal2+" :: "+rpctaxper+" :: "+sctaxamt2+" :: "+scnet2+" :: "+0);
							sqty+=(executedtrip-tottrips);     
						}else {
							invoiceList.add(seridno+" :: "+rpcacno+" :: "+rpcdesc+" :: "+qty+" :: "+rpcrate+" :: "+rpctotal+" :: "+rpctaxper+" :: "+rpctaxamt+" :: "+rpcnet+" :: "+0);
							sqty=qty;
						}
						qty=sqty;    
					}
					if(tippingfeechk.equalsIgnoreCase("1")) {  
						doctype="SINT"; 
						double tqty=0.0,balanceqty=qty2;      
						String sqltip ="select coalesce(dt.name,'') wastetype,sum(if("+type+"=10,if(t.wasteid=1 or t.wasteid=6,coalesce(t.weight,0),coalesce(t.qty,0)),coalesce(t.qty,0))) qty,if("+type+"=10,if(t.wasteid=1 or t.wasteid=6,coalesce(sum(t.price)/sum(t.weight),0),coalesce(if(t.wasteid=dd.wastetype,dd.tippingfee,t.rate),0)),coalesce(if(t.wasteid=dd.wastetype,dd.tippingfee,t.rate),0)) rate from sk_tippingdet t left join sk_dumptype dt on dt.doc_no = t.wasteid left join sk_srvcontrdet dd on dd.rdocno=t.contno and dd.rowno=t.contdet WHERE TOTSRNO="+tripsrno+" group by t.wasteid order by t.wasteid,t.skipsizeid";
						ResultSet rstip=stmttip.executeQuery(sqltip);                    
						while(rstip.next()) {  
							//tqty+=rstip.getInt("qty");  
							double tripsqty=0.0,tripsrate=0.0,available=0.0,actualqty=0.0,tripstotal=0.0,tripstaxtotal=0.0,tripsnettotal=0.0;
							tripsqty=rstip.getDouble("qty");
							tripsrate=rstip.getDouble("rate");  
							available=balanceqty-tripsqty;  
							
							if(available<0) {
								actualqty=balanceqty; 
								balanceqty=0.0;
							}else if(available>0) {
								actualqty=tripsqty; 
								balanceqty=available;
							}else {
								actualqty=tripsqty;  
								balanceqty=0.0;
							}
							
							if(actualqty>0) {  
								tripstotal=objcommon.sqlRound(actualqty*tripsrate,2);
								tripstaxtotal=objcommon.sqlRound((5*(actualqty*tripsrate))/100,2);
								tripsnettotal=objcommon.sqlRound((105*(actualqty*tripsrate))/100,2);
								//tripstaxtotal=objcommon.sqlRound((actualqty*tripsrate)*0.05,2);  // commented on 2024-05-03 bcuz of point value difference in jv entries
								//tripsnettotal=objcommon.sqlRound((actualqty*tripsrate)*1.05,2);   
								invoiceList.add(2+" :: "+tfacno+" :: "+(tfdesc+" "+rstip.getString("wastetype"))+" :: "+actualqty+" :: "+rstip.getString("rate")+" :: "+tripstotal+" :: 5 :: "+tripstaxtotal+" :: "+tripsnettotal+" :: "+0);  
							}
							tqty+=actualqty;    
						}
						qty2=tqty;   
					}
					if(gatefeechk.equalsIgnoreCase("1")) {   
						invoiceList.add(3+" :: "+gfacno+" :: "+gfdesc+" :: "+qty2+" :: "+gfrate+" :: "+objcommon.sqlRound(qty2*gfrate,2)+" :: "+gftaxper+" :: "+objcommon.sqlRound((qty2*gfrate)*0.05,2)+" :: "+objcommon.sqlRound((qty2*gfrate)*1.05,2)+" :: "+0);
					}
				
				docno=InvoiceDAO.insert(conn, sqlStartDate,sqlperiodfrom,sqlperiodto, "AMC", tr_no, cldocno, description, description, invoiceList, session, "A", doctype, request,"");    
				if(docno>0) {
					String upsql3="update sk_srvcontrm set invoiced=1 where tr_no='"+tr_no+"'";         
					stmt2.executeUpdate(upsql3);
					
					String upsqls1="update sk_invm set manual=1, skiptype='"+skipsizeid+"', siteid='"+siteid+"', atsiteqty='"+atsiteqty+"' where doc_no='"+docno+"'";        
					stmt2.executeUpdate(upsqls1);   
					
						if(servchargechk.equalsIgnoreCase("1")) {   
							String upsql2="update sk_triptotal set invoicetrip=invoicetrip+"+qty+",manual=1 where srno='"+tripsrno+"'";          
							stmt2.executeUpdate(upsql2);
						}
						if(tippingfeechk.equalsIgnoreCase("1")) {
							String upsql2="update sk_triptotal set tippinginvoiced=tippinginvoiced+"+qty2+",manual=1 where srno='"+tripsrno+"'";           
							stmt2.executeUpdate(upsql2);
							//System.out.println("type  ==="+upsql2);
							String upsql12="update sk_tippingdet set invno="+docno+" where totsrno='"+tripsrno+"'";          
							stmt2.executeUpdate(upsql12);
							//System.out.println("type  ==="+upsql12);
						}
						if(gatefeechk.equalsIgnoreCase("1")) {  
							String upsql2="update sk_triptotal set gateinvoiced=gateinvoiced+"+qty3+",manual=1 where srno='"+tripsrno+"'";             
							stmt2.executeUpdate(upsql2);
						}
				}        
				
				if (docno <= 0) {  
					stmt.close();  
					conn.close();
					return 0;
				} 
				if(cnt==1){
				vocnos=vocnos+request.getAttribute("vocno").toString()+", ";
				}
				invno=request.getAttribute("vocno").toString();
				invoiceList=new ArrayList<String>();    
			}  
			if(cnt>1){
				vocnos=vocnos+"-"+invno;
				}
			request.setAttribute("vocnos", vocnos); 
			if (docno > 0) {
				conn.commit();
				stmt.close();  
				conn.close();
				return 1; 
			}
		}catch(Exception e){	
			e.printStackTrace();
			conn.close();	
		}
		return 0;
	}
	 
	 public int getTotalTrips(String date,String enddate,String noofvisit,String serviceterm,int days,String rowno,String brhid,String srno,String scheduledays) throws SQLException {               
		 int val=0,invoiced=0,tottrips=0;     
		 try{	
		 	conn= objconn.getMyConnection();      
		 	Statement stmtmain = conn.createStatement ();     
		 	java.sql.Date xdate=null;
		 	java.sql.Date fdate=null;
		 	java.sql.Date endsdate=null;
		     String day="",dates="";
		 	int xsrno=0;
		 	date.trim();

		 	if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		 		xdate = objcommon.changeStringtoSqlDate(date);
		 		fdate = objcommon.changeStringtoSqlDate(date);  
		 	}

		 	enddate.trim();
		 	if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
		 		endsdate = objcommon.changeStringtoSqlDate(enddate);
		 	}
		 	//System.out.println(xdate+"=="+endsdate);
		 	String xsql="";

		 	Statement stmt = conn.createStatement();  
		 	Statement stmt2 = conn.createStatement();  
		     int duelen=0;
		     String type=serviceterm.equalsIgnoreCase("DAILY")?" Day ":serviceterm.equalsIgnoreCase("MONTHLY")?" Month ":serviceterm.equalsIgnoreCase("WEEKLY")?" Week ":" Day "; 
		 	String strsql1="SELECT TIMESTAMPDIFF("+type+", '"+fdate+"', '"+endsdate+"') duelen";   
		 	//System.out.println("strsql1==="+strsql1);
		 	ResultSet rs1 = stmt.executeQuery(strsql1);  
		 	while(rs1.next()) {
		 		duelen=rs1.getInt("duelen");
		 	}
		 	//System.out.println("days==="+days); 
		 	if(!serviceterm.equalsIgnoreCase("MONTHLY")){
		 	do							
		 	{	
		 		if (Integer.parseInt(noofvisit)>0 && xsrno>duelen) break;
		 		if(xsrno>duelen) break; 
		 		if(days!=0) {    
		 	    String sqltst="";   
		 	    if(days!=8) {   
		 		 	sqltst=" AND DAYOFWEEK(DATE) in("+days+")";  
		 	    }
		 	    int alternative=0,weekly=0, interval=0,month=0;
		 	    String sql="SELECT  * FROM (SELECT  if(convert(n4.num*1000+n3.num*100+n2.num*10+n1.num ,UNSIGNED)%2,1,0) alternative,if(convert(n4.num*1000+n3.num*100+n2.num*10+n1.num ,UNSIGNED)%7,1,0) weekly,DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
		 	    //System.out.println("sql="+sql);      
		 	    ResultSet rs = stmt.executeQuery(sql);
		 	    while(rs.next()) {
		 		xdate=rs.getDate("date");  
		 		alternative=rs.getInt("alternative");
		 		weekly=rs.getInt("weekly"); 
		 		if(!(xdate==null) || !(endsdate.after(xdate))){
		 			String sql1="";
		 			
		 			sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, 0 month";  
		 			//System.out.println("sql1="+sql1);    
		 	                ResultSet rs2 = stmt2.executeQuery(sql1);
		 			if(rs2.next()) {
		 				day=rs2.getString("day"); 
		 				dates=rs2.getString("date"); 
		 				month=rs2.getInt("month");
		 				if(month==1){interval++;}
		 			}
		 			//System.out.println(serviceterm+"alternative : "+alternative +" day : "+day+" scheduledays: "+scheduledays);
		 						if (serviceterm.equalsIgnoreCase("DAILY")
		 								|| (serviceterm.equalsIgnoreCase("ALTERNATIVE") && alternative == 0)
		 								|| (serviceterm.equalsIgnoreCase("WEEKLY") && scheduledays.equalsIgnoreCase("1") && weekly == 0)
		 								|| (serviceterm.equalsIgnoreCase("WEEKLY") && scheduledays.equalsIgnoreCase("4") && (day.equalsIgnoreCase("Monday")||day.equalsIgnoreCase("Tuesday")||day.equalsIgnoreCase("Thursday")||day.equalsIgnoreCase("Saturday")))
		 								|| (serviceterm.equalsIgnoreCase("Daily (Except Holiday)") && (!day.equalsIgnoreCase("Sunday")))
		 							//	|| (serviceterm.equalsIgnoreCase("MONTHLY") && scheduledays.equalsIgnoreCase("26") && (!day.equalsIgnoreCase("Sunday")))
		 								) {
		 							        tottrips++;         
		 									}
		 								}
		 							}
		 							rs.close();  
		 							break;
		 						}
		 						xsrno++;
		 					} while (true);
		 					// System.out.println();
		 	} else if (serviceterm.equalsIgnoreCase("MONTHLY")) {
		 					String sqlmon="";
		 					Date sqldate=fdate;
		 					int end=0;
		 					if(scheduledays.equalsIgnoreCase("1")){
		 					do{
		 						//System.out.println(xdate+"===="+endsdate+"===="+sqldate+"============="+endsdate.after(sqldate));
		 					if(!(xdate==null) || !(endsdate.after(sqldate))){
		 					
		 				
		 					if(endsdate.before(sqldate)){
		 						end=1;
		 						break;
		 					}else{
		 						 tottrips++;      
		 					}
		 					if(scheduledays.equalsIgnoreCase("1")){
		 						sqlmon=" select date_add('"+fdate+"' , interval 1 month) calcdate , DAYNAME('"+xdate+"') day; ";
		 					}
		 					
		 					ResultSet rsmon=stmt.executeQuery(sqlmon);
		 					while(rsmon.next()){
		 						sqldate=rsmon.getDate("calcdate");
		 						day=rsmon.getString("day");
		 					}
		 					fdate=sqldate;
		 					}} while(end==0);
		 	}else{
		 					do{
		 						int cnt=0,diff=0,noofdays=Integer.parseInt(scheduledays);
		 						TreeMap<Date,String> s = new TreeMap<Date, String>();
		 						do{
		 						sqlmon=" SELECT last_day('"+fdate+"') - INTERVAL FLOOR(RAND() * datediff(last_day('"+fdate+"'),'"+fdate+"')+1) day calcdate ," 
		 								+" dayname(last_day('"+fdate+"') - INTERVAL FLOOR(RAND() * datediff(last_day('"+fdate+"'),'"+fdate+"')) day) DAY , datediff(last_day('"+fdate+"'),'"+fdate+"')+1 diff "  ;
		 						//System.out.println("=="+sqlmon);
		 						ResultSet rsmon=stmt.executeQuery(sqlmon);
		 						while(rsmon.next()){
		 							sqldate=rsmon.getDate("calcdate");
		 							//day=rsmon.getString("day");
		 							diff=rsmon.getInt("diff");
		 							s.put(rsmon.getDate("calcdate"),day);
		 							cnt=s.size();
		 							if(diff<=noofdays){
			 							cnt=diff;
			 							tottrips=diff;
			 							s = new TreeMap<Date, String>();
		 							}    
		 						} 
		 						//System.out.println(noofdays+"=="+diff+"=="+s.size()+"===="+s);
		 						//System.out.println(diff+"=="+cnt+"=="+noofdays+"===="+s.size());    
		 						}while(diff>cnt && noofdays>s.size());
		 						
		 						 for (Map.Entry<Date,String> entry : s.entrySet()){
		 							 tottrips++;        
		 						 }
		 							
		 						 sqlmon=" select date_add(last_day('"+fdate+"') , interval 1 day) calcdate  ";
		 							ResultSet rsmon=stmt.executeQuery(sqlmon);
		 							while(rsmon.next()){
		 								fdate=rsmon.getDate("calcdate");
		 							}
		 					         
		 					}while(endsdate.after(fdate));  
		 					}
		 		}
			 	if(tottrips>0) {   
					conn.close();
					return tottrips;
				}    
		 		stmtmain.close();
		 		conn.close();

		 	} catch (Exception e) {
		 		e.printStackTrace();
		 		conn.close();
		 	}finally {
 				conn.close();
 			}
		 	return tottrips;  
     } 
	 
	 public int getTotalTrips(String date, String enddate, String noofvisit, String serviceterm, String days) throws SQLException {   
		 int totaltrips = 0;  
		 Connection conn = null; 
			try {
				java.sql.Date xdate=null;
				java.sql.Date fdate=null;
				java.sql.Date endsdate=null;
	            String day="",dates="";
				int xsrno=0;
				date.trim();
				 
				if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
					xdate = objcommon.changeStringtoSqlDate(date);
					fdate = objcommon.changeStringtoSqlDate(date);  
				}

				enddate.trim();
				if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
					endsdate = objcommon.changeStringtoSqlDate(enddate);
				}

				String xsql="";

				conn = objconn.getMyConnection();
				Statement stmt = conn.createStatement();  
				Statement stmt2 = conn.createStatement();  
	            int duelen=0;
	            //System.out.println("serviceterm="+serviceterm);
	            String type=serviceterm.equalsIgnoreCase("DAILY")?" Day ":serviceterm.equalsIgnoreCase("MONTHLY")?" Month ":serviceterm.equalsIgnoreCase("WEEKLY")?" Week ":" Day "; 
				String strsql1="SELECT TIMESTAMPDIFF("+type+", '"+fdate+"', '"+endsdate+"') duelen";   
				//System.out.println("strsql1==="+strsql1);   
				ResultSet rs1 = stmt.executeQuery(strsql1);  
				while(rs1.next()) {
					duelen=rs1.getInt("duelen");
				}
				if(serviceterm.equalsIgnoreCase("ALTERNATIVE")) {
					duelen=duelen/2; 
					xsql=2 + type;
				}else {
					xsql=1 + type;
				}
				//System.out.println(days+"=days===serviceterm="+serviceterm); 
				//System.out.println("noofvisit="+noofvisit);
				int t2=0,a1=0,a2=1,a3=0;
				t2=Integer.parseInt(noofvisit);  
				do							
				{	
					if (Integer.parseInt(noofvisit)>0 && xsrno>duelen) break;

					 
					if(xsrno>duelen) break; 
					
					if(serviceterm.equalsIgnoreCase("DAILY")) {                
						//System.out.println("=IN 1=");  
						int t1=1;    
						String sqltst="";   
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							xdate=rs.getDate("date");  
							while(!(xdate==null) || !(endsdate.after(xdate))){ 
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";        
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
								}
								if(t1 <= t2) {      
									totaltrips++;
									t1++;  
								}else { 
									t1 = 1;
									break;
								}
							}
						}
						rs.close();
						break;   
					}else if(serviceterm.equalsIgnoreCase("MONTHLY")) {     
						//System.out.println("=IN 2=");   
						int t1=0,t3=0,m1=0,m2=0;   
						String sqltst="";   
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							t1++;
							xdate=rs.getDate("date");  
							if(!(xdate==null) || !(endsdate.after(xdate))){
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, month('"+xdate+"') m1";        
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									m1 = rs2.getInt("m1");
								}
								if((m1 == m2) && (t1 <= t2)) {      
									totaltrips++;
								}else if(m1 != m2) {
									t1 = 1;
									totaltrips++;
								}else { 
								}
								m2=m1;
							}
						}
						rs.close();
						break;
					}else if(serviceterm.equalsIgnoreCase("WEEKLY")) {      
						//System.out.println("=IN 3=");      
						int t1=0,t3=0,m1=0,m2=0,w1=0,w2=2;                 
						String sqltst="";   
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							t1++;
							xdate=rs.getDate("date");  
							if(!(xdate==null) || !(endsdate.after(xdate))){
								String sql1="Select DAYNAME('"+xdate+"') day, date_format('"+xdate+"','%d.%m.%Y') date, DAYOFWEEK('"+xdate+"') w1";           
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									w1 = rs2.getInt("w1");     
								}
								if(w1 == w2) {   
									t1 = 1;
									totaltrips++;
								}else if((w1 != w2) && (t1 <= t2)) {   
									totaltrips++;
								}else { 
									 
								}
							}
						}
						rs.close();
						break;
					}else if(serviceterm.equalsIgnoreCase("Daily (Except Holiday)")) {                
						//System.out.println("=IN 1=");  
						int t1=1,t3=1,d1=0;      
						String sqltst="";   
						String sql="select date, dayname(date) dayname from(SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE)a where dayname(date)!='Sunday'";   
					    //System.out.println("sql="+sql);        
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							xdate=rs.getDate("date");  
							while(!(xdate==null) || !(endsdate.after(xdate))){ 
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, DAYOFWEEK('"+xdate+"') d1";         
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									d1 = rs2.getInt("d1"); 
								}
								if(t1 <= t2) { 
									if(t3 == 1) {
										totaltrips++;
										t1++;
									}else if(d1 != 1) {
										totaltrips++;
										t1++;
									}else {
										t1++;
									}
								}else { 
									t1 = 1;
									break;
								}
							}
						}
						rs.close();
						break;   
					}else if(serviceterm.equalsIgnoreCase("ALTERNATIVE")){     
						//System.out.println("=IN 4="); 
						while(!(xdate==null) || !(endsdate.after(xdate))){
							//System.out.println("=a2="+a2);   
							String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, month('"+xdate+"') a1";       
							//System.out.println("sql1="+sql1);    
			                ResultSet rs2 = stmt2.executeQuery(sql1);
							if(rs2.next()) {
								day=rs2.getString("day"); 
								dates=rs2.getString("date"); 
								a1 = rs2.getInt("a1");     
							}
							if((a1 == a3) && (a2 <= t2)) {         
								totaltrips++;
							}else if(a1 != a3) {  
								a2=1;   
								totaltrips++;
							}else {
								a2=1;   
								break;
							}
							a2++; 
							a3 = a1; 
						}
						String sql="Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(noofvisit)+",'-',day('"+xdate+"')))) fdate";
						//System.out.println("sql="+sql);          
		                ResultSet rs = stmt.executeQuery(sql);
						if(rs.next()) xdate=rs.getDate("fdate");     
						rs.close(); 
					}
					xsrno++;
				}while(true); 
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return totaltrips;
     } 
} 
