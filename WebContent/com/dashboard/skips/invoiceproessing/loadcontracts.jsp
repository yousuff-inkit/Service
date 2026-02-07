<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<%@page import="com.dashboard.skips.invoiceproessing.ClsInvoiceProcessingDAO" %>  
<%
	Connection conn = null;
    int val=0,val1=0; 
    String date=request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");
	try{
		ClsConnection connDAO = new ClsConnection(); 
		ClsInvoiceProcessingDAO INVDAO = new ClsInvoiceProcessingDAO();
		conn = connDAO.getMyConnection();
		conn.setAutoCommit(false);  
		ClsCommon cmn=new ClsCommon();
		Statement stmt = conn.createStatement(); 
		Statement stmt1 = conn.createStatement(); 
		Statement stmt2 = conn.createStatement(); 
		Statement stmt3 = conn.createStatement(); 
		java.sql.Date sqltodate = null;
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))) {
	       sqltodate=cmn.changeStringtoSqlDate(date);
	     } else{}
	 	//System.out.println("IN");
	 	String srno="0",startdt="",enddt="",serviceterm="",scheduledays="",tipping="",month="", year="", contractno="", contdetno="", totsrno="",wasteid="", skipsizeid="", wastetype="" , dno="", ddate="",contno="",cbrhid="";
	 	Double rate=0.0,total=0.0;
	 	int executedtrips=0,days=0,trips=0,advinvmethod=0,noofvisit=0;       
	 	String sql1="select cm.advinvmethod,d.srno,d.scheduledays,d.nos,r.name,8 days,if(month(startdt)=month('"+sqltodate+"') and year(startdt)=year('"+sqltodate+"'),date_format(startdt,'%d.%m.%Y'),date_format('"+sqltodate+"','01.%m.%Y')) startdt,date_format(last_day('"+sqltodate+"'),'%d.%m.%Y')  enddt,cm.brhid,round(coalesce(disposalfee,0),2) rate,month('"+sqltodate+"') month,year('"+sqltodate+"') year,cm.tr_no contractno,d.rowno contdetno, d.wastetype, d.skiptype from sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join sk_tippingtariff tt on tt.wastetypeid=d.wastetype and tt.skipsizeid=d.skiptype left join sk_enqrelated r on r.srno=d.servicetermid and r.type='SCHEDULE' where d.ctypeid=1 and cm.status=3 and '"+sqltodate+"' between startdt and enddt group by cm.tr_no";
	 	//System.out.println("sql1--->>>"+sql1);                   
		ResultSet rs1= stmt.executeQuery(sql1);  
		while(rs1.next()){  
			 startdt=rs1.getString("startdt");
			 enddt=rs1.getString("enddt");
			 noofvisit=rs1.getInt("nos");  
			 serviceterm=rs1.getString("name");
			 scheduledays=rs1.getString("scheduledays");
			 days=rs1.getInt("days");
			 srno=rs1.getString("srno");  
			 advinvmethod=rs1.getInt("advinvmethod");  
			 contractno= rs1.getString("contractno");
			 contdetno= rs1.getString("contdetno");
			 month= rs1.getString("month");
			 year= rs1.getString("year");
			 cbrhid= rs1.getString("brhid");   
			 total= rs1.getDouble("rate");               
			 trips=INVDAO.getTotalTrips(startdt, enddt, noofvisit+"", serviceterm, days, contdetno, cbrhid, srno, scheduledays)*noofvisit;  
			 
			 int tripsrno=0,totaltrips=0,chargeabletrips=0;   
			 String sql22="select srno,tottrips,executedtrip from sk_triptotal where year='"+year+"' and month='"+month+"' and contractno='"+contractno+"' and contdetno='"+contdetno+"'";      
		 	 //System.out.println("sql22--->>>"+sql22);    
			 ResultSet rs22= stmt1.executeQuery(sql22);  
			 while(rs22.next()){
				 tripsrno=rs22.getInt("srno");
				 executedtrips=rs22.getInt("executedtrip");
			 }
			 if(tripsrno>0){
				 if(trips>=executedtrips){      
					 chargeabletrips=trips;  
				 }
				 if(trips<executedtrips){ 
					 chargeabletrips=executedtrips;    
				 }
				 String sql3="update sk_triptotal set tottrips='"+trips+"', chargedtrip='"+chargeabletrips+"', tiptotal="+total+" where srno='"+tripsrno+"' and manual=0";          
			 	  //System.out.println(advinvmethod+"==sql3--->>>"+sql3);        
				 val= stmt2.executeUpdate(sql3); 
				 if(advinvmethod==1){  
					 String sql4="update sk_triptotal set invoicetrip='"+trips+"', tippinginvoiced='"+trips+"', gateinvoiced='"+trips+"' where srno='"+tripsrno+"' and manual=0";                 
				 	 //System.out.println("sql4--->>>"+sql4);   
					 stmt2.executeUpdate(sql4);
				 }else{
					 String sql4="update sk_triptotal set invoicetrip=0, tippinginvoiced=0, gateinvoiced=0 where srno='"+tripsrno+"' and manual=0";                 
				 	 //System.out.println("sql4--->>>"+sql4);   
					 stmt2.executeUpdate(sql4);
				 }
				 totsrno=tripsrno+"";    
			 }else{
				 String sql2="select coalesce(max(srno)+1,1) srno from sk_triptotal";   
			 	 //System.out.println("sql2--->>>"+sql2);    
				 ResultSet rs2= stmt1.executeQuery(sql2);  
				 while(rs2.next()){
					 totsrno=rs2.getString("srno");  
				 }
				 
				 String sql3="insert into sk_triptotal(srno, month, year, contractno, contdetno, tottrips, executedtrip, chargedtrip, tiptotal) values('"+totsrno+"', '"+month+"', '"+year+"', '"+contractno+"', '"+contdetno+"', '"+trips+"', 0, '"+trips+"', "+total+")";      
			 	 //System.out.println("sql3--->>>"+sql3);    
				 val= stmt2.executeUpdate(sql3); 
				 
				 if(advinvmethod==1){  
					 String sql4="update sk_triptotal set invoicetrip='"+trips+"', tippinginvoiced='"+trips+"', gateinvoiced='"+trips+"' where srno='"+totsrno+"' and manual=0";                 
				 	 //System.out.println("sql4--->>>"+sql4);    
					 stmt2.executeUpdate(sql4);
				 }else{
					 String sql4="update sk_triptotal set invoicetrip=0, tippinginvoiced=0, gateinvoiced=0 where srno='"+tripsrno+"' and manual=0";                 
				 	 //System.out.println("sql4--->>>"+sql4);   
					 stmt2.executeUpdate(sql4);
				 }
			 }
			 if(val>0){
				 val1=1; 
			 }
		 }
		if(val>0){  
			conn.commit();  
		}
		response.getWriter().print(val1);     
	 	conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
