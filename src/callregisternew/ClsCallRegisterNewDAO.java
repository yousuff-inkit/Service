package callregisternew;

import java.sql.*;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsEncrypt;
import com.connection.ClsConnection;
import com.login.ClsLogin;

public class ClsCallRegisterNewDAO {
	ClsConnection objconn=new ClsConnection();
	ClsLogin objlogin=new ClsLogin();
	ClsEncrypt objencrypt=new ClsEncrypt();
	public boolean userLogin(String username, String password,
			HttpSession session, HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Connection conn=null;
		try{
			int userid=0;
			conn=objconn.getMyConnection();
			conn.setAutoCommit(false);
			Statement stmt=conn.createStatement();
			password=objencrypt.getInstance().encrypt(password);
			String str="select * from my_user where user_id='"+username+"' and pass='"+password+"'";
			ResultSet rs=stmt.executeQuery(str);
			while(rs.next()){
				userid=rs.getInt("doc_no");
				session.setAttribute("USERID", userid);
				session.setAttribute("USERNAME", username);
				session.setAttribute("CREGCOMPID",rs.getInt("cregcomp"));
			}
			
			String ip = objlogin.getRemortIP(request);
			String mac = objlogin.getMACAddress(ip);
			
			Map<String, String> env = System.getenv();
		    String xuser=env.get("USERNAME");
		    String xcomp=env.get("COMPUTERNAME");
			
		    if(userid>0){
		    	session.setAttribute("BRANCHID","1");
		    	session.setAttribute("COMPANYID","1");
				String strlog = "insert into gc_userlog (USER,WIN_USER,win_cmp,DATE_IN) values ('"+username+"','"+xuser+"','"+xcomp+"',now())";
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

}
