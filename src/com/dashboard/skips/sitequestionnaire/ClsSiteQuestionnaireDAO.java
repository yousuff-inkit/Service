package com.dashboard.skips.sitequestionnaire;
        
import com.common.ClsCommon;
import com.connection.ClsConnection;

import java.sql.*;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class ClsSiteQuestionnaireDAO {  

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
		 
	public JSONArray contractGridLoad(HttpSession session, int id) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();   
		if(id==0) {
			return RESULTDATA1;   
		}
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String sql="select coalesce(qs.count,0) count,ac.refname,cm.cldocno,s.site from sk_srvcontrm cm left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='CRM' left join sk_srvcsited s on s.tr_no=cm.tr_no left join (select count(*) count, cldocno, site from sk_clientquestsite group by cldocno,site) qs on qs.cldocno=cm.cldocno and qs.site=s.site where s.site is not null group by cm.cldocno,s.site";
			//System.out.println("sql="+sql);    
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
	
public JSONArray searchqstn(String cldocno, String site) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
		try {
				conn = objconn.getMyConnection();
				Statement stmtEMPs = conn.createStatement();

				String sqlq1="select q.seqno,coalesce(c.question,q.question) question,coalesce(c.answer,'') answer,c.rowno from sk_question q left join sk_clientquestsite c on q.seqno=c.srno and c.cldocno='"+cldocno+"' and c.site='"+site+"' order by seqno ";
				ResultSet resultSet = stmtEMPs.executeQuery(sqlq1) ;
			 	System.out.println("--sql--"+sqlq1);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				stmtEMPs.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			conn.close();
		}
		return RESULTDATA;
    }
}