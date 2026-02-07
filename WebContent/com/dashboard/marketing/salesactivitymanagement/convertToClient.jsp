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
<%@page import="com.controlcentre.masters.client.ClsClientDAO" %>     
<%@page import="java.text.SimpleDateFormat" %>           
<%	
ClsConnection ClsConnection=new ClsConnection();  

ClsCommon ClsCommon=new ClsCommon();

	Connection conn = null;

	try{
	 	conn = ClsConnection.getMyConnection();     
		Statement stmt = conn.createStatement();
		session=request.getSession();         
		String trno=request.getParameter("trno")=="" || request.getParameter("trno")==null?"0":request.getParameter("trno"); 
		String brhid=request.getParameter("brhid")=="" || request.getParameter("brhid")==null?"0":request.getParameter("brhid");
		String sql="",sqlsub="",sql1="",sql2="",sql3="";
		int dat=0;
		String temp="";
		int val=0,val1=0;
			 ClsClientDAO clientDAO=new ClsClientDAO();
			 String name="",mob="",email="";
			 int salid=0,telesales=0;
			 String pdname="",pdmob="",pdemail="",pdtel="",pdact="",pdext="",area="",tel="";
			 ArrayList<String> cparray= new ArrayList<String>();
			 ArrayList<String> dcarray= new ArrayList<String>();  
			 SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");         
			 java.util.Date curDate=new java.util.Date();
		     java.sql.Date cdate=ClsCommon.changeStringtoSqlDate(formatter.format(curDate));
		     session.setAttribute("BRANCHID",brhid);
		     String sqls="select m.name,m.sal_id,m.mob,m.email,m.tel from cm_prosclientm m  where m.tr_no="+trno+"";      
		//	 System.out.println("sqls--->>>"+sqls);  
			 ResultSet rsstk = stmt.executeQuery(sqls);    

				while(rsstk.next()) {
					name=rsstk.getString("name");
					salid=rsstk.getInt("sal_id");
					mob=rsstk.getString("mob");
					email=rsstk.getString("email");
					tel=rsstk.getString("tel");
				}
				  
				String sqlpd="select pd.cperson,pd.mob,pd.email,pd.tel,pd.actvty_id,pd.extn from cm_prosclientd pd left join "  
					+" cm_prosclientm m on pd.rtrno=m.tr_no where m.tr_no="+trno+"";         
				//  System.out.println("sqlpd--->>>"+sqlpd);   
				ResultSet rspd = stmt.executeQuery(sqlpd);

					while(rspd.next()) {    
						pdname=rspd.getString("cperson");
						pdmob=rspd.getString("mob");
						pdemail=rspd.getString("email");
						pdtel=rspd.getString("tel");
						pdact=rspd.getString("actvty_id");
						pdext=rspd.getString("extn");
					
						cparray.add(pdname+"::"+pdmob+" :: "+pdtel+" :: "+pdext+" :: "+pdemail+" :: "+area+" :: "+area+" :: "+pdact+" :: "+0);
					}
					
					String sqldag = "SELECT DOC_NO, acc_group FROM my_clcatm WHERE dtype='CRM' AND `default`=1";
					ResultSet rs = stmt.executeQuery(sqldag);
					int docNo=0;
					int accGroup = 0;
					while(rs.next()){
						docNo = rs.getInt("DOC_NO");
						accGroup = rs.getInt("acc_group");
					}
					
					dat=clientDAO.insert(cdate,name,1,accGroup,salid,docNo,"","",0.0,0.0,0.0,"","",mob,tel,"","",email,"",0,"0","","","","","","",0,"",cparray,session,"A","CRM","","",request,1,0,dcarray);	  
	              if(dat>0){            
					 sql1="update cm_prosclientm m left join cm_appoinment m1 on (m.tr_no=m1.ppctrno) set m.clientacid= "+dat+" ,m1.cldocno="+dat+" where m.tr_no= "+trno+"";              
			         //System.out.println("update="+sql1);                 
					 val= stmt.executeUpdate(sql1);
					 String sql111="insert into gl_biblog(doc_no,brhid,dtype,edate,userid,entry) values("+trno+",'"+session.getAttribute("BRANCHID")+"','ACR',now(),'"+session.getAttribute("USERID")+"','A')";           
				     int val111= stmt.executeUpdate(sql111);          
	              }
				 if(val>0){  
					 temp="1";
				 }
		 response.getWriter().print(temp+"::"+dat);   
 	stmt.close();
 	conn.close();
	}catch(Exception e){
	 	e.printStackTrace();
	 	conn.close();
   }finally{
	   conn.close();
   }
%>
