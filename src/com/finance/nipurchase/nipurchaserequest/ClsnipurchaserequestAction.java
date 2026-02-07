package com.finance.nipurchase.nipurchaserequest;


import java.io.IOException;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceBean;
import com.procurement.purchase.purchaseinvoice.ClspurchaseinvoiceDAO;

@SuppressWarnings("serial")
public class ClsnipurchaserequestAction extends ActionSupport{
	
		ClsnipurchaserequestDAO purorderDAO= new ClsnipurchaserequestDAO(); 
		ClsnipurchaserequestBean viewobj= new ClsnipurchaserequestBean();
		
		ClsCommon commDAO=new ClsCommon();
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
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
			String mode=getMode();
			
	if(mode.equalsIgnoreCase("A")){
		java.sql.Date sqlStartDate1 = commDAO.changeStringtoSqlDate(getNipurchaserequestdate());
		ArrayList<String> descarray= new ArrayList<>();
		for(int i=0;i<getDescgridlenght();i++){
			String temp2=requestParams.get("desctest"+i)[0];
			descarray.add(temp2);
		}
		int val=purorderDAO.insert(sqlStartDate1,getRequestedby(),getPurdesc(),session,getMode(),descarray,getFormdetailcode(),request);
		int vdocno=(int) request.getAttribute("vocno");
		if(val>0){
			setHidnipurchaserequestdate(sqlStartDate1.toString());
			setRequestedby(getRequestedby());
			setPurdesc(getPurdesc());
			setDocno(vdocno);
			setMasterdoc_no(val);
		
			setMsg("Successfully Saved");
			return "success";
		}
		else{
			setHidnipurchaserequestdate(sqlStartDate1.toString());
			setRequestedby(getRequestedby());
			setPurdesc(getPurdesc());
			setDocno(vdocno);
			setMasterdoc_no(val);
			setMsg("Not Saved");
			return "fail";
		}
	}

   
		else if(mode.equalsIgnoreCase("E")){
			java.sql.Date sqlStartDate1 = commDAO.changeStringtoSqlDate(getNipurchaserequestdate());
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getDescgridlenght();i++){
				String temp2=requestParams.get("desctest"+i)[0];
				descarray.add(temp2);
			 
			}
			
			boolean Status=purorderDAO.edit(getMasterdoc_no(),sqlStartDate1,getRequestedby(),getPurdesc(),session,getMode(),descarray,getFormdetailcode());
			if(Status){
				
				setHidnipurchaserequestdate(sqlStartDate1.toString());
				setRequestedby(getRequestedby());
			    setPurdesc(getPurdesc());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setMsg("Updated Successfully");
				return "success";
			
			}
			else{
				setHidnipurchaserequestdate(sqlStartDate1.toString());
				setRequestedby(getRequestedby());
			    setPurdesc(getPurdesc());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setMsg("Not Updated");
				return "fail";
			}
		}
	else if(mode.equalsIgnoreCase("D")){
			boolean Status=purorderDAO.delete(getMasterdoc_no(),session,getMode(),getFormdetailcode());
		if(Status){
			setRequestedby(getRequestedby());
		    setPurdesc(getPurdesc());
			setDocno(getDocno());
			setMasterdoc_no(getMasterdoc_no());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
		    setPurdesc(getPurdesc());
			setDocno(getDocno());
			setMsg("Not Deleted");
			return "fail";
		}
	
	}
	
	else if(mode.equalsIgnoreCase("view")){
		 viewobj=purorderDAO.getViewDetails(getDocno(),session);
		 
		 setHidnipurchaserequestdate(viewobj.getHidnipurchaserequestdate());
		 setRequestedby(viewobj.getRequestedby());
		 setPurdesc(viewobj.getPurdesc());
		 setDocno(viewobj.getDocno());
		 setMasterdoc_no(viewobj.getMasterdoc_no());
		
}

	
return "fail";	
	
}
		
		
}
