package com.skips.nafithdownload;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.text.ParseException;
import java.sql.*;

import org.apache.struts2.ServletActionContext;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriverService;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;


public class ClsNafithDownloadAction extends ActionSupport{
	ClsCommon objcommon=new ClsCommon();
	private String username,mode,msg,deleted,date,docno;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}
	
	private static ChromeDriverService service;
	
	public String process() throws ParseException, SQLException{

		boolean result=false;
		System.out.println("Inside Action");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Connection conn=null;
		ClsConnection objconn=new ClsConnection();
		ClsNaifithDownloadDAO dao=new ClsNaifithDownloadDAO();
		try{
			conn=objconn.getMyConnection();
			
			//Getting Username
			String sqlfilters="";
			if(getUsername()!=null && !getUsername().trim().equalsIgnoreCase("")){
				sqlfilters+=" and username='"+getUsername()+"'";
			}
			System.out.println("select username,pass,url from gl_nafithid where status=3"+sqlfilters);
			ResultSet rsgetusername= conn.createStatement().executeQuery("select username,pass,url from gl_nafithid where status=3"+sqlfilters);
			
			while(rsgetusername.next()){	
				String username=rsgetusername.getString("username");
				String password=rsgetusername.getString("pass");
				String url=rsgetusername.getString("url");
				boolean status=dao.downloadNafith(username,password,url,conn,session);
			}
			
			setUsername(getUsername());
		}
		catch(Exception e){
			conn.close();
		}
		finally{
			conn.close();
		}
		
		return "fail";
	}
}
