package com.cargo.estimation;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;
import java.util.HashMap;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;    
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;    

public class ClsEstimationAction {
	ClsCommon ClsCommon=new ClsCommon();
	ClsEstimationDAO DAO = new ClsEstimationDAO();
	ClsConnection connDAO = new ClsConnection();      
	private String estmDate,hidestmDate,cmbreftype,txtclient,txtclientname,txtaddress,txtmobile,txtemail,txtRemarks,mode,deleted,enqdtype,enqgridlenght,gridval,forradiochk,brandval,fromdatesval,todateval,txtradio,msg;
	private int refno,hidrefno,docno,masterdoc_no;
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
	public String getCmbreftype() {
		return cmbreftype;
	}
	public void setCmbreftype(String cmbreftype) {
		this.cmbreftype = cmbreftype;
	}
	public String getTxtclient() {
		return txtclient;
	}
	public void setTxtclient(String txtclient) {
		this.txtclient = txtclient;
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
	public String getTxtemail() {
		return txtemail;
	}
	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	public String getTxtRemarks() {
		return txtRemarks;
	}
	public void setTxtRemarks(String txtRemarks) {
		this.txtRemarks = txtRemarks;
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
	public String getEnqdtype() {
		return enqdtype;
	}
	public void setEnqdtype(String enqdtype) {
		this.enqdtype = enqdtype;
	}
	public String getEnqgridlenght() {
		return enqgridlenght;
	}
	public void setEnqgridlenght(String enqgridlenght) {
		this.enqgridlenght = enqgridlenght;
	}
	public String getGridval() {
		return gridval;
	}
	public void setGridval(String gridval) {
		this.gridval = gridval;
	}
	public String getForradiochk() {
		return forradiochk;
	}
	public void setForradiochk(String forradiochk) {
		this.forradiochk = forradiochk;
	}
	public String getBrandval() {
		return brandval;
	}
	public void setBrandval(String brandval) {
		this.brandval = brandval;
	}
	public String getFromdatesval() {
		return fromdatesval;
	}
	public void setFromdatesval(String fromdatesval) {
		this.fromdatesval = fromdatesval;
	}
	public String getTodateval() {
		return todateval;
	}
	public void setTodateval(String todateval) {
		this.todateval = todateval;
	}
	public String getTxtradio() {
		return txtradio;
	}
	public void setTxtradio(String txtradio) {
		this.txtradio = txtradio;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getRefno() {
		return refno;
	}
	public void setRefno(int refno) {
		this.refno = refno;
	}
	
	public int getHidrefno() {
		return hidrefno;
	}
	public void setHidrefno(int hidrefno) {
		this.hidrefno = hidrefno;
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
	
	//print
	private String url;
	private String lblcompname,lblcompaddress,lblcomptel,lblcompfax,lblcompemail,lblbranchtrno,lblprintname,lbllocation;
	private String lblclientname,lbladdress,lblmobile,lbldocno,lbldate,lblenquiryno,lblremarks;
	
	public String getLblprintname() {
		return lblprintname;
	}
	public void setLblprintname(String lblprintname) {
		this.lblprintname = lblprintname;
	}
	public String getLblcompname() {
		return lblcompname;
	}
	public void setLblcompname(String lblcompname) {
		this.lblcompname = lblcompname;
	}
	public String getLbllocation() {
		return lbllocation;
	}
	public void setLbllocation(String lbllocation) {
		this.lbllocation = lbllocation;
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
	public String getLblcompemail() {
		return lblcompemail;
	}
	public void setLblcompemail(String lblcompemail) {
		this.lblcompemail = lblcompemail;
	}
	public String getLblbranchtrno() {
		return lblbranchtrno;
	}
	public void setLblbranchtrno(String lblbranchtrno) {
		this.lblbranchtrno = lblbranchtrno;
	}
	public String getLblclientname() {
		return lblclientname;
	}
	public void setLblclientname(String lblclientname) {
		this.lblclientname = lblclientname;
	}
	public String getLbladdress() {
		return lbladdress;
	}
	public void setLbladdress(String lbladdress) {
		this.lbladdress = lbladdress;
	}
	public String getLblmobile() {
		return lblmobile;
	}
	public void setLblmobile(String lblmobile) {
		this.lblmobile = lblmobile;
	}
	public String getLbldocno() {
		return lbldocno;
	}
	public void setLbldocno(String lbldocno) {
		this.lbldocno = lbldocno;
	}
	public String getLbldate() {
		return lbldate;
	}
	public void setLbldate(String lbldate) {
		this.lbldate = lbldate;
	}
	public String getLblenquiryno() {
		return lblenquiryno;
	}
	public void setLblenquiryno(String lblenquiryno) {
		this.lblenquiryno = lblenquiryno;
	}
	public String getLblremarks() {
		return lblremarks;
	}
	public void setLblremarks(String lblremarks) {
		this.lblremarks = lblremarks;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	private Map<String, Object> param=null;
	public Map<String, Object> getParam() {
		return param;
	}

	public void setParam(Map<String, Object> param) {
		this.param = param;
	}   
	
	public String saveAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();  
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		java.sql.Date masterdate = ClsCommon.changeStringtoSqlDate(getEstmDate());

		if(mode.equalsIgnoreCase("A")){
			int val = DAO.insert(masterdate,getCmbreftype(),getHidrefno(),getTxtclient(),getTxtclientname(),getTxtaddress(),getTxtmobile(),getTxtemail(),getTxtRemarks(),getMode(),getDeleted(),getEnqdtype(),getEnqgridlenght(),getGridval(),getForradiochk(),getBrandval(),getFromdatesval(),getTodateval(),getTxtradio(),getMsg(),session,request);
			if(val>0){
				int vdocno=(int) request.getAttribute("vocno");  
				setData(masterdate);
				setDocno(vdocno);
				setMasterdoc_no(val);
				setMsg("Successfully Saved");
				return "success";
			}else if(val==-1){       
				setData(masterdate);
				setMsg("Not Saved");   
				return "fail";
			}else{
				setData(masterdate);
				setMsg("Not Saved");
				return "fail";
			}
		}
		
		else if(mode.equalsIgnoreCase("E")){
			boolean status=DAO.edit(getMasterdoc_no(), masterdate, getCmbreftype(),getHidrefno(), getTxtclient(), getTxtclientname(), getTxtaddress(),
					getTxtmobile(), getTxtemail(), getTxtRemarks(), getMode(), getDeleted(), getEnqdtype(), getEnqgridlenght(), getGridval(), getForradiochk(),
					getBrandval(), getFromdatesval(), getTodateval(), getTxtradio(), getMsg(), session, request);
			if(status){
				setData(masterdate);
				setMsg("Updated Successfully");
				return "success";
			}
			else{
				setData(masterdate);
				setMsg("Not Updated");
				return "fail";
			}
		}
		else if(mode.equalsIgnoreCase("D")){
			boolean Status=DAO.delete(getMasterdoc_no(),session,getMode());
			if(Status){
				
				
			}
		}
		
		return "success";
	}
	
	public void setData(Date masterdate) {
		setEstmDate(masterdate.toString());
		setHidestmDate(masterdate.toString());
		//System.out.println("--date--  "+getEstmDate()+"  |||  "+getHidestmDate());
		setCmbreftype(getCmbreftype());
		setTxtclient(getTxtclient());
		setTxtclientname(getTxtclientname());
		setTxtaddress(getTxtaddress());
		setTxtmobile(getTxtmobile());
		setTxtemail(getTxtemail());
		setTxtRemarks(getTxtRemarks());
		setMode(getMode());
		setDeleted(getDeleted());
		setEnqdtype(getEnqdtype());
		setEnqgridlenght(getEnqgridlenght());
		setGridval(getGridval());
		setForradiochk(getForradiochk());
		setBrandval(getBrandval());
		setFromdatesval(getFromdatesval());
		setTodateval(getTodateval());
		setTxtradio(getTxtradio());
		setMsg(getMsg());
		setRefno(getRefno());
		setHidrefno(getHidrefno());
		setDocno(getDocno());
		setMasterdoc_no(getMasterdoc_no());
	}
	
	/*public String printAction() throws ParseException, SQLException{
		
		  HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		  int doc=Integer.parseInt(request.getParameter("docno"));
		  ClsEstimationBean bean=new ClsEstimationBean();
		  String dtype=request.getParameter("dtype");
		  
		  bean=DAO.getPrint(docno,request,session);
		  setUrl(ClsCommon.getPrintPath(dtype));
		  setLbldate(bean.getLbldate());
		 setLblcompname(bean.getLblcompname());
		 setLblcompaddress(bean.getLblcompaddress());
		 setLblcomptel(bean.getLblcomptel());
		 setLblcompfax(bean.getLblcompfax());
		setLblprintname("QUOTATION");   
		setLblbranchtrno(bean.getLblbranchtrno());
		setLbllocation(bean.getLbllocation());
		
		setLblclientname(bean.getLblclientname());
		setLbladdress(bean.getLbladdress());
		setLblmobile(bean.getLblmobile());
		setLbldocno(bean.getLbldocno());
		setLbldate(bean.getLbldate());
		setLblenquiryno(bean.getLblenquiryno());
		
		 
		  return "print";
	}*/
	public String printAction() throws ParseException, SQLException{           
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		int doc=Integer.parseInt(request.getParameter("docno")); 
		String dtype=request.getParameter("dtype");
		ResultSet rs=null,rss=null;      
	    HttpServletResponse response = ServletActionContext.getResponse();
		String tinno="",email="",refname="",mob="",claddress="",vocno="",date="",estsql1="",estsql2="",estsql3="",address="",imgpath="",comp="",tel="",fax="",cmpname="",branch="",printedby="",nettotal="",sql2=""; 
		param = new HashMap();      
		Connection conn = null;
		Statement stmt =null;
		String brhid=session.getAttribute("BRANCHID").toString();  
		String doctype="CESM";  
		try {	  
			  conn = connDAO.getMyConnection();    
			  stmt=conn.createStatement();
			  
			  String sql123="select USER_NAME,email from my_user where doc_no="+session.getAttribute("USERID").toString()+"";   
			  //System.out.println("print main--->>>"+sql123); 
			  ResultSet rs123 = stmt.executeQuery(sql123);    
			  while(rs123.next()){
				 printedby=rs123.getString("USER_NAME");  
				 email=rs123.getString("email");    
			  }     
			  String sql="select b.tinno,m.voc_no,date_format(m.date,'%d.%m.%Y') date,em.voc_no enqno,ac.refname,ac.address,ac.per_mob,ac.mail1,m.remarks,em.doc_no enqdoc, "
						+" b.branchname,b.address branchaddress,b.tel branchtel,b.fax branchfax,b.email branchmail,b.tinno,l.loc_name"
						+" from cr_qotm m left join cr_enqm em on m.rrefno=em.doc_no left join my_acbook ac on m.cldocno=ac.cldocno and ac.dtype='crm'"
						+ " left join my_brch b on m.brhid=b.doc_no left join my_locm l on b.doc_no=l.doc_no where m.doc_no="+docno;
			  ResultSet printrs = stmt.executeQuery(sql);         
			  int enqno=0;
			  while(printrs.next()){
					comp=printrs.getString("branchname");
					address=printrs.getString("branchaddress");
					tel=printrs.getString("branchtel");    
					fax=printrs.getString("branchfax");
					branch=printrs.getString("loc_name");     
					enqno=Integer.parseInt(printrs.getString("enqdoc"));  
					refname=printrs.getString("refname");
					claddress=printrs.getString("address");
					mob=printrs.getString("per_mob");
					vocno=printrs.getString("voc_no");
					date=printrs.getString("date"); 
					tinno=printrs.getString("tinno"); 
				}   
			  sql2="select format(sum(d.total),2) total from cr_qotd d where d.rdocno="+doc+" group by d.rdocno";	
			  ResultSet totrs = stmt.executeQuery(sql2);   
				while(totrs.next()){
					nettotal=totrs.getString("total");
				}
			  int i=1,enqdocno=0; 
			  String detband="0";     
			  estsql1="select d.doc_no enqdoc,md.modename mode,sm.submode,sp.shipment,coalesce(t.terms,'') terms,d.origin,"
		      			+ " d.pol,d.pod,d.commodity,d.wight weight,d.noofpacks,d.dimension,d.volume,d.remarks,d.qty"
		      			+ " from cr_enqd d left join cr_mode md on md.doc_no=d.modeid left join cr_smode sm on sm.doc_no=d.smodeid"
		      			+ " left join cr_shipment sp on sp.doc_no=d.shipid left join cr_terms t on t.doc_no=d.termsid where d.rdocno="+enqno;	
			  ResultSet rsest = stmt.executeQuery(estsql1);   
			  while(rsest.next()){
				  param.put("mode"+i,rsest.getString("mode"));  
				  param.put("submode"+i,rsest.getString("submode"));
				  param.put("shipment"+i,rsest.getString("shipment"));
				  param.put("terms"+i,rsest.getString("terms"));
				  param.put("pol"+i,rsest.getString("pol"));
				  param.put("pod"+i,rsest.getString("pod"));
				  param.put("qty"+i,rsest.getString("qty"));    
				  param.put("commidity"+i,rsest.getString("commodity"));   
				  param.put("packs"+i,rsest.getString("noofpacks")); 
				  param.put("dimn"+i,rsest.getString("dimension")); 
				  param.put("volume"+i,rsest.getString("volume")); 
				  param.put("weight"+i,rsest.getString("weight"));   
				  param.put("origin"+i,rsest.getString("origin"));      
				  enqdocno=rsest.getInt("enqdoc");  
				  String qotsql="select s.srvtype servtype,d.remarks,cr.code curr,convert(round(d.rate,2),char(50)) rate,convert(format(d.price,2),char(50)) price,"
							+" convert(round(d.qty,2),char(50)) qty,u.unit uom,convert(format(d.total,2),char(50)) total,convert(format(d.btotal,2),char(50)) basetotal,convert(round(d.total,2),char(50)) total1,convert(round(d.btotal,2),char(50)) basetotal1,d.billing "
							+" from cr_qotd d left join cr_srvtype s on d.typeid=s.doc_no left join my_curr cr on cr.doc_no=d.curid"
							+" left join my_unitm u on u.doc_no=d.uom left join my_acbook ac on ac.cldocno=d.vndid and ac.dtype='VND' where d.rdocno="+doc+" and d.refdocno="+enqdocno+"";    
				  param.put("qotsql"+i,qotsql);
				  param.put("detband"+i,"1");      
				  i++;      
			  }       
			  estsql3="select distinct '  ' no,termsheader terms,m.doc_no,tr.priorno,0 priornos from (select distinct termsid,dtype,tr.priorno from "
			  		+ "my_trterms tr where  tr.dtype='"+doctype+"' and tr.rdocno="+doc+" and tr.brhid="+brhid+" and tr.status=3 )"
			  		+ " tr inner join my_termsm m on(tr.termsid=m.voc_no and m.dtype=tr.dtype) where  m.status=3 group by m.doc_no union all "
			  		+ "select ' * ' no,concat('',conditions) terms,m.doc_no,priorno,1 priornos from my_trterms tr left join my_termsm m on(tr.termsid=m.voc_no and m.dtype=tr.dtype)"
			  		+ " where  tr.dtype='"+doctype+"' and tr.rdocno="+doc+" and tr.brhid="+brhid+" and tr.status=3 and m.status=3 order by doc_no,priorno,priornos";
			            
			  imgpath=request.getSession().getServletContext().getRealPath("/icons/aitsheader.jpg");                    
			  imgpath=imgpath.replace("\\", "\\\\");      
			        //System.out.println("estsql1==="+estsql1);    
			        //System.out.println("estsql2==="+estsql2);
			        System.out.println("estsql3==="+estsql3);      
			        param.put("address",address); 
			        param.put("img",imgpath); 
			        param.put("printedby",printedby);          
			        param.put("comp",comp);   
			        param.put("tel",tel);
			        param.put("fax",fax);
			        param.put("brch",branch);    
			        //param.put("estsql1",estsql1);
			        //param.put("estsql2",estsql2);     
			        param.put("estsql3",estsql3);     
			        param.put("nettotal",nettotal);  
			        param.put("refname",refname);  
			        param.put("mob",mob);  
			        param.put("claddress",claddress);  
			        param.put("date",date);                     
			        param.put("docno",vocno); 
			        param.put("email",email); 
			        param.put("user",printedby);               
			        param.put("trnno",tinno);
			        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/cargo/estimation/quotationprint.jrxml"));       
  	                JasperReport jasperReport = JasperCompileManager.compileReport(design);
  	                generateReportPDF(response, param, jasperReport, conn);           
	               } catch (Exception e) {      

	                 e.printStackTrace();
	             }
	            	 
	            finally{
			conn.close();    
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
