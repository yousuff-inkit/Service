package com.dashboard.procurment.productdetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.dashboard.sales.commercialreceiptreport.ClsCommercialReceiptBean;
public class ClsProductDetailsDAO {

	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	
	public   JSONArray stocklist(String branch,String status,String psrno,String load,String locid,String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String branchid,String hidept,String type,String cldocno,String acno) throws SQLException {

	
        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        

        String sqltest="";
        String sqltest1="";
        String sqltest2="";
        
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and i.brhid='"+branch+"'";
    		sqltest1+=" and i.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase(""))&&(!(psrno.equalsIgnoreCase("0"))))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
    	if((!(locid.equalsIgnoreCase("NA")) )&&(!(locid.equalsIgnoreCase(""))&&(!(locid.equalsIgnoreCase("0"))))){
    		sqltest2+=" and i.locid='"+locid+"'";
 		}
    	
    	if((!(hidbrand.equalsIgnoreCase("NA")) )&&(!(hidbrand.equalsIgnoreCase(""))&&(!(hidbrand.equalsIgnoreCase("0"))))){
    		sqltest+=" and m.brandid in("+hidbrand+")";
 		}
    	if((!(hidtype.equalsIgnoreCase("NA")) )&&(!(hidtype.equalsIgnoreCase(""))&&(!(hidtype.equalsIgnoreCase("0"))))){
    		sqltest+=" and m.typeid in ("+hidtype+")";
 		}
    	if((!(hidproduct.equalsIgnoreCase("NA")) )&&(!(hidproduct.equalsIgnoreCase(""))&&(!(hidproduct.equalsIgnoreCase("0"))))){
    		sqltest+=" and m.doc_no in ("+hidproduct+")";
 		}
    	if((!(hidcat.equalsIgnoreCase("NA")) )&&(!(hidcat.equalsIgnoreCase(""))&&(!(hidcat.equalsIgnoreCase("0"))))){
    		sqltest+=" and m.catid in ("+hidcat+")";
 		}
    	if((!(hidsubcat.equalsIgnoreCase("NA")) )&&(!(hidsubcat.equalsIgnoreCase(""))&&(!(hidsubcat.equalsIgnoreCase("0"))))){
    		sqltest+=" and m.scatid in ("+hidsubcat+")";
 		}
    	if((!(hidept.equalsIgnoreCase("NA")) )&&(!(hidept.equalsIgnoreCase(""))&&(!(hidept.equalsIgnoreCase("0"))))){
    		sqltest+=" and m.deptid in ("+hidept+")";
 		}
    	System.out.println("=====cldocnlo======="+cldocno);
    	String sqltest3="";
    	if((!(cldocno.equalsIgnoreCase("NA")) )&&(!(cldocno.equalsIgnoreCase(""))&&(!(cldocno.equalsIgnoreCase("0"))))){
    		sqltest+=" and vb.rdocno='"+cldocno+"'";
    		sqltest3= " inner join my_vendorbrand vb on vb.brandid=m.brandid ";
    		
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
	
				/*String sql=" select c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout where 1=1  group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1  "+sqltest1+"  group by i.stockid) b group by b.prdid ) c left join my_main m on m.doc_no=c.prdId  "
							+ "left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  "
							+ "my_brand bd on m.brandid=bd.doc_no where 1=1 and c.qty>0 "+sqltest ;
				*/
/*				String sql="select i.locid,i.brhid,d.department,bd.brandname,round(i.qty,0) qty ,m.part_no productid,m.productname,"
						+ " round(fixingprice,2) price, DATE_FORMAT(exp_date, '%d-%m-%Y')expry, convert(concat (round(coalesce(f1.qty,''),0),'+', (round(coalesce (f1.foc,''),0) )),char(100)) 'foc1'"
						+ " ,convert(concat (round(coalesce(f2.qty,''),0),'+',round(coalesce (f2.foc,''),0)),char(100)) foc2,"
						+ " convert(concat (round(coalesce(f3.qty,''),0),'+',round(coalesce(f3.foc,''),0)) ,char(100))foc3   from my_main m inner join (select i.locid,i.brhid,"
						+ " sum(i.op_qty-i.out_qty) qty,i.prdid from my_prddin i where 1=1 "+sqltest2+" group by psrno having qty>0)  i on m.doc_no=i.prdId"
						+ " inner join (select i.locid,i.brhid,sum(i.op_qty-i.out_qty) qty,min(exp_date) exp_date,i.prdid from my_prddin i where 1=1 "+sqltest2+" "
						+ " group by psrno having qty>0)  e on m.doc_no=e.prdId  left join my_desc de on(de.psrno=m.doc_no and i.brhid= de.brhid)"
						+ " left join  my_brand bd on m.brandid=bd.doc_no left join  my_prodfocfixing f1 on f1.psrno=m.psrno and f1.sr_no=1"
						+ " left join  my_prodfocfixing f2 on f2.psrno=m.psrno and f2.sr_no=2 left join  my_prodfocfixing f3 on f3.psrno=m.psrno and f3.sr_no=3"
						+ "  left join my_dept d on d.doc_no=m.deptid where 1=1 "+sqltest+" "  ;
			
				*/
				String sql="select reorderlevel,reorderqty,m.psrno,i.locid,i.brhid,d.department,bd.brandname,round(i.qty,0) stkqty,0 qty ,0 foc ,0 extfoc ,m.part_no productid,m.productname,"
						+ " round(0,2) price, DATE_FORMAT(exp_date, '%d-%b-%Y')expry  from my_main m left join (select i.locid,i.brhid,"
						+ " sum(i.op_qty-i.out_qty) qty,i.prdid from my_prddin i where 1=1 "+sqltest2+" group by psrno)  i on m.doc_no=i.prdId"
						+ " left join (select i.locid,i.brhid,sum(i.op_qty-i.out_qty) qty,min(exp_date) exp_date,i.prdid from my_prddin i where 1=1 and (i.op_qty-i.out_qty)>0 "+sqltest2+" "
						+ " group by psrno )  e on m.doc_no=e.prdId  left join my_desc de on(de.psrno=m.doc_no and (i.brhid= de.brhid or de.cmpid=1))"
						+ " left join  my_brand bd on m.brandid=bd.doc_no "
						+ "  left join my_dept d on d.doc_no=m.deptid  "+sqltest3+" where 1=1 "+sqltest+" "+sqltest2+" "  ;
          	System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	public   JSONArray stockExcellist(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        

        String sqltest="";
        String sqltest1="";
        
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and i.brhid='"+branch+"'";
    		sqltest1+=" and i.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    	   
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
	
				/*String sql=" select m.part_no 'product id',m.productname 'product Name', bd.brandname 'Brand Name',c.qty,c.amount from "
						+ "(select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 "+sqltest1+" group by i.stockid) b group by b.prdid ) c left join my_main m on m.doc_no=c.prdId  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 and c.qty>0 "+sqltest ;
				*/

				String sql=" select m.part_no 'product id',m.productname 'product Name', bd.brandname 'Brand Name',i.qty 'Quantity' "
						+ "	from my_main m inner join (select i.brhid,sum(i.op_qty-i.out_qty) qty,i.prdid   from my_prddin i group by psrno,brhid having qty>0)  i  on m.doc_no=i.prdId  left join my_desc de on(de.psrno=m.doc_no and i.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 "+sqltest ;
				
          //	System.out.println("-----------"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray stockExcellistqty(String branch,String status,String psrno,String load,String locid,String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String branchid,String hidept,String type,String cldocno,String acno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	      /*  
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
	     
	     	}*/
	        
	        
	        if(!(load.equalsIgnoreCase("yes")))
	        {
	        	return RESULTDATA;
	        }
	        

	        String sqltest="";
	        String sqltest1="";
	        String sqltest2="";
	        
	    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    		sqltest+=" and i.brhid='"+branch+"'";
	    		sqltest1+=" and i.brhid='"+branch+"'";
	 		}
	    	
	    	 
	    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase(""))&&(!(psrno.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.doc_no='"+psrno+"'";
	 		}
	    	
	    	if((!(locid.equalsIgnoreCase("NA")) )&&(!(locid.equalsIgnoreCase(""))&&(!(locid.equalsIgnoreCase("0"))))){
	    		sqltest2+=" and i.locid='"+locid+"'";
	 		}
	    	
	    	if((!(hidbrand.equalsIgnoreCase("NA")) )&&(!(hidbrand.equalsIgnoreCase(""))&&(!(hidbrand.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.brandid in("+hidbrand+")";
	 		}
	    	if((!(hidtype.equalsIgnoreCase("NA")) )&&(!(hidtype.equalsIgnoreCase(""))&&(!(hidtype.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.typeid in ("+hidtype+")";
	 		}
	    	if((!(hidproduct.equalsIgnoreCase("NA")) )&&(!(hidproduct.equalsIgnoreCase(""))&&(!(hidproduct.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.doc_no in ("+hidproduct+")";
	 		}
	    	if((!(hidcat.equalsIgnoreCase("NA")) )&&(!(hidcat.equalsIgnoreCase(""))&&(!(hidcat.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.catid in ("+hidcat+")";
	 		}
	    	if((!(hidsubcat.equalsIgnoreCase("NA")) )&&(!(hidsubcat.equalsIgnoreCase(""))&&(!(hidsubcat.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.scatid in ("+hidsubcat+")";
	 		}
	    	if((!(hidept.equalsIgnoreCase("NA")) )&&(!(hidept.equalsIgnoreCase(""))&&(!(hidept.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.deptid in ("+hidept+")";
	 		}
	    	System.out.println("=====cldocnlo======="+cldocno);
	    	String sqltest3="";
	    	if((!(cldocno.equalsIgnoreCase("NA")) )&&(!(cldocno.equalsIgnoreCase(""))&&(!(cldocno.equalsIgnoreCase("0"))))){
	    		sqltest+=" and vb.rdocno='"+cldocno+"'";
	    		sqltest3= " inner join my_vendorbrand vb on vb.brandid=m.brandid ";
	    		
	 		}
	    	
	 
	    	   
	    	
	     	Connection conn = null;
	        
			try {
					 conn = ClsConnection.getMyConnection();
					Statement stmt = conn.createStatement ();   
			
					
					
		
					/*String sql=" select c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
							    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
								+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout where 1=1  group by stockid) a on a.stockid=i.stockid "
								+ "  where 1=1  "+sqltest1+"  group by i.stockid) b group by b.prdid ) c left join my_main m on m.doc_no=c.prdId  "
								+ "left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  "
								+ "my_brand bd on m.brandid=bd.doc_no where 1=1 and c.qty>0 "+sqltest ;
					*/
	/*				String sql="select i.locid,i.brhid,d.department,bd.brandname,round(i.qty,0) qty ,m.part_no productid,m.productname,"
							+ " round(fixingprice,2) price, DATE_FORMAT(exp_date, '%d-%m-%Y')expry, convert(concat (round(coalesce(f1.qty,''),0),'+', (round(coalesce (f1.foc,''),0) )),char(100)) 'foc1'"
							+ " ,convert(concat (round(coalesce(f2.qty,''),0),'+',round(coalesce (f2.foc,''),0)),char(100)) foc2,"
							+ " convert(concat (round(coalesce(f3.qty,''),0),'+',round(coalesce(f3.foc,''),0)) ,char(100))foc3   from my_main m inner join (select i.locid,i.brhid,"
							+ " sum(i.op_qty-i.out_qty) qty,i.prdid from my_prddin i where 1=1 "+sqltest2+" group by psrno having qty>0)  i on m.doc_no=i.prdId"
							+ " inner join (select i.locid,i.brhid,sum(i.op_qty-i.out_qty) qty,min(exp_date) exp_date,i.prdid from my_prddin i where 1=1 "+sqltest2+" "
							+ " group by psrno having qty>0)  e on m.doc_no=e.prdId  left join my_desc de on(de.psrno=m.doc_no and i.brhid= de.brhid)"
							+ " left join  my_brand bd on m.brandid=bd.doc_no left join  my_prodfocfixing f1 on f1.psrno=m.psrno and f1.sr_no=1"
							+ " left join  my_prodfocfixing f2 on f2.psrno=m.psrno and f2.sr_no=2 left join  my_prodfocfixing f3 on f3.psrno=m.psrno and f3.sr_no=3"
							+ "  left join my_dept d on d.doc_no=m.deptid where 1=1 "+sqltest+" "  ;
				
					*/
					String sql="select i.locid,i.brhid,d.department,bd.brandname,round(i.qty,0) qty ,m.part_no productid,m.productname,"
							+ " round(fixingprice,2) price, DATE_FORMAT(exp_date, '%d-%b-%Y')expry  from my_main m left join (select i.locid,i.brhid,"
							+ " sum(i.op_qty-i.out_qty) qty,i.prdid from my_prddin i where 1=1 "+sqltest2+" group by psrno having qty>0)  i on m.doc_no=i.prdId"
							+ " left join (select i.locid,i.brhid,sum(i.op_qty-i.out_qty) qty,min(exp_date) exp_date,i.prdid from my_prddin i where 1=1 and (i.op_qty-i.out_qty)>0 "+sqltest2+" "
							+ " group by psrno having qty>0)  e on m.doc_no=e.prdId  left join my_desc de on(de.psrno=m.doc_no and i.brhid= de.brhid)"
							+ " left join  my_brand bd on m.brandid=bd.doc_no "
							+ "  left join my_dept d on d.doc_no=m.deptid  "+sqltest3+" where 1=1 "+sqltest+" "+sqltest2+" "  ;
	          	System.out.println("-----------"+sql);	
	            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	
	public   JSONArray stockdetlist(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and c.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
					/* branchname loc_name
				String sql=" select c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 "+sqltest ;
				*/
				
				String sql="  select bc.branchname,lc.loc_name,c.locid,c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from "
						 + "  (select  b.locid,b.brhid,b.qty qty,b.prdid,amount amount from (select i.locid,i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						 + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
						 + "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a "
						 + "  on a.stockid=i.stockid   where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId "
						 + "  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) left join my_brch bc on bc.doc_no=c.brhid "
						 + " left join my_locm lc on lc.doc_no=c.locid left join  my_brand bd on m.brandid=bd.doc_no where 1=1 and qty>0 "+sqltest;
				     
          //	System.out.println("-------asdas----"+sql);	
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	public   JSONArray stockexceldetlist(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and c.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
					/* branchname loc_name
				String sql=" select c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 "+sqltest ;
				*/
				
				String sql="  select m.part_no 'product id',m.productname 'product name',bd.brandname 'Brand Name',bc.branchname 'Branch',lc.loc_name 'Location',c.qty,c.amount from "
						 + "  (select  b.locid,b.brhid,b.qty qty,b.prdid,amount amount from (select i.locid,i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						 + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
						 + "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a "
						 + "  on a.stockid=i.stockid   where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId "
						 + "  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) left join my_brch bc on bc.doc_no=c.brhid "
						 + " left join my_locm lc on lc.doc_no=c.locid left join  my_brand bd on m.brandid=bd.doc_no where 1=1 and qty>0 "+sqltest;
				     
          //	System.out.println("-------asdas----"+sql);	
				ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	public   JSONArray stockexceldetlistqty(String branch,String status,String psrno,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
      /*  
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
     
     	}*/
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and c.brhid='"+branch+"'";
 		}
    	
    	 
    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase("")))){
    		sqltest+=" and m.doc_no='"+psrno+"'";
 		}
    	
 
    
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();   
		
				
				
					/* branchname loc_name
				String sql=" select c.brhid,bd.brandname,c.qty,m.part_no productid,m.productname,c.amount from (select  b.brhid,sum(b.qty) qty,b.prdid,sum(amount) amount from (select i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						    + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
							+ "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a on a.stockid=i.stockid "
							+ "  where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid)  left join  my_brand bd on m.brandid=bd.doc_no where 1=1 "+sqltest ;
				*/
				
				String sql="  select m.part_no 'product id',m.productname 'product name',bd.brandname 'Brand Name',bc.branchname 'Branch',lc.loc_name 'Location',c.qty from "
						 + "  (select  b.locid,b.brhid,b.qty qty,b.prdid,amount amount from (select i.locid,i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
						 + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
						 + "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a "
						 + "  on a.stockid=i.stockid   where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId "
						 + "  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) left join my_brch bc on bc.doc_no=c.brhid "
						 + " left join my_locm lc on lc.doc_no=c.locid left join  my_brand bd on m.brandid=bd.doc_no where 1=1 and qty>0 "+sqltest;
				     
          //	System.out.println("-------asdas----"+sql);	
				ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
     				stmt.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }	
	
	
	
	
	public JSONArray productSearch(HttpSession session,String docnos,String prdid,String prdname,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
		
			
			if(!((prdid.equalsIgnoreCase("")) || (prdid.equalsIgnoreCase("NA")))){
				sql1+=" and m.part_no like'%"+prdid+"%' ";
	 		}
			if(!((prdname.equalsIgnoreCase("")) || (prdname.equalsIgnoreCase("NA")))){
				sql1+=" and m.productname like '%"+prdname+"%' ";
	 		}
			
			if(load.equalsIgnoreCase("yes"))
					{
			
		 
				    	
			String sql="select m.psrno doc_no,m.part_no prodcode,m.productname prodname,um.unit from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
					+ "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no) left join my_desc de on(de.psrno=m.doc_no)    "
					+ " left join my_unit u on(u.psrno=m.psrno) left join my_unitm um on(um.doc_no=u.unit)  where m.status=3  and de.discontinued=0 "+sql1+ "group by m.doc_no  ";
		//	System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
					}

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray locationSearch(HttpSession session,String docnos,String locname,String load) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
		
			
			
			if(!((locname.equalsIgnoreCase("")) || (locname.equalsIgnoreCase("NA")))){
				sql1+=" and m.loc_name like '%"+locname+"%' ";
	 		}
			
			if(load.equalsIgnoreCase("yes"))
					{
			
		 
				    	
			String sql="select doc_no,loc_name,address,tel from my_locm m where 1=1 "+sql1+ "  ";
		//	System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
					}

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	
	
	
	public ClsProductDetailsBean getPrint(HttpServletRequest request,String branch,String status,String psrno,String locid,String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String branchid,String hidept,String type,String cldocno,String acno) throws SQLException {
		ClsProductDetailsBean bean = new ClsProductDetailsBean();
		
		Connection conn = null;

	try {
		 String sqltest="";
	        String sqltest1="";
	        String sqltest2="";
	        
	    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    		sqltest+=" and i.brhid='"+branch+"'";
	    		sqltest1+=" and i.brhid='"+branch+"'";
	 		}
	    	
	    	 
	    	if((!(psrno.equalsIgnoreCase("NA")) )&&(!(psrno.equalsIgnoreCase(""))&&(!(psrno.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.doc_no='"+psrno+"'";
	 		}
	    	
	    	if((!(locid.equalsIgnoreCase("NA")) )&&(!(locid.equalsIgnoreCase(""))&&(!(locid.equalsIgnoreCase("0"))))){
	    		sqltest2+=" and i.locid='"+locid+"'";
	 		}
	    	
	    	if((!(hidbrand.equalsIgnoreCase("NA")) )&&(!(hidbrand.equalsIgnoreCase(""))&&(!(hidbrand.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.brandid in("+hidbrand+")";
	 		}
	    	if((!(hidtype.equalsIgnoreCase("NA")) )&&(!(hidtype.equalsIgnoreCase(""))&&(!(hidtype.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.typeid in ("+hidtype+")";
	 		}
	    	if((!(hidproduct.equalsIgnoreCase("NA")) )&&(!(hidproduct.equalsIgnoreCase(""))&&(!(hidproduct.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.doc_no in ("+hidproduct+")";
	 		}
	    	if((!(hidcat.equalsIgnoreCase("NA")) )&&(!(hidcat.equalsIgnoreCase(""))&&(!(hidcat.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.catid in ("+hidcat+")";
	 		}
	    	if((!(hidsubcat.equalsIgnoreCase("NA")) )&&(!(hidsubcat.equalsIgnoreCase(""))&&(!(hidsubcat.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.scatid in ("+hidsubcat+")";
	 		}
	    	if((!(hidept.equalsIgnoreCase("NA")) )&&(!(hidept.equalsIgnoreCase(""))&&(!(hidept.equalsIgnoreCase("0"))))){
	    		sqltest+=" and m.deptid in ("+hidept+")";
	 		}
	    	System.out.println("=====cldocnlo======="+cldocno);
	    	String sqltest3="";
	    	if((!(cldocno.equalsIgnoreCase("NA")) )&&(!(cldocno.equalsIgnoreCase(""))&&(!(cldocno.equalsIgnoreCase("0"))))){
	    		sqltest+=" and vb.rdocno='"+cldocno+"'";
	    		sqltest3= " inner join my_vendorbrand vb on vb.brandid=m.brandid ";
	    		
	 		}
		conn = ClsConnection.getMyConnection();
		Statement stmtCMR = conn.createStatement();
		java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        ClsCommon commonDAO= new ClsCommon();
        
		String sqld="",sql="",sql1 = "",sql2 = "",sql3 = "";
		
		
		sql="select 'Offer List' vouchername,(DATE_FORMAT(now(),'%d-%m-%Y ')) vouchername1,c.company,c.address,c.tel,c.fax,"
				+ " lc.loc_name location,b.branchname,b.pbno,b.stcno,b.cstno from"
				+ " my_brch b inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no inner join"
				+ " (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) limit 1";
		
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

		if(commonDAO.getBIBPrintPath("BSL").contains(".jrxml")==true)
		{
			
		} else {
			
		sql1 ="select i.locid,i.brhid,d.department,bd.brandname,round(i.qty,0) qty ,m.part_no productid,m.productname,"
				+ " round(fixingprice,2) price, DATE_FORMAT(exp_date, '%d-%m-%Y')expry  from my_main m left join (select i.locid,i.brhid,"
				+ " sum(i.op_qty-i.out_qty) qty,i.prdid from my_prddin i where 1=1 "+sqltest2+" group by psrno having qty>0)  i on m.doc_no=i.prdId"
				+ " left join (select i.locid,i.brhid,sum(i.op_qty-i.out_qty) qty,min(exp_date) exp_date,i.prdid from my_prddin i where 1=1 "+sqltest2+" "
				+ " group by psrno having qty>0)  e on m.doc_no=e.prdId  left join my_desc de on(de.psrno=m.doc_no and i.brhid= de.brhid)"
				+ " left join  my_brand bd on m.brandid=bd.doc_no "
				+ "  left join my_dept d on d.doc_no=m.deptid  "+sqltest3+" where 1=1 "+sqltest+" "+sqltest2+" "  ;
  	System.out.println("-----------"+sql1);	
		
		ResultSet resultSet1 = stmtCMR.executeQuery(sql1);
		
		ArrayList<String> printarray= new ArrayList<String>();
		
		while(resultSet1.next()){

			String temp="";
			temp=resultSet1.getString("department")+"::"+resultSet1.getString("productid")+"::"+resultSet1.getString("productname")+"::"+resultSet1.getString("qty")+"::"+resultSet1.getString("expry")+"::"+resultSet1.getString("price")+"::"+resultSet1.getString("foc1")+"::"+resultSet1.getString("foc2")+"::"+resultSet1.getString("foc3");
		    
			printarray.add(temp);
		}
		
		request.setAttribute("printingarray", printarray);
		
		}
		
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
	
	
	
	public JSONArray typeSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,producttype ptype from my_ptype where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	
	public JSONArray suitbrandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,brand from (select doc_no,brand from my_sbrand where status=3 union all select '-1','ALL') as a ";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray brandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray deptSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select department dept, doc_no from my_dept where status<>7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray catSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select category cat,doc_no  from my_catm where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	public JSONArray subCatSearch(HttpSession session,String catid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select subcategory subcat,s.doc_no,category cat  from my_scatm s inner join my_catm c on(c.doc_no=s.catid) and c.doc_no in ("+catid+")";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray vendorSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select ac.cldocno,ac.acno,ac.refname,h.account from my_acbook ac "
					+ " left join my_head h on h.doc_no=ac.acno "
					+ " where ac.dtype='VND' and ac.status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
}
