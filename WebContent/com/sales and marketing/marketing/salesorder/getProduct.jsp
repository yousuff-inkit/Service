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
		String clientid=request.getParameter("clientid")==null || request.getParameter("clientid").equals("") ?"0":request.getParameter("clientid").trim();
		String clientcatid=request.getParameter("clientcatid")==null || request.getParameter("clientcatid").equals("") ?"0":request.getParameter("clientcatid").trim();
		//String brchid=request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
		JSONArray prdarray=new JSONArray();
		JSONObject objprd=new JSONObject(); 
		String dates=request.getParameter("dates")==null || request.getParameter("dates").equals("") ?"0":request.getParameter("dates").trim();
		String cmbbilltype=request.getParameter("cmbbilltype")==null || request.getParameter("cmbbilltype").equals("") ?"0":request.getParameter("cmbbilltype").trim();
		String docdepid=request.getParameter("docdepid")==null || request.getParameter("docdepid").equals("") ?"0":request.getParameter("docdepid").trim();
		String prodsearchtype=request.getParameter("prodsearchtype")==null || request.getParameter("prodsearchtype").equals("") ?"0":request.getParameter("prodsearchtype").trim();
		String rdoc=request.getParameter("enqmasterdocno")==null || request.getParameter("enqmasterdocno").equals("") ?"0":request.getParameter("enqmasterdocno").trim();
		//System.out.println("Product Search Params===clientid======"+clientid+"==clientcatid=="+clientcatid+"==dept=="+docdepid+"===date==="+dates);
		//Statement stmt = conn.createStatement (); 
		//Statement stmt1 = conn.createStatement (); 
		String sql="";
		int method=0;
		int method1=0;
 
		int pricemgt=0;
		/*String sqlcond1="";
		String sqlcond2="";
		String sqlselect="";*/
		String catid=clientcatid;
		String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
		ResultSet rs=stmt.executeQuery(chk); 
		if(rs.next())
		{

			method=rs.getInt("method");
		}

		
		  String brchid=session.getAttribute("BRANCHID").toString();
		  
		  
		  java.sql.Date masterdate = null;
			if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
	     	{
				masterdate=ClsCommon.changeStringtoSqlDate(dates);
	     		
	     	}
	     	else{
	     
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
				String sqltax="select tax from my_acbook where dtype='CRM' and cldocno="+clientid+"";
				//System.out.println("===sqltax======"+sqltax);
				ResultSet rs0=stmt.executeQuery(sqltax);				
				if(rs0.first())
				{
					taxid=rs0.getInt("tax");
				}
				
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
					
					
	/*			joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid ) t1 on "
						+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
				
				fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
				
				outfsql=outfsql+ " taxper , ";*/
				
				
					joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=2 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid   ";
				
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
					
					outfsql=outfsql+ " taxper ,taxdocno, ";
				}
				
			}
			
	

		if(prodsearchtype.equals("0")){ // o main only else prddin
			
			String chk1="select method  from gl_prdconfig where field_nme='edit'";
			ResultSet rs1=stmt1.executeQuery(chk1); 
			if(rs1.next())
			{

				method1=rs1.getInt("method");
			}
	/*		String chk2="select catid from my_acbook where dtype='CRM' and cldocno='"+clientid+"'";
			ResultSet rs2=stmt1.executeQuery(chk2); 
			if(rs2.next())
			{

				catid=rs2.getInt("catid");
			}
		 */
			 
			String chk3="select method  from gl_prdconfig where field_nme='pricemgt'";
			ResultSet rs3=stmt1.executeQuery(chk3); 
			if(rs3.next())
			{

				pricemgt=rs3.getInt("method");
			}
		 
			int discountset=0;
			String chk311="select method  from gl_prdconfig where field_nme='discountset'";
			ResultSet rs31=stmt1.executeQuery(chk311); 
			if(rs31.next())
			{

				discountset=rs31.getInt("method");
			}
		 
			int superseding=0;
			String chk21="select method  from gl_prdconfig where field_nme='superseding'";
			ResultSet rs21=stmt1.executeQuery(chk21); 
			if(rs21.next())
			{
				
				superseding=rs21.getInt("method");
			}
				
		
			
            String sqls=""; 

			if(method>0){ // eidtprice price mgt edit unit price

				if(pricemgt>0)
                {
					if(superseding==1)
					{
						
						sql="  select s.part_no,m.* from (  select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, case   when '"+masterdate+"' between "
	                			+ "  clrfromdate and  clrtodate then 0   else round(pr.discount1,2) end as allowdiscount,bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
								+ " m.psrno,round(i.cost_price,2) costprice,convert('',char(20)) qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
								+ " sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
								+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"') "
								+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
							 	+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'   "
								+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ) "
						  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
						
				// System.out.println("p1---"+sql);	
					}
					else
					{
				sql="select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, case   when '"+masterdate+"' between "
            			+ "  clrfromdate and  clrtodate then 0   else round(pr.discount1,2) end as allowdiscount,bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
						+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,round(i.cost_price,2) costprice,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
						+ " sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
						+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
						+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"') "
						+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
					 	+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'   "
						+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ";
                    
		// System.out.println("p2---"+sql);
					}
                }
				else
				{
					if(superseding==1)
					{
						sql=" select s.part_no,m.* from (  select "+fsql+"  bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
								+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,round(i.cost_price,2) costprice,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
								+ " sum(i.op_qty) as totqty,i.stockid as stkid ,round(m.fixingprice,2) unitprice,0 allowdiscount  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin "
								+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"' ) "
							 	+ " "+joinsql+"  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'   "
								+ " group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ) "
						  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
				 	//System.out.println("p3---"+sql);
					}
					
					else
					{
						sql="select "+fsql+"  bd.brandname,1 method,'"+method1+"' eidtprice, at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno, "
								+ " m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty,round(i.cost_price,2) costprice,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty, "
								+ " sum(i.op_qty) as totqty,i.stockid as stkid ,round(m.fixingprice,0) unitprice,0 allowdiscount  from my_main m left join my_unitm u on m.munit=u.doc_no left join  my_brand bd on m.brandid=bd.doc_no  "
								+ " left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) left join my_prddin "
								+ "  i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+brchid+"' ) "
							 	+ " "+joinsql+"  where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'   "
								+ " group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ";
	                        
				 	//System.out.println("p4---"+sql);
					}
					
					
				
				}
				
			}
			else{

			 
				if(pricemgt>0)
                {
					
					if(superseding==1)
					{
						
						
						sql=" select s.part_no,m.* from ( select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, case   when '"+masterdate+"' between "
	                			+ "  clrfromdate and  clrtodate then 0   else round(pr.discount1,2) end as allowdiscount,bd.brandname,0 method,'"+method1+"' eidtprice, "
	                			+ " at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as totqty,0 as costprice,"
							    + "0 as stki  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
							    + "left join my_desc de on(de.psrno=m.doc_no)   "
							    + "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
									+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'  group by m.doc_no ) "
						  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
						
						
					  //System.out.println("p5---"+sql);	
					}
					else
					{
						
					
					
						sql="select  "+fsql+" "+discountset+" discountset, case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, case   when '"+masterdate+"' between "
	                			+ "  clrfromdate and  clrtodate then 0   else round(pr.discount1,2) end as allowdiscount,bd.brandname,0 method,'"+method1+"' eidtprice, "
	                			+ " at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as costprice,0 as totqty,"
							    + "0 as stki  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
							    + "left join my_desc de on(de.psrno=m.doc_no)   "
							    + "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
									+ " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'  group by m.doc_no  ";
					 // System.out.println("p6---"+sql);	
						
					}
					
				
                }
				else
				{
					
				
					
					
					if(superseding==1)
					{
						
						sql=" select s.part_no,m.* from ( select  "+fsql+" bd.brandname,0 method,'"+method1+"' eidtprice,at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as costprice,0 as balqty,0 as totqty,"
								+ "0 as stki,round(m.fixingprice,0) unitprice,0 allowdiscount  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ "left join my_desc de on(de.psrno=m.doc_no)   "
							    + " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"'  )  "
						  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
						
					  //System.out.println("p7---"+sql);
						
					}
					
					else
					{
						
						sql="select  "+fsql+" bd.brandname,0 method,'"+method1+"' eidtprice,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as costprice,0 as totqty,"
								+ "0 as stki,round(m.fixingprice,0) unitprice,0 allowdiscount  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
								+ "left join my_desc de on(de.psrno=m.doc_no)   "
							    + " "+joinsql+" where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+brchid+",de.brhid)='"+brchid+"' ";
						 // System.out.println("p8---"+sql);	
						
					}
					
					
					
				
					
				}
			}

		
		
		}
		else{

			if(method>0){

				
	 			
				
				
				sql="select  "+outfsql+"   brandname,1 method, stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
						+ "( select "+fsql+"  bd.brandname,i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(i.op_qty) as qty,sum(i.out_qty+i.del_qty+i.rsv_qty) as outqty,round(i.cost_price,2) costprice,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
						+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  "
						+ "  my_brand bd on m.brandid=bd.doc_no inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and ma.brhid=i.brhid)  "+joinsql+"  where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.stockid having sum((op_qty)-(i.out_qty+i.rsv_qty+i.del_qty))>0 order by i.date ) as a ";

				
			 	//System.out.println("p9---"+sql);
				

			}
			else{


				

				
				sql="select   "+outfsql+"   brandname,0 method, allowdiscount,stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 as costprice,0 size,part_no,productid,productname,unit,unitdocno,unitprice,total, "
						+ " discper,dis,netotal from "
						+ "( select  "+fsql+"  bd.brandname,0 as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,"
						+ " d.amount unitprice,sum(d.qty-d.out_qty)*d.amount total,d.disper discper,(sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis,((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100)  netotal,round(d.allowdiscount,2)allowdiscount  from "
						+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join "
						+ " my_unitm u on(d.unitid=u.doc_no)  left join  my_brand bd on m.brandid=bd.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "+joinsql+"   where  d.clstatus=0 and m.status=3 and d.rdocno in("+rdoc+") "
						 + "and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by  d.psrno,d.amount,d.disper having sum(d.qty-d.out_qty)>0  order by d.prdid,d.doc_no ) as a ";

				
				 //System.out.println("p10==>"+sql);
			}


			/*sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno from "
					+ "( select "+sqlselect+" as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty) as qty,sum(d.out_qty) as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno from "
					+ "my_qotm ma left join my_qotd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlcond1+" where m.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "+sqlcond2+" ) as a ";
			 */
		}

 	
		ResultSet rss = stmt.executeQuery(sql);      
		//System.out.println("----product 1---");
		
		String prdid="";
		String dmbrand="",prdname="",taxper="",unit="",brand="",psrno="",specid="",unitdoc="",uprice="",taxdoc="",catname="",scatname="",sprice="";
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
			//System.out.println("----product 2---");
			if(tax>0)
			{
			objsub.put("taxdocno", rss.getString("taxdocno"));
			objsub.put("taxper", rss.getString("taxper"));
			}
			objsub.put("unit", rss.getString("unit"));
			objsub.put("productname", rss.getString("productname"));
			objsub.put("allowdiscount", rss.getString("allowdiscount"));
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
  
