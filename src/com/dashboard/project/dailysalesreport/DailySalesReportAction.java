package com.dashboard.project.dailysalesreport;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.sql.Statement;
import java.sql.SQLException;   
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.common.*;
import com.connection.ClsConnection;

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

public class DailySalesReportAction {
	ClsCommon cmn=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	private String url;
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
	
	public String printAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String fromdate=request.getParameter("fromdate");  
		String todate=request.getParameter("todate");
		String branch=request.getParameter("branch");
		String branchname="",user="",fromdate2="",todate2="",sqluser="",smanid="";   
		ResultSet rs=null,rss=null;
	    HttpServletResponse response = ServletActionContext.getResponse();
	    java.sql.Date sqlfromdate = null;
	    java.sql.Date sqltodate = null;   
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;
			 try {	
				    conn = ClsConnection.getMyConnection();
					stmt=conn.createStatement();
				 if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
				 if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}
				 SimpleDateFormat dt1 = new SimpleDateFormat("dd-MM-yyyy");
				 fromdate2=dt1.format(sqlfromdate);
				 todate2=dt1.format(sqltodate);
				String sql1="select branchname from my_brch where status<>7 and doc_no='"+branch+"'"; 
				rs= stmt.executeQuery(sql1);        
				if(rs.next()){    
					branchname=rs.getString("branchname");                                    	
				}  
				 sqluser="select doc_no from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
		    	 //System.out.println("sqluser====="+sqluser); 
		    	 rss =stmt.executeQuery(sqluser);         
		    	 if(rss.next()){
		    		 smanid=rss.getString("doc_no");
		    	 }  
				
				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");  
			        user=session.getAttribute("USERNAME").toString();
			       // System.out.println("in...."+user);
			        param.put("img",imgpath);  
			        param.put("name",user);    
	    			param.put("fromdate",sqlfromdate);  
	    			param.put("todate",sqltodate);
	    			param.put("fromdate2",fromdate2);  
	    			param.put("todate2",todate2);
	    			param.put("branch",branch);    
	    			param.put("branchname",branchname); 
	    			param.put("smanid",smanid);  
		                   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/project/dailysalesreport/dailysalesreport.jrxml"));
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
//	     	               System.out.println("in....");               
	     	               generateReportPDF(response, param, jasperReport, conn);
	          
	               } catch (Exception e) {      

	                 e.printStackTrace();
	             }
	            	 
	            finally{
			conn.close();
		}	  	 
	return "print";   
	}  
	
	public String printSumAction() throws ParseException, SQLException{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		String fromdate=request.getParameter("fromdate");  
		String todate=request.getParameter("todate");
		String branch=request.getParameter("branch");
		String branchname="",user="",fromdate2="",todate2="",sqluser="";
		String targettot4="0",saletotb4="0",jiptotb4="",collntotb4="",collntotb3="",jiptotb3="",collntot="",jiptot="",collntotb1="",jiptotb1="",collntotb2="",saletotb1="0",saletotb2="0",saletot="0",saletotb3="0",jiptotb2="",targettot="0",targettot1="0",targettot2="0",targettot3="0";             
		ResultSet rs51=null,rs52=null,rs53=null,rs54=null,rs=null,rss=null,rs1=null,rs2=null,rs3=null,rs4=null,rs11=null,rs22=null,rs33=null,rs44=null,rs111=null,rs222=null,rs333=null,rs444=null,rs61=null,rs62=null,rs63=null,rs64=null;                        
	    String targetper="0.00",targetper1="0.00",targetper2="0.00",targetper3="0.00",targetper4="0.00";
	    Double targettot4p=0.0,saletotb4p=0.0,saletotb1p=0.0,saletotb2p=0.0,saletotp=0.0,saletotb3p=0.0,targettotp=0.0,targettot1p=0.0,targettot2p=0.0,targettot3p=0.0;   
		HttpServletResponse response = ServletActionContext.getResponse();    
	    java.sql.Date sqlfromdate = null;      
	    java.sql.Date sqltodate = null; 
			 param = new HashMap();    
				Connection conn = null;
				Statement stmt =null;   
			 try {	
				    conn = ClsConnection.getMyConnection();                                    
					stmt=conn.createStatement();                    
					String sql51="",sql52="",sql53="",sql54="",smanid="0",sql11="",sql22="",sql33="",sql44="",sql111="",sql222="",sql333="",sql444="",sql1111="",sql2222="",sql3333="",sql4444="",sqltest1="",sqltest2="",sqltest3="",sql61="",sql62="",sql63="",sql64="";
				 if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
						sqlfromdate = cmn.changeStringtoSqlDate(fromdate);
					}
				 if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
						sqltodate = cmn.changeStringtoSqlDate(todate);
					}
				 SimpleDateFormat dt1 = new SimpleDateFormat("dd-MM-yyyy");  
				 fromdate2=dt1.format(sqlfromdate);
				 todate2=dt1.format(sqltodate);
				String sql1="select branchname from my_brch where status<>7 and doc_no='"+branch+"'"; 
				rs= stmt.executeQuery(sql1);        
				if(rs.next()){    
					branchname=rs.getString("branchname");                                    	
				}
				sqluser="select doc_no from my_salm where salesuserlink like '"+session.getAttribute("USERID")+"'";            
		    	 //System.out.println("sqluser====="+sqluser); 
		    	 rss =stmt.executeQuery(sqluser);         
		    	 if(rss.next()){
		    		 sqltest2=" where s.doc_no="+rss.getString("doc_no");   
		    		 sqltest3=" and s.doc_no="+rss.getString("doc_no");      
		    	 }            
		    	 
				 sql11="select format(coalesce(sum(jipvalue),0),2) collntot from (select cash, card, cheque,coalesce((cash+card+cheque),0) jipvalue from  (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from (select m.doc_no, coalesce(m.SAL_ID,ac.sal_id) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash, card, cheque from (SELECT r.cldocno,r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card, sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO LEFT JOIN my_acbook ac ON ac.cldocNO=a.cldocno and ac.dtype='crm' ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c LEFT JOIN MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID "+sqltest2+") h"; 
				 //System.out.println("sql11--->>>"+sql11);
				 rs1= stmt.executeQuery(sql11);
				 if(rs1.next()){      
						collntot=rs1.getString("collntot");                                     	
				}     
				 sql22="select format(coalesce(sum(JOBAMOUNT),0),2) saletot,round(coalesce(sum(JOBAMOUNT),0),2) saletotp from (SELECT m.salesbookdate JOBDATE,m.netamount JOBAMOUNT,M.DOC_NO JOBNO,A.REFNAME,B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') SALNAME FROM  CM_SRVCONTRM M left join cm_srvqotm q on q.tr_no=m.reftrno LEFT JOIN MY_BRCH B ON B.DOC_NO=q.BRHID LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON  A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' WHERE M.status=3 and M.salesbookdate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest3+") n"; 
				 //System.out.println("sql22--->>>"+sql22);
				 rs2= stmt.executeQuery(sql22);
				 if(rs2.next()){    
					 saletot=rs2.getString("saletot");   
					 saletotp=rs2.getDouble("saletotp");   
			     }          
				 sql33="select format(coalesce(sum(jipvalue),0),2) jiptot from ( select brhid,sal_id,count(*) cn,sum(jipvalue) jipvalue from ( select jobno,brhid, sal_id, ROUND(AMT*((max(curmonth)-max(prev))/100),2) jipvalue from ( select c.doc_no jobno,c.sal_id,c.brhid,(m.wrkper) wrkper,rtrno, IF(D.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' ,d.wrkper,0) curmonth, ROUND(C.NETAMOUNT,2) AMT,  IF( d.date< '"+sqlfromdate+"' ,d.wrkper,0 ) prev from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE where m.date between '"+sqlfromdate+"' and '"+sqltodate+"' ORDER BY M.DOC_NO,C.DOC_NO ) b group by b.jobno ) a group by brhid,sal_id ) j LEFT JOIN MY_BRCH B ON B.DOC_NO=j.BRHID LEFT JOIN my_salm S ON S.DOC_NO=j.SAL_ID where jipvalue!=0 "+sqltest3+"";
