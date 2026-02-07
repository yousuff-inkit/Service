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
System.out.println("on jsp getproduct");
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
	JSONArray RESULTDATA=new JSONArray();
	JSONArray prdarray=new JSONArray();
	JSONObject objprd=new JSONObject();
	//String rdoc="0";
	String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
	String locid=request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
	String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").trim();

	//String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();

	//String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
	//String clientid1=request.getParameter("clientid1")==null?"0":request.getParameter("clientid1").trim(); 

	//String cmbreftype=request.getParameter("cmbreftype")==null?"0":request.getParameter("cmbreftype").trim();

	String location=request.getParameter("location")==null?"0":request.getParameter("location").trim();

	//String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

	//String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();

	//String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();
	//System.out.println("prodsearchtype  : "+prodsearchtype+"rdoc : "+rdoc+"reftype : "+reftype+"cmbprice : "+cmbprice+"clientid : "+clientid+"clientid1 : "+clientid+"cmbreftype : "+cmbreftype+"location : "+location+"clientcaid : "+clientcaid);
try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement (); 
			String sql="", sqltest="";
			int method=0;
			
			if(((docno.equalsIgnoreCase(""))||(docno.equalsIgnoreCase("undefined")))){

				docno="0";
			}
			if(locid!=null && !locid.equalsIgnoreCase("") && !locid.equalsIgnoreCase("0")){
			    sqltest+=" and ma.locid='"+locid+"'";
			}
			/*String sqlcond1="";
			String sqlcond2="";
			String sqlselect="";*/

			/*String pdmsql = "SELECT srno FROM gl_bibd WHERE dtype='PDM' AND STATUS=1";
			String pdmname = "";
			String wpdm = "";
			ResultSet pdm = stmt.executeQuery(pdmsql);
			if(pdm.next())
			{
			    pdmname = "CASE WHEN (pdm.clpartno IS NOT NULL AND pdm.clpartno<>0) THEN pdm.clpartno ELSE m.part_no END AS part_no ,CASE WHEN pdm.clproductname IS NOT NULL THEN pdm.clproductname ELSE m.`ProductName` END AS productname" ;
			    wpdm = " LEFT JOIN (SELECT psrno, clproductname, clpartno, clientid FROM my_prddata) pdm ON ma.`cldocno`= pdm.clientid  AND m.`psrno`= pdm.psrno";
			    
			} else {
			    pdmname = "m.part_no ,m.productname";
			}*/


			/*	sql="select  stkid,specid,psrno as doc_no,rdocno,psrno,qty as totqty,(qty-outqty) qty,outqty,(qty-outqty) as balqty,0 size,part_no,productid,productname,unit,unitdocno, unitprice from "
						+ "( select i.stockid as stkid,at.mspecno as specid,d.rdocno,m.doc_no psrno,d.qty as qty,d.out_qty as outqty,m.part_no,m.part_no productid,m.productname,u.unit,u.doc_no unitdocno,i.cost_price as unitprice from "
						+ "my_invm ma left join my_invd d on(ma.doc_no=d.rdocno) left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
						+ "inner join my_prddin i on(i.psrno=d.psrno and i.prdid=d.prdid and i.specno=d.specno and ma.brhid=i.brhid) where ma.status=3 and d.rdocno in("+rdoc+") and ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' group by d.stockid having sum((d.qty)-(d.out_qty))>0 order by d.prdid,i.date ) as a ";*/
	/*			sql=" select bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty-out_qty) totqty,"
					+ " sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,part_no,m.part_no "
				    + "	productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
				    + "	 KGPrice kgprice,d.amount unitprice,((d.qty-d.out_qty)*d.amount) total,d.disper discper, "
					+ " (sum(d.qty-d.out_qty)*d.amount*d.disper)/100 dis, "
					+ " ((sum(d.qty-d.out_qty)*d.amount)-(sum(d.qty-d.out_qty)*d.amount*d.disper)/100) netotal "
					+ "  from my_invm ma left join my_invd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) "
					+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
					+ "  where m.status=3 and d.rdocno in("+rdoc+") and   ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' and ma.locid='"+locaid+"' group by d.stockid "
					+ "  having sum(d.qty-d.out_qty)>0  order by d.prdid,d.stockid ";

*/
sql=" select ma.billtype,ma.vatype,d.nettotal netsss,d.taxamount taxperamt,d.taxper,sum(d.foc)-sum(d.out_foc) foc,sum(d.foc)-sum(d.out_foc) balfoc,d.doc_no detdocno, d.rdocno,bd.brandname,d.stockid stkid,d.specno as specid,d.psrno as doc_no,rdocno,d.psrno,d.psrno as prodoc,sum(qty-out_qty) totqty,"
		+ " sum(out_qty) as oldqty,sum(qty-out_qty) qty,sum(out_qty) outqty,sum(qty-out_qty) as balqty,part_no,m.part_no "
	    + "	productid,m.part_no as proid,m.productname,m.productname as proname,unit,u.doc_no unitdocno,NtWtKG totwtkg, "
	    + "	 KGPrice kgprice,d.amount unitprice,((d.qty-d.out_qty)*d.amount) total,d.disper discper, "
		+ " if(d.out_qty=0,d.discount, (d.discount/d.qty)*(d.qty-d.out_qty)) dis, "
		+ " d.nettaxamount fintot "
		+ "  from my_invm ma left join my_invd d on(ma.doc_no=d.rdocno)  left join my_main m on(d.psrno=m.doc_no) left join  my_unitm u on(d.unitid=u.doc_no) left join  my_brand bd on m.brandid=bd.doc_no "
		+ "  left join my_prodattrib at on(at.mpsrno=m.doc_no) where m.status=3 and d.rdocno in("+docno+") and "
				+ "  ma.brhid='"+session.getAttribute("BRANCHID").toString()+"' "+sqltest+" group by d.rdocno,d.prdid,d.unitid,d.specno  "
		+ "  having sum(d.qty-d.out_qty)>0  order by d.rdocno,d.prdid ";			
		System.out.println("----searchProduct-sql---"+sql);

			ResultSet resultSet = stmt.executeQuery (sql);
			//RESULTDATA=ClsCommon.convertToJSON(resultSet);
			while(resultSet.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("taxper", resultSet.getString("taxper"));
				objsub.put("foc", resultSet.getString("foc"));
				objsub.put("balfoc", resultSet.getString("balfoc"));
				objsub.put("rdocno", resultSet.getString("rdocno"));
				objsub.put("brandname", resultSet.getString("brandname"));
				objsub.put("stkid", resultSet.getString("stkid"));
				objsub.put("specid", resultSet.getString("specid"));
				objsub.put("doc_no", resultSet.getString("doc_no"));
				objsub.put("detdocno", resultSet.getString("detdocno"));
				objsub.put("psrno", resultSet.getString("psrno"));
				objsub.put("prodoc", resultSet.getString("prodoc"));
				objsub.put("totqty", resultSet.getString("totqty"));
				objsub.put("oldqty", resultSet.getString("oldqty"));
				objsub.put("qty", resultSet.getString("qty"));
				objsub.put("outqty", resultSet.getString("outqty"));
				objsub.put("balqty", resultSet.getString("balqty"));
				objsub.put("productid", resultSet.getString("productid"));
				objsub.put("proid", resultSet.getString("proid"));
				objsub.put("productname", resultSet.getString("productname"));
				objsub.put("proname", resultSet.getString("proname"));
				objsub.put("unit", resultSet.getString("unit"));
				objsub.put("unitdocno", resultSet.getString("unitdocno"));
				objsub.put("totwtkg", resultSet.getString("totwtkg"));
				objsub.put("kgprice", resultSet.getString("kgprice"));
				objsub.put("unitprice", resultSet.getString("unitprice"));
				objsub.put("total", resultSet.getString("total"));
				objsub.put("discper", resultSet.getString("discper"));
				objsub.put("dis", resultSet.getString("dis"));
				objsub.put("netotal", resultSet.getString("netsss"));
				objsub.put("part_no", resultSet.getString("part_no"));
				//objsub.put("colbatch", resultSet.getString("colbatch"));
				objsub.put("taxamt", resultSet.getString("taxperamt"));
				objsub.put("finaltotamt", resultSet.getString("fintot"));
				objsub.put("billtype", resultSet.getString("billtype"));
				objsub.put("vattype", resultSet.getString("vatype"));
				prdarray.add(objsub);

				
			}
			objprd.put("pddata", prdarray);
			System.out.println("test : ");

			System.out.println("Json data : "+objprd);
			response.getWriter().print(objprd);

			stmt.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
%>