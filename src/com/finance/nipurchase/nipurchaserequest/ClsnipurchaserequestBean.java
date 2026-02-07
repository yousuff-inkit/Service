package com.finance.nipurchase.nipurchaserequest;

import java.util.Map;

public class ClsnipurchaserequestBean {
	
	private String nipurchaserequestdate;
	private String hidnipurchaserequestdate;
	private int  docno,descgridlenght;
	
	private String requestedby,purdesc,mode,msg,formdetailcode;

	private String deleted;
	private int masterdoc_no;

	public String getNipurchaserequestdate() {
		return nipurchaserequestdate;
	}
	
	public void setNipurchaserequestdate(String nipurchaserequestdate) {
		this.nipurchaserequestdate = nipurchaserequestdate;
	}
	
	public String getHidnipurchaserequestdate() {
		return hidnipurchaserequestdate;
	}
	
	public void setHidnipurchaserequestdate(String hidnipurchaserequestdate) {
		this.hidnipurchaserequestdate = hidnipurchaserequestdate;
	}
	
	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}
	
	public String getRequestedby() {
		return requestedby;
	}

	public void setRequestedby(String requestedby) {
		this.requestedby = requestedby;
	}

	public String getPurdesc() {
		return purdesc;
	}
	public void setPurdesc(String purdesc) {
		this.purdesc = purdesc;
	}
	

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getMsg() {
		return msg;
	}
	

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
	public int getDescgridlenght() {
		return descgridlenght;
	}
	
	public void setDescgridlenght(int descgridlenght) {
		this.descgridlenght = descgridlenght;
	}
	
	
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	// form name
	public String getFormdetailcode() {
		return formdetailcode;
	}
	
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

    private Map<String, Object> param=null;
	
	public Map<String, Object> getParam() {
		return param;
	}
	
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
}
