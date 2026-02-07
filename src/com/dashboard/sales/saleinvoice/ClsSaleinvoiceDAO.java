package com.dashboard.sales.saleinvoice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 




import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
public class ClsSaleinvoiceDAO { 

	
	

 
	
	
	  ClsConnection ClsConnection= new ClsConnection();
	  ClsCommon ClsCommon =new ClsCommon();
	  

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
	      
	   
 
	    
	    String  sql= "select a.doc_no,a.refname as account,a.refname description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_acbook a where dtype='CRM' "+sqltest;
	 
	    
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
					
		/*			String sql="  select d.rowno,bd.brandname,m.part_no productid,m.productname,u.unit,d.rdocno,     d.psrno, d.batch_no, d.exp_date, d.qty-d.out_qty qty,  d. out_qty,"
							+ "  d.amount unitprice, (d.qty-d.out_qty)*d.amount total, " 
							  + " d.disper, ((d.qty-d.out_qty)*d.amount*d.disper)/100  discount, StockId, bunit, (((d.qty-d.out_qty)*d.amount)-((d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal"
							  + " , d.foc-d.out_foc foc , d.out_foc,d.qty-d.out_qty chkqty,d.foc-d.out_foc,d.taxper   chkfoc "
					          + " from my_sorderd d left join my_main m on m.doc_no=d.psrno left join   my_unitm u on d.unitid=u.doc_no "
					          + " left join  my_brand bd on m.brandid=bd.doc_no  where d.rdocno='"+docno+"' and (((d.qty-d.out_qty)>0)  or  ((d.foc-d.out_foc)>0))   " ;
					
					 */
					String sql="  select d.doc_no  rowno,bd.brandname,m.part_no productid,m.productname,u.unit,d.rdocno,     d.psrno, d.qty-d.out_qty qty,  d. out_qty,"
							+ "  d.amount unitprice, (d.qty-d.out_qty)*d.amount total, " 
							  + " d.disper, ((d.qty-d.out_qty)*d.amount*d.disper)/100  discount, StockId, bunit, (((d.qty-d.out_qty)*d.amount)-((d.qty-d.out_qty)*d.amount*d.disper)/100) nettotal"
							  + " , d.foc-d.out_foc foc , d.out_foc,d.qty-d.out_qty chkqty,d.foc-d.out_foc  chkfoc,d.taxper "
					          + " from my_sorderd d left join my_main m on m.doc_no=d.psrno left join   my_unitm u on d.unitid=u.doc_no "
					          + " left join  my_brand bd on m.brandid=bd.doc_no  where d.rdocno='"+docno+"' and (((d.qty-d.out_qty)>0)  or  ((d.foc-d.out_foc)>0))   " ;
					
	           	System.out.println("----2------"+sql);	
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
					Statement stmtVeh1 = conn.createStatement ();
 
	/*				String sql=" select  mm.brhid branchvals,mm.refno,mm.doc_no,mm.voc_no,mm.date,mm.description, "
							+ "   h.account,h.description acname   from my_sorderm mm "
							+ "   left join  my_sorderd d on (d.rdocno=mm.doc_no and d.clstatus=0) left join my_sorderddet det on det.rdocno=mm.doc_no "
							+ "   left join my_head h on h.doc_no=mm.acno   where  mm.DATE>='"+sqlfromdate+"' and  mm.DATE<='"+sqltodate+"'  "
									+ "   "+sqltest+"  group by mm.doc_no having  (((sum(det.qty)-sum(det.out_qty))>0)  or  ((sum(det.foc)-sum(det.out_foc))>0))  " ;
					*/
					
					int docnoss=1;
					String loc_name="";
					
					
					
					String sqls="select doc_no,loc_name from my_locm where status=3 limit 1 ";
					ResultSet rsd=stmtVeh1.executeQuery(sqls);
					if(rsd.first())
					{
						docnoss=rsd.getInt("doc_no");
						loc_name=rsd.getString("loc_name");
					}
					
					
					
					String sql=" select "+docnoss+" locdoc, '"+loc_name+"' loc_name, mm.brhid branchvals,mm.refno,mm.doc_no,mm.voc_no,mm.date,mm.description, "
							+ "   h.account,h.description acname   from my_sorderm mm "
							+ "   left join  my_sorderd d on (d.rdocno=mm.doc_no)   "
							+ "   left join my_head h on h.doc_no=mm.acno   where  mm.DATE>='"+sqlfromdate+"' and mm.status=3 and  mm.DATE<='"+sqltodate+"'  and    ((d.qty>d.out_qty) or (d.foc>d.out_foc))  "
									+ "   "+sqltest+"  group by mm.doc_no " ;
	          
					
					
	          
	            	//System.out.println("-----orderlistsearch---aaaaaaaaaa---"+sql);	
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
