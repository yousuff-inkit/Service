package com.dashboard.sales.salesreport;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsSalesReportDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray reloadGrid(String branchVal,String fromDate,String toDate,String summaryType,String hidsalesman,String hidpassdate,String hidaccno,String hideptid,String hidbrandid,String hidproductid) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        try{
        	java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
        	String sqlgroup1="",sqlgroup2=" group by m.refno";;
        	String sqlfilter="";
        	String sqljoin="";
        	String sqlref="";
        	 System.out.println("sqlfromdate========="+fromDate);
          	 System.out.println("sqltodate======"+toDate);
        	System.out.println("DAOVALUES=========="+summaryType+hidpassdate+fromDate+toDate+hidaccno+hidsalesman+hidproductid+hidbrandid+hideptid);
        	
        	
        	if(summaryType.equalsIgnoreCase("acc")){
        		sqlref+=" m.acno refno,h.description refname,";
        		sqljoin+=" left join my_head h on m.acno=h.account";
        		sqlgroup1+=" group by m.acno";
        		System.out.println("sqlgoup");
        	} else if(summaryType.equalsIgnoreCase("slm")){
        		sqlref+=" m.sal_id refno,s.sal_name refname,";
        		sqljoin+=" left join my_salm s on s.sal_id=m.sal_id";
        		sqlgroup1+=" group by m.sal_id";
        		System.out.println("sql1");
        	} else if(summaryType.equalsIgnoreCase("dat")){
        		sqlgroup1+=" group by m.date  ";
        		sqlgroup2=" group by m.refname ";
        		sqlref+=" day(m.date) refno , DATE_FORMAT(m.date,'%d.%m.%Y') refname,";
        		System.out.println("sql2");
        	} else if(summaryType.equalsIgnoreCase("prd")){
        		sqlref+=" n.psrno refno,n.productname refname,";
        		sqljoin+=" left join my_main n on d.psrno=n.psrno";
        		sqlgroup1+=" group by n.psrno";
        		System.out.println("sql3");
        	} else if(summaryType.equalsIgnoreCase("brd")){
        		sqlref+=" n.brandid refno,b.brand refname,";
        		sqljoin+=" left join my_main n on d.psrno=n.psrno left join my_brand b on b.doc_no=n.brandid";
        		sqlgroup1+=" group by n.brandid";
        		System.out.println("sql4");
        	} else if(summaryType.equalsIgnoreCase("dpt")){
        		sqlgroup1+=" group by n.deptid";
        		sqljoin+=" left join my_main n on d.psrno=n.psrno left join my_dept dt on dt.doc_no=n.deptId";
        		sqlref+=" n.deptid refno,dt.department refname,";
        		System.out.println("sql5");
        	}

			if(hidpassdate.equalsIgnoreCase("")){
				if(!fromDate.equalsIgnoreCase("") && !fromDate.equalsIgnoreCase("0")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromDate);
				}
				if(!toDate.equalsIgnoreCase("") && !toDate.equalsIgnoreCase("0")){
					sqltodate=ClsCommon.changeStringtoSqlDate(toDate);
				}
				sqlfilter+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			else{
				sqlfilter+=" and m.date in ("+hidpassdate+")";
			} 
			if(!hidaccno.equalsIgnoreCase("")){
        		sqlfilter+=" and h.doc_no in ("+hidaccno+")";
        		if(!summaryType.equalsIgnoreCase("acc")){
	        		sqljoin+=" left join my_head h on m.acno=h.account";
	        	}
        		System.out.println("hid");
        	}
			if(!hidsalesman.equalsIgnoreCase("")){
        		sqlfilter+=" and s.doc_no in ("+hidsalesman+")";
        		if(!summaryType.equalsIgnoreCase("slm")){
        			sqljoin+=" left join my_salm s on s.sal_id=m.sal_id";
	        	}
        		System.out.println("hid1");
        	}
			if(!hidproductid.equalsIgnoreCase("")){
        		sqlfilter+=" and n.doc_no in ("+hidproductid+")";
        		if(!summaryType.equalsIgnoreCase("prd")){
        			if(!sqljoin.contains("my_main")){
       				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
        			}
        			sqljoin+=" left join my_main n on d.psrno=n.psrno";
	        	}
        		System.out.println("hid2");
        	}
        	if(!hidbrandid.equalsIgnoreCase("")){
        		sqlfilter+=" and b.doc_no in ("+hidbrandid+")";
        		if(!summaryType.equalsIgnoreCase("brd")){
        			if(!sqljoin.contains("my_main")){
        				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
        			}
        			sqljoin+=" left join my_brand b on b.doc_no=n.brandid";
	        	}
        		System.out.println("hid3");
        	}
        	if(!hideptid.equalsIgnoreCase("")){
        		sqlfilter+=" and dt.doc_no in ("+hideptid+")";
        		if(!summaryType.equalsIgnoreCase("dpt")){
        			if(!sqljoin.contains("my_main")){
       				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
        			}
        			sqljoin+=" left join my_dept dt on dt.doc_no=n.deptId ";
	        	}
        		System.out.println("hid4");
        	}
        	
        	conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			/*String strSql="select"+sqlref+",round(sum(d.total),2) sales,round(coalesce(r.retamt,0),2) retamt,"
					+" round(sum(d.total)-coalesce(r.retamt,0),2) nettotal from my_invm m inner join my_invd d on m.doc_no=d.rdocno "
					+" left join (select voc_no,date,cldocno,acno,sum(d.total) retamt ,psrno,ref_type,rrefno  "
					+" from my_invr m inner join my_inrd d on m.doc_no=d.rdocno where status=3 ) r"
					+" on m.doc_no=r.rrefno and r.ref_type='inv' left join my_acbook a on a.acno=m.acno and a.dtype='crm' "
					+sqljoin+" where m.status=3 "+sqlfilter+sqlgroup1;
			*/
String sqlss="  ";
String ss="";
String ss1="";
String ss2="";
			if(summaryType.equalsIgnoreCase("dat")){
				sqlss=" refname date ,";
				ss1= " m.date d1, ";
				ss2= " d1, ";
				ss= " order by d1 ";
			}
			
			
			String strSql="select "+ss2+" refno,refname,"+sqlss+"round(sum(sales),2) sales,round(sum(retamt),2) retamt,round(sum(sales)-sum(retamt),2) nettotal  from "
					+ "(select "+ss1+" "+sqlref+"  m.cldocno,sum(d.total) sales ,0 retamt  "
					+ " from my_invM m inner join my_inVd d on m.doc_no=d.rdocno "+sqljoin+
					" where m.status=3 "+sqlfilter+sqlgroup1+""
					+ "	UNION ALL select "+ss1+" "+sqlref+" m.cldocno,0 sales ,sum(d.total) retamt  "
					+ " from my_invr m inner join my_inrd d on m.doc_no=d.rdocno "+sqljoin
					+ " where m.status=3  "+sqlfilter+sqlgroup1+" ) m  "
					+sqlgroup2+"  "+ss+"  ";

			
			System.out.println("==strSql1vtyt=="+strSql);
			ResultSet resultSet = stmt.executeQuery(strSql);
			
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    	stmt.close();
			conn.close();
			return RESULTDATA;
        } catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 
		}
        return RESULTDATA;
	}
	
	public JSONArray reloadExceldata(String branchVal,String fromDate,String toDate,String summaryType,String hidsalesman,String hidpassdate,String hidaccno,String hideptid,String hidbrandid,String hidproductid) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        try{
        	java.sql.Date sqlfromdate=null;
			java.sql.Date sqltodate=null;
			
        	String sqlgroup1="",sqlgroup2=" group by m.refno";;
        	String sqlfilter="";
        	String sqljoin="";
        	String sqlref="";
        	
        	if(summaryType.equalsIgnoreCase("acc")){
        		sqlref+=" m.acno refno,h.description refname,";
        		sqljoin+=" left join my_head h on m.acno=h.account";
        		sqlgroup1+=" group by m.acno";
        		
        	} else if(summaryType.equalsIgnoreCase("slm")){
        		sqlref+=" m.sal_id refno,s.sal_name refname,";
        		sqljoin+=" left join my_salm s on s.doc_no=m.sal_id";
        		sqlgroup1+=" group by m.sal_id";
        	} else if(summaryType.equalsIgnoreCase("dat")){
        		sqlgroup1+=" group by m.date";
        		sqlgroup2=" group by m.refname";
        		sqlref+=" day(m.date) refno , DATE_FORMAT(m.date,'%d.%m.%Y') refname,";
        	} else if(summaryType.equalsIgnoreCase("prd")){
        		sqlref+=" n.psrno refno,n.productname refname,";
        		sqljoin+=" left join my_main n on d.psrno=n.psrno";
        		sqlgroup1+=" group by n.psrno";
        	} else if(summaryType.equalsIgnoreCase("brd")){
        		sqlref+=" n.brandid refno,b.brand refname,";
        		sqljoin+=" left join my_main n on d.psrno=n.psrno left join my_brand b on b.doc_no=n.brandid";
        		sqlgroup1+=" group by n.brandid";
        	} else if(summaryType.equalsIgnoreCase("dpt")){
        		sqlgroup1+=" group by n.deptid";
        		sqljoin+=" left join my_main n on d.psrno=n.psrno left join my_dept dt on dt.doc_no=n.deptId";
        		sqlref+=" n.deptid refno,dt.department refname,";
        	}

			if(hidpassdate.equalsIgnoreCase("")){
				if(!fromDate.equalsIgnoreCase("") && !fromDate.equalsIgnoreCase("0") ){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromDate);
				}
				if(!toDate.equalsIgnoreCase("") && !toDate.equalsIgnoreCase("0")){
					sqltodate=ClsCommon.changeStringtoSqlDate(toDate);
				}
				sqlfilter+=" and m.date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			else{
				sqlfilter+=" and m.date in ("+hidpassdate+")";
			} 
			if(!hidaccno.equalsIgnoreCase("")){
        		sqlfilter+=" and h.doc_no in ("+hidaccno+")";
        		if(!summaryType.equalsIgnoreCase("acc")){
	        		sqljoin+=" left join my_head h on m.acno=h.account";
	        	}
        	}
			if(!hidsalesman.equalsIgnoreCase("")){
        		sqlfilter+=" and s.doc_no in ("+hidsalesman+")";
        		if(!summaryType.equalsIgnoreCase("slm")){
        			sqljoin+=" left join my_salm s on s.sal_id=m.sal_id";
	        	}
        	}
			if(!hidproductid.equalsIgnoreCase("")){
        		sqlfilter+=" and n.doc_no in ("+hidproductid+")";
        		if(!summaryType.equalsIgnoreCase("prd")){
        			if(!sqljoin.contains("my_main")){
       				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
        			}
        			sqljoin+=" left join my_main n on d.psrno=n.psrno";
	        	}
        	}
        	if(!hidbrandid.equalsIgnoreCase("")){
        		sqlfilter+=" and b.doc_no in ("+hidbrandid+")";
        		if(!summaryType.equalsIgnoreCase("brd")){
        			if(!sqljoin.contains("my_main")){
        				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
        			}
        			sqljoin+=" left join my_brand b on b.doc_no=n.brandid";
	        	}
        	}
        	if(!hideptid.equalsIgnoreCase("")){
        		sqlfilter+=" and dt.doc_no in ("+hideptid+")";
        		if(!summaryType.equalsIgnoreCase("dpt")){
        			if(!sqljoin.contains("my_main")){
       				 sqljoin+=" left join my_main n on d.psrno=n.psrno";
        			}
        			sqljoin+=" left join my_dept dt on dt.doc_no=n.deptId ";
	        	}
        	}
        	
        	conn=ClsConnection.getMyConnection();
			Statement stmt=conn.createStatement();
			/*String strSql="select"+sqlref+",round(sum(d.total),2) sales,round(coalesce(r.retamt,0),2) retamt,"
					+" round(sum(d.total)-coalesce(r.retamt,0),2) nettotal from my_invm m inner join my_invd d on m.doc_no=d.rdocno "
					+" left join (select voc_no,date,cldocno,acno,sum(d.total) retamt ,psrno,ref_type,rrefno  "
					+" from my_invr m inner join my_inrd d on m.doc_no=d.rdocno where status=3 ) r"
					+" on m.doc_no=r.rrefno and r.ref_type='inv' left join my_acbook a on a.acno=m.acno and a.dtype='crm' "
					+sqljoin+" where m.status=3 "+sqlfilter+sqlgroup1;
			*/
			String sqlss="  ";
			String ss="";
			String ss1="";
			String ss2="";
						if(summaryType.equalsIgnoreCase("dat")){
							 
							ss1= " m.date d1, ";
							ss2= " ,d1 ";
							ss= " order by d1 ";
						}
						
			String strSql="select  refno,refname type,round(sum(sales),2) sales,round(sum(retamt),2) retamt,round(sum(sales)-sum(retamt),2) nettotal "+ss2+"  from "
					+ "(select  "+ss1+" "+sqlref+"  m.cldocno,sum(d.total) sales ,0 retamt  "
					+ " from my_invM m inner join my_inVd d on m.doc_no=d.rdocno "+sqljoin+
					" where m.status=3 "+sqlfilter+sqlgroup1+""
					+ "	UNION ALL select  "+ss1+" "+sqlref+" m.cldocno,0 sales ,sum(d.total) retamt  "
					+ " from my_invr m inner join my_inrd d on m.doc_no=d.rdocno "+sqljoin
					+ " where m.status=3  "+sqlfilter+sqlgroup1+" ) m  "
					+sqlgroup2+" "+ss+" ";

			ResultSet resultSet = stmt.executeQuery(strSql);
			
			RESULTDATA=ClsCommon.convertToEXCEL(resultSet);
	    	stmt.close();
			conn.close();
			return RESULTDATA;
        } catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 
		}
        return RESULTDATA;
	}
        
	
	public JSONArray salesManSearch() throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        Connection  conn = null;
        
		try {
			conn=ClsConnection.getMyConnection();
			Statement stmtsal=conn.createStatement();
			
			String strSql="select doc_no,sal_name from my_salm where status=3";
            
			ResultSet resultSet = stmtsal.executeQuery(strSql);
        	RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
        	stmtsal.close();
			conn.close();
			
			return RESULTDATA;
  
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		
        return RESULTDATA;
    }
	
	
		public JSONArray accSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,account , description from my_head  where atype='ar' and m_s=0";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray dateSearch(HttpSession session,String fromdate,String todate) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		java.sql.Date sqlfromdate=null;
		java.sql.Date sqltodate=null;
		
		String sqltest="";
		
		if(!fromdate.equalsIgnoreCase("")){
			sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
		}
		if(!todate.equalsIgnoreCase("")){
			sqltodate=ClsCommon.changeStringtoSqlDate(todate);
		}

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select distinct date_format(date,'%m-%d-%Y') date,date passdate from my_invm where date between '"+sqlfromdate+"' and '"+sqltodate+"'";
			System.out.println("datesql====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray deptSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select department dept, doc_no from my_dept where status<>7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray brandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	
	public JSONArray productSearch(String brandid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
			//System.out.println("brandid===="+brandid);
			if(!(brandid.equals("0") || brandid.equals(""))){
				sql1="and b.doc_no in ("+brandid+")";
			}


			String sql="select m.doc_no,m.part_no prodcode,m.productname prodname,b.brand from my_main m inner join my_brand b on(m.brandid=b.doc_no)"
					+ "inner join my_catm c on(m.catid=c.doc_no) inner join my_scatm s on(m.scatid=s.doc_no)  where m.status=3 "+sql1;
			//System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	
	
}
