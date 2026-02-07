<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.project.execution.serviceReport.ClsServiceReportDAO"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="java.text.SimpleDateFormat" %>  
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsServiceReportDAO sdao= new ClsServiceReportDAO();   
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
Statement stmt=null;
String temp="0";
ArrayList<String> activityarray= new ArrayList<String>();
ArrayList<String> tobeinvoicedarray= new ArrayList<String>();

SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
String dt=sdf.format(new java.util.Date());
java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(dt);
String branch=session.getAttribute("BRANCHID").toString().trim();
String userid=session.getAttribute("USERID").toString().trim();
String company=session.getAttribute("COMPANYID").toString().trim();
	try{
	 	conn = ClsConnection.getMyConnection();
		stmt = conn.createStatement();   
		String address=request.getParameter("address")==null?"":request.getParameter("address");  
		String latittude=request.getParameter("latittude")==null?"":request.getParameter("latittude");     
		String longitude=request.getParameter("longitude")==null?"":request.getParameter("longitude");
		String cmbcontracttype=request.getParameter("cmbcontracttype")==null?"":request.getParameter("cmbcontracttype");
		String txtcontracttrno=request.getParameter("txtcontracttrno")==null?"":request.getParameter("txtcontracttrno");
		double txtxper=request.getParameter("txtxper")==null || request.getParameter("txtxper")==""?0.0:Double.parseDouble(request.getParameter("txtxper"));
		String txtdesc=request.getParameter("txtdesc")==null?"":request.getParameter("txtdesc");
		int rectval=request.getParameter("rectval")==null || request.getParameter("rectval")==""?0:Integer.parseInt(request.getParameter("rectval"));
		int txtsrtrno=request.getParameter("txtsrtrno")==null || request.getParameter("txtsrtrno")==""?0:Integer.parseInt(request.getParameter("txtsrtrno"));
		
		int txtcustomerdocno=request.getParameter("txtcustomerdocno")==null || request.getParameter("txtcustomerdocno")==""?0:Integer.parseInt(request.getParameter("txtcustomerdocno"));
		int txtcustomeracno=request.getParameter("txtcustomeracno")==null || request.getParameter("txtcustomeracno")==""?0:Integer.parseInt(request.getParameter("txtcustomeracno"));
		String txtsiteid=request.getParameter("txtsiteid")==null?"":request.getParameter("txtsiteid");
		String txtareaid=request.getParameter("txtareaid")==null?"":request.getParameter("txtareaid");
		int txtscheduleno=request.getParameter("txtscheduleno")==null || request.getParameter("txtscheduleno")==""?0:Integer.parseInt(request.getParameter("txtscheduleno"));
		String servicetype=request.getParameter("servicetype")==null?"0":request.getParameter("servicetype");
		int txtsrdocno=request.getParameter("txtsrdocno")==null || request.getParameter("txtsrdocno")==""?0:Integer.parseInt(request.getParameter("txtsrdocno"));
	      
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
			 /* boolean Status=sdao.edit(txtsrdocno,"SRVE",txtsrtrno,sqlDate,"",txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,
				txtsiteid,txtareaid,txtscheduleno,txtxper,0.0,activityarray,tobeinvoicedarray,session,request,"E",rectval,txtdesc);
			  */
			/* if(!container.equalsIgnoreCase("")){
			String sql="update cm_srvdetm set  where tr_no="+txtsrtrno+" and doc_no="+txtsrdocno+" ";
			} */
			 activityarray.add(servicetype+"::"+"0"+"::"+"1"+"::"+"0"+"::"+"Auto Generated Service Report"+"::");
			if(txtsrtrno>0){
				System.out.println("in edit service report");
				boolean Status=sdao.edit(txtsrdocno,"SRVE",txtsrtrno,sqlDate,"",txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,
				txtsiteid,txtareaid,txtscheduleno,txtxper,0.0,activityarray,tobeinvoicedarray,session,request,"E",rectval,txtdesc);
				System.out.println("Status==="+Status);        
				if(Status){
						temp="1";
				}                         
			}else{
				System.out.println("in insert service report");
				int val=sdao.insert(sqlDate,"SRVE","",txtcustomerdocno,txtcustomeracno,cmbcontracttype,txtcontracttrno,
					txtsiteid,txtareaid,txtscheduleno,txtxper,0.0,activityarray,tobeinvoicedarray,session,request,"A",rectval,txtdesc);
			    //System.out.println("4");
			    txtsrtrno=Integer.parseInt(request.getAttribute("tranno").toString());        
				if(val>0){
					temp="1";
				}
			}
			if(temp.equalsIgnoreCase("1")){   
				String sqlsss="update cm_srvdetm set longitude='"+longitude+"',latittude='"+latittude+"',address='"+address+"' where tr_no="+txtsrtrno+"";
				stmt.executeUpdate(sqlsss);       
			}
		 response.getWriter().print(temp);
 		
 	
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   stmt.close();
	   conn.close();
   }
%>
