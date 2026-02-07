package com.dashboard.audit.contractservicesiteupdate;

import java.sql.*;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;
import com.mailwithpdf.EmailProcess;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsContractServiceSiteUpdateAction extends ActionSupport {
	ClsContractServiceSiteUpdateDAO DAO=new ClsContractServiceSiteUpdateDAO();
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon(); 
	
	private String mode,msg; 
	
	private String txtselectedcontract,txtselectedcontractdtype,srvcinterval,cmbsrvctype,serdueafter,serdate,txteditrval,txteditrfillval,detail,detailname,deldoc; 
	
	private int gridlength;
	
	public String getDeldoc() {
		return deldoc;
	}

	public void setDeldoc(String deldoc) {
		this.deldoc = deldoc;
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
	
	public String getTxtselectedcontract() {
		return txtselectedcontract;
	}

	public void setTxtselectedcontract(String txtselectedcontract) {
		this.txtselectedcontract = txtselectedcontract;
	}

	public String getTxtselectedcontractdtype() {
		return txtselectedcontractdtype;
	}

	public void setTxtselectedcontractdtype(String txtselectedcontractdtype) {
		this.txtselectedcontractdtype = txtselectedcontractdtype;
	}

	public String getSrvcinterval() {
		return srvcinterval;
	}

	public void setSrvcinterval(String srvcinterval) {
		this.srvcinterval = srvcinterval;
	}

	public String getCmbsrvctype() {
		return cmbsrvctype;
	}

	public void setCmbsrvctype(String cmbsrvctype) {
		this.cmbsrvctype = cmbsrvctype;
	}

	public String getSerdueafter() {
		return serdueafter;
	}

	public void setSerdueafter(String serdueafter) {
		this.serdueafter = serdueafter;
	}

	public String getSerdate() {
		return serdate;
	}

	public void setSerdate(String serdate) {
		this.serdate = serdate;
	}

	public String getTxteditrval() {
		return txteditrval;
	}

	public void setTxteditrval(String txteditrval) {
		this.txteditrval = txteditrval;
	}

	public String getTxteditrfillval() {
		return txteditrfillval;
	}

	public void setTxteditrfillval(String txteditrfillval) {
		this.txteditrfillval = txteditrfillval;
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
	
	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	
	public String saveAction() throws ParseException, SQLException{   
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();

		if(mode.equalsIgnoreCase("A")){      
			ArrayList sitelist=new ArrayList();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("site"+i)[0];		
				sitelist.add(temp);
			}
			
			int val=DAO.insert(getTxtselectedcontract(), sitelist, session, request);       
			if(val>0){ 
				 setDetail("Audit");
			    setDetailname("Contract Site Update");
				setMsg("Successfully Saved");            
				return "success";
			}
			else{   
				setDetail("Audit");
			    setDetailname("Contract Site Update");   
			    setMsg("Not Saved");  
				return "fail";
			}	
		}    
		return "fail";	    
	}

}
