<%@page import="java.util.ArrayList"%>
<%@page import="com.project.execution.callRegister.ClsCallRegisterDAO"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
String contact=request.getParameter("contact")==null?"":request.getParameter("contact");
String contactid=request.getParameter("contactid")==null?"":request.getParameter("contactid");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
String email=request.getParameter("email")==null?"":request.getParameter("email");
String cmbservicetype=request.getParameter("cmbservicetype")==null?"":request.getParameter("cmbservicetype");
String cmbcomplaint=request.getParameter("cmbcomplaint")==null?"":request.getParameter("cmbcomplaint");
String cmbcompany=request.getParameter("cmbcompany")==null?"":request.getParameter("cmbcompany");
String query=request.getParameter("query")==null?"":request.getParameter("query");
String contracttype=request.getParameter("contracttype")==null?"":request.getParameter("contracttype");
String contracttrno=request.getParameter("contracttrno")==null?"":request.getParameter("contracttrno");
String cmbcommtype=request.getParameter("cmbcommtype")==null?"":request.getParameter("cmbcommtype");
String cmbpriority=request.getParameter("cmbpriority")==null?"":request.getParameter("cmbpriority");
int errorstatus=0;
int cregdocno=0;
ClsConnection objconn=new ClsConnection();
ClsCallRegisterDAO objcreg=new ClsCallRegisterDAO();
Connection conn=null;
try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	
	//CREG Insertion
	String strmisc="select (select CURDATE()) basedate,(select date_format(now(),'%H:%i')) basetime,(select rowno from cm_srvcsited where tr_no="+contracttrno+") siteid";
	ResultSet rsmisc=stmt.executeQuery(strmisc);
	java.sql.Date sqlbasedate=null;
	String basetime="",siteid="";
	
	while(rsmisc.next()){
		sqlbasedate=rsmisc.getDate("basedate");
		basetime=rsmisc.getString("basetime");
		siteid=rsmisc.getString("siteid");
	}
	ArrayList<String> complaintsarray=new ArrayList();
	complaintsarray.add(cmbservicetype+":: "+1+":: "+cmbcomplaint+":: "+query);
	
	cregdocno=objcreg.insert(sqlbasedate, "CREG", "", Integer.parseInt(cmbcompany), contact, "", 
		mobile, email, sqlbasedate, basetime, contracttype, contracttrno, siteid,query,
		complaintsarray, session, request, "A");
	if(cregdocno<=0){
		errorstatus=1;
		System.out.println("CREG Insert Error");
	}
	else{
		String strupdate="update cm_cuscallm set commtype='"+cmbcommtype+"',priority="+cmbpriority+" where doc_no="+cregdocno;
		int update=stmt.executeUpdate(strupdate);
		if(update<=0){
			errorstatus=1;
			System.out.println("CREG Update Error");
		}
		else{
			System.out.println("Passed Contact Id:"+contactid);
			if(contactid.equalsIgnoreCase("") || contactid.equalsIgnoreCase("undefined") || contactid.equalsIgnoreCase("0")){
				//New Contact Insertion
				String strgetcontactrowno="select max(coalesce(row_no,0))+1 maxrowno from my_crmcontact";
				ResultSet rsgetcontactrowno=stmt.executeQuery(strgetcontactrowno);
				int contactrowno=0;
				while(rsgetcontactrowno.next()){
					contactrowno=rsgetcontactrowno.getInt("maxrowno");
				}
				String strinsertcontact="insert into my_crmcontact(dtype, cldocno, CPERSON, MOB, EMAIL, SR_NO,actvty_id,row_no)values('CRM',"+cmbcompany+",'"+contact+"','"+mobile+"','"+email+"',1,0,"+contactrowno+")";
				System.out.println(strinsertcontact);
				int insertcontact=stmt.executeUpdate(strinsertcontact);
				if(insertcontact<=0){
					errorstatus=1;
					System.out.println("Contact Insert Error");
				}
				contactid=contactrowno+"";
			}
		}
		
	}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	conn.close();
}
response.getWriter().write(errorstatus+"::"+cregdocno);
%>