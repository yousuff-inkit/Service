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
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
int resultSet4 =0;
String list=request.getParameter("list")==null?"0":request.getParameter("list");

ArrayList<String> mainarray= new ArrayList<String>();
String aa[]=list.split(",");

 
String doc="0"; 
for(int i=0;i<aa.length;i++){
	 
	 String bb[]=aa[i].split("::");
	  
	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
		 
	 
		 temp=temp+bb[j]+"::";
		 
	}
	 mainarray.add(temp);
	 
} 

	  Connection conn=null;
	    String sql="";
	    try
	    { ClsConnection ClsConnection =new ClsConnection();
	   	
	    conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		
		for(int k=0;k<mainarray.size();k++)
		{
		
		 

			     String[] serarray=mainarray.get(k).split("::");  
			     
			     if(k==0)
					{
						  doc=""+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"";
						
						 
						
						String sqls="delete from  my_benqps where rdocno='"+doc+"' ";
									
				   	    stmt.executeUpdate(sqls); 
					
					}
			     
			 
			    	 
			    	                                      //  0       1      2      3      4             5            6             7           8         9     10        11       12         13
			     String sql2="INSERT INTO my_benqps(sr_no,rdocno,refdocno, prdid, qty, stock, cost_price, sellingprice, discount, netsellingprice, rfqdocno, acno, rfqprice, margin, netprice, squoteprice)VALUES"
			  	           + " ("+(k+1)+","
					       + "'"+(serarray[0].trim().equalsIgnoreCase("undefined") || serarray[0].trim().equalsIgnoreCase("null") || serarray[0].trim().equalsIgnoreCase("NaN")||serarray[0].trim().equalsIgnoreCase("")|| serarray[0].isEmpty()?0:serarray[0].trim())+"',"
					       + "'"+(serarray[14].trim().equalsIgnoreCase("undefined") || serarray[14].trim().equalsIgnoreCase("null") || serarray[14].trim().equalsIgnoreCase("NaN")||serarray[14].trim().equalsIgnoreCase("")|| serarray[14].isEmpty()?0:serarray[14].trim())+"',"
					       + "'"+(serarray[1].trim().equalsIgnoreCase("undefined") || serarray[1].trim().equalsIgnoreCase("null") || serarray[1].trim().equalsIgnoreCase("NaN")||serarray[1].trim().equalsIgnoreCase("")|| serarray[1].isEmpty()?0:serarray[1].trim())+"',"
					       + "'"+(serarray[2].trim().equalsIgnoreCase("undefined") || serarray[2].trim().equalsIgnoreCase("null") || serarray[2].trim().equalsIgnoreCase("NaN")||serarray[2].trim().equalsIgnoreCase("")|| serarray[2].isEmpty()?0:serarray[2].trim())+"',"
					       + "'"+(serarray[3].trim().equalsIgnoreCase("undefined") || serarray[3].trim().equalsIgnoreCase("null") || serarray[3].trim().equalsIgnoreCase("NaN")||serarray[3].trim().equalsIgnoreCase("")|| serarray[3].isEmpty()?0:serarray[3].trim())+"',"
					       + "'"+(serarray[4].trim().equalsIgnoreCase("undefined") || serarray[4].trim().equalsIgnoreCase("null") || serarray[4].trim().equalsIgnoreCase("NaN")||serarray[4].trim().equalsIgnoreCase("")|| serarray[4].isEmpty()?0:serarray[4].trim())+"',"
					       + "'"+(serarray[5].trim().equalsIgnoreCase("undefined") || serarray[5].trim().equalsIgnoreCase("null") || serarray[5].trim().equalsIgnoreCase("NaN")||serarray[5].trim().equalsIgnoreCase("")|| serarray[5].isEmpty()?0:serarray[5].trim())+"',"
					       + "'"+(serarray[6].trim().equalsIgnoreCase("undefined") || serarray[6].trim().equalsIgnoreCase("null") || serarray[6].trim().equalsIgnoreCase("NaN")||serarray[6].trim().equalsIgnoreCase("")|| serarray[6].isEmpty()?0:serarray[6].trim())+"',"
					       + "'"+(serarray[7].trim().equalsIgnoreCase("undefined") || serarray[7].trim().equalsIgnoreCase("null") || serarray[7].trim().equalsIgnoreCase("NaN")||serarray[7].trim().equalsIgnoreCase("")|| serarray[7].isEmpty()?0:serarray[7].trim())+"',"
					       + "'"+(serarray[8].trim().equalsIgnoreCase("undefined") || serarray[8].trim().equalsIgnoreCase("null") || serarray[8].trim().equalsIgnoreCase("NaN")||serarray[8].trim().equalsIgnoreCase("")|| serarray[8].isEmpty()?0:serarray[8].trim())+"',"
					       + "'"+(serarray[9].trim().equalsIgnoreCase("undefined") || serarray[9].trim().equalsIgnoreCase("null") || serarray[9].trim().equalsIgnoreCase("NaN")||serarray[9].trim().equalsIgnoreCase("")|| serarray[9].isEmpty()?0:serarray[9].trim())+"',"
					       + "'"+(serarray[10].trim().equalsIgnoreCase("undefined") || serarray[10].trim().equalsIgnoreCase("null")|| serarray[10].trim().equalsIgnoreCase("NaN")||serarray[10].trim().equalsIgnoreCase("")|| serarray[10].isEmpty()?0:serarray[10].trim())+"',"
					       + "'"+(serarray[11].trim().equalsIgnoreCase("undefined") || serarray[11].trim().equalsIgnoreCase("null")|| serarray[11].trim().equalsIgnoreCase("NaN")||serarray[11].trim().equalsIgnoreCase("")|| serarray[11].isEmpty()?0:serarray[11].trim())+"',"
					       + "'"+(serarray[12].trim().equalsIgnoreCase("undefined") || serarray[12].trim().equalsIgnoreCase("null")|| serarray[12].trim().equalsIgnoreCase("NaN")||serarray[12].trim().equalsIgnoreCase("")|| serarray[12].isEmpty()?0:serarray[12].trim())+"',"
					       + "'"+(serarray[13].trim().equalsIgnoreCase("undefined") || serarray[13].trim().equalsIgnoreCase("null")|| serarray[13].trim().equalsIgnoreCase("NaN")||serarray[13].trim().equalsIgnoreCase("")|| serarray[13].isEmpty()?0:serarray[13].trim())+"' )";
			     System.out.println("---------------sql2-----------------"+sql2);
			       resultSet4 = stmt.executeUpdate(sql2);
			     if(resultSet4<=0)
                 {
			      
                 } 
		 
 
		 
	    } 
		 System.out.println("---------------resultSet4-----------------"+resultSet4);
		if(resultSet4>0)
		{
			resultSet4=0;
		String chk="select sum(qty)-sum(out_qty) from my_cusenqd where rdocno='"+doc+"' group by prdid having sum(qty)-sum(out_qty)>0 ";

				System.out.println("===chk==sds="+chk);

				ResultSet rs=stmt.executeQuery(chk); 
				
				while(rs.next())
				{
					resultSet4=1;
					 System.out.println("---------------resultSet4--- while-------------"+resultSet4);
				}
				
		}
		 stmt.close();
		 
	conn.close();
   
	
	response.getWriter().print(resultSet4);
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().print(0);
    }
	 	
	 	
	 	
%>



