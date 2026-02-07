<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.sales.marketing.salesorder.ClsSalesOrderDAO"%>
<%@page import="com.sales.Sales.deliverynote.ClsDeliveryNoteDAO"%>
<%@page import="com.sales.Sales.salesInvoice.ClsSalesInvoiceDAO"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="java.text.SimpleDateFormat" %>  
<%	
ClsConnection ClsConnection=new ClsConnection();
ClsSalesOrderDAO sdao= new ClsSalesOrderDAO();  
ClsDeliveryNoteDAO deldao= new ClsDeliveryNoteDAO();
ClsSalesInvoiceDAO invdao= new ClsSalesInvoiceDAO();
ClsCommon ClsCommon=new ClsCommon();
Connection conn = null;
Statement stmt=null;
String temp="0",type="";
ArrayList<String> activityarray= new ArrayList<String>();
ArrayList<String> tobeinvoicedarray= new ArrayList<String>();

SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
String dt=sdf.format(new java.util.Date());
java.sql.Date sqlDate= ClsCommon.changeStringtoSqlDate(dt);
java.sql.Date sqlpayDate=null;
//String branch=session.getAttribute("BRANCHID").toString().trim();
//String userid=session.getAttribute("USERID").toString().trim();
//String company=session.getAttribute("COMPANYID").toString().trim();

//System.out.println("brnch===="+branch+"===userid==="+userid+"==compny=="+company);

