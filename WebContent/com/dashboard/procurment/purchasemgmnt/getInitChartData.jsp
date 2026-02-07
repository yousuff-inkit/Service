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
	String brhid = request.getParameter("brhid")==null || request.getParameter("brhid")==""?"0":request.getParameter("brhid").trim();  
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim(); 
	System.out.println("from date ="+fromdate);                
	System.out.println("to date ="+todate);                
    java.sql.Date sqlfromdate = null;
    java.sql.Date sqltodate = null;
	try{
		conn=objconn.getMyConnection();
		Statement stmt=conn.createStatement();
		
		if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
	    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
	    }else{}
	    
		if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
	       sqltodate=objcommon.changeStringtoSqlDate(todate);
	    } else{} 
		
		/* String sql1="select e.doc_no from my_salm  e where e.status=3 and  salesuserlink='"+session.getAttribute("USERID")+"'";
		ResultSet resultSet1 = stmt.executeQuery(sql1) ;
		if(resultSet1.next()){
			salesuser=" and sal_id='"+resultSet1.getString("doc_no")+"'";    
		} */ 
		String sqltest="";
		if (!(brhid.equalsIgnoreCase("a")) && !(brhid.equalsIgnoreCase("0"))
                && !(brhid.equalsIgnoreCase(""))) {
            sqltest += " and m.brhid=" + brhid;
        } 
	
		String strenq="select count(*) reqcount from my_reqm m left join my_reqd d on m.tr_no=d.tr_no where d.qty-d.out_qty>0 and m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.dtype='PR' "+sqltest+"";
			String reqcount="0",ordcount="0",grncount="0",pivcount="0",pircount="0",grrcount="0";         
			System.out.println("pr count : "+strenq);
ResultSet rsenq=stmt.executeQuery(strenq);
			while(rsenq.next()){
				reqcount=rsenq.getString("reqcount");
				/* newcrmcount=rsenq.getString("newcrm");
				amccount=rsenq.getString("amc");
				quotcount=rsenq.getString("quot");  */   
			}
			String orsql="select count(*) ordcount from my_ordm m left join my_ordd d on m.tr_no=d.tr_no where d.qty>0 and d.out_qty=0 and m.status=3 and date between '"+sqlfromdate+"' and '"+sqltodate+"' and dtype='PO' "+sqltest+"";
			ResultSet ors=stmt.executeQuery(orsql);
			while(ors.next()){
				ordcount=ors.getString("ordcount");
			}
			String grnsql="select count(*) grncount from my_grnm m left join my_grnd d on m.tr_no=d.tr_no where d.qty>0 and d.out_qty=0 and m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.dtype='GRN' "+sqltest+"";
			System.out.println("grnsql count : "+grnsql);

			ResultSet grnrs=stmt.executeQuery(grnsql);
			while(grnrs.next()){
				grncount=grnrs.getString("grncount");
			}
			String pivsql="select count(*) pivcount from my_srvm m left join my_srvd d on m.tr_no=d.tr_no left join my_prddin din on din.stockid=d.stockid and din.prdid=d.prdid and din.specno=d.specno where din.op_qty>0 and din.out_qty=0 and m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.dtype='PIV' "+sqltest+"";
			System.out.println("PIV count : "+pivsql);
			ResultSet pivrs=stmt.executeQuery(pivsql);
			while(pivrs.next()){
				pivcount=pivrs.getString("pivcount");
			}
			String pirsql="select count(*) pircount from my_srrm m left join my_srrd d on m.tr_no=d.tr_no left join my_srvd pd on pd.stockid=d.stockid where m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.dtype='PIR' and  pd.qty>0 and pd.out_qty!=0 "+sqltest+"";
			System.out.println("pirsql count : "+pirsql);

			ResultSet pirrs=stmt.executeQuery(pirsql);
			while(pirrs.next()){
				pircount=pirrs.getString("pircount");
			}
			String grrsql="select count(*) grrcount from my_grrm m left join my_grrd d on m.tr_no=d.tr_no left join   my_prddin  dd on   dd.stockid=d.stockid and dd.specno=d.specno and dd.prdid=d.prdid and m.brhid=dd.brhid where d.qty>0 and d.out_qty=0 and m.status=3 and m.date between '"+sqlfromdate+"' and '"+sqltodate+"' and m.dtype='GRR' "+sqltest+"";
			System.out.println("grrsql="+grrsql);                

			ResultSet grrrs=stmt.executeQuery(grrsql);
			while(grrrs.next()){
				grrcount=grrrs.getString("grrcount");
			}
			objdata.put("enqcount",reqcount);
			objdata.put("ordcount",ordcount);
			objdata.put("grncount",grncount);
			objdata.put("pivcount",pivcount);
			objdata.put("pircount",pircount);
			objdata.put("grrcount",grrcount);
			/* objdata.put("newcrmcount",newcrmcount); 
			objdata.put("amccount",amccount);
			objdata.put("quotcount",quotcount); */  
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