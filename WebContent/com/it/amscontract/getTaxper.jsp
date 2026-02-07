<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon"%>

<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;
	
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		java.sql.Date sqlDate=null;
		
		String date=request.getParameter("date");
		String cldocno=request.getParameter("cldocno");
		
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
        {
     	   sqlDate = ClsCommon.changeStringtoSqlDate(date);
        }
		
		String sql = "select method from gl_config where field_nme='tax'";
		ResultSet rsConfig = stmt.executeQuery(sql);
		
		int configTax=0;
		while(rsConfig.next()) {
			configTax=rsConfig.getInt("method");
		} 
		
		int cltax=0;
		String clsql="select nontax from my_acbook where cldocno='"+cldocno+"' and dtype='crm'";
	    ResultSet rscltax = stmt.executeQuery(clsql);  
	    while (rscltax.next()) {
			cltax=rscltax.getInt("nontax");
		}
	         
		String taxper="0";
		
		if(configTax==1 && cltax==1){
		
			String strSql = "select per from gl_taxmaster where status=3 and type=2 and per>0 and fromdate<='"+sqlDate+"' and todate>='"+sqlDate+"' limit 1";
			ResultSet rs = stmt.executeQuery(strSql);
		
			while(rs.next()) {
				taxper=rs.getString("per");
			} 
		
		}
		
		response.getWriter().write(taxper);
		
		stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  