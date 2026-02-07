package com.project.execution.projectInvoice;

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

import org.apache.poi.ss.formula.functions.Replace;
import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.project.execution.ServiceSale.ClsServiceSaleBean;

/*import com.ibm.icu.text.DecimalFormat;*/
import java.text.DecimalFormat;     

public class ClsProjectInvoiceAction {

	ClsCommon com=new ClsCommon();
	ClsProjectInvoiceDAO proinvDAO= new ClsProjectInvoiceDAO();
	ClsProjectInvoiceBean proinvBean;
	ClsConnection conobj=new ClsConnection();
	private String date;
	private String hiddate;
	private String refno;  
	private String brchName;
	private String amtwordsfire7;

	private String txtlegalamt;
	private String txtseramt;
	private String txtexptotal;
	private String txtnettotal;
    private String Aitsamountwrds,discount,chkstatus;
    
	public String getChkstatus() {
		return chkstatus;
	}
	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	public String getAitsamountwrds() {
		return Aitsamountwrds;
	}
	public void setAitsamountwrds(String aitsamountwrds) {
		Aitsamountwrds = aitsamountwrds;
	}
	private String clacno,preparedby;  
    public String getPreparedby() {
		return preparedby;
	}
	public void setPreparedby(String preparedby) {
		this.preparedby = preparedby;
	}
	private int costid;
	private int maintrno;
	private String searchtrno;
	private int docno;
	private String pdid;
	private int invgridlength;
	private int expgridlength;
	private String cmbcontracttype;
	private String ptype;


	private String desc;
	private String txtnotes;
	private String mode;
	private String msg;
	private String deleted;
	private String formdetailcode;

	private String lblcompname, lblnetamount, lblnetamountword;
	private String lblcompaddress;
	private String lblcompanyaddress;
	private String lblprintname;
	private String lblcomptel;
	private String lblcompfax;
	private String lblprintname1;
	private String lblbranch;
	private String lbllocation;
	private String lblbranchtrno;
	private String amountwords;
	private String lblcheckedby;
	private String lblfinaldate;
	private String txtheader;
	private String url;
	private String txttel;
	private String txtmob;
	private String txtemail;
	private String txtjobrefno; 
    private String contypeval;
	private int masterdoc_no;

	private int clientid;
	private int cpersonid;

	private String txtclient;
	private String txtclientdet;
	private int txtcontract;
	private String lblcltrnno;

	private ArrayList list;
	private ArrayList sitelist;
	private ArrayList serlist;
	private ArrayList termlist;
	private ArrayList paylist;

	private String mxrnomin;
	private String mxrnomax;
	private String total1;
	private String invoived;
	private String balance;
	
	private String cperson;
	private String companytinno;
	private String contractnum;
	private String comtel;
	private String comfax;
	private String comemail;
	private Double fstotvat,fsinvoicevat,fsbalancevat;
	
	public String getLblnetamount() {
		return lblnetamount;
	}
	public void setLblnetamount(String lblnetamount) {
		this.lblnetamount = lblnetamount;
	}
	public String getLblnetamountword() {
		return lblnetamountword;
	}
	public void setLblnetamountword(String lblnetamountword) {
		this.lblnetamountword = lblnetamountword;
	}
	public Double getFsbalancevat() {
		return fsbalancevat;
	}
	public void setFsbalancevat(Double fsbalancevat) {
		this.fsbalancevat = fsbalancevat;
	}
	public Double getFsinvoicevat() {
		return fsinvoicevat;
	}
	public void setFsinvoicevat(Double fsinvoicevat) {
		this.fsinvoicevat = fsinvoicevat;
	}
	public Double getFstotvat() {
		return fstotvat;
	}
	public void setFstotvat(Double fstotvat) {
		this.fstotvat = fstotvat;
	}
	public String getAmtwordsfire7() {
		return amtwordsfire7;
	}
	public void setAmtwordsfire7(String amtwordsfire7) {
		this.amtwordsfire7 = amtwordsfire7;
	}
	public String getComtel() {
		return comtel;
	}
	public void setComtel(String comtel) {
		this.comtel = comtel;
	}
	public String getComfax() {
		return comfax;
	}
	public void setComfax(String comfax) {
		this.comfax = comfax;
	}
	public String getComemail() {
		return comemail;
	}
	public void setComemail(String comemail) {
		this.comemail = comemail;
	}
	public String getContractnum() {
		return contractnum;
	}
	public void setContractnum(String contractnum) {
		this.contractnum = contractnum;
	}
	public String getCompanytinno() {
		return companytinno;
	}
	public void setCompanytinno(String companytinno) {
		this.companytinno = companytinno;
	}
	private String txtrefdetails;
	private String txtdtype;
	private String cltelno;
	
	private String txtpjivreturned;
	
	public String getTxtpjivreturned() {
		return txtpjivreturned;
	}
	public void setTxtpjivreturned(String txtpjivreturned) {
		this.txtpjivreturned = txtpjivreturned;
	}
	
	public String getCltelno() {
		return cltelno;
	}
	public void setCltelno(String cltelno) {
		this.cltelno = cltelno;
	}
	public String getTxtdtype() {
		return txtdtype;
	}
	public void setTxtdtype(String txtdtype) {
		this.txtdtype = txtdtype;
	}
	public String getTxtrefdetails() {
		return txtrefdetails;
	}
	public void setTxtrefdetails(String txtrefdetails) {
		this.txtrefdetails = txtrefdetails;
	}
	public String getCperson() {
		return cperson;
	}
	public void setCperson(String cperson) {
		this.cperson = cperson;
	}
	
	
	public String getMxrnomin() {
		return mxrnomin;
	}
	public void setMxrnomin(String mxrnomin) {
		this.mxrnomin = mxrnomin;
	}
	public String getMxrnomax() {
		return mxrnomax;
	}
	public void setMxrnomax(String mxrnomax) {
		this.mxrnomax = mxrnomax;
	}
	public String getTotal1() {
		return total1;
	}
	public void setTotal1(String total1) {
		this.total1 = total1;
	}
	public String getInvoived() {
		return invoived;
	}
	public void setInvoived(String invoived) {
		this.invoived = invoived;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}

