<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>   
<%	
ClsConnection ClsConnection=new ClsConnection();     
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
    
	try{
	 	conn = ClsConnection.getMyConnection();                 
		Statement stmt = conn.createStatement();   
		int brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
		int docno=request.getParameter("docno")=="" || request.getParameter("docno")==null?0:Integer.parseInt(request.getParameter("docno").trim().toString());
		int vocno=request.getParameter("vocno")=="" || request.getParameter("vocno")==null?0:Integer.parseInt(request.getParameter("vocno").trim().toString());
		String mawb=request.getParameter("mawb")=="" || request.getParameter("mawb")==null?"":request.getParameter("mawb");
		String mbl=request.getParameter("mbl")=="" || request.getParameter("mbl")==null?"":request.getParameter("mbl");
		String hawb=request.getParameter("hawb")=="" || request.getParameter("hawb")==null?"":request.getParameter("hawb");
		String hbl=request.getParameter("hbl")=="" || request.getParameter("hbl")==null?"":request.getParameter("hbl");
		String shipper=request.getParameter("shipper")=="" || request.getParameter("shipper")==null?"":request.getParameter("shipper");
		String consignee=request.getParameter("consignee")=="" || request.getParameter("consignee")==null?"":request.getParameter("consignee");
		String carrier=request.getParameter("carrier")=="" || request.getParameter("carrier")==null?"":request.getParameter("carrier");
		String flightno=request.getParameter("flightno")=="" || request.getParameter("flightno")==null?"":request.getParameter("flightno");
		String vessel=request.getParameter("vessel")=="" || request.getParameter("vessel")==null?"":request.getParameter("vessel");
		String etd=request.getParameter("etd")=="" || request.getParameter("etd")==null?"0":request.getParameter("etd");
		String eta=request.getParameter("eta")=="" || request.getParameter("eta")==null?"0":request.getParameter("eta");    
		String boe=request.getParameter("boe")=="" || request.getParameter("boe")==null?"":request.getParameter("boe");               
		String containerno=request.getParameter("containerno")=="" || request.getParameter("containerno")==null?"":request.getParameter("containerno");
		String truckno=request.getParameter("truckno")=="" || request.getParameter("truckno")==null?"":request.getParameter("truckno");
		String transittime=request.getParameter("transittime")=="" || request.getParameter("transittime")==null?"0":request.getParameter("transittime");
		String cfidocno=request.getParameter("cfidocno")=="" || request.getParameter("cfidocno")==null?"":request.getParameter("cfidocno");  
		int val=0;    
		//System.out.println(etd+"====date===="+eta); 
		session.setAttribute("BRANCHID",brhid);     
		java.sql.Date sqletd=null;   
	     if(!etd.equalsIgnoreCase("0")){              
	    	 sqletd=ClsCommon.changeStringtoSqlDate(etd);       
	     }
	     java.sql.Date sqleta=null;
	     if(!eta.equalsIgnoreCase("0")){          
	    	 sqleta=ClsCommon.changeStringtoSqlDate(eta);       
	     }    
		String sqlinsert="update cr_cfim set mawb='"+mawb+"', mbl='"+mbl+"', hawb='"+hawb+"', hbl='"+hbl+"',shipper='"+shipper+"',"
				+ "  consignee ='"+consignee+"', carrier ='"+carrier+"', flightno ='"+flightno+"', voage ='"+vessel+"',eta ='"+sqleta+"', etd ='"+sqletd+"', "
						+ "ttime='"+transittime+"', boe='"+boe+"', contno='"+containerno+"',truckno='"+truckno+"' where doc_no='"+cfidocno+"'";                             
		System.out.println(val+"====sqlinsert===="+sqlinsert);      
		val=stmt.executeUpdate(sqlinsert);                                                  
		String logdesc="Shipment details added";       
		if(val>0){
   	        	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
				 //System.out.println(val+"====sqllog===="+sqllog);          
				 val=stmt.executeUpdate(sqllog);    
   	    }
	response.getWriter().print(val);                             
 	stmt.close();  
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
