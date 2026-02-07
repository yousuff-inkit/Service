package com.dashboard.procurment.productdetailsnew;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
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
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsProductDetailsAction extends ActionSupport{
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsProductDetailsDAO productdetailsDAO= new ClsProductDetailsDAO();
	ClsProductDetailsBean productdetailsBean;
	
	//Print
	private String lblcompname;
	private String lblcompaddress;
	private String lblprintname;
	private String lblprintname1;
	private String lblcomptel;
	private String lblcompfax;
	private String lblbranch;
	private String lbllocation;
	private String lblservicetax;
	private String lblpan;
	private String lblcstno;
	private String lblcashtotal;
	private String lblcardtotal;
	private String lblchequetotal;
	private String lblappliedtotal;
	private String lblbalancetotal;
	private String lblnetbalance,lblprid,lbldepartment;
	private String url;
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getLblprid() {
		return lblprid;
	}
	public void setLblprid(String lblprid) {
		this.lblprid = lblprid;
	}
	public String getLbldepartment() {
		return lbldepartment;
	}
	public void setLbldepartment(String lbldepartment) {
		this.lbldepartment = lbldepartment;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLblcompaddress() {
		return lblcompaddress;
	}
	public void setLblcompaddress(String lblcompaddress) {
		this.lblcompaddress = lblcompaddress;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
	}
	public String getLblcomptel() {
		return lblcomptel;
	}
	public void setLblcomptel(String lblcomptel) {
		this.lblcomptel = lblcomptel;
	}
	public String getLblcompfax() {
		return lblcompfax;
	}
	public void setLblcompfax(String lblcompfax) {
		this.lblcompfax = lblcompfax;
	}
	public String getLblbranch() {
		return lblbranch;
	}
	public void setLblbranch(String lblbranch) {
		this.lblbranch = lblbranch;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
	}
	public String getLblservicetax() {
		return lblservicetax;
	}
	public void setLblservicetax(String lblservicetax) {
		this.lblservicetax = lblservicetax;
	}
	public String getLblpan() {
		return lblpan;
	}
	public void setLblpan(String lblpan) {
		this.lblpan = lblpan;
	}
	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
	}
	public String getLblcashtotal() {
		return lblcashtotal;
	}
	public void setLblcashtotal(String lblcashtotal) {
		this.lblcashtotal = lblcashtotal;
	}
	public String getLblcardtotal() {
		return lblcardtotal;
	}
	public void setLblcardtotal(String lblcardtotal) {
		this.lblcardtotal = lblcardtotal;
	}
	public String getLblchequetotal() {
		return lblchequetotal;
	}
	public void setLblchequetotal(String lblchequetotal) {
		this.lblchequetotal = lblchequetotal;
	}
	public String getLblappliedtotal() {
		return lblappliedtotal;
	}
	public void setLblappliedtotal(String lblappliedtotal) {
		this.lblappliedtotal = lblappliedtotal;
	}
	public String getLblbalancetotal() {
		return lblbalancetotal;
	}
	public void setLblbalancetotal(String lblbalancetotal) {
		this.lblbalancetotal = lblbalancetotal;
	}
	public String getLblnetbalance() {
		return lblnetbalance;
	}
	public void setLblnetbalance(String lblnetbalance) {
		this.lblnetbalance = lblnetbalance;
	}
	
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	
	public String printAction() throws ParseException, SQLException{
//		System.out.println("nnnnnnn");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
				
		String barchval = request.getParameter("barchval");
		String statusselect = request.getParameter("statusselect");
		String psrno = request.getParameter("psrno");
		String locid = request.getParameter("locid");
		String hidbrand = request.getParameter("hidbrand");
		String hidtype = request.getParameter("hidtype");
		String hidcat = request.getParameter("hidcat");
		String hidsubcat = request.getParameter("hidsubcat");
		String hidproduct = request.getParameter("hidproduct");
		String branchid = request.getParameter("branchid");
		String hidept = request.getParameter("hidept");
		
		String hidcldocno = request.getParameter("hidcldocno");
		String hidacno = request.getParameter("hidacno");
		String type = request.getParameter("type");
		
	
		
		
		
		
		
		productdetailsBean=productdetailsDAO.getPrint(request,barchval,statusselect,psrno,locid,hidbrand,hidtype,hidproduct,hidcat,hidsubcat,branchid,hidept,type,hidcldocno,hidacno);
		setLblcompname(productdetailsBean.getLblcompname());
		setLblcompaddress(productdetailsBean.getLblcompaddress());
		setLblprintname(productdetailsBean.getLblprintname());
		setLblprintname1(productdetailsBean.getLblprintname1());
		setLblcomptel(productdetailsBean.getLblcomptel());
		setLblcompfax(productdetailsBean.getLblcompfax());
		setLblbranch(productdetailsBean.getLblbranch());
		setLbllocation(productdetailsBean.getLbllocation());
		setLblservicetax(productdetailsBean.getLblservicetax());
		setLblpan(productdetailsBean.getLblpan());
		setLblcstno(productdetailsBean.getLblcstno());
		setLblcashtotal(productdetailsBean.getLblcashtotal());
		setLblcardtotal(productdetailsBean.getLblcardtotal());
		setLblchequetotal(productdetailsBean.getLblchequetotal());
		setLblappliedtotal(productdetailsBean.getLblappliedtotal());
		setLblbalancetotal(productdetailsBean.getLblbalancetotal());
		setLblnetbalance(productdetailsBean.getLblnetbalance());
		setLbldepartment(productdetailsBean.getLbldepartment());
		setLblprid(productdetailsBean.getLblprid());
		
		if(commonDAO.getBIBPrintPath("BPD").contains(".jrxml")==true)
		{
			HttpServletResponse response = ServletActionContext.getResponse();
			
			 Connection conn = null;
			
			 try {
				 param = new HashMap();
			
		      	 conn = connDAO.getMyConnection();
             	 Statement stmtPC = conn.createStatement();
                 String reportFileName="Stocklist";
                 String sqltest="";
     	        String sqltest1="";
     	        String sqltest2="";
     	        
     	    	if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
     	    		//sqltest+=" and i.brhid='"+barchval+"'";
     	    		sqltest2+=" and i.brhid='"+barchval+"'";
     	 		}
     	    	
     	    	 
     	    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase(""))&&(!(psrno.equalsIgnoreCase("0"))))){
     	    		sqltest+=" and m.doc_no='"+psrno+"'";
     	 		}
     	    	
     	    	if((!(locid.equalsIgnoreCase("NA")) )&&(!(locid.equalsIgnoreCase(""))&&(!(locid.equalsIgnoreCase("0"))))){
     	    		sqltest2+=" and i.locid='"+locid+"'";
     	 		}
     	    	
     	    	if((!(hidbrand.equalsIgnoreCase("NA")) )&&(!(hidbrand.equalsIgnoreCase(""))&&(!(hidbrand.equalsIgnoreCase("0"))))){
     	    		sqltest+=" and m.brandid in("+hidbrand+")";
     	 		}
     	    	if((!(hidtype.equalsIgnoreCase("NA")) )&&(!(hidtype.equalsIgnoreCase(""))&&(!(hidtype.equalsIgnoreCase("0"))))){
     	    		sqltest+=" and m.typeid in ("+hidtype+")";
     	 		}
     	    	if((!(hidproduct.equalsIgnoreCase("NA")) )&&(!(hidproduct.equalsIgnoreCase(""))&&(!(hidproduct.equalsIgnoreCase("0"))))){
     	    		sqltest+=" and m.doc_no in ("+hidproduct+")";
     	 		}
     	    	if((!(hidcat.equalsIgnoreCase("NA")) )&&(!(hidcat.equalsIgnoreCase(""))&&(!(hidcat.equalsIgnoreCase("0"))))){
     	    		sqltest+=" and m.catid in ("+hidcat+")";
     	 		}
     	    	if((!(hidsubcat.equalsIgnoreCase("NA")) )&&(!(hidsubcat.equalsIgnoreCase(""))&&(!(hidsubcat.equalsIgnoreCase("0"))))){
     	    		sqltest+=" and m.scatid in ("+hidsubcat+")";
     	 		}
     	    	if((!(hidept.equalsIgnoreCase("NA")) )&&(!(hidept.equalsIgnoreCase(""))&&(!(hidept.equalsIgnoreCase("0"))))){
     	    		sqltest+=" and m.deptid in ("+hidept+")";
     	 		}
     	    	String sqltest3="";
     	    	if((!(hidcldocno.equalsIgnoreCase("NA")) )&&(!(hidcldocno.equalsIgnoreCase(""))&&(!(hidcldocno.equalsIgnoreCase("0"))))){
    	    		sqltest+=" and vb.rdocno='"+hidcldocno+"'";
    	    		sqltest3= " inner join my_vendorbrand vb on vb.brandid=m.brandid ";
    	    		
    	 		}
                /* String sqlStock ="select @i:=@i+1 srno,b.* from(select i.locid,i.brhid,d.department,bd.brandname,round(i.qty,0) qty ,m.part_no productid,m.productname,"
				+ " round(fixingprice,2) price, DATE_FORMAT(exp_date, '%d-%m-%Y')expry  from my_main m left join (select i.locid,i.brhid,"
				+ " sum(i.op_qty-i.out_qty) qty,i.prdid from my_prddin i where 1=1 "+sqltest2+" group by psrno having qty>0)  i on m.doc_no=i.prdId"
				+ " left join (select i.locid,i.brhid,sum(i.op_qty-i.out_qty) qty,min(exp_date) exp_date,i.prdid from my_prddin i where 1=1 "+sqltest2+" "
				+ " group by psrno having qty>0)  e on m.doc_no=e.prdId  left join my_desc de on(de.psrno=m.doc_no and i.brhid= de.brhid)"
				+ " left join  my_brand bd on m.brandid=bd.doc_no "
				+ "  left join my_dept d on d.doc_no=m.deptid  "+sqltest3+" where 1=1 "+sqltest+" "+sqltest2+") b,(select @i:=0) as i";
                 */
     	    	
     	    	String sqlStock ="select @i:=@i+1 srno,b.* from(select concat(d.department) department,round(i.qty,0) qty ,m.productname,bd.brandname,"
       		 + "round(fixingprice,2) price, coalesce(DATE_FORMAT(coalesce(exp_date,''), '%m/%y'),'') expry, convert(concat (round(coalesce(f1.qty,''),0),'+',"
       		 + "(round(coalesce (f1.foc,''),0) )),char(100)) 'foc1' ,convert(concat (round(coalesce(f2.qty,''),0),'+',"
       		 + " round(coalesce (f2.foc,''),0)),char(100)) foc2, convert(concat (round(coalesce(f3.qty,''),0),'+',"
       		 + " round(coalesce(f3.foc,''),0)) ,char(100))foc3   from my_main m left join (select i.brhid, sum(i.op_qty-i.out_qty) qty,"
       		 + " i.prdid from my_prddin i where 1=1 "+sqltest2+" group by psrno having qty>0)  i on m.doc_no=i.prdId left join (select i.brhid,"
       		 + " sum(i.op_qty-i.out_qty) qty,min(exp_date) exp_date,i.prdid from my_prddin i where 1=1 and (i.op_qty-i.out_qty)>0 "+sqltest2+" group by psrno having qty>0)  e on "
       		 + " m.doc_no=e.prdId  left join my_desc de on(de.psrno=m.doc_no and i.brhid= de.brhid) left join  my_brand bd on m.brandid=bd.doc_no "
       		 + " left join  my_prodfocfixing f1 on f1.psrno=m.psrno and f1.sr_no=1 left join  my_prodfocfixing f2 on f2.psrno=m.psrno and f2.sr_no=2 "
       		 + " left join  my_prodfocfixing f3 on f3.psrno=m.psrno and f3.sr_no=3  left join my_dept d on d.doc_no=m.deptid "+sqltest3+" where 1=1 "+sqltest+" "
       		 + " order by d.department) b,(select @i:=0) as i";
     	    	
     	    	System.out.println("12345456789"+sqlStock);
                 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
               	 imgpath=imgpath.replace("\\", "\\\\");
               	param.put("stocksql", sqlStock);
		         param.put("imgpath", imgpath);
		         param.put("compname", productdetailsBean.getLblcompname());
		         param.put("compaddress", productdetailsBean.getLblcompaddress());
		         param.put("comptel", productdetailsBean.getLblcomptel());
		         param.put("compfax", productdetailsBean.getLblcompfax());
		         param.put("compbranch", productdetailsBean.getLblbranch());
		         param.put("location", productdetailsBean.getLbllocation());
		         param.put("printname", productdetailsBean.getLblprintname());
		         param.put("subprintname", productdetailsBean.getLblprintname1()); 
		         param.put("printby", session.getAttribute("USERNAME"));
		       
		        
		        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/procurment/productdetails/" + reportFileName + ".jrxml"));
         	 
         	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                           generateReportPDF(response, param, jasperReport, conn);
                             
          
                 } catch (Exception e) {
  
                     e.printStackTrace();
  
                 }
	            	 
	           finally{
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
