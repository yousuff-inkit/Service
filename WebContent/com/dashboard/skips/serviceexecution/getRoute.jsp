<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
    ClsConnection ClsConnection=new ClsConnection();  
	Connection conn = null;
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql="select sm.sal_name driver,h1.sal_name helper1,h2.sal_name helper2,v.reg_no,r.code,r.name,g.gname ,s.name site,dt.name wastetype,r.doc_no from sk_route r left join gl_vehgroup g on r.grpid=g.doc_no left join sk_dumpsite s on s.doc_no=r.dumpsiteid left join sk_dumptype dt on dt.doc_no=s.typeid left join my_salesman sm on sm.doc_no=r.driverid and sm.sal_type='DRV' left join my_salesman h1 on h1.doc_no=r.helper and h1.sal_type='HLR' left join my_salesman h2 on h2.doc_no=r.helper2 and h2.sal_type='HLR' left join gl_vehmaster v on v.fleet_no=r.fleetno where r.status<>7";
		ResultSet rs = stmt.executeQuery(strSql);
		String pro="",sr="";
		while(rs.next()) {
					pro+=rs.getString("name")+",";  
					sr+=rs.getString("doc_no")+",";
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
  