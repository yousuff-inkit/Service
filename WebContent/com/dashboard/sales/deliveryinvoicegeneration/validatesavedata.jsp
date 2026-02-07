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

<%ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
int resultSet4 =0;
String list=request.getParameter("list")==null?"0":request.getParameter("list");

 
String dates=request.getParameter("date")==null?"0":request.getParameter("date");
String masterdocno=request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
String branchvals=request.getParameter("branchvals")==null?"0":request.getParameter("branchvals");
String refnos=request.getParameter("refnos")==null?"0":request.getParameter("refnos");
String description=request.getParameter("description")==null?"0":request.getParameter("description");
String locationid=request.getParameter("locationid")==null?"1":request.getParameter("locationid");

/* System.out.println("===list====="+list);


System.out.println("===dates====="+dates);
System.out.println("===masterdocno====="+masterdocno);
System.out.println("===branchvals====="+branchvals);
System.out.println("===refnos====="+refnos);
System.out.println("===description====="+description);
System.out.println("===locationid====="+locationid); */

ArrayList<String> mainarray= new ArrayList<String>();
String aa[]=list.split(",");

java.sql.Date date=ClsCommon.changeStringtoSqlDate(dates);
 
String doc="0"; 




for(int k=0;k<aa.length;k++){
	 
	 String bb[]=aa[k].split("::");
	  
	 String temp="";
	 for(int j=0;j<bb.length;j++){ 
		 
	 
		 temp=temp+bb[j]+"::";
		 
	}
	 mainarray.add(temp);
	 
} 
double fr=1;


	  Connection conn=null;
	    String sql="";
	    try
	    {
	   	
	    					conn = ClsConnection.getMyConnection();
	    					Statement st=conn.createStatement();
	      					String sqlsdel="delete from  my_focvalidate where rdocno="+masterdocno+"";
	       					st.executeUpdate(sqlsdel); 
	       					
	       					
	       					int multimethod=0;
	       				 Statement stmtqty=conn.createStatement();
	       				 String chkw="select method  from gl_prdconfig where field_nme='multiqty'";
	       				  
	       				 ResultSet rsszs=stmtqty.executeQuery(chkw); 
	       				 if(rsszs.next())
	       				 {
	       					 
	       					  
	       					 multimethod=rsszs.getInt("method");
	       					 
	       				 }
	       					
				            Statement stmt1=conn.createStatement();
				            Statement stmt2=conn.createStatement();
						for(int i=0;i<mainarray.size();i++)
						{
							
										
							String[] prod=((String) mainarray.get(i)).split("::");
							
							int temp=0;
										
							String rowno=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
							String qtys=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
							String focs=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
							double qty=Double.parseDouble(qtys);
							double foc=Double.parseDouble(focs);
							
							int  prdId=0;int  orddocno=0;int  psrno=0;String  batch_no="";Date  exp_date=null;
							double totqty=0;double out_qty=0;double totfoc=0;double out_foc=0;
							int  SpecNo=0;int  stockid=0;int  unitid=1;double unitprice=0;
							double total=0;double disper=0;double nettotal=0;double discount=0;
							
							
							
							
							
							String  ordsqls="select  psrno,unitid   from my_sorderd   where doc_no="+rowno+"   ";
						 	System.out.println("===ordsqls====="+ordsqls);
							ResultSet ar=st.executeQuery(ordsqls);
							if(ar.next())
							{
								psrno=ar.getInt("psrno");
								
								unitid=ar.getInt("unitid");
								
							}
							
							if(multimethod>0)
							{
							
							  Statement stmt=conn.createStatement();
							    fr=1;
							     String slss=" select fr from my_unit where psrno="+psrno+" and unit='"+unitid+"' ";
							     
							 //    System.out.println("====slss==="+slss);
							     ResultSet rv1=stmt.executeQuery(slss);
							     if(rv1.next())
							     {
							    	 fr=rv1.getDouble("fr"); 
							     }
							}
					    	 
							
							
							String partno="";
							
							String  ordsqlsw="select  part_no   from my_main   where psrno="+psrno+"   ";
						//	System.out.println("===ordsqlsw====="+ordsqlsw);
							ResultSet ar1=st.executeQuery(ordsqlsw);
							if(ar1.next())
							{
								partno=ar1.getString("part_no");
							}
							
							
							
							 String sqlsss="insert into my_focvalidate(rdocno, sr_no, psrno, qty, foc,part_no)VALUES"
							 		+ " ("+masterdocno+","+(i+1)+",'"+psrno+"','"+qty*fr+"','"+foc*fr+"','"+partno+"')";
						       System.out.println("sqlsss--->>>>Sql"+sqlsss);
						     int ss= stmt1.executeUpdate (sqlsss);
							 
						 
		                 }	
						
						
					
					

						
						
				double valqty=0;		
				double valfoc=0;
				int valpsrno=0;
				
			   	
		    	double maxvalqty=0;		
				double maxvalfoc=0;
				
				int k=0;
				
				double maxfoc=0;
				String mxpart_no="";
				String part_no="";
				    String sqlss="select sum(qty) qty ,sum(foc) foc,psrno,part_no   from my_focvalidate where rdocno="+masterdocno+" group by psrno ";	
				    
				  //  System.out.println("-----sqlss---sum---"+sqlss);
				    ResultSet rssss=stmt1.executeQuery(sqlss);
				    
				    while(rssss.next())
				    {
				    	valqty=rssss.getDouble("qty");
				    	valfoc=rssss.getDouble("foc");
				    	valpsrno=rssss.getInt("psrno");
				    	part_no=rssss.getString("part_no");
				    	  maxvalqty=0;		
						  maxvalfoc=0;
						  
						  
						    
						   
					
						
						
				    	String sqls1="select foc,qty,psrno from  my_prodfocfixing where psrno="+valpsrno+" and qty<="+valqty+" order by qty desc  ";
				    	// System.out.println("-----sqls1- dochk------"+sqls1);
				       ResultSet rss=stmt2.executeQuery(sqls1);
				       
				       
				       
				    	if(rss.first())
				    	{
				    		maxvalfoc=rss.getDouble("foc");
				    	}
				   
				    	
				    	// System.out.println("----valfoc--"+valfoc);
				    	// System.out.println("----maxvalfoc-----"+maxvalfoc);
				    	
				    	
				    	
				    	if(valfoc>maxvalfoc)
				    	{
				    		
				    		// System.out.println("--INNNNNNNNNNNNNNNNNNN----");
				    		
				    		maxfoc=maxvalfoc;
				    		mxpart_no=part_no;
				    		k=1;
				    		conn.close();
				    		break;
				    	}
				    	
				    	
					if(maxfoc>0)
					{
						
					 
						break;	
					}
				    	
				    	
				    	
				    }
						
						
				  
				    	conn.close();
				    	response.getWriter().write(k+"::"+maxfoc/fr+"::"+mxpart_no);
					 		
						
	
    	
    }
    catch(Exception e)
    {
    	e.printStackTrace();
    	conn.close();
    	response.getWriter().write(22+"::"+0);
    }
	 	
	 	
	 	
%>



 