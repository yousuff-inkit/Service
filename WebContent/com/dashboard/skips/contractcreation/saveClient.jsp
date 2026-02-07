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
<%@page import="com.skips.clientskip.ClsClientskipDAO"%>       
<%@page import="java.text.SimpleDateFormat" %>  
<%	
    ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();
	 	ClsClientskipDAO DAO = new ClsClientskipDAO();
		String client = request.getParameter("client").trim(); 
		int brhid = request.getParameter("brhid")==null || request.getParameter("brhid").trim().equals("")?0:Integer.parseInt(request.getParameter("brhid").trim().toString());     
		int qottrno = request.getParameter("qottrno")==null || request.getParameter("qottrno").trim().equals("")?0:Integer.parseInt(request.getParameter("qottrno").trim().toString());     
		String enqdocno = request.getParameter("enqdocno")==null || request.getParameter("enqdocno").trim()==""?"0":request.getParameter("enqdocno").trim();
		String Txtaddress = request.getParameter("address")==null?"":request.getParameter("address").trim();
		String Txtmobile = request.getParameter("mobile")==null?"":request.getParameter("mobile").trim();
		String Txtemail = request.getParameter("email")==null?"":request.getParameter("email").trim();
		String pertel = request.getParameter("pertel")==null?"":request.getParameter("pertel").trim();
		String areaidnw = request.getParameter("areaid")==null?"":request.getParameter("areaid").trim();
		String salidnw = request.getParameter("salid")==null?"":request.getParameter("salid").trim();   
		int category = request.getParameter("category")==null || request.getParameter("category").trim()==""?0:Integer.parseInt(request.getParameter("category").trim().toString());
		int acgroup = request.getParameter("acgroup")==null || request.getParameter("acgroup").trim()==""?0:Integer.parseInt(request.getParameter("acgroup").trim().toString());  
		String tinno = request.getParameter("tinno")==null || request.getParameter("tinno").trim()==""?"0":request.getParameter("tinno").trim();  
		//int areaid=(request.getParameter("areaid")==null || request.getParameter("areaid")=="")?0:Integer.parseInt(request.getParameter("areaid"));
		String cpersonid = request.getParameter("cpersonid")==null?"0":request.getParameter("cpersonid");
		String cperson = request.getParameter("cperson")==null?"0":request.getParameter("cperson");
		//int salid=request.getParameter("salid")==null?0:Integer.parseInt(request.getParameter("salid"));
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
		String dt=sdf.format(new java.util.Date());
		java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(dt);
		session.setAttribute("BRANCHID",brhid+"");     
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
		ArrayList<String> qstnarray= new ArrayList<String>();
		String sql="",sqlsub="",sql1="";
		String temp="";
		int val=0,reqval=0;
		 /*Submit */  
		cparrayList.add(cperson+"::"+Txtmobile+" :: "+pertel+" :: "+""+" :: "+Txtemail+" :: "+""+" :: "+""+" :: "+""+" :: ");
		reqval=DAO.insert(sqlDate, client, 1, acgroup, salid, category, "0", tinno, 0.0, 0.0, 0.0, Txtaddress, "0", Txtmobile, pertel, "", "", Txtemail, cpersonid, areaid, "", "", "", "", "", "", "", 0, "", cparrayList, session, "A", "CRM", "", "", request, 1, 0, documentsarray,"",qstnarray,"","");//System.out.println("Inserted=="+reqval);
		 if(reqval>0){  
			 sql="update gl_enqm m left join sk_srvqotm q on q.refdocno=m.doc_no and q.refdtype='ENQ' set m.cldocno='"+reqval+"',q.cldocno='"+reqval+"' where m.doc_no='"+enqdocno+"'";
			 //System.out.println("update sql=="+sql);
	    	 val= stmt.executeUpdate(sql);  
	    	 String sql2="insert into my_fileattach(ref_id, dtype, doc_no, brhid, sr_no, date, user, path, filename, descpt) select 2 refid,'CRM' dtype,"+reqval+" doc_no,"+brhid+" brhid,@i:=@i+1 srno,curdate(),'"+session.getAttribute("USERID").toString()+"',convert(a.path,char(1500)) path,convert(a.attach,char(500)) attach,a.desc1 from(select d.attach, d.path,c.desc1 from sk_checklistdet d left join sk_checklist c on c.srno=d.checksrno where d.qotno='"+qottrno+"' and (d.path!='0' and d.path!='' and d.checksrno in (1,2,4)))a,(select @i:=0)c";
	    	// System.out.println("sql2=="+sql2);      
	    	 int val1= stmt.executeUpdate(sql2);      
		 }
		 if(val>0){  
    		conn.commit();
    	 }
		 response.getWriter().print(reqval);
 	stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
   }finally{
	   conn.close();
   }
%>