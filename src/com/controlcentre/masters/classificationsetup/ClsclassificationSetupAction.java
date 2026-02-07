package com.controlcentre.masters.classificationsetup;

import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsclassificationSetupAction{
	
	ClsclassificationSetupDAO DAO = new ClsclassificationSetupDAO();
	
	ClsclassificationSetupBean bean = new ClsclassificationSetupBean();
	
	ClsCommon ClsCommon = new ClsCommon();
	
	private int docno;
	
	private String name;
	
	private String mode;
	
	private String deleted;
	
	private String msg;
	
	private String formdetail;
	
	private String formdetailcode;
	
	private String chkstatus;
	
	private String specDate;
	
	private String hidspecDate;

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
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

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}

	public String getSpecDate() {
		return specDate;
	}

	public void setSpecDate(String specDate) {
		this.specDate = specDate;
	}
	
	public String getHidspecDate() {
		return hidspecDate;
	}

	public void setHidspecDate(String hidspecDate) {
		this.hidspecDate = hidspecDate;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
	
	public String saveAction() throws SQLException {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String returns="";
		Date date = ClsCommon.changeStringtoSqlDate(getSpecDate());
		System.out.println("Crosssed Date line");
		if(mode.equalsIgnoreCase("A")) {
			int val = DAO.insert(date, getFormdetail(), getFormdetailcode(), getName(), getMode());
			if(val>0) {
				setDocno(val);
				setSpecDate(date+"");
				setHidspecDate(date+"");
				setMsg("Successfully Saved");
				returns = "success";
			} else {
				setMsg("Not Updated");
				setSpecDate(date+"");
				returns="fail";
			}
		}
		else if(mode.equalsIgnoreCase("E")) {
			int val = DAO.update(date, getFormdetail(),getFormdetailcode(),getName(),getMode(),getDocno());
			if(val>0.0) {
				setDocno(val);
				setSpecDate(date+"");
				setMsg("Updated Successfully");
				setChkstatus("0");
				returns = "success";
			} else if(val == -1) {
				setChkstatus("2");
				setSpecDate(date+"");
				setMsg("name already exists");
				return "fail";
			} else {
				setMsg("Not Updated");
				setSpecDate(date+"");
				returns="fail";
			}
		} 
		else if(mode.equalsIgnoreCase("D")) {
			int status = DAO.delete(getDocno(), session, getName(),getFormdetailcode());
			if(status>0.0) {
				setName(getName());
				setSpecDate(date+"");
				setMsg("Successfully Deleted");
				setDeleted("DELETED");
				returns = "success";
			} else {
				setSpecDate(date+"");
				setMsg("Not Deleted");
				returns = "fail";
			}	
		} 
		return returns;
	}

	
	
}
