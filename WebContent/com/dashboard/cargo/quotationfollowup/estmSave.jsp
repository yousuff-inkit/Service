<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*" %>

<%
Connection conn = null;
ClsConnection ClsConnection=new ClsConnection();
int errorstatus=0;
String gridarray=request.getParameter("gridarray");
ArrayList<String> griddataarray = new ArrayList<String>();
String docno=request.getParameter("docno").toString();
String enqdocno=request.getParameter("enqdocno").toString();  
String jobno=request.getParameter("jobno").toString(); 
String cmbinfo=request.getParameter("cmbinfo").toString(); 
System.out.println("cmbinfo======="+cmbinfo);
String[] temparray=gridarray.split(",");
for(int i=0;i<temparray.length;i++){
 griddataarray.add(temparray[i]);
}

try{
	conn=ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement();      
	
	for(int i=0;i< griddataarray.size();i++){
		String[] arrayDet=((String) griddataarray.get(i)).split("::");
		if(!(arrayDet[2].trim().equalsIgnoreCase("undefined")|| arrayDet[2].trim().equalsIgnoreCase("NaN")||arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()))
		{
			String sql="INSERT INTO cr_qotjobd(jobno, refdocno, rdocno, typeid, curid, rate, price, qty, uom, total, btotal, billing, vndid, costprice, margin, marginper) VALUES("            
					+ "'"+jobno+"',"                         
					+ "'"+(arrayDet[0].trim().equalsIgnoreCase("undefined") || arrayDet[0].trim().equalsIgnoreCase("NaN")|| arrayDet[0].trim().equalsIgnoreCase("")|| arrayDet[0].isEmpty()?0:arrayDet[0].trim())+"',"
					+ "'"+(arrayDet[1].trim().equalsIgnoreCase("undefined") || arrayDet[1].trim().equalsIgnoreCase("NaN")|| arrayDet[1].trim().equalsIgnoreCase("")|| arrayDet[1].isEmpty()?0:arrayDet[1].trim())+"',"
					+ "'"+(arrayDet[2].trim().equalsIgnoreCase("undefined") || arrayDet[2].trim().equalsIgnoreCase("NaN")|| arrayDet[2].trim().equalsIgnoreCase("")|| arrayDet[2].isEmpty()?0:arrayDet[2].trim())+"',"
					+ "'"+(arrayDet[3].trim().equalsIgnoreCase("undefined") || arrayDet[3].trim().equalsIgnoreCase("NaN")|| arrayDet[3].trim().equalsIgnoreCase("")|| arrayDet[3].isEmpty()?0:arrayDet[3].trim())+"',"
					+ "'"+(arrayDet[4].trim().equalsIgnoreCase("undefined") || arrayDet[4].trim().equalsIgnoreCase("NaN")|| arrayDet[4].trim().equalsIgnoreCase("")|| arrayDet[4].isEmpty()?0:arrayDet[4].trim())+"',"
					+ "'"+(arrayDet[5].trim().equalsIgnoreCase("undefined") || arrayDet[5].trim().equalsIgnoreCase("NaN")|| arrayDet[5].trim().equalsIgnoreCase("")|| arrayDet[5].isEmpty()?0:arrayDet[5].trim())+"',"
					+ "'"+(arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:arrayDet[6].trim())+"',"
					+ "'"+(arrayDet[7].trim().equalsIgnoreCase("undefined") || arrayDet[7].trim().equalsIgnoreCase("NaN")|| arrayDet[7].trim().equalsIgnoreCase("")|| arrayDet[7].isEmpty()?0:arrayDet[7].trim())+"',"
					+ "'"+(arrayDet[8].trim().equalsIgnoreCase("undefined") || arrayDet[8].trim().equalsIgnoreCase("NaN")|| arrayDet[8].trim().equalsIgnoreCase("")|| arrayDet[8].isEmpty()?0:arrayDet[8].trim())+"',"
					+ "'"+(arrayDet[9].trim().equalsIgnoreCase("undefined") || arrayDet[9].trim().equalsIgnoreCase("NaN")|| arrayDet[9].trim().equalsIgnoreCase("")|| arrayDet[9].isEmpty()?0:arrayDet[9].trim())+"',"
					+ "'"+(arrayDet[10].trim().equalsIgnoreCase("undefined") || arrayDet[10].trim().equalsIgnoreCase("NaN")|| arrayDet[10].trim().equalsIgnoreCase("")|| arrayDet[10].isEmpty()?"":arrayDet[10].trim())+"',"
					+ "'"+(arrayDet[11].trim().equalsIgnoreCase("undefined") || arrayDet[11].trim().equalsIgnoreCase("NaN")|| arrayDet[11].trim().equalsIgnoreCase("")|| arrayDet[11].isEmpty()?0:arrayDet[11].trim())+"',"
					+ "'"+(arrayDet[12].trim().equalsIgnoreCase("undefined") || arrayDet[12].trim().equalsIgnoreCase("NaN")|| arrayDet[12].trim().equalsIgnoreCase("")|| arrayDet[12].isEmpty()?0.0:arrayDet[12].trim())+"',"
					+ "'"+(arrayDet[13].trim().equalsIgnoreCase("undefined") || arrayDet[13].trim().equalsIgnoreCase("NaN")|| arrayDet[13].trim().equalsIgnoreCase("")|| arrayDet[13].isEmpty()?0.0:arrayDet[13].trim())+"',"
					+ "'"+(arrayDet[14].trim().equalsIgnoreCase("undefined") || arrayDet[14].trim().equalsIgnoreCase("NaN")|| arrayDet[14].trim().equalsIgnoreCase("")|| arrayDet[14].isEmpty()?0.0:arrayDet[14].trim())+"')";
			//System.out.println("====insertcr_qotjobd===="+sql);
			errorstatus = stmt.executeUpdate (sql); 
			System.out.println("====errorstatus==1=="+errorstatus);
			int outqty=arrayDet[6].trim().equalsIgnoreCase("undefined") || arrayDet[6].trim().equalsIgnoreCase("NaN")|| arrayDet[6].trim().equalsIgnoreCase("")|| arrayDet[6].isEmpty()?0:Integer.parseInt(arrayDet[6].trim());
			int qdocno=arrayDet[15].trim().equalsIgnoreCase("undefined") || arrayDet[15].trim().equalsIgnoreCase("NaN")|| arrayDet[15].trim().equalsIgnoreCase("")|| arrayDet[15].isEmpty()?0:Integer.parseInt(arrayDet[15].trim());
			int exoutqty=arrayDet[16].trim().equalsIgnoreCase("undefined") || arrayDet[16].trim().equalsIgnoreCase("NaN")|| arrayDet[16].trim().equalsIgnoreCase("")|| arrayDet[16].isEmpty()?0:Integer.parseInt(arrayDet[16].trim());
		    int totqty=exoutqty+outqty;          
			if((errorstatus>0) && cmbinfo.equalsIgnoreCase("1")){
		    	String sqlup="update cr_qotd set out_qty='"+totqty+"' where doc_no='"+qdocno+"'";                                                 
		    	System.out.println("====update cr_qotd=="+sqlup);
		    	errorstatus = stmt.executeUpdate (sqlup);   
				System.out.println("====errorstatus==2=="+errorstatus);
		    }
		}
	}
	if(errorstatus>0){      
		String userid=session.getAttribute("USERID").toString();
		String brhid =session.getAttribute("BRANCHID").toString();
		PreparedStatement stmtlog=conn.prepareStatement("insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, ENTRY) values (?,?,?,now(),?,?,?,?)");
		 
		 stmtlog.setString(1,docno);
		 stmtlog.setInt(2,Integer.parseInt(brhid));
		 stmtlog.setString(3,"CAQF");
		 stmtlog.setString(4, userid);     
		 stmtlog.setInt(5, 0);
		 stmtlog.setInt(6, 0);
		 stmtlog.setString(7, "A");
		 
		 errorstatus=stmtlog.executeUpdate();
		 System.out.println("====errorstatus==3=="+errorstatus);
	}
	if(errorstatus>0){    
		conn.commit();
	}
	response.getWriter().print(errorstatus);   
}
catch(Exception e){
	e.printStackTrace();
	response.getWriter().print(0);
}
finally{
	conn.close();
}

%>