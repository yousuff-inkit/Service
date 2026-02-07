<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*"%>
<%
	String totalitemcount=session.getAttribute("TOTALITEMCOUNT")==null?"0":session.getAttribute("TOTALITEMCOUNT").toString();
	String itemcurrentdocno=session.getAttribute("ITEMCURRENTDOCNO")==null?"0":session.getAttribute("ITEMCURRENTDOCNO").toString();
	String finalcount=request.getParameter("finalcount")==null?"0":request.getParameter("finalcount");
	JSONObject objdata=new JSONObject();
	Connection conn=null;
	int itemcount=0;
	try{
		ClsConnection objconn=new ClsConnection();	
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		//System.out.println("Item Current Doc No:"+itemcurrentdocno);
		if(!totalitemcount.equalsIgnoreCase("0") && !itemcurrentdocno.equalsIgnoreCase("0")){
			String strsql="select count(*) itemcount from gl_nafith where rdocno="+itemcurrentdocno;
			// System.out.println(strsql);
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				itemcount=rs.getInt("itemcount");
			}				
		}
		
		objdata.put("itemcurrentdocno",itemcurrentdocno);
		if(finalcount.trim().equalsIgnoreCase("1")){
			objdata.put("totalitemcount",itemcount);	
		}
		else{
			objdata.put("totalitemcount",totalitemcount);
		}
		
		objdata.put("itemcount",itemcount);
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}
	response.getWriter().write(objdata+"");
%>