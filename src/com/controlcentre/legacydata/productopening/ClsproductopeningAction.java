package com.controlcentre.legacydata.productopening;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsproductopeningAction {

	ClsproductopeningDAO ClsproductopeningDAO= new ClsproductopeningDAO();
	
	ClsCommon ClsCommon=new ClsCommon();
	private String   date,hiddate,mode,deleted,msg;
	
	
	private int docno,masterdoc_no,gridlenght;


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


	public int getDocno() {
		return docno;
	}


	public void setDocno(int docno) {
		this.docno = docno;
	}


	public int getMasterdoc_no() {
		return masterdoc_no;
	}


	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}


	public int getGridlenght() {
		return gridlenght;
	}


	public void setGridlenght(int gridlenght) {
		this.gridlenght = gridlenght;
	}
	
	
	
	
	
	
	public String saveAction() throws SQLException
	{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		
		
		
		
		if(mode.equalsIgnoreCase("A"))
		{
			java.sql.Date dates=ClsCommon.changeStringtoSqlDate(getDate());
			ArrayList<String> descarray= new ArrayList<>();
			for(int i=0;i<getGridlenght();i++){
				
			 
				String temp2=requestParams.get("reqtest"+i)[0];
			 

				descarray.add(temp2);
				 
			}

			
			
			int val=ClsproductopeningDAO.inset(dates,descarray,request,session);
			
			System.out.println("======val===="+val);
			
			if(val>0)
			{
				System.out.println("======val== iNS=="+val);
				
				setHiddate(dates.toString());
				setDocno(val); 
				setMasterdoc_no(val);
				setMsg("Successfully Saved");
				return "success";
				
			}
			else
			{

				setHiddate(dates.toString());
				setDocno(val); 
				setMasterdoc_no(val);
				
				setMsg("Not Saved");
				return "fail";
				
				
			}
			
				
				
			
		}
		
 
		
		
		
		
		return "fail";
	}
	
 
	
	
}



