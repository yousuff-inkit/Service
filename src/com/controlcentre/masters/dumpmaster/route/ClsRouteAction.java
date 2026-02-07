package com.controlcentre.masters.dumpmaster.route;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

 
	public class ClsRouteAction {

		ClsRouteDAO routeDAO= new ClsRouteDAO();
		ClsCommon ClsCommon=new ClsCommon();
		private int docno;
		private String txtcode;
		private String txtname;
		private String txtvehgrp;
		private String vehgrpid;
		private String txtarea;
		private String areaid;
		private String txtdump;
		private String dumpid;
		private String txtdriver;
		
		private String driverid;
		private String txthelper;
		private String helperid;
		private String txthelper2;
		private String helperid2;
		private String txtvehicle;
		private String vehicleid;
		private String mode;
		private String delete;
		private String msg;
		private String formdetail;
		private String formdetailcode;
		private String chkstatus;
		public String getTxtdriver() {
			return txtdriver;
		}


		public void setTxtdriver(String txtdriver) {
			this.txtdriver = txtdriver;
		}


		public String getDriverid() {
			return driverid;
		}


		public void setDriverid(String driverid) {
			this.driverid = driverid;
		}


		public String getTxthelper() {
			return txthelper;
		}


		public void setTxthelper(String txthelper) {
			this.txthelper = txthelper;
		}


		public String getHelperid() {
			return helperid;
		}


		public void setHelperid(String helperid) {
			this.helperid = helperid;
		}


		public String getTxthelper2() {
			return txthelper2;
		}


		public void setTxthelper2(String txthelper2) {
			this.txthelper2 = txthelper2;
		}


		public String getHelperid2() {
			return helperid2;
		}


		public void setHelperid2(String helperid2) {
			this.helperid2 = helperid2;
		}


		public String getTxtvehicle() {
			return txtvehicle;
		}


		public void setTxtvehicle(String txtvehicle) {
			this.txtvehicle = txtvehicle;
		}


		public String getVehicleid() {
			return vehicleid;
		}


		public void setVehicleid(String vehicleid) {
			this.vehicleid = vehicleid;
		}


		
		
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
				
							int val=routeDAO.insert(getTxtcode(), getTxtname(),getVehgrpid(),getDumpid(),getAreaid(),getMode(),session,getFormdetailcode(),getDriverid(),getHelperid(),getHelperid2(),getVehicleid());
							if(val>0){
								setTxtcode(getTxtcode());
								setTxtname(getTxtname());
								setTxtvehgrp(getTxtvehgrp());
								setVehgrpid(getVehgrpid());
								setTxtdump(getTxtdump());
								setDumpid(getDumpid());
								setTxtdriver(getTxtdriver());
								setDriverid(getDriverid());
								setTxthelper(getTxthelper());
								setHelperid(getHelperid());
								setTxthelper2(getTxthelper2());
								setHelperid2(getHelperid2());
							    setTxtvehicle(getTxtvehicle());
								setVehicleid(getVehicleid());
								setTxtarea(getTxtarea());
								setAreaid(getAreaid());
								setDocno(val);
								setMsg("Successfully Saved");
								return "success";
							}
							else if(val==-1){
								setTxtcode(getTxtcode());
								setTxtname(getTxtname());
								setTxtvehgrp(getTxtvehgrp());
								setVehgrpid(getVehgrpid());
								setTxtdump(getTxtdump());
								setDumpid(getDumpid());
								setTxtdriver(getTxtdriver());
								setDriverid(getDriverid());
								setTxthelper(getTxthelper());
								setHelperid(getHelperid());
								setTxthelper2(getTxthelper2());
								setHelperid2(getHelperid2());
							    setTxtvehicle(getTxtvehicle());
								setVehicleid(getVehicleid());
							
								setTxtarea(getTxtarea());
								setAreaid(getAreaid());
								setDocno(val);
								setChkstatus("1");
								setMsg("Code Already Exists.");
								return "fail";
							}
							else if(val==-2){
								setTxtcode(getTxtcode());
								setTxtname(getTxtname());
								setTxtvehgrp(getTxtvehgrp());
								setVehgrpid(getVehgrpid());
								setTxtdump(getTxtdump());
								setDumpid(getDumpid());
								setTxtdriver(getTxtdriver());
								setDriverid(getDriverid());
								setTxthelper(getTxthelper());
								setHelperid(getHelperid());
								setTxthelper2(getTxthelper2());
								setHelperid2(getHelperid2());
							    setTxtvehicle(getTxtvehicle());
								setVehicleid(getVehicleid());
							
								setTxtarea(getTxtarea());
								setAreaid(getAreaid());
								setDocno(val);
								setChkstatus("1");
								setMsg("Name Already Exists.");
								return "fail";
							}
							
							else{
								setTxtcode(getTxtcode());
								setTxtname(getTxtname());
								setTxtvehgrp(getTxtvehgrp());
								setVehgrpid(getVehgrpid());
								setTxtdump(getTxtdump());
								setDumpid(getDumpid());
								setTxtdriver(getTxtdriver());
								setDriverid(getDriverid());
								setTxthelper(getTxthelper());
								setHelperid(getHelperid());
								setTxthelper2(getTxthelper2());
								setHelperid2(getHelperid2());
							    setTxtvehicle(getTxtvehicle());
								setVehicleid(getVehicleid());
						
								setTxtarea(getTxtarea());
								setAreaid(getAreaid());
								setDocno(val);
								setMsg("Not Saved");
								return "fail";
							}	
			}
			
			else if(mode.equalsIgnoreCase("E")){
				int Status=routeDAO.edit(getTxtcode(), getTxtname(),getVehgrpid(),getDumpid(),getAreaid(),getDocno(),getMode(),session,getFormdetailcode(),getDriverid(),getHelperid(),getHelperid2(),getVehicleid());
				if(Status>0){
					setTxtcode(getTxtcode());
					setTxtname(getTxtname());
					setTxtvehgrp(getTxtvehgrp());
					setVehgrpid(getVehgrpid());
					setTxtdump(getTxtdump());
					setDumpid(getDumpid());
					setTxtdriver(getTxtdriver());
					setDriverid(getDriverid());
					setTxthelper(getTxthelper());
					setHelperid(getHelperid());
					setTxthelper2(getTxthelper2());
					setHelperid2(getHelperid2());
				    setTxtvehicle(getTxtvehicle());
					setVehicleid(getVehicleid());
				
					setTxtarea(getTxtarea());
					setAreaid(getAreaid());
					setDocno(getDocno());
					setMode(getMode());
					setMsg("Updated Successfully");
					
					return "success";
				}
				else if(Status==-1){
					setTxtcode(getTxtcode());
					setTxtname(getTxtname());
					setTxtvehgrp(getTxtvehgrp());
					setVehgrpid(getVehgrpid());
					setTxtdump(getTxtdump());
					setDumpid(getDumpid());
					setTxtdriver(getTxtdriver());
					setDriverid(getDriverid());
					setTxthelper(getTxthelper());
					setHelperid(getHelperid());
					setTxthelper2(getTxthelper2());
					setHelperid2(getHelperid2());
				    setTxtvehicle(getTxtvehicle());
					setVehicleid(getVehicleid());
			
					setTxtarea(getTxtarea());
					setAreaid(getAreaid());
					setDocno(getDocno());
					setMode(getMode());
					setChkstatus("2");
					setMsg("Code Already Exists.");
					return "fail";
				}
				
				else if(Status==-2){
					setTxtcode(getTxtcode());
					setTxtname(getTxtname());
					setTxtvehgrp(getTxtvehgrp());
					setVehgrpid(getVehgrpid());
					setTxtdump(getTxtdump());
					setDumpid(getDumpid());
					setTxtdriver(getTxtdriver());
					setDriverid(getDriverid());
					setTxthelper(getTxthelper());
					setHelperid(getHelperid());
					setTxthelper2(getTxthelper2());
					setHelperid2(getHelperid2());
				    setTxtvehicle(getTxtvehicle());
					setVehicleid(getVehicleid());
				
					setTxtarea(getTxtarea());
					setAreaid(getAreaid());
					setDocno(getDocno());
					setMode(getMode());
					setChkstatus("2");
					setMsg("Name Already Exists.");
					return "fail";
				}
				else{

					setTxtcode(getTxtcode());
					setTxtname(getTxtname());
					setTxtvehgrp(getTxtvehgrp());
					setVehgrpid(getVehgrpid());
					setTxtdump(getTxtdump());
					setDumpid(getDumpid());
					setTxtdriver(getTxtdriver());
					setDriverid(getDriverid());
					setTxthelper(getTxthelper());
					setHelperid(getHelperid());
					setTxthelper2(getTxthelper2());
					setHelperid2(getHelperid2());
				    setTxtvehicle(getTxtvehicle());
					setVehicleid(getVehicleid());
				
					setTxtarea(getTxtarea());
					setAreaid(getAreaid());
					setDocno(getDocno());
					setMode(getMode());
					setMsg("Not Updated");
					return "fail";
				}
				

			}
			
			else if(mode.equalsIgnoreCase("D")){
				boolean Status=routeDAO.delete(getDocno(),session,getMode(),getFormdetailcode());
			if(Status){
				setTxtcode(getTxtcode());
				setTxtname(getTxtname());
				setTxtvehgrp(getTxtvehgrp());
				setVehgrpid(getVehgrpid());
				setTxtdump(getTxtdump());
				setDumpid(getDumpid());
				setTxtdriver(getTxtdriver());
				setDriverid(getDriverid());
				setTxthelper(getTxthelper());
				setHelperid(getHelperid());
				setTxthelper2(getTxthelper2());
				setHelperid2(getHelperid2());
			    setTxtvehicle(getTxtvehicle());
				setVehicleid(getVehicleid());
			
				setTxtarea(getTxtarea());
				setAreaid(getAreaid());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Successfully Deleted");
				
				return "success";
			}
			else{
				setTxtcode(getTxtcode());
				setTxtname(getTxtname());
				setTxtvehgrp(getTxtvehgrp());
				setVehgrpid(getVehgrpid());
				setTxtdump(getTxtdump());
				setDumpid(getDumpid());
				setTxtdriver(getTxtdriver());
				setDriverid(getDriverid());
				setTxthelper(getTxthelper());
				setHelperid(getHelperid());
				setTxthelper2(getTxthelper2());
				setHelperid2(getHelperid2());
			    setTxtvehicle(getTxtvehicle());
				setVehicleid(getVehicleid());
			
				setTxtarea(getTxtarea());
				setAreaid(getAreaid());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}


	
		public String getVehgrpid() {
			return vehgrpid;
		}


		public void setVehgrpid(String vehgrpid) {
			this.vehgrpid = vehgrpid;
		}


		

		public String getAreaid() {
			return areaid;
		}


		public void setAreaid(String areaid) {
			this.areaid = areaid;
		}


		public String getTxtvehgrp() {
			return txtvehgrp;
		}


		public void setTxtvehgrp(String txtvehgrp) {
			this.txtvehgrp = txtvehgrp;
		}


		public String getTxtarea() {
			return txtarea;
		}


		public void setTxtarea(String txtarea) {
			this.txtarea = txtarea;
		}


		public String getTxtdump() {
			return txtdump;
		}


		public void setTxtdump(String txtdump) {
			this.txtdump = txtdump;
		}


		public String getDumpid() {
			return dumpid;
		}


		public void setDumpid(String dumpid) {
			this.dumpid = dumpid;
		}
		
		
  }

	
