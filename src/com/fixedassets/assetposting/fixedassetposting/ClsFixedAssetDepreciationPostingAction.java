package com.fixedassets.assetposting.fixedassetposting;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsFixedAssetDepreciationPostingAction extends ActionSupport{
	ClsCommon ClsCommon=new ClsCommon();
	
	ClsFixedAssetDepreciationPostingDAO fixedAssetDepreciationPostingDAO= new ClsFixedAssetDepreciationPostingDAO();
	ClsFixedAssetDepreciationPostingBean fixedAssetDepreciationPostingBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private String brchName;
	
	private String jqxFixedAssetDepreciationPostingDate;
	private String hidjqxFixedAssetDepreciationPostingDate;
	private int txtjvno;
	private double txtdeprtotal;
	private double txtdrtotal;
	private double txtcrtotal;
	private int txttrno;
	
	//Asset Details Grid 
	private int gridlength;
	
	//Account Details Grid
	private int journalgridlength;
	
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

	public String getBrchName() {
		return brchName;
	}

	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}

	public String getJqxFixedAssetDepreciationPostingDate() {
		return jqxFixedAssetDepreciationPostingDate;
	}

	public void setJqxFixedAssetDepreciationPostingDate(
			String jqxFixedAssetDepreciationPostingDate) {
		this.jqxFixedAssetDepreciationPostingDate = jqxFixedAssetDepreciationPostingDate;
	}

	public String getHidjqxFixedAssetDepreciationPostingDate() {
		return hidjqxFixedAssetDepreciationPostingDate;
	}

	public void setHidjqxFixedAssetDepreciationPostingDate(
			String hidjqxFixedAssetDepreciationPostingDate) {
		this.hidjqxFixedAssetDepreciationPostingDate = hidjqxFixedAssetDepreciationPostingDate;
	}

	public int getTxtjvno() {
		return txtjvno;
	}

	public void setTxtjvno(int txtjvno) {
		this.txtjvno = txtjvno;
	}

	public double getTxtdeprtotal() {
		return txtdeprtotal;
	}

	public void setTxtdeprtotal(double txtdeprtotal) {
		this.txtdeprtotal = txtdeprtotal;
	}

	public double getTxtdrtotal() {
		return txtdrtotal;
	}

	public void setTxtdrtotal(double txtdrtotal) {
		this.txtdrtotal = txtdrtotal;
	}

	public double getTxtcrtotal() {
		return txtcrtotal;
	}

	public void setTxtcrtotal(double txtcrtotal) {
		this.txtcrtotal = txtcrtotal;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public int getJournalgridlength() {
		return journalgridlength;
	}

	public void setJournalgridlength(int journalgridlength) {
		this.journalgridlength = journalgridlength;
	}

	java.sql.Date fixedAssetDepreciationDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsFixedAssetDepreciationPostingBean bean = new ClsFixedAssetDepreciationPostingBean();
		fixedAssetDepreciationDate = ClsCommon.changeStringtoSqlDate(getJqxFixedAssetDepreciationPostingDate());
		
		if(mode.equalsIgnoreCase("A")){
			
			/*Asset Details Grid*/
			ArrayList<String> vehicledetailsarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				ClsFixedAssetDepreciationPostingBean fixedAssetDepreciationPostingBean=new ClsFixedAssetDepreciationPostingBean();
				String temp=requestParams.get("test"+i)[0];
				vehicledetailsarray.add(temp);
			}
			/*Asset Details Grid Ends*/
			
			/*Journal Voucher Grid*/
			ArrayList<String> journalvouchersarray= new ArrayList<>();
			for(int i=0;i<getJournalgridlength();i++){
				ClsFixedAssetDepreciationPostingBean fixedAssetDepreciationPostingBean=new ClsFixedAssetDepreciationPostingBean();
				String temp1=requestParams.get("journal"+i)[0];
				journalvouchersarray.add(temp1);
			}
			/*Journal Voucher Grid Ends*/
			
						int val=fixedAssetDepreciationPostingDAO.insert(getFormdetailcode(),getBrchName(),fixedAssetDepreciationDate,getTxtdeprtotal(),vehicledetailsarray,journalvouchersarray,session,request,mode);
						if(val>0.0){
							setTxtjvno(val);
							setHidjqxFixedAssetDepreciationPostingDate(fixedAssetDepreciationDate.toString());
							setTxttrno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setData();
							setHidjqxFixedAssetDepreciationPostingDate(fixedAssetDepreciationDate.toString());
							
							setMsg("Not Saved");
							return "fail";
						}	
		}
		return "fail";
	}
	
	public void setData(){
		setTxtdeprtotal(getTxtdeprtotal());
		setTxtdrtotal(getTxtdrtotal());
		setTxtcrtotal(getTxtcrtotal());
	}
}


