
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
int method=0;	ClsConnection ClsConnection=new ClsConnection();

Connection conn = null;

try
{

  conn = ClsConnection.getMyConnection();

Statement stmt=conn.createStatement();

String chk="select method from gl_config where field_nme='firecoprojectinvoiceprint'";

//System.out.println("===chk==="+chk);

ResultSet rs=stmt.executeQuery(chk); 
int foc=0;
int kg=0;
int i=0;
int freq=0;
while(rs.next())
{
	foc=rs.getInt("method");
	System.out.println("------"+foc);
	
}
String freqchk="select method from gl_config where field_nme='mmjPrintDetailFreq'";
ResultSet freqrs=stmt.executeQuery(freqchk);
if(freqrs.next()){
	freq=1;
}

 //  System.out.println("--xxxxxxx---foc----"+foc+"---kg---"+kg);
 response.getWriter().write(foc+"####"+freq);
	//response.getWriter().print(foc);
	stmt.close();
	conn.close();
}
catch(Exception e)
{
	conn.close();
}

  %>
  













					