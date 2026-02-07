<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.connection.*"%>
<%@page import="java.sql.*"%>
<%
Connection conn=null;
String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
JSONObject objdata=new JSONObject();
try{
	System.out.println("inside GRN Product:"+branch);
	ClsConnection objconn=new ClsConnection();
	conn=objconn.getMyConnection();
	Statement stmt=conn.createStatement();
	JSONArray productarray=new JSONArray();
	int method=0;
	
	String chk="select method  from gl_prdconfig where field_nme='Prosearch'";
	ResultSet rs=stmt.executeQuery(chk); 
	if(rs.next())
	{
		method=rs.getInt("method");
	}
	
	int superseding=0;
	String chk1="select method  from gl_prdconfig where field_nme='superseding'";
	ResultSet rs1=stmt.executeQuery(chk1); 
	if(rs1.next())
	{
		superseding=rs1.getInt("method");
	}
	String fleetsql="";
	if(superseding==1)
	{
		 fleetsql="select s.part_no,m.* from( select  "+method+" method,m.barcode, at.mspecno as specid,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
				+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
				+ "   left join my_desc de on(de.psrno=m.doc_no)    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+branch+",de.brhid)='"+branch+"'  ) "
					    + "  m left join  my_prdsuperseding s  on s.psrno=m.psrno  where   s.discontinued=0   order by s.psrno,s.priority  "  	;
					 
		  System.out.println("----main1---"+fleetsql);

	}
	
	else
	{
	
/*String fleetsql="select  "+method+" method,bd.brandname, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
		+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
		+ "   left join my_desc de on(de.psrno=m.doc_no)    where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+branch+",de.brhid)='"+branch+"' ";
*/
 fleetsql="select  "+method+" method,m.barcode, at.mspecno as specid, m.part_no,m.productname,m.doc_no,u.unit,m.munit,m.psrno from my_main m left join  "
		+ " my_unitm u on m.munit=u.doc_no  left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_desc de on(de.psrno=m.doc_no)  "
		+ " where m.status=3 and de.discontinued=0  and  if(de.brhid=0,"+branch+",de.brhid)='"+branch+"' group by m.psrno  ";

 System.out.println("-----fleetsql---"+fleetsql);

}
	ResultSet rsprod=stmt.executeQuery(fleetsql);
	while(rsprod.next()){
		JSONObject objtemp=new JSONObject();
		objtemp.put("method",method);
		objtemp.put("brandname",rsprod.getString("barcode"));
		objtemp.put("specid",rsprod.getString("specid"));
		objtemp.put("part_no",rsprod.getString("part_no"));
		objtemp.put("productname",rsprod.getString("productname"));
		objtemp.put("doc_no",rsprod.getString("doc_no"));
		objtemp.put("unit",rsprod.getString("unit"));
		objtemp.put("munit",rsprod.getString("munit"));
		objtemp.put("psrno",rsprod.getString("psrno"));
		productarray.add(objtemp);				
	}
	objdata.put("grnproduct",productarray);
}
catch(Exception e){
	e.printStackTrace();
	conn.close();
}
finally{
	conn.close();
}
response.getWriter().write(objdata+"");
%>