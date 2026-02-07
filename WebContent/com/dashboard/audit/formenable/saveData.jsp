<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	

	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		String docno=request.getParameter("docno");
		String path=request.getParameter("path")==""?"":request.getParameter("path");
		String printpath=request.getParameter("printpath")==""?"":request.getParameter("printpath");
		String printpath2=request.getParameter("printapth2")==""?"":request.getParameter("printpath2");
		String rpttype=request.getParameter("rpttype");
		String gate=request.getParameter("gate");
		String chk=request.getParameter("chk");

		String sql=null;
		int val=0;
	System.out.println("chk=="+chk);
		 /*Linking Salesman with User */
		 if(rpttype.equalsIgnoreCase("0")) {
			 if(chk.equalsIgnoreCase("1"))
			 {
			 if(!(path.equalsIgnoreCase("") || path.equalsIgnoreCase(null)))
			 {
    	 	sql="update gl_bibd  set path='"+path+"' where  doc_no="+docno+"";
    	 	System.out.println("sql01="+sql);
     	 	val= stmt.executeUpdate(sql);
			 }
			 if(!(printpath.equalsIgnoreCase("") || printpath.equalsIgnoreCase(null)))
			 {
				 sql="update gl_bibd  set printpath='"+printpath+"' where  doc_no="+docno+"";  
		    	 	System.out.println("sql02="+sql);
	
				 val= stmt.executeUpdate(sql);
			 }
			 }
			 else
			 {
				 if(!(gate.equalsIgnoreCase("") || gate.equalsIgnoreCase(null)))
			 {
				
				 sql="update gl_bibd  set status='"+gate+"' where  doc_no="+docno+"";  
	
				 val= stmt.executeUpdate(sql);
		    	 	System.out.println("sql02="+sql);

			 }
			 }
		 }
		 /*Linking Salesman with User Ends*/
		 
		 /*Remove Linking Salesman with User */
		 if(rpttype.equalsIgnoreCase("1")) {
			 if(chk.equalsIgnoreCase("1"))
			 {
				 if(!(path.equalsIgnoreCase("") || path.equalsIgnoreCase(null)))
			 {
    	 	sql="update my_menu  set func='"+path+"' where  mno="+docno+"";
    	 	System.out.println("sql11="+sql);

     	 	val= stmt.executeUpdate(sql);
			 }
				 if(!(printpath.equalsIgnoreCase("") || printpath.equalsIgnoreCase(null)))
			 {
				 sql="update my_menu  set printpath='"+printpath+"' where  mno="+docno+"";  
		    	 	System.out.println("sql12="+sql);

		     	 	val= stmt.executeUpdate(sql);
			 }
				 if(!(printpath2.equalsIgnoreCase("") || printpath2.equalsIgnoreCase(null)))
			 {
				 sql="update my_menu  set printpath2='"+printpath2+"' where  mno="+docno+"";   
		    	 	System.out.println("sql13="+sql);
		     	 	val= stmt.executeUpdate(sql);
			 }
			 }
			 else
			 {
				 if(!(gate.equalsIgnoreCase("") || gate.equalsIgnoreCase(null)))
			 {
				
				 sql="update my_menu  set gate='"+gate+"' where  MNO="+docno+"";  
		    	 	System.out.println("sql001="+sql);
		     	 	val= stmt.executeUpdate(sql);

				
			 }
			 }
		 }
		 /*Remove Linking Salesman with User Ends*/
		 				
		response.getWriter().print(val);

	 	stmt.close();
	 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
	
%>
