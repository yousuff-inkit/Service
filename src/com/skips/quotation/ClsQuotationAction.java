package com.skips.quotation;  

import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.skips.quotation.ClsQuotationBean;  
import com.skips.quotation.ClsQuotationDAO;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class ClsQuotationAction {    
	ClsQuotationDAO QuoteDAO= new ClsQuotationDAO();    
	ClsCommon com=new ClsCommon();
	ClsQuotationBean pintbean= new ClsQuotationBean(); 
        ClsConnection conobj=new ClsConnection();    

	private String comptel,imgpath,url,quoteDate,hidquoteDate,docno,mode,msg,deleted,txtenquiry,hidenqdocno,txtclient,hidcldocno,txtsource,
	sourceid,txtsalesman,txtsalesmandocno,txtdesc,formdetailcode,netamount,txtmail,txtaddress,txtmob,txttele,cmbbillingmethod,
	hidcmbbillingmethod,txtgroupcompanies,cmbpayterm,hidcmbpayterm,txtrevise,txtcperson,hidcpersonid,txtdesig,exefolio;  
	
	public String getExefolio() {
        return exefolio;
    }
    public void setExefolio(String exefolio) {
        this.exefolio = exefolio;
    }
    public String getTxtdesig() {
		return txtdesig;
	}
	public void setTxtdesig(String txtdesig) {
		this.txtdesig = txtdesig;
	}
	public String getComptel() {
		return comptel;
	}
	public void setComptel(String comptel) {
		this.comptel = comptel;
	}
        public String getTxtcperson() {
		return txtcperson;
	}

	public void setTxtcperson(String txtcperson) {
		this.txtcperson = txtcperson;
	}

	public String getHidcpersonid() {
		return hidcpersonid;
	}

	public void setHidcpersonid(String hidcpersonid) {
		this.hidcpersonid = hidcpersonid;
	}

	public String getTxtrevise() {
		return txtrevise;
	}

	public void setTxtrevise(String txtrevise) { 
		this.txtrevise = txtrevise;
	}

	public String getCmbpayterm() {   
		return cmbpayterm;
	}

	public void setCmbpayterm(String cmbpayterm) {
		this.cmbpayterm = cmbpayterm;
	}

	public String getHidcmbpayterm() {
		return hidcmbpayterm;
	}

	public void setHidcmbpayterm(String hidcmbpayterm) {
		this.hidcmbpayterm = hidcmbpayterm;
	}

	public String getCmbbillingmethod() {  
		return cmbbillingmethod;
	}

	public void setCmbbillingmethod(String cmbbillingmethod) {
		this.cmbbillingmethod = cmbbillingmethod;
	}

	public String getHidcmbbillingmethod() {
		return hidcmbbillingmethod;
	}

	public void setHidcmbbillingmethod(String hidcmbbillingmethod) {
		this.hidcmbbillingmethod = hidcmbbillingmethod;
	}

	public String getTxtgroupcompanies() {
		return txtgroupcompanies;
	}

	public void setTxtgroupcompanies(String txtgroupcompanies) {
		this.txtgroupcompanies = txtgroupcompanies;
	}
	private int enqgridlenght,siteGridlength,masterdoc_no;   

	public String getTxtmail() {  
		return txtmail;
	}

	public void setTxtmail(String txtmail) {
		this.txtmail = txtmail;
	}
        public ClsConnection getConobj() {
		return conobj;
	}
	public void setConobj(ClsConnection conobj) {
		this.conobj = conobj;
	}        

        public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getImgpath() {
		return imgpath;
	}
	public void setImgpath(String imgpath) {
		this.imgpath = imgpath;
	}
        

	public String getTxtaddress() {
		return txtaddress;
	}

	public void setTxtaddress(String txtaddress) {
		this.txtaddress = txtaddress;
	}

	public String getTxtmob() {
		return txtmob;
	}

	public void setTxtmob(String txtmob) {
		this.txtmob = txtmob;
	}

	public String getTxttele() {
		return txttele;
	}

	public void setTxttele(String txttele) {
		this.txttele = txttele;
	}

	public String getNetamount() {    
		return netamount;
	}

	public void setNetamount(String netamount) {
		this.netamount = netamount;
	}

	public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}
	public String getQuoteDate() {
		return quoteDate;
	}

	public void setQuoteDate(String quoteDate) {
		this.quoteDate = quoteDate;
	}

	public String getHidquoteDate() {
		return hidquoteDate;
	}

	public void setHidquoteDate(String hidquoteDate) {
		this.hidquoteDate = hidquoteDate;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public int getMasterdoc_no() {
		return masterdoc_no;
	}

	public void setMasterdoc_no(int masterdoc_no) {  
		this.masterdoc_no = masterdoc_no;
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

	public String getTxtenquiry() {
		return txtenquiry;
	}

	public void setTxtenquiry(String txtenquiry) {
		this.txtenquiry = txtenquiry;
	}
        private Map<String, Object> param=null;
	
	
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}


	public String getHidenqdocno() {
		return hidenqdocno;
	}

	public void setHidenqdocno(String hidenqdocno) {
		this.hidenqdocno = hidenqdocno;
	}

	public String getTxtclient() {
		return txtclient;
	}

	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
	}

	public String getHidcldocno() {
		return hidcldocno;
	}

	public void setHidcldocno(String hidcldocno) {
		this.hidcldocno = hidcldocno;
	}

	public String getTxtsource() {
		return txtsource;
	}

	public void setTxtsource(String txtsource) {
		this.txtsource = txtsource;
	}

	public String getSourceid() {
		return sourceid;
	}

	public void setSourceid(String sourceid) {
		this.sourceid = sourceid;
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

	public String getTxtdesc() {
		return txtdesc;
	}

	public void setTxtdesc(String txtdesc) {
		this.txtdesc = txtdesc;
	}

	public int getEnqgridlenght() {
		return enqgridlenght;
	}

	public void setEnqgridlenght(int enqgridlenght) {
		this.enqgridlenght = enqgridlenght;
	}

	public int getSiteGridlength() {
		return siteGridlength;
	}

	public void setSiteGridlength(int siteGridlength) {
		this.siteGridlength = siteGridlength;
	}

	public String saveAction() throws Exception{  
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
//		System.out.println("IN QUOTE ACTION");
		java.sql.Date sqlStartDate =null;   
		String mode=getMode();  
		ArrayList<String> enqarray= new ArrayList<>();
		ArrayList<String> sitearray= new ArrayList<>();
		//System.out.println(getEnqgridlenght()+"=IN 1="+getSiteGridlength());  
		if(mode.equalsIgnoreCase("A") || mode.equalsIgnoreCase("E") || mode.equalsIgnoreCase("R")){   
			 sqlStartDate= com.changeStringtoSqlDate(getQuoteDate());
			for(int i=0;i<getEnqgridlenght();i++){
				String temp2=requestParams.get("enqtest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				enqarray.add(temp2);
			}
			
			for(int i=0;i<getSiteGridlength();i++){
				String temp2=requestParams.get("sitetest"+i)[0];
				// String temp2=request.getAttribute("enqtest"+i).toString();
				sitearray.add(temp2);
			}
		}
		//System.out.println("IN 2");  
		if(mode.equalsIgnoreCase("A")){   
			int val=QuoteDAO.insert(sqlStartDate,getHidenqdocno(),getHidcldocno(),getSourceid(),getTxtsalesmandocno(),getTxtdesc(),enqarray,session,getMode(),getFormdetailcode(),request,sitearray,getNetamount(),getCmbbillingmethod(),getCmbpayterm(),getHidcpersonid(),getTxtmob(),getTxttele(),getTxtmail(),getTxtcperson());  
			String vdocno=request.getAttribute("vocno").toString();      
			
			if(val>0){ 
				setHidquoteDate(sqlStartDate.toString());
				subdata();
				setDocno(vdocno);
				setMasterdoc_no(val);  
				setMsg("Successfully Saved");
				return "success";
			}
			else{
				subdata();
				setDocno(vdocno);
				setMasterdoc_no(val);  
				setMsg("Not Saved");
				return "fail";
			}
		}else if(mode.equalsIgnoreCase("E")){ 
			boolean Status=QuoteDAO.edit(getMasterdoc_no(),getDocno(),sqlStartDate,getHidenqdocno(),getHidcldocno(),getSourceid(),getTxtsalesmandocno(),getTxtdesc(),enqarray,session,getMode(),getFormdetailcode(),request,sitearray,getNetamount(),getCmbbillingmethod(),getCmbpayterm(),getHidcpersonid(),getTxtmob(),getTxttele(),getTxtmail(),getTxtcperson());
			if(Status){ 
				setHidquoteDate(sqlStartDate.toString());
				subdata();
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());  
				setMsg("Updated Successfully");
				return "success"; 
			}
			else{
				subdata();
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());   
				setMsg("Not Updated");  
				return "fail";
				
			}
		}else if(mode.equalsIgnoreCase("D")){ 
			boolean Status=QuoteDAO.delete(getMasterdoc_no(),sqlStartDate,getMode(),getFormdetailcode(),session);   
			if(Status){
			    sqlStartDate= com.changeStringtoSqlDate(getQuoteDate());
				setHidquoteDate(sqlStartDate.toString());  
				subdata();
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());  
				setMsg("Successfully Deleted");
				setDeleted("DELETED");
				return "success";
			}
			else{
				subdata();
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());  
				setMsg("Not Deleted");
				return "fail";
			}
		}else if(mode.equalsIgnoreCase("R")){        
			boolean Status=QuoteDAO.revise(sqlStartDate,getMasterdoc_no(),getDocno(),session,request,sitearray,enqarray,getTxtdesc(),getCmbbillingmethod(),getCmbpayterm(),getHidcpersonid(),getTxtmob(),getTxttele(),getTxtmail(),getTxtcperson()); 
			if(Status){   
				setTxtrevise(request.getAttribute("revisionno").toString());  
				setHidquoteDate(sqlStartDate.toString());
				subdata();  
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());  
				setMsg("Updated Successfully");
				return "success"; 
			}
			else{
				subdata();
				setDocno(getDocno());
				setMasterdoc_no(getMasterdoc_no());   
				setMsg("Not Updated");  
				return "fail";
				
			}
		}
		if(mode.equalsIgnoreCase("view")){
			// System.out.println(getMasterdoc_no()+"==="+getDocno());
			 //setMasterdoc_no( (getMasterdoc_no()==0?Integer.parseInt(getDocno()):getMasterdoc_no()));
			pintbean=QuoteDAO.getViewDetails(session,getDocno());   
			setHidquoteDate(pintbean.getDate()!=null?pintbean.getDate().toString():""); 
			setHidenqdocno(pintbean.getHidenqdocno());
			setHidcldocno(pintbean.getHidcldocno());
			setSourceid(pintbean.getSourceid());
			setTxtsalesmandocno(pintbean.getTxtsalesmandocno());
			//setComptel(pintbean.getComptel());
			setTxtdesc(pintbean.getTxtdesc());  
			setTxtenquiry(pintbean.getTxtenquiry());
			setTxtclient(pintbean.getTxtclient());
			setTxtsource(pintbean.getTxtsource());  
			setTxtsalesman(pintbean.getTxtsalesman());
			setTxtaddress(pintbean.getTxtaddress());
			setTxtmail(pintbean.getTxtmail());
			setTxtmob(pintbean.getTxtmob());
			setTxttele(pintbean.getTxttele());  
			setTxtgroupcompanies(pintbean.getTxtgroupcompanies());
//			System.out.println("grp="+pintbean.getTxtgroupcompanies());  
			setHidcmbbillingmethod(pintbean.getCmbbillingmethod());        
			setCmbbillingmethod(pintbean.getCmbbillingmethod());
			setCmbpayterm(pintbean.getCmbpayterm());   
			setHidcmbpayterm(pintbean.getCmbpayterm());  
			setMasterdoc_no(pintbean.getMasterdoc_no());
			setDocno(pintbean.getDocno()); 
			setHidcpersonid(pintbean.getHidcpersonid());
			setTxtcperson(pintbean.getTxtcperson());  
			setTxtdesig(pintbean.getTxtdesig());   
		}
		return "fail";	 

	}  
	public void subdata() {         
		setHidenqdocno(getHidenqdocno());
		setHidcldocno(getHidcldocno());
		setSourceid(getSourceid());
		setTxtsalesmandocno(getTxtsalesmandocno());
		setTxtdesc(getTxtdesc());  
		setTxtenquiry(getTxtenquiry());
		setTxtclient(getTxtclient());
		setTxtsource(getTxtsource());  
		setTxtsalesman(getTxtsalesman());
		setNetamount(getNetamount());
		setTxtaddress(getTxtaddress());
		setTxtmail(getTxtmail());
		setTxtmob(getTxtmob());
		setTxttele(getTxttele());  
		setTxtgroupcompanies(getTxtgroupcompanies());
		setHidcmbbillingmethod(getCmbbillingmethod());        
		setCmbbillingmethod(getCmbbillingmethod());
		setCmbpayterm(getCmbpayterm());   
		setHidcmbpayterm(getCmbpayterm());  
		setTxtrevise(getTxtrevise()); 
		setTxtcperson(getTxtcperson());
		setHidcpersonid(getHidcpersonid());  
		setComptel(getComptel());
		setTxtdesig(getTxtdesig());   
   }
	
