<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
		String clientcatid=request.getParameter("clientcatid")==null?"0":request.getParameter("clientcatid").trim();
		String brchid=request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
		String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
		System.out.println("===clientid======"+clientid+"==clientcatid=="+clientcatid);
		int tax=0;
		Statement stmt3 = conn.createStatement (); 
		 //String brchid=session.getAttribute("BRANCHID").toString();
		
		//Getting Client Category
		String strclientcat="select coalesce(catid,0) catid from my_acbook where cldocno="+clientid+" and dtype='CRM' and status=3";
		ResultSet rsclientcat=stmt.executeQuery(strclientcat);
		while(rsclientcat.next()){
			clientcatid=rsclientcat.getString("catid");
		}
		
		String chk31="select method  from gl_prdconfig where field_nme='tax' ";
		ResultSet rss3=stmt3.executeQuery(chk31); 
		if(rss3.next())
		{

			tax=rss3.getInt("method");
		}
		
	    	int taxid=0;
			String sqltax="select tax from my_acbook where dtype='CRM' and cldocno="+clientid+"";
			System.out.println("===sqltax======"+sqltax);
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
			
				
				
				
				Statement pv=conn.createStatement();
				int prvdocno=0;
				String dd="select prvdocno from my_brch where doc_no='"+brchid+"' ";
				ResultSet rs13=pv.executeQuery(dd); 
				if(rs13.next())
				{

					prvdocno=rs13.getInt("prvdocno");
				}
				
				
/*			joinsql=joinsql+" left join (select max(doc_no) tdocno,typeid from gl_taxmaster where   fromdate<='"+masterdate+"' and todate>='"+masterdate+"' and provid='"+prvdocno+"' group by typeid ) t1 on "
					+ " t1.typeid=m.typeid left join gl_taxmaster t on t.doc_no=t1.tdocno  and t.provid='"+prvdocno+"'   ";
			
			fsql=fsql+" case when 1="+cmbbilltype+"  then per when 2="+cmbbilltype+"  then cstper else 0 end as  'taxper' , ";
			
			outfsql=outfsql+ " taxper , ";*/
			
			
				joinsql=joinsql+" left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where   fromdate<=now() and todate>=now() and provid='"+prvdocno+"'  and type=2 and if(1=1,per,cstper)>0  group by typeid  ) t1 on "
						+ " t1.typeid=m.typeid   ";
			
				
				fsql=fsql+" case when 1=1  then t1.per when 2=1  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno , ";
				
				outfsql=outfsql+ " taxper ,taxdocno, ";
			
			
		}
		//m.prdtype=2 and
		
		String strSql = "select    "+fsql+"  1 discountset, case when now() between clrfromdate and  clrtodate then m.clrprice else m.fixingprice end "+
		" as unitprice, case   when now() between   clrfromdate and  clrtodate then 0   else round(pr.discount1,2) end as allowdiscount,"+
		" m.barcode,0 method,'1' eidtprice,  at.mspecno as specid,dt.department,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,"+
		" m.psrno,convert('',char(100)) qty,0 outqty,0 as balqty,0 as costprice,0 as totqty,0 as stki  from my_main m left join my_dept dt on "+
		" m.deptid=dt.doc_no left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on "+
		" m.brandid=bd.doc_no left join my_desc de on(de.psrno=m.doc_no)     left join my_descpr pr on pr.psrno=m.doc_no and "+
		" (pr.catid='"+clientcatid+"' or (now() between ofrfrmdate and  ofrtodate and m.ofrcatid=pr.catid  and pr.catid='"+clientcatid+"')) "+
		" "+joinsql+"  inner join my_prddin i on(i.psrno=m.psrno and  i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid="+brchid+" ) where m.status=3  and  i.brhid="+brchid+" and i.locid="+locid+" and  i.date<=curdate() group by i.prdid having  sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by  i.prdid,i.date,i.stockid  ";   
		System.out.println("productfetchappqry===="+strSql);
		ResultSet rs = stmt.executeQuery(strSql);      
		
		String prdid="";
		String prdname="",taxper="",unit="",brand="",psrno="",specid="",unitdoc="",uprice="",taxdoc="";
		while(rs.next()) {
			prdid+=rs.getString("part_no")+",";
			prdname+=rs.getString("productname")+",";         
			taxper+=rs.getString("taxper")+","; 
			unit+=rs.getString("unit")+",";
			brand+=rs.getString("barcode")+","; 
			psrno+=rs.getString("psrno")+","; 
			specid+=rs.getString("specid")+","; 
			unitdoc+=rs.getString("unitdocno")+","; 
			uprice+=rs.getString("unitprice")+","; 
			taxdoc+=rs.getString("taxdocno")+","; 
	  		} 
		
		//emp=emp.substring(0, emp.length()>0?emp.length()-1:0);   
		
		response.getWriter().write(prdid+"####"+prdname+"####"+taxper+"####"+unit+"####"+brand+"####"+psrno+"####"+specid+"####"+unitdoc+"####"+uprice+"####"+taxdoc);     
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
