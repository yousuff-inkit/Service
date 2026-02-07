package com.cargo.costingforinvoicing;
 import java.io.IOException;
import java.sql.Connection;
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

import com.cargo.estimation.ClsEstimationBean;
import com.common.*;
import com.connection.ClsConnection;

public class ClsCostingForInvoicingAction {

	ClsCommon ClsCommon=new ClsCommon();
	ClsCostingForInvoicingDAO Save =new  ClsCostingForInvoicingDAO();
	
	private int mastertr_no,masterdoc_no,docno,refno,savestatus;
	

	private String estmDate,hidestmDate,refnos,txtRemarks,msg,deleted,mode,formdetailcode;
	
	
	private String mawb,mbl, hawb ,hbl ,shipper, consignee, carrier ,flightno, Voage ,etd ,eta, ttime, boe ,contno, truckno,hidttime;
	
 
	public String getHidttime() {
		return hidttime;
	}

	public void setHidttime(String hidttime) {
		this.hidttime = hidttime;
	}

	public String getMawb() {
		return mawb;
	}

	public void setMawb(String mawb) { 
		this.mawb = mawb;
	}

	public String getMbl() {
		return mbl;
	}

	public void setMbl(String mbl) {
		this.mbl = mbl;
	}

	public String getHawb() {
		return hawb;
	}

	public void setHawb(String hawb) {
		this.hawb = hawb;
	}

	public String getHbl() {
		return hbl;
	}

	public void setHbl(String hbl) {
		this.hbl = hbl;
	}

	public String getShipper() {
		return shipper;
	}

	public void setShipper(String shipper) {
		this.shipper = shipper;
	}

	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	public String getCarrier() {
		return carrier;
	}

	public void setCarrier(String carrier) {
		this.carrier = carrier;
	}

	public String getFlightno() {
		return flightno;
	}

	public void setFlightno(String flightno) {
		this.flightno = flightno;
	}

	public String getVoage() {
		return Voage;
	}

	public void setVoage(String voage) {
		Voage = voage;
	}

	public String getEtd() {
		return etd;
	}

	public void setEtd(String etd) {
		this.etd = etd;
	}

	public String getEta() {
		return eta;
	}

	public void setEta(String eta) {
		this.eta = eta;
	}

	public String getTtime() {
		return ttime;
	}

	public void setTtime(String ttime) {
		this.ttime = ttime;
	}

	public String getBoe() {
		return boe;
	}

	public void setBoe(String boe) {
		this.boe = boe;
	}

	public String getContno() {
		return contno;
	}

	public void setContno(String contno) {
		this.contno = contno;
	}

	public String getTruckno() {
		return truckno;
	}

	public void setTruckno(String truckno) {
		this.truckno = truckno;
	}

	public int getSavestatus() {
		return savestatus;
	}

	public void setSavestatus(int savestatus) {
		this.savestatus = savestatus;
	}

	public int getMastertr_no() {
		return mastertr_no;
	}

