package com.dashboard.procurment.trademarginreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClstrademarginreportDAO { 

	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	
	public   JSONArray listsearch(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load,String type) throws SQLException {

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
    		sqltest+=" and brhid='"+branch+"'";
 		}
    	
       String grpsql="";
   	String refno="";
    	String refname="";
    	String refname1="";
    	String refname2="";
  
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and m.brandid in ("+hidbrand+")";
		}

		 
		

		if(!(hidept.equalsIgnoreCase("0") || hidept.equalsIgnoreCase("") || hidept.equalsIgnoreCase("undefined"))){
			sql8=" and m.deptid in ("+hidept+")";
		}


		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and m.catid in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and m.scatid in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.psrno in ("+hidproduct+")";
		}
    
 String joinsql="";
	    
		 if(type.equalsIgnoreCase("DC"))
		 {
			 grpsql= " group by m1.doc_no "; 
			 
			 refname= " concat(m1.dtype,'-',m1.voc_no,'-',h.description,'-',sa.sal_name)  ";
			 refno= " m1.doc_no refno , ";
			 
			 joinsql="    inner join my_head h on h.doc_no=m1.acno inner join my_salm sa on sa.doc_no=m1.sal_id  ";
			 
			 
		 }
		 else if(type.equalsIgnoreCase("AC"))
		 {
 		 refno= " m1.acno refno , ";
			 refname= " concat(m1.acno,'-',h.description)     ";
			 grpsql= " group by m1.acno "; 
			 joinsql="    inner join my_head h on h.doc_no=m1.acno ";
		 }
		 
 	 else if(type.equalsIgnoreCase("DT"))
		 {
 		 refno= " m1.date refno , ";
			 refname= " date_format(m1.date,'%d-%m-%Y')   ";
			 grpsql= " group by m1.date "; 
		 }
		 
		 else if(type.equalsIgnoreCase("BR"))
		 {
			 refname= " bd.brandname  ";
			 refno= " m.brandid refno , ";
			 grpsql= " group by m.brandid ";  
			 
			 joinsql=" inner join my_brand bd on(m.brandid=bd.doc_no) ";
			 
		 }
		 else if(type.equalsIgnoreCase("CA"))
		 {
			 
			 refname= " cat.category   ";
			 grpsql= " group by m.catid ";  
			 refno= " m.catid  refno, ";
			 joinsql="  inner join my_catm cat on(m.catid=cat.doc_no)   ";
			 
			
			 
			 
		 }
		 else if(type.equalsIgnoreCase("SC"))
		 {
			 refname= " sc.subcategory   ";
			 
			 grpsql= " group by m.scatid ";  
			 refno= " m.scatid refno, ";
			 joinsql="  inner join my_scatm sc on(m.scatid=sc.doc_no)   ";
		 }
		
		 else if(type.equalsIgnoreCase("PR"))
		 {
			 refname= " m.productname  ";
			 refname2= "  brandname , ";
		//	 refname1= " m.part_no productid, ";
			 joinsql=" inner join my_brand bd on(m.brandid=bd.doc_no) ";		 
			 refno= " m.psrno refno, ";
			 grpsql= " group by m.psrno ";
		 }
		 
	 /*	 else if(type.equalsIgnoreCase("BH"))
		 {
			 
			 refname=  " brr.branchname ";
			 grpsql= " group by ma.brhid";
		 }*/
		 
		 
		 else if(type.equalsIgnoreCase("DP"))
		 {
			 
			 refname=  " dp.department ";
			 grpsql= " group by m.deptid";
			 refno= " m.deptid refno, ";
			 joinsql="  inner join my_dept dp on(m.deptid=dp.doc_no)   ";
			 
		 } 
		 
		 
		 
		 else if(type.equalsIgnoreCase("SA"))
		 {
			 
			 refname=  " sa.sal_name ";
			 grpsql= " group by sa.doc_no ";
			 refno= " sa.doc_no  refno,";
			 joinsql="   inner join my_salm sa on sa.doc_no=m1.sal_id ";
			 
		 } 
		 
		 
		 else
		 {
			 
			 refname= " m.productname  ";
			// refname1= " m.productid productid ,";
			 refname2= "  brandname , ";
			 joinsql=" inner join my_brand bd on(m.brandid=bd.doc_no) ";
			 refno= " m.psrno refno,";
			 grpsql= " group by m.psrno ";
			 
		 }
		 
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		 
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
     
			 
				
				String sql= "select @i:=@i+1 slno, a.* from(select dtype,productid,  name, "+refname2+" sum(qty) qty,sum(foc) foc,"
						+ " round(sum(sales),2) netsale,round(sum(retamt),2) salesreturn,round(sum(sales)-coalesce(sum(retamt),0),2) totalsales ,"
					 
						+ " sum(costprice) netcost,round(sum(sales)-sum(retamt)-sum(costprice),2) profit,if(sum(sales)-sum(retamt)<0,(((sum(sales)-sum(retamt)-sum(costprice))/(sum(sales)-sum(retamt)))*100)*-1,(sum(sales)-sum(retamt)-sum(costprice))/(sum(sales)-sum(retamt))*100) profitper from "
						+ " (select  "+refno+" m.part_no productid,m1.dtype, convert("+refname+",char(200))  name, "+refname2+" m1.date,m1.tr_no,  m.psrno,sum(d.qty) qty,sum(d.foc) foc,sum(d.nettotal) sales ,0 retamt , "
								+ " salcost costprice  from my_invM m1 inner join my_inVd d on m1.doc_no=d.rdocno "
								+ " left join (select sum(qty*cost_price) salcost,tr_no,psrno from my_prddout "
								+ " where dtype='inv' and date between '"+sqlfromdate+"' and  '"+sqltodate+"' group by tr_no,psrno) o "
								+ " on o.tr_no=d.tr_no and o.psrno=d.psrno left join  my_main m  on d.psrno=m.psrno "+joinsql+"   where m1.status=3  and m1.date between "
						 + " '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlfinal+"   group by d.tr_no,d.psrno  "
						 + " UNION ALL "
						 + " select "+refno+"  m.part_no productid,m1.dtype, convert("+refname+",char(200))  name, "+refname2+"  m1.date,m1.tr_no,  m.psrno ,sum(d.qty) qty,sum(d.foc) foc,0 sales ,sum(d.nettotal) retamt , salretcost costprice "
						 		+ " from my_invr m1 "
						 		+ " inner join my_inrd d on m1.doc_no=d.rdocno left join (select (sum(op_qty*cost_price)*-1) salretcost,tr_no,psrno from my_prddin "
						 		+ "where dtype='inr' and date between '"+sqlfromdate+"' and  '"+sqltodate+"' group by tr_no,psrno) o "
						 		+ " on o.tr_no=d.tr_no and o.psrno=d.psrno  left join  my_main m  on d.psrno=m.psrno "+joinsql+"  where m1.status=3   "
						 		+ " and m1.date between '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqlfinal+"  group by  d.tr_no,d.psrno  ) m  "
						 		+ " group by m.refno order by date,tr_no)a,(select @i:=0)c ";
				
				
 
						 
	/*	dtype,				String sql= "select "+refname1+" convert("+refname+",char(200))  name, "+refname2+" sum(ot.qty) qty,sum(ot.netsale) netsale,"
								+ "sum(ot.retsale) salesreturn,sum(ot.netcost) netcost, "
		  +"  sum(ot.netsale)-sum(coalesce(ot.retsale,0))-sum(ot.netcost) profit, " 
		  +"  (sum(ot.netsale)-sum(coalesce(ot.retsale,0))-sum(ot.netcost))/(sum(ot.netsale)-sum(coalesce(ot.retsale,0)))*100 profitper "
		  +" from (select  date,brhid,locid,psrno,rdocno,tr_no,sum(qty) qty ,sum(qty*unit_price) netsale,sum((qty-out_qty)*cost_price) netcost, "
		 +" sum(out_qty*unit_price) retsale from my_prddout "
		  +"  where dtype='INV' "+sqltest+" and DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' group by rdocno,psrno  ) ot "
		 +"  inner join my_main m on m.doc_no=ot.psrno  "+joinsql+" where 1=1 "+sqlfinal+"  "+grpsql+"  " ;*/
						
				
          
       // System.out.println("Trademargingrid1===>"+sql);	
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
	public JSONArray brandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brandname brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public   JSONArray listsearchex(String branch,String fromdate,String todate,String status,String acno,String psrno,String invdocnomaster,
			String hidbrand,String hidtype,String hidproduct,String hidcat,String hidsubcat,String hidept,String load,String type) throws SQLException {

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
    	
   String grpsql="";
    	String refname="";
    	
  
    	String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";

		if(!(hidbrand.equalsIgnoreCase("0") || hidbrand.equalsIgnoreCase("") || hidbrand.equalsIgnoreCase("undefined"))){
			sql7=" and m.brandid in ("+hidbrand+")";
		}

		 

		if(!(hidcat.equalsIgnoreCase("0") || hidcat.equalsIgnoreCase("") || hidcat.equalsIgnoreCase("undefined"))){
			sql9=" and m.catid in ("+hidcat+")";
		}
		if(!(hidsubcat.equalsIgnoreCase("0") || hidsubcat.equalsIgnoreCase("") || hidsubcat.equalsIgnoreCase("undefined"))){
			sql10=" and m.scatid in ("+hidsubcat+")";
		}

		if(!(hidproduct.equalsIgnoreCase("0") || hidproduct.equalsIgnoreCase("") || hidproduct.equalsIgnoreCase("undefined"))){
			sql11=" and m.psrno in ("+hidproduct+")";
		}
    
 
	    
		 if(type.equalsIgnoreCase("DC"))
		 {
			 grpsql= " group by ma.doc_no "; 
			 
			 refname= " concat(ma.voc_no,'-',ac.refname)  ";
			 
			 
		 }
		 else if(type.equalsIgnoreCase("DT"))
		 {
			 
			 refname= " date_format(ma.date,'%d-%m-%Y')   ";
			 grpsql= " group by ma.date "; 
		 }
		 
		 else if(type.equalsIgnoreCase("BR"))
		 {
			 refname= " bd.brandname  ";
			 
			 grpsql= " group by ma.brandid ";  
		 }
		 else if(type.equalsIgnoreCase("CA"))
		 {
			 
			 refname= " cat.category   ";
			 grpsql= " group by ma.catid ";  
		 }
		 else if(type.equalsIgnoreCase("SC"))
		 {
			 refname= " sc.subcategory   ";
			 
			 grpsql= " group by ma.scatid ";  
		 }
		
		 else if(type.equalsIgnoreCase("PR"))
		 {
			 refname= " ma.productname  ";
			 
			 grpsql= " group by ma.psrno ";
		 }
		 
		 else if(type.equalsIgnoreCase("BH"))
		 {
			 
			 refname=  " brr.branchname ";
			 grpsql= " group by ma.brhid";
		 }
		 else
		 {
			 
			 refname= " ma.productname  ";
			 
			 grpsql= " group by ma.doc_no,ma.psrno ";
			 
		 }
		 
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		 
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
		
     
			
				
/*				select mb.date,mb.tr_no,mb.brsale,mb.crsale,mb.chsale,mbftype,mb.paymode,

				select  ma.date,ma.tr_no,if(ma.ftype=1,ma.brsale,0) brsale,
				if(ma.ftype=0 and ma.paymode=2,ma.crsale, 0) crsale ,if(ma.ftype=0 and ma.paymode=1,ma.chsale, 0)
				  chsale,ma.ftype,ma.paymode,ma.psrno,ma.cost_price from(
				select mm.date,mm.tr_no,mm.ftype,mm.paymode,dd.psrno,dd.sale  brsale, dd.sale crsale, dd.sale chsale,ot.cost_price from my_invm mm

				left join  (select sum(nettotal)/sum(qty) sale,rdocno,psrno from  my_invd group by rdocno,psrno)  dd on dd.rdocno=mm.doc_no

				left join (select sum(cost_price)/count(*) cost_price,tr_no,psrno  from my_prddout group by tr_no,psrno) ot on ot.tr_no=mm.tr_no

				where 1=1  group by mm.doc_no,dd.psrno) ma ) mb 
				*/
 
				
			 
				
				String sql=" select convert("+refname+",char(200))  'Ref Name', "
						+ " sum(ma.totalsale) 'Total Sale',sum(ma.totalcost) ' Total cost_price ',  "
						+ "  sum(ma.totalsale)-sum(ma.totalcost) Profit,  "
				+ "  ((sum(ma.totalsale)-sum(ma.totalcost))/sum(ma.totalcost))*100 Profitper  "
				 + " from (select m.productname,m.brandid,m.catid,m.scatid,mm.cldocno, mm.voc_no,mm.brhid,mm.doc_no,mm.date,mm.tr_no,dd.psrno,dd.sale totalsale, ot.costprice  totalcost  "
				 + " from my_invm mm left join  (select sum(nettotal) sale,rdocno,psrno  from  my_invd group by rdocno,psrno)  "
				 + "  dd on dd.rdocno=mm.doc_no left join (select tr_no,psrno,sum(cost_price*qty) costprice  from my_prddout group by tr_no,psrno) ot on ot.tr_no=mm.tr_no "
				 + "  left join my_main m on m.psrno=dd.psrno where mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"' "+sqltest+" "+sqlfinal+"   group by mm.doc_no,dd.psrno ) ma	"
				 		+ " left join my_acbook ac on ac.cldocno=ma.cldocno and ac.dtype='CRM' "
				 		  + " left join my_brand bd on(ma.brandid=bd.doc_no)  	 left join my_catm cat on(ma.catid=cat.doc_no)  "
				 + "  left join my_scatm sc on(ma.scatid=sc.doc_no) left join my_brch brr on brr.doc_no=ma.brhid   where 1=1   "+grpsql+" ";
				
				
				
				
				
          
     //  System.out.println("-----saleslistsearch------"+sql);	
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
	
	   public JSONArray productSearch(HttpSession session,String brandid,String catid,String subcatid) throws SQLException {


	        JSONArray RESULTDATA=new JSONArray();

	        Connection conn = null;

	        try {
	            conn = ClsConnection.getMyConnection();
	            Statement stmt = conn.createStatement();
	            String sql1="";
	            //System.out.println("brandid===="+brandid);
	            if(!(brandid.equals("0") || brandid.equals(""))){
	                sql1="and b.doc_no in ("+brandid+")";
	            }

	            String sql2="";
	            //System.out.println("brandid===="+brandid);
	            if(!(catid.equals("0") || catid.equals(""))){
	                sql2="and c.doc_no in ("+catid+")";
	            }

	            String sql3="";
	            //System.out.println("brandid===="+brandid);
	            if(!(subcatid.equals("0") || subcatid.equals(""))){
	                sql3="and s.doc_no in ("+subcatid+")";
	            }


	            String sql="select m.doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
	                    + "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no)  where m.status=3 "+sql1+" "+sql2+" "+sql3+"";
//	          System.out.println("==productSearch==="+sql);
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
