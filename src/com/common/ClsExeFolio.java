package com.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.connection.ClsConnection;
import com.dashboard.ClsDashBoardBean;
import com.mailwithpdf.EmailProcess;
import com.emailnew.EmailUtility;

public class ClsExeFolio {

	ClsConnection ClsConnection=new ClsConnection();

	public  JSONArray exefolioGridload(HttpSession session) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		ClsCommon ClsCommon=new ClsCommon();
		Connection conn =null;
		try {

			String userid=session.getAttribute("USERID").toString();

			conn = ClsConnection.getMyConnection();
			Statement cpstmt = conn.createStatement();

			String  cpsql="select (@n := @n + 1) as flag,status,coalesce(xnew,0) approval,'' general,coalesce(userId,0) as userId from "
					+ "(Select 'New' as status,sum(if(date(t.sub_Date)=date(now()) and t.approved=0  ,1,0)) xnew,t.userId"
					+ " from my_exeb t where  t.approved=0 and t.userId='"+userid+"' union all Select 'Pending'as status,"
					+ " sum(if(date(t.sub_Date)!=date(now()) and t.approved=0,1,0)) xnew,t.userId "
					+ "from my_exeb t where   t.approved!=0 and t.userId='"+userid+"' union all Select 'P-Cycle'as status,"
					+ " sum(if(t.apprStatus!=0 and t.apprlevel!=0 ,1,0)) xnew,t.userId from my_exdet t where   t.userId='"+userid+"' "
					+ "union all Select 'No Of Messages'as status, sum(1) xnew,t.userId from my_exdet t where  t.apprlevel!=0 and t.userId='"+userid+"') as a,"
					+ "(select @n:=0) srno  group by status order by flag";

//System.out.println("=== "+cpsql);
			ResultSet resultSet = cpstmt.executeQuery(cpsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			cpstmt.close();

		}
		catch(Exception e){
			e.printStackTrace();
		}finally{
			conn.close();
		}

		return RESULTDATA;
	}



