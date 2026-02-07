<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;  
    String manualdate=request.getParameter("manualdate")==null || request.getParameter("manualdate")==""?"0":request.getParameter("manualdate"); 
    String contrno=request.getParameter("contrno")==null || request.getParameter("contrno")==""?"0":request.getParameter("contrno");
    String dodate=request.getParameter("dodate")==null || request.getParameter("dodate")==""?"0":request.getParameter("dodate");
    String dno=request.getParameter("dno")==null || request.getParameter("dno")==""?"0":request.getParameter("dno");
    String wastetype=request.getParameter("wastetype")==null || request.getParameter("wastetype")==""?"":request.getParameter("wastetype");
    String qty=request.getParameter("qty")==null || request.getParameter("qty")==""?"0":request.getParameter("qty");
    String tipping=request.getParameter("tipping")==null || request.getParameter("tipping")==""?"":request.getParameter("tipping");
    String weight=request.getParameter("weight")==null || request.getParameter("weight")==""?"0":request.getParameter("weight");
    String price=request.getParameter("price")==null || request.getParameter("price")==""?"0":request.getParameter("price");      
    int val=0;  
	try{
		ClsConnection connDAO = new ClsConnection();       
		conn = connDAO.getMyConnection();
		ClsCommon cmn=new ClsCommon();
		Statement stmt = conn.createStatement(); 
		Statement stmt1 = conn.createStatement(); 
		Statement stmt2 = conn.createStatement(); 
		Statement stmt3 = conn.createStatement(); 
		java.sql.Date sqlmanualdate = null;
		java.sql.Date sqldodate = null;
	    if(!(manualdate.equalsIgnoreCase("undefined"))&&!(manualdate.equalsIgnoreCase(""))&&!(manualdate.equalsIgnoreCase("0"))) {
	    	sqlmanualdate=cmn.changeStringtoSqlDate(manualdate);
	     } else{}
	    if(!(dodate.equalsIgnoreCase("undefined"))&&!(dodate.equalsIgnoreCase(""))&&!(dodate.equalsIgnoreCase("0"))) {
	    	sqldodate=cmn.changeStringtoSqlDate(dodate);   
	     } else{}
	 	 //System.out.println("IN");
	 	 String month="", year="", contractno="", contdetno="",  totsrno="",wasteid="", skipsizeid="",cbrhid="",trips="",contno="";
	 	 Double rate=0.0,total=0.0;
	 	 int executedtrips=0;
	 	String sql1="select a.*,round(coalesce(sum(disposalfee),0),2) rate, coalesce(dm.wastetypeid,0) wastetypeid,month('"+sqldodate+"') month,year('"+sqldodate+"') year from(select '"+wastetype+"' wastetype,cm.doc_no contno,cm.brhid,cm.tr_no contractno,d.rowno contdetno,st.name skipsize,coalesce(st.doc_no,0) skipsizeid from sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join sk_skiptype st on st.doc_no=d.skiptype where cm.tr_no='"+contrno+"')a left join sk_dumptypedet dm on dm.wastename=CONVERT(a.wastetype USING utf8) left join sk_tippingtariff tt on tt.wastetypeid=dm.wastetypeid and tt.skipsizeid=a.skipsizeid group by a.contractno ";
	 	//System.out.println("sql1--->>>"+sql1);              
		 ResultSet rs1= stmt.executeQuery(sql1);  
		 while(rs1.next()){
			 month= rs1.getString("month");
			 year= rs1.getString("year");
			 contractno= rs1.getString("contractno");
			 contdetno= rs1.getString("contdetno");
			 trips= qty;
			 executedtrips= Integer.parseInt(qty);     
			 contno= rs1.getString("contno");
			 cbrhid= rs1.getString("brhid"); 
			 total= rs1.getDouble("rate"); 
			 wasteid= rs1.getString("wastetypeid");     
			 skipsizeid= rs1.getString("skipsizeid"); 
			 
			 int tripsrno=0,totaltrips=0,chargeabletrips=0;   
			 String sql22="select srno,tottrips from sk_triptotal where year='"+year+"' and month='"+month+"' and contractno='"+contractno+"' and contdetno='"+contdetno+"'";      
		 	 //System.out.println("sql22--->>>"+sql22);    
			 ResultSet rs22= stmt1.executeQuery(sql22);  
			 while(rs22.next()){
				 tripsrno=rs22.getInt("srno");
				 totaltrips=rs22.getInt("tottrips");
			 }
			 if(tripsrno>0){
				 if(totaltrips>executedtrips){ 
					 chargeabletrips=totaltrips;
				 }
				 if(totaltrips<executedtrips){ 
					 chargeabletrips=executedtrips;    
				 }
				 String sql3="update sk_triptotal set executedtrip='"+executedtrips+"', chargedtrip='"+chargeabletrips+"' where srno='"+tripsrno+"'";        
			 	 //System.out.println("sql3--->>>"+sql3);    
				 val= stmt2.executeUpdate(sql3); 
				 if(val>0){ 
					 if(tipping.equalsIgnoreCase("YES")){      
						 String sql4="insert into sk_tippingdet(contno, contdet, wasteid, skipsizeid, qty, TOTSRNO, wastetype, dno, ddate, rate, weight, price) values('"+contractno+"', '"+contdetno+"', '"+wasteid+"', '"+skipsizeid+"', '"+trips+"', '"+tripsrno+"', '"+wastetype+"', '"+dno+"', '"+sqldodate+"', "+total+", "+weight+", "+price+")";     
					 	 //System.out.println("sql4--->>>"+sql4);    
						 val= stmt2.executeUpdate(sql4);  
					 }
				 }
			 }else{  
				 String sql2="select coalesce(max(srno)+1,1) srno from sk_triptotal";   
			 	 //System.out.println("sql2--->>>"+sql2);    
				 ResultSet rs2= stmt1.executeQuery(sql2);  
				 while(rs2.next()){
					 totsrno=rs2.getString("srno");  
				 }
				 
				 String sql3="insert into sk_triptotal(srno, month, year, contractno, contdetno, tottrips, executedtrip, chargedtrip, tiptotal) values('"+totsrno+"', '"+month+"', '"+year+"', '"+contractno+"', '"+contdetno+"', '"+trips+"', '"+trips+"', '"+trips+"', "+total+")";      
			 	 //System.out.println("sql3--->>>"+sql3);    
				 val= stmt2.executeUpdate(sql3); 
				 if(val>0){ 
					 if(tipping.equalsIgnoreCase("YES")){      
						 String sql4="insert into sk_tippingdet(contno, contdet, wasteid, skipsizeid, qty, TOTSRNO, wastetype, dno, ddate, rate, weight, price) values('"+contractno+"', '"+contdetno+"', '"+wasteid+"', '"+skipsizeid+"', '"+trips+"', '"+totsrno+"', '"+wastetype+"', '"+dno+"', '"+sqldodate+"', "+total+", "+weight+", "+price+")";        
					 	 //System.out.println("sql4--->>>"+sql4);    
						 val= stmt2.executeUpdate(sql4);  
					 }
				 }
			 }
			 }
		response.getWriter().print(val);   
	 	conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
