<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="java.awt.Desktop"%>
<%@page import="java.io.File"%>  


<%
		String filepath=request.getParameter("filepath")==null?"":request.getParameter("filepath");
		System.out.println("==filepath==="+filepath);
		String newpath=filepath.replace(';', '\\');
		System.out.println("==newpath==="+newpath);
	     if (Desktop.isDesktopSupported()) {
	       Desktop.getDesktop().open(new File(newpath));
	     }
  %>