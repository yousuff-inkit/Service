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
		
		String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
		String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();
		String acno=request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
		String reqmasterdocno=(request.getParameter("reqmasterdocno")==null||request.getParameter("reqmasterdocno")=="")?"0":request.getParameter("reqmasterdocno").trim();
		String dtype=request.getParameter("dtype")==null?"0":request.getParameter("dtype").trim();
		
		Statement stmtVeh = conn.createStatement (); 
		String brcid=session.getAttribute("BRANCHID").toString();
		int method=0,productconcat=0;
		String sqltest="";
		String chk4="select method  from gl_prdconfig where field_nme='productnameconcat'";
		ResultSet rs33=stmtVeh.executeQuery(chk4); 
		if(rs33.next())
		{

			productconcat=rs33.getInt("method");
		}
	   if(productconcat>0){
		   sqltest="concat(TRIM(m.productname),'-',bd.brandname,'-',dt.department)productname";
	   }else{
		   sqltest="m.productname";
	   }
		String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
		ResultSet rs=stmtVeh.executeQuery(chk); 
		if(rs.next())
		{
			
			method=rs.getInt("method");
		}
		
		
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
				
				
	/*		joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid  ) t1 on "
					+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'    ";
			
			fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
			
			outfsql=outfsql+ " taxper , ";*/
			
			
				joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"'   and type=1  and if(1="+cmbbilltype+",per,per)>0 group by typeid  ) t1 on "
						+ " t1.typeid=m.typeid   ";
			
				
				fsql=fsql+" case when 1="+cmbbilltype+"  then t1.per when 2="+cmbbilltype+"  then t1.per else 0 end as  'taxper' ,t1.taxdocno , ";
				
				outfsql=outfsql+ " taxper ,taxdocno, ";	
			}
			
		}else {
			fsql=fsql+ " 0 taxper ,0 taxdocno,'' tax_name,0 per,0 cstper, ";	
		}
		
		
		int joinchk=0;
		Statement stmt322 = conn.createStatement (); 
	 
		String chk31111="select method  from gl_prdconfig where field_nme='prdjoinchk' ";
		ResultSet rss3111=stmt322.executeQuery(chk31111); 
		if(rss3111.next())
		{

			joinchk=rss3111.getInt("method");
		}
		
		
	   	int superseding=0;
			String chk11="select method  from gl_prdconfig where field_nme='superseding'";
			ResultSet rs11=stmtVeh.executeQuery(chk11); 
			if(rs11.next())
			{
				
				superseding=rs11.getInt("method");
			}
			String sql001="";	
			String sql002="";	
			if(superseding==1)
			{
				
				sql001= " select s.part_no,m.* from (  ";
				sql002= "  ) "
					    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority ";
			 
			}
		   	
		
		
		String sqjoin1="";		
		String sqjoin2="";
		
		if(joinchk>0)
		{
			sqjoin1 = " left join my_desc de on(de.psrno=m.doc_no)";
			sqjoin2 =  " and de.discontinued=0  and  if(de.brhid=0,"+brcid+",de.brhid)='"+brcid+"' ";
		}
		
		String sql="";
		
		if(dtype.equalsIgnoreCase("GRN"))
		{
			 sql=""+sql001+" select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,"+sqltest+",m.doc_no,u.unit,m.munit unitdocno,m.psrno,0 as allowdiscount,"
					+ " d.stockid,  sum(d.qty-d.out_qty)  qty,0 pqty,  sum(d.qty-d.out_qty) qutval,sum(d.qty-d.out_qty) saveqty,d.amount unitprice,d.amount*sum(d.qty-d.out_qty) total,"
					+ " d.amount*sum(d.qty-d.out_qty)* d.disper/100 discount, d.disper, (d.amount*sum(d.qty-d.out_qty))-(d.amount*sum(d.qty-d.out_qty)*d.disper/100) nettotal,"
					+ " 0 foc, 0 focqutval, 0 focpqty, 0 focsaveqty, 0 orderdiscper, 0 orderamount "
					+ " from my_grnm m1 left join my_grnd d on d.tr_no=m1.tr_no left join my_main m on d.prdid=m.doc_no "
					+ " left join my_unitm u on m.munit=u.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ " "+sqjoin1+" "+joinsql+" where m.status=3 "+sqjoin2+" "+sql002+" and m1.brhid="+brcid+" and m1.doc_no in ("+reqmasterdocno+")" 
					+" group by d.stockid having sum(d.qty-d.out_qty)>0";
		
		}else if(dtype.equalsIgnoreCase("PO")){
			 sql=""+sql001+" select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,"+sqltest+",m.doc_no,u.unit,m.munit unitdocno,m.psrno,case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice,0 as allowdiscount,"
					+ " coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qty,coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0) qutval,  coalesce(sum(rd.out_qty),0) pqty,"
					+ " coalesce(sum(rd.qty-rd.out_qty),0) saveqty, coalesce(sum(rd.foc),0)-coalesce(sum(rd.foc_out),0) foc,coalesce(sum(rd.foc),0)-coalesce(sum(rd.foc_out),0) focqutval, coalesce(sum(rd.foc_out),0) focpqty,"
					+ " coalesce(sum(rd.foc-rd.foc_out),0) focsaveqty,rd.amount unitprice, (coalesce(sum(rd.qty),0)-coalesce(sum(rd.out_qty),0))*rd.amount*rd.disper/100 discount,rd.disper,"
					+ " ((sum(rd.qty-rd.out_qty)*rd.amount)-(sum(rd.qty-rd.out_qty)*rd.amount*rd.disper)/100) nettotal,sum(rd.qty-rd.out_qty)*rd.amount total ,rd.disper orderdiscper,rd.amount orderamount,"
					+ " 0 stockid "
					+ " from my_ordm m1 left join my_ordd rd on rd.tr_no=m1.tr_no left join my_grnd d on m1.tr_no=d.tr_no left join my_main m  on rd.prdid=m.doc_no "
					+ " left join my_unitm u on m.munit=u.doc_no  left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ " "+sqjoin1+" "+joinsql+" where m.status=3 and m1.status=3 and rd.clstatus=0 "+sqjoin2+" "+sql002+" and m1.brhid="+brcid+" and rd.tr_no in ("+reqmasterdocno+") and rd.qty-rd.out_qty>0"
					+ " group by rd.prdid,rd.amount,rd.disper order by rd.prdid,rd.rowno";
						
		}else{
			 sql=""+sql001+" select  "+fsql+" "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,"+sqltest+",m.doc_no,u.unit,m.munit unitdocno,m.psrno,case when '"+masterdate+"' between clrfromdate and  clrtodate then round(m.clrprice,2) else round(m.fixingprice,2) end as unitprice,0 as allowdiscount,"
					+ " 0 stockid, 0 qty, 0 pqty, 0 qutval, 0 saveqty, 0 total, 0 disper, 0 discount, 0 nettotal, 0 foc, 0 focqutval, 0 focpqty, 0 focsaveqty, 0 orderdiscper, 0 orderamount "
					+ " from my_main m left join my_unitm u on m.munit=u.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
					+ " "+sqjoin1+" "+joinsql+" where m.status=3 "+sqjoin2+" "+sql002;
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
			//if(tax>0)
			//{
			objsub.put("taxdocno", rss.getString("taxdocno"));
			objsub.put("taxper", rss.getString("taxper"));
		//	}
			objsub.put("unit", rss.getString("unit"));
			objsub.put("productname", rss.getString("productname"));
			objsub.put("allowdiscount", rss.getString("allowdiscount"));
			
			objsub.put("stockid", rss.getString("stockid"));
			objsub.put("qty", rss.getString("qty"));
			objsub.put("pqty", rss.getString("pqty"));
			objsub.put("qutval", rss.getString("qutval"));
			objsub.put("saveqty", rss.getString("saveqty"));
			objsub.put("total", rss.getString("total"));
			objsub.put("disper", rss.getString("disper"));
			objsub.put("discount", rss.getString("discount"));
			objsub.put("nettotal", rss.getString("nettotal"));
			objsub.put("foc", rss.getString("foc"));
			objsub.put("focqutval", rss.getString("focqutval"));
			objsub.put("focpqty", rss.getString("focpqty"));
			objsub.put("focsaveqty", rss.getString("focsaveqty"));
			objsub.put("orderdiscper", rss.getString("orderdiscper"));
			objsub.put("orderamount", rss.getString("orderamount"));
			
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
  
