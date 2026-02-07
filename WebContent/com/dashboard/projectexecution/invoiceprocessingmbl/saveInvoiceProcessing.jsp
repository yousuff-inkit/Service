<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>  
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleDAO"%> 
<%@page import="com.project.execution.ServiceSale.ClsServiceSaleAction"%>  
<%@page import="java.text.SimpleDateFormat" %>   
<%	
	ClsConnection connDAO=new ClsConnection();     
	ClsCommon commonDAO=new ClsCommon();        
	ClsServiceSaleDAO DAO=new ClsServiceSaleDAO(); 
	ClsServiceSaleAction masteraction = new ClsServiceSaleAction();       
	Connection conn = null;
	java.sql.Date sqlStartDate=null;   
	SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");       
	java.util.Date curDate=new java.util.Date();  
    java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));                     
	java.sql.Date sqlStartDate2=null;    
	String pono = request.getParameter("pono")=="" || request.getParameter("pono")==null?"":request.getParameter("pono");  
	String invdate=request.getParameter("invdate")=="" || request.getParameter("invdate")==null?"0":request.getParameter("invdate");
	String invdesc=request.getParameter("invdesc")=="" || request.getParameter("invdesc")==null?"":request.getParameter("invdesc");
	String jobdocno=request.getParameter("jobdocno")=="" || request.getParameter("jobdocno")==null?"0":request.getParameter("jobdocno");  
	String pdrowno=request.getParameter("pdrowno")=="" || request.getParameter("pdrowno")==null?"0":request.getParameter("pdrowno");   
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").trim().equalsIgnoreCase("")?"0":request.getParameter("brhid").trim().toString();
    int inctax=0,temptrno=0,tempvocno=0,val=0,docno=0,vocno=0,tr_no=0,doc_no=0,clientid=0,cpersonid=0,costid=0,contractno=0,lineacno=0,srno=0;         
	String interserv="0",dtype="",refdtype="",otype="",client="",contrtype="",refno="",clientdet="",desc="",branchid="0",clacno="0",legalamt="0.0",seramt="0.0",exptotal="0.0",nettotal="0.0",mode="",pdid="0",ptype="",schid="0",nontax="0",remarks="",costtype="";  
	double contramt=0.0,legalfee=0.0,tobeinvamt=0.0,dueamt=0.0,netamount=0.0,expamt=0.0,legamt=0.0,netotal=0.0,taxamt=0.0,taxtot=0.0,taxper=0.0, dueamount=0.0, total = 0.0;
	try{ 
	 	conn=connDAO.getMyConnection();
		Statement stmt=conn.createStatement();    
		conn.setAutoCommit(false);             
		if(!(invdate.equalsIgnoreCase("undefined")) && !(invdate.equalsIgnoreCase("")) && !(invdate.equalsIgnoreCase("0"))){  
	  	  sqlStartDate = commonDAO.changeStringtoSqlDate(invdate);   
	    }       
		ArrayList<String> gridarray=new ArrayList<String>();   
		
		 String strcountdata="select (select coalesce(per,0) per from gl_taxmaster where  status=3 and type=2 and '"+sqlStartDate+"' between fromdate and todate and per>0) taxper, (select coalesce(acno,0) acno from my_account where codeno=if(a.dtype='AMC','AMC INCOME','SJOB INCOME')) lineacno,a.* from (select si.sitess,if(cm.dtype='AMC',3,4) costType,cm.tr_no tr_no,cm.dtype dtype,cm.dtype rdtype,cm.doc_no doc_no,cm.refno as refno,cm.date date, if(dueafser=99,ifnull(least(cm.legalDate,duedate),duedate),duedate) as duedate,round(cm.netamount,2) as cval, round(coalesce(ser.netamount,0.0),2) tobeinvamt, round(sum(a.amount),2) dueamt,dueafser,serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee, cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo, cm.validFrom sdate,cm.validUpto edate,cm.brhid brch,a.rowno as pdid,1 as ptype,0 site,ac.interserv,coalesce(ac.nontax,0) nontax,coalesce(cm.inctax,0) inctax from (select duedate,amount,dueafser,serviceno,m.tr_no,pd.rowno from   cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where  pd.dueafser=98 and invtrno=0 union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m  on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno  where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5  and s.dtype in('sjob','amc')  union all select duedate,amount,dueafser,serviceno,pd.tr_no,pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1) as a  left join cm_srvcontrm cm on(cm.tr_no=a.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on(si.tr_no=cm.tr_no) left join ( select sum(ss.total) as netamount,sv.costid doc_no,sv.ref_type from cm_srvdetm sv left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and invtrno=0 where sv.wrkper=100 group by sv.costid,sv.ref_type  ) ser  on(ser.doc_no=a.tr_no) left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where cm.status=3 and a.rowno='"+pdrowno+"' and a.tr_no='"+jobdocno+"' and jbaction in(0,4)  group by tr_no union all select si.sitess,3 costType,cm.tr_no tr_no,(pd.dtype) as dtype,concat('Service','-',pd.dtype) as rdtype,cm.doc_no doc_no,cm.refno as refno,  cm.date date, pd.date as duedate,round(cm.netamount,2) as cval,coalesce(round(ser.netamount,2),0) tobeinvamt, round(sum(servamt),2) as dueamt,'0' as dueafser,0 serviceno,round(if(cm.islegal=1 ,legalchrg,0),2) lfee,cm.cldocNo clientid,ac.refName client,ac.acno as clacno, trim(concat(ifnull(ac.per_mob,''),' ',ifnull(ac.com_mob,''))) contactNo,cm.validFrom sdate,cm.validUpto edate,cm.brhid brch, pd.tr_no as pdid,2 as ptype,sdd.site,ac.interserv,coalesce(ac.nontax,0) nontax,coalesce(cm.inctax,0) inctax from cm_servplan pd left join cm_srvcontrm cm on(pd.doc_no=cm.tr_no) left join (select tr_no,group_concat(site) sitess from cm_srvcsited group by tr_no) si on(si.tr_no=cm.tr_no) left join cm_srvcsited sdd on sdd.tr_no=cm.tr_no left join (select sum(ss.total) as netamount,sch.doc_no,sv.ref_type from cm_servplan sch  left join cm_srvdetm sv on sch.tr_no=sv.schrefdocno  left join cm_srvspares ss on sv.tr_no=ss.tr_no and ss.chg=1 and ss.invtrno=0 where sv.wrkper=100 group by sv.costid ,sv.ref_type ) ser  on(ser.doc_no=cm.tr_no)left join my_acbook ac on(ac.cldocno=cm.cldocno and ac.dtype='CRM') where cm.iser=1 and pd.iserv=1 and pd.serinv=1 and pd.invtrno<=0 and pd.workper=100 and cm.status=3 and jbaction in(0,4) group by pd.doc_no) as a  where 1=1  and a.tr_no='"+jobdocno+"'";
		 //System.out.println("strcountdata--->>>"+strcountdata);                        
		 ResultSet rs=stmt.executeQuery(strcountdata);                                
		 while(rs.next()){ 
			srno++;
			costtype = rs.getString("costType");  
		    costid = rs.getInt("tr_no");
			contractno = rs.getInt("doc_no");
			contrtype = rs.getString("dtype");
			contramt = rs.getDouble("cval");
			exptotal = rs.getString("tobeinvamt"); 
			seramt = rs.getString("cval");
			legalamt = rs.getString("lfee");
			client = rs.getString("client"); 
			clacno = rs.getString("clacno");
			clientid = rs.getInt("clientid");
			refno = rs.getString("refno"); 
			branchid = rs.getString("brch"); 
			pdid = rs.getString("pdid"); 
			ptype = rs.getString("ptype"); 
			inctax = rs.getInt("inctax"); 
			nontax = rs.getString("nontax");  
			interserv = rs.getString("interserv");
			dueamount = rs.getDouble("dueamt");   
			lineacno = rs.getInt("lineacno");              
			taxper = rs.getDouble("taxper"); 
			if(inctax>0){
				total = (dueamount*100)/(100+taxper);
				taxtot = dueamount; 
				taxamt = dueamount-total;              
			}else{
				taxamt = (dueamount*taxper)/100; 
				total = dueamount;   
				taxtot = dueamount+taxamt;  
			}
			gridarray.add(srno+" :: "+1+" :: "+invdesc+" :: "+total+" :: "+total+" :: "+0+" :: "+total+" :: "+taxper+" :: "+taxamt+" :: "+taxtot+" :: "+total+" :: "+costtype+" :: "+contractno+" :: "+remarks+" :: "+lineacno+" :: "+0+" :: "); 
		}   
    	
    	 val = DAO.insert(sqlStartDate, sqlStartDate, contrtype, contractno+"", "AR", clacno+"", client, "1" , "1", "", "", invdesc, session, "A", total, gridarray, "SRS", request, sqlStartDate, pono, sqlStartDate+"", 0, taxper, masteraction);
    	 //System.out.println("val========"+val);
    	 if(val>0){
    		 tempvocno = Integer.parseInt(request.getAttribute("vocno").toString());    
    		 temptrno = Integer.parseInt(request.getAttribute("trans").toString());  
    		 
    		 String updat="update cm_srvcontrpd set invtrno="+temptrno+", invamt='"+dueamount+"' where tr_no="+jobdocno+" and invtrno=0 and rowno='"+pdrowno+"'";     
			 stmt.executeUpdate(updat);   
    		 
			 String updat1="update cm_servplan set invtrno="+temptrno+" where tr_no="+jobdocno+" and invtrno=0";                 
			 stmt.executeUpdate(updat1);  
    	 }  
		        
	  
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