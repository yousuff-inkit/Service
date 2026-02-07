<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="webapp.ClsWebAppDAO"%>    
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%> 
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	JSONObject objsor=new JSONObject(); 
	JSONObject objdel=new JSONObject(); 
	ClsWebAppDAO dao=new ClsWebAppDAO(); 
	 String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid");
	 String brhid = request.getParameter("brhid")==null?"0":request.getParameter("brhid"); 
	 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
	 String doc = request.getParameter("sordoc")==null?"0":request.getParameter("sordoc");
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		System.out.println("brhid==="+brhid);
		if(chk.equalsIgnoreCase("DEL")){
			 
			JSONArray delarray=dao.getDELData(doc, conn);
			objdel.put("deldata", delarray);
			response.getWriter().print(objdel);
		}
		   
		if(chk.equalsIgnoreCase("SOR")){
			 
			JSONArray sorarray=dao.getSORData(doc, conn);
			objsor.put("sordata", sorarray);
			response.getWriter().print(objsor);
		}
		if(chk.equalsIgnoreCase("SORDET")){
			String pySql=("select * from (select concat('Date-',m.date,' SOR-',m.voc_no,' Customer-',ac.refname)sordetails,sum(qty-d.out_qty) as qty,coalesce(ii.belqty,0) as bel,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname "
					+ " as client,0 as chk from my_sorderm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM')  "
					+ " left join my_sorderd d on(d.rdocno=m.doc_no) left join (select psrno,specno,prdid,brhid ,sum(op_qty)-(sum(out_qty+rsv_qty+del_qty)) belqty "
					+ "  from  my_prddin  where 1=1 group by  psrno) ii on (ii.psrno=d.psrno and ii.specno=d.specno and ii.prdid=d.prdid and ii.brhid=m.brhid)  "
					+ "  where d.clstatus=0 and m.status=3 and m.cldocno="+clientid+"  and m.brhid="+brhid+"     group by m.doc_no)  as a having  qty>0 ");
			System.out.println("sorfetch==="+pySql);
			ResultSet rs = stmt.executeQuery(pySql);      
			
			String emp="";
			String sordetails="",sordoc="",curid="",rate="",catid="";
			while(rs.next()) {
				sordetails+=rs.getString("sordetails")+",";
				sordoc+=rs.getString("doc_no")+",";         
			
		  		} 
			
			//emp=emp.substring(0, emp.length()>0?emp.length()-1:0);   
			
			response.getWriter().write(sordetails+"####"+sordoc);  
		}
		
		if(chk.equalsIgnoreCase("DELDET")){
			String pySql=("select * from (select concat('Date-',m.date,' DEL-',m.voc_no,' Customer-',ac.refname)deldetails,sum(qty-d.out_qty) as qty,m.doc_no,m.rrefno as refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_delm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join my_deld d on(d.rdocno=m.doc_no)  where m.status=3 and m.cldocno="+clientid+"  and m.brhid="+brhid+"  group by m.doc_no) as a having qty>0" );
			System.out.println("delfetch==="+pySql);
			ResultSet rs = stmt.executeQuery(pySql);      
			
			String emp="";
			String deldetails="",deldoc="",curid="",rate="",catid="";
			while(rs.next()) {
				deldetails+=rs.getString("deldetails")+",";
				deldoc+=rs.getString("doc_no")+",";         
			
		  		} 
			
			//emp=emp.substring(0, emp.length()>0?emp.length()-1:0);   
			
			response.getWriter().write(deldetails+"####"+deldoc);  
		}
	
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
