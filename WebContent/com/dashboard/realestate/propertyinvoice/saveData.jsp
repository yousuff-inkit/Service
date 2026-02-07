<%@page import="javax.mail.MessagingException"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.mail.internet.AddressException"%>
<%@page import="com.mailwithpdf.SendEmailAction"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>  
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>  
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO"%>     
<%@page import="com.common.*"%>                   
<%  
    int rowno=request.getParameter("rowno")==null || request.getParameter("rowno")==""?0:Integer.parseInt(request.getParameter("rowno").toString());
	String date=request.getParameter("date")==null || request.getParameter("date")==""?"0":request.getParameter("date");     
    String remarks=request.getParameter("remarks")==null || request.getParameter("remarks")==""?"":request.getParameter("remarks");
    String podate=request.getParameter("podate")==null || request.getParameter("podate")==""?"0":request.getParameter("podate");
    String pono=request.getParameter("pono")==null || request.getParameter("pono")==""?"":request.getParameter("pono");
	String amount=request.getParameter("amount")==null || request.getParameter("amount")==""?"0":request.getParameter("amount");   
	String vocno=request.getParameter("vocno")==null || request.getParameter("vocno")==""?"0":request.getParameter("vocno");
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid");
	String rntldocno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString();
	String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno").trim().toString();
	String userid=session.getAttribute("USERID").toString();
	ClsConnection objconn=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	//ClsURLShortener urlshortener=new ClsURLShortener();
	SendEmailAction sendmail=new SendEmailAction();
	Connection conn=null;
	int val=0,val1=0,tax=0; 
	int invdocno=0;
	String logdesc="",invacno="0",acno="0",servocno="0";          
	java.sql.Date sqldate=null;
	java.sql.Date sqlpodate=null;
	Double taxper=0.00,taxamount=0.00,total=0.00,nettotal=0.00;  
	try{
		conn=objconn.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt=conn.createStatement(); 
		ClsServiceSaleDAO DAO= new ClsServiceSaleDAO();     
		ArrayList<String> gridarray=new ArrayList<String>();
		if(!date.equalsIgnoreCase("0")){
			sqldate=ClsCommon.changeStringtoSqlDate(date);     
		}
		if(!podate.equalsIgnoreCase("0")){   
			sqlpodate=ClsCommon.changeStringtoSqlDate(podate);        
		}   
		String strcountdata="select coalesce(ac.tax,0) tax,ac.acno,(select acno from my_account where codeno='INVOICE ACCOUNT') invacno from my_acbook ac where ac.cldocno="+cldocno+"";        
		//System.out.println("strcountdata--->>>"+strcountdata);                                  
		ResultSet rs=stmt.executeQuery(strcountdata);                        
		while(rs.next()){           
				invacno=rs.getString("invacno"); 
				acno=rs.getString("acno");  
				tax=rs.getInt("tax");                 
		}
		total=Double.parseDouble(amount);         
		nettotal=ClsCommon.round(total,session);            
		gridarray.add(1+"::"+1+" :: "+remarks+" :: "+nettotal+" :: "+nettotal+" :: "+""+" :: "+nettotal+" :: "+0.0+" :: "+0.0+" :: "+nettotal+" :: "+""+" :: "+""+" :: "+""+" :: "+""+" :: "+invacno+" :: "+""+" :: ");
		//System.out.println("====gridarray===="+gridarray); 
		val=DAO.insert(sqldate,sqldate,"",vocno,"AR",acno,"","1","1","","",remarks,session,"A",nettotal,gridarray,"SRS",request,sqlpodate,pono,"",0,taxper);
		if(val>0){
			servocno=request.getAttribute("vocno").toString(); 
			//Sending Email to Client
			int errorstatus=0;
			invdocno=val;
			if(rowno>0){         
				 String sql="update rl_rentald set invtrno='"+val+"' where rowno="+rowno+"";           
				 //System.out.println("====sql===="+sql);   
				 val=stmt.executeUpdate(sql);  
			 }else{
				 String sql="update rl_rental set invtrno='"+val+"' where doc_no="+rntldocno+"";           
				 //System.out.println("====sql===="+sql);   
				 val=stmt.executeUpdate(sql); 
			 }    
			 logdesc="Invoice generated - Rental Docno#"+rntldocno+" Rental Rowno#"+rowno;                                             
			 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,description) values("+vocno+",'"+brhid+"','PIV',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                       
			 //System.out.println(val+"====sqllog===="+sqllog);
			 stmt.executeUpdate(sqllog);               
			              
			 if(errorstatus==0){
				 val1=1; 
				 conn.commit();
			 	String strSql2 = "select (select coalesce(m.desc1,'') from my_srvsalem m where doc_no="+val+") maindesc,(select mail1 from my_acbook where acno="+acno+" and dtype='CRM' and status=3) mail1,(select date_format(m.date,'%M %Y') from my_srvsalem m where doc_no="+val+") invmonthname";
				//System.out.println("sql=="+strSql2);
				String email="",invmonthname="",maindesc="";
				ResultSet rs2 = stmt.executeQuery(strSql2);
				while(rs2.next ()) {
					email=rs2.getString("mail1");
					invmonthname=rs2.getString("invmonthname");
				}
				if(email.equalsIgnoreCase("") || email==null){
					errorstatus=1;
					System.out.println("Mail Empty");
				}
				//String receiptdate=request.getParameter("receiptdate");   
				//String docno=request.getParameter("docno");
				/* String shortenurl=urlshortener.generateRandomShortUrl(conn);
				 */
				String msg="";
				String sub="Property Invoice Notification",invno="";
				msg="<html><body><table><tr><td>Dear Customer,</td></tr><tr><td> Please be informed, your Property Invoice for "+invmonthname+" has been raised as below:</td></tr> ";
				String emailTraffic ="select comp.imgpath,date_format(m.date,'%M %Y') invdatename,format(round(coalesce(netamount,0),2),2) amount,coalesce(comp.company,'') compname,coalesce(comp.tel,'') tel,coalesce(comp.fax,'') fax,a.refname,a.mail1,concat('<tr><td>',coalesce(m.desc1,''),'</td><td>',format(round(coalesce(netamount,0),2),2),'</td></tr>"+
				" <tr><td>You could use <a href=\"http://abzig-deira.fortiddns.com:8889/REALESTATETRIAL/webinvoice/index.jsp?docid="+invdocno+"\">Pay Online</a> for Online Payments</td></tr>"+
				" <tr><td>If you have any questions or concerns, please dont hesitate to contact our office.</td></tr>"+
				" <tr><td>Yours Sincerely<br>Team ',coalesce(comp.company,''),'<br></td></tr>') msg from my_srvsalem m left join my_acbook a on m.acno=a.acno left join my_brch br on a.brhid=br.doc_no left join my_comp comp on br.cmpid=comp.doc_no where m.doc_no="+invdocno;
				System.out.println(emailTraffic);
				ResultSet rstrf=conn.createStatement().executeQuery(emailTraffic);
				String compname="",comptel="",compfax="",mailamount="",invdatename="",filepath="";
				while(rstrf.next()) {
					filepath=rstrf.getString("imgpath");
					msg=msg.replace("Customer",rstrf.getString("refname") );
					email=rstrf.getString("mail1");
					mailamount=rstrf.getString("amount");
					invdatename=rstrf.getString("invdatename");
					//invno=rstrf.getString("inv_no");
					compname=rstrf.getString("compname");
					comptel=rstrf.getString("tel");
					compfax=rstrf.getString("fax");
					msg+=rstrf.getString("msg");
					System.out.println(" inside "+email+"==="+invno+"===="+msg);
				}
				/* msg="<!DOCTYPE html>"+
						"<html lang='en'>"+
						"<head>"+
						"<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"+
						"<meta http-equiv='X-UA-Compatible' content='IE=edge'>"+
						"<meta name='viewport' content='width=device-width, initial-scale=1.0'>"+
						"<meta name='description' content='Gateway ERP BPM enabled ERP Software Solution'>"+
						"<meta name='keywords' content='gatewayerp,gateway,erp'>"+
						"<meta name='author' content='gatewayerp'>"+
						"<link rel='icon' href='../assets/images/favicon.png' type='image/x-icon'>"+
						"<link rel='shortcut icon' href='../assets/images/favicon.png' type='image/x-icon'>"+
						"<title>GatewayERP</title>"+
						"<link href='https://fonts.googleapis.com/css?family=Rubik:400,400i,500,500i,700,700i&amp;display=swap' rel='stylesheet'>"+
						"<link href='https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i,700,700i,900&amp;display=swap' rel='stylesheet'>"+
						//"<link rel='stylesheet' type='text/css' href='assets/css/font-awesome.css'>"+
						"<link rel='stylesheet' type='text/css' href='cid:fontawesome'>"+
						//"<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css'>"+
						"<link rel='stylesheet' href='cid:bootstrap-v3-css'>"+
						//"<link rel='stylesheet' href='assets/css/style.css'>"+
						"<link rel='stylesheet' href='cid:webinvoice-css'>"+
						//"<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>"+
						"</head>"+
						"<style type='text/css'>"+
						"  *{box-sizing: border-box;margin: 0;padding: 0;}"+
						"</style>"+
						"<body>"+
						"  <div class='container'>"+
						"    <div class='mail-header'>"+
						"      <div class='row'>"+
						"        <div class='col-xs-12'>"+
						"          <img src='cid:complogo' class='img-responsive'  style='width: 30%;height: auto;' />"+
						"          <div class='text-center'>"+
						"            <h3>Payment Link from "+compname+"</h3>"+
						"          </div>"+
						"        </div>"+
						"      </div>"+
						"    </div>"+
						"    <div class='mail-body'>"+
						"      <p>Dear <strong>Customer</strong><br>Below is the summary of monthly invoice of "+invdatename+" against Property</p>"+
						"      <ul class='list-group'>"+
						"        <li class='list-group-item'>Sub Total<span class='badge badge-secondary'>AED "+mailamount+"</span></li>"+
						"        <li class='list-group-item'>Tax<span class='badge badge-secondary'>AED 0.0</span></li>"+
						"        <li class='divider'></li>"+
						"        <li class='list-group-item'><strong>Grand Total</strong><span class='badge badge-secondary'>AED "+mailamount+"</span></li>"+
						"      </ul>"+
						"      <div class='row'>"+
						"        <div class='col-xs-12 text-right'>"+
						"          <a href='http://gate-way.dyndns.org:8877/INSDEMO/webinvoice/index.jsp?docid='"+val+"' class='btn btn-default btn-primary'>PAY ONLINE</a>"+
						"        </div>"+
						"      </div>"+
						"    </div>"+
						"    <div class='mail-footer'>"+
						"      <div class='text-center'>"+
						"        <p><strong>POWERED BY</strong></p>"+
						"        <img src='cid:complogo' class='img-responsive' style='width:20%;margin-left: auto;margin-right: auto;'>"+
						"      </div>"+
						"    </div>"+
						"  </div>"+
						"</body>"+
						"</html>"; */
				msg+="<tr><td><h2>"+compname+"</h2><br><address>Tel: "+comptel+"<br>Fax: "+compfax+"</address><br><p>Please dont print e-mails unless you really need</p></td></tr>";
				msg+="<tr><td> Thank you</tr></td></table></body></html>";
				System.out.println(email+"==="+invno+"===="+msg);
				if(!email.trim().equalsIgnoreCase("")) {
					File saveFile=null;
					//new File(filepath+"/WebContent/icons/complogo.jpg");;
					/*
					* HttpServletRequest request=ServletActionContext.getRequest(); HttpSession
					* session=request.getSession();
					*/ 
					try {
						String mailstatus=sendmail.SendTomailINT( saveFile,"CRM",email,cldocno+"",session.getAttribute("BRANCHID").toString().trim(),session.getAttribute("USERID").toString().trim(),invdocno+"",sub,msg);
						if(!mailstatus.trim().equalsIgnoreCase("success")){
							errorstatus=1;
						}
					} catch (AddressException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					} catch (MessagingException e) {
						e.printStackTrace();
					} catch (SQLException e) {
						e.printStackTrace();
					}catch(Exception e){
						e.printStackTrace();
						errorstatus=1;
					}
					
					
				}
			 }
			 else{
				 val1=0;
			 }
			  
		 }
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}   
	response.getWriter().print(val1+"###"+servocno);                              
%>