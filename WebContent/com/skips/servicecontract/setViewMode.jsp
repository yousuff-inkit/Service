<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<% 
    String masterdoc =request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc").toString();
    String brhid =request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString();
	Connection conn = null;
    ClsConnection ClsConnection=new ClsConnection();
	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String 	revno="",witheffectdt="",payterms="",telno="",tr_no="",doc_no="",date="",remarks="",cldocno="",name="",com_add1="",mob="",email="",sourceid="",source="",sal_id="",sal_name="",grpname="",billingtype="",enqvocno="",enqdocno="",enddt="",startdt="",typeid="";  
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		int rs=0;
		String str1Sql= "select date_format(m.witheffect,'%d.%m.%Y') witheffect,m.revision_no,m.payterms,m.billingmethod,coalesce(a1.name,'') groupcompanies,date_format(m.date,'%d.%m.%Y') date,date_format(m.startdt,'%d.%m.%Y') startdt,date_format(m.enddt,'%d.%m.%Y') enddt,em.com_add1, em.mob, em.telno, em.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,em.name refname,sm.sal_name,m.sal_id,m.cldocno,m.typeid from sk_srvcontrm m left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) where m.status<>7 and m.tr_no='"+masterdoc+"'";
		System.out.println("str1Sqlenqview====="+str1Sql);        
		ResultSet rst=stmt.executeQuery(str1Sql);  
        while(rst.next()) {
        	witheffectdt=rst.getString("witheffect");
        	revno=rst.getString("revision_no");
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
			//sourceid=rst.getString("source_id");
			//source=rst.getString("source");
			enqvocno=rst.getString("enqvocno");
			enqdocno=rst.getString("enqdocno");  
			sal_id=rst.getString("sal_id");
			sal_name=rst.getString("sal_name"); 
			startdt=rst.getString("startdt");
			enddt=rst.getString("enddt"); 
			payterms=rst.getString("payterms"); 
			typeid=rst.getString("typeid"); 
        }    
		response.getWriter().write(telno+"###"+tr_no+"###"+doc_no+"###"+date+"###"+remarks+"###"+cldocno+"###"+name+"###"+com_add1+"###"+
                mob+"###"+email+"###"+billingtype+"###"+sourceid+"###"+source+"###"+enqvocno+"###"+enqdocno+"###"+sal_id+"###"+sal_name+"###"+grpname+"###"+
				startdt+"###"+enddt+"###"+payterms+"###"+witheffectdt+"###"+revno+"###"+typeid);       
		
		stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
	}finally{
		conn.close();
	}
  %>