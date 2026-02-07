<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();   
		String trnarray = request.getParameter("trno")==null || request.getParameter("trno").trim().equals("")?"0":request.getParameter("trno").trim().toString();
		String contractno = request.getParameter("contractno")==null || request.getParameter("contractno").equals("")?"0":request.getParameter("contractno").trim().toString();
		String linedesc="",vattype="",service="",headdoc="",description="",linetype="",contracttype="AMC",remarks=""; 
		double taxperc1=0.0, taxperc=0.0, amount=0.0, taxperamt=0.0, taxamount=0.0; 
		int i=0,srsvocno=0;  
		//System.out.println("trnarray=="+trnarray);
		String temp[] = trnarray.split(",");        
		ArrayList<String> descarray = new ArrayList<String>();
	    int val=0;
			for(int j=0;j<temp.length;j++){
				String trnsarray[] = temp[j].split("####"); 
				linetype = trnsarray[5];  
				if(linetype.equalsIgnoreCase("HR")){   
					//System.out.println("trnsarray[0]=="+trnsarray[0]);     
					String linearray[] = trnsarray[0].split("/");            
					
					String sqlup1 = "UPDATE hr_timesheethrs SET invtrno=99999999, confirm=1 WHERE empid='"+linearray[0]+"' AND costtype='"+linearray[1]+"' AND costcode='"+linearray[2]+"'";
					//System.out.println("sqlup1=="+sqlup1);              
					val = stmt.executeUpdate(sqlup1);  
					
					String sqlup = "INSERT INTO sa_expenseinv(tranid, invamt, costtype, costcode, invtrno, linetype) VALUES('"+linearray[0]+"', "+trnsarray[1]+", 3, '"+contractno+"', 99999999, '"+linetype+"')";
					//System.out.println("sqlup=="+sqlup);            
					val = stmt.executeUpdate(sqlup);
				}else{
					String sqlup = "INSERT INTO sa_expenseinv(tranid, invamt, costtype, costcode, invtrno, linetype) VALUES('"+trnsarray[0]+"', "+trnsarray[1]+", 3, '"+contractno+"', 99999999, '"+linetype+"')";      
					//System.out.println("sqlup=="+sqlup);            
					val = stmt.executeUpdate(sqlup); 
				}
				
			}
		 
		  
		 if(val>0){  
			 conn.commit();
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