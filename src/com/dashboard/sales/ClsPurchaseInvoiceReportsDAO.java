package com.dashboard.sales;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 




import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
 







import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsPurchaseInvoiceReportsDAO {

	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public   JSONArray saleEnqFollowUpGridLoding(String branch,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				
				
				String sql=" select bv.fdate,d.specno,mm.brhid,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty,"
						+ " convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,if(d.qty-d.out_qty=0,'',d.qty-d.out_qty) balqty "
						+ "  from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ " left join (select sum(out_qty) chkqty,rdocno,prdid from my_cusenqd group by rdocno,prdid) aa on  aa.rdocno=d.rdocno and aa.prdid=d.prdid"
						+ " left join (select max(b.doc_no) doc_no,rdocno,prdid from my_bsef b group by  rdocno,prdid) "
	        			+ "  b on(d.rdocno=b.rdocno and b.prdid=d.prdid ) "
	        			+ " left join  my_bsef bv on b.doc_no=bv.doc_no and d.rdocno=bv.rdocno  "
						+ "  where  mm.status=3  and aa.chkqty=0 and  mm.DATE>='"+sqlfromdate+"' and   mm.DATE<='"+sqltodate+"'  "+sqltest;
			
        /* 
            System.out.println("----saleEnqFollowUpGridLoding-------"+sql);	*/
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray reqlistsearch(String branch,String fromdate,String todate,String status) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("ORD"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				
				
				String sql=" select mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty,"
						+ " convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,if(d.qty-d.out_qty=0,'',d.qty-d.out_qty) balqty "
						+ "  from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
						+ "  where    mm.DATE>='"+sqlfromdate+"' and   mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("----reqlistsearch-------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	public   JSONArray reqlistsearchex(String branch,String fromdate,String todate,String status) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("ORD"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				
				
				String sql=" select  mm.voc_no doc_no,mm.date,mm.refno,m.part_no productid,m.productname,u.unit,d.qty "
						+ "  from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
						+ "  where    mm.DATE>='"+sqlfromdate+"' and   mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          
            	//System.out.println("----reqlistsearch-------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray salesenqcancel(String branch,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				
				
				String sql=" select  mm.voc_no doc_no,mm.date,mm.refno,m.part_no productid,m.productname,u.unit,d.qty "
						+ "  from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
						+ "  where  mm.status=6 and  mm.DATE>='"+sqlfromdate+"' and   mm.DATE<='"+sqltodate+"' ";
			
          
            	System.out.println("----salesenqcancel-------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }		
	
	
	public   JSONArray salesenqcancelExcel(String branch,String fromdate,String todate) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				
				
				String sql=" select  mm.date Date,mm.refno 'Ref No',m.part_no 'product Id',m.productname 'Product Name',u.unit Unit,d.qty Quantity "
						+ "  from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
						+ "  where  mm.status=6 and  mm.DATE>='"+sqlfromdate+"' and   mm.DATE<='"+sqltodate+"' ";
			
          
            	System.out.println("----salesenqcancel-------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }		
	
	
	public   JSONArray orderlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();    
		 
				
				
				String sql=" select (case when ref_type='DIR' then 'Direct' else 'Quotation' end) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_sorderm mm left join my_sorderd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          
            	System.out.println("-----orderlistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray orderlistsearchex(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();    
		 
				
				
				String sql=" select mm.voc_no doc_no,mm.date,mm.refno,(case when ref_type='DIR' then 'Direct' else 'Quotation' end) type, "
						+ "  h.account,h.description accountname, "
						+ "  m.part_no productid,m.productname,u.unit,"
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_sorderm mm left join my_sorderd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          
           // 	System.out.println("-----orderlistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray qotlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("SQOT"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();    
		 
				
				
				String sql=" select (case when ref_type='DIR' then 'Direct' else 'Enquiry' end) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_qotm mm left join my_qotd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          
            	System.out.println("-----qotlistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	public   JSONArray qotlistsearchex(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("SQOT"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();    
		 
				
				
				String sql=" select mm.voc_no doc_no,mm.date,(case when ref_type='DIR' then 'Direct' else 'Enquiry' end) type,mm.refno, "
						+ "  h.account,h.description accountname, "
						+ "  m.part_no productid,m.productname,u.unit, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_qotm mm left join my_qotd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("-----qotlistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	public  JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String enqno,String enqdate,String enqtype) throws SQLException {


		System.out.println("==searchMaster===");

		JSONArray RESULTDATA=new JSONArray();
		Enumeration<String> Enumeration = session.getAttributeNames();
		int a=0;
		while(Enumeration.hasMoreElements()){
			if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
				a=1;
			}
		}
		if(a==0){
			return RESULTDATA;
		}

 
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}

		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}

		if(!(enqtype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.ref_type like '%"+enqtype+"%'";
		}

		if(!(enqno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.rrefno like '%"+enqno+"%'";
		}

		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 



		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement ();

			String clssql= ("select m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,"
					+ "m.cldocno,m.ref_type,rrefno from my_qotm m  left join my_qotd d on d.rdocno=m.doc_no "
					+ " left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') "
					+ " where    d.clstatus=0   "+sqltest+" group by m.doc_no ");
			System.out.println("====searchmaster===="+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	
	public   JSONArray qotfollowsearch(String branch,String fromdate,String todate,String status,String acno,String ostk,String quotdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
        String sqltest1="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest1+=" and brhid='"+branch+"'";
 		}
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if((!(quotdocno.equalsIgnoreCase("NA")) )&&(!(quotdocno.equalsIgnoreCase(""))) &&(!(quotdocno.equalsIgnoreCase("0"))) ){
    		sqltest+=" and mm.voc_no='"+quotdocno+"'";
 		}
    	
    	
    	if(ostk.equalsIgnoreCase("out"))
    	{
    		sqltest+=" and (d.qty-d.out_qty)>s.stkqty ";
    	}
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
		 
				
				
				String sql=" select convert(coalesce(if(s1.stkqtys=0,'',stkqtys),0),char(100)) totstkqty,if((d.qty-d.out_qty)>s.stkqty,1,0) val ,convert(coalesce(if(s.stkqty=0,'',stkqty),0),char(100)) stkqty,bv.fdate,mm.brhid,d.specno,(case when ref_type='DIR' then 'Direct' else 'Enquiry' end) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_qotm mm left join my_qotd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join (select max(b.doc_no) doc_no,rdocno,prdid,specno from my_bsqf b group by  rdocno,prdid,specno) "
	        			+ "  b on(b.prdid=d.prdid and d.specno=b.specno and d.rdocno=b.rdocno) left join  my_bsqf bv on b.doc_no=bv.doc_no and d.prdid=bv.prdid and d.specno=bv.specno and d.rdocno=bv.rdocno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ " left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid  from  my_prddin  where 1=1 "+sqltest1+"  group by psrno) s   on s.prdid=m.doc_no "
						+ " left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqtys,prdid prdids from  my_prddin   group by psrno) s1   on s1.prdids=m.doc_no"
						+ "   where d.clstatus=0 and "
						+ "  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          
            	//System.out.println("-----qotlistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	

	
	
	public   JSONArray Detailsenq(String rdocno,String prodoc,String specno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from my_bsef m "   
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"'"
            						+ "  and m.prdid='"+prodoc+"'  and m.fdate is not null  group by m.doc_no ";
 System.out.println("=======sql=="+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public   JSONArray Details(String rdocno,String prodoc,String specno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from my_bsqf m "   
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"' and m.prdid='"+prodoc+"' and m.specno='"+specno+"' and m.fdate is not null  group by m.doc_no ";
 System.out.println("=======sql=="+sql);
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	

	public   JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String mob,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	  
     //   JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        
        
   java.sql.Date sqlDate=null;
      date.trim();
      String sqltest="";
                  /*   if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }*/
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and a.refname like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and a.refname like '%"+accountname+"%'";
                     }
                     if(!(mob.equalsIgnoreCase("0")) && !(mob.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and if(a.per_mob=0,a.per_tel,a.per_mob) like '%"+mob+"%'";
                  }
  try {
     conn = ClsConnection.getMyConnection();
     if(chk.equalsIgnoreCase("1"))
     {
    Statement stmt = conn.createStatement ();
      
   
    String  sql= "select a.doc_no,a.refname as account,a.refname description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_acbook a where dtype='VND' "+sqltest;
 
    
   System.out.println("-----sql---+"+sql);
    
    ResultSet resultSet = stmt.executeQuery(sql);
    RESULTDATA=ClsCommon.convertToJSON(resultSet);
    
    stmt.close();
     }
    conn.close();
  }
  catch(Exception e){
   e.printStackTrace();
   conn.close();
  }
        return RESULTDATA;
    }

	
	
	public   JSONArray deliveryNotelistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("INV"))
  	    {
  		
      		sqltest+=" and d.out_qty>0  "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
			
 
/*				String sql="select mm.voc_no,mm.date,convert(if(mm.ref_type='DIR','Direct','Sales Order'),char(30)) dtype, "
						+ "	mm.refno,h.account,h.description acname,m.part_no productid,m.productname,m.part_no proid ,  "
						+ " sum(dd.op_qty-dd.foc) qty,convert(if(sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)=0,'',sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)),char(30)) Out_qty,  "
						+ "convert(if((sum(dd.op_qty-dd.foc)-sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc))=0,'',sum(dd.op_qty-dd.foc)-sum(dd.out_qty+dd.rsv_qty+dd.del_qty-dd.foc)),char(50)) balqty, "
						+ "	convert(if(sum(dd.foc)=0,'',sum(dd.foc)),char(30)) foc ,convert(if(sum(dd.foc_out)=0,'',sum(dd.foc_out)),char(30)) foc_out,convert(if(sum(dd.foc)-sum(dd.foc_out)=0,'',sum(dd.foc)-sum(dd.foc_out)),char(30)) focbal, "
						+ " d.prdId prodoc, u.unit, d.unitid unitdocno "
						+ " from  my_delm  mm left join my_deld d  on mm.doc_no=d.rdocno	left join my_head h on h.doc_no=mm.acno  "
						+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno  "
						+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no where  "
						+ " mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " group by d.psrno " ;
            	 */
				String sql="select mm.voc_no,mm.date,convert(if(mm.ref_type='DIR','Direct','Sales Order'),char(30)) dtype, "
						+ "	mm.refno,h.account,h.description acname,m.part_no productid,m.productname,m.part_no proid ,  "
						+ "  sum(d.qty) qty,convert(if(sum(d.Out_qty)=0,'',sum(d.Out_qty)),char(30)) Out_qty,sum(d.qty)-sum(d.out_qty) balqty, d.prdId prodoc, u.unit, d.unitid unitdocno "
						+ " from  my_delm  mm left join my_deld d  on mm.doc_no=d.rdocno	left join my_head h on h.doc_no=mm.acno  "
						+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno  "
						+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no where  "
						+ " mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " group by d.psrno " ;
				
				System.out.println("===deliveryNotelistsearch===="+sql);
				
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray deliveryNotelistsearchex(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("INV"))
  	    {
  		
      		sqltest+=" and  sd.out_qty>0 "; 
  	    }
     	 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
			
 
				String sql="select mm.voc_no doc_no,mm.date,mm.refno,convert(if(mm.ref_type='DIR','Direct','Sales Order'),char(30)) type, "
						+ "	h.account,h.description accountname,m.part_no productid,m.productname, u.unit,  "
						+ " sum(d.qty) qty,convert(if(sum(d.Out_qty)=0,'',sum(d.Out_qty)),char(30)) Out_qty,sum(d.qty)-sum(d.out_qty) balqty "
						+  " from  my_delm  mm left join my_deld d  on mm.doc_no=d.rdocno	left join my_head h on h.doc_no=mm.acno  "
						+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno  "
						+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no where  "
						+ " mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " group by d.psrno" ;
            	 
				System.out.println("===deliveryNotelistsearch===="+sql);
				
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	public   JSONArray delReturnlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
  /*  	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and dd.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("PIV"))
  	    {
  		
      		sqltest+=" and mm.status=3 and dd.pstatus=1  "; 
  	    }
     	*/ 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
			
  
				
				
				String sql="select mm.voc_no,mm.date,convert(if(mm.ref_type='DIR','Direct','Delivery Note Return'),char(30)) dtype, "
						+ " mm.refno,h.account,h.description acname,m.part_no productid,m.productname,m.part_no proid ,  "
						+ " sum(d.qty) qty,convert(if(sum(d.foc)=0,'',sum(d.foc)),char(30)) foc , "
						+ " d.prdId prodoc, u.unit, d.unitid unitdocno "
			            + " from  my_delrm  mm left join my_delrd d  on mm.doc_no=d.rdocno " 
			            + " left join my_head h on h.doc_no=mm.acno    left join my_prddin dd "
			            + " on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "
			            + " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on "
			            + " d.unitid=u.doc_no where mm.status=3 and   mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'" +sqltest+ "  group by dd.stockid ";
				
				
				
				
				
            System.out.println("-----delReturnlistsearch--"+sql); 
				
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public   JSONArray delReturnlistsearchex(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
  /*  	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and dd.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("PIV"))
  	    {
  		
      		sqltest+=" and mm.status=3 and dd.pstatus=1  "; 
  	    }
     	*/ 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
			
  
				
				
				String sql="select mm.voc_no doc_no,mm.date,mm.refno, "
						+ " h.account,h.description accountname,m.part_no productid,m.productname , u.unit, sum(d.qty) qty "
					 
			            + " from  my_delrm  mm left join my_delrd d  on mm.doc_no=d.rdocno " 
			            + " left join my_head h on h.doc_no=mm.acno    left join my_prddin dd "
			            + " on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno "
			            + " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on "
			            + " d.unitid=u.doc_no where mm.status=3 and   mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'" +sqltest+ "  group by dd.stockid ";
				
				
				
				
				
            System.out.println("-----delReturnlistsearch--"+sql); 
				
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	public JSONArray orddocnoSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
		

			String sql="select mm.doc_no,h.description name , mm.voc_no,b.BRANCHNAME  branch from my_sorderm mm "
					+ " left join my_sorderd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId "
					+ " left join my_unitm u on d.unitid=u.doc_no left join my_brch b on b.doc_no=mm.brhid left join my_head h on h.doc_no=mm.acno"
					+ "  where 1=1 group by mm.doc_no ";
			//System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	
	public JSONArray docnoSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
		

			String sql="select mm.doc_no,h.description name , mm.voc_no,b.BRANCHNAME  branch from my_invm mm "
					+ " left join my_invd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId "
					+ " left join my_unitm u on d.unitid=u.doc_no left join my_brch b on b.doc_no=mm.brhid left join my_head h on h.doc_no=mm.acno"
					+ "  where 1=1 group by mm.doc_no ";
			//System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	
	public JSONArray productSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
		

			String sql="select  d.prdId doc_no,   m.part_no prodcode,m.productname prodname,u.unit    from my_invm mm "
					+ " left join my_invd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId "
					+ " left join my_unitm u on d.unitid=u.doc_no  where 1=1 group by d.prdid ";
		//	System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public   JSONArray salesordlistsearchsumm(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and d.prdId='"+psrno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and bd.doc_no in ("+hidbrand+")";
		}

		if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			sql8=" and pt.doc_no in ("+hidtype+")";
		}

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and cat.doc_no in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and sc.doc_no in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.doc_no in ("+hidproduct+")";
		}
    
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();    
		
				
 
				String sql=" select 'View' butview, mm.doc_no,a.per_mob,cl.cat_name category,sa.sal_name salesman ,sf.sal_name salesperson,mm.tr_no,mm.voc_no,mm.date, case when mm.ref_type='DIR' then 'Direct'  when mm.ref_type='DEL' then 'Delivery Note' "
						+ " when mm.ref_type='JOR' then 'Job Order' when mm.ref_type='SOR' then 'Sales Order'  else 'Direct' end as 'dtype', "
						+ " if(paymode=2,'CREDIT','CASH') paymode, h.account,h.description acname,sum(d.nettotal) nettotal,sum(d.taxamount) taxamount,sum(d.nettotal+coalesce(d.taxamount,0)) totalamount "
						 + " from my_sorderm mm left join my_sorderd d on d.rdocno=mm.doc_no   left join my_head h on h.doc_no=mm.acno "
						 + "left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='CRM' left join my_salm sa on sa.doc_no=a.sal_id "
						 + " left join my_salm sf on sf.doc_no=mm.sal_id left join my_clcatm cl on cl.doc_no=a.catid "
						 + " where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by mm.doc_no ";
				
 
          
            	// System.out.println("-----saleslistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	public   JSONArray salesordlistsearchsummex(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and d.prdId='"+psrno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and bd.doc_no in ("+hidbrand+")";
		}

		if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			sql8=" and pt.doc_no in ("+hidtype+")";
		}

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and cat.doc_no in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and sc.doc_no in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.doc_no in ("+hidproduct+")";
		}
    
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
 
				String sql=" select mm.voc_no doc_no,mm.date, case when mm.ref_type='DIR' then 'Direct'  when mm.ref_type='DEL' then 'Delivery Note' "
						+ " when mm.ref_type='JOR' then 'Job Order' when mm.ref_type='SOR' then 'Sales Order'  else 'Direct' end as 'type', "
						+ " if(paymode=2,'CREDIT','CASH') 'mode of payment', h.account,h.description account_name,a.per_mob MOB,sum(dd.nettotal) nettotal,sum(dd.taxamount) 'taxamount',sum(dd.nettotal+coalesce(dd.taxamount,0))  'TOTAL',cl.cat_name Category,sa.sal_name Salesman   "
						 + " from my_sorderm mm left join my_sorderd dd on mm.doc_no=dd.rdocno  left join my_head h on h.doc_no=mm.acno "
						 + "left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='CRM' left join my_salm sa on sa.doc_no=a.sal_id "
						 + " left join my_salm sf on sf.doc_no=mm.sal_id left join my_clcatm cl on cl.doc_no=a.catid"
						 + " where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by mm.tr_no ";
				
	 
			
          
             	 System.out.println("-----saleslistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray salesordlistsearchdet(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and d.prdId='"+psrno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and bd.doc_no in ("+hidbrand+")";
		}

		if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			sql8=" and pt.doc_no in ("+hidtype+")";
		}

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and cat.doc_no in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and sc.doc_no in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.doc_no in ("+hidproduct+")";
		}
    
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
	 			String sql=" select a.per_mob,bd.brandname,mm.voc_no ,mm.date,convert(if(mm.ref_type='DIR','Direct','Direct'),char(30)) dtype,"
						+ " h.account,h.description acname,mm.refno, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "   d.qty  qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,"
						 + "  d.amount,d.total total,d.nettotal nettotal, d.taxamount  taxamount,d.nettotal+coalesce(d.taxamount) nettaxamount   "
						+ "  from my_sorderm mm left join my_sorderd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='CRM'  "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqljoin+"    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" "+sqlfinal+"     ";
			
 			 
          
           System.out.println("-----saleslistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public   JSONArray salesordlistsearchdetex(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and d.prdId='"+psrno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and bd.doc_no in ("+hidbrand+")";
		}

		if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			sql8=" and pt.doc_no in ("+hidtype+")";
		}

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and cat.doc_no in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and sc.doc_no in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.doc_no in ("+hidproduct+")";
		}
    
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
 
				
				String sql=" select mm.voc_no doc_no,mm.date,mm.refno,convert(if(mm.ref_type='DIR','Direct','Delivery Note'),char(30)) type,"
						+ "  h.account,h.description account_name,a.per_mob MOB, "
						+ "  m.part_no productid,m.productname,u.unit,bd.brandname 'brand name', "
						+ "  d.qty qty,convert(if(d.foc=0,'',d.foc),char(30)) foc "
						 + " , d.amount,d.total total,d.nettotal nettotal, d.taxamount  taxamount,d.nettotal+coalesce(d.taxamount) 'Total Amount'   "
						+ "  from my_sorderm mm left join my_sorderd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='CRM' "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqljoin+"    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" "+sqlfinal+"    ";
			
 			 

  
           //  	 System.out.println("-----saleslistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray saleslistsearchsumm(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and d.prdId='"+psrno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and bd.doc_no in ("+hidbrand+")";
		}

		if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			sql8=" and pt.doc_no in ("+hidtype+")";
		}

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and cat.doc_no in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and sc.doc_no in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.doc_no in ("+hidproduct+")";
		}
    
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
/*				
				String sql=" select mm.voc_no,mm.date,convert(if(mm.ref_type='DIR','Direct','Delivery Note'),char(30)) dtype,"
						+ "if(paymode=2,'CREDIT','CASH') paymode, h.account,h.description acname, "
				
						+ "  from my_invm mm left join my_invd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqljoin+"    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" "+sqlfinal+" ";
				
				*/  
				
				
  
				
				
				String sql=" select 'View' butview,mm.doc_no,a.per_mob,cl.cat_name category,mm.refinvno invoicenumber ,mm.refinvdate invoicedate,mm.tr_no,mm.voc_no,mm.date, case when mm.rdtype='PO' then 'Purchase Order' "
						+ " else 'Direct' end as 'dtype', "
						+ " h.account,h.description acname,sum(d.nettotal) nettotal,sum(d.taxamount)  taxamount, "
						+ " sum(d.nettotal+coalesce(d.taxamount,0)) totalamount "
						 + " from my_srvm mm  left join my_srvd d  on d.rdocno=mm.doc_no left join  my_jvtran j on j.tr_no=mm.tr_no and mm.acno=j.acno left join my_head h on h.doc_no=mm.acno "
						 + "left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='VND' "
						 + " left join my_clcatm cl on cl.doc_no=a.catid"
						 + " where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by mm.doc_no ";
				
				
	/*			String sql=" select mm.voc_no,mm.date,convert(if(mm.ref_type='DIR','Direct','Delivery Note'),char(30)) dtype,"
						+ "if(paymode=2,'CREDIT','CASH') paymode, h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_invm mm left join my_invd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqljoin+"    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" "+sqlfinal+" ";*/
			
          
            	 System.out.println("-----purchasesummarygridsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	public   JSONArray saleslistsearchsummex(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and d.prdId='"+psrno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and bd.doc_no in ("+hidbrand+")";
		}

		if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			sql8=" and pt.doc_no in ("+hidtype+")";
		}

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and cat.doc_no in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and sc.doc_no in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.doc_no in ("+hidproduct+")";
		}
    
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
/*				
				String sql=" select mm.voc_no,mm.date,convert(if(mm.ref_type='DIR','Direct','Delivery Note'),char(30)) dtype,"
						+ "if(paymode=2,'CREDIT','CASH') paymode, h.account,h.description acname, "
				
						+ "  from my_invm mm left join my_invd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqljoin+"    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" "+sqlfinal+" ";
				
				*/
				String sql=" select mm.voc_no doc_no,mm.date, case when mm.rdtype='PO' then 'Purchase Order' else 'Direct' end as 'type', "
						+ " h.account,h.description account_name,a.per_mob MOB,sum(dd.nettotal) nettotal, sum(dd.taxamount) 'Tax Amount',sum(dd.nettotal+coalesce(dd.taxamount,0)) 'TOTAL',cl.cat_name Category,mm.refinvno 'Invoice Number' ,mm.refinvdate 'Invoice Date' "
						 + " from my_srvm mm left join my_srvd dd on mm.doc_no=dd.rdocno left join  my_jvtran j on j.tr_no=mm.tr_no and mm.acno=j.acno left join my_head h on h.doc_no=mm.acno "
						 + "left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='VND' left join my_salm sa on sa.doc_no=a.sal_id "
						 + " left join my_salm sf on sf.doc_no=mm.sal_id left join my_clcatm cl on cl.doc_no=a.catid"
						 + " where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by mm.doc_no ";
				
				
	/*			String sql=" select mm.voc_no,mm.date,convert(if(mm.ref_type='DIR','Direct','Delivery Note'),char(30)) dtype,"
						+ "if(paymode=2,'CREDIT','CASH') paymode, h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_invm mm left join my_invd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqljoin+"    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" "+sqlfinal+" ";*/
			
          
             	 System.out.println("-----purchasesummarygridexcel------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray saleslistsearchdet(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and d.prdId='"+psrno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and bd.doc_no in ("+hidbrand+")";
		}

		if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			sql8=" and pt.doc_no in ("+hidtype+")";
		}

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and cat.doc_no in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and sc.doc_no in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.doc_no in ("+hidproduct+")";
		}
    
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
	 			String sql=" select a.per_mob,bd.brandname,mm.voc_no ,mm.date,convert(if(mm.rdtype='DIR','Direct','Purchase Order'),char(30)) dtype,"
						+ "h.account,h.description acname,mm.refno, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "   d.qty  qty,convert(if(d.foc=0,'',d.foc),char(30)) foc,"
						 + "  d.amount,d.total total,d.nettotal nettotal, d.taxamount  taxamount,d.nettotal+coalesce(d.taxamount) nettaxamount   "
						+ "  from my_srvm mm left join my_srvd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='VND'  "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqljoin+"    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" "+sqlfinal+"    ";
			
 			 
          
           System.out.println("-----purchasedetailgridsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	public   JSONArray saleslistsearchdetex(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and d.prdId='"+psrno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and bd.doc_no in ("+hidbrand+")";
		}

		if(!(hidtype.equalsIgnoreCase("0") || hidtype.equalsIgnoreCase("") || hidtype.equalsIgnoreCase("undefined"))){
			sql8=" and pt.doc_no in ("+hidtype+")";
		}

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and cat.doc_no in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and sc.doc_no in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.doc_no in ("+hidproduct+")";
		}
    
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
 
				
				String sql=" select mm.voc_no doc_no,mm.date,mm.refno,convert(if(mm.rdtype='DIR','Direct','Purchase Order'),char(30)) type,"
						+ "h.account,h.description account_name,a.per_mob MOB, "
						+ "  m.part_no productid,m.productname,u.unit,bd.brandname 'brand name', "
						+ "  d.qty qty,convert(if(d.foc=0,'',d.foc),char(30)) foc "
						 + " , d.amount,d.total total,d.nettotal nettotal, d.taxamount  taxamount,d.nettotal+coalesce(d.taxamount) 'Total Amount'   "
						+ "  from my_srvm mm left join my_srvd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='VND' "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqljoin+"    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" "+sqlfinal+"    ";
			
 			 

  
            	 System.out.println("-----purchasedetailexcel------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray salereturnlistsearchex(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
     
    
    
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select mm.voc_no,mm.date, if(paymode=2,'CREDIT','CASH') 'Mode Of Payment',mm.refno, "
						+ "  h.account,h.description accountname, "
						+ "  m.part_no productid,m.productname,u.unit, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_invr mm left join my_inrd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("------salereturnlistsearch-----"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray salereturnlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
     
    
    
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select  if(paymode=2,'CREDIT','CASH') paymode,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_invr mm left join my_inrd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("------salereturnlistsearch-----"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray ordercancellistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select  'Edit' btnsave, d.doc_No as rdocno,convert(if(mm.dtype='DIR','Direct','Sale Order'),char(30)) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  a.doc_no account,a.refname acname,d.doc_no rowno, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_sorderm mm left join my_sorderd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_acbook a on a.doc_no=mm.cldocno  and a.dtype='CRM' "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where d.qty!=d.out_qty  and d.clstatus=0 and"
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            	//System.out.println("--dsdsdsdsd---------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray ordercancellistshow(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.acno='"+acno+"'";
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
				
				
				String sql=" select   convert(if(mm.rdtype='DIR','Direct','Sale Enquiry'),char(30)) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_sorderm mm left join my_sorderd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where  d.clstatus=1 and "
						+ "  mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest;
			
          
            //	System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	       
	public   JSONArray qotecancellistshow(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement (); 
		 
				
				
				String sql=" select bv.fdate,mm.brhid,d.specno,(case when ref_type='DIR' then 'Direct' else 'Enquiry' end) dtype,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc, "
						+ "  h.account,h.description acname, "
						+ "  m.part_no productid,m.productname,u.unit, d.unitid unitdocno, "
						+ "  d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'',d.disper),char(30)) disper,"
						+ "  convert(if(d.discount=0,'',d.discount),char(30)) discount,d.nettotal  "
						+ "  from my_qotm mm left join my_qotd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no "
						+ "  left join my_head h on h.doc_no=mm.acno left join (select max(b.doc_no) doc_no,rdocno,prdid,specno from my_bsqf b group by  rdocno,prdid,specno) "
	        			+ "  b on(b.prdid=d.prdid and d.specno=b.specno and d.rdocno=b.rdocno) left join  my_bsqf bv on b.doc_no=bv.doc_no and d.prdid=bv.prdid and d.specno=bv.specno and d.rdocno=bv.rdocno "
						+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no)    where d.clstatus=1 and"
						+ "  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          
            	System.out.println("-----qotlistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	

	
	


 
}
