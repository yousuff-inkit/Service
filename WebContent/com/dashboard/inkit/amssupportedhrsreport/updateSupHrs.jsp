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
 
<%
	String docno=request.getParameter("docno")==null || request.getParameter("docno").equalsIgnoreCase("")?"0":request.getParameter("docno").toString();
	String brhid=request.getParameter("brhid")==null || request.getParameter("brhid").equalsIgnoreCase("")?"0":request.getParameter("brhid").toString();
	String todate=request.getParameter("todate")==null || request.getParameter("todate").equalsIgnoreCase("")?"0":request.getParameter("todate").toString();
	String supportedhrs=request.getParameter("supporthrs")==null || request.getParameter("supporthrs").equalsIgnoreCase("")?"0":request.getParameter("supporthrs").toString();
	
	Connection conn1=null;
	Connection conn=null;
	try{
		ClsConnection ClsConnection =new ClsConnection();    
		ClsCommon ClsCommon=new ClsCommon();
		java.sql.Date sqltodate=null;   
		int val=0;
		
	 	conn = ClsConnection.getMyConnection();
	 	conn.setAutoCommit(false);
	 	
		Statement stmt = conn.createStatement ();
					
		if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
			 sqltodate=ClsCommon.changeStringtoSqlDate(todate);    
		}
		 
		int period=0;
		int invoiced=0;
		
		String sqlPrd="select doc_no from cm_amscontrm where doc_no="+docno+" and '"+sqltodate+"' between fromdt and todt;";
		ResultSet rsPrd = stmt.executeQuery(sqlPrd);
		while (rsPrd.next()) {
			period=rsPrd.getInt("doc_no");
		}
		
		String sqlInv="select rowno from cm_amssupdet where rdocno="+docno+" and coalesce(invtrno,0)!=0 and date='"+sqltodate+"';";
		ResultSet rsInv = stmt.executeQuery(sqlInv);
		while (rsInv.next()) {
			invoiced=rsInv.getInt("doc_no");
		}
		
		if(period>0 && invoiced==0){
			String sqlMaster="select sp.rowno, m.supporthrs, m.carryforwards, m.cfmaxper, m.cfminper," 
					+"coalesce((select cfhrs from cm_amssupdet where rdocno=m.doc_no and  date_format(date,'%Y-%m')= date_format('"+sqltodate+"' - INTERVAL 1 MONTH,'%Y-%m')),0) cfhrs " 
					+"from cm_amscontrm m left join cm_amssupdet sp on sp.rdocno=m.doc_no and sp.date='"+sqltodate+"' " 
					+"where m.status=3 and m.doc_no="+docno;
			ResultSet rsMaster = stmt.executeQuery(sqlMaster);
			
			int rowno=0;
			double supporthrs=0;
			int carryforwards=0;
			double cfmaxper=0;
			double cfminper=0;
			double cfhrs=0;
			
			while (rsMaster.next()) {
				rowno=rsMaster.getInt("rowno");
				supporthrs=rsMaster.getDouble("supporthrs");
				carryforwards=rsMaster.getInt("carryforwards");
				cfmaxper=rsMaster.getDouble("cfmaxper");
				cfminper=rsMaster.getDouble("cfminper");
				cfhrs=rsMaster.getDouble("cfhrs");
			}
			
			if(carryforwards != 1){
				cfhrs=0;
			}
			
			double diff = (supporthrs + cfhrs) - Double.parseDouble(supportedhrs);
			double extrahrs = 0;
			double currentcfhrs = 0;
			
			if(diff>0){
				if(carryforwards == 1){	
					double cfmax = supporthrs * (cfmaxper / 100);
					double cfmin = supporthrs * (cfminper / 100);
					
					if(diff >= cfmin && diff <= cfmax){
						currentcfhrs = diff;
					}else if(diff > cfmax){
						currentcfhrs = cfmax;
					}
				}
				
			}else{
				extrahrs= Math.abs(diff);
			}
			
			String sqlIns="";
			if(rowno>0){
				sqlIns="update cm_amssupdet set supportedhrs ="+supportedhrs+",exthrs="+extrahrs+",cfhrs="+currentcfhrs+" where rdocno="+docno+" and date='"+sqltodate+"';";
			}else{
				sqlIns="insert into cm_amssupdet(rdocno, date, supportedhrs, exthrs, cfhrs) values ("+docno+",'"+sqltodate+"',"+supportedhrs+","+extrahrs+","+currentcfhrs+")";
			}
			
			val = stmt.executeUpdate(sqlIns);
			
			if(val>0){
				String sqlBiblog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY) values("+docno+","+brhid+",'AINP',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E')";
				val = stmt.executeUpdate(sqlBiblog);
			}
		}		
		 	 
		if(val>0){    
			conn.commit();  
			conn.close();    
		}
		  
		response.getWriter().print(period+"#"+invoiced+"#"+val);    
		
	 }catch(Exception e){    
	 	 conn.close();
	 	 e.printStackTrace();
	 }finally{
			conn.close();    
	 }
	%>
