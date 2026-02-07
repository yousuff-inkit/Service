package com.dashboard.skips.dumpinglist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsDumpingListDAO {

	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	
		 
	public JSONArray contractGridLoad(int id, String fromdate, String todate) throws SQLException{
		JSONArray RESULTDATA1=new JSONArray();
		if(id==0) {
			return RESULTDATA1;   
		}
		String sqltest="";
		Connection conn=null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			
			java.sql.Date sqlfromdate = null, sqltodate = null;
		    if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))) {
		    	sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
		    }  
		    
		    if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))) {
		    	sqltodate=objcommon.changeStringtoSqlDate(todate);
		    }  
		    
				String  sql="select @i:=@i+1 slno, a.* from(select  d.date,concat(v.reg_no,' - ',v.flname) vehicle,l.sal_name helper,m.sal_name driver,d.doc_no,d.dumpdate,d.dumptime, d.remarks,weight,s.name skip,dt.name wasttype,ds.name dumpsite"
			                + " from sk_dumping d left join sk_skipm s on s.doc_no=d.skipno"
							+ " left join sk_dumptype dt on dt.doc_no=d.dumptypeid "
							+ " left join sk_dumpsite ds on ds.doc_no=d.dumpsiteid "
							+ " left join sk_trip t on t.doc_no=d.tripstartdocno "
							+ " left join my_salesman m on (m.doc_no=t.driverdocno and m.sal_type='DRV') "
							+ " left join my_salesman l on (l.doc_no=t.helperdocno and l.sal_type='HLR') "
							+ " left join gl_vehmaster v on v.fleet_no=t.fleet_no where  d.date between '"+sqlfromdate+"' and '"+sqltodate+"')a,(select @i:=0)c";      
			//System.out.println("==sql7=="+sql);                

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
