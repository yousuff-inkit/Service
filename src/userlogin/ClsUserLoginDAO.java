package userlogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.Map;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.login.ClsLogin;

public class ClsUserLoginDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLogin objlogin=new ClsLogin();
	ClsEncrypt ClsEncrypt=new ClsEncrypt();
	public boolean clientLogin(String clientusername, String clientpassword,   
			HttpSession session, HttpServletRequest request) throws SQLException {   
		// TODO Auto-generated method stub
		//System.out.println("in dao");
		Connection conn=null;
		try{
			int userid=0;
			String username="";
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			//System.out.println("===="+clientpassword);
			clientpassword=ClsEncrypt.getInstance().encrypt(clientpassword);
			//System.out.println("===="+clientpassword);
			String str="select * from my_user where user_id='"+clientusername+"' and pass='"+clientpassword+"' and status=3";
			ResultSet rs=stmt.executeQuery(str);     
			while(rs.next()){
				userid=rs.getInt("doc_no");
				username=rs.getString("user_name");      
			}   
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(userid>0){    
		    	session.setAttribute("CLDOCNO", userid);  
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("USERID",userid);
		    	session.setAttribute("COMPANYID","1");
		    	session.setAttribute("USERNAME",username);          
				session.setAttribute("CLIENTNAME", username);          
				String strlog = "insert into userlog (userid,username,WIN_USER,win_cmp,WIN_MAC,DATE_IN) values ("+userid+",'"+username+"','"+xuser+"','"+xcomp+"','"+mac+"',now())";
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert<=0){
					conn.close();
					return false;
				}
				else{
					conn.commit();
					return true;
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return false;
	}

	
	
	public JSONArray getContractData(String userid,Connection conn){
		JSONArray contractarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1;    
            String strmaster="select ser.doc_no as serdocno,a.tr_no,a.siteid,ac.acno,ac.doc_no docno2,a.brhid branch,cast(a.srdocno as char) srdocno,coalesce(a.workper,0) workper,a.reftrno as doctrno,cast(a.srtrno as char) srtrno,a.dtype,a.refdocno,s.site,ac.refname,concat(CAST(DATE_FORMAT(a.plannedon,'%d-%m-%Y') as CHAR(50)),' ',CAST(a.pltime as CHAR(50))) pldate from (select p.tr_no,p.dtype,p.date,p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.asgnmode,p.refdocno,p.siteid,p.servid,p.reftrno,p.plannedon,p.pltime,m.validupto,'0' srtrno,'0' srdocno,p.workper,p.sr_no from cm_servplan p left join cm_srvcontrm m on m.tr_no=p.doc_no and m.dtype=p.dtype where m.status=3 and m.jbaction in (0,4)  and m.pstatus!=1 and p.status in (4) union all select p.tr_no,p.dtype,p.date,p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.asgnmode,p.refdocno,p.siteid,p.servid,p.reftrno,p.plannedon,p.pltime,m.validupto,dm.tr_no srtrno,dm.doc_no srdocno,p.workper,p.sr_no from cm_servplan p left join cm_srvcontrm m on m.tr_no=p.doc_no and m.dtype=p.dtype left join cm_srvdetm dm on dm.schrefdocno=p.tr_no where  dm.moconfirm=0 and dm.confirm=0  union all select p.tr_no,p.dtype,p.date,p.cldocno,p.priorno,p.brhid,p.empgroupid,p.empid,p.asgnmode,p.refdocno,p.siteid,p.servid,p.reftrno,p.plannedon,p.pltime,'' validupto,'0' srtrno,'0' srdocno,p.workper,p.sr_no from cm_servplan p left join cm_cuscallm c on c.tr_no=p.doc_no and p.dtype=c.dtype where c.status=3 and c.clstatus in (0,4) and p.status=4) a left join my_groupvals ser on(a.servid=ser.doc_no and ser.grptype='service') left join cm_serteamm m on(a.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and a.empid=md.empid) left join cm_srvcsited s on( a.siteid=s.rowno ) left join my_acbook ac on ac.cldocno=a.cldocno and ac.dtype='CRM' where md.serteamuserlink="+userid+" group by a.tr_no order by a.plannedon";
			//System.out.println("strmaster--->>>"+strmaster);    
			ResultSet rsmaster=stmt.executeQuery(strmaster);
			while(rsmaster.next()){
				JSONObject objsub=new JSONObject();
				objsub.put("srno", srno);
				objsub.put("docno", rsmaster.getString("refdocno"));
				objsub.put("dtype", rsmaster.getString("dtype"));
				objsub.put("pldate", rsmaster.getString("pldate"));
				objsub.put("refname", rsmaster.getString("refname"));
				objsub.put("site", rsmaster.getString("site"));
				objsub.put("branch", rsmaster.getString("branch"));
				objsub.put("srdocno", rsmaster.getString("srdocno"));
				objsub.put("doctrno", rsmaster.getString("doctrno"));
				objsub.put("srtrno", rsmaster.getString("srtrno")); 
				objsub.put("serdocno", rsmaster.getString("serdocno")); 
				objsub.put("tr_no", rsmaster.getString("tr_no")); 
				objsub.put("siteid", rsmaster.getString("siteid")); 
				objsub.put("acno", rsmaster.getString("acno"));
				objsub.put("docno2", rsmaster.getString("docno2"));
				objsub.put("workper", rsmaster.getString("workper"));   
				srno++;
				contractarray.add(objsub);  
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return contractarray;
	}
	public JSONArray getSurveyData(String userid,Connection conn){
		JSONArray contractarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1;
            String empid="0",docno="0";
            String sql1="select group_concat(doc_no) docno from cm_serteamm  where serteamuserlink='"+userid+"'";
            //System.out.println("sql1--->>>"+sql1);        
			ResultSet rs1=stmt.executeQuery(sql1);
			if(rs1.next()){
				docno=rs1.getString("docno");
				String sql2="select group_concat(empid) docno from cm_serteamd where rdocno in("+docno+")";
	            //System.out.println("sql2--->>>"+sql2);        
				ResultSet rs2=stmt.executeQuery(sql2);	
				while(rs2.next()){
					empid=rs2.getString("docno");
				}
			}else{
				String sql2="select group_concat(empid) docno from cm_serteamd where serteamuserlink='"+userid+"'";
	            //System.out.println("sql2--->>>"+sql2);        
				ResultSet rs2=stmt.executeQuery(sql2);	
				while(rs2.next()){
					empid=rs2.getString("docno");
				}    
			}
            //String strmaster="select date_format(bq.plannedon,'%d.%m.%Y') date, e.remarks,qs.site,coalesce(sm.doc_no,0) surdocno,sm.voc_no survocno,e.cpersonid,ma.cldocno,em.doc_no empid,e.voc_no,sm.brhid, e.doc_no, ma.refname,coalesce(ct.mob,'') conmob,ct.email conemail,e.cperson,concat(ma.address,', ',ma.per_mob,', ',ma.mail1) compaddress from gl_enqm e left join (select rowno,group_concat(site) site,rdocno from gl_enqsited group by rdocno) qs on qs.rdocno=e.doc_no left join gl_beqs bq on bq.rdocno=e.doc_no left join cm_serteamm m on(bq.empgroupid=m.doc_no) left join cm_serteamd md on(md.rdocno=m.doc_no and bq.empid=md.empid) left join hr_empm em on(md.empid=em.doc_no) left join my_acbook ma on (ma.cldocno=e.cldocno and ma.dtype='CRM') left join my_crmcontact ct on (ct.row_no=e.cpersonid) left join cm_surveym sm on (sm.refdocno=e.doc_no and sm.ref_type='ENQ') where e.status=3 and e.pconfirm=0 and md.serteamuserlink="+userid+" group by e.doc_no";
			String strmaster="select date_format(bq.plannedon,'%d.%m.%Y') date, e.remarks,qs.site,coalesce(sm.doc_no,0) surdocno,sm.voc_no survocno,e.cpersonid,ma.cldocno,em.doc_no empid,e.voc_no,sm.brhid, e.doc_no, ma.refname,coalesce(ct.mob,'') conmob,ct.email conemail,e.cperson,concat(ma.address,', ',ma.per_mob,', ',ma.mail1) compaddress from gl_enqm e left join (select rowno,group_concat(site) site,rdocno from gl_enqsited group by rdocno) qs on qs.rdocno=e.doc_no left join gl_beqs bq on bq.rdocno=e.doc_no left join hr_empm em on(bq.empid=em.doc_no) left join my_acbook ma on (ma.cldocno=e.cldocno and ma.dtype='CRM') left join my_crmcontact ct on (ct.row_no=e.cpersonid) left join cm_surveym sm on (sm.refdocno=e.doc_no and sm.ref_type='ENQ') where e.status=3 and e.pconfirm=0 and e.enqstatus<=1 and bq.empid in("+empid+") group by e.doc_no";
			System.out.println("strmaster--->>>"+strmaster);                  
			ResultSet rsmaster=stmt.executeQuery(strmaster);
			while(rsmaster.next()){    
				JSONObject objsub=new JSONObject();    
				objsub.put("srno", srno);
				objsub.put("docno", rsmaster.getString("voc_no"));
				objsub.put("refname", rsmaster.getString("refname"));
				objsub.put("conmob", rsmaster.getString("conmob"));
				objsub.put("conemail", rsmaster.getString("conemail"));
				objsub.put("cperson", rsmaster.getString("cperson"));
				objsub.put("compaddress", rsmaster.getString("compaddress"));
				objsub.put("vocno", rsmaster.getString("voc_no"));
				objsub.put("brhid", rsmaster.getString("brhid"));
				objsub.put("docno", rsmaster.getString("doc_no"));
				objsub.put("cpersonid", rsmaster.getString("cpersonid"));
				objsub.put("cldocno", rsmaster.getString("cldocno"));
				objsub.put("empid", rsmaster.getString("empid")); 
				objsub.put("surdocno", rsmaster.getString("surdocno")); 
				objsub.put("survocno", rsmaster.getString("survocno"));  
				objsub.put("date", rsmaster.getString("date"));  
				objsub.put("remarks", rsmaster.getString("remarks"));  
				objsub.put("site", rsmaster.getString("site"));            
				srno++;
				contractarray.add(objsub);      
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return contractarray;
	}

	private JSONArray getContractAttachData(int refdocno, String reftype,Connection conn) {   
		// TODO Auto-generated method stub
		JSONArray attacharray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
			
			/*String strattach="select sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.clientview=1 and a.doc_no="+refdocno+" and a.dtype='"+reftype+"' order by sr_no";
			//System.out.println(strattach);
			ResultSet rsattach=stmt.executeQuery(strattach);*/
			
			Statement cpstmt = conn.createStatement();
		       
		       int i=0;
		       String sqls="",sqltst="",docnoss="",dtypess="",sqltest="";  
		       String dtype="INS",docno="0";
		       String  cpsql="";
		       ResultSet rsattach=null;
		       /*String sqlsss="select * from gl_attachtypechk where dtype='"+dtype+"' and status=3";
		       ResultSet rs=cpstmt.executeQuery(sqlsss);
		       if(rs.next())
		       {
		    	   i=1;
		       }*/
		       String enddocno="",insdocno="",qotdocno="",enqdocno="",crmdocno="",ppcdocno="";
		     
		    	  
		    	   
		    	  /* if(i==0)
			       {
			    	   sqls= " and a.brhid='"+contractarray.get(j).split("::")[1]+"' " ;     
			       }*/
		    	   docno=refdocno+"";
		    	   ResultSet rs44=null;
			       sqltst="select en.brhid endbrch,qm.brhid qotbrhid,eq.brhid enqbrhid,cm.brhid cntbrhid,if(eq.clientid=2,pm.doc_no,eq.cldocno) cldocno,0 crgno,coalesce(eq.clientid,1) clientid,coalesce(eq.voc_no,0) enqno,coalesce(en.voc_no,0) endno,coalesce(cm.voc_no,0) insno,coalesce(qm.doc_no,0) qotno from in_contract cm left join in_enqm eq on cm.refno=eq.doc_no left join cm_prosclientm pm on (pm.tr_no=eq.cldocno and eq.clientid=2) left join in_srvqotm qm on qm.refdocno=eq.doc_no left join in_endorsement en on cm.doc_no=en.cntrno where 1=1 and cm.voc_no="+docno+"";
				//   System.out.println("sqltst--4->>>"+sqltst);  
				   rs44=cpstmt.executeQuery(sqltst); 
				    while(rs44.next()){    
			    			
				    	
				    	
				       docnoss+=rs44.getString("endno")+",";
		    		   if(!enddocno.contains(rs44.getString("endno"))){
		    			   if(!cpsql.equalsIgnoreCase("")){
				    		   cpsql=cpsql+" union all \n ";
				    	   }
		    			   cpsql=cpsql+" select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("endno")+") and a.dtype in ('END') and a.brhid="+rs44.getString("endbrch")+" and a.clientview=1 ";   
		    		   }
		    		   enddocno+=rs44.getString("endno")+",";
		    		   docnoss+=rs44.getString("insno")+",";
		    		   if(!insdocno.contains(rs44.getString("insno")+",")){
			    		   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("insno")+") and a.dtype in ('INS') and a.brhid="+rs44.getString("cntbrhid")+" and a.clientview=1 ";
					   }
		    		   insdocno+=rs44.getString("insno")+",";
				       //System.out.println("Ddddd"+docnoss);
				       
					   
		    		   docnoss+=rs44.getString("qotno")+",";
		    		   if(!qotdocno.contains(rs44.getString("qotno")+",")){
		    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("qotno")+") and a.dtype in ('SQOT') and a.brhid="+rs44.getString("qotbrhid")+"  and a.clientview=1 ";   
		    		   }
		    		   qotdocno+=rs44.getString("qotno")+",";
					   
		    		   docnoss+=rs44.getString("enqno")+",";
		    		   if(!enqdocno.contains(rs44.getString("enqno")+",")){
		    			   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("enqno")+") and a.dtype in ('ENQ') and a.brhid="+rs44.getString("enqbrhid")+"  and a.clientview=1 ";   
		    		   }
		    		   enqdocno+=rs44.getString("enqno")+",";
					   
	                if(rs44.getString("clientid").equalsIgnoreCase("1")){
		    			   dtypess+="'CRM'";
		    			   if(!crmdocno.contains(rs44.getString("clientid")+",")){
		    				   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('CRM')  and a.clientview=1  ";  
		    			   }
		    			   crmdocno+=rs44.getString("clientid")+",";
	                }else{
		    			   dtypess+="'PPC'";   
		    			   if(ppcdocno.contains(rs44.getString("clientid")+",")){
		    				   cpsql=cpsql+" union all select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type,if(a.clientview=1,'true','false') clientview,a.rowno,a.doc_no from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+rs44.getString("cldocno")+") and a.dtype in ('PPC')  and a.clientview=1  ";   
		    			   }
		    			   ppcdocno+=rs44.getString("clientid")+",";
		    		   }
					    dtypess+="'END'"+",";  
		    		   dtypess+="'INS'"+",";  
					   dtypess+="'SQOT'"+",";
		    		   dtypess+="'ENQ'"+",";
		    		   dtypess+="'CRM'"+",";
		    	     }
		       
		       
		       if(!(docnoss.equalsIgnoreCase("") || dtypess.equalsIgnoreCase(""))){  
		    	  // cpsql="select a.user,a.date,sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no in ("+docnoss+") and a.dtype in ("+dtypess+") "+sqls+" order by sr_no desc"; 
//		    	   System.out.println("cpsql--123->>>"+cpsql);
			       rsattach = cpstmt.executeQuery(cpsql);
		//	       data=objcommon.convertToJSON(resultSet);             
		       }
	    
			int serial=1;
			while(rsattach.next()){
				JSONObject objattach=new JSONObject();
				objattach.put("serial", serial);
				objattach.put("sr_no",rsattach.getString("sr_no"));
				objattach.put("extension", rsattach.getString("extension"));
				objattach.put("description", rsattach.getString("description"));
				objattach.put("filename", rsattach.getString("filename"));
				objattach.put("filepath", rsattach.getString("path"));
				objattach.put("type", rsattach.getString("type"));
				attacharray.add(objattach);
				serial++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return attacharray;
	}
	public int insert(String cmbbranch, String cmbyear, String cmbmonth, ArrayList<String> timesheetarray, HttpSession session, HttpServletRequest request, 
			String mode) throws SQLException {
		
		Connection conn  = null;
		  
		try{
			
			 conn=objconn.getMyConnection();
			 conn.setAutoCommit(false);
			 Statement stmtBHTS = conn.createStatement();
			
			 String branch=session.getAttribute("BRANCHID").toString().trim();
			 String userid=session.getAttribute("USERID").toString().trim();
	        
			 String selectedemployees="";int docno=0;
        	
			 String sql="select coalesce(max(doc_no)+1,1) doc_no from hr_bhts";    
		     ResultSet resultSet = stmtBHTS.executeQuery(sql);
		  
		     while (resultSet.next()) {
		    	  docno=resultSet.getInt("doc_no");
		     }
		     
			 /*Time Sheet Grid Saving*/
				for(int i=0;i< timesheetarray.size();i++){
				CallableStatement stmtBHTS1=null;
				String[] timesheet=timesheetarray.get(i).split("::");
				
				 if(!timesheet[0].equalsIgnoreCase("undefined") && !timesheet[0].equalsIgnoreCase("NaN")){
				 
					 java.sql.Date date=(timesheet[1].trim().equalsIgnoreCase("undefined") || timesheet[1].trim().equalsIgnoreCase("NaN") || timesheet[1].trim().equalsIgnoreCase("") ||  timesheet[1].trim().isEmpty()?null:objcommon.changeStringtoSqlDate(timesheet[1].trim()));
					 
					 if(!(selectedemployees.contains((timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()))) {
						 if(i==0) {
							 selectedemployees = (timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString();
						 } else {
							 selectedemployees += ","+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString();
						 }
					 }
					 
					 String normalTime = (timesheet[4].trim().equalsIgnoreCase("undefined") || timesheet[4].trim().equalsIgnoreCase("NaN") || timesheet[4].trim().equalsIgnoreCase("") || timesheet[4].trim()==null ||timesheet[4].trim().isEmpty()?"0:00":timesheet[4].trim()).toString();
					 String otTime = (timesheet[5].trim().equalsIgnoreCase("undefined") || timesheet[5].trim().equalsIgnoreCase("NaN") || timesheet[5].trim().equalsIgnoreCase("") || timesheet[5].trim()==null ||timesheet[5].trim().isEmpty()?"0:00":timesheet[5].trim()).toString();
					 String hotTime = (timesheet[6].trim().equalsIgnoreCase("undefined") || timesheet[6].trim().equalsIgnoreCase("NaN") || timesheet[6].trim().equalsIgnoreCase("") || timesheet[6].trim()==null ||timesheet[6].trim().isEmpty()?"0:00":timesheet[6].trim()).toString();
					 
					 int normalHourInHour = 0; 
					 int otInHour = 0;
					 int hotInHour = 0;
					 int normalhours=0; //
					 
					 if(!(normalTime.equalsIgnoreCase("null"))) {
						 String[] normalHour=normalTime.split(":");
						 normalHourInHour = (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
						 normalhours= (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
					 } else {
						 normalTime="00:00";
					 }
					 
					 if(!(otTime.equalsIgnoreCase("null"))) {
						 String[] otHour=otTime.split(":");
						 otInHour = (Integer.parseInt(otHour[0]) * 60)+ Integer.parseInt(otHour[1]);
					 } else {
						 otTime="00:00";
					 }
					 
					 if(!(hotTime.equalsIgnoreCase("null"))) {
						 String[] hotHour=hotTime.split(":");
						 hotInHour = (Integer.parseInt(hotHour[0]) * 60)+ Integer.parseInt(hotHour[1]);
					 } else {
						 hotTime="00:00";
					 }
					 
					 /*Holidays & Ramdan Deduction Hrs*/
					 String method="0",ramdanDedHrs="0";
					 int ramdanWhrs=0,actualWhrs=0,ramdanDeduction=0,holidayWorked=0;
					 java.sql.Date sqlHolidayDate=null;
					 
					 String sqls ="select CONCAT(YEAR('"+date+"'),'-',if(LENGTH(MONTH('"+date+"'))=1,CONCAT('0',MONTH('"+date+"')),MONTH('"+date+"')),'-',if(LENGTH(row+1)=1,CONCAT('0',row+1),row+1))  as holidaysofmonth from ( "
							 + "SELECT @row := @row + 1 as row FROM ( select 0 union all select 1 union all select 3 union all select 4 union all select 5 union all select 6) t1, (select 0 union all select 1 union all "
							 + "select 3 union all select 4 union all select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY) between "
							 + "DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH) and LAST_DAY('"+date+"') and DAYOFWEEK(DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY))="
							 + "(if(((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
							 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+")+1)>7,1,"
							 + "((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid where m.status=3 and c.status=3 "
							 + "and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+")+1)))";
					 ResultSet resultSets = stmtBHTS.executeQuery(sqls);
					 while (resultSets.next()) {
						 sqlHolidayDate=resultSets.getDate("holidaysofmonth");
						 if(sqlHolidayDate.compareTo(date) == 0){
							 holidayWorked=1;
							 break;
						 }
						 
						 if(holidayWorked==1){
							 break;
						 }
					 }
					 
					 Statement stmtBHTS2 = conn.createStatement();
					 Statement stmtBHTS3 = conn.createStatement();
					 
					 String sql1="select * from hr_setholidayhrsd where status=3 and date='"+date+"'";
					 ResultSet resultSet1 = stmtBHTS.executeQuery(sql1);
					 while (resultSet1.next()) {
						 holidayWorked=1;
						 String sql2="select * from hr_setholidayhrsm where status=3 and '"+date+"' between fromdate and todate and deduction=1";
						 ResultSet resultSet2 = stmtBHTS2.executeQuery(sql2);
						 while (resultSet2.next()) {
							 ramdanDeduction=1;
							 String sql3="select method,round(value,0) ramdanhrsded from gl_config where field_nme='HRRamdanDedHrs'";
							 ResultSet resultSet3 = stmtBHTS3.executeQuery(sql3);
							 while (resultSet3.next()) {
								 method=resultSet3.getString("method");
								 ramdanDedHrs=resultSet3.getString("ramdanhrsded");
							 }
							 
						 }
				     }
					 
					 /* 
					  * local holiday normal hrs move to holiday overtime
					  */
					 
					 Statement stmtholiday=conn.createStatement();
					 Statement stmtholiday2=conn.createStatement();
					 String sqlholiday="select DAY('"+date+"') day";
					 ResultSet resultSetholiday = stmtholiday.executeQuery(sqlholiday);
					 while (resultSetholiday.next()) {
						 String sqlholiday2="select * from hr_timesheet where empid=102 and date"+resultSetholiday.getString("day")+"=9 and month('"+date+"')=month and year('"+date+"')=YEAR ";
//						 System.out.println("======= "+sqlholiday2);
						 ResultSet resultSetHoliday2 = stmtholiday2.executeQuery(sqlholiday2);
						 while (resultSetHoliday2.next()) {
							 holidayWorked=1;	 
						 }
//						 System.out.println("======= "+holidayWorked);
				     }
					 stmtholiday.close();
					 stmtholiday2.close();
					 
					 
					 /*Ramdan Deduction Hrs*/
					 if(method.equalsIgnoreCase("1") && ramdanDeduction==1){
						 
						 //String sql4s="select ((coalesce(sum(normal),0)+coalesce(sum(ot),0)+coalesce(sum(hot),0))+("+normalHourInHour+")) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						
						 String sql4s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 
						 ResultSet resultSet4s = stmtBHTS.executeQuery(sql4s);
						 while (resultSet4s.next()) {
							 normalHourInHour=resultSet4s.getInt("workedhrs");
						 }
						 
						 String sql4="select ((if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))))-("+ramdanDedHrs+")) ramdanwhrs from "
								 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
								 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet4 = stmtBHTS.executeQuery(sql4);
						 while (resultSet4.next()) {
							 ramdanWhrs=resultSet4.getInt("ramdanwhrs");
						 }
						 
						 if(holidayWorked==1) {
							 
							 if(normalHourInHour>ramdanWhrs){
								 otInHour=normalHourInHour-ramdanWhrs;
								 int hours = otInHour / 60;
								 int minutes = otInHour % 60;
								 /*otTime=hours+":"+minutes;*/
								 otTime=hours+":"+String.format("%02d", minutes);  
							 }
						 } else {
							 
							 if(normalHourInHour>ramdanWhrs){
								 hotInHour=normalHourInHour-ramdanWhrs;
								 int hours = hotInHour / 60;
								 int minutes = hotInHour % 60;
								 //hotTime=hours+":"+minutes;
								 hotTime=hours+":"+String.format("%02d", minutes);
							 }
							 
						 }
						 
					 }
					 /*Ramdan Deduction Hrs Ends*/
					 
					 /*Holiday Hrs*/
					 if(holidayWorked==1 && ramdanDeduction==0) {
						 
						 String sql5s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet5s = stmtBHTS.executeQuery(sql5s);
						 while (resultSet5s.next()) {
							 normalHourInHour=resultSet5s.getInt("workedhrs");
						 }
						 
						 String sql5="select if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))) whrs from "
								 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
								 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet5 = stmtBHTS.executeQuery(sql5);
						 while (resultSet5.next()) {
							 actualWhrs=resultSet5.getInt("whrs");
						 }
						 
						 hotInHour=normalHourInHour;
						 int hours = hotInHour / 60;
						 int minutes = hotInHour % 60;
						 //hotTime=hours+":"+minutes;
						hotTime=hours+":"+String.format("%02d", minutes);
						 
						 
					 }
					 /*Holiday Hrs*/
					 
					 /*Over Time Hrs*/
					 if(holidayWorked==0 && ramdanDeduction==0) {
						 
						 String sql6s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet6s = stmtBHTS.executeQuery(sql6s);
						 while (resultSet6s.next()) {
							 normalHourInHour=resultSet6s.getInt("workedhrs");
						 }
						 
						 String sql6="select if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))) whrs from "
								 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
								 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet6 = stmtBHTS.executeQuery(sql6);
						 while (resultSet6.next()) {
							 actualWhrs=resultSet6.getInt("whrs");
						 }
						   
						 if(normalHourInHour>actualWhrs){
							 otInHour=normalHourInHour-actualWhrs;
							 int hours = otInHour / 60;
							 int minutes = otInHour % 60;
							 /*otTime=hours+":"+minutes;*/
							 otTime=hours+":"+String.format("%02d", minutes);
						 }
						 
					 }
					 /*Over Time Hrs*/
					 
					 stmtBHTS1 = conn.prepareCall("INSERT INTO hr_timesheethrs(date, empid, costtype, costcode, normalhrs, othrs, hothrs, normal, ot, hot, intime, outtime, costperhour, status) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						
					 stmtBHTS1.setDate(1,date);
					 stmtBHTS1.setString(2,(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString());
					 stmtBHTS1.setString(3,(timesheet[2].trim().equalsIgnoreCase("undefined") || timesheet[2].trim().equalsIgnoreCase("NaN") || timesheet[2].trim().equalsIgnoreCase("") ||timesheet[2].trim().isEmpty()?"0":timesheet[2].trim()).toString());
					 stmtBHTS1.setString(4,(timesheet[3].trim().equalsIgnoreCase("undefined") || timesheet[3].trim().equalsIgnoreCase("NaN") || timesheet[3].trim().equalsIgnoreCase("") ||timesheet[3].trim().isEmpty()?"0":timesheet[3].trim()).toString());
					 stmtBHTS1.setString(5,normalTime);
					 stmtBHTS1.setString(6,otTime);
					 stmtBHTS1.setString(7,hotTime);
					 stmtBHTS1.setInt(8,normalhours);
					 stmtBHTS1.setInt(9,otInHour);
					 stmtBHTS1.setInt(10,hotInHour);
					 stmtBHTS1.setString(11, (timesheet[7].trim().equalsIgnoreCase("undefined") || timesheet[7].trim().equalsIgnoreCase("NaN") || timesheet[7].trim().equalsIgnoreCase("") || timesheet[7].trim()==null ||timesheet[7].trim().isEmpty()?"00:00":timesheet[7].trim()).toString());
					 stmtBHTS1.setString(12, (timesheet[8].trim().equalsIgnoreCase("undefined") || timesheet[8].trim().equalsIgnoreCase("NaN") || timesheet[8].trim().equalsIgnoreCase("") || timesheet[8].trim()==null ||timesheet[8].trim().isEmpty()?"":timesheet[8].trim()).toString());
					 stmtBHTS1.setString(13,(timesheet[9].trim().equalsIgnoreCase("undefined") || timesheet[9].trim().equalsIgnoreCase("NaN") || timesheet[9].trim().equalsIgnoreCase("") ||timesheet[9].trim().isEmpty()?"0.00":timesheet[9].trim()).toString());
					 stmtBHTS1.setString(14,"3");
				     System.out.println("==== "+stmtBHTS1);
					 int data = stmtBHTS1.executeUpdate();
					 if(data<=0){
						stmtBHTS.close();
						conn.close();
						return 0;
					 }
					 
					 stmtBHTS2.close();
					 stmtBHTS3.close();
				}
				 
			}
				
			/*Inserting hr_bhts*/
		     String sql2="insert into hr_bhts(doc_no, date, employeeIds, brhid, userid) values('"+docno+"',now(),'"+selectedemployees+"','"+branch+"','"+userid+"')";
		     int data1= stmtBHTS.executeUpdate(sql2);
			 if(data1<=0){
				    stmtBHTS.close();
					conn.close();
					return 0;
				}
			 /*Inserting hr_bhts Ends*/
				 
			 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ('"+docno+"','"+branch+"','BHTS',now(),'"+userid+"','A')";
			 int datas= stmtBHTS.executeUpdate(sqls);
			 if(datas<=0){
				 	stmtBHTS.close();
				    conn.close();
					return 0;
				}
			conn.commit();
			stmtBHTS.close();
			conn.close();
			return docno;
		
	 } catch(Exception e){	
		 	conn.close();
		 	e.printStackTrace();	
		 	return 0;
	 } finally{
		 conn.close();
	 }
	}
	public int edit(String tsrowno,String cmbbranch, String cmbyear, String cmbmonth, ArrayList<String> timesheetarray, HttpSession session, HttpServletRequest request, 
			String mode) throws SQLException {              
		
		Connection conn  = null;
		  
		try{
			int docno=0;
			 conn=objconn.getMyConnection();
			 conn.setAutoCommit(false);
			 Statement stmtBHTS = conn.createStatement();
			
			 String branch=session.getAttribute("BRANCHID").toString().trim();
			 String userid=session.getAttribute("USERID").toString().trim();
	        
			 String selectedemployees="";        
        	
		     
			 /*Time Sheet Grid Saving*/
				for(int i=0;i< timesheetarray.size();i++){
				CallableStatement stmtBHTS1=null;
				String[] timesheet=timesheetarray.get(i).split("::");
				
				 if(!timesheet[0].equalsIgnoreCase("undefined") && !timesheet[0].equalsIgnoreCase("NaN")){
				 
					 java.sql.Date date=(timesheet[1].trim().equalsIgnoreCase("undefined") || timesheet[1].trim().equalsIgnoreCase("NaN") || timesheet[1].trim().equalsIgnoreCase("") ||  timesheet[1].trim().isEmpty()?null:objcommon.changeStringtoSqlDate(timesheet[1].trim()));
					 
					 if(!(selectedemployees.contains((timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()))) {
						 if(i==0) {
							 selectedemployees = (timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString();
						 } else {
							 selectedemployees += ","+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString();
						 }
					 }
					 
					 String normalTime = (timesheet[4].trim().equalsIgnoreCase("undefined") || timesheet[4].trim().equalsIgnoreCase("NaN") || timesheet[4].trim().equalsIgnoreCase("") || timesheet[4].trim()==null ||timesheet[4].trim().isEmpty()?"0:00":timesheet[4].trim()).toString();
					 String otTime = (timesheet[5].trim().equalsIgnoreCase("undefined") || timesheet[5].trim().equalsIgnoreCase("NaN") || timesheet[5].trim().equalsIgnoreCase("") || timesheet[5].trim()==null ||timesheet[5].trim().isEmpty()?"0:00":timesheet[5].trim()).toString();
					 String hotTime = (timesheet[6].trim().equalsIgnoreCase("undefined") || timesheet[6].trim().equalsIgnoreCase("NaN") || timesheet[6].trim().equalsIgnoreCase("") || timesheet[6].trim()==null ||timesheet[6].trim().isEmpty()?"0:00":timesheet[6].trim()).toString();
					 
					 int normalHourInHour = 0; 
					 int otInHour = 0;
					 int hotInHour = 0;
					 int normalhours=0; //
					 
					 if(!(normalTime.equalsIgnoreCase("null"))) {
						 String[] normalHour=normalTime.split(":");
						 normalHourInHour = (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
						 normalhours= (Integer.parseInt(normalHour[0]) * 60)+ Integer.parseInt(normalHour[1]);
					 } else {
						 normalTime="00:00";
					 }
					 
					 if(!(otTime.equalsIgnoreCase("null"))) {
						 String[] otHour=otTime.split(":");
						 otInHour = (Integer.parseInt(otHour[0]) * 60)+ Integer.parseInt(otHour[1]);
					 } else {
						 otTime="00:00";
					 }
					 
					 if(!(hotTime.equalsIgnoreCase("null"))) {
						 String[] hotHour=hotTime.split(":");
						 hotInHour = (Integer.parseInt(hotHour[0]) * 60)+ Integer.parseInt(hotHour[1]);
					 } else {
						 hotTime="00:00";
					 }
					 
					 /*Holidays & Ramdan Deduction Hrs*/
					 String method="0",ramdanDedHrs="0";
					 int ramdanWhrs=0,actualWhrs=0,ramdanDeduction=0,holidayWorked=0;
					 java.sql.Date sqlHolidayDate=null;
					 
					 String sqls ="select CONCAT(YEAR('"+date+"'),'-',if(LENGTH(MONTH('"+date+"'))=1,CONCAT('0',MONTH('"+date+"')),MONTH('"+date+"')),'-',if(LENGTH(row+1)=1,CONCAT('0',row+1),row+1))  as holidaysofmonth from ( "
							 + "SELECT @row := @row + 1 as row FROM ( select 0 union all select 1 union all select 3 union all select 4 union all select 5 union all select 6) t1, (select 0 union all select 1 union all "
							 + "select 3 union all select 4 union all select 5 union all select 6) t2,(SELECT @row:=-1) t3 limit 31 ) b where DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY) between "
							 + "DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH) and LAST_DAY('"+date+"') and DAYOFWEEK(DATE_ADD(DATE_ADD(DATE_ADD(LAST_DAY('"+date+"'),INTERVAL 1 DAY),INTERVAL -1 MONTH), INTERVAL ROW DAY))="
							 + "(if(((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
							 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+")+1)>7,1,"
							 + "((select c.woff from hr_empm m left join (select max(doc_no) doc_no ,catid,woff,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid where m.status=3 and c.status=3 "
							 + "and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+")+1)))";
					 ResultSet resultSets = stmtBHTS.executeQuery(sqls);
					 while (resultSets.next()) {
						 sqlHolidayDate=resultSets.getDate("holidaysofmonth");
						 if(sqlHolidayDate.compareTo(date) == 0){
							 holidayWorked=1;
							 break;
						 }
						 
						 if(holidayWorked==1){
							 break;
						 }
					 }
					 
					 Statement stmtBHTS2 = conn.createStatement();
					 Statement stmtBHTS3 = conn.createStatement();
					 
					 String sql1="select * from hr_setholidayhrsd where status=3 and date='"+date+"'";
					 ResultSet resultSet1 = stmtBHTS.executeQuery(sql1);
					 while (resultSet1.next()) {
						 holidayWorked=1;
						 String sql2="select * from hr_setholidayhrsm where status=3 and '"+date+"' between fromdate and todate and deduction=1";
						 ResultSet resultSet2 = stmtBHTS2.executeQuery(sql2);
						 while (resultSet2.next()) {
							 ramdanDeduction=1;
							 String sql3="select method,round(value,0) ramdanhrsded from gl_config where field_nme='HRRamdanDedHrs'";
							 ResultSet resultSet3 = stmtBHTS3.executeQuery(sql3);
							 while (resultSet3.next()) {
								 method=resultSet3.getString("method");
								 ramdanDedHrs=resultSet3.getString("ramdanhrsded");
							 }
							 
						 }
				     }
					 
					 /* 
					  * local holiday normal hrs move to holiday overtime
					  */
					 
					 Statement stmtholiday=conn.createStatement();
					 Statement stmtholiday2=conn.createStatement();
					 String sqlholiday="select DAY('"+date+"') day";
					 ResultSet resultSetholiday = stmtholiday.executeQuery(sqlholiday);
					 while (resultSetholiday.next()) {
						 String sqlholiday2="select * from hr_timesheet where empid=102 and date"+resultSetholiday.getString("day")+"=9 and month('"+date+"')=month and year('"+date+"')=YEAR ";
//						 System.out.println("======= "+sqlholiday2);
						 ResultSet resultSetHoliday2 = stmtholiday2.executeQuery(sqlholiday2);
						 while (resultSetHoliday2.next()) {
							 holidayWorked=1;	 
						 }
//						 System.out.println("======= "+holidayWorked);
				     }
					 stmtholiday.close();
					 stmtholiday2.close();
					 
					 
					 /*Ramdan Deduction Hrs*/
					 if(method.equalsIgnoreCase("1") && ramdanDeduction==1){
						 
						 //String sql4s="select ((coalesce(sum(normal),0)+coalesce(sum(ot),0)+coalesce(sum(hot),0))+("+normalHourInHour+")) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						
						 String sql4s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 
						 ResultSet resultSet4s = stmtBHTS.executeQuery(sql4s);
						 while (resultSet4s.next()) {
							 normalHourInHour=resultSet4s.getInt("workedhrs");
						 }
						 
						 String sql4="select ((if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))))-("+ramdanDedHrs+")) ramdanwhrs from "
								 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
								 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet4 = stmtBHTS.executeQuery(sql4);
						 while (resultSet4.next()) {
							 ramdanWhrs=resultSet4.getInt("ramdanwhrs");
						 }
						 
						 if(holidayWorked==1) {
							 
							 if(normalHourInHour>ramdanWhrs){
								 otInHour=normalHourInHour-ramdanWhrs;
								 int hours = otInHour / 60;
								 int minutes = otInHour % 60;
								 /*otTime=hours+":"+minutes;*/
								 otTime=hours+":"+String.format("%02d", minutes);  
							 }
						 } else {
							 
							 if(normalHourInHour>ramdanWhrs){
								 hotInHour=normalHourInHour-ramdanWhrs;
								 int hours = hotInHour / 60;
								 int minutes = hotInHour % 60;
								 //hotTime=hours+":"+minutes;
								 hotTime=hours+":"+String.format("%02d", minutes);
							 }
							 
						 }
						 
					 }
					 /*Ramdan Deduction Hrs Ends*/
					 
					 /*Holiday Hrs*/
					 if(holidayWorked==1 && ramdanDeduction==0) {
						 
						 String sql5s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet5s = stmtBHTS.executeQuery(sql5s);
						 while (resultSet5s.next()) {
							 normalHourInHour=resultSet5s.getInt("workedhrs");
						 }
						 
						 String sql5="select if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))) whrs from "
								 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
								 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet5 = stmtBHTS.executeQuery(sql5);
						 while (resultSet5.next()) {
							 actualWhrs=resultSet5.getInt("whrs");
						 }
						 
						 hotInHour=normalHourInHour;
						 int hours = hotInHour / 60;
						 int minutes = hotInHour % 60;
						 //hotTime=hours+":"+minutes;
						hotTime=hours+":"+String.format("%02d", minutes);
						 
						 
					 }
					 /*Holiday Hrs*/
					 
					 /*Over Time Hrs*/
					 if(holidayWorked==0 && ramdanDeduction==0) {
						 
						 String sql6s="select ((coalesce(sum(normal),0)+("+normalHourInHour+")-(coalesce(sum(ot),0)+coalesce(sum(hot),0)))) workedhrs from hr_timesheethrs where status=3 and date='"+date+"' and empid="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet6s = stmtBHTS.executeQuery(sql6s);
						 while (resultSet6s.next()) {
							 normalHourInHour=resultSet6s.getInt("workedhrs");
						 }
						 
						 String sql6="select if(((((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1))))=0,0,(((SUBSTRING_INDEX(c.whrs,':',1))*60)+(SUBSTRING_INDEX(c.whrs,':',-1)))) whrs from "
								 + "hr_empm m left join (select max(doc_no) doc_no ,catid,whrs,status,timesheet from hr_paycode where revdate<='"+date+"' and status=3 and timesheet=1 group by catid) c on  c.catid=m.pay_catid "
								 + "where m.status=3 and c.status=3 and c.timesheet=1 and m.doc_no="+(timesheet[0].trim().equalsIgnoreCase("undefined") || timesheet[0].trim().equalsIgnoreCase("NaN") || timesheet[0].trim().equalsIgnoreCase("") ||timesheet[0].trim().isEmpty()?"0":timesheet[0].trim()).toString()+"";
						 ResultSet resultSet6 = stmtBHTS.executeQuery(sql6);
						 while (resultSet6.next()) {
							 actualWhrs=resultSet6.getInt("whrs");
						 }
						   
						 if(normalHourInHour>actualWhrs){
							 otInHour=normalHourInHour-actualWhrs;
							 int hours = otInHour / 60;
							 int minutes = otInHour % 60;
							 /*otTime=hours+":"+minutes;*/
							 otTime=hours+":"+String.format("%02d", minutes);
						 }
						 
					 }
					 /*Over Time Hrs*/
					 String mrowarray[]=tsrowno.split(",");          
						for(int k=0;k<mrowarray.length;k++){          
							 stmtBHTS1 = conn.prepareCall("update hr_timesheethrs set  normalhrs=?, othrs=?, hothrs=?, normal=?, ot=?, hot=?, intime=?, outtime=?, costperhour=? where  rowno="+mrowarray[k]+"");           
								
							 stmtBHTS1.setString(1,normalTime);
							 stmtBHTS1.setString(2,otTime);
							 stmtBHTS1.setString(3,hotTime);
							 stmtBHTS1.setInt(4,normalhours);
							 stmtBHTS1.setInt(5,otInHour);
							 stmtBHTS1.setInt(6,hotInHour);
							 stmtBHTS1.setString(7, (timesheet[7].trim().equalsIgnoreCase("undefined") || timesheet[7].trim().equalsIgnoreCase("NaN") || timesheet[7].trim().equalsIgnoreCase("") || timesheet[7].trim()==null ||timesheet[7].trim().isEmpty()?"00:00":timesheet[7].trim()).toString());
							 stmtBHTS1.setString(8, (timesheet[8].trim().equalsIgnoreCase("undefined") || timesheet[8].trim().equalsIgnoreCase("NaN") || timesheet[8].trim().equalsIgnoreCase("") || timesheet[8].trim()==null ||timesheet[8].trim().isEmpty()?"00:00":timesheet[8].trim()).toString());
							 stmtBHTS1.setString(9,(timesheet[9].trim().equalsIgnoreCase("undefined") || timesheet[9].trim().equalsIgnoreCase("NaN") || timesheet[9].trim().equalsIgnoreCase("") ||timesheet[9].trim().isEmpty()?"0.00":timesheet[9].trim()).toString());
							 System.out.println(stmtBHTS1);
							        
						     int data = stmtBHTS1.executeUpdate();
						     if(data>0){
						    	 docno=1;
						     }
							 if(data<=0){
								stmtBHTS.close();
								conn.close();
								return 0;
							 }	
						}
					 stmtBHTS2.close();
					 stmtBHTS3.close();
				}
				 
			}
				
			/*Inserting hr_bhts*/
		     /*String sql2="insert into hr_bhts(doc_no, date, employeeIds, brhid, userid) values('"+docno+"',now(),'"+selectedemployees+"','"+branch+"','"+userid+"')";
		     int data1= stmtBHTS.executeUpdate(sql2);
			 if(data1<=0){
				    stmtBHTS.close();
					conn.close();
					return 0;
				}*/           
			 /*Inserting hr_bhts Ends*/
			String rownoarray[]=tsrowno.split(",");          
			for(int i=0;i<rownoarray.length;i++){    
				 String sqls="insert into gl_biblog (doc_no, brhId, dtype, edate, userId, ENTRY) values ("+rownoarray[i]+",'"+branch+"','BHTS',now(),'"+userid+"','E')";
				 int datas= stmtBHTS.executeUpdate(sqls);   
				 if(datas<=0){
					 	stmtBHTS.close();
					    conn.close();
						return 0;
				}	
			}
			conn.commit();
			stmtBHTS.close();
			conn.close();
			return docno;   
		
	 } catch(Exception e){	
		 	conn.close();
		 	e.printStackTrace();	
		 	return 0;
	 } finally{
		 conn.close();
	 }
	}
	
	// ABZ reports 

	public JSONArray getPLReport(String month, String Year,Connection conn){
		JSONArray plarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1;
            String empid="0",docno="0";
            ArrayList<String> dbarray=new ArrayList<>();
            
            String sql1="SELECT compname,dbname  FROM intercompany.my_intrcomp m";
            //System.out.println("sql1--->>>"+sql1);        
			ResultSet rs1=stmt.executeQuery(sql1);
			while(rs1.next()){
				   dbarray.add(rs1.getString("compname")+"::"+rs1.getString("dbname"));
			}
			 for(int i=0;i<dbarray.size();i++){
         		String dname=dbarray.get(i).toString().split("::")[1];
         	String cmpname=dbarray.get(i).toString().split("::")[0];
         	String sqlpl="select format(round(sum(if(month(j.date)="+month+",drAmount,0))*-1,2),2) tot,format(round(sum(drAmount)*-1,2),2) ytot from "+dname+".my_jvtran j inner join "+dname+".my_head h on j.acno=h.doc_no and h.gr_type in (4,5) where j.status=3 and month(j.date)<="+month+" and year(j.date)="+Year;
         	
         	ResultSet rspl=stmt.executeQuery(sqlpl);
            	while(rspl.next()){
            		JSONObject objsub=new JSONObject();    
    				objsub.put("cmpname", cmpname);
    				objsub.put("total", rspl.getString("tot"));
    				objsub.put("ytotal", rspl.getString("ytot"));
    				plarray.add(objsub); 
            		
            	}
            }
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return plarray;
	}
	

	public JSONArray getMISReport(String month, String Year,Connection conn){
		JSONArray plarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1;
            String empid="0",docno="0";
            ArrayList<String> dbarray=new ArrayList<>();
            
            String sql1="SELECT compname,dbname  FROM intercompany.my_intrcomp m";
            //System.out.println("sql1--->>>"+sql1);        
			ResultSet rs1=stmt.executeQuery(sql1);
			while(rs1.next()){
				   dbarray.add(rs1.getString("compname")+"::"+rs1.getString("dbname"));
			}
			 for(int i=0;i<dbarray.size();i++){
         		String dname=dbarray.get(i).toString().split("::")[1];
         	String cmpname=dbarray.get(i).toString().split("::")[0];
         	String sqlpl="select format(round(sum(if(den=340,drAmount,0)),2),2)  receivable, format(round(sum(if(den=604,drAmount,0)),2),2) cash,format(round(sum(if(den=305,drAmount,0)),2),2) bank, format(round(sum(if(gp_pr=11,drAmount,0)),2),2) FixedAssets, format(round(sum(if(gp_pr=12,drAmount,0)),2),2) CurrentAssets, format(round(sum(if(gp_pr=13,drAmount,0)),2),2) CurrentLiabilities, format(round(sum(if(den=255,drAmount,0)),2),2) Creditors, format(round(sum(if(grpno=5486,drAmount,0)),2),2) Intercompany from "+dname+".my_jvtran j inner join "+dname+".my_head h on j.acno=h.doc_no left join "+dname+".my_agrp a on a.fi_id=h.den left join "+dname+".gc_agrpd g on g.gp_id=a.gp_pr  where j.status=3 and month(j.date)="+month+" and year(j.date)="+Year;
         	
         	ResultSet rspl=stmt.executeQuery(sqlpl);
            	while(rspl.next()){
            		JSONObject objsub=new JSONObject();    
    				objsub.put("cmpname", cmpname);
    				objsub.put("receivable", rspl.getString("receivable"));
    				objsub.put("cash", rspl.getString("cash"));
					objsub.put("bank", rspl.getString("bank"));
    				objsub.put("FixedAssets", rspl.getString("FixedAssets"));
					objsub.put("CurrentAssets", rspl.getString("CurrentAssets"));
    				objsub.put("CurrentLiabilities", rspl.getString("CurrentLiabilities"));
					objsub.put("Creditors", rspl.getString("Creditors"));
    				objsub.put("Intercompany", rspl.getString("Intercompany"));
    				plarray.add(objsub); 
            		
            	}
            }
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return plarray;
	}

	public JSONArray getPLAnalaysis(String month, String Year,Connection conn){
		JSONArray plarray=new JSONArray();
		try{
			Statement stmt=conn.createStatement();
            int srno=1;
            String empid="0",docno="0";
            ArrayList<String> dbarray=new ArrayList<>();
            
            String sql1="SELECT compname,dbname  FROM intercompany.my_intrcomp m";
            //System.out.println("sql1--->>>"+sql1);        
			ResultSet rs1=stmt.executeQuery(sql1);
			while(rs1.next()){
				   dbarray.add(rs1.getString("compname")+"::"+rs1.getString("dbname"));
			}
			 for(int i=0;i<dbarray.size();i++){
         		String dname=dbarray.get(i).toString().split("::")[1];
         	String cmpname=dbarray.get(i).toString().split("::")[0];
         	String sqlpl="select format(round(sum(if(den=110,drAmount,0)),2),2)  revenue, format(round(sum(if(h.gr_type=4,drAmount,0)),2),2) cost, format(round(sum(if(den=135,drAmount,0)),2),2) OtherIncome  from "+dname+".my_jvtran j inner join "+dname+".my_head h on j.acno=h.doc_no left join "+dname+".my_agrp a on a.fi_id=h.den left join "+dname+".gc_agrpd g on g.gp_id=a.gp_pr  where j.status=3 and month(j.date)="+month+" and year(j.date)="+Year;
			
        	
        	System.out.println("sql1--->>>"+sqlpl);    
			ResultSet rspl=stmt.executeQuery(sqlpl);
        	while(rspl.next()){
        		JSONObject objsub=new JSONObject();    
				objsub.put("cmpname", cmpname);
				objsub.put("revenue", rspl.getString("revenue"));
				objsub.put("cost", rspl.getString("cost"));
				objsub.put("OtherIncome", rspl.getString("OtherIncome"));
				
				plarray.add(objsub); 
        		
        	}
            }
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return plarray;
	}

	public JSONArray getIncome(String month, String Year,Connection conn){
		JSONArray plarray=new JSONArray();
		JSONArray subarray=new JSONArray();
		
		try{
			Statement stmt=conn.createStatement();
            int srno=1;
            String empid="0",docno="0";
            
            ArrayList<String> dbarray=new ArrayList<>();
            
            String sql1="SELECT compname,dbname  FROM intercompany.my_intrcomp m";
            //System.out.println("sql1--->>>"+sql1);        
			ResultSet rs1=stmt.executeQuery(sql1);
			while(rs1.next()){
				   dbarray.add(rs1.getString("compname")+"::"+rs1.getString("dbname"));
			}
			 
			String sqlmain=" select a0.description,a0.doc_no ";
			String sqlinner=" ";
			String sqltot=" ";
			int cnt=0;
            for(int i=0;i<dbarray.size();i++){
            		String dname=dbarray.get(i).toString().split("::")[1];
					String cmpname=dbarray.get(i).toString().split("::")[0];
				if(i==0){
					sqlinner+=" (select '"+cmpname+"' cmpname"+i+",round(sum(drAmount),2) tot"+i+",h.description,h.doc_no  from "+dname+".my_jvtran j inner join "+dname+".my_head h on j.acno=h.doc_no where j.status=3  and gr_type=5 and month(j.date)="+month+" and year(j.date)="+Year+" group by acno order by acno) a"+i ;
				}else {
					sqlinner+=" left join (select  '"+cmpname+"' cmpname"+i+",round(sum(drAmount),2) tot"+i+",h.description, h.doc_no  from "+dname+".my_jvtran j inner join "+dname+".my_head h on j.acno=h.doc_no where j.status=3  and gr_type=5 and month(j.date)="+month+" and year(j.date)="+Year+" group by acno order by acno) a"+i+" on a"+i+".doc_no=a0.doc_no " ;

				}
				sqlmain+=" , coalesce(a"+i+".tot"+i+",0) a"+i+"tot, a"+i+".cmpname"+i+" ";
				sqltot+="  coalesce(a"+i+".tot"+i+",0) +";
				cnt++;
            }	
			sqlmain =sqlmain+" , " +sqltot.substring(1,sqltot.length()-1)+" total from "+ sqlinner +" ";
            	System.out.println("sql1--->>>"+sqlmain);    
				ResultSet rspl=stmt.executeQuery(sqlmain);
            	while(rspl.next()){
            		JSONObject objsub=new JSONObject();    
					objsub.put("description", rspl.getString("description"));
					objsub.put("total", objcommon.format(rspl.getString("total"),conn));
					for(int j=0;j<cnt;j++){
						JSONObject objsub1=new JSONObject();   
    				//objsub1.put("cmpname"+j, rspl.getString("cmpname"+j));
					objsub1.put("cmpname"+j, dbarray.get(j).toString().split("::")[0]);
    				objsub1.put("tot"+j, objcommon.format(rspl.getString("a"+j+"tot"),conn));
					subarray.add(objsub1); 
					
					}
    				objsub.put("comparray", subarray);
    				plarray.add(objsub); 
            		subarray=new JSONArray();
            	}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return plarray;
	}

	public JSONArray getExpense(String month, String Year,Connection conn){
		JSONArray plarray=new JSONArray();
		JSONArray subarray=new JSONArray();
		
		try{
			Statement stmt=conn.createStatement();
            int srno=1;
            String empid="0",docno="0";
            
            ArrayList<String> dbarray=new ArrayList<>();
            
            String sql1="SELECT compname,dbname  FROM intercompany.my_intrcomp m";
            //System.out.println("sql1--->>>"+sql1);        
			ResultSet rs1=stmt.executeQuery(sql1);
			while(rs1.next()){
				   dbarray.add(rs1.getString("compname")+"::"+rs1.getString("dbname"));
			}
			 
			String sqlmain=" select a0.description,a0.doc_no ";
			String sqlinner=" ";
			String sqltot=" ";
			int cnt=0;
            for(int i=0;i<dbarray.size();i++){
            		String dname=dbarray.get(i).toString().split("::")[1];
					String cmpname=dbarray.get(i).toString().split("::")[0];
				if(i==0){
					sqlinner+=" (select '"+cmpname+"' cmpname"+i+",round(sum(drAmount),2) tot"+i+",h.description,h.doc_no  from "+dname+".my_jvtran j inner join "+dname+".my_head h on j.acno=h.doc_no where j.status=3  and gr_type=4 and month(j.date)="+month+" and year(j.date)="+Year+" group by acno order by acno) a"+i ;
				}else {
					sqlinner+=" left join (select  '"+cmpname+"' cmpname"+i+",round(sum(drAmount),2) tot"+i+",h.description, h.doc_no  from "+dname+".my_jvtran j inner join "+dname+".my_head h on j.acno=h.doc_no where j.status=3  and gr_type=4 and month(j.date)="+month+" and year(j.date)="+Year+" group by acno order by acno) a"+i+" on a"+i+".doc_no=a0.doc_no " ;

				}
				sqlmain+=" , coalesce(a"+i+".tot"+i+",0) a"+i+"tot, a"+i+".cmpname"+i+" ";
				sqltot+="  coalesce(a"+i+".tot"+i+",0) +";
				cnt++;
            }	
			sqlmain =sqlmain+" , " +sqltot.substring(1,sqltot.length()-1)+" total from "+ sqlinner +" ";
            	System.out.println("sql1--->>>"+sqlmain);    
				ResultSet rspl=stmt.executeQuery(sqlmain);
            	while(rspl.next()){
            		JSONObject objsub=new JSONObject();    
					objsub.put("description", rspl.getString("description"));
					objsub.put("total", objcommon.format(rspl.getString("total"),conn));
					for(int j=0;j<cnt;j++){
						JSONObject objsub1=new JSONObject();   
    				//objsub1.put("cmpname"+j, rspl.getString("cmpname"+j));
					objsub1.put("cmpname"+j, dbarray.get(j).toString().split("::")[0]);
    				objsub1.put("tot"+j, objcommon.format(rspl.getString("a"+j+"tot"),conn));
					subarray.add(objsub1); 
					
					}
    				objsub.put("comparray", subarray);
    				plarray.add(objsub); 
            		subarray=new JSONArray();
            	}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return plarray;
	}

}
