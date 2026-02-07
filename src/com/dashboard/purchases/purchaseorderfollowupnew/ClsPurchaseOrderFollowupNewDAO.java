package com.dashboard.purchases.purchaseorderfollowupnew;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.*;

public class ClsPurchaseOrderFollowupNewDAO {
	ClsCommon ClsCommon = new ClsCommon();
	ClsConnection ClsConnection = new ClsConnection();

	public JSONArray mainGridLoad(HttpSession session, String brhid, String load) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		if (!(load.equalsIgnoreCase("1"))) {
			return RESULTDATA;
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement();

			String sql = "select m.voc_no, m.date, h.account, h.description acname,\r\n"
					+ "case when m.rdtype='SOR' then 'Sales Order' when m.rdtype='RFQ' then 'Purchase Request For Quote' \r\n"
					+ "when m.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype, m.netTotal netamt, m.description,\r\n"
					+ "m.doc_no, m.brhid, m.cldocno\r\n"
					+ "from my_ordm m left join my_ordd d on d.tr_no=m.tr_no left join my_head h on h.doc_no=m.acno \r\n"
					+ "where m.status=3 and d.clstatus=0 and d.qty>d.out_qty and m.brhid=" + brhid
					+ " group by m.doc_no order by m.date desc, m.doc_no desc;";

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

	public JSONArray subGridLoad(HttpSession session, String doc, String acno, String cmbbilltype, String dates) throws SQLException {

		JSONArray RESULTDATA = new JSONArray();
		if ((doc.equalsIgnoreCase("0"))) {
			return RESULTDATA;
		}
		
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			java.sql.Date masterdate = null;
			if (!(dates.equalsIgnoreCase("undefined")) && !(dates.equalsIgnoreCase(""))
					&& !(dates.equalsIgnoreCase("0"))) {
				masterdate = ClsCommon.changeStringtoSqlDate(dates);
			}

			int tax = 0;
			Statement stmt3 = conn.createStatement();

			String chk31 = "select method  from gl_prdconfig where field_nme='tax' ";
			ResultSet rss3 = stmt3.executeQuery(chk31);
			if (rss3.next()) {
				tax = rss3.getInt("method");
			}

			int temptax = 0;
			Statement stmt3111 = conn.createStatement();
			String sqlss = "select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where a.dtype='VND' and a.acno='"
					+ acno + "' ";
			ResultSet rsss = stmt3111.executeQuery(sqlss);
			if (rsss.next()) {
				temptax = rsss.getInt("tax");

			}
			if (temptax != 1) {
				tax = 0;
			}

			String joinsql = "";

			String fsql = "";

			String outfsql = "";

			if (tax > 0 && Integer.parseInt(cmbbilltype) > 0) {

				Statement pv = conn.createStatement();
				int prvdocno = 0;
				String dd = "select prvdocno from my_brch where doc_no='" + session.getAttribute("BRANCHID").toString()
						+ "' ";
				ResultSet rs13 = pv.executeQuery(dd);
				if (rs13.next()) {

					prvdocno = rs13.getInt("prvdocno");
				}

				joinsql = joinsql
						+ " left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"
						+ masterdate + "' and todate>='" + masterdate + "' and provid='" + prvdocno
						+ "'  and type=1 and if(1=" + cmbbilltype + ",per,cstper)>0  group by typeid) t1 on "
						+ " t1.typeid=m.typeid   ";

				fsql = fsql + " case when 1=" + cmbbilltype + " then t1.per when 2=" + cmbbilltype
						+ " then t1.cstper else 0 end as 'taxper' ,t1.taxdocno , ";

				outfsql = outfsql + " taxper ,taxdocno, ";
			}

			int mulqty = 0;
			Statement stmt31 = conn.createStatement();

			String chk311 = "select method  from gl_prdconfig where field_nme='multiqty' ";
			ResultSet rss31 = stmt31.executeQuery(chk311);
			if (rss31.next()) {
				mulqty = rss31.getInt("method");
			}

			String joinsqls = "";
			if (mulqty > 0) {
				joinsqls = ",d.unitid,d.specno ";
			}

			String sql = "select " + fsql
					+ " mm.brhid, mm.acno account, bd.brandname,group_concat(d.rowno) refrowno, 'pro' checktype ,at.mspecno as specid,m.part_no productid,m.productname,m.part_no proid ,m.productname proname,d.sr_no,d.psrno,\r\n"
					+ " d.prdId prodoc, u.unit, d.unitid unitdocno,sum(d.qty-d.out_qty) qty,sum(d.qty-d.out_qty) qutval,\r\n"
					+ " sum(d.qty-d.out_qty) saveqty,d.amount orderamount,d.disper orderdiscper,\r\n"
					+ " d.amount unitprice,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 discount,d.disper discper,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal, "
					+ " sum(d.qty-d.out_qty)*d.amount total from my_ordd d inner join my_ordm mm on mm.tr_no=d.tr_no\r\n"
					+ "	left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_brand bd on m.brandid=bd.doc_no "
					+ joinsql + "  where d.rdocno in (" + doc + ") and  d.clstatus=0 group by d.prdid" + joinsqls
					+ ",d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.rowno;";

			
			ResultSet resultSet = stmt.executeQuery(sql);

			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmt.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
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

			String sql = "select loc_name,doc_no,brhid from my_locm where status=3 and brhid="+brhid ;

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

}
