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
<%@page import="com.project.execution.ServiceSale.*"%>  
 
<%
    ClsServiceSaleDAO srDAO=new ClsServiceSaleDAO();   
	String docno=request.getParameter("docno")==null || request.getParameter("docno").equalsIgnoreCase("")?"0":request.getParameter("docno").toString();
	String srvdocno=request.getParameter("srvdocno");   
	String branchids=request.getParameter("branchids")==null || request.getParameter("branchids").equalsIgnoreCase("")?"0":request.getParameter("branchids").toString();
	String desc1=request.getParameter("desc1");
	String podate=request.getParameter("podate");  
	String pono=request.getParameter("pono");
	String taxperc="18";  
	String acno=request.getParameter("acno")==null || request.getParameter("acno").equalsIgnoreCase("")?"0":request.getParameter("acno").toString();
	String processid=request.getParameter("processid")==null || request.getParameter("processid").equalsIgnoreCase("")?"0":request.getParameter("processid").toString();
 	Connection conn1=null;
	String uptodate=request.getParameter("date")==null?"0":request.getParameter("date");  
	
	String refrowno="0";
	Connection conn=null;
	try{
		 ClsConnection ClsConnection =new ClsConnection();    
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlprocessdate=null;
		 java.sql.Date sqluptodate = null;
		 String upsql=null;
		 int val=0;
		 String vocno="",sqlcl="",sqljoin="",sqlcl1="",sqldata="";
	 	 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
	 	 session.setAttribute("BRANCHID", branchids);
		 Statement stmt = conn.createStatement ();
		 Statement stmt2 = conn.createStatement ();
		 int docval=0;  
 
		 java.sql.Date podates=null;
		 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))){
				podates=ClsCommon.changeStringtoSqlDate(podate);
		 }else{}
		 if(!(uptodate.equalsIgnoreCase("undefined"))&&!(uptodate.equalsIgnoreCase(""))&&!(uptodate.equalsIgnoreCase("0"))){
				sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);
		 }else {} 
		 String atype="AR";      
		 ArrayList<String> proday= new ArrayList<String>();    
		
		 if(processid.equalsIgnoreCase("Site")) {
		    	sqlcl+=" group by p.siteid";
		 }else if(processid.equalsIgnoreCase("State")) {
		    	sqlcl+=" group by po.doc_no";  
		 }else if(processid.equalsIgnoreCase("Service")) {    
		    	sqlcl+=" group by gs.doc_no";    
		 }else {}  
		 int curid=1,i=1,interstate=0,refid=0;    
		 String qty="",description="",remarks="",costtype="",costcode="",headdoc="",vocnos="";
		 Double unitprice=0.0,total=0.0,discount=0.0,nettotal=0.0,taxper=0.0,taxperamt=0.0,taxamount=0.0,nuprice=0.0,rate=1.00;     
		 
		 if(processid.equalsIgnoreCase("Call Register")) {               
			 sqldata="select '' remarks,if(s.posid!=b.posid,1,0) interstate,if(s.posid=b.posid,9,0) gst,if(s.posid!=b.posid,18,9) igst,case when '"+processid+"'='Call Register' then gs.groupname else '' end as description,case when '"+processid+"'='Call Register' then p.servid else 0 end as refid,1 qty,round(coalesce(sum(d.total),0),2) unitprice,round(coalesce(sum(d.total),0),2) total,0.00 discount,round(coalesce(sum(d.total),0),2) nettotal,18 taxper,round(((coalesce(sum(d.total),0)*18)/100),2) taxperamt,round(((coalesce(sum(d.total),0)*18)/100)+coalesce(sum(d.total),0),2)  taxamount,round(((coalesce(sum(d.total),0)*18)/100)+coalesce(sum(d.total),0),2) nuprice,'3' costtype,cm.doc_no costcode,(select acno from my_account where codeno='AMC INCOME') headdoc,'' remarks from cm_cuscallm c left join cm_srvcontrm m on m.tr_no=c.contractno and c.contracttype=m.dtype left join cm_servplan p  on p.doc_no=c.tr_no and p.dtype='creg' left join cm_srvcontrd d on m.tr_no=d.tr_no and p.servid=d.servid  left join cm_srvcsited s on(p.siteid=s.rowno) left join my_gstpos po on po.doc_no=s.posid left join my_groupvals gs on(gs.doc_no=p.servid and gs.grptype='service') left join my_brch b on b.doc_no=cm.brhid where p.tr_no in("+srvdocno.substring(0, srvdocno.length()-1)+") and p.date<='"+sqluptodate+"' and p.workper=100 and p.dtype='creg' group by p.servid"; 
		 }else {
				 sqldata="select '' remarks,if(s.posid!=b.posid,1,0) interstate,if(s.posid=b.posid,9,0) gst,if(s.posid!=b.posid,18,9) igst,case when '"+processid+"'='Site' then s.site when '"+processid+"'='State' then po.name  when '"+processid+"'='Service' then gs.groupname when '"+processid+"'='LumpSum' then 'LumpSum Invoice' else '' end as description,case when '"+processid+"'='Site' then p.siteid when '"+processid+"'='State' then po.doc_no  when '"+processid+"'='Service' then gs.doc_no else 0 end as refid,1 qty,round(coalesce(sum(p.servamt),0),2) unitprice,round(coalesce(sum(p.servamt),0),2) total,0.00 discount,round(coalesce(sum(p.servamt),0),2) nettotal,18 taxper,round(((coalesce(sum(p.servamt),0)*18)/100),2) taxperamt,round(((coalesce(sum(p.servamt),0)*18)/100)+coalesce(sum(p.servamt),0),2)  taxamount,round(((coalesce(sum(p.servamt),0)*18)/100)+coalesce(sum(p.servamt),0),2) nuprice,'3' costtype,cm.doc_no costcode,(select acno from my_account where codeno='AMC INCOME') headdoc,'' remarks from cm_srvcontrm cm left join cm_servplan p on p.reftrno=cm.tr_no and p.dtype=cm.dtype left join cm_srvcsited s on(p.siteid=s.rowno) left join my_gstpos po on po.doc_no=s.posid left join my_groupvals gs on(gs.doc_no=p.servid and gs.grptype='service') left join my_brch b on b.doc_no=cm.brhid where p.tr_no in("+srvdocno.substring(0, srvdocno.length()-1)+") and p.date<='"+sqluptodate+"' and p.workper=100 and p.dtype='AMC' "+sqlcl+""; 
		 }    
		 //System.out.println("==checksave=="+sqldata);                  
	     ResultSet rs= stmt2.executeQuery (sqldata);    
	     while(rs.next()){
	    	 qty=rs.getString("qty");
	    	 description=rs.getString("description");
	    	 remarks=rs.getString("remarks");
	    	 costtype=rs.getString("costtype");
	    	 costcode=rs.getString("costcode");
	    	 headdoc=rs.getString("headdoc");  
	    	 unitprice=rs.getDouble("unitprice");
	    	 total=rs.getDouble("total"); 
	    	 discount=rs.getDouble("discount"); 
	    	 nettotal=rs.getDouble("nettotal"); 
	    	 taxper=rs.getDouble("taxper"); 
	    	 taxamount=rs.getDouble("taxamount"); 
	    	 taxperamt=rs.getDouble("taxperamt"); 
	    	 nuprice=rs.getDouble("nuprice"); 
	    	 interstate=rs.getInt("interstate");
	    	 refid=	rs.getInt("refid");  	   
			 proday.add(i+"::"+qty+" :: "+description+" :: "+unitprice+" :: "+total+" :: "+discount+" :: "+nettotal+" :: "+taxper+" :: "+taxperamt+" :: "+taxamount+" :: "+nuprice+" :: "+costtype+" :: "+costcode+" :: "+remarks+" :: "+headdoc+" :: "+0+" :: ");
			 ClsServiceSaleAction masteraction=new ClsServiceSaleAction();
				masteraction.setDelno("");
			 val=srDAO.insert(podates,podates,"PINV-"+docno,"",atype,acno,"", ""+curid,""+rate,"",pono,desc1,session,"A",nettotal,proday,"SRS",request,podates,"",podate,interstate,Double.parseDouble(taxperc),masteraction);               
			 System.out.println(interstate+"==="+val+"==="+refid);    
	     
			 if(val>0){  
				 if(processid.equalsIgnoreCase("Site")) {
					 sqlcl1=" and p.siteid='"+refid+"'";  
			    	 sqljoin=" left join cm_srvcsited s on(p.siteid=s.rowno) ";
			     }else if(processid.equalsIgnoreCase("State")) {  
			    	 sqlcl1=" and po.doc_no='"+refid+"'";  
			    	 sqljoin=" left join cm_srvcsited s on(p.siteid=s.rowno) left join my_gstpos po on po.doc_no=s.posid ";
			     }else if(processid.equalsIgnoreCase("Service")) {    
			    	 sqlcl1=" and gs.doc_no='"+refid+"'"; 
			    	 sqljoin="  left join my_groupvals gs on(gs.doc_no=p.servid and gs.grptype='service') ";  
			     }else if(processid.equalsIgnoreCase("Call Register")) {      
			    	 sqlcl1=" and gs.doc_no='"+refid+"'"; 
			    	 sqljoin="  left join my_groupvals gs on(gs.doc_no=p.servid and gs.grptype='service') ";  
			     }else {}   
				 
			     vocno=request.getAttribute("vocno").toString();     
			     
			     String sqldata1="update cm_servplan p"+sqljoin+" set p.invtrno="+val+" where p.tr_no in("+srvdocno.substring(0, srvdocno.length()-1)+")"+sqlcl1+""; 
			     //System.out.println("sqldata1==="+sqldata1);       
				 val=stmt.executeUpdate(sqldata1);      
	          }
			 vocnos+=vocno+",";        
			 proday= new ArrayList<String>();   
	     }
		  if(val>0){    
				     conn.commit();  
				     conn.close();    
		  }
		//System.out.println(val+"======="+vocnos);  
		vocnos=vocnos.substring(0, vocnos.length()-1);     
		response.getWriter().print(val+"###"+vocnos);         
	 }catch(Exception e){  
	 	 conn.close();
	 	 e.printStackTrace();
	 }finally{
			conn.close();    
	 }
	%>
