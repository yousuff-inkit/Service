package com.sales.Sales.deliverynote;
 
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.io.OutputStream;
import java.sql.SQLException;
import java.sql.Statement;
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
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 


public class ClsDeliveryNoteAction {

	ClsDeliveryNoteDAO DAO= new ClsDeliveryNoteDAO();
	ClsDeliveryNoteBean bean= new ClsDeliveryNoteBean();
	ClsCommon ClsCommon=new ClsCommon();
 
	private String date,hidcmbcurr;
	private String url;
	private String hiddate;
	private String txtrefno,refdetail,reftype,clienttrno;
	private String docno,hidcmbvatype;
	private String txtclient,address,mob;
	private int clientid;
	private String txtclientdet;
	private String txtsalesperson;
	private int salespersonid;
	private String cmbcurr;
	private String hidcmbcurrency;
	private String currate;
	private String cmbreftype;
	private String hidcmbreftype;
	private String rrefno;
	private String txtpaymentterms;
	private String txtdescription;
	private String txtproductamt;
	private String txtdiscount;
	private String txtnettotal;
	private String formdetailcode;
	private String mode;
	private String msg;
	private String deleted;
	private int gridlength;
	private int termsgridlength;
	private int servgridlen;
	private int masterdoc_no;
	private String refmasterdocno;
	private String prodsearchtype;
	private String descPercentage;
	private String orderValue;
	private String roundOf;
	private String nettotal;
	private String cmbprice;
	private String hidcmbprice;
	private String txtlocation,gridqry;
	private String lblarea,locationid,editdata;
	
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	public String getLblarea() {
		return lblarea;
	}
	public void setLblarea(String lblarea) {
		this.lblarea = lblarea;
	}

	private int	shipdatagridlenght,shipdocno;
	
	 
	private String  shipto,shipaddress,contactperson,shiptelephone,shipmob,shipemail,shipfax,cltel;
	
    public String getCltel() {
		return cltel;
	}
	public void setCltel(String cltel) {
		this.cltel = cltel;
	}
		
	

