package com.dashboard.skips.nafithlist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsNafithListDAO {

	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getNafithData(String fromdate,String todate,String brhid,String id) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqlfilters="";
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
				sqlfilters+=" and date(nft.indatetime)>='"+sqlfromdate+"'";
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
				sqlfilters+=" and date(nft.outdatetime)<='"+sqltodate+"'";
			}
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+brhid;
			}
			conn=objconn.getMyConnection();
			String strsql="select TRIM(TRAILING '.0' FROM nft.trip) trip,nft.plate,nft.indatetime,nft.outdatetime,nft.displocation,nft.actualweight,nft.entry from gl_nafithm m left join"+
			" gl_nafith nft on m.doc_no=nft.rdocno where 1=1"+sqlfilters;
			System.out.println(strsql);
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
}
