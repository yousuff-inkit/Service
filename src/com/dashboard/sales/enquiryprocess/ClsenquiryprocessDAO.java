package com.dashboard.sales.enquiryprocess;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
 
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

 
public class ClsenquiryprocessDAO { 
	
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection =new ClsConnection();

	public   JSONArray mastersearch(String branch,String fromdate,String todate) throws SQLException {

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
    		sqltest+=" and m.brhid='"+branch+"'";
 		}
    	
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
		
				
				
/*				String sql=" select mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty,"
						+ " convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,if(d.qty-d.out_qty=0,'',d.qty-d.out_qty) balqty "
						+ "  from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
						+ "  where    mm.DATE>='"+sqlfromdate+"' and   mm.DATE<='"+sqltodate+"'  "+sqltest;*/
				String sql="  select m.brhid branchvals,m.clientid,m.doc_no,m.voc_no,if(m.cltype=0,a.refname,m.clientname) client,if(m.cltype=0,'Client','General') category "
						+ " from my_cusenqm m left join my_acbook a on a.cldocno=m.clientid and a.dtype='CRM'   where    m.DATE>='"+sqlfromdate+"' and   m.DATE<='"+sqltodate+"'  "+sqltest+" group by m.doc_no  order by m.voc_no";
          
            	System.out.println("----reqlistsearch-------"+sql);	
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
	