session.setAttribute("COMPANYID",1);
	try{
		String list=request.getParameter("prodArray")==null?"":request.getParameter("prodArray");  
		int  clientid=request.getParameter("clinetid")==null?0:Integer.parseInt(request.getParameter("clinetid"));     
		String vatype=request.getParameter("vatype")==null?"":request.getParameter("vatype");
		String desc=request.getParameter("desc")==null?"":request.getParameter("desc");
		String locid=request.getParameter("locid")==null?"":request.getParameter("locid");
		System.out.println("Location Recieved:"+locid);
		String frmtype=request.getParameter("frmtype")==null?"":request.getParameter("frmtype");
		String clntacno=request.getParameter("clntacno")==null?"":request.getParameter("clntacno");
		String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
		String userid=request.getParameter("userid")==null?"":request.getParameter("userid");
		userid=session.getAttribute("USERID").toString();
		session.setAttribute("BRANCHID",brhid);
		session.setAttribute("USERID",userid);
		String cur=request.getParameter("cur")==null?"":request.getParameter("cur");
		//double totalsum=request.getParameter("totalsum")==null || request.getParameter("totalsum")==""?0.0:Double.parseDouble(request.getParameter("totalsum"));
		//double ntamtsum=request.getParameter("ntamtsum")==null || request.getParameter("ntamtsum")==""?0.0:Double.parseDouble(request.getParameter("ntamtsum"));
		double taxamtsum=request.getParameter("taxamtsum")==null || request.getParameter("taxamtsum")==""?0.0:Double.parseDouble(request.getParameter("taxamtsum"));
		//double netotalsum=request.getParameter("netotalsum")==null || request.getParameter("netotalsum")==""?0.0:Double.parseDouble(request.getParameter("netotalsum"));
		String ref=request.getParameter("reftype")==null?"":request.getParameter("reftype").trim();
		String sordoc=request.getParameter("sordoc")==null?"0":request.getParameter("sordoc");
		String rate=request.getParameter("rate")==null?"":request.getParameter("rate");
		//int rectval=request.getParameter("rectval")==null || request.getParameter("rectval")==""?0:Integer.parseInt(request.getParameter("rectval"));
		//int txtsrtrno=request.getParameter("txtsrtrno")==null || request.getParameter("txtsrtrno")==""?0:Integer.parseInt(request.getParameter("txtsrtrno"));
		int loc=Integer.parseInt(locid);
		//int txtcustomerdocno=request.getParameter("txtcustomerdocno")==null || request.getParameter("txtcustomerdocno")==""?0:Integer.parseInt(request.getParameter("txtcustomerdocno"));
		//int txtcustomeracno=request.getParameter("txtcustomeracno")==null || request.getParameter("txtcustomeracno")==""?0:Integer.parseInt(request.getParameter("txtcustomeracno"));
		String totalsum=request.getParameter("totalsum")==null?"0":request.getParameter("totalsum");
		String ntamtsum=request.getParameter("ntamtsum")==null?"0":request.getParameter("ntamtsum");
		//int txtscheduleno=request.getParameter("txtscheduleno")==null || request.getParameter("txtscheduleno")==""?0:Integer.parseInt(request.getParameter("txtscheduleno"));
		String netotalsum=request.getParameter("netotalsum")==null?"0":request.getParameter("netotalsum");
		//int txtsrdocno=request.getParameter("txtsrdocno")==null || request.getParameter("txtsrdocno")==""?0:Integer.parseInt(request.getParameter("txtsrdocno"));
		System.out.println(clientid+"::"+vatype+"::"+desc+"::"+locid+"::"+frmtype+"::"+clntacno+"::"+
		brhid+"::"+userid+"::"+cur+"::"+taxamtsum+"::"+ref+"::"+sordoc+"::"+rate+"::"+loc+"::"+totalsum+"::"+
		ntamtsum+"::"+netotalsum);
		ArrayList<String> prodarray= new ArrayList<String>();

		ArrayList<String> termsarray= new ArrayList<String>();
		ArrayList<String> servarray= new ArrayList<String>();
		ArrayList<String> shiparray= new ArrayList<String>();
		String aa[]=list.split(",");
		int val=0;
			
		for(int i=0;i<aa.length;i++){
			System.out.println("----------"+aa[i]);
			 String bb[]=aa[i].split("::");
			  
			 String tempnw="";
			 for(int j=0;j<bb.length;j++){ 
				 
				 System.out.println("----------"+bb[j]);
				 tempnw=tempnw+bb[j]+"::";
				 
			}
			 prodarray.add(tempnw);
			 
		}     
			String container="",sql2="",sorno="0";
			/* if(frmtype.equalsIgnoreCase("SOR")){
				 val=sdao.insert(sqlDate, "0", "1", cur, rate, 0, clientid, "", "DIR", "", desc, totalsum, "0", ntamtsum, "0", "0", netotalsum, "A", "SOR", prodarray, termsarray, servarray, session, request, "0", "0", shiparray, 0, "", 0.0, 0.0, 0.0, 0.0, taxamtsum, 1, vatype);
				if(val>0){
					sorno=request.getAttribute("vdocNo").toString();
				}
				 
			} */
			System.out.println("Form Type:"+frmtype);
			if(frmtype.equalsIgnoreCase("DEL")){
				System.out.println("Inside DelNote Ajax");
				//System.out.println(sqlDate+"::"+"0"+"::"+"1"+"::"+cur+"::"+rate+"::"+0+"::"+clientid+"::"+""+"::"+ref+"::"+""+"::"+desc+"::"+totalsum+"::"+"0"+"::"+ntamtsum+"::"+"0"+"::"+"0"+"::"+netotalsum+"::"+"A"+"::"+"DEL"+"::"+prodarray+"::"+termsarray+"::"+servarray+"::"+""+"::"+""+"::"+sordoc+"::"+"0"+"::"+locid+"::"+shiparray+"::"+0+"::"+vatype);
				System.out.println("USERID"+(session.getAttribute("USERID")==null?"":session.getAttribute("USERID").toString()));
				System.out.println("BRANCHID"+(session.getAttribute("BRANCHID")==null?"":session.getAttribute("BRANCHID").toString()));
				System.out.println("COMPANYID"+(session.getAttribute("COMPANYID")==null?"":session.getAttribute("COMPANYID").toString()));
				val=deldao.insert(sqlDate, "0", "1", cur, rate, 0, clientid, "", ref, "", desc, totalsum, "0", ntamtsum, "0", "0", netotalsum, "A", 
					"DEL", prodarray, termsarray, servarray, session, request, sordoc, "0", locid, shiparray, 0,vatype);
					System.out.println("DelNote Return Value:"+val);
				if(val>0){
						sorno=request.getAttribute("vdocNo")==null?"0":request.getAttribute("vdocNo").toString();
						System.out.println("DelNote Doc No:"+sorno);
					//Updating Location
					String strupdateloc="update my_delm set locid="+locid+" where doc_no="+val;
					conn = ClsConnection.getMyConnection();
					stmt = conn.createStatement();  
					int updateloc=stmt.executeUpdate(strupdateloc);
					if(updateloc<0){
						
					}
				}
			}
			if(frmtype.equalsIgnoreCase("INV")){
				/* val=invdao.insert(sqlDate, "0", "1", cur, rate, 0, clientid, "", ref, "", desc, totalsum, "0", ntamtsum, "0", "0", netotalsum, "A", "INV", prodarray, termsarray, servarray, session, request, sordoc, "0", sqlpayDate, loc, "CREDIT", "", shiparray, 0, 0.0, 0.0, 0.0, 0.0, taxamtsum, 1, "", "", vatype, clntacno);
						if(val>0){
							sorno=request.getAttribute("vdocNo").toString();
						} */
			}
				
				response.getWriter().print(val+"::"+sorno);
 		
 	
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   stmt.close();
	   conn.close();
   }
%>
