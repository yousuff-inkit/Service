<%@page import="com.common.ClsCommon"%>
<%@page import="java.util.ArrayList"%>  
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>

<%
	Connection conn = null;  
    String tipdetsrno=request.getParameter("tipdetsrno")==null || request.getParameter("tipdetsrno")==""?"0":request.getParameter("tipdetsrno");   
    String skipsizeid=request.getParameter("skipesizeid")==null || request.getParameter("skipesizeid")==""?"0":request.getParameter("skipesizeid");
    String wasteid=request.getParameter("wasteid")==null || request.getParameter("wasteid")==""?"0":request.getParameter("wasteid"); 
    int contrno=request.getParameter("contrno")==null || request.getParameter("contrno")==""?0:Integer.parseInt(request.getParameter("contrno"));   
    String dodate=request.getParameter("dodate")==null || request.getParameter("dodate")==""?"0":request.getParameter("dodate");
    String dno=request.getParameter("dno")==null || request.getParameter("dno")==""?"0":request.getParameter("dno");
    String wastetype=request.getParameter("wastetype")==null || request.getParameter("wastetype")==""?"":request.getParameter("wastetype");
    int qty=request.getParameter("qty")==null || request.getParameter("qty")==""?0:Integer.parseInt(request.getParameter("qty"));
    String skipesize=request.getParameter("skipesize")==null || request.getParameter("skipesize")==""?"":request.getParameter("skipesize");
    String weight=request.getParameter("weight")==null || request.getParameter("weight")==""?"0":request.getParameter("weight");
    String price=request.getParameter("price")==null || request.getParameter("price")==""?"0":request.getParameter("price");      
    int val=0;      
	try{
		ClsConnection connDAO = new ClsConnection();         
		conn = connDAO.getMyConnection();
		conn.setAutoCommit(false);  
		ClsCommon cmn=new ClsCommon();
		Statement stmt = conn.createStatement(); 
		Statement stmt1 = conn.createStatement(); 
		java.sql.Date sqldodate = null;   
	    if(!(dodate.equalsIgnoreCase("undefined"))&&!(dodate.equalsIgnoreCase(""))&&!(dodate.equalsIgnoreCase("0"))) {
	    	sqldodate=cmn.changeStringtoSqlDate(dodate);   
	    } else{}
	    int oldqty=0, monthold=0, yearold=0, monthnew=0, yearnew=0, contractno=0, newcontdetno=0;  
	 	String totsrno="0", contdetno="", cbrhid="", contno="";  
	 	Double rate=0.0,total=0.0;   
	 	String sql1="select (select round(coalesce(disposalfee,0),2) rate from sk_tippingtariff where wastetypeid='"+wasteid+"' and skipsizeid='"+skipsizeid+"') rate,month('"+sqldodate+"') monthnew, year('"+sqldodate+"') yearnew, tt.month monthold, tt.year yearold, cm.brhid, cm.tr_no contractno, d.rowno contdetno, td.qty, td.totsrno from sk_tippingdet td left join sk_triptotal tt on tt.srno=td.totsrno left join sk_srvcontrm cm on cm.tr_no=td.contno left join sk_srvcontrdet d on d.rowno=td.contdet where td.srno='"+tipdetsrno+"' group by td.srno";
	 	//System.out.println("sql1--->>>"+sql1);                     
		ResultSet rs1= stmt.executeQuery(sql1);  
		while(rs1.next()){
			 oldqty= rs1.getInt("qty");  
			 monthnew= rs1.getInt("monthnew");
			 yearnew= rs1.getInt("yearnew");
			 monthold= rs1.getInt("monthold");
			 yearold= rs1.getInt("yearold");  
			 contractno= rs1.getInt("contractno");   
			 contdetno= rs1.getString("contdetno");
			 cbrhid= rs1.getString("brhid");   
			 total= rs1.getDouble("rate"); 
			 totsrno= rs1.getString("totsrno");    
		}
		//System.out.println(oldqty+"=="+qty+"=="+monthold+"=="+monthnew+"=="+yearold+"=="+yearnew+"=="+contractno+"=="+contrno);      
		if(monthold==monthnew && yearold==yearnew && contractno==contrno){             
			String sql2="update sk_tippingdet set qty='"+qty+"', wasteid='"+wasteid+"', skipsizeid='"+skipsizeid+"', wastetype='"+wastetype+"', dno='"+dno+"', ddate='"+sqldodate+"', rate="+total+", weight="+weight+", price="+price+" where srno='"+tipdetsrno+"'";
			//System.out.println("sql2--->>>"+sql2);            
			val= stmt.executeUpdate(sql2); 
			
			if(val>0 && oldqty!=qty){  
				String sql7="update sk_triptotal tt left join (select sum(qty) qty,totsrno from sk_tippingdet group by totsrno) td on tt.srno=td.totsrno set tt.executedtrip=td.qty where tt.srno='"+totsrno+"'";      
				//System.out.println("sql7--->>>"+sql7);              
				val= stmt.executeUpdate(sql7);   
			}
		}else{
			String sql2="update sk_triptotal set executedtrip=executedtrip-"+oldqty+" where srno='"+totsrno+"'";  
			//System.out.println("sql2--->>>"+sql2);            
			val= stmt.executeUpdate(sql2); 
			 
			int newtotsrno=0;  
			String sql="select d.rowno contdetno from sk_srvcontrm cm left join sk_srvcontrdet d on cm.tr_no=d.rdocno where cm.tr_no='"+contrno+"'";
			ResultSet rs= stmt.executeQuery(sql);  
			while(rs.next()){  
				newcontdetno= rs.getInt("contdetno");          
			}
			String sql3="select srno from sk_triptotal where month='"+monthnew+"' and year='"+yearnew+"' and contractno='"+contrno+"'";
		 	//System.out.println("sql3--->>>"+sql3);                     
			ResultSet rs3= stmt1.executeQuery(sql3);  
			if(rs3.next()){
				newtotsrno=rs3.getInt("srno");
				String sql5="update sk_tippingdet set totsrno='"+newtotsrno+"', qty='"+qty+"', wasteid='"+wasteid+"', skipsizeid='"+skipsizeid+"', wastetype='"+wastetype+"', dno='"+dno+"', ddate='"+sqldodate+"', rate="+total+", contno='"+contrno+"', contdet='"+newcontdetno+"', weight="+weight+", price="+price+" where srno='"+tipdetsrno+"'";
				//System.out.println("sql5--->>>"+sql5);              
				val= stmt.executeUpdate(sql5);  
			}else{  
				String sql4="select coalesce(max(srno)+1,1) srno from sk_triptotal";   
			 	//System.out.println("sql4--->>>"+sql4);    
				ResultSet rs4= stmt.executeQuery(sql4);  
				while(rs4.next()){
					newtotsrno=rs4.getInt("srno");  
				}
				
				String sql6="insert into sk_triptotal(srno, month, year, contractno, contdetno, tottrips, executedtrip, chargedtrip, tiptotal) values('"+newtotsrno+"', '"+monthnew+"', '"+yearnew+"', '"+contrno+"', '"+newcontdetno+"', '"+qty+"', '"+qty+"', '"+qty+"', "+total+")";       
				//System.out.println("sql6--->>>"+sql6);      
				val= stmt.executeUpdate(sql6);     
				
				if(val>0){ 
					String sql5="update sk_tippingdet set totsrno='"+newtotsrno+"', qty='"+qty+"', wasteid='"+wasteid+"', skipsizeid='"+skipsizeid+"', wastetype='"+wastetype+"', dno='"+dno+"', ddate='"+sqldodate+"', rate="+total+", contno='"+contrno+"', contdet='"+newcontdetno+"', weight="+weight+", price="+price+" where srno='"+tipdetsrno+"'";
					//System.out.println("sql5--->>>"+sql5);              
					val= stmt.executeUpdate(sql5);
				}
			}
			if(val>0){
				String sql7="update sk_triptotal tt left join (select sum(qty) qty,totsrno from sk_tippingdet group by totsrno) td on tt.srno=td.totsrno set tt.executedtrip=td.qty where tt.srno='"+newtotsrno+"'";  
				//System.out.println("sql7--->>>"+sql7);               
				val= stmt.executeUpdate(sql7);   
			}  
		}
		if(val>0){  
			conn.commit();  
		}    
		response.getWriter().print(val);   
	 	conn.close(); 
	} catch(Exception e){
	 	e.printStackTrace();	
	 	conn.close();
   } finally{
	   conn.close();
   }
%>
  
