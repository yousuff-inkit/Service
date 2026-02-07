<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>    
<% 
 String trno = request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").toString();
 Connection conn = null;
 ClsConnection ClsConnection=new ClsConnection();
 ClsCommon ClsCommon=new ClsCommon();

 try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String 	advtype="0",inctipfee="",invstart="",cperson="",cpersonid="",mergedinvoice="",refno="",advinvvalue="",advinvmethod="0",grpname="";  
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
		int rs=0;
		String clsql= "select m.cpemail, m.advtype, m.inctipfee, m.invstart, m.cperson,m.cpersonid,if(m.mergedinvoice='Yes',1,0) mergedinvoice,m.refno,m.advinvvalue,m.advinvmethod,m.refdtype,m.payterms,m.billingmethod,coalesce(a1.name,'') groupcompanies,date_format(m.date,'%d.%m.%Y') date,date_format(m.startdt,'%d.%m.%Y') startdt,date_format(m.enddt,'%d.%m.%Y') enddt,ac.address com_add1, m.mob, m.tel telno, m.email,m.remarks,em.doc_no enqdocno,em.voc_no enqvocno,m.doc_no,m.tr_no,ac.refname,sm.sal_name,m.sal_id,m.cldocno,m.typeid from sk_srvcontrm m left join gl_enqm em on em.doc_no=m.refdocno left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='CRM' left join my_salm sm on sm.doc_no=m.sal_id left join sk_clgroup a1 on (ac.grpcmp=a1.docno or em.grpcmpid=a1.docno) left join my_crmcontact cp on cp.row_no=m.cpersonid where m.tr_no='"+trno+"'";
		//System.out.println("====Contract Details===="+clsql);                                 
		ResultSet rst = stmt.executeQuery(clsql);        
        while(rst.next()) {
        	grpname=rst.getString("groupcompanies");
			advtype=rst.getString("advtype");
			inctipfee=rst.getString("inctipfee");
			invstart=rst.getString("invstart"); 
			cperson=rst.getString("cperson");
			cpersonid=rst.getString("cpersonid");
			mergedinvoice=rst.getString("mergedinvoice");
			refno=rst.getString("refno");
			advinvvalue=rst.getString("advinvvalue");
			advinvmethod=rst.getString("advinvmethod");  
        }
		response.getWriter().print(grpname+"###"+advtype+"###"+inctipfee+"###"+invstart+"###"+cperson+"###"+cpersonid+"###"+mergedinvoice+"###"+refno+"###"+advinvvalue+"###"+advinvmethod+"###"+advinvmethod);      
		stmt.close(); 
		conn.close();  
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  