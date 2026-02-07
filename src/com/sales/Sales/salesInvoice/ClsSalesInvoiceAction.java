package com.sales.Sales.salesInvoice;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
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

import org.apache.struts2.ServletActionContext;

import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

import com.common.ClsCommon;
import com.common.ClsAmountToWords;
import com.connection.ClsConnection;
import com.google.common.collect.Sets.SetView;


public class ClsSalesInvoiceAction {

	ClsSalesInvoiceDAO DAO= new ClsSalesInvoiceDAO();
	ClsSalesInvoiceBean bean= new ClsSalesInvoiceBean();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null; 
	private String date,clientname,lbldiscount,lblnettotal,lbltotalamt,lbltotaltaxamt,lblnetamountwds,currency,tr_no;  
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getLblnetamountwds() {
		return lblnetamountwds;
	}
	public void setLblnetamountwds(String lblnetamountwds) {
		this.lblnetamountwds = lblnetamountwds;
	}
	private String hiddate;
	private String txtrefno,txtclientmob,refdetail,reftype,clntacno,hidcmbcurr;
	private String docno;
	private String txtclient,cmbvatype,hidcmbvatype;
	private int clientid;
	private String txtclientdet,lbltrno,lblclienttrno;
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
	private String formdetailcode,lbltotaltaxamount,lbltotaltax;
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
	private String orderValue,orderValuefinal;
	private String roundOf;
	private String nettotal;
	private String cmbprice;
	private String hidcmbprice;
	private String cmbmodeofpay;
	private String payDueDate;
	private String hidpayDueDate;
	private String txtlocation,editdata,txtdelterms,lblduedate;
	private int    locationid; 
	private int	shipdatagridlenght,shipdocno;
	private double st,taxontax1,taxontax2,taxontax3,taxtotal;
	private String billto,btrno;
	private String salesman;
	private int hidsalesman;
	private int cmbbilltype,hidcmbbilltype;
	private String url,trnno,lbltrnno,lblvattotal,lblcmptrn_no;
	private String lblclientmail,lblrrefno,lblrrdate,lblclienttel,lblfinaldate;
	public String getLbltotalamt() {
		return lbltotalamt;
	}
	public void setLbltotalamt(String lbltotalamt) {
		this.lbltotalamt = lbltotalamt;
	}
	public String getLbltotaltaxamt() {
		return lbltotaltaxamt;
	}
	public void setLbltotaltaxamt(String lbltotaltaxamt) {
		this.lbltotaltaxamt = lbltotaltaxamt;
	}
	public String getLbldiscount() {
		return lbldiscount;
	}
	public void setLbldiscount(String lbldiscount) {
		this.lbldiscount = lbldiscount;
	}
	public String getLblnettotal() {
		return lblnettotal;
	}
	public void setLblnettotal(String lblnettotal) {
		this.lblnettotal = lblnettotal;
	}
	public String getClientname() {
		return clientname;
	}
	public void setClientname(String clientname) {
		this.clientname = clientname;
	}
	public String getLblfinaldate() {
		return lblfinaldate;
	}
	public void setLblfinaldate(String lblfinaldate) {
		this.lblfinaldate = lblfinaldate;
	}
	public String getBillto() {
		return billto;
	}
	public void setBillto(String billto) { 
		this.billto = billto;
	}
	public String getBtrno() {
		return btrno;
	}
	public void setBtrno(String btrno) {
		this.btrno = btrno;
	}
	public String getLblclienttel() {
		return lblclienttel;
	}
	public void setLblclienttel(String lblclienttel) {
		this.lblclienttel = lblclienttel;
	}
	public String getLblrrdate() {
		return lblrrdate;
	}
	public void setLblrrdate(String lblrrdate) {
		this.lblrrdate = lblrrdate;
	}
	public String getLblrrefno() {
		return lblrrefno;
	}
	public void setLblrrefno(String lblrrefno) {
		this.lblrrefno = lblrrefno;
	}
		
