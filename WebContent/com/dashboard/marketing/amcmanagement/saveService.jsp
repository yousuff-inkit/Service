<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<%@page import="java.text.SimpleDateFormat" %>  
<%	
ClsConnection ClsConnection=new ClsConnection();

ClsCommon ClsCommon=new ClsCommon();
ClsServiceReportDAO sdao= new ClsServiceReportDAO();
	Connection conn = null;
	Statement stmt=null;
String temp="0";
ArrayList<String> activityarray= new ArrayList<String>();
ArrayList<String> tobeinvoicedarray= new ArrayList<String>();


SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
String dt=sdf.format(new java.util.Date());
java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(dt);
String userid=session.getAttribute("USERID").toString().trim();
String company=session.getAttribute("COMPANYID").toString().trim();
int dataval=0;
	try{
	 	conn = ClsConnection.getMyConnection();
	 	 //conn.setAutoCommit(false);
		stmt = conn.createStatement();
		//activityarray=null;
		String vocno =request.getParameter("jobvocno")==null?"":request.getParameter("jobvocno").toString(); 
		String branch=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");    
		String method=request.getParameter("method")==null?"":request.getParameter("method");  
		int txtcustomerdocno=request.getParameter("txtcustomerdocno")==null || request.getParameter("txtcustomerdocno")==""?0:Integer.parseInt(request.getParameter("txtcustomerdocno"));
		int txtcustomeracno=request.getParameter("txtcustomeracno")==null || request.getParameter("txtcustomeracno")==""?0:Integer.parseInt(request.getParameter("txtcustomeracno"));
		String cmbcontracttype=request.getParameter("cmbcontracttype")==null?"":request.getParameter("cmbcontracttype");
		String txtcontracttrno=request.getParameter("txtcontracttrno")==null?"":request.getParameter("txtcontracttrno");
		String txtsiteid=request.getParameter("txtsiteid")==null?"":request.getParameter("txtsiteid");
		String txtareaid=request.getParameter("txtareaid")==null?"":request.getParameter("txtareaid");
		int txtscheduleno=request.getParameter("txtscheduleno")==null || request.getParameter("txtscheduleno")==""?0:Integer.parseInt(request.getParameter("txtscheduleno"));
		String servicetype=request.getParameter("servicetype")==null?"0":request.getParameter("servicetype");
		double txtxper=request.getParameter("txtxper")==null || request.getParameter("txtxper")==""?0.0:Double.parseDouble(request.getParameter("txtxper"));
		String txtdesc=request.getParameter("txtdesc")==null?"":request.getParameter("txtdesc");
		int rectval=request.getParameter("rectval")==null || request.getParameter("rectval")==""?0:Integer.parseInt(request.getParameter("rectval"));
		int txtsrtrno=request.getParameter("txtsrtrno")==null || request.getParameter("txtsrtrno")==""?0:Integer.parseInt(request.getParameter("txtsrtrno"));
		int txtsrdocno=request.getParameter("txtsrdocno")==null || request.getParameter("txtsrdocno")==""?0:Integer.parseInt(request.getParameter("txtsrdocno"));
		//System.out.println("2");  
		
		if(method.equalsIgnoreCase("Saved"))  
		{
			System.out.println("details==="+txtcustomerdocno+"==="+txtsrtrno+"==="+txtsrdocno);
			
			System.out.println("in edit service report==="+txtxper);
			
			System.out.println(branch+"===rectval==="+rectval);    
			
			String container="",sql2="";
			
			int iclstatus=0;
			if(txtxper==100){
				iclstatus=3;
			}
			if(txtxper!=100){
				iclstatus=4;
			}
			if(txtxper!=0.0){
			String container1="update cm_srvdetm set wrkper="+txtxper+"  where tr_no="+txtsrtrno+"";
				int valk=stmt.executeUpdate(container1);
			}
			
			if(rectval!=0){
				String container2="update cm_srvdetm set chkrect="+rectval+"  where tr_no="+txtsrtrno+"";
				int valb=stmt.executeUpdate(container2);
			}
			
			if(!txtdesc.equalsIgnoreCase("")){
				String container3="update cm_srvdetm set rect='"+txtdesc+"'  where tr_no="+txtsrtrno+"";
				int valc=stmt.executeUpdate(container3);
			}
			 
			 
			 String sql1="insert into cm_srvreportstatus (rtrno, DATE, cmpid, brhid, userId, wrkPer) values ("+txtsrtrno+",'"+sqlDate+"',"+company+","+branch+","+userid+","+txtxper+");";
			 int valg=stmt.executeUpdate(sql1);
			 if(cmbcontracttype.equalsIgnoreCase("AMC") || cmbcontracttype.equalsIgnoreCase("SJOB")){
			 sql2="update cm_srvcontrm set JBAction=4 where tr_no="+txtcontracttrno+"";
			 }
			 else if(cmbcontracttype.equalsIgnoreCase("CREG")) {
			 sql2="update cm_cuscallm set clstatus="+iclstatus+" where tr_no="+txtcontracttrno+"";
		      }
		     int valh=stmt.executeUpdate(sql2);
			 System.out.println("result======"+valg+"==="+valh);
			 
			 if( valg>0 && valh>0){
				 temp="1";
			 }
			//  boolean Status=sdao.edit(txtsrdocno,"SRVE",txtsrtrno,sqlDate,"",txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,txtsiteid,txtareaid,txtscheduleno,txtxper,0.0,activityarray,tobeinvoicedarray,session,request,"E",rectval,txtdesc);
			  
			  
			if(!container.equalsIgnoreCase("")){
				String sql="update cm_srvdetm set  where tr_no="+txtsrtrno+" and doc_no="+txtsrdocno+" ";
			} 
			 activityarray.add(servicetype+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"Auto Generated Service Report"+"::");
			if(txtsrtrno>0){
				System.out.println("in edit service report");
				boolean Status=sdao.edit(txtsrdocno,"SRVE",txtsrtrno,sqlDate,"",txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,
				txtsiteid,txtareaid,txtscheduleno,txtxper,0.0,activityarray,tobeinvoicedarray,session,request,"E",rectval,txtdesc);
				//System.out.println("3");
				if(Status)
		{
			temp="1";
		}
		else{
			temp="0";
		}
			}
			else{
				System.out.println("in insert service report");
			int val=sdao.insert(sqlDate,"SRVE","",txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,
					txtsiteid,txtareaid,txtscheduleno,txtxper,0.0,activityarray,tobeinvoicedarray,session,request,"A",rectval,txtdesc);
			//System.out.println("4");
			if(val>0)
			{
				temp="1";
			}
			} 
		}else{
			
			 String sql="update cm_srvdetm set confirm=1 where tr_no="+txtsrtrno+"";	
			 System.out.println("sql===="+sql);
			 int val=stmt.executeUpdate(sql);	
			 if(val>0)
			 {
				 temp="1";   
			 }
		}
		if(temp.equalsIgnoreCase("1")){         
		     String logdesc="Service "+method+"###"+txtscheduleno;                           
			 String sqllog="insert into gl_jobactivitylog(doc_no, brhId, dtype, edate, userId,description) values("+vocno+",'"+branch+"','AMCM',now(),'"+session.getAttribute("USERID")+"','"+logdesc+"')";                       
			 //System.out.println("====sqllog===="+sqllog);  
			 dataval=stmt.executeUpdate(sqllog);
	     }
		 response.getWriter().print(dataval);      
 		
 	
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   stmt.close();
	   conn.close();
   }
%>
