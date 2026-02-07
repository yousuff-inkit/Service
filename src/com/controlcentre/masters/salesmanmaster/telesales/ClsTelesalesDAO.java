package com.controlcentre.masters.salesmanmaster.telesales;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTelesalesDAO {
	ClsConnection ClsConnection = new ClsConnection();

	ClsCommon ClsCommon = new ClsCommon();

	ClsTelesalesBean telesalesBean = new ClsTelesalesBean();
	Connection conn;

	public int insert(String code, String name, Date sqlStartDate,
			String txtaccno, HttpSession session, String mode, String mobile,
			String mail, String formdetailcode, int cmbuser)
			throws SQLException {
		try {
			conn = ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			int docno;

			CallableStatement stmtTelesales = conn
					.prepareCall("{call telesalesDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmtTelesales.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtTelesales.setString(1, code);
			stmtTelesales.setString(2, name);
			stmtTelesales.setDate(3, sqlStartDate);
			stmtTelesales.setString(4, txtaccno);
			stmtTelesales.setString(5, formdetailcode);
			stmtTelesales.setString(6, session.getAttribute("USERID")
					.toString());
			stmtTelesales.setString(7, session.getAttribute("BRANCHID")
					.toString());
			stmtTelesales.setString(9, mode);
			stmtTelesales.setString(10, mobile);
			stmtTelesales.setString(11, mail);
			stmtTelesales.setInt(12, cmbuser);
			stmtTelesales.executeQuery();

			docno = stmtTelesales.getInt("docNo");
			telesalesBean.setDocno(docno);
			if (docno > 0) {
				conn.commit();
				stmtTelesales.close();
				conn.close();
				return docno;
			} else if (docno == -1) {
				stmtTelesales.close();
				conn.close();
				return docno;
			} else if (docno == -2) {
				stmtTelesales.close();
				conn.close();
				return docno;
			} else if (docno == -3) {
				stmtTelesales.close();
				conn.close();
				return docno;
			}
			stmtTelesales.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
			return 0;
		} finally {
			conn.close();
		}
		return 0;
	}

	public int edit(String code, String name, Date sqlStartDate,
			String txtaccno, HttpSession session, String mode, int docno,
			String mobile, String mail, String formdetailcode, int cmbuser)
			throws SQLException {

		try {
			conn = ClsConnection.getMyConnection();
			conn.setAutoCommit(false);

			CallableStatement stmtTelesales = conn
					.prepareCall("{call telesalesDML(?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtTelesales.setInt(8, docno);
			stmtTelesales.setString(1, code);
			stmtTelesales.setString(2, name);
			stmtTelesales.setDate(3, sqlStartDate);
			stmtTelesales.setString(4, txtaccno);
			stmtTelesales.setString(5, formdetailcode);
			stmtTelesales.setString(6, session.getAttribute("USERID")
					.toString());
			stmtTelesales.setString(7, session.getAttribute("BRANCHID")
					.toString());
			stmtTelesales.setString(9, mode);
			stmtTelesales.setString(10, mobile);
			stmtTelesales.setString(11, mail);
			stmtTelesales.setInt(12, cmbuser);
			stmtTelesales.executeUpdate();

			int documentNo = stmtTelesales.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtTelesales.close();
				conn.close();
				return 1;
			} else if (documentNo == -1) {
				stmtTelesales.close();
				conn.close();
				return documentNo;
			} else if (documentNo == -2) {
				stmtTelesales.close();
				conn.close();
				return documentNo;
			} else if (documentNo == -3) {
				stmtTelesales.close();
				conn.close();
				return documentNo;
			}
			stmtTelesales.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
			return 0;
		} finally {
			conn.close();
		}
		return 0;
	}

	public boolean delete(String code, String name, Date sqlStartDate,
			int txtaccno, HttpSession session, String mode, int docno,
			String mobile, String mail, String formdetailcode, int cmbuser)
			throws SQLException {
		try {
			conn = ClsConnection.getMyConnection();
			conn.setAutoCommit(false);

			CallableStatement stmtTelesales = conn
					.prepareCall("{call telesalesDML(?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmtTelesales.setInt(8, docno);
			stmtTelesales.setString(1, code);
			stmtTelesales.setString(2, name);
			stmtTelesales.setDate(3, sqlStartDate);
			stmtTelesales.setInt(4, txtaccno);
			stmtTelesales.setString(5, formdetailcode);
			stmtTelesales.setString(6, session.getAttribute("USERID")
					.toString());
			stmtTelesales.setString(7, session.getAttribute("BRANCHID")
					.toString());
			stmtTelesales.setString(9, mode);
			stmtTelesales.setString(10, mobile);
			stmtTelesales.setString(11, mail);
			stmtTelesales.setInt(12, cmbuser);
			stmtTelesales.executeUpdate();

			int documentNo = stmtTelesales.getInt("docNo");
			if (documentNo > 0) {
				conn.commit();
				stmtTelesales.close();
				return true;
			}
			stmtTelesales.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
			return false;
		} finally {
			conn.close();
		}
		return false;
	}

	public List<ClsTelesalesBean> list() throws SQLException {
		List<ClsTelesalesBean> listBean = new ArrayList<ClsTelesalesBean>();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtTelesales = conn.createStatement();

			ResultSet resultSet = stmtTelesales
					.executeQuery("select m1.sal_code,m1.sal_name,m1.doc_no,m2.account acc_no,m2.doc_no acdoc,m1.date,m1.mobile,m1.mail,m2.description,usr.user_id user,m1.user_id"
							+ " from my_salesman m1 left join my_head m2 on m1.acc_no=m2.doc_no left join my_user usr on usr.doc_no=m1.user_id where m1.status<>7 and m1.sal_type='TEL'");

			while (resultSet.next()) {

				ClsTelesalesBean bean = new ClsTelesalesBean();
				bean.setDocno(resultSet.getInt("doc_no"));
				bean.setName(resultSet.getString("sal_name"));
				bean.setCode(resultSet.getString("sal_code"));
				bean.setTelesalesdate(resultSet.getDate("date"));
				bean.setTxtaccno(resultSet.getInt("acc_no"));
				bean.setTxtaccname(resultSet.getString("description"));
				bean.setMobile(resultSet.getString("mobile"));
				bean.setMail(resultSet.getString("mail"));
				bean.setHidacno(resultSet.getString("acdoc"));
				bean.setUser(resultSet.getString("user"));
				bean.setHidcmbuser(resultSet.getInt("user_id"));
				listBean.add(bean);
			}

			stmtTelesales.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		return listBean;
	}

	public JSONArray searchDetails() throws SQLException {

		JSONArray RESULTDATA = new JSONArray();

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtVeh1 = conn.createStatement();
			String sqldata = "select sal.doc_no,sal.sal_code code,sal.sal_name name,head.account acno,head.doc_no acdoc,sal.mail,sal.mobile,sal.date,head.description,usr.user_id user,sal.user_id"
					+ " from my_salesman sal left join my_head head on (sal.acc_no=head.doc_no) left join my_user usr on usr.doc_no=sal.user_id where sal.status=3 and sal_type='TEL';";

			ResultSet resultSet = stmtVeh1.executeQuery(sqldata);
			RESULTDATA = ClsCommon.convertToJSON(resultSet);

			stmtVeh1.close();
			conn.close();
			return RESULTDATA;

		} catch (Exception e) {
			e.printStackTrace();
			conn.close();
		} finally {
			conn.close();
		}
		// System.out.println(RESULTDATA);
		return RESULTDATA;
	}

}
