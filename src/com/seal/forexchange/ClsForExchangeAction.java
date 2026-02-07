package com.seal.forexchange;

import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsForExchangeAction {   
    ClsForExchangeDAO serviceDAO = new ClsForExchangeDAO();       
	ClsCommon com = new ClsCommon();
	ClsForExchangeBean bean = new ClsForExchangeBean(); 
	ClsConnection conobj = new ClsConnection();  
	private String forexDate,hidfrxDate,forexAdjstDate,hidAdjDate,docno,txtremarks,mode,msg,deleted,formdetail,formdetailcode;  
	private int masterdoc_no,gridlength;  
	
	
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public String getForexDate() {
		return forexDate;
	}
	public void setForexDate(String forexDate) {
		this.forexDate = forexDate;
	}
	public String getHidfrxDate() {
		return hidfrxDate;
	}
	public void setHidfrxDate(String hidfrxDate) {
		this.hidfrxDate = hidfrxDate;
	}
	public String getForexAdjstDate() {
		return forexAdjstDate;
	}
	public void setForexAdjstDate(String forexAdjstDate) {
		this.forexAdjstDate = forexAdjstDate;
	}
	public String getHidAdjDate() {
		return hidAdjDate;
	}
	public void setHidAdjDate(String hidAdjDate) {
		this.hidAdjDate = hidAdjDate;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	public String getTxtremarks() {
		return txtremarks;
	}
	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
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
	   public String saveAction() throws ParseException, SQLException{  
   		HttpServletRequest request=ServletActionContext.getRequest();
   		HttpSession session=request.getSession();
   		Map<String, String[]> requestParams = request.getParameterMap();    
			String mode = getMode();    
			java.sql.Date sqlStartDate = null;
			java.sql.Date sqlAdjustDate = null;
			System.out.println("IN ACTION=FOREX="+getMode());
			ArrayList<String> gridarray = new ArrayList<String>();    
			if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("D")){
				if(getForexDate()!=null && !getForexDate().equals("")) { 
					sqlStartDate = com.changeStringtoSqlDate(getForexDate());
				}
				
				if(getForexAdjstDate()!=null && !getForexAdjstDate().equals("")) { 
					sqlAdjustDate = com.changeStringtoSqlDate(getForexAdjstDate());
				}
				
				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("det"+i)[0];		
					gridarray.add(temp);    
				}  
			}  
			
			if(mode.equalsIgnoreCase("A")){                  
				int val=serviceDAO.insert(sqlStartDate,sqlAdjustDate,getTxtremarks(),session,mode,request,getFormdetailcode(),gridarray);   
				String vdocno=request.getAttribute("vocno").toString();      
				//System.out.println("==="+val);
				if(val>0){ 
					setHidAdjDate(sqlAdjustDate+"");   
					setHidfrxDate(sqlStartDate+"");
					setDocno(vdocno);
					setMasterdoc_no(val);   
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					setHidAdjDate(sqlAdjustDate+"");   
					setHidfrxDate(sqlStartDate+"");
					setMsg("Not Saved");   
					return "fail";
				}
			}else if(mode.equalsIgnoreCase("View")){  
					bean=serviceDAO.getViewdetails(session,request,getDocno());	
					setTxtremarks(bean.getTxtremarks());
					setHidAdjDate(bean.getHidAdjDate());
					setHidfrxDate(bean.getHidfrxDate());
					setMasterdoc_no(bean.getMasterdoc_no());  
					return "success";
			}
			return "fail";  
     }
}
