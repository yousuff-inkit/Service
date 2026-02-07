<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>  
<% 
 String groupid =request.getParameter("groupid")==null?"0":request.getParameter("groupid").toString();
 String grpmemberid =request.getParameter("grpmemberid")==null?"0":request.getParameter("grpmemberid").toString();
 String grpempid =request.getParameter("grpempid")==null?"0":request.getParameter("grpempid").toString();
 String assignid =request.getParameter("assignid")==null?"0":request.getParameter("assignid").toString();
 String assigntrno=request.getParameter("assigntrno");   
 String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
 String dtype =request.getParameter("dtype")==null?"0":request.getParameter("dtype").toString();
 String brchid =request.getParameter("brchid")==null?"0":request.getParameter("brchid").toString();
 String desc =request.getParameter("desc")==null?"":request.getParameter("desc").toString();
 String pdate =request.getParameter("pdate")==null?"":request.getParameter("pdate").toString();
 String ptime =request.getParameter("ptime")==null?"":request.getParameter("ptime").toString();
 String vocno =request.getParameter("jobvocno")==null?"":request.getParameter("jobvocno").toString(); 
		 
 Connection conn = null;
 ClsConnection ClsConnection=new ClsConnection();
 ClsCommon ClsCommon=new ClsCommon();  
 int val=0;
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String datecount="";
		String strSql ="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		
		String sql1="";
		if(!(clientid.equalsIgnoreCase("0") || clientid.equalsIgnoreCase("undefined") || clientid.equalsIgnoreCase("") )){
			sql1=" and cldocno="+clientid+"";
		}
		if(!(brchid.equalsIgnoreCase("0") || brchid.equalsIgnoreCase("undefined") || brchid.equalsIgnoreCase("a") )){
			sql1=" and brhid="+brchid+"";
		}
		else{
			brchid="0";
		}
		if(!(pdate.equalsIgnoreCase("0") || pdate.equalsIgnoreCase("undefined") || pdate.equalsIgnoreCase("a") )){
			sdate = ClsCommon.changeStringtoSqlDate(pdate);
		}
		String userid=session.getAttribute("USERID").toString();
		String aa[]=assigntrno.split(","); 
		//System.out.println("==assigntrno===="+assigntrno);    
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("###");    
			 //System.out.println(bb[0]+"<<<---->>>"+bb[1]);    
			 String tr_no=bb[0];  
			 String refdocno=bb[1]; 
			 strSql = "update cm_servplan set status=4,empGroupId="+groupid+", empId="+grpempid+", asgnMode="+assignid+" ,remarks='"+desc+"',plannedon='"+sdate+"',date='"+sdate+"',pltime='"+ptime+"' where TR_NO="+tr_no+" and refdocno="+refdocno+" and dTYPE='"+dtype+"' "+sql1+"";      
			 //System.out.println("strSqlqq===="+strSql);  
			 val = stmt.executeUpdate(strSql); 
			 
			 if(val>0){
				 String sqlassign="insert into cm_srvassign (brhid,refDocNo, empGroupId, empId, asgnMode, plannedOn, plTime, description) values ('"+brchid+"','"+refdocno+"',"+groupid+","+grpempid+","+assignid+",'"+sdate+"','"+ptime+"','"+desc+"')";
				 //System.out.println("sqlassign===="+sqlassign);    
				 val = stmt.executeUpdate(sqlassign);    
			}
		  }
		  //System.out.println("====val===="+val);  
		  if(val>0){
			     String logdesc="Assignment -"+assigntrno;                   
				 String sqllog="insert into gl_jobactivitylog(doc_no, brhId, dtype, edate, userId,description) values("+vocno+",'"+brchid+"','AMCM',now(),'"+session.getAttribute("USERID")+"','"+logdesc+"')";                       
				 //System.out.println("====sqllog===="+sqllog);  
				 val=stmt.executeUpdate(sqllog);
		  }
		  //System.out.println("====val===="+val);     
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
  