package com.seal.servicecontract;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
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

import org.apache.http.HttpRequest;
import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mysql.jdbc.Statement;
import com.project.execution.quotation.ClsQuotationBean;
import com.project.execution.quotation.ClsQuotationDAO;
public class ClsServiceContractAction {

	ClsCommon com=new ClsCommon();
	ClsServiceContractBean bean=new ClsServiceContractBean();
 
	private String docno,date,txtclient,txtclientdet,txtmob1,txtmob2,txtemail,txtcontact,currencyid,stdate,enddate,txtrate1,
    mode,msg,deleted,formdetailcode,hidcmbcurrencyid,cmbvattype,hidcmbvattype,txtsalman,hiddate,hidstdate,hidenddate;
	
    private int masterdoc_no,seronelen,seryearlen,clientid,cpersonid,salid;       
    
    
	public String getTxtrate1() {  
		return txtrate1;
	}
	public void setTxtrate1(String txtrate1) {
		this.txtrate1 = txtrate1;
	}
	public String getHiddate() {    
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getHidstdate() {
		return hidstdate;
	}
	public void setHidstdate(String hidstdate) {
		this.hidstdate = hidstdate;
	}
	public String getHidenddate() {
		return hidenddate;
	}
	public void setHidenddate(String hidenddate) {
		this.hidenddate = hidenddate;
	}
	public String getTxtsalman() {   
		return txtsalman;
	}
	public void setTxtsalman(String txtsalman) {
		this.txtsalman = txtsalman;
	}
	public String getCurrencyid() {
		return currencyid;
	}
	public void setCurrencyid(String currencyid) {
		this.currencyid = currencyid;
	}
	public String getHidcmbcurrencyid() {
		return hidcmbcurrencyid;
	}
	public void setHidcmbcurrencyid(String hidcmbcurrencyid) {
		this.hidcmbcurrencyid = hidcmbcurrencyid;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}
	public String getTxtmob1() {
		return txtmob1;
	}
	public void setTxtmob1(String txtmob1) {
		this.txtmob1 = txtmob1;
	}
	public String getTxtmob2() {
		return txtmob2;
	}
	public void setTxtmob2(String txtmob2) {
		this.txtmob2 = txtmob2;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtcontact() {
		return txtcontact;
	}
	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}
	public String getStdate() {
		return stdate;
	}
	public void setStdate(String stdate) {
		this.stdate = stdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
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
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getCmbvattype() {
		return cmbvattype;
	}
	public void setCmbvattype(String cmbvattype) {
		this.cmbvattype = cmbvattype;
	}
	public String getHidcmbvattype() {
		return hidcmbvattype;
	}
	public void setHidcmbvattype(String hidcmbvattype) {
		this.hidcmbvattype = hidcmbvattype;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getSeronelen() {
		return seronelen;
	}
	public void setSeronelen(int seronelen) {
		this.seronelen = seronelen;
	}
	public int getSeryearlen() {
		return seryearlen;
	}
	public void setSeryearlen(int seryearlen) {
		this.seryearlen = seryearlen;
	}
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
	}
	public int getSalid() {
		return salid;
	}
	public void setSalid(int salid) {
		this.salid = salid;
	}
	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}  
 
	public String saveAction(){
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="";
		int val=0;

		//System.out.println("inside saveaction"+getMode());
		java.sql.Date date = null;
		java.sql.Date stdate = null;
		java.sql.Date enddate = null;
		try{
			if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("D")) {
				date = com.changeStringtoSqlDate(getDate());
				stdate = com.changeStringtoSqlDate(getStdate());
				enddate = com.changeStringtoSqlDate(getEnddate());
			}   
			  
			ArrayList seronelist=new ArrayList();
			ArrayList seryearlist=new ArrayList();

			if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E")) {
				for(int i=0;i<getSeronelen();i++){
					String temp=requestParams.get("serone"+i)[0];		
					seronelist.add(temp); 
				}

				for(int i=0;i<getSeryearlen();i++){
					String temp=requestParams.get("seryear"+i)[0];		
					seryearlist.add(temp);  
				}   	
			}

			ClsServiceContractDAO DAO=new ClsServiceContractDAO();

			if(mode.equalsIgnoreCase("A")){ 

				val=DAO.insert(date,stdate,enddate,session,request,mode,getFormdetailcode(),getClientid(),getCpersonid(),getSalid(),getCurrencyid(),getCmbvattype(),seronelist,seryearlist,getTxtrate1());
  
				int docno=Integer.parseInt(request.getAttribute("docNo").toString());

				if(val>0){
					setData();
					setMasterdoc_no(docno);
					setDocno(val+"");
					setHiddate(date+"");
					setHidenddate(enddate+"");   
					setHidstdate(stdate+"");
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setData();
					setDocno(val+"");
					setHiddate(date+"");
					setHidenddate(enddate+"");   
					setHidstdate(stdate+"");
					setMsg("Not Saved");
					returns="fail";
				}
			}else if(mode.equalsIgnoreCase("E")){

				val = DAO.edit(getMasterdoc_no(),Integer.parseInt(getDocno()),date,stdate,enddate,session,request,mode,getFormdetailcode(),getClientid(),getCpersonid(),getSalid(),getCurrencyid(),getCmbvattype(),seronelist,seryearlist,getTxtrate1());

				if(val>0){  
					setData();
					setMasterdoc_no(getMasterdoc_no());
					setDocno(getDocno());   
					setHiddate(date+"");
					setHidenddate(enddate+"");   
					setHidstdate(stdate+"");
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					setData();
					setDocno(val+"");
					setHiddate(date+"");
					setHidenddate(enddate+"");   
					setHidstdate(stdate+"");
					returns="fail";
				}
			}else if(mode.equalsIgnoreCase("D")){ 
				val=DAO.delete(getMasterdoc_no(),Integer.parseInt(getDocno()),session,request,mode);  

				if(val>0){
					setData();
					setMasterdoc_no(getMasterdoc_no());
					setDocno(getDocno());   
					setHiddate(date+"");
					setHidenddate(enddate+"");   
					setHidstdate(stdate+"");
					setMsg("Successfully Deleted");
					setDeleted("DELETED");
					returns="success";
				}
				else{
					setData();
					setMasterdoc_no(getMasterdoc_no());  
					setDocno(getDocno());
					setHiddate(date+"");
					setHidenddate(enddate+"");   
					setHidstdate(stdate+"");
					setMsg("Not Deleted");
					returns="fail";
				}
			}else if(mode.equalsIgnoreCase("view")){
				bean=DAO.getViewdetails(session,request,getDocno());	
				setClientid(bean.getClientid());
				setDocno(bean.getDocno());
				setMasterdoc_no(bean.getMasterdoc_no());
				setHiddate(bean.getHiddate());   
				setTxtclient(bean.getTxtclient());
				setTxtcontact(bean.getTxtcontact());
				setCpersonid(bean.getCpersonid());
				setHidstdate(bean.getHidstdate());     
				setHidenddate(bean.getHidenddate());
				setTxtclientdet(bean.getTxtclientdet());  
				setTxtmob1(bean.getTxtmob1());
				setTxtmob2(bean.getTxtmob2());
				setTxtemail(bean.getTxtemail());
				setSalid(bean.getSalid());
				setTxtclientdet(bean.getTxtclientdet());    
				setHidcmbcurrencyid(bean.getHidcmbcurrencyid());      
				setHidcmbvattype(bean.getHidcmbvattype());
				setTxtrate1(bean.getTxtrate1());  
				System.out.println(getTxtrate1());   
				returns="success";
			}else {}  
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return returns;
	}
	public void setData() {
		setClientid(getClientid());
		setCurrencyid(getCurrencyid());
		setHidcmbcurrencyid(getCurrencyid());
		setHidcmbvattype(getCmbvattype());
		setTxtclientdet(getTxtclientdet());  
		setTxtmob1(getTxtmob1());
		setTxtmob2(getTxtmob2());
		setTxtemail(getTxtemail());
		setSalid(getSalid());   
		setTxtclient(getTxtclient());
		setTxtcontact(getTxtcontact());
		setCpersonid(getCpersonid());
		setTxtsalman(getTxtsalman());   
		setTxtrate1(getTxtrate1());
	}
	
}
