package com.finance.nipurchase.nipurchaserequest;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
 
 








import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
 

 









import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.finance.nipurchase.nipurchase.ClsnipurchaseBean;

public class ClsnipurchaserequestDAO  {
	ClsConnection connDAO=new ClsConnection();
	
	ClsCommon commDAO=new ClsCommon();
	Connection conn;

	public int insert(Date sqlStartDate,String requestedby, String purdesc,
			HttpSession session, String mode,ArrayList<String> descarray,String Formdetailcode,HttpServletRequest request) throws SQLException {
		
		try{
			int docno;
		
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call nipurchaserequestDML(?,?,?,?,?,?,?,?,?)}");
			stmtpurorder.registerOutParameter(7, java.sql.Types.INTEGER);
			stmtpurorder.registerOutParameter(8, java.sql.Types.INTEGER);
			stmtpurorder.setDate(1,sqlStartDate);
			stmtpurorder.setString(2,requestedby);
			stmtpurorder.setString(3,purdesc);
			stmtpurorder.setString(4,Formdetailcode);
			stmtpurorder.setString(5,session.getAttribute("USERID").toString());
			stmtpurorder.setString(6,session.getAttribute("BRANCHID").toString());
			
			stmtpurorder.setString(9,mode);
			stmtpurorder.executeQuery();
			docno=stmtpurorder.getInt("docNo");
			int vocno=stmtpurorder.getInt("vocNo");	
			request.setAttribute("vocno", vocno);
			
			if(docno<=0)
			{
				conn.close();
				return 0;
			}
			
			for(int i=0;i< descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
			    	 String sql="INSERT INTO my_srvreqd(srno,desc1,qty,brhid,rdocno)VALUES"
				       + " ("+(i+1)+","
				       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
				       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
				       + "'"+session.getAttribute("BRANCHID").toString()+"',"
				       +"'"+docno+"')";

			    	 int resultSet2 = stmtpurorder.executeUpdate(sql);
			    	 if(resultSet2<=0){
			    		 conn.close();
			    		 return 0;
			    	 }
			     }
			}
			
