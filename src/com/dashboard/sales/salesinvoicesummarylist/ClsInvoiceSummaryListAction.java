package com.dashboard.sales.salesinvoicesummarylist;


import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

import net.sf.json.JSONArray;

public class ClsInvoiceSummaryListAction {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
		
	public String printAction() throws  SQLException{
		
		 HttpServletRequest request=ServletActionContext.getRequest();
		 HttpServletResponse response=ServletActionContext.getResponse();
		 HttpSession session=request.getSession();
		 ClsCommon common=new ClsCommon();
		 String docnos=request.getParameter("printdocno");
		 String brhid=request.getParameter("brhid");
		 String dtype=request.getParameter("dtype");
         
		 System.out.println("----inside action-----: "+common.getPrintPath(dtype).contains(".jrxml"));
		 
        /* if(common.getPrintPath(dtype).contains(".jrxml")==true)
				{*/				   
					  
      	  // System.out.println("iside jrxml");
      	   ClsConnection conobj=new ClsConnection();
											 
      	   param = new HashMap();
      	   Connection conn = null;
      	   conn = conobj.getMyConnection();	        	   
      	   String reportFileName = "Invoice List";
      	   
      	   try {
      		 if(docnos.contains(":")){
      			String [] inv=new String []{};
      			inv=docnos.split(":");
      			for(int i=0;i<inv.length;i++){
      				param.put("printdocnos"+i+"",inv[i]);
      			}
      		}
      		else{
      			param.put("printdocnos0",docnos);
      		}
      		     
      		   //param.put("complogo", pintbean.getLblcompname());
      		   
      		     JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/sales/salesinvoicesummarylist/creditinvprint.jrxml"));	      	     	 
	             JasperReport jasperReport = JasperCompileManager.compileReport(design);
                 generateReportPDF(response, param, jasperReport, conn);
      	   } catch (Exception e) {

			       e.printStackTrace();

			   }
						 
      	   finally{
      		   conn.close();
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
