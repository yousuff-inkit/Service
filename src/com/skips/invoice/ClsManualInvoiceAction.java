package com.skips.invoice;    

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.skips.invoice.ClsManualInvoiceAction;    
import com.emailnew.EmailUtility;
public class ClsManualInvoiceAction extends ActionSupport{           
	ClsConnection conobj=new ClsConnection(); 
	ClsCommon objcommon=new ClsCommon();  
	EmailUtility eut=new EmailUtility();
	ClsManualInvoiceDAO1 DAO=new ClsManualInvoiceDAO1();  
	ClsManualInvoiceBean bean=new ClsManualInvoiceBean();   
	private int gridlength,masterdoc_no;   
	private String url,cmbreftype,hidcmbreftype,docno,mode,msg,deleted,txtcontract,hidcntrno,txtclient,hidcldocno,hiddate,hidfromdate,ledgernote,hidtodate,invoicenote,formdetailcode,date,fromdate,todate,txtremarks; 
	
    public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getFromdate() {
		return fromdate;
	}
	public void setFromdate(String fromdate) {
		this.fromdate = fromdate;
	}
	public String getTodate() {
		return todate;
	}
	public void setTodate(String todate) {
		this.todate = todate;
	}
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getHidcmbreftype() {
		return hidcmbreftype;
	}
	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}
	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
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
	public String getTxtcontract() {
		return txtcontract;
	}
	public void setTxtcontract(String txtcontract) {
		this.txtcontract = txtcontract;
	}
	public String getHidcntrno() {
		return hidcntrno;
	}
	public void setHidcntrno(String hidcntrno) {
		this.hidcntrno = hidcntrno;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getHidcldocno() {
		return hidcldocno;
	}
	public void setHidcldocno(String hidcldocno) {
		this.hidcldocno = hidcldocno;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getHidfromdate() {
		return hidfromdate;
	}
	public void setHidfromdate(String hidfromdate) {
		this.hidfromdate = hidfromdate;
	}
	public String getLedgernote() {
		return ledgernote;
	}
	public void setLedgernote(String ledgernote) {
		this.ledgernote = ledgernote;
	}
	public String getHidtodate() {
		return hidtodate;
	}
	public void setHidtodate(String hidtodate) {
		this.hidtodate = hidtodate;
	}
	public String getInvoicenote() {
		return invoicenote;
	}
	public void setInvoicenote(String invoicenote) {
		this.invoicenote = invoicenote;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getTxtremarks() {
		return txtremarks;
	}
	public void setTxtremarks(String txtremarks) {
		this.txtremarks = txtremarks;
	}   


	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String saveAction() throws ParseException, SQLException{  
		Connection conn = null;
		try {
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession();
			Map<String, String[]> requestParams = request.getParameterMap();
	//		System.out.println("IN ACTION");
			java.sql.Date sqlStartDate=null,sqlStDate=null,sqlEdDate=null;
			if(getDate()!=null) {
				  sqlStartDate = objcommon.changeStringtoSqlDate(getDate()); 
			}
			if(getFromdate()!=null) {
				  sqlStDate = objcommon.changeStringtoSqlDate(getFromdate());
			}
			if(getTodate()!=null) {
				  sqlEdDate = objcommon.changeStringtoSqlDate(getTodate());     
			}  
			String mode=getMode();  
			ArrayList<String> invarray= new ArrayList<>();
			if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E")){   
				for(int i=0;i<getGridlength();i++){
					String temp2=requestParams.get("test"+i)[0];     
					invarray.add(temp2);
				}
			} 
			if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("D")){     
				conn = conobj.getMyConnection();  
				conn.setAutoCommit(false);
			}
			//System.out.println("IN 2");  
			if(mode.equalsIgnoreCase("A")){   
				int val=DAO.insert(conn, sqlStartDate,sqlStDate,sqlEdDate,getCmbreftype(),getHidcntrno(),getHidcldocno(),getLedgernote(),getInvoicenote(),invarray,session,getMode(),getFormdetailcode(),request,getTxtremarks());
				String vdocno="";               
				if(val>0){  
					conn.commit();
					conn.close();
					vdocno=request.getAttribute("vocno").toString();
					setHidfromdate(sqlStDate.toString());  
					setHidtodate(sqlEdDate.toString());
					setHiddate(sqlStartDate.toString());    
					subdata();
					setDocno(vdocno);
					setMasterdoc_no(val);  
					setMsg("Successfully Saved");
					return "success";
				}
				else{
					subdata();
					setDocno(vdocno);
					setMasterdoc_no(val);  
					setMsg("Not Saved");
					return "fail";
				}
			}else if(mode.equalsIgnoreCase("E")){ 
				boolean Status=DAO.edit(conn, getMasterdoc_no(),sqlStartDate,sqlStDate,sqlEdDate,getCmbreftype(),getHidcntrno(),getHidcldocno(),getLedgernote(),getInvoicenote(),invarray,session,getMode(),getFormdetailcode(),request,getTxtremarks());
				if(Status){ 
					conn.commit();
					conn.close();
					setHidfromdate(sqlStDate.toString());  
					setHidtodate(sqlEdDate.toString());
					setHiddate(sqlStartDate.toString()); 
					subdata();
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());  
					setMsg("Updated Successfully");
					return "success"; 
				}
				else{
					subdata();
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());   
					setMsg("Not Updated");  
					return "fail";
					
				}
			}else if(mode.equalsIgnoreCase("D")){   
				boolean Status=DAO.delete(conn, getMasterdoc_no(),sqlStartDate,getMode(),sqlStDate,sqlEdDate);      
				if(Status){
					conn.commit();
					conn.close();  
					setHidfromdate(sqlStDate.toString());  
					setHidtodate(sqlEdDate.toString());
					setHiddate(sqlStartDate.toString()); 
					subdata();
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());  
					setMsg("Successfully Deleted");
					setDeleted("DELETED");
					return "success";
				}
				else{
					subdata();
					setDocno(getDocno());
					setMasterdoc_no(getMasterdoc_no());  
					setMsg("Not Deleted");
					return "fail";
				}
			}
			if(mode.equalsIgnoreCase("view")){
				bean=DAO.getViewDetails(getMasterdoc_no());     
			    setCmbreftype(bean.getCmbreftype());     
				setHidcmbreftype(bean.getCmbreftype());  
				setHidcntrno(bean.getHidcntrno());
				setTxtclient(bean.getTxtclient());
				setTxtcontract(bean.getTxtcontract());   
				setHiddate(bean.getHiddate());  
				setHidfromdate(bean.getHidfromdate());
				setHidtodate(bean.getHidtodate()); 
				setLedgernote(bean.getLedgernote()); 
				setInvoicenote(bean.getInvoicenote());    
				setTxtremarks(bean.getTxtremarks());      
			}
		}catch (Exception e) {  
            e.printStackTrace();
        }finally{
       		 if(conn!=null){
       			 conn.close();
       		 }  
		} 
		return "fail";	 
	}  
	public void subdata() {         
		    setCmbreftype(getCmbreftype());     
			setHidcmbreftype(getCmbreftype());  
			setHidcntrno(getHidcntrno());
			setTxtclient(getTxtclient());
			setTxtcontract(getTxtcontract());   
			setLedgernote(getLedgernote()); 
			setInvoicenote(getInvoicenote());
			setTxtremarks(getTxtremarks());     
	}
	public String printAction() throws Exception{  
		Connection conn = null;
		try {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession(); 
		//System.out.println("printaction");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("branch").toString();
		String header=request.getParameter("header").toString(); 
		String bankdocno=request.getParameter("bankdocno")==null || request.getParameter("bankdocno").equals("")?"1":request.getParameter("bankdocno").toString();
		ClsAmountToWords amntobj=new ClsAmountToWords();  
		if(objcommon.getPrintPath("SINV").contains(".jrxml"))  
		{
		    HttpServletResponse response = ServletActionContext.getResponse();
			
			String reportFileName = "";
			
	     	param = new HashMap();
	 		     
				 conn = conobj.getMyConnection();
				 Statement stmt=conn.createStatement();   
				
				 String strSql1 = "select name,address,beneficiary,account,ibanno,swiftcode from cm_bankdetails where status=3 and doc_no="+bankdocno+"";
					ResultSet rs1 = stmt.executeQuery(strSql1);
					
					String bankname="",bankaddress="",bankbeneficiary="",bankaccount="",bankibanno="",bankswiftcode="";
					while(rs1.next()) {
						bankname=rs1.getString("beneficiary");
						bankaddress=rs1.getString("address");
						bankbeneficiary=rs1.getString("name");
						bankaccount=rs1.getString("account");
						bankibanno=rs1.getString("ibanno");
						bankswiftcode=rs1.getString("swiftcode");
					} 
					//System.out.println("bank details="+strSql1);
					param.put("bankname", bankname);
					param.put("bankbeneficiary", bankbeneficiary);
					param.put("bankaccountno", bankaccount);
					param.put("bankibanno", bankibanno);
					param.put("bankswiftcode", bankswiftcode);
					param.put("bnkaddress",bankaddress);

					
					/*param.put("bnkname",bean.getLblbankdetails());
					param.put("bnkbeneficiary",bean.getLblbankbeneficiary());
					param.put("bnkaccountno",bean.getLblbankaccountno());
					param.put("bnkswiftcode",bean.getLblbeneficiarybank());
					param.put("bnkibanno",bean.getLblbankibanno());
					param.put("bnkaddress",bean.getLblcompbranchaddress()); */
				
				 setUrl(objcommon.getPrintPath("SINV"));  
			   
			     String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
				 headerimgpath=headerimgpath.replace("\\", "\\\\");
				 
				 String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
			         footerimgpath=footerimgpath.replace("\\", "\\\\");
			              
					 String footerimgpath1=request.getSession().getServletContext().getRealPath("/icons/skipfooter.png");
				         footerimgpath1=footerimgpath1.replace("\\", "\\\\");
			         param.put("header", header);
			         param.put("footerimgpath", footerimgpath);
			         param.put("footerimgpath1", footerimgpath1);
			         param.put("imgpath", headerimgpath);
			         param.put("docno", docno);       
			         param.put("amntobj", amntobj); 
			         param.put("printby", session.getAttribute("USERNAME"));  
			         
			         
			     String upsql = "update sk_invm set statusid=3 where doc_no='"+docno+"'";   
			     stmt.executeUpdate(upsql);  
			     
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	       		            generateReportPDF(response, param, jasperReport, conn);
	                 
		}  
//	    System.out.println("===== "+getUrl());         
		} catch (Exception e) {

	                 e.printStackTrace();

	             }
	            	 finally{
	            		 if(conn!=null){
	            			 conn.close();
	            		 }
				} 
		
		return "print";
	}
	public String multipageprintAction() throws Exception{  
		Connection conn = null;
		try {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession(); 
		//System.out.println("multipage");
		String printdocno=request.getParameter("docno").toString();
		String brhid=request.getParameter("branch").toString();
		String header=request.getParameter("header").toString(); 
		 String bankdocno=request.getParameter("bankdocno")==null || request.getParameter("bankdocno").equals("")?"1":request.getParameter("bankdocno").toString();
		ClsAmountToWords amntobj=new ClsAmountToWords();  
		if(objcommon.getPrintPath("SINV").contains(".jrxml"))  
		{
		    HttpServletResponse response = ServletActionContext.getResponse();
			
			String reportFileName = "";
			
	     	param = new HashMap();
	 		     
				 conn = conobj.getMyConnection();
				 Statement stmt=conn.createStatement();   
				 ArrayList<String> invarray=new ArrayList<String>();
					if(printdocno.contains(":")){
						String [] inv=new String []{};
						inv=printdocno.split(":");
						for(int i=0;i<inv.length;i++){
							invarray.add(i, inv[i]);
						}
					}
					else{
						invarray.add(0, printdocno);
					}
					param.put("docnos", invarray); 
				 String strSql1 = "select name,address,beneficiary,account,ibanno,swiftcode from cm_bankdetails where status=3 and doc_no="+bankdocno+"";
					ResultSet rs1 = stmt.executeQuery(strSql1);
					
					String bankname="",bankaddress="",bankbeneficiary="",bankaccount="",bankibanno="",bankswiftcode="";
					while(rs1.next()) {
						bankname=rs1.getString("beneficiary");
						bankaddress=rs1.getString("address");
						bankbeneficiary=rs1.getString("name");
						bankaccount=rs1.getString("account");
						bankibanno=rs1.getString("ibanno");
						bankswiftcode=rs1.getString("swiftcode");
					} 
					//System.out.println("bank details="+strSql1);
					param.put("bankname", bankname);
					param.put("bankbeneficiary", bankbeneficiary);
					param.put("bankaccountno", bankaccount);
					param.put("bankibanno", bankibanno);
					param.put("bankswiftcode", bankswiftcode);
					param.put("bnkaddress",bankaddress);

					
					/*param.put("bnkname",bean.getLblbankdetails());
					param.put("bnkbeneficiary",bean.getLblbankbeneficiary());
					param.put("bnkaccountno",bean.getLblbankaccountno());
					param.put("bnkswiftcode",bean.getLblbeneficiarybank());
					param.put("bnkibanno",bean.getLblbankibanno());
					param.put("bnkaddress",bean.getLblcompbranchaddress()); */
				
				 setUrl(objcommon.getPrintPath("SINV"));  
			   
			     String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
				 headerimgpath=headerimgpath.replace("\\", "\\\\");
				 
				 String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
			         footerimgpath=footerimgpath.replace("\\", "\\\\");
			         param.put("header", header);
			         param.put("imgpath", headerimgpath);
			         param.put("amntobj", amntobj); 
			         param.put("printby", session.getAttribute("USERNAME"));  
			         
			         for(int i=0;i<invarray.size();i++){    
					     String upsql = "update sk_invm set statusid=3 where doc_no='"+invarray.get(i)+"'";   
					     stmt.executeUpdate(upsql);  
			         }
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/skips/invoice/invoicePrintSkip2.jrxml"));
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	       		            generateReportPDF(response, param, jasperReport, conn);
	                 
		}  
//	    System.out.println("===== "+getUrl());         
		} catch (Exception e) {

	                 e.printStackTrace();

	             }
	            	 finally{
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
	public String emailAction(String docno,String brhid) throws Exception{      
		Connection conn = null;
		try {
			
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession(); 
		ClsAmountToWords amntobj=new ClsAmountToWords();  
		String bankdocno=request.getParameter("bankdocno")==null || request.getParameter("bankdocno").equals("")?"1":request.getParameter("bankdocno").toString();
		if(objcommon.getPrintPath("SINV").contains(".jrxml"))  
		{
		    HttpServletResponse response = ServletActionContext.getResponse();
			
			String reportFileName = "";
			
	     	param = new HashMap();
	 		     
				 conn = conobj.getMyConnection();
				 Statement stmt=conn.createStatement();   
				
				 String strSql1 = "select name,address,beneficiary,account,ibanno,swiftcode from cm_bankdetails where status=3 and doc_no="+bankdocno+"";
					ResultSet rs1 = stmt.executeQuery(strSql1);
						
					String bankname="",bankaddress="",bankbeneficiary="",bankaccount="",bankibanno="",bankswiftcode="";
					while(rs1.next()) {  
							bankname=rs1.getString("beneficiary");
							bankaddress=rs1.getString("address");
							bankbeneficiary=rs1.getString("name");
							bankaccount=rs1.getString("account");
							bankibanno=rs1.getString("ibanno");
							bankswiftcode=rs1.getString("swiftcode");
						} 
						//System.out.println("bank details="+strSql1);
						param.put("bankname", bankname);
						param.put("bankbeneficiary", bankbeneficiary);
						param.put("bankaccountno", bankaccount);
						param.put("bankibanno", bankibanno);
						param.put("bankswiftcode", bankswiftcode);
						param.put("bnkaddress",bankaddress);
				 setUrl(objcommon.getPrintPath("SINV"));  
			   
			     String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
				 headerimgpath=headerimgpath.replace("\\", "\\\\");
				 
				 String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
			         footerimgpath=footerimgpath.replace("\\", "\\\\");
			         String header="1";
			         param.put("header", header);
			         param.put("imgpath", headerimgpath);
			         param.put("docno", docno);       
			         param.put("amntobj", amntobj); 
			         param.put("printby", session.getAttribute("USERNAME"));    
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	     	              generateReportEmail(response, param, jasperReport, conn,docno,session,brhid,request);   
	                 
		}  
//	    System.out.println("===== "+getUrl());         
		} catch (Exception e) {

	                 e.printStackTrace();

	             }
	            	 finally{
	            		 if(conn!=null){
	            			 conn.close();
	            		 }
				} 
		
		return "print";
	}
	 
	  private void generateReportEmail(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn,String docno,HttpSession session,String brhid,HttpServletRequest request)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
			try{  
				byte[] bytes = null;
			    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);  
			  	Statement stmt=conn.createStatement();
			  	String fileName="",path="", formcode="SINV",filepath=""; 
			  	//Deleting Existing Internal Attachments
			  	String strgetattach="select path from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999";
			  	ResultSet rsgetattach=stmt.executeQuery(strgetattach);
			  	while(rsgetattach.next()){
			  		String deletepath=rsgetattach.getString("path");
			  		File deletefile = new File(deletepath);
			  		deletefile.delete(); 
			  	}
			  	int deleteFileEntry=stmt.executeUpdate("delete from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999");
			  	
			  	String host="", port="", userName="", password="", recipient="", message="",docnos="1";
			  	String strSql1 = "select imgPath from my_comp";
				ResultSet rs1 = stmt.executeQuery(strSql1);
				while(rs1.next ()) {
					path=rs1.getString("imgPath");
				}
				//path=path.replace("\\", "/");
				String srno="";
				String strSql = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"'";
				ResultSet rs = stmt.executeQuery(strSql);
				while(rs.next()) {
					srno=rs.getString("srno");
				}
				String refdet="";
				String strSql2 = "select concat(ac.refname,' - ',m.voc_no) refdet from sk_invm m left join my_acbook ac on ac.dtype='crm' and ac.cldocno=m.cldocno where m.doc_no="+docno+"";
				ResultSet rs2 = stmt.executeQuery(strSql2);
				while(rs2.next()) {
					refdet=rs2.getString("refdet");
				}	
				fileName = refdet+".pdf";  
				filepath=path+ "\\attachment\\"+formcode+"\\"+fileName;

				File dir = new File(path+ "\\attachment\\"+formcode); 
				dir.mkdirs();
				JasperPrint print = JasperFillManager.fillReport(jasperReport, parameters);
			  	JasperExportManager.exportReportToPdfFile(print, filepath);	
				
			    CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");     
				stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
				stmtAttach.setString(1,formcode);
				stmtAttach.setString(2,docno);
				stmtAttach.setString(3,session.getAttribute("BRANCHID")==null?brhid:session.getAttribute("BRANCHID").toString());
				stmtAttach.setString(4,session.getAttribute("USERNAME").toString());
				stmtAttach.setString(5,path+"\\attachment\\"+formcode+"\\"+fileName);
				stmtAttach.setString(6,fileName);
				stmtAttach.setString(7,"");
				stmtAttach.setString(8,"999");
				stmtAttach.executeQuery();
				int no=stmtAttach.getInt("srNo");
				if(no<=0){
					System.out.println("Insert Error");
				}
			}
			catch(Exception e){
				e.printStackTrace();  
			}
	  }
		public void printActionJasper() throws Exception{      
			Connection conn = null;
			try {
			HttpServletRequest request=ServletActionContext.getRequest();
			HttpSession session=request.getSession(); 
			//System.out.println("jasper--");
			conn = conobj.getMyConnection();
			Statement stmt=conn.createStatement();
			Statement stmt1=conn.createStatement();
			String printdocno=request.getParameter("printdocno").toString();
			ClsAmountToWords amntobj=new ClsAmountToWords(); 
			ArrayList<String> invarray=new ArrayList<String>();
			if(printdocno.contains(":")){
				String [] inv=new String []{};
				inv=printdocno.split(":");
				for(int i=0;i<inv.length;i++){
					invarray.add(i, inv[i]);
				}
			}
			else{
				invarray.add(0, printdocno);
			}
			param = new HashMap();
			int valid=0; 
			System.out.println("bank docno="+request.getParameter("bankdocno"));
			
			String bankdocno=request.getParameter("bankdocno")==null || request.getParameter("bankdocno").equals("")?"1":request.getParameter("bankdocno").toString(); 
			String strSql1 = "select name,address,beneficiary,account,ibanno,swiftcode from cm_bankdetails where status=3 and doc_no="+bankdocno+"";
			ResultSet rs1 = stmt.executeQuery(strSql1);
				
			String bankname="",bankaddress="",bankbeneficiary="",bankaccount="",bankibanno="",bankswiftcode="";
			while(rs1.next()) {  
					bankname=rs1.getString("beneficiary");
					bankaddress=rs1.getString("address");
					bankbeneficiary=rs1.getString("name");
					bankaccount=rs1.getString("account");
					bankibanno=rs1.getString("ibanno");
					bankswiftcode=rs1.getString("swiftcode");
			} 
			System.out.println(bankdocno+"=bank details="+strSql1);
			param.put("bankname", bankname);
			param.put("bankbeneficiary", bankbeneficiary);
			param.put("bankaccountno", bankaccount);
			param.put("bankibanno", bankibanno);
			param.put("bankswiftcode", bankswiftcode);
			param.put("bnkaddress",bankaddress);
				
			String msgsql="",emailcontent="", sub = "";
			String strSql3 = "select emailcontent, subject from gl_emailmsg WHERE dtype='INVD'";
			//System.out.println("sql=="+strSql3);      
			ResultSet rs3 = stmt.executeQuery(strSql3);        
			while(rs3.next ()) {
				emailcontent = rs3.getString("emailcontent");
				sub = rs3.getString("subject");
			}
			
			for(int i=0;i<invarray.size();i++){
				String msgstr1="",type="", cldocno="0", email="", date="",  skipsize="", insname="", msg="", brhid="0", company="", subject="", vocno="0",client="",fromdate="",todate="",docno="0";  
				
				String strSql2 = "select dd.type, date_format(m.fromdate,'%d-%m-%Y') fromdate, date_format(m.todate,'%d-%m-%Y') todate,ac.refname client,date_format(m.date,'%d-%M-%Y') date,m.brhid,m.doc_no,m.cldocno,coalesce(cm.email,'') email,(select company from my_comp) company,m.voc_no from sk_invm m left join sk_srvcontrm cm on cm.tr_no=m.cnttrno and m.reftype=cm.dtype left join my_acbook ac on (ac.cldocno=m.cldocno and ac.dtype='crm') left join (select group_concat(case when idno=1 then 'S' when idno=2 then 'T' else '' end) type,rdocno from sk_invd group by rdocno) dd on dd.rdocno = m.doc_no where m.doc_no='"+invarray.get(i)+"'";
				//System.out.println("sql=="+strSql2);  
				ResultSet rs2 = stmt.executeQuery(strSql2);          
				while(rs2.next ()) {
					  cldocno=rs2.getString("cldocno");
					  email=rs2.getString("email");
					  brhid=rs2.getString("brhid"); 
					  company=rs2.getString("company");   
					  date=rs2.getString("date");   
					  docno=rs2.getString("doc_no");  
					  vocno=rs2.getString("voc_no");  
					  client=rs2.getString("client");    
					  fromdate=rs2.getString("fromdate");
					  todate=rs2.getString("todate");
					  type=rs2.getString("type");  
				}
				
				msgsql = emailcontent.trim().replaceAll("docno", docno);    
				ResultSet rs4 = stmt1.executeQuery(msgsql); 
				while(rs4.next()){
					msg = rs4.getString("msg");
				}
				
				if(type.contains("S") && type.contains("T")) {  
					msgstr1="Waste Collection and Tipping fees,"; 
				}else if(type.contains("S")) {
					msgstr1="Waste Collection"; 
				}else if(type.contains("T")) {  
					msgstr1="Tipping fees"; 
				}else {}
				//subject="Dubai Municipality - ADF (Tipping FEE) Invoice No. "+vocno+" for MR SKIPS Waste Services for immediate payment release.";  
				if(!sub.equals("") && sub!=null){
					subject = sub.trim().replaceAll("<<vocno>>", vocno);  
				}
				/*msg="<html>"              
							+" <body>"
							+" <p>Dear Valued Customer <<client>>,</p>"    
							+" <p>In pursuance to Dubai Municipality resolution w.e.f 1st January 2022 towards prepaid tipping fees, attached is the Invoice No. <<vocno>> for the period from <<fromdate>> to <<todate>>.</p>" 
						    +" <p>MR Skips is privileged by stepping towards Dubais paperless goals by sending E-copies of its invoices. We expect your good office to accept this E-Copy invoice and release the payment within 3 days from the date of invoice receipt (E-Copy).</p>" 
							+" <p>Payment can also be made by Bank Transfer with the following details:</p>" 
							+" <p>BANK NAME: COMMERCIAL BANK OF DUBAI <br/>" 
							+"  ACCOUNT NAME: MRSKIPS WASTE SERVICES <br/>" 
							+"  A/C NO: 1001817442 <br/>"  
							+"  IBAN NO: AE330230000001001817442 <br/>" 
							+"  SHEIKH ZAYED ROAD BRANCH <br/>" 
							+"  SWIFT CODE: CBDUAEAD </p>"
							+" <p>If you are not the concern, we request you to escalate the email to the right department for quick action and to avail uninterrupted services. </p>" 
							+" <p>In case of questions, please feel free to get in touch with the undersigned. </p>" 
							+" <p>FOR, <br/>"   
							+" MR SKIPS WASTE SERVICES <br/>" 
							+" Accounts Department. <br/>" 
							+" Mob: +971564096619 / +971545860552, Tel: +97143794989 <br/>" 
							+" Email: invoice@mrskips.net , accounts@mrskips.net <br/>" 
							+" Escalation Level 1: cc@mrskips.net </p>"   
							+" </body>"
						    +" </html>"; */
				/*msg="<html>"                
						+" <body>"
						+" <p>Dear Valued Customer <<client>>,</p>"      
						+" <p>Please adhere attached invoice of <<msgstr1>> due dates"   
					    +"  for Waste collection invoice will remain as per expressed contract in place and please note tipping fee does not have any credit period will be paid with immediate effect.</p>" 
					    +" <p>You are also aware of newly implemented prepaid Dubai Municipality w.e.f 01.01.2022 on tipping and gate fees.</p>" 
					    +" <p>Payment can also be made by Bank Transfer/Cards with Following Details:</p>" 
						+" <p>BANK NAME : EMIRATES ISLAMIC BANK <br/>" 
						+"  ACCOUNT NAME : MRSKIPS WASTE SERVICES <br/>" 
						+"  A/C NO : 3708442833901 <br/>"  
						+"  IBAN NO : AE070340003708442833901 <br/>" 
						+"  BRANCH : Al Barsha Mall, Dubai, UAE <br/>"  
						+"  SWIFT CODE : MEBLAEAD </p>"   
						+" <p>Note:- Mr Skips is privileged by stepping towards Dubai paperless goal and sending E-Copies of its invoices. </p>" 
						+" <p>We expect your good office to accept this e-copy invoice to release the payment.</p>" 
						+" </body>"   
					    +" </html>"; */  
				  msg = msg.replace("<<client>>",client);     
				  //msg = msg.replace("<<fromdate>>",fromdate);  
				  //msg = msg.replace("<<todate>>",todate);
				  //msg = msg.replace("<<vocno>>",vocno);  
				  msg = msg.replace("<<msgstr0>>","invoice");   
				  msg = msg.replace("<<msgstr1>>",msgstr1);          
				if(objcommon.getPrintPath("SINV").contains(".jrxml"))  
				{
				    HttpServletResponse response = ServletActionContext.getResponse();
					
					String reportFileName = "";
						
						 setUrl(objcommon.getPrintPath("SINV"));  
					   
					     String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
						 headerimgpath=headerimgpath.replace("\\", "\\\\");
						 
						 String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
					         footerimgpath=footerimgpath.replace("\\", "\\\\");
					         String header="1";
					         param.put("header", header);
					         param.put("imgpath", headerimgpath);
					         param.put("docno", docno);       
					         param.put("amntobj", amntobj); 
					         param.put("printby", session.getAttribute("USERNAME"));    
				         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
			     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
			     	               if(!email.equalsIgnoreCase("") && email!=null) {       
			     	            	  generateReportPDF(response, param, jasperReport, conn, email, session, docno, brhid, vocno, subject, msg, client);
			     	               }
				} 
			} 
			} catch (Exception e) {
		                 e.printStackTrace();
		             }
		            	 finally{
		            		 if(conn!=null){
		            			 conn.close();
		            		 }
					} 
		}
		 private void generateReportPDF(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email,HttpSession session,String printdoc,String brhid,String refid,String subject,String msg,String client)throws JRException, NamingException, SQLException, IOException, MessagingException, javax.mail.MessagingException {
			  byte[] bytes = null;
	          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
	          resp.reset();
	          resp.resetBuffer();
	          ClsEncrypt ClsEncrypt=new ClsEncrypt();
	          resp.setContentType("application/pdf");
	          resp.setContentLength(bytes.length);
	          ServletOutputStream ouputStream = resp.getOutputStream();
	         
	          /*if(print.equalsIgnoreCase("1")) { 
	          
		          ouputStream.write(bytes, 0, bytes.length);
		          ouputStream.flush();
		          ouputStream.close();
	         } else {*/
	         Statement stmt =conn.createStatement(); 
	         String strSql = "select smtpServer, smtpHostPort,signature,email,mailpass from my_user where doc_no='"+session.getAttribute("USERID")+"'";
	      	 ResultSet rs = stmt.executeQuery(strSql);
	      	 String host="",port="",signature="",userName="",password="";
	      	 while(rs.next()) {
	      		host=rs.getString("smtpServer").trim();
	      		port=rs.getString("smtpHostPort").trim();
	      		signature=rs.getString("signature").trim();
	      		userName=rs.getString("email").trim();
	      		password=ClsEncrypt.getInstance().decrypt(rs.getString("mailpass").trim());
	         } 
			 
	        	String fileName="",path="", formcode="INVD",filepath="",cc=""; 
	        	String strSql1 = "select imgPath from my_comp";
	      		ResultSet rs1 = stmt.executeQuery(strSql1);
	      		while(rs1.next ()) {
	      			path=rs1.getString("imgPath");
	      		}

	      		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
	    		java.util.Date date = new java.util.Date();
	    		String currdate=dateFormat.format(date);
	    		
	      		//fileName = "InvoiceToBeDispath"+currdate+".pdf";
	    		fileName = client+" - "+refid+".pdf";       
	      		filepath=path+ "/attachment/"+formcode+"/"+fileName;

	      		File dir = new File(path+ "/attachment/"+formcode);
	      		dir.mkdirs();
	      		
	      		FileOutputStream fos = new FileOutputStream(filepath);
	        	fos.write(bytes);
	        	fos.flush();
	        	fos.close();
	        	
	        	File saveFile=new File(filepath);
	        	
	        	String strSql3  = "select emailcc from gl_emailmsg where dtype='INVD'";    
	    		//System.out.println("sql=="+strSql3);    
				ResultSet rs3 = stmt.executeQuery(strSql3);            
				while(rs3.next ()) {
					cc=rs3.getString("emailcc");       
				}
				
	        	String bcc="",urll="",value="";     
	        	value=eut.sendEmailpdf(host, port, userName, password, email,cc,subject, msg, urll,bcc,saveFile);	
	        	/*value="";
	        	eut.sendEmailwithpdf(host, port, userName, password, email,subject, msg, saveFile,"");*/
	        	if(value.equalsIgnoreCase("success")){  
	        		String upsqls="update sk_invm set email=1 where doc_no='"+printdoc+"'";     
           		stmt.executeUpdate(upsqls);  
	            	/*  Inserting into emaillog*/  
           		String sqls="insert into emaillog (doc_no, brhId, dtype, edate, userId, refid, email) values ('"+printdoc+"','"+brhid+"','INVD',now(),'"+session.getAttribute("USERID")+"','"+refid+"','"+email+"')";
           		stmt.executeUpdate(sqls);  
           	/*	Inserting into emaillog Ends	*/
	            }
	      }
		 
		  public void printActionContractJasper() throws Exception{       
				Connection conn = null;
				try {
				HttpServletRequest request=ServletActionContext.getRequest();
				HttpSession session=request.getSession(); 
				conn = conobj.getMyConnection();
				ClsEncrypt ClsEncrypt=new ClsEncrypt();   
				//System.out.println("contract jasper");
				Statement stmt=conn.createStatement();
				Statement stmt1=conn.createStatement();
				String printdocno=request.getParameter("printdocno").toString();
				ClsAmountToWords amntobj=new ClsAmountToWords(); 
				ArrayList<String> invarray=new ArrayList<String>();
				String invoicestr="";  
				if(printdocno.contains(":")){
					String [] inv=new String []{};
					inv=printdocno.split(":");
					for(int i=0;i<inv.length;i++){
						invoicestr+=inv[i]+",";  
					}
				}
				else{
					invoicestr+=printdocno+",";     
				}
				param = new HashMap();   
				String bankdocno=request.getParameter("bankdocno")==null || request.getParameter("bankdocno").equals("")?"1":request.getParameter("bankdocno").toString();    
				String strSql1 = "select name,address,beneficiary,account,ibanno,swiftcode from cm_bankdetails where status=3 and doc_no="+bankdocno+"";
				ResultSet rs1 = stmt.executeQuery(strSql1);
					
				String bankname="",bankaddress="",bankbeneficiary="",bankaccount="",bankibanno="",bankswiftcode="";
				while(rs1.next()) {  
						bankname=rs1.getString("beneficiary");
						bankaddress=rs1.getString("address");
						bankbeneficiary=rs1.getString("name");
						bankaccount=rs1.getString("account");
						bankibanno=rs1.getString("ibanno");
						bankswiftcode=rs1.getString("swiftcode");
					} 
					//System.out.println("bank details="+strSql1);
					param.put("bankname", bankname);
					param.put("bankbeneficiary", bankbeneficiary);
					param.put("bankaccountno", bankaccount);
					param.put("bankibanno", bankibanno);
					param.put("bankswiftcode", bankswiftcode);
					param.put("bnkaddress",bankaddress);
					
				int d1=0,d2=0;
				String filepaths="",vocnos="",docnos="",cc="",host="",port="",signature="",userName="", password="", emailcontent="", msgsql="", sub="";   
				String strSql3  = "select coalesce(emailcc,'') emailcc, emailcontent, subject from gl_emailmsg where dtype='INVD'";    
		    	//System.out.println("sql=="+strSql3);    
				ResultSet rs3 = stmt.executeQuery(strSql3);             
				while(rs3.next ()) {
						cc=rs3.getString("emailcc");  
						emailcontent = rs3.getString("emailcontent");
						sub = rs3.getString("subject");
				}  
				String strSql = "select smtpServer, smtpHostPort,signature,email,mailpass from my_user where doc_no='"+session.getAttribute("USERID")+"'";
//			    System.out.println("userSql="+strSql); 
				ResultSet rs = stmt.executeQuery(strSql);
			    while(rs.next()) {
			      		host=rs.getString("smtpServer").trim();
			      		port=rs.getString("smtpHostPort").trim();
			      		signature=rs.getString("signature").trim();
			      		userName=rs.getString("email").trim();
			      		password=ClsEncrypt.getInstance().decrypt(rs.getString("mailpass").trim());
			    }
				int valid=0, i=0, pdfcount=0;  
				 
				String type="",type1="",msgstr0="", msg="" , msgstr1="",cldocno="0",email="",date="",skipsize="",insname="",brhid="0",company="",subject="",vocno="0",client="",fromdate="",todate="",docno="0";  
				String strSql2 = "select dd.type, m.cnttrno,date_format(m.fromdate,'%d-%m-%Y') fromdate, date_format(m.todate,'%d-%m-%Y') todate,ac.refname client,date_format(m.date,'%d-%M-%Y') date,m.brhid,m.doc_no,m.cldocno,coalesce(cm.email,'') email,(select company from my_comp) company,m.voc_no from sk_invm m left join sk_srvcontrm cm on cm.tr_no=m.cnttrno and m.reftype=cm.dtype left join my_acbook ac on (ac.cldocno=m.cldocno and ac.dtype='crm') left join (select group_concat(case when idno=1 then 'S' when idno=2 then 'T' else '' end) type,rdocno from sk_invd group by rdocno) dd on dd.rdocno = m.doc_no  where m.doc_no in("+invoicestr.substring(0, invoicestr.length()-1)+") order by m.cnttrno";
				//System.out.println("sql=="+strSql2);    
				ResultSet rs2 = stmt.executeQuery(strSql2);          
				while(rs2.next ()) {
					msgsql = emailcontent.trim().replaceAll("docno", rs2.getString("doc_no"));    
					ResultSet rs4 = stmt1.executeQuery(msgsql); 
					while(rs4.next()){
						msg = rs4.getString("msg");
					} 
					
						  d1=rs2.getInt("cnttrno");  
						  pdfcount++;
					if(i==0) {
						d2=d1;  
					}
					if(d1!=d2) {
						if(type.contains("S") && type.contains("T")) {  
							msgstr1="Waste Collection and Tipping fees,"; 
					    }else if(type.contains("S")) {
							msgstr1="Waste Collection"; 
					    }else if(type.contains("T")) {  
							msgstr1="Tipping fees"; 
					    }else {}
						
						if(pdfcount>1) {
							msgstr0="invoices";
						}else {
							msgstr0="invoice";  
						}  
						//System.out.println(d1+"=="+d2);  
						//System.out.println(docnos+"=="+vocnos+"=="+filepaths);  
						//subject="Invoice No. "+vocnos.substring(0, vocnos.length()-1)+" for MR SKIPS Waste Services for immediate payment release."; 
						if(!sub.equals("") && sub!=null){  
							subject = sub.trim().replaceAll("<<vocno>>", vocnos.substring(0, vocnos.length()-1));  
						}
						 /*msg="<html>"              
									+" <body>"
									+" <p>Dear Valued Customer <<client>>,</p>"    
									+" <p>In pursuance to Dubai Municipality resolution w.e.f 1st January 2022 towards prepaid tipping fees, attached is the Invoice No. <<vocno>> for the period from <<fromdate>> to <<todate>>.</p>" 
								    +" <p>MR Skips is privileged by stepping towards Dubais paperless goals by sending E-copies of its invoices. We expect your good office to accept this E-Copy invoice and release the payment within 3 days from the date of invoice receipt (E-Copy).</p>" 
									+" <p>Payment can also be made by Bank Transfer with the following details:</p>" 
									+" <p>BANK NAME: COMMERCIAL BANK OF DUBAI <br/>" 
									+"  ACCOUNT NAME: MRSKIPS WASTE SERVICES <br/>" 
									+"  A/C NO: 1001817442 <br/>"  
									+"  IBAN NO: AE330230000001001817442 <br/>" 
									+"  SHEIKH ZAYED ROAD BRANCH <br/>" 
									+"  SWIFT CODE: CBDUAEAD </p>"
									+" <p>If you are not the concern, we request you to escalate the email to the right department for quick action and to avail uninterrupted services. </p>" 
									+" <p>In case of questions, please feel free to get in touch with the undersigned. </p>" 
									+" <p>FOR, <br/>"   
									+" MR SKIPS WASTE SERVICES <br/>" 
									+" Accounts Department. <br/>" 
									+" Mob: +971564096619 / +971545860552, Tel: +97143794989 <br/>" 
									+" Email: invoice@mrskips.net , accounts@mrskips.net <br/>" 
									+" Escalation Level 1: cc@mrskips.net </p>"   
									+" </body>"
								    +" </html>"; */  
						/*msg="<html>"                
								+" <body>"
								+" <p>Dear Valued Customer <<client>>,</p>"    
								+" <p>Please adhere attached <<msgstr0>> of <<msgstr1>> due dates"   
							    +"  for Waste collection invoice will remain as per expressed contract in place and please note tipping fee does not have any credit period will be paid with immediate effect.</p>" 
							    +" <p>You are also aware of newly implemented prepaid Dubai Municipality w.e.f 01.01.2022 on tipping and gate fees.</p>" 
							    +" <p>Payment can also be made by Bank Transfer/Cards with Following Details:</p>" 
								+" <p>BANK NAME : EMIRATES ISLAMIC BANK <br/>" 
								+"  ACCOUNT NAME : MRSKIPS WASTE SERVICES <br/>" 
								+"  A/C NO : 3708442833901 <br/>"  
								+"  IBAN NO : AE070340003708442833901 <br/>" 
								+"  BRANCH : Al Barsha Mall, Dubai, UAE <br/>"  
								+"  SWIFT CODE : MEBLAEAD </p>"
								+" <p>Note:- Mr Skips is privileged by stepping towards Dubai paperless goal and sending E-Copies of its invoices. </p>" 
								+" <p>We expect your good office to accept this e-copy invoice to release the payment.</p>" 
								+" </body>"   
							    +" </html>";*/
						  msg = msg.replace("<<client>>",client); 
						  msg = msg.replace("<<msgstr0>>",msgstr0); 
						  msg = msg.replace("<<msgstr1>>",msgstr1);    
						  //msg = msg.replace("<<fromdate>>",fromdate);  
						  //msg = msg.replace("<<todate>>",todate);
						  //msg = msg.replace("<<vocno>>",vocnos.substring(0, vocnos.length()-1));   
						  
						  String bcc="",urll="",value="";   
				          File saveFile1= null;  
				          urll+=filepaths.substring(0, filepaths.length()-1);   
				          //System.out.println("=="+urll);
				          value=eut.sendEmailpdf(host, port, userName, password, email,cc,subject, msg, urll, bcc, saveFile1);
				          //System.out.println("======"+value);          
				          if(value.equalsIgnoreCase("success")){  
				        		String upsqls="update sk_invm set email=1 where doc_no in("+docnos.substring(0, docnos.length()-1)+")";
				        		//System.out.println("upsqls======"+upsqls);  
				        		stmt1.executeUpdate(upsqls);  
		                		
		                		String[] docarray = docnos.split(",");
		                		String[] vocarray = vocnos.split(",");  
		                		for (int j = 0; j < docarray.length; j++) {
		                			String printdoc=docarray[j];	
		                			String printvoc=vocarray[j];     	
		                			if(!(printdoc.equalsIgnoreCase(""))){
		                				String sqls="insert into emaillog (doc_no, brhId, dtype, edate, userId, refid, email) values ('"+printdoc+"','"+brhid+"','INVD',now(),'"+session.getAttribute("USERID")+"','"+printvoc+"','"+email+"')";
		                				stmt1.executeUpdate(sqls); 
		                			}
		                		}
				           }
				           filepaths="";docnos="";vocnos="";type="";
				           pdfcount=0;     
					  }
					  vocno = rs2.getString("voc_no"); 
					  docno = rs2.getString("doc_no");
					  client = rs2.getString("client");    
					  if(objcommon.getPrintPath("SINV").contains(".jrxml"))  
					  {
					    HttpServletResponse response = ServletActionContext.getResponse();
						String reportFileName = "";
							
							 setUrl(objcommon.getPrintPath("SINV"));  
						   
						     String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
							 headerimgpath=headerimgpath.replace("\\", "\\\\");
							 
							 String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
						         footerimgpath=footerimgpath.replace("\\", "\\\\");
						         String header="1";
						         param.put("header", header);
						         param.put("imgpath", headerimgpath);
						         param.put("docno", docno);       
						         param.put("amntobj", amntobj); 
						         param.put("printby", session.getAttribute("USERNAME"));    
					             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
				     	         JasperReport jasperReport = JasperCompileManager.compileReport(design);
				     	         filepaths+=generateReportPDF1(response, param, jasperReport, conn, email, session, docno, brhid, vocno, subject, msg, client)+",";      
				     	         d2=d1;   
				     	         vocnos+=vocno+",";
				     	         docnos+=docno+",";  
				     	         System.out.println("END"); 
					  } 
					  cldocno=rs2.getString("cldocno");
					  email=rs2.getString("email");
					  brhid=rs2.getString("brhid"); 
					  company=rs2.getString("company");   
					  date=rs2.getString("date");   
					  fromdate=rs2.getString("fromdate");
					  todate=rs2.getString("todate");  
					  type1=rs2.getString("type"); 
					  type+=type1+",";
					  i++;
				} 
				if(d1>0) {
					msgsql = emailcontent.trim().replaceAll("docno", docno);    
					ResultSet rs4 = stmt1.executeQuery(msgsql); 
					while(rs4.next()){
						msg = rs4.getString("msg");
					}
					
					if(type.contains("S") && type.contains("T")) {  
						msgstr1="Waste Collection and Tipping fees,"; 
				    }else if(type.contains("S")) {
						msgstr1="Waste Collection"; 
				    }else if(type.contains("T")) {  
						msgstr1="Tipping fees"; 
				    }else {}
					
					if(pdfcount>1) {   
						msgstr0="invoices";
					}else {
						msgstr0="invoice";  
					}
					//System.out.println(d1+"=="+d2);  
					//System.out.println(docnos+"=="+vocnos+"=="+filepaths);    
					//subject="Invoice No. "+vocnos.substring(0, vocnos.length()-1)+" for MR SKIPS Waste Services for immediate payment release.";   
					if(!sub.equals("") && sub!=null){  
						subject = sub.trim().replaceAll("<<vocno>>", vocnos.substring(0, vocnos.length()-1));  
					}
					/*msg="<html>"              
								+" <body>"
								+" <p>Dear Valued Customer <<client>>,</p>"    
								+" <p>In pursuance to Dubai Municipality resolution w.e.f 1st January 2022 towards prepaid tipping fees, attached is the Invoice No. <<vocno>> for the period from <<fromdate>> to <<todate>>.</p>" 
							    +" <p>MR Skips is privileged by stepping towards Dubais paperless goals by sending E-copies of its invoices. We expect your good office to accept this E-Copy invoice and release the payment within 3 days from the date of invoice receipt (E-Copy).</p>" 
								+" <p>Payment can also be made by Bank Transfer with the following details:</p>" 
								+" <p>BANK NAME: COMMERCIAL BANK OF DUBAI <br/>" 
								+"  ACCOUNT NAME: MRSKIPS WASTE SERVICES <br/>" 
								+"  A/C NO: 1001817442 <br/>"  
								+"  IBAN NO: AE330230000001001817442 <br/>" 
								+"  SHEIKH ZAYED ROAD BRANCH <br/>" 
								+"  SWIFT CODE: CBDUAEAD </p>"
								+" <p>If you are not the concern, we request you to escalate the email to the right department for quick action and to avail uninterrupted services. </p>" 
								+" <p>In case of questions, please feel free to get in touch with the undersigned. </p>" 
								+" <p>FOR, <br/>"   
								+" MR SKIPS WASTE SERVICES <br/>" 
								+" Accounts Department. <br/>" 
								+" Mob: +971564096619 / +971545860552, Tel: +97143794989 <br/>" 
								+" Email: invoice@mrskips.net , accounts@mrskips.net <br/>" 
								+" Escalation Level 1: cc@mrskips.net </p>"   
								+" </body>"
							    +" </html>"; */ 
					/*msg="<html>"                
							+" <body>"
							+" <p>Dear Valued Customer <<client>>,</p>"      
							+" <p>Please adhere attached <<msgstr0>> of <<msgstr1>> due dates"   
						    +"  for Waste collection invoice will remain as per expressed contract in place and please note tipping fee does not have any credit period will be paid with immediate effect.</p>" 
						    +" <p>You are also aware of newly implemented prepaid Dubai Municipality w.e.f 01.01.2022 on tipping and gate fees.</p>" 
						    +" <p>Payment can also be made by Bank Transfer/Cards with Following Details:</p>" 
							+" <p>BANK NAME : EMIRATES ISLAMIC BANK <br/>" 
							+"  ACCOUNT NAME : MRSKIPS WASTE SERVICES <br/>" 
							+"  A/C NO : 3708442833901 <br/>"  
							+"  IBAN NO : AE070340003708442833901 <br/>" 
							+"  BRANCH : Al Barsha Mall, Dubai, UAE <br/>"  
							+"  SWIFT CODE : MEBLAEAD </p>"
							+" <p>Note:- Mr Skips is privileged by stepping towards Dubai paperless goal and sending E-Copies of its invoices. </p>" 
							+" <p>We expect your good office to accept this e-copy invoice to release the payment.</p>" 
							+" </body>"   
						    +" </html>";*/
					  msg = msg.replace("<<client>>",client);    
					  msg = msg.replace("<<msgstr0>>",msgstr0); 
					  msg = msg.replace("<<msgstr1>>",msgstr1);   
					  //msg = msg.replace("<<fromdate>>",fromdate);  
					  //msg = msg.replace("<<todate>>",todate);
					  //msg = msg.replace("<<vocno>>",vocnos.substring(0, vocnos.length()-1));   
					  
					  String bcc="",urll="",value="";   
			          File saveFile1= null;  
			          urll+=filepaths.substring(0, filepaths.length()-1);   
			          //System.out.println("=="+urll);
			          value=eut.sendEmailpdf(host, port, userName, password, email,cc,subject, msg, urll, bcc, saveFile1);
			         // System.out.println("======"+value);          
			          if(value.equalsIgnoreCase("success")){  
			        		String upsqls="update sk_invm set email=1 where doc_no in("+docnos.substring(0, docnos.length()-1)+")";  
			        		//System.out.println("upsqls======"+upsqls);  
			        		stmt1.executeUpdate(upsqls);  
	                		
	                		String[] docarray = docnos.split(",");
	                		String[] vocarray = vocnos.split(",");  
	                		for (int j = 0; j < docarray.length; j++) {
	                			String printdoc=docarray[j];	
	                			String printvoc=vocarray[j];     	
	                			if(!(printdoc.equalsIgnoreCase(""))){
	                				String sqls="insert into emaillog (doc_no, brhId, dtype, edate, userId, refid, email) values ('"+printdoc+"','"+brhid+"','INVD',now(),'"+session.getAttribute("USERID")+"','"+printvoc+"','"+email+"')";
	                				stmt1.executeUpdate(sqls); 
	                			}
	                		}
			           }
			           filepaths="";docnos="";vocnos="";   
				  }
				} catch (Exception e) {
			                 e.printStackTrace();
			             }
			            	 finally{
			            		 if(conn!=null){
			            			 conn.close();
			            		 }
						} 
			}
			 private String generateReportPDF1(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn, String email,HttpSession session,String printdoc,String brhid,String refid,String subject,String msg,String client)throws JRException, NamingException, SQLException, IOException, MessagingException, javax.mail.MessagingException {
				  byte[] bytes = null;
		          bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		          resp.reset();
		          resp.resetBuffer();
		          ClsEncrypt ClsEncrypt=new ClsEncrypt();
		          resp.setContentType("application/pdf");
		          resp.setContentLength(bytes.length);
		          ServletOutputStream ouputStream = resp.getOutputStream();
		         
			         Statement stmt =conn.createStatement(); 
			         String strSql = "select smtpServer, smtpHostPort,signature,email,mailpass from my_user where doc_no='"+session.getAttribute("USERID")+"'";
			      	 ResultSet rs = stmt.executeQuery(strSql);
			      	 String host="",port="",signature="",userName="",password="";
			      	 while(rs.next()) {
			      		host=rs.getString("smtpServer").trim();
			      		port=rs.getString("smtpHostPort").trim();
			      		signature=rs.getString("signature").trim();
			      		userName=rs.getString("email").trim();
			      		password=ClsEncrypt.getInstance().decrypt(rs.getString("mailpass").trim());
			         } 
				 
		        	String fileName="",path="", formcode="INVD",filepath="",cc=""; 
		        	String strSql1 = "select imgPath from my_comp";
		      		ResultSet rs1 = stmt.executeQuery(strSql1);
		      		while(rs1.next ()) {
		      			path=rs1.getString("imgPath");
		      		}

		      		DateFormat dateFormat = new SimpleDateFormat("dd_MM_yyyy_HH_mm_ss");
		    		java.util.Date date = new java.util.Date();
		    		String currdate=dateFormat.format(date);
		    		
		    		fileName = client+" - "+refid+".pdf";     
		      		//fileName = "InvoiceToBeDispath"+currdate+"_"+refid+".pdf";    
		      		filepath=path+ "/attachment/"+formcode+"/"+fileName;

		      		File dir = new File(path+ "/attachment/"+formcode);
		      		dir.mkdirs();
		      		
		      		FileOutputStream fos = new FileOutputStream(filepath);
		        	fos.write(bytes);
		        	fos.flush();
		        	fos.close();
		        	
		        	File saveFile=new File(filepath);
		        	return filepath;
		      }
}
