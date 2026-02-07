<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
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
//String data=request.getParameter("data");
//System.out.println("srvdetmtrno ="+data);
Connection conn=null;
try{
	ClsConnection ClsConnection =new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	conn = ClsConnection.getMyConnection();
	conn.setAutoCommit(false);
	Statement stmt = conn.createStatement ();
	
	double val=0;
	int changed = 0;
	String cogsacno = "";
    String stkacno = "";
    int piv=0;
    int gis=0;
    int inv=0;
    int inr=0;
    int pir=0;
    int gir=0;
    int phk=0;
    
    int totalpiv=0;
    int totalgis=0;
    int totalinv=0;
    int totalinr=0;
    int totalpir=0;
    int totalgir=0;
    int totalphk=0;
	
    // getting the data from reqeust body 
      StringBuilder requestBody = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
            }
        }
    
	// converting String to json array  
	System.out.println("45----"+requestBody.toString());
	
    JSONObject json = JSONObject.fromObject(requestBody.toString());   
	JSONArray jsonArray = json.getJSONArray("data");
    
	if(jsonArray.size()>0){
		String cogacnosql = "SELECT acno FROM my_account WHERE codeno='COST OF GOODS SOLD'";    
	     ResultSet resultSet = stmt.executeQuery(cogacnosql);
	    
	     while(resultSet.next()){
	     	cogsacno = resultSet.getString("acno");
	     }
	     
	     String stkacnosql = "SELECT acno FROM my_account WHERE codeno='STOCK ACCOUNT'";
	     resultSet = stmt.executeQuery(stkacnosql);
	     while(resultSet.next()){
	    	 stkacno = resultSet.getString("acno");
	      }	
	}
	
	
	for (int i = 0; i < jsonArray.size(); i++) {   
		JSONObject jsobj = jsonArray.getJSONObject(i);
        System.out.println(jsobj.getString("transtype"));
        if(jsobj.getString("transtype").equalsIgnoreCase("GIS") || jsobj.getString("transtype").equalsIgnoreCase("INV") ){
        	if(jsobj.getString("transtype").equalsIgnoreCase("GIS")) totalgis++;
    		if(jsobj.getString("transtype").equalsIgnoreCase("INV")) totalinv++;
        	String upstckasql="update  my_jvtran j left join (select dtype,round(sum(qty*cost_price),4) pp,tr_no from my_prddout where dtype in ('inv','gis') group by tr_no) o on j.tr_no=o.tr_no set j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+stkacno+" and status=3 and j.dtype in ('inv','gis') and j.dramount*id!=pp and j.tr_no="+jsobj.getString("tr_no");
        	System.out.println(upstckasql);
        	changed = stmt.executeUpdate(upstckasql);
        	System.out.println("updated=="+changed);        	         	
        	
        	String upstckachecksql = "select j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,round(sum(qty*cost_price),4) pp,tr_no from my_prddout where dtype in ('inv','gis') group by tr_no) o on j.tr_no=o.tr_no where acno="+stkacno+" and status=3 and j.dtype in ('inv','gis') and j.tr_no="+jsobj.getString("tr_no");
        	ResultSet rss = stmt.executeQuery(upstckachecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	
        	String upcogsql="update my_jvtran j left join (select dtype,round(sum(qty*cost_price),4) pp,tr_no from my_prddout where dtype in ('inv','gis') group by tr_no) o on j.tr_no=o.tr_no set j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+cogsacno+" and status=3 and j.dtype in ('inv','gis') and j.dramount*id!=pp and j.tr_no="+jsobj.getString("tr_no");
        	System.out.println(upcogsql);
        	changed = stmt.executeUpdate(upcogsql);
        	System.out.println("updated=="+changed);      
        	
        	
        	
        	String upcogchecksql = "select j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,round(sum(qty*cost_price),4) pp,tr_no from my_prddout where dtype in ('inv','gis') group by tr_no) o on j.tr_no=o.tr_no where acno="+cogsacno+" and status=3 and j.dtype in ('inv','gis') and j.tr_no="+jsobj.getString("tr_no");
         	rss = stmt.executeQuery(upcogchecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        		
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	if(changed>0 ) {
        		if(jsobj.getString("transtype").equalsIgnoreCase("GIS")) gis++;
        		if(jsobj.getString("transtype").equalsIgnoreCase("INV")) inv++;
        	}
        	
        } else if(jsobj.getString("transtype").equalsIgnoreCase("INR") ){
    		if(jsobj.getString("transtype").equalsIgnoreCase("INR")) totalinr++;
        	
        	String upstckasql="update my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('inr') group by tr_no) o on j.tr_no=o.tr_no set j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+stkacno+" and status=3 and j.dtype in ('inr')  and j.dramount*id!=pp and j.tr_no="+jsobj.getString("tr_no");
        	System.out.println(upstckasql);
        	changed = stmt.executeUpdate(upstckasql);
        	System.out.println("updated=="+changed);        	         	
       		
        	String upstckachecksql = "select j.tr_no,j.date,j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('inr') group by tr_no) o on j.tr_no=o.tr_no where acno="+stkacno+" and status=3 and j.dtype in ('inr')  and j.tr_no="+jsobj.getString("tr_no");
        	ResultSet rss = stmt.executeQuery(upstckachecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	String upcogsql="update my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('inr') group by tr_no) o on j.tr_no=o.tr_no set j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+cogsacno+" and status=3 and j.dtype in ('inr')  and j.dramount*id!=pp and j.tr_no="+jsobj.getString("tr_no");
        	System.out.println(upcogsql);
        	changed = stmt.executeUpdate(upcogsql);
        	System.out.println("updated=="+changed);        	         	
        	String upcogchecksql = "select j.tr_no,j.date,j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('inr') group by tr_no) o on j.tr_no=o.tr_no where acno="+cogsacno+" and status=3 and j.dtype in ('inr') and j.tr_no="+jsobj.getString("tr_no");
         	rss = stmt.executeQuery(upcogchecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	if(changed>0) {
        		if(jsobj.getString("transtype").equalsIgnoreCase("INR")) inr++;
        	}
        	
        } else if(jsobj.getString("transtype").equalsIgnoreCase("PIR") ){
        	if(jsobj.getString("transtype").equalsIgnoreCase("PIR")) totalpir++;
        	
        	String upstckasql="update  my_jvtran j left join (select dtype,round(sum(qty*cost_price),4) pp,tr_no from my_prddout where dtype in ('pir') group by tr_no) o on j.tr_no=o.tr_no set j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+stkacno+" and status=3 and j.dtype in ('pir') and j.dramount*id!=pp and j.tr_no="+jsobj.getString("tr_no");
        	System.out.println(upstckasql);
        	changed = stmt.executeUpdate(upstckasql);
        	System.out.println("updated=="+changed);        	 
        	String upstckachecksql = "select j.date,j.tr_no,j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,round(sum(qty*cost_price),4) pp,tr_no from my_prddout where dtype in ('pir') group by tr_no) o on j.tr_no=o.tr_no where acno="+stkacno+" and status=3 and j.dtype in ('pir') and j.tr_no="+jsobj.getString("tr_no");
        	ResultSet rss = stmt.executeQuery(upstckachecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	if(changed>0) {
        		if(jsobj.getString("transtype").equalsIgnoreCase("PIR")) pir++;
        	}
        	
        } else if(jsobj.getString("transtype").equalsIgnoreCase("PIV") ){
        	
        	if(jsobj.getString("transtype").equalsIgnoreCase("PIV")) totalpiv++;
        	String upstckasql="update my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,invno from my_prddin where dtype in ('piv','grn') group by invno) o on j.doc_no=o.invno SET j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+stkacno+" and status=3 and j.dtype in ('PIV') and ROUND(j.dramount*id-pp,2)!=0 and j.tr_no="+jsobj.getString("tr_no");;
        	System.out.println(upstckasql);
        	changed = stmt.executeUpdate(upstckasql);
        	System.out.println("updated=="+changed);
        	String upstckachecksql = "select j.tr_no,j.date,j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,invno from my_prddin where dtype in ('piv','grn') group by invno) o on j.doc_no=o.invno where acno="+stkacno+" and status=3 and j.dtype in ('PIV') and j.tr_no="+jsobj.getString("tr_no");
        	ResultSet rss = stmt.executeQuery(upstckachecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	if(changed>0 ) {
        		if(jsobj.getString("transtype").equalsIgnoreCase("PIV")) piv++;
        	}
        	
        } if(jsobj.getString("transtype").equalsIgnoreCase("GIR") ){
        	
        	if(jsobj.getString("transtype").equalsIgnoreCase("GIR")) totalgir++;
        	
        	String upstckasql="update my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,invno from my_prddin where dtype in ('GIR') group by invno) o on j.doc_no=o.invno SET j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+stkacno+" and status=3 and j.dtype in ('gir') and ROUND(j.dramount*id-pp,2)!=0 and j.tr_no="+jsobj.getString("tr_no");;
        	System.out.println(upstckasql);
        	changed = stmt.executeUpdate(upstckasql);
        	System.out.println("updated==phk=="+stkacno+"=="+changed);
        	
        	String upstckachecksql = "select j.tr_no,j.date,j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,invno from my_prddin where dtype in ('gis') group by invno) o on j.doc_no=o.invno where acno="+stkacno+" and status=3 and j.dtype in ('GIR') and j.tr_no="+jsobj.getString("tr_no");
        	ResultSet rss = stmt.executeQuery(upstckachecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	String upcogsql="update my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('GIR') group by tr_no) o on j.tr_no=o.tr_no set j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+cogsacno+" and status=3 and j.dtype in ('GIR')  and j.dramount*id!=pp and j.tr_no="+jsobj.getString("tr_no");
        	System.out.println(upcogsql);
        	changed = stmt.executeUpdate(upcogsql);
        	System.out.println("updated=="+changed);
        	
        	String upcogchecksql = "select j.tr_no,j.date,j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('GIR') group by tr_no) o on j.tr_no=o.tr_no where acno="+cogsacno+" and status=3 and j.dtype in ('GIR') and j.tr_no="+jsobj.getString("tr_no");
         	rss = stmt.executeQuery(upcogchecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	if(changed>0 ) {
        		if(jsobj.getString("transtype").equalsIgnoreCase("GIR")) gir++;
        	}
        	
        	
        }if(jsobj.getString("transtype").equalsIgnoreCase("PHK") ){
        	
        	if(jsobj.getString("transtype").equalsIgnoreCase("PHK")) totalphk++;
        	
        	String upstckasql="update my_jvtran j left join (select dtype,sum(pp) pp,tr_no from (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('PHK') group by tr_no union all select dtype,round(SUM(qty*cost_price),2) pp,tr_no from my_prddout where dtype in ('PHK') group by tr_no)a group by tr_no) o on j.tr_no=o.tr_no SET j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+stkacno+" and status=3 and j.dtype in ('PHK') and ROUND(j.dramount*id-pp,2)!=0 and j.tr_no="+jsobj.getString("tr_no");;
        	System.out.println(upstckasql);
        	changed = stmt.executeUpdate(upstckasql);
        	System.out.println("updated==phk=="+stkacno+"=="+changed);
        	
        	String upstckachecksql = "select j.tr_no,j.date,j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,sum(pp) pp,tr_no from (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('PHK') group by tr_no union all select dtype,round(SUM(qty*cost_price),2) pp,tr_no from my_prddout where dtype in ('PHK') group by tr_no)a group by tr_no) o on j.tr_no=o.tr_no where acno="+stkacno+" and status=3 and j.dtype in ('PHK') and j.tr_no="+jsobj.getString("tr_no");
        	ResultSet rss = stmt.executeQuery(upstckachecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	String upcogsql="update my_jvtran j left join (select dtype,sum(pp) pp,tr_no from (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('PHK') group by tr_no union all select dtype,round(SUM(qty*cost_price),2)*-1 pp,tr_no from my_prddout where dtype in ('PHK') group by tr_no)a group by tr_no) o on j.tr_no=o.tr_no set j.dramount=pp*j.id, j.ldramount=pp*j.id where acno="+cogsacno+" and status=3 and j.dtype in ('PHK')  and j.dramount*id!=pp and j.tr_no="+jsobj.getString("tr_no");
        	System.out.println(upcogsql);
        	changed = stmt.executeUpdate(upcogsql);
        	System.out.println("updated==phk=="+cogsacno+"=="+changed);
        	
        	String upcogchecksql = "select j.tr_no,j.date,j.dtype,(j.dramount-pp*j.id) result,j.dramount,pp*j.id from my_jvtran j left join (select dtype,sum(pp) pp,tr_no from (select dtype,round(sum(op_qty*cost_price),2) pp,tr_no from my_prddin where dtype in ('PHK') group by tr_no union all select dtype,round(SUM(qty*cost_price),2) pp,tr_no from my_prddout where dtype in ('PHK') group by tr_no)a group by tr_no) o on j.tr_no=o.tr_no where acno="+cogsacno+" and status=3 and j.dtype in ('PHK') and j.tr_no="+jsobj.getString("tr_no");
         	rss = stmt.executeQuery(upcogchecksql);
        	if(rss.next()){
        		val = rss.getDouble("result");
        	}
        	
        	if(changed>0 && val!=0){
    			stmt.close();
    			conn.close();
    			response.getWriter().print(0);
    			return;
    		} 
        	
        	if(changed>0 ) {
        		if(jsobj.getString("transtype").equalsIgnoreCase("PHK")) phk++;
        	}
        	
        }
        
        
        
	}
    System.out.println("phk---"+totalphk+"----"+phk);
    System.out.println("piv---"+totalpiv+"----"+piv);
    System.out.println("gis---"+totalgis+"----"+gis);
    System.out.println("gir---"+totalgir+"----"+gir);
    System.out.println("inv---"+totalinv+"----"+inv);
    System.out.println("inr---"+totalinr+"----"+inr);
	response.getWriter().print("1");
	
	stmt.close();
	conn.commit();
	conn.close();
}
catch(Exception e){
	response.getWriter().print(0);
	conn.close();
	e.printStackTrace();
}
%>
