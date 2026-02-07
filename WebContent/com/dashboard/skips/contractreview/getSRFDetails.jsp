<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String result="";
int errorstatus=0;
Connection conn = null;
 
String cnttrno=request.getParameter("cnttrno")==null || request.getParameter("cnttrno").equals("")?"0":request.getParameter("cnttrno").toString(); 
String srno = request.getParameter("srno")==null?"":request.getParameter("srno").trim();  
String type = request.getParameter("type")==null?"":request.getParameter("type").trim(); 
try{      
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection(); 
	Statement stmt=conn.createStatement();
	String comp1="", comp2="", action="", status="";
	
	int oldskipqty = 0, newskipqty = 0, oldcnttrno = 0;
	String strenq="select m.oldcnttrno, m.doc_no, d.nos qty, d.scheduledays novisit, r1.name serviceterm, r2.name ownership, sk.name skipsize,CONCAT('New Contract - ',COALESCE(m.doc_no,''),', Skip Qty - ',COALESCE(d.nos,''),', Ownership - ',COALESCE(r2.name,''),', Skipsize - ',COALESCE(sk.name,''),', Service Term - ',COALESCE(r1.name,''),', No of Visit - ',COALESCE(d.scheduledays,'')) comp1 from sk_srvcontrm m inner join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_enqrelated r1 on (r1.srno=d.servicetermid and r1.type='SCHEDULE') left join sk_enqrelated r2 on (r2.srno=d.ownershipid and r2.type='SERVICEBY') left join sk_skiptype sk on sk.doc_no=d.skiptype where m.tr_no="+cnttrno+"";
	//System.out.println("strenq="+strenq);                                      
	ResultSet rsenq=stmt.executeQuery(strenq);
	while(rsenq.next()){
		comp1 = rsenq.getString("comp1"); 
		newskipqty = rsenq.getInt("qty"); 
		oldcnttrno = rsenq.getInt("oldcnttrno"); 
	}
	
	String strenq1="";
	if(type.equalsIgnoreCase("REV")){
		strenq1="select m.doc_no, d.nos qty, d.scheduledays novisit, r1.name serviceterm, r2.name ownership, sk.name skipsize,CONCAT('New Contract - ',COALESCE(m.doc_no,''),', Skip Qty - ',COALESCE(d.nos,''),', Ownership - ',COALESCE(r2.name,''),', Skipsize - ',COALESCE(sk.name,''),', Service Term - ',COALESCE(r1.name,''),', No of Visit - ',COALESCE(d.scheduledays,'')) comp2 from sk_srvcontrm m inner join sk_srvcontrdetr d on d.rdocno=m.tr_no and d.revision_no=(m.revision_no-1) left join sk_enqrelated r1 on (r1.srno=d.servicetermid and r1.type='SCHEDULE') left join sk_enqrelated r2 on (r2.srno=d.ownershipid and r2.type='SERVICEBY') left join sk_skiptype sk on sk.doc_no=d.skiptype where m.tr_no="+cnttrno+"";
	}else if(type.equalsIgnoreCase("REN")){
		strenq1="select m.doc_no, d.nos qty, d.scheduledays novisit, r1.name serviceterm, r2.name ownership, sk.name skipsize,CONCAT('New Contract - ',COALESCE(m.doc_no,''),', Skip Qty - ',COALESCE(d.nos,''),', Ownership - ',COALESCE(r2.name,''),', Skipsize - ',COALESCE(sk.name,''),', Service Term - ',COALESCE(r1.name,''),', No of Visit - ',COALESCE(d.scheduledays,'')) comp2 from sk_srvcontrm m inner join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_enqrelated r1 on (r1.srno=d.servicetermid and r1.type='SCHEDULE') left join sk_enqrelated r2 on (r2.srno=d.ownershipid and r2.type='SERVICEBY') left join sk_skiptype sk on sk.doc_no=d.skiptype where m.tr_no="+oldcnttrno+"";
	}else{}
	//System.out.println(type+"=strenq1="+strenq1);
	if(type.equalsIgnoreCase("REV") || type.equalsIgnoreCase("REN")){
		ResultSet rsenq1=stmt.executeQuery(strenq1);
		while(rsenq1.next()){
			comp2 = rsenq1.getString("comp2");  
			oldskipqty = rsenq1.getInt("qty"); 
		} 
	}  
	if(type.equalsIgnoreCase("REV") || type.equalsIgnoreCase("REN")){
		if(newskipqty>oldskipqty){
			action = "Delivery schedule to be done";
		}else if(newskipqty<oldskipqty){
			action = "Pullout schedule to be done";
		}else{}
	}else if(type.equalsIgnoreCase("NEW")){
		action = "Delivery schedule to be done";
		comp1="";
	}else if(type.equalsIgnoreCase("TER")){
		comp1="";  
	}else{}
	
	
	if(type.equalsIgnoreCase("NEW")){
		status = "NEW";
	}else if(type.equalsIgnoreCase("REV")){
		status = "REVISED";
	}else if(type.equalsIgnoreCase("REN")){
		status = "RENEWED";
	}else if(type.equalsIgnoreCase("TER")){
		status = "TERMINATED";
	}else{}
	
	response.getWriter().print(comp1+"####"+comp2+"####"+action+"####"+status);       
}
catch(Exception e){
	e.printStackTrace();   
}finally{  
	conn.close();  
}
%>