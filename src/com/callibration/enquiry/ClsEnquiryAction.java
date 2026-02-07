package com.callibration.enquiry;



import java.io.IOException;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;
import com.callibration.enquiry.ClsEnquiryDAO;
import com.callibration.enquiry.ClsEnquiryBean;

@SuppressWarnings("serial")
public class ClsEnquiryAction extends ActionSupport{
	ClsEnquiryDAO EnquiryDAO= new ClsEnquiryDAO(); 
	ClsCommon com=new ClsCommon();
	ClsEnquiryBean pintbean= new ClsEnquiryBean(); 
	private int docno;


	private String EnquiryDate;
	private String hidEnquiryDate;
	private String cmbclient;
	private String txtclientname;
	private int genaral;
	private int client;
	private int amc;
	private int sjob;
	private String cnt;
	private String hidradio;
	private int sourceid,cpersonid;
	private String txtaddress;
	private String txtmobile,txttelno;
	private String txtsource,txtcontact;
	private String txtRemarks;
	private String txtemail;
	private String mode,formdetailcode;
	private int gridval;
	// grid
	private int enqgridlenght;



	// for radio chk
	private int forradiochk;
	//
	private String addvalchange;
	private String remvalchange;

	//
	private String deleted;
	//
	private String enqdtype;

	private String msg;

