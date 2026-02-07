<%@page import="com.common.ClsCommon"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%
String result="";
int errorstatus=0;
Connection conn = null;
JSONObject objdata=new JSONObject(); 
String type=request.getParameter("loadtype")==null?"":request.getParameter("loadtype").toString(); 
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();  
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim(); 
try{      
	ClsCommon objcommon=new ClsCommon();  
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection(); 
	Statement stmt=conn.createStatement();
	String sqltest="";
	java.sql.Date sqlfromdate = null, sqltodate = null;
    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
    	sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
    }  
    
    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
    	sqltodate=objcommon.changeStringtoSqlDate(todate);
    }  
    String sql1="select m.doc_no from my_salm m where m.status=3 and salesuserlink='"+session.getAttribute("USERID")+"'";
	ResultSet rs1 = stmt.executeQuery(sql1) ;
	if(rs1.next()){    
		sqltest+=" and m.sal_id='"+rs1.getString("doc_no")+"'";   
	} 
	
	/*if(sqlfromdate!=null && sqltodate!=null) {
		sqltest+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";   
	}*/   
	
	String strenq="select (select count(*) from sk_srvcontrm m where  m.status not in(6,7) and if(m.status=10,'"+sqlfromdate+"'<=m.closedate,1=1)  and ('"+sqlfromdate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or '"+sqltodate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' or if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) between '"+sqlfromdate+"' and '"+sqltodate+"')"+sqltest+") allcnt,(select count(*) from sk_srvcontrm m where m.status <= 3 and m.revision_no = 0  and m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' and ('"+sqlfromdate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or '"+sqltodate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' or if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) between '"+sqlfromdate+"' and '"+sqltodate+"')"+sqltest+") newcnt,(select count(*) from sk_srvcontrm m where m.status=9 and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) between '"+sqlfromdate+"' and '"+sqltodate+"' and ('"+sqlfromdate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or '"+sqltodate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' or if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) between '"+sqlfromdate+"' and '"+sqltodate+"') "+sqltest+") rencnt,(select count(*) from sk_srvcontrm m where m.revision_no > 0 and m.status=3 and m.witheffect between '"+sqlfromdate+"' and '"+sqltodate+"' and ('"+sqlfromdate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or '"+sqltodate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' or if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) between '"+sqlfromdate+"' and '"+sqltodate+"')"+sqltest+") revcnt,(select count(*) from sk_srvcontrm m where m.status=10 and m.closedate  between '"+sqlfromdate+"' and '"+sqltodate+"'  and ('"+sqlfromdate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or '"+sqltodate+"' between m.startdt and if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) or m.startdt between '"+sqlfromdate+"' and '"+sqltodate+"' or if(m.status=10,coalesce(m.closedate,m.enddt),m.enddt) between '"+sqlfromdate+"' and '"+sqltodate+"')"+sqltest+") termcnt,(select count(*) from sk_srvcontrm m where m.status=3 and m.enddt<='"+sqltodate+"' and m.enddt>='"+sqlfromdate+"' "+sqltest+") expcnt";
	//System.out.println("count="+strenq);                                      
	String newcount="0",revcount="0",rencount="0",termcount="0",expcount="0",allcount="0";            
	ResultSet rsenq=stmt.executeQuery(strenq);
	while(rsenq.next()){
		newcount=rsenq.getString("newcnt");   
		revcount=rsenq.getString("revcnt");
		rencount=rsenq.getString("rencnt");
		termcount=rsenq.getString("termcnt");  
		expcount=rsenq.getString("expcnt");  
		allcount=rsenq.getString("allcnt");  
	}
	objdata.put("newcount",newcount);
	objdata.put("revcount",revcount); 
	objdata.put("rencount",rencount);  
	objdata.put("termcount",termcount); 
	objdata.put("expcount",expcount);       
	objdata.put("allcount",allcount);          
	response.getWriter().print(objdata);     
}
catch(Exception e){
	e.printStackTrace();   
}finally{  
	conn.close();  
}
%>