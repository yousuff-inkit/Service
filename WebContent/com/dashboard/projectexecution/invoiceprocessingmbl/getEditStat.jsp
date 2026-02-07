<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    String rowno=request.getParameter("rowno")==null || request.getParameter("rowno")==""?"0":request.getParameter("rowno");     
    Connection conn = null;      
try{	
	ClsConnection ClsConnection=new ClsConnection();
	conn= ClsConnection.getMyConnection();  
	Statement stmt = conn.createStatement ();  
	int val=0,val1=0,val2=0,val3=0,val4=0;   
	String strSql1 = "select pd.rowno from cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where pd.dueafser=98 and invtrno=0 and pd.rowno='"+rowno+"'";         
	//System.out.println("strSql1---->>>"+strSql1);     
	ResultSet rs1 = stmt.executeQuery(strSql1);         
	while(rs1.next()) {         
		  val1=rs1.getInt("rowno");    
  	}     
	
	String strSql2 = "select pd.rowno from cm_srvcontrpd pd  inner join cm_srvcontrm m  on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 and pd.rowno='"+rowno+"'";         
	//System.out.println("strSql2---->>>"+strSql2);     
	ResultSet rs2 = stmt.executeQuery(strSql2);         
	while(rs2.next()) {         
		  val2=rs2.getInt("rowno");    
  	} 
	
	String strSql3 = "select pd.rowno from  cm_srvcontrpd pd inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno  where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5  and s.dtype='sjob' and pd.rowno='"+rowno+"'";         
	//System.out.println("strSql3---->>>"+strSql3);     
	ResultSet rs3 = stmt.executeQuery(strSql3);         
	while(rs3.next()) {         
		  val3=rs3.getInt("rowno");    
  	} 
	
	String strSql4 = "select pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1 and pd.rowno='"+rowno+"'";         
	//System.out.println("strSql4---->>>"+strSql4);       
	ResultSet rs4 = stmt.executeQuery(strSql4);         
	while(rs4.next()) {         
		  val4=rs4.getInt("rowno");       
  	} 
	if(val1>0 || val2>0 || val3>0 || val4>0){   
		val=1;   
	}
    System.out.println("val---->>>"+val);  
	stmt.close();
	conn.close();  

	response.getWriter().print(val);          
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
	%>