	public   JSONArray listsearch(String docno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
      
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
		
				String sql=" select bd.brandname,d.rdocno,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty  "
						+ " from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
						+ "  where d.rdocno='"+docno+"'";
				
/*				String sql=" select mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.qty,"
						+ " convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,if(d.qty-d.out_qty=0,'',d.qty-d.out_qty) balqty "
						+ "  from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId left join  "
						+ " my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no)   "
						+ "  where    mm.DATE>='"+sqlfromdate+"' and   mm.DATE<='"+sqltodate+"'  "+sqltest;
			
          */
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
	
	
	public   JSONArray gridreloadsearch(String docno,String branch,String type,String clientid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        String sqltest="";
        
    	System.out.println("---branch-----"+branch);	
    	if((!(branch.equalsIgnoreCase("a")) && (!(branch.equalsIgnoreCase("NA"))) && (!(branch.equalsIgnoreCase("0")) ))){
    		sqltest+=" and brhid='"+branch+"'";
 		}	
    	   String sqltest1="";
    	if(type.equalsIgnoreCase("Client")){
    		sqltest1+=" and inv.cldocno="+clientid+"";
 		}
    	
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();  
			 
			//	String sql="select   refdocno, rdocno , cldocno, qty, stock, cost_price, sellingprice, discount, netsellingprice, rfqdocno, acno, rfqprice, margin, netprice, squoteprice"
			/*int j=0;	
				
			String sqls="select refdocno, rdocno  from my_benqps where rdocno='"+docno+"' ";
			
			ResultSet rs=stmt1.executeQuery(sqls);
			
			
			if(rs.next())
			{
				j=1;
			}
				
			if(j==1)	
			{*/
				
				/*String sql=" select  d.refdocno,d.rdocno,d.prdId prodoc,m.part_no productid,m.productname,d.qty,d.stock,d.cost_price "
						+ " costperunit,coalesce(d.sellingprice,0)  sellingprice  ,coalesce(d.netsellingprice,0) netsellingprice,  "
						+ " d.discount,d.rfqprice,coalesce(d.netprice,0) netamount,coalesce(d.squoteprice,0) sqoute,d.rfqdocno,d.acno,d.margin,h.description vendor,rf.voc_no rfq "
						+ "  from my_benqps d  left join my_main m on m.doc_no=d.prdId   left join my_head h on h.doc_no=d.acno left join my_prfqm rf on rf.doc_no=d.rfqdocno where  d.rdocno='"+docno+"' ";
				
                     System.out.println("---3--asd----"+sql);	
            	 	ResultSet resultSet = stmt.executeQuery(sql);
            	 	 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            	 	 
            	 	 
			}
			else
			{
				
				String sql=" select d.docno refdocno,d.rdocno,d.prdId prodoc,m.part_no productid,m.productname,d.qty,aa.stkqty stock,aa.cost_price costperunit,doc.maxdocno,coalesce(invs.nettotal,0)  sellingprice "
						+ " ,coalesce(invs.nettotal,0) netsellingprice,0 discount,'' rfqprice,coalesce(invs.nettotal,0) netamount,coalesce(invs.nettotal,0) sqoute from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId  "
						+ " left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid,(sum(cost_price)/count(*)) cost_price  "
						+ " from my_prddin  where 1=1 "+sqltest+" and (op_qty)-(out_qty+rsv_qty+del_qty)>0 group by prdid) aa 	on aa.prdid=d.prdId  "
						+ " left join (select max(inv.doc_no) maxdocno,det.prdid,inv.doc_no,inv.cldocno from my_invm inv  "
						+ " left join  my_invd det on det.rdocno=inv.doc_no  where 1=1  "+sqltest1+"   group by prdid) doc on doc.prdid=d.prdid  "
						+ " left join (select coalesce(sum(det.nettotal),0)/sum(qty) nettotal,det.prdid,inv.doc_no,inv.cldocno from my_invm inv  "
						+ " left join  my_invd det on det.rdocno=inv.doc_no group by inv.doc_no,det.prdid) invs  "
						+ " on  invs.prdid=d.prdid and invs.doc_no=doc.maxdocno  where  d.rdocno='"+docno+"'";
				
 
			            	System.out.println("---3as------"+sql);	
            	 	ResultSet resultSet = stmt.executeQuery(sql);
            	 	 RESULTDATA=ClsCommon.convertToJSON(resultSet);	
				
			}
            	 	 */ 
			 	
				String sql="  select * from (select  bd.doc_no brdocno, bd.brandname,d.refdocno,d.rdocno,d.prdId prodoc,m.part_no productid,m.productname,d.qty,d.stock,d.cost_price  costperunit, "
						+ "   coalesce(d.sellingprice,0)  sellingprice  ,coalesce(d.netsellingprice,0) netsellingprice, d.discount,convert(d.rfqprice,char(20)) rfqprice, "
						+ "   coalesce(d.netprice,0) netamount,coalesce(d.squoteprice,0) sqoute,convert(d.rfqdocno,char(30)) rfqmaindoc,convert(d.acno,char(20)) vendordoc, "
						+ "   convert(d.margin,char(20)) margin,h.description vendor,convert(rf.voc_no,char(20)) rfq  "
						+ "   from my_benqps d  left join my_main m on m.doc_no=d.prdId   left join my_head h on h.doc_no=d.acno left join my_prfqm rf  "
						+ "   on rf.doc_no=d.rfqdocno left join my_brand bd on m.brandid=bd.doc_no  where  d.rdocno='"+docno+"' ) aa union all "
								+ " 	(select b.doc_no brdocno,  b.brandname,d.docno refdocno,d.rdocno,d.prdId prodoc,m.part_no productid, "
						+ "   m.productname,d.qty,aa.stkqty stock,aa.cost_price costperunit,coalesce(invs.nettotal,0)  sellingprice  , "
						+ "  coalesce(invs.nettotal,0) netsellingprice,0 discount,'' rfqprice,(coalesce(invs.nettotal,0)) netamount,coalesce(invs.nettotal,0) sqoute,  "
						+ "  '' rfqdocno,'' acno,'' margin,''  vendor,'' rfq from my_cusenqm mm left join my_cusenqd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId "
						+ " left join (select sum(op_qty)-sum(out_qty+rsv_qty+del_qty) stkqty,prdid,(sum(cost_price)/count(*)) cost_price from my_prddin  "
						+ "  where 1=1 "+sqltest+"  and (op_qty)-(out_qty+rsv_qty+del_qty)>0 group by prdid) aa 	on aa.prdid=d.prdId "
						+ "	 left join (select max(inv.doc_no) maxdocno,det.prdid,inv.doc_no,inv.cldocno from my_invm inv  "
						+ "  left join  my_invd det on det.rdocno=inv.doc_no  where 1=1  "+sqltest1+"    group by prdid) doc on doc.prdid=d.prdid "
						+ "  left join (select coalesce(sum(det.nettotal),0)/sum(qty) nettotal,det.prdid,inv.doc_no,inv.cldocno from my_invm inv "
						+ "  left join  my_invd det on det.rdocno=inv.doc_no group by inv.doc_no,det.prdid) invs  on  invs.prdid=d.prdid and invs.doc_no=doc.maxdocno "
						+ "  left join my_benqps bd on bd.rdocno=d.rdocno and bd.refdocno=d.docno left join my_brand b on m.brandid=b.doc_no "
						+ " where  d.rdocno='"+docno+"' and  bd.rdocno is null) ";
				
	          	//System.out.println("---3as------"+sql);	
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
	
	public   JSONArray refmainsearch(HttpSession session,String prdid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	 /*   Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	  return RESULTDATA;
	     }
	    String brcid=session.getAttribute("BRANCHID").toString();*/
	    
	    
	    
/*	    java.sql.Date  sqlStartDate = null;
	  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
	      	{
	      	sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
	      	}
	      	
	      	*/
	  	    
/*	  		String sqltest="";
	  	    
	  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
	      	}
	      	if((!(accountss.equalsIgnoreCase(""))) && (!(accountss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and h.account like '%"+accountss+"%'  ";
	      	}
	      	if((!(accnamess.equalsIgnoreCase(""))) && (!(accnamess.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and h.description like '%"+accnamess+"%'";
	      	}
	      
	      	
	      	if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	      	}*/
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
			
				Statement stmtmain = conn.createStatement (); 
				
				String pySql=("select m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.description desc1,aa.maxdocno,d.nettotal  "
						+ " from my_prfqm m left join my_prfqd d on m.doc_no=d.rdocno  left join my_head h on h.doc_no=m.acno  "
						+ " left join(select max(doc_no) maxdocno,m1.acno from my_prfqm m1 left join my_prfqd d1 on m1.doc_no=d1.rdocno "
						+ "	where prdid='"+prdid+"' and d1.nettotal>0 group by m1.acno ) aa on aa.acno=m.acno "
						+ "   where m.status=3  and d.prdid='"+prdid+"' and m.doc_no=aa.maxdocno  and d.nettotal>0  limit 10 " );
				
/*	        	String pySql=("select m.doc_no,m.voc_no,m.date,h.description,h.account,m.acno,m.description desc1 from my_prfqm m left join my_prfqd d on m.doc_no=d.rdocno "
	        			+ " left join my_head h on h.doc_no=m.acno   where m.status=3  and d.prdid='"+prdid+"' " );*/
                 System.out.println("========"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			 
			conn.close();
			  return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}

 

}