//				 System.out.println("sql33--->>>"+sql33);           
				 rs3= stmt.executeQuery(sql33);            
				 if(rs3.next()){    
					 jiptot=rs3.getString("jiptot");                                        	
					} 
				 sql44="select format(coalesce(sum(targetval),0),2) targetval,round(coalesce(sum(targetval),0),2) targetvalp from cm_monthsalem where month=month('"+sqlfromdate+"') and type=1 and year=year('"+sqlfromdate+"')";                        
				 //System.out.println("sql44--->>>"+sql44);           
				 rs4= stmt.executeQuery(sql44);             
				 if(rs4.next()){    
					 targettot=rs4.getString("targetval");                   
					 targettotp=rs4.getDouble("targetvalp"); 
					}    
				 
				 
				 
				 sql111="select format(coalesce(sum(jipvalue),0),2) collntot from (select cash, card, cheque,coalesce((cash+card+cheque),0) jipvalue from  (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from (select m.doc_no, coalesce(m.SAL_ID,ac.sal_id) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash, card, cheque from (SELECT r.cldocno,r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card, sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.brhid=1 and r.status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO LEFT JOIN my_acbook ac ON ac.cldocNO=a.cldocno and ac.dtype='crm' ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c LEFT JOIN MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID "+sqltest2+") h"; 
				 //System.out.println("sql11--->>>"+sql11);
				 rs11= stmt.executeQuery(sql111);
				 if(rs11.next()){      
						collntotb1=rs11.getString("collntot");                                     	
				}   
				 sql222="select format(coalesce(sum(JOBAMOUNT),0),2) saletot,round(coalesce(sum(JOBAMOUNT),0),2) saletotp from (SELECT m.salesbookdate JOBDATE,m.netamount JOBAMOUNT,M.DOC_NO JOBNO,A.REFNAME,B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') SALNAME FROM  CM_SRVCONTRM M left join cm_srvqotm q on q.tr_no=m.reftrno LEFT JOIN MY_BRCH B ON B.DOC_NO=q.BRHID LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON  A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' WHERE q.brhid=1 and m.status=3 and M.salesbookdate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest3+") n"; 
				 //System.out.println("sql222--->>>"+sql222);
				 rs22= stmt.executeQuery(sql222);
				 if(rs22.next()){    
					 saletotb1=rs22.getString("saletot");   
					 saletotb1p=rs22.getDouble("saletotp");  
			     }          
				 sql333="select format(coalesce(sum(jipvalue),0),2) jiptot from ( select brhid,sal_id,count(*) cn,sum(jipvalue) jipvalue from ( select jobno,brhid, sal_id, ROUND(AMT*((max(curmonth)-max(prev))/100),2) jipvalue from ( select c.doc_no jobno,c.sal_id,c.brhid,(m.wrkper) wrkper,rtrno, IF(D.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' ,d.wrkper,0) curmonth, ROUND(C.NETAMOUNT,2) AMT,  IF( d.date< '"+sqlfromdate+"' ,d.wrkper,0 ) prev from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE where m.brhid=1 and m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' ORDER BY M.DOC_NO,C.DOC_NO ) b group by b.jobno ) a group by brhid,sal_id ) j LEFT JOIN MY_BRCH B ON B.DOC_NO=j.BRHID LEFT JOIN my_salm S ON S.DOC_NO=j.SAL_ID where jipvalue!=0 "+sqltest3+""; //System.out.println("sql33--->>>"+sql33);           
				 rs33= stmt.executeQuery(sql333);            
				 if(rs33.next()){    
					 jiptotb1=rs33.getString("jiptot");                                        	
					} 
				 sql444="select format(coalesce(sum(targetval),0),2) targetval,round(coalesce(sum(targetval),0),2) targetvalp from cm_monthsalem where month=month('"+sqlfromdate+"') and brhid=1  and type=1  and year=year('"+sqlfromdate+"')";  
				 //System.out.println("sql444--->>>"+sql444);           
				 rs44= stmt.executeQuery(sql444);            
				 if(rs44.next()){    
					 targettot1=rs44.getString("targetval");    
					 targettot1p=rs44.getDouble("targetvalp"); 
					}
				 
				 
				 sql1111="select format(coalesce(sum(jipvalue),0),2) collntot from (select cash, card, cheque,coalesce((cash+card+cheque),0) jipvalue from  (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from (select m.doc_no, coalesce(m.SAL_ID,ac.sal_id) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash, card, cheque from (SELECT r.cldocno,r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card, sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.brhid=2 and r.status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO LEFT JOIN my_acbook ac ON ac.cldocNO=a.cldocno and ac.dtype='crm' ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c LEFT JOIN MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID "+sqltest2+") h"; 
				 //System.out.println("sql11--->>>"+sql11);
				 rs111= stmt.executeQuery(sql1111);
				 if(rs111.next()){      
						collntotb2=rs111.getString("collntot");                                     	
				}   
				 sql2222="select format(coalesce(sum(JOBAMOUNT),0),2) saletot,round(coalesce(sum(JOBAMOUNT),0),2) saletotp from (SELECT m.salesbookdate JOBDATE,m.netamount JOBAMOUNT,M.DOC_NO JOBNO,A.REFNAME,B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') SALNAME FROM  CM_SRVCONTRM M left join cm_srvqotm q on q.tr_no=m.reftrno LEFT JOIN MY_BRCH B ON B.DOC_NO=q.BRHID LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON  A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' WHERE q.brhid=2 and m.status=3 and M.salesbookdate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest3+") n"; 
				 //System.out.println("sql2222--->>>"+sql2222);   
				 rs222= stmt.executeQuery(sql2222);   
				 if(rs222.next()){    
					 saletotb2=rs222.getString("saletot"); 
					 saletotb2p=rs222.getDouble("saletotp");  
			     }          
				 sql3333="select format(coalesce(sum(jipvalue),0),2) jiptot from ( select brhid,sal_id,count(*) cn,sum(jipvalue) jipvalue from ( select jobno,brhid, sal_id, ROUND(AMT*((max(curmonth)-max(prev))/100),2) jipvalue from ( select c.doc_no jobno,c.sal_id,c.brhid,(m.wrkper) wrkper,rtrno, IF(D.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' ,d.wrkper,0) curmonth, ROUND(C.NETAMOUNT,2) AMT,  IF( d.date< '"+sqlfromdate+"' ,d.wrkper,0 ) prev from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE where m.brhid=2 and m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' ORDER BY M.DOC_NO,C.DOC_NO ) b group by b.jobno ) a group by brhid,sal_id ) j LEFT JOIN MY_BRCH B ON B.DOC_NO=j.BRHID LEFT JOIN my_salm S ON S.DOC_NO=j.SAL_ID where jipvalue!=0 "+sqltest3+"";
				 //System.out.println("sql33--->>>"+sql33);           
				 rs333= stmt.executeQuery(sql3333);                          
				 if(rs333.next()){    
					 jiptotb2=rs333.getString("jiptot");                                           	
					}
				 sql4444="select format(coalesce(sum(targetval),0),2) targetval,round(coalesce(sum(targetval),0),2) targetvalp from cm_monthsalem where month=month('"+sqlfromdate+"') and brhid=2  and type=1 and year=year('"+sqlfromdate+"')";  
				// System.out.println("sql4444--->>>"+sql4444);           
				 rs444= stmt.executeQuery(sql4444);            
				 if(rs444.next()){    
					 targettot2=rs444.getString("targetval");   
					 targettot2p=rs444.getDouble("targetvalp"); 
					}
				  
				 
				 sql51="select format(coalesce(sum(jipvalue),0),2) collntot from (select cash, card, cheque,coalesce((cash+card+cheque),0) jipvalue from  (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from (select m.doc_no, coalesce(m.SAL_ID,ac.sal_id) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash, card, cheque from (SELECT r.cldocno,r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card, sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.brhid=3 and r.status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO LEFT JOIN my_acbook ac ON ac.cldocNO=a.cldocno and ac.dtype='crm' ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c LEFT JOIN MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID "+sqltest2+") h"; 
				 //System.out.println("sql51--->>>"+sql51);
				 rs51= stmt.executeQuery(sql51);
				 if(rs51.next()){      
						collntotb3=rs51.getString("collntot");                                     	
				}   
				 sql52="select format(coalesce(sum(JOBAMOUNT),0),2) saletot,round(coalesce(sum(JOBAMOUNT),0),2) saletotp from (SELECT m.salesbookdate JOBDATE,m.netamount JOBAMOUNT,M.DOC_NO JOBNO,A.REFNAME,B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') SALNAME FROM  CM_SRVCONTRM M left join cm_srvqotm q on q.tr_no=m.reftrno LEFT JOIN MY_BRCH B ON B.DOC_NO=q.BRHID LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON  A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' WHERE q.brhid=3 and m.status=3 and M.salesbookdate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest3+") n"; 
				 //System.out.println("sql52--->>>"+sql52);   
				 rs52= stmt.executeQuery(sql52);   
				 if(rs52.next()){    
					 saletotb3=rs52.getString("saletot");    
					 saletotb3p=rs52.getDouble("saletotp");  
			     }          
				 sql53="select format(coalesce(sum(jipvalue),0),2) jiptot from ( select brhid,sal_id,count(*) cn,sum(jipvalue) jipvalue from ( select jobno,brhid, sal_id, ROUND(AMT*((max(curmonth)-max(prev))/100),2) jipvalue from ( select c.doc_no jobno,c.sal_id,c.brhid,(m.wrkper) wrkper,rtrno, IF(D.DATE between '"+sqlfromdate+"' and '"+sqltodate+"' ,d.wrkper,0) curmonth, ROUND(C.NETAMOUNT,2) AMT,  IF( d.date< '"+sqlfromdate+"' ,d.wrkper,0 ) prev from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE where m.brhid=3 and m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' ORDER BY M.DOC_NO,C.DOC_NO ) b group by b.jobno ) a group by brhid,sal_id ) j LEFT JOIN MY_BRCH B ON B.DOC_NO=j.BRHID LEFT JOIN my_salm S ON S.DOC_NO=j.SAL_ID where jipvalue!=0 "+sqltest3+"";
				 //System.out.println("sql53--->>>"+sql53);           
				 rs53= stmt.executeQuery(sql53);                          
				 if(rs53.next()){    
					 jiptotb3=rs53.getString("jiptot");                                           	
					} 
				 sql54="select format(coalesce(sum(targetval),0),2) targetval,round(coalesce(sum(targetval),0),2) targetvalp from cm_monthsalem where month=month('"+sqlfromdate+"') and brhid=3  and type=1 and year=year('"+sqlfromdate+"')";  
				// System.out.println("sql54--->>>"+sql54);           
				 rs54= stmt.executeQuery(sql54);            
				 if(rs54.next()){         
					 targettot3=rs54.getString("targetval");   
					 targettot3p=rs54.getDouble("targetvalp"); 
					}
				 
				 sql61="select format(coalesce(sum(jipvalue),0),2) collntot from (select cash, card, cheque,coalesce((cash+card+cheque),0) jipvalue from  (select sum(cash) cash, sum(card) card, sum(cheque) cheque, brhid , sal_id from (select m.doc_no, coalesce(m.SAL_ID,ac.sal_id) SAL_ID,a.brhid,coalesce(netamount,0) jobtotal, cash, card, cheque from (SELECT r.cldocno,r.brhid,r.aggno,sum(IF(PAYTYPE=1,ROUND(NETAMT,2),0)) cash,sum(IF(PAYTYPE=2,ROUND(NETAMT,2),0)) card, sum(IF(PAYTYPE=3,ROUND(NETAMT,2),0)) cheque FROM GL_RENTRECEIPT R where r.brhid=4 and r.status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' group by r.BRHID,r.aggno) a LEFT JOIN CM_SRVCONTRM M ON m.TR_NO=a.AGGNO LEFT JOIN my_acbook ac ON ac.cldocNO=a.cldocno and ac.dtype='crm' ) b GROUP BY BRHID,coalesce(SAL_ID,0)) c LEFT JOIN MY_BRCH B ON B.DOC_NO=c.BRHID LEFT JOIN my_salm S ON S.DOC_NO=c.SAL_ID "+sqltest2+") h"; 
