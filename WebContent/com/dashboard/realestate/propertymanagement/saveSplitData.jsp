<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>  
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %>  
<%@page import="com.common.*"%>                   
<%   
	String gridarray=request.getParameter("gridarray")==null?"":request.getParameter("gridarray");
	String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
	String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString();	
	String userid=session.getAttribute("USERID").toString();      
	java.sql.Date sqldate=null;          
	ClsConnection objconn=new ClsConnection();    
	ClsCommon ClsCommon=new ClsCommon();
	Connection conn=null;
	int val=0,val1=0;   
	String logdesc="";     
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");              
		java.util.Date curDate=new java.util.Date();
		java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		Statement stmt=conn.createStatement();  
			ArrayList<String> newarray=new ArrayList();
			//System.out.println("gridarray--->>>"+gridarray);
			String temparray[]=gridarray.split(",");
			for(int i=0;i<temparray.length;i++){
				newarray.add(temparray[i]);
			}
			for(int i=0;i<newarray.size();i++){
				String temp[]=newarray.get(i).split("::");
				if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
				String name = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"":temp[0].trim()).toString();    
				String remarks = temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"":temp[1].trim().toString();
				int rowsno= temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?0:Integer.parseInt(temp[2].trim().toString());   
				int srno= temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?0:Integer.parseInt(temp[3].trim().toString());
				           
				if(rowsno>0){   
					 String sql="update rl_propertysub set name='"+name+"', remarks='"+remarks+"' where rowno="+rowsno+" and status<>7";               
					 val=stmt.executeUpdate(sql);
			    }else{ 
					 String sql="insert into rl_propertysub(propertyid, srno, name, remarks) values("+docno+","+(i+1)+",'"+name+"','"+remarks+"')";
					 val=stmt.executeUpdate(sql);    
		        }     
			   } 
			/* conn.commit(); */         
		    }      
			if(val>0){
				 logdesc="Property splitted - Property Docno#"+docno;               
 				 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','PMT',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                   
				 //System.out.println(val+"====sqllog===="+sqllog);
				 stmt.executeUpdate(sqllog);     
				 val1=1;                
				 conn.commit();  
			}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	finally{
		conn.close();
	}   
	response.getWriter().print(val1);              
%>