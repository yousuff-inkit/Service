<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	String rdocno=request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").toString();
	System.out.println("rdocno"+rdocno);
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String strSql = "select intro1, intro2, intro3, intro4, exist1, exist2, coalesce(numofitem,'') numofitem, shape1, shape2, shape3, shape4, ctype1, ctype2, ctype3, coalesce(other,'') other, material1, material2, drawer1, drawer2, drawer3, sp1, sp2, ls1, ls2, cor1, cor2, kstyle1, kstyle2, interest1, interest2, interest3, interest4, coalesce(listitem,'') listitem, appl1, appl2, appl3, appl4, appl5, appl6, appl7, appl8, appl9, appl10, counter1, counter2, counter3, coalesce(fwtw,'') fwtw, coalesce(fwth,'') fwth, coalesce(fwtd,'') fwtd, coalesce(dwash,'') dwash, coalesce(cooks,'') cooks, coalesce(cookw,'') cookw, coalesce(mwaves,'') mwaves, coalesce(mwavew,'') mwavew, coalesce(mwaveh,'') mwaveh, coalesce(mwaveftr,'') mwaveftr, coalesce(mwavedet,'') mwavedet, coalesce(sinks,'') sinks, coalesce(sinkw,'') sinkw, coalesce(brand,'') brand, coalesce(applncs,'') applncs, coalesce(applncss,'') applncss, layout1, layout2,bank from gl_enqquestkit where rdocno='"+rdocno+"'";
		System.out.println("strSql------"+strSql);
		//System.out.println("rdocno------"+rdocno);
		ResultSet rs = stmt.executeQuery(strSql);
		
		String check="0",intro1="",intro2="",intro3="", intro4="", exist1="", exist2="", numofitem="", shape1="", shape2="", shape3="", shape4="", ctype1="", ctype2="", ctype3="", other="", material1="", material2="", drawer1="", drawer2="", drawer3="", sp1="", sp2="", ls1="", ls2="", cor1="", cor2="", kstyle1="", kstyle2="", interest1="", interest2="", interest3="", interest4="", listitem="", appl1="", appl2="", appl3="", appl4="", appl5="", appl6="", appl7="", appl8="", appl9="", appl10="", counter1="", counter2="", counter3="", fwtw="", fwth="", fwtd="", dwash="", cooks="", cookw="", mwaves="", mwavew="", mwaveh="", mwaveftr="", mwavedet="", sinks="", sinkw="", brand="", applncs="", applncss="", layout1="", layout2="",bank="";
		while(rs.next()) {
			check="1";
			intro1=rs.getString("intro1");
			intro2=rs.getString("intro2");
			 intro3=rs.getString("intro3");
			intro4=rs.getString("intro4"); 
			exist1=rs.getString("exist1"); 
			exist2=rs.getString("exist2");
			numofitem=rs.getString("numofitem"); 
			shape1=rs.getString("shape1"); 
			shape2=rs.getString("shape2");
			shape3=rs.getString("shape3"); 
			shape4=rs.getString("shape4"); 
			ctype1=rs.getString("ctype1");
			ctype2=rs.getString("ctype2");
			ctype3=rs.getString("ctype3"); 
			other=rs.getString("other");
			material1=rs.getString("material1");
			material2 =rs.getString("material2");
			drawer1 =rs.getString("drawer1");
			drawer2=rs.getString("drawer2");
			drawer3 =rs.getString("drawer3");
			sp1 =rs.getString("sp1");
			sp2 =rs.getString("sp2");
			ls1=rs.getString("ls1");
			ls2 =rs.getString("ls2");
			cor1=rs.getString("cor1");
			cor2=rs.getString("cor2");
			kstyle1=rs.getString("kstyle1");
			kstyle2 =rs.getString("kstyle2");
			interest1=rs.getString("interest1");
			interest2 =rs.getString("interest2");
			interest3 =rs.getString("interest3");
			interest4 =rs.getString("interest4");
			listitem=rs.getString("listitem");
			appl1 =rs.getString("appl1");
			appl2=rs.getString("appl2");
			appl3=rs.getString("appl3");
			appl4 =rs.getString("appl4");
			appl5=rs.getString("appl5");
			appl6=rs.getString("appl6");
			appl7=rs.getString("appl7");
			appl8=rs.getString("appl8");
			appl9 =rs.getString("appl9");
			appl10 =rs.getString("appl10");
			counter1=rs.getString("counter1");
			counter2=rs.getString("counter2");
			counter3 =rs.getString("counter3");
			fwtw =rs.getString("fwtw");
			fwth =rs.getString("fwth");
			fwtd=rs.getString("fwtd");
			dwash=rs.getString("dwash");
			cooks=rs.getString("cooks");
			cookw=rs.getString("cookw");
			mwaves=rs.getString("mwaves");
			mwavew=rs.getString("mwavew");
			mwaveh=rs.getString("mwaveh");
			mwaveftr=rs.getString("mwaveftr");
			mwavedet =rs.getString("mwavedet");
			sinks=rs.getString("sinks");
			sinkw=rs.getString("sinkw");
			brand=rs.getString("brand");
			applncs=rs.getString("applncs");
			applncss=rs.getString("applncss");
			layout1 =rs.getString("layout1");
			layout2=rs.getString("layout2"); 
			bank=rs.getString("bank"); 
				} 
		
		response.getWriter().write(intro1+"####"+intro2+"####"+intro3+"####"+intro4+"####"+exist1+"####"+exist2+"####"+numofitem+"####"+shape1+"####"+shape2+"####"+shape3+"####"+shape4+"####"+ctype1+"####"+ctype2+"####"+ctype3+"####"+other+"####"+material1+"####"+material2+"####"+drawer1+"####"+drawer2+"####"+drawer3+"####"+sp1+"####"+sp2+"####"+ls1+"####"+ls2+"####"+cor1+"####"+cor2+"####"+kstyle1+"####"+kstyle2+"####"+interest1+"####"+interest2+"####"+interest3+"####"+interest4+"####"+listitem+"####"+appl1+"####"+appl2+"####"+appl3+"####"+appl4+"####"+appl5+"####"+appl6+"####"+appl7+"####"+appl8+"####"+appl9+"####"+appl10+"####"+counter1+"####"+counter2+"####"+counter3+"####"+fwtw+"####"+fwth+"####"+fwtd+"####"+dwash+"####"+cooks+"####"+cookw+"####"+mwaves+"####"+mwavew+"####"+mwaveh+"####"+mwaveftr+"####"+mwavedet+"####"+sinks+"####"+sinkw+"####"+brand+"####"+applncs+"####"+applncss+"####"+layout1+"####"+layout2+"####"+bank+"####"+check);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  