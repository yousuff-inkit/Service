<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>


<%	
	Connection conn = null;
    ResultSet rs=null;
	ClsConnection ClsConnection=new ClsConnection();
	String type = request.getParameter("costtype")==null || request.getParameter("costtype")==""?"0":request.getParameter("costtype").toString();
	try{
	 	conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String sql="";    
		if(type.equalsIgnoreCase("1"))
    	{
    		 sql="select c1.costcode code,c1.doc_no doc_no,c1.description name,coalesce(c2.description,c1.description) namedet,c1.grpno,c2.grpno from my_ccentre c1 left join my_ccentre c2 on(c1.doc_no=c2.grpno) where c1.m_s=0";
    	}
    	/* AMC & SJOB */
    	else if(type.equalsIgnoreCase("3") || type.equalsIgnoreCase("4"))
    	{
    		String dtype="";
    		if(type.equalsIgnoreCase("3")) {
    			dtype="AMC";
    		} else if(type.equalsIgnoreCase("4")) {
    			dtype="SJOB";
    		}
    		
    		 sql="select m.doc_no tr_no,concat(m.doc_no, if(sd.doc_no is null,'',concat('',sd.doc_no))) code,concat(if(sd.name is null,'' ,concat(sd.name,' ')),a.refname) name from cm_srvcontrm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' "
    				+ " left join cm_subdivm s on m.tr_no=s.jobdocno left join cm_subdivision sd on sd.doc_no=s.rdocno where m.status=3 and a.status=3 and m.dtype='"+dtype+"' order by m.doc_no,sd.doc_no";
    	}
    	/* Call Register */
    	else if(type.equalsIgnoreCase("5"))
    	{
    		 sql="select m.doc_no,m.doc_no code,a.refname name from cm_cuscallm m left join my_acbook a on m.cldocno=a.doc_no and a.dtype='CRM' where m.status=3 and a.status=3 and m.dtype='CREG'";
    	}
    	/* Fleet */
    	else if(type.equalsIgnoreCase("6"))
    	{
    		 sql="select doc_no,fleet_no code,flname name,reg_no from gl_vehmaster where cost=0";
    	}
    	/* IJCE */
    	else if(type.equalsIgnoreCase("7"))
    	{
    		 sql="select m.doc_no,m.doc_no code,a.refname name,m.jobno,p.proj_name project from is_jobmaster m left join my_acbook a on m.client_id=a.doc_no and a.dtype='CRM' left join is_jprjname p on m.project_id=p.tr_no where m.status=3 and a.status=3 and p.status=3 and m.dtype='IJCE'";
    	}
		/* Contract */
    	else if(type.equalsIgnoreCase("8"))
    	{
    		 sql="select m.doc_no,m.doc_no code,if(m.cardno is null,' ',(if(m.cardno=0,' ',m.cardno))) reg_no,cl.name name from hi_contract m left join hi_client cl on cl.doc_no=m.cldocno where m.status=3 and cl.status=3";
    	}
		
		/* Job Card */
    	else if(type.equalsIgnoreCase("9"))
    	{
    		 sql="SELECT * FROM (select M.voc_no code,M.doc_no,M.reftype,convert(concat(M.reftype,' ',M.voc_no),char(100)) project,ac.refname name,ac.cldocno,0 siteid,0 site from ws_jobcard M left join ws_estm e on M.refno=e.doc_no and reftype='est' left join ws_gateinpass g on (M.refno=g.doc_no and reftype='gip') or (e.gipno=g.doc_no) left join  my_acbook ac on (ac.cldocno=g.cldocno and ac.dtype='CRM') where  m.status in(3)) M WHERE 1=1";
    	} else{}         
		System.out.println("sql==="+sql);
		String costtype="";
		String costtypeid="";
		if(!type.equalsIgnoreCase("0")){
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				costtype+=rs.getString("code")+" - "+rs.getString("name")+"$$$$";    
				costtypeid+=rs.getString("code")+",";           
		  		} 
			
			costtype=costtype.substring(0, costtype.length()>0?costtype.length()-1:0);    
		}        
		
		response.getWriter().write(costtype+"####"+costtypeid);   
		
		stmt.close();
		conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
	}finally{
		conn.close();
	}
  %>
  
