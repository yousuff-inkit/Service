<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>    
<%@page import="javax.servlet.http.HttpServletRequest"%>  
<%@page import="org.apache.struts2.ServletActionContext"%>    
<%
	JSONObject data=new JSONObject();
	JSONObject enqdetails=new JSONObject();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	JSONObject objdata=new JSONObject();  
	HttpServletRequest request2=ServletActionContext.getRequest();  
	HttpSession sessions=request2.getSession();     
	Connection conn=null;
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString(); 
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+sessions.getAttribute("USERID")+"'";  
		System.out.println("--------underwriter----------"+sql1);  
		String salesuser="";
		ResultSet resultSet1 = stmt.executeQuery(sql1) ;
		if(resultSet1.next()){
			salesuser=" and m.sal_id='"+resultSet1.getString("doc_no")+"'";        
		} 
		if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){          
			salesuser+=" and m.brhid='"+brhid+"'";            
		}
		String strenq="select (select count(*) from cm_prosclientm m where status=3 "+salesuser+") pros,(select count(*) from gl_enqm m where status=3 and enqstatus in(0,1) and m.cntrtrno=0 "+salesuser+") enq,(select count(*) from cm_srvqotm m left join gl_enqm e on e.doc_no=m.refdocno and m.ref_type='ENQ' where m.status!=7 and e.enqstatus=3 and m.quotstatus=0 and m.cntrtrno=0 "+salesuser+") quot,(select count(*) from cm_appoinment m where cancelstatus=0) appnt";
		System.out.println(strenq);    
			String enqcount="0",proscount="0",quotcount="0",appntcount="0";            
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				enqcount=rsenq.getString("enq");  
				proscount=rsenq.getString("pros");
				quotcount=rsenq.getString("quot");
				appntcount=rsenq.getString("appnt");    
			}
			objdata.put("proscount",proscount);
			objdata.put("enqcount",enqcount);
			objdata.put("quotcount",quotcount);
			objdata.put("appntcount",appntcount);  
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	//System.out.println(enqdetails);  
	response.getWriter().print(objdata);           
%>