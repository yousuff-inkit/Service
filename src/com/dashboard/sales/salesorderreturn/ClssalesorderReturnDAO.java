package com.dashboard.sales.salesorderreturn;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClssalesorderReturnDAO {

	

	 
	
	
	  ClsConnection ClsConnection= new ClsConnection();
	  ClsCommon ClsCommon =new ClsCommon();
	  
	public   JSONArray listsearch(String docno,String branch) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
      
      
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
		
 
			    String sqltest="";
		        
		    //	System.out.println("---branch-----"+branch);	
		    	if((!(branch.equalsIgnoreCase("a")) && (!(branch.equalsIgnoreCase("NA"))) && (!(branch.equalsIgnoreCase("0")) ))){
		    		sqltest+=" and brhid='"+branch+"'";
		 		}	

				
/*					 
				*/
				
				String sql="  select d.taxper,d.rdocno orddocno,d.doc_no rowno,bd.brandname,m.part_no productid,m.productname,u.unit,d.rdocno,    d.psrno , d.qty-d.out_qty qty,  d. out_qty,"
						+ "  d.amount unitprice, (d.qty-d.out_qty)*d.amount total, " 
						  + " d.disper, ((d.qty-d.out_qty)*d.amount*d.disper)/100  discount,   (((d.qty-d.out_qty)*d.amount)-((d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal, d.foc-d.out_foc foc , d.out_foc,d.qty-d.out_qty chkqty,d.foc-d.out_foc  chkfoc "
				          + " from   my_sorderd d    left join my_main m on m.doc_no=d.psrno left join   my_unitm u on d.unitid=u.doc_no "
				          + " left join  my_brand bd on m.brandid=bd.doc_no  where d.rdocno='"+docno+"' and (((d.qty-d.out_qty)>0)  or  ((d.foc-d.out_foc)>0))   " ;
				
				 
				
				
          // 	System.out.println("----2------"+sql);	
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
	

	public   JSONArray searchLocation(String  barchval) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 

		     String sqltest="";
		    	if(!((barchval.equalsIgnoreCase("a")) || (barchval.equalsIgnoreCase("NA")))){
		    		sqltest+=" and brhid='"+barchval+"'";
		 		}
		    	
			

			String sql="select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3  "+sqltest+"";
			System.out.println("-----searchLocation===---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
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
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	/*if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		*/
    	/*else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}
  	
    
     	else if(status.equalsIgnoreCase("GRN"))
  	    {
  		
      		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
  	    }
     	 
    	   */
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();    
		 
				
				
/*					String sql=" select mm.brhid branchvals,mm.refno,mm.doc_no,mm.voc_no,mm.date,mm.description, "
						+ "  h.account,h.description acname "
						+ "  from my_sorderm mm  left join  my_sorderd d on (d.rdocno=mm.doc_no and d.clstatus=0) "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  where "
						+ "  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  and d.clstatus=0 and (((d.qty-d.out_qty)>0)  or  ((d.foc-d.out_foc)>0))   "+sqltest+" group by mm.doc_no";
			
				
				*/


				String sql=" select mm.status, mm.brhid branchvals,mm.refno,mm.doc_no,mm.voc_no,mm.date,mm.description, "
						+ "   h.account,h.description acname   from my_sorderm mm "
						+ "   left join  my_sorderd d on (d.rdocno=mm.doc_no )   "
						+ "   left join my_head h on h.doc_no=mm.acno   where  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "
								+ "   "+sqltest+"   group by mm.doc_no having  (((sum(d.qty)-sum(d.out_qty))>0)  or  ((sum(d.foc)-sum(d.out_foc))>0))  " ;
          
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

	
  public   JSONArray returnorderlistsearch(String branch,String fromdate,String todate,String status,String acno) throws SQLException {

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
  	
  	/*if(status.equalsIgnoreCase("All"))
  	{
  		sqltest+=" and  mm.status=3 ";	
  	}
  		*/
  	/*else if(status.equalsIgnoreCase("PED"))
   	{
   		
   		sqltest+=" and mm.status=3 and d.out_qty=0 ";
   		 
		
    	}
	
  
   	else if(status.equalsIgnoreCase("GRN"))
	    {
		
    		sqltest+=" and mm.status=3 and d.out_qty!=0  "; 
	    }
   	 
  	   */
  	
   	Connection conn = null;
      
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();    
		 
				
				
/*					String sql=" select mm.brhid branchvals,mm.refno,mm.doc_no,mm.voc_no,mm.date,mm.description, "
						+ "  h.account,h.description acname "
						+ "  from my_sorderm mm  left join  my_sorderd d on (d.rdocno=mm.doc_no and d.clstatus=0) "
						+ "  left join my_head h on h.doc_no=mm.acno "
						+ "  where "
						+ "  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  and d.clstatus=0 and (((d.qty-d.out_qty)>0)  or  ((d.foc-d.out_foc)>0))   "+sqltest+" group by mm.doc_no";
			
				
				*/


				String sql=" select  mm.brhid branchvals,mm.refno,mm.doc_no,mm.voc_no,mm.date,mm.description, "
						+ "   h.account,h.description acname   from my_sorderm mm "
						+ "     inner join my_sorderretd det on det.rdocno=mm.doc_no "
						+ "   left join my_head h on h.doc_no=mm.acno   where  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "
								+ "   "+sqltest+"  group by mm.doc_no    " ;
        
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

	
  public   JSONArray retlistsearchdet(String docno,String branch) throws SQLException {

      JSONArray RESULTDATA=new JSONArray();
      
    
    
   	Connection conn = null;
      
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
		

			    String sqltest="";
		        
		    //	System.out.println("---branch-----"+branch);	
		    	if((!(branch.equalsIgnoreCase("a")) && (!(branch.equalsIgnoreCase("NA"))) && (!(branch.equalsIgnoreCase("0")) ))){
		    		sqltest+=" and brhid='"+branch+"'";
		 		}	

				
/*			TR_NO, RDOCNO, DOC_NO, SR_NO, psrno, prdId, qty, fr, OUT_QTY, amount, total, disper, discount, UNITID, SpecNo, ref_row, StockId, nettotal, foc, BATCHNO, out_foc, locId, bExpiry		 
				*/
				
				String sql="  select bd.brandname,m.part_no productid,m.productname,u.unit,d.rdocno ,u.unit,  d.psrno, d.BATCHNO batch_no, d.bExpiry exp_date,d.qty qty ,"
						+ "  d.amount unitprice, d.total, " 
						  + " d.disper, d.discount,   d.nettotal, convert(if(d.foc=0,'',d.foc),char(100))  foc   "
				          + " from my_sorderretd d left join my_main m on m.doc_no=d.psrno   left join  my_sorderd d1 on d1.rdocno=d.rdocno and d1.psrno=d.psrno left join   my_unitm u on d1.unitid=u.doc_no "
				          + " left join  my_brand bd on m.brandid=bd.doc_no  where d.rdocno='"+docno+"'    " ;
				
				 
				
				
       //  System.out.println("----2------"+sql);	
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
	
	
	
}
