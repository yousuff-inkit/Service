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
<%@page import="com.dashboard.marketing.opaccounting.ClsOpAccountingDAO"%>
<%@page import="java.text.SimpleDateFormat" %>    
<%	
	ClsConnection connDAO=new ClsConnection();     
	ClsCommon commonDAO=new ClsCommon();        
	ClsOpAccountingDAO DAO= new ClsOpAccountingDAO();   
	Connection conn = null;
	java.sql.Date sqlStartDate=null;   
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");       
	java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));                     
	java.sql.Date sqlStartDate2=null;                                                   
	String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"0":request.getParameter("invdate");
	String invdesc=request.getParameter("invdesc")=="" || request.getParameter("invdesc")==null?"":request.getParameter("invdesc");
	String jobdocno=request.getParameter("jobdocno")=="" || request.getParameter("jobdocno")==null?"0":request.getParameter("jobdocno");  
	String pdrowno=request.getParameter("pdrowno")=="" || request.getParameter("pdrowno")==null?"0":request.getParameter("pdrowno");   
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid").trim().toString();
    int val=0,tempvocno=0; 
    String doc_no="",dtype="",refdtype="",sdate="",edate="",cval="",duedate="",lfee="",clientid="",cpersonid="",clacno="",client="";  
	try{ 
	 	conn=connDAO.getMyConnection();
		Statement stmt=conn.createStatement(); 
		conn.setAutoCommit(false);             
		if(!(invdate.equalsIgnoreCase("undefined")) && !(invdate.equalsIgnoreCase("")) && !(invdate.equalsIgnoreCase("0"))){  
	  	  sqlStartDate = commonDAO.changeStringtoSqlDate(invdate);   
	    }       
		ArrayList<String> gridarray=new ArrayList<String>();        
		
		String strcountdata="select cm.tr_no,cm.doc_no,cm.dtype,cm.ref_type refdtype,date_format(cm.validfrom,'%d.%m.%Y') sdate,date_format(cm.validupto,'%d.%m.%Y') edate,round(coalesce(pd.amount,0),2) cval,date_format(pd.duedate,'%d.%m.%Y')  as duedate,round(coalesce(cm.legalchrg,0),2) lfee,ac.doc_no as clientid,cm.cpersonid,cm.brhid,ac.acno as clacno,ac.refname client from cm_srvcontrm cm left join cm_srvcontrpd pd on(pd.tr_no=cm.tr_no and pd.dueafser=98)  left join my_acbook ac on (cm.cldocno=ac.cldocno and ac.dtype='CRM') where cm.tr_no='"+jobdocno+"' and pd.rowno='"+pdrowno+"'";
		//System.out.println("strcountdata--->>>"+strcountdata);                  
		ResultSet rs=stmt.executeQuery(strcountdata);                                
		while(rs.next()){ 
			doc_no=rs.getString("doc_no");
			dtype=rs.getString("dtype");
			refdtype=rs.getString("refdtype");
			sdate=rs.getString("sdate");
			edate=rs.getString("edate");
			cval=rs.getString("cval");
			duedate=rs.getString("duedate");
			lfee=rs.getString("lfee");
			clientid=rs.getString("clientid");
			cpersonid=rs.getString("cpersonid");
			clacno=rs.getString("clacno");
			client=rs.getString("client");    
			gridarray.add(jobdocno+"::"+doc_no+"::"+dtype+"::"+refdtype+"::"+sdate+"::"+edate+"::"+cval+"::"+duedate+"::"+lfee+"::"+clientid+"::"+cpersonid+"::"+brhid+"::"+clacno+"::"+client);         
		}
  				
		tempvocno=DAO.insert(session, request, sqlStartDate, "PINV", "A", gridarray, invdesc);
		System.out.println("tempvocno--->>>"+tempvocno);          
		String tempdocno=request.getAttribute("docNo").toString();
		/* if(tempvocno>0){    
			 String sql="update cm_srvcontrpd set pinvdocno='"+tempdocno+"' where rowno='"+pdrowno+"'";        
			 //System.out.println("sql==="+sql);   
			 val=stmt.executeUpdate(sql);            
		} */    
		if(tempvocno>0){            
			 conn.commit();     
		}   
	                               
  		 response.getWriter().write(tempvocno+"::"+tempvocno);               
	 	 conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>