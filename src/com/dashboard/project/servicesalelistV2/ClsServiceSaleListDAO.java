package com.dashboard.project.servicesalelistV2;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsServiceSaleListDAO {

	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon cm=new ClsCommon();
	
	public  JSONArray loadSummaryData(String fromdate,String todate,String clientid,String brch,String chk) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
        if(!chk.equalsIgnoreCase("1")){
        	return RESULTDATA;
        }

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqltest1="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	    	
	     	if(brch.equalsIgnoreCase("a"))
        	{
	     		sqltest1+="";
        	}
			else
			{
				sqltest1+=" and m.brhid="+brch;
			}

		
			
			
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and a.cldocno="+clientid+" ";
	       	}
			
			
				
		String sqldata="select ROUND(@i:=@i+1 ,0) slno,a.* from(select  s.sal_name salesperson,m.rate*sum(d.nettaxamount) nettotal,m.rate,c.code currency,b.branchname brhid,m.doc_no,m.voc_no,m.date,a.refname client,coalesce(m.invno,'') invno,m.desc1,sum(d.nettaxamount)total from my_srvsalem m "
				+ "left join my_head h on h.doc_no=m.acno left join my_acbook a on a.acno=h.doc_no and a.dtype='CRM' left join my_brch b on b.doc_no=m.brhid left join my_salm s on s.doc_no=a.sal_id  "
				+ "left join my_srvsaled d on m.doc_no=d.rdocno left join my_curr c on c.doc_no=m.curid where m.status<>7 "+sqltest1+" "+sqltest+" and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' group by d.rdocno)a,(select @i:=0)b ";
		 
		//System.out.println("******+main+******"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			    RESULTDATA=cm.convertToJSON(resultSet);
			//			System.out.println("=====RESULTDATA"+RESULTDATA);

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
	
	public  JSONArray loadDetailData(String fromdate,String todate,String clientid,String brch,String chk) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
		 if(!chk.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }

		Connection conn = null;
		Statement stmt =null;
		ResultSet resultSet=null;
		String sqltest="",sqltest1="";
		try {

			//System.out.println("=====loadTrafficdaily");
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlfromdate = null;
	     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
	     	{
	     		sqlfromdate=cm.changeStringtoSqlDate(fromdate);
	     		
	     	}
	     	else{
	     
	     	}

	        java.sql.Date sqltodate = null;
	     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
	     	{
	     		sqltodate=cm.changeStringtoSqlDate(todate);
	     		
	     	}
	     	else{
	     
	     	}
	    	
	     	if(brch.equalsIgnoreCase("a"))
        	{
	     		sqltest1+="";
        	}
			else
			{
				sqltest1+=" and m.brhid="+brch;
			}

		
			
			
			
			if(!(clientid.equalsIgnoreCase("")) && !(clientid.equalsIgnoreCase("0"))){
	       		sqltest+=" and a.cldocno="+clientid+" ";
	       	}
			
			
				
		String sqldata="select ROUND(@i:=@i+1 ,0) slno,a.* from(select sm.doc_no as salid,sm.sal_name as salname,m.date,m.rate*d.nettaxamount nettaxamountb,m.rate*d.total totalb,m.rate*d.nettotal nettotalb,m.rate*d.tax taxperamtb,m.rate,c.code currency,b.branchname brhid,m.voc_no,a.refname client,d.srno,d.desc1 description,d.unitprice,d.qty,d.qty qutval,d.total,d.discount,d.nettotal,d.nuprice,"
				+ "d.acno headdoc,h.gr_type grtype ,d.costtype,d.costcode, d.remarks,h.account account,h.description accname,h.atype type,coalesce(u.CostGroup,'') CostGroup,"
				+ "d.taxper,d.tax taxperamt,d.nettaxamount taxamount  from my_srvsaled d left join my_srvsalem m on d.rdocno=m.doc_no  left join my_brch b on b.doc_no=m.brhid left join my_head hd on hd.doc_no=m.acno left join my_head h on h.doc_no=d.acno  "
				+ "left join my_costunit u on u.costtype=d.costtype left join my_acbook a on a.acno=hd.doc_no and a.dtype='CRM'left join my_curr c on c.doc_no=m.curid left join my_salm sm on(a.sal_id=sm.doc_no) where m.status<>7 and m.date>='"+sqlfromdate+"' and m.date<='"+sqltodate+"' "+sqltest+" "+sqltest1+")a,(select @i:=0)b";
		 
	//System.out.println("******+mainDetail+******"+sqldata);
				resultSet= stmt.executeQuery (sqldata);
			    RESULTDATA=cm.convertToJSON(resultSet);
			//			System.out.println("=====RESULTDATA"+RESULTDATA);

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
	public JSONArray accountDetails(String type,String account,String partyname,String contact) throws SQLException {     
	    Connection conn=null;
	   
	    JSONArray RESULTDATA1=new JSONArray();    
	
	    try {
	    	    conn = ClsConnection.getMyConnection();
		        Statement stmtClient = conn.createStatement();
			
	    	    String sql = "";
	    	    String condition="";
            	     
				if(type.equalsIgnoreCase("AR")){
					condition="and a.dtype='CRM'";
				}
				if(type.equalsIgnoreCase("AP")){
					condition="and a.dtype='VND'";
				}
				
	    	    if(!(account.equalsIgnoreCase(""))){
	                sql=sql+" and t.doc_no like '%"+account+"%'";
	            }
	            if(!(partyname.equalsIgnoreCase(""))){
	             sql=sql+" and t.description like '%"+partyname+"%'";
	            }
	            if(!(contact.equalsIgnoreCase(""))){
	                sql=sql+" and a.per_mob like '%"+contact+"%'";
	            }
	            
				sql = "select a.per_mob,a.cldocno doc_no,t.account,t.description from my_acbook a left join my_head t on a.acno=t.doc_no "
						+ " where a.dtype='crm' and a.status<>7  "+sql;
				
				ResultSet resultSet1 = stmtClient.executeQuery(sql);
				
				RESULTDATA1=cm.convertToJSON(resultSet1);
				
				stmtClient.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
}
