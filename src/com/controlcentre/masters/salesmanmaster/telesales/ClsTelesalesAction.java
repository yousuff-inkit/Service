package com.controlcentre.masters.salesmanmaster.telesales;

import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.common.ClsCommon;
import com.controlcentre.masters.salesmanmaster.telesales.ClsTelesalesBean;
import com.controlcentre.masters.salesmanmaster.telesales.ClsTelesalesDAO;

public class ClsTelesalesAction extends ActionSupport {
	ClsCommon ClsCommon = new ClsCommon();
	ClsTelesalesDAO telesalesDAO = new ClsTelesalesDAO();
	ClsTelesalesBean bean;

	private int docno;
	private String txtaccname;
	private int txtaccno;
	private String code;
	private String name;
	private String telesalesdate;
	private String hidtelesalesdate;
	private String mode;
	private String deleted;
	private String mobile;
	private String mail;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	private String hidacno;
	private int cmbuser;
	private int hidcmbuser;

	public String getHidacno() {
		return hidacno;
	}

	public void setHidacno(String hidacno) {
		this.hidacno = hidacno;
	}

	public String getFormdetail() {
		return formdetail;
	}

	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}

	public int getTxtaccno() {
		return txtaccno;
	}

	public void setTxtaccno(int txtaccno) {
		this.txtaccno = txtaccno;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTelesalesdate() {
		return telesalesdate;
	}

	public void setTelesalesdate(String telesalesdate) {
		this.telesalesdate = telesalesdate;
	}

	public String getHidtelesalesdate() {
		return hidtelesalesdate;
	}

	public void setHidtelesalesdate(String hidtelesalesdate) {
		this.hidtelesalesdate = hidtelesalesdate;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}

	public int getCmbuser() {
		return cmbuser;
	}
	
	public void setCmbuser(int cmbuser) {
		this.cmbuser = cmbuser;
	}
	
	public int getHidcmbuser() {
		return hidcmbuser;
	}
	
	public void setHidcmbuser(int hidcmbuser) {
		this.hidcmbuser = hidcmbuser;
	}
	
	public String saveAction() throws ParseException, SQLException {
		System.out.println("INnnnn");
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		session.getAttribute("BranchName");
		String mode = getMode();
		ClsTelesalesBean bean = new ClsTelesalesBean();

		java.sql.Date hlprDate = ClsCommon
				.changeStringtoSqlDate(getTelesalesdate());

		if (mode.equalsIgnoreCase("A")) {
			int val = telesalesDAO.insert(getCode(), getName(), hlprDate,
					getHidacno(), session, getMode(), getMobile(), getMail(),
					getFormdetailcode(),getCmbuser());
			if (val > 0.0) {
				setCode(getCode());
				setName(getName());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMode(getMode());
				setMail(getMail());
				setDocno(val);
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setMsg("Successfully Saved");
				return "success";
			} else if (val == -1) {
				setCode(getCode());
				setName(getName());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMode(getMode());
				setMail(getMail());
				setDocno(val);
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setChkstatus("1");
				setMsg("Code Already Exists.");
				return "fail";
			} else if (val == -2) {
				setCode(getCode());
				setName(getName());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMode(getMode());
				setMail(getMail());
				setDocno(val);
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setChkstatus("1");
				setMsg("Name Already Exists.");
				return "fail";
			} else if (val == -3) {
				setCode(getCode());
				setName(getName());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMode(getMode());
				setMail(getMail());
				setDocno(val);
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setChkstatus("1");
				setMsg("Account Already Exists.");
				return "fail";
			} else {
				setCode(getCode());
				setName(getName());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setMobile(getMobile());
				setMode(getMode());
				setMail(getMail());
				setDocno(val);
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setMsg("Not Saved");
				return "fail";
			}
		}

		else if (mode.equalsIgnoreCase("E")) {
			int val = telesalesDAO.edit(getCode(), getName(), hlprDate,
					getHidacno(), session, getMode(), getDocno(), getMobile(),
					getMail(), getFormdetailcode(), getCmbuser());
			if (val > 0) {

				// session.getAttribute("BranchName");
				setCode(getCode());
				setName(getName());
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());

				setMsg("Updated Successfully");
				return "success";
			} else if (val == -1) {
				setCode(getCode());
				setName(getName());
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
				setChkstatus("2");
				setMsg("Code Already Exists.");
				return "fail";
			} else if (val == -2) {
				setCode(getCode());
				setName(getName());
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
				setChkstatus("2");
				setMsg("Name Already Exists.");
				return "fail";
			} else if (val == -3) {
				setCode(getCode());
				setName(getName());
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
				setChkstatus("2");
				setMsg("Account Already Exists.");
				return "fail";
			} else {
				setCode(getCode());
				setName(getName());
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
				setMsg("Not Updated");
				return "fail";
			}
		} else if (mode.equalsIgnoreCase("D")) {
			boolean Status = telesalesDAO.delete(getCode(), getName(),
					hlprDate, getTxtaccno(), session, getMode(), getDocno(),
					getMobile(), getMail(), getFormdetailcode(), getCmbuser());
			if (Status) {
				setCode(getCode());
				setName(getName());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			} else {

				setCode(getCode());
				setName(getName());
				setHidtelesalesdate(hlprDate.toString());
				setTxtaccname(getTxtaccname());
				setTxtaccno(getTxtaccno());
				setDocno(getDocno());
				setMode(getMode());
				setMobile(getMobile());
				setMail(getMail());
				setHidacno(getHidacno());
				setHidcmbuser(getCmbuser());
				setMsg("Not Deleted");

				return "fail";
			}
		}
		return "fail";
	}

	public JSONArray searchDetails() {
		JSONArray cellarray = new JSONArray();
		JSONObject cellobj = null;
		try {
			List<ClsTelesalesBean> list = telesalesDAO.list();
			for (ClsTelesalesBean bean : list) {
				cellobj = new JSONObject();
				cellobj.put("DOC_NO", bean.getDocno());
				cellobj.put("sal_code", bean.getCode());
				cellobj.put("sal_name", bean.getName());
				cellobj.put("date", bean.getTelesalesdate().toString());
				cellobj.put("acc_no", bean.getTxtaccno());
				cellobj.put("description", bean.getTxtaccname());
				cellobj.put("mobile", bean.getMobile());
				cellobj.put("mail", bean.getMail());
				cellobj.put("acdoc", bean.getHidacno());
				cellobj.put("user", bean.getUser());
				cellobj.put("user_id", bean.getHidcmbuser());
				cellarray.add(cellobj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cellarray;
	}
}
