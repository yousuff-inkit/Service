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
		Statement stmtVeh = conn.createStatement (); 
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		String id = request.getParameter("id")==null?"0":request.getParameter("id");
		JSONArray prdarray=new JSONArray();
		JSONObject objprd=new JSONObject(); 
		String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
		String date=request.getParameter("date")==null?"0":request.getParameter("date");
		int method=0;
		
		String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
		ResultSet rs=stmtVeh.executeQuery(chk); 
		if(rs.next())
		{
			
			method=rs.getInt("method");
		}
		

		java.sql.Date sqlStartDate=null;


		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
		}
		String condtn="";
		
		
		if(locid.equalsIgnoreCase("")){
			String brhid=session.getAttribute("BRANCHID").toString();
			String tst="select doc_no from my_locm  where brhid="+brhid+" limit 1";
			ResultSet rsp = stmtVeh.executeQuery (tst);
			if(rsp.next()){
				locid=rsp.getString("doc_no");
			}
		}
		
		/*String	sql="select   bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
				+ "sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qutval,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,"
				+ " sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty))*i.cost_price savecost_price,i.cost_price from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no"
				+ "  left join my_catm c on c.doc_no=m.catid "
						   + "left join my_scatm sc on m.scatid=sc.doc_no inner join my_prddin i "
				+ "on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' )    "
				+ "where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+locid+"' and i.date<='"+sqlStartDate+"'  "+condtn+" "
				+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date "; 	
*/			
		
		/*Removed 'and i.specno=at.mspecno' this connection from inner join of above query for not loading sr1654*/
		
		String	sql="select   bd.brandname,at.mspecno as specid,m.part_no,m.productname,m.doc_no,u.unit,m.munit as unitdocno,m.psrno,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qty,"
				+ "sum(i.out_qty) outqty,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) qutval,sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)) as balqty,sum(i.op_qty) as totqty,i.stockid as stkid,"
				+ " sum(i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty))*i.cost_price savecost_price,i.cost_price from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no"
				+ "  left join my_catm c on c.doc_no=m.catid "
						   + "left join my_scatm sc on m.scatid=sc.doc_no inner join my_prddin i "
				+ "on(i.specno=at.mspecno and i.psrno=m.psrno and i.prdid=m.doc_no  and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' )    "
				+ "where m.status=3 and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' and  i.locid='"+locid+"' and i.date<='"+sqlStartDate+"'  "+condtn+" "
				+ "group by i.prdid having sum(op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 order by i.prdid,i.date "; 	

 	System.out.println("----searchProduct-sql---"+sql);
		ResultSet rss = stmt.executeQuery(sql);      
		
		
		String prdid="";
		String dmbrand="",prdname="",taxper="",unit="",brand="",psrno="",specid="",unitdoc="",uprice="",taxdoc="",catname="",scatname="",sprice="";
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
  
