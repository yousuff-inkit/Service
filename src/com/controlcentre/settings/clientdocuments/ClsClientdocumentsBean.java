package com.controlcentre.settings.clientdocuments;

import java.util.Date;

public class ClsClientdocumentsBean {

	private String txtdocument;
	private String remarks;
    private Date date;
	public String getTxtdocument() {
		return txtdocument;
	}
	public void setTxtdocument(String txtdocument) {
		this.txtdocument = txtdocument;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	private int docno;
    private String mode;
}
