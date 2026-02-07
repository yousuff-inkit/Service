<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.ArrayList"%>
<%@page import="net.sf.json.JSONArray"%>   
<%@page import="net.sf.json.JSONObject"%>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;    
	String docsarray=request.getParameter("docsarray")==null || request.getParameter("docsarray").trim()==""?"0":request.getParameter("docsarray").trim();
	String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
	String site=request.getParameter("site")==null?"":request.getParameter("site").trim();
	String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno").trim()==""?"0":request.getParameter("cldocno").trim();
    try{       
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();  
		System.out.println("process--->>>"+processid);               
	    
		int val=0;
		 
		/*Operations*/  
		if(processid.equalsIgnoreCase("Questionnaire")){
			 JSONObject json = JSONObject.fromObject(docsarray);   
			 JSONArray jsonArray = json.getJSONArray("questions");    
		     for (int i = 0; i < jsonArray.size(); i++) {    
		            JSONObject jsobj = jsonArray.getJSONObject(i);  
		            int rowno = jsobj.getString("rowno").equalsIgnoreCase("undefined") || jsobj.getString("rowno").equalsIgnoreCase("") || jsobj.getString("rowno").trim().equalsIgnoreCase("NaN")|| jsobj.getString("rowno").isEmpty()?0:Integer.parseInt(jsobj.getString("rowno").trim().toString());   
		            
		            if(rowno>0){
		            	 PreparedStatement prestmt = conn.prepareStatement("UPDATE sk_clientquestsite SET cldocno=?, site=?, srno=?, question=?, answer=? WHERE rowno=?");
			             
			             prestmt.setString(1, cldocno);
			             prestmt.setString(2, site);  
			             prestmt.setString(3, jsobj.getString("seqno").equalsIgnoreCase("undefined") || jsobj.getString("seqno").equalsIgnoreCase("") || jsobj.getString("seqno").trim().equalsIgnoreCase("NaN")|| jsobj.getString("seqno").isEmpty()?"0":jsobj.getString("seqno").trim());
			             prestmt.setString(4, jsobj.getString("question").equalsIgnoreCase("undefined") || jsobj.getString("question").equalsIgnoreCase("") || jsobj.getString("question").trim().equalsIgnoreCase("NaN")|| jsobj.getString("question").isEmpty()?"":jsobj.getString("question").trim());
			             prestmt.setString(5, jsobj.getString("answer").equalsIgnoreCase("undefined") || jsobj.getString("answer").equalsIgnoreCase("") || jsobj.getString("answer").trim().equalsIgnoreCase("NaN")|| jsobj.getString("answer").isEmpty()?"":jsobj.getString("answer").trim());
			             prestmt.setString(6, jsobj.getString("rowno").equalsIgnoreCase("undefined") || jsobj.getString("rowno").equalsIgnoreCase("") || jsobj.getString("rowno").trim().equalsIgnoreCase("NaN")|| jsobj.getString("rowno").isEmpty()?"0":jsobj.getString("rowno").trim().toString());
			             val = prestmt.executeUpdate(); 
		            }else{
		            	 PreparedStatement prestmt = conn.prepareStatement("INSERT INTO sk_clientquestsite(cldocno, site, srno, question, answer) VALUES(?, ?, ?, ?, ?)");
			             
		            	 prestmt.setString(1, cldocno);
				         prestmt.setString(2, site);  
				         prestmt.setString(3, jsobj.getString("seqno").equalsIgnoreCase("undefined") || jsobj.getString("seqno").equalsIgnoreCase("") || jsobj.getString("seqno").trim().equalsIgnoreCase("NaN")|| jsobj.getString("seqno").isEmpty()?"0":jsobj.getString("seqno").trim());
				         prestmt.setString(4, jsobj.getString("question").equalsIgnoreCase("undefined") || jsobj.getString("question").equalsIgnoreCase("") || jsobj.getString("question").trim().equalsIgnoreCase("NaN")|| jsobj.getString("question").isEmpty()?"":jsobj.getString("question").trim());
				         prestmt.setString(5, jsobj.getString("answer").equalsIgnoreCase("undefined") || jsobj.getString("answer").equalsIgnoreCase("") || jsobj.getString("answer").trim().equalsIgnoreCase("NaN")|| jsobj.getString("answer").isEmpty()?"":jsobj.getString("answer").trim());
				         val = prestmt.executeUpdate();   
		            }
		     } 
		}
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