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
<%@page import="com.email.*"%>
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();
	 	Statement stmt = conn.createStatement();  
	 	Statement stmt2 = conn.createStatement();
	 	String srno=request.getParameter("srno")==null || request.getParameter("srno").trim()==""?"0":request.getParameter("srno").trim();
	 	String contrno=request.getParameter("contrno")==null || request.getParameter("contrno").trim()==""?"0":request.getParameter("contrno").trim();
		int val=0,rowno=0,month=0,year=0,count=0;   
		Double tiptotal=0.0;
		
		String strsql="select d.rowno,coalesce(tf.disposalfee,0) tippingfee from sk_srvcontrdet d left join sk_tippingtariff tf on tf.wastetypeid=d.wastetype and tf.skipsizeid=d.skiptype where d.rdocno='"+contrno+"' and d.srno='"+srno+"'"; 
		//System.out.println("strsql==="+strsql);  
		ResultSet rs = stmt.executeQuery(strsql);         
		while(rs.next()) {  
			tiptotal=rs.getDouble("tippingfee");      
			rowno=rs.getInt("rowno");
		}
		
		String strsql1="select count(*) val,month(sc.date) month,year(sc.date) year from sk_srvcontrsch sc where sc.rdocno='"+contrno+"' and sc.srno='"+srno+"' group by month(sc.date),year(sc.date) order by year(sc.date),month(sc.date)"; 
		//System.out.println("strsql1==="+strsql1);    
		ResultSet rs1 = stmt.executeQuery(strsql1);         
		while(rs1.next()) {
			int val1=0;   
			month=rs1.getInt("month");
			year=rs1.getInt("year");
			count=rs1.getInt("val");
			String strsql2="select * from sk_triptotal where year='"+year+"' and month='"+month+"' and contractno='"+contrno+"' and contdetno='"+rowno+"'"; 
			//System.out.println("strsql2==="+strsql2);  
			ResultSet rs2 = stmt2.executeQuery(strsql2);           
			if(rs2.next()) {  
				val1=1;
			}
			if(val1==0){
				 String inssql="insert into sk_triptotal(year, month, contractno, contdetno, tottrips, executedtrip, chargedtrip, invoicetrip, tippinginvoiced, gateinvoiced, tiptotal) values('"+year+"', '"+month+"', '"+contrno+"', '"+rowno+"', '"+count+"', 0, 0, '"+count+"', '"+count+"', '"+count+"', "+tiptotal+")";                     
				 //System.out.println("inssql--->>>"+inssql);    
				 val= stmt2.executeUpdate(inssql);
			}
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
