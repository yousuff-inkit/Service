<%@page import="net.sf.json.JSONArray"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>

<%
	JSONObject data=new JSONObject();
	JSONObject enqdetails=new JSONObject();
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	JSONObject objdata=new JSONObject();  
	Connection conn=null;
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid").toString(); 
	try{
			conn=objconn.getMyConnection();
			Statement stmt=conn.createStatement();
			String sqltest="";
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){          
				sqltest+=" and m.brhid='"+brhid+"'";              
			}
			String strenq="select (select count(*) from (select m.tr_no from cm_srvcontrm m left join cm_srvcontrpd d on d.tr_no=m.tr_no where m.status=3 and m.jbaction in (0,4) and m.pstatus=1 and coalesce(m.pinvno,0)=0 and d.dueafser=98 "+sqltest+" group by m.tr_no)a) proforma,(select count(*) from(select m.tr_no from cm_srvcontrm m left join cm_srvcontrpd d on d.tr_no=m.tr_no where m.status=3 and m.jbaction in (0,4) and m.pstatus=1 and coalesce(m.pinvno,0)!=0 and d.dueafser=98 "+sqltest+" group by m.tr_no)a) notrcvd,(select count(*) from cm_srvcontrm m left join cm_srvcontrpd d on d.tr_no=m.tr_no where m.status=3 and d.invtrno>0 and d.confirm=0 and m.jbaction in (0,4) "+sqltest+") tobecnfmed";
			System.out.println(strenq);             
			String proformacount="0",notrcvdcount="0",invprocount="0",tobecnfmedcount="0";      
			ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				proformacount=rsenq.getString("proforma");  
				notrcvdcount=rsenq.getString("notrcvd");
				tobecnfmedcount=rsenq.getString("tobecnfmed");        
			}
			String strSql1 = "select count(*) invpro from(select a.* from(select pd.rowno from cm_srvcontrpd pd inner join cm_srvcontrm m on(m.tr_no=pd.tr_no and pstatus=2) where pd.dueafser=98 and invtrno=0 and m.jbaction in (0,4) and m.status=3 "+sqltest+" union all select pd.rowno from cm_srvcontrpd pd  inner join cm_srvcontrm m  on (m.tr_no=pd.tr_no) where pd.dueafser=99 and invtrno=0 and m.pstatus!=1 and m.jbaction in (0,4) and m.status=3 "+sqltest+" union all select pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m  on (m.tr_no=pd.tr_no) inner join cm_servplan s on pd.tr_no=s.doc_no and s.sr_no=pd.serviceno  where  pd.dueafser not in (98,99) and serviceno>0 and PD.invtrno=0 and workper=100 and s.status=5  and  m.jbaction in (0,4) and m.status=3 "+sqltest+" union all select pd.rowno from  cm_srvcontrpd pd  inner join cm_srvcontrm m on (m.tr_no=pd.tr_no) where  pd.dueafser=0 and invtrno=0 and m.pstatus!=1 and coalesce(serviceno,0)=0 and m.jbaction in (0,4) and m.status=3 "+sqltest+")a group by a.rowno)b";
			//System.out.println(strSql1);              
			ResultSet rs1=stmt.executeQuery(strSql1);           
			while(rs1.next()){
				invprocount=rs1.getString("invpro");
			}  
			objdata.put("proformacount",proformacount);
			objdata.put("notrcvdcount",notrcvdcount);
			objdata.put("invprocount",invprocount);
			objdata.put("tobecnfmedcount",tobecnfmedcount);      
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
	
	//System.out.println(enqdetails);  
	response.getWriter().print(objdata);           
%>