	public  JSONArray approvalGridload(HttpSession session,String dtype,String branch,String docno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		ClsCommon ClsCommon=new ClsCommon();
		try {

			String userid=session.getAttribute("USERID").toString();

			Connection conn = ClsConnection.getMyConnection();
			Statement cpstmt = conn.createStatement();


			String cpsql="SELECT * FROM (SELECT m.doc_no,m.dtype,m.userid,m.apprdate,m.apprstatus,m.remarks,m.finstatus,m.tsr_no sr_no,m.apprlevel, "
					+ "m.subdate,m.subby, CASE WHEN m.apprStatus=5 THEN 'Forwarded By' WHEN m.apprStatus=3 THEN 'Approved By' WHEN m.apprStatus=2 THEN 'Returned By' WHEN m.apprStatus=4 THEN 'Rejected By' WHEN m.apprStatus=1 THEN 'Submitted By' WHEN m.apprStatus=9 THEN 'Returned Records' WHEN m.apprStatus=8 THEN 'Old Records' ELSE 'Send To' END AS apprtype, "
					+ "CONVERT(CONCAT(DAY(m.apprDate),'/',MONTH(m.apprDate),'/',YEAR(m.apprDate),' ',TIME(m.apprDate)),CHAR(50)) apprDateTime, "
					+ "u.user_name FROM my_exdet m LEFT JOIN my_user u ON m.userId=u.doc_no WHERE m.dtype='"+dtype+"' AND m.brhId="+branch+" AND m.doc_no='"+docno+"' "
					+ "union all SELECT m.doc_no,m.dtype,m.userid,sub_date apprdate,0 apprstatus,m.desc1 remarks,0  finstatus,m.sr_no,m.apprlevel,m.sub_date subdate,0 subby, "
					+ "' Send To ' apprtype,''  apprDateTime,u.user_name FROM my_exeb m LEFT JOIN my_user u ON m.userId=u.doc_no WHERE m.dtype='"+dtype+"' AND m.brhId="+branch+" AND m.doc_no='"+docno+"')a ORDER BY apprdate DESC";
			
			System.out.println("==Approval=="+cpsql);  
			ResultSet resultSet = cpstmt.executeQuery(cpsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			cpstmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return RESULTDATA;
	}

	public  JSONArray ApprovalStatus() throws SQLException {
		List<ClsDashBoardBean> fleetStatusBean = new ArrayList<ClsDashBoardBean>();

		JSONArray RESULTDATA=new JSONArray();
		ClsCommon ClsCommon=new ClsCommon();
		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtDashBoard6 = conn.createStatement ();

			/*ResultSet resultSet6 = stmtDashBoard6.executeQuery ("select round(aa.val/bb.val *100,2) per,aa.tran_code from (select count(*) val,tran_code from gl_vehmaster vm  group by vm.tran_code )aa,"
						+ "(select count(*) val,tran_code from gl_vehmaster vm  where tran_code is not null )bb");*/

			ResultSet resultSet6 = stmtDashBoard6.executeQuery ("select round(aa.val/bb.val *100,2) per,aa.level from ( select count(*) val,if(m.apprlevel=1,'Level 1',if(m.apprlevel=2,'Level 2','Level 3')) level "
					+ "from my_exdet m group by  apprlevel)aa,(select count(*) val,if(m.apprlevel=1,'Level 1',if(m.apprlevel=2,'Level 2','Level 3')) level from my_exdet m where m.apprlevel is not null )bb");


			RESULTDATA=ClsCommon.convertToJSON(resultSet6);

			stmtDashBoard6.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public  JSONArray exefolioDataGridload(int flag,HttpSession session) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		ClsCommon ClsCommon=new ClsCommon();
		Connection conn =null;
		try {

			String xsql="",select="",join="";
			if(flag==1)
				xsql=" and date(t.sub_Date)=date(now()) and t.approved=0  ";
			else if(flag==2)
				xsql=" and date(t.sub_Date)!=date(now()) and t.approved=0 ";  //pending
			else if(flag==3)
				xsql="and t.approved=0";


			conn = ClsConnection.getMyConnection();
			Statement cpstmt = conn.createStatement();
			String cpsql = "", unionstr = "";

			String sqlqry = "select coalesce(select1,'') as select1 ,coalesce(join1,'') join1 from my_exeb t inner join my_brch br on t.brhId=br.doc_no left join "
					+ "my_user u on t.userid=u.doc_no left join my_menu m on(m.doc_type=t.dtype) left join win_tbldet wt on(wt.dtype=t.dtype)  "
					+ "where t.approved=0 and t.apprlevel!=0 and t.userId='"+session.getAttribute("USERID").toString()+"'"+xsql+" group by t.dtype";

            //System.out.println("gridload====="+sqlqry);
			ResultSet rs=cpstmt.executeQuery(sqlqry);

			while(rs.next()){
				select = rs.getString("select1");
				join = rs.getString("join1");
				
				cpsql += " "+unionstr+" Select t.sub_Date, 'View' as btnclick,date(now()) tdate,time(now()) ttime,t.doc_no doc_no,t.dtype doctype,br.doc_no branch,"
						+ "CONVERT(concat(day(t.sub_Date),'/',month(t.sub_Date),'/',year(t.sub_Date),' ', time(t.sub_Date)),CHAR(50)) subdatetime,"
						+ "u.user_name submitedby,m.func as path,m.menu_name as name,m.doc_type as dtype "+select+" from my_exeb t  inner join my_brch br on t.brhId=br.doc_no left join "
						+ "my_user u on t.suby=u.doc_no left join my_menu m on(m.doc_type=t.dtype) "+join+" where t.approved=0 and t.apprlevel!=0 and  t.userId='"+session.getAttribute("USERID").toString()+"'"+xsql+" ";
				
				unionstr = " union all ";    
			}

            if(!cpsql.equals("")) {
            	cpsql = "SELECT * FROM("+cpsql+")a order by sub_Date desc "; 
            	//System.out.println("===== "+cpsql);
    			ResultSet resultSet = cpstmt.executeQuery(cpsql);
    			RESULTDATA=ClsCommon.convertToJSON(resultSet);  
            }
			
			cpstmt.close();
			//conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	/*funDtype();
	getapprcount();
	apprCheck();       These method in header.jsp has to be called for approval working */
	public String saveApproveAction() throws Exception { 
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		//System.out.println(" inside saveApproveAction");
		String docno=request.getParameter("docno").trim();
		String dtype=request.getParameter("dtype").trim();
		String userid=request.getParameter("userid").trim();
		String brchid=request.getParameter("brchid").trim();
		String desc=request.getParameter("desc").trim();
		String apprlevel=request.getParameter("apprlevel").trim();
		String minapprl=request.getParameter("minapprl").trim();
		String optid=request.getParameter("optid").trim();
		String apprlist=request.getParameter("apprlist").trim();
		System.out.println("==minapprl==="+minapprl+"===apprlevel=="+apprlevel+"==optid==="+optid+"==apprlist===="+apprlist+"==userid===="+userid);
		Connection conn = ClsConnection.getMyConnection();
		Statement stmt1 =null;
		Statement stmt2 =null;   
		try { 
			stmt1 =conn.createStatement();
			stmt2 =conn.createStatement();
			String mtblnme="",subuser="";
			int approvalcount=0;
			int applvlcount=0;
			String msg="";
			int doccount=0;
			int docapprlevel=0;
			int docminapprls=0;

			String sql="",doccmd="",transtype="";
			String strsql="select msttable as mtbl,transtype from win_tbldet where dtype='"+dtype+"'";
			ResultSet rs1 = stmt1.executeQuery(strsql);
			while(rs1.next()) {
				mtblnme=rs1.getString("mtbl");
				transtype=rs1.getString("transtype");
			}
			
			String strsql2="select count(*) as count,apprstatus from my_exdet m  where m.apprstatus not in(8,9) and  m.dtype='"+dtype+"'  and m.brhId="+brchid+" and m.doc_no='"+docno+"' group by apprstatus";
			ResultSet rs2 = stmt1.executeQuery(strsql2);  
			while(rs2.next()) {
				if(rs2.getString("apprstatus").equalsIgnoreCase("2")){
					approvalcount=0;
					break;
				}
				else{
					approvalcount=rs2.getInt("count");
				}
			}

			String strsql6="select count(*) as count from my_exdet m  where apprstatus not in (0,9,8) and m.dtype='"+dtype+"' and apprlevel="+apprlevel+"  and m.brhId="+brchid+" and m.doc_no='"+docno+"'";
//			System.out.println("===="+strsql6);
			ResultSet rs6 = stmt1.executeQuery(strsql6);  
			while(rs6.next()) {
				applvlcount=rs6.getInt("count");
			}

			if(Integer.parseInt(apprlevel)!=0){
				doccmd=" and apprlevel="+apprlevel+"";
			}

			String strsql7="select count(*) as count,apprlevel,minapprls from my_exdoc m  where m.dtype='"+dtype+"' "+doccmd+" group by apprlevel order by apprlevel desc";
//			System.out.println("===== "+strsql7);
			ResultSet rs7 = stmt1.executeQuery(strsql7);
			while(rs7.next()) {
				doccount=rs7.getInt("count");
				docapprlevel=rs7.getInt("apprlevel");
				docminapprls=rs7.getInt("minapprls");
			}  

            System.out.println("approvalcount===="+approvalcount);   
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL ApproveDML(?,?,?,?,?,?,?,?,?,?,?)}");	

			stmt.registerOutParameter(11, java.sql.Types.INTEGER);
			stmt.setString(1,dtype);
			stmt.setInt(2,Integer.parseInt(docno));
			stmt.setInt(3,Integer.parseInt(brchid));
			stmt.setInt(4,Integer.parseInt(userid));
			stmt.setString(5,desc);
			stmt.setInt(6,Integer.parseInt(apprlevel));
			stmt.setInt(7,Integer.parseInt(userid));
			stmt.setInt(8,Integer.parseInt(optid));
			stmt.setInt(9,Integer.parseInt(minapprl));
			stmt.setInt(10,approvalcount);
			stmt.executeQuery(); 
			int no=stmt.getInt("srNo");
			if(no>=1){
				conn.commit();
//				System.out.println("=== commit ===");
			}
			// Thread.sleep(1500);
			int minapp=0;
			//System.out.println("=== IN ===1");
			minapp=(Integer.parseInt(minapprl)==0)?doccount:docminapprls;
			String minsqlapnd="";
/*			if(Integer.parseInt(minapprl)==0){
				minsqlapnd="limit "+(doccount)+"";
			}
			else{
				minsqlapnd="limit "+minapp+"";
			}
*/
				Integer nxtapprlevel=Integer.parseInt(apprlevel)+1;
					if((docminapprls==(applvlcount+1)) || Integer.parseInt(apprlevel)==0){
						sql="and apprlevel in (select coalesce(min(apprlevel),0) from my_exdoc where dtype='"+dtype+"' and apprlevel > "+Integer.parseInt(apprlevel)+" ) "+minsqlapnd+"";
					}
					else{
						sql="and apprlevel="+Integer.parseInt(apprlevel)+" order by apprlevel "+minsqlapnd+"";
					}

			String strsql3="select * from my_exdoc where userid not in (select userid from (select userid from my_exdet where dtype='"+dtype+"' and doc_no='"+docno+"' and brhid="+brchid+"  and apprStatus not in(8,9) "
					+ "union all select userid from my_exeb where dtype='"+dtype+"' and doc_no='"+docno+"' and brhid="+brchid+") as a ) and dtype='"+dtype+"' "
					+ " "+sql+"" ;
            System.out.println("===="+strsql3);
			ResultSet rs3 = stmt1.executeQuery(strsql3);  
			int touserid=0;
			int nextapprlvl=0;
			int status=0;
			while(rs3.next()) {
				touserid=rs3.getInt("userid");
				nextapprlvl=rs3.getInt("apprlevel");
// 		System.out.println("===== "+touserid+"====== "+nextapprlvl+" ===== "+optid);
				if(!((Integer.parseInt(optid)==2) || (Integer.parseInt(optid)==4)))
				{

					String strsql4="insert into my_exeb(brhId, doc_no, dtype, userId, sr_no, apprlevel,sub_date,suby) "
							+ "values("+brchid+","+docno+",'"+dtype+"',"+touserid+","+no+","+nextapprlvl+",now(),"+userid+")";
//					System.out.println("====== "+strsql4);
					int val1=stmt2.executeUpdate(strsql4);

					conn.commit();
					status=Integer.parseInt(apprlevel);
 					System.out.println("Status 1 ===="+status);
				}
				File saveFile = null ;
				//System.out.println("=== IN ===2");
				SendTomail(saveFile, "APPR", touserid+"", docno, brchid, userid, apprlevel, msg, dtype);
			}

			if(((Integer.parseInt(optid.trim())==2) || (Integer.parseInt(optid.trim())==4))){

				if((Integer.parseInt(optid.trim())==2)){
					status=0;
 					System.out.println("Status 2 ===="+status);
				}
				else{

					status=Integer.parseInt(optid.trim());
 					System.out.println("Status 3 ===="+status);
				}
			}
			else{
			//	status=Integer.parseInt(apprlevel); /// COMMENTED FOR FIRE 7 WHEN ONLY ONE USER IN APPROVAL
//				System.out.println("Status 4 ===="+status);
			//	status=3;
			}
			if(nextapprlvl==0 && !((Integer.parseInt(optid)==2) || (Integer.parseInt(optid)==4))){
				status=3;
 				System.out.println("Status nxtapprlvl 5 ===="+status);
			}
			if(status==3){
				int srno=0;
				ResultSet rssrno= conn.createStatement().executeQuery("select max(sr_no) srno from my_exdet where dtype='"+dtype+"' and doc_no="+Integer.parseInt(docno)+" and brhid="+Integer.parseInt(brchid)+"");
				if(rssrno.next())
				{
					srno=rssrno.getInt("srno");
				}
				conn.createStatement().executeUpdate("update my_exdet set apprstatus=3 where sr_no="+srno);
				ResultSet rsset= conn.createStatement().executeQuery("select userid,u.user_name as suby,ur.user_name as users from my_exdet e left join my_user u on(u.doc_no="+userid+") left join my_user ur on(ur.doc_no=e.userid) where e.apprlevel=0 and e.dtype='"+dtype+"' and e.doc_no="+Integer.parseInt(docno)+" and e.brhid="+Integer.parseInt(brchid)+"");
				if(rsset.next())
				{
					touserid=rsset.getInt("userid");
					//msg="Dear "+rsset.getString("users")+" , Document No "+docno+" of "+dtype+" is  approval by "+rsset.getString("suby");
				}
				/*
				File saveFile = null ;
				//System.out.println("=== IN ===3");
				SendTomail(saveFile,dtype,touserid+"" ,docno,brchid , userid,apprlevel,msg);
				*/
			}

			String strsql5="update "+mtblnme+" set status="+status+" where dtype='"+dtype+"' and "+transtype+"="+Integer.parseInt(docno)+" and brhid="+Integer.parseInt(brchid)+"";
			int val2=stmt1.executeUpdate(strsql5);

			String strsql8="update my_jvtran set status="+status+" where dtype='"+dtype+"' and doc_no="+Integer.parseInt(docno)+" and brhid="+Integer.parseInt(brchid)+"";
			//System.out.println("===update my_jvtran===="+strsql7);
			int val3=stmt1.executeUpdate(strsql8);

			conn.commit();
			if(status==3){  
				File saveFile = null ;
				System.out.println(dtype+" == "+touserid+"==="+docno+"==="+brchid +"===="+ userid+"=="+apprlevel+"==="+msg);
			    SendTomail(saveFile, "APRD", touserid+"", docno, brchid, userid, apprlevel, msg, dtype);
		}  
		} catch (Exception e) {    
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return "success";  
	}

	public String SendTomail(File saveFile,String formdetailcode,String recipient , String doc_no, String branch , String userid , String refid,String msg,String dtype) throws IOException, AddressException,
	MessagingException, SQLException, InterruptedException {

		String docnos="",subject="",message="",userName="",password="";
		String host="",port="";

		Connection conn = null;
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		String sub="";
		String sqlmessage="";

		ClsConnection ClsConnection=new ClsConnection();    
		conn=ClsConnection.getMyConnection();
		
		//System.out.println("=== IN ===4");
		
		if(msg.equalsIgnoreCase("")){
			String returnstr[] = message(branch, formdetailcode, userid, doc_no, dtype).split("####");
			message=returnstr[0];
			sub=returnstr[1];    
		if(message.equalsIgnoreCase("")){  
			return "error";
		}
		}
		else{
			message=msg;
		}

		subject= sub;
		//System.out.println("=== IN ===4.1");
		try{
			EmailUtility eut=new EmailUtility();  
			try {


				conn=ClsConnection.getMyConnection();
				Statement stmt1 = conn.createStatement();
				String strSql1 = "select email,mailpass,smtpServer,smtpHostport FROM my_user where doc_no='"+userid+"'";
				//	System.out.println("==strSql1===="+strSql1);
				ResultSet rs1 = stmt1.executeQuery(strSql1);
				while(rs1.next ()) {


					userName=rs1.getString("email");
					port=rs1.getString("smtpHostport");
					host=rs1.getString("smtpServer");
					password=rs1.getString("mailpass");
					password=ClsEncrypt.getInstance().decrypt(password);
					//System.out.println("getpassword====="+password);

				}
				stmt1.close();
				conn.close();
				//System.out.println("=== IN ===4.2");
			}
			catch(Exception e){
				e.printStackTrace();
			}



			try {


				conn=ClsConnection.getMyConnection();
				Statement stmt1 = conn.createStatement();
				String strSql1 = "select email,mailpass,smtpServer,smtpHostport FROM my_user where doc_no='"+recipient+"'";
				//	System.out.println("==strSql1===="+strSql1);
				ResultSet rs1 = stmt1.executeQuery(strSql1);
				while(rs1.next ()) {


					recipient=rs1.getString("email");

				}
				stmt1.close();
				conn.close();
				//System.out.println("=== IN ===4.3");  
			}
			catch(Exception e){
				e.printStackTrace();
			}

			
			//sendEmail(host, port, userName, password, recipient, subject, message, saveFile,docnos);
			System.out.println(message+"=MAIL="+subject);
			String cc="",bcc="",urll="",value="";  
			if(!userName.trim().equalsIgnoreCase("")){
        	value=eut.sendEmailpdf(host, port, userName, password, recipient,cc,subject, message, urll,bcc,saveFile);

			conn=ClsConnection.getMyConnection();
			Statement stmt10 = conn.createStatement();

			/*Inserting into emaillog*/
			String sqls=("insert into emaillog (doc_no, brhId, dtype, edate, userId, refid, email) values ('"+doc_no+"','"+branch+"','"+formdetailcode+"',now(),'"+userid+"','"+refid+"','"+recipient+"')");
			int datas = stmt10.executeUpdate(sqls);
			/*Inserting into emaillog Ends*/

			}

		}
		catch(Exception e){
			e.printStackTrace();
			return "error";
		}

		return "success";
	}


	public  void sendEmail(String host, String port,
			final String userName, final String password,
			String recipient,String subject, String message, File attachFile,String docnos)
					throws AddressException, MessagingException {
		
		
		//System.out.println("==host==="+host+"==password=="+password+"==recipient=="+recipient+"==subject==="+subject+"==message=="+message);

		Properties properties = new Properties();
		properties.setProperty("mail.smtp.protocol", "smtps");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", port);
		properties.put("mail.smtp.debug", "true");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.socketFactory.fallback", "false");
		properties.put("mail.user", userName);
		properties.put("mail.password", password);

		Authenticator auth = new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userName, password);
			}
		};
		Session session = Session.getInstance(properties, auth);

		Message msg = new MimeMessage(session);

		msg.setFrom(new InternetAddress(userName));
		InternetAddress[] toAddresses = { new InternetAddress(recipient) };
		msg.setRecipients(Message.RecipientType.TO, toAddresses);


		/*  String[] cc = null;
        String[] bcc = null;
        if(CC.length() != 0){
            cc = CC.trim().split(",");
        } 
        if(BCC.length() != 0){
            bcc = BCC.trim().split(",");
        }


        if(!(CC.equals(""))){
        for(int i = 0; i < cc.length; i++) {
            if(!cc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
        }
        }

        if(!(BCC.equals(""))){
        for(int i = 0; i < bcc.length; i++) {
            if(!bcc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
        }
        }*/


		if(!(subject.equals(""))){
			msg.setSubject(subject);
		}
		msg.setSentDate(new Date());

		Multipart multipart = new MimeMultipart();
		docnos=docnos==null?"":docnos;

		MimeBodyPart myattach = new MimeBodyPart();

		DataSource source = new FileDataSource(attachFile);
		myattach.setDataHandler(new DataHandler(source));

		MimeBodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(message, "text/html");

		multipart.addBodyPart(messageBodyPart);



		if (attachFile != null) {
			MimeBodyPart attachPart = new MimeBodyPart();

			try {
				attachPart.attachFile(attachFile);
			} catch (IOException ex) {
				ex.printStackTrace();
			}

			multipart.addBodyPart(attachPart);
		}

		msg.setContent(multipart);

		Transport.send(msg);

	}

	public String message(String branch,String formdetailcode,String userid,String doc_no,String dtype) throws SQLException{

		String msg="-",sub="-",returnstr="";  	
		String sqlmessage="";
		String sqlsubject="";
		Connection conn = null;
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();

		try{


			ClsConnection ClsConnection=new ClsConnection();  
			conn=ClsConnection.getMyConnection();
			ResultSet rs= conn.createStatement(
					ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE).executeQuery(
							"select COALESCE(msg,'') msg,COALESCE(subject,'') subject from gl_emailmsg where dtype='"+formdetailcode+"'");

			if(rs.next())
			{
				sqlmessage = rs.getString("msg").replaceAll("branch", branch).replaceAll("documentno", doc_no).replaceAll("documenttype", dtype).replaceAll("userno", userid);
				sqlsubject = rs.getString("subject").replaceAll("branch", branch).replaceAll("documentno", doc_no).replaceAll("documenttype", dtype).replaceAll("userno", userid);
			}
			System.out.println("sqlmessage="+sqlmessage);
			System.out.println("sqlsubject="+sqlsubject);
			if(!(sqlmessage.trim().equalsIgnoreCase("")) && sqlmessage.toLowerCase().contains("select")){ 
				ResultSet rsset=conn.createStatement().executeQuery(sqlmessage);
				while(rsset.next()) {
					msg =rsset.getString("msg");
				}
			}else {
				msg = sqlmessage;
			}
			if(!(sqlsubject.trim().equalsIgnoreCase("")) && sqlsubject.toLowerCase().contains("select")){  
				ResultSet rssub=conn.createStatement().executeQuery(sqlsubject);  
				while(rssub.next()) {
					sub =rssub.getString("sub");
				}   
			}else {
				sub = sqlsubject;  
			}
			returnstr = msg+"####"+sub;
		}catch(SQLException e){
			e.printStackTrace();

		}
		finally{
			conn.close();
		}
		return returnstr;
	}
}
