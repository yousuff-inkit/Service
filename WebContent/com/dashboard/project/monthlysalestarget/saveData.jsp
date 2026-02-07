<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
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
		int differentiater=request.getParameter("differentiater")=="" || request.getParameter("differentiater")==null?0:Integer.parseInt(request.getParameter("differentiater").toString());
		int rowno=request.getParameter("rowno")=="" || request.getParameter("rowno")==null?0:Integer.parseInt(request.getParameter("rowno").toString());
		String year=request.getParameter("year")=="" || request.getParameter("year")==null?"0":request.getParameter("year");
		String month=request.getParameter("month")=="" || request.getParameter("month")==null?"0":request.getParameter("month");
		String targetval=request.getParameter("targetval")=="" || request.getParameter("targetval")==null?"0":request.getParameter("targetval");
		String branch=request.getParameter("branch")=="" || request.getParameter("branch")==null?"0":request.getParameter("branch");
		String salid=request.getParameter("salid")=="" || request.getParameter("salid")==null?"0":request.getParameter("salid");
		String percentval=request.getParameter("percentval")=="" || request.getParameter("percentval")==null?"0":request.getParameter("percentval");
		int val=0;                      
		String strcountdata="";  
		if(differentiater==1){
			if(rowno>0){        
				strcountdata="update cm_monthsalem set type="+differentiater+",year='"+year+"', month='"+month+"', brhid='"+branch+"', targetval='"+targetval+"',gpper='"+percentval+"' where rowno='"+rowno+"'";   
			}else{
				strcountdata="insert into cm_monthsalem(year, month, brhid, targetval,type,gpper) values('"+year+"','"+month+"','"+branch+"','"+targetval+"',"+differentiater+","+percentval+")";   
			}     
		}else if(differentiater==2){     
			if(rowno>0){                
				strcountdata="update cm_monthsalem set type="+differentiater+",year='"+year+"', month='"+month+"', salid='"+salid+"', targetval='"+targetval+"',gpper='"+percentval+"' where rowno='"+rowno+"'";   
			}else{
				strcountdata="insert into cm_monthsalem(year, month, salid, targetval,type,gpper) values('"+year+"','"+month+"','"+salid+"','"+targetval+"',"+differentiater+","+percentval+")";   
			}
		}    
			 
			//System.out.println("strcountdata--->>>"+strcountdata);                                                         
			val=stmt.executeUpdate(strcountdata);          
			//System.out.println("val--->>>"+val);      
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
