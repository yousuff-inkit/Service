<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String result="";
Connection conn=null;   
String type = request.getParameter("type")==null?"":request.getParameter("type").trim().toString(); 
String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim().toString();   
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();
java.sql.Date sqlfromdate = null;
java.sql.Date sqltodate = null;
try{
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	ClsCommon objcommon=new ClsCommon(); 
	Statement stmt=conn.createStatement();
	String sqltest="";  
	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
  	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
    }else{}
    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
      sqltodate=objcommon.changeStringtoSqlDate(todate);
    } else{}
    String strcountdata="";
	if(type.equalsIgnoreCase("1")) {   
		 strcountdata="select (select count(*) from sk_triptotal t left join sk_tippingdet td on t.srno=td.totsrno left join sk_invm m on m.doc_no=td.invno where ddate between '"+sqlfromdate+"' and '"+sqltodate+"' and m.doc_no is not null) invoiced, (select count(*) from sk_triptotal t left join sk_tippingdet td on t.srno=td.totsrno left join sk_invm m on m.doc_no=td.invno where ddate between '"+sqlfromdate+"' and '"+sqltodate+"' and m.doc_no is null) notinvoiced";
	}else{
		 strcountdata="select (select count(*) from(select t.srno from sk_triptotal t left join sk_tippingdet td on t.srno=td.totsrno left join sk_invm m on m.doc_no=td.invno where ddate between '"+sqlfromdate+"' and '"+sqltodate+"' and m.doc_no is not null group by t.contractno)a) invoiced, (select count(*) from(select t.srno from sk_triptotal t left join sk_tippingdet td on t.srno=td.totsrno left join sk_invm m on m.doc_no=td.invno where ddate between '"+sqlfromdate+"' and '"+sqltodate+"' and m.doc_no is null group by t.contractno)a) notinvoiced";
	}
	//System.out.println("===COUNT===="+strcountdata);         
	ResultSet rs=stmt.executeQuery(strcountdata);  
	while(rs.next()){       
		result=rs.getString("invoiced")+"####"+rs.getString("notinvoiced");            
	}   
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(result);
%>