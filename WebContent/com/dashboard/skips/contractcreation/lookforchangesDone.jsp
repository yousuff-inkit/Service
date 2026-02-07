<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
int val=0,qotno=0,cntno=0;    
	try{
	 	conn = ClsConnection.getMyConnection();
	 	Statement stmt = conn.createStatement();    
		String docno=request.getParameter("docno")==null || request.getParameter("docno").trim()==""?"0":request.getParameter("docno").trim();
		String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
		System.out.println("process--->>>"+processid+"===docno==="+docno);       
	    
		if(processid.equalsIgnoreCase("Look Changes")){         
			 
			 String selectsql="select coalesce(q.tr_no,0) qotno,coalesce(c.tr_no,0) cntno from gl_enqm m left join sk_srvqotm q on q.refdocno=m.doc_no and q.refdtype='ENQ' left join sk_srvcontrm c on c.refdocno=m.doc_no and c.refdtype='ENQ' where m.status<>7 and m.doc_no='"+docno+"'";  
			 //System.out.println("selectsql--->>>"+selectsql);    
			 ResultSet rs= stmt.executeQuery(selectsql);        
		     while(rs.next()){
		    	 qotno=rs.getInt("qotno");
		    	 cntno=rs.getInt("cntno");   
		     }
	    }else{}            
		 response.getWriter().print(qotno+"####"+cntno);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
