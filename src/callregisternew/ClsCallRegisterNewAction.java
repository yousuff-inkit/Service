package callregisternew;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class ClsCallRegisterNewAction extends ActionSupport{
	private String username,password,mode,msg,docno;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDocno() {
		return docno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}
	
	public String saveAction()throws ParseException, SQLException{

		HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
		String mode=getMode();
		ClsCallRegisterNewDAO dao=new ClsCallRegisterNewDAO();
		if(mode.equalsIgnoreCase("A")){
			boolean status=dao.userLogin(getUsername(),getPassword(),session,request);
			if(status){
				return "success";
			}
			else{
				return "fail";
			}
		}
		
		return "fail";
	}
}
