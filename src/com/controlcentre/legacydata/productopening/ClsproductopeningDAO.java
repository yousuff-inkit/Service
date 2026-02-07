package com.controlcentre.legacydata.productopening;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;   

import net.sf.json.JSONArray;

public class ClsproductopeningDAO {

	
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	
	
	
	public   JSONArray locationsearch(String  branch) throws SQLException {

		 
	    
		JSONArray RESULTDATA=new JSONArray();
 
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
				Statement stmtmain = conn.createStatement (); 
				
 
				
	        	String pySql=("select loc_name,doc_no,brhid from my_locm where status=3 and brhid='"+branch+"'" );
  
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
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}


	
	public   JSONArray branchsearch() throws SQLException {

		 
	    
		JSONArray RESULTDATA=new JSONArray();
 
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
				Statement stmtmain = conn.createStatement (); 
				
 
				
	        	String pySql=("select branchname,doc_no from my_brch where status=3");
 
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
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}  

	public JSONArray productSearch(HttpSession session,String aa,String part_no,String productname) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		if(!aa.equalsIgnoreCase("yes"))
		{
			
			return RESULTDATA;
		}
		
		
		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sqls="";
			
			
			if(!part_no.equalsIgnoreCase("") && (!part_no.equalsIgnoreCase("0")))
			{
				sqls =" and  m.part_no like '%"+part_no+"%'";
			
			
		}
		
		
		
		if(!productname.equalsIgnoreCase("") && (!productname.equalsIgnoreCase("0")))
		{
			sqls =sqls + " and  m.productname like '%"+productname+"%'"; 
		
		
					}

			String sql="select b.brandname,m.psrno doc_no,m.part_no prodcode,m.productname prodname,um.unit,at.mspecno as specid from my_main m "
					+ "  inner join my_brand b on(m.brandid=b.doc_no) "
					+ "  left join my_unit u on(u.psrno=m.psrno)  inner join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ " left join my_unitm um on(um.doc_no=m.munit)  where   m.status=3  "+sqls+"  ";
		 
			
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	Connection conn;

