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
		String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
		String rdoc=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
		String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();
		String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
		String reftypes=request.getParameter("reftypes")==null?"0":request.getParameter("reftypes").trim();
		String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();
		String date=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
		String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();
		String acno=request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
		String brandids=request.getParameter("brandids")==null?"0":request.getParameter("brandids").trim();
		String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();
		String prdname = request.getParameter("productsname")==null?"0":request.getParameter("productsname");
		String brandname = request.getParameter("brandsname")==null?"0":request.getParameter("brandsname");
		String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
		String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
		String category = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
		String subcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");
		String department = request.getParameter("griddepartment")==null?"0":request.getParameter("griddepartment");
		System.out.println("===clientid======"+clientid+"==clientcatid=="+clientcaid);
		String sql="",sqltest="",condtn="";
		int method=0,productconcat=0;
		/*String sqlcond1="";
		String sqlcond2="";
		String sqlselect="";*/

		/*			String chk="select method  from gl_prdconfig where field_nme='prosearch_stock'";
		ResultSet rs=stmt.executeQuery(chk); 
		if(rs.next())
		{

			method=rs.getInt("method");
		}*/


		java.sql.Date sqlStartDate=null;


		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
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
		if((location.equalsIgnoreCase("undefined"))||(location.equalsIgnoreCase(""))||(location.equalsIgnoreCase("0")))
		{
			String brhid = session.getAttribute("BRANCHID").toString(); 
			String strSql = "select m.doc_no,loc_name as location,branchname as branch from my_locm m left join my_brch b on(b.doc_no=m.brhid) where m.status=3 and brhid="+brhid+"  group by m.brhid order by m.doc_no asc";
			
			System.out.println("--locatioset--"+strSql);
			
			ResultSet rs = stmt.executeQuery(strSql);
			int userid=0;
			while(rs.next ()) {
				location=rs.getString("doc_no");
				
				 
			}
		}
		
		System.out.println("======="+prodsearchtype);
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


				/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,1 qty,sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno ) where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.date ";*/
			/*}
			else{

				sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,1 qty,0 outqty,0 as balqty,0 as totqty,0 as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no)  where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"' ";

			}*/

			/*sql="select at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,1 qty,0 outqty,0 as balqty,0 as totqty,"+sqlselect+" as stkid  from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join my_desc de on(de.psrno=m.doc_no) "+sqlcond1+" where m.status=3 and de.brhid='"+session.getAttribute("BRANCHID").toString()+"' "+sqlcond2+" ";*/

			int superseding=0;
			String chk1="select method  from gl_prdconfig where field_nme='superseding'";
			ResultSet rs1=stmt.executeQuery(chk1); 
			if(rs1.next())
			{
				
				superseding=rs1.getInt("method");
			}
				



			
			
			if(superseding==1)
			{
				sql=" select dt.department,m.jdeno,m.bhno,s.part_no,m.* from(  select bd.brandname,at.mspecno as specid,"+sqltest+",m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(20)) qty,round(i.cost_price,2) costprice,sum(i.out_qty) outqty, "
						+ " sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,i. unit_price unitprice  "
						+ " from my_main m left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ "    left join  my_brand bd on m.brandid=bd.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no inner join my_prddin i on(i.psrno=m.psrno and  "
						+ "i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' ) where m.status=3 and  "
						+ "i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and i.locid='"+location+"' and  i.date<='"+sqlStartDate+"'  group by i.prdid having  "
						+ "sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by  i.prdid,i.date,i.stockid ) "
						  + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
				
			}
			 
			else
			{
				
				
				sql="select dt.department,m.jdeno,m.bhno,bd.brandname,at.mspecno as specid,m.part_no,"+sqltest+",m.doc_no,u.unit,m.munit as unitdocno,m.psrno,convert('',char(20)) qty,sum(i.out_qty) outqty, "
						+ "sum(i.op_qty) as totqty,i.stockid as stkid,i. unit_price unitprice,round(i.cost_price,2) costprice, coalesce(sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty  "
						+ " from my_main m left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ "    left join  my_brand bd on m.brandid=bd.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no inner join my_prddin i on(i.psrno=m.psrno and  "
						+ "i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' ) where m.status=3 "+condtn+" and  "
						+ "i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and i.locid='"+location+"' and  i.date<='"+sqlStartDate+"' group by i.prdid having  "
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
			  sql="select dt.department,m.jdeno,m.bhno,bd.brandname,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty) totqty, "
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
			
			//objsub.put("unitprice", rss.getString("unitprice"));
            
			//objsub.put("category", rss.getString("category"));
			//objsub.put("subcategory", rss.getString("subcategory"));
			//objsub.put("cost_price", rss.getString("costprice"));
			//objsub.put("demobrand", rss.getString("demobrand"));
			
			objsub.put("unit", rss.getString("unit"));
			objsub.put("productname", rss.getString("productname"));
			objsub.put("balqty", rss.getString("balqty"));
			//objsub.put("allowdiscount", rss.getString("allowdiscount"));
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
  
