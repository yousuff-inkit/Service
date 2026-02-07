package com.humanresource.transactions.terminationbenefits;

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
import net.sf.json.JSONObject;

import com.common.ClsAmountToWords;
import com.common.ClsCommonHR;
import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsTerminationBenefitsDAO {

	ClsCommon commonDAO = new ClsCommon();
	ClsConnection connDAO = new ClsConnection();
	ClsTerminationBenefitsBean terminationBenefitsPostingBean = new ClsTerminationBenefitsBean();
	
	public int insert(String formdetailcode, String branch,Date terminationBenfitDate, double txtdeprtotal, ArrayList<String> employeedetailsarray, ArrayList<String> journalvouchersarray, 
			HttpSession session,HttpServletRequest request,String mode) throws SQLException {
		Connection conn = null;
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			
			String userid=session.getAttribute("USERID").toString().trim();
			String company=session.getAttribute("COMPANYID").toString().trim();
			int total = 0;
			
			CallableStatement stmtTEB = conn.prepareCall("{CALL HRTerminationBenefitsmDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtTEB.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtTEB.registerOutParameter(8, java.sql.Types.INTEGER);
			
			stmtTEB.setDate(1,terminationBenfitDate);
			stmtTEB.setDouble(2,txtdeprtotal);
			stmtTEB.setString(3,formdetailcode);
			stmtTEB.setString(4,company);
			stmtTEB.setString(5,branch);
			stmtTEB.setString(6,userid);
			stmtTEB.setString(9,mode);
			int datas=stmtTEB.executeUpdate();
			if(datas<=0){
				stmtTEB.close();
				conn.close();
				return 0;
			}
			int docno=stmtTEB.getInt("docNo");
			int trno=stmtTEB.getInt("itranNo");
			request.setAttribute("tranno", trno);
			terminationBenefitsPostingBean.setTxtjvno(docno);
			if (docno > 0) {
				/*Insertion to hr_emptran,my_jvtran*/
				int insertData=insertion(conn, docno, branch, trno, formdetailcode, terminationBenfitDate, employeedetailsarray, journalvouchersarray, session,mode);
				if(insertData<=0){
					stmtTEB.close();
					conn.close();
					return 0;
				}
				/*Insertion to hr_emptran,my_jvtran Ends*/
					
				String sql1="select sum(ldramount) as jvtotal from my_jvtran where tr_no="+trno+"";
				ResultSet resultSet = stmtTEB.executeQuery(sql1);
			    
				 while (resultSet.next()) {
				 total=resultSet.getInt("jvtotal");
				 }
				 
				 if(total == 0) {
					conn.commit();
					stmtTEB.close();
					conn.close();
					return docno;
				 } else{
				        System.out.println("*=*=*=*=*=*=*=*=*=*=*=*= TOTAL IS NOT ZERO *=*=*=*=*=*=*=*=*=*=*=*=");
				        stmtTEB.close();
					    return 0;
				    }
			}
			
			stmtTEB.close();
			conn.close();
	 }catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
			conn.close();
		}
		return 0;
	}

	
	public JSONArray terminationDetailsProcessing(String branch,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = commonDAO.changeStringtoSqlDate(deprDate);
		        }
			    
				String sql = "select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.dtjoin joiningdate,m.desc_id,m.pay_catid,m.terminal_benefits,ds.desc1 designation,round(DATEDIFF('"+sqlDeprDate+"',m.dtjoin)/365,1) years "
						   + "from hr_empm m left join hr_setdesig ds on ds.doc_no=m.desc_id where m.status=3 and m.active=1 and m.terminal_benefits<'"+sqlDeprDate+"'";
						
				ResultSet resultSet = stmtTEB.executeQuery(sql);

				ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
				ClsCommonHR hrCalc = new ClsCommonHR();
				String oldempid="",newempid="",empCategoryID="";
				
				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					String tobeposteddays="0",salaryAmount="0.00";
					
					newempid=resultSet.getString("employeedocno");
					empCategoryID=resultSet.getString("pay_catid");
					
					if(oldempid!=newempid){
						temp.add(newempid);
						temp.add(resultSet.getString("employeeid"));
						temp.add(resultSet.getString("employeename"));
						temp.add(resultSet.getString("designation"));
						temp.add(resultSet.getString("joiningdate"));
						temp.add(resultSet.getString("years"));
						
						/*To be Posted Days*/
						tobeposteddays= hrCalc.getHRTerminationBenefitToBePostedDays(conn,empCategoryID,resultSet.getDouble("years"));
						temp.add(tobeposteddays);
						/*To be Posted Days Ends*/
						
						/*Salary Calculation */
						salaryAmount= hrCalc.getHRTerminationBenefitSalary(conn,newempid,empCategoryID);
						temp.add(salaryAmount);
						/*Salary Calculation Ends */
						
						temp.add("");
						temp.add("");
						temp.add("");
						
						oldempid=newempid;
					}
					
					analysisrowarray.add(temp);
				}
				
				RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				
				stmtTEB.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray terminationDetailsCalculating(String branch,String deprDate) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		
        try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
		
				java.sql.Date sqlDeprDate = null;
		        
		        if(!(deprDate.equalsIgnoreCase("undefined")) && !(deprDate.equalsIgnoreCase("")) && !(deprDate.equalsIgnoreCase("0"))){
		        	sqlDeprDate = commonDAO.changeStringtoSqlDate(deprDate);
		        }
			    
				String sql = "select m.doc_no employeedocno,m.codeno employeeid,m.name employeename,m.dtjoin joiningdate,m.desc_id,m.pay_catid,m.terminal_benefits,ds.desc1 designation,round(DATEDIFF('"+sqlDeprDate+"',m.dtjoin)/365,1) years,coalesce(round(a.alreadydepreciated,2),0) alreadydepreciated "
						   + "from hr_empm m left join hr_setdesig ds on ds.doc_no=m.desc_id left join (select coalesce(sum(posteddepr),0) alreadydepreciated,empid from hr_emptran group by empid) a on a.empid=m.doc_no where m.status=3 and m.active=1 and m.terminal_benefits<'"+sqlDeprDate+"'";
						
				ResultSet resultSet = stmtTEB.executeQuery(sql);

				ArrayList<ArrayList<String>> analysisrowarray= new ArrayList<ArrayList<String>>();
				ClsCommonHR hrCalc = new ClsCommonHR();
				String oldempid="",newempid="",empCategoryID="";
				
				while(resultSet.next()){
					ArrayList<String> temp=new ArrayList<String>();
					String tobeposteddays="0",salaryAmount="0.00",currentDepreciationAmount="0.00";
					
					newempid=resultSet.getString("employeedocno");
					empCategoryID=resultSet.getString("pay_catid");
					
					if(oldempid!=newempid){
						temp.add(newempid);
						temp.add(resultSet.getString("employeeid"));
						temp.add(resultSet.getString("employeename"));
						temp.add(resultSet.getString("designation"));
						temp.add(resultSet.getString("joiningdate"));
						temp.add(resultSet.getString("years"));
						
						/*To be Posted Days*/
						tobeposteddays= hrCalc.getHRTerminationBenefitToBePostedDays(conn,empCategoryID,resultSet.getDouble("years"));
						temp.add(tobeposteddays);
						/*To be Posted Days Ends*/
						
						/*Salary Calculation */
						salaryAmount= hrCalc.getHRTerminationBenefitSalary(conn,newempid,empCategoryID);
						temp.add(salaryAmount);
						/*Salary Calculation Ends */
						
						/*Current Depreciation Calculation */
						currentDepreciationAmount= hrCalc.getHRTerminationBenefitCurrentDepriciation(conn,tobeposteddays,salaryAmount);
						temp.add(currentDepreciationAmount);
						/*Current Depreciation Calculation Ends */
						
						temp.add(resultSet.getString("alreadydepreciated"));
						temp.add(String.valueOf(Math.round(Double.parseDouble(currentDepreciationAmount)-resultSet.getDouble("alreadydepreciated"))));
						
						oldempid=newempid;
					}
					
					analysisrowarray.add(temp);
				}
				
				RESULTDATA=convertRowAnalysisArrayToJSON(analysisrowarray);
				
				stmtTEB.close();
				conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray terminationBenefitsReloading(String docno,String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
				
				String sql = "select d.empid employeedocno, d.salary, d.worked_yrs years,d.posted_yrs daystobeposted, d.currentdepr currentdepramt,d.alreadydepr alreadydepreciated,"
						   + "d.posteddepr depr_amt,m.codeno employeeid, m.name employeename, m.dtjoin joiningdate,ds.desc1 designation from hr_emptran d left join hr_empm m on "
						   + "d.empid=m.doc_no left join hr_setdesig ds on ds.doc_no=m.desc_id where d.tr_no="+trno+" and d.doc_no="+docno+"";
		        
				ResultSet resultSet = stmtTEB.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtTEB.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }

	public JSONArray accountDetailsGridLoading() throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
				
				String sql = "select h.doc_no acno,h.account,h.description codeno from my_account a left join my_head h on a.acno=h.doc_no where a.codeno IN('HRTERMINATIONEXPENSE','HRTERMINATIONBENEFIT')";
		        
				ResultSet resultSet = stmtTEB.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtTEB.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray accountDetailsGridReloading(String trno) throws SQLException {
        
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
		try {
				conn = connDAO.getMyConnection();
				Statement stmtTEB = conn.createStatement();
            	
				String sql = "select j.acno,if(j.dramount>0,0,j.dramount*j.id) debit ,if(j.dramount<0,0,j.dramount*j.id) credit,t.account,t.description codeno "
						+ "from my_jvtran j left join my_head t on j.acno=t.doc_no WHERE j.dtype='TEB' and j.tr_no="+trno+"";
            	
				ResultSet resultSet = stmtTEB.executeQuery(sql);
				
				RESULTDATA=commonDAO.convertToJSON(resultSet);
				
				stmtTEB.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			 conn.close();
		 }
        return RESULTDATA;
    }
	
	public JSONArray tebMainSearch(String branch,String partyname,String docNo,String date,String amount) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
           
        java.sql.Date sqlDepriciationDate=null;
           
     try {
	       conn = connDAO.getMyConnection();
	       Statement stmtTEB = conn.createStatement();
	       
	       date.trim();
	        if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
	        {
	        	sqlDepriciationDate = commonDAO.changeStringtoSqlDate(date);
	        }

	        String sqltest="";
	        
	        if(!(docNo.equalsIgnoreCase(""))){
	            sqltest=sqltest+" and mv.doc_no like '%"+docNo+"%'";
	        }
	        if(!(partyname.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and u.user_name like '%"+partyname+"%'";
	        }
	        if(!(amount.equalsIgnoreCase(""))){
	         sqltest=sqltest+" and m.total like '%"+amount+"%'";
	        }
	        if(!(sqlDepriciationDate==null)){
		         sqltest=sqltest+" and m.date='"+sqlDepriciationDate+"'";
		        } 
	        
	       ResultSet resultSet = stmtTEB.executeQuery("select m.date,m.doc_no,m.total,m.tr_no,u.user_name from hr_terminationbenefitsm m left join my_user u on m.userid=u.doc_no where m.brhid='"+branch+"' and m.status=3" +sqltest);
	
	       RESULTDATA=commonDAO.convertToJSON(resultSet);
	       
	       stmtTEB.close();
	       conn.close();
     }catch(Exception e){
    	 e.printStackTrace();
    	 conn.close();
     }finally{
 		conn.close();
 	}
       return RESULTDATA;
   }
	
	public ClsTerminationBenefitsBean getPrint(HttpServletRequest request,int docNo,int branch,int header) throws SQLException {
		 ClsTerminationBenefitsBean bean = new ClsTerminationBenefitsBean();
		 Connection conn = null;
		 
		try {
			conn = connDAO.getMyConnection();
			Statement stmtTEB = conn.createStatement();
			
			int trno=0;
			
			String headersql="select if(m.dtype='TEB','Termination Benefits','  ') vouchername,c.company,c.address,c.tel,c.fax,lc.loc_name location,b.branchname,b.pbno,b.stcno,"
					+ "b.cstno from hr_terminationbenefitsm m inner join my_brch b on m.brhid=b.doc_no inner join my_comp c on b.cmpid=c.doc_no inner join my_locm l on l.brhid=b.doc_no "
					+ "inner join (select min(lo.loc) loc,lo.loc_name,lo.brhid from my_locm lo group by brhid) as lc on(lc.loc=l.loc and lc.brhid=b.doc_no) where m.dtype='TEB' "
					+ "and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSetHead = stmtTEB.executeQuery(headersql);
			
			while(resultSetHead.next()){
				
				bean.setLblcompname(resultSetHead.getString("company"));
				bean.setLblcompaddress(resultSetHead.getString("address"));
				bean.setLblprintname(resultSetHead.getString("vouchername"));
				bean.setLblcomptel(resultSetHead.getString("tel"));
				bean.setLblcompfax(resultSetHead.getString("fax"));
				bean.setLblbranch(resultSetHead.getString("branchname"));
				bean.setLbllocation(resultSetHead.getString("location"));
				bean.setLblcstno(resultSetHead.getString("cstno"));
				bean.setLblpan(resultSetHead.getString("pbno"));
				bean.setLblservicetax(resultSetHead.getString("stcno"));
				bean.setLblpobox(resultSetHead.getString("pbno"));
			}

			ClsAmountToWords c = new ClsAmountToWords();
			
			String sqls="select m.doc_no,DATE_FORMAT(m.date ,'%d-%m-%Y') date,round(m.total,2) deprtotal,m.tr_no,u.user_name from hr_terminationbenefitsm m left join my_user u on "
					+ "m.userid=u.doc_no where m.dtype='TEB' and m.brhid="+branch+" and m.doc_no="+docNo+"";
				
			ResultSet resultSets = stmtTEB.executeQuery(sqls);
			
			while(resultSets.next()){
				
				bean.setLblvoucherno(resultSets.getString("doc_no"));
				bean.setLbldate(resultSets.getString("date"));
				bean.setLbldepreciationtotal(resultSets.getString("deprtotal"));
				bean.setLbldebittotal(resultSets.getString("deprtotal"));
				bean.setLblcredittotal(resultSets.getString("deprtotal"));
				bean.setLblnetamount(resultSets.getString("deprtotal"));
				bean.setLblnetamountwords(c.convertAmountToWords(resultSets.getString("deprtotal")));
				bean.setLblpreparedby(resultSets.getString("user_name"));
				trno=resultSets.getInt("tr_no");
			}
			
			bean.setTxtheader(header);
			
			String sql1 = "";

			sql1 = "select j.acno,if(j.dramount>0,round(j.dramount*j.id,2),'  ') debit ,if(j.dramount<0,round(j.dramount*j.id,2),'  ') credit,t.account,t.description codeno "
					+ "from my_jvtran j left join my_head t on j.acno=t.doc_no WHERE j.dtype='TEB' and j.tr_no="+trno+"";
				
			ResultSet resultSet1 = stmtTEB.executeQuery(sql1);
			
			ArrayList<String> printaccounting= new ArrayList<String>();
			
			while(resultSet1.next()){
				bean.setFirstarray(1);
				String temp="";
				temp=resultSet1.getString("account")+"::"+resultSet1.getString("codeno")+"::"+resultSet1.getString("debit")+"::"+resultSet1.getString("credit");
				printaccounting.add(temp);
			}
			
			request.setAttribute("printaccounting", printaccounting);

			String sql2 = "";
			
			 sql2 = "select d.empid employeedocno, round(d.posted_yrs,1) daystobeposted, round(d.currentdepr,2) currentdepr,round(d.alreadydepr,2) alreadydepr,round(d.posteddepr,2) posteddepr,m.codeno employeeid, m.name employeename, DATE_FORMAT(m.dtjoin,'%d-%m-%Y') joiningdate from hr_emptran d left join hr_empm m on "
				  + "d.empid=m.doc_no where d.tr_no="+trno+" and d.doc_no="+docNo+"";
			 
			ResultSet resultSet2 = stmtTEB.executeQuery(sql2);
			
			ArrayList<String> printarray= new ArrayList<String>();
			
			while(resultSet2.next()){
				bean.setSecarray(2); 
				String temp="";
				temp=resultSet2.getString("employeeid")+"::"+resultSet2.getString("employeename")+"::"+resultSet2.getString("joiningdate")+"::"+resultSet2.getString("daystobeposted")+"::"+resultSet2.getString("currentdepr")+"::"+resultSet2.getString("alreadydepr")+"::"+resultSet2.getString("posteddepr");
			    printarray.add(temp);
			}

			request.setAttribute("printingarray", printarray);
			
			String sql3 = "select max(DATE_FORMAT(d.edate,'%d-%m-%Y')) preparedon,max(DATE_FORMAT(d.edate,'%H:%i:%s')) preparedat from hr_terminationbenefitsm m inner join datalog d on (m.doc_no=d.doc_no and m.dtype=d.dtype and m.brhid=d.brhid) where m.dtype='TEB' and m.brhid="+branch+" and m.doc_no="+docNo+"";
			
			ResultSet resultSet3 = stmtTEB.executeQuery(sql3);
			
			while(resultSet3.next()){
				bean.setLblpreparedon(resultSet3.getString("preparedon"));
				bean.setLblpreparedat(resultSet3.getString("preparedat"));
			}
		
			stmtTEB.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
		return bean;
	}
	
	public  JSONArray convertRowAnalysisArrayToJSON(ArrayList<ArrayList<String>> rowsAnalysisList) throws Exception {
		JSONArray jsonArray = new JSONArray();
		
		for (int i = 0; i < rowsAnalysisList.size(); i++) {
			
			JSONObject obj = new JSONObject();
			ArrayList<String> analysisRowArray=rowsAnalysisList.get(i);
			
			obj.put("employeedocno",analysisRowArray.get(0));
			obj.put("employeeid",analysisRowArray.get(1));
			obj.put("employeename",analysisRowArray.get(2));
			obj.put("designation",analysisRowArray.get(3));
			obj.put("joiningdate",analysisRowArray.get(4));
			obj.put("years",analysisRowArray.get(5));
			obj.put("daystobeposted",analysisRowArray.get(6));
			obj.put("salary",analysisRowArray.get(7));
			obj.put("currentdepramt",analysisRowArray.get(8));
			obj.put("alreadydepreciated",analysisRowArray.get(9));
			obj.put("depr_amt",analysisRowArray.get(10));
			
			jsonArray.add(obj);
		}
		return jsonArray;
		}
	
	public int insertion(Connection conn,int docno,String branch,int trno,String formdetailcode,Date terminationBenfitDate, ArrayList<String> employeedetailsarray,ArrayList<String> journalvouchersarray,
			 HttpSession session,String mode) throws SQLException{
		
		  try{
				conn.setAutoCommit(false);
				CallableStatement stmtTEB;
				Statement stmtTEB1 = conn.createStatement();
				
				String userid=session.getAttribute("USERID").toString().trim();
				
				/*Termination Benefits Details Grid and Details Saving*/
				for(int i=0;i< employeedetailsarray.size();i++){
					String[] terminationbenefitsdetail=employeedetailsarray.get(i).split("::");
					if(!terminationbenefitsdetail[0].trim().equalsIgnoreCase("undefined") && !terminationbenefitsdetail[0].trim().equalsIgnoreCase("NaN")){
					
					int accountNo=0;
					/*Selecting account no.*/
					String sqls=("select acno from my_account where codeno='HRTERMINATIONBENEFIT'");
					ResultSet resultSets = stmtTEB1.executeQuery(sqls);
					    
					 while (resultSets.next()) {
						 accountNo=resultSets.getInt("acno");
					 }
					 /*Selecting account no. Ends*/
					 
					stmtTEB = conn.prepareCall("{CALL HRTerminationBenefitsdDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to hr_emptran*/
					stmtTEB.setInt(12,trno); 
					stmtTEB.setInt(13,docno);
					stmtTEB.registerOutParameter(14, java.sql.Types.INTEGER);
					
					stmtTEB.setDate(1,terminationBenfitDate); //Date
					stmtTEB.setInt(2,accountNo);  //doc_no of my_head
					stmtTEB.setString(3,(terminationbenefitsdetail[0].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[0].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[0].trim().isEmpty()?0:terminationbenefitsdetail[0].trim()).toString()); //Employee ID
					stmtTEB.setString(4,(terminationbenefitsdetail[1].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[1].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[1].trim().isEmpty()?0:terminationbenefitsdetail[1].trim()).toString()); //Salary To be processed Amount
					stmtTEB.setString(5,(terminationbenefitsdetail[2].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[2].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[2].trim().isEmpty()?0:terminationbenefitsdetail[2].trim()).toString()); //Current Depreciation Amount
					stmtTEB.setString(6,(terminationbenefitsdetail[3].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[3].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[3].trim().isEmpty()?0:terminationbenefitsdetail[3].trim()).toString()); //Already Depreciation Amount
					stmtTEB.setString(7,(terminationbenefitsdetail[4].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[4].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[4].trim().isEmpty()?0:terminationbenefitsdetail[4].trim()).toString()); //To be Depreciated Amount
					stmtTEB.setString(8,(terminationbenefitsdetail[5].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[5].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[5].trim().isEmpty()?0:terminationbenefitsdetail[5].trim()).toString()); //Worked
					stmtTEB.setString(9,(terminationbenefitsdetail[6].trim().equalsIgnoreCase("undefined") || terminationbenefitsdetail[6].trim().equalsIgnoreCase("NaN") || terminationbenefitsdetail[6].trim().isEmpty()?0:terminationbenefitsdetail[6].trim()).toString()); //To be Posted
					
					stmtTEB.setString(10,formdetailcode);
					stmtTEB.setString(11,branch);
					stmtTEB.setString(15,mode);
					int detail=stmtTEB.executeUpdate();
						if(detail<=0){
							stmtTEB.close();
							conn.close();
							return 0;
						}
     				  }
				    }
				    /*Termination Benefits Details Grid and Details Saving Ends*/
				
					/*Journal Voucher Grid Saving*/
					for(int i=0;i< journalvouchersarray.size();i++){
					String[] journal=journalvouchersarray.get(i).split("::");
					if(!journal[0].trim().equalsIgnoreCase("undefined") && !journal[0].trim().equalsIgnoreCase("NaN")){
					
					stmtTEB = conn.prepareCall("{CALL HRTerminationBenefitsJournaldDML(?,?,?,?,?,?,?,?,?,?,?,?)}");
					
					/*Insertion to my_jvtran*/
					stmtTEB.setInt(10,docno);
					stmtTEB.setInt(11,trno);
					stmtTEB.setDate(1,terminationBenfitDate); //Date
					stmtTEB.setString(2,"TEB - "+docno);
					stmtTEB.setInt(3,(i+1)); //SR_No
					stmtTEB.setString(4,(journal[0].trim().equalsIgnoreCase("undefined") || journal[0].trim().equalsIgnoreCase("NaN") || journal[0].trim().isEmpty()?0:journal[0].trim()).toString());  //doc_no of my_head
					stmtTEB.setString(5,(journal[1].trim().equalsIgnoreCase("undefined") || journal[1].trim().equalsIgnoreCase("NaN") || journal[1].trim().isEmpty()?0:journal[1].trim()).toString()); //amount
					stmtTEB.setString(6,(journal[2].trim().equalsIgnoreCase("undefined") || journal[2].trim().equalsIgnoreCase("NaN") || journal[2].trim().isEmpty()?0:journal[2].trim()).toString()); //credit -1 & debit 1
					stmtTEB.setString(7,formdetailcode);
					stmtTEB.setString(8,branch);
					stmtTEB.setString(9,userid);
					stmtTEB.setString(12,mode);
					stmtTEB.execute();
						
					if(stmtTEB.getInt("docNo")<=0){
						stmtTEB.close();
						conn.close();
						return 0;
					}
					/*my_jvtran Grid Saving Ends*/
						
					 stmtTEB.close();
					 }
				}	
					
				/*Deleting amount of value zero*/
				String sql2=("DELETE FROM hr_emptran where TR_NO="+trno+" and posteddepr=0");
			    int data = stmtTEB1.executeUpdate(sql2);
			    /*Deleting amount of value zero ends*/
			    
			    stmtTEB1.close();
	   } catch(Exception e){	
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }
		return 1;
	}
}
