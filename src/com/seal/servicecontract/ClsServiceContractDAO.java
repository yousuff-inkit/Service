package com.seal.servicecontract;

import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.common.ClsNumberToWord;
import com.connection.ClsConnection;
import com.project.execution.quotation.ClsQuotationBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsServiceContractDAO {

	ClsCommon com=new ClsCommon();
	ClsConnection conobj=new ClsConnection();
	ClsServiceContractBean bean=new ClsServiceContractBean();

	public int insert(java.sql.Date date, java.sql.Date  stdate, java.sql.Date  enddate, HttpSession session, HttpServletRequest request, String mode, String dtype, int cldocno, int cpersonid, int salid, String currencyid, String vattype, ArrayList<String> seronelist, ArrayList<String> seryearlist, String rate) throws SQLException{
		Connection conn=null;  
		int docNo=0;
		int vocno=0;
		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sa_ServiceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			stmt.setDate(1, date);
			stmt.setInt(2, cldocno);
			stmt.setInt(3, cpersonid);    
			stmt.setInt(4, salid);
			stmt.setDate(5, stdate);
			stmt.setDate(6, enddate);
			stmt.setString(7, currencyid);
			stmt.setString(8, vattype);
			stmt.setString(9, "AMC");
			stmt.setString(10, mode);
			stmt.setString(11, session.getAttribute("BRANCHID").toString());
			stmt.setString(12, session.getAttribute("USERID").toString());
			stmt.setDouble(15,rate.trim().equals("") || rate==null ? 0.00:Double.parseDouble(rate));    
			int val = stmt.executeUpdate();
			docNo=stmt.getInt("docNo");
			vocno=stmt.getInt("vocno");
			request.setAttribute("docNo", docNo);  
			if(docNo<=0) {
				conn.close();
				return 0;
			}  
			if(docNo>0){
				//System.out.println(seronelist+"==="+seryearlist);   
				for(int i=0;i< seronelist.size();i++){   
					String[] serone = ((String) seronelist.get(i)).split("::");
					if(!(serone[0].trim().equalsIgnoreCase("undefined") || serone[0].trim().equalsIgnoreCase("NaN") || serone[0].trim().equalsIgnoreCase("") || serone[0].trim().equalsIgnoreCase("null") || serone[0].isEmpty()))  
					{

						String sql="INSERT INTO sa_srvcontrd(srno, servid, acno, curid, rate, amounttr, amountlc, description, rdocno, billtype)VALUES"   
								+ " ("+(i+1)+","
								+ "'"+(serone[0].trim().equalsIgnoreCase("undefined") || serone[0].trim().equalsIgnoreCase("NaN")|| serone[0].trim().equalsIgnoreCase("")|| serone[0].isEmpty()?0:serone[0].trim())+"',"
								+ "'"+(serone[1].trim().equalsIgnoreCase("undefined") || serone[1].trim().equalsIgnoreCase("NaN")|| serone[1].trim().equalsIgnoreCase("")|| serone[1].isEmpty()?0:serone[1].trim())+"',"
								+ "'"+(serone[2].trim().equalsIgnoreCase("undefined") || serone[2].trim().equalsIgnoreCase("NaN")|| serone[2].trim().equalsIgnoreCase("")|| serone[2].isEmpty()?0:serone[2].trim())+"',"
								+ "'"+(serone[3].trim().equalsIgnoreCase("undefined") || serone[3].trim().equalsIgnoreCase("NaN")|| serone[3].trim().equalsIgnoreCase("")|| serone[3].isEmpty()?0:serone[3].trim())+"',"
								+ "'"+(serone[4].trim().equalsIgnoreCase("undefined") || serone[4].trim().equalsIgnoreCase("NaN")|| serone[4].trim().equalsIgnoreCase("")|| serone[4].isEmpty()?0:serone[4].trim())+"',"
								+ "'"+(serone[5].trim().equalsIgnoreCase("undefined") || serone[5].trim().equalsIgnoreCase("NaN")|| serone[5].trim().equalsIgnoreCase("")|| serone[5].isEmpty()?0:serone[5].trim())+"',"
								+ "'"+(serone[6].trim().equalsIgnoreCase("undefined") || serone[6].trim().equalsIgnoreCase("NaN")|| serone[6].trim().equalsIgnoreCase("")|| serone[6].isEmpty()?"":serone[6].trim())+"',"
								+"'"+docNo+"','"+(serone[8].trim().equalsIgnoreCase("undefined") || serone[8].trim().equalsIgnoreCase("NaN")|| serone[8].trim().equalsIgnoreCase("")|| serone[8].isEmpty()?"0":serone[8].trim())+"')";    

						//System.out.println("==serone==="+sql);

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
					}
				}
				for(int i=0;i< seryearlist.size();i++){   
					String[] seryear = ((String) seryearlist.get(i)).split("::");
					if(!(seryear[0].trim().equalsIgnoreCase("undefined") || seryear[0].trim().equalsIgnoreCase("NaN") || seryear[0].trim().equalsIgnoreCase("") || seryear[0].trim().equalsIgnoreCase("null") || seryear[0].isEmpty()))  
					{

						String sql="INSERT INTO sa_srvcontrd(srno, servid, acno, curid, rate, amounttr, amountlc, description, rdocno, billtype)VALUES"   
								+ " ("+(i+1)+","
								+ "'"+(seryear[0].trim().equalsIgnoreCase("undefined") || seryear[0].trim().equalsIgnoreCase("NaN")|| seryear[0].trim().equalsIgnoreCase("")|| seryear[0].isEmpty()?0:seryear[0].trim())+"',"
								+ "'"+(seryear[1].trim().equalsIgnoreCase("undefined") || seryear[1].trim().equalsIgnoreCase("NaN")|| seryear[1].trim().equalsIgnoreCase("")|| seryear[1].isEmpty()?0:seryear[1].trim())+"',"
								+ "'"+(seryear[2].trim().equalsIgnoreCase("undefined") || seryear[2].trim().equalsIgnoreCase("NaN")|| seryear[2].trim().equalsIgnoreCase("")|| seryear[2].isEmpty()?0:seryear[2].trim())+"',"
								+ "'"+(seryear[3].trim().equalsIgnoreCase("undefined") || seryear[3].trim().equalsIgnoreCase("NaN")|| seryear[3].trim().equalsIgnoreCase("")|| seryear[3].isEmpty()?0:seryear[3].trim())+"',"
								+ "'"+(seryear[4].trim().equalsIgnoreCase("undefined") || seryear[4].trim().equalsIgnoreCase("NaN")|| seryear[4].trim().equalsIgnoreCase("")|| seryear[4].isEmpty()?0:seryear[4].trim())+"',"
								+ "'"+(seryear[5].trim().equalsIgnoreCase("undefined") || seryear[5].trim().equalsIgnoreCase("NaN")|| seryear[5].trim().equalsIgnoreCase("")|| seryear[5].isEmpty()?0:seryear[5].trim())+"',"
								+ "'"+(seryear[6].trim().equalsIgnoreCase("undefined") || seryear[6].trim().equalsIgnoreCase("NaN")|| seryear[6].trim().equalsIgnoreCase("")|| seryear[6].isEmpty()?"":seryear[6].trim())+"',"
								+"'"+docNo+"','"+(seryear[8].trim().equalsIgnoreCase("undefined") || seryear[8].trim().equalsIgnoreCase("NaN")|| seryear[8].trim().equalsIgnoreCase("")|| seryear[8].isEmpty()?"0":seryear[8].trim())+"')";   

						//System.out.println("==seryear==="+sql);      

						int resultSet2 = stmt.executeUpdate (sql);
						if(resultSet2<=0)
						{
							conn.close();
							return 0;
						}
					}
				}
			}
			if(docNo>0){  
				stmt.close();        
				conn.commit();
				conn.close();
				return vocno;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;  
	}
	public int edit(int docno,int vocno,java.sql.Date date, java.sql.Date  stdate, java.sql.Date  enddate, HttpSession session, HttpServletRequest request, String mode, String dtype, int cldocno, int cpersonid, int salid, String currencyid, String vattype, ArrayList<String> seronelist, ArrayList<String> seryearlist, String rate) throws SQLException{
		Connection conn=null;  
		int val = 0;
		try{
			//System.out.println("vattype="+vattype);  
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sa_ServiceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(13, docno);
			stmt.setInt(14, vocno);     
			stmt.setDate(1,date);
			stmt.setInt(2,cldocno);
			stmt.setInt(3,cpersonid);    
			stmt.setInt(4,salid);
			stmt.setDate(5,stdate);
			stmt.setDate(6,enddate);
			stmt.setString(7,currencyid);
			stmt.setString(8,vattype);
			stmt.setString(9,"AMC");
			stmt.setString(10,mode);
			stmt.setString(11, session.getAttribute("BRANCHID").toString());
			stmt.setString(12, session.getAttribute("USERID").toString());
			stmt.setDouble(15,rate.trim().equals("") || rate==null ? 0.00:Double.parseDouble(rate));    
			val = stmt.executeUpdate();  
			if(val<=0) {
				conn.close();
				return 0;
			}
			if(val>0){  
				//System.out.println(seronelist+"==="+seryearlist);
				for(int i=0,j=0;i< seryearlist.size();i++){     
					String[] seryear = ((String) seryearlist.get(i)).split("::");
					if(!(seryear[0].trim().equalsIgnoreCase("undefined") || seryear[0].trim().equalsIgnoreCase("NaN") || seryear[0].trim().equalsIgnoreCase("") || seryear[0].trim().equalsIgnoreCase("null") || seryear[0].isEmpty()))  
					{  
						String sql="";
						int rowno = seryear[7].trim().equalsIgnoreCase("undefined") || seryear[7].trim().equalsIgnoreCase("NaN") || seryear[7].trim().equalsIgnoreCase("") || seryear[7].trim().equalsIgnoreCase("null") || seryear[7].isEmpty()?0:Integer.parseInt(seryear[7].trim().toString());
						double amounttr = seryear[4].trim().equalsIgnoreCase("undefined") || seryear[4].trim().equalsIgnoreCase("NaN")|| seryear[4].trim().equalsIgnoreCase("")|| seryear[4].isEmpty()?0.0:Double.parseDouble(seryear[4].trim());
						if(amounttr>0) {      
							if(rowno>0) {  
								sql="UPDATE sa_srvcontrd SET srno="+(j+1)+", servid='"+(seryear[0].trim().equalsIgnoreCase("undefined") || seryear[0].trim().equalsIgnoreCase("NaN")|| seryear[0].trim().equalsIgnoreCase("")|| seryear[0].isEmpty()?0:seryear[0].trim())+"',"
									 	+ " acno='"+(seryear[1].trim().equalsIgnoreCase("undefined") || seryear[1].trim().equalsIgnoreCase("NaN")|| seryear[1].trim().equalsIgnoreCase("")|| seryear[1].isEmpty()?0:seryear[1].trim())+"', "
									    + " curid='"+(seryear[2].trim().equalsIgnoreCase("undefined") || seryear[2].trim().equalsIgnoreCase("NaN")|| seryear[2].trim().equalsIgnoreCase("")|| seryear[2].isEmpty()?0:seryear[2].trim())+"',"
									    + " rate='"+(seryear[3].trim().equalsIgnoreCase("undefined") || seryear[3].trim().equalsIgnoreCase("NaN")|| seryear[3].trim().equalsIgnoreCase("")|| seryear[3].isEmpty()?0:seryear[3].trim())+"',"
									    + " amounttr='"+(seryear[4].trim().equalsIgnoreCase("undefined") || seryear[4].trim().equalsIgnoreCase("NaN")|| seryear[4].trim().equalsIgnoreCase("")|| seryear[4].isEmpty()?0:seryear[4].trim())+"',"
									    + " amountlc='"+(seryear[5].trim().equalsIgnoreCase("undefined") || seryear[5].trim().equalsIgnoreCase("NaN")|| seryear[5].trim().equalsIgnoreCase("")|| seryear[5].isEmpty()?0:seryear[5].trim())+"',"
									    + " description='"+(seryear[6].trim().equalsIgnoreCase("undefined") || seryear[6].trim().equalsIgnoreCase("NaN")|| seryear[6].trim().equalsIgnoreCase("")|| seryear[6].isEmpty()?"":seryear[6].trim())+"',"
									    + " rdocno='"+docno+"', billtype='"+(seryear[8].trim().equalsIgnoreCase("undefined") || seryear[8].trim().equalsIgnoreCase("NaN")|| seryear[8].trim().equalsIgnoreCase("")|| seryear[8].isEmpty()?"0":seryear[8].trim())+"' WHERE doc_no='"+rowno+"'";
						}else {
								 sql="INSERT INTO sa_srvcontrd(srno, servid, acno, curid, rate, amounttr, amountlc, description, rdocno, billtype)VALUES"   
										+ " ("+(j+1)+","
										+ "'"+(seryear[0].trim().equalsIgnoreCase("undefined") || seryear[0].trim().equalsIgnoreCase("NaN")|| seryear[0].trim().equalsIgnoreCase("")|| seryear[0].isEmpty()?0:seryear[0].trim())+"',"
										+ "'"+(seryear[1].trim().equalsIgnoreCase("undefined") || seryear[1].trim().equalsIgnoreCase("NaN")|| seryear[1].trim().equalsIgnoreCase("")|| seryear[1].isEmpty()?0:seryear[1].trim())+"',"
										+ "'"+(seryear[2].trim().equalsIgnoreCase("undefined") || seryear[2].trim().equalsIgnoreCase("NaN")|| seryear[2].trim().equalsIgnoreCase("")|| seryear[2].isEmpty()?0:seryear[2].trim())+"',"
										+ "'"+(seryear[3].trim().equalsIgnoreCase("undefined") || seryear[3].trim().equalsIgnoreCase("NaN")|| seryear[3].trim().equalsIgnoreCase("")|| seryear[3].isEmpty()?0:seryear[3].trim())+"',"
										+ "'"+(seryear[4].trim().equalsIgnoreCase("undefined") || seryear[4].trim().equalsIgnoreCase("NaN")|| seryear[4].trim().equalsIgnoreCase("")|| seryear[4].isEmpty()?0:seryear[4].trim())+"',"
										+ "'"+(seryear[5].trim().equalsIgnoreCase("undefined") || seryear[5].trim().equalsIgnoreCase("NaN")|| seryear[5].trim().equalsIgnoreCase("")|| seryear[5].isEmpty()?0:seryear[5].trim())+"',"
										+ "'"+(seryear[6].trim().equalsIgnoreCase("undefined") || seryear[6].trim().equalsIgnoreCase("NaN")|| seryear[6].trim().equalsIgnoreCase("")|| seryear[6].isEmpty()?"":seryear[6].trim())+"',"
										+"'"+docno+"','"+(seryear[8].trim().equalsIgnoreCase("undefined") || seryear[8].trim().equalsIgnoreCase("NaN")|| seryear[8].trim().equalsIgnoreCase("")|| seryear[8].isEmpty()?"0":seryear[8].trim())+"')"; 
						}
							//System.out.println("==seryear==="+sql);   
							int resultSet2 = stmt.executeUpdate (sql);
							j++;  
							if(resultSet2<=0)
							{
								conn.close();
								return 0;
							}
						}
						if(rowno>0 && amounttr==0) {  
							sql="DELETE FROM sa_srvcontrd WHERE doc_no='"+rowno+"'";
							int resultSet2 = stmt.executeUpdate (sql);
							if(resultSet2<=0)
							{
								conn.close();
								return 0;
							}
						}  
					}
				}
				for(int i=0,j=0;i< seronelist.size();i++){   
					String[] serone = ((String) seronelist.get(i)).split("::");
					if(!(serone[0].trim().equalsIgnoreCase("undefined") || serone[0].trim().equalsIgnoreCase("NaN") || serone[0].trim().equalsIgnoreCase("") || serone[0].trim().equalsIgnoreCase("null") || serone[0].isEmpty()))  
					{
						String sql="";
						int rowno = serone[7].trim().equalsIgnoreCase("undefined") || serone[7].trim().equalsIgnoreCase("NaN") || serone[7].trim().equalsIgnoreCase("") || serone[7].trim().equalsIgnoreCase("null") || serone[7].isEmpty()?0:Integer.parseInt(serone[7].trim().toString());
						double amounttr = serone[4].trim().equalsIgnoreCase("undefined") || serone[4].trim().equalsIgnoreCase("NaN")|| serone[4].trim().equalsIgnoreCase("")|| serone[4].isEmpty()?0.0:Double.parseDouble(serone[4].trim()); 
						if(amounttr>0) {   
							if(rowno>0) {  
								 sql="UPDATE sa_srvcontrd SET srno="+(j+1)+", servid='"+(serone[0].trim().equalsIgnoreCase("undefined") || serone[0].trim().equalsIgnoreCase("NaN")|| serone[0].trim().equalsIgnoreCase("")|| serone[0].isEmpty()?0:serone[0].trim())+"',"
								 	+ " acno='"+(serone[1].trim().equalsIgnoreCase("undefined") || serone[1].trim().equalsIgnoreCase("NaN")|| serone[1].trim().equalsIgnoreCase("")|| serone[1].isEmpty()?0:serone[1].trim())+"', "
								    + " curid='"+(serone[2].trim().equalsIgnoreCase("undefined") || serone[2].trim().equalsIgnoreCase("NaN")|| serone[2].trim().equalsIgnoreCase("")|| serone[2].isEmpty()?0:serone[2].trim())+"',"
								    + " rate='"+(serone[3].trim().equalsIgnoreCase("undefined") || serone[3].trim().equalsIgnoreCase("NaN")|| serone[3].trim().equalsIgnoreCase("")|| serone[3].isEmpty()?0:serone[3].trim())+"',"
								    + " amounttr='"+(serone[4].trim().equalsIgnoreCase("undefined") || serone[4].trim().equalsIgnoreCase("NaN")|| serone[4].trim().equalsIgnoreCase("")|| serone[4].isEmpty()?0:serone[4].trim())+"',"
								    + " amountlc='"+(serone[5].trim().equalsIgnoreCase("undefined") || serone[5].trim().equalsIgnoreCase("NaN")|| serone[5].trim().equalsIgnoreCase("")|| serone[5].isEmpty()?0:serone[5].trim())+"',"
								    + " description='"+(serone[6].trim().equalsIgnoreCase("undefined") || serone[6].trim().equalsIgnoreCase("NaN")|| serone[6].trim().equalsIgnoreCase("")|| serone[6].isEmpty()?"":serone[6].trim())+"',"
								    + " rdocno='"+docno+"', billtype='"+(serone[8].trim().equalsIgnoreCase("undefined") || serone[8].trim().equalsIgnoreCase("NaN")|| serone[8].trim().equalsIgnoreCase("")|| serone[8].isEmpty()?"0":serone[8].trim())+"' WHERE doc_no='"+rowno+"'";
						}else {
								 sql="INSERT INTO sa_srvcontrd(srno, servid, acno, curid, rate, amounttr, amountlc, description, rdocno, billtype)VALUES"   
										+ " ("+(j+1)+","
										+ "'"+(serone[0].trim().equalsIgnoreCase("undefined") || serone[0].trim().equalsIgnoreCase("NaN")|| serone[0].trim().equalsIgnoreCase("")|| serone[0].isEmpty()?0:serone[0].trim())+"',"
										+ "'"+(serone[1].trim().equalsIgnoreCase("undefined") || serone[1].trim().equalsIgnoreCase("NaN")|| serone[1].trim().equalsIgnoreCase("")|| serone[1].isEmpty()?0:serone[1].trim())+"',"
										+ "'"+(serone[2].trim().equalsIgnoreCase("undefined") || serone[2].trim().equalsIgnoreCase("NaN")|| serone[2].trim().equalsIgnoreCase("")|| serone[2].isEmpty()?0:serone[2].trim())+"',"
										+ "'"+(serone[3].trim().equalsIgnoreCase("undefined") || serone[3].trim().equalsIgnoreCase("NaN")|| serone[3].trim().equalsIgnoreCase("")|| serone[3].isEmpty()?0:serone[3].trim())+"',"
										+ "'"+(serone[4].trim().equalsIgnoreCase("undefined") || serone[4].trim().equalsIgnoreCase("NaN")|| serone[4].trim().equalsIgnoreCase("")|| serone[4].isEmpty()?0:serone[4].trim())+"',"
										+ "'"+(serone[5].trim().equalsIgnoreCase("undefined") || serone[5].trim().equalsIgnoreCase("NaN")|| serone[5].trim().equalsIgnoreCase("")|| serone[5].isEmpty()?0:serone[5].trim())+"',"
										+ "'"+(serone[6].trim().equalsIgnoreCase("undefined") || serone[6].trim().equalsIgnoreCase("NaN")|| serone[6].trim().equalsIgnoreCase("")|| serone[6].isEmpty()?"":serone[6].trim())+"',"
										+"'"+docno+"','"+(serone[8].trim().equalsIgnoreCase("undefined") || serone[8].trim().equalsIgnoreCase("NaN")|| serone[8].trim().equalsIgnoreCase("")|| serone[8].isEmpty()?"0":serone[8].trim())+"')";
						    }
							//System.out.println("==serone==="+sql);
							int resultSet2 = stmt.executeUpdate (sql);
							j++;  
							if(resultSet2<=0)
							{
								conn.close();
								return 0;
							}
						}
						if(rowno>0 && amounttr==0) {    
							sql="DELETE FROM sa_srvcontrd WHERE doc_no='"+rowno+"'";
							int resultSet2 = stmt.executeUpdate (sql);
							if(resultSet2<=0)
							{
								conn.close();
								return 0;
							}
						} 
					}
				}
			}
			if(val>0){    
				stmt.close();        
				conn.commit();
				conn.close();
				return val;  
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;  
	}
	public int delete(int docno,int vocno, HttpSession session, HttpServletRequest request, String mode) throws SQLException{
		Connection conn=null;  
		int val = 0;
		try{
			conn=conobj.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL Sa_ServiceContractDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			stmt.setInt(13, docno);
			stmt.setInt(14, vocno);     
			stmt.setDate(1,null);
			stmt.setInt(2,0);
			stmt.setInt(3,0);    
			stmt.setInt(4,0);  
			stmt.setDate(5,null);
			stmt.setDate(6,null);
			stmt.setString(7,"0");
			stmt.setString(8,"0");
			stmt.setString(9,"AMC");  
			stmt.setString(10,mode);   
			stmt.setString(11, session.getAttribute("BRANCHID").toString());
			stmt.setString(12, session.getAttribute("USERID").toString());
			stmt.setString(15,"0");
			val = stmt.executeUpdate();  
			if(val<=0) {  
				conn.close();
				return 0;
			}
			if(val>0){  
				stmt.close();        
				conn.commit();
				conn.close();
				return val;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return 0;  
	}
 
	public JSONArray searchMaster(HttpSession session,String msdocno,String Cl_names,String surdate,int id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(id==0){  
			return RESULTDATA;
		}
		java.sql.Date sqlStartDate=null;

		String sqltest="";
		if(!(surdate.equalsIgnoreCase("undefined"))&&!(surdate.equalsIgnoreCase(""))&&!(surdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = com.changeStringtoSqlDate(surdate);
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";    
		}
		if(!(msdocno.equalsIgnoreCase("undefined"))&&!(msdocno.equalsIgnoreCase(""))&&!(msdocno.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and m.doc_no like '%"+msdocno+"%'";
		}
		if(!(Cl_names.equalsIgnoreCase("undefined"))&&!(Cl_names.equalsIgnoreCase(""))&&!(Cl_names.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and ac.refname like '%"+Cl_names+"%'";
		}  
		String brhid=session.getAttribute("BRANCHID").toString();
		if(!(brhid.equalsIgnoreCase("undefined"))&&!(brhid.equalsIgnoreCase(""))&&!(brhid.equalsIgnoreCase("0"))){
            sqltest=sqltest+" and m.brhid='"+brhid+"'";
        }
		Connection conn = null;

		try {
				conn = conobj.getMyConnection();
				Statement stmtenq1 = conn.createStatement ();

				String str1Sql=("SELECT m.date,m.tr_no,m.doc_no,m.cldocno,ac.refname FROM cm_srvcontrm m LEFT JOIN my_acbook ac ON ac.cldocno=m.cldocno AND ac.dtype='crm' WHERE m.status=3"+sqltest+"");
  
				//System.out.println("==mainsearch==="+str1Sql);
				ResultSet resultSet = stmtenq1.executeQuery(str1Sql);
				RESULTDATA=com.convertToJSON(resultSet);
				stmtenq1.close();
				conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}

	public ClsServiceContractBean getViewdetails(HttpSession session,HttpServletRequest request,String docno) throws SQLException{

		Connection conn=null;
		try { 
			conn = conobj.getMyConnection();
			Statement stmt  = conn.createStatement ();
			String brhid=session.getAttribute("BRANCHID").toString();

			String sqls=("SELECT ROUND(m.rate,4) rate,m.date,m.validfrom, m.validupto,m.tr_no,m.doc_no,m.cldocno,ac.per_tel pertel,ac.cldocno,ac.refname,"
					+ "trim(ac.address) address,ac.per_mob,trim(ac.mail1) mail1,sm.sal_name as salname,sm.doc_no as salid, cc.cperson,"
					+ " m.cpersonid, m.curid, m.vattype, cr.code FROM cm_srvcontrm m LEFT JOIN my_acbook ac ON ac.cldocno=m.cldocno AND ac.dtype='crm' "
					+ "left join my_salm sm ON(ac.sal_id=sm.doc_no) LEFT JOIN my_crmcontact cc ON cc.row_no=m.cpersonid "
					+ "LEFT JOIN my_curr cr ON cr.doc_no=m.curid WHERE m.status=3 AND m.doc_no='"+docno+"' AND m.brhid='"+brhid+"'");    
		    //System.out.println("===getViewdetails===="+sqls);   
			ResultSet resultSet = stmt.executeQuery(sqls);    
			while (resultSet.next()) {
				bean.setClientid(resultSet.getInt("cldocno"));
				bean.setDocno(resultSet.getString("doc_no"));
				bean.setMasterdoc_no(resultSet.getInt("tr_no"));
				bean.setHiddate(resultSet.getString("date"));
				bean.setTxtclient(resultSet.getString("refname"));
				bean.setTxtcontact(resultSet.getString("cperson"));
				bean.setCpersonid(resultSet.getInt("cpersonid"));
				bean.setHidstdate(resultSet.getString("validfrom"));
				bean.setHidenddate(resultSet.getString("validupto")); 
				bean.setHidcmbcurrencyid(resultSet.getString("curid"));
				bean.setHidcmbvattype(resultSet.getString("vattype"));
				bean.setSalid(resultSet.getInt("salid"));
				bean.setTxtemail(resultSet.getString("mail1"));
				bean.setTxtmob1(resultSet.getString("pertel"));
				bean.setTxtmob2(resultSet.getString("per_mob"));
				bean.setTxtsalman(resultSet.getString("salname")); 
				bean.setTxtclientdet(resultSet.getString("address")); 
				bean.setTxtrate1(resultSet.getString("rate"));  
			}

		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return bean;
	}
	public JSONArray serviceGrid(int id,int trno) throws SQLException {
		JSONArray jsonArray = new JSONArray();
		if(id==0){   
			return jsonArray;    
		}

		Connection conn = null; 
		try {
			conn = conobj.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql = "", sqltest = "", sqltest1 = "";
			if(id == 1) {
				sqltest += " AND s.billmethod not in(2) ";
				sqltest1 += " AND d.billtype not in(2) ";
			}else {
				sqltest += " AND s.billmethod='"+id+"'";
				sqltest1 += " AND d.billtype='"+id+"'";   
			}
			if(trno>0) {   
				 sql = "SELECT * FROM(SELECT bm.name billmethodname,d.curid, cr.code curr, ROUND(d.amounttr,2) amounttr, ROUND(d.amountlc,2) amountlc, d.rate, s.doc_no servid, s.service sername, s.billmethod, d.acno, d.description, d.doc_no FROM sa_srvcontrd d LEFT JOIN sa_service s ON s.doc_no=d.servid LEFT JOIN sa_billmethod bm ON bm.doc_no=s.billmethod LEFT JOIN my_curr cr ON cr.doc_no=d.curid WHERE 1=1"+sqltest1+" AND d.rdocno='"+trno+"' UNION ALL SELECT bm.name billmethodname,0 curid,'' curr,0 amounttr,0 amountlc,0 rate,s.doc_no servid, s.service sername, s.billmethod, s.acno,'' description,0 doc_no FROM sa_service s LEFT JOIN sa_billmethod bm ON bm.doc_no=s.billmethod WHERE s.status=3"+sqltest+")a GROUP BY a.servid";
			}else {  
				 sql = "select bm.name billmethodname,0 curid,'' curr,0 amounttr,0 amountlc,0 rate,s.doc_no servid, s.service sername, s.billmethod, s.acno,'' description,0 doc_no from sa_service s LEFT JOIN sa_billmethod bm ON bm.doc_no=s.billmethod where s.status=3"+sqltest+"";
			}  
			//System.out.println("sql="+sql);     
			ResultSet rs = stmt.executeQuery(sql);  
			jsonArray=com.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return jsonArray;
	}
	public JSONArray searchClient(HttpSession session,String clname,String mob,int id) throws SQLException {
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


		String brid=session.getAttribute("BRANCHID").toString();


		String sqltest="";

		if(!(clname.equalsIgnoreCase("undefined"))&&!(clname.equalsIgnoreCase(""))&&!(clname.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}


		Connection conn = null;
		try {
			conn = conobj.getMyConnection();
			Statement stmtVeh1 = conn.createStatement ();
			int clientbranchwise=0;
			Statement stmt=conn.createStatement();
			String strsql="select method from gl_config where field_nme='clientbranchwise'";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				clientbranchwise=rs.getInt("method");
			}
			if(clientbranchwise==1){
				if(!(brid.equalsIgnoreCase("undefined"))&&!(brid.equalsIgnoreCase(""))&&!(brid.equalsIgnoreCase("0"))){
					sqltest=sqltest+" and ac.brhid='"+brid+"'";
				}
				
			}
			if(id>0){
				String clsql= ("select curid,per_tel pertel,cldocno,refname,trim(address) address,per_mob,trim(mail1) mail1,sal_name as salname,sm.doc_no as salid"
						+ " from my_acbook ac left join my_salm sm on(ac.sal_id=sm.doc_no) where  ac.dtype='CRM' and ac.status=3 " +sqltest);

				ResultSet resultSet = stmtVeh1.executeQuery(clsql);

				RESULTDATA=com.convertToJSON(resultSet);
				stmtVeh1.close();
				conn.close();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	public JSONArray contactpersonSearch(HttpSession session,int clientid) throws SQLException
	{

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
		Connection conn =null;
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			String sql= ("select cperson,c.tel as tel,area,row_no as cprowno from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientid+" and a.doc_no="+clientid+"" );
					//System.out.println("------------------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	public JSONArray currencySearch(String date,String brhid) throws SQLException  
	{
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		Statement stmt =null;
		try {
			conn = conobj.getMyConnection();
			stmt = conn.createStatement ();
			java.sql.Date sqlDate = null;
			if(!date.equals("") && date!=null) {
				sqlDate = com.changeStringtoSqlDate(date);
			}  
			String sql = "select c.doc_no curid,c.code,cb.rate rate,cb.type from my_brch b inner join my_curr c on(c.doc_no=b.curId) inner join my_curbook cb on (b.curid=cb.curid) "
					+"inner join (select max(cr.doc_no) doc_no,cr.curid curid,cr.toDate,cr.frmDate from my_curbook cr where  coalesce(toDate,curdate())>='"+sqlDate+"' and "
					+"frmDate<='"+sqlDate+"' group by cr.curid) as bo on(cb.doc_no=bo.doc_no and cb.curid=bo.curid) where b.doc_no='"+brhid+"'";  
					//System.out.println("------------------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=com.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	
}