	public int inset(Date dates, ArrayList<String> masterarray, HttpServletRequest request, HttpSession session) throws SQLException {
		 
		
		try
		{
			 
			
			 conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
		String userid=session.getAttribute("USERID").toString();
		String brhid=session.getAttribute("BRANCHID").toString();
		String cmpid=session.getAttribute("COMPANYID").toString();
			
			
			
			Statement stmt=conn.createStatement();
			
			int docno=0;
			ResultSet rss1=stmt.executeQuery("select coalesce((max(doc_no)+1),1)   docno from  my_prdopening");
			if(rss1.next())
			{
				docno=rss1.getInt("docno");
				
			}
			int tr_no=0;
			ResultSet rss=stmt.executeQuery("select coalesce((max(trno)+1),1)   itrno from  my_trno");
			if(rss.next())
			{
				tr_no=rss.getInt("itrno");
				
			}                        
		    
			
			String sqls="insert into my_prdopening(doc_no, date, userid, brhid, cmpid,trno) values ("+docno+",'"+dates+"',"+userid+","+brhid+","+cmpid+","+tr_no+") ";
			
			System.out.println("insert into prdopening--->"+sqls);
		int	resultSet12=stmt.executeUpdate(sqls);
		   if(resultSet12<=0)
			{
				conn.close();
				return 0;
				
			}
		
			
			
			String trnosql="insert into my_trno(edate,trtype,brhId,USERNO,trno) values(now(),10,'"+session.getAttribute("BRANCHID").toString()+"','"+session.getAttribute("USERID").toString()+"','"+tr_no+"')";
			
			int dd=stmt.executeUpdate(trnosql);
		     
					 if(dd<=0)
						{
							conn.close();
							return 0;
							
						}
		   
			 
			 
				for(int i=0;i< masterarray.size();i++){
			    	
				     String[] detmasterarrays=masterarray.get(i).split("::");
				     if(!(detmasterarrays[1].trim().equalsIgnoreCase("undefined")|| detmasterarrays[1].trim().equalsIgnoreCase("NaN")||detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()))
				     {
				    	 
	    	 
			     String sql="INSERT INTO my_prddin(sr_no,psrno,prdid,dtype,date,tr_no,op_qty,specno,cost_price,unit_price,brhid,locid)VALUES"
					       + " ("+(i+1)+","
					       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"',"
					       + "'"+(detmasterarrays[0].trim().equalsIgnoreCase("undefined") || detmasterarrays[0].trim().equalsIgnoreCase("NaN")|| detmasterarrays[0].trim().equalsIgnoreCase("")|| detmasterarrays[0].isEmpty()?0:detmasterarrays[0].trim())+"'," 
					       +"'OPN' ," 
					       +"'"+dates+"' ," 
					       +"'"+tr_no+"' ," 
					       + "'"+(detmasterarrays[1].trim().equalsIgnoreCase("undefined") || detmasterarrays[1].trim().equalsIgnoreCase("NaN")|| detmasterarrays[1].trim().equalsIgnoreCase("")|| detmasterarrays[1].isEmpty()?0:detmasterarrays[1].trim())+"',"
					       + "'"+(detmasterarrays[2].trim().equalsIgnoreCase("undefined") || detmasterarrays[2].trim().equalsIgnoreCase("NaN")|| detmasterarrays[2].trim().equalsIgnoreCase("")|| detmasterarrays[2].isEmpty()?0:detmasterarrays[2].trim())+"',"
					       + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
					        + "'"+(detmasterarrays[3].trim().equalsIgnoreCase("undefined") || detmasterarrays[3].trim().equalsIgnoreCase("NaN")||detmasterarrays[3].trim().equalsIgnoreCase("")|| detmasterarrays[3].isEmpty()?0:detmasterarrays[3].trim())+"',"
					       + "'"+(detmasterarrays[4].trim().equalsIgnoreCase("undefined") || detmasterarrays[4].trim().equalsIgnoreCase("NaN")||detmasterarrays[4].trim().equalsIgnoreCase("")|| detmasterarrays[4].isEmpty()?0:detmasterarrays[4].trim())+"',"
					       + "'"+(detmasterarrays[5].trim().equalsIgnoreCase("undefined") || detmasterarrays[5].trim().equalsIgnoreCase("NaN")||detmasterarrays[5].trim().equalsIgnoreCase("")|| detmasterarrays[5].isEmpty()?0:detmasterarrays[5].trim())+"')";
			     	//		System.out.println("=======sql============"+sql);
					     int resultSet2 = stmt.executeUpdate(sql);
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
					     
					     
					     if(i==0 || i< masterarray.size())
					     {
					      int Stockid=0;
					    	  ResultSet rssp=stmt.executeQuery("Select max(stockid)  stockid from my_prddin where dtype='OPN' limit 1 ");
					    	if(rssp.next())
					    	{
					    		Stockid=rssp.getInt("stockid");
					    		
					    	}
					    	
					    	
					    	if(i==0 )  
					    	{
					    		String sqls1="update my_prdopening set opstockid="+Stockid+" where doc_no='"+docno+"'";
					    		
					    		stmt.executeUpdate(sqls1);
					    		
					    	}
					    	 if(i< masterarray.size())
					    	{

					    		String sqls1="update my_prdopening set closestockid="+Stockid+" where doc_no='"+docno+"'";
					    		
					    		stmt.executeUpdate(sqls1);
					    		
					    	}
					    	
					    	
					    	 
					     }
					     
					     
					     
					     
					     
					 
				     }	    
					     
					     }
		   
		   
		
				
				if(docno>0)
				{
					
					
					conn.commit();
					conn.close();
					
					return docno;
				}
			
			
			
		}
		catch(Exception e)
		{
			
			e.printStackTrace();
			conn.close();
			
		}
		
		
		return 0;
	}
	
	
	
	public   JSONArray reloadsearch(String docno) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	   
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
			
				Statement stmtmain = conn.createStatement ();int trno=0;
				
	              ResultSet rs=stmtmain.executeQuery("select trno from  my_prdopening where doc_no="+docno+"");
				
				if(rs.next())
				{
					trno=rs.getInt("trno");
					
					 
				}
				
				
 
	        	String pySql=("select   p.op_qty qty, p.brhid,p.locid,br.branchname branch,l.loc_name location, b.brandname,m.psrno ,  "
	        			+ " m.part_no productid,m.productname productname,um.unit,at.mspecno as specid,p.cost_price costprice  "
	        			+ " from my_prddin p   left join my_main m on m.psrno=p.psrno and p.dtype='OPN'  "
	        			+ " left join my_brand b on(m.brandid=b.doc_no) "
	        			+ " left join my_unit u on(u.psrno=m.psrno)  left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
	        			+ " left join my_unitm um on(um.doc_no=m.munit) "
	        			+ " left join my_brch br on br.doc_no=p.brhid left join my_locm l on l.doc_no=p.locid  where p.dtype='OPN' and p.tr_no="+trno+" ");
	    
	        	
	        	
				ResultSet resultSet = stmtmain.executeQuery(pySql);
                
				System.out.println("pySql--->"+pySql);
				
				
				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
				stmtmain.close();
				
			 
			conn.close();
			  return RESULTDATA;
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	public   JSONArray mainsearch() throws SQLException {

		JSONArray RESULTDATA=new JSONArray();
	    
	   
	    
	    Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
		 
			
				Statement stmtmain = conn.createStatement (); 
	 
				
 
	        	String pySql=("select doc_no,date from  my_prdopening  ");
	    
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
	//	System.out.println(RESULTDATA);
	    return RESULTDATA;
	}
	
	
	
	
	
}
