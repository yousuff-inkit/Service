package com.dashboard.skips.serviceschedule;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ClsServiceScheduleAction  extends ActionSupport{
	ClsConnection connobj=new ClsConnection();   
	ClsCommon objcommon=new ClsCommon(); 
	ClsServiceScheduleDAO DAO = new ClsServiceScheduleDAO();  
	private String url;
	private Map<String, Object> param=null;    
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String printAction() throws Exception{
		Connection conn = null;
		try {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession(); 
		
		String routeid=request.getParameter("routeid").toString(); 
		String date=request.getParameter("date").toString();   
		String brhid=request.getParameter("branch").toString();
		String header=request.getParameter("header").toString();   
		if(objcommon.getBIBPrintPath("BSS").contains(".jrxml"))         
		{
		    HttpServletResponse response = ServletActionContext.getResponse();
			String reportFileName = "";
	     	param = new HashMap();
	 		     
			conn = connobj.getMyConnection();    
			Statement stmt=conn.createStatement();
			java.sql.Date sqldate=null;
			System.out.println("IN ACTION = "+date);
			if(!date.equalsIgnoreCase("") && !date.equalsIgnoreCase("0")) {
				 sqldate=objcommon.changeStringtoSqlDate(date); 
			}  
		    setUrl(objcommon.getBIBPrintPath("BSS"));        
			   
			String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
		    headerimgpath=headerimgpath.replace("\\", "\\\\");
				 
			String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
			footerimgpath=footerimgpath.replace("\\", "\\\\"); 
			System.out.println("IN ACTION = "+sqldate);     
			param.put("header", header);
			param.put("imgpath", headerimgpath);  
			param.put("routeid", routeid);       
			param.put("date", sqldate);    
			param.put("printby", session.getAttribute("USERNAME"));       
			//System.out.println("URL="+getUrl());  
		    JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
	     	JasperReport jasperReport = JasperCompileManager.compileReport(design);
	       	generateReportPDF(response, param, jasperReport, conn);
	                 
		}  
		} catch (Exception e) {
	                 e.printStackTrace();
	    }finally{
	             if(conn!=null){  
	            		conn.close();
	             }
		} 
		return "print";
	}
	 private void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {
		  byte[] bytes = null; 
     bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
       resp.reset();
     resp.resetBuffer();
     
     resp.setContentType("application/pdf");
     resp.setContentLength(bytes.length);
     ServletOutputStream ouputStream = resp.getOutputStream();     
     ouputStream.write(bytes, 0, bytes.length);
    
     ouputStream.flush();
     ouputStream.close();
 }
}  
