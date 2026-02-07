package com.finance.posting.prePayment;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsPrePaymentAction extends ActionSupport{

	ClsCommon commonDAO= new ClsCommon();
	ClsPrePaymentDAO prePaymentDAO= new ClsPrePaymentDAO();
	ClsPrePaymentBean prePaymentBean;

	private String formdetailcode;
	private String mode;
	private String deleted;
	private String msg;
	private int txtaccountdocno;
	private int txttranid;
	private String txtdtype;
	private String txtaccid;
	private String txtaccname;
	private String jqxFromDate;
	private String hidjqxFromDate;
	private String jqxToDate;
	private String hidjqxToDate;
	private String cmbtype;
	private String hidcmbtype;
	private String txtdistributiondocno;
	private String txtdistributionaccid;
	private String txtdistributionaccname;
	private String txtcostgroup;
	private int txtcosttype;
	private int txtcostno;
	private double txtamount;
	private String jqxStartDate;
	private String hidjqxStartDate;
	private String cmbfrequency;
	private String hidcmbfrequency;
	private int txtdueafter;
	private int txtinstnos;
	private double txtinstamt;
	private String txtdescription;
	private int txttrno;
	private int txttranno;
	private double txtdebittotal;
	private String txtrowno;
	
	//Distribution Grid
	private int gridlength;
	
	//Posting Grid
    private int applylength;
	
	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getTxtaccountdocno() {
		return txtaccountdocno;
	}

	public void setTxtaccountdocno(int txtaccountdocno) {
		this.txtaccountdocno = txtaccountdocno;
	}

	public int getTxttranid() {
		return txttranid;
	}

	public void setTxttranid(int txttranid) {
		this.txttranid = txttranid;
	}

	public String getTxtdtype() {
		return txtdtype;
	}

	public void setTxtdtype(String txtdtype) {
		this.txtdtype = txtdtype;
	}

	public String getTxtaccid() {
		return txtaccid;
	}

	public void setTxtaccid(String txtaccid) {
		this.txtaccid = txtaccid;
	}

	public String getTxtaccname() {
		return txtaccname;
	}

	public void setTxtaccname(String txtaccname) {
		this.txtaccname = txtaccname;
	}

	public String getJqxFromDate() {
		return jqxFromDate;
	}

	public void setJqxFromDate(String jqxFromDate) {
		this.jqxFromDate = jqxFromDate;
	}

	public String getHidjqxFromDate() {
		return hidjqxFromDate;
	}

	public void setHidjqxFromDate(String hidjqxFromDate) {
		this.hidjqxFromDate = hidjqxFromDate;
	}

	public String getJqxToDate() {
		return jqxToDate;
	}

	public void setJqxToDate(String jqxToDate) {
		this.jqxToDate = jqxToDate;
	}

	public String getHidjqxToDate() {
		return hidjqxToDate;
	}

	public void setHidjqxToDate(String hidjqxToDate) {
		this.hidjqxToDate = hidjqxToDate;
	}

	public String getCmbtype() {
		return cmbtype;
	}

	public void setCmbtype(String cmbtype) {
		this.cmbtype = cmbtype;
	}

	public String getHidcmbtype() {
		return hidcmbtype;
	}

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}

	public String getTxtdistributiondocno() {
		return txtdistributiondocno;
	}

	public void setTxtdistributiondocno(String txtdistributiondocno) {
		this.txtdistributiondocno = txtdistributiondocno;
	}

	public String getTxtdistributionaccid() {
		return txtdistributionaccid;
	}

	public void setTxtdistributionaccid(String txtdistributionaccid) {
		this.txtdistributionaccid = txtdistributionaccid;
	}

	public String getTxtdistributionaccname() {
		return txtdistributionaccname;
	}

	public void setTxtdistributionaccname(String txtdistributionaccname) {
		this.txtdistributionaccname = txtdistributionaccname;
	}

	public String getTxtcostgroup() {
		return txtcostgroup;
	}

	public void setTxtcostgroup(String txtcostgroup) {
		this.txtcostgroup = txtcostgroup;
	}

	public int getTxtcosttype() {
		return txtcosttype;
	}

	public void setTxtcosttype(int txtcosttype) {
		this.txtcosttype = txtcosttype;
	}

	public int getTxtcostno() {
		return txtcostno;
	}

	public void setTxtcostno(int txtcostno) {
		this.txtcostno = txtcostno;
	}

	public double getTxtamount() {
		return txtamount;
	}

	public void setTxtamount(double txtamount) {
		this.txtamount = txtamount;
	}

	public String getJqxStartDate() {
		return jqxStartDate;
	}

	public void setJqxStartDate(String jqxStartDate) {
		this.jqxStartDate = jqxStartDate;
	}

	public String getHidjqxStartDate() {
		return hidjqxStartDate;
	}

	public void setHidjqxStartDate(String hidjqxStartDate) {
		this.hidjqxStartDate = hidjqxStartDate;
	}

	public String getCmbfrequency() {
		return cmbfrequency;
	}

	public void setCmbfrequency(String cmbfrequency) {
		this.cmbfrequency = cmbfrequency;
	}

	public String getHidcmbfrequency() {
		return hidcmbfrequency;
	}

	public void setHidcmbfrequency(String hidcmbfrequency) {
		this.hidcmbfrequency = hidcmbfrequency;
	}

	public int getTxtdueafter() {
		return txtdueafter;
	}

	public void setTxtdueafter(int txtdueafter) {
		this.txtdueafter = txtdueafter;
	}

	public int getTxtinstnos() {
		return txtinstnos;
	}

	public void setTxtinstnos(int txtinstnos) {
		this.txtinstnos = txtinstnos;
	}

	public double getTxtinstamt() {
		return txtinstamt;
	}

	public void setTxtinstamt(double txtinstamt) {
		this.txtinstamt = txtinstamt;
	}

	public String getTxtdescription() {
		return txtdescription;
	}

	public void setTxtdescription(String txtdescription) {
		this.txtdescription = txtdescription;
	}

	public int getTxttrno() {
		return txttrno;
	}

	public void setTxttrno(int txttrno) {
		this.txttrno = txttrno;
	}

	public int getTxttranno() {
		return txttranno;
	}

	public void setTxttranno(int txttranno) {
		this.txttranno = txttranno;
	}

	public double getTxtdebittotal() {
		return txtdebittotal;
	}

	public void setTxtdebittotal(double txtdebittotal) {
		this.txtdebittotal = txtdebittotal;
	}

	public String getTxtrowno() {
		return txtrowno;
	}

	public void setTxtrowno(String txtrowno) {
		this.txtrowno = txtrowno;
	}

	public int getGridlength() {
		return gridlength;
	}

	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public int getApplylength() {
		return applylength;
	}

	public void setApplylength(int applylength) {
		this.applylength = applylength;
	}

	java.sql.Date fromDate;
	java.sql.Date toDate;
	java.sql.Date startDate;
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();

		String mode=getMode();
		ClsPrePaymentBean bean = new ClsPrePaymentBean();

		fromDate = commonDAO.changeStringtoSqlDate(getJqxFromDate());
		toDate = commonDAO.changeStringtoSqlDate(getJqxToDate());
		startDate = commonDAO.changeStringtoSqlDate(getJqxStartDate());
		if(mode.equalsIgnoreCase("A")){
			
			/*Distribution Grid Saving*/
			ArrayList<String> distributionarray= new ArrayList<String>();
			for(int i=0;i<getGridlength();i++){
				String temp=requestParams.get("test"+i)[0];
				distributionarray.add(temp);
			}
			/*Distribution Grid Saving Ends*/
			
			/*Posting Grid*/
			ArrayList<String> journalvouchersarray= new ArrayList<>();
			for(int i=0;i<getApplylength();i++){
				String temp=requestParams.get("txtapply"+i)[0];
				journalvouchersarray.add(temp);
			}
			
			/*Posting Grid Ends*/
			
						int val=prePaymentDAO.insert(getFormdetailcode(),getCmbtype(),getTxtaccountdocno(),getTxttrno(),getTxttranid(),getTxtdtype(),getTxtdistributiondocno(),getTxtcosttype(),getTxtcostno(),getTxtamount(),startDate,getCmbfrequency(),getTxtdueafter(),getTxtinstnos(),getTxtinstamt(),getTxtdescription(),getTxtdebittotal(),getTxtrowno(),toDate,distributionarray,journalvouchersarray,session,request);
						if(val>0.0){
							
							//setTxttranno(Integer.parseInt(request.getAttribute("tranno").toString()));
							setData();
							
							setMsg("Successfully Saved");
							return "success";
						}
						else{
							setMsg("Not Saved");
							return "fail";
						}	
		}
		return "fail";
}

	public void setData() {

    	    setTxtaccid(getTxtaccid());
    	    setTxtaccname(getTxtaccname());
    	    if(fromDate != null){
    	    setHidjqxFromDate(fromDate.toString());
    	    }
    	    if(toDate != null){
    	    setHidjqxToDate(toDate.toString());
    	    }
    	    setHidcmbtype(getCmbtype());   
    	    
    	    setTxtdistributiondocno(getTxtdistributiondocno());
    	    setTxtdistributionaccid(getTxtdistributionaccid());
    	    setTxtdistributionaccname(getTxtdistributionaccname());
    	    setTxtcostgroup(getTxtcostgroup());
    	    setTxtcosttype(getTxtcosttype());
    	    setTxtcostno(getTxtcostno());
    	    setTxtamount(getTxtamount());
    	    if(startDate != null){
    	    setHidjqxStartDate(startDate.toString());
    	    }
    	    setHidcmbfrequency(getCmbfrequency());
    	    
    	    setTxtdueafter(getTxtdueafter());
    	    setTxtinstnos(getTxtinstnos());
    	    setTxtinstamt(getTxtinstamt());
    	    setTxtdescription(getTxtdescription());
    	    setTxttranid(getTxttranid());
    	    setTxtdtype(getTxtdtype());
    	    setTxtrowno(getTxtrowno());
    	    setTxtdebittotal(getTxtdebittotal());
			setFormdetailcode(getFormdetailcode());
		}
}