	public String getLblclientmail() {
		return lblclientmail;
	}
	public void setLblclientmail(String lblclientmail) {
		this.lblclientmail = lblclientmail;
	}
	public String getLblcmptrn_no() {
		return lblcmptrn_no;
	}
	public void setLblcmptrn_no(String lblcmptrn_no) {
		this.lblcmptrn_no = lblcmptrn_no;
	}
	public String getLbltrnno() {
		return lbltrnno;
	}
	public void setLbltrnno(String lbltrnno) {
		this.lbltrnno = lbltrnno;
	}
	public String getLblvattotal() {
		return lblvattotal;
	}
	public void setLblvattotal(String lblvattotal) {
		this.lblvattotal = lblvattotal;
	}
	public String getLbltrno() {
		return lbltrno;
	}
	public void setLbltrno(String lbltrno) {
		this.lbltrno = lbltrno;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	
	public String getLbltotaltaxamount() {
		return lbltotaltaxamount;
	}
	public void setLbltotaltaxamount(String lbltotaltaxamount) {
		this.lbltotaltaxamount = lbltotaltaxamount;
	}
	public String getLbltotaltax() {
		return lbltotaltax;
	}
	public void setLbltotaltax(String lbltotaltax) {
		this.lbltotaltax = lbltotaltax;
	}
	public int getCmbbilltype() {
		return cmbbilltype;
	}
	public void setCmbbilltype(int cmbbilltype) {
		this.cmbbilltype = cmbbilltype;
	}
	public int getHidcmbbilltype() {
		return hidcmbbilltype;
	}
	public void setHidcmbbilltype(int hidcmbbilltype) {
		this.hidcmbbilltype = hidcmbbilltype;
	}
	public double getSt() {
		return st;
	}
	public void setSt(double st) {
		this.st = st;
	}
	public double getTaxontax1() {
		return taxontax1;
	}
	public void setTaxontax1(double taxontax1) {
		this.taxontax1 = taxontax1;
	}
	public double getTaxontax2() {
		return taxontax2;
	}
	public void setTaxontax2(double taxontax2) {
		this.taxontax2 = taxontax2;
	}
	public double getTaxontax3() {
		return taxontax3;
	}
	public void setTaxontax3(double taxontax3) {
		this.taxontax3 = taxontax3;
	}
	public double getTaxtotal() {
		return taxtotal;
	}
	public void setTaxtotal(double taxtotal) {
		this.taxtotal = taxtotal;
	}

	public String getSalesman() {
		return salesman;
	}

	public void setSalesman(String salesman) {
		this.salesman = salesman;
	}

	public int getHidsalesman() {
		return hidsalesman;
	}

	public void setHidsalesman(int hidsalesman) {
		this.hidsalesman = hidsalesman;
	}

	private String  shipto,shipaddress,contactperson,shiptelephone,shipmob,shipemail,shipfax;

	public String getLblduedate() {
		return lblduedate;
	}
	public void setLblduedate(String lblduedate) {
		this.lblduedate = lblduedate;
	}
	public String getTxtdelterms() {
		return txtdelterms;
	}
	public void setTxtdelterms(String txtdelterms) {
		this.txtdelterms = txtdelterms;
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
	public int getLocationid() {
		return locationid;
	}
	public void setLocationid(int locationid) {
		this.locationid = locationid;
	}
	public String getCmbmodeofpay() {
		return cmbmodeofpay;
	}
	public void setCmbmodeofpay(String cmbmodeofpay) {
		this.cmbmodeofpay = cmbmodeofpay;
	}
	public String getPayDueDate() {
		return payDueDate;
	}
	public void setPayDueDate(String payDueDate) {
		this.payDueDate = payDueDate;
	}
	public String getHidpayDueDate() {
		return hidpayDueDate;
	}
	public void setHidpayDueDate(String hidpayDueDate) {
		this.hidpayDueDate = hidpayDueDate;
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


	public String getTxtclientmob() {
		return txtclientmob;
	}
	public void setTxtclientmob(String txtclientmob) {
		this.txtclientmob = txtclientmob;
	}
    
	public String getHidcmbvatype() {
		return hidcmbvatype;
	}
	public void setHidcmbvatype(String hidcmbvatype) {
		this.hidcmbvatype = hidcmbvatype;
	}

	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems,lblround, lbldesc1,lblrefno,lblsubtotal,lbltotal,lblroundof,lblordervalue,lblordervaluewords;
	private int lbldoc,firstarray,secarray,thirdarray;
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblsalesPerson,lbllocation1,lblprintnameakamal;	
	
	
	 
	
	public String getLblprintnameakamal() {
		return lblprintnameakamal;
	}
	public void setLblprintnameakamal(String lblprintnameakamal) {
		this.lblprintnameakamal = lblprintnameakamal;
	}
	public String getLblround() {
		return lblround;
	}
	public void setLblround(String lblround) {
		this.lblround = lblround;
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
	
	
	public String getLblclienttrno() {
		return lblclienttrno;
	}
	public void setLblclienttrno(String lblclienttrno) {
		this.lblclienttrno = lblclienttrno;
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
	
	public String getLblroundof() {
		return lblroundof;
	}
	public void setLblroundof(String lblroundof) {
		this.lblroundof = lblroundof;
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
	public int getLbldoc() {
		return lbldoc;
	}
	public void setLbldoc(int lbldoc) {
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
	public String getLbllocation1() {
		return lbllocation1;
	}
	public void setLbllocation1(String lbllocation1) {
		this.lbllocation1 = lbllocation1;
	}
	
	
	//duca
	
	
	private String lblclientaddress,lblclientcity,lblclientcountry,lblclientmob,lblinvno,lblcompemail,lblamountinwordsakmal,invnosamba;
	
 
	
	
	
	public String getLblamountinwordsakmal() {
		return lblamountinwordsakmal;
	}
	public void setLblamountinwordsakmal(String lblamountinwordsakmal) {
		this.lblamountinwordsakmal = lblamountinwordsakmal;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblclientcity() {
		return lblclientcity;
	}
	public void setLblclientcity(String lblclientcity) {
		this.lblclientcity = lblclientcity;
	}
	public String getLblclientcountry() {
		return lblclientcountry;
	}
	public void setLblclientcountry(String lblclientcountry) {
		this.lblclientcountry = lblclientcountry;
	}
	public String getLblclientmob() {
		return lblclientmob;
	}
	public void setLblclientmob(String lblclientmob) {
		this.lblclientmob = lblclientmob;
	}
	public String getLblinvno() {
		return lblinvno;
	}
	public void setLblinvno(String lblinvno) {
		this.lblinvno = lblinvno;
	}
        public String getInvnosamba() {
		return invnosamba;
	}
	public void setInvnosamba(String invnosamba) {
		this.invnosamba = invnosamba;
	}
	public String getLblcompemail() {
		return lblcompemail;
	}
	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}
	
	private String  lblshipto,lblshipaddress,lblcontactperson,lblshiptelephone,lblshipmob,lblshipemail,lblshipfax, lblakmaldates, lbllpono ,lbldono, lblamountinwords ;
	
	
	
	
	public String getLblakmaldates() {
		return lblakmaldates;
	}
	public void setLblakmaldates(String lblakmaldates) {  
		this.lblakmaldates = lblakmaldates;
	}
	public String getLbllpono() {
		return lbllpono;
	}
	public void setLbllpono(String lbllpono) {
		this.lbllpono = lbllpono;
	}
	public String getLbldono() {
		return lbldono;
	}
	public void setLbldono(String lbldono) {
		this.lbldono = lbldono;
	}
	public String getLblamountinwords() {      
		return lblamountinwords;
	}
	public void setLblamountinwords(String lblamountinwords) {
		this.lblamountinwords = lblamountinwords;
	}
	public String getLblshipto() {
		return lblshipto;
	}
	public void setLblshipto(String lblshipto) {
		this.lblshipto = lblshipto;
	}
	public String getLblshipaddress() {
		return lblshipaddress;
	}
	public void setLblshipaddress(String lblshipaddress) {
		this.lblshipaddress = lblshipaddress;
	}
	public String getLblcontactperson() {
		return lblcontactperson;
	}
	public void setLblcontactperson(String lblcontactperson) {
		this.lblcontactperson = lblcontactperson;
	}
	public String getLblshiptelephone() {
		return lblshiptelephone;
	}
	public void setLblshiptelephone(String lblshiptelephone) {
		this.lblshiptelephone = lblshiptelephone;
	}
	public String getLblshipmob() {
		return lblshipmob;
	}
	public void setLblshipmob(String lblshipmob) {
		this.lblshipmob = lblshipmob;
	}
	public String getLblshipemail() {
		return lblshipemail;
	}
	public void setLblshipemail(String lblshipemail) {
		this.lblshipemail = lblshipemail;
	}
	public String getLblshipfax() {
		return lblshipfax;
	}
	public void setLblshipfax(String lblshipfax) {
		this.lblshipfax = lblshipfax;
	}
	
	
	
	public int getThirdarray() {
		return thirdarray;
	}
	public void setThirdarray(int thirdarray) {
		this.thirdarray = thirdarray;
	}
	public String getOrderValuefinal() {
		return orderValuefinal;
	}
	public void setOrderValuefinal(String orderValuefinal) {
		this.orderValuefinal = orderValuefinal;
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
	public String getTrnno() {
		return trnno;
	}
	public void setTrnno(String trnno) {
		this.trnno = trnno;
	}
	public String getCmbvatype() {
		return cmbvatype;
	}
	public void setCmbvatype(String cmbvatype) {
		this.cmbvatype = cmbvatype;
	}
	public String saveInvoiceAction(){

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String returns="fail";
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
				
				java.sql.Date payduedate=ClsCommon.changeStringtoSqlDate(getPayDueDate());

                val=DAO.insert(date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getHidsalesman(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,termsarray,servarray,session,request,
						getRefmasterdocno(),getDescPercentage(),payduedate,getLocationid(),getCmbmodeofpay(),getTxtdelterms(),shiparray,getShipdocno(),
						getSt(), getTaxontax1() ,getTaxontax2() ,getTaxontax3() , getTaxtotal(),getCmbbilltype(),getBillto(),getBtrno(),getCmbvatype(),getClntacno());
				String vdocno=request.getAttribute("vdocNo").toString();
				String saletrno=request.getAttribute("Vtrno").toString();
				setTr_no(saletrno);

				if(val>0){
					
					setBillto(getBillto());
					setBtrno(getBtrno());
					
					 setSt(getSt()); 
					 setTaxontax1(getTaxontax1());
					 setTaxontax2(getTaxontax2());
					 setTaxontax3(getTaxontax3());
					 setTaxtotal(getTaxtotal());
					 setHidcmbbilltype(getCmbbilltype());
					 setHidcmbvatype(getCmbvatype());
					 
					 
					setHiddate(date.toString());
					setHidpayDueDate(payduedate.toString());
					setHidcmbprice(getCmbprice());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setTxtdelterms(getTxtdelterms());
					setHidcmbcurrency(getHidcmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setRefmasterdocno(getRefmasterdocno());
					setHidcmbreftype(getCmbreftype());
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setRoundOf(getRoundOf());
					setOrderValue(getOrderValue());
					setOrderValuefinal(getOrderValue());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					
					setSalesman(getSalesman());
					setHidsalesman(getHidsalesman());
					
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
					 setSt(getSt()); 
					 setTaxontax1(getTaxontax1());
					 setTaxontax2(getTaxontax2());
					 setTaxontax3(getTaxontax3());
					 setTaxtotal(getTaxtotal());
					 setHidcmbbilltype(getCmbbilltype());
						setBillto(getBillto());
						setBtrno(getBtrno());
					setHidcmbprice(getCmbprice());
					setHiddate(date.toString());
					setHidpayDueDate(payduedate.toString());
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurrency(getHidcmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setTxtdelterms(getTxtdelterms());
					setHidcmbreftype(getCmbreftype());
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setRefmasterdocno(getRefmasterdocno());
					setFormdetailcode(getFormdetailcode());
					
					setSalesman(getSalesman());
					setHidsalesman(getHidsalesman());
					
				       setShipto(getShipto());
			             setShipaddress(getShipaddress());
			             setContactperson(getContactperson());
			             setShiptelephone(getShiptelephone());
			             setShipmob(getShipmob());
			             setShipemail(getShipemail());
			             setShipfax(getShipfax());
			             setOrderValue(getOrderValue());
			             setOrderValuefinal(getOrderValue());
			             setShipdocno(getShipdocno());
			             setHidcmbvatype(getCmbvatype());
					
					setMsg("Not Saved");
					returns="fail";
				}
			}
			if(mode.equalsIgnoreCase("view")){

				bean=DAO.getViewDetails(getMasterdoc_no(),session.getAttribute("BRANCHID").toString());
				
				setCurrency(bean.getCurrency());
				setTxtclient(bean.getTxtclient());
				setTxtclientdet(bean.getTxtclientdet());
				 setSt(bean.getSt()); 
				 setTaxontax1(bean.getTaxontax1());
				 setTaxontax2(bean.getTaxontax2());
				 setTaxontax3(bean.getTaxontax3());
				 setTaxtotal(bean.getTaxtotal());
				 setHidcmbbilltype(bean.getCmbbilltype());
				 setHidcmbvatype(bean.getCmbvatype());
				 setTr_no(bean.getTr_no());
 
				
					setBillto(bean.getBillto());
					setBtrno(bean.getBtrno());
				System.out.println(getBtrno()+"==="+bean.getBtrno());
				
				setHiddate(bean.getDate());
				setHidpayDueDate(bean.getPayDueDate());
				setMasterdoc_no(bean.getMasterdoc_no());
				setDocno(bean.getDocno());
				setDate(bean.getDate());
				setTxtrefno(bean.getTxtrefno());
				setCmbcurr(bean.getCmbcurr());
				setHidcmbcurrency(bean.getHidcmbcurr());
				setHidcmbcurr(bean.getHidcmbcurr());
				setCurrate(bean.getCurrate());
				setSalespersonid(bean.getSalespersonid());
				setClientid(bean.getClientid());
				setClientid(getClientid());
				setRrefno(bean.getRrefno());
				setCmbreftype(bean.getCmbreftype());
				setHidcmbreftype(bean.getCmbreftype());
				setTxtpaymentterms(bean.getTxtpaymentterms());
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
				setOrderValuefinal(bean.getOrderValue());
				setNettotal(bean.getNettotal());
				setCmbprice(bean.getCmbprice());
				setLocationid(bean.getLocationid());
				setTxtlocation(bean.getTxtlocation());
				
				setTxtdelterms(bean.getTxtdelterms());
				
				setSalesman(bean.getSalesman());
				setHidsalesman(bean.getHidsalesman());
				
		         
		         
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
				java.sql.Date payduedate=ClsCommon.changeStringtoSqlDate(getPayDueDate());

				val=DAO.update(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getHidsalesman(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,termsarray,servarray,session,request,
						getRefmasterdocno(),getDescPercentage(),payduedate,getLocationid(),getCmbmodeofpay(),getEditdata(),getTxtdelterms(),shiparray,getShipdocno(),
						getSt(), getTaxontax1() ,getTaxontax2() ,getTaxontax3(), getTaxtotal(),getCmbbilltype(),getBillto(),getBtrno(),getCmbvatype(),getClntacno());
				int vdocno=(int) request.getAttribute("vdocNo");
				//setTr_no(request.getAttribute("vdocNo").toString());
				if(val>0){
					 setSt(getSt()); 
					 setTaxontax1(getTaxontax1());
					 setTaxontax2(getTaxontax2());
					 setTaxontax3(getTaxontax3());
					 setTaxtotal(getTaxtotal());
					 setHidcmbbilltype(getCmbbilltype());
					 setHidcmbvatype(getCmbvatype());
					 setTr_no(getTr_no());
					setHidcmbprice(getCmbprice());
					setHiddate(date.toString());
					setHidpayDueDate(payduedate.toString());
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurrency(getHidcmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtdelterms(getTxtdelterms());
					setTxtsalesperson(getTxtsalesperson());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setHidcmbreftype(getCmbreftype());
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setRefmasterdocno(getRefmasterdocno());
					setFormdetailcode(getFormdetailcode());
					setBillto(getBillto());
					setBtrno(getBtrno());
					
					setSalesman(getSalesman());
					setHidsalesman(getHidsalesman());
					
				     setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             setShipdocno(getShipdocno());
		             setOrderValue(getOrderValue());
					 setOrderValuefinal(getOrderValue());
					
					setMsg("Updated Successfully");
					returns="success";
				}
				else{
					setTr_no(getTr_no());
					 setSt(getSt()); 
					 setTaxontax1(getTaxontax1());
					 setTaxontax2(getTaxontax2());
					 setTaxontax3(getTaxontax3());
					 setTaxtotal(getTaxtotal());
					 setHidcmbbilltype(getCmbbilltype());
						setBillto(getBillto());
						setBtrno(getBtrno());
					setHidcmbprice(getCmbprice());
					setHiddate(date.toString());
					setHidpayDueDate(payduedate.toString());
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurrency(getHidcmbcurr());
					setHidcmbcurr(getHidcmbcurr());
					setCurrate(getCurrate());
					setTxtsalesperson(getTxtsalesperson());
					setTxtdelterms(getTxtdelterms());
					setSalespersonid(getSalespersonid());
					setClientid(getClientid());
					setTxtclient(getTxtclient());
					setTxtclientdet(getTxtclientdet());
					setRrefno(getRrefno());
					setHidcmbreftype(getCmbreftype());
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setRefmasterdocno(getRefmasterdocno());
					setFormdetailcode(getFormdetailcode());
					
					setSalesman(getSalesman());
					setHidsalesman(getHidsalesman());
					
				     setShipto(getShipto());
		             setShipaddress(getShipaddress());
		             setContactperson(getContactperson());
		             setShiptelephone(getShiptelephone());
		             setShipmob(getShipmob());
		             setShipemail(getShipemail());
		             setShipfax(getShipfax());
		             setShipdocno(getShipdocno());
		             setOrderValue(getOrderValue());
					 setOrderValuefinal(getOrderValue());
					 setHidcmbvatype(getCmbvatype());
					setMsg("Not Updated");
					returns="fail";
				}
			}

			if(mode.equalsIgnoreCase("D")){
				ArrayList<String> prodarray= new ArrayList<>();
				ArrayList<String> termsarray= new ArrayList<>();
				ArrayList<String> servarray= new ArrayList<>();

		 
				java.sql.Date date=ClsCommon.changeStringtoSqlDate(getDate());

				val=DAO.delete(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,termsarray,servarray,session,request,getRefmasterdocno(),getDescPercentage());
				//String vdocno=(String) request.getAttribute("vdocNo");
				int vdocno=(int) request.getAttribute("vdocNo");

				if(val>0){
					setMasterdoc_no(val);
					setDocno(vdocno+"");
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurrency(getHidcmbcurr());
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setRefmasterdocno(getRefmasterdocno());
					setFormdetailcode(getFormdetailcode());
					setOrderValue(getOrderValue());
					setOrderValuefinal(getOrderValue());
					setHidcmbvatype(getCmbvatype());
					setSalesman(getSalesman());
					setHidsalesman(getHidsalesman());
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					returns="success";
				}
				else{
					setTxtrefno(getTxtrefno());
					setCmbcurr(getCmbcurr());
					setHidcmbcurrency(getHidcmbcurr());
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setRefmasterdocno(getRefmasterdocno());
					setFormdetailcode(getFormdetailcode());
					setOrderValue(getOrderValue());
					setOrderValuefinal(getOrderValue());
					setHidcmbvatype(getCmbvatype());
					setSalesman(getSalesman());
					setHidsalesman(getHidsalesman());
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

	
	
	
	
	public String printAction() throws ParseException, SQLException, Exception{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		 int doc=Integer.parseInt(request.getParameter("docno"));
		 
		 String  formcode= request.getParameter("formdetailcode");
		 //System.out.println("In INVOICE PRINT JRXML             BEGINING"); 
		
		 bean=DAO.getPrint(doc,request,formcode);
	  
		 
		  ClsAmountToWords c = new ClsAmountToWords();
		  // cl details
		 
		 if(formcode.equalsIgnoreCase("CASH"))
		 {
			 setLblprintname("TAX INVOICE");
			 
		 }
		 else  
		 {
			 setLblprintname("TAX INVOICE"); 
		 }
		    
		 if(formcode.equalsIgnoreCase("CASH"))
		 {
			 setLblprintnameakamal("TAX INVOICE");
			 
		 }
		 else  
		 {
			 setLblprintnameakamal("TAX INVOICE"); 
		 }
		    
		    setClientname(bean.getClientname());
		    setLblfinaldate(bean.getLblfinaldate());
		    setLbltotaltax(bean.getLbltotaltax());
		    setLbltotaltaxamount(bean.getLbltotaltaxamount());
		    setLbldoc(bean.getLbldoc());
		    setLbldate(bean.getLbldate());
		     setLblrefno(bean.getLblrefno());
		     setLbldesc1(bean.getLbldesc1());
		     setLbltrno(bean.getLbltrno());
		    setLblclienttrno(bean.getLblclienttrno());
	 	   
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
				   setLblcmptrn_no(bean.getLblcmptrn_no());
				   setSecarray(bean.getSecarray());
				    setLblvattotal(bean.getLblvattotal());
					   
		    	      setLbltrnno(bean.getLbltrnno());
				   
				   setThirdarray(bean.getThirdarray());
				     setLblroundof(bean.getLblroundof());
		    	   setLblordervalue(bean.getLblordervalue());
		    	   setLblordervaluewords(bean.getLblordervaluewords());
		    	   
		    	   setLblduedate(bean.getLblduedate());
		    	   
		    	   
		    	   //doca print
		    	    setLblcompemail(bean.getLblcompemail());
		    	    
		    	    setLblround(bean.getLblround());
		    	    setLblvattotal(bean.getLblvattotal());
		    	    
		    	     setLblinvno(bean.getLblinvno());
		    	     setLblclientaddress(bean.getLblclientaddress());
		    	   
		    	     setLblclientcity(bean.getLblclientcity());
		    	    
		    	     setLblclientcountry(bean.getLblclientcountry());
		    	    
		    	     setLblclientmob(bean.getLblclientmob());
					setLblclientmail(bean.getLblclientmail());
		    	     setLblrrefno(bean.getLblrrefno());
		    	     setLblrrdate(bean.getLblrrdate());
					 setLblclienttel(bean.getLblclienttel());
		    	      
					     setLblshipto(bean.getLblshipto());
						 setLblshipaddress(bean.getLblshipaddress());
						 setLblcontactperson(bean.getLblcontactperson());
						 setLblshiptelephone(bean.getLblshiptelephone());
							
						 setLblshipmob(bean.getLblshipmob());
						 setLblshipemail(bean.getLblshipemail());
						 setLblshipfax(bean.getLblshipfax());
					
						 setTxtrefno(bean.getTxtrefno());
						 setLblamountinwords(bean.getLbltotal());
						 setLblakmaldates(bean.getLblakmaldates());
						 setLblamountinwordsakmal(bean.getLblamountinwordsakmal());
						 setRefdetail(bean.getRefdetail());
						 setReftype(bean.getReftype());
						 setLbldelterms(bean.getLbldelterms());
//						 System.out.println("==== "+bean.getLblamountinwordsakmal());
						 setUrl(ClsCommon.getPrintPath("INV"));
						 String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader2.jpg");
		        		 imgpath=imgpath.replace("\\", "\\\\");
		        	     
				         String imgpath1=request.getSession().getServletContext().getRealPath("/icons/quotationheader.jpg");
					     imgpath1=imgpath1.replace("\\", "\\\\");

				         String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/quotationfooter.png");
					     imgpathfooter=imgpathfooter.replace("\\", "\\\\");
			         
	if(ClsCommon.getPrintPath("INV").contains(".jrxml")==true){
		HttpServletResponse response = ServletActionContext.getResponse();
	    
		HashMap<String,String> param = new HashMap<String,String>();
		Connection conn = null;
		String reportFileName = "CreditInvoice";
		ClsConnection conobj=new ClsConnection();
		conn = conobj.getMyConnection();
		Statement stmt = conn.createStatement();      
		try {      
			
			String qstatus="0";
			Double totalsumexe=0.0;
			 String strqstatus="select coalesce(srno,0) qstatus,srno,sa.description,round(unitprice,2) price,qty,round(total,2) total,sum(round(total,2))totalexe,round(discount,2)discount,round(nettotal,2)nettotal,ir.acno as acno,h.description as account  from my_invdser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno="+doc;
			 ResultSet rsqstatus=stmt.executeQuery(strqstatus);
			 while(rsqstatus.next()){
				 qstatus=rsqstatus.getString("qstatus");
				 totalsumexe=rsqstatus.getDouble("totalexe");
			 }
			 //System.out.println("strqstatus=="+strqstatus+"==totlsumexe=="+totalsumexe);
			 Double servicetotal=0.00;
			 String servicesql="select srno,sa.description,round(unitprice,2) price,qty,round(total,2) total,round(discount,2)discount,round(nettotal,2)nettotal,sum(round(nettaxamount,2))nettaxamount,ir.acno as acno,h.description as account  from my_invdser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno="+doc;
			 ResultSet rsservice=stmt.executeQuery(servicesql);
			 while(rsservice.next()){
				 servicetotal=rsservice.getDouble("nettaxamount");
			 }
			 double totalService=0.00;
			  totalService=servicetotal+Double.parseDouble(bean.getLblnettotal().replace(",",""));
			// System.out.println("totalservice=="+totalService);
			 String bankdetails="select name, address, beneficiary, account, ibanno, swiftcode, city, country from cm_bankdetails ";
			 ResultSet rsbank=stmt.executeQuery(bankdetails);
			 while(rsbank.next()){
				 param.put("beneficiary",rsbank.getString("beneficiary"));
				 param.put("accountno",rsbank.getString("account"));
				 param.put("ibanno",rsbank.getString("ibanno"));
				 param.put("bankname",rsbank.getString("name"));
				 param.put("bankbranch",rsbank.getString("address"));
				 param.put("swiftcode",rsbank.getString("swiftcode"));
				 param.put("bankcity",rsbank.getString("city"));
				 param.put("bankcountry",rsbank.getString("country"));
			 }
			 String totalamount="";
			 
			 String forsql="select  round("+totalService+",2) total,format("+totalService+",2) total1;";
			 ResultSet rsfor=stmt.executeQuery(forsql);
			 while(rsfor.next()){
				 String total1=rsfor.getString("total1");
				 param.put("nettotal1",total1);
				 totalamount=rsfor.getString("total");
				 param.put("amtwords1",c.convertAmountToWords(totalamount).replace("AED",bean.getCurrency()));
				 //param.put("amtwords1",c.convertAmountToWords(totalamount)+"");
			 }
			 
			 param.put("qstatus",qstatus);
			 String nettotalsum="0.0",expensetotal="0.0";
			
			 double addinvexpensetotal=0.00;
			 String invqry="select round(@runtotal:=@runtotal+nettotal,2) netruntotal,a.nettotal,@i:=@i+1 row,a.* from(select m.part_no productid,m.productname, u.unit uom,round(sum(d.qty),2) qty,round((d.amount),2) unit,round(d.taxper,2)taxper,round(d.total,2) nettotal,round(sum(d.total),2) sumnettotal,round(sum(d.taxamount),2) taxamount,round(sum(d.nettotal+d.taxamount),2) nettaxamount  from my_invd d left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no where d.rdocno='"+doc+"'  group by d.prdid order by d.sr_no)a,(select @i:=0)c,(select @runtotal:=0)d";
			 ResultSet rsinv=stmt.executeQuery(invqry);
			 while(rsinv.next()){
				nettotalsum=rsinv.getString("netruntotal");
				}
			
			System.out.println("invqry=="+invqry);
			String invespense= "select srno,sa.description,round(unitprice,2) price,qty,round(total,2) total,round(discount,2)discount,round(nettotal,2)nettotal,coalesce(sum(round(nettotal,2)),'') sumnettotalexpnse,round(taxamount,2)taxamount,round(nettaxamount,2)nettaxamount,ir.acno as acno,h.description as account  from my_invdser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno="+doc;
			ResultSet rsinvexpense=stmt.executeQuery(invespense);
			 while(rsinvexpense.next()){
				 expensetotal=rsinvexpense.getString("sumnettotalexpnse");
			 }	
		
			 String invespens="0.0";
			 if(!nettotalsum.equalsIgnoreCase("")){
				 addinvexpensetotal+=Double.parseDouble(nettotalsum); 
			 }
			 if(!expensetotal.equalsIgnoreCase("")){
				 addinvexpensetotal+=Double.parseDouble(expensetotal); 
			 }
			String invqry1="select format("+addinvexpensetotal+",2) addinvexp";
			ResultSet rsinvexpensee=stmt.executeQuery(invqry1);
			 while(rsinvexpensee.next()){
				 invespens=rsinvexpensee.getString("addinvexp");
			}
			 
			 ClsCommon objcommon=new ClsCommon();
			 //addinvexpensetotal=objcommon.sqlRound(addinvexpensetotal,2);
			 //System.out.println("Final:"+invespens);
			 param.put("nettotalsum",invespens);
			 System.out.println("invespense=="+nettotalsum+" -- expense=="+expensetotal+"==addinvexpense=="+addinvexpensetotal);	
			 param.put("docno", getDocno());
			 param.put("printname", getLblprintnameakamal());
			 param.put("amtwords", bean.getLblamountinwords());  
			 param.put("tinno", bean.getTrnno()); 
			 param.put("invqry", invqry);
			 param.put("preparedby", "");
			 param.put("cusname", bean.getClientname());    
			 param.put("trnno", bean.getLblclienttrno());
			 param.put("invno", bean.getLblinvno());
             param.put("invnosamba",bean.getInvnosamba());
			 param.put("date", bean.getLbldate());
			 param.put("salesman", bean.getLblsalesPerson());
			 param.put("description", bean.getLbldesc1());
			 param.put("claddress", bean.getLblclientaddress());
			 param.put("clmob", bean.getLblclientmob());
			 param.put("refno", bean.getLblrefno());
			 param.put("cltel", bean.getLblclienttel());
			// System.out.println(">>>>>>>"+c.convertAmountToWords(totalService+"").replace("AED",bean.getCurrency()));
			// param.put("amountinwords",(c.convertAmountToWords(totalService+"")).replace("AED",bean.getCurrency()));
			 //System.out.println("amountinwords=="+c.convertAmountToWords(bean.getLblnettotal().replace(",", "")));
			 param.put("nettotal", totalService+""); 
			 param.put("nettotaltes",bean.getLblnettotal());
			  
			// System.out.println("nettotal=="+bean.getLblnettotal()+totalService);
			 param.put("discount", bean.getLbldiscount());  
			 
			 //System.out.println("discount=="+bean.getLbldiscount());
			 param.put("tax", bean.getLbltotaltaxamt());
			 param.put("total", bean.getLbltotalamt());
			 param.put("casheader", imgpath);
			 param.put("mode", formcode);
			  param.put("invnonw", bean.getLbldoc()+"");
			  System.out.println("tax=="+bean.getLbltotaltaxamt()+"====");
			 param.put("delterms", bean.getLbldelterms());
			 param.put("currency",bean.getCurrency());
			 param.put("payterms",bean.getTxtpaymentterms());
			 param.put("refno", bean.getLblrefno());
			//System.out.println("refno=="+bean.getLblrefno());
			 //System.out.println(bean.getCurrency()+"=bean.getCurrency()="+bean.getLblordervaluewords().replace("AED",bean.getCurrency()));
			 //System.out.println(bean.getLblordervaluewords()+"= bean.getLblordervaluewords()="+ bean.getLblordervaluewords());
			 param.put("amountinwords", bean.getLblnetamountwds().replace("AED",bean.getCurrency())); 
			// System.out.println("amountinwords=="+bean.getLblnetamountwds().replace("AED",bean.getCurrency()));
			 //System.out.println("currency=="+bean.getCurrency());
			 if(getReftype().equalsIgnoreCase("DEL")){
				 param.put("refdetname", "LPO :");
				 param.put("refdetail", bean.getRefdetail());
				 
			 }
			 
			 param.put("duedate", bean.getLblduedate());
	         param.put("imgpathfooter",imgpathfooter);
	         param.put("imgpath",imgpath1 );
	         
	         
			 ClsCommon com=new ClsCommon();
			 //System.out.println("In INVOICE PRINT JRXML");   
			JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
			 JasperReport jasperReport = JasperCompileManager.compileReport(design);
			 generateReportPDF(response, param, jasperReport, conn);
			 conn.close();
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
public String getClntacno() {
	return clntacno;
}
public void setClntacno(String clntacno) {
	this.clntacno = clntacno;
}
public String getHidcmbcurr() {
	return hidcmbcurr;
}
public void setHidcmbcurr(String hidcmbcurr) {
	this.hidcmbcurr = hidcmbcurr;
}
public String getTr_no() {
    return tr_no;
}
public void setTr_no(String tr_no) {
    this.tr_no = tr_no;
}

	
	
	
}
