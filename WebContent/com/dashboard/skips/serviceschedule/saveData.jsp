<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.email.*"%>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;    
	String delid=request.getParameter("delid")==null || request.getParameter("delid").trim()==""?"0":request.getParameter("delid").trim();
	String docno=request.getParameter("docno")==null || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();
	String cnttrno=request.getParameter("cnttrno")==null || request.getParameter("cnttrno").trim()==""?"0":request.getParameter("cnttrno").trim();
	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
    String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim()==""?"0":request.getParameter("brhid").trim();
	String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
	String statusid=request.getParameter("statusid")==null || request.getParameter("statusid")==""?"0":request.getParameter("statusid").trim(); 
	String docsarray=request.getParameter("docsarray")==null || request.getParameter("docsarray")==""?"0":request.getParameter("docsarray").trim();  
	
	String skipsizeid=request.getParameter("skipesizeid")==null || request.getParameter("skipesizeid")==""?"0":request.getParameter("skipesizeid");
    String wasteid=request.getParameter("wasteid")==null || request.getParameter("wasteid")==""?"0":request.getParameter("wasteid"); 
    String dodate=request.getParameter("dodate")==null || request.getParameter("dodate")==""?"0":request.getParameter("dodate");
    String dno=request.getParameter("dno")==null || request.getParameter("dno")==""?"0":request.getParameter("dno");
    //String wastetype=request.getParameter("wastetype")==null || request.getParameter("wastetype")==""?"":request.getParameter("wastetype");
    int qty=request.getParameter("qty")==null || request.getParameter("qty")==""?0:Integer.parseInt(request.getParameter("qty"));
    //String skipesize=request.getParameter("skipesize")==null || request.getParameter("skipesize")==""?"":request.getParameter("skipesize");
    String weight=request.getParameter("weight")==null || request.getParameter("weight")==""?"0":request.getParameter("weight");
    String price=request.getParameter("price")==null || request.getParameter("price")==""?"0":request.getParameter("price"); 
    String tipping=request.getParameter("tipping")==null || request.getParameter("tipping")==""?"NO":request.getParameter("tipping");
    
    String routeid=request.getParameter("routeid")==null || request.getParameter("routeid")==""?"0":request.getParameter("routeid");
    String driverid=request.getParameter("driver")==null || request.getParameter("driver")==""?"0":request.getParameter("driver");
    String helperid=request.getParameter("helper")==null || request.getParameter("helper")==""?"0":request.getParameter("helper");
    String helperid2=request.getParameter("helper2")==null || request.getParameter("helper2")==""?"0":request.getParameter("helper2");
    String fleetno=request.getParameter("vehicle")==null || request.getParameter("vehicle")==""?"0":request.getParameter("vehicle");
    
    String sccnttrno=request.getParameter("sccnttrno")==null || request.getParameter("sccnttrno")==""?"0":request.getParameter("sccnttrno");
    String sccntsrno=request.getParameter("sccntsrno")==null || request.getParameter("sccntsrno")==""?"0":request.getParameter("sccntsrno");
    String scdate=request.getParameter("scdate")==null || request.getParameter("scdate")==""?"0":request.getParameter("scdate");
    String sctime=request.getParameter("sctime")==null || request.getParameter("sctime")==""?"0":request.getParameter("sctime");
    String scwasteid=request.getParameter("scwasteid")==null || request.getParameter("scwasteid")==""?"0":request.getParameter("scwasteid");
 
    String podate=request.getParameter("podate")==null || request.getParameter("podate")==""?"0":request.getParameter("podate");
    String potime=request.getParameter("potime")==null || request.getParameter("potime")==""?"0":request.getParameter("potime"); 
    String poremarks=request.getParameter("poremarks")==null?"":request.getParameter("poremarks");  
    String poskipno=request.getParameter("poskipno")==null || request.getParameter("poskipno")==""?"0":request.getParameter("poskipno");
    String oldskipid=request.getParameter("oldskipid")==null || request.getParameter("oldskipid")==""?"0":request.getParameter("oldskipid");  
    String exchange=request.getParameter("exchange")==null || request.getParameter("exchange")==""?"0":request.getParameter("exchange");
    String delsrno=request.getParameter("delsrno")==null || request.getParameter("delsrno")==""?"0":request.getParameter("delsrno");   
   
    String name=request.getParameter("name")==null?"":request.getParameter("name");
    String mobno=request.getParameter("mobno")==null?"":request.getParameter("mobno");
    String email=request.getParameter("email")==null?"":request.getParameter("email");
    String location=request.getParameter("location")==null?"":request.getParameter("location");    
    String substatusid=request.getParameter("substatusid")==null || request.getParameter("substatusid")==""?"0":request.getParameter("substatusid");     
    
    try{       
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();  
		//System.out.println("process--->>>"+processid);               
	    
		String sql="",sqlsub="",sql1="",rowno="0";       
		String temp="";
		int val=0;
		java.sql.Date sqldate = null;  
		java.sql.Date sqlcldate = null;
		
		ArrayList<String> docsar=new ArrayList<String>();
		if(docsarray.contains(":")){
			String [] docs=new String []{};   
			docs=docsarray.split(":");
			System.out.print(docs.toString());
			for(int i=0;i<docs.length;i++){
				docsar.add(i, docs[i]);  
			}
		}
		else{
			docsar.add(0, docsarray);     
		}
		/*Operations*/
		if(processid.equalsIgnoreCase("Status Update")){
			for(int i=0;i<docsar.size();i++){       
				 String upsql="update sk_srvcontrsch set statusid='"+statusid+"' where doc_no='"+docsar.get(i)+"'";    
		    	 //System.out.println("upsql--->>>"+upsql);      
				 val= stmt.executeUpdate(upsql);
				 
				 if(statusid.equalsIgnoreCase("1")){    
					 String pskipno="0";
					//When Pullout marking future schedules as dropped for the particulor po skip 
					 String selectsql="select pskipno from sk_srvcontrsch where status=2 and doc_no='"+docsar.get(i)+"'";   
				 	 //System.out.println("selectsql--->>>"+selectsql);    
					 ResultSet rs= stmt.executeQuery(selectsql);    
					 while(rs.next()){
						 pskipno=rs.getString("pskipno");    
					 }
					 if(!pskipno.equals("0")){
						 String upsql2="update sk_srvcontrsch set status=4 where pskipno='"+pskipno+"' and date>curdate() and rdocno='"+cnttrno+"'";         
				    	 //System.out.println("upsql2--->>>"+upsql2);          
						 stmt.executeUpdate(upsql2);
						 
						 String upsql3="update sk_srvcontrsch sc left join sk_srvcontrdel dl on dl.doc_no=sc.delid set sc.status=4 where dl.skipid='"+pskipno+"' and sc.date>curdate() and rdocno='"+cnttrno+"'";  
						 //System.out.println("upsql3--->>>"+upsql3);           
						 stmt.executeUpdate(upsql3); 
					 }
					 //End of marking   
					 
					 String upsql4="update sk_skipm set skipstatus=1 where doc_no='"+pskipno+"'";               
			    	 //System.out.println("upsql4--->>>"+upsql4);        
					 stmt.executeUpdate(upsql4); 
				 }
			}
			if(val>0){     
				 String upsql5="update sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no set cm.status=6 where d.balqty=0 and d.statusid=6 and cm.tr_no='"+cnttrno+"'";                 
		    	 //System.out.println("upsql5--->>>"+upsql5);        
				 stmt.executeUpdate(upsql5);  
			 
				 String upsql6="update sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no set cm.status=10 where d.statusid=7 and cm.tr_no='"+cnttrno+"'";                       
		    	 //System.out.println("upsql6--->>>"+upsql6);         
				 stmt.executeUpdate(upsql6);     
			}
			if(val>0){
				 temp="1";    
			}
	    }else if(processid.equalsIgnoreCase("Tipping Details Update")){
	    	 Statement stmt1 = conn.createStatement(); 
			 Statement stmt2 = conn.createStatement(); 
			 Statement stmt3 = conn.createStatement(); 
	    	 String month="", year="", contractno="", contdetno="",  totsrno="", cbrhid="",trips="",contno="";  
		 	 Double rate=0.0,total=0.0;
		 	 int executedtrips=0;
		 	 if(!(dodate.equalsIgnoreCase("undefined"))&&!(dodate.equalsIgnoreCase(""))&&!(dodate.equalsIgnoreCase("0"))) {
		 		sqldate=ClsCommon.changeStringtoSqlDate(dodate);   
			 } else{} 
		 	 //System.out.println("docsar--->>>"+docsar); 
			 String strsql1="select dm.name wastetype,st.name skipsize,a.*,round(coalesce(sum(disposalfee),0),2) rate,month('"+sqldate+"') month,year('"+sqldate+"') year from(select '"+wasteid+"' wastetypeid,cm.doc_no contno,cm.brhid,cm.tr_no contractno,d.rowno contdetno,'"+skipsizeid+"' skipsizeid from sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no where cm.tr_no='"+cnttrno+"')a left join sk_skiptype st on st.doc_no=a.skipsizeid left join sk_dumptype dm on dm.doc_no=a.wastetypeid left join sk_tippingtariff tt on tt.wastetypeid=a.wastetypeid and tt.skipsizeid=a.skipsizeid group by a.contractno";
			 //System.out.println("strsql1--->>>"+strsql1);              
			 ResultSet rs1= stmt.executeQuery(strsql1);     
			 while(rs1.next()){
						 month= rs1.getString("month");
						 year= rs1.getString("year");
						 contractno= rs1.getString("contractno");
						 contdetno= rs1.getString("contdetno");
						 trips= qty+"";
						 executedtrips= qty;     
						 contno= rs1.getString("contno");
						 cbrhid= rs1.getString("brhid"); 
						 total= rs1.getDouble("rate"); 
						 wasteid= rs1.getString("wastetypeid");     
						 skipsizeid= rs1.getString("skipsizeid"); 
						 String wastetype= rs1.getString("wastetype"); 
						 String skipesize= rs1.getString("skipsize");    
						 
						 int tripsrno=0,totaltrips=0,chargeabletrips=0,temexecutedtrip=0;   
						 String sql22="select srno,tottrips,executedtrip from sk_triptotal where year='"+year+"' and month='"+month+"' and contractno='"+contractno+"' and contdetno='"+contdetno+"'";      
					 	 //System.out.println("sql22--->>>"+sql22);    
						 ResultSet rs22= stmt1.executeQuery(sql22);  
						 while(rs22.next()){
							 tripsrno=rs22.getInt("srno");
							 totaltrips=rs22.getInt("tottrips");
							 temexecutedtrip=rs22.getInt("executedtrip");
						 }
						 executedtrips = executedtrips+temexecutedtrip;      
						 if(tripsrno>0){
							 if(totaltrips>executedtrips){ 
								 chargeabletrips=totaltrips;
							 }
							 if(totaltrips<executedtrips){ 
								 chargeabletrips=executedtrips;    
							 }
							 String sql3="update sk_triptotal set executedtrip='"+executedtrips+"', chargedtrip='"+chargeabletrips+"' where srno='"+tripsrno+"'";        
						 	 System.out.println("sql3--->>>"+sql3);    
							 val= stmt2.executeUpdate(sql3); 
							 if(val>0){ 
								 if(tipping.equalsIgnoreCase("YES")){      
									 String sql4="insert into sk_tippingdet(contno, contdet, wasteid, skipsizeid, qty, TOTSRNO, wastetype, dno, ddate, rate, weight, price) values('"+contractno+"', '"+contdetno+"', '"+wasteid+"', '"+skipsizeid+"', '"+trips+"', '"+tripsrno+"', '"+wastetype+"', '"+dno+"', '"+sqldate+"', "+total+", "+weight+", "+price+")";     
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
									 String sql4="insert into sk_tippingdet(contno, contdet, wasteid, skipsizeid, qty, TOTSRNO, wastetype, dno, ddate, rate, weight, price) values('"+contractno+"', '"+contdetno+"', '"+wasteid+"', '"+skipsizeid+"', '"+trips+"', '"+totsrno+"', '"+wastetype+"', '"+dno+"', '"+sqldate+"', "+total+", "+weight+", "+price+")";        
								 	 //System.out.println("sql4--->>>"+sql4);    
									 val= stmt2.executeUpdate(sql4);  
								 }
							 }
						  }
			}        
		    for(int i=0;i<docsar.size();i++){
						 String sqlinsert = "insert into sk_serviceinfo(schno, entrydatetime, dno, ddate, wasteid, skipsizeid, qty, weight, price, statusid, substatusid, exchange, skipid, remarks, userid) "
					 			+ "values('"+docsar.get(i)+"', now(), '"+dno+"', '"+sqldate+"', '"+wasteid+"', '"+skipsizeid+"', '"+trips+"', '"+weight+"', '"+price+"', '"+statusid+"', '"+substatusid+"', '"+exchange+"', '"+poskipno+"', '"+poremarks+"', '"+session.getAttribute("USERID").toString()+"')";  
					 	 val = stmt.executeUpdate(sqlinsert); 
					 	 
						 String upsql="update sk_srvcontrsch set statusid = '"+statusid+"', substatusid = '"+substatusid+"', remarks = '"+poremarks+"' where doc_no='"+docsar.get(i)+"'";    
					     //System.out.println("upsql--->>>"+upsql);      
						 val= stmt.executeUpdate(upsql);    
						 if(statusid.equalsIgnoreCase("1")){
							 String pskipno="0";
							 //When Pullout marking future schedules as dropped for the particulor po skip 
							 String selectsql="select pskipno from sk_srvcontrsch where status=2 and doc_no='"+docsar.get(i)+"'";   
						 	 //System.out.println("selectsql--->>>"+selectsql);    
							 ResultSet rs= stmt1.executeQuery(selectsql);    
							 while(rs.next()){
								 pskipno=rs.getString("pskipno");    
							 }
							 if(!pskipno.equals("0")){
								 String upsql2="update sk_srvcontrsch set status=4 where pskipno='"+pskipno+"' and date>'"+sqldate+"' and rdocno='"+contractno+"'";      
						    	 //System.out.println("upsql2--->>>"+upsql2);          
								 stmt.executeUpdate(upsql2);
								 
								 String upsql3="update sk_srvcontrsch sc left join sk_srvcontrdel dl on dl.doc_no=sc.delid set sc.status=4 where dl.skipid='"+pskipno+"' and sc.date>'"+sqldate+"' and rdocno='"+contractno+"'";  
								 //System.out.println("upsql3--->>>"+upsql3);           
								 stmt.executeUpdate(upsql3);
							 }   
							 //End of po skip dropped marking
							 
							 
							 String upsql4="update sk_skipm set skipstatus=1 where doc_no='"+pskipno+"'";               
					    	 //System.out.println("upsql4--->>>"+upsql4);        
							 stmt.executeUpdate(upsql4);   
						 }
						 if(exchange.equalsIgnoreCase("1")){
							 String excnttrno="",exdetsrno="",exdelid="",exoldskipid="";   
							 String selectsql="select sc.rdocno,sc.srno,sc.delid,dl.skipid from sk_srvcontrsch sc left join sk_srvcontrdel dl on dl.doc_no=sc.delid where sc.doc_no='"+docsar.get(i)+"'";   
						 	 //System.out.println("selectsql--->>>"+selectsql);    
							 ResultSet rs= stmt1.executeQuery(selectsql);      
							 while(rs.next()){
								 excnttrno=rs.getString("rdocno");  
								 exdetsrno=rs.getString("srno"); 
								 exdelid=rs.getString("delid"); 
								 exoldskipid=rs.getString("skipid");     
							 }
							 String inssql="insert into sk_srvcontrrep(delid, cnttrno, detsrno, oldskipno, newskipno, date, time, entrydatetime, userid, typeid, remarks) values('"+exdelid+"', '"+excnttrno+"','"+exdetsrno+"','"+exoldskipid+"','"+poskipno+"','"+sqldate+"','"+potime+"',now(),'"+session.getAttribute("USERID").toString()+"', 'E', '"+poremarks+"')";                       
					    	 //System.out.println("inssql--->>>"+inssql);                  
							 val= stmt.executeUpdate(inssql); 
							 if(val>0){   
								     String upsql1="update sk_skipm set skipstatus=1 where doc_no='"+exoldskipid+"'";                         
							    	 // System.out.println("upsql1--->>>"+upsql1);                  
									 val= stmt.executeUpdate(upsql1);  
									 String upsql2="update sk_skipm set skipstatus=2 where doc_no='"+poskipno+"'";                            
							    	 //System.out.println("upsql2--->>>"+upsql2);                  
									 val= stmt.executeUpdate(upsql2);  
							 }
							 if(val>0){      
								 String upsql2="update sk_srvcontrdel set skipid='"+poskipno+"' where doc_no='"+exdelid+"'";                                     
						    	 //System.out.println("upsql2--->>>"+upsql2);                  
								 val= stmt.executeUpdate(upsql2);    
							 }
						}
			}
		    if(val>0){     
				 String upsql5="update sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no set cm.status=6 where d.balqty=0 and d.statusid=6 and cm.tr_no='"+cnttrno+"'";                 
		    	 //System.out.println("upsql5--->>>"+upsql5);        
				 stmt.executeUpdate(upsql5);  
			 
				 String upsql6="update sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no set cm.status=10 where d.statusid=7 and cm.tr_no='"+cnttrno+"'";                       
		    	 //System.out.println("upsql6--->>>"+upsql6);         
				 stmt.executeUpdate(upsql6);     
			}
			if(val>0){
					 temp="1";    
			} 
		}else if(processid.equalsIgnoreCase("Route Details Update")){                   
			for(int i=0;i<docsar.size();i++){           
				 String upsql="update sk_srvcontrsch sc set sc.routeid='"+routeid+"',sc.driverid='"+driverid+"',sc.helperid='"+helperid+"',sc.helperid2='"+helperid2+"',sc.fleetno='"+fleetno+"' where sc.doc_no='"+docsar.get(i)+"'";         
		    	 //System.out.println("upsql--->>>"+upsql);           
				 val= stmt.executeUpdate(upsql);        
			}
			if(val>0){
				 temp="1";    
			}
	    }else if(processid.equalsIgnoreCase("Schedule on call basis")){    
		    	 Statement stmt1 = conn.createStatement(); 	 
		    	 if(!(scdate.equalsIgnoreCase("undefined"))&&!(scdate.equalsIgnoreCase(""))&&!(scdate.equalsIgnoreCase("0"))) {
			    		 sqldate=ClsCommon.changeStringtoSqlDate(scdate);     
				 } else{}
		    	 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))) {     
		    		 sqlcldate=ClsCommon.changeStringtoSqlDate(podate);      
			     }else{}      
				 int scdelid=0; 
				 String sqltest="",days="";
				 if(!delsrno.equalsIgnoreCase("All")) {   
						sqltest+=" and dl.slno='"+delsrno+"'";       
				 }
			 	 String strsql1="select dl.doc_no,cm.brhid,dayname('"+sqldate+"') dayname from sk_srvcontrdel dl left join sk_srvcontrm cm on cm.tr_no=dl.rdocno where dl.rdocno='"+sccnttrno+"' and dl.srno='"+sccntsrno+"' "+sqltest+" group by dl.doc_no";             
				 //System.out.println("strsql1==="+strsql1);  
				 ResultSet rs1 = stmt.executeQuery(strsql1);    
				 while(rs1.next()) {
					        scdelid=rs1.getInt("doc_no");
							brhid = rs1.getString("brhid"); 
							days = rs1.getString("dayname");   
							String inssql="insert into sk_srvcontrsch(rdocno, srno, brhid, delid, date, time, days, name, mobile, email, location, calldate, calltime) values('"+sccnttrno+"', '"+sccntsrno+"', '"+brhid+"', '"+scdelid+"', '"+sqldate+"', '"+sctime+"', '"+days+"', '"+name+"', '"+mobno+"', '"+email+"', '"+location+"', '"+sqlcldate+"', '"+potime+"')";        
					    	//System.out.println("inssql--->>>"+inssql);      
							val= stmt1.executeUpdate(inssql);                       
				 }
				if(val>0){
					 temp="1";    
				}    
	    }else if(processid.equalsIgnoreCase("Pull Out")){           
	    	 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))) {     
	    		 sqldate=ClsCommon.changeStringtoSqlDate(podate);    
		      }else{} 
	    	 String days="";
	    	 int podelid=0,oldskipidpo=0;
	    	 String strsql1="select dl.doc_no,dayname('"+sqldate+"') dayname,dl.skipid from sk_srvcontrdel dl where dl.rdocno='"+cnttrno+"' and dl.srno='"+srno+"' and dl.slno='"+delsrno+"' group by dl.doc_no";               
			 //System.out.println("strsql1==="+strsql1);  
			 ResultSet rs1 = stmt.executeQuery(strsql1);    
			 while(rs1.next()) {
				        podelid=rs1.getInt("doc_no");   
				        oldskipidpo=rs1.getInt("skipid");    
				        days = rs1.getString("dayname");  
             }
	    	 String inssql="insert into sk_srvcontrsch(rdocno, srno, brhid, delid, date, pskipno, status, time, days, remarks) values('"+cnttrno+"', '"+srno+"', '"+brhid+"', '"+podelid+"', '"+sqldate+"', '"+poskipno+"', 2, '"+potime+"', '"+days+"', '"+poremarks+"')";                          
	    	 //System.out.println("inssql--->>>"+inssql);                
			 val= stmt.executeUpdate(inssql);     
			 
			 if(val>0){
					 String inssql1="insert into sk_srvcontrrep(delid, cnttrno, detsrno, oldskipno, newskipno, date, time, entrydatetime, userid, typeid, remarks) values('"+podelid+"', '"+cnttrno+"','"+srno+"','"+oldskipidpo+"','"+poskipno+"','"+sqldate+"','"+potime+"',now(),'"+session.getAttribute("USERID").toString()+"', 'P','"+poremarks+"')";                          
			    	 //System.out.println("inssql1--->>>"+inssql1);                       
					 val= stmt.executeUpdate(inssql1);      
					 
				     String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+podelid+"','"+brhid+"','BSS',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Pull Out')";  
					 // System.out.println("logsql--->>>"+logsql);        
					 stmt.executeUpdate(logsql);      
			 }
			 if(val>0){
				 temp="1";    
			 }
	     }else if(processid.equalsIgnoreCase("Replacement")){                
	    	 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))) {     
	    		 sqldate=ClsCommon.changeStringtoSqlDate(podate);      
		      }else{} 
	    	 int rpdelid=0,oldskipidrp=0;
	    	 String strsql1="select dl.doc_no,dl.skipid from sk_srvcontrdel dl where dl.rdocno='"+cnttrno+"' and dl.srno='"+srno+"' and dl.slno='"+delsrno+"' group by dl.doc_no";               
			 //System.out.println("strsql1==="+strsql1);    
			 ResultSet rs1 = stmt.executeQuery(strsql1);    
			 while(rs1.next()) {   
				 rpdelid=rs1.getInt("doc_no");   
				 oldskipidrp=rs1.getInt("skipid");    
             }
	    	 String inssql="insert into sk_srvcontrrep(delid, cnttrno, detsrno, oldskipno, newskipno, date, time, entrydatetime, userid, typeid, remarks) values('"+rpdelid+"', '"+cnttrno+"','"+srno+"','"+oldskipidrp+"','"+poskipno+"','"+sqldate+"','"+potime+"',now(),'"+session.getAttribute("USERID").toString()+"', 'R','"+poremarks+"')";                       
	    	 //System.out.println("inssql--->>>"+inssql);                  
			 val= stmt.executeUpdate(inssql);     
			 if(val>0){
				 String upsql1="update sk_skipm set skipstatus=1 where doc_no='"+oldskipidrp+"'";                         
		    	 //System.out.println("upsql1--->>>"+upsql1);                  
				 val= stmt.executeUpdate(upsql1);  
				 String upsql2="update sk_skipm set skipstatus=2 where doc_no='"+poskipno+"'";                            
		    	 //System.out.println("upsql2--->>>"+upsql2);                  
				 val= stmt.executeUpdate(upsql2);   
			 }
			 if(val>0){  
				 String upsql2="update sk_srvcontrdel set skipid='"+poskipno+"' where doc_no='"+rpdelid+"'";                                  
		    	 //System.out.println("upsql2--->>>"+upsql2);                  
				 val= stmt.executeUpdate(upsql2);
				 
				 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+rpdelid+"','"+brhid+"','BSS',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Replacement')";    
				 //System.out.println("logsql--->>>"+logsql);    
				 stmt.executeUpdate(logsql);             
			 }
			 if(val>0){
				 temp="1";    
			 }
	     }else if(processid.equalsIgnoreCase("Change Schedule")){             
	    	 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))) {     
	    		 sqldate=ClsCommon.changeStringtoSqlDate(podate);    
		      }else{} 
	    	 String days="";
	    	 String strsql1="select dayname('"+sqldate+"') dayname";   
			 //System.out.println("strsql1--->>>"+strsql1);                
			 ResultSet rs1= stmt.executeQuery(strsql1);     
			 while(rs1.next()){
				 days = rs1.getString("dayname");   
			 }
	    	 String inssql="update sk_srvcontrsch set date='"+sqldate+"', time='"+potime+"', days='"+days+"', remarks='"+poremarks+"' where doc_no='"+docno+"'";                                  
	    	 //System.out.println("inssql--->>>"+inssql);                
			 val= stmt.executeUpdate(inssql);     
			 
			 if(val>0){
				     String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+docno+"','"+brhid+"','BSS',now(),'"+session.getAttribute("USERID").toString()+"','A', 'Schedule Changed')";    
					 // System.out.println("logsql--->>>"+logsql);      
					 stmt.executeUpdate(logsql);      
			 }
			 if(val>0){
				 temp="1";    
			 }
	     }else{}            
		 
		if(temp.equalsIgnoreCase("1")){     
			conn.commit();
		}
		 response.getWriter().print(temp);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
