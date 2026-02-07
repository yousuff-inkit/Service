<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>  
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>  
<%@page import="com.common.*"%>                   
<%   
	String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno");
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
	String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
	String noofdays=request.getParameter("noofdays")==null?"":request.getParameter("noofdays");
	String types=request.getParameter("types")==null?"":request.getParameter("types");    
	String total=request.getParameter("total")==null || request.getParameter("total")==""?"0":request.getParameter("total");
	String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
	String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
	String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString();
	String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno").trim().toString();
	String userid=session.getAttribute("USERID").toString();      
	ClsConnection objconn=new ClsConnection();    
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;
	java.sql.Date sqlfromdate=null;
	java.sql.Date sqltodate=null;    
	int val=0,val1=0,days=0,startsat=0; 
	String rntlvocno="0",rntldocno="0",rntlmark="R",logdesc="";       
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
		java.util.Date curDate=new java.util.Date();
		java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		Statement stmt=conn.createStatement();  
		 if(!fromdate.equalsIgnoreCase("")){
			 sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);    
		 }
		if(!todate.equalsIgnoreCase("")){          
			sqltodate=ClsCommon.changeStringtoSqlDate(todate);           
		 }          
		String strSql = "select coalesce(max(doc_no)+1,1) vocno from rl_rental where brhid="+brhid+"";    
		ResultSet rs = stmt.executeQuery(strSql);
		while(rs.next()) {
			rntlvocno=rs.getString("vocno");                 
		}
		String sql="insert into rl_rental(voc_no, brhid, cldocno, propertyid, propertysub, fromdate, type, noofdays, todate, totalval, remarks, status, userid) values("+rntlvocno+","+brhid+","+cldocno+","+docno+","+srno+",'"+sqlfromdate+"','"+types+"','"+noofdays+"','"+sqltodate+"',"+total+",'"+remarks+"',3,"+userid+")";
		//System.out.println("====sql===="+sql);   
		val=stmt.executeUpdate(sql);    
		if(val>0){
				String sql2 = "select coalesce(max(doc_no),0) docno from rl_rental";                  
				ResultSet rs2 = stmt.executeQuery(sql2);
				while(rs2.next()) {
					rntldocno=rs2.getString("docno");                 
				} 
				if(!srno.equalsIgnoreCase("0")){        
					String sql3="update rl_propertysub set cntno="+rntldocno+",cntdate='"+cdate+"',cnt_type='Rental' where propertyid="+docno+" and srno="+srno+"";                   
					//System.out.println("====sql===="+sql);       
					val=stmt.executeUpdate(sql3);	
				}else{       
					String sql3="update rl_propertymaster set cnt_no="+rntldocno+",cnt_date='"+cdate+"',cnt_type='Rental' where doc_no="+docno+"";
					//System.out.println("====sql===="+sql);         
					val=stmt.executeUpdate(sql3);
				}
				 logdesc="Rental created - Property Docno#"+docno+" Property Srno#"+srno+" Rental Docno#"+rntldocno;        
				 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','PMT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                       
				 //System.out.println(val+"====sqllog===="+sqllog);
				 stmt.executeUpdate(sqllog);             
			}
		 if(val>0){   
			 Date startDate = sqlfromdate;   
			 Date enDate = sqltodate;  
			 Date endDate = new Date(enDate. getTime() + (1000 * 60 * 60 * 24));    
			 Calendar start = Calendar.getInstance();
			 start.setTime(startDate);
			 Calendar end = Calendar.getInstance();     
			 end.setTime(endDate);
			 for (Date date = start.getTime(); start.before(end); start.add(Calendar.MONTH, 1), date = start.getTime()) {
			     //System.out.println(ClsCommon.changeStringtoSqlDate(formatter.format(date)));          
			     String sqlinsert="insert into rl_rentaldays(propertyid, propertysrno, year, month) select m.doc_no docno,coalesce(s.srno,0) srno,year('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') year,month('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') month from rl_propertymaster m left join rl_propertysub s on s.propertyid=m.doc_no  left join rl_rentaldays rd on (coalesce(rd.propertysrno,0)=coalesce(s.srno,0) and rd.propertyid=m.doc_no and rd.month=month('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') and rd.year=year('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"')) where m.status<>7 and rd.rowno is null"; 
				 //System.out.println("sqlinsert--->>>"+sqlinsert);           
			     val=stmt.executeUpdate(sqlinsert);
			 }  
			 
			 startDate = sqlfromdate;   
			 enDate = sqltodate;  
			 endDate = new Date(enDate. getTime() + (1000 * 60 * 60 * 24));    
			 start = Calendar.getInstance();
			 start.setTime(startDate);
			 end = Calendar.getInstance();             
			 end.setTime(endDate);
			 for (Date date = start.getTime(); start.before(end); start.add(Calendar.DATE, 1), date = start.getTime()) {
			     //System.out.println(start.get(Calendar.DAY_OF_MONTH)+"==="+ClsCommon.changeStringtoSqlDate(formatter.format(date)));          
			     String sql5="update rl_rentaldays set day"+start.get(Calendar.DAY_OF_MONTH)+"='"+rntlmark+"' where  propertyid="+docno+" and propertysrno="+srno+" and year=year('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"') and month=month('"+ClsCommon.changeStringtoSqlDate(formatter.format(date))+"')";              
				 //System.out.println("====sql===="+sql5);                        
				 val=stmt.executeUpdate(sql5);             
			 }
			 val1=1;                      
			 conn.commit(); 
		 }
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}   
	response.getWriter().print(val1);              
%>