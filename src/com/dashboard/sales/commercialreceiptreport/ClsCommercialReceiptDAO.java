package com.dashboard.sales.commercialreceiptreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsCommercialReceiptDAO  {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray commercialReceiptGridLoading(String branch,String fromdate,String todate) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCMR = conn.createStatement();
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			     
			     sql = "select cc.branch,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,cc.cashtotal,cc.cardtotal,cc.chequetotal,CONVERT(if(cc.out_amount=0,'  ',cc.out_amount),CHAR(100)) applied,CONVERT(if(cc.balance=0,'  ',cc.balance),CHAR(100)) balance,cc.description from ( "  
			     		+ "select if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,"
			    		+ "CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal,round(if(j.out_amount<0,j.out_amount*j.id,j.out_amount),2) out_amount,round(if((j.dramount-j.out_amount)<0,(j.dramount-j.out_amount)*j.id,(j.dramount-j.out_amount)),2) balance,"
			     		+ "r.paydesc description from gl_rentreceipt r left join my_jvtran j on (r.tr_no=j.tr_no and r.cldocno=j.cldocno) left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch "
			    		+ "where r.date>='"+sqlFromDate+"' and r.date<='"+sqlToDate+"' and r.status=3"+sql+" group by r.srno)cc";
			   
			    ResultSet resultSet = stmtCMR.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToJSON(resultSet);
			    
			    stmtCMR.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
		
	public JSONArray commercialReceiptGridExcelExport(String branch,String fromdate,String todate) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		
		Connection conn = null;
		
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		  try {
			    conn = ClsConnection.getMyConnection();
			    Statement stmtCMR = conn.createStatement();
			    
			    if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
		              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
		        }
		        
			    if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
		              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
		        }
		        
			    String sql = "";
			    
			    if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and r.brhid="+branch+"";
	    		}
			     
			      sql = "select cc.srno 'CMR No.',cc.date 'Date',cc.dtype 'Doc Type',cc.rdocno 'Doc No',cc.branch 'Branch',cc.refname 'Client',cc.cashtotal 'Cash Total',cc.cardtotal 'Card Total',cc.chequetotal 'Cheque Total',CONVERT(if(cc.out_amount=0,'  ',cc.out_amount),CHAR(100)) 'Applied',"
	    		 	+ "CONVERT(if(cc.balance=0,'  ',cc.balance),CHAR(100)) 'Balance',cc.description 'Description' from ( "  
		     		+ "select if(r.ibbrchid=0,b.branchname,br.branchname) branch,r.date,r.rdocno,r.dtype,r.srno,a.refname,if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,"
		    		+ "CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal,round(if(j.out_amount<0,j.out_amount*j.id,j.out_amount),2) out_amount,round(if((j.dramount-j.out_amount)<0,(j.dramount-j.out_amount)*j.id,(j.dramount-j.out_amount)),2) balance,"
		     		+ "r.paydesc description from gl_rentreceipt r left join my_jvtran j on (r.tr_no=j.tr_no and r.cldocno=j.cldocno) left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch "
		    		+ "where r.date>='"+sqlFromDate+"' and r.date<='"+sqlToDate+"' and r.status=3"+sql+" group by r.srno)cc";
			    
			    ResultSet resultSet = stmtCMR.executeQuery(sql);
			                
			    RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
			    
			    stmtCMR.close();
			    conn.close();
		  }catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }finally{
			  conn.close();
		  }
		  return RESULTDATA;
		}
	
	public ClsCommercialReceiptBean getPrint(HttpServletRequest request,String branch,String fromdate,String todate) throws SQLException {
		ClsCommercialReceiptBean bean = new ClsCommercialReceiptBean();
		
		Connection conn = null;

	try {
		
		conn = ClsConnection.getMyConnection();
		Statement stmtCMR = conn.createStatement();
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        
		String sqld="",sql="",sql1 = "",sql2 = "";
		
        if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
              sqlFromDate = ClsCommon.changeStringtoSqlDate(fromdate);
        }
        if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
              sqlToDate = ClsCommon.changeStringtoSqlDate(todate);
        }
		
		if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			sqld+=" and r.brhId="+branch+"";
		}
		
		sql="select 'Commercial Receipt' vouchername,CONCAT('From ',DATE_FORMAT('"+sqlFromDate+"','%D %M  %Y '),'  To  ',DATE_FORMAT('"+sqlToDate+"','%D %M  %Y ')) vouchername1,"
			+ "c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from gl_rentreceipt r inner join my_brch b on r.brhid=b.doc_no inner join my_comp c "
			+ "on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc "
			+ "on(lc.loc=l.loc and lc.brhid=b.doc_no) where 1=1 "+sqld+" group by r.brhid";
		
		ResultSet resultSet = stmtCMR.executeQuery(sql);
		
		while(resultSet.next()){
			bean.setLblcompname(resultSet.getString("company"));
			bean.setLblcompaddress(resultSet.getString("address"));
			bean.setLblprintname(resultSet.getString("vouchername"));
			bean.setLblprintname1(resultSet.getString("vouchername1"));
			bean.setLblcomptel(resultSet.getString("tel"));
			bean.setLblcompfax(resultSet.getString("fax"));
			bean.setLblbranch(resultSet.getString("branchname"));
			bean.setLbllocation(resultSet.getString("location"));
			bean.setLblcstno(resultSet.getString("cstno"));
			bean.setLblpan(resultSet.getString("pbno"));
			bean.setLblservicetax(resultSet.getString("stcno"));
		}
		
		sql1 = "select cc.branch,cc.date,cc.rdocno,cc.dtype,cc.srno,cc.refname,cc.cashtotal,cc.cardtotal,cc.chequetotal,CONVERT(if(cc.out_amount=0,'  ',cc.out_amount),CHAR(100)) applied,CONVERT(if(cc.balance=0,'  ',cc.balance),CHAR(100)) balance,cc.description from ( "  
     		+ "select if(r.ibbrchid=0,b.branchname,br.branchname) branch,DATE_FORMAT(r.date,'%d-%m-%Y') date,r.rdocno,r.dtype,r.srno,a.refname,if(r.cardtype=0,' ',if(r.cardtype=2,'(Master)','(Visa)')) cardtype,CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,"
    		+ "CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal,round(if(j.out_amount<0,j.out_amount*j.id,j.out_amount),2) out_amount,round(if((j.dramount-j.out_amount)<0,(j.dramount-j.out_amount)*j.id,(j.dramount-j.out_amount)),2) balance,"
     		+ "r.paydesc description from gl_rentreceipt r left join my_jvtran j on (r.tr_no=j.tr_no and r.cldocno=j.cldocno) left join my_acbook a on r.cldocno=a.cldocno and a.dtype='CRM' left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch "
    		+ "where r.date>='"+sqlFromDate+"' and r.date<='"+sqlToDate+"' and r.status=3"+sqld+" group by r.srno)cc";
		
		ResultSet resultSet1 = stmtCMR.executeQuery(sql1);
		
		ArrayList<String> printarray= new ArrayList<String>();
		
		while(resultSet1.next()){

			String temp="";
			temp=resultSet1.getString("srno")+"::"+resultSet1.getString("date")+"::"+resultSet1.getString("dtype")+"::"+resultSet1.getString("rdocno")+"::"+resultSet1.getString("branch")+"::"+resultSet1.getString("refname")+"::"+resultSet1.getString("cashtotal")+"::"+resultSet1.getString("cardtotal")+"::"+resultSet1.getString("chequetotal")+"::"+resultSet1.getString("applied")+"::"+resultSet1.getString("balance")+"::"+resultSet1.getString("description");
		    
			printarray.add(temp);
		}
		
		request.setAttribute("printingarray", printarray);
		
		sql2 = "select round((cashtotal+cardtotal+chequetotal),2) nettotal,round(cashtotal,2) cashtotal,round(cardtotal,2) cardtotal,round(chequetotal,2) chequetotal,round(out_amount,2) out_amount,round(balance,2) balance from ("
				+ "select sum(cc.cashtotal) cashtotal,sum(cc.cardtotal) cardtotal,sum(cc.chequetotal) chequetotal,sum(cc.out_amount) out_amount,sum(cc.balance) balance from (select CONVERT(if(r.paytype=1,round(r.netamt,2),'  '),CHAR(100)) cashtotal,"
				+ "CONVERT(if(r.paytype=2,round(r.netamt,2),'  '),CHAR(100)) cardtotal,CONVERT(if(r.paytype=3,round(r.netamt,2),'  '),CHAR(100)) chequetotal,round(if(j.out_amount<0,j.out_amount*j.id,j.out_amount),2) out_amount,"
				+ "round(if((j.dramount-j.out_amount)<0,(j.dramount-j.out_amount)*j.id,(j.dramount-j.out_amount)),2) balance from gl_rentreceipt r left join my_jvtran j on (r.tr_no=j.tr_no and r.cldocno=j.cldocno) left join my_acbook a on r.cldocno=a.cldocno "
				+ "and a.dtype='CRM' left join my_brch b on r.brhid=b.branch left join my_brch br on r.ibbrchid=br.branch where r.date>='"+sqlFromDate+"' and r.date<='"+sqlToDate+"' and r.status=3"+sqld+" group by r.srno)cc) as bb";
		
		ResultSet resultSet2 = stmtCMR.executeQuery(sql2);
		
		String netamount="0.00",cashamount="0.00",cardamount="0.00",chequeamount="0.00",appliedamount="0.00",balanceamount="0.00";
		while(resultSet2.next()){
			cashamount=resultSet2.getString("cashtotal");
			cardamount=resultSet2.getString("cardtotal");
			chequeamount=resultSet2.getString("chequetotal");
			appliedamount=resultSet2.getString("out_amount");
			balanceamount=resultSet2.getString("balance");
			netamount=resultSet2.getString("nettotal");
		}
		
		bean.setLblcashtotal(cashamount);
		bean.setLblcardtotal(cardamount);
		bean.setLblchequetotal(chequeamount);
		bean.setLblappliedtotal(appliedamount);
		bean.setLblbalancetotal(balanceamount);
		bean.setLblnetbalance(netamount);
		
		stmtCMR.close();
		conn.close();
	} catch(Exception e){
		 e.printStackTrace();
		 conn.close();
	} finally{
		conn.close();
	}
	return bean;
   }
}