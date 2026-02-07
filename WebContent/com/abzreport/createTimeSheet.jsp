<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="userlogin.ClsUserLoginDAO"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>     
<%	

	ClsConnection connDAO=new ClsConnection();
	ClsCommon commonDAO=new ClsCommon();                         
	ClsUserLoginDAO DAO= new ClsUserLoginDAO();                      
	Connection conn = null;
	java.sql.Date sqlDate=null;
	String latittude=request.getParameter("latittude")==null?"":request.getParameter("latittude");     
	String longitude=request.getParameter("longitude")==null?"":request.getParameter("longitude");     
	String month=request.getParameter("month")==null?"":request.getParameter("month").trim().toString();
	String year=request.getParameter("year")==null?"":request.getParameter("year").trim().toString();
	String costid=request.getParameter("costid")==null || request.getParameter("costid")==""?"0":request.getParameter("costid").trim().toString();
	String costcode=request.getParameter("costcode")==null || request.getParameter("costcode")==""?"0":request.getParameter("costcode").trim().toString();
	String empid=request.getParameter("empid")==null?"0":request.getParameter("empid").trim().toString();
	String date=request.getParameter("date")==null?"0":request.getParameter("date").trim().toString();
	String intime=request.getParameter("intime")==null?"":request.getParameter("intime").trim().toString();
	String outtime=request.getParameter("outtime")==null?"":request.getParameter("outtime").trim();
	String normalhrs=request.getParameter("normalhrs")==null?"":request.getParameter("normalhrs").trim(); 
	String tsrowno=request.getParameter("tsrowno")==null?"":request.getParameter("tsrowno").trim();                   
	try{                                          
		ArrayList<String> timesheetarray=new ArrayList<String>();      
		String branch=session.getAttribute("BRANCHID").toString().trim();
		String sql=null,costperhr="";
		int val=0;
	 	conn=connDAO.getMyConnection();
	 	Statement stmt=conn.createStatement();                     
		if(!date.equalsIgnoreCase("0") && !date.equalsIgnoreCase("")){   
			sqlDate = commonDAO.changeStringtoSqlDate(date); 
		}
		String emparray[]=empid.split(",");  
		for(int i=0;i<emparray.length;i++){   
			String strSql = "select round(m.costperhour,2) costperhour from hr_empm m  where m.doc_no='"+emparray[i]+"'";   
			ResultSet rs = stmt.executeQuery(strSql);      
			while(rs.next()) {
				costperhr=rs.getString("costperhour");      
		  		}  
			timesheetarray.add(emparray[i]+"::"+date+" :: "+costid+" :: "+costcode+" :: "+normalhrs+" :: "+""+" :: "+""+" :: "+intime+" :: "+outtime+" :: "+costperhr+" :: ");
		}
		System.out.println("timesheetarray==== "+timesheetarray);   
		if(!tsrowno.equalsIgnoreCase("")){                     
			val=DAO.edit(tsrowno, branch, year, month, timesheetarray, session, request, "E");   
		}else{
			val=DAO.insert(branch, year, month, timesheetarray, session, request, "A");
		}
		if(val>0){
			val=1;          
		}
        response.getWriter().print(val);             

	 	conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>

