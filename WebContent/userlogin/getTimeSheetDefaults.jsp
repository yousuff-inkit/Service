<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%
    String costtype=request.getParameter("costtype")==null?"0":request.getParameter("costtype");
    String employee=request.getParameter("employee")==null?"0":request.getParameter("employee");
    String costcode=request.getParameter("costcode")==null?"0":request.getParameter("costcode");
   /*  String intimes=request.getParameter("intime")==null?"":request.getParameter("intime");      
    String dates=request.getParameter("date")==null?"":request.getParameter("date");     */   
    Connection conn = null; 
    java.sql.Date sqldate=null;
try{	   
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();    
	Statement stmt = conn.createStatement (); 
	ClsCommon ClsCommon =new ClsCommon();
	/* if(!dates.equalsIgnoreCase("")){    
		sqldate=ClsCommon.changeStringtoSqlDate(dates);	
	} */
	int val=0;
	String rowno="",intime="",date="",dates="";      
	String strSql = "select  rowno,intime,date_format(date,'%m/%d/%Y') date,date dates from hr_timesheethrs where empid in("+employee+") and costcode='"+costcode+"' and costtype='"+costtype+"' and outtime=''";  
	//System.out.println("======= "+strSql);               
	ResultSet rs = stmt.executeQuery(strSql);                                 
	while(rs.next()) {         
		   rowno=rowno+rs.getString("rowno")+",";                    
		   intime=rs.getString("intime");        
		   date=rs.getString("date"); 
		   dates=rs.getString("dates");     
		   val=1;    
  	} 
	if(val==0){
		String strSql2 = "select rowno,intime from hr_timesheethrs where empid in("+employee+") and outtime=''";  
	    //System.out.println("======= "+strSql2);                     
		ResultSet rs2 = stmt.executeQuery(strSql2);                                     
		while(rs2.next()) {         
			   val=2;                      
	  	}	
	}
	if(val==1){    
		String strSql2 = "select rowno from hr_timesheethrs where  date='"+dates+"' and  intime='"+intime+"' and empid in("+employee+") and costcode='"+costcode+"' and costtype='"+costtype+"'  and outtime!=''";          
	    //System.out.println("======= "+strSql2);                        
		ResultSet rs2 = stmt.executeQuery(strSql2);                                        
		while(rs2.next()) {           
			   val=3;                      
	  	}
		String rownoarray[]=employee.split(",");              
		for(int i=0;i<rownoarray.length;i++){    
			 String strSql3="select rowno from hr_timesheethrs where  date='"+dates+"' and  intime='"+intime+"' and empid="+rownoarray[i]+" and costcode='"+costcode+"' and costtype='"+costtype+"'";
			 //System.out.println("======= "+strSql3); 
			 ResultSet rs3 = stmt.executeQuery(strSql3);       
			 if(rs3.next()){
			 }else{
				 val=2; 
			 }
		}
	}
	stmt.close();   
	conn.close();      

	response.getWriter().print(val+"###"+rowno+"###"+intime+"###"+date);                  
}  
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>