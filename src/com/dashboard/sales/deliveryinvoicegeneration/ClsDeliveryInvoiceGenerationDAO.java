package com.dashboard.sales.deliveryinvoicegeneration;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDeliveryInvoiceGenerationDAO {

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
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
				String sql="select mm.vattype,mm.locid,mm.brhid,mm.doc_no,mm.voc_no,mm.date,convert(if(mm.ref_type='DIR','Direct','Sales Order'),char(30)) dtype, "
						+ "	mm.refno,h.account,d.psrno as prodoc,h.description acname,m.part_no productid,m.productname,m.part_no proid,d.specno as specid ,d.amount unitprice,d.disper,d.discount,d.nettotal,d.taxper,d.nettaxamount,d.taxamount,d.total,  "
						+ "  sum(d.qty) qty,convert(if(sum(d.Out_qty)=0,'',sum(d.Out_qty)),char(30)) Out_qty,sum(d.qty)-sum(d.out_qty) balqty, d.prdId prodoc, u.unit, d.unitid unitdocno "
						+ " from  my_delm  mm left join my_deld d  on mm.doc_no=d.rdocno	left join my_head h on h.doc_no=mm.acno  "
						+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno  "
						+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no where   "
						+ " mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " group by d.doc_no having sum(d.qty-d.out_qty)>0 order by d.doc_no " ;
				
				System.out.println("===deliveryNotelistsearch1===="+sql);
				
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
			
 
				String sql="select mm.locid,mm.brhid,mm.doc_no,mm.voc_no,mm.date,mm.refno,convert(if(mm.ref_type='DIR','Direct','Sales Order'),char(30)) type, "
						+ "	h.account,h.description accountname,m.part_no productid,m.productname, u.unit,d.amount unitprice,d.psrno as prodoc,d.specno as specid,d.disper,d.discount,d.nettotal,d.taxper,d.nettaxamount,d.taxamount,d.total,  "
						+ " sum(d.qty) qty,convert(if(sum(d.Out_qty)=0,'',sum(d.Out_qty)),char(30)) Out_qty,sum(d.qty)-sum(d.out_qty) balqty "
						+  " from  my_delm  mm left join my_deld d  on mm.doc_no=d.rdocno	left join my_head h on h.doc_no=mm.acno  "
						+ " left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno  "
						+ " left join my_main m on m.doc_no=d.prdId	 left join my_unitm u on d.unitid=u.doc_no where  "
						+ " mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' " +sqltest+ " group by d.doc_no having sum(d.qty-d.out_qty)>0 order by d.doc_no " ;
            	 
				System.out.println("===deliveryNotelistsearch2===="+sql);
				
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
                         sqltest=sqltest+" and a.doc_no like '%"+accountno+"%'";
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
      
   

    
    String  sql= "select a.acno doc_no,a.refname as account,a.refname description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_acbook a where dtype='CRM' "+sqltest;
 
    
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
}
