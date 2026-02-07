<%@page import="com.opensymphony.xwork2.util.TextParseUtil.ParsedValueEvaluator"%>
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

<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		int errorstatus=0;
		/* String process=request.getParameter("process");
		String date=request.getParameter("date");
		String extdate=request.getParameter("extdate");
		String branchid=request.getParameter("branchid");
		String cldocno=request.getParameter("cldocno");
		String expirydate=request.getParameter("expirydate");
		String remarks=request.getParameter("remarks");
		String rentaltype=request.getParameter("rentaltype");
		String agreementno=request.getParameter("agreementno");
		String cardno=request.getParameter("cardno");
		String pytdocno=request.getParameter("pytdocno"); */
		String gridarray=request.getParameter("gridarray");
		ArrayList<String> griddataarray = new ArrayList<String>();
		String[] temparray=gridarray.split(",");
		for(int i=0;i<temparray.length;i++){
		 griddataarray.add(temparray[i]);
		}
		java.sql.Date sqlDate=null;

	    /* if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
		     sqlDate=ClsCommon.changeStringtoSqlDate(date);
		} */

		String sql=null,sqltst="";
		int val=0,docNo=0;
		
		  
				 for(int i=0;i< griddataarray.size();i++){
					 System.out.println("array== "+griddataarray.get(i));
						String[] arrayDet=((String) griddataarray.get(i)).split("::");
						int doc=arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:Integer.parseInt(arrayDet[0].trim());
						if(doc==0)
						{
							
							sqltst="INSERT INTO my_clientdetails(date, clientname, ipdetails, username, password, remarks) VALUES("            
									+ "now(),"                         
									+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?"":arrayDet[1].trim())+"',"
									+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?"":arrayDet[2].trim())+"',"
									+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?"":arrayDet[3].trim())+"',"
									+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?"":arrayDet[4].trim())+"',"
									+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?"":arrayDet[5].trim())+"')";
							 
						}
						else{
							String client=arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?"":(arrayDet[1].trim()).toString();
							String ipcon=arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?"":(arrayDet[2].trim()).toString();
							String user=arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?"":(arrayDet[3].trim()).toString();
							String pwd=arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?"":(arrayDet[4].trim()).toString();
							String remark=arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?"":(arrayDet[5].trim()).toString();
						System.out.println("client=="+client+"==ipcon=="+ipcon+"==user=="+user+"==pwd=="+pwd+"==remarks=="+remark);
						sqltst="update my_clientdetails set clientname='"+client+"', ipdetails='"+ipcon+"', username='"+user+"', password='"+pwd+"', remarks='"+remark+"' where doc_no="+doc+""; 
						}
						errorstatus = stmt.executeUpdate (sqltst);
				 }
		   
		  
				 if(errorstatus>0){
				 /*Follow-Up */
				 int docval=0;
			    String upsql="select coalesce(max(doc_no)+1,1) doc_no from my_clientdetails";
			    ResultSet resultSet = stmt.executeQuery(upsql);
			   
			    if (resultSet.next()) {
			    	docval=resultSet.getInt("doc_no");
			    }
				 sql="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docval+"','"+session.getAttribute("BRANCHID").toString()+"','BCDT',now(),'"+session.getAttribute("USERID").toString()+"','A')";
				 errorstatus= stmt.executeUpdate(sql);
		   }
		   
		  
		   
			response.getWriter().print(errorstatus);
	
		 	stmt.close();
		 	conn.close();
		}catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
	   }finally{
		   conn.close();
	   }
	%>
