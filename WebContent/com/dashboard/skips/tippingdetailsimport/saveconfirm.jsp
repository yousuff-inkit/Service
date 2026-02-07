<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;
    String date=request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");      
    int val=0;  
	try{
		ClsConnection connDAO = new ClsConnection();     
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
	 	 String tipping="",month="", year="", contractno="", contdetno="", trips="", totsrno="",wasteid="", skipsizeid="", wastetype="" , dno="", ddate="",contno="",cbrhid="";
	 	 Double rate=0.0,total=0.0,weight=0.0,price=0.0;
	 	 int executedtrips=0;
	 	  String sql1="select m.contno,m.brhid,round(coalesce(0,0),2) rate,month('"+sqltodate+"') month,year('"+sqltodate+"') year,cm.tr_no contractno,d.rowno contdetno,m.oldcontno, m.dono, m.dodate, sum(m.visitno) visitno,m.tipping from sk_tippingdetexcel m left join sk_srvcontrm cm on cm.doc_no=m.contno and cm.brhid=m.brhid   left join sk_srvcontrdet d on d.rdocno=cm.tr_no  where 1=1 group by m.contno,m.brhid";
	 	  //System.out.println("sql1--->>>"+sql1);               
		 ResultSet rs1= stmt.executeQuery(sql1);  
		 while(rs1.next()){
			 month= rs1.getString("month");
			 year= rs1.getString("year");
			 contractno= rs1.getString("contractno");
			 contdetno= rs1.getString("contdetno");
			 trips= rs1.getString("visitno");
			 executedtrips= rs1.getInt("visitno");  
			 contno= rs1.getString("contno");
			 cbrhid= rs1.getString("brhid"); 
			 total= rs1.getDouble("rate"); 
			 
			 int tripsrno=0,totaltrips=0,chargeabletrips=0;   
			 String sql22="select srno,tottrips from sk_triptotal where year='"+year+"' and month='"+month+"' and contractno='"+contractno+"' and contdetno='"+contdetno+"'";      
		 	 //System.out.println("sql22--->>>"+sql22);    
			 ResultSet rs22= stmt1.executeQuery(sql22);  
			 while(rs22.next()){
				 tripsrno=rs22.getInt("srno");
				 totaltrips=rs22.getInt("tottrips");
			 }
			 if(tripsrno>0){
				 if(totaltrips>=executedtrips){    
					 chargeabletrips=totaltrips;
				 }
				 if(totaltrips<executedtrips){ 
					 chargeabletrips=executedtrips;    
				 }
				 String sql3="update sk_triptotal set executedtrip='"+executedtrips+"', chargedtrip='"+chargeabletrips+"', tiptotal="+total+" where srno='"+tripsrno+"'";        
			 	 //System.out.println("sql3--->>>"+sql3);    
				 val= stmt2.executeUpdate(sql3); 
				 totsrno=tripsrno+"";    
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
			 }
			    
			 if(val>0){ 
				 String sql6="select m.weight,m.price,round(coalesce(disposalfee,0),2) rate,cm.tr_no contractno,d.rowno contdetno,m.contno, m.oldcontno, m.dono, m.dodate, m.visitno, dm.wastename wastetype, st.name skipsize, m.brhid,coalesce(dm.wastetypeid,0) wastetypeid,coalesce(st.doc_no,0) skipsizeid,m.tipping from sk_tippingdetexcel m left join sk_srvcontrm cm on cm.doc_no=m.contno and cm.brhid=m.brhid left join sk_dumptypedet dm on upper(replace(dm.wastename,' ',''))=upper(replace(m.wastetype,' ','')) left join sk_skiptype st on upper(replace(st.name,' ',''))=upper(replace(m.skipsize,' ',''))  left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join sk_tippingtariff tt on tt.wastetypeid=dm.wastetypeid and tt.skipsizeid=st.doc_no where m.contno='"+contno+"' and m.brhid='"+cbrhid+"' group by m.doc_no";
				 //System.out.println("sql6--->>>"+sql6);                        
				 ResultSet rs6= stmt3.executeQuery(sql6);    
				 while(rs6.next()){    
					 trips= rs6.getString("visitno");
					 wasteid= rs6.getString("wastetypeid");
					 skipsizeid= rs6.getString("skipsizeid");	 
					 wastetype= rs6.getString("wastetype");	 
					 dno= rs6.getString("dono");
					 ddate= rs6.getString("dodate");	 	 
					 rate= rs6.getDouble("rate");  
					 tipping= rs6.getString("tipping");
					 weight= rs6.getDouble("weight");  
					 price= rs6.getDouble("price");  
					 if(tipping.equalsIgnoreCase("YES")){      
						 String sql4="insert into sk_tippingdet(contno, contdet, wasteid, skipsizeid, qty, TOTSRNO, wastetype, dno, ddate, rate, weight, price) values('"+contractno+"', '"+contdetno+"', '"+wasteid+"', '"+skipsizeid+"', '"+trips+"', '"+totsrno+"', '"+wastetype+"', '"+dno+"', '"+ddate+"', "+rate+", "+weight+", "+price+")";             
					 	 //System.out.println("sql4--->>>"+sql4);    
						 val= stmt2.executeUpdate(sql4);  
					 }
				 }
				  
			 }
		 }
		if(val>0){  
			 String sql5="truncate sk_tippingdetexcel";       
		 	 //System.out.println("sql5--->>>"+sql5);    
			 stmt2.executeUpdate(sql5);      
		}
		if(val>0){  
			conn.commit();  
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
  
