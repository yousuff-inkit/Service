package com.fixedassets.assets.assetssalesinvoice;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;


public class ClsAssetSalesInvAction {

	ClsCommon ClsCommon=new ClsCommon();

	ClsAssetSalesInvDAO assetdao=new ClsAssetSalesInvDAO();
	ClsAssetSalesInvBean bean;
	private int docno;
	private int vocno;
	private String date;
	private String hiddate;
	private String client;
	private String clientname;
	private String clientacno;
	private String cmbtype;
	private String hidcmbtype;
	private String description;
	private String msg;
	private String deleted;
	private String mode;
	private int trno;
	private int gridlength;
	private String formdetailcode;
	private String formdetail;
	private String hidbranch;
	private String days;
	private String brchName;
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getVocno() {
		return vocno;
	}
	public void setVocno(int vocno) {
		this.vocno = vocno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getClientname() {
		return clientname;
	}
	public void setClientname(String clientname) {
		this.clientname = clientname;
	}
	public String getClientacno() {
		return clientacno;
	}
	public void setClientacno(String clientacno) {
		this.clientacno = clientacno;
	}
	public String getCmbtype() {
		return cmbtype;
	}
	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}
	public String getHidcmbtype() {
		return hidcmbtype;
	}
	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public int getTrno() {
		return trno;
	}
	public void setTrno(int trno) {
		this.trno = trno;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getFormdetail() {
		return formdetail;
	}
	public void setFormdetail(String formdetail) {
		this.formdetail = formdetail;
	}
	public String getHidbranch() {
		return hidbranch;
	}
	public void setHidbranch(String hidbranch) {
		this.hidbranch = hidbranch;
	}
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	
	public void setValues(java.sql.Date sqlStartDate,String branch,int docno,int trno,int vocno){
		setDate(sqlStartDate.toString());
		setClient(getClient());
		setClientacno(getClientacno());
		setClientname(getClientname());
		setDescription(getDescription());
		setHidcmbtype(getCmbtype());
		setDocno(docno);
		setTrno(trno);
		setHidbranch(branch);
		setVocno(vocno);
	}
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> assetarray= new ArrayList<>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				
				assetarray.add(temp);
			}
						ClsAssetSalesInvBean bean=assetdao.insert(sqlStartDate,getCmbtype(),getDescription(),session,getMode(),assetarray,
								getFormdetailcode(),getClientacno(),getClient(),getDays(),getBrchName(),request);
						if(bean.getDocno()>0){
							setValues(sqlStartDate,getBrchName(),bean.getDocno(),bean.getTrno(),Integer.parseInt(request.getAttribute("VOCNO").toString()));
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setValues(sqlStartDate,getBrchName(),bean.getDocno(),bean.getTrno(),0);
							setMsg("Not Saved");

							return "fail";
						}	
		}
		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> assetarray= new ArrayList<>();
			System.out.println("inside tarifsave");
			for(int i=0;i<getGridlength();i++){
				//ClsTarifBean tarifbean=new ClsTarifBean();
				System.out.println("request =========="+request.getAttribute("test"+i));
				String temp=requestParams.get("test"+i)[0];
				
				assetarray.add(temp);
			}
			boolean Status=assetdao.edit(sqlStartDate,getCmbtype(),getDescription(),session,getMode(),getDocno(),getTrno(),assetarray,getFormdetailcode(),getClientacno(),getClient(),getBrchName());
			if(Status){
				setValues(sqlStartDate,getHidbranch(),getDocno(),getTrno(),getVocno());//System.out.println("brand"+brand);
				setMsg("Updated Successfully");

				return "success";
			}
			else{
				setValues(sqlStartDate,getHidbranch(),getDocno(),getTrno(),getVocno());
				setMsg("Not Updated");

				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			//System.out.println(getDocno()+","+getBrand()+","+getDate_brand());
			boolean Status=assetdao.delete(sqlStartDate,getCmbtype(),getDescription(),session,getMode(),getDocno(),getTrno(),getFormdetailcode(),getClientacno(),getBrchName());
		if(Status){
			//setBra(getBrand());
			setValues(sqlStartDate,getHidbranch(),getDocno(),getTrno(),getVocno());
			setDeleted("DELETED");
			setMsg("Successfully Deleted");

			return "success";
		}
		else{
			setValues(sqlStartDate,getHidbranch(),getDocno(),getTrno(),getVocno());
			setMsg("Not Deleted");

			return "fail";
		}
		}
		return "fail";
	}
}
