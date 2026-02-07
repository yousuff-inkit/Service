<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.common.*" %>
<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();

		JSONArray prdarray=new JSONArray();
		JSONObject objprd=new JSONObject(); 
		String prdname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
		String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
		String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
		String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
		String category = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
		String subcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");
		String department = request.getParameter("griddepartment")==null?"0":request.getParameter("griddepartment");
		String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
		String rdoc=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
		String reftype=request.getParameter("reftype")==null?"0":request.getParameter("reftype").trim();

		String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();
		String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
		String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype").trim();
		String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();
		String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();
		String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
		String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();		

		String sql="",sqltest="",condtn="";
		int method=0;
		int method1=0;
		String catid=clientcaid;
		
		int pricemgt=0,productconcat=0;
		/*String sqlcond1="";
		String sqlcond2="";
		String sqlselect="";*/

//System.out.println("=====rdoc===="+rdoc+"=====cmbbilltype====="+cmbbilltype);
Statement stmt2 = conn.createStatement (); 
String chk4="select method  from gl_prdconfig where field_nme='productnameconcat'";
ResultSet rs33=stmt2.executeQuery(chk4); 
if(rs33.next())
{

	productconcat=rs33.getInt("method");
}
if(productconcat>0){
   sqltest="concat(TRIM(m.productname),'-',bd.brandname,'-',dt.department)productname";
}else{
   sqltest="m.productname";
}

String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
ResultSet rs3=stmt2.executeQuery(chk3); 
if(rs3.next())
{

	pricemgt=rs3.getInt("method");
}
 java.sql.Date masterdate = null;
	if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
	{
		masterdate=ClsCommon.changeStringtoSqlDate(dates);
		
	}
	else{

	}
	
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
	 Statement stmt43=conn.createStatement();
	int discountset=0;
	String chk311="select method  from gl_prdconfig where field_nme='discountset'";
	ResultSet rs31=stmt43.executeQuery(chk311); 
	if(rs31.next())
	{
		discountset=rs31.getInt("method");
	}
 
	 
	int tax=0;
	Statement stmt3 = conn.createStatement (); 
 
	String chk31="select method  from gl_prdconfig where field_nme='tax' ";
	ResultSet rss3=stmt3.executeQuery(chk31); 
	if(rss3.next())
	{

		tax=rss3.getInt("method");
	}
	
  	int taxid=0;
  	if(!clientid.equalsIgnoreCase("")){
		String sqltax="select tax from my_acbook where dtype='CRM' and cldocno="+clientid+"";
		System.out.println("===sqltax======"+sqltax);
		ResultSet rs0=stmt.executeQuery(sqltax);				
		if(rs0.first())
		{
			taxid=rs0.getInt("tax");
		}
  	}
