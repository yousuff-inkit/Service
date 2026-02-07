package com.cargo.transportmasters.servicetype;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.controlcentre.masters.salesmanmaster.staff.ClsStaffBean;
import com.opensymphony.xwork2.ActionSupport;

public class ClsServiceTypeAction extends ActionSupport{
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsServiceTypeDAO serviceDAO= new ClsServiceTypeDAO();
	ClsServiceTypeBean bean;
	
	private int docno,seqno;
	private String servicedate,inaccname,exaccname,chkhidtax,chktaxable;
	private String servicetype;
	public int getSeqno() {
		return seqno;
	}
	public void setSeqno(int seqno) {
		this.seqno = seqno;
	}
	
	public String getServicetype() {
		return servicetype;
	}
	public String getChkhidtax() {
		return chkhidtax;
	}
	public void setChkhidtax(String chkhidtax) {
		this.chkhidtax = chkhidtax;
	}
	public String getChktaxable() {
		return chktaxable;
	}
	public void setChktaxable(String chktaxable) {
		this.chktaxable = chktaxable;
	}
	public String getInaccname() {
		return inaccname;
	}
	public void setInaccname(String inaccname) {
		this.inaccname = inaccname;
	}
	public String getExaccname() {
		return exaccname;
	}
	public void setExaccname(String exaccname) {
		this.exaccname = exaccname;
	}
	public void setServicetype(String servicetype) {
		this.servicetype = servicetype;
	}
	private String cmbmode,inaccid,exaccid,hidcmbmode;
	private String cmbsubmode,hidcmbsubmode;
	private String cmbshipment,hidcmbshipment;
	public String getHidcmbshipment() {
		return hidcmbshipment;
	}
	public void setHidcmbshipment(String hidcmbshipment) {
		this.hidcmbshipment = hidcmbshipment;
	}
	public String getHidcmbmode() {
		return hidcmbmode;
	}
	public void setHidcmbmode(String hidcmbmode) {
		this.hidcmbmode = hidcmbmode;
	}
	public String getHidcmbsubmode() {
		return hidcmbsubmode;
	}
	public void setHidcmbsubmode(String hidcmbsubmode) {
		this.hidcmbsubmode = hidcmbsubmode;
	}
	public String getInaccid() {
		return inaccid;
	}
	public void setInaccid(String inaccid) {
		this.inaccid = inaccid;
	}
	public String getExaccid() {
		return exaccid;
	}
	public void setExaccid(String exaccid) {
		this.exaccid = exaccid;
	}
	private String hidservicedate;
	private String mode;
	private String deleted;
	private int gridlength;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String chkstatus;
	private String servtype;
	private int modeid;
	private int smodeid;
	private int shipid;
	public String getServtype() {
		return servtype;
	}
	public void setServtype(String servtype) {
		this.servtype = servtype;
	}
	public int getModeid() {
		return modeid;
	}
	public void setModeid(int modeid) {
		this.modeid = modeid;
	}
	public int getSmodeid() {
		return smodeid;
	}
	public void setSmodeid(int smodeid) {
		this.smodeid = smodeid;
	}
	public int getShipid() {
		return shipid;
	}
	public void setShipid(int shipid) {
		this.shipid = shipid;
	}
	public ClsCommon getClsCommon() {
		return ClsCommon;
	}
	public void setClsCommon(ClsCommon clsCommon) {
		ClsCommon = clsCommon;
	}
	public ClsServiceTypeDAO getserviceDAO() {
		return serviceDAO;
	}
	public void setserviceDAO(ClsServiceTypeDAO serviceDAO) {
		this.serviceDAO = serviceDAO;
	}
	public ClsServiceTypeBean getBean() {
		return bean;
	}
	public void setBean(ClsServiceTypeBean bean) {
		this.bean = bean;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getServicedate() {
		return servicedate;
	}
	public void setServicedate(String servicedate) {
		this.servicedate = servicedate;
	}
	public String getCmbmode() {
		return cmbmode;
	}
	public void setCmbmode(String cmbmode) {
		this.cmbmode = cmbmode;
	}
	public String getCmbsubmode() {
		return cmbsubmode;
	}
	public void setCmbsubmode(String cmbsubmode) {
		this.cmbsubmode = cmbsubmode;
	}
	public String getCmbshipment() {
		return cmbshipment;
	}
	public void setCmbshipment(String cmbshipment) {
		this.cmbshipment = cmbshipment;
	}
	public String getHidservicedate() {
		return hidservicedate;
	}
	public void setHidservicedate(String hidservicedate) {
		this.hidservicedate = hidservicedate;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
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
		Map<String, String[]> requestParams = request.getParameterMap();
		//System.out.println("MOde===="+getMode()+"=="+getCmbsubmode()+"==="+getInaccid()+"==="+getExaccid());
		String mode=getMode();
		//String smode=getCmbsubmode();
		String inacno=getInaccid();
		String exacno=getExaccid();
		if(getCmbsubmode()==null){
			setCmbsubmode("0");
		}
		if(getChktaxable()==null){
			setChktaxable("0");
		}
		if(inacno.equalsIgnoreCase("")){
			setInaccid("0");
		}
		if(exacno.equalsIgnoreCase("")){
			setExaccid("0");
		}
	
		System.out.println("===getCmbsubmode========changed smode==="+getCmbsubmode()+"mode====="+getMode()+"==cmbmode===="+getCmbmode());
		java.sql.Date sqlServiceDate = ClsCommon.changeStringtoSqlDate(getServicedate());
		
		if(mode.equalsIgnoreCase("A")){
						int val=serviceDAO.insert(getDocno(),getServicetype(), sqlServiceDate, getCmbmode(), getCmbsubmode(), getCmbshipment(), mode, session, getFormdetailcode(),getInaccid(),getExaccid(),getChktaxable(),getSeqno());
						if(val>0){
							setServicedate(getServicedate());
							setServicetype(getServicetype());
							setChkhidtax(getChktaxable());
							setCmbmode(getCmbmode());
							setHidcmbmode(getCmbmode());
							setCmbsubmode(getCmbsubmode());
							setHidcmbsubmode(getCmbsubmode());
							setCmbshipment(getCmbshipment());
							setHidcmbshipment(getCmbshipment());
							setMode(getMode());
							setInaccid(getInaccid());
							setExaccid(getExaccid());
							setInaccname(getInaccname());
							setExaccname(getExaccname());
							setSeqno(getSeqno());
						    setDocno(val);
							setMsg("Successfully Saved");
							return "success";
						}
						
						else{
							setServicetype(getServicetype());
							setHidservicedate(getHidservicedate());
							setChkhidtax(getChktaxable());
							setCmbmode(getCmbmode());
							setHidcmbmode(getCmbmode());
							setCmbsubmode(getCmbsubmode());
							setHidcmbsubmode(getCmbsubmode());
							setCmbshipment(getCmbshipment());
							setHidcmbshipment(getCmbshipment());
							setInaccname(getInaccname());
							setExaccname(getExaccname());
							setMode(getMode());
							setInaccid(getInaccid());
							setExaccid(getExaccid());
							setSeqno(getSeqno());
						    setDocno(val);
							setMsg("Not Saved");
							return "fail";
						}	
		}
		if(mode.equalsIgnoreCase("E")){
			//String ssmode=getCmbsubmode();
			
			
			System.out.println("===getCmbsubmode=======changed smode==="+getCmbsubmode());
			int val=serviceDAO.edit(getDocno(),getServicetype(), sqlServiceDate, getCmbmode(), getCmbsubmode(), getCmbshipment(), mode, session, getFormdetailcode(),getInaccid(),getExaccid(),getChktaxable(),getSeqno());
			if(val>0){
				setServicedate(getServicedate());
				setServicetype(getServicetype());
				setChkhidtax(getChktaxable());
				setCmbmode(getCmbmode());
				setHidcmbmode(getCmbmode());
				setCmbsubmode(getCmbsubmode());
				setHidcmbsubmode(getCmbsubmode());
				setCmbshipment(getCmbshipment());
				setHidcmbshipment(getCmbshipment());
				setInaccname(getInaccname());
				setExaccname(getExaccname());
				setMode(getMode());
				setInaccid(getInaccid());
				setExaccid(getExaccid());
				setSeqno(getSeqno());
			    setDocno(val);
				setMsg("Updated Successfully");
				return "success";
			}
			
			else{
				setServicetype(getServicetype());
				setHidservicedate(getHidservicedate());
				setChkhidtax(getChktaxable());
				setCmbmode(getCmbmode());
				setHidcmbmode(getCmbmode());
				setCmbsubmode(getCmbsubmode());
				setHidcmbsubmode(getCmbsubmode());
				setCmbshipment(getCmbshipment());
				setHidcmbshipment(getCmbshipment());
				setMode(getMode());
				setInaccid(getInaccid());
				setExaccid(getExaccid());
				setInaccname(getInaccname());
				setExaccname(getExaccname());
				setSeqno(getSeqno());
			    setDocno(val);
			    setMsg("Not Updated");
				return "fail";
			}	
}
		if(mode.equalsIgnoreCase("D")){
			boolean Status=serviceDAO.delete(getDocno(),getServicetype(), sqlServiceDate, getCmbmode(), getCmbsubmode(), getCmbshipment(), mode, session, getFormdetailcode());
			if(Status){
				setServicedate(getServicedate());
				setServicetype(getServicetype());
				setChkhidtax(getChktaxable());
				setCmbmode(getCmbmode());
				setHidcmbmode(getCmbmode());
				setCmbsubmode(getCmbsubmode());
				setHidcmbsubmode(getCmbsubmode());
				setCmbshipment(getCmbshipment());
				setHidcmbshipment(getCmbshipment());
				setMode(getMode());
				setInaccname(getInaccname());
				setExaccname(getExaccname());
				setInaccid(getInaccid());
				setExaccid(getExaccid());
				setSeqno(getSeqno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			
			else{
				setServicetype(getServicetype());
				setHidservicedate(getHidservicedate());
				setChkhidtax(getChktaxable());
				setCmbmode(getCmbmode());
				setHidcmbmode(getCmbmode());
				setCmbsubmode(getCmbsubmode());
				setHidcmbsubmode(getCmbsubmode());
				setCmbshipment(getCmbshipment());
				setHidcmbshipment(getCmbshipment());
				setMode(getMode());
				setInaccname(getInaccname());
				setExaccname(getExaccname());
				setInaccid(getInaccid());
				setExaccid(getExaccid());
				setSeqno(getSeqno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "fail";
			}	
}

	return "fail";
	}
	public  JSONArray searchDetails(){
		  JSONArray cellarray = new JSONArray();
		  JSONObject cellobj = null;
		  try {
			  List <ClsServiceTypeBean> list= serviceDAO.list();
			  for(ClsServiceTypeBean bean:list){
			  cellobj = new JSONObject();
			  cellobj.put("doc_no", bean.getDocno());
			  cellobj.put("date",bean.getServicedate().toString());
			  cellobj.put("srvtype",bean.getServtype());
			  cellobj.put("modename",bean.getCmbmode());
			  cellobj.put("submode",bean.getCmbsubmode());
			  cellobj.put("shipment", bean.getCmbmode());
			  cellobj.put("modeid",bean.getModeid());
			  cellobj.put("smodeid", bean.getSmodeid());
			  cellobj.put("shipid", bean.getShipid());		  
			  cellobj.put("inaccid", bean.getInaccid());
			  cellobj.put("indesc",bean.getIndesc());
			  cellobj.put("exaccid", bean.getExaccid());
			  cellobj.put("exdesc", bean.getExdesc());
			  cellobj.put("tax", bean.getChkhidtax());
			  cellobj.put("seqno", bean.getSeqno());
			  cellarray.add(cellobj);
			 }
		  } catch (SQLException e) {
			  e.printStackTrace();
		  }
		return cellarray;
	}
	
	
}



