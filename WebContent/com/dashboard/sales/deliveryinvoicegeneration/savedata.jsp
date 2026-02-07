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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO" %>

<%ClsConnection ClsConnection=new ClsConnection();
ClsSalesInvoiceDAO DAO =new ClsSalesInvoiceDAO();
ClsCommon ClsCommon=new ClsCommon();
int resultSet4 =0;
String list=request.getParameter("list")==null?"0":request.getParameter("list");
String list1=request.getParameter("list1")==null?"0":request.getParameter("list1");




String duedate=request.getParameter("duedate")==null?"0":request.getParameter("duedate");
 
String dates=request.getParameter("date")==null?"0":request.getParameter("date");
String masterdocno=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
String branchvals=request.getParameter("branchvals")==null?"0":request.getParameter("branchvals");
String refnos=request.getParameter("refnos")==null?"0":request.getParameter("refnos");
String description=request.getParameter("description")==null?"0":request.getParameter("description");
String locationid=request.getParameter("locationid")==null?"1":request.getParameter("locationid");

String clntacno=request.getParameter("clntacno")==null?"0":request.getParameter("clntacno");
String vatype=request.getParameter("vatype")==null?"1":request.getParameter("vatype");

/*   System.out.println("===list====="+list);
  System.out.println("===list1====="+list1);

System.out.println("===dates====="+dates);
System.out.println("===masterdocno====="+masterdocno);
System.out.println("===branchvals====="+branchvals);
System.out.println("===refnos====="+refnos);
System.out.println("===description====="+description);
System.out.println("===locationid====="+locationid);  */ 

ArrayList<String> mainarray= new ArrayList<String>();
String aa[]=list.split(",");

java.sql.Date date=ClsCommon.changeStringtoSqlDate(dates);

java.sql.Date duedate1=ClsCommon.changeStringtoSqlDate(duedate);


 
String doc="0"; 

int cmbbilltype=1;



for(int k=0;k<aa.length;k++){
	 
	 String bb[]=aa[k].split("::");
	  
	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
		 
	 
		 temp=temp+bb[j]+"::";
		 
	}
	 mainarray.add(temp);
	 
} 
ArrayList<String> mainarray2= new ArrayList<String>();
ArrayList<String> mainarray3= new ArrayList<String>();
ArrayList<String> mainarray4= new ArrayList<String>();
ArrayList<String> mainarray1= new ArrayList<String>();
String aa1[]=list1.split(",");



for(int k1=0;k1<aa1.length;k1++){
	
	
 
	 String bb1[]=aa1[k1].split("::");
	  
	 String temp1="";
	 for(int j1=0;j1<bb1.length;j1++){ 
		 
	 
		 temp1=temp1+bb1[j1]+"::";
		 
	}
	 mainarray1.add(temp1);
	 
} 




	  Connection conn=null;
	    String sql="";
	    try
	    {
	   	
	    conn = ClsConnection.getMyConnection();
	 
		
		
	    Statement st=conn.createStatement();
	    int loc=Integer.parseInt(locationid);
	    int acnom=0;
	    int curr=1;
	    int clientid=0;
	    double currate=0,nettax=0;
	    String prodamt="",dis="",finalamt="",nettotal="";
	    String ordsql="select  acno,cldocno,curid,rate from my_delm where doc_no in("+masterdocno+") ";
	  //  System.out.println("===ordsql====="+ordsql);
	    ResultSet rss=st.executeQuery(ordsql);
	    
	    if(rss.next())
	    {
	    	clientid=rss.getInt("cldocno");
	    	curr=rss.getInt("curid");
	    	acnom=rss.getInt("acno");
	    	currate=rss.getInt("rate");
	    }
	    
	    String ordsql1="select  sum(amount),sum(total)total,sum(discount)dis,sum(nettotal)nettotal,sum(taxamount)nettax,sum((qty*amount)-discount+taxamount)finalamt from my_deld where rdocno in("+masterdocno+") ";
		    System.out.println("===ordsql====="+ordsql1);
		    ResultSet rss1=st.executeQuery(ordsql1);
		    
		    if(rss1.next())
		    {
		    	prodamt=rss1.getString("total");
		    	dis=rss1.getString("dis");
		    	nettax=rss1.getDouble("nettax");
		    	finalamt=rss1.getString("finalamt");
		    	nettotal=rss1.getString("nettotal");
		    }
	    
	    
	    
	   int val= DAO.insert(date, refnos, "0", "1", "1", 0, clientid, masterdocno, "DEL", "0", description, prodamt, dis, nettotal, "0", "0", finalamt, "A", "INV", mainarray, mainarray2, mainarray3, session, request, masterdocno, "0", date, loc, "credit", "0", mainarray4, 0, 0.0, 0.0, 0.0, 0.0, nettax, cmbbilltype, "0", "0", vatype, clntacno);
	   int vdoc=Integer.parseInt(request.getAttribute("vdocNo").toString());
	   response.getWriter().print(val+"::"+vdoc);
	  									
	
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().print(0);
    }
	 	
	 	
	 	
%>



 