//	System.out.println("clientid ======= "+taxid+"===="+clientid);
	if(taxid==0)
	{
		tax=0;
	}
	String joinsql="";
	
	String fsql="";
	
	String outfsql="";
	
	
	if(tax>0)
	{
		if(Integer.parseInt(cmbbilltype)>0)
		{
			
			
			
			Statement pv=conn.createStatement();
			int prvdocno=0;
			String dd="select prvdocno from my_brch where doc_no='"+session.getAttribute("BRANCHID").toString()+"' ";
			ResultSet rs13=pv.executeQuery(dd); 
			if(rs13.next())
			{

				prvdocno=rs13.getInt("prvdocno");
			}
			
/*				
		joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"'  and status=3 and type=1  and provid='"+prvdocno+"' group by typeid ) t1 on "
				+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
		
		fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
		
		outfsql=outfsql+ " taxper , ";*/
		
			joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=2 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
					+ " t1.typeid=m.typeid   ";
		
			
			fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";

			outfsql=outfsql+ " taxper ,taxdocno, ";
		
		}
		
	}
	
 
		System.out.println("========prodsearchtype======"+prodsearchtype);

		if(prodsearchtype.equals("0")){
			 
			String chk1="select method  from gl_prdconfig where field_nme='edit'";
			ResultSet rs1=stmt1.executeQuery(chk1); 
			if(rs1.next())
			{

				method1=rs1.getInt("method");
			}
 
			
			int superseding=0;
			String chk11="select method  from gl_prdconfig where field_nme='superseding'";
			ResultSet rs11=stmt.executeQuery(chk11); 
			if(rs11.next())
			{
				
				superseding=rs11.getInt("method");
			}
				
			
			
            String sqls=""; 
            
            if(pricemgt>0) 
            {
            	
            	
            	
            	if(superseding==1) 
				{
            		
            		
          			sql="select dt.department,s.part_no,m.* from(  select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,'"+method1+"' eidtprice,at.mspecno as specid,"+sqltest+",m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,"
    						+ " sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,round(i.cost_price,2) costprice,i.stockid as stkid "
    						+ " "+sqls+"  from my_main m left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no"
    						+ "   inner join my_prddin i "
    						+ " on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' )"
    						+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
    						+ " "+joinsql+" where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+location+"' and i.date<='"+masterdate+"' "
    						+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date ) "
						  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;

                 	             	

            		
            		
				}
            	
            	else
            	{
            		
          			sql="select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, case   when '"+masterdate+"' between "
                			+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,'"+method1+"' eidtprice,at.mspecno as specid,m.part_no,dt.department,"+sqltest+",m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,"
    						+ " sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,round(i.cost_price,2) costprice,i.stockid as stkid "
    						+ " "+sqls+"  from my_main m left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no "
    						+ "   inner join my_prddin i "
    						+ " on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' )"
    						+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
    						+ " "+joinsql+" where m.status=3 "+condtn+" and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+location+"' and i.date<='"+masterdate+"' "
    						+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date ";	
                	

                	     	

            		
            	}
            	
            	
            	
            	
            	
          
            	
            }
            else
            {
            	
            	if(superseding==1)
				{
                	sql="select s.part_no,m.* from( select  "+fsql+" bd.brandname,at.mspecno as specid,"+sqltest+",m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
    						+ " sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,round(i.cost_price,2) costprice,i.stockid as stkid,dt.department,i.cost_price costprice,"
    						+ " round(m.fixingprice,2) unitprice  from my_main m left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no "
    						+ "   inner join my_prddin i "
    						+ " on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"'  )  " 
    						+ " "+joinsql+" where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+location+"' and i.date<='"+masterdate+"' "
    						+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date ) "
						  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;

                	
            		
				}
            	
            	else
            	{
            		
            	
            	
            	sql="select  "+fsql+" bd.brandname,at.mspecno as specid,m.part_no,"+sqltest+",m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
						+ "sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,round(i.cost_price,2) costprice,dt.department,i.stockid as stkid,"
						+ " round(m.fixingprice,2) unitprice  from my_main m left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no "
						+ "   inner join my_prddin i "
						+ "  on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"'  )  " 
						+ " "+joinsql+" where m.status=3 "+condtn+" and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+location+"' and i.date<='"+masterdate+"' "
						+ "  group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date "; 	
            	
    			
            	}
            }
            
	

		
            

		}
		else{
			  

			if(reftype.equalsIgnoreCase("DEL")){


				   if(pricemgt>0)
				   {
					   
					   
			/*					sql="select   "+outfsql+" "+discountset+" discountset,allowdiscount,brandname,locid,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty,part_no,productid, "
								+ " proid,productname,proname,unit,unitdocno,if(a.ref_type='DIR',a.unitprice1,unitprice) unitprice, "
								+ " qty*if(a.ref_type='DIR',a.unitprice1,unitprice) total,convert(if(a.ref_type='DIR','0',dis),char(10)) dis,convert(if(a.ref_type='DIR','0',discper),char(10)) discper, "
								+ "  if(a.ref_type='DIR',qty*unitprice1,netotal) netotal from (select "+fsql+" m1.ref_type,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice1,  "
								+ " case   when '"+masterdate+"' between "
								+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount, "
								+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
								+ " m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
								+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
								+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"' )) "
								+ " "+joinsql+" where m.status=3 and d.rdocno in("+rdoc+") and m1.brhid="+session.getAttribute("BRANCHID").toString()+" group by d.psrno,d.unitid,d.specno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0) a  ";
				
						*/
					
					
					sql="select  "+outfsql+"    "+discountset+" discountset ,round(allowdiscount,2) allowdiscount,brandname,locid,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty,part_no,productid, "
								+ " proid,productname,proname,unit,unitdocno, if(a.ref_type='DIR',round(a.unitprice1,2),round(unitprice,2)) unitprice, "
								+ " qty*if(a.ref_type='DIR',a.unitprice1,unitprice) total,convert(if(a.ref_type='DIR','',dis),char(10)) dis,convert(if(a.ref_type='DIR','',discper),char(10)) discper, "
								+ "  if(a.ref_type='DIR',qty*unitprice1,netotal) netotal from (select "+fsql+" m1.ref_type,case when '"+masterdate+"' between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end as unitprice1,  "
								+ " case   when '"+masterdate+"' between "
								+ "  clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount,bd.brandname,dt.department,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
								+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
								+ " m.part_no as proid,"+sqltest+",m.productname as proname,unit,u.doc_no unitdocno ,d.amount unitprice,((qty-out_qty)*d.amount) total, "
								+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
								+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no"
								+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
								+ " "+joinsql+" where m.status=3 "+condtn+" and d.rdocno in("+rdoc+") and m1.brhid="+session.getAttribute("BRANCHID").toString()+" group by d.psrno,d.unitid,d.specno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0 ) a ";
						
					
						
						
						
				   }
				   else
				   {
									sql="select "+fsql+" bd.brandname,dt.department,m1.locid,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
											+ " sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as balqty,part_no,m.part_no productid, "
											+ " m.part_no as proid,"+sqltest+",m.productname as proname,unit,u.doc_no unitdocno ,round(d.amount,2) unitprice,((qty-out_qty)*d.amount) total, "
											+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal"
											+ " from my_delm m1 left join  my_deld d on m1.doc_no=d.rdocno left join my_main m on(d.psrno=m.doc_no) left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no "
											+ " left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
											+ "  "+joinsql+" where m.status=3 "+condtn+" and d.rdocno in("+rdoc+") and m1.brhid="+session.getAttribute("BRANCHID").toString()+" group by d.psrno,d.amount,m1.locid having sum(d.qty-d.out_qty)>0  ";
									
									
									
									
				   }
			}
			else if(reftype.equalsIgnoreCase("SOR")){

	
			      sql=" select  "+fsql+" bd.brandname,dt.department,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc, "
							+ " ii.inblqty  totqty,sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as "
							+ " balqty,part_no,m.part_no productid,m.part_no as proid,"+sqltest+",m.productname as proname,unit, "
							+ " u.doc_no unitdocno,NtWtKG totwtkg, KGPrice kgprice,round(d.amount,2) unitprice,((qty-out_qty)*d.amount) total, "
							+ " d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal from  my_sorderm m1 left join my_sorderd d  "
							+ " on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no) left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join  my_unitm u "
							+ " on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no "
							+ " left join( select date,sum(op_qty)-sum(out_qty+del_qty+rsv_qty) inblqty,stockid,sum(out_qty+del_qty+rsv_qty) outqty, "
							+ " prdid,psrno,specno,brhid,locid "
							+ " from my_prddin where 1=1 and  date<='"+masterdate+"' group by psrno) ii on   (ii.psrno=d.psrno and ii.prdid=d.prdid "
							+ "	and d.specno=ii.specno and m1.brhid=ii.brhid) "+joinsql+"  "
							+ " where m.status=3 "+condtn+" "
							+ " and  d.clstatus=0 and  d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"   "
							+ " group by d.psrno,d.unitid,d.specno  having sum(d.qty-d.out_qty)>0     ";
			   
			
			
			
			}

			else if(reftype.equalsIgnoreCase("JOR")){
				

		        if(pricemgt>0)   
		        {
		        	  		sql=" select "+outfsql+" "+discountset+" discountset,lbrchg,unitprice*qty total, unitprice*qty netotal, unitprice,allowdiscount,brandname,stkid,specid,doc_no,rdocno,psrno,prodoc,totqty,oldqty,qty,outqty,balqty, "
		        	  				+ " part_no,productid,proid,productname,proname,unit,unitdocno  "
		        	  				+ " from(select  "+fsql+" m.lbrchg,case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, "
		        	  				+ " case   when '"+masterdate+"' between   clrfromdate and  clrtodate then 0   else pr.discount1 end as allowdiscount, "
		        	  				+ " bd.brandname,dt.department,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,  "
		        	  				+ " sum(d.qty)  totqty,sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as  balqty,  "
		        	  				+ " part_no,m.part_no productid,m.part_no as proid,"+sqltest+",m.productname as proname,unit,  u.doc_no unitdocno  "
		        	  				+ " from  my_joborderm m1   left join my_joborderd d   on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no) left join my_dept dt on m.deptid=dt.doc_no and dt.status=3  "
		        	  				+ " left join  my_unitm u  on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no "
		        	  				+ " left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
		        	  				+ " left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid and pr.catid='"+catid+"')) "
		        	  				+ "   "+joinsql+"  where m.status=3  "+condtn+" and  d.status=2 and d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
		        	  				+ " group by psrno having sum(d.qty-d.out_qty)>0 ) a ";
		        	  		
		        	  	
		        	  		
					
		        }
		        else
		        {
		        	 sql=" select  "+fsql+" m.lbrchg,bd.brandname,dt.department,d.stockid stkid,d.specno as specid,d.psrno as doc_no,d.rdocno,d.psrno,d.psrno as prodoc,  "
				        		+ " sum(d.qty)  totqty,sum(d.out_qty) as oldqty,sum(d.qty-d.out_qty) qty,sum(d.out_qty) outqty,sum(d.qty-d.out_qty) as  balqty,  "
				        		+ " part_no,m.part_no productid,m.part_no as proid,"+sqltest+",m.productname as proname,unit,  u.doc_no unitdocno  "
				        		+ " from  my_joborderm m1   left join my_joborderd d   on d.rdocno=m1.doc_no  left join my_main m on(d.psrno=m.doc_no) left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 "
				        		+ " left join  my_unitm u  on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no "
				        		+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) "
				                + "  "+joinsql+"  where m.status=3  "+condtn+" and  d.status=2 and d.rdocno in("+rdoc+") and  m1.brhid="+session.getAttribute("BRANCHID").toString()+"  "
				                + " group by psrno having sum(d.qty-d.out_qty)>0  ";
		        	 
		        	
		        	
		        	
		        }
		
		
			}
	        

	 
		 
	}

 	System.out.println("----searchProduct-sql---"+sql);
		ResultSet rss = stmt.executeQuery(sql);      
		
		
		String prdid="";
		String dmbrand="",taxper="",unit="",brand="",psrno="",specid="",unitdoc="",uprice="",taxdoc="",catname="",scatname="",sprice="";
		while(rss.next()) {
			JSONObject objsub=new JSONObject();
			objsub.put("part_no", rss.getString("part_no"));
			objsub.put("brandname", rss.getString("brandname"));
			objsub.put("psrno", rss.getString("psrno"));
			objsub.put("specid", rss.getString("specid"));
			objsub.put("unitdocno", rss.getString("unitdocno"));
			
			objsub.put("unitprice", rss.getString("unitprice"));
            
			//objsub.put("category", rss.getString("category"));
			//objsub.put("subcategory", rss.getString("subcategory"));
			objsub.put("cost_price", rss.getString("costprice"));
			//objsub.put("demobrand", rss.getString("demobrand"));
			if(tax>0)
			{
			objsub.put("taxdocno", rss.getString("taxdocno"));
			objsub.put("taxper", rss.getString("taxper"));
			}else {
				objsub.put("taxdocno", "0");
				objsub.put("taxper", "0");
			}
			objsub.put("unit", rss.getString("unit"));
			objsub.put("productname", rss.getString("productname"));
			ResultSetMetaData rsmd = rss.getMetaData();
			String columnName="allowdiscount";
			
		    int columns = rsmd.getColumnCount(),alldis=0;
		    for (int x = 1; x <= columns; x++) {
		        if (columnName.equals(rsmd.getColumnName(x))) {
		        	alldis=1;
		        }
		    }
		    if(alldis==1){
				objsub.put("allowdiscount", rss.getString("allowdiscount"));
		    }else {
		    	objsub.put("allowdiscount", "0");	
		    }
			objsub.put("balqty", rss.getString("balqty"));
			objsub.put("outqty", rss.getString("outqty"));
			objsub.put("totqty", rss.getString("totqty"));     
			/*prdid+=rs.getString("part_no")+",";
			prdname+=rs.getString("productname")+",";         
			
			unit+=rs.getString("unit")+",";
			brand+=rs.getString("brandname")+","; 
			psrno+=rs.getString("psrno")+","; 
			specid+=rs.getString("specid")+","; 
			unitdoc+=rs.getString("unitdocno")+","; 
			uprice+=rs.getString("unitprice")+",";
			catname+=rs.getString("category")+","; 
			scatname+=rs.getString("subcategory")+","; 
			sprice+=rs.getString("cost_price")+",";
			dmbrand+=rs.getString("demobrand")+","; 
			if(tax>0)
			{
			taxdoc+=rs.getString("taxdocno")+","; 
			taxper+=rs.getString("taxper")+",";}  */
			
			
			prdarray.add(objsub);
			
	  		} 
		objprd.put("pddata", prdarray);
		//emp=emp.substring(0, emp.length()>0?emp.length()-1:0);   
		//response.setContentType("text/html; charset=utf8");
		//response.getWriter().write(prdid+"####"+prdname+"####"+taxper+"####"+unit+"####"+brand+"####"+psrno+"####"+specid+"####"+unitdoc+"####"+uprice+"####"+taxdoc+"####"+catname+"####"+scatname+"####"+sprice+"####"+dmbrand);     
		response.getWriter().print(objprd);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>