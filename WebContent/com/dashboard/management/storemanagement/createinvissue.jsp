 <%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*" %>
<%@page import="com.connection.*" %>
<%@page import="com.common.*" %>
<%@page import="com.sales.InventoryTransfer.InventoryTransferIssue.*" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%

ClsCommon objcommon=new ClsCommon();
ClsConnection objconn=new ClsConnection();

Connection conn=null;

ClsTransferIssueDAO DAO= new ClsTransferIssueDAO();
String invissuearray=request.getParameter("invissuearray")==null?"":request.getParameter("invissuearray");
String remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks");
String txttotal=request.getParameter("txttotal")==null?"":request.getParameter("txttotal");
int frmlocid = request.getParameter("frmlocid")==null || request.getParameter("frmlocid").equals("")?0:Integer.parseInt(request.getParameter("frmlocid").trim());
int frmbrhid = request.getParameter("frmbrhid")==null || request.getParameter("frmbrhid").equals("")?0:Integer.parseInt(request.getParameter("frmbrhid").trim());
int branch1 = request.getParameter("branch1")==null || request.getParameter("branch1").equals("")?0:Integer.parseInt(request.getParameter("branch1").trim());
int location1 = request.getParameter("location1")==null || request.getParameter("location1").equals("")?0:Integer.parseInt(request.getParameter("location1").trim());
String txtnettotal=request.getParameter("txtnettotal")==null?"":request.getParameter("txtnettotal");
String finalamt=request.getParameter("finalamt")==null?"":request.getParameter("finalamt");
String vocno=request.getParameter("vocno")==null?"":request.getParameter("vocno");
String insuff=request.getParameter("insuff")==null?"":request.getParameter("insuff");
String voc_no=request.getParameter("voc_no")==null?"":request.getParameter("voc_no");


//System.out.println("branch1======="+branch1);
//System.out.println("location1======="+location1);

ArrayList<String> mainarray=new ArrayList<String>();
String temparray[]=invissuearray.split(",");




try{
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	Statement stmt1=conn.createStatement();
	
	
 long millis=System.currentTimeMillis();  
 java.sql.Date date=new java.sql.Date(millis);  
 
 String reftype="";
 
	if(frmbrhid==branch1){
		reftype="ILT";	
	}else{
		reftype="IBT";
	}
	
	for(int i=0;i<temparray.length;i++){
		mainarray.add(temparray[i]);
	}
		
	int v1=0, v2=0,val=0;   
	for(int i=0;i< mainarray.size();i++){

		String[] prod=((String) mainarray.get(i)).split("::");
		
		if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){
			String prdid=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
			String specno=""+(prod[10].equalsIgnoreCase("undefined") || prod[10].equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"";
		  	String  rqty=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
			double masterqty=Double.parseDouble(rqty);
			
			v1++;
			 
			 String stkSql="select m.part_no,i.cost_price,i.stockid,i.psrno,i.specno,sum(i.op_qty) stkqty,sum(i.op_qty-i.out_qty-i.rsv_qty-i.del_qty) balstkqty,(i.rsv_qty+i.out_qty+i.del_qty) out_qty,i.out_qty as qty,i.date from my_prddin i  "
						+ "left join my_main m on m.psrno=i.psrno and m.specid=i.specno where i.psrno='"+prdid+"' and i.specno='"+specno+"' and i.prdid='"+prdid+"' and i.brhid="+branch1+" and i.locid="+location1+" "
						+ " having sum(i.op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 ";
					
						
				//		System.out.println("my_prdin check invissue=================="+stkSql);
					
					ResultSet rsstk = stmt.executeQuery(stkSql);
					if(rsstk.next()) {     
						v2++;
					}else{   
						String ssql="select m.part_no,sum(if(i.brhid="+branch1+" and i.locid="+location1+",(i.op_qty-i.out_qty-i.rsv_qty-i.del_qty),0)) balstkqty  from my_prddin i left join my_main m on m.psrno=i.psrno where i.psrno='"+prdid+"' and i.specno='"+specno+"' and i.prdid='"+prdid+"' ";
					//	System.out.println("my_prdin check 22 invissue=================="+ssql);
						ResultSet rs1 = stmt1.executeQuery(ssql);
							while(rs1.next()){
							insuff += rs1.getString("part_no")+" - Bal Qty= "+ rs1.getString("balstkqty")+", ";
							
							
						}
						
						
					}
		     }			
		}

	session.setAttribute("BRANCHID",branch1);   
	
	if(v1==v2){
		//System.out.println("arraysys======="+mainarray);
	
	       val= DAO.insert("",date,reftype,branch1,location1,frmbrhid,frmlocid,remarks,txttotal,txtnettotal,"0","0",finalamt,"A","ITI", mainarray, session, request); 
	     //System.out.println("vallll-=========="+val);
	       if(val>0){
	    	     conn.setAutoCommit(false);
			   vocno = 	request.getAttribute("vdocNo").toString();
				  
			     Statement stmt2=conn.createStatement();
			     for(int i=0;i< mainarray.size();i++){

			 		String[] prod=((String) mainarray.get(i)).split("::");
			 		
			 		if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){
			 			String rowno=""+(prod[15].trim().equalsIgnoreCase("undefined") || prod[15].trim().equalsIgnoreCase("NaN")|| prod[15].trim().equalsIgnoreCase("")|| prod[15].isEmpty()?0:prod[15].trim())+"";
			 			String  quantity=""+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].trim().equalsIgnoreCase("")|| prod[2].isEmpty()?0:prod[2].trim())+"";
			 			
			 			String upsql="update my_invtranreqd set outqty="+quantity+" where rowno="+rowno+" ";   
						   val =  stmt2.executeUpdate(upsql);  
						//   System.out.println(val+"======= query=================="+upsql);       
				
			 		 
			 		     }			
			 		}
			       
			   stmt2.close();  
		   }
		}else{
			val=-1;
		}

       if(val>0){
    	  conn.commit();  
      }
   response.getWriter().print(val+"####"+vocno+"####"+insuff);   
   stmt.close();
	conn.close();
}catch(Exception e){
 	e.printStackTrace();
 	conn.close();
}finally{
   conn.close();
}
%>