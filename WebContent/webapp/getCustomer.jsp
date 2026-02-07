<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select a.acno,sa.doc_no saldocno,h.curid,c.code currency,round(cb.rate,2) rate,sa.sal_name,a.catid,cl.cat_name,cl.pricegroup,a.per_tel pertel,a.cldocno,a.refname,trim(a.address) address,a.per_mob,trim(a.mail1) mail1  "
				+ "  from my_acbook a left join my_clcatm cl on cl.doc_no=a.catid  left join my_head h on h.doc_no=a.acno left join my_curr c on h.curid=c.doc_no left join my_curbook cb on h.curid=cb.curid   left join my_salm sa on sa.doc_no=a.sal_id  and a.dtype='CRM' where  a.dtype='CRM'  ";   
		ResultSet rs = stmt.executeQuery(strSql);      
		
		String emp="";
		String empid="",costperhr="",curid="",rate="",catid="",acno="";
		while(rs.next()) {
			emp+=rs.getString("refname")+",";
			empid+=rs.getString("cldocno")+",";         
			curid+=rs.getString("curid")+","; 
			rate+=rs.getString("rate")+","; 
			catid+=rs.getString("catid")+","; 
			acno+=rs.getString("acno")+","; 
	  		} 
		
		emp=emp.substring(0, emp.length()>0?emp.length()-1:0);   
		
		response.getWriter().write(emp+"####"+empid+"####"+curid+"####"+rate+"####"+catid+"####"+acno);     
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
