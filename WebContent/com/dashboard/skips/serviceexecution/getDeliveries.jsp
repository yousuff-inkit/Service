<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
ClsConnection ClsConnection=new ClsConnection();  

	Connection conn = null;
	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
 	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno").trim()==""?"0":request.getParameter("contrno").trim();
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		//Changed query to meet revision scheduling case also
		//String strSql = "select 'All' slno from sk_srvcontrdel dl left join sk_srvcontrsch sc on sc.delid=dl.doc_no where dl.rdocno='"+contrno+"' and dl.srno='"+srno+"' and sc.doc_no is null group by dl.rdocno union all select dl.slno from sk_srvcontrdel dl left join sk_srvcontrsch sc on sc.delid=dl.doc_no where dl.rdocno='"+contrno+"' and dl.srno='"+srno+"' and sc.doc_no is null";
		String strSql = "select 'All' slno from sk_srvcontrm m left join sk_srvcontrdel dl on dl.rdocno=m.tr_no left join sk_srvcontrsch sc on sc.delid=dl.doc_no left join (select max(date) schdate, rdocno, srno from sk_srvcontrsch sch group by rdocno,srno) sch on sch.rdocno=m.tr_no and sch.srno=dl.srno where dl.rdocno='"+contrno+"' and dl.srno='"+srno+"' and (sc.doc_no is null or (sc.date is not null and m.enddt>sc.date)) group by dl.rdocno union all select dl.slno from sk_srvcontrm m left join sk_srvcontrdel dl on dl.rdocno=m.tr_no left join sk_srvcontrsch sc on sc.delid=dl.doc_no left join (select max(date) schdate, rdocno, srno from sk_srvcontrsch sch group by rdocno,srno) sch on sch.rdocno=m.tr_no and sch.srno=dl.srno where dl.rdocno='"+contrno+"' and dl.srno='"+srno+"' and (sc.doc_no is null or (sc.date is not null and m.enddt>sc.date)) group by dl.slno"; 
		System.out.println("strSql="+strSql);        
		ResultSet rs = stmt.executeQuery(strSql);  
		String pro="",sr="";
		while(rs.next()) {
					pro+=rs.getString("slno")+",";  
					sr+=rs.getString("slno")+",";    
		} 
		if(!pro.equalsIgnoreCase("")){  
			String procc[]=pro.split(",");
			String brnId[]=sr.split(",");
			
			pro=pro.substring(0, pro.length()-1);
			sr=sr.substring(0, sr.length()-1);
		}  
		response.getWriter().write(sr+"####"+pro);
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  