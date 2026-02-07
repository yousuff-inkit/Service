<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<% 
    String psrno = request.getParameter("psrno")==null || request.getParameter("psrno")==""?"0":request.getParameter("psrno").trim();
	String prodoc = request.getParameter("prodoc")==null || request.getParameter("prodoc")==""?"0":request.getParameter("prodoc").trim();
	//String qty = request.getParameter("qty")==null || request.getParameter("qty")==""?"0":request.getParameter("qty").trim();
	//String binid = request.getParameter("binid")==null || request.getParameter("binid")==""?"0":request.getParameter("binid").trim();
	String rdocno = request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim();
	String rdtype = request.getParameter("rdtype")==null || request.getParameter("rdtype")==""?"":request.getParameter("rdtype").trim();
	String rbrhid = request.getParameter("rbrhid")==null || request.getParameter("rbrhid")==""?"0":request.getParameter("rbrhid").trim();
	String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");     
	Connection conn=null;
	int val=0; 
	Double totqty=0.0;
	 try{
		  ClsConnection ClsConnection=new ClsConnection();
 	      conn = ClsConnection.getMyConnection();
 	      conn.setAutoCommit(false);
	      Statement stmt = conn.createStatement ();
	      System.out.println(rdocno+"=rdocno=rdtype="+rdtype) ;  
	      ArrayList<String> newarray=new ArrayList();    
			String temparray[]=gridarray.split(",");
			for(int i=0;i<temparray.length;i++){
				newarray.add(temparray[i]);
			}
			for(int i=0;i<newarray.size();i++){
				String temp[]=newarray.get(i).split("::");
				if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
					String binid = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim()).toString();    
					Double qty = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?0.0:Double.parseDouble(temp[1].trim().toString());  
					
					String sql2="insert into my_whm(psrno, prdid, binid, qty, rdocno, rdtype, rbrhid) values('"+psrno+"','"+prodoc+"','"+binid+"','"+qty*-1+"','"+rdocno+"','"+rdtype+"','"+rbrhid+"')";      
					  //System.out.println("-----sql2----"+sql2) ;      
					 val = stmt.executeUpdate(sql2);
					 totqty=totqty+qty;  
				}
		  }	
		  if(val>0){	
		      if(rdtype.equalsIgnoreCase("GRR")){  
		    	  String sql1="update my_grrd set binqty=binqty+'"+totqty+"' where rdocno='"+rdocno+"' and psrno='"+psrno+"' and prdid='"+prodoc+"'";      
				  //System.out.println("-----sql1----"+sql1) ;
				  val = stmt.executeUpdate(sql1); 
		      }else if(rdtype.equalsIgnoreCase("DEL")){    
		    	  String sql1="update my_deld set binqty=binqty+'"+totqty+"' where rdocno='"+rdocno+"' and psrno='"+psrno+"' and prdid='"+prodoc+"'";      
				  //System.out.println("-----sql1----"+sql1) ;
				  val = stmt.executeUpdate(sql1); 
		      }else{}
		  }      
          if(val>0){  
			  String logdesc="Warehouse Management - Picking slip created.";           
	          String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+rdocno+",'"+rbrhid+"','WHM',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
			  //System.out.println(val+"====sqllog===="+sqllog);     
			  stmt.executeUpdate(sqllog);    
          }
	  
		 if(val>0) {
			  conn.commit();
		 }
	 	stmt.close();
	 	conn.close();
	 	response.getWriter().print(1);  
	 }
	 catch(Exception e){
			conn.close();
			e.printStackTrace();  
	 }
	%>
