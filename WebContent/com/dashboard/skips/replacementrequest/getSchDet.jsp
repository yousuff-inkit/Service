<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="com.dashboard.skips.replacementrequest.ClsReplacementRequestDAO"%>

<%
String result="";
int errorstatus=0;
Connection conn = null;
 
String cnttrno = request.getParameter("cnttrno")==null || request.getParameter("cnttrno").equals("")?"0":request.getParameter("cnttrno").toString();
String schdate = request.getParameter("schdate")==null || request.getParameter("schdate").equals("")?"0":request.getParameter("schdate").toString();
try{      
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection(); 
	Statement stmt=conn.createStatement();
	ClsCommon cmn=new ClsCommon();
	ClsReplacementRequestDAO DAO = new ClsReplacementRequestDAO();
	String startdt="", enddt="", serviceterm="", scheduledays="";
 	int trips=0, noofvisit=0, skipqty=0; 
 	java.sql.Date sqltodate = null;
    if(!(schdate.equalsIgnoreCase("undefined"))&&!(schdate.equalsIgnoreCase(""))&&!(schdate.equalsIgnoreCase("0"))) {
       sqltodate=cmn.changeStringtoSqlDate(schdate);
     } else{}
    
    String sql1="select d.scheduledays,dd.skipatsiteqty,date_format('"+sqltodate+"','01.%m.%Y') startdt,if(cm.status=10 and cm.closedate<=last_day('"+sqltodate+"'),date_format(cm.closedate,'%d.%m.%Y'),date_format(last_day('"+sqltodate+"'),'%d.%m.%Y'))  enddt,r.name from sk_srvcontrm cm left join sk_srvcontrdet d on d.rdocno=cm.tr_no left join (select count(*) skipatsiteqty, rdocno, srno from sk_srvcontrdel del where UPPER(type)='N' group by del.rdocno,del.srno) dd on dd.rdocno=cm.tr_no left join sk_enqrelated r on r.srno=d.servicetermid and r.type='SCHEDULE' where cm.tr_no='"+cnttrno+"' group by cm.tr_no";
    //System.out.println("sql1--->>>"+sql1);                                       
	ResultSet rs1= stmt.executeQuery(sql1);         
	while(rs1.next()){ 
		 startdt=rs1.getString("startdt");
		 enddt=rs1.getString("enddt");
		 skipqty=rs1.getInt("skipatsiteqty");    
		 noofvisit=rs1.getInt("scheduledays");     
		 serviceterm=rs1.getString("name");
		 scheduledays=rs1.getString("scheduledays");
		 
		 if(serviceterm.equalsIgnoreCase("WEEKLY")){
			 int temptrip = 0, t1=0; 
			 t1 = DAO.getTotalTrips(startdt, enddt, noofvisit+"", serviceterm, scheduledays);
			 temptrip = t1/noofvisit;
			 if(temptrip>5){
				 trips = 5*skipqty*noofvisit;    
			 }else{
				 trips = temptrip*skipqty*noofvisit;            
			 }    
		 }else{
			 trips = DAO.getTotalTrips(startdt, enddt, noofvisit+"", serviceterm, scheduledays)*skipqty;   
		 }
	}
	int totsch=0, val = 0; 
	String sql2 = "select count(*) val from sk_srvcontrsch where rdocno="+cnttrno+" and status=1 and month(date)=month('"+sqltodate+"')";
	//System.out.println("sql2--->>>"+sql2);                                       
	ResultSet rs2 = stmt.executeQuery(sql2);         
	while(rs2.next()){ 
		totsch = rs2.getInt("val");  
	}
	if(totsch<trips){
		val = 1;
	}
	response.getWriter().print(val+"####"+trips+"####"+totsch);         
}
catch(Exception e){
	e.printStackTrace();   
}finally{  
	conn.close();  
}
%>