	public String getContypeval() {
		return contypeval;
	}
	public void setContypeval(String contypeval) {
		this.contypeval = contypeval;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public ArrayList getPaylist() {
		return paylist;
	}
	public void setPaylist(ArrayList paylist) {
		this.paylist = paylist;
	}
	public String getHiddate() {
		return hiddate;
	}
	public void setHiddate(String hiddate) {
		this.hiddate = hiddate;
	}
	public String getTxttel() {
		return txttel;
	}
	public void setTxttel(String txttel) {
		this.txttel = txttel;
	}
	public String getTxtmob() {
		return txtmob;
	}
	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtjobrefno() {
		return txtjobrefno;
	}
	public void setTxtjobrefno(String txtjobrefno) {
		this.txtjobrefno = txtjobrefno;
	}
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}
	public ArrayList getSitelist() {
		return sitelist;
	}
	public void setSitelist(ArrayList sitelist) {
		this.sitelist = sitelist;
	}
	public ArrayList getSerlist() {
		return serlist;
	}
	public void setSerlist(ArrayList serlist) {
		this.serlist = serlist;
	}
	public ArrayList getTermlist() {
		return termlist;
	}
	public void setTermlist(ArrayList termlist) {
		this.termlist = termlist;
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
	public String getLblcompanyaddress() {
		return lblcompanyaddress;
	}
	public void setLblcompanyaddress(String lblcompanyaddress) {
		this.lblcompanyaddress = lblcompanyaddress;
	}
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
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
	public String getLblprintname1() {
		return lblprintname1;
	}
	public void setLblprintname1(String lblprintname1) {
		this.lblprintname1 = lblprintname1;
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
	public String getLblbranchtrno() {
		return lblbranchtrno;
	}
	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}
	public String getAmountwords() {
		return amountwords;
	}
	public void setAmountwords(String amountwords) {
		this.amountwords = amountwords;
	}
	public String getLblcheckedby() {
		return lblcheckedby;
	}
	public void setLblcheckedby(String lblcheckedby) {
		this.lblcheckedby = lblcheckedby;
	}
	public String getLblfinaldate() {
		return lblfinaldate;
	}
	public void setLblfinaldate(String lblfinaldate) {
		this.lblfinaldate = lblfinaldate;
	}
	public String getTxtheader() {
		return txtheader;
	}
	public void setTxtheader(String txtheader) {
		this.txtheader = txtheader;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getCostid() {
		return costid;
	}
	public void setCostid(int costid) {
		this.costid = costid;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}
	public int getTxtcontract() {
		return txtcontract;
	}
	public void setTxtcontract(int txtcontract) {
		this.txtcontract = txtcontract;
	}

	public String getSearchtrno() {
		return searchtrno;
	}
	public void setSearchtrno(String searchtrno) {
		this.searchtrno = searchtrno;
	}


	public int getMaintrno() {
		return maintrno;
	}
	public void setMaintrno(int maintrno) {
		this.maintrno = maintrno;
	}
	public String getClacno() {
		return clacno;
	}
	public void setClacno(String clacno) {
		this.clacno = clacno;
	}
	public String getBrchName() {
		return brchName;
	}
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	public String getRefno() {
		return refno;
	}
	public void setRefno(String refno) {
		this.refno = refno;
	}



	public int getInvgridlength() {
		return invgridlength;
	}
	public void setInvgridlength(int invgridlength) {
		this.invgridlength = invgridlength;
	}

	public String getTxtlegalamt() {
		return txtlegalamt;
	}
	public void setTxtlegalamt(String txtlegalamt) {
		this.txtlegalamt = txtlegalamt;
	}
	public String getTxtseramt() {
		return txtseramt;
	}
	public void setTxtseramt(String txtseramt) {
		this.txtseramt = txtseramt;
	}
	public String getTxtexptotal() {
		return txtexptotal;
	}
	public void setTxtexptotal(String txtexptotal) {
		this.txtexptotal = txtexptotal;
	}
	public String getTxtnettotal() {
		return txtnettotal;
	}
	public void setTxtnettotal(String txtnettotal) {
		this.txtnettotal = txtnettotal;
	}
	public int getExpgridlength() {
		return expgridlength;
	}
	public void setExpgridlength(int expgridlength) {
		this.expgridlength = expgridlength;
	}
	public String getCmbcontracttype() {
		return cmbcontracttype;
	}
	public void setCmbcontracttype(String cmbcontracttype) {
		this.cmbcontracttype = cmbcontracttype;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}




	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}
	public String getTxtclientdet() {
		return txtclientdet;
	}
	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}
	public String getLblcltrnno() {
		return lblcltrnno;
	}
	public void setLblcltrnno(String lblcltrnno) {
		this.lblcltrnno = lblcltrnno;
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
	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}


	public int getClientid() {
		return clientid;
	}
	public void setClientid(int clientid) {
		this.clientid = clientid;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
	}
	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getPdid() {
		return pdid;
	}
	public void setPdid(String pdid) {
		this.pdid = pdid;
	}
	public String getTxtnotes() {
		return txtnotes;
	}
	public void setTxtnotes(String txtnotes) {
		this.txtnotes = txtnotes;
	}
private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}