	public void setMastertr_no(int mastertr_no) {
		this.mastertr_no = mastertr_no;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getRefno() {
		return refno;
	}

	public void setRefno(int refno) {
		this.refno = refno;
	}

	public String getEstmDate() {
		return estmDate;
	}

	public void setEstmDate(String estmDate) {
		this.estmDate = estmDate;
	}

	public String getHidestmDate() {
		return hidestmDate;
	}

	public void setHidestmDate(String hidestmDate) {
		this.hidestmDate = hidestmDate;
	}

	public String getRefnos() {
		return refnos;
	}

	public void setRefnos(String refnos) {
		this.refnos = refnos;
	}

	public String getTxtRemarks() {
		return txtRemarks;
	}

	public void setTxtRemarks(String txtRemarks) {
		this.txtRemarks = txtRemarks;
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

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}
	
	
	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
private int gridlenght;



	public int getGridlenght() {
	return gridlenght;
}

public void setGridlenght(int gridlenght) {
	this.gridlenght = gridlenght;
}

	public String saveForm() throws SQLException
	{
		 
		
	 
		
		
	 java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getEstmDate());
	 HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
	System.out.println("=======mode==ssssssssssssssssssssss=="+getMode());
		
		if(!(getMode().equalsIgnoreCase("view")))
		{
			
			ArrayList<String> descarray= new ArrayList<>();
			
			if(!(getMode().equalsIgnoreCase("D")))
			{
			
			
			for(int i=0;i<getGridlenght();i++){
				String temp2=requestParams.get("desctest"+i)[0];
				descarray.add(temp2);
			}
			
			}
			
			
			/**/
			
			
				int value=Save.saveData(getMasterdoc_no(),getMastertr_no(),getRefno(),masterdate,getMode(),
						 getFormdetailcode(),getTxtRemarks(),getRefnos(),session,request,descarray,getDocno(),getMawb(), getMbl(), getHawb(),getHbl(),getShipper(),getConsignee(),
				            getCarrier(),getFlightno(),getVoage(),getEta(),getEtd(),getTtime(),getBoe(),getContno(),getTruckno());
					 if(getMode().equalsIgnoreCase("A"))
					 {
							 if(value>0)
							 {
								 int vdocno=(int) request.getAttribute("vocno");
								 setMasterdoc_no(value);
								 setDocno(vdocno);
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 
								 setMsg("Successfully Saved");
								 return "success"; 
							 }
							 else
							 {
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 
								 setMsg("Not Saved");
								 return "fail";
							 }
						
							
					 }
					 
					 
					 
					 if(getMode().equalsIgnoreCase("E"))
					 {    
							 if(value>0)
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 
								 setMsg("Updated Successfully");
								 return "success"; 
							 }
							 else
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 setMsg("Not Updated");
								 return "fail";
							 }
							
							
					 }
					 
					 
					 
					 
					 if(getMode().equalsIgnoreCase("S"))
					 {    
							 if(value>0)
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								/* setMsg("Updated Successfully");*/
								 setMsg("");
								 
								 setSavestatus(1);
								 return "success"; 
							 }
							 else
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setHidestmDate(masterdate.toString());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								/* setMsg("Not Updated");*/
								 setMsg("");
								 setSavestatus(2);
								 return "fail";
							 }
							
							
					 }
					 
					 
					 
					 
					 if(getMode().equalsIgnoreCase("D"))
					 {
							 if(value>0)
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 
								 setDeleted("DELETED");
								 setMsg("Successfully Deleted");
								 return "success";
							 }
							 else
							 {
								 setMasterdoc_no(getMasterdoc_no());
								 setDocno(getDocno());
								 setRefno(getRefno());
								 setRefnos(getRefnos());
								 setTxtRemarks(getTxtRemarks());
								 setMastertr_no(getMastertr_no());
								 
								 setMawb(getMawb());
								 setMbl(getMbl());
								 setHawb(getHawb());
								 setHbl(getHbl());
								 setShipper(getShipper());
								 setConsignee(getConsignee());
						           setCarrier(getCarrier());
						            setFlightno(getFlightno());
						           setVoage(getVoage());
						            setEta(getEta());
						            setEtd(getEtd());
						            setHidttime(getTtime());
						            setBoe(getBoe());
						            setContno(getContno());
						           setTruckno(getTruckno());								 
								 
								 setMsg("Not Deleted");
							     setDeleted("");
								 return "fail";
							 }
						
							
					    }
					 
						 }
					 
					 
					 
					 
				 
		else if((getMode().equalsIgnoreCase("view")))
		{
			
			ClsCostingForInvoicingBean bean=new ClsCostingForInvoicingBean();
			
			bean=Save.getViewDetails(getDocno(),session);
			setDocno(getDocno());
			 setHidestmDate(bean.getHidestmDate());
			 setRefno(bean.getRefno());
			 setMasterdoc_no(bean.getMasterdoc_no());
			 setRefnos(bean.getRefnos());
			 setMastertr_no(bean.getMastertr_no());
			 setTxtRemarks(bean.getTxtRemarks());
			 
			 
			 
			 setMawb(bean.getMawb());
			 setMbl(bean.getMbl());
			 setHawb(bean.getHawb());
			 setHbl(bean.getHbl());
			 setShipper(bean.getShipper());
			 setConsignee(bean.getConsignee());
	           setCarrier(bean.getCarrier());
	            setFlightno(bean.getFlightno());
	           setVoage(bean.getVoage());
	            setEta(bean.getEta());
	            setEtd(bean.getEtd());
	            setHidttime(bean.getTtime());
	            setBoe(bean.getBoe());
	            setContno(bean.getContno());
	           setTruckno(bean.getTruckno());								 
			 
			 
			
			 return "success";
			
		}
		
		 
		
				return "fail";
			}
	private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public String printAction() throws ParseException, SQLException{
		 System.out.println("==========inside print action");
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  int doc=Integer.parseInt(request.getParameter("docno"));
		  ClsCostingForInvoicingBean bean=new ClsCostingForInvoicingBean();
		  String dtype=request.getParameter("dtype");
		  
		  bean=Save.getPrint(docno,request,session);
		 /* setUrl(ClsCommon.getPrintPath(dtype));
		  setLbldate(bean.getLbldate());
		 setLblcompname(bean.getLblcompname());
		 setLblcompaddress(bean.getLblcompaddress());
		 setLblcomptel(bean.getLblcomptel());
		 setLblcompfax(bean.getLblcompfax());
		setLblprintname("ESTIMATION");
		setLblbranchtrno(bean.getLblbranchtrno());
		setLbllocation(bean.getLbllocation());
		
		setLblclientname(bean.getLblclientname());
		setLbladdress(bean.getLbladdress());
		setLblmobile(bean.getLblmobile());
		setLbldocno(bean.getLbldocno());
		setLbldate(bean.getLbldate());
		setLblenquiryno(bean.getLblenquiryno());*/
		  System.out.println("commDAO.getPrintPath(dtype)=="+ClsCommon.getPrintPath(dtype));
		   if(ClsCommon.getPrintPath(dtype).contains("jrxml")==true)
	   	   
		   {
			  System.out.println("inside jrxml");
			    HttpServletResponse response = ServletActionContext.getResponse();
			    	 
				 param = new HashMap();
				 Connection conn = null;
				 
				 //String reportFileName = "NIPurchaseInvoice";
				 							
				 ClsConnection conobj=new ClsConnection();
				 conn = conobj.getMyConnection();
			     
				 try {      
					  /* param.put("termsquery",pintbean.getTermQry());
			                
			         param.put("descQry",pintbean.getDescQry());*/
			         
			       //  System.out.println("product++++++++++"+productQuery);
			         String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
			        	imgpath=imgpath.replace("\\", "\\\\");    
			          param.put("imghedderpath", imgpath);
			          
			          
			         /* String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
			        	imgpath2=imgpath2.replace("\\", "\\\\");    
			          param.put("imgfooterpath", imgpath2);*/
			          
			          
			      
			          param.put("cusname", bean.getLblclientname());
			          //param.put("attn", bean.getAttn());
			          param.put("claddress", bean.getLbladdress());
			          param.put("clmob", bean.getLblmobile());
			          //param.put("description", bean.getEmail());
			          param.put("invno",doc);
			          param.put("date", bean.getLbldate());
			         // param.put("compbranch",bean.getLblbranch());
				      param.put("compname",bean.getLblcompname());				  
				      param.put("compaddress",bean.getLblcompaddress());				 
				      param.put("comptel",bean.getLblcomptel());				  
				      param.put("compfax",bean.getLblcompfax());
				      param.put("compemail",bean.getLblcompemail());
				      param.put("preparedby",bean.getLblpreparedby());
				      param.put("printby",bean.getPrintby());
				      //param.put("complocation",bean.getLbllocation());
				      
				      //param.put("trnno", bean.getTinno());
					  param.put("tinno", bean.getLblbranchtrno());
					  param.put("qry1", bean.getQry1());
					  param.put("qry2", bean.getQry2());
					  param.put("qry3", bean.getQry3());
			        /*  param.put("refno", pintbean.getRefno());
			          param.put("desc", pintbean.getLbldsc());
			          param.put("payterm", pintbean.getLblpatms());
			          param.put("delterm", pintbean.getLbldddtm());
			          param.put("netamount", pintbean.getLblnettotal());
			          param.put("amountwords", pintbean.getWordnetamount());
				      param.put("taxnetamount", pintbean.getLblnettotal());
			          param.put("taxamountwords", pintbean.getWordnetamount());*/
			       
				  
				//alabbar
				  String imgpath1=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			      	imgpath1=imgpath1.replace("\\", "\\\\");
			       // param.put("imghedderpath", imgpath1);

				 /* param.put("taxqry",pintbean.getAlabbarqry());
			      
			      param.put("address",pintbean.getVenaddress());
			      param.put("phoneno",pintbean.getVenphon());
			      param.put("trnno",pintbean.getVentrno());
			      param.put("landno",pintbean.getVenland());			      
			      param.put("refno",pintbean.getLblrefno());
			      param.put("deldate",pintbean.getLbldeldate());
			      param.put("delterms",pintbean.getLbldddtm());
			      param.put("payterms",pintbean.getLblpatms());
			      param.put("description",pintbean.getLbldsc());
			      param.put("docno",pintbean.getDocvals());
			      param.put("date",pintbean.getLbldate());
			      param.put("nettotal",pintbean.getLblnettotal());
			      param.put("amtinwords",pintbean.getWordnetamount());
			      param.put("preparedby",pintbean.getLblpreparedby());
			      param.put("pdate",pintbean.getLblpreparedon());
			      param.put("ptime",pintbean.getLblpreparedat());
			      param.put("verifiedby",pintbean.getLblverifiedby());
			      param.put("vdate",pintbean.getLblverifiedon());
			      param.put("vtime",pintbean.getLblverifiedat());
			      param.put("approvedby",pintbean.getLblapprovedby());
			      param.put("adate",pintbean.getLblapprovedon());
			      param.put("atime",pintbean.getLblapprovedon());
			      param.put("total", pintbean.getLbltotal());
			      param.put("discount", pintbean.getLbldiscount());
			      param.put("nettax", pintbean.getLblnettax());
			      param.put("invno", pintbean.getLblinvno());
			      param.put("type", pintbean.getLbltype());
			      param.put("invdate", pintbean.getLblinvdate());*/
			      
			     
				      
			       // System.out.println("desc"+bean.getLbldesc1()+"pay"+bean.getLblpaytems()+"paytrim"+bean.getLblpaytems()+"del"+ bean.getLbldelterms());
			     //   System.out.println("pathhhhhhhhhhhhhhhhhhh"+commDAO.getPrintPath(dtype));  
	             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/cargo/costingforinvoicing/"+ClsCommon.getPrintPath(dtype)));
	         	 
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
