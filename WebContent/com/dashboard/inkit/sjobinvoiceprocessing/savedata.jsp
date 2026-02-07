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
<%@page import="com.project.execution.ServiceSale.*"%>  
 
<%
    ClsServiceSaleDAO srDAO=new ClsServiceSaleDAO();  
    String contracttype=request.getParameter("contracttype")==null || request.getParameter("contracttype").equalsIgnoreCase("")?"0":request.getParameter("contracttype").toString();
    String docno=request.getParameter("docno")==null || request.getParameter("docno").equalsIgnoreCase("")?"0":request.getParameter("docno").toString();
    String trno=request.getParameter("trno")==null || request.getParameter("trno").equalsIgnoreCase("")?"0":request.getParameter("trno").toString();
    String dtype=request.getParameter("dtype")==null || request.getParameter("dtype").equalsIgnoreCase("")?"0":request.getParameter("dtype").toString();
    String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno").equalsIgnoreCase("")?"0":request.getParameter("cldocno").toString();
    String interstate=request.getParameter("interstate")==null || request.getParameter("interstate").equalsIgnoreCase("")?"0":request.getParameter("interstate").toString();
	String pono=request.getParameter("pono")==null || request.getParameter("pono").equalsIgnoreCase("")?"0":request.getParameter("pono").toString();
	String podate=request.getParameter("podate")==null || request.getParameter("podate").equalsIgnoreCase("")?"0":request.getParameter("podate").toString();
	String clacno=request.getParameter("clacno")==null || request.getParameter("clacno").equalsIgnoreCase("")?"0":request.getParameter("clacno").toString();
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").equalsIgnoreCase("")?"0":request.getParameter("brhid").toString();
	String total=request.getParameter("total")==null || request.getParameter("total").equalsIgnoreCase("")?"0":request.getParameter("total").toString();
	String client=request.getParameter("client")==null || request.getParameter("client").equalsIgnoreCase("")?"0":request.getParameter("client").toString();  
	String gridarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
	String description=request.getParameter("description")==null || request.getParameter("description").equalsIgnoreCase("")?"0":request.getParameter("description").toString();
 	Connection conn1=null;
 	//System.out.println("=IN=2");           
	String refrowno="0";  
	Connection conn=null;
	try{
		 ClsConnection ClsConnection =new ClsConnection();    
		 ClsCommon ClsCommon=new ClsCommon();
		 java.sql.Date sqlinvdate=null;
		 int val=0;
		 String vocno="",sqlcl="",sqljoin="",sqlcl1="",sqldata="";
	 	 conn = ClsConnection.getMyConnection();
	 	 conn.setAutoCommit(false);
	 	 session.setAttribute("BRANCHID", brhid);  
		 Statement stmt = conn.createStatement ();
		 Statement stmt2 = conn.createStatement ();
		 ArrayList<String> newarray=new ArrayList();   
			String temparray[]=gridarray.split(",");
			for(int i=0;i<temparray.length;i++){
				newarray.add(temparray[i]);
			} 
		 java.sql.Date podates=null;
		 if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))){
			 sqlinvdate=ClsCommon.changeStringtoSqlDate(podate);  
		 }else{}
		 String atype="AR",costtype="",sql2="",acno="0",currency="0",currate="0";        
		 ArrayList<String> proday= new ArrayList<String>();      
		 //System.out.println("=IN=3");
		 int configs=0,cltax=0;
		 String consql="select method from gl_config where field_nme='tax'";
		 ResultSet rsconfg = stmt.executeQuery(consql);
         while (rsconfg.next()) {
        	 configs=rsconfg.getInt("method");
		 }  
			
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
			 
		 for(int i=0;i<newarray.size();i++){
				
				String temp[]=newarray.get(i).split("::");
				
				if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
					 
				String srno = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"":temp[0].trim()).toString();    
				String desc1 = (temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?"":temp[2].trim()).toString(); 
				Double amount = temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?0.0:Double.parseDouble(temp[3].trim().toString()); 
				String conttype = (temp[15].trim().equalsIgnoreCase("undefined") || temp[15].trim().equalsIgnoreCase("NaN") || temp[15].trim().equalsIgnoreCase("") || temp[15].trim().isEmpty()?"":temp[15].trim()).toString();
				String rowno = (temp[16].trim().equalsIgnoreCase("undefined") || temp[16].trim().equalsIgnoreCase("NaN") || temp[16].trim().equalsIgnoreCase("") || temp[16].trim().isEmpty()?"0":temp[16].trim()).toString();
				String inctax = (temp[17].trim().equalsIgnoreCase("undefined") || temp[17].trim().equalsIgnoreCase("NaN") || temp[17].trim().equalsIgnoreCase("") || temp[17].trim().isEmpty()?"0":temp[17].trim()).toString();
				Double taxper=0.0,taxamt=0.0,nettaxamt=0.0,grossamt=0.0;    
		        if(configs>0 && cltax==1){        
						String upsql="";
						/* if(interstate.equalsIgnoreCase("1")) //inter-state_IGST  
						{
							upsql=" select t.tax_code,t.acno,t.value,cstper per,round(("+amount+"*t.cstper)/100,2) as taxamt,t.doc_no docno "
									+" from  gl_taxsubmaster t where   fromdate<='"+sqlinvdate+"' and todate>='"+sqlinvdate+"' and status=3 and type=2 and cstper>0" ;
						}
						else{
							upsql=" select t.tax_code,t.acno,t.value,per,round(("+amount+"*t.per)/100,2) as taxamt,t.doc_no docno "  
								+" from  gl_taxsubmaster t where   fromdate<='"+sqlinvdate+"' and todate>='"+sqlinvdate+"' and status=3 and type=2 and per>0" ;  
						} */
						
						upsql="select taxper,round(("+amount+" * taxper)/100,2) as taxamt from cm_srvcontrm where taxper>0 and tr_no="+trno;  
						ResultSet resultSet = stmt.executeQuery(upsql);
						while (resultSet.next()) {
						  taxper=resultSet.getDouble("taxper");
						  taxamt=resultSet.getDouble("taxamt");  
						}
						
		        	if(inctax.equalsIgnoreCase("1")){
		        		grossamt=amount-taxamt;    
		       			amount=grossamt;     
		        	}
				} 
		        nettaxamt=taxamt+amount;       
		        proday.add(srno+"::"+1+" :: "+desc1+" :: "+amount+" :: "+amount+" :: "+0.0+" :: "+amount+" :: "+taxper+" :: "+taxamt+" :: "+nettaxamt+" :: "+amount+" :: "+costtype+" :: "+trno+" :: "+""+" :: "+acno+" :: "+0+" :: "); 
		        ClsServiceSaleAction masteraction=new ClsServiceSaleAction();
		        masteraction.setDelno("0");
		        
		        System.out.println("proday---"+proday);
		        
				val=srDAO.insert(sqlinvdate,sqlinvdate, "",docno, atype, clacno, client, currency, currate,  "", "", description, session, "A", amount, proday, "SRS", request,sqlinvdate, pono, "", Integer.parseInt(interstate), taxper,masteraction); 
				//System.out.println("val==="+val);              
				proday= new ArrayList<String>();      
				if(val>0){  
					     String sqldata1="";
					     vocno=vocno+request.getAttribute("vocno").toString()+", ";
					     String invtrno=request.getAttribute("trans").toString(); 
					     //System.out.println("conttype==="+conttype);     
					     if(conttype.equalsIgnoreCase("AMC") || conttype.equalsIgnoreCase("SJOB")){
					    	   sqldata1="update cm_srvcontrpd set invtrno="+invtrno+" where rowno="+rowno+"";
						 }
						 if(conttype.equalsIgnoreCase("SINV")){    
							   sqldata1="update cm_servplan set invtrno="+invtrno+" where tr_no="+rowno+"";      
						 }
					     //System.out.println("sqldata1==="+sqldata1);        
						 val=stmt.executeUpdate(sqldata1);          
			   } 
			}
			 
		 }
		 	 
		  if(val>0){    
				     conn.commit();  
				     conn.close();    
		  }
		  
		response.getWriter().print(val+"###"+vocno.substring(0, vocno.length()-1));              
	 }catch(Exception e){    
	 	 conn.close();
	 	 e.printStackTrace();
	 }finally{
			conn.close();    
	 }
	%>