	public int getShipdatagridlenght() {
		return shipdatagridlenght;
	}
	public void setShipdatagridlenght(int shipdatagridlenght) {
		this.shipdatagridlenght = shipdatagridlenght;
	}
	public int getShipdocno() {
		return shipdocno;
	}
	public void setShipdocno(int shipdocno) {
		this.shipdocno = shipdocno;
	}
	public String getShipto() {
		return shipto;
	}
	public void setShipto(String shipto) {
		this.shipto = shipto;
	}
	public String getShipaddress() {
		return shipaddress;
	}
	public void setShipaddress(String shipaddress) {
		this.shipaddress = shipaddress;
	}
	public String getContactperson() {
		return contactperson;
	}
	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}
	public String getShiptelephone() {
		return shiptelephone;
	}
	public void setShiptelephone(String shiptelephone) {
		this.shiptelephone = shiptelephone;
	}
	public String getShipmob() {
		return shipmob;
	}
	public void setShipmob(String shipmob) {
		this.shipmob = shipmob;
	}
	public String getShipemail() {
		return shipemail;
	}
	public void setShipemail(String shipemail) {
		this.shipemail = shipemail;
	}
	public String getShipfax() {
		return shipfax;
	}
	public void setShipfax(String shipfax) {
		this.shipfax = shipfax;
	}
	public String getEditdata() {
		return editdata;
	}
	public void setEditdata(String editdata) {
		this.editdata = editdata;
	}
	public String getTxtlocation() {
		return txtlocation;
	}
	public void setTxtlocation(String txtlocation) {
		this.txtlocation = txtlocation;
	}
	public String getLocationid() {
		return locationid;
	}
	public void setLocationid(String locationid) {
		this.locationid = locationid;
	}
	public String getCmbprice() {
		return cmbprice;
	}
	public void setCmbprice(String cmbprice) {
		this.cmbprice = cmbprice;
	}
	public String getHidcmbprice() {
		return hidcmbprice;
	}
	public void setHidcmbprice(String hidcmbprice) {
		this.hidcmbprice = hidcmbprice;
	}
	public int getServgridlen() {
		return servgridlen;
	}
	public void setServgridlen(int servgridlen) {
		this.servgridlen = servgridlen;
	}
	public String getNettotal() {
		return nettotal;
	}
	public void setNettotal(String nettotal) {
		this.nettotal = nettotal;
	}
	public String getRoundOf() {
		return roundOf;
	}
	public void setRoundOf(String roundOf) {
		this.roundOf = roundOf;
	}
	public String getOrderValue() {
		return orderValue;
	}
	public void setOrderValue(String orderValue) {
		this.orderValue = orderValue;
	}
	public String getDescPercentage() {
		return descPercentage;
	}
	public void setDescPercentage(String descPercentage) {
		this.descPercentage = descPercentage;
	}
	public String getHidcmbcurrency() {
		return hidcmbcurrency;
	}
	public void setHidcmbcurrency(String hidcmbcurrency) {
		this.hidcmbcurrency = hidcmbcurrency;
	}
	public String getProdsearchtype() {
		return prodsearchtype;
	}
	public void setProdsearchtype(String prodsearchtype) {
		this.prodsearchtype = prodsearchtype;
	}

	public String getRefmasterdocno() {
		return refmasterdocno;
	}
	public void setRefmasterdocno(String refmasterdocno) {
		this.refmasterdocno = refmasterdocno;
	}
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}

	public String getDocno() {
		return docno;
	}
	public void setDocno(String docno) {
		this.docno = docno;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}
	public String getCmbcurr() {
		return cmbcurr;
	}
	public void setCmbcurr(String cmbcurr) {
		this.cmbcurr = cmbcurr;
	}
	public String getCurrate() {
		return currate;
	}
	public void setCurrate(String currate) {
		this.currate = currate;
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

	public String getTxtrefno() {
		return txtrefno;
	}
	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}
	public String getTxtsalesperson() {
		return txtsalesperson;
	}
	public void setTxtsalesperson(String txtsalesperson) {
		this.txtsalesperson = txtsalesperson;
	}
	public int getSalespersonid() {
		return salespersonid;
	}
	public void setSalespersonid(int salespersonid) {
		this.salespersonid = salespersonid;
	}
	public String getRrefno() {
		return rrefno;
	}
	public void setRrefno(String rrefno) {
		this.rrefno = rrefno;
	}
	public String getTxtpaymentterms() {
		return txtpaymentterms;
	}
	public void setTxtpaymentterms(String txtpaymentterms) {
		this.txtpaymentterms = txtpaymentterms;
	}
	public String getTxtdescription() {
		return txtdescription;
	}
	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}
	public String getTxtproductamt() {
		return txtproductamt;
	}
	public void setTxtproductamt(String txtproductamt) {
		this.txtproductamt = txtproductamt;
	}
	public String getTxtdiscount() {
		return txtdiscount;
	}
	public void setTxtdiscount(String txtdiscount) {
		this.txtdiscount = txtdiscount;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
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
	public int getGridlength() {
		return gridlength;
	}
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}
	public int getTermsgridlength() {
		return termsgridlength;
	}
	public void setTermsgridlength(int termsgridlength) {
		this.termsgridlength = termsgridlength;
	}
	
	private String lbldoc,lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblsubtotal,lbltotal,lblordervalue,lblordervaluewords;
	private int firstarray,secarray;
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblsalesPerson,lbllocation1,codeno1,refandno,fax1,dellocation;		
	
	
	public String getDellocation() {
		return dellocation;
	}
	public void setDellocation(String dellocation) {
		this.dellocation = dellocation;
	}
	public String getFax1() {
		return fax1;
	}
	public void setFax1(String fax1) {
		this.fax1 = fax1;
	}
	public String getRefandno() {
		return refandno;
	}
	public void setRefandno(String refandno) {
		this.refandno = refandno;
	}
	public String getCodeno1() {
		return codeno1;
	}
	public void setCodeno1(String codeno1) {
		this.codeno1 = codeno1;
	}
	
	public String getLbllocation1() {
		return lbllocation1;
	}
	public void setLbllocation1(String lbllocation1) {
		this.lbllocation1 = lbllocation1;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltype() {
		return lbltype;
	}
	public void setLbltype(String lbltype) {
		this.lbltype = lbltype;
	}
	public String getLblvendoeacc() {
		return lblvendoeacc;
	}
	public void setLblvendoeacc(String lblvendoeacc) {
		this.lblvendoeacc = lblvendoeacc;
	}
	public String getLblvendoeaccName() {
		return lblvendoeaccName;
	}
	public void setLblvendoeaccName(String lblvendoeaccName) {
		this.lblvendoeaccName = lblvendoeaccName;
	}
	public String getExpdeldate() {
		return expdeldate;
	}
	public void setExpdeldate(String expdeldate) {
		this.expdeldate = expdeldate;
	}
	public String getLbldelterms() {
		return lbldelterms;
	}
	public void setLbldelterms(String lbldelterms) {
		this.lbldelterms = lbldelterms;
	}
	public String getLblpaytems() {
		return lblpaytems;
	}
	public void setLblpaytems(String lblpaytems) {
		this.lblpaytems = lblpaytems;
	}
	public String getLbldesc1() {
		return lbldesc1;
	}
	public void setLbldesc1(String lbldesc1) {
		this.lbldesc1 = lbldesc1;
	}
	public String getLblrefno() {
		return lblrefno;
	}
	public void setLblrefno(String lblrefno) {
		this.lblrefno = lblrefno;
	}
	public String getLblsubtotal() {
		return lblsubtotal;
	}
	public void setLblsubtotal(String lblsubtotal) {
		this.lblsubtotal = lblsubtotal;
	}
	public String getLbltotal() {
		return lbltotal;
	}
	public void setLbltotal(String lbltotal) {
		this.lbltotal = lbltotal;
	}
	public String getLblordervalue() {
		return lblordervalue;
	}
	public void setLblordervalue(String lblordervalue) {
		this.lblordervalue = lblordervalue;
	}
	public String getLblordervaluewords() {
		return lblordervaluewords;
	}
	public void setLblordervaluewords(String lblordervaluewords) {
		this.lblordervaluewords = lblordervaluewords;
	}
	public String getLbldoc() {
		return lbldoc;
	}
	public void setLbldoc(String lbldoc) {
		this.lbldoc = lbldoc;
	}
	public int getFirstarray() {
		return firstarray;
	}
	public void setFirstarray(int firstarray) {
		this.firstarray = firstarray;
	}
	public int getSecarray() {
		return secarray;
	}
	public void setSecarray(int secarray) {
		this.secarray = secarray;
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
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblsalesPerson() {
		return lblsalesPerson;
	}
	public void setLblsalesPerson(String lblsalesPerson) {
		this.lblsalesPerson = lblsalesPerson;
	}
	public String getGridqry() {
		return gridqry;
	}
	public void setGridqry(String gridqry) {
		this.gridqry = gridqry;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMob() {
		return mob;
	}
	public void setMob(String mob) {
		this.mob = mob;
	}
	public String getRefdetail() {
		return refdetail;
	}
	public void setRefdetail(String refdetail) {
		this.refdetail = refdetail;
	}
	public String getReftype() {
		return reftype;
	}
	public void setReftype(String reftype) {
		this.reftype = reftype;
	}
	public String getClienttrno() {
		return clienttrno;
	}
	public void setClienttrno(String clienttrno) {
		this.clienttrno = clienttrno;
	}
	public String savedeliveryNoteAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		
		String mode=getMode();
		String returns="";
		int val=0;
		try{


	 
			if(mode.equalsIgnoreCase("A")){
				ArrayList<String> prodarray= new ArrayList<>();
				ArrayList<String> termsarray= new ArrayList<>();
				ArrayList<String> servarray= new ArrayList<>();

				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("prodg"+i)[0];		
					prodarray.add(temp);
				}

				for(int i=0;i<getTermsgridlength();i++){
					String temp=requestParams.get("termg"+i)[0];		
					termsarray.add(temp);
				}

				for(int i=0;i<getServgridlen();i++){
					String temp=requestParams.get("serv"+i)[0];		
					servarray.add(temp);
				}
				
				
				
		      ArrayList<String> shiparray= new ArrayList<>();
				for(int i=0;i<getShipdatagridlenght();i++){
					
				 
					String temp2=requestParams.get("shiptest"+i)[0];
				 
				
					shiparray.add(temp2);
					 
				}
				
				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				val=DAO.insert(date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getLocationid(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),
						getFormdetailcode(),prodarray,termsarray,servarray,session,request,getRefmasterdocno(),getDescPercentage(),getLocationid(),shiparray,getShipdocno(),getHidcmbvatype());
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					setHidcmbvatype(getHidcmbvatype());
					setHidcmbprice(getCmbprice());
					setHiddate(date.toString());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
				 
					setHidcmbreftype(getCmbreftype());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setRoundOf(getRoundOf());
					setOrderValue(getOrderValue());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setTxtlocation(getTxtlocation());
					
					
					 setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
				
					setMsg("Successfully Saved");
					returns="success";
				}
				else{
					setHidcmbprice(getCmbprice());
					setHiddate(date.toString());
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setHidcmbreftype(getCmbreftype());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setTxtlocation(getTxtlocation());
					setHidcmbvatype(getHidcmbvatype());
					
					 setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
				
					setMsg("Not Saved");
					returns="fail";
				}
			}
			if(mode.equalsIgnoreCase("view")){

				bean=DAO.getViewDetails(getMasterdoc_no(),session.getAttribute("BRANCHID").toString());
				setHidcmbprice(bean.getHidcmbprice());
				  setHiddate(bean.getHiddate());
				setMasterdoc_no(bean.getMasterdoc_no());
				setDocno(bean.getDocno());
				setTxtrefno(bean.getTxtrefno());
				setCmbcurr(bean.getHidcmbcurr());
				setHidcmbcurr(bean.getHidcmbcurr());
				setCurrate(bean.getCurrate());
				setSalespersonid(bean.getSalespersonid());
				setClientid(bean.getClientid());
				setClientid(getClientid());
				setRrefno(bean.getRrefno());
				 
				setHidcmbreftype(bean.getHidcmbreftype());
				setLocationid(bean.getLocationid());
				setTxtdescription(bean.getTxtdescription());
				setDescPercentage(bean.getDescPercentage());
				setTxtproductamt(bean.getTxtproductamt());
				setTxtdiscount(bean.getTxtdiscount());
				setTxtnettotal(bean.getTxtnettotal());
				setRoundOf(bean.getRoundOf());
				setProdsearchtype(bean.getProdsearchtype());
				setTxtsalesperson(bean.getTxtsalesperson());
				setRefmasterdocno(bean.getRefmasterdocno());
				setOrderValue(bean.getOrderValue());
				setNettotal(bean.getNettotal());
				setTxtlocation(bean.getTxtlocation());
				setHidcmbvatype(bean.getHidcmbvatype());
				
				
		         
		         
				 setShipdocno(bean.getShipdocno());
			     setShipto(bean.getShipto());
				 setShipaddress(bean.getShipaddress());
				 setContactperson(bean.getContactperson());
				 setShiptelephone(bean.getShiptelephone());
					
				 setShipmob(bean.getShipmob());
				 setShipemail(bean.getShipemail());
				 setShipfax(bean.getShipfax());
				

				returns="success";
			}


			if(mode.equalsIgnoreCase("E")){
				ArrayList<String> prodarray= new ArrayList<>();
				ArrayList<String> termsarray= new ArrayList<>();
				ArrayList<String> servarray= new ArrayList<>();

				for(int i=0;i<getGridlength();i++){
					String temp=requestParams.get("prodg"+i)[0];		
					prodarray.add(temp);
				}

				for(int i=0;i<getTermsgridlength();i++){
					String temp=requestParams.get("termg"+i)[0];		
					termsarray.add(temp);
				}

				for(int i=0;i<getServgridlen();i++){
					String temp=requestParams.get("serv"+i)[0];		
					servarray.add(temp);
				}
				
				
				
			      ArrayList<String> shiparray= new ArrayList<>();
					for(int i=0;i<getShipdatagridlenght();i++){
						
					 
						String temp2=requestParams.get("shiptest"+i)[0];
					 
					
						shiparray.add(temp2);
						 
					}
				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				val=DAO.update(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getLocationid(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),
						getFormdetailcode(),prodarray,termsarray,servarray,session,request,getRefmasterdocno(),getDescPercentage(),getEditdata(),shiparray,getShipdocno(),getHidcmbvatype());
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					setHidcmbvatype(getHidcmbvatype());
					setHidcmbprice(getCmbprice());
					setHiddate(date.toString());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setHidcmbreftype(getCmbreftype());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setTxtlocation(getTxtlocation());
					
					 setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
				
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					setHidcmbvatype(getHidcmbvatype());
					setHidcmbprice(getCmbprice());
					setHiddate(date.toString());
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setHidcmbreftype(getCmbreftype());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setTxtlocation(getTxtlocation());
					
					
					 setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             
		             setShipdocno(getShipdocno());
				
					setMsg("Not Updated");
					returns="fail";
				}
			}

			if(mode.equalsIgnoreCase("D")){
				ArrayList<String> prodarray= new ArrayList<>();
				ArrayList<String> termsarray= new ArrayList<>();
				ArrayList<String> servarray= new ArrayList<>();
 
				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				val=DAO.delete(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getLocationid(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,termsarray,servarray,session,request,getRefmasterdocno(),getDescPercentage(),getHidcmbvatype());
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					setHidcmbvatype(getHidcmbvatype());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getHidcmbreftype());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setMsg("Deleted Successfully");
					returns="success";
				}
				else{
					setHidcmbvatype(getHidcmbvatype());
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setCmbreftype(getCmbreftype());
					setHidcmbreftype(getHidcmbreftype());
					setLocationid(getLocationid());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setMsg("Not Deleted");
					returns="fail";
				}
			}


		}
		catch(Exception e){
			e.printStackTrace();
		}


		return returns;
	}

	
	public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 String xlstat=request.getParameter("xlstat")==null?"0":request.getParameter("xlstat").toString();
		 
		// System.out.println("doc========="+doc);
		
		 bean=DAO.getPrint(doc,request);
	  
		 
		
		  //cl details
		 
		    setLblprintname("Delivery Note");
             setTxtrefno(bean.getTxtrefno());
		    setLblarea(bean.getLblarea());
		    setGridqry(bean.getGridqry());
		    setLbldoc(bean.getLbldoc());
		    setLbldate(bean.getLbldate());
		     setLblrefno(bean.getLblrefno());
		     setLbldesc1(bean.getLbldesc1());
		     setAddress(bean.getAddress());
		     setMob(bean.getMob());
		     setCltel(bean.getCltel());
		    
	 	      
  	     setLblpaytems(bean.getLblpaytems());
  	     setLbldelterms(bean.getLbldelterms());
  	     setLbltype(bean.getLbltype());
  	     setLblvendoeacc(bean.getLblvendoeacc());  
  	     setLblvendoeaccName(bean.getLblvendoeaccName());
		     setExpdeldate(bean.getExpdeldate());
	 
					
  	           setLbltotal(bean.getLbltotal());
	    	       setLblsubtotal(bean.getLblsubtotal());
				   setLblbranch(bean.getLblbranch());
				   setLblcompname(bean.getLblcompname());
				  
				   setLblcompaddress(bean.getLblcompaddress());
				   setLblcomptel(bean.getLblcomptel());
				   setLblcompfax(bean.getLblcompfax());
				   setLbllocation(bean.getLbllocation());
				  
				   setLblsalesPerson(bean.getLblsalesPerson());
				   
				   
				   setLbllocation1(bean.getLbllocation1());
				   setFirstarray(bean.getFirstarray());
				   
				   setSecarray(bean.getSecarray());
				     
		    	   setLblordervalue(bean.getLblordervalue());
		    	   setLblordervaluewords(bean.getLblordervaluewords());
		    	   setRefdetail(bean.getRefdetail());
			       setReftype(bean.getReftype());
			       setClienttrno(bean.getClienttrno());
		    	   setUrl(ClsCommon.getPrintPath("DEL"));
		    	   if(ClsCommon.getPrintPath("DEL").contains(".jrxml")==true){
		    			HttpServletResponse response = ServletActionContext.getResponse();
		    		    
		    			//HashMap<String,String> param = new HashMap<String,String>();
		    			param = new HashMap();
		    			Connection conn = null;
		    			String reportFileName = "DeliveryNote";
		    			ClsConnection conobj=new ClsConnection();
		    			conn = conobj.getMyConnection();
		    			try {      
		    				conn = conobj.getMyConnection();
		    				Statement stmt = conn.createStatement ();  
		    				
		    				String prepby="";
		    				String preparedby="select u.user_name from my_user u left join my_delm m on u.doc_no=m.userId where m.doc_no="+docno;
		    				ResultSet rsPreBy = stmt.executeQuery(preparedby);
		    				//System.out.println("prepared by===="+preparedby);
		    				while (rsPreBy.next()) {
		    					prepby=rsPreBy.getString("user_name");
		    					
		    				}
		    				param.put("preparedby",prepby);
		    				 param.put("docno", getDocno());
		    				 param.put("printname", getLblprintname());
		    				 param.put("tinno", bean.getLbltrno()); 
		    				 param.put("trnno", bean.getClienttrno());
		    				 param.put("invqry", bean.getGridqry());
		    				 //param.put("preparedby", "");
		    				 param.put("cusname", bean.getLblvendoeaccName());    
		    				 param.put("trnno", bean.getClienttrno());
		    				 param.put("invno", bean.getLbldoc());
		    				 param.put("date", bean.getLbldate());
		    				 param.put("salesman", bean.getLblsalesPerson());
		    				 param.put("description", bean.getLbldesc1());
		    				 param.put("claddress", bean.getAddress());
		    				 //System.out.println("bean.setShipaddress=="+bean.getShipaddress());
                             param.put("Cuscode",bean.getCodeno1());
		    				 param.put("Fax1",bean.getFax1());
		    				 param.put("refandno",bean.getRefandno());
		    				 param.put("dellocation",bean.getDellocation());
		    				 param.put("clmob", bean.getMob());
		    				 param.put("cltel", bean.getCltel());
		    				 param.put("refno",getLblrefno());
		    				 param.put("refno1", getTxtrefno());
		    				// System.out.println("bean.getClienttrno()--"+bean.getClienttrno()+"-Lblrefno-"+bean.getLbltrno());
		    				 param.put("compname",lblcompname);
		    				 param.put("area",lblarea);
		    				 
		    				 //System.out.println("Area===="+lblarea);
		    				 
		    				 if(getReftype().equalsIgnoreCase("DEL")){
		    					 param.put("refdetname", "Ref Detail :");
		    					 param.put("refdetail", bean.getRefdetail());
		    				 }
                              String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
					        	imgpath=imgpath.replace("\\", "\\\\");    
					          param.put("imghedderpath", imgpath);
					          String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
					        	imgpath2=imgpath2.replace("\\", "\\\\");    
					          param.put("imgheader", imgpath2);
					          String imgpath3=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
					        	imgpath3=imgpath3.replace("\\", "\\\\");    
					          param.put("imgfooter", imgpath3);
		    				  param.put("location", bean.getLbllocation1());
		    				 param.put("locationaddress", bean.getLbllocationaddress());
		    				 ClsCommon com=new ClsCommon();
		    				 //System.out.println("In INVOICE PRINT JRXML"); 
                             JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/sales and marketing/Sales/deliverynote/"+ClsCommon.getPrintPath("DEL")));
		    				 JasperReport jasperReport = JasperCompileManager.compileReport(design);

	         	              if(xlstat.equalsIgnoreCase("1"))
	         	     	   	 { 
	         	     	    //System.out.println("Creating JasperPrint Object For Excel");
	         	     	    JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,param,conn); 
	         	     	    byte bytes[] = new byte[20000]; 
	         	     	    //String result = JasperRunManager.runReportToHtmlFile("./usertemplates/test.jasper" , parameters, conn); 
	         	     		
	         	     		JRXlsExporter exporter = new JRXlsExporter(); 
	         	     	    ByteArrayOutputStream xlsReport = new ByteArrayOutputStream(); 
	         	     	    
	         	     	    
	         	     	    exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
	         	     	    exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,Boolean.TRUE);
	         	     	    exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE); 
	         	     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
	         	     	    exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS,Boolean.TRUE);
	         	     	    exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN,Boolean.TRUE);
	         	     	    exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS,Boolean.TRUE);
	         	     	    exporter.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, xlsReport); 
	         	     	    exporter.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET,30000);
	         	     	    exporter.setParameter(JRXlsExporterParameter.IS_IMAGE_BORDER_FIX_ENABLED, Boolean.TRUE);
	         	     	    exporter.setParameter(JRXlsExporterParameter.IS_IGNORE_GRAPHICS, Boolean.FALSE);
	         	     	    exporter.exportReport(); 
	         	     	   
	         	     	   
	         	     	    String fileName = "InvoiceReport.xls";
	         	     	    response.setHeader("Content-Disposition", "inline; filename="+ fileName);
	         	     	    response.setContentType("application/vnd.ms-excel"); 
	         	     	    //System.out.println("After JasperPrint = 1"); 
	         	     	    response.setContentLength(xlsReport.size()); 
	         	     	    //System.out.println("After JasperPrint = 2"); 
	         	     	    xlsReport.close(); 
	         	     	    //System.out.println("After JasperPrint = 3"); 
	                         OutputStream outputStream = response.getOutputStream(); 
	         	     	    //System.out.println("After JasperPrint = 4"); 
	         	     	    xlsReport.writeTo(outputStream); 
	         	     	    outputStream.flush(); 
	         	     	   // conn.close();
	         	     	    //outputStream.close(); 
	         	     	    //System.out.println("export end");
	         	     	   	 }
	         	               
	         	               else
	         	               {
	                           generateReportPDF(response, param, jasperReport, conn);
	                           conn.close();
	         	               } 
		    				 //generateReportPDF(response, param, jasperReport, conn);
		    				 //conn.close();
		    			 }
		    			catch(Exception e){
		    				 conn.close();
		    				 e.printStackTrace();
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
				public String getHidcmbvatype() {
					return hidcmbvatype;
				}
				public void setHidcmbvatype(String hidcmbvatype) {
					this.hidcmbvatype = hidcmbvatype;
				}
				public String getHidcmbcurr() {
					return hidcmbcurr;
				}
				public void setHidcmbcurr(String hidcmbcurr) {
					this.hidcmbcurr = hidcmbcurr;
				}
				
				
	
	
	
	
	
}
