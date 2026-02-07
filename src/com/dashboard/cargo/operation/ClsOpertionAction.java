package com.dashboard.cargo.operation;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;   
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.*;
import com.connection.ClsConnection;
import com.mailwithpdf.EmailProcess;
import com.mailwithpdf.SendEmailAction;
import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

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

public class ClsOpertionAction {
	ClsCommon cmn=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();  
	private String url;
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String printAction() throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String trno=request.getParameter("trno");      
		String mainsql="",address="",imgpath="",comp="",tel="",fax="",cmpname="",printedby="";             
		String remarks="",volume="",subjbono="",jobno="",tradecode="",hawb="",mawb="",shipper="",consignee="",salesman="",refname="",origin="",pol="",pod="",wight="";
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
					 java.sql.Date sqltodate = null,sqlfromdate=null;
					 String sqltest1="";
					String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs123 = stmt.executeQuery(sql123);    
					while(rs123.next()){
						printedby=rs123.getString("USER_NAME");    
					}
					String sql777="select m.confirm_no jobno, sc.doc_no subjbono, sp.shipment tradecode, hawb, mawb,shipper, consignee, sal.sal_name salesman,"
							+ " ac.refname, ed.origin, ed.pol, ed.pod, ed.wight, ed.volume, ed.remarks from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno  left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno  left join cr_qotm m on m.rrefno=em.doc_no and m.reftype='ENQ' left join my_acbook ac on ac.cldocno=sc.cldocno and ac.dtype='CRM' left join cr_shipment sp on sp.doc_no=ed.shipid left join my_salm sal on sal.doc_no=ac.sal_id left join cr_cfim cm on sc.cfidocno=cm.doc_no where  sc.status<>7 and sc.tr_no="+trno+" group by sc.tr_no";   
					//System.out.println("print main--->>>"+sql777); 
					ResultSet rs777 = stmt.executeQuery(sql777); 
					while(rs777.next()){
						jobno=rs777.getString("jobno");  
						subjbono=rs777.getString("subjbono"); 
						tradecode=rs777.getString("tradecode"); 
						hawb=rs777.getString("hawb"); 
						mawb=rs777.getString("mawb"); 
						shipper=rs777.getString("shipper"); 
						consignee=rs777.getString("consignee"); 
						refname=rs777.getString("refname"); 
						origin=rs777.getString("origin"); 
						pol=rs777.getString("pol"); 
						pod=rs777.getString("pod"); 
						wight=rs777.getString("wight"); 
						volume=rs777.getString("volume"); 
						remarks=rs777.getString("remarks");
						salesman=rs777.getString("salesman");
					}
					
