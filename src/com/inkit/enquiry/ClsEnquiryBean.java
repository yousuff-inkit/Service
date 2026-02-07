package com.inkit.enquiry;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

public class ClsEnquiryBean {
	
	
	private String jqxIenqDate;
	private String hidjqxIenqDate;
	private String jqxTime;
	private String hidjqxTime;
	private String txtrefno;
	private String jqxResponseTime;
	private String hidjqxResponseTime;
	private String docno;
	private String txtclientname,txtaddress,txtsalesman,txtsalesmandocno,txtmobile,txttelno,txtemail;
	public String getTxtaddress() {
		return txtaddress;
	}


	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}


	public String getTxtsalesman() {
		return txtsalesman;
	}


	public void setTxtsalesman(String txtsalesman) {
		this.txtsalesman = txtsalesman;
	}


	public String getTxtsalesmandocno() {
		return txtsalesmandocno;
	}


	public void setTxtsalesmandocno(String txtsalesmandocno) {
		this.txtsalesmandocno = txtsalesmandocno;
	}


	public String getTxtmobile() {
		return txtmobile;
	}


	public void setTxtmobile(String txtmobile) {
		this.txtmobile = txtmobile;
	}


	public String getTxttelno() {
		return txttelno;
	}


	public void setTxttelno(String txttelno) {
		this.txttelno = txttelno;
	}


	public String getTxtemail() {
		return txtemail;
	}


	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}


	private String txtclientdet;
	private int clientid;
	private String txtcontactperson;
	private String txttelnoarea;
	private String txtprojectowner;
	private int projectownerid;
	private String txtvendor;
	private int vendorid;
	private String txtsubsupplier;
	private int subvendorid;
	private int jobdetgridlenth;
	private String mode;
	private String formdetailcode;
	private String msg;
	private String deleted;
	private int cptrno;
	private int clientcurid;
	private double clientcurrate;
	
	
	
	
	
    public double getClientcurrate() {
		return clientcurrate;
	}


	public void setClientcurrate(double clientcurrate) {
		this.clientcurrate = clientcurrate;
	}


	public int getClientcurid() {
		return clientcurid;
	}


	public void setClientcurid(int clientcurid) {
		this.clientcurid = clientcurid;
	}
	
	
    public int getCptrno() {
		return cptrno;
	}


	public void setCptrno(int cptrno) {
		this.cptrno = cptrno;
	}


	public int getJobdetgridlenth() {
		return jobdetgridlenth;
	}


	public void setJobdetgridlenth(int jobdetgridlenth) {
		this.jobdetgridlenth = jobdetgridlenth;
	}



	public String getJqxIenqDate() {
		return jqxIenqDate;
	}


	public void setJqxIenqDate(String jqxIenqDate) {
		this.jqxIenqDate = jqxIenqDate;
	}


	public String getHidjqxIenqDate() {
		return hidjqxIenqDate;
	}


	public void setHidjqxIenqDate(String hidjqxIenqDate) {
		this.hidjqxIenqDate = hidjqxIenqDate;
	}


	public String getJqxTime() {
		return jqxTime;
	}


	public void setJqxTime(String jqxTime) {
		this.jqxTime = jqxTime;
	}


	public String getHidjqxTime() {
		return hidjqxTime;
	}


	public void setHidjqxTime(String hidjqxTime) {
		this.hidjqxTime = hidjqxTime;
	}


	public String getTxtrefno() {
		return txtrefno;
	}


	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}


	public String getJqxResponseTime() {
		return jqxResponseTime;
	}


	public void setJqxResponseTime(String jqxResponseTime) {
		this.jqxResponseTime = jqxResponseTime;
	}


	public String getHidjqxResponseTime() {
		return hidjqxResponseTime;
	}


	public void setHidjqxResponseTime(String hidjqxResponseTime) {
		this.hidjqxResponseTime = hidjqxResponseTime;
	}


	public String getDocno() {
		return docno;
	}


	public void setDocno(String docno) {
		this.docno = docno;
	}


	public String getTxtclientname() {
		return txtclientname;
	}


	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}


	public String getTxtclientdet() {
		return txtclientdet;
	}


	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}


	public int getClientid() {
		return clientid;
	}


	public void setClientid(int clientid) {
		this.clientid = clientid;
	}


	public String getTxtcontactperson() {
		return txtcontactperson;
	}


	public void setTxtcontactperson(String txtcontactperson) {
		this.txtcontactperson = txtcontactperson;
	}


	public String getTxttelnoarea() {
		return txttelnoarea;
	}


	public void setTxttelnoarea(String txttelnoarea) {
		this.txttelnoarea = txttelnoarea;
	}


	public String getTxtprojectowner() {
		return txtprojectowner;
	}


	public void setTxtprojectowner(String txtprojectowner) {
		this.txtprojectowner = txtprojectowner;
	}


	public int getProjectownerid() {
		return projectownerid;
	}


	public void setProjectownerid(int projectownerid) {
		this.projectownerid = projectownerid;
	}


	public String getTxtvendor() {
		return txtvendor;
	}


	public void setTxtvendor(String txtvendor) {
		this.txtvendor = txtvendor;
	}


	public int getVendorid() {
		return vendorid;
	}


	public void setVendorid(int vendorid) {
		this.vendorid = vendorid;
	}


	public String getTxtsubsupplier() {
		return txtsubsupplier;
	}


	public void setTxtsubsupplier(String txtsubsupplier) {
		this.txtsubsupplier = txtsubsupplier;
	}


	public int getSubvendorid() {
		return subvendorid;
	}


	public void setSubvendorid(int subvendorid) {
		this.subvendorid = subvendorid;
	}


	public String getMode() {
		return mode;
	}


	public void setMode(String mode) {
		this.mode = mode;
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


	public String getDeleted() {
		return deleted;
	}


	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	
	
	

}
