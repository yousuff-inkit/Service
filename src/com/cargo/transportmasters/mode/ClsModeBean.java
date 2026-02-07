package com.cargo.transportmasters.mode;
import java.util.*;

import com.common.ClsCommon;
public class ClsModeBean {
	
	
	
	private int docno;
	private String modedate,chksubmode,chkhidmode;
	private String modeid;
	private String mode;
	private String deleted;
	public String getChksubmode() {
		return chksubmode;
	}
	public void setChksubmode(String chksubmode) {
		this.chksubmode = chksubmode;
	}
	public String getChkhidmode() {
		return chkhidmode;
	}
	public void setChkhidmode(String chkhidmode) {
		this.chkhidmode = chkhidmode;
	}
	private String msg;
	private String formdetail;
	private String formdetailcode;
	
	
	
	
		
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getModedate() {
		return modedate;
	}
	public void setModedate(String modedate) {
		this.modedate = modedate;
	}
	public String getModeid() {
		return modeid;
	}
	public void setModeid(String modeid) {
		this.modeid = modeid;
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
	
}
