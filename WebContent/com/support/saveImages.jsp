
 <%@page import="sun.misc.BASE64Encoder"%>
 <%@page import="java.io.File"%>
 <%@page import="java.io.FileOutputStream"%>
 <%@page import="java.io.Reader"%> 
 <%@page import="java.util.Random"%>
 <%@page import="javax.servlet.http.HttpServlet"%>
 <%@page import="javax.servlet.http.HttpServletRequest"%>
 <%@page import="javax.servlet.http.HttpServletResponse"%>
 <%@page import=" sun.misc.BASE64Decoder"%> 
 <%@page import="java.sql.Connection"%>
 <%@page import="com.connection.ClsConnection"%>
 <%@page import="com.common.ClsCommon"%>
 <%@page import="java.sql.Statement"%>
 <%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement;"%>
 
 <%
 Connection conn =null;
 ClsConnection ClsConnection=new ClsConnection();

 ClsCommon ClsCommon=new ClsCommon();

 try{
 StringBuffer buffer = new StringBuffer(); 
 Reader reader = request.getReader(); 
 int current; 
 while((current = reader.read()) >= 0)
  buffer.append((char) current); 
  String data = new String(buffer); 
  data = data.substring(data.indexOf(",") + 1);
  
  String code=request.getParameter("formname");
	String doc=request.getParameter("date");
	String userfrmid=request.getParameter("userfrmid").trim();
  String usertoid=request.getParameter("usertoid").trim();
  String srno="";
 
 //System.out.println("===doc====="+doc);
  conn = ClsConnection.getMyConnection();
 
 /* String code="VOP";
 String doc="1";
 String srno="2"; */

 Statement stmt1 = conn.createStatement();
 String strSql1 = "select coalesce(max(asrno)+1,1) as srno from gw_mesngr where userfrm="+userfrmid;
 //System.out.println("====strSql======="+strSql1);
 ResultSet rs1 = stmt1.executeQuery(strSql1);
 while(rs1.next ()) {
	 srno=rs1.getString("srno");
// 	System.out.println("IMGPATH:"+path);
 }
 
 
 
  String fname=code+'-'+doc+'-'+srno;
  String fname2=fname+".png";
 //System.out.println("CODE==="+code);
//  	System.out.println("Code"+getFormdetailcode());
  String dirname ="";
  //System.out.println(dirname);
  String path ="";
  
  Statement stmt = conn.createStatement ();
  String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
  //System.out.println("====strSql======="+strSql);
  ResultSet rs = stmt.executeQuery(strSql);
  String path1="";
  while(rs.next ()) {
  	path1=rs.getString("imgPath");
//  	System.out.println("IMGPATH:"+path);
  }
  path=path1.replace("\\", "/");
 
  ServletContext context = request.getServletContext();
  //String path = context.getRealPath("/");

  File dir = new File(path+ "/attachment/"+code);
  	dir.mkdirs();
  	
  	
  	java.util.Date date=new java.util.Date();
    java.sql.Date sd=ClsCommon.getSqlDate(date);
  	
  	
  	//conn.setAutoCommit(false);
  	String strSqlm = "insert into gw_mesngr(userfrm, userto, mesg, date,attachpath,udate,asrno) values("+userfrmid+",'"+usertoid+"','"+fname2+"','"+sd+"','"+path +"/attachment/"+code+ "/"+ fname2+"','"+date+"','"+srno+"')";
	//System.out.println("strSql======"+strSqlm);
	int rsm = stmt.executeUpdate(strSqlm);
  	
  	
   //System.out.println("PNG imarwrwrwrwrwge data on Base64: " + doc);
    FileOutputStream output = new FileOutputStream(new File(path +"/attachment/"+code+ "/"+ fname2));
     output.write(new BASE64Decoder().decodeBuffer(data));
      output.flush();
       output.close();
 }
 catch(Exception e){
	 e.printStackTrace();
 }
 finally{
	 conn.close();
 }
       
%>
