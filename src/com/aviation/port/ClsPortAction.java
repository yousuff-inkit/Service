package com.aviation.port;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.aviation.fuelinginformation.ClsfuelingInformationBean;
import com.aviation.fuelinginformation.ClsfuelingInformationDAO;
import com.common.ClsCommon;
import com.controlcentre.settings.areamaster.region.ClsRegionAction;
import com.controlcentre.settings.areamaster.region.ClsRegionBean;

public class ClsPortAction {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsPortBean Beans=new ClsPortBean();
	
	ClsPortBean viewObj = new ClsPortBean();
	ClsPortDAO saveObj = new ClsPortDAO();
	
	private int masterdoc_no,docno;
	private String PortDate,hidPortDate,port,portname,country;
	private String msg,formdetailcode,mode;
	private String deleted;
	
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public int getDocno() {
		return docno;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getPortname() {
		return portname;
	}
	public void setPortname(String portname) {
		this.portname = portname;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getPortDate() {
		return PortDate;
	}
	public void setPortDate(String portDate) {
		PortDate = portDate;
	}
	public String getHidPortDate() {
		return hidPortDate;
	}
	public void setHidPortDate(String hidPortDate) {
		this.hidPortDate = hidPortDate;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	public String saveAction() throws ParseException{
//		System.out.println("testing saveAction ------------ ");
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String mode=getMode();
		//ClsPortBean bean=new ClsportBean();
		//ClsRegionAction cra=new ClsRegionAction();
		
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getPortDate());
		System.out.println("date"+sqlStartDate);
		Beans.setPort(getPort());
		Beans.setPortname(getPortname());
		Beans.setPortDate(sqlStartDate);
		Beans.setCountry(getCountry());
		Beans.setMode(getMode());
		Beans.setDocno(getDocno());

		if(mode.equalsIgnoreCase("A")){
			System.out.println("date--ClsPortBean-"+sqlStartDate);
			int val=saveObj.insert(Beans,session);
			if(val>0){
//				setDatehidden(getDate_reg());
				setPortDate(sqlStartDate.toString());
				setPort(getPort());
				setPortname(getPortname());
				setDocno(val);
				setMsg("Successfully Saved");
//				request.setAttribute("SAVED", "SUCCESSFULLY SAVED");
				//addActionMessage("Saved Successfully");
//				System.out.println(session.getAttribute("SAVED"));
				return "success";
			}
			else{
//				request.setAttribute("SAVED", "NOT SAVED");
//				addActionError("Not Saved");
				setMsg("Not Saved");
				return "fail";
			}	
		}
		
		else if(mode.equalsIgnoreCase("E")){
		
		boolean Status=saveObj.edit(Beans,session);
		if(Status){
//			setDatehidden(getDate_reg());
			setPortDate(sqlStartDate.toString());
			setPort(getPort());
			setPortname(getPortname());
			setDocno(getDocno());
			setMsg("Updated Successfully");
			return "success";
		}
		else{
			setMsg("Not Updated");
			return "fail";
		}
	}
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=saveObj.delete(Beans,session);
		if(Status){
//			setDatehidden(getDate_reg());
			setPortDate(sqlStartDate.toString());
			setPort(getPort());
			setPortname(getPortname());
			setDocno(getDocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			setMsg("Not Deleted");
			return "fail";
		}
		}
		
		return "fail";
	}
	public JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsPortBean> list = saveObj.list();
			  for(ClsPortBean Beans:list){
					  cellobj = new JSONObject();
					  cellobj.put("DOC_NO", Beans.getDocno());
					  cellobj.put("PORT",Beans.getPort());
					  cellobj.put("PORT_NAME",Beans.getPortname());
					  cellobj.put("COUNTRY",Beans.getCountry());
					  cellobj.put("DATE",((Beans.getPortDate()==null) ? "NA" : Beans.getPortDate().toString()));
					  cellarray.add(cellobj);
			 }
				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	
}
