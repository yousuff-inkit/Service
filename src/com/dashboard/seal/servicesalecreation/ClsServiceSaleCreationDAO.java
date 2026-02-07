package com.dashboard.seal.servicesalecreation;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsServiceSaleCreationDAO {
	ClsConnection conobj = new ClsConnection();
	ClsCommon com = new ClsCommon(); 
	Connection conn;
	public JSONArray reloadnipurchase(String nidoc, String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
	    if(!id.equals("1")){
	    	return RESULTDATA;
	    }  
	    Connection conn = null;    
		try {
				 conn = conobj.getMyConnection();    
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select case when d.costtype=1 then cc.doc_no when d.costtype in(3,4) then cm.doc_no when d.costtype=11 then sc.voc_no when d.costtype=13 then ac.voc_no else 0 end as costcodeid,d.srno,d.desc1 description,d.unitprice,d.qty,d.qty qutval,d.total,d.discount,d.nettotal,d.nuprice,d.acno headdoc,h.gr_type grtype ,"
	        			+ "d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup,d.taxper,d.tax taxperamt,d.nettaxamount taxamount "
	        			+ " from my_srvsaleprod d left join my_head h on h.doc_no=d.acno  left join my_costunit u on u.costtype=d.costtype left join cm_srvcontrm cm on cm.tr_no=d.costcode and cm.dtype=if(d.costtype=3,'AMC',if(d.costtype=4,'SJOB','')) "
	        			+" left join my_ccentre cc on cc.doc_no = d.costcode and d.costtype=1 left join cm_staffcontrm sc on sc.doc_no = d.costcode and d.costtype=11 left join cm_amscontrm ac on ac.doc_no = d.costcode and d.costtype=13 "
	        			+ "  where d.rdocno='"+nidoc+"'  ");
	        	System.out.println("=====++==="+pySql);
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=com.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return RESULTDATA;
	}
    public JSONArray invoiceGridLoad(int id, String brhid, String todate) throws SQLException {
    	JSONArray result = new JSONArray();
    	if(id==0) {
    		return result;
    	}
    	try {  
    		conn = conobj.getMyConnection();
    		Statement stmt = conn.createStatement();
    		String sqltest = "";
    		java.sql.Date sqltodate = null;  
    		if(!todate.equalsIgnoreCase("") && todate!=null) {
    			sqltodate = com.changeStringtoSqlDate(todate);  
    			sqltest += " AND m.date<='"+sqltodate+"'";   
    		}
    		if(!brhid.equalsIgnoreCase("a") && !brhid.equalsIgnoreCase("0")) {
    			sqltest += " AND m.brhid='"+brhid+"'"; 
    		}
    		String sql = "SELECT m.delterm,m.voc_no, m.doc_no, DATE_FORMAT(m.date,'%d.%m.%Y') date, ROUND(d.nettotal,2) amount,"
    				+ " DATE_FORMAT(m.invdate,'%d.%m.%Y') invdate, m.invno, m.payterm, m.desc1, c.code currency, ROUND(m.rate,4) rate,"
    				+ " h.description accname, h.account FROM my_srvsaleprom m LEFT JOIN my_head h ON h.doc_no=m.acno "
    				+ "LEFT JOIN my_curr c ON c.doc_no=m.curid  LEFT JOIN(SELECT SUM(nettaxamount) nettotal,rdocno FROM my_srvsaleprod GROUP BY rdocno) d on d.rdocno=m.doc_no WHERE m.srstrno=0 AND m.status=3"+sqltest+""; 
    		//System.out.println("sql==="+sql);                      
    		ResultSet rs = stmt.executeQuery(sql);
    		result = com.convertToJSON(rs);      
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		conn.close();
    	}
    	return result;
    } 
}  
