package com.aviation.port;

import java.util.Date;

public class ClsPortBean {
	private int masterdoc_no,docno;
	private String hidPortDate,port,portname,country;
	private Date PortDate;
	private String msg,formdetailcode,mode;
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public Date getPortDate() {
		return PortDate;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getPortname() {
		return portname;
	}
	public void setPortname(String portname) {
		this.portname = portname;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public void setPortDate(Date portDate) {
		PortDate = portDate;
	}
	public String getHidPortDate() {
		return hidPortDate;
	}
	public void setHidPortDate(String hidPortDate) {
		this.hidPortDate = hidPortDate;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
}