//				 System.out.println("sql61--->>>"+sql61);
				 rs61= stmt.executeQuery(sql61);
				 if(rs61.next()){      
						collntotb4=rs61.getString("collntot");                                     	
				}   
				 sql62="select format(coalesce(sum(JOBAMOUNT),0),2) saletot,round(coalesce(sum(JOBAMOUNT),0),2) saletotp from (SELECT m.salesbookdate JOBDATE,m.netamount JOBAMOUNT,M.DOC_NO JOBNO,A.REFNAME,B.BRANCHNAME brch,COALESCE(S.SAL_NAME,'') SALNAME FROM  CM_SRVCONTRM M left join cm_srvqotm q on q.tr_no=m.reftrno LEFT JOIN MY_BRCH B ON B.DOC_NO=q.BRHID LEFT JOIN my_salm S ON S.DOC_NO=M.SAL_ID LEFT JOIN MY_ACBOOK A ON  A.CLDOCNO=M.CLDOCNO AND A.DTYPE='CRM' WHERE q.brhid=4 and m.status=3 and M.salesbookdate between '"+sqlfromdate+"' and '"+sqltodate+"' "+sqltest3+") n"; 
//				 System.out.println("sql62--->>>"+sql62);   
				 rs62= stmt.executeQuery(sql62);   
				 if(rs62.next()){    
					 saletotb4=rs62.getString("saletot");    
					 saletotb4p=rs62.getDouble("saletotp");  
			     }          
				 sql63="select format(coalesce(sum(jipvalue),0),2) jiptot from ( select brhid,sal_id,count(*) cn,sum(jipvalue) jipvalue from ( select jobno,brhid, sal_id, max(jipvalue) jipvalue from ( select c.doc_no jobno,c.sal_id,c.brhid,(m.wrkper) wrkper,rtrno, ROUND(C.NETAMOUNT*(D.WRKPER/100),2) jipvalue from CM_srvdetm m left join cm_srvreportstatus d on m.tr_no=d.rtrno LEFT JOIN cm_srvCONTRM C ON C.TR_NO=M.COSTID AND M.COSTTYPE=C.COSTTYPE where m.brhid=4 and m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' ORDER BY M.DOC_NO,C.DOC_NO ) b group by b.jobno ) a group by brhid,sal_id ) j LEFT JOIN MY_BRCH B ON B.DOC_NO=j.BRHID LEFT JOIN my_salm S ON S.DOC_NO=j.SAL_ID where jipvalue!=0 "+sqltest3+"";
				 //System.out.println("sql53--->>>"+sql53);           
				 rs63= stmt.executeQuery(sql63);                          
				 if(rs63.next()){    
					 jiptotb4=rs63.getString("jiptot");                                           	
					} 
				 sql64="select format(coalesce(sum(targetval),0),2) targetval,round(coalesce(sum(targetval),0),2) targetvalp from cm_monthsalem where month=month('"+sqlfromdate+"') and brhid=4  and type=1 and year=year('"+sqlfromdate+"')";  
				// System.out.println("sql54--->>>"+sql54);           
				 rs64= stmt.executeQuery(sql64);            
				 if(rs64.next()){         
					 targettot4=rs64.getString("targetval");   
					 targettot4p=rs64.getDouble("targetvalp"); 
					}
				 
				 if(targettotp!=0 || targettotp!=0.00){    
					 targetper=""+cmn.Round((saletotp/targettotp)*100,0); 
					 BigDecimal bd = new BigDecimal(targetper).setScale(0, RoundingMode.HALF_EVEN);
					 targetper = ""+bd.doubleValue();
				 }   
				 if(targettot1p!=0 || targettot1p!=0.00){    
					 targetper1=""+cmn.Round((saletotb1p/targettot1p)*100,0);
					 BigDecimal bd = new BigDecimal(targetper1).setScale(0, RoundingMode.HALF_EVEN);
					 targetper1 = ""+bd.doubleValue();
				 }
				 if(targettot2p!=0 || targettot2p!=0.00){    
					 targetper2=""+cmn.Round((saletotb2p/targettot2p)*100,0);
					 BigDecimal bd = new BigDecimal(targetper2).setScale(0, RoundingMode.HALF_EVEN);
					 targetper2 = ""+bd.doubleValue();
				 }
				 if(targettot3p!=0 || targettot3p!=0.00){    
					 targetper3=""+cmn.Round((saletotb3p/targettot3p)*100,0);
					 BigDecimal bd = new BigDecimal(targetper3).setScale(0, RoundingMode.HALF_EVEN);
					 targetper3 = ""+bd.doubleValue();
				 }
				 if(targettot4p!=0 || targettot4p!=0.00){    
					 targetper4=""+cmn.Round((saletotb4p/targettot4p)*100,0);
					 BigDecimal bd = new BigDecimal(targetper4).setScale(0, RoundingMode.HALF_EVEN);
					 targetper4 = ""+bd.doubleValue();
				 }    
