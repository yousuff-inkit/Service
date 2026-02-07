package com.inkit.enquiry;

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
public class ClsEnquiryAction  extends ActionSupport {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	ClsEnquiryBean enqBean= new ClsEnquiryBean();
	
		private String jqxIenqDate;
		private String hidjqxIenqDate;
		private String jqxTime;
		private String hidjqxTime;
		private String txtrefno;
		private String jqxResponseTime;
		private String hidjqxResponseTime;
		private String docno;
		private String txtclientname,txtaddress,txtsalesman,txtsalesmandocno,txtmobile,txttelno,txtemail;
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
		private int jobdetgridlenth;
		private int inspgridlenth;
		private int cegridlenth;
		private int cptrno;
		private String mode;
		private String formdetailcode;
		private String msg;
		private String deleted;
		private int estatusid;
		private int clientcurid;
		private double clientcurrate;
		
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

		public int getCptrno() {
			return cptrno;
		}

		public void setCptrno(int cptrno) {
			this.cptrno = cptrno;
		}

		public int getJobdetgridlenth() {
			return jobdetgridlenth;
		}

		public void setJobdetgridlenth(int jobdetgridlenth) {
			this.jobdetgridlenth = jobdetgridlenth;
		}

		public int getInspgridlenth() {
			return inspgridlenth;
		}


		public void setInspgridlenth(int inspgridlenth) {
			this.inspgridlenth = inspgridlenth;
		}

		public ClsEnquiryBean getEnqBean() {
			return enqBean;
		}

