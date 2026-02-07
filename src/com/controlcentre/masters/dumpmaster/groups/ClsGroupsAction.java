package com.controlcentre.masters.dumpmaster.groups;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

 
	public class ClsGroupsAction {

		ClsGroupsDAO groupDAO= new ClsGroupsDAO();
		ClsCommon ClsCommon=new ClsCommon();
		private int docno;
		private String txtname;
		private String mode;
		private String delete;
		private String msg;
		private String formdetail;
		private String formdetailcode;
		private String chkstatus;
		
		public int getDocno() {
			return docno;
		}


		public void setDocno(int docno) {
			this.docno = docno;
		}


		


		public String getTxtname() {
			return txtname;
		}


		public void setTxtname(String txtname) {
			this.txtname = txtname;
		}


		


		public String getMode() {
			return mode;
		}


		public void setMode(String mode) {
			this.mode = mode;
		}


		public String getDelete() {
			return delete;
		}


		public void setDelete(String delete) {
			this.delete = delete;
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

			if(mode.equalsIgnoreCase("A")){
				
							int val=groupDAO.insert(getTxtname(),session,getMode(),getFormdetailcode());
							if(val>0){
								setTxtname(getTxtname());
								setDocno(val);
								setMsg("Successfully Saved");
								return "success";
							}
							else if(val==-1){
								setTxtname(getTxtname());
								setDocno(val);
								setChkstatus("1");
								setMsg("Name Already Exists.");
								return "fail";
							}
							
							
							else{
								setTxtname(getTxtname());
								setDocno(val);
								setMsg("Not Saved");
								return "fail";
							}	
			}
			
			else if(mode.equalsIgnoreCase("E")){
				int Status=groupDAO.edit(getTxtname(),getDocno(),session,getMode(),getFormdetailcode());
				if(Status>0){
					setTxtname(getTxtname());
					setDocno(getDocno());
					setMode(getMode());
					setMsg("Updated Successfully");
					
					return "success";
				}
				else if(Status==-1){
					setTxtname(getTxtname());
					setDocno(getDocno());
					setMode(getMode());
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				
				
				else{

					setTxtname(getTxtname());
					setDocno(getDocno());
					setMode(getMode());
					setMsg("Not Updated");
					return "fail";
				}
				

			}
			
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=groupDAO.delete(getDocno(),session,getMode(),getFormdetailcode());
			if(Status){
				setTxtname(getTxtname());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Successfully Deleted");
				
				return "success";
			}
			else{
				setTxtname(getTxtname());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}
		
  }

	