//				 System.out.println(targetper+"=========="+targetper1+"========"+targetper2+"============="+targetper3);      
				 String imgpath=request.getSession().getServletContext().getRealPath("/icons/epic.jpg");
			        imgpath=imgpath.replace("\\", "\\\\");  
			        user=session.getAttribute("USERNAME").toString();
			       // System.out.println("in...."+user);
			        param.put("img",imgpath);  
			        param.put("name",user);    
	    			param.put("fromdate",sqlfromdate);     
	    			param.put("todate",sqltodate);
	    			param.put("fromdate2",fromdate2);  
	    			param.put("todate2",todate2);
	    			param.put("collntot",collntot);    
	    			param.put("saletot",saletot);     
	    			param.put("jiptot",jiptot);
	    			param.put("targettot",targettot);
	    			
	    			param.put("collntotb1",collntotb1);    
	    			param.put("saletotb1",saletotb1);       
	    			param.put("jiptotb1",jiptotb1);
	    			param.put("targettot1",targettot1);
	    			
	    			param.put("collntotb2",collntotb2);    
	    			param.put("saletotb2",saletotb2);     
	    			param.put("jiptotb2",jiptotb2);
	    			param.put("targettot2",targettot2);
	    			
	    			param.put("collntotb3",collntotb3);    
	    			param.put("saletotb3",saletotb3);     
	    			param.put("jiptotb3",jiptotb3);
	    			param.put("targettot3",targettot3);
	    			
	    			param.put("collntotb4",collntotb4);    
	    			param.put("saletotb4",saletotb4);     
	    			param.put("jiptotb4",jiptotb4);
	    			param.put("targettot4",targettot4);
	    			
	    			param.put("branchname",branchname);
	    			
	    			
	    			param.put("targetper",targetper);
	    			param.put("targetper1",targetper1);    
	    			param.put("targetper2",targetper2);           
	    			param.put("targetper3",targetper3);
	    			param.put("targetper4",targetper4);
	    			
		                   JasperDesign design = JRXmlLoader.load(request.getSession().getServletContext().getRealPath("com/dashboard/project/dailysalesreport/summaryreport.jrxml"));
	     	               JasperReport jasperReport = JasperCompileManager.compileReport(design);
//	     	               System.out.println("in....");                  
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
