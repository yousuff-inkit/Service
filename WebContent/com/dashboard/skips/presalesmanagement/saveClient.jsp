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
<%@page import="com.email.*"%>
<%@page import="com.controlcentre.masters.client.*"%>
<%@page import="java.text.SimpleDateFormat" %>  
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
	 	ClsClientDAO DAO = new ClsClientDAO();
		String client=request.getParameter("client").trim();  
		String enqdocno=request.getParameter("enqdocno").trim()==null || request.getParameter("enqdocno").trim()==""?"0":request.getParameter("enqdocno").trim();
		String Txtaddress=request.getParameter("address").trim();
		String Txtmobile=request.getParameter("mobile").trim();
		String Txtemail=request.getParameter("email");
		String areaidnw=request.getParameter("areaid").trim();
		String salidnw=request.getParameter("salid").trim();
		String sourceid=request.getParameter("sourceid").trim();
		int category=request.getParameter("category").trim()==null || request.getParameter("category").trim()==""?0:Integer.parseInt(request.getParameter("category"));
		int acgroup=request.getParameter("acgroup").trim()==null || request.getParameter("acgroup").trim()==""?0:Integer.parseInt(request.getParameter("acgroup"));  
		String tinno=request.getParameter("tinno").trim();
		//int areaid=(request.getParameter("areaid")==null || request.getParameter("areaid")=="")?0:Integer.parseInt(request.getParameter("areaid"));
		String cpersonid=request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid");
		//int salid=request.getParameter("salid")==null?0:Integer.parseInt(request.getParameter("salid"));
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
		String dt=sdf.format(new java.util.Date());
		java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(dt);
		//System.out.println("areaidnw------"+areaidnw+"===salidnw==="+salidnw+"===cpersonid==="+cpersonid);
		//java.sql.Date sqlDate=null;

	    /* if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		} */
	    int areaid=0,salid=0;
		if(!(areaidnw.equalsIgnoreCase(""))){
			areaid=Integer.parseInt(areaidnw);
		}
		 if(!(salidnw.equalsIgnoreCase(""))){
			salid=Integer.parseInt(salidnw);
		} 
	    ArrayList<String> cparrayList= new ArrayList<String>();
		ArrayList<String> documentsarray= new ArrayList<String>();
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0,reqval=0;
		 /*Submit */  
		reqval=DAO.insert(sqlDate, client, 1, acgroup, salid, category, "0", tinno, 0.0, 0.0, 0.0, Txtaddress, "0", Txtmobile, "", "", "", Txtemail, cpersonid, areaid, "", "", "", "", "", "", "", 0, "", cparrayList, session, "A", "CRM", "", "", request, 1, 0, documentsarray);
		//System.out.println("Inserted=="+reqval);
		 if(reqval>0){  
			 sql="update gl_enqm m left join sk_srvqotm q on q.refdocno=m.doc_no and q.refdtype='ENQ' set m.cldocno='"+reqval+"',q.cldocno='"+reqval+"' where m.doc_no='"+enqdocno+"'";
			 //System.out.println("update sql=="+sql);
	    	 val= stmt.executeUpdate(sql);    
		 }
		 if(val>0){  
    		conn.commit();
    	 }
		 response.getWriter().print(reqval);
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
