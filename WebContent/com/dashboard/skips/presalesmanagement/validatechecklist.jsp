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
int val=0,valid=0;    
	try{
	 	conn = ClsConnection.getMyConnection();
	 	Statement stmt = conn.createStatement();    
		String qottrno=request.getParameter("qottrno")==null || request.getParameter("qottrno").trim()==""?"0":request.getParameter("qottrno").trim();
	    
		String selectsql="select if(cd.rowno is null,1,0) val from sk_checklist ck left join sk_checklistdet cd on ck.srno=cd.checksrno and cd.qotno='"+qottrno+"' where ck.mandatory=1";
		//System.out.println("selectsql--->>>"+selectsql);    
		ResultSet rs= stmt.executeQuery(selectsql);        
		while(rs.next()){
			val=rs.getInt("val");
			if(val>0){
				valid=1;    
			}
		}
		response.getWriter().print(valid);   
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