public String printAction() throws Exception{   

//	System.out.println("PRINT ACTION");
	Connection conn = null;
	try {
	HttpServletRequest request=ServletActionContext.getRequest();
	HttpSession session=request.getSession();
	ClsQuotationBean bean = new ClsQuotationBean();
	ClsQuotationDAO DAO= new  ClsQuotationDAO();
	
	String docno=request.getParameter("docno").toString();
	String brhid=request.getParameter("branch").toString();  
	String typeid=request.getParameter("typeid").toString();    
	String valuee=request.getParameter("valuee").toString(); 
	String dtype=request.getParameter("dtype").toString();
	//String mail=request.getAttribute("mail")==null || request.getAttribute("mail").toString().equalsIgnoreCase("")?"0":request.getAttribute("mail").toString();
	//bean=DAO.printMaster(session,docno,brhid,trno,dtype);
	//System.out.println(dtype);
	if(com.getPrintPath("QOT").contains(".jrxml"))
	{
	//System.out.println("in 2");
	    HttpServletResponse response = ServletActionContext.getResponse();
		
		String reportFileName = "";
		
     	param = new HashMap();
 		     
			 conn = conobj.getMyConnection();
			 Statement stmt=conn.createStatement();   
			 //param.put("mob", bean.getTxtmob());
			 int draftstatus=0;
			 String first_salName="",revisionno="",ctype="",mob="",email="",refname="",date="",sal_name="",billingmethod="",contactperson="",payterms="",clientphone="",salesmob="",salesemail="",clientdesig="",clientdesig1="",clienttrn="",tradelicense="";
			 
			 String clsql12= "select case when m.billingmethod=1 then 'Monthly' when m.billingmethod=2 then 'Yearly' when m.billingmethod=3 then 'Adhoc' end billmethodname,coalesce(r6.name,'') ctype,rd.docidnum,pt.desc1 payterms,em.cperson,m.billingmethod billingmethod,round(coalesce(m.netamount,0),2) netamount,date_format(m.date,'%d.%m.%Y') date,em.com_add1,ac.trnnumber, em.mob, em.telno, em.email,em.designstat,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,em.name refname,sc.txtname source,m.source_id,sm.sal_name,sm.mob_no,sm.mail,m.sal_id,m.cldocno from sk_srvqotm m left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_enqsource sc on sc.doc_no=m.source_id left join my_salm sm on sm.doc_no=m.sal_id left join sk_payterms pt on pt.srno=m.payterms left join rl_cldoc rd on rd.cldocno=ac.cldocno  and rd.docid=1 left join sk_srvqotdet d on d.rdocno=m.tr_no left join sk_enqrelated r6 on (r6.srno=d.ctypeid and r6.type='CTYPE') where m.tr_no='"+docno+"'";
			 ResultSet rs62 = stmt.executeQuery(clsql12);  
			 while(rs62.next()){
				 ctype=rs62.getString("ctype");
			 }
			 
			 String clsql= "select av.ay_name desig,case when m.billingmethod=1 then 'Monthly' when m.billingmethod=2 then 'Yearly' when m.billingmethod=3 then 'Adhoc' end billmethodname,en.name Ownership,r6.name ctype,rd.docidnum,pt.desc1 payterms,coalesce(dp.name,'') designation,coalesce(m.cperson,'') cperson,m.billingmethod billingmethod,round(coalesce(m.netamount,0),2) netamount,date_format(m.date,'%d.%m.%Y') date,em.com_add1,ac.trnnumber, em.mob, em.telno, em.email,em.designstat,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,em.name refname,sc.txtname source,m.source_id,SUBSTRING_INDEX(SUBSTRING_INDEX(sm.SAL_name, ' ', 1), ' ', -1) AS first_salName,sm.sal_name,sm.mob_no,sm.mail,m.status,m.sal_id,coalesce(m.revision_no,'') revision_no,m.cldocno from sk_srvqotm m left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_enqsource sc on sc.doc_no=m.source_id left join my_salm sm on sm.doc_no=m.sal_id left join sk_payterms pt on pt.srno=m.payterms left join rl_cldoc rd on rd.cldocno=ac.cldocno  and rd.docid=1 left join sk_enqrelated r6 on r6.type='CTYPE' left join sk_enqrelated en on en.type='SERVICEBY' left join my_crmcontact cp on cp.row_no=m.cpersonid left join sk_cldept dp on dp.doc_no=cp.dept_id left join my_activity av on av.doc_no=em.activityid where m.tr_no='"+docno+"'"; 
		     //System.out.println("====Main Search===="+clsql);          
			 ResultSet rs6 = stmt.executeQuery(clsql);  
			 while(rs6.next()){
				                 first_salName=rs6.getString("first_salName");
				                 revisionno=rs6.getString("revision_no");
                                 draftstatus=rs6.getInt("status"); 
								 tradelicense=rs6.getString("docidnum");
							     clienttrn=rs6.getString("trnnumber");
								 clientdesig1=rs6.getString("desig");
								 clientdesig=rs6.getString("designstat");
								 salesmob=rs6.getString("mob_no");
								 salesemail=rs6.getString("mail");
								 clientphone=rs6.getString("telno");
								 mob=rs6.getString("mob");
								 sal_name=rs6.getString("sal_name");
								 date=rs6.getString("date");
								 refname=rs6.getString("refname");
								 email=rs6.getString("email");
				                 billingmethod=rs6.getString("billmethodname");
				                 contactperson=rs6.getString("cperson");  
				                 payterms=rs6.getString("payterms");  
		
			 }
			 ArrayList<String> arr=new ArrayList<>();
			 String clsql1="select site site,dm.name wastetype,sk.name SkipType,sc.name Spec,coalesce(en.name,'') Ownership,d.nos Qty,coalesce(en1.name,'') ServiceTerm,d.scheduledays Noofvisits,coalesce(en2.name,'') Collection,round(rate,2) RateCollection,foc FOCTrips,round(rent,2) SkipRent,round(d.securityval,2) Security,coalesce(en3.name,'') TippingFeeMethod,round(d.tippingfee,2) TippingFee,round(d.tippingsecurity,2) TippingFeeSecurity,if(d.restricted=1,'Yes','No') Restricted from sk_srvqotdet d left join sk_dumptype dm on dm.doc_no=d.wastetype left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_spec sc on sc.doc_no=d.specid left join sk_enqrelated en on en.srno=d.ownershipid and en.type='SERVICEBY' left join sk_enqrelated en1 on en1.srno=d.servicetermid  and en1.type='SCHEDULE' left join sk_enqrelated en2 on en2.srno=d.servicetermid  and en2.type='COLLECTION' left join sk_enqrelated en3 on en3.srno=d.tippingmethod  and en3.type='TIPPINGFEEMETHOD' where d.rdocno='"+docno+"'";
//			System.out.println("====Main Search===="+clsql1);  
			 ResultSet rs = stmt.executeQuery(clsql1);
			 while(rs.next()){
				 arr.add(rs.getString("wastetype")+"::"+rs.getString("SkipType")+"::"+rs.getString("Spec")+"::"+rs.getString("Ownership")+"::"+rs.getString("Qty")+"::"+rs.getString("ServiceTerm")+"::"+rs.getString("Noofvisits")+"::"+rs.getString("Collection")+"::"+rs.getDouble("RateCollection")+"::"+rs.getString("FOCTrips")+"::"+rs.getDouble("SkipRent")+"::"+rs.getDouble("Security")+"::"+rs.getString("TippingFeeMethod")+"::"+rs.getDouble("TippingFee")+"::"+rs.getDouble("TippingFeeSecurity")+"::"+rs.getString("Restricted")+"::"+rs.getString("site"));
				/* param.put("site"+j,rs.getString("site"));
				 param.put("wastetype"+j,rs.getString("wastetype"));
				 param.put("skiptype"+j, rs.getString("SkipType"));
				 param.put("spec"+j, rs.getString("Spec"));
				 param.put("ownership"+j,rs.getString("Ownership"));
				 param.put("qty"+j, rs.getString("Qty"));
				 param.put("serviceterm"+j, rs.getString("ServiceTerm"));
				 param.put("noofvisits"+j, rs.getString("Noofvisits"));
				 param.put("collection"+j, rs.getString("Collection"));
				 param.put("ratecollection"+j, rs.getDouble("RateCollection"));
				 param.put("foctrips"+j, rs.getString("FOCTrips"));
				 param.put("skiprent"+j,rs.getDouble("SkipRent"));
				 param.put("security"+j, rs.getDouble("Security"));
				 param.put("tippingfeemethod"+j, rs.getString("TippingFeeMethod"));
				 param.put("tippingfee"+j, rs.getDouble("TippingFee"));
				 param.put("tippingfeesecurity"+j, rs.getDouble("TippingFeeSecurity"));
				 param.put("restricted"+j, rs.getString("Restricted"));
				 param.put("val"+j, j);*/
			 }
//			 System.out.println(arr.size()+"----arr--->>>"+arr);
			 for(int i=0,j=1;i<arr.size();i++,j++){
//				 System.out.println("array="+arr.get(i));
				 param.put("wastetype"+j, arr.get(i).split("::")[0]);
				 param.put("skiptype"+j, arr.get(i).split("::")[1]);
				 param.put("spec"+j, arr.get(i).split("::")[2]);
				 param.put("ownership"+j, arr.get(i).split("::")[3]);
				 param.put("qty"+j, arr.get(i).split("::")[4]);
				 param.put("serviceterm"+j, arr.get(i).split("::")[5]);
				 param.put("noofvisits"+j, arr.get(i).split("::")[6]);
				 param.put("collection"+j, arr.get(i).split("::")[7]);
				 param.put("ratecollection"+j, Double.parseDouble(arr.get(i).split("::")[8]));
				 param.put("foctrips"+j, arr.get(i).split("::")[9]);
				 param.put("skiprent"+j, Double.parseDouble(arr.get(i).split("::")[10]));
				 param.put("security"+j, Double.parseDouble(arr.get(i).split("::")[11]));
				 param.put("tippingfeemethod"+j, arr.get(i).split("::")[12]);
				 param.put("tippingfee"+j, Double.parseDouble(arr.get(i).split("::")[13]));
				 param.put("tippingfeesecurity"+j, Double.parseDouble(arr.get(i).split("::")[14]));
				 param.put("restricted"+j, arr.get(i).split("::")[15]);
				 param.put("site"+j,arr.get(i).split("::")[16]);
//				 System.out.println(j+"----------inside array "+param);
			 }
			/* for(int k=arr.size();k<=15;k++){
				 param.put("wastetype"+k, "");
				 param.put("skiptype"+k, "");
				 param.put("spec"+k, "");
				 param.put("ownership"+k, "");
				 param.put("qty"+k, "");
				 param.put("serviceterm"+k, "");
				 param.put("noofvisits"+k, "");
				 param.put("collection"+k, "");
				 param.put("ratecollection"+k, 0.00);
				 param.put("foctrips"+k, "");
				 param.put("skiprent"+k, 0.00);
				 param.put("security"+k, 0.00);
				 param.put("tippingfeemethod"+k, "");
				 param.put("tippingfee"+k, 0.00);
				 param.put("tippingfeesecurity"+k, 0.00);
				 param.put("restricted"+k, "");
				 param.put("site"+k,"");
				 System.out.println(k+"----------inside array "+param);
			 }*/
			
			 
			 String site="",spec="";
			 String sitesql="select d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, d.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, 0 adminfee, d.rent, d.foc,r2.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection  from sk_srvqotdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumpsite ds on ds.doc_no=d.wastetype left join sk_enqrelated r1 on (r1.rowno=d.ownershipid and r1.type='METHOD') left join sk_enqrelated r2 on (r2.rowno=d.ownershipid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.rowno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.rowno=d.collectionid and r4.type='COLLECTION') where d.rdocno='"+docno+"'";			
			 //System.out.println("====Main Search===="+sitesql);
			 ResultSet rs2=stmt.executeQuery(sitesql);
			 while(rs2.next()){
			 site=rs2.getString("site");
			 spec=rs2.getString("spec");
			 //System.out.println("site=="+site);
			 }
			 String typeid2="";
			 String billingmethod1="select distinct typeid srno,type desc1 FROM sk_qterms";
			 ResultSet rs3=stmt.executeQuery(billingmethod1);
			 while(rs3.next()){
				 typeid2=rs3.getString("desc1");
			 }
			 
			 String company="";
			 String companysql = "select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno from sk_srvqotm r inner join my_brch b on  "
						+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
						+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.tr_no='"
						+ docno + "' ";
//				 System.out.println("----------------"+companysql);
				ResultSet rs1 = stmt.executeQuery(companysql);

				while (rs1.next()) {
					company=rs1.getString("company");
					//bean.setLblbranchtrno(resultsetcompany.getString("tinno"));
					   //bean.setEasycmp(bean.getEasycmp()+resultsetcompany.getString("tinno")); 	   
					    	 // branch=resultsetcompany.getString("branchname");
					    	 //  bean.setLblcompname(resultsetcompany.getString("company"));
					    	  
					    	  // bean.setLblcompaddress(resultsetcompany.getString("address"));
					    	 
					    	   bean.setComptel(rs1.getString("tel"));
					    	  
					    	  // bean.setLblcompfax(resultsetcompany.getString("fax"));
					    	 
					    	  
					    	 
					    	   
					       }
				String billingmethodctype=billingmethod+" ("+ctype+")";
			if(billingmethod.equalsIgnoreCase("yearly") && ctype.equalsIgnoreCase("rent"))
			{
				billingmethodctype=billingmethod+" (FIXED)";
			}
			String sitearea="";
			String sitesql1="select d.site,coalesce(a.Area,'') Area,s.areaid from sk_srvqotm m left join sk_srvqotdet d on d.rdocno=m.tr_no left join sk_servsited s on (s.tr_no=m.tr_no and s.revision_no=d.revision_no and d.site=s.site)  left join my_area a on a.doc_no=s.areaId where d.revision_no='"+revisionno+"' and d.rdocno='"+docno+"'  union all select s.site,'' Area,s.areaid from sk_srvqotm m left join sk_srvcontrdetr d on d.rdocno=m.tr_no left join sk_servsited s on s.tr_no=m.tr_no and s.revision_no=d.revision_no where d.revision_no='"+revisionno+"' and d.rdocno='"+docno+"'"; 
			ResultSet rsite = stmt.executeQuery(sitesql1);
				 while(rsite.next()){
			      sitearea=rsite.getString("Area"); 
				 }
				//String billingmethodctype=billingmethod+" ("+ctype+")";
			//System.out.println("sitesql1=="+sitesql1);
			 param.put("billingmethod",billingmethodctype);
                         param.put("draftstatus", draftstatus);
			//param.put("billingmethod",typeid2);
			 param.put("company", company);
			 param.put("comptel", bean.getComptel());
			 param.put("mob", mob);
			 param.put("salesmob",salesmob);
			 param.put("clientdesig", clientdesig);
			 param.put("clientdesig1", clientdesig1);
			 param.put("salesemail", salesemail);
			 param.put("clientphone",clientphone);
			 param.put("trnno",clienttrn);
			 param.put("tradelicence",tradelicense);
			 param.put("client", refname);
			 param.put("docno",docno);
			 param.put("revisionno",revisionno);
			// System.out.println("revisionno=="+revisionno);
			 param.put("email",email);
			 param.put("date", date);
			 param.put("salesperson",first_salName);
			 //param.put("siteno",site);
			 param.put("siteno",site+" - "+sitearea);
			 param.put("spectype",spec);
             //param.put("billingmethod",billingmethod);  
              param.put("contperson",contactperson);
			 param.put("payterms", payterms);
			 setUrl(com.getPrintPath("QOT"));
			 param.put("typeid", typeid);
			 param.put("dtype", dtype);
			// System.out.println("typeid=="+typeid);
			 param.put("valuee", valuee);   
		     
		        String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
			 headerimgpath=headerimgpath.replace("\\", "\\\\");
			 
			 String sealimgpath=request.getSession().getServletContext().getRealPath("/icons/image_2022_02_24T11_36_19_015Z.png");
			 sealimgpath=sealimgpath.replace("\\", "\\\\");
	         
			 
			 String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
		         footerimgpath=footerimgpath.replace("\\", "\\\\");
		         param.put("headerimgpath", headerimgpath);
		         param.put("sealimgpath", sealimgpath);
	                 param.put("footerimgpath", footerimgpath);
			    //imgpath=request.getSession().getServletContext().getRealPath("/icons/amcfooter.jpg");
			    //imgpath=imgpath.replace("\\", "\\\\");
			   
	          	       
	         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
     	 
     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
                        
       		            generateReportPDF(response, param, jasperReport, conn);
                 
	}  
//    System.out.println("===== "+getUrl());         
	} catch (Exception e) {

                 e.printStackTrace();

             }
            	 finally{
            		 if(conn!=null){
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
  public String emailAction(String docno,String brhid) throws Exception{  
//		System.out.println("PRINT ACTION");
		Connection conn = null;
		try {
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		ClsQuotationBean bean = new ClsQuotationBean();
		ClsQuotationDAO DAO= new  ClsQuotationDAO();
		
		//String mail=request.getAttribute("mail")==null || request.getAttribute("mail").toString().equalsIgnoreCase("")?"0":request.getAttribute("mail").toString();
		//bean=DAO.printMaster(session,docno,brhid,trno,dtype);
		
		if(com.getPrintPath("QOT").contains(".jrxml"))
		{
//		System.out.println("in 2");
		    HttpServletResponse response = ServletActionContext.getResponse();
			
			String reportFileName = "";
			
	     	param = new HashMap();
	 		     
				 conn = conobj.getMyConnection();
				 Statement stmt=conn.createStatement();   
				 //param.put("mob", bean.getTxtmob());
				 String first_salName="",mob="",email="",refname="",date="",sal_name="",billingmethod="",ctype="";
				 
				 String contactperson="";
				
				 String clsql= "select  em.cperson,m.billingmethod billingmethod,round(coalesce(m.netamount,0),2) netamount,date_format(m.date,'%d.%m.%Y') date,em.com_add1, em.mob, em.telno, em.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,em.name refname,sc.txtname source,m.source_id,SUBSTRING_INDEX(SUBSTRING_INDEX(sm.SAL_name, ' ', 1), ' ', -1) AS first_salName,sm.sal_name,m.sal_id,m.cldocno from sk_srvqotm m left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join cm_enqsource sc on sc.doc_no=m.source_id left join my_salm sm on sm.doc_no=m.sal_id left join my_crmcontact ct on (ct.row_no=em.cpersonid) where m.tr_no='"+docno+"'";
				 //System.out.println("====Main Search===="+clsql);            
				 ResultSet rs = stmt.executeQuery(clsql);  
				 while(rs.next()){
					 mob=rs.getString("mob");
					 first_salName=rs.getString("first_salName");
					 sal_name=rs.getString("sal_name");
					 date=rs.getString("date");
					 refname=rs.getString("refname");
					 email=rs.getString("email");
                   billingmethod=rs.getString("billingmethod");
                   contactperson=rs.getString("cperson"); 
                   
				 }
				 String site="",spec="";
				 String sitesql="select d.wastetype wastedoc,d.skiptype skipdoc,sk.name skiptype, ds.name wastetype, d.rowno, d.site, d.nos, d.ownershipid, d.servicebyid, d.servicetermid, d.scheduledays days, d.specid, d.collectionid, d.rate, 0 adminfee, d.rent, d.foc,r2.name ownership,r2.name serviceby,r3.name serviceterm,sp.name spec,r4.name collection  from sk_srvqotdet d left join sk_skiptype sk on sk.doc_no=d.skiptype left join sk_dumpsite ds on ds.doc_no=d.wastetype left join sk_enqrelated r1 on (r1.rowno=d.ownershipid and r1.type='METHOD') left join sk_enqrelated r2 on (r2.rowno=d.ownershipid and r2.type='SERVICEBY') left join sk_enqrelated r3 on (r3.rowno=d.servicetermid and r3.type='SCHEDULE') left join sk_spec sp on (sp.doc_no=d.specid) left join sk_enqrelated r4 on (r4.rowno=d.collectionid and r4.type='COLLECTION') where d.rdocno='"+docno+"'";				
				 //System.out.println("====Main Search===="+sitesql);
				 ResultSet rs2=stmt.executeQuery(sitesql);
				 while(rs2.next()){
				 site=rs2.getString("site");
				 spec=rs2.getString("spec");
				 }
				 
						 			
				 String company="";
				 String companysql = "select c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno,b.tinno from sk_srvqotm r inner join my_brch b on  "
							+ "r.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name, "
							+ " lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where r.tr_no='"
							+ docno + "' ";
//					 System.out.println("----------------"+companysql);
					ResultSet rs1 = stmt.executeQuery(companysql);

					while (rs1.next()) {
						company=rs1.getString("company");
						//bean.setLblbranchtrno(resultsetcompany.getString("tinno"));
						   //bean.setEasycmp(bean.getEasycmp()+resultsetcompany.getString("tinno")); 	   
						    	 // branch=resultsetcompany.getString("branchname");
						    	 //  bean.setLblcompname(resultsetcompany.getString("company"));
						    	  
						    	  // bean.setLblcompaddress(resultsetcompany.getString("address"));
						    	 
						    	   //bean.setComptel(rs1.getString("tel"));
						    	  
						    	  // bean.setLblcompfax(resultsetcompany.getString("fax"));
						    	  // bean.setLbllocation(resultsetcompany.getString("location"));
						    	  
						    	 
						    	   
						       } 
				 param.put("company", company);
				 param.put("mob", mob);
				 param.put("client", refname);
				 param.put("docno",docno);
				 param.put("email",email);
				 param.put("date", date);
				 param.put("salesperson",first_salName);
				 param.put("siteno",site);
                
                // param.put("billingmethod",billingmethodctype);
                 
                 param.put("contperson", contactperson);

				 
				 setUrl(com.getPrintPath("QOT"));
			   
			        String headerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityheader.png");
				 headerimgpath=headerimgpath.replace("\\", "\\\\");
				 
				 String footerimgpath=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
			         footerimgpath=footerimgpath.replace("\\", "\\\\");
			         param.put("headerimgpath", headerimgpath);
		                 param.put("footerimgpath", footerimgpath);
				    //imgpath=request.getSession().getServletContext().getRealPath("/icons/amcfooter.jpg");
				    //imgpath=imgpath.replace("\\", "\\\\");
				   
		          	       
		         JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath(getUrl()));
	     	 
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
	                        
	       		        	generateReportEmail(response, param, jasperReport, conn,docno,session,brhid,request);
	                 
		}  
//	    System.out.println("===== "+getUrl());         
		} catch (Exception e) {

	                 e.printStackTrace();

	             }
	            	 finally{
	            		 if(conn!=null){
	            			 conn.close();
	            		 }
				} 
		
		return "print";
	}
	private void generateReportEmail(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn,String docno,HttpSession session,String brhid,HttpServletRequest request)throws JRException, NamingException, SQLException, IOException, AddressException, MessagingException {
		try{  
			byte[] bytes = null;
		    bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		  	Statement stmt=conn.createStatement();
		  	String fileName="",path="", formcode="QOT",filepath=""; 
		  	//Deleting Existing Internal Attachments
		  	String strgetattach="select path from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999";
		  	ResultSet rsgetattach=stmt.executeQuery(strgetattach);
		  	while(rsgetattach.next()){
		  		String deletepath=rsgetattach.getString("path");
		  		File deletefile = new File(deletepath);
		  		deletefile.delete(); 
		  	}
		  	int deleteFileEntry=stmt.executeUpdate("delete from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"' and ref_id=999");
		  	
		  	String host="", port="", userName="", password="", recipient="", message="",docnos="1";
		  	String strSql1 = "select imgPath from my_comp";
			ResultSet rs1 = stmt.executeQuery(strSql1);
			while(rs1.next ()) {
				path=rs1.getString("imgPath");
			}
			//path=path.replace("\\", "/");
			String srno="";
			String strSql = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+docno+" and dtype='"+formcode+"'";
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				srno=rs.getString("srno");
			}
				
			fileName = formcode+"-"+docno+"-"+srno+".pdf";
			filepath=path+ "\\attachment\\"+formcode+"\\"+fileName;

			File dir = new File(path+ "\\attachment\\"+formcode); 
			dir.mkdirs();
			JasperPrint print = JasperFillManager.fillReport(jasperReport, parameters);
		  	JasperExportManager.exportReportToPdfFile(print, filepath);	
			
		    CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");     
			stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
			stmtAttach.setString(1,formcode);
			stmtAttach.setString(2,docno);
			stmtAttach.setString(3,session.getAttribute("BRANCHID")==null?brhid:session.getAttribute("BRANCHID").toString());
			stmtAttach.setString(4,session.getAttribute("USERNAME").toString());
			stmtAttach.setString(5,path+"\\attachment\\"+formcode+"\\"+fileName);
			stmtAttach.setString(6,fileName);
			stmtAttach.setString(7,"");
			stmtAttach.setString(8,"999");
			stmtAttach.executeQuery();
			int no=stmtAttach.getInt("srNo");
			if(no<=0){
				System.out.println("Insert Error");
			}
		}
		catch(Exception e){
			e.printStackTrace();  
		}
  }
}