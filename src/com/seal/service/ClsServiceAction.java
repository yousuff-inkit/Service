package com.seal.service;

import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsServiceAction {
	ClsServiceDAO serviceDAO= new ClsServiceDAO();    
	ClsCommon com=new ClsCommon();
	ClsServiceBean pintbean= new ClsServiceBean(); 
	ClsConnection conobj=new ClsConnection();
	
	private String txtdate,txtservice,txtacc,txtbillmethod,hidtxtbillmethod,txtdescription,accdocno,mode,msg,deleted,formdetail,formdetailcode,hiddate;
	private int docno,masterdoc_no;

	    public String getTxtacc() {
		return txtacc;
	}

	public void setTxtacc(String txtacc) {
		this.txtacc = txtacc;
	}

		public String getTxtdate() {
		return txtdate;
	}

	public void setTxtdate(String txtdate) {
		this.txtdate = txtdate;
	}

		public String getHiddate() {
		return hiddate;
	}

	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

		
		public String getTxtservice() {
		return txtservice;
	}

	public void setTxtservice(String txtservice) {
		this.txtservice = txtservice;
	}

	public String getTxtbillmethod() {
		return txtbillmethod;
	}

	public void setTxtbillmethod(String txtbillmethod) {
		this.txtbillmethod = txtbillmethod;
	}

	public String getHidtxtbillmethod() {
		return hidtxtbillmethod;
	}

	public void setHidtxtbillmethod(String hidtxtbillmethod) {
		this.hidtxtbillmethod = hidtxtbillmethod;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public String getAccdocno() {
		return accdocno;
	}

	public void setAccdocno(String accdocno) {
		this.accdocno = accdocno;
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

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

		public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

		public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

		public String saveAction() throws ParseException, SQLException{  
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			String mode=getMode();  
			java.sql.Date sqlStartDate = null;
			System.out.println("IN ACTION");
			System.out.println("==="+getMasterdoc_no());
			System.out.println(getTxtdate()+"==="+getMode());  
			if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("D")){
				  sqlStartDate = com.changeStringtoSqlDate(getTxtdate());
			}
			
			
			if(mode.equalsIgnoreCase("A")){            
				int val=serviceDAO.insert(sqlStartDate,getTxtservice(),getTxtbillmethod(),getAccdocno(),getTxtdescription(),session,getMode(),request,getFormdetailcode());
				int vdocno=Integer.parseInt(request.getAttribute("vocno").toString());      
				System.out.println("==="+val);
				if(val>0){ 
					setData();
					setHiddate(sqlStartDate+"");
					setDocno(vdocno);
					setMasterdoc_no(val);  
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setData();
					setDocno(vdocno);
					setMasterdoc_no(val); 
					setMsg("Not Saved");
					return "fail";
				}
			}
				
				else if(mode.equalsIgnoreCase("E")){
					boolean Status=serviceDAO.edit(sqlStartDate,getTxtservice(),getTxtbillmethod(),getAccdocno(),getTxtdescription(),session,getMode(),request,getFormdetailcode(),getMasterdoc_no(),getDocno());
							
						if(Status){
					    setData();
						setAccdocno(getAccdocno());
						setHiddate(getHiddate());
						setTxtservice(getTxtservice());
						setMsg("Updated Successfully");
						return "success";
					}
					else{
						setData();
						setAccdocno(getAccdocno());
						setHiddate(getHiddate());
						setTxtservice(getTxtservice());
						setMsg("Not Updated");
						return "fail";
					}
				}				
						else if(mode.equalsIgnoreCase("D")){
							boolean Status=serviceDAO.delete(sqlStartDate,getTxtservice(),getTxtbillmethod(),getAccdocno(),getTxtdescription(),session,getMode(),request,getFormdetailcode(),getMasterdoc_no(),getDocno());
							
							if(Status){
								setData();
								setAccdocno(getAccdocno());
								setHiddate(getHiddate());
								setTxtservice(getTxtservice());
								setDeleted("DELETED");
								setMsg("Successfully Deleted");
								return "success";
							}
							else{
								setData();
								setAccdocno(getAccdocno());
								setHiddate(getHiddate());
								setTxtservice(getTxtservice());
								setData();
								setMsg("Not Deleted");
								return "fail";
							}
							
              }
			
				else if(mode.equalsIgnoreCase("View")){
					

					pintbean=serviceDAO.getViewDetails(session,getMasterdoc_no());
					setHiddate(pintbean.getHiddate());
					setAccdocno(pintbean.getAccdocno());
					setTxtservice(pintbean.getTxtservice());
					setHidtxtbillmethod(pintbean.getHidtxtbillmethod());
					setTxtdescription(pintbean.getTxtdescription());
					setTxtacc(pintbean.getTxtacc());
					return "success";
					}
			
			
			
			
			
			return "fail";  
      }
	public void setData(){
		setAccdocno(getAccdocno());
		setTxtservice(getTxtservice());
		setHidtxtbillmethod(getTxtbillmethod());
		setTxtdescription(getTxtdescription());
		setTxtacc(getTxtacc());
	}	
		
}
