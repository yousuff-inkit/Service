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
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleAction"%>  
 
<%
    ClsServiceSaleDAO srDAO=new ClsServiceSaleDAO();      
    String todate=request.getParameter("todate")==null || request.getParameter("todate").equalsIgnoreCase("")?"0":request.getParameter("todate").toString();
	String pono=request.getParameter("pono")==null || request.getParameter("pono").equalsIgnoreCase("")?"0":request.getParameter("pono").toString();
	String podate=request.getParameter("podate")==null || request.getParameter("podate").equalsIgnoreCase("")?"0":request.getParameter("podate").toString();
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").equalsIgnoreCase("")?"0":request.getParameter("brhid").toString();
	String gridarray=request.getParameter("gridarray")==null || request.getParameter("gridarray").equalsIgnoreCase("")?"0":request.getParameter("gridarray").toString();
	String description=request.getParameter("description")==null || request.getParameter("description").equalsIgnoreCase("")?"0":request.getParameter("description").toString();
 	Connection conn1=null;
 	System.out.println("=IN=");               
	String refrowno="0";  
	Connection conn=null;
	
	try{
		ClsConnection ClsConnection =new ClsConnection();    
		ClsCommon ClsCommon=new ClsCommon();
		java.sql.Date sqlinvdate=null;	
		java.sql.Date sqltodate=null;   
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
		if(!(podate.equalsIgnoreCase("undefined"))&&!(podate.equalsIgnoreCase(""))&&!(podate.equalsIgnoreCase("0"))){
			sqlinvdate=ClsCommon.changeStringtoSqlDate(podate);  
		}
		
		if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
			 sqltodate=ClsCommon.changeStringtoSqlDate(todate);    
		}
		 
		String atype="AR",sql2="",acno="0",interstate="0";        
		ArrayList<String> proday= new ArrayList<String>();      
		System.out.println("=IN=1");
		int configs=0;
		String consql="select method from gl_config where field_nme='tax'";
		ResultSet rsconfg = stmt.executeQuery(consql);
        while (rsconfg.next()) {
        	 configs=rsconfg.getInt("method");
		}  
			
		for(int i=0;i<newarray.size();i++){
				
				String temp[]=newarray.get(i).split("::");
				
				if(!temp[0].trim().equalsIgnoreCase("undefined") && !temp[0].trim().equalsIgnoreCase("NaN") && !temp[0].trim().equalsIgnoreCase("")){
					
				String srno = (temp[0].trim().equalsIgnoreCase("undefined") || temp[0].trim().equalsIgnoreCase("NaN") || temp[0].trim().equalsIgnoreCase("") || temp[0].trim().isEmpty()?"0":temp[0].trim()).toString();    
				String desc1 = (temp[1].trim().equalsIgnoreCase("undefined") || temp[1].trim().equalsIgnoreCase("NaN") || temp[1].trim().equalsIgnoreCase("") || temp[1].trim().isEmpty()?"":temp[1].trim()).toString(); 
				Double amount = temp[2].trim().equalsIgnoreCase("undefined") || temp[2].trim().equalsIgnoreCase("NaN") || temp[2].trim().equalsIgnoreCase("") || temp[2].trim().isEmpty()?0.0:Double.parseDouble(temp[2].trim().toString()); 
				String clacno = (temp[3].trim().equalsIgnoreCase("undefined") || temp[3].trim().equalsIgnoreCase("NaN") || temp[3].trim().equalsIgnoreCase("") || temp[3].trim().isEmpty()?"0":temp[3].trim()).toString();
				String rowno = (temp[4].trim().equalsIgnoreCase("undefined") || temp[4].trim().equalsIgnoreCase("NaN") || temp[4].trim().equalsIgnoreCase("") || temp[4].trim().isEmpty()?"0":temp[4].trim()).toString();
				String inctax = (temp[5].trim().equalsIgnoreCase("undefined") || temp[5].trim().equalsIgnoreCase("NaN") || temp[5].trim().equalsIgnoreCase("") || temp[5].trim().isEmpty()?"0":temp[5].trim()).toString();
				String incomeacno = (temp[6].trim().equalsIgnoreCase("undefined") || temp[6].trim().equalsIgnoreCase("NaN") || temp[6].trim().equalsIgnoreCase("") || temp[6].trim().isEmpty()?"0":temp[6].trim()).toString();
				String cldocno = (temp[7].trim().equalsIgnoreCase("undefined") || temp[7].trim().equalsIgnoreCase("NaN") || temp[7].trim().equalsIgnoreCase("") || temp[7].trim().isEmpty()?"0":temp[7].trim()).toString();
				String client = (temp[8].trim().equalsIgnoreCase("undefined") || temp[8].trim().equalsIgnoreCase("NaN") || temp[8].trim().equalsIgnoreCase("") || temp[8].trim().isEmpty()?"":temp[8].trim()).toString();    
				int cltax = temp[9].trim().equalsIgnoreCase("undefined") || temp[9].trim().equalsIgnoreCase("NaN") || temp[9].trim().equalsIgnoreCase("") || temp[9].trim().isEmpty()?0:Integer.parseInt(temp[9].trim().toString());     
				String contvocno = (temp[10].trim().equalsIgnoreCase("undefined") || temp[10].trim().equalsIgnoreCase("NaN") || temp[10].trim().equalsIgnoreCase("") || temp[10].trim().isEmpty()?"0":temp[10].trim()).toString(); 
				String costcode = (temp[11].trim().equalsIgnoreCase("undefined") || temp[11].trim().equalsIgnoreCase("NaN") || temp[11].trim().equalsIgnoreCase("") || temp[11].trim().isEmpty()?"0":temp[11].trim()).toString();
				String costtype = (temp[12].trim().equalsIgnoreCase("undefined") || temp[12].trim().equalsIgnoreCase("NaN") || temp[12].trim().equalsIgnoreCase("") || temp[12].trim().isEmpty()?"0":temp[12].trim()).toString();
				String exthrs = (temp[13].trim().equalsIgnoreCase("undefined") || temp[13].trim().equalsIgnoreCase("NaN") || temp[13].trim().equalsIgnoreCase("") || temp[13].trim().isEmpty()?"0":temp[13].trim()).toString();
				String billamt = (temp[14].trim().equalsIgnoreCase("undefined") || temp[14].trim().equalsIgnoreCase("NaN") || temp[14].trim().equalsIgnoreCase("") || temp[14].trim().isEmpty()?"0":temp[14].trim()).toString();
				String exthramt = (temp[15].trim().equalsIgnoreCase("undefined") || temp[15].trim().equalsIgnoreCase("NaN") || temp[15].trim().equalsIgnoreCase("") || temp[15].trim().isEmpty()?"0":temp[15].trim()).toString();
				String cfhrs = (temp[16].trim().equalsIgnoreCase("undefined") || temp[16].trim().equalsIgnoreCase("NaN") || temp[16].trim().equalsIgnoreCase("") || temp[16].trim().isEmpty()?"0":temp[16].trim()).toString();
				String billfrequency = (temp[17].trim().equalsIgnoreCase("undefined") || temp[17].trim().equalsIgnoreCase("NaN") || temp[17].trim().equalsIgnoreCase("") || temp[17].trim().isEmpty()?"0":temp[17].trim()).toString();
				
				Double taxper=0.0,taxamt=0.0,nettaxamt=0.0,grossamt=0.0;
				String currency="0",currate="0";   
				String cursql="select ac.curid currency, round(cb.rate,2) currate from my_acbook ac left join my_curbook cb on (ac.curid=cb.curid) where ac.cldocno='"+cldocno+"' and ac.dtype='crm'";
				ResultSet rscur = stmt.executeQuery(cursql);
		        while (rscur.next()) {
		        	currency=rscur.getString("currency");  
		        	currate=rscur.getString("currate");  
				}
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
						
						upsql="select taxper,round(("+amount+" * taxper)/100,2) as taxamt from cm_amscontrm where taxper>0 and doc_no="+costcode;  
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
		        proday.add(srno+"::"+1+" :: "+desc1+" :: "+amount+" :: "+amount+" :: "+0.0+" :: "+amount+" :: "+taxper+" :: "+taxamt+" :: "+nettaxamt+" :: "+amount+" :: "+costtype+" :: "+costcode+" :: "+""+" :: "+incomeacno+" :: "+0+" :: "); 
		        
		        ClsServiceSaleAction masteraction= new ClsServiceSaleAction();
		        masteraction.setDelno("0");
		        
				val=srDAO.insert(sqlinvdate,sqlinvdate, "",contvocno, atype, clacno, client, currency, currate,  "", "", description, session, "A", amount, proday, "SRS", request,sqlinvdate, pono, "", Integer.parseInt(interstate), taxper, masteraction); 

				proday= new ArrayList<String>();  
				if(val>0){  
					vocno=vocno+request.getAttribute("vocno").toString()+", ";  
					String invtrno = request.getAttribute("trans").toString();
					
					String sqldata1="";
					if(billfrequency=="1"){
						sqldata1="update cm_amssupdet set invtrno="+invtrno+",billamt="+billamt+",exthramt="+exthramt+",totalval="+amount+" where rowno="+rowno; 
					}else{
						sqldata1="update cm_amssupdet sp inner join cm_amscontrm m on m.doc_no=sp.rdocno set sp.invtrno="+invtrno+",sp.billamt=m.amount,sp.exthramt=(sp.exthrs*m.extrahrsrate),sp.totalval=(m.amount+(sp.exthrs*m.extrahrsrate)) where coalesce(sp.invtrno,0)=0 and sp.date<='"+sqltodate+"' and sp.rdocno="+costcode;      
					}
					val=stmt.executeUpdate(sqldata1);      
				}
				if(val>0){ 		
					String sqldata2="update cm_amscontrm set invdate='"+sqlinvdate+"' where doc_no="+costcode;   
					val=stmt.executeUpdate(sqldata2);      
			   	} 
				if(val>0){ 
					String sqlBiblog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY) values("+costcode+","+brhid+",'AINP',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E')";
					val = stmt.executeUpdate(sqlBiblog);
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
