<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	JSONObject data=new JSONObject();
	JSONObject enqdetails=new JSONObject();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	JSONObject objdata=new JSONObject();  
	Connection conn=null;
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString(); 
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();  
		
		String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
		//System.out.println("--------underwriter----------"+sql1);
		String salesuser="";
		ResultSet resultSet1 = stmt.executeQuery(sql1) ;
		if(resultSet1.next()){
			salesuser=" and sal_id='"+resultSet1.getString("doc_no")+"'";    
		} 
		if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){        
			salesuser+=" and brhid='"+brhid+"'";            
		}
			String strenq="select (select count(*) from gl_enqm where enqstatus=0 and sh_empid=0 and status=3 "+salesuser+") enqsur,(select count(*) from gl_enqm where enqstatus=0 and sh_empid!=0 and status=3"+salesuser+") schenq,(select count(*) from gl_enqm where enqstatus=1 and status=3"+salesuser+") sur,(select count(*) from gl_enqm where enqstatus=2 and status=3"+salesuser+") est,(select count(*) from gl_enqm where enqstatus=3 and status=3"+salesuser+") quot,(select count(*) from gl_enqm where enqstatus<=3 and status=3"+salesuser+") total";
			System.out.println(strenq);    
			String totalcount="0",enqsurcount="0",schenqcount="0",surcount="0",estcount="0",quotcount="0";      
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				totalcount=rsenq.getString("total");  
				enqsurcount=rsenq.getString("enqsur");
				schenqcount=rsenq.getString("schenq");
				surcount=rsenq.getString("sur");
				estcount=rsenq.getString("est");
				quotcount=rsenq.getString("quot");  
			}
			objdata.put("enqschcount",enqsurcount);
			objdata.put("schenqcount",schenqcount);
			objdata.put("surcount",surcount);
			objdata.put("estcount",estcount);
			objdata.put("quotcount",quotcount);
			objdata.put("totalcount",totalcount);     
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