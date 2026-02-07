<%@page import="java.util.ArrayList"%>
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
	String strSql = "select date_format(m.startdt,'%d.%m.%Y')  startdt,date_format(m.enddt,'%d.%m.%Y')  enddt,'00:00',d.nos,r.name,8 days,d.rdocno rowno,m.brhid,d.srno from sk_srvcontrm m left join sk_srvcontrdet d on m.doc_no=d.rdocno "
			+" left join sk_enqrelated r on r.srno=d.servicetermid and r.type='SCHEDULE' where m.status=3 and   billingmethod=2 and advinvmethod=1 and 20220101 between startdt and enddt and m.doc_no=406";      
	//System.out.println("strSql---->>>"+strSql);  
	ResultSet rsmain = stmtmain.executeQuery(strSql);         
	while(rsmain.next()) {         
		arr.add(rsmain.getString("startdt")+"::"+rsmain.getString("enddt")+"::00:00::"+rsmain.getString("nos")+"::"+rsmain.getString("name")+"::"+rsmain.getString("days")+"::"+rsmain.getString("rowno")+"::"+rsmain.getString("brhid")+"::"+rsmain.getString("srno"));  
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
			if(serviceterm.equalsIgnoreCase("ALTERNATIVE")) {
				duelen=duelen/2; 
				xsql=2 + type;
			}else {
				xsql=1 + type;
			}
			//System.out.println("days==="+days); 
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
					String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					System.out.println("sql="+sql);      
	                ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()) {
						xdate=rs.getDate("date");  
						if(!(xdate==null) || !(endsdate.after(xdate))){
							String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";    
							System.out.println("sql1="+sql1);    
			                ResultSet rs2 = stmt2.executeQuery(sql1);
							if(rs2.next()) {
								day=rs2.getString("day"); 
								dates=rs2.getString("date");    
							}
							obj.put("date",dates);
							obj.put("time",time); 
							obj.put("day",day);  
							String inssql="insert into sk_srvcontrsch(rdocno,srno, brhid, delid, date, time, days) values('"+rowno+"','"+srno+"','"+brhid+"','0','"+objcommon.changeStringtoSqlDate(dates)+"','"+time+"','"+day+"')";                  
							  System.out.println("inssql--->>>"+inssql);  
							 val= stmtmain.executeUpdate(inssql); 
						}
						jsonArray.add(obj);
					}
					rs.close();
					break;   
				}else {  
					if(!(xdate==null) || !(endsdate.after(xdate))){
						String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";    
						//System.out.println("sql1="+sql1);    
		                ResultSet rs2 = stmt2.executeQuery(sql1);
						if(rs2.next()) {
							day=rs2.getString("day"); 
							dates=rs2.getString("date");    
						}
						
						obj.put("date",dates);
						obj.put("time",time); 
						obj.put("day",day);  
						 String inssql="insert into sk_srvcontrsch(rdocno, brhid, delid, date, time, days) values('"+rowno+"','"+brhid+"','0','"+dates+"','"+time+"','"+day+"')";                  
						  System.out.println("inssql-2-->>>"+inssql);  
						 val= stmt.executeUpdate(inssql); 
					}
					jsonArray.add(obj);
					String sql="Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(noofvisit)+",'-',day('"+xdate+"')))) fdate";
					System.out.println("sql="+sql);      
	                ResultSet rs = stmt.executeQuery(sql);
					if(rs.next()) xdate=rs.getDate("fdate");  
					rs.close(); 
					
				}
				xsrno++;
			}while(true); 
         // System.out.println();
			String sql="Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(noofvisit)+",'-',day('"+xdate+"')))) fdate";
			System.out.println("sql="+sql); 
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
	
	}
	System.out.println(jsonArray);
	stmtmain.close();
	conn.close();  

	response.getWriter().print(jsonArray);        
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>