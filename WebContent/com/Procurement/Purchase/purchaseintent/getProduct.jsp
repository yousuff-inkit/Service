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
		String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
		String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();

		String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
		 
		String reftypes=request.getParameter("reftypes")==null?"0":request.getParameter("reftypes").trim();


		String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

		String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
		String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();

		String acno=request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
		String brandname=request.getParameter("brandids")==null?"0":request.getParameter("brandids").trim();

		String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
		String prdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
		String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
		String scope = request.getParameter("scopeid")==null?"0":request.getParameter("scopeid");
		String scopeproduct = request.getParameter("scopeproduct")==null?"0":request.getParameter("scopeproduct");
		String category = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
		String subcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");
		String id = request.getParameter("id")==null?"0":request.getParameter("id");
		conn = ClsConnection.getMyConnection();
		//Statement stmt = conn.createStatement (); 
		//Statement stmt1 = conn.createStatement (); 
		 String brcid=session.getAttribute("BRANCHID").toString();
		 java.sql.Date masterdate = null;
		 String catid=clientcaid;
		int method=0;
        String condtn="",sql="";
        Statement stmtVeh = conn.createStatement ();
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
				String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
				ResultSet rs=stmtVeh.executeQuery(chk); 
				if(rs.next())
				{
					
					method=rs.getInt("method");
				}
				
			    int method1=0;
				String chk1="select method  from gl_prdconfig where field_nme='brandchk'";
				ResultSet rs1=stmtVeh.executeQuery(chk1); 
				if(rs1.next())
					{
								
					method1=rs1.getInt("method");
					}


				String sqlstest="";
							
			    if(method1>0)
				{
				  sqlstest=" left join  my_acbook ac on ac.acno='"+acno+"'  and ac.dtype='VND'  left join my_vendorbrand br on ac.cldocno=br.rdocno and m.brandid=br.brandid ";
				}
			
			    
			    

				int tax=0;
				Statement stmt3 = conn.createStatement (); 
			 
				String chk31="select method  from gl_prdconfig where field_nme='tax' ";
				ResultSet rss3=stmt3.executeQuery(chk31); 
				if(rss3.next())
				{

					tax=rss3.getInt("method");
				}
				
				int temptax=0;
				Statement stmt3111 = conn.createStatement (); 
				String sqlss="select coalesce(t1.tax,0) tax from my_acbook a left join my_vndtax t1 on t1.doc_no=a.type where   a.dtype='VND' and a.acno='"+acno+"' ";
			 // System.out.println("===sqlss======"+sqlss);
				ResultSet rsss=stmt3111.executeQuery(sqlss);
			    if(rsss.next())
			    {
			    	temptax=rsss.getInt("tax");
			    	
			    }
				if(temptax!=1)
				{
					tax=0;
				}
				String joinsql="";
				
				String fsql="";
				
				String outfsql="";
				
				
				if(tax>0)
				{
					
					
					if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			     	{
						masterdate=ClsCommon.changeStringtoSqlDate(dates);
			     		
			     	}
			     	else{
			     
			     	}
				
					
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
						
						
				/*	joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
					
					outfsql=outfsql+ " taxper , ";*/
					
					joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'  and type=1 and if(1="+cmbbilltype+",per,cstper)>0  group by typeid  ) t1 on "
							+ " t1.typeid=m.typeid   ";
				
					
					fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
					
					outfsql=outfsql+ " taxper ,taxdocno, ";
					
					}
					
				}
				int superseding=0;
				String chk11="select method  from gl_prdconfig where field_nme='superseding'";
				ResultSet rs11=stmtVeh.executeQuery(chk11); 
				if(rs11.next())
				{
					
					superseding=rs11.getInt("method");
				}
					
				if(superseding==1)
				{
					 sql=" select s.part_no,m.* from (  select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, case   when '"+masterdate+"' between "
	                		+ "  clrfromdate and  clrtodate then 0   else round(pr.discount1,2) end as allowdiscount from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
						    + "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
							+ "   left join my_desc de on(de.psrno=m.doc_no)  left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
							+ "   where m.status=3 "+condtn+" and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'  ) "
						    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;

					
				}
				
				else
				{    // left join my_desc de on(de.psrno=m.doc_no) and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"'
					 sql="select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno, case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice, case   when '"+masterdate+"' between "
	                		+ "  clrfromdate and  clrtodate then 0   else round(pr.discount1,2) end as allowdiscount from my_main m left join  "
							+ " my_unitm u on m.munit=u.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) "+sqlstest+" "
									+ "  left join my_descpr pr on pr.psrno=m.doc_no and (pr.catid='"+catid+"' or ('"+masterdate+"' between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+catid+"')) "
									+ "      left join  my_brand bd on m.brandid=bd.doc_no     "+joinsql+"  "
							+ "   where m.status=3 "+condtn+"  "	;
						
					
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
			//objsub.put("cost_price", rss.getString("costprice"));
			//objsub.put("demobrand", rss.getString("demobrand"));
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
  
