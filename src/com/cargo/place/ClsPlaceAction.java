package com.cargo.place;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.aviation.port.ClsPortBean;
import com.aviation.port.ClsPortDAO;
import com.common.ClsCommon;

public class ClsPlaceAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsPlaceBean Beans=new ClsPlaceBean();
	
	ClsPlaceBean viewObj = new ClsPlaceBean();
	ClsPlaceDAO saveObj = new ClsPlaceDAO();
	private int masterdoc_no,docno;
	private String deleted;
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCmbcountry() {
		return cmbcountry;
	}
	public void setCmbcountry(String cmbcountry) {
		this.cmbcountry = cmbcountry;
	}
	public String getHidcmbcountry() {
		return hidcmbcountry;
	}
	public void setHidcmbcountry(String hidcmbcountry) {
		this.hidcmbcountry = hidcmbcountry;
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
	private String code,name,cmbcountry,hidcmbcountry;
	private String PlaceDate;
	private String msg,formdetailcode,mode;
	public String getPlaceDate() {
		return PlaceDate;
	}
	public void setPlaceDate(String placeDate) {
		PlaceDate = placeDate;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
	public String saveAction() throws ParseException{
//		System.out.println("testing saveAction ------------ ");
		
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		
		String mode=getMode();
		//ClsPortBean bean=new ClsportBean();
		//ClsRegionAction cra=new ClsRegionAction();
		
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getPlaceDate());
		System.out.println("date"+sqlStartDate);
		Beans.setCode(getCode());
		Beans.setName(getName());
		Beans.setPlaceDate(sqlStartDate);
		Beans.setCmbcountry(getCmbcountry());
		Beans.setHidcmbcountry(getCmbcountry());
		Beans.setMode(getMode());
		Beans.setDocno(getDocno());

		if(mode.equalsIgnoreCase("A")){
			System.out.println("date--ClsPortBean-"+sqlStartDate);
			int val=saveObj.insert(Beans,session);
			if(val>0){
//				setDatehidden(getDate_reg());
				setPlaceDate(sqlStartDate.toString());
				setCode(getCode());
				setName(getName());
				setDocno(val);
				setCmbcountry(getCmbcountry());
				setHidcmbcountry(getCmbcountry());
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
			setPlaceDate(sqlStartDate.toString());
			setCode(getCode());
			setName(getName());
			setCmbcountry(getCmbcountry());
			setHidcmbcountry(getCmbcountry());
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
			setPlaceDate(sqlStartDate.toString());
			setCode(getCode());
			setName(getName());
			setCmbcountry(getCmbcountry());
			setHidcmbcountry(getCmbcountry());
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
			  List <ClsPlaceBean> list = saveObj.list();
			  for(ClsPlaceBean Beans:list){
					  cellobj = new JSONObject();
					  cellobj.put("DOC_NO", Beans.getDocno());
					  cellobj.put("CODE",Beans.getCode());
					  cellobj.put("NAME",Beans.getName());
					 cellobj.put("COUNTRY_ID",Beans.getCmbcountry());
					 cellobj.put("COUNTRY",Beans.getSrchcountry());
					  cellobj.put("DATE",((Beans.getPlaceDate()==null) ? "NA" : Beans.getPlaceDate().toString()));
					  cellarray.add(cellobj);
			 }
				 System.out.println("cellobj"+cellarray);
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	
}