			if (docno > 0) {
				conn.commit();
				stmtpurorder.close();
				conn.close();
				return docno;
			}
		}catch(Exception e){	
			conn.close();
		e.printStackTrace();	
		}
		return 0;
	}

	public boolean edit(int docno,Date sqlStartDate,String requestedby, String purdesc,
			HttpSession session, String mode,ArrayList<String> descarray,String Formdetailcode) throws SQLException {
		
		try{
			conn=connDAO.getMyConnection();
			conn.setAutoCommit(false);
			CallableStatement stmtpurorder= conn.prepareCall("{call nipurchaserequestDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtpurorder.setDate(1,sqlStartDate);
			stmtpurorder.setString(2,requestedby);
			stmtpurorder.setString(3,purdesc);
			stmtpurorder.setString(4,Formdetailcode);
			stmtpurorder.setString(5,session.getAttribute("USERID").toString());
			stmtpurorder.setString(6,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setInt(7,docno);
			stmtpurorder.setInt(8,0);
			stmtpurorder.setString(9,"E");
			int aaa=stmtpurorder.executeUpdate();
			docno=stmtpurorder.getInt("docNo");
			
			if(aaa<=0)
			{
				System.out.println("=============== MASTER ==============");
				conn.close();
				return false;
			}
			
			  String delsql="Delete from my_srvreqd where rdocno="+docno+"  ";
			  stmtpurorder.executeUpdate(delsql);
			  for(int i=0;i<descarray.size();i++){
		    	
			     String[] purorderarray=descarray.get(i).split("::");
			    
			     if(!(purorderarray[1].trim().equalsIgnoreCase("undefined")|| purorderarray[1].trim().equalsIgnoreCase("NaN")||purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()))
			     {
			    	 
			    	 String sql="INSERT INTO my_srvreqd(srno,desc1,qty,brhid,rdocno)VALUES"
						       + " ("+(i+1)+","
						       + "'"+(purorderarray[1].trim().equalsIgnoreCase("undefined") || purorderarray[1].trim().equalsIgnoreCase("NaN")|| purorderarray[1].trim().equalsIgnoreCase("")|| purorderarray[1].isEmpty()?0:purorderarray[1].trim())+"',"
						       + "'"+(purorderarray[2].trim().equalsIgnoreCase("undefined") || purorderarray[2].trim().equalsIgnoreCase("NaN")|| purorderarray[2].trim().equalsIgnoreCase("")|| purorderarray[2].isEmpty()?0:purorderarray[2].trim())+"',"
						       + "'"+session.getAttribute("BRANCHID").toString()+"',"
						       +"'"+docno+"')";
		    
			int resultSet4 = stmtpurorder.executeUpdate(sql);
		 	if(resultSet4<=0)
			{
		 		System.out.println("=============== DETAILS ==============");
				conn.close();
				return false;
				
			} 
			     }
				     
				     }

			 
			if (aaa > 0) {
				conn.commit();
				stmtpurorder.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		return false;
	}

	public boolean delete(int docno,HttpSession session,String mode,String Formdetailcode) throws SQLException {
		try{
			conn=connDAO.getMyConnection();
			CallableStatement stmtpurorder= conn.prepareCall("{call nipurchaserequestDML(?,?,?,?,?,?,?,?,?)}");
			
			stmtpurorder.setDate(1,null);
			stmtpurorder.setString(2,null);
			stmtpurorder.setString(3,null);
			stmtpurorder.setString(4,Formdetailcode);
			stmtpurorder.setString(5,session.getAttribute("USERID").toString());
			stmtpurorder.setString(6,session.getAttribute("BRANCHID").toString());
			stmtpurorder.setInt(7,docno);
			stmtpurorder.setInt(8,0);
			stmtpurorder.setString(9,"D");
			
			int aaa=stmtpurorder.executeUpdate();
			
			if (aaa > 0) {
				//conn.commit();
				stmtpurorder.close();
				conn.close();
				System.out.println("Sucess");
				return true;
			}	
		}catch(Exception e){
			conn.close();
		}
		return false;
	}
	
	public JSONArray reloadnioreder(HttpSession session,String nidoc) throws SQLException {

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
	    Connection conn = null;
		try {
				conn = connDAO.getMyConnection();
				Statement stmtVeh1 = conn.createStatement ();
	        	String pySql=(" select srno,desc1 description,qty from my_srvreqd  where rdocno='"+nidoc+"'");
				ResultSet resultSet = stmtVeh1.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtVeh1.close();
				conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray mainsearch(HttpSession session,String docnoss,String requestedbyss,String datess,String descriptions,String aa) throws SQLException {

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
	  		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
	      	{
	      	sqlStartDate = commDAO.changeStringtoSqlDate(datess);
	      	}
	      	
	  		String sqltest="";
	  	    
	  	   	if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
	      	}
	      	
	  	   	if((!(requestedbyss.equalsIgnoreCase(""))) && (!(requestedbyss.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.requestedby like '%"+requestedbyss+"%'";
	      	}
	    	
	      	if((!(descriptions.equalsIgnoreCase(""))) && (!(descriptions.equalsIgnoreCase("NA")))){
	      		sqltest=sqltest+" and m.desc1 like '%"+descriptions+"%'";
	      	}
	      
	      	if(!(sqlStartDate==null)){
	      		sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
	      	}
	    
	    Connection conn = null;
		try {
			conn = connDAO.getMyConnection();
			if(aa.equalsIgnoreCase("yes"))
			{	
				Statement stmtmain = conn.createStatement ();
	        	String pySql=("select m.doc_no,m.voc_no,m.date,m.requestedby,m.desc1 description from my_srvreqm m where m.status<>7 and m.brhid='"+brcid+"' "+sqltest );
				
	        	ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=commDAO.convertToJSON(resultSet); 
				stmtmain.close();
				conn.close();
			}
			  return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public ClsnipurchaserequestBean getViewDetails(int docno, HttpSession session) throws SQLException {
		ClsnipurchaserequestBean showBean = new ClsnipurchaserequestBean();
		
		Connection conn=null;
		try { 
			conn = connDAO.getMyConnection();
		 
		Statement stmtmain = conn.createStatement ();
    
    	String pySql=("select m.doc_no,m.voc_no,m.date,m.requestedby,m.desc1 from my_srvreqm m where m.status<>7  and m.voc_no='"+docno+"' and m.brhid="+session.getAttribute("BRANCHID").toString()+" " );
    	
    	System.out.println("===viewdetails====="+pySql);
		ResultSet resultSet = stmtmain.executeQuery(pySql);  

		while (resultSet.next())
		{
			  
			  showBean.setNipurchaserequestdate(resultSet.getString("date"));
			  showBean.setRequestedby(resultSet.getString("requestedby"));
			  showBean.setPurdesc(resultSet.getString("desc1"));
			  showBean.setDocno(resultSet.getInt("voc_no"));
			  showBean.setMasterdoc_no(resultSet.getInt("doc_no"));
			 
		}
		
		stmtmain.close();
		conn.close();
		}
		catch(Exception e){
			
		e.printStackTrace();
		conn.close();
		}
		return showBean;
		
	}

	
}

	