private String fire7site,fire7sitenw;
private String from;
private String to;
private String header;
	
	public String getHeader() {
	return header;
}
public void setHeader(String header) {
	this.header = header;
}
	public String getFrom() {
	return from;
}
public void setFrom(String from) {
	this.from = from;
}
public String getTo() {
	return to;
}
public void setTo(String to) {
	this.to = to;
}
	public String getFire7site() {
		return fire7site;
	}
	public void setFire7site(String fire7site) {
		this.fire7site = fire7site;
	}
	public String saveInvoiceAction()throws ParseException, SQLException{



		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		String searchtrno=getSearchtrno();

		int val=0;
		Double taxamt=0.0,taxtot=0.0;
		String nontax="0";
		ClsProjectInvoiceDAO DAO=new ClsProjectInvoiceDAO();

		if(mode.equals("A")){

			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();

			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("inv"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				invarray.add(temp2);

			}
			for(int i=0;i<getExpgridlength();i++){
				String temp2=requestParams.get("exp"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				exparray.add(temp2);

			}
			if(getTxtlegalamt().equalsIgnoreCase("") || getTxtlegalamt().equalsIgnoreCase("undefined")){
				setTxtlegalamt("0");
			}
			double nettotal=Double.parseDouble(getTxtseramt())+Double.parseDouble(getTxtlegalamt())+Double.parseDouble(getTxtexptotal());
			
			taxlist=DAO.getTax(session,nettotal,date,"0",getClientid());
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				//System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}

			
			val=DAO.insert(date,getRefno(),getContypeval(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),"0",getPdid(),getTxtnotes(),getPtype(),taxtot,taxlist,nontax);
			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setMaintrno(val);
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				proinvBean=(ClsProjectInvoiceBean)request.getAttribute("proinvBean");   
				if(proinvBean!=null){
				if(!proinvBean.getValidmsg().equals("") && proinvBean.getValidmsg()!=null) {
					setMsg(proinvBean.getValidmsg());
					setChkstatus("1"); 
				}else {
				setMsg("Not Saved");
				}
				}else {
	                setMsg("Not Saved");
	                }
				return "fail";


			}

		}

		else if(mode.equalsIgnoreCase("E")){
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();

			for(int i=0;i<getInvgridlength();i++){
				String temp2=requestParams.get("inv"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				invarray.add(temp2);

			}
			for(int i=0;i<getExpgridlength();i++){
				String temp2=requestParams.get("exp"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				exparray.add(temp2);

			}
			
			double nettotal=Double.parseDouble(getTxtseramt())+Double.parseDouble(getTxtlegalamt())+Double.parseDouble(getTxtexptotal());
			
			taxlist=DAO.getTax(session,nettotal,date,"0",getClientid());
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				//System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}


			val=DAO.edit(getMaintrno(),getDocno(),date,getRefno(),getContypeval(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),"0",getPdid(),getTxtnotes(),getPtype(),taxtot,taxlist);



			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivreturned(getTxtpjivreturned());
				setMsg("Updated Successfully");
				return "success";
			}
			else{

				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivreturned(getTxtpjivreturned());
				proinvBean=(ClsProjectInvoiceBean)request.getAttribute("proinvBean");   
				if(proinvBean!=null){
				if(!proinvBean.getValidmsg().equals("") && proinvBean.getValidmsg()!=null) {
					setMsg(proinvBean.getValidmsg());
					setChkstatus("2"); 
				}else {
				setMsg("Not Updated");
				}
				}else {
	                setMsg("Not Updated");
	                }
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("D")){
			java.sql.Date date=com.changeStringtoSqlDate(getDate());

			ArrayList<String> invarray= new ArrayList<>();
			ArrayList<String> exparray= new ArrayList<>();
			ArrayList taxlist=new ArrayList();
			
			
			
			taxlist=DAO.getTax(session,Double.parseDouble(getTxtnettotal()),date,"0",getClientid());
			
			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

//				System.out.println("==tmp===="+tmp.length);

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;
				//netotal=netotal;
			}


			val=DAO.delete(getMaintrno(),getDocno(),date,getRefno(),getContypeval(),getTxtcontract(),getTxtclient(),getTxtclientdet(),getDesc(),getBrchName(),getClacno(),getClientid(),
					getCostid(),invarray,exparray,session,getMode(),getFormdetailcode(),request,getTxtlegalamt(),getTxtseramt(),getTxtexptotal(),"0",getPdid(),getTxtnotes(),getPtype(),taxtot,taxlist);



			if(val>0){

				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivreturned(getTxtpjivreturned());
				setDeleted("DELETED");
				setMsg("Deleted Successfully");
				return "success";
			}
			else{
				setMaintrno(val);
				setDocno(Integer.parseInt(request.getAttribute("docno").toString()));
				setDate(date+"");
				setRefno(getRefno());
				setContypeval(getContypeval());
				setTxtcontract(getTxtcontract());
				setTxtclient(getTxtclient());
				setTxtclientdet(getTxtclientdet());
				setDesc(getDesc());
				setTxtnotes(getTxtnotes());
				setClacno(getClacno());
				setClientid(getClientid());
				setCostid(getCostid());
				setPdid(getPdid());
				setPtype(getPtype());
				setTxtpjivreturned(getTxtpjivreturned());
				setMsg("Not Deleted");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("view")){
			proinvBean=proinvDAO.getViewDetails(session,getMaintrno(),getBrchName());

			setDocno(proinvBean.getDocno());
			setDate(proinvBean.getDate());
			setRefno(proinvBean.getRefno());
			setTxtclient(proinvBean.getTxtclient());
			setTxtclientdet(proinvBean.getTxtclientdet());
			setContypeval(proinvBean.getCmbcontracttype());
			setDesc(proinvBean.getDesc());
			setTxtcontract(proinvBean.getTxtcontract());
			setMaintrno(proinvBean.getMaintrno());
			setClientid(proinvBean.getClientid());
			setClacno(proinvBean.getClacno());
			setCostid(proinvBean.getCostid());
			setPdid(proinvBean.getPdid());
			setTxtnettotal(proinvBean.getTxtnettotal());
			setTxtlegalamt(proinvBean.getTxtlegalamt());
			setTxtseramt(proinvBean.getTxtseramt());
			setTxtexptotal(proinvBean.getTxtexptotal());
			setTxtnotes(proinvBean.getTxtnotes());
			setTxtrefdetails(proinvBean.getTxtrefdetails());
			setTxtpjivreturned(proinvBean.getTxtpjivreturned());
			
			return "success";
		}

		return "fail";

	}	
	public String printAction() throws ParseException, SQLException{
		DecimalFormat dfs=new DecimalFormat("###,###.00");
        System.out.println("In Action");	
        
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsProjectInvoiceBean bean = new ClsProjectInvoiceBean();
		ClsProjectInvoiceDAO DAO= new  ClsProjectInvoiceDAO();
		 ClsConnection objconn=new ClsConnection();	
			Connection conn = objconn.getMyConnection(); 
		java.sql.Statement stmt =  conn.createStatement();
		String freq= request.getParameter("freq").toString();
		String dtype=request.getParameter("dtype").toString();
		String type=request.getParameter("type")==null?"0":request.getParameter("type");
		String cmbfreq=request.getParameter("cmbfreq")==null?"0":request.getParameter("cmbfreq");
		String unitP="1";
		
  if(!freq.equalsIgnoreCase(""))		
  {
	unitP=freq;  
  }	
  
 		//System.out.println("unit value"+unitP);
		String headerstat=request.getParameter("header_stat")==null?"0":request.getParameter("header_stat");
		setUrl(com.getPrintPath(dtype));
	//	System.out.println("==="+com.getPrintPath(dtype));
	
		String allbranch=request.getParameter("allbranch")==null?"0":request.getParameter("allbranch");
		String hidheader=request.getParameter("hidheader")==null?"0":request.getParameter("hidheader");
		String docno=request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid").toString();
		String trno=request.getParameter("trno").toString();
		String header=request.getParameter("header")==null?"0":request.getParameter("header").toString();
		String bankdocno=request.getParameter("bankdocno").toString();
		Statement stmtnw = conn.createStatement ();
		String tstimg="",invnum="",duedate="";
		String c= "select coalesce(imgpath,'')imgpath from my_brch where doc_no="+brhid+"";
		String invoicenum="select concat ('FS-INV-',(SELECT SUBSTRING(year(curdate()), 3, 2)),'-',"+docno+") concat" ;
		System.out.println("brhid==="+invoicenum);
		 ResultSet rsinv=stmtnw.executeQuery(invoicenum);
         while(rsinv.next()){
        	invnum=rsinv.getString("concat");
         }
		 ResultSet rsq=stmtnw.executeQuery(c);
         while(rsq.next()){
        	 tstimg=rsq.getString("imgpath");
         }
         String duedte="select m.date ,ac.period2,date_format(date_add(m.date,interval ac.period2 day),'%d-%b-%Y') date1 from my_servm m left join my_acbook ac on ac.acno=m.acno and ac.dtype='crm' where m.tr_no='"+trno+"'";
         ResultSet rsduedte=stmtnw.executeQuery(duedte);
         while(rsduedte.next()){
        	duedate=rsduedte.getString("date1");
         }
        System.out.println(" header ="+request.getParameter("header"));
		
 		System.out.println("trno ="+trno);
		bean=DAO.printMaster(session,docno,brhid,trno,dtype);

		setTxtheader(header);
        setFstotvat(bean.getFstotvat());
        setFsinvoicevat(bean.getFsinvoicevat());
        setFsbalancevat(bean.getFsbalancevat());
		setPreparedby(bean.getPreparedby());  
		setMasterdoc_no(bean.getMasterdoc_no());
		setDocno(bean.getDocno());
		setDate(bean.getDate());
		setHiddate(bean.getDate());
		setClientid(bean.getClientid());
		setTxtclient(bean.getTxtclient());
		setTxtclientdet(bean.getTxtclientdet());
		setLblcltrnno(bean.getLblcltrnno());
		setTxtmob(bean.getTxtmob());
		setTxtemail(bean.getTxtemail());
		setTxttel(bean.getTxttel());
		setCpersonid(bean.getCpersonid());
		setRefno(bean.getRefno());
		setList(bean.getList());
		setTxtcontract(bean.getDocno());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setAmountwords(bean.getAmountwords());
		setLblcompname(bean.getLblcompname());
		setLblcheckedby(session.getAttribute("USERNAME").toString().trim());
		setLblfinaldate(bean.getLblfinaldate());
		setLblbranch(bean.getLblbranch());
		setLblcompaddress(bean.getLblcompaddress());
		setLblcompfax(bean.getLblcompfax());
		setLblcomptel(bean.getLblcomptel());
		setLbllocation(bean.getLbllocation());
		setLblcompname(bean.getLblcompname());
		setLblbranchtrno(bean.getLblbranchtrno());
		setLblfinaldate(bean.getLblfinaldate());
		setTxtjobrefno(bean.getTxtjobrefno());
		setCltelno(bean.getCltelno());
		setComtel(bean.getComtel());
		setComfax(bean.getComfax());
		setComemail(bean.getComemail());
		setAitsamountwrds(bean.getAitsamountwrds());
		setAmtwordsfire7(bean.getAmtwordsfire7());
	setDiscount(bean.getDiscount());
		setLblnetamount(bean.getLblnetamount());
		setLblnetamountword(bean.getLblnetamountword());
		setLblprintname("TAX INVOICE");
		setContypeval(bean.getCmbcontracttype());
		ArrayList sitelist=bean.getSitelist();
		ArrayList serlist=bean.getSerlist();
		ArrayList termlist=bean.getTermlist();
		ArrayList paylList=bean.getPaylist();
		ArrayList list=bean.getList();
//		System.out.println("==sitelist.size====="+sitelist.size());

		setSitelist(sitelist);
		setSerlist(serlist);
		setTermlist(termlist);
		setPaylist(paylList);
		setList(list);

		request.setAttribute("SITELIST", sitelist);
		request.setAttribute("SERLIST", serlist);
		request.setAttribute("TERMLIST", termlist);
		request.setAttribute("PAYLIST", paylList);
		request.setAttribute("LIST", list);
		 String amountwords="";
		String branchval=brhid;
if(brhid.equalsIgnoreCase("2"))
{
	branchval="2";
}
else if(brhid.equalsIgnoreCase("3"))
{
	branchval="3";
}
 else if(brhid.equalsIgnoreCase("1"))
{
	branchval="1";
}
 else
 {
	 
 }
	//	jasperHVLPrintAction();
 		System.out.println("getPrintPath(dtype)="+com.getPrintPath(dtype));
		if(com.getPrintPath(dtype).contains(".jrxml")==true)
		{
			 HttpServletResponse response = ServletActionContext.getResponse();
	
			   //Connection conn = null;
			 try {
				  
					String id=request.getParameter("id")==null?"0":request.getParameter("id");
				
					 param = new HashMap();
					
			                conn = conobj.getMyConnection();
			            param.put("printname", "SALES INVOICE");
				          String contractpay="select @id:=@id+1 as srno,a.* from(select  round(amount,2) as amount, "
				          		+ " IF(description IS NULL or description = '', '     ', description) description"
				          		+ " from cm_srvcontrpd  where tr_no="+bean.getConttrno()+") a,(select @id:=0) r";
				          param.put("contractpayment",contractpay);
 				    //   System.out.println("contractpay===="+contractpay);
				          
				          Statement statemnt = conn.createStatement ();
				          
				            String annualmaintainquery="select  m.description  as descp,'1' as qty, "
				                  + " round(atotal,2) as unitprice, round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) as total,CONCAT (round(coalesce(tax.per,0),2),' %') taxper,"
				            	  + "round(coalesce(tax.amount,0),2) taxamount,(round(atotal,2)+round(m.legalchrg,2)+round(coalesce(tax.amount,0),2)) as nettotal from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no "
				                  + "where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" union all select 'Civil Defence Contract Charges' as descp,  '1' as qty,round(legalchrg,2) as unitprice,"
				                  + "round(legalchrg,2) as legalchrg,(round(atotal,2)+round(legalchrg,2)) as total,CONCAT (round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount,"
				                  + "(round(atotal,2)+round(m.legalchrg,2)+round(coalesce(tax.amount,0),2)) as nettotal from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no where m.status=3 "
				                  + "and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" union all select 'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice, round(etotal,2) as atotal, "
				                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total,CONCAT (round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount,(round(atotal,2)+round(m.legalchrg,2)+round(coalesce(tax.amount,0),2)) as nettotal "
				                  + "from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no where m.status=3 and etotal>0.0000 and m.brhid="+brhid+" and m.tr_no="+trno+" ";
				           
				        //    System.out.println("griddd"+annualmaintainquery);
				            
				           ResultSet amt=statemnt.executeQuery(annualmaintainquery);
				            while(amt.next()){
				            	amountwords=(amt.getString("nettotal"));
				            }
				          
				            
//				           System.out.println("...amountwrds..."+amountwords);
				            // for fire 7 LLC
				            String itemqry="", itemqry2="";
				            
				           // System.out.println("Job : "+bean.getTxtdtype().toString());
				           // System.out.println("Frequence : "+freq);
				            if(bean.getTxtdtype().equalsIgnoreCase("SJOB" ) && freq.equalsIgnoreCase("2"))
				            {
				            	/*itemqry=itemqry+" UNION ALL select coalesce(cd.description,'') descp,coalesce(round(qty),'') qty,round(cd.amount,2) unitprice,CONCAT (round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount,round(cd.total,2) atotal,round(round(cd.total,2)+(round(cd.total,2)*0.05),2) tot,(round(atotal,2)+round(legalchrg,2)) total,round(round(cd.total,2)*0.05,2) taxamt "
					             		+ " from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no left join cm_srvcontrd cd on cd.tr_no=m.costid  where m.tr_no="+trno+" ";
				            	*/
                               //	commented above query and added taxableamt value for print on 2024-09-11
				            	
				            	itemqry=itemqry+" UNION ALL select round(coalesce(round(qty),0)*round(cd.amount,2),2)taxableamt,coalesce(cd.description,'') descp,coalesce(round(qty),'') qty,round(cd.amount,2) unitprice,CONCAT (round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount,round(cd.total,2) atotal,round(round(cd.total,2)+(round(cd.total,2)*0.05),2) tot,(round(atotal,2)+round(legalchrg,2)) total,round(round(cd.total,2)*0.05,2) taxamt "
					             		+ " from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no left join cm_srvcontrd cd on cd.tr_no=m.costid  where m.tr_no="+trno+" ";
				            
				            	
				            	
				            	itemqry2=itemqry2+" UNION ALL select u.unit,coalesce(d.description,'') descp,coalesce(round(d.qty),'') qty,round(d.amount,2) unitprice,round(d.total,2) atotal,round(q.amount,2) total,s.tr_no "
					             		+ " from my_servm m  left join cm_srvcontrm s on s.costid=m.costid and s.dtype=if(m.costtype=3,'amc','sjob') left join cm_srvqotm q on s.ref_type=q.dtype and s.reftrno=q.tr_no"
					             		+ "  left join cm_srvqotd d on d.tr_no=q.tr_no left join my_unitm u on(u.doc_no=d.unitid) where m.tr_no="+trno+" ";
				              }
				            
				            String itemmblqry="", itemmblqry2="";   
				            if(bean.getTxtdtype().equalsIgnoreCase("AMC" ))
				            {
				            	itemmblqry=itemmblqry+" select  if(m.ref_type='AMC',concat('Annual Maintenance of Fire Protection System - ',description),"
					            		+ "if(m.ref_type='SJOB',concat('Fire Protection System - ',description),description))  as descp,'1' as qty, "
						                  + " round(atotal,2) as unitprice, round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) "
						                  + "as total from my_servm m where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" union all ";
				            	itemmblqry2=itemmblqry2+" select  '' unit,if(m.ref_type='AMC',concat('Annual Maintenance of Stone Restoration Services - ',description),"
					            		+ "if(m.ref_type='SJOB',concat('Stone Restoration Services - ',description),description))  as descp,'1' as qty, "
						                  + " round(atotal,2) as unitprice, round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) "
						                  + "as total,0 tr_no from my_servm m where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" union all ";
				             
				              }
				            
				            String cmnqry="select  if(m.ref_type='AMC',concat('Annual Maintenance of Fire Protection System - ',description),"
					            		+ "if(m.ref_type='SJOB',concat('Fire Protection System - ',description),description))  as descp,'1' as qty, "
						                  + " round(atotal,2) as unitprice, round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) "
						                  + "as total from my_servm m where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" "
						                  + "union all select 'Civil Defence Contract Charges' as descp,  '1' as qty,"
						                  + " round(legalchrg,2) as unitprice,round(legalchrg,2) as legalchrg,"
						                  + "(round(atotal,2)+round(legalchrg,2)) as total from my_servm m where m.status=3 "
						                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
						                  + " union all select 'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice, round(etotal,2) as atotal, "
						                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total from my_servm m where m.status=3 and etotal>0.0000 "
						                  + " and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry+" ";
				            // System.out.println("cmnqry without unitprice--"+cmnqry);
				            
				            
				         /*   String cmnqry1="  select @i:=@i+1 srno,a.* from (select 'Civil Defence Contract Charges' as descp,  '1' as qty,"
					                  + " round(legalchrg,2) as unitprice,CONCAT(round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount,round(legalchrg,2) as atotal,round(round(legalchrg,2)*0.05+(round(legalchrg,2)),2) tot,"
					                  + "(round(atotal,2)+round(legalchrg,2)) as total,round(round(legalchrg,2)*0.05,2) taxamt from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no where m.status=3 "
					                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
					                  + " union all select 'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice,CONCAT (round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount, round(etotal,2) as atotal, round((round(etotal,2)*0.05)+(round(etotal,2)),2) tot, "
					                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total,round(round(etotal,2)*0.05,2) taxamt from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no  where m.status=3 and etotal>0.0000 "
					                  + " and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry+" ) a,(select @i:=0) r";
				       */
				            
				            
                    //	commented above query and added taxableamt value for print on 2024-09-11
					        
				            String cmnqry1="  select @i:=@i+1 srno,a.* from (select round(round(coalesce(legalchrg,0),2)*1) taxableamt,'Civil Defence Contract Charges' as descp,  '1' as qty,"
					                  + " round(legalchrg,2) as unitprice,CONCAT(round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount,round(legalchrg,2) as atotal,round(round(legalchrg,2)*0.05+(round(legalchrg,2)),2) tot,"
					                  + "(round(atotal,2)+round(legalchrg,2)) as total,round(round(legalchrg,2)*0.05,2) taxamt from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no where m.status=3 "
					                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
					                  + " union all select round(round(coalesce(etotal,0),2)*1) taxableamt,'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice,CONCAT (round(coalesce(tax.per,0),2),' %') taxper,round(coalesce(tax.amount,0),2) taxamount, round(etotal,2) as atotal, round((round(etotal,2)*0.05)+(round(etotal,2)),2) tot, "
					                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total,round(round(etotal,2)*0.05,2) taxamt from my_servm m left join my_invtaxdet tax on tax.rdocno=m.tr_no  where m.status=3 and etotal>0.0000 "
					                  + " and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry+"  ) a,(select @i:=0) r";
				            
				            
				          System.out.println("cmnqry1 with unitprice--"+cmnqry1);
				            
				            
				            String mblqry1="select @i:=@i+1 srno,a.* from ("+itemmblqry+" "
			            		+ " select 'Civil Defence Contract Charges' as descp,  '1' as qty,"
				                  + " round(legalchrg,2) as unitprice,round(legalchrg,2) as atotal,"
				                  + "(round(atotal,2)+round(legalchrg,2)) as total from my_servm m where m.status=3 "
				                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
				                  + " union all select 'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice, round(etotal,2) as atotal, "
				                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total from my_servm m where m.status=3 and etotal>0.0000 "
				                  + " and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry+" ) a,(select @i:=0) r";
				           // System.out.println("with unit price mblqr1 : "+mblqry1);
				            
				            String cmnqry2=" select @i:=@i+1 srno,a.* from (select '' unit,'Civil Defence Contract Charges' as descp,  '1' as qty,"
					                  + " round(m.legalchrg,2) as unitprice,round(m.legalchrg,2) as atotal,"
					                  + "(round(atotal,2)+round(m.legalchrg,2)) as total,s.tr_no from my_servm m left join cm_srvcontrm s on s.costid=m.costid and s.dtype=if(m.costtype=3,'amc','sjob') \r\n" + 
					                  "  where m.status=3 and m.brhid="+brhid+" and m.legalchrg !=0 and m.tr_no="+trno+" "
					                  + " union all select '' unit,'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice, round(etotal,2) as atotal, "
					                  + "  (round(atotal,2)+round(m.legalchrg,2)+round(etotal,2)) as total,s.tr_no from my_servm m left join cm_srvcontrm s on s.costid=m.costid and s.dtype=if(m.costtype=3,'amc','sjob') \r\n" + 
					                  "  where m.status=3 and etotal>0.0000 and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry2+" ) a,(select @i:=0) r ";
				           
				            //System.out.println("cmnqry1=="+cmnqry1);
				           //System.out.println("cmnqry2=="+cmnqry2);
				            String mblqry="select @i:=@i+1 srno,a.* from (select  if(m.ref_type='AMC',concat('Annual Maintenance of Stone Restoration Services - ',description),"
				            		+ "if(m.ref_type='SJOB',concat('Stone Restoration Services - ',description),description))  as descp,'1' as qty, "
					                  + " round(atotal,2) as unitprice, round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) "
					                  + "as total from my_servm m where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" "
					                  + "union all select 'Civil Defence Contract Charges' as descp,  '1' as qty,"
					                  + " round(legalchrg,2) as unitprice,round(legalchrg,2) as legalchrg,"
					                  + "(round(atotal,2)+round(legalchrg,2)) as total from my_servm m where m.status=3 "
					                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
					                  + " union all select 'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice, round(etotal,2) as atotal, "
					                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total from my_servm m where m.status=3 and etotal>0.0000 "
					                  + " and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry+" ) a,(select @i:=0) r";
				           
				            
				            String mblqry2=" select @i:=@i+1 srno,a.* from ("+itemmblqry2+" "
				            		+ " select '' unit,'Civil Defence Contract Charges' as descp,  '1' as qty,"
					                  + " round(m.legalchrg,2) as unitprice,round(m.legalchrg,2) as atotal,"
					                  + "(round(atotal,2)+round(m.legalchrg,2)) as total,s.tr_no from my_servm m left join cm_srvcontrm s on s.costid=m.costid and s.dtype=if(m.costtype=3,'amc','sjob') \r\n" + 
					                  "  where m.status=3 and m.brhid="+brhid+" and m.legalchrg !=0 and m.tr_no="+trno+" "
					                  + " union all select '' unit,'Other Charges'  as descp,'1' as qty,  round(etotal,2) as unitprice, round(etotal,2) as atotal, "
					                  + "  (round(atotal,2)+round(m.legalchrg,2)+round(etotal,2)) as total,s.tr_no from my_servm m left join cm_srvcontrm s on s.costid=m.costid and s.dtype=if(m.costtype=3,'amc','sjob') \r\n" + 
					                  "  where m.status=3 and etotal>0.0000 and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry2+" ) a,(select @i:=0) r ";
				            	//System.out.println("mblqry=="+mblqry2);
					        //    System.out.println("firstquery1=="+cmnqry);
				           //System.out.println("firstquery2=="+cmnqry2);
				           /* if(unitP.equalsIgnoreCase("2"))
				            {
				            	cmnqry="select  if(m.ref_type='AMC',concat('Annual Maintenance of Fire Protection System - ',description),"
				            		+ "if(m.ref_type='SJOB',concat('Fire Protection System - ',description),description))  as descp,'1' as qty, "
					                  + "  round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) "
					                  + "as total from my_servm m where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" "
					                  + "union all select 'Civil Defence Contract Charges' as descp,  '1' as qty,"
					                  + " round(legalchrg,2) as legalchrg,"
					                  + "(round(atotal,2)+round(legalchrg,2)) as total from my_servm m where m.status=3 "
					                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
					                  + " union all select 'Other Charges'  as descp,'1' as qty, round(etotal,2) as atotal, "
					                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total from my_servm m where m.status=3 and etotal>0.0000 "
					                  + " and m.brhid="+brhid+" and m.tr_no="+trno+" "+itemqry+" ";
				            	
				            }*/
					            String emiratesannualmaintainquery="select @i:=@i+1 srno,a.* from(select  if(m.ref_type='AMC',concat('Annual Maintenance of Fire Protection System - ',description),"
					            		+ "if(m.ref_type='SJOB',concat('Fire Protection System - ',description),description))  as descp,'1' as qty, "
						                  + " round(atotal,2) as atotal,(round(atotal,2)+round(legalchrg,2)) "
						                  + "as total from my_servm m where m.status=3  and m.brhid="+brhid+" and m.tr_no="+trno+" "
						                  + "union all select 'Civil Defence Contract Charges' as descp,  '1' as qty,"
						                  + " round(legalchrg,2) as legalchrg,"
						                  + "(round(atotal,2)+round(legalchrg,2)) as total from my_servm m where m.status=3 "
						                  + " and m.brhid="+brhid+" and legalchrg !=0 and m.tr_no="+trno+" "
						                  + " union all select 'Other Charges'  as descp,'1' as qty,  round(etotal,2) as atotal, "
						                  + "  (round(atotal,2)+round(legalchrg,2)+round(etotal,2)) as total from my_servm m where m.status=3 and etotal>0.0000 "
						                  + " and m.brhid="+brhid+" and m.tr_no="+trno+")a,(select @i:=0)r"; 
				          // System.out.println("emiratesannualmaintainquery---"+emiratesannualmaintainquery);
                          //   System.out.println("cmnqry1------"+cmnqry1);
				           param.put("fire7querywithout", cmnqry); 
				           param.put("fire7query",cmnqry1);
				           param.put("fire7query2",cmnqry2);
				           param.put("mblquerywithout", mblqry); 
				           param.put("mblquerywith", mblqry2); 
				           param.put("mblquerywith1", mblqry1); 
				           param.put("unitprice", cmbfreq);
				           //param.put("fire7querywithoutfs", cmnqry1); 
				          // param.put("fire7queryfs",cmnqry);
				          param.put("annualmaintainquery",annualmaintainquery);
				         
				          param.put("emiratesqry", emiratesannualmaintainquery);
				          
				          ClsAmountToWords ClsAmountToWord=new ClsAmountToWords();
					         String amountinwords=ClsAmountToWord.convertAmountToWords(amountwords.toString());
					      //   System.out.println("cmbfreq--"+cmbfreq);
				         
				         
//			         System.out.println("annualmaintainquery===="+annualmaintainquery);
			         
//			         System.out.println("fire7annualmaintainquery===="+fire7annualmaintainquery);
				         param.put("unitP",unitP);
				       //  System.out.println("UNITP--"+unitP);
				         param.put("txtclient", bean.getTxtclient());		         
				         param.put("clientdeta",bean.getTxtclientdet());
				         param.put("comtel",bean.getComtel());
				         param.put("comfax",bean.getComfax());
				         param.put("comemail",bean.getComemail());
				         param.put("txtmob", bean.getTxtmob());
				         param.put("telno", bean.getCltelno());
					     param.put("pertelno", bean.getCltelno());
					     param.put("clienttrno", bean.getTinno());
				         param.put("compnytrno", bean.getCompanytrno());
				         param.put("compnytinno", bean.getCompanytinno());
				         param.put("email", bean.getTxtemail());
				         param.put("date", bean.getDate());
				         param.put("date1", duedate);
				         param.put("contractnum",bean.getRefdocno());
				         param.put("from",bean.getFrom());
				         param.put("to",bean.getTo());
				         param.put("invono", docno);
				         param.put("refno", bean.getRefno());
				         param.put("refnum", bean.getRefno());
				         param.put("jobrefno", bean.getTxtjobrefno());
				         param.put("jobrefnum", bean.getTxtjobrefno());
				         param.put("cperson", bean.getCperson());
				         param.put("branchval",branchval);
				         System.out.println("branchval" +branchval);
				        
//				         System.out.println("ooooooooooooooooooooo"+bean.getCperson());
				         param.put("description", bean.getDesc());
				         param.put("notes",bean.getTxtnotes());
				         param.put("amountwrds", amountinwords);
//				         System.out.println("===param=="+amountinwords);

					      param.put("fire7srno1", bean.getFire7srno());
				         param.put("fire7mxrno1", bean.getFire7mxrno());
				         param.put("fire7total1", bean.getFire7total());
				         param.put("fire7invoice1", bean.getFire7invamt());
				         param.put("fstotvat", bean.getFstotvat());
				         param.put("fsinvono",invnum);
				         param.put("fsinvoicevat",bean.getFsinvoicevat());
				         param.put("fsbalancevat",bean.getFsbalancevat());
				         param.put("fire7total", Double.parseDouble(bean.getFire7total()));
				         param.put("fire7invoice", Double.parseDouble(bean.getFire7invamt()));
				         param.put("fire7balance", Double.parseDouble(bean.getFire7balance()));
				         param.put("fire7balance1", bean.getFire7balance());
				         param.put("amntwords", bean.getAmtwordsfire7());
				         
				         param.put("srno1", bean.getMxrnomin());
				         param.put("mxrno1", bean.getMxrnomax());
				         param.put("total1", bean.getTotal1());
				         param.put("invoice1", bean.getInvoived());
				         param.put("balance1", bean.getBalance());
				         param.put("printby", session.getAttribute("USERNAME"));
				         param.put("preparedBy", bean.getPreparedby()); 
				         param.put("preparedon", bean.getPreparedOn());
						   param.put("approvedby", bean.getApprovedBy());
						   param.put("approvedon", bean.getApprovedOn());
						   param.put("verifiedby", bean.getVerifiedBy());		         
						   param.put("verifiedon", bean.getVerifiedOn());
					  //fire7 site
				         param.put("sitedet",bean.getFire7site());
				         param.put("sitedetail",bean.getFire7site());
				         param.put("sitedetnw",bean.getFire7sitenw());
//				         System.out.println("==== "+bean.getTxtnotes());
				         /*param.put("notes",bean.getTxtnotes());*/
				         
				         param.put("dtype",bean.getTxtdtype());
				         param.put("compname",bean.getLblcompname());
				        String value=String.valueOf(dfs.format(Double.parseDouble(bean.getNettotal().replace(",",""))-Double.parseDouble(bean.getTaxamount().replace(",",""))));
			            String nettot=String.valueOf(dfs.format(bean.getNettotal()==null || bean.getNettotal().equals("")?"0":Double.parseDouble(bean.getNettotal().replace(",",""))));
				         param.put("totalamount",value);
					     param.put("taxamount",bean.getTaxamount());
				         param.put("taxper", bean.getTaxpercent());
				        // param.put("nettotal",bean.getNettotal());
				         //System.out.println("discount==="+getDiscount());
				         String mbldiscount=String.valueOf(dfs.format(bean.getDiscount()==null || bean.getDiscount().equals("")?"0":Double.parseDouble(bean.getDiscount().replace(",",""))));
				         param.put("nettotal", nettot);
				       //  System.out.println("discount==="+mbldiscount);
				         param.put("discount",mbldiscount);
				         String mblnetamt=String.valueOf(dfs.format(bean.getLblnetamount()==null || bean.getLblnetamount().equals("")?"0":Double.parseDouble(bean.getLblnetamount().replace(",",""))));
				         param.put("mblnetamount",mblnetamt);   
				         param.put("mblnetwords",bean.getLblnetamountword());
				        // Statement stmt = conn.createStatement ();
					     //String netamtqry="select if(cm.inctax=0,round(m.netamount+m.taxamt,2),round(m.netamount,2)) netamount from my_servm m left join cm_srvcontrm cm on m.costid=cm.tr_no where m.tr_no="+trno+"";
				         String netamtqry="select round(netamount,2) netamount from my_servm  where tr_no="+trno+"";   
				              
				         String taxqry="select @i:=@i+1 srno,a.* from (select if(m.ref_type='AMC',(select group_concat( distinct groupname) stype from cm_srvcontrd d left join my_groupvals g on "
		            		    + "(d.servid=g.doc_no and grptype='service') where tr_no=(select cm.tr_no from my_servm m left join cm_srvcontrm cm on m.costid=cm.tr_no where m.tr_no="+trno+")),"
		            		    + "if(m.ref_type='SAMC',(select group_concat( distinct coalesce(gs.groupname,'')) service from cm_servplan p left join my_servm m on m.costid=p.doc_no left join "
		            		    + "my_groupvals gs on (gs.doc_no=p.servid and gs.grptype='service') where m.tr_no="+trno+"),m.description)) as particular,'' as qty,'' as rate,'' as per, "
				                + " round((m.atotal+m.legalchrg+m.etotal),2) as Amt from my_servm m "
				                + "left join cm_srvcontrm cm on m.costid=cm.tr_no where m.tr_no="+trno+" "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select '' as particular ,'' as qty,'' as rate,'' as per,'' as Amt  "
				                + "union all select concat('                          ',tsm.tax_name,' @ ',round(td.per,2),'%')as particular,"
				                + "'' as qty,'' as rate,'' as per,round(td.amount,2) as Amt  from my_servm sm "
				                + "left join my_invtaxdet td on sm.tr_no=td.rdocno "
				                + "left join gl_taxsubmaster tsm on td.taxid=tsm.doc_no where sm.tr_no="+trno+" ) a,(select @i:=0)r";

				             //System.out.println("===taxqry=="+taxqry);
				          // System.out.println("===getTel2=="+bean.getTel2()+"ha");
				          // System.out.println("===getBrch_tel=="+bean.getBrch_tel()+"ha");
				         ResultSet  taxrs1=stmt.executeQuery(netamtqry);
				         String netamt="";
				       while(taxrs1.next()){
				        netamt=taxrs1.getString("netamount");
				       }
//				       System.out.println(netamtqry+"==="+netamt);  
				         ClsAmountToWords ClsAmountToWords=new ClsAmountToWords();
				         String amuntwrd=ClsAmountToWords.convertAmountToWords(netamt.toString()).replaceFirst("RS "," ");
//				         System.out.println("amuntwrd==="+amuntwrd);    
							DecimalFormat df = new DecimalFormat("#.00"); 
							
							String taxqryhvl="select @i:=@i+1 srno,a.* from (select if(m.ref_type='AMC',(select group_concat( distinct groupname) stype from cm_srvcontrd d left join my_groupvals g on "
			            		    + "(d.servid=g.doc_no and grptype='service') where tr_no=(select cm.tr_no from my_servm m left join cm_srvcontrm cm on m.costid=cm.tr_no where m.tr_no="+trno+")),"
			            		    + "if(m.ref_type='SAMC',(select group_concat( distinct coalesce(gs.groupname,'')) service from cm_servplan p left join my_servm m on m.costid=p.doc_no left join "
			            		    + "my_groupvals gs on (gs.doc_no=p.servid and gs.grptype='service') where m.tr_no="+trno+"),m.description)) as particular,'' as qty,'' as rate,'' as per, "
					                + " round((m.atotal+m.legalchrg+m.etotal),2) as Amt from my_servm m "
					                + "left join cm_srvcontrm cm on m.costid=cm.tr_no where m.tr_no="+trno+" "
					                + "union all select concat('                          ',tsm.tax_name,' @ ',round(td.per,2),'%')as particular,"
					                + "'' as qty,'' as rate,'' as per,round(td.amount,2) as Amt  from my_servm sm "
					                + "left join my_invtaxdet td on sm.tr_no=td.rdocno "
					                + "left join gl_taxsubmaster tsm on td.taxid=tsm.doc_no where sm.tr_no="+trno+" ) a,(select @i:=0)r";

							param.put("compaddress", bean.getLblcompanyaddress());
							param.put("amntword", amuntwrd);
							param.put("netAmount",netamt);	/*df.format(netamt)+""*/
							param.put("taxqry", taxqry);
							param.put("taxqryhvl", taxqryhvl);
							param.put("customer", bean.getTxtclient());		         
							param.put("address",bean.getTxtclientdet());
							param.put("site", bean.getSite());
							param.put("invodate", bean.getDate());
							param.put("vatstatus", bean.getInclusivestat());
							param.put("tinno", bean.getTinno());
							//param.put("remark", bean.getDesc());
							param.put("invonohvl",bean.getInvono());
							param.put("remark",bean.getTxtnotes());
							param.put("brch_name", bean.getBrch_name());
							param.put("brch_address", bean.getBrch_address());
							param.put("brch_pbno", bean.getBrch_pbno());
							param.put("brch_tel", bean.getBrch_tel());
							param.put("brch_email", bean.getBrch_email());
							param.put("compytrno",bean.getCompanytrno());
							param.put("trno",trno);
							param.put("amtwords", bean.getStaramuntword());
							param.put("costid",bean.getCostid());
//							System.out.println("headerstat ="+headerstat);
							param.put("header_stat",Integer.parseInt(headerstat));
							String proinv="";
							param.put("docno", docno);
							
							String strSql = "select (select concat('MAX','/',Substring(EXTRACT(YEAR FROM curdate()), 3),'/',"+docno+"))chkinvno,method from gl_config where field_nme='srvcProjectInvoicePrintWindow'";
							//System.out.println("strSql"+strSql); 
							ResultSet rs = stmt.executeQuery(strSql);
							
							String method="";
							while(rs.next()) {
								method=rs.getString("method");
								proinv=rs.getString("chkinvno");
							} 
							param.put("chkinvno", proinv);
							if(method.equalsIgnoreCase("1")){
								
								String strSql1 = "select name,address,beneficiary,account,ibanno,swiftcode from cm_bankdetails where status=3 and doc_no="+bankdocno+"";
								ResultSet rs1 = stmt.executeQuery(strSql1);
								
								String bankname="",bankaddress="",bankbeneficiary="",bankaccount="",bankibanno="",bankswiftcode="";
								while(rs1.next()) {
									bankname=rs1.getString("name");
									bankaddress=rs1.getString("address");
									bankbeneficiary=rs1.getString("beneficiary");
									bankaccount=rs1.getString("account");
									bankibanno=rs1.getString("ibanno");
									bankswiftcode=rs1.getString("swiftcode");
								} 
								
								param.put("bankname", bankaddress);
								param.put("bankbeneficiary", bankbeneficiary);
								param.put("bankaccountno", bankaccount);
								param.put("bankibanno", bankibanno);
								param.put("bankswiftcode", bankswiftcode);
								
								String cityheaderpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
								cityheaderpath=cityheaderpath.replace("\\", "\\\\");
								
								String cityfooterpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
								cityfooterpath=cityfooterpath.replace("\\", "\\\\");
								
								param.put("cityheaderpath", cityheaderpath);
								param.put("cityfooterpath", cityfooterpath);
							}

							String imgheader=request.getSession().getServletContext().getRealPath("/icons/emiratesheader.jpg");
							imgheader=imgheader.replace("\\", "\\\\");
							
							String imgfooter=request.getSession().getServletContext().getRealPath("/icons/emiratesfooter.jpg");
							imgfooter=imgfooter.replace("\\", "\\\\");
							String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/imgpsh_fullsize_anim.png");
						     imgpathfooter=imgpathfooter.replace("\\", "\\\\");
							
						    String imgpathfooter2=request.getSession().getServletContext().getRealPath(tstimg);
						     imgpathfooter2=imgpathfooter2.replace("\\", "\\\\");
						     
						     String watermark=request.getSession().getServletContext().getRealPath("/icons/watermark logo1.jpg");
						     watermark=watermark.replace("\\", "\\\\");
			                    param.put("watermark",watermark);
						     String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/quotationheader.png");
					         //String imgpath=request.getSession().getServletContext().getRealPath("/icons/quotationfooter.png");
						     imgpathheader=imgpathheader.replace("\\", "\\\\");
						     String imgpathfooter1=request.getSession().getServletContext().getRealPath("/icons/quotationfooter.png");
						     imgpathfooter1=imgpathfooter1.replace("\\", "\\\\");
						     
						     
							String img=request.getSession().getServletContext().getRealPath("/icons/fire7header1.jpg");
							img=img.replace("\\", "\\\\");
							String imgpath=request.getSession().getServletContext().getRealPath("/icons/headerimg1.jpeg");
						     imgpath=imgpath.replace("\\", "\\\\");
							String rupeeimgpath=request.getSession().getServletContext().getRealPath("/icons/rupee.jpg");
							rupeeimgpath=rupeeimgpath.replace("\\", "\\\\");
							String imgpath1=request.getSession().getServletContext().getRealPath("/icons/watermark logo1.jpg");
			                    imgpath1=imgpath1.replace("\\", "\\\\");
			                    //tstimg=tstimg.replace("\\", "\\\\");
			                    
			            param.put("watermark", imgpath1);
			            param.put("imgpathfooter", imgpathfooter1);
			            param.put("imgpathheader", imgpathheader);
						param.put("rupeeimgpath", rupeeimgpath);
						param.put("imgpath", imgpathfooter2);
						//param.put("headerimg2", headerimg2);
						param.put("imgheader", imgheader);
						param.put("imgfooter", imgfooter);
						//param.put("imgpath", img);
						
						/*String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
						imgpath=imgpath.replace("\\", "\\\\");
					param.put("imgpath", imgpath);
					System.out.println("path -- :"+getUrl());*/
						String printpath="";
						if(type.equals("1")) {
							printpath=com.getPrintPath2(dtype);
						}else {
							printpath=com.getPrintPath(dtype);
						}
						System.out.println("printpath2"+printpath);
			           JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(printpath));
		         	 
		         	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
		                           generateReportPDF(response, param, jasperReport, conn);
		                     
		          conn.close();
		                 } catch (Exception e) {
		  
		                     e.printStackTrace();
		                     conn.close();
		  
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
public String getFire7sitenw() {
	return fire7sitenw;
}
public void setFire7sitenw(String fire7sitenw) {
	this.fire7sitenw = fire7sitenw;
}



}
