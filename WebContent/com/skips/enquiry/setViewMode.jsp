<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.ClsCommon" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
 String masterdoc =request.getParameter("masterdoc")==null?"0":request.getParameter("masterdoc").toString();
String brhid =request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString();
	Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	try{
		conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement ();
		String 	telno="",doc_no="",voc_no="",date="",remarks="",cldocno="",name="",com_add1="",mob="",email="",enqtype="",sourceid="",source="",
				cperson="",cpersonid="",contrmode="",sjobtype="",surveyed="",sal_id="",sal_name="",grpname="";
		java.sql.Date sdate=null;
		java.sql.Date edate=null;
	//	String branchid=session.getAttribute("BRANCHID").toString();
		int rs=0;
		String str1Sql=("select coalesce(a1.refname,'') grpname,m.sertypeid,sm.doc_no sal_id,sm.sal_name,telno,m.enqbtypeid,m.qtype,m.doc_no,voc_no,m.date,m.remarks,m.desc1,m.cldocno,name,com_add1,coalesce(ct.mob,m.mob)mob,coalesce(ct.email,m.email)email,enqtype,sourceid,txtname as source,m.cperson,cpersonid,contrmode,m.sjobtype,m.surveyed,m.enqstatus from gl_enqm m left join cm_enqsource s on(m.sourceid=s.doc_no) left join my_salm sm on sm.doc_no=m.sal_id left join my_crmcontact ct on (ct.row_no=m.cpersonid) left join my_acbook a on a.cldocno=m.cldocno and  a.dtype='crm'  left join my_acbook a1 on a.grpcmp=a1.cldocno and a1.dtype='crm'  where m.status=3 and m.voc_no="+masterdoc+" and m.brhid="+brhid+" group by m.doc_no");
		System.out.println("str1Sqlenqview====="+str1Sql);  
		ResultSet rst=stmt.executeQuery(str1Sql);
        while(rst.next()) {
        	grpname=rst.getString("grpname");
			telno=rst.getString("telno");
			doc_no=rst.getString("doc_no");
			voc_no=rst.getString("voc_no");
			date=rst.getString("date");
			remarks=rst.getString("remarks");
			cldocno=rst.getString("cldocno");
			name=rst.getString("name");
			com_add1=rst.getString("com_add1");
			mob=rst.getString("mob");
			email=rst.getString("email");
			enqtype=rst.getString("enqtype");
			sourceid=rst.getString("sourceid");
			source=rst.getString("source");
			cperson=rst.getString("cperson");
			cpersonid=rst.getString("cpersonid");
			contrmode=rst.getString("contrmode");
			sjobtype=rst.getString("sjobtype");
			surveyed=rst.getString("surveyed");
			sal_id=rst.getString("sal_id");
			sal_name=rst.getString("sal_name");
        }  
System.out.println("date====="+date);
		response.getWriter().write(telno+"###"+doc_no+"###"+voc_no+"###"+date+"###"+remarks+"###"+cldocno+"###"+name+"###"+com_add1+"###"+
mob+"###"+email+"###"+enqtype+"###"+sourceid+"###"+source+"###"+cperson+"###"+cpersonid+"###"+contrmode+"###"+sjobtype+"###"+surveyed+"###"+sal_id+"###"+sal_name+"###"+grpname); 

		stmt.close();
		conn.close();  
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  