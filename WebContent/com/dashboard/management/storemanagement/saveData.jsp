<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.common.*"%>  
<%	
Connection conn = null;
	ClsConnection ClsConnection=new ClsConnection();
    ClsCommon ClsCommon=new ClsCommon();
	try{
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
		Statement stmt = conn.createStatement();
		
		String checklistarray = request.getParameter("productid")==null?"":request.getParameter("productid").trim();
		int val=0,val1=0;
		String doc_no="0",voc_no="0",vocnos="";
		 ArrayList<String> griddataarray=new ArrayList<String>();
 		 String[] temparray=checklistarray.split(",");  
 		 for(int i=0;i<temparray.length;i++){
 			griddataarray.add(temparray[i]);    
 		 }
 		 for(int i=0;i< griddataarray.size();i++){  
 			
 			 String[] contrtypedet=((String) griddataarray.get(i)).split("::");
			//System.out.println("ARRAY:"+contrtypedet[0]+contrtypedet[1]+contrtypedet[2]+contrtypedet[3]+contrtypedet[4]+contrtypedet[5]+contrtypedet[6]);
 			 if(!(contrtypedet[0].trim().equalsIgnoreCase("undefined")|| contrtypedet[0].trim().equalsIgnoreCase("NaN")||contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty())){
				String sqotprdid=(contrtypedet[0].trim().equalsIgnoreCase("undefined") || contrtypedet[0].trim().equalsIgnoreCase("NaN")|| contrtypedet[0].trim().equalsIgnoreCase("")|| contrtypedet[0].isEmpty()?"0":contrtypedet[0].trim());
				String sqotprdname=(contrtypedet[1].trim().equalsIgnoreCase("undefined") || contrtypedet[1].trim().equalsIgnoreCase("NaN")|| contrtypedet[1].trim().equalsIgnoreCase("")|| contrtypedet[1].isEmpty()?"":contrtypedet[1].trim());
				String quantity=(contrtypedet[2].trim().equalsIgnoreCase("undefined") || contrtypedet[2].trim().equalsIgnoreCase("NaN")|| contrtypedet[2].trim().equalsIgnoreCase("")|| contrtypedet[2].isEmpty()?"":contrtypedet[2].trim());
				String unit=(contrtypedet[3].trim().equalsIgnoreCase("undefined") || contrtypedet[3].trim().equalsIgnoreCase("NaN")|| contrtypedet[3].trim().equalsIgnoreCase("")|| contrtypedet[3].isEmpty()?"":contrtypedet[3].trim());
				String remarks=(contrtypedet[4].trim().equalsIgnoreCase("undefined") || contrtypedet[4].trim().equalsIgnoreCase("NaN")|| contrtypedet[4].trim().equalsIgnoreCase("")|| contrtypedet[4].isEmpty()?"":contrtypedet[4].trim());
				String branch=(contrtypedet[5].trim().equalsIgnoreCase("undefined") || contrtypedet[5].trim().equalsIgnoreCase("NaN")|| contrtypedet[5].trim().equalsIgnoreCase("")|| contrtypedet[5].isEmpty()?"":contrtypedet[5].trim());
				String location=(contrtypedet[6].trim().equalsIgnoreCase("undefined") || contrtypedet[6].trim().equalsIgnoreCase("NaN")|| contrtypedet[6].trim().equalsIgnoreCase("")|| contrtypedet[6].isEmpty()?"":contrtypedet[6].trim());
				String psrno=(contrtypedet[7].trim().equalsIgnoreCase("undefined") || contrtypedet[7].trim().equalsIgnoreCase("NaN")|| contrtypedet[7].trim().equalsIgnoreCase("")|| contrtypedet[7].isEmpty()?"":contrtypedet[7].trim());
				
			
				String strsql="select coalesce((max(doc_no)+1),1) doc_no,coalesce((max(voc_no)+1),1) voc_no from my_invtranreqm"; 
				//System.out.println("strsql==="+strsql);  
				ResultSet rs = stmt.executeQuery(strsql);         
				while(rs.next()) {  
					doc_no=rs.getString("doc_no");  
					voc_no=rs.getString("voc_no");  
				}  	
				//System.out.println("doc_no--->>>"+doc_no);   
				
				String upsql="insert into my_invtranreqm(doc_no,voc_no,brhid, date, reqbrhid, reqlocid, userid, remarks) values('"+doc_no+"','"+voc_no+"','"+branch+"',now(),'"+branch+"','"+location+"','"+session.getAttribute("USERID").toString()+"','"+remarks+"')";                     
				//System.out.println("my_invtranreqm insert--->>>"+upsql);  
				val= stmt.executeUpdate(upsql);
					
				if(val>0){
					vocnos += voc_no+", ";
					String upsql1="insert into my_invtranreqd(rdocno,psrno,qty,unitid) values('"+doc_no+"','"+psrno+"','"+quantity+"','"+unit+"')";                     
				    //System.out.println("my_invtranreqd insert--->>>"+upsql1);  
					val1= stmt.executeUpdate(upsql1);
				}
 			}
 	      }
 		  if (val>0 && val1>0){
	    	   conn.commit();
			}
 		  
 	//	 System.out.println(vocnos+"==="+vocnos.length()+"==="+vocnos.substring(0, vocnos.length() - 2)); 
 		response.getWriter().print(val+"####"+vocnos.substring(0, vocnos.length() - 2));   
    stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>