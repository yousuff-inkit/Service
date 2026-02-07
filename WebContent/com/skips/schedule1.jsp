<%@page import="java.sql.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="net.sf.json.JSONArray" %>
<%@page import="net.sf.json.JSONObject" %>
<%
	String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno");    
    Connection conn = null;   
    JSONArray jsonArray = new JSONArray();
try{	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	conn= ClsConnection.getMyConnection();  
	Statement stmtmain = conn.createStatement ();  
	int val=0,invoiced=0;
	ArrayList arr = new ArrayList();
	String strSql = "select date_format(if(m.startdt<'2022-01-01','2022-01-01',m.startdt),'%d.%m.%Y')  startdt,date_format(if(m.enddt>'2022-12-31','2022-12-31',m.enddt),'%d.%m.%Y')  enddt,'00:00',d.nos,r.name,8 days,d.rdocno rowno,m.brhid,d.srno,d.scheduledays from sk_srvcontrm m left join sk_srvcontrdet d on m.doc_no=d.rdocno "
	+" left join sk_enqrelated r on r.srno=d.servicetermid and r.type='SCHEDULE' where m.status=3 and   billingmethod=1 and advinvmethod=0 and (20220101 <=startdt or 20220101 <=enddt) ";      
	System.out.println("strSql---->>>"+strSql);  
	ResultSet rsmain = stmtmain.executeQuery(strSql);         
	while(rsmain.next()) {         
		arr.add(rsmain.getString("startdt")+"::"+rsmain.getString("enddt")+"::00:00::"+rsmain.getString("nos")+"::"+rsmain.getString("name")+"::"+rsmain.getString("days")+"::"+rsmain.getString("rowno")+"::"+rsmain.getString("brhid")+"::"+rsmain.getString("srno")+"::"+rsmain.getString("scheduledays"));  
  	}     
	
	System.out.println("strSql---->>>"+arr); 
	for(int arrsize=0;arrsize<arr.size();arrsize++){
		
	// HttpSession session;
	String[] array=arr.get(arrsize).toString().split("::");
	String date=array[0];
	String enddate=array[1];
	String time=array[2];
	String noofvisit=array[3];
	String serviceterm=array[4];
	int days=Integer.parseInt(array[5]);  
	String rowno=array[6];
	String brhid=array[7];
	String srno=array[8];	
	String scheduledays=array[9];
		try {
	java.sql.Date xdate=null;
	java.sql.Date fdate=null;
	java.sql.Date endsdate=null;
            		String day="",dates="";
	int xsrno=0;
	date.trim();

	if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		xdate = objcommon.changeStringtoSqlDate(date);
		fdate = objcommon.changeStringtoSqlDate(date);  
	}

	enddate.trim();
	if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
		endsdate = objcommon.changeStringtoSqlDate(enddate);
	}
	System.out.println(xdate+"=="+endsdate);
	String xsql="";

	conn = ClsConnection.getMyConnection();
	Statement stmt = conn.createStatement();  
	Statement stmt2 = conn.createStatement();  
            int duelen=0;
            String type=serviceterm.equalsIgnoreCase("DAILY")?" Day ":serviceterm.equalsIgnoreCase("MONTHLY")?" Month ":serviceterm.equalsIgnoreCase("WEEKLY")?" Week ":" Day "; 
	String strsql1="SELECT TIMESTAMPDIFF("+type+", '"+fdate+"', '"+endsdate+"') duelen";   
	System.out.println("strsql1==="+strsql1);
	ResultSet rs1 = stmt.executeQuery(strsql1);  
	while(rs1.next()) {
		duelen=rs1.getInt("duelen");
	}
	
	//System.out.println("days==="+days); 
	if(!serviceterm.equalsIgnoreCase("MONTHLY")){
	do							
	{	

		if (Integer.parseInt(noofvisit)>0 && xsrno>duelen) break;

		JSONObject obj = new JSONObject();

		if(xsrno>duelen) break; 
		if(days!=0) {    
	String sqltst="";   
	if(days!=8) {  
		 sqltst=" AND DAYOFWEEK(DATE) in("+days+")";  
	}
	int alternative=0,weekly=0, interval=0,month=0;
	String sql="SELECT  * FROM (SELECT  if(convert(n4.num*1000+n3.num*100+n2.num*10+n1.num ,UNSIGNED)%2,1,0) alternative,if(convert(n4.num*1000+n3.num*100+n2.num*10+n1.num ,UNSIGNED)%7,1,0) weekly,DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
	System.out.println("sql="+sql);      
	                ResultSet rs = stmt.executeQuery(sql);
	while(rs.next()) {
		xdate=rs.getDate("date");  
		alternative=rs.getInt("alternative");
		weekly=rs.getInt("weekly"); 
		if(!(xdate==null) || !(endsdate.after(xdate))){
			String sql1="";
			
			sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, 0 month";  
			System.out.println("sql1="+sql1);    
	                ResultSet rs2 = stmt2.executeQuery(sql1);
			if(rs2.next()) {
				day=rs2.getString("day"); 
				dates=rs2.getString("date"); 
				month=rs2.getInt("month");
				if(month==1){interval++;}
			}
			obj.put("date",dates);
			obj.put("time",time); 
			obj.put("day",day);  
			System.out.println(serviceterm+"alternative : "+alternative +" day : "+day+" scheduledays: "+scheduledays);
						if (serviceterm.equalsIgnoreCase("DAILY")
								|| (serviceterm.equalsIgnoreCase("ALTERNATIVE") && alternative == 0)
								|| (serviceterm.equalsIgnoreCase("WEEKLY") && scheduledays.equalsIgnoreCase("1") && weekly == 0)
								|| (serviceterm.equalsIgnoreCase("WEEKLY") && scheduledays.equalsIgnoreCase("4") && (day.equalsIgnoreCase("Monday")||day.equalsIgnoreCase("Tuesday")||day.equalsIgnoreCase("Thursday")||day.equalsIgnoreCase("Saturday")))
								|| (serviceterm.equalsIgnoreCase("Daily (Except Holiday)") && (!day.equalsIgnoreCase("Sunday")))
							//	|| (serviceterm.equalsIgnoreCase("MONTHLY") && scheduledays.equalsIgnoreCase("26") && (!day.equalsIgnoreCase("Sunday")))
								) {
										String inssql = "insert into sk_srvcontrsch(rdocno,srno, brhid, delid, date, time, days) values('"+ rowno+ "','"+ srno+ "','"
												+ brhid
												+ "','0','"
												+ objcommon
														.changeStringtoSqlDate(dates)
												+ "','"
												+ time
												+ "','"
												+ day + "')";
										System.out
												.println("inssql--->>>"
														+ inssql);
										val = stmtmain
												.executeUpdate(inssql);
									}
								}
								jsonArray.add(obj);
							}
							rs.close();

							break;
						}
						xsrno++;
					} while (true);
					// System.out.println();
				} else if (serviceterm.equalsIgnoreCase("MONTHLY")) {
					String sqlmon="";
					Date sqldate=fdate;
					int end=0;
					if(scheduledays.equalsIgnoreCase("1")){
					do{
						System.out.println(xdate+"===="+endsdate+"===="+sqldate+"============="+endsdate.after(sqldate));
					if(!(xdate==null) || !(endsdate.after(sqldate))){
					
				
					if(endsdate.before(sqldate)){
						end=1;
						break;
					}else{
					String inssql = "insert into sk_srvcontrsch(rdocno,srno, brhid, delid, date, time, days) values('"+ rowno+ "','"+ srno+ "','"
							+ brhid + "','0','"+ sqldate+"','"+ time+ "','"+ day + "')";
					System.out.println("inssql--->>>"+ inssql);
					val = stmtmain.executeUpdate(inssql);
					}
					if(scheduledays.equalsIgnoreCase("1")){
						sqlmon=" select date_add('"+fdate+"' , interval 1 month) calcdate , DAYNAME('"+xdate+"') day; ";
					}
					
					ResultSet rsmon=stmt.executeQuery(sqlmon);
					while(rsmon.next()){
						sqldate=rsmon.getDate("calcdate");
						day=rsmon.getString("day");
					}
					fdate=sqldate;
					}} while(end==0);
				}
					else{
						do{
						int cnt=0,diff=0,noofdays=Integer.parseInt(scheduledays);
						TreeMap<Date,String> s = new TreeMap<Date, String>();
						do{
						sqlmon=" SELECT last_day('"+fdate+"') - INTERVAL FLOOR(RAND() * datediff(last_day('"+fdate+"'),'"+fdate+"')) day calcdate ," 
								+" dayname(last_day('"+fdate+"') - INTERVAL FLOOR(RAND() * datediff(last_day('"+fdate+"'),'"+fdate+"')) day) DAY , datediff(last_day('"+fdate+"'),'"+fdate+"') diff "  ;
 						//System.out.println("=="+sqlmon);
						ResultSet rsmon=stmt.executeQuery(sqlmon);
						while(rsmon.next()){
							
							sqldate=rsmon.getDate("calcdate");
							day=rsmon.getString("day");
							diff=rsmon.getInt("diff");
							s.put(rsmon.getDate("calcdate"),day);
							cnt=s.size();
						}
						System.out.println(s.size()+"===="+s);
						
						}while(diff>cnt && noofdays>s.size());
						
						 for (Map.Entry<Date,String> entry : s.entrySet()){
							  // System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
							   String inssql = "insert into sk_srvcontrsch(rdocno,srno, brhid, delid, date, time, days) values('"+ rowno+ "','"+ srno+ "','"
										+ brhid + "','0','"+ entry.getKey()+"','"+ time+ "','"+ entry.getValue() + "')";
							//	System.out.println("inssql--->>>"+ inssql);
								val = stmtmain.executeUpdate(inssql);
						 }
							
						 sqlmon=" select date_add(last_day('"+fdate+"') , interval 1 day) calcdate  ";
							ResultSet rsmon=stmt.executeQuery(sqlmon);
							while(rsmon.next()){
								fdate=rsmon.getDate("calcdate");
							}
					         
					}while(endsdate.after(fdate));
					}
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				conn.close();
			}

		}
		System.out.println(jsonArray);
		stmtmain.close();
		conn.close();

		response.getWriter().print(jsonArray);
	} catch (Exception e) {
		e.printStackTrace();
		conn.close();
	}
%>