<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<%
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
int val=0;
Connection conn=null;
try{	 
	String cldocnos=request.getParameter("cldocnos")==null?"":request.getParameter("cldocnos").trim();  
	String telesalesid=request.getParameter("telesalesid")==null || request.getParameter("telesalesid").trim()==""?"0":request.getParameter("telesalesid").trim();
	ArrayList<String> clientarray=new ArrayList<String>();
	if(cldocnos.contains(":")){
		String [] cldocno=new String []{};
		cldocno=cldocnos.split(":");
		for(int i=0;i<cldocno.length;i++){  
			clientarray.add(i, cldocno[i]);
		}
	}
	else{
		clientarray.add(0, cldocnos);    
	}
	
	conn=ClsConnection.getMyConnection();
	Statement stmt=conn.createStatement(); 
	conn.setAutoCommit(false);
	for(int i=0;i<clientarray.size();i++){   
		String strsql="update my_acbook set telesalesid='"+telesalesid+"' where doc_no="+clientarray.get(i);    
		//System.out.println("strsql==="+strsql);
		val=stmt.executeUpdate(strsql);
    }
	if(val>0){
    	conn.commit();   
	}
	response.getWriter().print(val);  
}
catch(Exception e1){
	e1.printStackTrace();
}
finally{
	conn.close();
}

%>
  
