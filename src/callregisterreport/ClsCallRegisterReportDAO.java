package callregisterreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class ClsCallRegisterReportDAO {

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

	public  JSONArray loadSubGridData(String docno,String brhid) throws SQLException {    
		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			
				
			String sqldata = "select @id:=@id+1 srno,a.* from (select sm.grpcode empgroupid,he.name empid,gp.groupname asgnMode,ast.description as assignstatus,sa.plannedon,sa.pltime,sa.description,round(coalesce(TIMESTAMPDIFF(hour,concat(sa.plannedOn,' ',sa.plTime),now())/24,0),2) age from cm_srvassign sa "
					+ "left join cm_assignstatus ast on ast.doc_no=sa.asgnstatusid left join cm_serteamm sm on sm.doc_no=sa.empGroupId left join cm_serteamd sd on sd.empid =sa.empid "
					+ "left join hr_empm he on sd.empid=he.doc_no left join my_groupvals gp on gp.doc_no=sa.asgnmode and gp.grptype='assignmode' "
					+ "where sa.refdocno="+docno+" and sa.brhid="+brhid+" group by sa.tr_no order by sa.entrydate) a,(select @id:=0)r";
		
     		    //System.out.println("sqldata====*******"+sqldata);    
				resultSet= stmt.executeQuery (sqldata);
				while(resultSet.next()){
					JSONObject objdata=new JSONObject();      
					    objdata.put("srno", resultSet.getString("srno"));
						objdata.put("empgroupid", resultSet.getString("empgroupid"));
						objdata.put("empid", resultSet.getString("empid"));
						objdata.put("assignstatus", resultSet.getString("assignstatus"));
						objdata.put("plannedon", resultSet.getString("plannedon"));
						objdata.put("pltime", resultSet.getString("pltime"));
						objdata.put("age", resultSet.getString("age"));
						objdata.put("description", resultSet.getString("description"));
					RESULTDATA.add(objdata);
				}
		}
		catch(Exception e){
			e.printStackTrace();  
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
}