		public void setEnqBean(ClsEnquiryBean enqBean) {
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

		public String getJqxTime() {
			return jqxTime;
		}

		public void setJqxTime(String jqxTime) {
			this.jqxTime = jqxTime;
		}

		public String getHidjqxTime() {
			return hidjqxTime;
		}

		public void setHidjqxTime(String hidjqxTime) {
			this.hidjqxTime = hidjqxTime;
		}

		public String getTxtrefno() {
			return txtrefno;
		}

		public void setTxtrefno(String txtrefno) {
			this.txtrefno = txtrefno;
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

		public String getDocno() {
			return docno;
		}

		public void setDocno(String docno) {
			this.docno = docno;
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


	public String saveEnquiry() throws SQLException{
		
		ClsEnquiryDAO enqDAO= new ClsEnquiryDAO();
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String mode=getMode();
		int val=0;
		Map<String, String[]> requestParams = request.getParameterMap();
		
		if(mode.equalsIgnoreCase("A")){
			
			java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getJqxIenqDate());
	     	   
     	    ArrayList<String> jobdetgridList= new ArrayList<>();
     	 
			for(int i=0;i<getJobdetgridlenth();i++){
				String tempspec=requestParams.get("test"+i)[0];
				jobdetgridList.add(tempspec);
			}
						
			val=enqDAO.insert(sqlDate,getTxtrefno(),getClientid(),getCptrno(),getJqxTime(),getJqxResponseTime(),getProjectownerid(),getVendorid(),getSubvendorid(),getClientcurid(),jobdetgridList,mode,getFormdetailcode(),session,getTxtaddress(),getTxtsalesman(),getTxtsalesmandocno(),getTxtmobile(),getTxttelno(),getTxtclientdet(),getTxtemail(),getTxtcontactperson());
			System.out.println("docno=="+val);
			if(val>0)
			{
				reloadData(val);
				setMsg("Successfully Saved");
				return "success";
			}
			else
			{
				reloadData(val);
				setMsg("Not Saved");
				return "fail";
			}
			
		}
		
		if(mode.equalsIgnoreCase("E")){
			
			 java.sql.Date sqlDate = ClsCommon.changeStringtoSqlDate(getJqxIenqDate());
	     	   
			 		ArrayList<String> jobdetgridList= new ArrayList<>();
					for(int i=0;i<getJobdetgridlenth();i++){
						String tempspec=requestParams.get("test"+i)[0];
						jobdetgridList.add(tempspec);
					}
					
			 val=enqDAO.update(getDocno(),sqlDate,getTxtrefno(),getClientid(),getCptrno(),getJqxTime(),getJqxResponseTime(),getProjectownerid(),getVendorid(),getSubvendorid(),getClientcurid(),jobdetgridList,mode,getFormdetailcode(),session,getTxtaddress(),getTxtsalesman(),getTxtsalesmandocno(),getTxtmobile(),getTxttelno(),getTxtclientdet(),getTxtemail(),getTxtcontactperson());
			
			if(val>0)
			{
				reloadData(val);
				setMsg("Updated Successfully");
				return "success";
			}
			else
			{
				reloadData(val);
				setMsg("Not Updated");
				return "fail";
			}
			
		}
		
	else if(mode.equalsIgnoreCase("D")){
			
			val=enqDAO.delete(getDocno(),session);
			
			if(val>0)
			{
				reloadData(Integer.parseInt(getDocno()));
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			}
			else
			{
				setMsg("Not Deleted");
				return "fail";
			}
			
	}
		
	else if(mode.equalsIgnoreCase("View")){
	
		int statusid = request.getParameter("statusid")==null?0:Integer.parseInt(request.getParameter("statusid").trim()); 
		String doc_no=request.getParameter("doc_no")==null?getDocno():request.getParameter("doc_no");
		 
		if((getEstatusid()==4 ||getEstatusid()==5) && getCegridlenth()>0){
			
	 		ArrayList<String> cegridList= new ArrayList<>();
			for(int i=0;i<getCegridlenth();i++){
				String tempspec=requestParams.get("test2"+i)[0];
				cegridList.add(tempspec);
			}
			
			String cedata=enqDAO.ceGridInsert(getDocno(),cegridList,getEstatusid());
			if(Integer.parseInt(cedata)>0){
				setMsg("Updated Successfully");
			}
		}
	
		
		enqBean=enqDAO.getViewDetails(session,doc_no);
	       	
		setDocno(enqBean.getDocno());
		setTxtrefno(enqBean.getTxtrefno());
		setJqxIenqDate(enqBean.getJqxIenqDate());
		setHidjqxIenqDate(enqBean.getJqxIenqDate());
		setJqxTime(enqBean.getJqxTime());
		setHidjqxTime(enqBean.getJqxTime());
		setJqxResponseTime(enqBean.getJqxResponseTime());
		setHidjqxResponseTime(enqBean.getJqxResponseTime());
		setTxtclientname(enqBean.getTxtclientname());
		setTxtclientdet(enqBean.getTxtclientdet());
		setTxtcontactperson(enqBean.getTxtcontactperson());
		setTxttelnoarea(enqBean.getTxttelnoarea());
		setTxtprojectowner(enqBean.getTxtprojectowner());
		setTxtvendor(enqBean.getTxtvendor());
		setTxtsubsupplier(enqBean.getTxtsubsupplier());
		setClientid(enqBean.getClientid());
		setProjectownerid(enqBean.getProjectownerid());
		setVendorid(enqBean.getVendorid());
		setSubvendorid(enqBean.getSubvendorid());
		setCptrno(enqBean.getCptrno());
		setClientcurid(enqBean.getClientcurid());
		setClientcurrate(enqBean.getClientcurrate());
		setTxtaddress(enqBean.getTxtaddress());
		setTxtsalesman(enqBean.getTxtsalesman());
		setTxtsalesmandocno(enqBean.getTxtsalesmandocno());
		setTxtmobile(enqBean.getTxtmobile());
		setTxttelno(enqBean.getTxttelno());
		setTxtclientname(enqBean.getTxtclientname());
		setTxtemail(enqBean.getTxtemail());
		setTxtcontactperson(enqBean.getTxtcontactperson());
	    return "success";
		
	}
		return "fail";
	}		
	
	
	public void reloadData(int docno){
		
		setDocno(docno+"");
		
		/*setTxtrefno(getTxtrefno());
		setJqxIenqDate(ClsCommon.changeStringtoSqlDate(getJqxIenqDate()).toString());
		System.out.println("getJqxIenqDate========="+getJqxIenqDate());
		setHidjqxIenqDate(ClsCommon.changeStringtoSqlDate(getJqxIenqDate()).toString());
		setJqxTime(getJqxTime());
		setHidjqxTime(getJqxTime());
		setJqxResponseTime(getJqxResponseTime());
		setHidjqxResponseTime(getJqxResponseTime());
		setTxtclientname(getTxtclientname());
		setTxtclientdet(getTxtclientdet());
		setTxtcontactperson(getTxtcontactperson());
		setTxttelnoarea(getTxttelnoarea());
		setTxtprojectowner(getTxtprojectowner());
		setTxtvendor(getTxtvendor());
		setTxtsubsupplier(getTxtsubsupplier());
		setClientid(getClientid());
		setProjectownerid(getProjectownerid());
		setVendorid(getVendorid());
		setSubvendorid(getSubvendorid());
		setCptrno(getCptrno());*/
		
	
		setTxtrefno(getTxtrefno());
		setJqxIenqDate(getJqxIenqDate());
		setHidjqxIenqDate(getJqxIenqDate());
		setJqxTime(getJqxTime());
		setHidjqxTime(getJqxTime());
		setJqxResponseTime(getJqxResponseTime());
		setHidjqxResponseTime(getJqxResponseTime());
		setTxtclientname(getTxtclientname());
		setTxtclientdet(getTxtclientdet());
		setTxtcontactperson(getTxtcontactperson());
		setTxttelnoarea(getTxttelnoarea());
		setTxtprojectowner(getTxtprojectowner());
		setTxtvendor(getTxtvendor());
		setTxtsubsupplier(getTxtsubsupplier());
		setClientid(getClientid());
		setProjectownerid(getProjectownerid());
		setVendorid(getVendorid());
		setSubvendorid(getSubvendorid());
		setCptrno(getCptrno());
		setClientcurid(getClientcurid());
		setClientcurrate(getClientcurrate());
		setTxtaddress(getTxtaddress());
		setTxtsalesman(getTxtsalesman());
		setTxtsalesmandocno(getTxtsalesmandocno());
		setTxtmobile(getTxtmobile());
		setTxttelno(getTxttelno());
		setTxtclientname(getTxtclientname());
		setTxtemail(getTxtemail());
		setTxtcontactperson(getTxtcontactperson());
		
	}
				
}
