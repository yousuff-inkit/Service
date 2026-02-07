package com.dashboard.management.storemanagement;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsStoremanagementDAO {

	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	
	public   JSONArray stocklistgrid(String load, String brhid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        String sqltest="";
        if(!brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase(""))
  	  {
  	   sqltest+=" and c.brhid="+brhid;
  	  }
	
        Connection conn = null;
        
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();   

			 String sql="  select m.barcode,bc.branchname,lc.loc_name,c.locid,c.brhid brhid,bd.brandname,ca.category,c.qty,m.part_no productid,m.productname,c.amount,sc.subcategory,u.unit from "
					 + "  (select  b.locid,b.brhid,b.qty qty,b.prdid,amount amount from (select i.locid,i.brhid,i.op_qty-coalesce(a.outqty,0) qty,i.prdid "
					 + "  ,i.cost_price*(i.op_qty-coalesce(a.outqty,0)) amount from my_prddin i "
					 + "  left join (select sum(qty)+sum(del_qty)+sum(rsv_qty) outqty, stockid ,prdid from my_prddout group by stockid) a "
					 + "  on a.stockid=i.stockid   where 1=1 group by i.stockid) b  ) c left join my_main m on m.doc_no=c.prdId "
					 + "  left join my_desc de on(de.psrno=m.doc_no and c.brhid= de.brhid) left join my_brch bc on bc.doc_no=c.brhid "
					 + "  left join my_locm lc on lc.doc_no=c.locid left join  my_brand bd on m.brandid=bd.doc_no left join my_catm ca on ca.doc_no=m.catid left join my_scatm sc on sc.doc_no=m.scatid left join my_unitm u on u.doc_no=m.munit where 1=1 and qty>0 "+sqltest+" ";  
			 
			// System.out.println("-------STOCK LIST GRID ----"+sql);	
            ResultSet resultSet = stmt.executeQuery(sql);
            RESULTDATA=ClsCommon.convertToJSON(resultSet);
     		stmt.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }	
	
	
	public JSONArray pendingpogrid(String load,String brhid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        String sqltest="";
        if(!brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase(""))
  	  {
  	   sqltest+=" and mm.brhid="+brhid;
  	  }
	
        Connection conn = null;
       
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				String sql="select  mm.brhid brhid,bb.branchname branchname,mm.doc_no doc_no,0 foc,h.doc_no acno,at.mspecno specid,'pro' checktype ,d.psrno psrno,m.part_no proid ,m.productname proname,(d.qty-d.out_qty) saveqty,(d.qty-d.out_qty) qutval,d.rowno refrowno,d.amount unitprice,bd.brandname,case when mm.rdtype='SOR' then 'Sales Order' when mm.rdtype='RFQ' then 'Purchase Request For Quote'  when   mm.rdtype='PR' then 'Purchase Request' else 'Direct' end as dtype ,mm.refno,mm.doc_no,mm.voc_no,mm.date,d.prdId prodoc,if(d.clstatus=1,'Canceled','') status,d.clstatus,   h.account,h.description acname,   m.part_no productid,m.productname,u.unit, d.unitid unitdocno,d.taxper, d.taxamount, d.nettaxamount,   d.qty,convert(if(d.out_qty=0,'',d.out_qty),char(30)) out_qty,convert(if(d.qty-d.out_qty=0,'',d.qty-d.out_qty),char(50)) balqty,d.amount,d.total,convert(if(d.disper=0,'0.00',d.disper),char(30)) disper,  convert(if(d.discount=0,'0.00',d.discount),char(30)) discount,d.nettotal,coalesce(cancelamt,0) cancelamt    from my_ordm mm left join my_ordd d on d.tr_no=mm.tr_no left join my_main m on m.doc_no=d.prdId left join my_unitm u on d.unitid=u.doc_no left  join my_brch bb on bb.doc_no=mm.brhid left join  my_brand bd on m.brandid=bd.doc_no  left join my_head h on h.doc_no=mm.acno left join( select psrno,rdocno,coalesce(sum((d.qty-d.out_qty)*d.amount-(((d.qty-d.out_qty)*d.amount)*d.disper/100)),0) cancelamt  from my_ordd d  where clstatus=1 group by rdocno,psrno)  ss on ss.rdocno=mm.doc_no and ss.psrno=d.psrno  left join my_prodattrib at on(at.mpsrno=m.doc_no) where  mm.status=3 and d.out_qty=0 "+sqltest+" ";
		    		    	
	//	System.out.println("-------PENDING PO GRID ----"+sql);	
			ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
 			stmtVeh.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	public   JSONArray pendingGRN(String load, String brhid) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
		if(!(load.equalsIgnoreCase("yes")))
	        {
	        	return RESULTDATA;
	        }
		 String sqltest="";
	        if(!brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase(""))
	  	  {
	  	   sqltest+=" where m1.brhid="+brhid;
	  	  }
	        
	    Connection conn = null;
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
 
			
				
				String sql=" select bb.branchname branchname,m1.brhid brhid,dd.foc_out focout,dd.foc focd,dd.rsv_qty rsvqty,(dd.op_qty-(dd.out_qty+dd.del_qty)) qty1,dd.op_qty,dd.out_qty,dd.del_qty, m1.voc_no doc_no,h.doc_no acno,h.account account,h.description acname,0 oldfoc,(dd.foc-dd.foc_out) maxfoc,'pro' checktype,d.stockid stockid,d.qty oldqty,sum(d.qty) mainqty,bd.brandname,aa.rowno refrowno,at.mspecno as specid,m1.rdtype,m1.rrefno,m.part_no productid,   m.productname,d.sr_no,d.psrno,d.prdId prodoc,m.part_no proid ,m.productname proname,   u.unit, d.unitid unitdocno,(dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/(dd.fr) qutval,(dd.foc-dd.foc_out)/(dd.fr) foc,sum(d.out_qty) pqty,  (dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))/(dd.fr)saveqty, d.qty,d.amount unitprice,d.total,d.discount,d.disper, d.nettotal,d.prdid\r\n" + 
						"from my_grnm m1   left join my_grnd d on m1.tr_no=d.tr_no left join my_prddin dd on dd.stockid=d.stockid and dd.prdid=d.prdid and d.psrno=dd.psrno and  d.specno=dd.specno left join my_main m on m.doc_no=d.prdId    left join my_unitm u on d.unitid=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_brch bb on bb.doc_no=m1.brhid left join  my_brand bd on m.brandid=bd.doc_no left join my_head h on h.doc_no=m1.acno   left join (select  prdid,amount,qty,out_qty,rowno,discount,disper,clstatus,unitid,specno from  my_ordd   where clstatus=0 ) aa   on aa.prdid=d.prdid and aa.amount=d.amount and aa.disper=d.disper and aa.unitid=d.unitid and  aa.specno=d.specno "+sqltest+" group by m1.doc_no  having (dd.op_qty-(dd.out_qty+dd.rsv_qty+dd.del_qty+dd.foc-dd.foc_out))>0";
		
			
				//	System.out.println("-------PENDING GRN GRID ----"+sql);	
		           
				ResultSet resultSet = stmtVeh1.executeQuery(sql);

			 RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			 stmtVeh1.close();
			 conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray productdetlist(String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        
        Connection conn = null;
       
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
				
				String sql ="select bd.brandname,at.mspecno as specid,m.part_no productid,m.productname productname,m.doc_no doc_no,u.unit,m.munit as unitid,m.psrno,(i.out_qty) outqty,(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno) where m.status=3";
			
				//System.out.println("-------PRODUCT LIST GRID ----"+sql);	
		       ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
 			stmtVeh.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray invreqdetlist(String load, String brhid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        String sqltest="";
        if(!brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase(""))
  	  {
  	   sqltest+=" and inv.reqbrhid="+brhid;
  	  }
        
        Connection conn = null;
       
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		
				String sql ="select invd.rowno rowno,inv.voc_no vocno,inv.reqlocid locid,inv.reqbrhid brhid,at.mspecno as specid,u.unit_desc unit,invd.qty quantity,m.part_no productid,m.productname productname,inv.doc_no docno,inv.date date,b.branchname rebrch,l.loc_name reqloc,inv.remarks remarks from my_invtranreqm inv left join my_invtranreqd invd on invd.rdocno=inv.doc_no left join my_main m on m.doc_no=invd.psrno left join my_locm l on l.doc_no=inv.reqlocid left join my_brch b on b.doc_no=inv.reqbrhid left join my_unitm u on u.doc_no=invd.unitid  left join my_prodattrib at on(at.mpsrno=m.doc_no) where invd.qty-invd.outqty!=0  "+sqltest+"";		
					
				//System.out.println("-------INV REQ LIST GRID ----"+sql);	
		       ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
 			stmtVeh.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray invissdetlist(String docnos,String brhid,String locid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
          
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
		

		
				String sql="select invd.rowno rowno,((invd.qty -invd.outqty)*unitprice) netotal,((invd.qty -invd.outqty)*unitprice) total,i.stkqty stkqty,inv.doc_no docno,bb.branchname branchname,inv.voc_no voc_no,0 dis,0 discper,0 kgprice,0 totwtkg,0 foc,inv.reqbrhid reqbrhid,inv.reqlocid reqlocid,inv.remarks remarks,m.productname proname,m.doc_no prodoc,m.part_no proid, bd.brandname,at.mspecno as specid,m.part_no productid,m.productname productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, invd.qty -invd.outqty quantity,(invd.outqty) outqty,stkqty as balqty,stkqty as totqty,i.cost_price unitprice from my_invtranreqm inv left join my_invtranreqd invd on invd.rdocno=inv.doc_no left join my_main m on m.doc_no=invd.psrno left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_brch bb on bb.doc_no=inv.brhid inner join (select unit_price unitprice,sum(op_qty-out_qty-rsv_qty-del_qty) stkqty,psrno,prdid,specno,cost_price from my_prddin where brhid in("+brhid+") and locid in ("+locid+") group by psrno,prdid,specno) i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno) where inv.doc_no in("+docnos+") group by inv.doc_no";			
				
				//	System.out.println("-------INV ISSUE GET LIST GRID ----"+sql);	
		       ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
 			stmtVeh.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	public JSONArray pendissrpt(String load,String brhid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        if(!(load.equalsIgnoreCase("yes")))
        {
        	return RESULTDATA;
        }
        String sqltest="";
        if(!brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("0") && !brhid.equalsIgnoreCase(""))
  	  {
  	   sqltest+=" and ma.brhid="+brhid;
  	  }
       
        
        Connection conn = null;
       
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
				
				String sql="select m.part_no proid,m.productname proname,u.unit unit,u.doc_no unitdocno,d.rdocno,m.doc_no psrno,(d.qty) as qty, bb.branchname branchnames,l.loc_name locationnames,ma.brhid brhhid,d.doc_no dcnoo,ma.doc_no docnoo,ma.voc_no,ma.remarks remarks,ma.frmbrhid frmbrhid,ma.tobrhid tobrhid,ma.frmlocid frmlocid,ma.tolocid tolocid,((qty)-(d.out_qty)) as qtyy,d.stockid as refstkid, bd.brandname from my_invtranissuem ma left join my_invtranissued d on ma.doc_no=d.rdocno\r\n" + 
						"left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join my_brch bb on bb.doc_no=ma.frmbrhid\r\n" + 
						"left join my_locm l on l.doc_no=ma.frmlocid left join  my_unitm u on(d.unitid=u.doc_no)left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno )left join  my_brand bd on m.brandid=bd.doc_no\r\n" + 
						" where ma.status=3 and qty-out_qty!=0";
				
				//	System.out.println("------- PENDING ISS RECPT GRID ------"+sql);
				ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
 			stmtVeh.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray pendissrptload(String docnos, String brhhid) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
       
		try {
				conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();
				
			   		
				String sql="select location,branchname,brhhid,brhid,docnoo,rrefno,voc_no,remarks,frmbrhid,tobrhid,frmlocid,tolocid,qtyy,refstkid,brandname,0 foc,stkid,specid,psrno as prodoc,psrno as doc_no,rdocno,psrno,totqty, qty,qty as oldqty,outqty, (qty+balqty)  as balqty,0 size,part_no,productid as proid,productid,productname as proname,productname,unit,unitdocno, totwtkg,  kgprice, unitprice, total, discper,  dis, netotal from(select location,branchname,brhid,brhhid,docnoo,rrefno,voc_no,remarks,frmbrhid,tobrhid,frmlocid,tolocid,qtyy,refstkid, brandname,foc,stkid,specid,psrno as doc_no,rdocno,psrno,qtys as totqty, qty,qtys,outqty,(qtys-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, totwtkg, kgprice, unitprice, total, discper,  dis, netotal from (select ma.brhid brhhid,l.loc_name location ,bb.branchname branchname,ma.brhid brhid,ma.doc_no docnoo,ma.rrefno,ma.voc_no voc_no,ma.remarks remarks,ma.frmbrhid frmbrhid,ma.tobrhid tobrhid,ma.frmlocid frmlocid,ma.tolocid tolocid,(qty-d.out_qty) as qtyy,d.stockid as refstkid, bd.brandname,d.foc,i.stockid as stkid,d.specno as specid,d.rdocno,m.doc_no psrno,(d.qty) as qty,coalesce(ii.totalqty,0) as qtys,coalesce(ii.outqty,0) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,d.NtWtKG totwtkg, d.KGPrice kgprice,d.amount unitprice,d.total,d.disper discper, d.discount dis,coalesce((d.nettotal),0) netotal from my_invtranissuem ma left join my_invtranissued d on(ma.doc_no=d.rdocno)left join my_main m on(d.psrno=m.doc_no and d.prdid=m.psrno) left join my_brch bb on bb.doc_no=ma.frmbrhid left join my_locm l on l.doc_no=ma.frmlocid left join  my_unitm u on(d.unitid=u.doc_no)left join my_prodattrib at on(at.mpsrno=m.doc_no and d.specno=at.mpsrno ) left join  my_brand bd on m.brandid=bd.doc_no left join my_prddin i on (i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid and d.stockid=i.stockid)left join( select date,(op_qty) totalqty,(op_qty)-(out_qty+del_qty+rsv_qty) balqty,stockid, (out_qty+del_qty+rsv_qty) outqty,prdid,psrno,specno,brhid,locid  from my_prddin where 1=1 group by psrno,locid,brhid) ii on (ii.psrno=i.psrno and ii.prdid=i.prdid and i.specno=ii.specno and ma.brhid=ii.brhid and ii.locid=i.locid) where m.status=3 and d.doc_no in ("+docnos+") and ma.brhid="+brhhid+")  as a ) as b";		    
																
			//System.out.println("------- PENDING ISS RECPT LOAD GRID ------"+sql);
				ResultSet resultSet = stmtVeh.executeQuery(sql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
 			stmtVeh.close();
            conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	
}
