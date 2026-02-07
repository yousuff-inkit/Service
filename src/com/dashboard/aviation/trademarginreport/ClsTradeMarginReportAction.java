package com.dashboard.aviation.trademarginreport;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

public class ClsTradeMarginReportAction {
	ClsCommon commonDAO= new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	
	private Map<String, Object> param = null;
	public Map<String, Object> getParam() {
		return param;
	}
	public void setParam(Map<String, Object> param) {
		this.param = param;
	}
	public void printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session=request.getSession();
	    Connection conn = null;
        java.sql.Date sqlfromDate = null;
        java.sql.Date sqlToDate = null;
        String fromdate=request.getParameter("fromdate");
        String todate=request.getParameter("todate");
        String datefilter=request.getParameter("date");
        String id=request.getParameter("id");
        String clientid=request.getParameter("clientid");
        String portid=request.getParameter("portid");
        String vendorid=request.getParameter("vendorid");
        String sortby=request.getParameter("sortby");
        
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			sqlfromDate = commonDAO.changeStringtoSqlDate(fromdate);
        }
		if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			sqlToDate = commonDAO.changeStringtoSqlDate(todate);
		}
		
		String sql11="",sql12="";
		if(!(sortby.equals("0") || sortby.equals("") || sortby.equals("undefined"))){
			sql12=sql12+" order by "+sortby+" ";
		}
		if(!(clientid.equals("0") || clientid.equals("") || clientid.equals("undefined"))){
			sql11=sql11+" and ac1.cldocno in ("+clientid+")";
		}
		if(!(portid.equals("0") || portid.equals("") || portid.equals("undefined"))){
			sql11=sql11+" and d.portid in ("+portid+")";
		}
		if(!(vendorid.equals("0") || vendorid.equals("") || vendorid.equals("undefined"))){
			sql11=sql11+" and (ac.cldocno in ("+vendorid+") and ac.dtype='VND') ";
		}
		if(sqlfromDate!=null){
			if(datefilter.equalsIgnoreCase("invdate")){
				sql11=sql11+" and m.date>='"+sqlfromDate+"'";
			} else {
				sql11=sql11+" and fm.date>='"+sqlfromDate+"'";
			}
		}
		if(sqlToDate!=null){
			if(datefilter.equalsIgnoreCase("invdate")){
				sql11=sql11+" and m.date<='"+sqlToDate+"'";
			} else {
				sql11=sql11+" and fm.date<='"+sqlToDate+"'";
			}
		}
		try {
			conn = connDAO.getMyConnection();
			Statement stmt = conn.createStatement ();
	       
	        param = new HashMap();
	      
	        if(Integer.parseInt(id)>0){ 
	        	
				/*String sql="select fm.doc_no delno,m.voc_no invno,fd.delnoteno dno,m.date invdate,fm.date fueldate,"
						+ "coalesce(ac1.RefName,'') client,coalesce(ac.RefName,'') vendor,p.port port,d.sprice sales,"
						+ "d.pprice purc,d.usgqty qty,d.amountusd sval,d.amountusdp pval,convert(coalesce(d.sprice-d.pprice,''),"
						+ "char(100)) usc,convert(coalesce(d.amountusd-d.amountusdp,''),char(100)) total,"
						+ "convert(coalesce(((d.amountusd-d.amountusdp)/d.amountusd)*100,''),char(100)) perc from my_port p "
						+ "left join av_invd d on d.portid=p.doc_no left join av_invm m on d.rdocno=m.doc_no "
						+ "left join av_fuelm fm on d.doc_no=fm.doc_no left join av_fueld fd on fd.rdocno=fm.doc_no "
						+ "left join my_acbook ac1 on m.client_id=ac1.cldocno left join my_acbook ac on m.vndacno=ac.acno "
						+ "where m.status=3 and fm.status=3 "+sql11+" "+sql12+"";*/
				String sql="select @i:=@i+1 row,a.* from(select fm.doc_no delno,m.voc_no invno,fd.delnoteno dno,date_format(m.date,'%d-%m-%Y') invdate,"
						+ "date_format(fm.date,'%d-%m-%Y') fueldate,coalesce(ac1.RefName,'') client,coalesce(ac.RefName,'') vendor,p.port port,round(d.sprice,2) sales,"
						+ "round(d.pprice,2) purc,round(d.usgqty,2) qty,round(d.amountusd,2) sval,round(d.amountusdp,2) pval,convert(coalesce(round(d.sprice-d.pprice,2),''),char(100)) usc,"
						+ "convert(coalesce(format(d.amountusd-d.amountusdp,2),''),char(100)) total,convert(coalesce(round(((d.amountusd-d.amountusdp)/d.amountusd)*100,2),''),char(100)) perc from my_port p "
						+ "left join av_invd d on d.portid=p.doc_no left join av_invm m on d.rdocno=m.doc_no left join av_fuelm fm on d.doc_no=fm.doc_no left join av_fueld fd on fd.rdocno=fm.doc_no "
						+ "left join my_acbook ac1 on m.client_id=ac1.cldocno and ac1.dtype='crm' left join my_acbook ac on m.vndacno=ac.acno and ac.dtype='vnd' where m.status=3 and fm.status=3  "+sql11+" "+sql12+")a,(select @i:=0)c ";
				System.out.println("==============printgridqrysql========="+sql);
				ResultSet resultSet = stmt.executeQuery(sql);
				while(resultSet.next()){
					param.put("invoicesql", sql);
				}
			}
	        String imgpathheader=request.getSession().getServletContext().getRealPath("/icons/aviation_header.png");
            imgpathheader=imgpathheader.replace("\\", "\\\\");
            
           /* String imgpathfooter=request.getSession().getServletContext().getRealPath("/icons/cityfooter.jpg");
            imgpathfooter=imgpathfooter.replace("\\", "\\\\");*/
	        
          //  param.put("gridqry", pendingdelivery);
           
	        param.put("img", imgpathheader);
	       /* param.put("imgfooter", imgpathfooter);
	        param.put("fromdate", sqlfromDate);
	        param.put("todate", sqlToDate);
	        param.put("purchaseinvoice", purchaseinvoice);*/
       	
	        
	        JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/aviation/trademarginreport/TrademrgnRptLandscape.jrxml"));
  	        JasperReport jasperReport = JasperCompileManager.compileReport(design);
            generateReportPDF(response, param, jasperReport, conn);
			
            
		} catch (Exception e) {
            e.printStackTrace();
            conn.close();
    	} finally{
    		conn.close();
    	}
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
			ouputStream.close();
			ouputStream.flush();

}
}
