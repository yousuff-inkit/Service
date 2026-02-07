package com.dashboard.skips.invoiceproessingnew;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsInvoiceProcessingAction {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon common =new ClsCommon();
	ClsInvoiceProcessingDAO DAO=new ClsInvoiceProcessingDAO();      

	private String formcode;
	private String msg;
	private String detail;
	private String detailname;
	private String invdate;
	private String hidrowno,advance,type,hidservchargechk,hidtfeechk,hidgfeechk;               
	public String getHidservchargechk() {
		return hidservchargechk;
	}
	public void setHidservchargechk(String hidservchargechk) {
		this.hidservchargechk = hidservchargechk;
	}
	public String getHidtfeechk() {
		return hidtfeechk;
	}
	public void setHidtfeechk(String hidtfeechk) {
		this.hidtfeechk = hidtfeechk;
	}
	public String getHidgfeechk() {
		return hidgfeechk;
	}
	public void setHidgfeechk(String hidgfeechk) {
		this.hidgfeechk = hidgfeechk;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAdvance() {
		return advance;
	}
	public void setAdvance(String advance) {
		this.advance = advance;
	}
	public String getHidrowno() {
		return hidrowno;
	}
	public void setHidrowno(String hidrowno) {
		this.hidrowno = hidrowno;
	}
	public String getFormcode() {
		return formcode;
	}
	public void setFormcode(String formcode) {
		this.formcode = formcode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getDetailname() {
		return detailname;
	}
	public void setDetailname(String detailname) {
		this.detailname = detailname;
	}
	public String getInvdate() {
		return invdate;
	}
	public void setInvdate(String invdate) {
		this.invdate = invdate;
	}
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String saveInvAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		Map<String, String[]> requestParams = request.getParameterMap();
		Connection conn =null;
		String retunrns="";
		String invno="";
		try{
			int val=0;
			java.sql.Date sqldate=common.changeStringtoSqlDate(getInvdate());
 
		    val=DAO.insert(sqldate,session,request,getHidrowno(),getType(),getHidservchargechk(),getHidtfeechk(),getHidgfeechk()); 
			if(val>0){  
				setDetail("Operational Accounting");
				setDetailname("Invoice Processing");
				setMsg("Invoice No: "+request.getAttribute("vocnos")+" Successfully Generated"); 
				retunrns="success";
			}else if(val<=0){
				setDetail("Operational Accounting");  
				setDetailname("Invoice Processing");
				setMsg("Invoice Not Generated");
				retunrns="fail";
			}

		}
		catch(Exception e){
			e.printStackTrace();
		}

		return retunrns;

	}

}
