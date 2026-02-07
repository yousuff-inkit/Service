<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="com.common.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>
<%@page import="com.ibm.icu.text.SimpleDateFormat" %> 

<%	
	Connection conn = null;
	try{
		ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();
		ClsConnection connDAO = new ClsConnection();
		ClsCommon commonDAO=new ClsCommon();
	 	conn = connDAO.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		int AlreadyExists=0,mcptran=0,nipurchtran=0,mcpamount=0,nipurchtranoth=0;
		String sql8="",sql6="",sql5="",sql4="",sql ="",sql1="",invno="",invdate="",description="",prodtype="",sql2="",cldocno="",refname="",clacno="",taxamt="",sql3="",outacno="",sql7="";
		int val=0,billtype=0,tax=0,costtype=0,costcode=0,value=0,rowno=0;   
		double amount=0.0,vndtotal=0.0,total=0.0;
		ResultSet rs =null;
		ResultSet rd =null;
		ResultSet rg =null;
		ResultSet rf =null;
		ResultSet rq =null;
		java.sql.Date fdate=null;
		SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");  
		java.util.Date curDate=new java.util.Date();
		java.sql.Date cdate=commonDAO.changeStringtoSqlDate(formatter.format(curDate));
		java.sql.Date docdate=null;
		String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"":request.getParameter("docno").toString();
		String brhid=request.getParameter("brhid")==null || request.getParameter("brhid")==""?"":request.getParameter("brhid").toString();
		session.setAttribute("BRANCHID",brhid); 
		ArrayList<String> gridarray=new ArrayList<String>();
		ArrayList<String> vndarray=new ArrayList<String>();         
		sql2="select vndid from cr_mcpcredit where rdocno="+docno+" and vndid!=0 group by vndid";
		//System.out.println("sql2vendor fetch========"+sql2);
		 rd= stmt1.executeQuery(sql2);
		 while(rd.next()) {
			 vndarray.add(rd.getString("vndid"));     
		 }   
		 //System.out.println("vndarray========"+vndarray);
		 for(int j=0;j<vndarray.size();j++){
			 vndtotal=0;
			 String vnd=vndarray.get(j);
			 gridarray= new ArrayList();
			 sql1="select coalesce(d.rowno,0) rowno,d.qty,d.unitprice,coalesce(ac.cldocno,0) cldocno,coalesce(ac.refname,0) refname,coalesce(ac.acno,0) acno,d.costtype,d.acno glacno,d.costcode,d.taxper tax,d.taxamount taxamt,mm.productname description,d.nettotal total,d.amount,d.invno,d.invdate from cr_mcpcredit d left join my_acbook ac on d.vndid=ac.cldocno and ac.dtype='VND' left join my_main mm on mm.psrno=d.sr_no where d.rdocno="+docno+" and d.vndid="+vnd;
			 //System.out.println("sql1vendordetail========"+sql1);
			 rs= stmt.executeQuery(sql1);
			 while(rs.next()) {  
				rowno=rs.getInt("rowno");    
				invno=rs.getString("invno");
				invdate=rs.getString("invdate");
				fdate=rs.getDate("invdate");
				amount=rs.getDouble("amount");  
				total=rs.getDouble("total");
				description=rs.getString("description");   
				tax=rs.getInt("tax");
				costtype=rs.getInt("costtype");
				costcode=rs.getInt("costcode");
				cldocno=rs.getString("cldocno");
				refname=rs.getString("refname");
				clacno=rs.getString("acno");
				taxamt=rs.getString("taxamt");
				outacno=rs.getString("glacno");
				gridarray.add(1+"::"+rs.getString("qty")+" :: "+description+" :: "+rs.getString("unitprice")+" :: "+amount+" :: "+0+" :: "+amount+" :: "+taxamt+" :: "+costtype+" :: "+costcode+" :: "+description+" :: "+rs.getString("glacno")+" :: "+""+" :: "+tax+" :: "+taxamt+" :: "+rs.getString("total")+" :: ");
				vndtotal=vndtotal+total; 	   													
			} 
		    if(tax>0){
				prodtype="1";
				billtype=1;
				//System.out.println("billtype====="+billtype);   
			}
			if(!(docno.equalsIgnoreCase(""))){
				//value=viewDAO.insert(fdate, fdate, "DIR", 0, "AP", clacno, refname, "1", "1", "", "", "Multiple Cash Purchase", session, "A", vndtotal, gridarray, "CPU", request, fdate, invno,invdate, 1, 1, billtype, prodtype);
				
				value=viewDAO.insert(fdate, fdate, "DIR", 0, "AP", clacno, refname, "1", "1", "", "", "Multiple Cash Purchase", session, "A", vndtotal, gridarray, "CPU", request, fdate, invno,invdate, 1,  0.0, vndtotal, 1);
			    
				//System.out.println("value========="+value);	   
			    if (value>0){
					 sql1 = "update cm_srvcontrm set cpu=1,docstatus='Posted' where tr_no="+docno+"";          
				     val= stmt.executeUpdate(sql1);                 
				     
				     sql4 = "update cr_mcpcredit set cpudocno="+value+" where rowno="+rowno+"";      
				     val= stmt.executeUpdate(sql4);   
				     
				     String logdesc="Ni Purchase created#"+value+" contract tr_no is passing here";                                 
	   	        	 String sqllog="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, userNo, activity, srno, ENTRY,DESCRIPTION) values("+docno+",'"+brhid+"','COPN',now(),'"+session.getAttribute("USERID")+"',0,0,0,'E','"+logdesc+"')";                             
					 //System.out.println(val+"====sqllog===="+sqllog);   
					 stmt.executeUpdate(sqllog); 
					 
				}
			}	 
		 }
		 System.out.println("value========="+value);   	 
		response.getWriter().print(value);
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  