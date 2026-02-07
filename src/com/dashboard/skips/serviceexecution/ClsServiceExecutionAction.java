package com.dashboard.skips.serviceexecution;

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
public class ClsServiceExecutionAction {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon common =new ClsCommon();
	ClsServiceExecutionDAO DAO= new ClsServiceExecutionDAO();  
	private String formcode;
	private String msg;
	private String detail;
	private String detailname,hidrowno,hidsrno,hidcontrno,mode,hidbrhid,cmbslno;    
	public String getCmbslno() {
		return cmbslno;
	}
	public void setCmbslno(String cmbslno) {
		this.cmbslno = cmbslno;
	}
	public String getHidbrhid() {
		return hidbrhid;
	}
	public void setHidbrhid(String hidbrhid) {
		this.hidbrhid = hidbrhid;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	private int schgridlength;                 
	public String getHidsrno() {
		return hidsrno;
	}
	public void setHidsrno(String hidsrno) {
		this.hidsrno = hidsrno;
	}
	public String getHidcontrno() {
		return hidcontrno;
	}
	public void setHidcontrno(String hidcontrno) {
		this.hidcontrno = hidcontrno;
	}
	public int getSchgridlength() {
		return schgridlength;
	}
	public void setSchgridlength(int schgridlength) {
		this.schgridlength = schgridlength;
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
    private Map<String, Object> param=null; 
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String saveSchAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
        String mode=getMode();  
		Map<String, String[]> requestParams = request.getParameterMap();
		ArrayList<String> schedulearray= new ArrayList<>();
		Connection conn =null;
		String retunrns="";
		String invno="";
		try{
			int val=1;  
			//System.out.println("IN SCHEDULE ACTION");
			if(mode.equalsIgnoreCase("SCH")){   
				for(int i=0;i<getSchgridlength();i++){  
					String temp2=requestParams.get("contrtest"+i)[0];   
					schedulearray.add(temp2);  
				}   
				val=DAO.insert(getHidrowno(),getHidbrhid(),getHidcontrno(),getHidsrno(),getCmbslno(),schedulearray,session,request);       
				if(val>0){  
					setMsg("Successfully Saved"); 
					retunrns="success";
				}else if(val<=0){
					setMsg("Not Saved");   
					retunrns="fail";
				}
			} 
		}  
		catch(Exception e){
			e.printStackTrace();
		}
		return retunrns;
	}
}
