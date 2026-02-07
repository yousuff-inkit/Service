package com.operations.clientrelations.clientsubcategory;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsClientSubCategoryAction extends ActionSupport{

	ClsClientSubCategoryDAO clientCategoryDAO= new ClsClientSubCategoryDAO();
	ClsClientSubCategoryBean clientcategorybean;
	
	private String formdetailcode;
	private String chkstatus;
	private String mode;
	private String deleted;
	private String msg;
	private int hidtxtclientcategorydocno;
	private String cmbcategory;
	private String hidcmbcategory;
	private String cmbsubcategory;
	private int catid;
	private int hidchckapproval,docno;
	
	
	public int getCatid() {
		return catid;
	}

	public void setCatid(int catid) {
		this.catid = catid;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getCmbcategory() {
		return cmbcategory;
	}

	public void setCmbcategory(String cmbcategory) {
		this.cmbcategory = cmbcategory;
	}
	
	public String getHidcmbcategory() {
		return hidcmbcategory;
	}

	public void setHidcmbcategory(String hidcmbcategory) {
		this.hidcmbcategory = hidcmbcategory;
	}

	public String getCmbsubcategory() {
		return cmbsubcategory;
	}

	public void setCmbsubcategory(String cmbsubcategory) {
		this.cmbsubcategory = cmbsubcategory;
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

	public int getHidtxtclientcategorydocno() {
		return hidtxtclientcategorydocno;
	}

	public void setHidtxtclientcategorydocno(int hidtxtclientcategorydocno) {
		this.hidtxtclientcategorydocno = hidtxtclientcategorydocno;
	}

	

	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String mode=getMode();
		ClsClientSubCategoryBean clientcategorybean = new ClsClientSubCategoryBean();
		
		if(mode.equalsIgnoreCase("A")){
			int val=clientCategoryDAO.insert(getFormdetailcode(),getCmbcategory(),getCmbsubcategory(),session,mode);
			if(val>0){
				
				
				setData();
				 setDocno(val);
				
				setMsg("Successfully Saved");
				return "success";
			}
			 else if(val==-1) { 
			 setData();
			 setChkstatus("1");
			 setMsg("Sub Category Already Exists");
			 return "fail";
			 }
			else{
				setData();
				setMsg("Not Saved");
				return "fail";
			}	
		}
		else if(mode.equalsIgnoreCase("E")){
			int Status=clientCategoryDAO.edit(getDocno(),getFormdetailcode(),getCmbcategory(),getCmbsubcategory(),session,mode);
			if(Status>0){
				
				
				setData();
				setDocno(getDocno());
				
				setMsg("Updated Successfully");
				return "success";
			}
			else if(Status==-1)
			   {
				setData();
				setChkstatus("2");
			    setMsg("Sub Category Already Exists");
			    return "fail";
			}
			else{
				setData();
				setMsg("Not Updated");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println("docno==="+getDocno());
			boolean Status=clientCategoryDAO.delete(getDocno(),getFormdetailcode(),session,mode);
			//System.out.println("docno==="+getDocno());
		if(Status){
			
			
			setData();
			setDocno(getDocno());
			
			setDeleted("DELETED");
			setMsg("Successfully Deleted");
			return "success";
		}
		else{
			
			setData();
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
			  List <ClsClientSubCategoryBean> list= clientCategoryDAO.list();
			  for(ClsClientSubCategoryBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("subcatid", bean.getDocno());
			  cellobj.put("catid", bean.getCatid());
			  cellobj.put("category", bean.getCmbcategory());
			  cellobj.put("subcategory", bean.getCmbsubcategory());
			  cellarray.add(cellobj);
			 }
		  } catch (SQLException e) {
		  }
		return cellarray;
	}
	    
	public void setData(){
		setHidcmbcategory(getCmbcategory());
		setCmbsubcategory(getCmbsubcategory());
		setFormdetailcode(getFormdetailcode());
	}
}