					String sql="select company,address,tel,fax from  my_comp group by doc_no limit 1";   
					//System.out.println("print main--->>>"+sql); 
					ResultSet resultSet = stmt.executeQuery(sql);         
					while(resultSet.next()){
						comp=resultSet.getString("company");
						tel=resultSet.getString("tel");
						fax=resultSet.getString("fax");
						address=resultSet.getString("address");
					}
					String gpper="";
					String marginsql="select round((coalesce(sum(revenue)-sum(amount),0)/sum(revenue))*100,2) gpper from (select refdetails srvtype,convert(type,char(250)) type,convert(account,char(50)) account,sum(expense) amount,sum(revenue) revenue,coalesce(sum(revenue)-sum(expense),0) gpval from(select DISTINCT group_concat(CONCAT(ex.type ,' - ',INVNO,' - ',DATE_FORMAT(EX.INVdate, '%d.%m.%Y '))) type,group_concat(h.description) account,ss.doc_no,ss.srvtype refdetails,0 revenue,coalesce(sum(ex.amount),0) expense from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno left join cr_expense ex on sc.tr_no=ex.rdocno left join cr_srvtype ss on (ss.doc_no=ex.srvdocno) left join my_head h on h.doc_no=ex.acno where sc.status<>7 and sc.tr_no="+trno+" group by ss.doc_no union all select '' type,'' account,ss.doc_no,ss.srvtype refdetails,coalesce(sum(d.tobebilled),0) revenue,0 expense from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno left join cr_qotjobd d on ed.doc_no=d.refdocno left join cr_srvtype ss on (ss.doc_no=d.typeid) where sc.status<>7  and sc.tr_no="+trno+"  group by ss.doc_no)a group by refdetails) a";
					resultSet = stmt.executeQuery(marginsql);         
					while(resultSet.next()){
						gpper=resultSet.getString("gpper");
					}
					
						
					mainsql="select refdetails srvtype,convert(type,char(250)) type,convert(account,char(50)) account,round(sum(expense),2) amount,round(sum(revenue),2) revenue,round(coalesce(sum(revenue)-sum(expense),0),2) gpval from(select DISTINCT group_concat(CONCAT(ex.type ,' - ',INVNO,' - ',DATE_FORMAT(EX.INVdate, '%d.%m.%Y '))) type,group_concat(h.description) account,ss.doc_no,ss.srvtype refdetails,0 revenue,coalesce(sum(ex.amount),0) expense from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno left join cr_expense ex on sc.tr_no=ex.rdocno left join cr_srvtype ss on (ss.doc_no=ex.srvdocno) left join my_head h on h.doc_no=ex.acno where sc.status<>7 and sc.tr_no="+trno+" group by ss.doc_no union all select '' type,'' account,ss.doc_no,ss.srvtype refdetails,coalesce(sum(d.tobebilled),0) revenue,0 expense from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_enqm em on em.doc_no=ed.rdocno left join cr_qotjobd d on ed.doc_no=d.refdocno  and sc.tr_no=d.jobno left join cr_srvtype ss on (ss.doc_no=d.typeid) where sc.status<>7  and sc.tr_no="+trno+"  group by ss.doc_no)a group by refdetails";
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			        System.out.println(".....in...."+mainsql);    
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        /*param.put("comp",comp); 
			        param.put("address",address);
			        param.put("tel",tel);
			        param.put("fax",fax);*/   
			        param.put("mainsql",mainsql);
			        param.put("jobno",jobno);
			        param.put("subjobno",subjbono);    
			        param.put("tradecode",tradecode);  
			        param.put("hawb",hawb);
			        param.put("mawb",mawb);
			        param.put("shipper",shipper);
			        param.put("consignee",consignee);
			        param.put("billingparty",refname);
			        param.put("origin",origin);
			        param.put("pol",pol);
			        param.put("pod",pod);
			        param.put("weight",wight);
			        param.put("volume",volume);
			        param.put("container",remarks);
			        param.put("salesman",salesman);
			        param.put("salesman",salesman);
			        param.put("gpper",gpper);
			        
			        
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/cargo/operation/costsheetprint.jrxml"));     
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
	public String printJCAction() throws ParseException, SQLException{                
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String trno=request.getParameter("trno");      
		String enqdocno="",terms="",carrier="",flight="",mainsql="",address="",imgpath="",comp="",tel="",fax="",cmpname="",printedby="",fdc="";             
		String mode="",remarks="",volume="",subjbono="",jobno="",tradecode="",hawb="",mawb="",shipper="",consignee="",salesman="",refname="",origin="",pol="",pod="",wight="";
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
					 java.sql.Date sqltodate = null,sqlfromdate=null,eta=null,etd=null,jobdate=null;
					 String sqltest1="";
					String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs123 = stmt.executeQuery(sql123);    
					while(rs123.next()){
						printedby=rs123.getString("USER_NAME");    
					}
					String sql777="select em.doc_no enqdocno,ct.terms,md.modename mode,carrier,concat(flightno,'/',date_format(eta,'%d-%m-%Y')) flight,eta,etd,concat(ed.pol,'/',ed.pod) fdc,m.confirm_date jobdate,m.confirm_no jobno, sc.doc_no subjbono, sp.shipment tradecode, hawb, mawb,shipper, consignee, sal.sal_name salesman,"
							+ " ac.refname, ed.origin, ed.pol, ed.pod, ed.wight, ed.volume, ed.remarks from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno  left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_terms ct on ct.doc_no=ed.termsid left join cr_enqm em on em.doc_no=ed.rdocno  "
							+ " left join cr_qotm m on m.rrefno=em.doc_no and m.reftype='ENQ' left join my_acbook ac on ac.cldocno=sc.cldocno and ac.dtype='CRM' left join cr_shipment sp on sp.doc_no=ed.shipid left join my_salm sal on sal.doc_no=ac.sal_id left join cr_cfim cm on sc.cfidocno=cm.doc_no left join cr_mode md on md.doc_no=ed.modeid where sc.status<>7 and sc.tr_no="+trno+" group by sc.tr_no";   
					//System.out.println("print main--->>>"+sql777);    
					ResultSet rs777 = stmt.executeQuery(sql777); 
					while(rs777.next()){
						enqdocno=rs777.getString("enqdocno");
						terms=rs777.getString("terms");
						mode=rs777.getString("mode");
						carrier=rs777.getString("carrier");
						flight=rs777.getString("flight");
						eta=rs777.getDate("eta"); 
						etd=rs777.getDate("etd");       
						fdc=rs777.getString("fdc");
						jobdate=rs777.getDate("jobdate");    
						jobno=rs777.getString("jobno");  
						subjbono=rs777.getString("subjbono"); 
						tradecode=rs777.getString("tradecode"); 
						hawb=rs777.getString("hawb"); 
						mawb=rs777.getString("mawb"); 
						shipper=rs777.getString("shipper"); 
						consignee=rs777.getString("consignee"); 
						refname=rs777.getString("refname"); 
						origin=rs777.getString("origin"); 
						pol=rs777.getString("pol"); 
						pod=rs777.getString("pod"); 
						wight=rs777.getString("wight"); 
						volume=rs777.getString("volume"); 
						remarks=rs777.getString("remarks");
						salesman=rs777.getString("salesman");
					}
					
					String sql="select company,address,tel,fax from  my_comp group by doc_no limit 1";   
					//System.out.println("print main--->>>"+sql); 
					ResultSet resultSet = stmt.executeQuery(sql);         
					while(resultSet.next()){
						comp=resultSet.getString("company");
						tel=resultSet.getString("tel");
						fax=resultSet.getString("fax");
						address=resultSet.getString("address");
					}
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        /*param.put("comp",comp); 
			        param.put("address",address);
			        param.put("tel",tel);
			        param.put("fax",fax);*/   
			        param.put("mainsql",mainsql);
			        param.put("jobno",jobno);
			        param.put("jobdate",jobdate);  
			        param.put("subjobno",subjbono);    
			        param.put("tradecode",tradecode);  
			        param.put("hawb",hawb);
			        param.put("mawb",mawb);
			        param.put("shipper",refname);
			        param.put("consignee",consignee);
			        param.put("billingparty",refname);
			        param.put("bcustomer",refname);
			        param.put("fnp",refname);
			        param.put("origin",origin);  
			        param.put("pol",pol);
			        param.put("pod",pod);
			        param.put("weight",wight);
			        param.put("volume",volume);
			        param.put("container",remarks);
			        param.put("salesman",salesman);
			        param.put("salesman",salesman);
			        param.put("eta",eta);
			        param.put("etd",etd);
			        param.put("fdc",fdc);  
			        param.put("flight",flight);  
			        param.put("carrier",carrier);
			        param.put("frieght",mode);
			        param.put("descptn",remarks);
			        param.put("tos",terms);
			        param.put("enqdocno",enqdocno);
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/cargo/operation/jobcard.jrxml"));     
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
	public String printTCNAction() throws ParseException, SQLException{                  
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String trno=request.getParameter("trno");      
		String truckno="",enqdocno="",terms="",carrier="",flight="",mainsql="",address="",imgpath="",comp="",tel="",fax="",cmpname="",printedby="",fdc="";             
		String mode="",remarks="",volume="",subjbono="",jobno="",tradecode="",hawb="",mawb="",shipper="",consignee="",salesman="",refname="",origin="",pol="",pod="",wight="";
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = ClsConnection.getMyConnection();    
					stmt=conn.createStatement();
					 java.sql.Date sqltodate = null,sqlfromdate=null,eta=null,etd=null,jobdate=null;
					 String sqltest1="";
					String sql123="select USER_NAME from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
					//System.out.println("print main--->>>"+sql123); 
					ResultSet rs123 = stmt.executeQuery(sql123);    
					while(rs123.next()){
						printedby=rs123.getString("USER_NAME");    
					}
					String sql777="select truckno,em.doc_no enqdocno,ct.terms,md.modename mode,carrier,concat(flightno,'/',date_format(eta,'%d-%m-%Y')) flight,eta,etd,concat(ed.pol,'/',ed.pod) fdc,m.confirm_date jobdate,m.confirm_no jobno, sc.doc_no subjbono, sp.shipment tradecode, hawb, mawb,shipper, consignee, sal.sal_name salesman,"
							+ " ac.refname, ed.origin, ed.pol, ed.pod, ed.wight, ed.volume, ed.remarks from cm_srvcontrm sc left join cr_joblist l on sc.tr_no=l.jobno  left join cr_enqd ed on l.enqdocno=ed.doc_no left join cr_terms ct on ct.doc_no=ed.termsid left join cr_enqm em on em.doc_no=ed.rdocno  "
							+ " left join cr_qotm m on m.rrefno=em.doc_no and m.reftype='ENQ' left join my_acbook ac on ac.cldocno=sc.cldocno and ac.dtype='CRM' left join cr_shipment sp on sp.doc_no=ed.shipid left join my_salm sal on sal.doc_no=ac.sal_id left join cr_cfim cm on sc.cfidocno=cm.doc_no left join cr_mode md on md.doc_no=ed.modeid where sc.status<>7 and sc.tr_no="+trno+" group by sc.tr_no";   
					//System.out.println("print main--->>>"+sql777);    
					ResultSet rs777 = stmt.executeQuery(sql777); 
					while(rs777.next()){
						enqdocno=rs777.getString("enqdocno");
						terms=rs777.getString("terms");
						mode=rs777.getString("mode");
						carrier=rs777.getString("carrier");
						flight=rs777.getString("flight");
						eta=rs777.getDate("eta"); 
						etd=rs777.getDate("etd");       
						fdc=rs777.getString("fdc");
						jobdate=rs777.getDate("jobdate");    
						jobno=rs777.getString("jobno");  
						subjbono=rs777.getString("subjbono"); 
						tradecode=rs777.getString("tradecode"); 
						hawb=rs777.getString("hawb"); 
						mawb=rs777.getString("mawb"); 
						shipper=rs777.getString("shipper"); 
						consignee=rs777.getString("consignee"); 
						refname=rs777.getString("refname"); 
						origin=rs777.getString("origin"); 
						pol=rs777.getString("pol"); 
						pod=rs777.getString("pod"); 
						wight=rs777.getString("wight"); 
						volume=rs777.getString("volume"); 
						remarks=rs777.getString("remarks");
						salesman=rs777.getString("salesman");
						truckno=rs777.getString("truckno");
					}
					
					String sql="select company,address,tel,fax from  my_comp group by doc_no limit 1";   
					//System.out.println("print main--->>>"+sql); 
					ResultSet resultSet = stmt.executeQuery(sql);         
					while(resultSet.next()){
						comp=resultSet.getString("company");
						tel=resultSet.getString("tel");
						fax=resultSet.getString("fax");
						address=resultSet.getString("address");
					}
				    imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");      
			        //String user=session.getAttribute("USERNAME").toString();
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        /*param.put("comp",comp); 
			        param.put("address",address);
			        param.put("tel",tel);
			        param.put("fax",fax);*/   
			        param.put("mainsql",mainsql);
			        param.put("jobno",jobno);
			        param.put("jobdate",jobdate);  
			        param.put("subjobno",subjbono);    
			        param.put("tradecode",tradecode);  
			        param.put("hawb",hawb);
			        param.put("mawb",mawb);
			        param.put("shpname",refname);   
			        param.put("cosname",refname);
			        param.put("billingparty",refname);
			        param.put("contactinfo",refname);
			        param.put("fnp",refname);
			        param.put("origin",origin);  
			        param.put("opoint",pol);
			        param.put("destpoint",pod);
			        param.put("weight",wight);
			        param.put("volume",volume);
			        param.put("container",remarks);
			        param.put("salesman",salesman);
			        param.put("salesman",salesman);
			        param.put("eta",eta);
			        param.put("etd",etd);
			        param.put("fdc",fdc);  
			        param.put("flight",flight);  
			        param.put("carrier",carrier);
			        param.put("frieght",mode);
			        param.put("descptn",remarks);  
			        param.put("tos",terms);
			        param.put("enqdocno",enqdocno);
			        param.put("tplateno",truckno);
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/cargo/operation/trucknote.jrxml"));     
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
