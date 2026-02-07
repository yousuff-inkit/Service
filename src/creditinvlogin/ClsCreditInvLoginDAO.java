package creditinvlogin;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.login.ClsLogin;

public class ClsCreditInvLoginDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	ClsLogin objlogin=new ClsLogin();
	public boolean userLogin(String username, String password,
			HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			System.out.println("Inside Credit Invoice Login DAO");
			int userid=0;
			String loginusername="";
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			ClsEncrypt objencrypt=new ClsEncrypt();
			String str="select doc_no,user_id userid,user_name username from my_user where user_id='"+username+"' and pass='"+objencrypt.encrypt(password)+"' and status=3";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				userid=rs.getInt("doc_no");
				loginusername=rs.getString("username");
			}
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(userid>0){
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("USERID",userid);
		    	session.setAttribute("COMPANYID","1");
		    	session.setAttribute("USERNAME",loginusername);
				String strlog = "insert into gc_creditinvlog (userid,username,WIN_USER,win_cmp,WIN_MAC,DATE_IN) values ("+userid+",'"+loginusername+"','"+xuser+"','"+xcomp+"','"+mac+"',now())";
				int loginsert=stmt.executeUpdate(strlog);
				if(loginsert<=0){
					System.out.println("Log Insert Query:"+strlog);
					System.out.println("Log Insert Error");
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
	public JSONArray salesman(HttpSession session) throws SQLException{
		
		JSONArray RESULTDATA1=new JSONArray();
		Connection conn=null;
		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "";
			//String brhid=session.getAttribute("BRANCHID").toString();

			sql="select cldocno doc_no,refname client from my_acbook where dtype='CRM'";
				System.out.println("===client===="+sql);
	     
			ResultSet resultSet1 = stmt.executeQuery(sql);
			RESULTDATA1=objcommon.convertToJSON(resultSet1);

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}


		return RESULTDATA1;
	}
	public JSONArray productSearch(String catid) throws SQLException {

		System.out.println("catiddddddd===="+catid);
		JSONArray RESULTDATA=new JSONArray();
		 HttpServletRequest request=ServletActionContext.getRequest();
		  HttpSession session=request.getSession();
		Connection conn = null;

		try {
			conn=objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="",sql2="";
			if(!(catid.equals("0") || catid.equals(""))){
				sql1="and m.catid in ("+catid+")";
			}
		/*	sql2=session.getAttribute("BRANCHID").toString();
		System.out.println("branch===="+sql2);*/
		/*	if(!(brandid.equals("0") || brandid.equals(""))){
				sql1="and b.doc_no in ("+brandid+")";
			}

			String sql2="";
			//System.out.println("brandid===="+brandid);
			if(!(catid.equals("0") || catid.equals(""))){
				sql2="and c.doc_no in ("+catid+")";
			}

			String sql3="";
			//System.out.println("brandid===="+brandid);
			if(!(subcatid.equals("0") || subcatid.equals(""))){
				sql3="and s.doc_no in ("+subcatid+")";
			}*/


			String sql="select case when 1=1  then t1.per when 2=1  then t1.cstper else 0 end as  'taxper' ,t1.taxdocno ,m.psrno,m.munit as unitdocno,at.mspecno as specid,m.productname name,round(m.sellprice,2) price from my_main m inner join my_brand b on(m.brandid=b.doc_no) left join my_prodattrib at  "
					+ "  on(at.mpsrno=m.doc_no) left join (select group_concat(cast(doc_no as char)) taxdocno, sum(per) per,sum(cstper) cstper,typeid from gl_taxmaster where provid='10'  and type=2 and if(1=1,per,cstper)>0  group by typeid  ) t1 on  t1.typeid=m.typeid "
					+ "  inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no)  where m.status=3 "+sql1;
			System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=objcommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

}
