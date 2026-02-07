<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>

<%	
ClsConnection ClsConnection=new ClsConnection();


    String invarray=request.getParameter("invarray")==null?"":request.getParameter("invarray");
    int branch1 = request.getParameter("branch1")==null || request.getParameter("branch1").equals("")?0:Integer.parseInt(request.getParameter("branch1").trim());
    int location1 = request.getParameter("location1")==null || request.getParameter("location1").equals("")?0:Integer.parseInt(request.getParameter("location1").trim());
    String insuff=request.getParameter("insuff")==null?"":request.getParameter("insuff");
//System.out.println("branch1=="+branch1);
//System.out.println("location1=="+location1);

    String sql="",sql1="";
	Connection conn = null;
	
	
	ArrayList<String> mainarray=new ArrayList<String>();
	String temparray[]=invarray.split(",");

	
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		Statement stmt1= conn.createStatement();
		
		
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
				 
				 String stkSql="select m.part_no,i.cost_price,i.stockid,i.psrno,i.specno,sum(i.op_qty) stkqty, sum(i.op_qty-i.out_qty-i.rsv_qty-i.del_qty) stkqty,(i.rsv_qty+i.out_qty+i.del_qty) out_qty,i.out_qty as qty,i.date from my_prddin i  "
							+ "left join my_main m on m.psrno=i.psrno and m.specid=i.specno where i.psrno='"+prdid+"' and i.specno='"+specno+"' and i.prdid='"+prdid+"' and i.brhid="+branch1+" and i.locid="+location1+" "
							+ " having sum(i.op_qty-i.out_qty-i.rsv_qty-i.del_qty)>0 ";
						
							
							//System.out.println("my_prdin check invissue=================="+stkSql);
						
						ResultSet rsstk = stmt.executeQuery(stkSql);
						if(rsstk.next()) {  
							v2++;
						}else{   
							String ssql="select m.part_no,sum(if(i.brhid="+branch1+" and i.locid="+location1+",(i.op_qty-i.out_qty-i.rsv_qty-i.del_qty),0)) stkqty from my_prddin i left join my_main m on m.psrno=i.psrno where i.psrno='"+prdid+"' and i.specno='"+specno+"' and i.prdid='"+prdid+"' ";
						//System.out.println("my_prdin check 22 invissue=================="+ssql);
							ResultSet rs1 = stmt1.executeQuery(ssql);
								while(rs1.next()){
								insuff += rs1.getString("part_no")+" - Bal Qty= "+ rs1.getString("stkqty")+", ";
								val=1;
								
							}
							
							
						}
			     }			
			}		
		
		 response.getWriter().print(val+"####"+insuff);   
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>