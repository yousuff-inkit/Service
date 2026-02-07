package com.dashboard.sales.salesreport;

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

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

import org.apache.poi.util.SystemOutLogger;
import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsSalesReportAction {

	
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
		
		System.out.println("Action");
		 HttpServletRequest request=ServletActionContext.getRequest();
		 HttpServletResponse response=ServletActionContext.getResponse();
		 HttpSession session=request.getSession();
		 ClsCommon common=new ClsCommon();
		
		 //System.out.println("----inside action-----: "+common.getPrintPath(dtype).contains(".jrxml"));
		 
		 
		 
		 
		 
		 
     // if(common.getPrintPath(dtype).contains(".jrxml")==true)
					  
      	   System.out.println("iside jrxml");
      	   ClsConnection conobj=new ClsConnection();
											 
      	   param = new HashMap();
      	   Connection conn = null;
      	   conn = conobj.getMyConnection();	        	   
      	  
      	   String summaryType=request.getParameter("summarytype").toString();
      	   String hidpassdate=request.getParameter("passdate").toString();
      	   String fromDate=request.getParameter("fromdate").toString();
      	   String toDate=request.getParameter("todate").toString();
      	   String hidaccno=request.getParameter("Accno").toString();
      	   String hidsalesman=request.getParameter("salesman").toString();
      	   String hidproductid=request.getParameter("productid").toString();
      	   String hidbrandid=request.getParameter("brandid").toString();
      	   String hideptid=request.getParameter("ptid").toString();
      	   System.out.println("sqlfromdate"+fromDate);
      	 System.out.println("sqltodate"+toDate);
      	   System.out.println("values===="+summaryType+hidpassdate+fromDate+toDate+hidaccno+hidsalesman+hidproductid+hidbrandid+hideptid);
      	   try {
      		 
      		 java.sql.Date sqlfromdate=null;
 			java.sql.Date sqltodate=null;
 			
         	String sqlgroup1="",sqlgroup2=" group by m.refno";;
         	String sqlfilter="";
         	String sqljoin="";
         	String sqlref="";
         	
         	if(summaryType.equalsIgnoreCase("acc")){
         		sqlref+=" m.acno refno,h.description refname,";
         		sqljoin+=" left join my_head h on m.acno=h.account";
         		sqlgroup1+=" group by m.acno";
         		System.out.println("1");
         		
         	} else if(summaryType.equalsIgnoreCase("slm")){
         		sqlref+=" m.sal_id refno,s.sal_name refname,";
         		sqljoin+=" left join my_salm s on s.sal_id=m.sal_id";
         		sqlgroup1+=" group by m.sal_id";
         	} else if(summaryType.equalsIgnoreCase("dat")){
         		sqlgroup1+=" group by m.date  ";
         		sqlgroup2=" group by m.refname ";
         		sqlref+=" day(m.date) refno , DATE_FORMAT(m.date,'%d.%m.%Y') refname,";
         	} else if(summaryType.equalsIgnoreCase("prd")){
         		sqlref+=" n.psrno refno,n.productname refname,";
         		sqljoin+=" left join my_main n on d.psrno=n.psrno";
         		sqlgroup1+=" group by n.psrno";
         	} else if(summaryType.equalsIgnoreCase("brd")){
         		sqlref+=" n.brandid refno,b.brand refname,";
         		sqljoin+=" left join my_main n on d.psrno=n.psrno left join my_brand b on b.doc_no=n.brandid";
         		sqlgroup1+=" group by n.brandid";
         	} else if(summaryType.equalsIgnoreCase("dpt")){
         		sqlgroup1+=" group by n.deptid";
         		sqljoin+=" left join my_main n on d.psrno=n.psrno left join my_dept dt on dt.doc_no=n.deptId";
         		sqlref+=" n.deptid refno,dt.department refname,";
         	}

 			if(hidpassdate.equalsIgnoreCase("")){
 				if(!fromDate.equalsIgnoreCase("")&&!fromDate.equalsIgnoreCase("0")){
 					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromDate);
 				}
 				if(!toDate.equalsIgnoreCase("")&&!toDate.equalsIgnoreCase("0")){
 					sqltodate=ClsCommon.changeStringtoSqlDate(toDate);
 				}
 				sqlfilter+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
 			}
 			else{
 				sqlfilter+=" and m.date in ("+hidpassdate+")";
 			} 
 			if(!hidaccno.equalsIgnoreCase("")){
         		sqlfilter+=" and h.doc_no in ("+hidaccno+")";
         		if(!summaryType.equalsIgnoreCase("acc")){
 	        		sqljoin+=" left join my_head h on m.acno=h.account";
 	        	}
         	}
 			if(!hidsalesman.equalsIgnoreCase("")){
         		sqlfilter+=" and s.doc_no in ("+hidsalesman+")";
         		if(!summaryType.equalsIgnoreCase("slm")){
         			sqljoin+=" left join my_salm s on s.sal_id=m.sal_id";
 	        	}
         	}
 			if(!hidproductid.equalsIgnoreCase("")){
         		sqlfilter+=" and n.doc_no in ("+hidproductid+")";
         		if(!summaryType.equalsIgnoreCase("prd")){
         			if(!sqljoin.contains("my_main")){
        				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
         			}
         			sqljoin+=" left join my_main n on d.psrno=n.psrno";
 	        	}
         	}
         	if(!hidbrandid.equalsIgnoreCase("")){
         		sqlfilter+=" and b.doc_no in ("+hidbrandid+")";
         		if(!summaryType.equalsIgnoreCase("brd")){
         			if(!sqljoin.contains("my_main")){
         				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
         			}
         			sqljoin+=" left join my_brand b on b.doc_no=n.brandid";
 	        	}
         	}
         	if(!hideptid.equalsIgnoreCase("")){
         		sqlfilter+=" and dt.doc_no in ("+hideptid+")";
         		if(!summaryType.equalsIgnoreCase("dpt")){
         			if(!sqljoin.contains("my_main")){
        				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
         			}
         			sqljoin+=" left join my_dept dt on dt.doc_no=n.deptId ";
 	        	}
         	}
         	
         	conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
      		   
      		   
      		 String sqlss="  ";
      		String ss="";
      		String ss1="";
      		String ss2="";
      					if(summaryType.equalsIgnoreCase("dat")){
      						sqlss=" refname date ,";
      						ss1= " m.date d1, ";
      						ss2= " d1, ";
      						ss= " order by d1 ";
      					}
      					
      		   
      		   
      		 String strSql="select @i:=@i+1 as srno,a.* from(select "+ss2+" refno,refname,"+sqlss+"round(sum(sales),2) sales,round(sum(retamt),2) retamt,round(sum(sales)-sum(retamt),2) nettotal  from "
 					+ "(select "+ss1+" "+sqlref+"  m.cldocno,sum(d.total) sales ,0 retamt  "
 					+ " from my_invM m inner join my_inVd d on m.doc_no=d.rdocno "+sqljoin+
 					" where m.status=3 "+sqlfilter+sqlgroup1+""
 					+ "	UNION ALL select "+ss1+" "+sqlref+" m.cldocno,0 sales ,sum(d.total) retamt  "
 					+ " from my_invr m inner join my_inrd d on m.doc_no=d.rdocno "+sqljoin
 					+ " where m.status=3  "+sqlfilter+sqlgroup1+" ) m  "
 					+sqlgroup2+"  "+ss+" )a,(select @i:=0) r ";

      		   System.out.println("query++++++++++"+strSql);
      		   System.out.println("detaisl===="+ss2+sqlss+ss1+sqlref+sqljoin+sqlfilter+sqlgroup1+sqlgroup2+ss);
      		   
      		   
      		  param.put("gridquery",strSql);
      		  param.put("fromdate", fromDate);
      		  param.put("todate",toDate);
      		   /*param.put("ss2",ss2 );
      		   param.put("sqlss",sqlss);
      		   param.put("ss1",ss1);
      		   param.put("sqlref",sqlref);
      		   param.put("sqljoin",sqljoin);
      		   param.put("sqlfilter",sqlfilter);
      		   param.put("sqlgroup1",sqlgroup1);
      		   param.put("sqlgroup2",sqlgroup2);
      		   param.put("ss",ss);
      		  */
      		     JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/sales/salesreport/SalesReportPrint.jrxml"));	      	     	 
	             JasperReport jasperReport = JasperCompileManager.compileReport(design);
                 generateReportPDF(response, param, jasperReport, conn);
      	   
      	   
      	   
      	   
                 stmt.close();
     			conn.close();
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

	
	
	
	
	

