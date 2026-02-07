package com.sales.marketing.salesorder;

 
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.sql.ResultSet;












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
 
























import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;


public class ClsSalesOrderAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsSalesOrderDAO DAO= new ClsSalesOrderDAO();
	ClsCommon objcommon=new ClsCommon();
	ClsSalesOrderBean bean= new ClsSalesOrderBean();

	private String date,hidcmbcurr;
	private String hiddate;
	private String txtrefno;
	private String docno,cmbvatype,hidcmbvatype;
	private String txtclient;
	private int clientid;
	private String txtclientdet;
	private String txtsalesperson;
	private int salespersonid;
	private String cmbcurr;
	private String hidcmbcurrency;
	private String currate;
	private String cmbreftype;
	private String hidcmbreftype;
	private String discount2,taxamount2;
	 public String getTaxamount2() {
		return taxamount2;
	}
	public void setTaxamount2(String taxamount2) {
		this.taxamount2 = taxamount2;
	}
	public String getDiscount2() {
		return discount2;
	}
	public void setDiscount2(String discount2) {
		this.discount2 = discount2;
	}
	private String currency,url,taxamount,lblcladdress,lbltrnno,Lblmob,Lbltel;
	 public String getLblmob() {
		return Lblmob;
	}
	public void setLblmob(String lblmob) {
		Lblmob = lblmob;
	}
	public String getLbltel() {
		return Lbltel;
	}
	public void setLbltel(String lbltel) {
		Lbltel = lbltel;
	}
	public String getTaxamount() {
			return taxamount;
		}
		public void setTaxamount(String taxamount) {
			this.taxamount = taxamount;
		}

		public String getCurrency() {
			return currency;
		}
		public void setCurrency(String currency) {
			this.currency = currency;
		}
		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
	public String getCmbvatype() {
		return cmbvatype;
	}
	public void setCmbvatype(String cmbvatype) {
		this.cmbvatype = cmbvatype;
	}
	public String getHidcmbvatype() {
		return hidcmbvatype;
	}
	public void setHidcmbvatype(String hidcmbvatype) {
		this.hidcmbvatype = hidcmbvatype;
	}
	public String getLblcladdress() {
		return lblcladdress;
	}
	public void setLblcladdress(String lblcladdress) {
		this.lblcladdress = lblcladdress;
	}
	public String getLbltrnno() {
		return lbltrnno;
	}
	public void setLbltrnno(String lbltrnno) {
		this.lbltrnno = lbltrnno;
	}
	private String rrefno;
	private String txtpaymentterms;
	private String txtdescription;
	private String txtproductamt;
	private String txtdiscount,txt_discount;
	public String getTxt_discount() {
		return txt_discount;
	}
	public void setTxt_discount(String txt_discount) {
		this.txt_discount = txt_discount;
	}
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
	private String hidcmbprice,editdata,delterms;

	private int	shipdatagridlenght,shipdocno;
	
	 
	private String  shipto,shipaddress,contactperson,shiptelephone,shipmob,shipemail,shipfax;

    
	private double st,taxontax1,taxontax2,taxontax3,taxtotal;
	
	
	private int cmbbilltype,hidcmbbilltype;
	
	
	
	
	
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
	public String getDelterms() {
		return delterms;
	}
	public void setDelterms(String delterms) {
		this.delterms = delterms;
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

	private String lbldate,lbltype,lblvendoeacc,lblvendoeaccName, expdeldate,lbldelterms ,lblpaytems, lbldesc1,lblrefno,lblsubtotal,lbltotal,lblordervalue,lblordervaluewords;
	private int lbldoc,firstarray,secarray;
	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname,lblsalesPerson,refno;	
	
	
	 
	
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}
	public String getLblsalesPerson() {
		return lblsalesPerson;
	}
	public void setLblsalesPerson(String lblsalesPerson) {
		this.lblsalesPerson = lblsalesPerson;
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
	public String saveOrderAction(){

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

				val=DAO.insert(date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),
						getFormdetailcode(),prodarray,termsarray,servarray,session,request,getRefmasterdocno(),getDescPercentage()
						,shiparray,getShipdocno(),getDelterms(),getSt(),getTaxontax1(),getTaxontax2(),getTaxontax3(),getTaxtotal(),getCmbbilltype(),getCmbvatype());
				int vdocno=(int) request.getAttribute("vdocNo");
				setDate(date.toString());
				if(val>0){
					
					
					
					 setSt(getSt()); 
					 setTaxontax1(getTaxontax1());
					 setTaxontax2(getTaxontax2());
					 setTaxontax3(getTaxontax3());
					 setTaxtotal(getTaxtotal());
					 setHidcmbbilltype(getCmbbilltype());
					 setHidcmbvatype(getCmbvatype());
					 
					setDelterms(getDelterms());
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setRoundOf(getRoundOf());
					setOrderValue(getOrderValue());
					setTxtdiscount(getTxtdiscount());
					setTxt_discount(getTxt_discount());
					setDiscount2(getDiscount2());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					
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
					setDelterms(getDelterms());
					
					 setSt(getSt()); 
					 setTaxontax1(getTaxontax1());
					 setTaxontax2(getTaxontax2());
					 setTaxontax3(getTaxontax3());
					 setTaxtotal(getTaxtotal());
					 setHidcmbbilltype(getCmbbilltype());
					 setHidcmbvatype(getCmbvatype());
					 
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxt_discount(getTxt_discount());
					setDiscount2(getDiscount2());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					
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
				 setDate(bean.getDate());
				 setTaxamount(bean.getTaxamount());
				 setTaxamount2(bean.getTaxamount2());
				 setDocno(bean.getDocno());
				 setCurrency(bean.getCurrency());
				 setSt(bean.getSt()); 
				 setTaxontax1(bean.getTaxontax1());
				 setTaxontax2(bean.getTaxontax2());
				 setTaxontax3(bean.getTaxontax3());
				 //setTaxtotal(bean.getTaxtotal());
				 setHidcmbbilltype(bean.getCmbbilltype());
				 setHidcmbvatype(bean.getCmbvatype());
				
				setDelterms(bean.getDelterms());
				setMasterdoc_no(bean.getMasterdoc_no());
				//setDocno(bean.getDocno());
				setTxtrefno(bean.getTxtrefno());
				setCmbcurr(bean.getCmbcurr());
				setHidcmbcurr(bean.getHidcmbcurr());
				setCurrate(bean.getCurrate());
				setSalespersonid(bean.getSalespersonid());
				setClientid(bean.getClientid());
				//setClientid(getClientid());
				setTxtclient(bean.getTxtclient());
				setTxtclientdet(bean.getTxtclientdet());
				setHidcmbprice(bean.getHidcmbprice());
				setRrefno(bean.getRrefno());
				 
				setHidcmbreftype(bean.getCmbreftype());
				setTxtpaymentterms(bean.getTxtpaymentterms());
				setTxtdescription(bean.getTxtdescription());
				setDescPercentage(bean.getDescPercentage());
				setTxtproductamt(bean.getTxtproductamt());
				setTxtdiscount(bean.getTxtdiscount());
				setTxt_discount(bean.getTxt_discount());
				setDiscount2(bean.getDiscount2());
				setTxtnettotal(bean.getTxtnettotal());
				setRoundOf(bean.getRoundOf());
				setProdsearchtype(bean.getProdsearchtype());  
				setTxtsalesperson(bean.getTxtsalesperson());
				setRefmasterdocno(bean.getRefmasterdocno());
				setOrderValue(bean.getOrderValue());
				setNettotal(bean.getNettotal());
				
				
				
		         
		         
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

				val=DAO.update(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),
						getFormdetailcode(),prodarray,termsarray,servarray,session,request,getRefmasterdocno(),getDescPercentage(),getEditdata(),shiparray,
						getShipdocno(),getDelterms(),getSt(), getTaxontax1() ,getTaxontax2() ,getTaxontax3(), getTaxtotal(),getCmbbilltype(),getCmbvatype());
				int vdocno=(int) request.getAttribute("vdocNo");
				setDate(date.toString());
				if(val>0){
					
					 setSt(getSt()); 
					 setTaxontax1(getTaxontax1());
					 setTaxontax2(getTaxontax2());
					 setTaxontax3(getTaxontax3());
					 setTaxtotal(getTaxtotal());
					 setHidcmbbilltype(getCmbbilltype());
					 setHidcmbvatype(getCmbvatype());
					 
					setDelterms(getDelterms());
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxt_discount(getTxt_discount());
					//setDiscount2(getDisount2());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					
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
					
					 setSt(getSt()); 
					 setTaxontax1(getTaxontax1());
					 setTaxontax2(getTaxontax2());
					 setTaxontax3(getTaxontax3());
					 setTaxtotal(getTaxtotal());
					 setHidcmbbilltype(getCmbbilltype());
					 setHidcmbvatype(getCmbvatype());
					 
					setDelterms(getDelterms());
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxt_discount(getTxt_discount());
					setDiscount2(getDiscount2());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
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

				val=DAO.delete(getDocno(),getMasterdoc_no(),date,getTxtrefno(),getCmbprice(),getHidcmbcurr(),getCurrate(),getSalespersonid(),getClientid(), getRrefno(),getCmbreftype(),getTxtpaymentterms(),getTxtdescription(),
						getTxtproductamt(),getTxtdiscount(),getTxtnettotal(),getNettotal(),getRoundOf(),getOrderValue(),getMode(),getFormdetailcode(),prodarray,termsarray,servarray,session,request,getRefmasterdocno(),getDescPercentage());
				 
				setDate(date.toString());
				if(val>0){
					setMasterdoc_no(val);
					setDocno(getDocno()+"");
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxt_discount(getTxt_discount());
					setDiscount2(getDiscount2());
					setTxtnettotal(getTxtnettotal());
					setMode(getMode());
					setFormdetailcode(getFormdetailcode());
					setDeleted("DELETED");
					setMsg("Successfully Deleted");
					returns="success";
				}
				else{
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
					setTxtpaymentterms(getTxtpaymentterms());
					setTxtdescription(getTxtdescription());
					setTxtproductamt(getTxtproductamt());
					setTxtdiscount(getTxtdiscount());
					setTxt_discount(bean.getTxt_discount());
					setDiscount2(bean.getDiscount2());
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
		 //System.out.println("Print Sales order"); 
		 String id=request.getParameter("id")==null?"0":request.getParameter("id").toString();
		 bean=DAO.getPrint(doc,request);
	    

		  ClsAmountToWords c = new ClsAmountToWords();
		
		  //cl details
		 
		    setLblprintname("Sales Order");
		    setLbldoc(bean.getLbldoc());
		    setLbldate(bean.getLbldate());
		    setLblrefno(bean.getLblrefno());
		    setRefno(bean.getRefno());

		    setLbldesc1(bean.getLbldesc1());
		    
	 	      
  	     setLblpaytems(bean.getLblpaytems());
  	     setLbldelterms(bean.getLbldelterms());
  	     setLbltype(bean.getLbltype());
  	     setLblvendoeacc(bean.getLblvendoeacc());  
  	     setLblvendoeaccName(bean.getLblvendoeaccName());
  	    setLbltrnno(bean.getLbltrnno());
  	    setLblcladdress(bean.getLblcladdress());
  	    setLbltel(bean.getLbltel());
  	    setLblmob(bean.getLblmob());
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
				   
				   setFirstarray(bean.getFirstarray());
				   setSecarray(bean.getSecarray());
		    	   setLblordervalue(bean.getLblordervalue());
		    	   setLblordervaluewords(bean.getLblordervaluewords());
		    	   setTxt_discount(bean.getTxt_discount());
		    	   setDiscount2(bean.getDiscount2());
		    	   setUrl(ClsCommon.getPrintPath("SOR"));
		    	   String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader2.jpg");
	        		 imgpath=imgpath.replace("\\", "\\\\");
	        	     
			         String imgpath1=request.getSession().getServletContext().getRealPath("/icons/quotationheader.jpg");
				     imgpath1=imgpath1.replace("\\", "\\\\");

			         String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/quotationfooter.png");
				     imgpathfooter=imgpathfooter.replace("\\", "\\\\");
		         
				     if(ClsCommon.getPrintPath("SOR").contains(".jrxml")==true){
				    		//System.out.println("print path",+printpath());
				 		HttpServletResponse response = ServletActionContext.getResponse();
				 	    
				 		HashMap<String,String> param = new HashMap<String,String>();
				 		Connection conn = null;
				 		String reportFileName = "Sales Order";
				 		ClsConnection conobj=new ClsConnection();
				 		conn = conobj.getMyConnection();
				 		Statement stmt = conn.createStatement();      
				 		try {      
				 			//String invqry="select @i:=@i+1 row,a.* from(select m.part_no productid,m.productname, u.unit uom,round(d.qty,2) qty,format((d.nettotal/d.qty),2)unit,round(d.taxper,2)taxper,round(sum(d.taxamount),2) taxamount,round(d.nettaxamount,2) nettaxamount  from my_sorderd d left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no where d.rdocno='"+doc+"' group by d.prdid)a,(select @i:=0)c";
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
							 String servicesql="select srno,desc1,round(unitprice,2) price,qty,round(total,2) total,round(discount,2)discount,round(nettotal,2)nettotal,coalesce(sum((round(nettotal,2)+round(srvtaxamount,2))),0)nettaxamount,ir.acno as acno,h.description as account  from my_sordser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno="+doc;
						    // System.out.println("service grid--"+servicesql);
							 ResultSet rsservice=stmt.executeQuery(servicesql);
							 while(rsservice.next()){
								 servicetotal=rsservice.getDouble("nettaxamount");
							 }
							
							// select srno,desc1,round(unitprice,2) price,qty,round(total,2) total,round(discount,2)discount,round(nettotal,2)nettotal,round(srvtaxamount,2)taxamount,(round(nettotal,2)+round(srvtaxamount,2)) nettaxamount,ir.acno as acno,h.description as account  from my_sordser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno=132;
							 double totalService=0.00;
							 double addinvexpensetotal=0.00;
							 String nettotalsum="0.0",expensetotal="0.0";
							  totalService=servicetotal+Double.parseDouble(bean.getNettotal().replace(",",""));
							// System.out.println("totalservice=="+totalService);  
							  String invqry=" select round(@runtotal:=@runtotal+nettotal,2) netruntotal,a.nettotal,@i:=@i+1 row,a.* from(select m.part_no productid,m.productname, u.unit uom,round(d.qty,2) qty,format((d.nettotal/d.qty),2)unit,round(d.taxper,2)taxper,round(sum(d.taxamount),2) taxamount,coalesce(f.path,'')  illimage,round(d.nettotal,2) nettotal,round(d.nettaxamount,2) nettaxamount  from my_sorderd d left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_fileattach f on  m.doc_no=f.doc_no and f.status=3 and f.dtype='PRD' where d.rdocno='"+doc+"' group by d.prdid)a,(select @i:=0)c,(select @runtotal:=0)d";
							  //System.out.println("invqry=="+invqry);
							  ResultSet rsinv=stmt.executeQuery(invqry);
								 while(rsinv.next()){
									nettotalsum=rsinv.getString("netruntotal");
									}
								 String totalamount="";
								 Double amtword=0.00;
                                 String word1="";
                                 Double total2=0.00;

								 String invqry2=" select round(@runtotal:=@runtotal+nettotal,2) netruntotal,a.nettotal,@i:=@i+1 row,a.* from(select m.part_no productid,m.productname, u.unit uom,round(d.qty,2) qty,format((d.amount),2)unit,round(d.taxper,2)taxper,round(sum(d.taxamount),2) taxamount,coalesce(f.path,'')  illimage,round(d.total,2) nettotal,round(d.nettaxamount,2) nettaxamount  from my_sorderd d left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left join my_fileattach f on  m.doc_no=f.doc_no and f.status=3 and f.dtype='PRD' where d.rdocno='"+doc+"' group by d.prdid)a,(select @i:=0)c,(select @runtotal:=0)d";
								 //System.out.println("nettotalsum--"+nettotalsum);
								 ClsAmountToWords awdao=new ClsAmountToWords();
								 Double total11=0.00;
								 String total1="";
																 String forsql="select  round("+totalService+",2) total,format("+totalService+",2) total1;";
								//System.out.println("total=="+forsql);
								 ResultSet rsfor=stmt.executeQuery(forsql);
								 while(rsfor.next()){
									  total1=rsfor.getString("total1");
									// total11=rsfor.getDouble("total1");
									
									 
									 
								
									 totalamount=rsfor.getString("total");
									 amtword=Double.parseDouble(totalamount)+Double.parseDouble(bean.getRoundOf());
									
									
									 //System.out.println("nettotal2--"+total2+Double.parseDouble(bean.getRoundOf()));
									 param.put("amtwords1",c.convertAmountToWords(totalamount).replace("AED",bean.getCurrency()));

								 }
								// System.out.println("c.convertAmountToWords(totalamount)--"+c.convertAmountToWords(totalamount));
								 String str="select round("+amtword+",2) roundvalue";
                                 ResultSet rsfor1=stmt.executeQuery(str);
                                 while(rsfor1.next()){
                                
                                     word1=rsfor1.getString("roundvalue");
                                 }
                                 
                                // System.out.println("total1======"+total1);
                                 //ClsAmountToWords awdao=new ClsAmountToWords();
                                 //amtwords=awdao.convertAmountToWordsWithCurr(nettotaltok1+"",curId);
                                 param.put("nettotal2",word1);
                                 param.put("nettotal1",total1);
                                 param.put("amtwords3", c.convertAmountToWords(word1));
                                param.put("amtwords2",bean.getCurrency()+awdao.convertAmountToWordsWithCurr(word1,getHidcmbcurr()));
								 param.put("qstatus",qstatus);
								 //System.out.println("invqry=="+invqry);
									String invespense= "select srno,desc1,round(unitprice,2) price,qty,round(total,2) total,round(discount,2)discount,round(nettotal,2)nettotal,coalesce(sum((round(nettotal,2)+round(srvtaxamount,2))),'') sumnettotalexpnse,round(srvtaxamount,2)taxamount,(round(nettotal,2)+round(srvtaxamount,2))nettaxamount,ir.acno as acno,h.description as account  from my_sordser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno="+doc;
									                  //  select srno,desc1,round(unitprice,2) price,qty,round(total,2) total,round(discount,2)discount,round(nettotal,2)nettotal,sum((round(nettotal,2)+round(srvtaxamount,2)))nettaxamount,ir.acno as acno,h.description as account  from my_sordser ir left join my_salexpaccount sa on(sa.acno=ir.acno) left join my_head h on(sa.acno=h.doc_no)  where rdocno="+doc;
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
									 String printpath2="";
									 if(id.equalsIgnoreCase("1"))
									 {
										// printpath2=objcommon.getPrintPath2("SOR");
										 setUrl(objcommon.getPrintPath2("SOR"));
									 }
									 
								 //System.out.println("id---"+id);
                             String bankdetails="select name, address, beneficiary, account, ibanno, swiftcode, city, country from cm_bankdetails ";
							 ResultSet rsbank=conn.createStatement().executeQuery(bankdetails);
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
							 
							 
							
				 			 param.put("doc_no", getDocno());
				 			 //param.put("printname", getLblprintnameakamal());
				 			 //param.put("amtwords", bean.getLblamountinwords());  
				 			 //param.put("tinno", bean.getTinno()); 
				 			 param.put("invqry", invqry);
				 			 param.put("invqry1", invqry2);
				 			 param.put("nettotalsum",invespens);
                             param.put("nettaxamt", servicetotal+"");
                             //System.out.println("nettaxamt=="+servicetotal);
				 			 param.put("id",id);
				 			 param.put("salesperson",bean.getTxtsalesperson());
				 			 param.put("preparedby", "");
				 			 param.put("cusname", bean.getLblvendoeaccName());   
				 			 param.put("claddress", bean.getLblcladdress());
				 			 param.put("clmob", bean.getLblmob());
				 			 param.put("cltel", bean.getLbltel());
				 			 param.put("trnno", bean.getLbltrnno());
				 			 param.put("compname", bean.getLblcompname());
				 			 param.put("compaddress", bean.getLblcompaddress());
				             param.put("comptel",bean.getLblcomptel());
				 			 param.put("branchname",bean.getLblbranch());
				 			 param.put("date", bean.getLbldate());
				 			 param.put("salesman", bean.getLblsalesPerson());
				 			 param.put("description", bean.getLbldesc1());
				 			param.put("roundoff", bean.getRoundOf());
				 			 //System.out.println("roundoff--"+bean.getRoundOf());
				 			 //param.put("claddress", bean.getLblclientaddress());
				 			 //param.put("clmob", bean.getLblclientmob());
				 			 param.put("amountinwords", bean.getLblordervaluewords().replace("AED",bean.getCurrency()));   
				 			
				 			 param.put("nettotal", bean.getNettotal());  
				 			 param.put("discount", bean.getTxtdiscount());
				 			 param.put("discount1",bean.getTxt_discount());
				 			 param.put("discount2", bean.getDiscount2());
				 		// System.out.println("discount=="+bean.getDiscount2()+"=discount1="+bean.getTxt_discount());
				 			param.put("tax", bean.getTaxamount());
				 			param.put("tax2", bean.getTaxamount2());
				 			 param.put("total", bean.getLbltotal());
				 			 param.put("casheader", imgpath);
				 			 param.put("currency",bean.getCurrency());
				 			// System.out.println(bean.getCurrency()+"=bean.getCurrency()="+bean.getLblordervaluewords().replace("AED",bean.getCurrency()));
							// System.out.println(bean.getLblordervaluewords()+"= bean.getLblordervaluewords()="+ bean.getLblordervaluewords());
				 			  //param.put("docno", bean.getLbldoc()+"");
				 			 param.put("delterms", bean.getLbldelterms());
				 			 param.put("payterms", bean.getLblpaytems());
				 			 param.put("type", bean.getLbltype());
				 			 param.put("refno", bean.getRefno());
				 			// System.out.println("refno--"+getTxtrefno());
				 			param.put("refnum", bean.getLblrefno());
				 			 //if(getReftype().equalsIgnoreCase("DEL")){
				 				 //param.put("refdetname", "LPO :");
				 				 //param.put("refdetail", bean.getRefdetail());
				 			 //}
				 			 String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
					        	imgpath2=imgpath2.replace("\\", "\\\\");    
					          param.put("imgheader", imgpath2);
					          String imgpath3=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
					        	imgpath3=imgpath3.replace("\\", "\\\\");    
					          param.put("imgfooter", imgpath3);
				 			 
				 	         param.put("imgpathfooter",imgpathfooter);
				 	         param.put("imgpath",imgpath1 );
				 	         
				 	         
				 			 ClsCommon com=new ClsCommon();
				 		     //System.out.println("In SALES ORDER PRINT JRXML");   
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
	public String getHidcmbcurr() {
		return hidcmbcurr;
	}
	public void setHidcmbcurr(String hidcmbcurr) {
		this.hidcmbcurr = hidcmbcurr;
	}	
}
