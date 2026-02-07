<%@page import="com.common.ClsAttachmaster"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
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
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="com.common.ClsCommon"%>
<%
	int errorstatus=0;
	ClsConnection objconn=new ClsConnection();
	StringBuffer buffer = new StringBuffer(); 
	ClsCommon ClsCommon=new ClsCommon();
 	Reader reader = request.getReader(); 
 	int current; 
 	while((current = reader.read()) >= 0)
  		buffer.append((char) current);
  	String data = new String(buffer);
  	data = data.substring(data.indexOf(",") + 1);
  	String code=request.getParameter("formname");
  	String userid=session.getAttribute("USERID")==null?"0":session.getAttribute("USERID").toString();
	String signindex=request.getParameter("signindex");
  
	String email=request.getParameter("email")==null?"":request.getParameter("email").toString();
  	String name=request.getParameter("name")==null?"":request.getParameter("name");
	String visit=request.getParameter("visit")==null?"":request.getParameter("visit");
	String type=request.getParameter("type")==null?"":request.getParameter("type");
	String roomno=request.getParameter("roomno")==null?"":request.getParameter("roomno");
	String date=request.getParameter("date")==null?"":request.getParameter("date");   
	String time=request.getParameter("time")==null?"":request.getParameter("time");     
	String mob=request.getParameter("mob")==null?"":request.getParameter("mob");       
  	
	String srno="0",doc="0";   
  	Connection conn =null;
 	try{
  		conn = objconn.getMyConnection();
  	  	conn.setAutoCommit(false);
  		Statement stmt = conn.createStatement();
  		 java.sql.Date sqldate = null;
	     	if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	     	{
	     		sqldate=ClsCommon.changeStringtoSqlDate(date);
	     	}
  		String strmaxdoc1 = "select coalesce(max(doc_no)+1,1) docno from rl_guestregm";
		ResultSet rsmaxdoc1 = stmt.executeQuery(strmaxdoc1);
		while(rsmaxdoc1.next()){
			doc=rsmaxdoc1.getString("docno");  
		}
  		
  		
		String strmaxdoc = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no="+doc+" and dtype='CGR'";     
		System.out.println("Max Doc No"+strmaxdoc);
		ResultSet rsmaxdoc = stmt.executeQuery(strmaxdoc);
		while(rsmaxdoc.next()){
			srno=rsmaxdoc.getString("srno");
		}
  		String fname="CGR"+'-'+doc+'-'+srno;    
  		String fname2=fname+".png";
  		String dirname ="";
  		String path ="";
  		String strSql = "select imgPath from my_comp where doc_no=1";
  		ResultSet rs = stmt.executeQuery(strSql);
  		String path1="";
  		while(rs.next ()) {
  			path1=rs.getString("imgPath");
		}
  		path=path1.replace("\\", "/");
 		File dir = new File(path+ "/attachment/CGR");
  		dir.mkdirs();
  	
		CallableStatement stmtAttach = conn.prepareCall("{CALL fileAttach(?,?,?,?,?,?,?,?,?)}");
		stmtAttach.registerOutParameter(9, java.sql.Types.INTEGER);
		stmtAttach.setString(1,"CGR");
		stmtAttach.setString(2,doc);
		stmtAttach.setString(3,"1");
		stmtAttach.setString(4,"1");
		stmtAttach.setString(5,path+"//attachment//VIP//"+fname2);
		stmtAttach.setString(6,fname2);
		stmtAttach.setString(7,"");
		stmtAttach.setString(8,"0");     
		stmtAttach.executeQuery();
		int no=stmtAttach.getInt("srNo");
		if(no<=0){
			errorstatus=1;
		}
		String check=path+"//attachment//CGR//"+ fname2;
		String strsignature="";
		System.out.println("Sign Index:"+signindex+"//");
		
		strsignature="insert into rl_guestregm(doc_no, name, mob, email, type, roomno, visit, date, time, path, status)  values("+doc+",'"+name+"','"+mob+"','"+email+"','"+type+"','"+roomno+"','"+visit+"','"+sqldate+"','"+time+"','"+path+"/attachment/CGR/"+fname2+"',3)";
		System.out.println(strsignature);
		int savesign=stmt.executeUpdate(strsignature);
		if(savesign<=0){
			errorstatus=1;
		}
		String strl="",docn="";
  		String imageString = data;  
		byte byteArray[] = new byte[1000000];
		FileOutputStream fos = new FileOutputStream(path +"/attachment/CGR/"+ fname2);        
		byteArray = Base64.decodeBase64(imageString);
		fos.write(byteArray);
		fos.flush();
		fos.close();
		if(no>0 && errorstatus==0){
			conn.commit();
		}
	}
	catch(Exception e){
		e.printStackTrace();
		errorstatus=1;
	}
	finally{
		conn.close(); 
	}
response.getWriter().write(errorstatus+"");
%>
