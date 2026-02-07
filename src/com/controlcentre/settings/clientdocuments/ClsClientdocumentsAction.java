package com.controlcentre.settings.clientdocuments;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.controlcentre.settings.activity.ClsActivityBean;

public class ClsClientdocumentsAction {
	
	ClsClientdocumentsDAO DAO= new ClsClientdocumentsDAO();
	
	ClsCommon com= new ClsCommon();
	ClsClientdocumentsBean bean;
	
	private int docno;
	private String txtdocument;
	private String remarks;
	private String date;
	private String mode;
	private String deleted;
	private String datehidden;
	private String msg;
	private String chkstatus;
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public String getDatehidden() {
		return datehidden;
	}
	public void setDatehidden(String datehidden) {
		this.datehidden = datehidden;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	
public String saveAction() throws ParseException, SQLException{
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		ClsClientdocumentsBean bean=new ClsClientdocumentsBean();
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate());
		bean.setTxtdocument(getTxtdocument());
		bean.setRemarks(getRemarks());
		bean.setDate(sqlStartDate);
		bean.setDocno(getDocno());
		bean.setMode(getMode());
		  if(mode.equalsIgnoreCase("A")){
				
				int val=DAO.insert(bean,session,getTxtdocument());
				if(val>0){
					setData();
					setDocno(val);
					setMsg("Successfully Saved");
					
					return "success";
				} else if(val==-1)
				   {
					setData();
					setChkstatus("1");
					setMsg("Document Already Exists");
				    return "fail";
				   }
				else{
					setData();
					setMsg("Not Saved");
					return "fail";
				}	
				
			}
		  else if(mode.equalsIgnoreCase("E")){
	 			
	 			int Status=DAO.edit(bean,session,getDocno(),getTxtdocument());
	 			if(Status>0){
	 				setData();
					setMsg("Updated Successfully");
					return "success";
				}
	 			else if(Status==-1)
				   {
	 				setData();
					setChkstatus("2");
				    setMsg("Document Already Exists");
				    return "fail";
				}
				else{
					setData();
					setMsg("Not Updated");
					return "fail";
				}
			}
	         else if(mode.equalsIgnoreCase("D")){
	 			int Status=DAO.delete(bean,session,getDocno());
	 		if(Status>0){
	 			setData();
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}else if(Status==-1)
			   {
				setData();
				setChkstatus("3");
			    setMsg("Transcation Already Exists, Delete Restricted");
			    return "fail";
			}
			else{
				setData();
				setMsg("Not Deleted");
				return "fail";
			}
			}
		  
		  return "fail";
}

public void setData(){
	    java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getDate());
	    setDate(sqlStartDate.toString());
		setTxtdocument(getTxtdocument());
		setRemarks(getRemarks());
		setDocno(getDocno());
	
}
}
