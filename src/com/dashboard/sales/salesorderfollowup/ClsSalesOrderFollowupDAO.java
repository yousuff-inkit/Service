package com.dashboard.sales.salesorderfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.*;

public class ClsSalesOrderFollowupDAO {
	ClsCommon ClsCommon = new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();

	public JSONArray mainGridLoad(HttpSession session, String brhid, String type, String load) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		if (!(load.equalsIgnoreCase("1"))) {
			return RESULTDATA;
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement();

			String sql = "";

			if ((type.equalsIgnoreCase("SOR"))) {
				sql = "select m.voc_no, m.date, h.account, h.description acname,\r\n"
						+ "case when m.ref_type='DIR' then 'Direct' else 'Quotation' end dtype, m.grantamt netamt, m.description,\r\n"
						+ "m.doc_no, m.brhid, m.cldocno, ac.catid clientcaid \r\n"
						+ "from my_sorderm m left join my_sorderd d on d.tr_no=m.tr_no left join my_head h on h.doc_no=m.acno \r\n"
						+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' \r\n"
						+ "where m.status=3 and d.clstatus=0 and d.qty>d.out_qty and m.brhid=" + brhid
						+ " group by m.doc_no order by m.date desc, m.doc_no desc;";

			} else if ((type.equalsIgnoreCase("DEL"))) {
				sql = "select m.voc_no, m.date, h.account, h.description acname,\r\n"
						+ "if(m.ref_type='DIR','Direct','Sales Order') dtype, m.grantamt netamt, m.description,\r\n"
						+ "m.doc_no, m.brhid, m.cldocno, ac.catid clientcaid \r\n"
						+ "from my_delm m left join my_deld d on d.tr_no=m.tr_no left join my_head h on h.doc_no=m.acno \r\n"
						+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' \r\n"
						+ "where m.status=3 and d.qty>d.out_qty and m.brhid=" + brhid
						+ " group by m.doc_no order by m.date desc, m.doc_no desc;";

			}

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmt.close();
			conn.close();
			return RESULTDATA;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray deliveryGridLoad(HttpSession session, String brhid, String docno, String locationid, String date)
			throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;

		java.sql.Date sqlStartDate = null;

		if (!(date.equalsIgnoreCase("undefined")) && !(date.equalsIgnoreCase("")) && !(date.equalsIgnoreCase("0"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
		}

		try {

			if (((docno.equalsIgnoreCase("")) || (docno.equalsIgnoreCase("undefined")))) {
				docno = "0";
			}

			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select ma.cldocno,group_concat(d.doc_no)refrowno,ma.vattype,bd.brandname,sum(qty)-sum(out_qty) valorderqty,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
					+ " sum(qty) as oldqty,sum(qty)-sum(out_qty) qty,sum(out_qty) outqty,coalesce(ii.balqty,0)/d.fr as balqty,part_no,m.part_no productid,m.part_no "
					+ " as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
					+ " KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,d.discount dis,d.nettotal netotal "
					+ " from my_sorderm ma left join my_sorderd d on ma.doc_no=d.rdocno "
					+ " left join my_main m on(d.psrno=m.doc_no) left join my_unitm u on (d.unitid=u.doc_no)"
					+ " left join my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ " left join( select date,sum(op_qty) op_qty,stockid, "
					+ " sum(op_qty)-sum(out_qty+del_qty+rsv_qty) balqty,prdid,psrno,specno,brhid,locid "
					+ " from my_prddin where 1=1 and  date<='" + sqlStartDate
					+ "' group by psrno) ii on (ii.psrno=d.psrno and ii.prdid=d.prdid "
					+ " and d.specno=ii.specno and ma.brhid=ii.brhid) " + " where m.status=3 and ma.brhid='"
					+ session.getAttribute("BRANCHID").toString() + "' and d.clstatus=0  and d.rdocno in (" + docno
					+ ") group by d.psrno,d.unitid,d.specno having sum(d.qty-d.out_qty)>0 ";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray invoiceGridLoad(HttpSession session, String brhid, String docno, String reftype, String dates,
			String catid, String cmbbilltype, String clientid) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		if ((reftype.equalsIgnoreCase("0"))) {
			return RESULTDATA;
		}

		Connection conn = null;

		try {

			if (docno.equalsIgnoreCase("") || docno.equalsIgnoreCase("undefined")) {
				docno = "0";
			}

			String sql = "";
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();

			int pricemgt = 0;
			String chk3 = "select method from gl_prdconfig where field_nme='pricemgt'";
			ResultSet rs3 = stmt1.executeQuery(chk3);
			if (rs3.next()) {
				pricemgt = rs3.getInt("method");
			}

			java.sql.Date masterdate = null;
			if (!(dates.equalsIgnoreCase("undefined")) && !(dates.equalsIgnoreCase(""))
					&& !(dates.equalsIgnoreCase("0")) && !(dates.equalsIgnoreCase("NA"))) {
				masterdate = ClsCommon.changeStringtoSqlDate(dates);
			}

			Statement stmt43 = conn.createStatement();
			int discountset = 0;
			String chk311 = "select method from gl_prdconfig where field_nme='discountset'";
			ResultSet rs31 = stmt43.executeQuery(chk311);
			if (rs31.next()) {
				discountset = rs31.getInt("method");
			}

			int tax = 0;
			Statement stmt3 = conn.createStatement();

			String chk31 = "select method from gl_prdconfig where field_nme='tax' ";
			ResultSet rss3 = stmt3.executeQuery(chk31);
			if (rss3.next()) {
				tax = rss3.getInt("method");
			}

			String joinsql = "";

			String fsql = "";

			String outfsql = "";
			int taxid = 0;
			String sqltax = "select tax from my_acbook where dtype='CRM' and cldocno=" + clientid + "";
			ResultSet rs0 = stmt.executeQuery(sqltax);
			if (rs0.first()) {
				taxid = rs0.getInt("tax");
			}

			if (taxid == 0) {
				tax = 0;
			}

			if (tax > 0) {
				if (Integer.parseInt(cmbbilltype) > 0) {
					Statement pv = conn.createStatement();
					int prvdocno = 0;
					String dd = "select prvdocno from my_brch where doc_no=" + brhid;
					ResultSet rs13 = pv.executeQuery(dd);
					if (rs13.next()) {
						prvdocno = rs13.getInt("prvdocno");
					}

					joinsql = joinsql
							+ " left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where fromdate<='"
							+ masterdate + "' and todate>='" + masterdate + "' and provid='" + prvdocno
							+ "' and type=2 and if(1=" + cmbbilltype
							+ ",per,cstper)>0 group by typeid) t1 on t1.typeid=m.typeid ";

					fsql = fsql + " case when 1=" + cmbbilltype + " then t1.per when 2=" + cmbbilltype
							+ " then t1.cstper else 0 end as 'taxper', t1.taxdocno , ";

					outfsql = outfsql + " taxper, netotal+netotal*(taxper/100) taxamount, taxdocno, ";

				}
			}

			if (reftype.equalsIgnoreCase("DEL")) {
				String sqls = "select count(c) counts from (select count(d.psrno) c,d.psrno,m.productname "
						+ " from my_delm m1 left join my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) "
						+ " left join my_brand bd on m.brandid=bd.doc_no left join my_unitm u on(d.unitid=u.doc_no) "
						+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) " + " where d.rdocno in(" + docno
						+ ") and m1.brhid=" + brhid
						+ " group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0) a group by psrno;";

				ResultSet rss = stmt.executeQuery(sqls);
				int count = 0;
				while (rss.next()) {
					count = rss.getInt("counts");
					if (count > 1) {
						count = 2;
					}
				}

				if (pricemgt > 0) {
					sql = "select  " + outfsql + "  " + count + " count," + discountset
							+ " discountset,costprice,setbalqty,vatype,round(allowdiscount,2) allowdiscount,brandname,locid,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty,part_no,productid, "
							+ " proid,productname,proname,unit,unitdocno, if(a.ref_type='DIR',a.unitprice1,unitprice) unitprice, "
							+ " qty*if(a.ref_type='DIR',a.unitprice1,unitprice) total,convert(if(a.ref_type='DIR','',dis),char(10)) dis,convert(if(a.ref_type='DIR','',discper),char(10)) discper, "
							+ " if(a.ref_type='DIR',qty*unitprice1,netotal) netotal,a.cldocno,refrowno from (select "
							+ fsql
							+ " m1.ref_type,m1.cldocno,group_concat(d.doc_no)refrowno,ii.cost_price as costprice,ii.inblqty as setbalqty,m1.vattype as vatype,"
							+ " case when '" + masterdate
							+ "' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice1,  "
							+ " case when '" + masterdate + "' between "
							+ " clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
							+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
							+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
							+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
							+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
							+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
							+ " left join( select cost_price,date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty, "
							+ " prdid,psrno,specno,brhid,locid from my_prddin " + " where 1=1 and date<='" + masterdate
							+ "' group by psrno) ii on (ii.psrno=d.psrno and ii.prdid=d.prdid "
							+ "	and d.specno=ii.specno and m1.brhid=ii.brhid) "
							+ " left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='" + catid + "' or ('"
							+ masterdate + "' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"
							+ catid + "')) " + " " + joinsql + " where m.status=3 and d.rdocno in(" + docno
							+ ") and m1.brhid=" + brhid
							+ " group by d.psrno,d.unitid,d.specno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0 ) a ";

				} else {
					sql = " select " + fsql + " " + count
							+ " count, bd.brandname,ii.cost_price as costprice,ii.inblqty as setbalqty,m1.cldocno,group_concat(d.doc_no)refrowno,m1.locid,m1.vattype as vatype,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
							+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
							+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,d.amount unitprice,((qty-out_qty)*d.amount) total, "
							+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
							+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
							+ " left join( select cost_price,date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty, "
							+ " prdid,psrno,specno,brhid,locid " + " from my_prddin where 1=1 and date<='" + masterdate
							+ "' group by psrno) ii on (ii.psrno=d.psrno and ii.prdid=d.prdid "
							+ "	and d.specno=ii.specno and m1.brhid=ii.brhid) "
							+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
							+ joinsql + " where m.status=3 and d.rdocno in(" + docno + ") and  m1.brhid=" + brhid
							+ " group by d.psrno,d.unitid,d.specno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0";

				}

			}

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			conn.close();
		}
		return RESULTDATA;
	}

	
	public JSONArray locationSearch(String brhid) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();

			Statement stmtmain = conn.createStatement();

			String sql = "select loc_name,doc_no,brhid from my_locm where status=3 and brhid=" + brhid;

			ResultSet resultSet = stmtmain.executeQuery(sql);

			RESULTDATA = ClsCommon.convertToJSON(resultSet);
			stmtmain.close();

			conn.close();
			return RESULTDATA;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		}
		return RESULTDATA;
	}

	
	public JSONArray getSalesmanData(String id) throws SQLException {
		JSONArray data = new JSONArray();
		if (!id.equalsIgnoreCase("1")) {
			return data;
		}
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement();
			String clssql = ("select sal_name salesman,doc_no,coalesce(mob_no,'') mobile,coalesce(mail,'') mail from my_salm where status=3");
			ResultSet resultSet = stmtenq1.executeQuery(clssql);
			data = ClsCommon.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
			return data;
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return data;
	}


}
