package com.controlcentre.masters.dumpmaster.dump;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

 
	public class ClsDumpAction {

		ClsDumpDAO dumpDAO= new ClsDumpDAO();
		ClsCommon ClsCommon=new ClsCommon();
		private int docno;
		private String txtcode;
		private String txtname;
		private String cmbtype;
		private String hidcmbtype;
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


		public String getTxtcode() {
			return txtcode;
		}


		public void setTxtcode(String txtcode) {
			this.txtcode = txtcode;
		}


		public String getTxtname() {
			return txtname;
		}


		public void setTxtname(String txtname) {
			this.txtname = txtname;
		}


		public String getCmbtype() {
			return cmbtype;
		}


		public void setCmbtype(String cmbtype) {
			this.cmbtype = cmbtype;
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
		public String getHidcmbtype() {
			return hidcmbtype;
		}


		public void setHidcmbtype(String hidcmbtype) {
			this.hidcmbtype = hidcmbtype;
		}
		
		public String saveAction() throws ParseException, SQLException{
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			
			String mode=getMode();

			if(mode.equalsIgnoreCase("A")){
				
							int val=dumpDAO.insert(getTxtcode(), getTxtname(),getCmbtype(),getMode(),session,getFormdetailcode());
							if(val>0){
								setTxtcode(getTxtcode());
								setTxtname(getTxtname());
								setCmbtype(getCmbtype());
								setHidcmbtype(getCmbtype());
								setDocno(val);
								setMsg("Successfully Saved");
								return "success";
							}
							else if(val==-1){
								setTxtcode(getTxtcode());
								setTxtname(getTxtname());
								setCmbtype(getCmbtype());
								setHidcmbtype(getCmbtype());
								setDocno(val);
								setChkstatus("1");
								setMsg("Code Already Exists.");
								return "fail";
							}
							else if(val==-2){
								setTxtcode(getTxtcode());
								setTxtname(getTxtname());
								setCmbtype(getCmbtype());
								setHidcmbtype(getCmbtype());
								setDocno(val);
								setChkstatus("1");
								setMsg("Name Already Exists.");
								return "fail";
							}
							
							else{
								setTxtcode(getTxtcode());
								setTxtname(getTxtname());
								setCmbtype(getCmbtype());
								setHidcmbtype(getCmbtype());
								setDocno(val);
								setMsg("Not Saved");
								return "fail";
							}	
			}
			
			else if(mode.equalsIgnoreCase("E")){
				int Status=dumpDAO.edit(getTxtcode(), getTxtname(),getCmbtype(),getDocno(),getMode(),session,getFormdetailcode());
				if(Status>0){
					setTxtcode(getTxtcode());
					setTxtname(getTxtname());
					setCmbtype(getCmbtype());
					setHidcmbtype(getCmbtype());
					setDocno(getDocno());
					setMode(getMode());
					setMsg("Updated Successfully");
					
					return "success";
				}
				else if(Status==-1){
					setTxtcode(getTxtcode());
					setTxtname(getTxtname());
					setCmbtype(getCmbtype());
					setHidcmbtype(getCmbtype());
					setDocno(getDocno());
					setMode(getMode());
					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				
				else if(Status==-2){
					setTxtcode(getTxtcode());
					setTxtname(getTxtname());
					setCmbtype(getCmbtype());
					setHidcmbtype(getCmbtype());
					setDocno(getDocno());
					setMode(getMode());
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else{

					setTxtcode(getTxtcode());
					setTxtname(getTxtname());
					setCmbtype(getCmbtype());
					setDocno(getDocno());
					setMode(getMode());
					setMsg("Not Updated");
					return "fail";
				}
				

			}
			
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=dumpDAO.delete(getDocno(),session,getMode(),getFormdetailcode());
			if(Status){
				setTxtcode(getTxtcode());
				setTxtname(getTxtname());
				setCmbtype(getCmbtype());
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Successfully Deleted");
				
				return "success";
			}
			else{
				setTxtcode(getTxtcode());
				setTxtname(getTxtname());
				setCmbtype(getCmbtype());
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}
		
		
  }

	
