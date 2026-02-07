package com.dashboard.procurment.intercompinventorymgmt;

import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import java.sql.Connection;
import java.sql.ResultSet;

import net.sf.json.JSONArray;

public class ClsInterCompInventoryMgmtDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	
	public JSONArray getPurchaseOrderData(String id,String uptodate) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqluptodate=null;
			if(!uptodate.trim().equalsIgnoreCase("")) {
				sqluptodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			String sqlfilters="";
			if(sqluptodate!=null) {
				sqlfilters+=" and m.date<='"+sqluptodate+"'";
			}
			String strsql="SELECT m.brhid,br.branchname branch,d.rowno detrowno,m1.psrno,m.doc_no,m.voc_no,m.date,m.refno,m.rdtype reftype,m.rrefno refvocno,ac.refname,ac.cldocno,m.description,CASE WHEN m.billtype=1 THEN 'VAT' \r\n" + 
					" WHEN m.billtype=2 THEN 'RCM' ELSE '' END billtype,m1.part_no product,m1.productname,u.unit,d.qty,d.out_qty outqty,(d.qty-d.out_qty) balqty,d.interOutQty interoutqty,(d.qty-d.interOutQty) interbalqty,d.amount unitprice,d.nettotal total,d.taxamount,d.nettaxamount taxtotal FROM my_ordm m \r\n" + 
					" LEFT JOIN my_ordd d ON m.tr_no=d.tr_no\r\n" + 
					" LEFT JOIN my_main m1 ON d.psrno=m1.psrno\r\n" + 
					" LEFT JOIN my_acbook ac ON m.cldocno=ac.cldocno AND ac.dtype='VND'\r\n" + 
					" LEFT JOIN my_unitm u ON d.unitid=u.doc_no\r\n" + 
					" left join my_comp cmp on m.cmpid=cmp.doc_no"+
					" left join my_brch br on m.brhid=br.doc_no"+
					" WHERE m.status=3  and (d.qty-d.out_qty>0 or d.qty-d.interOutQty>0)  "+sqlfilters+" order by m.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getSalesOrderData(String id,String uptodate) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqluptodate=null;
			if(!uptodate.trim().equalsIgnoreCase("")) {
				sqluptodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			String sqlfilters="";
			if(sqluptodate!=null) {
				sqlfilters+=" and m.date<='"+sqluptodate+"'";
			}
			String strsql="SELECT m.brhid,br.branchname branch,d.doc_no detrowno,m1.psrno,m.doc_no,m.voc_no,m.date,m.refno,m.ref_type reftype,m.rrefno refvocno,ac.refname,ac.cldocno,m.description,CASE WHEN m.billtype=1 THEN 'VAT' \r\n" + 
					" WHEN m.billtype=2 THEN 'RCM' ELSE '' END billtype,m1.part_no product,m1.productname,u.unit,ROUND(d.qty,2) qty,ROUND(d.out_qty,2) outqty,\r\n" + 
					" ROUND((d.qty-d.out_qty),2) balqty,ROUND(d.amount,2) unitprice,ROUND((d.qty-d.out_qty)*d.amount,2) total,\r\n" + 
					" ROUND(CASE WHEN ac.tax>0 AND maxtax.per>0 THEN ((d.qty-d.out_qty)*d.amount)*(maxtax.per/100) ELSE 0 END,2) taxamount,\r\n" + 
					" ROUND(CASE WHEN ac.tax>0 AND maxtax.per>0 THEN ((d.qty-d.out_qty)*d.amount)*(maxtax.per/100)+(d.qty-d.out_qty)*d.amount ELSE (d.qty-d.out_qty)*d.amount END,2) taxtotal FROM my_sorderm m \r\n" + 
					" LEFT JOIN my_sorderd d ON m.tr_no=d.tr_no \r\n" + 
					" LEFT JOIN my_main m1 ON d.psrno=m1.psrno \r\n" + 
					" LEFT JOIN my_acbook ac ON m.cldocno=ac.cldocno AND ac.dtype='CRM' \r\n" + 
					" LEFT JOIN my_unitm u ON d.unitid=u.doc_no \r\n" + 
					" LEFT JOIN my_comp cmp ON m.cmpid=cmp.doc_no \r\n" + 
					" LEFT JOIN (SELECT COALESCE(tm.per,0) per,br.doc_no brhid FROM my_brch br LEFT JOIN gl_taxmaster tm ON br.prvdocno=tm.provid WHERE tm.type=2 AND '"+sqluptodate+"' BETWEEN tm.fromdate AND tm.todate GROUP BY br.doc_no) maxtax ON m.brhid=maxtax.brhid\r\n" + 
					" left join my_brch br on m.brhid=br.doc_no"+
					" WHERE m.status=3  AND d.qty-d.out_qty>0 "+sqlfilters+" order by m.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getGRNData(String id,String uptodate) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqluptodate=null;
			if(!uptodate.trim().equalsIgnoreCase("")) {
				sqluptodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			String sqlfilters="";
			if(sqluptodate!=null) {
				sqlfilters+=" and m.date<='"+sqluptodate+"'";
			}
			String strsql="SELECT m.brhid,br.branchname branch,d.rowno detrowno,m1.psrno,m.doc_no,m.voc_no,m.date,m.refno,m.rdtype reftype,m.rrefno refvocno,ac.refname,ac.cldocno,m.description,\r\n" + 
					"'' billtype,m1.part_no product,m1.productname,u.unit,ROUND(d.qty,2) qty,ROUND(d.out_qty,2) outqty,\r\n" + 
					" ROUND((d.qty-d.out_qty),2) balqty,ROUND(d.amount,2) unitprice,ROUND((d.qty-d.out_qty)*d.amount,2) total,\r\n" + 
					" ROUND((d.qty-d.out_qty)*d.amount,2) taxamount,ROUND((d.qty-d.out_qty)*d.amount,2) taxtotal FROM my_grnm m \r\n" + 
					"LEFT JOIN my_grnd d ON m.TR_NO=d.TR_NO \r\n" + 
					"LEFT JOIN my_main m1 ON d.psrno=m1.psrno \r\n" + 
					"LEFT JOIN my_acbook ac ON m.cldocno=ac.cldocno AND ac.dtype='VND' \r\n" + 
					"LEFT JOIN my_unitm u ON d.unitid=u.doc_no \r\n" + 
					"LEFT JOIN my_comp cmp ON m.cmpid=cmp.doc_no\r\n" + 
					" left join my_brch br on m.brhid=br.doc_no"+
					" WHERE m.status=3 AND d.qty-d.OUT_QTY>0 "+sqlfilters+" order by m.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	
	public JSONArray getDelNoteData(String id,String uptodate) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			java.sql.Date sqluptodate=null;
			if(!uptodate.trim().equalsIgnoreCase("")) {
				sqluptodate=objcommon.changeStringtoSqlDate(uptodate);
			}
			String sqlfilters="";
			if(sqluptodate!=null) {
				sqlfilters+=" and m.date<='"+sqluptodate+"'";
			}
			String strsql="SELECT m.brhid,br.branchname branch,d.doc_no detrowno,m1.psrno,m.doc_no,m.voc_no,m.date,m.refno,m.ref_type reftype,m.rrefno refvocno,ac.refname,ac.cldocno,m.description,m1.part_no product,m1.productname,u.unit,ROUND(d.qty,2) qty,ROUND(d.out_qty,2) outqty,\r\n" + 
					" ROUND((d.qty-d.out_qty),2) balqty FROM my_delm m \r\n" + 
					" LEFT JOIN my_deld d ON m.tr_no=d.tr_no \r\n" + 
					" LEFT JOIN my_main m1 ON d.psrno=m1.psrno \r\n" + 
					" LEFT JOIN my_acbook ac ON m.cldocno=ac.cldocno AND ac.dtype='CRM' \r\n" + 
					" LEFT JOIN my_unitm u ON d.unitid=u.doc_no \r\n" + 
					" LEFT JOIN my_comp cmp ON m.cmpid=cmp.doc_no \r\n" + 
					" left join my_brch br on m.brhid=br.doc_no"+
					" WHERE m.status=3  AND d.qty-d.out_qty>0 "+sqlfilters+" order by m.doc_no";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getModalPIVData(String cldocno,String detrowno,String brhid,String locid,String date,String billtype,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			java.sql.Date sqldate = null;
			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	     	{
				sqldate=objcommon.changeStringtoSqlDate(date);
	     	}
			
			int tax=0;
			String strtaxconfig="select method  from gl_prdconfig where field_nme='tax' ";
			ResultSet rstaxconfig=stmt.executeQuery(strtaxconfig); 
			if(rstaxconfig.next())
			{
				tax=rstaxconfig.getInt("method");
			}
			int acno=0;
			String strgetacno="select acno from my_acbook where cldocno="+cldocno+" and dtype='VND'";
			ResultSet rsacno=stmt.executeQuery(strgetacno);
			while(rsacno.next()) {
				acno=rsacno.getInt("acno");
			}
			int taxmethod=0;
			String sqltaxcheck="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+acno+"' ";
			ResultSet rstaxcheck=stmt.executeQuery(sqltaxcheck);
			if(rstaxcheck.next()){
				taxmethod=rstaxcheck.getInt("tax");
			}
			if(taxmethod!=1){
				tax=0;
			}
			
			String joinsql="",fsql="",outfsql="";
			if(tax>0)
			{
				if(Integer.parseInt(billtype)>0)
				{
					int prvdocno=0;
					String strprovince="select prvdocno from my_brch where doc_no="+brhid;
					ResultSet rsprovince=stmt.executeQuery(strprovince); 
					if(rsprovince.next())
					{
						prvdocno=rsprovince.getInt("prvdocno");
					}
					
					joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+billtype+",per,cstper)>0  group by typeid  ) t1 on t1.typeid=m.typeid";
					fsql=fsql+" case when 1="+billtype+"  then t1.per when 2="+billtype+"  then t1.cstper else 0 end as  'taxpercent' ,t1.taxdocno , ";
					outfsql=outfsql+ " taxper ,taxdocno, ";
				
					
				}
				
			}
			
			int multiqty=0;
			String strmultiqty="select method  from gl_prdconfig where field_nme='multiqty' ";
			ResultSet rsmultiqty=stmt.executeQuery(strmultiqty); 
			if(rsmultiqty.next()){
				multiqty=rsmultiqty.getInt("method");
			}
			
			String joinsqls1="";
			if(multiqty>0)
			{
				joinsqls1=",d.unitid,d.specno ";
			}
			
			String strsql=("select  "+fsql+" bd.brandname,'pro' checktype ,d.stockid,at.mspecno specid,m.part_no product,m.productname,"
			 		+ "m.part_no proid , "
						 		+ "  m.productname proname,d.sr_no,d.psrno,d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty, "
						 		+ " sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty,sum(d.qty-d.out_qty) balqty,d.amount unitprice,d.amount*sum(d.qty-d.out_qty)  "
						 		+ "  total,d.amount*sum(d.qty-d.out_qty)* d.disper/100 discountvalue, d.disper discountpercent, "
						 		+ " (d.amount*sum(d.qty-d.out_qty))-(d.amount*sum(d.qty-d.out_qty)*d.disper/100) nettotal from my_grnm mm  "
						 		+ " left join  my_grnd d on d.tr_no=mm.tr_no  left join my_main m on m.doc_no=d.prdId  "
						 		+ " left join my_unitm u on d.unitid=u.doc_no   left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
						 		+ " "+joinsql+"  where  d.rowno in ("+detrowno+")    group by d.stockid having sum(d.qty-d.out_qty)>0");
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	public JSONArray getModalINVData(String cldocno,String detrowno,String brhid,String locid,String date,String billtype,String vattype,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			java.sql.Date sqldate = null;
			if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	     	{
				sqldate=objcommon.changeStringtoSqlDate(date);
	     	}
			
			int pricemgmt=0;
			String strpricemgmt="select method  from gl_prdconfig where field_nme='pricemgt'";
			ResultSet rspricemgmt=stmt.executeQuery(strpricemgmt); 
			if(rspricemgmt.next())
			{
				pricemgmt=rspricemgmt.getInt("method");
			}
			
			int discountset=0;
			String strdiscount="select method  from gl_prdconfig where field_nme='discountset'";
			ResultSet rsdiscount=stmt.executeQuery(strdiscount); 
			if(rsdiscount.next())
			{
				discountset=rsdiscount.getInt("method");
			}
			
			int tax=0;
			String strtaxconfig="select method  from gl_prdconfig where field_nme='tax' ";
			ResultSet rstaxconfig=stmt.executeQuery(strtaxconfig); 
			if(rstaxconfig.next())
			{
				tax=rstaxconfig.getInt("method");
			}
			int acno=0;
			int clienttax=0;
			int catid=0;
			String strgetacno="select acno,tax,catid from my_acbook where cldocno="+cldocno+" and dtype='CRM'";
			ResultSet rsacno=stmt.executeQuery(strgetacno);
			while(rsacno.next()) {
				acno=rsacno.getInt("acno");
				clienttax=rsacno.getInt("tax");
				catid=rsacno.getInt("catid");
			}
			if(clienttax==0) {
				tax=0;
			}
			int taxmethod=0;
			String sqltaxcheck="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+acno+"' ";
			ResultSet rstaxcheck=stmt.executeQuery(sqltaxcheck);
			if(rstaxcheck.next()){
				taxmethod=rstaxcheck.getInt("tax");
			}
			if(taxmethod!=1){
				tax=0;
			}
			
			String joinsql="",fsql="",outfsql="";
			if(tax>0)
			{
				if(Integer.parseInt(billtype)>0)
				{
					int prvdocno=0;
					String strprovince="select prvdocno from my_brch where doc_no="+brhid;
					ResultSet rsprovince=stmt.executeQuery(strprovince); 
					if(rsprovince.next())
					{
						prvdocno=rsprovince.getInt("prvdocno");
					}
					
					joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+sqldate+"' and todate>='"+sqldate+"' and provid='"+prvdocno+"'  and type=2 and if(1="+billtype+",per,cstper)>0  group by typeid  ) t1 on t1.typeid=m.typeid   ";
								
					fsql=fsql+" case when 1="+billtype+"  then t1.per when 2="+billtype+"  then t1.cstper else 0 end as  'taxpercent' ,t1.taxdocno , ";
					
					outfsql=outfsql+ " taxper ,if(a.ref_type='DIR',qty*unitprice1,netotal)+if(a.ref_type='DIR',qty*unitprice1,netotal)*(taxper/100)  taxamount ,taxdocno, ";
					
				}
				
			}
			
			String strprcount="select count(c) counts from (select count(d.psrno) c   ,d.psrno,m.productname  from my_delm m1 left join "
					+ "  my_deld d on m1.doc_no=d.rdocno   left join my_main m on(d.psrno=m.doc_no) "
					+ "  left join  my_brand bd on m.brandid=bd.doc_no  left join  my_unitm u on(d.unitid=u.doc_no) "
					+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)  where d.doc_no in("+detrowno+") and  m1.brhid="+brhid+"  "
					+ "   group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0  ) a group by  psrno ";
			
			System.out.println("=asd==counts="+strprcount);
			ResultSet rsprcount=stmt.executeQuery(strprcount);
			int count=0;
			while(rsprcount.next())
			{
				count=rsprcount.getInt("counts");
				if(count>1)
				{
					count=2;
				}
			}
			
			String strsql="";
			if(pricemgmt>0)
			{
			
				
				
				strsql="select  "+outfsql+"  "+count+" count,"+discountset+" discountset,costprice,setbalqty,vatype,round(allowdiscount,2) allowdiscount,brandname,locid,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty,part_no,productid, "
						+ " proid,productname,proname,unit,unitdocno, if(a.ref_type='DIR',a.unitprice1,unitprice) unitprice, "
						+ " qty*if(a.ref_type='DIR',a.unitprice1,unitprice) total,convert(if(a.ref_type='DIR','',dis),char(10)) dis,convert(if(a.ref_type='DIR','',discper),char(10)) discper, "
						+ "  if(a.ref_type='DIR',qty*unitprice1,netotal) netotal from (select "+fsql+" m1.ref_type,ii.cost_price as costprice,ii.inblqty as setbalqty,m1.vattype as vatype,case when '"+sqldate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice1,  "
						+ " case   when '"+sqldate+"' between "
						+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
						+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
						+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
						+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
						+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ " left join( select cost_price,date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty, "
						+ " prdid,psrno,specno,brhid,locid "
						+ " from my_prddin where 1=1 and date<='"+sqldate+"' group by psrno) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid "
						+ "	and d.specno=ii.specno and m1.brhid=ii.brhid) "
						+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+sqldate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
						+ " "+joinsql+" where m.status=3 and d.doc_no in("+detrowno+") and m1.brhid="+brhid+" group by d.psrno,d.unitid,d.specno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0 ) a ";
				 
			}
			else
			{
				
				
				strsql=" select "+fsql+" "+count+" count, bd.brandname,ii.cost_price as costprice,ii.inblqty as setbalqty,m1.locid,m1.vattype as vatype,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
						+ "   sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid,m.part_no product, "
						+ "   m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,d.amount unitprice,((qty-out_qty)*d.amount) total, "
							+ " d.disper discountpercent,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discountvalue,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal "
						+ "   from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
						+ " left join( select cost_price,date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty, "
						+ " prdid,psrno,specno,brhid,locid "
						+ " from my_prddin where 1=1 and date<='"+sqldate+"' group by psrno) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid "
						+ "	and d.specno=ii.specno and m1.brhid=ii.brhid) "
						+ "   left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					    + "  "+joinsql+" where m.status=3 and d.doc_no in("+detrowno+") and  m1.brhid="+brhid+"    group by d.psrno,d.unitid,d.specno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0  ";
						
			}
			
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	public JSONArray getModalSalesOrderData(String id,String cldocno,String detrowno,String brhid,String date) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			int clienttax=0;
			
			if(!cldocno.trim().equalsIgnoreCase("")) {
				String str="select tax from my_acbook where cldocno="+cldocno+" and dtype='CRM'";
				ResultSet rstax=stmt.executeQuery(str);
				while(rstax.next()) {
					clienttax=rstax.getInt("tax");
				}
			}
			java.sql.Date sqldate=null;
			if(!date.trim().equalsIgnoreCase("")) {
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			String sqlfilters="";
			if(!detrowno.trim().equalsIgnoreCase("")) {
				sqlfilters+=" and d.rowno in ("+detrowno+")";
			}
			double taxpercent=0.0;
			if(clienttax>0) {
				String strgettax="SELECT coalesce(tm.per,0) per FROM my_brch br LEFT JOIN gl_taxmaster tm ON br.prvdocno=tm.provid WHERE tm.type=2 AND '"+sqldate+"' BETWEEN tm.fromdate AND tm.todate AND br.doc_no="+brhid;
				ResultSet rsgettax=stmt.executeQuery(strgettax);
				while(rsgettax.next()) {
					taxpercent=rsgettax.getDouble("per");
				}
			}
			String strsql="select base.*,if(base.taxpercent>0,(base.nettotal*(base.taxpercent/100)),0) taxamount,if(base.taxpercent>0,(base.nettotal*(base.taxpercent/100))+base.nettotal,base.nettotal) taxtotal from (SELECT u.doc_no unitdocno,att.MSPECNO specid,"+clienttax+" clienttax,d.rowno,d.psrno,m1.part_no product,m1.ProductName,u.UNIT,d.qty-d.interOutQty qty,d.interOutQty outqty,d.amount unitprice,(d.qty-d.interOutQty)*d.amount total,d.disper discountpercent,\r\n" + 
					" d.discount discountvalue,(d.qty-d.interOutQty)*d.amount nettotal,"+taxpercent+" taxpercent  FROM my_ordd d\r\n" + 
					" LEFT JOIN my_main m1 ON d.psrno=m1.psrno\r\n" + 
					" LEFT JOIN my_prodattrib att ON m1.psrno=att.MPSRNO\r\n" + 
					" LEFT JOIN my_unitm u ON d.unitid=u.doc_no\r\n" + 
					" WHERE 1=1"+sqlfilters+") base";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getModalDelNoteData(String id,String cldocno,String detrowno,String brhid,String date) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			java.sql.Date sqldate=null;
			if(!date.trim().equalsIgnoreCase("")) {
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			String sqlfilters="";
			
			String strsql="select m.psrno,ma.vattype,bd.brandname,sum(qty)-sum(out_qty) valorderqty,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, \r\n" + 
					" sum(qty) as oldqty,sum(qty)-sum(out_qty) qty,sum(out_qty) outqty,coalesce(ii.balqty,0)/d.fr as balqty,part_no,m.part_no productid,m.part_no \r\n" + 
					" as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, \r\n" + 
					" KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,d.discount dis,d.nettotal netotal \r\n" + 
					" from my_sorderm ma left join  my_sorderd d on ma.doc_no=d.rdocno \r\n" + 
					" left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on \r\n" + 
					" (d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) \r\n" + 
					" left join( select date,sum(op_qty) op_qty,stockid, \r\n" + 
					" sum(op_qty)-sum(out_qty+del_qty+rsv_qty) balqty,prdid,psrno,specno,brhid,locid \r\n" + 
					" from my_prddin where 1=1 and  date<='"+sqldate+"'  group by psrno) ii on  (ii.psrno=d.psrno and ii.prdid=d.prdid \r\n" + 
					" and d.specno=ii.specno and ma.brhid=ii.brhid  )  \r\n" + 
					" where m.status=3 and ma.brhid="+brhid+" and d.clstatus=0  and d.doc_no in ("+detrowno+") group by d.psrno,d.unitid,d.specno having sum(d.qty-d.out_qty)>0 ;\r\n" + 
					" ";
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
	
	public JSONArray getModalGRNData(String id,String cldocno,String detrowno,String brhid,String date,String locid) throws SQLException {
		JSONArray data=new JSONArray();
		if(!id.trim().equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			
			java.sql.Date sqldate=null;
			if(!date.trim().equalsIgnoreCase("")) {
				sqldate=objcommon.changeStringtoSqlDate(date);
			}
			int multiqty=0;
			String strmultiqty="select method  from gl_prdconfig where field_nme='multiqty' ";
			ResultSet rsmultiqty=stmt.executeQuery(strmultiqty); 
			if(rsmultiqty.next())
			{
				multiqty=rsmultiqty.getInt("method");
			}
			
			String joinsqls="";
			String joinsqls1="";
			if(multiqty>0)
			{
				joinsqls=",d.unitid,d.specno ";
				  
				
			}
			String sqlfilters="";
			
			String strsql="select bd.brandname,d.rowno refrowno, 'pro' checktype ,at.mspecno as specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,\r\n" + 
					"d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty)  qty,sum(d.qty-d.out_qty) qutval,\r\n" + 
					"sum(d.qty-d.out_qty) saveqty,sum(d.qty-d.out_qty) balqty,\r\n" + 
					"d.amount unitprice,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discountvalue,d.disper discountpercent from my_ordd d\r\n" + 
					"	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ "    where d.rowno in ("+detrowno+") and  d.clstatus=0 group by d.prdid"+joinsqls+",d.amount,d.discount having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno ";
			
			System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			conn.close();
		}
		return data;
	}
}
