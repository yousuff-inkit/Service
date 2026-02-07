package com.humanresource.transactions.appraisal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
 
	public class ClsAppraisalAction {

		ClsCommon ClsCommon=new ClsCommon();


	private String  masterdate,hidmasterdate,leastpaydate,hidleastpaydate,empid,empname,joindate,hidjoindate,prevappdate,hidprevappdate,deprtment,designation,
    category,desc, mode, deleted ,msg,formdetailcode;
 
	private int hidcmbyear,hidcmbmonth,docno, empdocno,  hidcmbdept, hiddeprtment,hiddesignation,
	hidcategory,change,hidcmbcategory,hidchange,hidcmbdesignation,compensationGridlength,cmbyear,cmbmonth,cmbdept,cmbdesignation,cmbcategory;
	
	ClsAppraisalDAO saveDAO= new ClsAppraisalDAO();
	ClsAppraisalBean viewDAO= new ClsAppraisalBean();
	
	public String getMasterdate() {
		return masterdate;
	}
	public void setMasterdate(String masterdate) {
		this.masterdate = masterdate;
	}
	public String getHidmasterdate() {
		return hidmasterdate;
	}
	public void setHidmasterdate(String hidmasterdate) {
		this.hidmasterdate = hidmasterdate;
	}
	public String getLeastpaydate() {
		return leastpaydate;
	}
	public void setLeastpaydate(String leastpaydate) { 
		this.leastpaydate = leastpaydate;
	}
	public String getHidleastpaydate() {
		return hidleastpaydate;
	}
	public void setHidleastpaydate(String hidleastpaydate) {
		this.hidleastpaydate = hidleastpaydate;
	}
	public String getEmpid() {  
		return empid;
	}
	public void setEmpid(String empid) { 
		this.empid = empid;
	}
	public String getEmpname() {
		return empname;
	}
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getHidjoindate() {
		return hidjoindate;
	}
	public void setHidjoindate(String hidjoindate) {  
		this.hidjoindate = hidjoindate;
	}
	public String getPrevappdate() {
		return prevappdate;
	}
	public void setPrevappdate(String prevappdate) {
		this.prevappdate = prevappdate;
	}
	public String getHidprevappdate() {
		return hidprevappdate;
	}
	public void setHidprevappdate(String hidprevappdate) {    
		this.hidprevappdate = hidprevappdate;
	}
	public String getDeprtment() {  
		return deprtment;
	}
	public void setDeprtment(String deprtment) {
		this.deprtment = deprtment;
	}
	public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getCmbdept() {                        
		return cmbdept;
	}
	public void setCmbdept(int cmbdept) {
		this.cmbdept = cmbdept;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
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
	public int getHidcmbyear() {
		return hidcmbyear;
	}
	public void setHidcmbyear(int hidcmbyear) {      
		this.hidcmbyear = hidcmbyear;
	}
	public int getHidcmbmonth() {
		return hidcmbmonth;
	}
	public void setHidcmbmonth(int hidcmbmonth) {
		this.hidcmbmonth = hidcmbmonth;
	}
	public int getDocno() {   
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getEmpdocno() {
		return empdocno;
	}
	public void setEmpdocno(int empdocno) {
		this.empdocno = empdocno;
	}
	public int getHidcmbdept() {
		return hidcmbdept;
	}
	public void setHidcmbdept(int hidcmbdept) {
		this.hidcmbdept = hidcmbdept;
	}
	public int getHiddeprtment() {
		return hiddeprtment;
	}
	public void setHiddeprtment(int hiddeprtment) {
		this.hiddeprtment = hiddeprtment;
	}
	public int getHiddesignation() {
		return hiddesignation;
	}
	public void setHiddesignation(int hiddesignation) {
		this.hiddesignation = hiddesignation;
	}
	public int getHidcategory() {
		return hidcategory;
	}
	public void setHidcategory(int hidcategory) {
		this.hidcategory = hidcategory;
	}
	public int getCmbdesignation() {                  
		return cmbdesignation;
	}
	public void setCmbdesignation(int cmbdesignation) {
		this.cmbdesignation = cmbdesignation;
	}
	public int getCmbcategory() {
		return cmbcategory;
	}
	public void setCmbcategory(int cmbcategory) {
		this.cmbcategory = cmbcategory;
	}
	public int getChange() {
		return change;
	}
	public void setChange(int change) {
		this.change = change;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public int getHidcmbcategory() {
		return hidcmbcategory;
	}
	public void setHidcmbcategory(int hidcmbcategory) {
		this.hidcmbcategory = hidcmbcategory;
	}
	public int getHidchange() {
		return hidchange;
	}
	public void setHidchange(int hidchange) {
		this.hidchange = hidchange;
	}
	public int getCompensationGridlength() {
		return compensationGridlength;
	}
	public void setCompensationGridlength(int compensationGridlength) {
		this.compensationGridlength = compensationGridlength;
	}
	public int getHidcmbdesignation() {
		return hidcmbdesignation;
	}
	public void setHidcmbdesignation(int hidcmbdesignation) {
		this.hidcmbdesignation = hidcmbdesignation;
	}
	public int getCmbyear() {
		return cmbyear;
	}
	public void setCmbyear(int cmbyear) {
		this.cmbyear = cmbyear;
	}
	public int getCmbmonth() {
		return cmbmonth;
	}
	public void setCmbmonth(int cmbmonth) {
		this.cmbmonth = cmbmonth;
	}

	public String saveAction() throws SQLException {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap(); 
		
		if(getMode().equalsIgnoreCase("A")) {
	 
		java.sql.Date masterdate=	ClsCommon.changeStringtoSqlDate(getMasterdate());
		java.sql.Date payroldate=	ClsCommon.changeStringtoSqlDate(getLeastpaydate());
		java.sql.Date joindate=	ClsCommon.changeStringtoSqlDate(getJoindate());
		java.sql.Date appdate=	ClsCommon.changeStringtoSqlDate(getPrevappdate());
		
	 	ArrayList<String> comparray= new ArrayList<>();
		for(int i=0;i<getCompensationGridlength() ;i++){
			String temp1=requestParams.get("test"+i)[0];
			comparray.add(temp1);
		}
	 
		int val=saveDAO.insert(getCmbyear(),getCmbmonth(),masterdate,payroldate,appdate,getEmpdocno(),getHiddeprtment(),getHiddesignation(),getHidcategory(),
					getCmbdept(),getCmbdesignation(),getCmbcategory(),getDesc(),getChange(),getFormdetailcode(),getMode(),request,session,comparray);
			
		if(val>0) {
				
				 setDocno(val);
				 setEmpid(getEmpid());
				 setEmpdocno(getEmpdocno());
				 setEmpname(getEmpname());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setDeprtment(getDeprtment());
				 setHiddeprtment(getHiddeprtment());
				 setDesignation(getDesignation());
				 setHiddesignation(getHiddesignation());        	   
				 setCategory(getCategory());
				 setHidcategory(getHidcategory());
				 setHidchange(getChange());
		         setHidcmbdept(getCmbdept());
		         setHidcmbdesignation(getCmbdesignation());
		         setHidcmbcategory(getCmbcategory());
		         setDesc(getDesc());
		         setHidmasterdate(masterdate.toString());
		         setHidleastpaydate(payroldate.toString());
		         setHidjoindate(joindate.toString());
		         setHidprevappdate(appdate.toString());

		         setMsg("Successfully Saved");
				 return "success";
				
			} else {

				 setEmpid(getEmpid());
				 setEmpdocno(getEmpdocno());
				 setEmpname(getEmpname());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setDeprtment(getDeprtment());
				 setHiddeprtment(getHiddeprtment());
				 setDesignation(getDesignation());
				 setHiddesignation(getHiddesignation());        	   
				 setCategory(getCategory());
				 setHidcategory(getHidcategory());
				 setHidchange(getChange());
		         setHidcmbdept(getCmbdept());
		         setHidcmbdesignation(getCmbdesignation());
		         setHidcmbcategory(getCmbcategory());
		         setDesc(getDesc());
		         setHidmasterdate(masterdate.toString());
		         setHidleastpaydate(payroldate.toString());
		         setHidjoindate(joindate.toString());
		         setHidprevappdate(appdate.toString());
				  
				 setMsg("Not Saved");
				 return "fail";
				
			}
		}
		
		else if(getMode().equalsIgnoreCase("E")) {
	 
			    java.sql.Date masterdate=	ClsCommon.changeStringtoSqlDate(getMasterdate());
				java.sql.Date payroldate=	ClsCommon.changeStringtoSqlDate(getLeastpaydate());
				java.sql.Date joindate=	ClsCommon.changeStringtoSqlDate(getJoindate());
				java.sql.Date appdate=	ClsCommon.changeStringtoSqlDate(getPrevappdate());
				
			 	ArrayList<String> comparray= new ArrayList<>();
				for(int i=0;i<getCompensationGridlength() ;i++){
					String temp1=requestParams.get("test"+i)[0];
					comparray.add(temp1);
				}

				int val=saveDAO.update(getDocno(),getCmbyear(),getCmbmonth(),masterdate,payroldate,appdate,getEmpdocno(),getHiddeprtment(),getHiddesignation(),getHidcategory(),
							getCmbdept(),getCmbdesignation(),getCmbcategory(),getDesc(),getChange(),getFormdetailcode(),getMode(),request,session,comparray);
					
				if(val>0) {
						
						 setDocno(getDocno());
						 setEmpid(getEmpid());
						 setEmpdocno(getEmpdocno());
						 setEmpname(getEmpname());
						 setHidcmbyear(getCmbyear());
						 setHidcmbmonth(getCmbmonth());
						 setDeprtment(getDeprtment());
						 setHiddeprtment(getHiddeprtment());
						 setDesignation(getDesignation());
						 setHiddesignation(getHiddesignation());        	   
						 setCategory(getCategory());
						 setHidcategory(getHidcategory());
						 setHidchange(getChange());
				         setHidcmbdept(getCmbdept());
				         setHidcmbdesignation(getCmbdesignation());
				         setHidcmbcategory(getCmbcategory());
				         setDesc(getDesc());
				         setHidmasterdate(masterdate.toString());
				         setHidleastpaydate(payroldate.toString());
				         setHidjoindate(joindate.toString());
				         setHidprevappdate(appdate.toString());
				         
				         setMsg("Updated Successfully");
				         return "success";
						
					} else {
						 
						 setDocno(getDocno());
						 setEmpid(getEmpid());
						 setEmpdocno(getEmpdocno());
						 setEmpname(getEmpname());
						 setHidcmbyear(getCmbyear());
						 setHidcmbmonth(getCmbmonth());
						 setDeprtment(getDeprtment());
						 setHiddeprtment(getHiddeprtment());
						 setDesignation(getDesignation());
						 setHiddesignation(getHiddesignation());        	   
						 setCategory(getCategory());
						 setHidcategory(getHidcategory());
						 setHidchange(getChange());
				         setHidcmbdept(getCmbdept());
				         setHidcmbdesignation(getCmbdesignation());
				         setHidcmbcategory(getCmbcategory());
				         setDesc(getDesc());
				         setHidmasterdate(masterdate.toString());
				         setHidleastpaydate(payroldate.toString());
				         setHidjoindate(joindate.toString());
				         setHidprevappdate(appdate.toString());
						  
				         setMsg("Not Updated");
				         return "fail";
						
					}
		}
	 	
		else if(getMode().equalsIgnoreCase("D")) {
	 		 
		 	int val=saveDAO.delete(getDocno(),getMode(),getFormdetailcode(),session,request); 
	 		 
			if(val>0) {
				
				 setDocno(getDocno());
				 setEmpid(getEmpid());
				 setEmpdocno(getEmpdocno());
				 setEmpname(getEmpname());
				 setHidcmbyear(getCmbyear());
				 setHidcmbmonth(getCmbmonth());
				 setDeprtment(getDeprtment());
				 setHiddeprtment(getHiddeprtment());
				 setDesignation(getDesignation());
				 setHiddesignation(getHiddesignation());        	   
				 setCategory(getCategory());
				 setHidcategory(getHidcategory());
				 setHidchange(getChange());
		         setHidcmbdept(getCmbdept());
		         setHidcmbdesignation(getCmbdesignation());
		         setHidcmbcategory(getCmbcategory());
		         setDesc(getDesc());

		         setDeleted("DELETED");
				 setMsg("Successfully Deleted");
				 return "success";
				
			} else {
				 
				setDocno(getDocno());
				setEmpid(getEmpid());
				setEmpdocno(getEmpdocno());
			    setEmpname(getEmpname());
			    setHidcmbyear(getCmbyear());
			    setHidcmbmonth(getCmbmonth());
			    setDeprtment(getDeprtment());
			    setHiddeprtment(getHiddeprtment());
			    setDesignation(getDesignation());
			    setHiddesignation(getHiddesignation());        	   
			    setCategory(getCategory());
			    setHidcategory(getHidcategory());
				setHidchange(getChange());
		        setHidcmbdept(getCmbdept());
		        setHidcmbdesignation(getCmbdesignation());
		        setHidcmbcategory(getCmbcategory());
		        setDesc(getDesc());
		         
				setMsg("Not Deleted");
	            return "fail";
			}
		} 
		
	 	else if(getMode().equalsIgnoreCase("view")) {
	 		
			 viewDAO=saveDAO.getViewDetails(getDocno());
	 
			 setDocno(getDocno());
			 setEmpid(viewDAO.getEmpid());
			 setEmpdocno(viewDAO.getEmpdocno());
			 setEmpname(viewDAO.getEmpname());
			 setHidcmbyear(viewDAO.getCmbyear());
			 setHidcmbmonth(viewDAO.getCmbmonth());
			 setDeprtment(viewDAO.getDeprtment());
			 setHiddeprtment(viewDAO.getHiddeprtment());
			 setDesignation(viewDAO.getDesignation());
			 setHiddesignation(viewDAO.getHiddesignation());        	   
			 setCategory(viewDAO.getCategory());
			 setHidcategory(viewDAO.getHidcategory());
			 setHidchange(viewDAO.getChange());
	         setHidcmbdept(viewDAO.getCmbdept());
	         setHidcmbdesignation(viewDAO.getCmbdesignation());
	         setHidcmbcategory(viewDAO.getCmbcategory());
	         setDesc(viewDAO.getDesc());
	         setHidmasterdate(viewDAO.getMasterdate());
	         setHidleastpaydate(viewDAO.getLeastpaydate());
	         setHidjoindate(viewDAO.getJoindate());
	         setHidprevappdate(viewDAO.getPrevappdate());
			
			 return "success";
			
		}
		return "fail";
	}

}
