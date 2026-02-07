<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;
	String trno=request.getParameter("trno")==null || request.getParameter("trno").equalsIgnoreCase("")?"0":request.getParameter("trno");
	int qotrevno=request.getParameter("revision")==null || request.getParameter("revision").equalsIgnoreCase("")?0:Integer.parseInt(request.getParameter("revision"));   
	int val=0,val1=0,lstestrevno=0,estrevno=0,esttrno=0;    
	Double nettotaltax=0.00,taxper=0.00,taxamt=0.00,amount=0.00,total=0.00,discount=0.00,additionalamt=0.00;
	try{
		conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();  
		
		String select1 = "select d.estrevno,em.revision_no,em.tr_no,d.total,coalesce(q.taxper,0) taxper,coalesce(q.discount,0) discount,coalesce(q.additionalamt,0) additionalamt from cm_srvqotm q left join (select sum(total) total,tr_no,revision_no,estrevno from cm_srvqotd group by tr_no,revision_no)d on (d.tr_no=q.tr_no and d.revision_no="+qotrevno+") left join cm_prjestm em on (em.ref_type=q.ref_type and em.reftrno=q.refdocno) where q.tr_no='"+trno+"'";  
		//System.out.println("select1==="+select1);  
		ResultSet rs1 = stmt.executeQuery(select1);   
		while(rs1.next()){
			lstestrevno = rs1.getInt("revision_no");   
			estrevno = rs1.getInt("estrevno");
			esttrno	= rs1.getInt("tr_no");
			amount = rs1.getDouble("total");
			discount = rs1.getDouble("discount");
			taxper = rs1.getDouble("taxper");
			additionalamt = rs1.getDouble("additionalamt");
		}
		total = (amount+additionalamt)-discount;
		taxamt = (total*taxper)/100;
		nettotaltax = total+taxamt;     
		String upSql = "update cm_srvqotm set revision_no='"+qotrevno+"',netAmount="+nettotaltax+", tax="+taxamt+", amount="+amount+", total="+total+" where tr_no='"+trno+"'";
		//System.out.println("upSql==="+upSql);
		val = stmt.executeUpdate(upSql);     
		 
		if(val>0){
			if(lstestrevno!=estrevno){  
				String insertsql1="insert into cm_estmprddr(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,marginper,scopeid,scopeamount,stdprice,lbrchg,scopestdcost, revision_no) select tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,marginper,scopeid,scopeamount,stdprice,lbrchg,scopestdcost, revision_no from cm_estmprdd where tr_no='"+esttrno+"'";
				//System.out.println("insertsql1==="+insertsql1);
				val = stmt.executeUpdate (insertsql1);      
				if(val>0){
					String delsql="delete from cm_estmprdd where tr_no='"+esttrno+"'";   
					val = stmt.executeUpdate (delsql); 
					
					String insertsql2="insert into cm_estmprdd(tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,marginper,scopeid,scopeamount,stdprice,lbrchg,scopestdcost, revision_no) select tr_no, SR_NO,Description, psrno, prdId,UNITID, qty, costPrice,  total, profitPer,activityid, NetTotal,site,sertypeid,sitesrno,marginper,scopeid,scopeamount,stdprice,lbrchg,scopestdcost, revision_no from cm_estmprddr where tr_no='"+esttrno+"' and revision_no='"+estrevno+"'";
					//System.out.println("insertsql2==="+insertsql2);
					val = stmt.executeUpdate (insertsql2); 
					
					String delsql2="delete from cm_estmprddr where tr_no='"+esttrno+"' and revision_no='"+estrevno+"'";      
					val = stmt.executeUpdate (delsql2);   
				}
				if(val>0){
					String upSql2="update cm_prjestm set revision_no='"+estrevno+"' where tr_no='"+esttrno+"'";    
					//System.out.println("upSql2==="+upSql2);   
					val = stmt.executeUpdate (upSql2); 
				}
			}
		}
		if(val>0){
			conn.commit();
		}
		//System.out.println("val==="+val);     
		response.getWriter().print(val);       
		
		stmt.close();
		conn.close();
	}catch(Exception e){
		response.getWriter().print(0);  
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  