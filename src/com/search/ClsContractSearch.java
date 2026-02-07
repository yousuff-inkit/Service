package com.search;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsContractSearch {  
	ClsConnection objconn=new ClsConnection();     
	ClsCommon objcommon=new ClsCommon();
	public JSONArray contractSearch(HttpSession session, String clname, String docno, String refno, String qty, String site, String area, String skipsize, int id) throws SQLException{     
		JSONArray RESULTDATA1=new JSONArray();  
		if(id!=1) {
			return RESULTDATA1;  
		}
		Connection conn=null;      
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement();
			String strtest="";
			
			if(!clname.equalsIgnoreCase("") && !clname.equalsIgnoreCase("0") && !clname.equalsIgnoreCase("undefined") && clname!=null) {   
				strtest+=" and ac.refname like '%"+clname+"%'";      
			}else {}  
			
			if(!docno.equalsIgnoreCase("") && !docno.equalsIgnoreCase("0") && !docno.equalsIgnoreCase("undefined") && docno!=null) {   
				strtest+=" and cm.doc_no like '%"+docno+"%'";        
			}else {}
			
			if(!refno.equalsIgnoreCase("") && !refno.equalsIgnoreCase("0") && !refno.equalsIgnoreCase("undefined") && refno!=null) {   
				strtest+=" and cm.refno like '%"+refno+"%'";         
			}else {} 
			
			if(!qty.equalsIgnoreCase("") && !qty.equalsIgnoreCase("undefined") && qty!=null) {   
				strtest+=" and d.nos = '"+qty+"'";        
			}else {} 
			
			if(!site.equalsIgnoreCase("") && !site.equalsIgnoreCase("0") && !site.equalsIgnoreCase("undefined") && site!=null) {   
				strtest+=" and d.site like '%"+site+"%'";      
			}else {} 
			
			if(!area.equalsIgnoreCase("") && !area.equalsIgnoreCase("0") && !area.equalsIgnoreCase("undefined") && area!=null) {   
				strtest+=" and a.area like '%"+area+"%'";      
			}else {} 
			
			if(!skipsize.equalsIgnoreCase("") && !skipsize.equalsIgnoreCase("0") && !skipsize.equalsIgnoreCase("undefined") && skipsize!=null) {   
				strtest+=" and sk.name like '%"+skipsize+"%'";      
			}else {} 
			 
			String sql="select sk.name skipsize, a.area, d.nos qty, cm.brhid,cm.remarks oldcntno,cm.refno,d.srno,cm.doc_no,cm.tr_no,d.site,ac.refname,dm.name wastetype from sk_srvcontrm cm "
					+ "inner join sk_srvcontrdet d on d.rdocno=cm.tr_no left join my_acbook ac on ac.cldocno=cm.cldocno and ac.dtype='crm' "
					+ "left join sk_dumptype dm on dm.doc_no=d.wastetype left join sk_srvcsited sc on sc.rowno = d.siteid left join my_area a on a.doc_no = sc.areaid left join sk_skiptype sk on sk.doc_no = d.skiptype where cm.status=3 "+strtest+" group by cm.tr_no order by cm.tr_no";			
			//System.out.println("===contractSearch===="+sql);                           
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
