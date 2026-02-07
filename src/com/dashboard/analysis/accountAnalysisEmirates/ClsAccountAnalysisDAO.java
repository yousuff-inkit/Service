package com.dashboard.analysis.accountAnalysisEmirates;  

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsAccountAnalysisDAO {   

	ClsConnection conobj= new ClsConnection();
	ClsCommon com=new ClsCommon();

    public JSONArray dataLoad(HttpSession session,String id,String fromdate,String todate,String brhid) throws SQLException{  
				JSONArray RESULTDATA1=new JSONArray();
				Connection conn=null;
				if(!id.equalsIgnoreCase("1")) {  
					return RESULTDATA1;  
				}
				 java.sql.Date sqlFromDate = null;
			     java.sql.Date sqlToDate = null;
				try {  
					conn = conobj.getMyConnection();
					Statement stmt = conn.createStatement(); 
					String sqltest="";
					if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
			              sqlFromDate = com.changeStringtoSqlDate(fromdate);
			         }
					if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
			              sqlToDate = com.changeStringtoSqlDate(todate);  
			         }
					if(sqlFromDate!=null && sqlToDate!=null) {  
						sqltest+="  and jv.date<='"+sqlToDate+"' and jv.date>='"+sqlFromDate+"'";   
					}
					if(!brhid.equalsIgnoreCase("a") && brhid!="") {
						sqltest+=" and jv.brhid='"+brhid+"'";    
					}
					String sql="select cm.doc_no costcode,cm.dtype costtype,p.head,g.gp_desc grpname,jv.date,h.account,h.description accname,h.doc_no acno,jv.doc_no docno,b.branchname branch,jv.description,jv.dtype,jv.dramount dramt,ac.refname,d.site from my_jvtran jv left join my_head h on jv.acno=h.doc_no left join my_agrp p on h.den=p.fi_id  left join gc_agrpd g on p.gp_pr=g.gp_id and g.gtype='D' left join MY_BRCH b on jv.brhid=b.doc_no left join cm_srvcontrm cm on cm.costtype=jv.costtype and cm.tr_no=jv.costcode and jv.costtype in(4,5) left join my_acbook ac on(ac.doc_no=cm.cldocno and ac.dtype='CRM') left join (select GROUP_CONCAT(DISTINCT site ORDER BY site ASC SEPARATOR ';') site,tr_no from cm_srvcsited group by tr_no) d on(cm.tr_no=d.tr_no) where jv.status=3"+sqltest+"";
					//System.out.println("===sql===="+sql);     

					ResultSet resultSet1 = stmt.executeQuery(sql);
					RESULTDATA1=com.convertToJSON(resultSet1);
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