<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	String rdocno=request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
	//System.out.println("rdocno"+rdocno);
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String strSql = "select intro1, intro2, intro3, intro4, rep, norep, coalesce(numofitem,'') numofitem, shape1, shape2, shape3, shape4, dtype1, dtype2, dtype3, material1, material2, material3, coalesce(woodsel1,'') woodsel1, coalesce(woodsel2,'') woodsel2, coalesce(woodsel3,'') woodsel3, hardwr1, hardwr2, light, coalesce(ascode,'') ascode, drawer1, drawer2, bboard1, bboard2, bsboard1, bsboard2, layout1, layout2,bank from gl_enqquestclo where rdocno='"+rdocno+"'";
	   // System.out.println("strSql------"+strSql);
		ResultSet rs = stmt.executeQuery(strSql);
		String check="0",intro1="",intro2="",intro3="", intro4="", rep="", norep="", numofitem="", shape1="", shape2="", shape3="", shape4="", dtype1="", dtype2="", dtype3="", material1="", material2="", material3="", woodsel1="", woodsel2="", woodsel3="", hardwr1="", hardwr2="", light="", ascode="", drawer1="", drawer2="", bboard1="", bboard2="", bsboard1="", bsboard2="", layout1="", layout2="",cbank="";
		while(rs.next()) {
			check="1";
			intro1=rs.getString("intro1");
			intro2=rs.getString("intro2");
			intro3=rs.getString("intro3");
			intro4=rs.getString("intro4"); 
			rep=rs.getString("rep"); 
			norep=rs.getString("norep");
			numofitem=rs.getString("numofitem"); 
			shape1=rs.getString("shape1"); 
			shape2=rs.getString("shape2");
			shape3=rs.getString("shape3"); 
			shape4=rs.getString("shape4"); 
			dtype1=rs.getString("dtype1");
			dtype2=rs.getString("dtype2");
			dtype3=rs.getString("dtype3"); 
			material1=rs.getString("material1");
			material2 =rs.getString("material2");
			material3 =rs.getString("material3");  
			drawer1 =rs.getString("drawer1");
			drawer2=rs.getString("drawer2");
			woodsel1 =rs.getString("woodsel1");
			woodsel2 =rs.getString("woodsel2");
			woodsel3=rs.getString("woodsel3");
			hardwr1 =rs.getString("hardwr1");
			hardwr2=rs.getString("hardwr2");
			light=rs.getString("light");
			ascode=rs.getString("ascode");
			bboard1 =rs.getString("bboard1");
			bboard2=rs.getString("bboard2");
			bsboard1 =rs.getString("bsboard1");
			bsboard2 =rs.getString("bsboard2");
			layout1 =rs.getString("layout1");
			layout2=rs.getString("layout2");
			cbank=rs.getString("bank");
			} 
		//System.out.println("hardwr1==="+hardwr1);
		response.getWriter().write(intro1+"####"+intro2+"####"+intro3+"####"+intro4+"####"+rep+"####"+norep+"####"+numofitem+"####"+shape1+"####"+shape2+"####"+shape3+"####"+shape4+"####"+dtype1+"####"+dtype2+"####"+dtype3+"####"+material1+"####"+material2+"####"+material3+"####"+woodsel1+"####"+woodsel2+"####"+woodsel3+"####"+hardwr1+"####"+hardwr2+"####"+light+"####"+ascode+"####"+drawer1+"####"+drawer2+"####"+bboard1+"####"+bboard2+"####"+bsboard1+"####"+bsboard2+"####"+layout1+"####"+layout2+"####"+cbank+"####"+check);
		stmt.close();
		conn.close(); 
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  