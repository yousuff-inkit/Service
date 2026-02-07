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
<%@page import="com.project.execution.projectInvoicereturn.ClsProjectInvoiceReturnDAO"%>
<%@page import="java.text.SimpleDateFormat" %>   
<%	
	ClsConnection connDAO=new ClsConnection();     
	ClsCommon commonDAO=new ClsCommon();        
	ClsProjectInvoiceReturnDAO DAO= new ClsProjectInvoiceReturnDAO();                 
	Connection conn = null;
	java.sql.Date sqlStartDate=null;   
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");       
	java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));                     
	java.sql.Date sqlStartDate2=null;     
	String invlegalfee=request.getParameter("invlegalfee")=="" || request.getParameter("invlegalfee")==null?"0.0":request.getParameter("invlegalfee").toString(); 
	String invamount=request.getParameter("invamount")=="" || request.getParameter("invamount")==null?"0.0":request.getParameter("invamount").toString(); 
	String invnotes=request.getParameter("invnotes")=="" || request.getParameter("invnotes")==null?"":request.getParameter("invnotes");        
	String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"0":request.getParameter("invdate");
	String invdesc=request.getParameter("invdesc")=="" || request.getParameter("invdesc")==null?"":request.getParameter("invdesc");
	String jobdocno=request.getParameter("jobdocno")=="" || request.getParameter("jobdocno")==null?"0":request.getParameter("jobdocno");  
	String pdrowno=request.getParameter("pdrowno")=="" || request.getParameter("pdrowno")==null?"0":request.getParameter("pdrowno");   
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid").trim().toString();
	String retamount=request.getParameter("retamount")=="" || request.getParameter("retamount")==null?"0.0":request.getParameter("retamount").toString(); 
	String retlegalcharge=request.getParameter("retlegalcharge")=="" || request.getParameter("retlegalcharge")==null?"0.0":request.getParameter("retlegalcharge").toString(); 
   
	int tempvocno=0,val=0;     
    int docno=0,vocno=0,tr_no=0,doc_no=0,clientid=0,cpersonid=0,costid=0,contractno=0,reftrno=0;         
	String rrefno="0",interserv="0",dtype="",refdtype="",otype="",client="",contrtype="",refno="",clientdet="",desc="",branchid="0",clacno="0",legalamt="0.0",seramt="0.0",exptotal="0.0",nettotal="0.0",mode="",pdid="0",ptype="",schid="0",inctax="0",nontax="0";
	double invbalamt=0.0,invballfee=0.0,contramt=0.0,legalfee=0.0,tobeinvamt=0.0,dueamt=0.0,netamount=0.0,expamt=0.0,legamt=0.0,netotal=0.0,taxamt=0.0,taxtot=0.0,netretamt=0.0,netretleglfee=0.0;  
	try{ 
	 	conn=connDAO.getMyConnection();
		Statement stmt=conn.createStatement();      
		conn.setAutoCommit(false);             
		if(!(invdate.equalsIgnoreCase("undefined")) && !(invdate.equalsIgnoreCase("")) && !(invdate.equalsIgnoreCase("0"))){  
	  	  sqlStartDate = commonDAO.changeStringtoSqlDate(invdate);   
	    }       
		ArrayList<String> invoiceList=new ArrayList<String>(); 
		ArrayList<String> retList=new ArrayList<String>(); 
		ArrayList<String> taxlist=new ArrayList<String>();  
		ArrayList<String> enqarray= new ArrayList();
		ArrayList<String> exparray = new ArrayList();    
		
		String strcountdata="select * from (select round(if(cm.islegal=1 ,cm.legalchrg,0),2) lfee,round(sm.etotal,2) exptotal,round(sm.netamount,2) netamount,round(sm.atotal) seramt,round(sm.legalchrg,2) as legalchrg,sm.doc_no rrefno,sm.tr_no rreftrno,si.sitess,if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,cm.date date, if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(sum(pd.amount),2) dueamt,dueafser,serviceno,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,pd.rowno as pdid,1 as ptype,0 site,ac.interserv,coalesce(ac.nontax,0) nontax,coalesce(cm.inctax,0) inctax from cm_srvcontrpd pd  left join cm_srvcontrm cm on(cm.tr_no=pd.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on(si.tr_no=cm.tr_no) left join ( select sum(ss.total) as netamount,sv.costid doc_no,sv.ref_type from cm_srvdetm sv left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 where sv.wrkper=100 group by sv.costid,sv.ref_type  ) ser  on(ser.doc_no=pd.tr_no and ser.ref_type='SJOB') left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') left join my_servm sm on sm.tr_no=pd.invtrno where cm.status=3 and pd.rowno='"+pdrowno+"' and pd.invtrno>0 group by tr_no) as a  where 1=1  and a.tr_no='"+jobdocno+"' and dtype='SJOB'";
		System.out.println("strcountdata--->>>"+strcountdata);                          
		ResultSet rs=stmt.executeQuery(strcountdata);                                
		while(rs.next()){ 
		    costid=rs.getInt("tr_no");
			contractno=rs.getInt("doc_no");
			contrtype=rs.getString("dtype");
			contramt=rs.getDouble("cval");
			exptotal=rs.getString("exptotal");   
			seramt=rs.getString("dueamt");  
			legalamt=rs.getString("lfee");
			client=rs.getString("client"); 
			clacno=rs.getString("clacno");
			clientid=rs.getInt("clientid");
			refno=rs.getString("refno"); 
			branchid=rs.getString("brch"); 
			pdid=rs.getString("pdid"); 
			ptype=rs.getString("ptype"); 
			inctax=rs.getString("inctax"); 
			nontax=rs.getString("nontax");  
			interserv=rs.getString("interserv");
			rrefno=rs.getString("rrefno");
			reftrno=rs.getInt("rreftrno");  
		}
			mode="A";  
			dtype="PJIR";   
			
			netamount=Double.parseDouble(invamount)+Double.parseDouble(invlegalfee)+Double.parseDouble(exptotal);     
			netretamt=Double.parseDouble(retamount);
			netretleglfee=Double.parseDouble(retlegalcharge);    
			invbalamt=Double.parseDouble(seramt)-(Double.parseDouble(retamount)+Double.parseDouble(invamount));   
			invballfee=Double.parseDouble(legalamt)-(Double.parseDouble(retlegalcharge)+Double.parseDouble(invlegalfee));     
			
			System.out.println("netretamt="+netretamt+"=netretleglfee="+netretleglfee+"=invamount="+invamount+"=retamount="+retamount+"=invbalamt="+invbalamt+"=invballfee="+invballfee);     
			
			if(inctax.equalsIgnoreCase("0")){
				taxlist=DAO.getTax(session,netamount,sqlStartDate,interserv,clientid);   

			}
			else if((inctax.equalsIgnoreCase("1"))){
				taxlist=DAO.getinclusiveTax(session,netamount,sqlStartDate,interserv,clientid);     
			}
			System.out.println(inctax+"====="+taxlist);
			//taxlist=DAO.getTax(session,netamount,date);

			for(int t=0;t<taxlist.size();t++){

				String[] tmp=((String) taxlist.get(t)).split("::");

				taxamt=Double.parseDouble(tmp[3]);
				taxtot=taxtot+taxamt;

			}
		     System.out.println("taxlist==="+taxlist+"==netamount=="+netamount);    
			 val=DAO.insert(sqlStartDate,rrefno,reftrno,refno,contrtype,contractno,client,clientdet,invdesc,branchid,clacno,clientid,costid,enqarray,exparray,session,mode,dtype,request,invlegalfee,invamount,exptotal,inctax,pdid,invnotes,ptype,taxtot,"0.0","0.0",netretamt+"",netretleglfee+"",taxlist,nontax);        
			 System.out.println("val========"+val);       
			 tempvocno=Integer.parseInt(request.getAttribute("docno").toString());      
		
		if(val>0){     
			 conn.commit();     
		}   
	                               
  		 response.getWriter().write(val+"::"+tempvocno+"::"+invbalamt+"::"+invballfee);                      
	 	 conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>