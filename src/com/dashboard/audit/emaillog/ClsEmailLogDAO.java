package com.dashboard.audit.emaillog;       
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsEmailLogDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	public JSONArray EmailData(HttpSession session,int id,String fromdate,String todate) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray(); 
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
	       java.sql.Date sqlfromdate = null;
		     java.sql.Date sqltodate = null;

		try {
			 String  sql;
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	  sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		      }else{}
		      if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		       sqltodate=objcommon.changeStringtoSqlDate(todate);
		      } else{}
			
sql="select coalesce(m.voc_no,e.doc_no) doc_no,date_format(e.edate,'%d.%m.%Y %h:%m:%s') edate,e.dtype,e.brhid,mb.branchname branch,a.refname client,coalesce(u.user_id,'') mailuser,coalesce(e.email,'') email from emaillog e "
		+ "left join  sk_invm m on e.doc_no=m.doc_no and e.dtype in('sinv' ,'INVD','SINT') "
		+ "left join my_acbook a on a.cldocno=m.cldocno and a.dtype='crm' "
		+ "left join my_user u on u.doc_no=e.userid "
		+ "left join my_brch mb on mb.doc_no=e.brhid where  e.edate between '"+sqlfromdate+"' and '"+sqltodate+"' "  ;
			// System.out.println("===sql===="+sql);  
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

	 
}
