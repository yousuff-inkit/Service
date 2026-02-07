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
<%@page import="com.project.execution.projectInvoice.ClsProjectInvoiceDAO"%>
<%@page import="java.text.SimpleDateFormat" %>   
<%	
	ClsConnection connDAO=new ClsConnection();     
	ClsCommon commonDAO=new ClsCommon();        
	ClsProjectInvoiceDAO DAO= new ClsProjectInvoiceDAO();              
	Connection conn = null;
	java.sql.Date sqlStartDate=null;   
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");       
	java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));                     
	java.sql.Date sqlStartDate2=null;  
	String invnotes=request.getParameter("invnotes")=="" || request.getParameter("invnotes")==null?"":request.getParameter("invnotes");     
	String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"0":request.getParameter("invdate");
	String invdesc=request.getParameter("invdesc")=="" || request.getParameter("invdesc")==null?"":request.getParameter("invdesc");
	String jobdocno=request.getParameter("jobdocno")=="" || request.getParameter("jobdocno")==null?"0":request.getParameter("jobdocno");  
	String pdrowno=request.getParameter("pdrowno")=="" || request.getParameter("pdrowno")==null?"0":request.getParameter("pdrowno");   
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid").trim().toString();
    int tempvocno=0,val=0; 
    int docno=0,vocno=0,tr_no=0,doc_no=0,clientid=0,cpersonid=0,costid=0,contractno=0;         
	String interserv="0",dtype="",refdtype="",otype="",client="",contrtype="",refno="",clientdet="",desc="",branchid="0",clacno="0",legalamt="0.0",seramt="0.0",exptotal="0.0",nettotal="0.0",mode="",pdid="0",ptype="",schid="0",inctax="0",nontax="0";
	double contramt=0.0,legalfee=0.0,tobeinvamt=0.0,dueamt=0.0,netamount=0.0,expamt=0.0,legamt=0.0,netotal=0.0,taxamt=0.0,taxtot=0.0;  
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
		
		//String strcountdata="select coalesce(ac.interserv,0) interserv,coalesce(ac.nontax,0) nontax,coalesce(cm.inctax,0) inctax,1 as ptype,pd.rowno pdid,cm.refno,pd.dueafser,round(coalesce(ser.netamount,0.0),2) tobeinvamt,cm.date,cm.tr_no,cm.doc_no,cm.dtype,cm.ref_type refdtype,cm.validfrom sdate,cm.validupto edate,round(pd.amount,2) cval,pd.duedate as duedate,round(cm.legalchrg,2) lfee,ac.doc_no as clientid,cm.cpersonid,cm.brhid,ac.acno as clacno,ac.refname client from cm_srvcontrm cm left join cm_srvcontrpd pd on(pd.tr_no=cm.tr_no and pd.dueafser=98) left join my_acbook ac on (cm.cldocno=ac.cldocno and ac.dtype='CRM') left join (select sum(ss.total) as netamount,sv.costid doc_no,sv.ref_type from cm_srvdetm sv left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid,sv.ref_type) ser on(ser.doc_no=cm.tr_no and ser.ref_type='1') where cm.tr_no='"+jobdocno+"' and pd.rowno='"+pdrowno+"'";
		String strcountdata="select * from (select si.sitess,if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,cm.date date, if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(sum(a.amount),2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,0 site,ac.interserv,coalesce(ac.nontax,0) nontax,coalesce(cm.inctax,0) inctax from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m  on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno  where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5  and s.dtype in('sjob','amc')  union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1) as a  left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on(si.tr_no=cm.tr_no) left join ( select sum(ss.total) as netamount,sv.costid doc_no,sv.ref_type from cm_srvdetm sv left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid,sv.ref_type  ) ser  on(ser.doc_no=a.tr_no and ser.ref_type='SJOB') left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where cm.status=3 and a.rowno='"+pdrowno+"' and a.tr_no='"+jobdocno+"' and jbaction in(0,4)  group by tr_no union all select si.sitess,3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, pd.date as duedate,round(cm.netamount,2) as cval,coalesce(round(ser.netamount,2),0) tobeinvamt, round(sum(servamt),2) as dueamt,'0' as dueafser,0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, pd.tr_no as pdid,2 as ptype,sdd.site,ac.interserv,coalesce(ac.nontax,0) nontax,coalesce(cm.inctax,0) inctax from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on(si.tr_no=cm.tr_no) left join cm_srvcsited sdd on sdd.tr_no=cm.tr_no left join (select sum(ss.total) as netamount,sch.doc_no,sv.ref_type from cm_servplan sch  left join cm_srvdetm sv on sch.tr_no=sv.schrefdocno  left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and ss.invtrno=0 where sv.wrkper=100 group by sv.costid ,sv.ref_type ) ser  on(ser.doc_no=cm.tr_no and ser.ref_type='SJOB')left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) group by pd.doc_no) as a  where 1=1  and a.tr_no='"+jobdocno+"' and dtype='SJOB'";
		System.out.println("strcountdata--->>>"+strcountdata);                      
		ResultSet rs=stmt.executeQuery(strcountdata);                                
		while(rs.next()){ 
		    costid=rs.getInt("tr_no");
			contractno=rs.getInt("doc_no");
			contrtype=rs.getString("dtype");
			contramt=rs.getDouble("cval");
			exptotal=rs.getString("tobeinvamt"); 
			seramt=rs.getString("cval");
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
			
			//refdtype=rs.getString("refdtype");
			//sdate=rs.getString("sdate");
			//edate=rs.getString("edate");
			//duedate=rs.getString("duedate");
			//cpersonid=rs.getString("cpersonid");
			//date=rs.getString("date"); 
			//dueafser=rs.getString("dueafser");          
		}
		if(ptype.equalsIgnoreCase("1")){ 
			mode="A";
			dtype="PJIV";  
			
			netamount=Double.parseDouble(seramt)+Double.parseDouble(legalamt)+Double.parseDouble(exptotal);

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
			 val=DAO.insert(sqlStartDate,refno,contrtype,contractno,client,clientdet,invdesc,branchid,clacno,clientid,
					costid,enqarray,exparray,session,mode,dtype,request,legalamt,seramt,exptotal,inctax,pdid,invnotes,ptype,taxtot,taxlist,nontax);  
			 System.out.println("val========"+val);    
			 tempvocno=Integer.parseInt(request.getAttribute("docno").toString());   
		}else if(ptype.equalsIgnoreCase("2")){
			mode="A";
			dtype="PJIV";

			dueamt=dueamt+Double.parseDouble(seramt);
			expamt=expamt+Double.parseDouble(exptotal);
			legamt=legamt+Double.parseDouble(legalamt);

			schid=schid+","+pdid;

			netamount=Double.parseDouble(exptotal)+Double.parseDouble(seramt)+Double.parseDouble(legalamt);

			netotal=netotal+netamount;

			nettotal=netamount+"";
			
			if(nontax.equalsIgnoreCase("1")){

				if(inctax.equalsIgnoreCase("0")){
					taxlist=DAO.getTax(session,netotal,sqlStartDate,interserv,clientid);

				}
				else if((inctax.equalsIgnoreCase("1"))){
					taxlist=DAO.getinclusiveTax(session,netotal,sqlStartDate,interserv,clientid);
				}
				System.out.println(inctax+"====="+taxlist);

				for(int t=0;t<taxlist.size();t++){
					String[] tmp=((String) taxlist.get(t)).split("::");
                    taxamt=Double.parseDouble(tmp[3]);
					taxtot=taxtot+taxamt;
					netotal=netotal;
				}
				}
				nettotal=netotal+"";
				seramt=dueamt+"";
				exptotal=expamt+"";
				legalamt=legamt+"";


				if (schid.trim().endsWith(",")) {
					pdid = schid.trim().substring(0,schid.length() - 1);
				}
                
				val=DAO.insert(sqlStartDate,refno,contrtype,contractno,client,clientdet,invdesc,branchid,clacno,clientid,
						costid,enqarray,exparray,session,mode,dtype,request,legalamt,seramt,exptotal,inctax,schid,invnotes,ptype,taxtot,taxlist,nontax);  
				System.out.println("val========"+val);    
				tempvocno=Integer.parseInt(request.getAttribute("docno").toString());   
		 }else{}  
		
		/* if(tempvocno>0){    
			 String sql="update cm_srvcontrpd set invprodocno='"+tempdocno+"' where rowno='"+pdrowno+"'";        
			 //System.out.println("sql==="+sql);   
			 val=stmt.executeUpdate(sql);            
		} */   
		if(val>0){     
			 conn.commit();     
		}   
	                               
  		 response.getWriter().write(val+"::"+tempvocno);               
	 	 conn.close();
	} catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   } finally{
	   conn.close();
   }

%>