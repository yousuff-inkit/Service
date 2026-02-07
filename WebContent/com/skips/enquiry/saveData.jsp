<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();   
	 	String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno").trim()==""?"0":request.getParameter("cldocno").trim();
	    String cparrays=request.getParameter("cparray")==null?"":request.getParameter("cparray").trim(); 
	    String grpcmp=request.getParameter("grpcmp")==null?"":request.getParameter("grpcmp").trim(); 
	    String process=request.getParameter("process")==null?"":request.getParameter("process").trim(); 
		int val = 0;
		if(process.equalsIgnoreCase("CP")){  
			ArrayList<String> cparrayList=new ArrayList();    
		    String temparray[]=cparrays.split(","); 
		 	for(int i=0;i<temparray.length;i++){
		 		cparrayList.add(temparray[i]);   
		 	}
		 	for(int i=0;i< cparrayList.size() ;i++){
				String[] cparray=((String) cparrayList.get(i)).split("::");
				int j=1; 
				String tclsql="INSERT INTO my_crmcontact(cldocno,dtype,sr_no,cperson,mob,tel,extn,email,area_id,actvty_id,dept_id) values('"+cldocno+"','CRM',"+j+","
						+"'"+(cparray[0].equalsIgnoreCase("undefined")||cparray[0]==null || cparray[0].equalsIgnoreCase("") || cparray[0].trim().equalsIgnoreCase("NaN")|| cparray[0].isEmpty()?0:cparray[0].trim())+"',"
						+ "'"+(cparray[1].trim().equalsIgnoreCase("undefined")||cparray[1]==null  || cparray[1].trim().equalsIgnoreCase("") || cparray[1].trim().equalsIgnoreCase("NaN")|| cparray[1].isEmpty()?"":cparray[1].trim())+"',"
						+ "'"+(cparray[2].trim().equalsIgnoreCase("undefined")||cparray[2]==null  || cparray[2].trim().equalsIgnoreCase("") || cparray[2].trim().equalsIgnoreCase("NaN")|| cparray[2].isEmpty()?"":cparray[2].trim())+"',"
						+ "'"+(cparray[3].trim().equalsIgnoreCase("undefined")||cparray[3]==null  || cparray[3].trim().equalsIgnoreCase("") || cparray[3].trim().equalsIgnoreCase("NaN")|| cparray[3].isEmpty()?"":cparray[3].trim())+"',"
						+ "'"+(cparray[4].trim().equalsIgnoreCase("undefined")||cparray[4]==null  || cparray[4].trim().equalsIgnoreCase("") || cparray[4].trim().equalsIgnoreCase("NaN")|| cparray[4].isEmpty()?"":cparray[4].trim())+"',"
						+ "'"+(cparray[5].trim().equalsIgnoreCase("undefined")||cparray[5]==null  || cparray[5].trim().equalsIgnoreCase("") || cparray[5].trim().equalsIgnoreCase("NaN")|| cparray[5].isEmpty()?0:cparray[5].trim())+"',"
						+ "'"+(cparray[6].trim().equalsIgnoreCase("undefined")||cparray[6]==null  || cparray[6].trim().equalsIgnoreCase("") || cparray[6].trim().equalsIgnoreCase("NaN")|| cparray[6].isEmpty()?0:cparray[6].trim())+"',"
						+ "'"+(cparray[7].trim().equalsIgnoreCase("undefined")||cparray[7]==null  || cparray[7].trim().equalsIgnoreCase("") || cparray[7].trim().equalsIgnoreCase("NaN")|| cparray[7].isEmpty()?0:cparray[7].trim())+"')";
	
				//System.out.println("==tclsql===+"+tclsql);
				val = stmt.executeUpdate (tclsql); 
				j=j+1;
			}  
		}else if(process.equalsIgnoreCase("GC")){
			String tclsql="insert into sk_clgroup(name, status) values('"+grpcmp+"',3)";   
 			//System.out.println("==tclsql===+"+tclsql);
			val = stmt.executeUpdate (tclsql);   
		}else{}   
		
	    if(val>0){
			conn.commit();
		}
		 response.getWriter().print(val);   
 	stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
   }finally{
	   conn.close();
   }
%>
