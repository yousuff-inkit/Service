package com.dashboard.cargo.operation;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.mailwithpdf.SendEmailAction;
import com.opensymphony.xwork2.ActionSupport;
@SuppressWarnings("serial")

public class ClsOperationAction extends ActionSupport{
    
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	//Print
	
	public void expenseSave() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
        java.sql.Date sqlUpToDate = null;
        System.out.println("===="+request.getParameterNames().toString());
		try {
		
			String expcash=request.getParameter("expcash")=="" || request.getParameter("expcash")==null?"0":request.getParameter("expcash");
			int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
			String docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?"0":request.getParameter("docno");
			int vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?0:Integer.parseInt(request.getParameter("vocno"));
			String exparray=request.getParameter("exparray")=="" || request.getParameter("exparray")==null?"":request.getParameter("exparray");
	  		int dat=0;          
			int val=0,temp=0,val1=0,val2=0,tranno=0; 
			System.out.println("exparray--->>>"+exparray+"==="+expcash+"===="+brhid+"===="+vocno+"==="+request.getParameterNames());
			
			
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
	}
	
	
}