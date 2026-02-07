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
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO"%>  
 
<%
    ClsServiceSaleDAO srDAO=new ClsServiceSaleDAO(); 
    String ctotinv =request.getParameter("ctotinv")==null?"0":request.getParameter("ctotinv").toString();
    String ccdocno=request.getParameter("ccdocno")==null || request.getParameter("ccdocno").equalsIgnoreCase("")?"0":request.getParameter("ccdocno").toString();
	String podate=request.getParameter("podate")==null || request.getParameter("podate").equalsIgnoreCase("")?"0":request.getParameter("podate").toString();
	String total=request.getParameter("total")==null || request.getParameter("total").equalsIgnoreCase("")?"0":request.getParameter("total").toString();
	String tobeinvoiced =request.getParameter("tobeinvoiced")==null?"0":request.getParameter("tobeinvoiced").toString();
	String retnamt =request.getParameter("retnamt")==null?"0":request.getParameter("retnamt").toString();
	String description=request.getParameter("description")==null || request.getParameter("description").equalsIgnoreCase("")?"0":request.getParameter("description").toString();
 	Connection conn1=null;   
 	System.out.println("IN");           
	String refrowno="0";  
	Connection conn=null;
	try{
		 ClsConnection ClsConnection =new ClsConnection();    
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlinvdate=null;
		 int val=0;
		 String docno="",vocno="",sqlcl="",sqljoin="",sqlcl1="",sqldata="",contracttype="",contrno="",dtype="",cldocno="",interstate="",pono="",clacno="",brhid="",client="",desc1="",conttype="",inctax="",upsql="";   
		 Double taxper=0.0,taxamt=0.0,nettaxamt=0.0,grossamt=0.0,amount=0.0;  
	 	 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
		 Statement stmt = conn.createStatement ();
		 Statement stmt2 = conn.createStatement ();
		 java.sql.Date podates=null;
		 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))){
			 sqlinvdate=ClsCommon.changeStringtoSqlDate(podate);  
		 }else{}
		 String atype="AR",costtype="",sql2="",acno="0",currency="1",currate="1";        
		 ArrayList<String> proday= new ArrayList<String>();      
		 //System.out.println("=IN=3");
		 int configs=0,cltax=0;
		 String consql="select method from gl_config where field_nme='tax'";
		 ResultSet rsconfg = stmt.executeQuery(consql);
         while (rsconfg.next()) {
        	 configs=rsconfg.getInt("method");
		 }  
		
         String strsql1="select cm.inctax,c.brhid,ac.interserv,ac.acno,c.doc_no,cm.doc_no contno,c.date,cm.dtype,c.cldocno,ac.refname client,cm.tr_no ctrno from cm_compcert c left join cm_srvcontrm cm on cm.tr_no=c.rdocno left join my_acbook ac on(c.cldocno=ac.doc_no and ac.dtype='CRM') where c.doc_no='"+ccdocno+"'";
         //System.out.println("strsql1==="+strsql1);    
         ResultSet rs1 = stmt.executeQuery(strsql1);
         while (rs1.next()) {
        	 clacno=rs1.getString("acno");  
        	 docno=rs1.getString("contno"); 
        	 dtype=rs1.getString("dtype"); 
        	 contracttype=rs1.getString("dtype");   
        	 cldocno=rs1.getString("cldocno"); 
        	 client=rs1.getString("client"); 
        	 contrno=rs1.getString("ctrno"); 
        	 interstate=rs1.getString("interserv");  
        	 brhid=rs1.getString("brhid");    
        	 inctax=rs1.getString("inctax");     
		 }    
         session.setAttribute("BRANCHID", brhid);    
         amount=Double.parseDouble(tobeinvoiced);     
         
         String clsql="select ac.nontax,ac.curid currency, round(cb.rate,2) currate from my_acbook ac left join my_curbook cb on (ac.curid=cb.curid) where ac.cldocno='"+cldocno+"' and ac.dtype='crm'";
		 ResultSet rscltax = stmt.executeQuery(clsql);  
         while (rscltax.next()) {
				cltax=rscltax.getInt("nontax");
				currency=rscltax.getString("currency");
				currate=rscltax.getString("currate");
		 }    
         
         if(dtype.equalsIgnoreCase("AMC")) {  
        	 costtype="3";      
 		 } else if(dtype.equalsIgnoreCase("SJOB")) {
 			costtype="4";      
 		 }else{}
          
         if(contracttype.equalsIgnoreCase("AMC")){
				sql2="select  acno from my_account where codeno='AMC INCOME' ";
		 }
		 if(contracttype.equalsIgnoreCase("SJOB")){
				sql2="select  acno from my_account where codeno='SJOB INCOME' ";
		 }
		 if(contracttype.equalsIgnoreCase("SINV")){
				sql2="select  acno from my_account where codeno='SINCOME' ";
		 }
		 ResultSet tass1 = stmt.executeQuery (sql2);
		 if (tass1.next()) {
				acno=tass1.getString("acno");  
		 }   
		 if(configs>0 && cltax==1){        
					if(interstate.equalsIgnoreCase("1")) //inter-state_IGST  
					{
						upsql=" select t.tax_code,t.acno,t.value,cstper per,round(("+amount+"*t.cstper)/100,2) as taxamt,t.doc_no docno "
								+" from  gl_taxsubmaster t where   fromdate<='"+sqlinvdate+"' and todate>='"+sqlinvdate+"' and status=3 and type=2 and cstper>0" ;
					}
					else{
						upsql=" select t.tax_code,t.acno,t.value,per,round(("+amount+"*t.per)/100,2) as taxamt,t.doc_no docno "  
							+" from  gl_taxsubmaster t where   fromdate<='"+sqlinvdate+"' and todate>='"+sqlinvdate+"' and status=3 and type=2 and per>0" ;  
					}   
					//System.out.println("===tax====="+upsql);    
					ResultSet resultSet = stmt.executeQuery(upsql);
					while (resultSet.next()) {
					  taxper=resultSet.getDouble("per");
					  taxamt=resultSet.getDouble("taxamt");  
					}
			} 
	        if(cltax==1){  
	        	 if(inctax.equalsIgnoreCase("1")){
	        		   grossamt=amount-taxamt;    
			       }else{
			    	   grossamt=amount;                 
			       }
	        }
	        amount=grossamt;     
	        nettaxamt=taxamt+amount;            
	        proday.add(1+"::"+1+" :: "+description+" :: "+amount+" :: "+amount+" :: "+0.0+" :: "+amount+" :: "+taxper+" :: "+taxamt+" :: "+nettaxamt+" :: "+amount+" :: "+costtype+" :: "+contrno+" :: "+""+" :: "+acno+" :: "+0+" :: ");   
	        
			val=srDAO.insert(sqlinvdate,sqlinvdate, "",docno, atype, clacno, client, currency, currate,  "", "", description, session, "A", amount, proday, "SRS", request,sqlinvdate, pono, "", Integer.parseInt(interstate), taxper); 
			//System.out.println("val==="+val);              
			proday= new ArrayList<String>();      
			if(val>0){  
				     String sqldata1="";
				     vocno=request.getAttribute("vocno").toString();
				     String invtrno=request.getAttribute("trans").toString(); 
				     String str1Sql=("update cm_compcert set invtrno="+invtrno+",pytval="+total+", totinv="+ctotinv+", inv="+tobeinvoiced+", invdt='"+sqlinvdate+"',invdesc='"+description+"', rententionamt="+retnamt+" where doc_no="+ccdocno+" ");
				     //System.out.println("str1Sql==="+str1Sql);              
					 val=stmt.executeUpdate(str1Sql);            
		   }   		
		 	 
		  if(val>0){    
				     conn.commit();  
				     conn.close();    
		  }
		  
		  response.getWriter().write(val+"###"+val+"###"+vocno);            
	 }catch(Exception e){    
	 	 conn.close();
	 	 e.printStackTrace();
	 }finally{
			conn.close();    
	 }
	%>
