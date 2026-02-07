package com.it.staffingcontract;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class ClsStaffingContractAction extends ActionSupport {

	ClsConnection ClsConnection = new ClsConnection();
	ClsCommon ClsCommon = new ClsCommon();
	ClsStaffingContractBean enqBean = new ClsStaffingContractBean();

	private String jqxIenqDate;
	private String hidjqxIenqDate;
	private String jqxIfrmDate, hidjqxIfrmDate;
	private String jqxItoDate, hidjqxItoDate;
	private String txtrefno, cmbreftype, hidcmbreftype;
	
	public String txtenqtype;

	private String jqxResponseTime;
	private String hidjqxResponseTime;
	private int docno, masterdoc_no;
	private int gridlength;
	private String txtclientname, txtaddress, txtsalesman, txtsalesmandocno,
			txtmobile, txttelno, txtemail;
	private String txtclientdet;
	private int clientid;
	private String txtcontactperson;
	private String txttelnoarea;
	private String txtprojectowner;
	private int projectownerid;
	private String txtvendor;
	private int vendorid;
	private String txtsubsupplier;
	private int subvendorid;
	private int inspgridlenth;
	private int cegridlenth;
	private String cptrno;
	private String mode;
	private String formdetailcode;
	private String msg;
	private String deleted;
	private int estatusid;
	private int clientcurid;
	private int cmbcurr;
	private double clientcurrate;
	private int cmbpholiday;
	private int hidpholiday;
	private double txttaxper;
	private String brchName;

	public int getGridlength() {
		return gridlength;
	}
	
	public void setGridlength(int gridlength) {
		this.gridlength = gridlength;
	}

	public String getTxtrefno() {
		return txtrefno;
	}

	public String getHidcmbreftype() {
		return hidcmbreftype;
	}

	public void setHidcmbreftype(String hidcmbreftype) {
		this.hidcmbreftype = hidcmbreftype;
	}

	public String getJqxIfrmDate() {
		return jqxIfrmDate;
	}

	public void setJqxIfrmDate(String jqxIfrmDate) {
		this.jqxIfrmDate = jqxIfrmDate;
	}

	public String getHidjqxIfrmDate() {
		return hidjqxIfrmDate;
	}

	public void setHidjqxIfrmDate(String hidjqxIfrmDate) {
		this.hidjqxIfrmDate = hidjqxIfrmDate;
	}

	public String getJqxItoDate() {
		return jqxItoDate;
	}

	public void setJqxItoDate(String jqxItoDate) {
		this.jqxItoDate = jqxItoDate;
	}

	public String getHidjqxItoDate() {
		return hidjqxItoDate;
	}

	public void setHidjqxItoDate(String hidjqxItoDate) {
		this.hidjqxItoDate = hidjqxItoDate;
	}

	public String getCmbreftype() {
		return cmbreftype;
	}

	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}

	public void setTxtrefno(String txtrefno) {
		this.txtrefno = txtrefno;
	}

	public String getTxtaddress() {
		return txtaddress;
	}

	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}

	public String getTxtsalesman() {
		return txtsalesman;
	}

	public void setTxtsalesman(String txtsalesman) {
		this.txtsalesman = txtsalesman;
	}

	public String getTxtsalesmandocno() {
		return txtsalesmandocno;
	}

	public void setTxtsalesmandocno(String txtsalesmandocno) {
		this.txtsalesmandocno = txtsalesmandocno;
	}

	public String getTxtmobile() {
		return txtmobile;
	}

	public void setTxtmobile(String txtmobile) {
		this.txtmobile = txtmobile;
	}

	public String getTxttelno() {
		return txttelno;
	}

	public void setTxttelno(String txttelno) {
		this.txttelno = txttelno;
	}

	public String getTxtemail() {
		return txtemail;
	}

	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}

	public double getClientcurrate() {
		return clientcurrate;
	}

	public void setClientcurrate(double clientcurrate) {
		this.clientcurrate = clientcurrate;
	}

	public int getCegridlenth() {
		return cegridlenth;
	}

	public void setCegridlenth(int cegridlenth) {
		this.cegridlenth = cegridlenth;
	}

	public int getClientcurid() {
		return clientcurid;
	}

	public void setClientcurid(int clientcurid) {
		this.clientcurid = clientcurid;
	}
	
	public int getCmbcurr() {
		return cmbcurr;
	}
	
	public void setCmbcurr(int cmbcurr) {
		this.cmbcurr = cmbcurr;
	}

	public String getCptrno() {
		return cptrno;
	}

	public void setCptrno(String cptrno) {
		this.cptrno = cptrno;
	}

	public int getInspgridlenth() {
		return inspgridlenth;
	}

	public void setInspgridlenth(int inspgridlenth) {
		this.inspgridlenth = inspgridlenth;
	}

	public ClsStaffingContractBean getEnqBean() {
		return enqBean;
	}

	public void setEnqBean(ClsStaffingContractBean enqBean) {
		this.enqBean = enqBean;
	}

	public String getJqxIenqDate() {
		return jqxIenqDate;
	}

	public void setJqxIenqDate(String jqxIenqDate) {
		this.jqxIenqDate = jqxIenqDate;
	}

	public String getHidjqxIenqDate() {
		return hidjqxIenqDate;
	}

	public void setHidjqxIenqDate(String hidjqxIenqDate) {
		this.hidjqxIenqDate = hidjqxIenqDate;
	}

	public String getJqxResponseTime() {
		return jqxResponseTime;
	}

	public void setJqxResponseTime(String jqxResponseTime) {
		this.jqxResponseTime = jqxResponseTime;
	}

	public String getHidjqxResponseTime() {
		return hidjqxResponseTime;
	}

	public void setHidjqxResponseTime(String hidjqxResponseTime) {
		this.hidjqxResponseTime = hidjqxResponseTime;
	}

	public String getTxtclientname() {
		return txtclientname;
	}

	public void setTxtclientname(String txtclientname) {
		this.txtclientname = txtclientname;
	}

	public String getTxtclientdet() {
		return txtclientdet;
	}

	public void setTxtclientdet(String txtclientdet) {
		this.txtclientdet = txtclientdet;
	}

	public int getClientid() {
		return clientid;
	}

	public void setClientid(int clientid) {
		this.clientid = clientid;
	}

	public String getTxtcontactperson() {
		return txtcontactperson;
	}

	public void setTxtcontactperson(String txtcontactperson) {
		this.txtcontactperson = txtcontactperson;
	}

	public String getTxttelnoarea() {
		return txttelnoarea;
	}

	public void setTxttelnoarea(String txttelnoarea) {
		this.txttelnoarea = txttelnoarea;
	}

	public String getTxtprojectowner() {
		return txtprojectowner;
	}

	public void setTxtprojectowner(String txtprojectowner) {
		this.txtprojectowner = txtprojectowner;
	}

	public int getProjectownerid() {
		return projectownerid;
	}

	public void setProjectownerid(int projectownerid) {
		this.projectownerid = projectownerid;
	}

	public String getTxtvendor() {
		return txtvendor;
	}

	public void setTxtvendor(String txtvendor) {
		this.txtvendor = txtvendor;
	}

	public int getVendorid() {
		return vendorid;
	}

	public void setVendorid(int vendorid) {
		this.vendorid = vendorid;
	}

	public String getTxtsubsupplier() {
		return txtsubsupplier;
	}

	public void setTxtsubsupplier(String txtsubsupplier) {
		this.txtsubsupplier = txtsubsupplier;
	}

	public int getSubvendorid() {
		return subvendorid;
	}

	public void setSubvendorid(int subvendorid) {
		this.subvendorid = subvendorid;
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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getEnqtype() {
		return txtenqtype;
	}
	
	public void setEnqtype(String txtenqtype) {
		this.txtenqtype = txtenqtype;
	}
	
	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public int getEstatusid() {
		return estatusid;
	}

	public void setEstatusid(int estatusid) {
		this.estatusid = estatusid;
	}

	public int getDocno() {
		return docno;
	}

	public void setDocno(int docno) {
		this.docno = docno;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}
	
	public void setMasterdoc_no(int masterdoc_no) {
		this.masterdoc_no = masterdoc_no;
	}
	
	public int getCmbpholiday() {
		return cmbpholiday;
	}

	public void setCmbpholiday(int cmbpholiday) {
		this.cmbpholiday = cmbpholiday;
	}
	
	public int getHidpholiday() {
		return hidpholiday;
	}

	public void setHidpholiday(int hidpholiday) {
		this.hidpholiday = hidpholiday;
	}

	public double getTxttaxper() {
		return txttaxper;
	}

	public void setTxttaxper(double txttaxper) {
		this.txttaxper = txttaxper;
	}
	
	public String getBrchName() {
		return brchName;
	}
	
	public void setBrchName(String brchName) {
		this.brchName = brchName;
	}
	
	public String saveAction() throws SQLException {

		ClsStaffingContractDAO enqDAO = new ClsStaffingContractDAO();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String mode = getMode();
		int val = 0;
		Map<String, String[]> requestParams = request.getParameterMap();
		java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getJqxIenqDate());
		java.sql.Date sqlfrmDate = ClsCommon.changeStringtoSqlDate(getJqxIfrmDate());
		java.sql.Date sqltoDate = ClsCommon.changeStringtoSqlDate(getJqxItoDate());

		if (mode.equalsIgnoreCase("A")) {

			ArrayList<String> array = new ArrayList<String>();

			for (int i = 0; i < getGridlength(); i++) {
				String temp = requestParams.get("test" + i)[0];
				array.add(temp);
			    //System.out.println("array values==="+temp);
			}

			val = enqDAO.insert(sqlDate, getCmbreftype(), getTxtrefno(),getClientid(), getCptrno(), getTxtsalesmandocno(),sqlfrmDate, sqltoDate, session, mode, getFormdetailcode(),
					getCmbcurr(),getClientcurrate(),getCmbpholiday(), getTxttaxper(),array, request,getBrchName());
			int vocno = (int) request.getAttribute("vocno");
			if (val > 0) {
				reloadData(val, vocno);
				setMsg("Successfully Saved");
				return "success";
			} else {
				reloadData(val, vocno);
				setMsg("Not Saved");
				return "fail";
			}

		}

		if (mode.equalsIgnoreCase("E")) {
			
			ArrayList<String> array = new ArrayList<String>();

			for (int i = 0; i < getGridlength(); i++) {
				String temp = requestParams.get("test" + i)[0];
				array.add(temp);
				// System.out.println("array values==="+temp);
			}

			int val1 = enqDAO.update(getMasterdoc_no(), sqlDate, getCmbreftype(),getTxtrefno(), getClientid(), getCptrno(),getTxtsalesmandocno(), sqlfrmDate, sqltoDate, session,mode, getFormdetailcode(),
					getCmbcurr(),getClientcurrate(), getCmbpholiday(), getTxttaxper(), array, request,getBrchName());

			if (val1 > 0) {
				reloadData(getMasterdoc_no(), getDocno());
				setMsg("Updated Successfully");
				return "success";
			} else {
				reloadData(getMasterdoc_no(), getDocno());
				setMsg("Not Updated");
				return "fail";
			}

		}

		else if (mode.equalsIgnoreCase("D")) {

			val = enqDAO.delete(getMasterdoc_no(), session);

			if (val > 0) {
				reloadData(getMasterdoc_no(), getDocno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			} else {
				setMsg("Not Deleted");
				return "fail";
			}

		}

		else if (mode.equalsIgnoreCase("View")) {

			int docno = request.getParameter("doc_no") == null ? 0 : Integer.parseInt(request.getParameter("doc_no").trim());

			enqBean = enqDAO.getViewDetails(session, docno);

			setDocno(enqBean.getDocno());
			setTxtrefno(enqBean.getTxtrefno());
			setJqxIenqDate(enqBean.getJqxIenqDate());
			setHidjqxIenqDate(enqBean.getJqxIenqDate());
			setTxtclientname(enqBean.getTxtclientname());
			setTxtclientdet(enqBean.getTxtclientdet());
			setTxtcontactperson(enqBean.getTxtcontactperson());
			setClientid(enqBean.getClientid());
			setCptrno(enqBean.getCptrno());
			setTxtaddress(enqBean.getTxtaddress());
			setTxtsalesman(enqBean.getTxtsalesman());
			setTxtsalesmandocno(enqBean.getTxtsalesmandocno());
			setTxtmobile(enqBean.getTxtmobile());
			setTxttelno(enqBean.getTxttelno());
			setTxtemail(enqBean.getTxtemail());
			setJqxIfrmDate(enqBean.getJqxIfrmDate());
			setHidjqxIfrmDate(enqBean.getJqxIfrmDate());
			setJqxItoDate(enqBean.getJqxItoDate());
			setHidjqxItoDate(enqBean.getJqxItoDate());
			setClientcurid(enqBean.getClientcurid());
			setClientcurrate(enqBean.getClientcurrate());
			return "success";

		}
		return "fail";
	}

	public void reloadData(int docno, int vocno) {

		setMasterdoc_no(docno);
		setDocno(vocno);
		setTxtrefno(getTxtrefno());
		setJqxIenqDate(getJqxIenqDate());
		setHidjqxIenqDate(getJqxIenqDate());
		setTxtclientname(getTxtclientname());
		setTxtclientdet(getTxtclientdet());
		setTxtcontactperson(getTxtcontactperson());
		setClientid(getClientid());
		setCptrno(getCptrno());
		setTxtaddress(getTxtaddress());
		setTxtsalesman(getTxtsalesman());
		setTxtsalesmandocno(getTxtsalesmandocno());
		setTxtmobile(getTxtmobile());
		setTxttelno(getTxttelno());
		setTxtemail(getTxtemail());
		setJqxIfrmDate(getJqxIfrmDate());
		setHidjqxIfrmDate(getJqxIfrmDate());
		setJqxItoDate(getJqxItoDate());
		setHidjqxItoDate(getJqxItoDate());
		setClientcurid(getCmbcurr());
		setClientcurrate(getClientcurrate());
		setEnqtype(getEnqtype());
		setHidcmbreftype(getCmbreftype());
		setHidpholiday(getCmbpholiday());
		setTxttaxper(getTxttaxper());
	}

}
