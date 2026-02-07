<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.dashboard.skips.invoiceproessingnew.ClsInvoiceProcessingDAO" %>  
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
	 	String delsql="delete t from sk_triptotal t inner join sk_srvcontrm m on t.contractno=m.tr_no inner join sk_srvcontrdet d on t.contractno=d.rdocno left join sk_tippingdet td on td.totsrno=t.srno where (m.billingmethod=3 or d.ctypeid=2) and manual=0 and td.totsrno is null";  
	 	stmt.executeUpdate(delsql);       
	 	
	 	String invdate="",srno="0",startdt="",enddt="",serviceterm="",scheduledays="",tipping="",month="", year="", contractno="", contdetno="", totsrno="",wasteid="", skipsizeid="", wastetype="" , dno="", ddate="",contno="",cbrhid="";
	 	Double rate=0.0,total=0.0;
	 	int executedtrips=0,days=0,trips=0,advinvmethod=0,noofvisit=0,datecompare=0,inctipfee=0, skipqty=0;       
	 	//String sql1="select cm.inctipfee,if(d.invdate>'"+sqltodate+"',1,0) datecompare,cm.advinvmethod,d.srno,d.scheduledays,d.nos,r.name,8 days,if(month(startdt)=month('"+sqltodate+"') and year(startdt)=year('"+sqltodate+"'),date_format(startdt,'%d.%m.%Y'),date_format('"+sqltodate+"','01.%m.%Y')) startdt,if(cm.status=10 and cm.closedate<=last_day('"+sqltodate+"'),date_format(cm.closedate,'%d.%m.%Y'),date_format(last_day('"+sqltodate+"'),'%d.%m.%Y'))  enddt,cm.brhid,round(coalesce(disposalfee,0),2) rate,month('"+sqltodate+"') month,year('"+sqltodate+"') year,cm.tr_no contractno,d.rowno contdetno, d.wastetype, d.skiptype from sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join sk_tippingtariff tt on tt.wastetypeid=d.wastetype and tt.skipsizeid=d.skiptype left join sk_enqrelated r on r.srno=d.servicetermid and r.type='SCHEDULE' where d.ctypeid=1 and cm.status not in (6,7,8) and cm.billingmethod!=3 and '"+sqltodate+"' between startdt and if(cm.status=10 and cm.closedate<=last_day('"+sqltodate+"'),cm.closedate,enddt) group by cm.tr_no";
	 	String sql1="select cm.inctipfee,if(d.invdate>'"+sqltodate+"',1,0) datecompare,cm.advinvmethod,d.srno,  coalesce(dd.skipatsiteqty,0) skipatsiteqty,d.scheduledays,d.nos,r.name,8 days,if(month(startdt)=month('"+sqltodate+"') and year(startdt)=year('"+sqltodate+"'),date_format(startdt,'%d.%m.%Y'),date_format('"+sqltodate+"','01.%m.%Y')) startdt,if(cm.status=10 and cm.closedate<=last_day('"+sqltodate+"'),date_format(cm.closedate,'%d.%m.%Y'),date_format(last_day('"+sqltodate+"'),'%d.%m.%Y'))  enddt,cm.brhid,round(coalesce(disposalfee,0),2) rate,month('"+sqltodate+"') month,year('"+sqltodate+"') year,cm.tr_no contractno,d.rowno contdetno, d.wastetype, d.skiptype from sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join (select count(*) skipatsiteqty, rdocno, srno from sk_srvcontrdel del where type='N' group by del.rdocno,del.srno) dd on dd.rdocno=cm.tr_no left join sk_tippingtariff tt on tt.wastetypeid=d.wastetype and tt.skipsizeid=d.skiptype left join sk_enqrelated r on r.srno=d.servicetermid and r.type='SCHEDULE' where d.ctypeid=1 and cm.status not in (6,7,8) and cm.billingmethod!=3 and '"+sqltodate+"' between startdt and if(cm.status=10 and cm.closedate<=last_day('"+sqltodate+"'),cm.closedate,enddt) group by cm.tr_no";
	 	//System.out.println("sql1--->>>"+sql1);                                       
		ResultSet rs1= stmt.executeQuery(sql1);         
		while(rs1.next()){ 
			 inctipfee=rs1.getInt("inctipfee");            
			 datecompare=rs1.getInt("datecompare");          
			 startdt=rs1.getString("startdt");
			 enddt=rs1.getString("enddt");
			 //noofvisit=rs1.getInt("nos");
			 //skipqty=rs1.getInt("nos"); // 2023-08-02 changed to skip@site qty on request
			 skipqty=rs1.getInt("skipatsiteqty");   
			 noofvisit=rs1.getInt("scheduledays");     
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
			 //trips=INVDAO.getTotalTrips(startdt, enddt, noofvisit+"", serviceterm, days, contdetno, cbrhid, srno, scheduledays)*noofvisit;  //Commented due to weekly with different schedule days case   
			 //System.out.println("trips1---"+trips+"==noofvisit---"+noofvisit+"==scheduledays---"+scheduledays);
			 if(serviceterm.equalsIgnoreCase("WEEKLY")){
				 int temptrip = 0, t1=0; 
				 t1 = INVDAO.getTotalTrips(startdt, enddt, noofvisit+"", serviceterm, scheduledays);
				 temptrip = t1/noofvisit;
				 if(temptrip>5){
					 trips = 5*skipqty*noofvisit;    
				 }else{
					 trips = temptrip*skipqty*noofvisit;            
				 }
				 //System.out.println("temptrip---"+temptrip+"==trips---"+trips+"==t1---"+t1);      
			 }else{
				 trips = INVDAO.getTotalTrips(startdt, enddt, noofvisit+"", serviceterm, scheduledays)*skipqty;   
			 }
			 //System.out.println("trips2---"+trips+"==noofvisit---"+noofvisit+"==skipqty---"+skipqty);                                
			 
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
					 int tiptrips=0;
					 if(datecompare==1 && inctipfee==1){     
						 tiptrips=trips;  
					 } 
					 String sql4="update sk_triptotal set invoicetrip='"+trips+"', tippinginvoiced='"+tiptrips+"', gateinvoiced='"+tiptrips+"' where srno='"+tripsrno+"' and manual=0";                 
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
					 int tiptrips=0;
					 if(datecompare==1 && inctipfee==1){   
						 tiptrips=trips;  
					 } 
					 String sql4="update sk_triptotal set invoicetrip='"+trips+"', tippinginvoiced='"+tiptrips+"', gateinvoiced='"+tiptrips+"' where srno='"+totsrno+"' and manual=0";                 
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