	private int txtradio,masterdoc_no;
	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}

	//-------------------------------------------------------



	private String lblclient,lblclientaddress,lblmob,lblemail,lbldate,lbltypep;

	private int docvals;

	private String  lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblbranch,lbllocation,lblprintname;

	private String lblcstno,lblservicetax,lblpan;
	private String url;
	//------------------------------------------------

	private int cmbprocess;
	 
	 private int hidcmbprocess;
    
	 private String clbmthdusd,clbprdacpt,clbduedate,dispinst,stmtcnfrm,expdate,hidexpdate,paytrms,modreq,alwinst,adjspec,spclinsts,txtremarks,clbcnfrm,labreq;
	 private String hidclbmthdusd,hidclbprdacpt,hiddispinst,hidstmtcnfrm,hidpaytrms,hidmodreq,hidalwinst,hidadjspec,hidclbcnfrm,hidlabreq;
		public String getHidclbmthdusd() {
		return hidclbmthdusd;
	}
	public void setHidclbmthdusd(String hidclbmthdusd) {
		this.hidclbmthdusd = hidclbmthdusd;
	}
	public String getHidclbprdacpt() {
		return hidclbprdacpt;
	}
	public void setHidclbprdacpt(String hidclbprdacpt) {
		this.hidclbprdacpt = hidclbprdacpt;
	}
	public String getHiddispinst() {
		return hiddispinst;
	}
	public void setHiddispinst(String hiddispinst) {
		this.hiddispinst = hiddispinst;
	}
	public String getHidstmtcnfrm() {
		return hidstmtcnfrm;
	}
	public void setHidstmtcnfrm(String hidstmtcnfrm) {
		this.hidstmtcnfrm = hidstmtcnfrm;
	}
	public String getHidpaytrms() {
		return hidpaytrms;
	}
	public void setHidpaytrms(String hidpaytrms) {
		this.hidpaytrms = hidpaytrms;
	}
	public String getHidmodreq() {
		return hidmodreq;
	}
	public void setHidmodreq(String hidmodreq) {
		this.hidmodreq = hidmodreq;
	}
	public String getHidalwinst() {
		return hidalwinst;
	}
	public void setHidalwinst(String hidalwinst) {
		this.hidalwinst = hidalwinst;
	}
	public String getHidadjspec() {
		return hidadjspec;
	}
	public void setHidadjspec(String hidadjspec) {
		this.hidadjspec = hidadjspec;
	}
	public String getHidclbcnfrm() {
		return hidclbcnfrm;
	}
	public void setHidclbcnfrm(String hidclbcnfrm) {
		this.hidclbcnfrm = hidclbcnfrm;
	}
	public String getHidlabreq() {
		return hidlabreq;
	}
	public void setHidlabreq(String hidlabreq) {
		this.hidlabreq = hidlabreq;
	}
		public int getHidcmbprocess() {
		return hidcmbprocess;
	}
	public String getClbmthdusd() {
			return clbmthdusd;
		}
		public void setClbmthdusd(String clbmthdusd) {
			this.clbmthdusd = clbmthdusd;
		}
		public String getClbprdacpt() {
			return clbprdacpt;
		}
		public void setClbprdacpt(String clbprdacpt) {
			this.clbprdacpt = clbprdacpt;
		}
		public String getClbduedate() {
			return clbduedate;
		}
		public void setClbduedate(String clbduedate) {
			this.clbduedate = clbduedate;
		}
		public String getDispinst() {
			return dispinst;
		}
		public void setDispinst(String dispinst) {
			this.dispinst = dispinst;
		}
		public String getStmtcnfrm() {
			return stmtcnfrm;
		}
		public void setStmtcnfrm(String stmtcnfrm) {
			this.stmtcnfrm = stmtcnfrm;
		}
		public String getExpdate() {
			return expdate;
		}
		public void setExpdate(String expdate) {
			this.expdate = expdate;
		}
		public String getHidexpdate() {
			return hidexpdate;
		}
		public void setHidexpdate(String hidexpdate) {
			this.hidexpdate = hidexpdate;
		}
		public String getPaytrms() {
			return paytrms;
		}
		public void setPaytrms(String paytrms) {
			this.paytrms = paytrms;
		}
		public String getModreq() {
			return modreq;
		}
		public void setModreq(String modreq) {
			this.modreq = modreq;
		}
		public String getAlwinst() {
			return alwinst;
		}
		public void setAlwinst(String alwinst) {
			this.alwinst = alwinst;
		}
		public String getAdjspec() {
			return adjspec;
		}
		public void setAdjspec(String adjspec) {
			this.adjspec = adjspec;
		}
		public String getSpclinsts() {
			return spclinsts;
		}
		public void setSpclinsts(String spclinsts) {
			this.spclinsts = spclinsts;
		}
		public String getTxtremarks() {
			return txtremarks;
		}
		public void setTxtremarks(String txtremarks) {
			this.txtremarks = txtremarks;
		}
		public String getClbcnfrm() {
			return clbcnfrm;
		}
		public void setClbcnfrm(String clbcnfrm) {
			this.clbcnfrm = clbcnfrm;
		}
		public String getLabreq() {
			return labreq;
		}
		public void setLabreq(String labreq) {
			this.labreq = labreq;
		}
	public void setHidcmbprocess(int hidcmbprocess) {
		this.hidcmbprocess = hidcmbprocess;
	}
		public int getCmbprocess() {
		return cmbprocess;
	}
	public void setCmbprocess(int cmbprocess) {
		this.cmbprocess = cmbprocess;
	}


	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	public int getCpersonid() {
		return cpersonid;
	}
	public void setCpersonid(int cpersonid) {
		this.cpersonid = cpersonid;
	}
	public String getTxtcontact() {
		return txtcontact;
	}
	public void setTxtcontact(String txtcontact) {
		this.txtcontact = txtcontact;
	}
	public int getSourceid() {
		return sourceid;
	}
	public void setSourceid(int sourceid) {
		this.sourceid = sourceid;
	}
	public String getTxtsource() {
		return txtsource;
	}
	public void setTxtsource(String txtsource) {
		this.txtsource = txtsource;
	}
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}


	public String getLblclient() {
		return lblclient;
	}

	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public void setLblclient(String lblclient) {
		this.lblclient = lblclient;
	}
	public String getLblclientaddress() {
		return lblclientaddress;
	}
	public void setLblclientaddress(String lblclientaddress) {
		this.lblclientaddress = lblclientaddress;
	}
	public String getLblmob() {
		return lblmob;
	}
	public void setLblmob(String lblmob) {
		this.lblmob = lblmob;
	}
	public String getLblemail() {
		return lblemail;
	}
	public void setLblemail(String lblemail) {
		this.lblemail = lblemail;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLbltypep() {
		return lbltypep;
	}
	public void setLbltypep(String lbltypep) {
		this.lbltypep = lbltypep;
	}
	public int getDocvals() {
		return docvals;
	}
	public void setDocvals(int docvals) {
		this.docvals = docvals;
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
	public int getTxtradio() {
		return txtradio;
	}
	public void setTxtradio(int txtradio) {
		this.txtradio = txtradio;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getGridval() {
		return gridval;
	}
	public void setGridval(int gridval) {
		this.gridval = gridval;
	}
	public String getAddvalchange() {
		return addvalchange;
	}
	public void setAddvalchange(String addvalchange) {
		this.addvalchange = addvalchange;
	}
	public String getRemvalchange() {
		return remvalchange;
	}
	public void setRemvalchange(String remvalchange) {
		this.remvalchange = remvalchange;
	}
	public int getForradiochk() {
		return forradiochk;
	}
	public void setForradiochk(int forradiochk) {
		this.forradiochk = forradiochk;
	}
	public int getDocno() {
		return docno;
	}
	public void setDocno(int docno) {
		this.docno = docno;
	}

	public String getTxttelno() {
		return txttelno;
	}
	public void setTxttelno(String txttelno) {
		this.txttelno = txttelno;
	}

	public String getEnquiryDate() {
		return EnquiryDate;
	}
	public void setEnquiryDate(String enquiryDate) {
		EnquiryDate = enquiryDate;
	}


	public String getHidEnquiryDate() {
		return hidEnquiryDate;
	}
	public void setHidEnquiryDate(String hidEnquiryDate) {
		this.hidEnquiryDate = hidEnquiryDate;
	}
	public String getCmbclient() {
		return cmbclient;
	}
	public void setCmbclient(String cmbclient) {
		this.cmbclient = cmbclient;
	}

	public String getTxtclientname() {
		return txtclientname;
	}
	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}
	public String getTxtaddress() {
		return txtaddress;
	}
	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}

	public String getTxtmobile() {
		return txtmobile;
	}
	public void setTxtmobile(String txtmobile) {
		this.txtmobile = txtmobile;
	}

	public String getTxtRemarks() {
		return txtRemarks;
	}
	public void setTxtRemarks(String txtRemarks) {
		this.txtRemarks = txtRemarks;
	}



	public int getGenaral() {
		return genaral;
	}
	public void setGenaral(int genaral) {
		this.genaral = genaral;
	}
	public int getClient() {
		return client;
	}
	public void setClient(int client) {
		this.client = client;
	}



	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}

	//grid


	public int getEnqgridlenght() {
		return enqgridlenght;
	}
	public void setEnqgridlenght(int enqgridlenght) {
		this.enqgridlenght = enqgridlenght;
	}




	public String getFormdetailcode() {
		return formdetailcode;
	}
	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getEnqdtype() {
		return enqdtype;
	}
	public void setEnqdtype(String enqdtype) {
		this.enqdtype = enqdtype;
	}




	public String getLblcstno() {
		return lblcstno;
	}
	public void setLblcstno(String lblcstno) {
		this.lblcstno = lblcstno;
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


	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	public int getAmc() {
		return amc;
	}
	public void setAmc(int amc) {
		this.amc = amc;
	}
	public int getSjob() {
		return sjob;
	}
	public void setSjob(int sjob) {
		this.sjob = sjob;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	public String getHidradio() {
		return hidradio;
	}
	public void setHidradio(String hidradio) {
		this.hidradio = hidradio;
	}
	public String saveForm() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlStartDate = com.changeStringtoSqlDate(getEnquiryDate());
		String mode=getMode();
		//System.out.println(mode);
		String mobno=getTxtmobile();



		if(mode.equalsIgnoreCase("A")){
			ArrayList<String> enqarray= new ArrayList<>();
			for(int i=0;i<getEnqgridlenght();i++){
				String temp2=requestParams.get("enqtest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();

				enqarray.add(temp2);

			}
			
			
			int val=EnquiryDAO.insert(sqlStartDate,getCmbclient(),getTxtclientname(),getTxtaddress(),mobno,getGenaral(),getClient(),
					getTxtRemarks(),getTxtemail(),enqarray,session,getMode(),getFormdetailcode(),getTxttelno(),request,getSourceid(),
					getTxtcontact(),getCpersonid(),getCnt(),getCmbprocess(),
					getLabreq(),getClbcnfrm(),getSpclinsts(),getAdjspec(),
					getAlwinst(),getModreq(),getPaytrms(),getHidexpdate(),getExpdate(),getStmtcnfrm(),getDispinst(),getClbduedate(),getClbprdacpt(),getClbmthdusd());
			int vdocno=(int) request.getAttribute("vocno");
			if(val>0){

				setHidEnquiryDate(sqlStartDate.toString());
				setCmbclient(getCmbclient());
				setTxtclientname(getTxtclientname());
				setTxtaddress(getTxtaddress());
				setTxtemail(getTxtemail());
				setTxtmobile(getTxtmobile());
				setTxtRemarks(getTxtRemarks());
				setForradiochk(getForradiochk());
				setTxtradio(getTxtradio());
				setTxtsource(getTxtsource());
				setSourceid(getSourceid());
				setHidradio(getCnt());
				setTxtcontact(getTxtcontact());
				setCpersonid(getCpersonid());
				//setDocno(val);
				setDocno(vdocno);
				setMasterdoc_no(val);
				setGridval(getGridval());
				setCmbprocess(getCmbprocess());
				setHidcmbprocess(getCmbprocess());
				
				setLabreq(getLabreq());
				setClbcnfrm(getClbcnfrm());
				setSpclinsts(getSpclinsts());
				setAdjspec(getAdjspec());
				setAlwinst(getAlwinst());
				setModreq(getModreq());
				setPaytrms(getPaytrms());
				setHidexpdate(getHidexpdate());
				setExpdate(getExpdate());
				setStmtcnfrm(getStmtcnfrm());
				setDispinst(getDispinst());
				setClbduedate(getClbduedate());
				setClbprdacpt(getClbprdacpt());
				setClbmthdusd(getClbmthdusd());
				
				setHidclbmthdusd(getClbmthdusd());
				setHidclbprdacpt(getClbprdacpt());
				setHiddispinst(getDispinst());
				setHidstmtcnfrm(getStmtcnfrm());
				setHidpaytrms(getPaytrms());
				setHidmodreq(getModreq());
				setHidalwinst(getAlwinst());
				setHidadjspec(getAdjspec());
				setHidclbcnfrm(getClbcnfrm());
				setHidlabreq(getLabreq());
				
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				setHidEnquiryDate(sqlStartDate.toString());
				setCmbclient(getCmbclient());
				setTxtclientname(getTxtclientname());
				setTxtaddress(getTxtaddress());
				setTxtemail(getTxtemail());
				setTxtmobile(getTxtmobile());
				setTxtRemarks(getTxtRemarks());
				setForradiochk(getForradiochk());
				setTxtradio(getTxtradio());
				setTxtcontact(getTxtcontact());
				setCpersonid(getCpersonid());
				setHidradio(getCnt());
				//setDocno(val);
				setDocno(vdocno);
				setMasterdoc_no(val);
				setGridval(getGridval());
				setCmbprocess(getCmbprocess());
				setHidcmbprocess(getCmbprocess());
				
				setLabreq(getLabreq());
				setClbcnfrm(getClbcnfrm());
				setSpclinsts(getSpclinsts());
				setAdjspec(getAdjspec());
				setAlwinst(getAlwinst());
				setModreq(getModreq());
				setPaytrms(getPaytrms());
				setHidexpdate(getHidexpdate());
				setExpdate(getExpdate());
				setStmtcnfrm(getStmtcnfrm());
				setDispinst(getDispinst());
				setClbduedate(getClbduedate());
				setClbprdacpt(getClbprdacpt());
				setClbmthdusd(getClbmthdusd());
				
				setHidclbmthdusd(getClbmthdusd());
				setHidclbprdacpt(getClbprdacpt());
				setHiddispinst(getDispinst());
				setHidstmtcnfrm(getStmtcnfrm());
				setHidpaytrms(getPaytrms());
				setHidmodreq(getModreq());
				setHidalwinst(getAlwinst());
				setHidadjspec(getAdjspec());
				setHidclbcnfrm(getClbcnfrm());
				setHidlabreq(getLabreq());
				setMsg("Not Saved");
				return "fail";
			}
		}

		else if(mode.equalsIgnoreCase("E")){
			ArrayList<String> enqarray= new ArrayList<>();
			for(int i=0;i<getEnqgridlenght();i++){
				String temp2=requestParams.get("enqtest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();

				enqarray.add(temp2);

			}
			boolean Status=EnquiryDAO.edit(getMasterdoc_no(),sqlStartDate,getCmbclient(),getTxtclientname(),getTxtaddress(),mobno,getGenaral(),getClient(),getTxtRemarks(),
					getTxtemail(),enqarray,session,getMode(),getFormdetailcode(),getTxttelno(),getSourceid(),getTxtcontact(),getCpersonid(),getCnt(),getCmbprocess(),getLabreq(),getClbcnfrm(),getSpclinsts(),getAdjspec(),getAlwinst(),getModreq(),getPaytrms(),getHidexpdate(),getExpdate(),getStmtcnfrm(),getDispinst(),getClbduedate(),getClbprdacpt(),getClbmthdusd());
			if(Status){

				setHidEnquiryDate(sqlStartDate.toString());
				setCmbclient(getCmbclient());
				setTxtclientname(getTxtclientname());
				setTxtaddress(getTxtaddress());
				setTxtemail(getTxtemail());
				setTxtmobile(getTxtmobile());
				setTxtRemarks(getTxtRemarks());
				setTxtradio(getTxtradio());
				setForradiochk(getForradiochk());
				setHidradio(getCnt());
				setTxtsource(getTxtsource());
				setSourceid(getSourceid());
				setTxtcontact(getTxtcontact());
				setCpersonid(getCpersonid());
				//setDocno(getDocno());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setGridval(getGridval());
				setCmbprocess(getCmbprocess());
				setHidcmbprocess(getCmbprocess());
				
				setLabreq(getLabreq());
				setClbcnfrm(getClbcnfrm());
				setSpclinsts(getSpclinsts());
				setAdjspec(getAdjspec());
				setAlwinst(getAlwinst());
				setModreq(getModreq());
				setPaytrms(getPaytrms());
				setHidexpdate(getHidexpdate());
				setExpdate(getExpdate());
				setStmtcnfrm(getStmtcnfrm());
				setDispinst(getDispinst());
				setClbduedate(getClbduedate());
				setClbprdacpt(getClbprdacpt());
				setClbmthdusd(getClbmthdusd());
				
				setHidclbmthdusd(getClbmthdusd());
				setHidclbprdacpt(getClbprdacpt());
				setHiddispinst(getDispinst());
				setHidstmtcnfrm(getStmtcnfrm());
				setHidpaytrms(getPaytrms());
				setHidmodreq(getModreq());
				setHidalwinst(getAlwinst());
				setHidadjspec(getAdjspec());
				setHidclbcnfrm(getClbcnfrm());
				setHidlabreq(getLabreq());
				setMsg("Updated Successfully");
				return "success";

			}
			else{
				setHidEnquiryDate(sqlStartDate.toString());
				setCmbclient(getCmbclient());
				setTxtclientname(getTxtclientname());
				setTxtaddress(getTxtaddress());
				setTxtemail(getTxtemail());
				setTxtmobile(getTxtmobile());
				setTxtRemarks(getTxtRemarks());
				setTxtradio(getTxtradio());
				setForradiochk(getForradiochk());
				setTxtcontact(getTxtcontact());
				setCpersonid(getCpersonid());
				setHidradio(getCnt());
				//setDocno(getDocno());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setGridval(getGridval());
				setCmbprocess(getCmbprocess());
				setHidcmbprocess(getCmbprocess());
				
				setLabreq(getLabreq());
				setClbcnfrm(getClbcnfrm());
				setSpclinsts(getSpclinsts());
				setAdjspec(getAdjspec());
				setAlwinst(getAlwinst());
				setModreq(getModreq());
				setPaytrms(getPaytrms());
				setHidexpdate(getHidexpdate());
				setExpdate(getExpdate());
				setStmtcnfrm(getStmtcnfrm());
				setDispinst(getDispinst());
				setClbduedate(getClbduedate());
				setClbprdacpt(getClbprdacpt());
				setClbmthdusd(getClbmthdusd());
				
				setHidclbmthdusd(getClbmthdusd());
				setHidclbprdacpt(getClbprdacpt());
				setHiddispinst(getDispinst());
				setHidstmtcnfrm(getStmtcnfrm());
				setHidpaytrms(getPaytrms());
				setHidmodreq(getModreq());
				setHidalwinst(getAlwinst());
				setHidadjspec(getAdjspec());
				setHidclbcnfrm(getClbcnfrm());
				setHidlabreq(getLabreq());
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			
			ArrayList<String> enqarray= new ArrayList<>();
			
			boolean Status=EnquiryDAO.delete(getMasterdoc_no(),sqlStartDate,getCmbclient(),getTxtclientname(),getTxtaddress(),mobno,getGenaral(),getClient(),getTxtRemarks(),
					getTxtemail(),enqarray,session,getMode(),getFormdetailcode(),getTxttelno(),getSourceid(),getTxtcontact(),getCpersonid(),getCnt(),getCmbprocess(),getLabreq(),getClbcnfrm(),getSpclinsts(),getAdjspec(),getAlwinst(),getModreq(),getPaytrms(),getHidexpdate(),getExpdate(),getStmtcnfrm(),getDispinst(),getClbduedate(),getClbprdacpt(),getClbmthdusd());
			if(Status){

				setHidEnquiryDate(sqlStartDate.toString());
				setCmbclient(getCmbclient());
				setTxtclientname(getTxtclientname());
				setTxtaddress(getTxtaddress());
				setTxtemail(getTxtemail());
				setTxtmobile(getTxtmobile());
				setTxtRemarks(getTxtRemarks());
				setTxtradio(getTxtradio());
				setForradiochk(getForradiochk());
				setHidradio(getCnt());
				setTxtsource(getTxtsource());
				setSourceid(getSourceid());
				setTxtcontact(getTxtcontact());
				setCpersonid(getCpersonid());
				//setDocno(getDocno());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setGridval(getGridval());
				setCmbprocess(getCmbprocess());
				setHidcmbprocess(getCmbprocess());
				
				setLabreq(getLabreq());
				setClbcnfrm(getClbcnfrm());
				setSpclinsts(getSpclinsts());
				setAdjspec(getAdjspec());
				setAlwinst(getAlwinst());
				setModreq(getModreq());
				setPaytrms(getPaytrms());
				setHidexpdate(getHidexpdate());
				setExpdate(getExpdate());
				setStmtcnfrm(getStmtcnfrm());
				setDispinst(getDispinst());
				setClbduedate(getClbduedate());
				setClbprdacpt(getClbprdacpt());
				setClbmthdusd(getClbmthdusd());
				
				setHidclbmthdusd(getClbmthdusd());
				setHidclbprdacpt(getClbprdacpt());
				setHiddispinst(getDispinst());
				setHidstmtcnfrm(getStmtcnfrm());
				setHidpaytrms(getPaytrms());
				setHidmodreq(getModreq());
				setHidalwinst(getAlwinst());
				setHidadjspec(getAdjspec());
				setHidclbcnfrm(getClbcnfrm());
				setHidlabreq(getLabreq());
				setMsg("Successfully Deleted");
				setDeleted("DELETED");
				return "success";

			}
			else{
				setHidEnquiryDate(sqlStartDate.toString());
				setCmbclient(getCmbclient());
				setTxtclientname(getTxtclientname());
				setTxtaddress(getTxtaddress());
				setTxtemail(getTxtemail());
				setTxtmobile(getTxtmobile());
				setTxtRemarks(getTxtRemarks());
				setTxtradio(getTxtradio());
				setForradiochk(getForradiochk());
				setTxtcontact(getTxtcontact());
				setCpersonid(getCpersonid());
				setHidradio(getCnt());
				//setDocno(getDocno());
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());
				setGridval(getGridval());
				setCmbprocess(getCmbprocess());
				setHidcmbprocess(getCmbprocess());
				
				setLabreq(getLabreq());
				setClbcnfrm(getClbcnfrm());
				setSpclinsts(getSpclinsts());
				setAdjspec(getAdjspec());
				setAlwinst(getAlwinst());
				setModreq(getModreq());
				setPaytrms(getPaytrms());
				setHidexpdate(getHidexpdate());
				setExpdate(getExpdate());
				setStmtcnfrm(getStmtcnfrm());
				setDispinst(getDispinst());
				setClbduedate(getClbduedate());
				setClbprdacpt(getClbprdacpt());
				setClbmthdusd(getClbmthdusd());
				
				setHidclbmthdusd(getClbmthdusd());
				setHidclbprdacpt(getClbprdacpt());
				setHiddispinst(getDispinst());
				setHidstmtcnfrm(getStmtcnfrm());
				setHidpaytrms(getPaytrms());
				setHidmodreq(getModreq());
				setHidalwinst(getAlwinst());
				setHidadjspec(getAdjspec());
				setHidclbcnfrm(getClbcnfrm());
				setHidlabreq(getLabreq());
				setMsg("Not Deleted");
				return "fail";
			}
		}
		if(mode.equalsIgnoreCase("view")){
			setHidEnquiryDate(sqlStartDate.toString());
			ClsEnquiryBean viewbean= new ClsEnquiryBean(); 
			viewbean=EnquiryDAO.getViewDetails(getMasterdoc_no(),session);
			setLabreq(viewbean.getLabreq());
			setClbcnfrm(viewbean.getClbcnfrm());
			setSpclinsts(viewbean.getSpclinsts());
			setAdjspec(viewbean.getAdjspec());
			setAlwinst(viewbean.getAlwinst());
			setModreq(viewbean.getModreq());
			setPaytrms(viewbean.getPaytrms());
			setHidexpdate(viewbean.getHidexpdate());
			setExpdate(viewbean.getExpdate());
			setStmtcnfrm(viewbean.getStmtcnfrm());
			setDispinst(viewbean.getDispinst());
			setClbduedate(viewbean.getClbduedate());
			setClbprdacpt(viewbean.getClbprdacpt());
			setClbmthdusd(viewbean.getClbmthdusd());
			
			//hidclbmthdusd,hidclbprdacpt,hiddispinst,hidstmtcnfrm,hidpaytrms,hidmodreq,hidalwinst,hidadjspec,hidclbcnfrm,hidlabreq
			
			setHidclbmthdusd(viewbean.getClbmthdusd());
			setHidclbprdacpt(viewbean.getClbprdacpt());
			setHiddispinst(viewbean.getDispinst());
			setHidstmtcnfrm(viewbean.getStmtcnfrm());
			setHidpaytrms(viewbean.getPaytrms());
			setHidmodreq(viewbean.getModreq());
			setHidalwinst(viewbean.getAlwinst());
			setHidadjspec(viewbean.getAdjspec());
			setHidclbcnfrm(viewbean.getClbcnfrm());
			setHidlabreq(viewbean.getLabreq());
			
			
		}

		return "fail";	

	}



	public String printAction() throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int doc=Integer.parseInt(request.getParameter("docno"));
          String docsss=request.getParameter("docno");

		pintbean=EnquiryDAO.getPrint(doc,session);
		//ArrayList<String> arraylist = EnquiryDAO.getPrintdetails(doc,session);


		//cl details

		setLblprintname("Enquiry");
		setLblclient(pintbean.getLblclient());
		setLblclientaddress(pintbean.getLblclientaddress());
		setLblmob(pintbean.getLblmob());
		setLblemail(pintbean.getLblemail());
		//upper
		setLbldate(pintbean.getLbldate());
		setLbltypep(pintbean.getLbltypep());
		setDocvals(pintbean.getDocvals());

		//request.setAttribute("details",arraylist); 



		setLblbranch(pintbean.getLblbranch());
		setLblcompname(pintbean.getLblcompname());

		setLblcompaddress(pintbean.getLblcompaddress());

		setLblcomptel(pintbean.getLblcomptel());

		setLblcompfax(pintbean.getLblcompfax());
		setLbllocation(pintbean.getLbllocation());
		setHidradio(pintbean.getHidradio());


		setLblcstno(pintbean.getLblcstno());

		setLblservicetax(pintbean.getLblservicetax());
		setLblpan(pintbean.getLblpan());
		setUrl(com.getPrintPath("ENQ"));
		 String imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");
     	imgpath=imgpath.replace("\\", "\\\\");    
       
       
       
       String imgpath2=request.getSession().getServletContext().getRealPath("/icons/aitsfooter.jpg");
     	imgpath2=imgpath2.replace("\\", "\\\\");    
       
		if(com.getPrintPath("ENQ").contains(".jrxml")==true){
			HttpServletResponse response = ServletActionContext.getResponse();
		    
			HashMap<String,String> param = new HashMap<String,String>();
			Connection conn = null;
			//String reportFileName = "CreditInvoice";
			ClsConnection conobj=new ClsConnection();
			conn = conobj.getMyConnection();
			try {      
				 //String invqry="select @i:=@i+1 row,a.* from(select m.part_no productid,m.productname, u.unit uom,round(sum(d.qty),2) qty,format((d.nettotal/d.qty),2) unit,round(d.taxper,2)taxper,format(sum(d.taxamount),2) taxamount,round(sum(d.nettotal+d.taxamount),2) nettaxamount  from my_invd d left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no where d.rdocno='"+doc+"' group by d.prdid)a,(select @i:=0)c";
				param.put("imgfooterpath", imgpath2);
				param.put("imgheaderpath", imgpath);
				param.put("user", session.getAttribute("USERNAME").toString());
				param.put("docno", docsss);
				
				 
				 ClsCommon com=new ClsCommon();
				 //System.out.println("In INVOICE PRINT JRXML");   
				JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/callibration/enquiry/AlsaqrENQ.jrxml"));
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


	

}

