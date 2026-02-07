package com.cargo.place;

import java.util.Date;

public class ClsPlaceBean {
	private int masterdoc_no,docno;
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
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
	public String getCmbcountry() {
		return cmbcountry;
	}
	public void setCmbcountry(String cmbcountry) {
		this.cmbcountry = cmbcountry;
	}
	public String getHidcmbcountry() {
		return hidcmbcountry;
	}
	public void setHidcmbcountry(String hidcmbcountry) {
		this.hidcmbcountry = hidcmbcountry;
	}
	public Date getPlaceDate() {
		return PlaceDate;
	}
	public void setPlaceDate(Date placeDate) {
		PlaceDate = placeDate;
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
	private String code,name,cmbcountry,hidcmbcountry;
	private Date PlaceDate;
	private String msg,formdetailcode,mode,srchcountry;
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getSrchcountry() {
		return srchcountry;
	}
	public void setSrchcountry(String srchcountry) {
		this.srchcountry = srchcountry;
	}
}
