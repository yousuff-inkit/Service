package com.controlcentre.masters.dumpmaster.waste;



	import java.sql.CallableStatement;
	import java.sql.Connection;
	import java.sql.Date;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

	import net.sf.json.JSONArray;

	import com.common.ClsCommon;
	import com.connection.ClsConnection;

	public class ClsWasteDAO {
		Connection conn;
		ClsConnection ClsConnection=new ClsConnection();
		ClsCommon ClsCommon=new ClsCommon();
		public int insert(String txtcode,String txtname , String txtdesc, HttpSession session,String mode,String formdetailcode,ArrayList list) throws SQLException {

			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				int docno;
				
				CallableStatement stmtWaste = conn.prepareCall("{CALL wasteDML(?,?,?,?,?,?,?,?)}");
				
				stmtWaste.registerOutParameter(6, java.sql.Types.INTEGER);
				stmtWaste.setString(1,txtcode);
				stmtWaste.setString(2,txtname);
				stmtWaste.setString(3,txtdesc);
				stmtWaste.setString(4,session.getAttribute("USERID").toString());
				stmtWaste.setString(5,session.getAttribute("BRANCHID").toString());
				stmtWaste.setString(7,mode);
				stmtWaste.setString(8, formdetailcode);
			    stmtWaste.executeQuery();    
			    docno=stmtWaste.getInt("docNo");
				if (docno > 0) {
					

						for(int i=0;i< list.size();i++){


							String[] surveydet=((String) list.get(i)).split("::");
							
							if(!(surveydet[1].trim().equalsIgnoreCase("undefined")|| surveydet[1].trim().equalsIgnoreCase("NaN")||surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()))
							{
								String sql1 = "";
								int refrowno=0;

								sql1="select coalesce(max(srno)+1,1) as refrowno from   sk_dumptypedet ";

								//						System.out.println("==sql1=cm_srvcsited==="+sql1);

								ResultSet resultSet1 = stmtWaste.executeQuery(sql1);
								while(resultSet1.next()){
									refrowno=resultSet1.getInt("refrowno");
								}



								String sql="INSERT INTO sk_dumptypedet(srno,wastename,wastetypeid)VALUES"
										+ " ("+refrowno+","
										+ "'"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
										+ "'"+docno+"')" ;

													//	System.out.println("==DetailsInsert==="+sql);

								int resultSet2 = stmtWaste.executeUpdate (sql);
								if(resultSet2<=0)
								{
									conn.close();
									return 0;
								}
								//conn.commit();

							}
						}
						

					
					
					conn.commit();
					stmtWaste.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtWaste.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtWaste.close();
					conn.close();
					return docno;
				}
				
			  stmtWaste.close();
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
		
		public int edit(String txtcode,String txtname , String txtdesc,int docno, HttpSession session,String mode,String formdetailcode,ArrayList list) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				   
				CallableStatement stmtWaste = conn.prepareCall("{CALL wasteDML(?,?,?,?,?,?,?,?)}");
				

				stmtWaste.setInt(6,docno);
				stmtWaste.setString(1,txtcode);
				stmtWaste.setString(2,txtname);
				stmtWaste.setString(3,txtdesc);
				stmtWaste.setString(4,session.getAttribute("USERID").toString());
				stmtWaste.setString(5,session.getAttribute("BRANCHID").toString());
				stmtWaste.setString(7,mode);
				stmtWaste.setString(8, formdetailcode);
			    stmtWaste.executeUpdate();
			    	
			    
			    docno=stmtWaste.getInt("docNo");
				if (docno > 0) {
					
					
					
					for(int i=0;i<list.size();i++){

						String[] surveydet=((String) list.get(i)).split("::");
					//	System.out.println("==sitedet0==="+surveydet[0]);
						if(!(surveydet[1].trim().equalsIgnoreCase("undefined")|| surveydet[1].trim().equalsIgnoreCase("NaN")||surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()))
						{
						
						if(!(surveydet[0].trim().equalsIgnoreCase("undefined")|| surveydet[0].trim().equalsIgnoreCase("NaN")||surveydet[0].trim().equalsIgnoreCase("")||surveydet[0].trim().equalsIgnoreCase("null")|| surveydet[0].isEmpty()))
						{
						//	System.out.println("==sitedet4==="+surveydet[4]);
							
							String sql3="update sk_dumptypedet set "
									+ "wastename='"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"' "
									+ " where wastetypeid='"+docno+"' and srno="+surveydet[0].trim()+" ";
							
				//		System.out.println("==Details-update==="+sql3);
						
							int result = stmtWaste.executeUpdate(sql3);

						}
							else{
								
								String sql="INSERT INTO sk_dumptypedet(wastename,wastetypeid)VALUES"
										+ "('"+(surveydet[1].trim().equalsIgnoreCase("undefined") || surveydet[1].trim().equalsIgnoreCase("NaN")|| surveydet[1].trim().equalsIgnoreCase("")|| surveydet[1].isEmpty()?0:surveydet[1].trim())+"',"
										+ "'"+docno+"')" ;

													//	System.out.println("==DetailsInsert==="+sql);

							

								int res = stmtWaste.executeUpdate (sql);
								//System.out.println("==res-insert==="+res);
								if(res<=0)
								{
									conn.close();
									return 0;
								}
								
							}

						}
					}
					conn.commit();
					stmtWaste.close();
					conn.close();
					return docno;
				}
				else if (docno == -1){
					stmtWaste.close();
					conn.close();
					return docno;
				}
				else if (docno == -2){
					stmtWaste.close();
					conn.close();
					return docno;
				}
				
			  stmtWaste.close();
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

		public boolean delete(int docno, HttpSession session,String mode,String formdetailcode) throws SQLException {
			try{
				conn=ClsConnection.getMyConnection();
				conn.setAutoCommit(false);
				
CallableStatement stmtWaste = conn.prepareCall("{CALL wasteDML(?,?,?,?,?,?,?,?)}");
				

				stmtWaste.setInt(6,docno);
				stmtWaste.setString(1,null);
				stmtWaste.setString(2,null);
				stmtWaste.setString(3,null);
				stmtWaste.setString(4,session.getAttribute("USERID").toString());
				stmtWaste.setString(5,session.getAttribute("BRANCHID").toString());
				stmtWaste.setString(7,mode);
				stmtWaste.setString(8, formdetailcode);
		
				int docNo = stmtWaste.executeUpdate();
				if (docNo > 0) {
					conn.commit();
					stmtWaste.close();
					conn.close();
					return true;
				}
			   stmtWaste.close();
			   conn.close();
			}catch(Exception e){
				e.printStackTrace();
				conn.close();
				return false;
			}finally{
				conn.close();
			}
			return false;
		}

		 public   JSONArray list() throws SQLException {
		        
			    JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null;

		        try {
						conn = ClsConnection.getMyConnection();
						Statement stmtVeh = conn.createStatement();
		            	
						ResultSet resultSet = stmtVeh.executeQuery ("Select * from sk_dumptype where status <> 7");
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmtVeh.close();
						conn.close();
				}catch(Exception e){
					e.printStackTrace();
					conn.close();
				}finally{
					conn.close();
				}
		        return RESULTDATA;
		    }
		 
		 
		 public   JSONArray searchDetails() throws SQLException {

		        JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null;
				try {
						conn=ClsConnection.getMyConnection();
						Statement stmtVeh1 = conn.createStatement ();
		            	String sqldata="select * from sk_dumptype where status=3";
		            	
						ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmtVeh1.close();
						conn.close();
						 return RESULTDATA;

				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }
	
		 
		 public   JSONArray wastedetailsLoad(String docno) throws SQLException {

		        JSONArray RESULTDATA=new JSONArray();
		        
		        Connection conn = null;
				try {
						conn=ClsConnection.getMyConnection();
						Statement stmtVeh1 = conn.createStatement ();
		            	String sqldata="select srno,wastename,wastetypeid typeid from sk_dumptypedet where wastetypeid='"+docno+"' ";
		            //	System.out.println("detailgridload---->"+sqldata);
						ResultSet resultSet = stmtVeh1.executeQuery (sqldata);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
						stmtVeh1.close();
						conn.close();
						 return RESULTDATA;

				}
				catch(Exception e){
					e.printStackTrace();
					conn.close();
				}
				finally{
					conn.close();
				}
				//System.out.println(RESULTDATA);
		        return RESULTDATA;
		    }


	
}
