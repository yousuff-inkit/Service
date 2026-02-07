<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.util.ArrayList"%>
<%	
	ClsConnection ClsConnection=new ClsConnection();
	Connection conn = null;    
	String salid=request.getParameter("salid")==null || request.getParameter("salid").trim()==""?"0":request.getParameter("salid").trim();
	String docsarray=request.getParameter("docsarray")==null || request.getParameter("docsarray").trim()==""?"0":request.getParameter("docsarray").trim();
	String processid=request.getParameter("processid")==null || request.getParameter("processid").trim()==""?"0":request.getParameter("processid").trim();
    
    try{       
	 	conn = ClsConnection.getMyConnection();
		conn.setAutoCommit(false);
	 	Statement stmt = conn.createStatement();  
		System.out.println("process--->>>"+processid);               
	    
		int val=0;
		 
		/*Operations*/  
		if(processid.equalsIgnoreCase("Salesman")){
			
			ArrayList<String> docsar=new ArrayList<String>();
			if(docsarray.contains(":")){
				String [] docs=new String []{};   
				docs=docsarray.split(":");
				for(int i=0;i<docs.length;i++){
					docsar.add(i, docs[i]);  
				}
			}
			else{
				docsar.add(0, docsarray);     
			}
			for(int i=0;i<docsar.size();i++){
				 int docno=0,brhid=0;
				 String sqlselect="select brhid,doc_no from sk_srvcontrm where tr_no='"+docsar.get(i)+"'";  
		    	 //System.out.println("sqlselect--->>>"+sqlselect);         
				 ResultSet rs = stmt.executeQuery(sqlselect);  
				 while(rs.next()){
					 docno = rs.getInt("doc_no");
					 brhid = rs.getInt("brhid");
				 }
				 
			     String upsql="update sk_srvcontrm m left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join gl_enqm em on em.doc_no=m.refdocno left join sk_srvqotm qm on qm.refdocno=em.doc_no and qm.refdtype='ENQ' set m.sal_id='"+salid+"',ac.sal_id='"+salid+"',em.sal_id='"+salid+"',qm.sal_id='"+salid+"' where m.tr_no='"+docsar.get(i)+"'";  
		    	 //System.out.println("upsql--->>>"+upsql);         
				 val = stmt.executeUpdate(upsql);
		 
			     if(val>0){     
			    	 String logsql="insert into gl_biblog(doc_no, brhId, dtype, edate, userId, ENTRY, remarks) values ('"+docno+"','"+brhid+"','CSP',now(),'"+session.getAttribute("USERID").toString()+"','E', 'Salesman Changed')";    
					 //System.out.println("logsql--->>>"+logsql);      
					 stmt.executeUpdate(logsql);      
			     } 
			}    
	     }else{}            
		 
		if(val>0){        
			conn.commit();
		}
		 response.getWriter().print(val);
 	stmt.close();
	}catch(Exception e){
	 	e.printStackTrace();
   }finally{
	   conn.close();
   }
%>
