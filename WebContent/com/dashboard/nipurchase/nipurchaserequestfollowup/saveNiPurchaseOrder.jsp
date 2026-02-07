<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchaseorder.ClsnipurchaseorderDAO" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %> 
<%ClsnipurchaseorderDAO DAO=new ClsnipurchaseorderDAO();%>

<%	

String docdate=request.getParameter("docdate")==null?"":request.getParameter("docdate");
String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
String accdocno=request.getParameter("accdocno")==null?"":request.getParameter("accdocno");
String curr=request.getParameter("curr")==null?"":request.getParameter("curr");
String currate=request.getParameter("currate")==null?"":request.getParameter("currate");
int producttype=request.getParameter("producttype")==null?0:Integer.parseInt(request.getParameter("producttype"));
Double nettotal=request.getParameter("nettotal")==null?0:Double.parseDouble(request.getParameter("nettotal"));
String reqrefno=request.getParameter("reqrefno")==null?"":request.getParameter("reqrefno");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
String vocno="";
	Connection conn = null;

	try{
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO=new ClsCommon();
	 	conn = connDAO.getMyConnection();
	 	conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();

		java.sql.Date sqlStartDate = commonDAO.changeStringtoSqlDate(docdate);
		
		ArrayList<String> masterarray= new ArrayList<String>();
		String aa[]=gridarray.split(",");
		for(int i=0;i<aa.length;i++){
			 String bb[]=aa[i].split("::");
			 String temp="";
			 for(int j=0;j<bb.length;j++){ 
				 temp=temp+bb[j]+"::";
			 }
			 masterarray.add(temp);
		}

		session.setAttribute("BRANCHID",brhid);
		int val=DAO.insert(sqlStartDate,sqlStartDate,"","AP",accdocno,"",curr,currate,"","",desc,session,"A",nettotal,masterarray,"NPO",request,producttype,"NRQ",reqrefno);
		if(val>0){
			String sqlBiblog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY) values("+val+","+brhid+",'NRQF',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E')";
			val = stmt.executeUpdate(sqlBiblog);
			vocno=request.getAttribute("vocno").toString();
		}else{
			System.out.println("NI Purchase Order Create Error");
		}
		
		if(val>0){    
			conn.commit();  
			conn.close();    
		}
	
		response.getWriter().print(val+"#"+vocno);
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  