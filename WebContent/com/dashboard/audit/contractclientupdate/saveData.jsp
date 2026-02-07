<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
	Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
	try{
	 	 conn = ClsConnection.getMyConnection();
		 Statement stmt=conn.createStatement();
		 String trno = request.getParameter("trno")==null || request.getParameter("trno").trim().equals("")?"0":request.getParameter("trno");
		 String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").trim().equals("")?"0":request.getParameter("cldocno");  
		 String acno = request.getParameter("acno")==null || request.getParameter("acno").trim().equals("")?"0":request.getParameter("acno");  
		
		 int val = 0;
		 
		 String sqlup = "update cm_srvcontrm cm left join cm_servplan p on cm.tr_no=p.doc_no and cm.dtype=p.dtype left join cm_compcert cc on cm.tr_no=cc.rdocno and cm.dtype=cc.dtype left join my_servm m on m.costid=cm.tr_no left join my_serpvm pm on pm.costid=cm.tr_no left join my_servretm rm on rm.rtrno=m.tr_no left join cm_cuscallm cl on cm.tr_no=cl.contractno and cm.dtype=cl.contracttype left join cm_servplan pc on cl.tr_no=pc.doc_no and cl.dtype=pc.dtype left join cm_srvdetm dm on (dm.schrefdocno=p.tr_no or dm.schrefdocno=pc.tr_no) left join my_jvtran j1 on j1.tr_no=m.tr_no and m.cldocno=j1.cldocno left join my_jvtran j2 on j2.tr_no=rm.tr_no and rm.cldocno=j2.cldocno left join my_jvtran j3 on j3.tr_no=pm.tr_no and pm.cldocno=j3.cldocno set cm.cldocno='"+cldocno+"',cc.cldocno='"+cldocno+"',p.cldocno='"+cldocno+"',m.cldocno='"+cldocno+"',pm.cldocno='"+cldocno+"',rm.cldocno='"+cldocno+"',cl.cldocno='"+cldocno+"',pc.cldocno='"+cldocno+"',dm.cldocno='"+cldocno+"',j1.cldocno='"+cldocno+"',j2.cldocno='"+cldocno+"',j3.cldocno='"+cldocno+"',m.acno='"+acno+"',pm.acno='"+acno+"',dm.acno='"+acno+"',j1.acno='"+acno+"',j2.acno='"+acno+"',j3.acno='"+acno+"' where cm.tr_no='"+trno+"'";
          //System.out.println(sqlup);        
		 val = stmt.executeUpdate(sqlup);  	
	 
		 if(val>0){
			 String logsql = "insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+trno+"','"+session.getAttribute("BRANCHID").toString()+"','CCU',now(),'"+session.getAttribute("USERID").toString()+"','E')";
			 val= stmt.executeUpdate(logsql);    
		 }
		 
	     response.getWriter().print(val);
	 	 stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();	
   }finally{
	   conn.close();
   }
%>