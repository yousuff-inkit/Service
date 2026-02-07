<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<% 
 String masterdoc =request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc").toString();
 Connection conn = null;
 ClsConnection ClsConnection=new ClsConnection();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String 	revno="",payterms="",telno="",tr_no="",doc_no="",date="",remarks="",cldocno="",name="",com_add1="",mob="",email="",sourceid="",source="",sal_id="",sal_name="",grpname="",billingtype="",enqvocno="",enqdocno="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		int rs=0;
		String str1Sql= "select m.revision_no revno,m.payterms,m.billingmethod,coalesce(a1.name,'') groupcompanies,date_format(m.date,'%d.%m.%Y') date,em.com_add1, em.mob, em.telno, em.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,em.name refname,sc.txtname source,m.source_id,sm.sal_name,m.sal_id,m.cldocno from sk_srvqotm m left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) left join cm_enqsource sc on sc.doc_no=m.source_id left join my_salm sm on sm.doc_no=m.sal_id where m.status<>7 and m.tr_no='"+masterdoc+"'";
		//System.out.println("str1Sqlenqview====="+str1Sql);       
		ResultSet rst=stmt.executeQuery(str1Sql);  
        while(rst.next()) {
        	revno=rst.getString("revno");
        	grpname=rst.getString("groupcompanies");
			telno=rst.getString("telno");
			tr_no=rst.getString("tr_no");
			doc_no=rst.getString("doc_no"); 
			date=rst.getString("date");
			remarks=rst.getString("remarks");
			cldocno=rst.getString("cldocno");
			name=rst.getString("refname");
			com_add1=rst.getString("com_add1");
			mob=rst.getString("mob");
			email=rst.getString("email");
			billingtype=rst.getString("billingmethod");  
			sourceid=rst.getString("source_id");
			source=rst.getString("source");
			enqvocno=rst.getString("enqvocno");
			enqdocno=rst.getString("enqdocno");  
			sal_id=rst.getString("sal_id");
			sal_name=rst.getString("sal_name");  
			payterms=rst.getString("payterms");  
        }    
		response.getWriter().write(telno+"###"+tr_no+"###"+doc_no+"###"+date+"###"+remarks+"###"+cldocno+"###"+name+"###"+com_add1+"###"+
mob+"###"+email+"###"+billingtype+"###"+sourceid+"###"+source+"###"+enqvocno+"###"+enqdocno+"###"+sal_id+"###"+sal_name+"###"+grpname+"###"+payterms+"###"+revno);     

		stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
	}finally{
		conn.close();
	}
  %>