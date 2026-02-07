<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%
    Connection conn = null;      
	JSONObject objupload=new JSONObject();
	String refdocno=request.getParameter("refdocno")==null?"0":request.getParameter("refdocno").toString();
	String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype").toString();
	try{	
		ClsConnection ClsConnection=new ClsConnection();
		conn= ClsConnection.getMyConnection();  
		Statement stmt = conn.createStatement ();  
		String strattach="";  
		if(!reftype.equalsIgnoreCase("CREG")){
		strattach="select sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no="+refdocno+" and a.dtype='"+reftype+"' order by sr_no";
		  //System.out.println("strattach->>>"+strattach); 
		}
		else if(reftype.equalsIgnoreCase("CREG")){                 
			   String sqltst="select mm.brhid crbrhid,en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,if(eq.clientid=2,pm.doc_no,eq.cldocno) cldocno,coalesce(mm.doc_no,0) crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_callregm mm left join in_endorsement en on en.refno=mm.tr_no and en.reftype='CREG' left join in_contract cm on cm.doc_no=en.cntrno  left join in_enqm eq on cm.refno=eq.doc_no left join cm_prosclientm pm on (pm.tr_no=eq.cldocno and eq.clientid=2) left join in_srvqotm qm on qm.refdocno=eq.doc_no where 1=1 and mm.doc_no="+refdocno+"";
			   // System.out.println("sqltst--1->>>"+sqltst); 
			   Statement cpstmt = conn.createStatement (); 
			   ResultSet rs44=cpstmt.executeQuery(sqltst);
			   String docnoss="";
			    while(rs44.next()){    
		    		docnoss+=rs44.getString("crgno")+",";
		    		strattach="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.clientview=1 and a.doc_no in ("+rs44.getString("crgno")+") and a.dtype in ('CREG') and a.brhid="+rs44.getString("crbrhid")+" ";   
		    		   
			       docnoss+=rs44.getString("endno")+",";
			       strattach=strattach+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.clientview=1 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" ";
				 
			      /*  docnoss+=rs44.getString("insno")+",";
	    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" ";
				   
	    		   docnoss+=rs44.getString("qotno")+",";
	    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+" ";
				   
	    		   docnoss+=rs44.getString("enqno")+",";
	    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+" ";
				   
                if(rs44.getString("clientid").equalsIgnoreCase("1")){
	    			   dtypess+="'CRM'";
	    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  order by sr_no desc";   
	    		   }else{
	    			   dtypess+="'PPC'";   
	    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  order by sr_no desc";
	    		   } 
				   dtypess+="'END'"+",";  
	    		   dtypess+="'INS'"+",";  
				   dtypess+="'SQOT'"+",";
	    		   dtypess+="'ENQ'"+",";
	    		   dtypess+="'CRM'"+",";*/
	    	     }
	       }
		// System.out.println("======="+strattach);
		ResultSet rsattach=stmt.executeQuery(strattach);
		ArrayList<String> attacharray=new ArrayList();
		int serial=1;
		while(rsattach.next()){
			attacharray.add(serial+"***"+rsattach.getString("sr_no")+"***"+rsattach.getString("extension")+"***"+rsattach.getString("description")+"***"+rsattach.getString("filename")+"***"+rsattach.getString("path")+"***"+rsattach.getString("type"));
			serial++;
		}
		
		objupload.put("attachdata", attacharray);
		stmt.close();
		conn.close();  

		response.getWriter().print(objupload);        
	}
	catch(Exception e){
		e.printStackTrace();
		conn.close();
	}
	finally{
		conn.close();
	}
%>