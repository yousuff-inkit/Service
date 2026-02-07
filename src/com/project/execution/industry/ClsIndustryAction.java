package com.project.execution.industry;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.controlcentre.settings.activity.ClsActivityBean;

public class ClsIndustryAction {

	ClsCommon com=new ClsCommon();
	
	private int docno;
	private String date;  
	private String txtname;
	private String txtremarks;
    private String gridlength;
	private String mode;
	private String msg;
	private String deleted;

	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTxtname() {
		return txtname;
	}
	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}
	public String getTxtremarks() {
		return txtremarks;
	}
	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}
	public String getGridlength() {
		return gridlength;
	}
	public void setGridlength(String gridlength) {
		this.gridlength = gridlength;
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

	public String saveAction() throws SQLException{   
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		java.sql.Date sqlDate=com.changeStringtoSqlDate(getDate());  
		
		ClsIndustryDAO DAO= new ClsIndustryDAO();
		          
        if(mode.equalsIgnoreCase("A")){               
			int val=DAO.insert(getDocno(),sqlDate,getTxtname(),session,request,mode);
			if(val>0){            
				setDate(sqlDate+"");  
				setTxtname(getTxtname());
				setTxtremarks(getTxtremarks());
				
					setMsg("Successfully Saved");
				
				setDocno(val);   
				return "success";
			}
			else{
				setDate(sqlDate+"");  
				setTxtname(getTxtname());
				setTxtremarks(getTxtremarks());
		        setMsg("Not Saved");
				
				setDocno(val);   
				return "fail";
			}	
			
		}
        
        if(mode.equalsIgnoreCase("E")){               
			int val=DAO.edit(getDocno(),sqlDate,getTxtname(),session,request,mode);
			if(val>0){            
				setDate(sqlDate+"");  
				setTxtname(getTxtname());
				setTxtremarks(getTxtremarks());
					setMsg("Updated Successfully");
			
				setDocno(val);   
				return "success";
			}
			else{
				setDate(sqlDate+"");  
				setTxtname(getTxtname());
				setTxtremarks(getTxtremarks());
					setMsg("Not Updated");
				
				setDocno(val);   
				return "fail";
			}	
			
		}
        
        if(mode.equalsIgnoreCase("D")){               
			int val=DAO.delete(getDocno(),sqlDate,getTxtname(),getTxtremarks(),session,request,mode);
			if(val>0){        
				setDate(sqlDate+"");  
				setDocno(val);   
				setTxtname(getTxtname());
				setTxtremarks(getTxtremarks());
					
				setMsg("Successfully Deleted");
				return "success";
			}
			else{   
				setDate(sqlDate+"");  
				setDocno(val);   
				setTxtname(getTxtname());
				setTxtremarks(getTxtremarks());
				
				setMsg("Not Deleted");
				return "fail";
			}	
			
		}
		
		return "";
		
	}
}
