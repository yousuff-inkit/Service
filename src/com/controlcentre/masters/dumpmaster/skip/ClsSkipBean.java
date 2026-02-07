package com.controlcentre.masters.dumpmaster.skip;

import com.common.ClsCommon;

public class ClsSkipBean {

	
	ClsSkipDAO skipDAO= new ClsSkipDAO();
	ClsCommon ClsCommon=new ClsCommon();
	private int docno;
	private String txtcode;
	private String txtname;
	private String txttechspec;
	private String mode;
	private String delete;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	
	public int getDocno() {
		return docno;
	}


	public void setDocno(int docno) {
		this.docno = docno;
	}


	public String getTxtcode() {
		return txtcode;
	}


	public void setTxtcode(String txtcode) {
		this.txtcode = txtcode;
	}


	public String getTxtname() {
		return txtname;
	}


	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}


	public String getTxttechspec() {
		return txttechspec;
	}


	public void setTxttechspec(String txttechspec) {
		this.txttechspec = txttechspec;
	}


	public String getMode() {
		return mode;
	}


	public void setMode(String mode) {
		this.mode = mode;
	}


	public String getDelete() {
		return delete;
	}


	public void setDelete(String delete) {
		this.delete = delete;
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
	
	
}
