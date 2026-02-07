<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String locid=request.getParameter("locid")==null?"":request.getParameter("locid");

	Connection conn=null;
	try{
		ClsConnection objconn=new ClsConnection();
		String sql="",sqltest="",condtn="";
		int method=0,productconcat=0;
		String prodsearchtype="0",rdoc="",location=locid,reftype="DIR",prdname="0",brandname="0",gridunit="0",gridprdname="0",category="0",
		subcategory="0",department="0",id="1";
		
		java.sql.Date sqlStartDate=null;
		if(!(prdname.equalsIgnoreCase(""))&&!(prdname.equalsIgnoreCase("undefined"))&&!(prdname.equalsIgnoreCase("0"))){
			condtn ="  and m.part_no like '%"+prdname+"%' ";
		}
		if(!(brandname.equalsIgnoreCase(""))&&!(brandname.equalsIgnoreCase("undefined"))&&!(brandname.equalsIgnoreCase("0"))){
			condtn +="  and bd.brandname like '%"+brandname+"%' ";
		}

		gridprdname=gridprdname.replaceAll("@","%");
		if(!(gridprdname.equalsIgnoreCase(""))&&!(gridprdname.equalsIgnoreCase("undefined"))&&!(gridprdname.equalsIgnoreCase("0"))){
			condtn +="  and m.productname like '%"+gridprdname+"%' ";
		}
		if(!(gridunit.equalsIgnoreCase(""))&&!(gridunit.equalsIgnoreCase("undefined"))&&!(gridunit.equalsIgnoreCase("0"))){
			condtn +="  and u.unit like '%"+gridunit+"%' ";
		}
		if(!(category.equalsIgnoreCase(""))&&!(category.equalsIgnoreCase("undefined"))&&!(category.equalsIgnoreCase("0"))){
			condtn +="  and c.category like '%"+category+"%' ";
		}
		if(!(subcategory.equalsIgnoreCase(""))&&!(subcategory.equalsIgnoreCase("undefined"))&&!(subcategory.equalsIgnoreCase("0"))){
			condtn +="  and sc.subcategory like '%"+subcategory+"%' ";
		}
		if(!(department.equalsIgnoreCase(""))&&!(department.equalsIgnoreCase("undefined"))&&!(department.equalsIgnoreCase("0"))){
			condtn +="  and dt.department like '%"+department+"%' ";
		}
		Statement stmt=conn.createStatement();
		String chk4="select method  from gl_prdconfig where field_nme='productnameconcat'";
		ResultSet rs33=stmt.executeQuery(chk4); 
		if(rs33.next())
		{

			productconcat=rs33.getInt("method");
		}
	   	if(productconcat>0){
		   sqltest="concat(TRIM(m.productname),'-',bd.brandname,'-',dt.department)productname";
	   	}else{
		   sqltest="m.productname";
	   	}
		if(prodsearchtype.equals("0")){

			/*if(method>0){


				/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,1 qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno ) where m.status=3 and de.brhid='"+brhid+"' group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ";*/
			/*}
			else{

				sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,1 qty,0 outqty,0 as balqty,0 as totqty,0 as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no)  where m.status=3 and de.brhid='"+brhid+"' ";

			}*/

			/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,1 qty,0 outqty,0 as balqty,0 as totqty,"+sqlselect+" as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "+sqlcond1+" where m.status=3 and de.brhid='"+brhid+"' "+sqlcond2+" ";*/

			int superseding=0;
			String chk1="select method  from gl_prdconfig where field_nme='superseding'";
			ResultSet rs1=stmt.executeQuery(chk1); 
			if(rs1.next())
			{
				
				superseding=rs1.getInt("method");
			}
				



			
			
			if(superseding==1)
			{
				sql=" select dt.department,s.part_no,m.* from(  select bd.brandname,at.mspecno as specid,"+sqltest+",m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(20)) qty,round(i.cost_price,2) costprice,sum(i.out_qty) outqty, "
						+ " sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,i. unit_price unitprice  "
						+ " from my_main m left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ "    left join  my_brand bd on m.brandid=bd.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no inner join my_prddin i on(i.psrno=m.psrno and  "
						+ "i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brhid+"' ) where m.status=3 and  "
						+ "i.brhid='"+brhid+"' and i.locid='"+location+"' and  i.date<='"+sqlStartDate+"'  group by i.prdid having  "
						+ "sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by  i.prdid,i.date,i.stockid ) "
						  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
				
			}
			 
			else
			{
				
				
				sql="select dt.department,bd.brandname,at.mspecno as specid,m.part_no,"+sqltest+",m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty, "
						+ "sum(i.op_qty) as totqty,i.stockid as stkid,i. unit_price unitprice,round(i.cost_price,2) costprice, coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty  "
						+ " from my_main m left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ "    left join  my_brand bd on m.brandid=bd.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no inner join my_prddin i on(i.psrno=m.psrno and  "
						+ "i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brhid+"' ) where m.status=3 "+condtn+" and  "
						+ "i.brhid='"+brhid+"' and i.locid='"+location+"' and  i.date<='"+sqlStartDate+"' group by i.prdid having  "
						+ "sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by  i.prdid,i.date,i.stockid  ";
						
			}
			
			
		
			
			System.out.println("---sql---1"+sql);
			
		}
		else{

	 
/*		old without multi		  sql="select bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
					+ " sum(qty) as oldqty,sum(qty)-sum(out_qty) qty,sum(out_qty) outqty,ii.balqty as balqty,part_no,m.part_no productid,m.part_no "
			 + " as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
			 + "  KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,d.discount dis,d.nettotal netotal "
			+ "  from my_sorderm ma left join  my_sorderd d on ma.doc_no=d.rdocno "
			+ "   left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on "
			+ "  (d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
			+ " left join( select date,sum(op_qty) op_qty,stockid, "
			 + " sum(op_qty)-sum(out_qty+del_qty+rsv_qty) balqty,prdid,psrno,specno,brhid,locid "
			 + " from my_prddin where 1=1 group by psrno) ii on  (ii.psrno=d.psrno and ii.prdid=d.prdid "
			 + "  and d.specno=ii.specno and ma.brhid=ii.brhid) "
			+ "  where m.status=3 and d.rdocno in ("+rdoc+")   and d.clstatus=0  group by d.psrno having sum(d.qty-d.out_qty)>0  ";*/
			  sql="select dt.department,bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
					+ " sum(qty) as oldqty,sum(qty)-sum(out_qty) qty,sum(out_qty) outqty,ii.balqty/d.fr as balqty,ii.costprice,part_no,m.part_no productid,m.part_no "
			 + " as proid,"+sqltest+",m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
			 + "  KGPrice kgprice,d.amount unitprice, d.total,d.disper discper,d.discount dis,d.nettotal netotal "
			+ "  from my_sorderm ma left join  my_sorderd d on ma.doc_no=d.rdocno "
			+ "   left join my_main m on(d.psrno=m.doc_no) left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join  my_unitm u on "
			+ "  (d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
			+ " left join( select date,sum(op_qty) op_qty,stockid, "
			 + " sum(op_qty)-sum(out_qty+del_qty+rsv_qty) balqty,prdid,round(i.cost_price,2) costprice,psrno,specno,brhid,locid "
			 + " from my_prddin where 1=1 and  date<='"+sqlStartDate+"' group by psrno) ii on  (ii.psrno=d.psrno and ii.prdid=d.prdid "
			 + "  and d.specno=ii.specno and ma.brhid=ii.brhid) "
			+ "  where m.status=3 "+condtn+" and d.rdocno in ("+rdoc+")   and d.clstatus=0  group by d.psrno,d.unitid,d.specno having sum(d.qty-d.out_qty)>0  ";

		}
		String prdid="";
		String productname="",taxper="",unit="",brand="",psrno="",specid="",unitdoc="",uprice="",taxdoc="";
		ResultSet rs=stmt.executeQuery(sql);
		while(rs.next()){
			
		}
	}
	catch(Exception e){
		
	}
	finally{
		conn.close();
	}
%>