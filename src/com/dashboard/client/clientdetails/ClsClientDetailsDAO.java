package com.dashboard.client.clientdetails;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsClientDetailsDAO {
	ClsConnection ClsConnection=new ClsConnection();

	ClsCommon ClsCommon=new ClsCommon();
	public JSONArray getClientDetails(String branch,String id) throws SQLException {
		  String strSql="";
		  System.out.println("===id=="+id);
		    JSONArray RESULTDATA=new JSONArray();
		    if(!id.equalsIgnoreCase("1")){
				return RESULTDATA;
			}   
		    Connection  conn = null;
			java.sql.Date sqlfromdate=null,sqltodate=null;
	           try {
				/*if(!fromdate.equalsIgnoreCase("")){
					sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
				}
				if(!todate.equalsIgnoreCase("")){
					sqltodate=ClsCommon.changeStringtoSqlDate(todate);
				}
				String sqltest="";
				if(sqlfromdate!=null){
					sqltest+=" and dat.edate>='"+sqlfromdate+"'";
				}
				if(sqltodate!=null){
					sqltest+=" and dat.edate<='"+sqltodate+"'";
				}
				
				if(!branch.equalsIgnoreCase("") && !branch.equalsIgnoreCase("a")){
					sqltest+=" and dat.brhid="+branch+"";
				}
				if(!hiduser.equalsIgnoreCase("")){
					sqltest+=" and dat.userid="+hiduser;
				}
				if(!hidform.equalsIgnoreCase("")){
					if(hidform.equalsIgnoreCase("5")){
						sqltest+=" and dat.dtype='INT'";
					}
					else if(hidform.equalsIgnoreCase("6")){
						sqltest+=" and dat.dtype='INS'";
					}
					else{
						sqltest+=" and menu.mno="+hidform;
					}
					
				}*/
				
					conn=ClsConnection.getMyConnection();
					Statement stmtmanual = conn.createStatement ();
					
					strSql="select 'ADD'as addbtn,doc_no, clientname, ipdetails, username, password as pwd, remarks from my_clientdetails";
				System.out.println("===clientgrid=="+strSql);
					ResultSet resultSet = stmtmanual.executeQuery (strSql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					stmtmanual.close();
					conn.close();
			}
			catch(Exception e){
				e.printStackTrace();
				conn.close();
			}
			finally{
				conn.close();
			}
			//System.out.println("RESULTDATA=========>"+RESULTDATA);
		    return RESULTDATA;
		}

}
