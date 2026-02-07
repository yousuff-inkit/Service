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
		
		String docno=request.getParameter("docno");
		String company=request.getParameter("company");
		String indcode=request.getParameter("indcode");
		String date=request.getParameter("date");
		java.sql.Date sqlfromdate = null;
		if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(date);
     		
     	}

		String sql=null,rapath="";
		int val=0,docNo=0,comp_id=0,comp_code=0;
	    if(!(docno.equalsIgnoreCase("undefined"))&&!(docno.equalsIgnoreCase(""))&&!(docno.equalsIgnoreCase("0"))){
				 String sql1="";
				 
				 sql1="update gw_complist set company='"+company+"',indcode='"+indcode+"',date='"+sqlfromdate+"' where doc_no= '"+docno+"' ";
			//	 System.out.println("sql1=============="+sql1);
				 val= stmt.executeUpdate(sql1);
				 if(val<=0){
					stmt.close();
					conn.close();
				}
			}
	    else
	    {
	    	String sqls="select coalesce(max(doc_no)+1,1) doc_no,coalesce(max(comp_id)+1,1) comp_id,max(convert(comp_code,SIGNED))+1 comp_code,'' rapath from gw_complist where comp_code!=99999 ";
			// System.out.println("sqls=============="+sqls);

	    	ResultSet resultSet = stmt.executeQuery(sqls);
	  
	        while (resultSet.next()) {
			   docNo=resultSet.getInt("doc_no");
			   comp_id=resultSet.getInt("comp_id");
			   comp_code=resultSet.getInt("comp_code");
			   rapath=resultSet.getString("rapath");

	        }
	        String sql2="insert into gw_complist(doc_no, comp_id, comp_code, rapath,company,indcode,date) values('"+docNo+"', '"+comp_id+"', '"+comp_code+"', '"+rapath+"','"+company+"','"+indcode+"',curdate())";
			// System.out.println("sql2=============="+sql2);

	        val= stmt.executeUpdate(sql2);
			 if(val<=0){
				    stmt.close();
					conn.close();
				}
	    }
		
		
        
        /*Inserting gl_bchg*/
	   
		 /*Inserting gl_bchg Ends*/
	 	 
     	 				
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
