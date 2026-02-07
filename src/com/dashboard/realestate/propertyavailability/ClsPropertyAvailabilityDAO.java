package com.dashboard.realestate.propertyavailability;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsPropertyAvailabilityDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon =new ClsCommon();
	
	public JSONArray propertylist(String uptodate,String id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		
		Connection conn = null;
		java.sql.Date sqluptodate=null;
		/*sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);*/
		
		try {
			 conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			/*String strsql="(select  coalesce(count(*),0) value,'Rented' as status,1 relodestatus from  rl_propertymaster m left join  rl_tncm a on m.doc_no=a.prtype where m.status=3   and "+sqluptodate+" between a.period_from and a.period_to and a.status=3   group by m.doc_no)"
					 +" UNION ALL (select sum(nos) value,'Available' as status,2 relodestatus from(select count(*) nos  from  rl_propertymaster m left join (select doc_no docno,period_from, period_to,prtype from rl_tncm where "+sqluptodate+" between period_from and period_to and status=3) a "
					 +" on m.doc_no=a.prtype where m.status=3 and a.prtype is null   group by m.doc_no) a)"
					 +" UNION ALL (select  count(*) value,'All' as status,3 relodestatus  from  rl_propertymaster m  where m.status=3)";*/
			
			
			String strsql=" select  coalesce(count(*),0) value,'Rented' as status,1 relodestatus from "
					 +" rl_propertymaster m where status=3 and active=1 and cnt_no>0 "
					 +"union all "
			 +"select    coalesce(count(*),0) value,'Available' as status,2 relodestatus "
			 +" from  rl_propertymaster m where status=3 and active=1 and cnt_no=0 "
			 +"union all "
			 +"select  coalesce(count(*),0) value,'All' as status,3 relodestatus from "
			 +" rl_propertymaster m where status=3 and active=1  "  ;
			

			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray getPropertyData(String uptodate,String relodestatus,String id) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		
		Connection conn = null;
		java.sql.Date sqluptodate=null;
		/*sqluptodate=ClsCommon.changeStringtoSqlDate(uptodate);*/
		
		try {
			 conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			
			String strsql="";
			if(relodestatus.equalsIgnoreCase("1")){
				
				strsql="select o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.prtype type,ut.unittype unit_type,"
						+ " aa.area,m.landmark,t.transtype transaction_type,DATE_ADD(m.cnt_date, INTERVAL 1 DAY) availability_date "
					+" from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid"
					+" left join rl_transtype t on t.doc_no=m.ttype"
					+" left join rl_propertytype pt on pt.doc_no=m.prtype"
					+" left join rl_unittype ut on ut.doc_no=m.prunit"
					+" left join my_area aa on aa.doc_no=m.area"
					+" left join rl_buildingm bm on bm.doc_no=m.unitof"
					+" left join rl_tncm a on m.doc_no=a.prtype"
					+" where m.status=3    and m.active=1 and m.cnt_no>0  group by m.doc_no;";
			
			}else if(relodestatus.equalsIgnoreCase("2")){
				
				strsql="select o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.prtype type,ut.unittype "
						+ "unit_type,aa.area,m.landmark,t.transtype transaction_type "
					+" from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid"
					+" left join rl_transtype t on t.doc_no=m.ttype"
					+" left join rl_propertytype pt on pt.doc_no=m.prtype"
					+" left join rl_unittype ut on ut.doc_no=m.prunit"
					+" left join my_area aa on aa.doc_no=m.area"
					+" left join rl_buildingm bm on bm.doc_no=m.unitof"
					+" left join (select doc_no docno,period_from, period_to,prtype from rl_tncm where "+sqluptodate+" between period_from and period_to and status=3) a on m.doc_no=a.prtype"
					+" where m.status=3 and m.active=1 and m.cnt_no=0  group by m.doc_no;";
			
			}else if(relodestatus.equalsIgnoreCase("3")){
				strsql="select o.primary_owner  owner_name,m.unitno unit_number,bm.name Unit_of,pt.prtype type,ut.unittype unit_type,aa.area,m.landmark,t.transtype transaction_type "
					+" , convert(if(m.cnt_no=0,'',DATE_ADD(m.cnt_date, INTERVAL 1 DAY)),char(100))  availability_date from rl_propertymaster m left join rl_propertryowner o on o.doc_no=m.owid"
					+" left join rl_transtype t on t.doc_no=m.ttype"
					+" left join rl_propertytype pt on pt.doc_no=m.prtype"
					+" left join rl_unittype ut on ut.doc_no=m.prunit"
					+" left join my_area aa on aa.doc_no=m.area"
					+" left join rl_buildingm bm on bm.doc_no=m.unitof"
					+" where m.status=3  and m.active=1  group by m.doc_no;";
			}else{
				strsql="";
			}

			ResultSet resultSet = stmt.executeQuery(strsql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
		
}
