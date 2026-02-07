<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>  
<%
    String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno");    
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0,invoiced=0,val2=0,val3=0,val4=0;       
	String witheffectdate = "";
	int revno = 0;
	
	/* String strSql = "select invoiced from sk_srvcontrm where tr_no='"+trno+"'";      
	ResultSet rs = stmt.executeQuery(strSql);         
	while(rs.next()) {         
		invoiced = rs.getInt("invoiced");  
  	}  */      
	if(invoiced>0){   
		// val=1;    
	 }
	String strSql2 = "select revision_no,status from sk_srvcontrm where tr_no='"+trno+"'";  // and revision_no!=0   
	//System.out.println("strSql2---->>>"+strSql2);  
	ResultSet rs2 = stmt.executeQuery(strSql2);           
	if(rs2.next()) {     
		revno = rs2.getInt("revision_no");    
		//val4 = rs2.getInt("status");           
  	} 
	if(revno>0){   
		val2 = 1;  
	}
	int stat = 0;
	String strSql3 = "select coalesce(status,0) status, witheffect from sk_srvcontrrenew where cnttrno='"+trno+"' and revision_no=0 ORDER BY doc_no DESC LIMIT 1";       
	//System.out.println("strSql3---->>>"+strSql3);       
	ResultSet rs3 = stmt.executeQuery(strSql3);                
	if(rs3.next()) {     
		stat = rs3.getInt("status");   
		witheffectdate = rs3.getString("witheffect");   
  	} 
	if(stat==1){
		val3=1;
	}
	stmt.close();
	//System.out.println("witheffectdate---->>>"+witheffectdate);    
	response.getWriter().print(val+"####"+val2+"####"+val3+"####"+witheffectdate+"####"+val4);              
}
catch(Exception e){
	e.printStackTrace();
}finally{
	conn.close();  
}
	%>