package com.dashboard.aviation.pricemanagementlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsPriceManagementListDAO {
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();

	Connection conn;
	public   JSONArray loadGridData(HttpSession session,String date,String chk) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    Enumeration<String> Enumeration = session.getAttributeNames();
	    int a=0;
	    while(Enumeration.hasMoreElements()){
	     if(Enumeration.nextElement().equalsIgnoreCase("BRANCHID")){
	      a=1;
	     }
	    }
	    if(a==0){
	    	return RESULTDATA;
	    }
	    String brcid=session.getAttribute("BRANCHID").toString();
	    java.sql.Date  sqlStartDate = null;
	    if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
	      	sqlStartDate = ClsCommon.changeStringtoSqlDate(date);
	    }
	    String sqltest="";
	  	    
	  	  /* 	if((!(docno.equalsIgnoreCase(""))) && (!(docno.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";
	      	}
	      	if((!(type.equalsIgnoreCase(""))) && (!(type.equalsIgnoreCase("NA")))){
	      		//sqltest=sqltest+" and m.dtype like '%"+type+"%'  ";
	     
	       	sqltest=sqltest+" and m.dtype like '%"+type+"%'  ";
      		
	       	  
	      		
	      	}
	      	if((!(clientname.equalsIgnoreCase(""))) && (!(clientname.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and ac.refname like '%"+clientname+"%'";
	      	}
	      	if((!(note.equalsIgnoreCase(""))) && (!(note.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.pnotes like '%"+note+"%'";
	      	}
	      	if((!(product.equalsIgnoreCase(""))) && (!(product.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and mn.productname like '%"+product+"%'";
	      	}*/
	    System.out.println("====chk==="+chk);
	      	if(!(sqlStartDate==null) && chk.equalsIgnoreCase("1")){
	      		sqltest=sqltest+" and '"+sqlStartDate+"' between m.validfrm and m.validupto";
	      	}
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
				
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select m.doc_no,m.voc_no,m.date,if(m.dtype='S','Sales','Purchase') dtype,ac.cldocno,ac.refname,mn.psrno,mn.part_no,mn.productname,c.code currency,c.c_rate currate,m.currid,"
	        			+ "date_format(m.validfrm,'%d-%m-%Y')validfrm,date_format(m.validupto,'%d-%m-%Y')validupto,m.pnotes,p.port,p.desc1 region,d.unit unitid,u.unit,d.price,d.tax,d.itax from av_fuelpricem m left join av_fuelpriced d on m.doc_no=d.rdocno "
	        			+ "left join my_port p on d.portid=p.doc_no left join my_unitm u on d.unit=u.doc_no left join my_main mn on m.psrno=mn.psrno "
	        			+ "left join my_acbook ac on ac.cldocno=m.cldocno and ac.Dtype=if(m.dtype='S','CRM','VND') left join my_curr c on m.currid=c.doc_no where m.status=3 "+sqltest+" ");
	        	System.out.println("--searchsql--"+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
			
			conn.close();
			return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return RESULTDATA;
	}
}
