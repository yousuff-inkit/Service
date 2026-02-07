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
		JSONArray prdarray=new JSONArray();
		JSONObject objprd=new JSONObject(); 
	
		String productid="";
		String productname="";
			
				Statement stmt3111 = conn.createStatement (); 
				 
			
				 
			String sqlss="select m.doc_no doc_no,bd.brandname,at.mspecno as specid,m.part_no productid,m.productname productname,m.doc_no,u.unit,m.munit as unitid,m.psrno,(i.out_qty) outqty,round((i.op_qty-(i.out_qty+i.del_qty+i.rsv_qty)),0) as balqty,(i.op_qty) as totqty,i.stockid as stkid,i.cost_price unitprice from my_main m left join my_unitm u on m.munit=u.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no inner join my_prddin i on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno)";	
			// System.out.println("----searchProduct-sqlsss---"+sqlss);
		     ResultSet rss = stmt.executeQuery(sqlss);      
		   
		     String prdid="";
				while(rss.next()) {
					JSONObject objsub=new JSONObject();
					objsub.put("part_no", rss.getString("productid"));
					objsub.put("productname", rss.getString("productname"));
					objsub.put("psrno", rss.getString("psrno"));
					objsub.put("unit", rss.getString("unit"));
					objsub.put("unitid", rss.getString("unitid"));
					objsub.put("balqty", rss.getString("balqty"));
					objsub.put("doc_no", rss.getString("doc_no"));
					
					prdarray.add(objsub);
					
		  		} 
			objprd.put("pddata", prdarray);
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
  
