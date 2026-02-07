package com.seal.forexchange;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.project.execution.callRegister.ClsCallRegisterBean;
import com.skips.servicecontract.ClsServiceContractBean;


public class ClsForExchangeDAO {   
	ClsConnection conobj=new ClsConnection();
	ClsCommon com=new ClsCommon();
	ClsForExchangeBean bean = new ClsForExchangeBean(); 
	public int insert(Date sqlstartdate, Date adjustdate, String remarks, HttpSession session, String mode, HttpServletRequest request, String dtype, ArrayList<String> detailarray) throws SQLException {
		Connection conn;     
		conn=conobj.getMyConnection(); 
		Statement stmt =conn.createStatement();
		conn.setAutoCommit(false);     
	    int docno=0,vocno=0;
		CallableStatement smtService = conn.prepareCall("{call sa_forexentryDML(?,?,?,?,?,?,?,?,?)}");         
		
		smtService.setDate(1,sqlstartdate);    
		smtService.setDate(2,adjustdate);
		smtService.setString(3,remarks);
		smtService.setString(4,session.getAttribute("USERID").toString());
		smtService.setString(5,session.getAttribute("BRANCHID").toString());
		smtService.setString(6,mode);
		smtService.setString(7,dtype);
		smtService.registerOutParameter(8, java.sql.Types.INTEGER);
		smtService.registerOutParameter(9, java.sql.Types.INTEGER);       
		smtService.executeQuery();     
		docno=smtService.getInt("docNo");
		vocno=smtService.getInt("vocno");	
		request.setAttribute("vocno", vocno);
		if(docno<=0){  
			conn.close(); 
			return 0;
		}
		double netamount=0.0;
		int tranno=0;
		if(docno>0){
			//System.out.println(detailarray+"==="+detailarray); 
			
			String trsql="SELECT coalesce(max(trno)+1,1) trno FROM my_trno m";
			ResultSet tass = stmt.executeQuery (trsql);  
			if(tass.next()) {
				tranno=tass.getInt("trno");		
		    }
			String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),5,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tranno+"')";
			int dd=stmt.executeUpdate(trnosql);  
			if(dd<=0){
				conn.close();
				return 0;
			} 
			
			
			for(int i=0;i< detailarray.size();i++){ 
				double lineamount=0.0;
				int accdoc=0;
				String[] detarr = ((String) detailarray.get(i)).split("::");
				if(!(detarr[0].trim().equalsIgnoreCase("undefined") || detarr[0].trim().equalsIgnoreCase("NaN") || detarr[0].trim().equalsIgnoreCase("") || detarr[0].trim().equalsIgnoreCase("null") || detarr[0].isEmpty()))  
				{
					lineamount = detarr[1].trim().equalsIgnoreCase("undefined") || detarr[1].trim().equalsIgnoreCase("NaN")|| detarr[1].trim().equalsIgnoreCase("")|| detarr[1].isEmpty()?0.0:Double.parseDouble(detarr[1].trim());
					accdoc = detarr[0].trim().equalsIgnoreCase("undefined") || detarr[0].trim().equalsIgnoreCase("NaN")|| detarr[0].trim().equalsIgnoreCase("")|| detarr[0].isEmpty()?0:Integer.parseInt(detarr[0].trim());   
					String sql="INSERT INTO sa_forexd(acno, differences, rdocno) VALUES("     
							+ "'"+(detarr[0].trim().equalsIgnoreCase("undefined") || detarr[0].trim().equalsIgnoreCase("NaN")|| detarr[0].trim().equalsIgnoreCase("")|| detarr[0].isEmpty()?0:detarr[0].trim())+"',"
							+ "'"+(detarr[1].trim().equalsIgnoreCase("undefined") || detarr[1].trim().equalsIgnoreCase("NaN")|| detarr[1].trim().equalsIgnoreCase("")|| detarr[1].isEmpty()?0:detarr[1].trim())+"',"
							+"'"+docno+"')";         
					//System.out.println("==detarr==="+sql);  
					int resultSet2 = stmt.executeUpdate (sql);
					if(resultSet2<=0)
					{
						conn.close();
						return 0;
					}
					/* Due Date Selection*/	
					int period=0,curid=0;
					java.sql.Date sqlDuedate = null;
				    String s1sql = "SELECT coalesce(period2,0) period2,h.curid FROM my_head h LEFT JOIN my_acbook ac ON ac.cldocno=h.cldocno AND ac.dtype='crm' WHERE h.doc_no='"+accdoc+"'";  
					ResultSet s1rs = stmt.executeQuery (s1sql);
					if (s1rs.next()) {
						period = s1rs.getInt("period2");	
						curid = s1rs.getInt("curid");		
					}
					String s2sql = "SELECT DATE_ADD('"+sqlstartdate+"', INTERVAL "+period+" DAY) duedate";         
					ResultSet s2rs = stmt.executeQuery (s2sql);
					if (s2rs.next()) {
						sqlDuedate = s2rs.getDate("duedate"); 	 	
					}
					/* Due Date Selection*/	 
					double ldramt=com.Round(lineamount,2);    
					netamount = netamount + lineamount;   
					String sql1="insert into my_jvtran(date,duedate,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
					 		+ "values('"+sqlstartdate+"','"+sqlDuedate+"','',"+docno+",'"+accdoc+"','"+remarks+"','"+curid+"',1,0,"+ldramt+",0,"+(ldramt<0?-1:1)+",5,0,0,0,0,0,0,'FRX','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
				    //System.out.println("account sql ="+sql1);  
					int ss = stmt.executeUpdate(sql1);  
				    if(ss<=0){
							conn.close();
							return 0;
					}
				}
			}
		} 
		
		if(docno>0){
			int accno=0;
			String s2sql = "select acno from my_account where codeno='FOREXACCOUNT'";          
			ResultSet s2rs = stmt.executeQuery (s2sql);
			if (s2rs.next()) {
				accno = s2rs.getInt("acno");     	 	
			}
			double ldramt2=com.Round(netamount*-1,2);   
			String sql1="insert into my_jvtran(date,ref_detail,doc_no,acno,description,curId,rate,dramount,ldramount,out_amount,id,trtype,ref_row,LAGE,cldocno,lbrrate,costtype,costcode,dTYPE,brhId,tr_no,STATUS)   "
			 		+ "values('"+sqlstartdate+"','',"+docno+",'"+accno+"','"+remarks+"',1,1,0,"+ldramt2+",0,"+(ldramt2<0?-1:1)+",5,0,0,0,0,0,0,'FRX','"+session.getAttribute("BRANCHID").toString()+"',"+tranno+",3)";
		    //System.out.println("account sql ="+sql1);    
			int ss = stmt.executeUpdate(sql1);  
		    if(ss<=0){
					conn.close();
					return 0;
			}
		    
			conn.commit();
			conn.close();
			smtService.close();
			return docno;
		} 
		
		return 0;
	}
	
	public JSONArray loadData(int id, String adjdate, int docno) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		if(id==0) {  
			return RESULTDATA;
		}  
		Connection conn=null; 
		Statement stmt  =null;
		ResultSet resultSet =null;
		java.sql.Date sqladjdate=null;
		try {
			 conn = conobj.getMyConnection();
			 stmt = conn.createStatement ();
			 if(!adjdate.equals("undefined") && !(adjdate.equalsIgnoreCase("0")) && !(adjdate.equalsIgnoreCase(""))){
				 sqladjdate=com.changeStringtoSqlDate(adjdate);
		    }  
			 String strsql = "";
             if(docno>0) {
            	 strsql = "select round(d.differences,2) difference, h.description,h.doc_no,h.account from sa_forexd d left join my_head h on h.doc_no=d.acno where rdocno="+docno+"";
             }else if(id==2){
            	  strsql = "select a.*,round(ldramount,4)*-1 difference from(select h.description,h.doc_no,h.account,sum(dramount) dramount,sum(ldramount) ldramount "
     			 		+ "from my_jvtran j left join my_head h on h.doc_no=j.acno where j.status=3 and j.curid!=1 and j.date<='"+sqladjdate+"' group by j.acno)a where dramount=0 and ldramount!=0 UNION ALL SELECT a.*,ROUND(dramount-ldramount,4) difference FROM(SELECT h.description,h.doc_no,h.account,SUM(dramount*c.rate) dramount,SUM(ldramount) ldramount FROM my_jvtran j LEFT JOIN (SELECT a.rate rate,a.doc_no,a.curid FROM my_curbook a INNER JOIN(SELECT MAX(doc_no) doc_no,rate,curid,toDate,frmDate FROM my_curbook WHERE  COALESCE(toDate,CURDATE())>='"+sqladjdate+"' AND frmDate<='"+sqladjdate+"' GROUP BY curid) AS b ON(a.doc_no=b.doc_no AND a.curid=b.curid)) c ON j.curid=c.curId LEFT JOIN my_head h ON h.doc_no=j.acno WHERE j.status=3 AND j.curid!=1 and j.date<='"+sqladjdate+"' GROUP BY j.acno)a WHERE dramount<>0 and dramount<>ldramount";
             }
             else {
                 return RESULTDATA;
            //	 strsql = "select a.*,round(ldramount,4) difference from(select h.description,h.doc_no,h.account,sum(dramount) dramount,sum(ldramount) ldramount "
      		//	 		+ "from my_jvtran j left join my_head h on h.doc_no=j.acno where j.status=3 and j.curid!=1 group by j.acno)a where dramount=0 and ldramount!=0";
             }
			 System.out.println("strsql==="+strsql);  
			 resultSet = stmt.executeQuery(strsql);   
			 RESULTDATA=com.convertToJSON(resultSet);  
			 stmt.close();
			 conn.close();
		}
		catch(Exception e){
			e.printStackTrace();  
			conn.close();
		}
		return RESULTDATA;
	}
	public ClsForExchangeBean getViewdetails(HttpSession session,HttpServletRequest request,String docno) throws SQLException{

		Connection conn=null;
		try { 
			conn = conobj.getMyConnection();
			Statement stmt  = conn.createStatement ();
			String brhid=session.getAttribute("BRANCHID").toString();

			String sqls=("select m.doc_no, m.voc_no, m.date, m.adjustdate, m.remarks from sa_forex m WHERE m.status=3 AND m.voc_no='"+docno+"' AND m.brhid='"+brhid+"'");    
		    //System.out.println("===getViewdetails===="+sqls);   
			ResultSet resultSet = stmt.executeQuery(sqls);    
			while (resultSet.next()) {
				bean.setTxtremarks(resultSet.getString("remarks"));
				bean.setDocno(resultSet.getString("voc_no"));
				bean.setMasterdoc_no(resultSet.getInt("doc_no"));
				bean.setHidfrxDate(resultSet.getString("date"));
				bean.setHidAdjDate(resultSet.getString("adjustdate"));    
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
	public JSONArray ServiceMainSearch(HttpSession session, String docno, String date, String adjdate, String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        if(!check.equals("1")) {
        	return RESULTDATA;
        }
        Connection conn = null;
        Statement stmt  =null;
		ResultSet resultSet =null;
		try {
			conn = conobj.getMyConnection();
			 stmt = conn.createStatement ();
			 
			 java.sql.Date sqldate=null;
			 java.sql.Date sqladjdate=null;
			        String sqltest="";
			       
			        if(!(docno.equalsIgnoreCase("0")) && !(docno.equalsIgnoreCase(""))){
				         sqltest=sqltest+" and m.voc_no like '%"+docno+"%'";
				    }
			        
			        if(!date.equals("undefined") && !(date.equalsIgnoreCase("0")) && !(date.equalsIgnoreCase(""))){
			        	 sqldate=com.changeStringtoSqlDate(date);
				         sqltest=sqltest+" and m.date='"+sqldate+"'";
				    }
			        
			        if(!adjdate.equals("undefined") && !(adjdate.equalsIgnoreCase("0")) && !(adjdate.equalsIgnoreCase(""))){
			        	 sqladjdate=com.changeStringtoSqlDate(adjdate);
				         sqltest=sqltest+" and m.adjustdate='"+sqladjdate+"'"; 
				    }
			        
		    String salsql=("select m.doc_no, m.voc_no, m.date, m.adjustdate, m.remarks from sa_forex m WHERE m.status=3 "+sqltest+"");    
		    //System.out.println("salsql=="+salsql);
			resultSet = stmt.executeQuery(salsql);   
			RESULTDATA=com.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		}			 
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	
	}
	}	
