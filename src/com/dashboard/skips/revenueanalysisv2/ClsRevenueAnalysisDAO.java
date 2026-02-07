package com.dashboard.skips.revenueanalysisv2;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClsRevenueAnalysisDAO {

	ClsConnection objconn = new ClsConnection();
	ClsCommon objcommon = new ClsCommon();
	ArrayList<String> revarray = new ArrayList<String>();  
	int slno = 0, parentid = 0;  
	public JSONArray getRevenueAnalysisSummary(String fromdate,String todate,String brhid,String groupby,String id, String topclschk) throws SQLException{
		JSONArray data=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return data;
		}
		Connection conn=null;
		try{
			java.sql.Date sqlfromdate=null,sqltodate=null;
			String sqlfilters="",colname="",sqljoin="",groupcol="", ordercol="", sqlselect="", sqlorderby="",sqljoin1="";
			
			if(!fromdate.equalsIgnoreCase("")){
				sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(sqlfromdate!=null && sqltodate!=null){
				sqlfilters+=" and m.fromdate between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+brhid;
			}
			
			if(groupby.equalsIgnoreCase("AC")) {
				colname="md.description";
				groupcol="d.idno";
				sqljoin=" left join sk_invmode md on md.idno=d.idno ";
				sqlselect="md.groups,"; 
				sqlorderby=" order by groups";
				
			}else if(groupby.equalsIgnoreCase("CT")) {
				colname="case when c.billingmethod=1 then 'Monthly' when c.billingmethod=2 then 'Yearly' when c.billingmethod=3 then 'Adhoc' else 'Direct' end as ";  
				groupcol="c.billingmethod";
				
			}else if(groupby.equalsIgnoreCase("SM")) {
				colname="coalesce(sm.sal_name,'Direct')";  
				sqljoin=" left join my_salm sm on sm.doc_no=c.sal_id ";
				groupcol="c.sal_id";
				
			}else if(groupby.equalsIgnoreCase("SS")) {
				colname="coalesce(sk.name,'Direct')";
				sqljoin=" left join sk_skiptype sk on sk.doc_no=sd.skiptype ";
				groupcol="sd.skiptype";
				
			}else if(groupby.equalsIgnoreCase("WT")) {
				colname="coalesce(ds.name,'Direct')";  
				sqljoin=" left join sk_dumptype ds on ds.doc_no=sd.wastetype ";
				groupcol="sd.wastetype";
				
			}else if(groupby.equalsIgnoreCase("OW")) {
				colname="coalesce(r1.name,'Direct')";
				sqljoin=" left join sk_enqrelated r1 on (r1.srno=sd.ownershipid and r1.type='SERVICEBY') ";
				groupcol="sd.ownershipid";
				
			}else if(groupby.equalsIgnoreCase("CL")) {
				groupcol="sd.ownershipid";
			}else if(groupby.equalsIgnoreCase("TF")) {
				colname="coalesce(sk.name,'Direct')";
				sqljoin="left join sk_enqrelated sk on (sk.srno=sd.tippingmethod and sk.type='TIPPINGFEEMETHOD') ";
				sqljoin1=" left join (select sum(tr.executedtrip) executedtrip ,t.invno invno from sk_tippingdet t left join  sk_triptotal tr on tr.srno=t.totsrno where  t.ddate between '"+sqlfromdate+"' and  '"+sqltodate+"' group by t.invno) t on a.doc_no=t.invno ";	
				groupcol="sd.tippingmethod";
			}else if(groupby.equalsIgnoreCase("AT")) {
				sqljoin=" left join (select sum(tr.executedtrip) executedtrip ,t.invno invno from sk_tippingdet t left join  sk_triptotal tr on tr.srno=t.totsrno where  t.ddate between '"+sqlfromdate+"' and  '"+sqltodate+"' group by t.invno) t on a.doc_no=t.invno  ";
				groupcol="c.billingmethod";
			}else {}
			
			if(topclschk.equalsIgnoreCase("1") && groupby.equalsIgnoreCase("CL")) {     
				ordercol=" sum(coalesce(d.nettotal,0)) desc limit 25";  
			}else {
				ordercol=groupcol;         
			}
			
			conn=objconn.getMyConnection();
			if(groupby.equalsIgnoreCase("AC")) {
				groupbyAccount(conn,  "",  "", "", "","","","","","",sqlfilters, ordercol);  
			}else if(groupby.equalsIgnoreCase("CT")) {
				groupbyContractType(conn,  "","","", "","","","",sqlfilters, ordercol);   
			}else if(groupby.equalsIgnoreCase("SM")) {
				groupbySalesman(conn,  sqlselect,  colname,  sqljoin,  sqlfilters,  groupcol,  ordercol,  sqlorderby);
			}else if(groupby.equalsIgnoreCase("SS")) {
				groupbySkipsize(conn,  sqlselect,  colname,  sqljoin,  sqlfilters,  groupcol,  ordercol,  sqlorderby);
	        }else if(groupby.equalsIgnoreCase("WT")) {
				groupbyWastetype(conn,  sqlselect,  colname,  sqljoin,  sqlfilters,  groupcol,  ordercol,  sqlorderby);
	        }else if(groupby.equalsIgnoreCase("OW")) {
				groupbyOwnership(conn,  sqlselect,  colname,  sqljoin,  sqlfilters,  groupcol,  ordercol,  sqlorderby);
	        }else if(groupby.equalsIgnoreCase("CL")) {
	        	groupbyClient(conn,  sqlselect,  colname,  sqljoin,  sqlfilters,  groupcol,  ordercol,  sqlorderby);
	        }else if(groupby.equalsIgnoreCase("TF")) {
	        	groupbyTippingfee(conn,  sqlselect,  colname,  sqljoin,  sqljoin1, sqlfilters,  groupcol,  ordercol,  sqlorderby);
	        }else if(groupby.equalsIgnoreCase("AT")) {
	        	groupbyActualTrip(conn,  sqlselect,  colname,  sqljoin,  sqlfilters,  groupcol,  ordercol,  sqlorderby);
	        }else {
				
			}
			
			data = convertArrayToJSONRevenue(revarray);   
			//System.out.println("revarray="+revarray);
		//	System.out.println("data="+data);  
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	
	
	public void groupbyActualTrip(Connection conn, String sqlselect, String colname, String sqljoin, String sqlfilters, String groupcol, String ordercol, String sqlorderby) {     
			Statement stmt;    
			try {
				stmt = conn.createStatement(); 
			
				int parentchk = 0, superparent = 0;  
				
				String strsql="select sum(coalesce(executedtrip,0)) nooftrips , case when a.bill=1 then 'Monthly' when a.bill=2 then 'Yearly' when a.bill=3 then 'Adhoc' else 'Direct' end as refname, a.bill, sum(a.amount) amount from ( select  m.doc_no,  " + 
						"sum(coalesce(d.nettotal,0)) amount, coalesce(c.billingmethod,0) bill from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no  where m.status=3 "+sqlfilters+" group by m.doc_no)a  "+sqljoin+" group by a.bill order by a.bill";           
			//	System.out.println("---ACTUAL TRIP  QUERY---"+strsql);     
				ResultSet rs = stmt.executeQuery(strsql); 
				String refname="", cnttype="", subparent = "Total", salid="",skipid="", waseteid="",ownid="",own="",clientid="",ownids="",bill="",nooftrips="";   
				double amount = 0.0, granttotal = 0.0;    
				superparent = slno;
				while(rs.next()) {  
					     refname  = rs.getString("refname");     
					     amount  = rs.getDouble("amount"); 
					     bill  = rs.getString("bill"); 
					     nooftrips = rs.getString("nooftrips");
					     granttotal += amount; 
					     slno++; 
					     if(refname.equalsIgnoreCase("Direct")) {
					    	 if(parentchk==0) {
					    		 revarray.add(slno+":: ::"+refname+"::"+amount+"::"+nooftrips+" :: ::  :: ");
					    	 }else {
					    		 revarray.add(slno+"::"+superparent+"::"+refname+"::"+amount+"::"+nooftrips+" ::  ::  :: ");     
					    	 }
					     }else {
					    	 if(parentchk==0) {   
					    		 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+"::"+nooftrips+" :: :: :: ");
					    	 }else {
					    		 revarray.add(slno+"::"+superparent+"::"+refname+"::"+amount+"::"+nooftrips+" :: ::  :: ");     
					    	 }
					    	 groupbyAccount(conn,  cnttype,  salid,skipid,waseteid,ownid,ownids,clientid,own,bill,sqlfilters, ordercol);
					     }
				}
				slno++;   
				revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: ::  :: ");   
			} catch (SQLException e) {
				e.printStackTrace();          
			}
		}
	
	
	
	public void groupbyTippingfee(Connection conn, String sqlselect, String colname, String sqljoin,String sqljoin1, String sqlfilters, String groupcol, String ordercol, String sqlorderby) {     
		Statement stmt;      
		try {
			stmt = conn.createStatement();   
			String strsql="select  refname,sum(coalesce(a.amount,0)) amount,tipid,sum(coalesce(t.executedtrip,0)) nooftrips from (select "+sqlselect+""+colname+" refname,sum(coalesce(d.nettotal,0)) amount, coalesce(sk.srno,0) tipid,sd.tippingmethod,m.doc_no from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "+
					sqljoin+"where m.status=3 "+sqlfilters+" group by m.doc_no)a "+sqljoin1+"  group by a.tippingmethod order by a.tippingmethod";  
		//	System.out.println("---TIPPING FEE QUERY---"+strsql);      
			ResultSet rs = stmt.executeQuery(strsql); 
			 
			String refname="", subparent = "Total",nooftrips="";   
			double amount = 0.0, granttotal = 0.0;       
			while(rs.next()) {  
				     refname  = rs.getString("refname");     
				     amount  = rs.getDouble("amount"); 
				     nooftrips = rs.getString("nooftrips");
					granttotal += amount; 
				     slno++; 
				     if(refname.equalsIgnoreCase("Direct")) {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+"::"+nooftrips+" :: :: :: ");
				     }else {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+"::"+nooftrips+" :: :: :: ");   
				    	
				     }
			}
			slno++;   
			revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: :: ::  ");   
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public void groupbyClient(Connection conn, String sqlselect, String colname, String sqljoin, String sqlfilters, String groupcol, String ordercol, String sqlorderby) {     
			Statement stmt;      
			
			   		   
		try {
			stmt = conn.createStatement();   
			String strsqls="select a.* from(select if(sd.ownershipid=2,r1.name,coalesce(ac.refname,'Direct'))  refname,sum(coalesce(d.nettotal,0)) amount, coalesce(r1.srno,0) own,coalesce(ac.cldocno,0) clientid,COUNT(*) grouppp from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no  left join sk_enqrelated r1 on (r1.srno=sd.ownershipid and r1.type='SERVICEBY')\r\n" + 
					" left join my_acbook ac on ac.cldocno=c.cldocno and ac.dtype='CRM' where m.status=3 "+sqlfilters+" group by if(sd.ownershipid=2,sd.ownershipid,c.cldocno) order by "+ordercol+" )a";  
			//System.out.println("---CLIENT QUERY--"+strsqls);     
			ResultSet rs = stmt.executeQuery(strsqls); 
			 
			String refname="", subparent = "Total",clientid="",waseteid="",ownid="",own="",skipid="",cnttype="",ownids="",salid="",bill="",grouppp="";   
			double amount = 0.0, granttotal = 0.0;       
			while(rs.next()) {  
				     refname  = rs.getString("refname");     
				     amount  = rs.getDouble("amount"); 
				     clientid  = rs.getString("clientid");         
				     own  = rs.getString("own");    
				     grouppp  = rs.getString("grouppp");    
					 granttotal += amount; 
				     slno++; 
				     if(refname.equalsIgnoreCase("Direct")) {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: :: "+grouppp+" ");
				     }else {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: :: "+grouppp+" :: ");   
				    	 groupbyAccount(conn,  cnttype,  salid,skipid,waseteid,ownid,ownids,clientid,own,bill,sqlfilters, ordercol);
				     }		    	
			}
			slno++;   
			revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: :: :: ");   
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	

	public void Ownershipdet(Connection conn, String sqlselect, String colname, String sqljoin, String ownid, String ownids,String sqlfilters, String groupcol, String ordercol, String sqlorderby) {      
		Statement stmt;            
try {
	stmt = conn.createStatement(); 
	String sqltest="";  
	int parentchk = 0, superparent = 0;  
	if(!ownid.equals("0") && !ownid.equals("")) {  
		sqltest = " and sd.ownershipid = '"+ownid+"' ";     
		parentchk = 1;
	}else {
		
	}

	String strsql="select coalesce(sk.name,'Direct') refname,sum(coalesce(d.nettotal,0)) amount, coalesce(sk.doc_no,0) ownids,coalesce(sd.ownershipid,0) ownid,COUNT(*) count from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no left join sk_skiptype sk on sk.doc_no=sd.skiptype where m.status=3 "+sqltest+" "+sqlfilters+" group by sd.skiptype order by sd.skiptype";  
//	System.out.println("---OWN DET QUERY---"+strsql);     
	
	
	ResultSet rs = stmt.executeQuery(strsql); 
	String refname="", cnttype="", subparent = "Total",salid="",waseteid="",clientid="",own="",skipid="",bill="",count="";   
	double amount = 0.0, granttotal = 0.0;    
	superparent = slno;
	while(rs.next()) {  
		     refname  = rs.getString("refname");     
		     amount  = rs.getDouble("amount"); 
		     ownids  = rs.getString("ownids");  
		     ownid  = rs.getString("ownid"); 
		     count  = rs.getString("count"); 
		     granttotal += amount; 
		     slno++; 
		     if(refname.equalsIgnoreCase("Direct")) {
		    	 if(parentchk==0) {
		    		 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: "+count+" :: ::");
		    	 }else {
		    		 revarray.add(slno+"::"+superparent+"::"+refname+"::"+amount+"::  :: "+count+" :: ::");     
		    	 }
		     }else {
		    	 if(parentchk==0) {   
		    		 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: "+count+" :: :: ");
		    	 }else {
		    		 revarray.add(slno+"::"+superparent+"::"+refname+"::"+amount+"::  :: "+count+" :: :: ");     
		    	 }
		    	 groupbyAccount(conn,  cnttype,  salid,skipid,waseteid,ownid,ownids,clientid,own,bill,sqlfilters, ordercol);
		     }
	}
	slno++;   
	revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: :: :: ");   
} catch (SQLException e) {
	e.printStackTrace();          
  }
}
	

	
	public void groupbyOwnership(Connection conn, String sqlselect, String colname, String sqljoin, String sqlfilters, String groupcol, String ordercol, String sqlorderby) {     
		Statement stmt;      
		try {
			stmt = conn.createStatement();   
			String strsql="select a.* from(select "+sqlselect+""+colname+" refname,sum(coalesce(d.nettotal,0)) amount, coalesce(r1.srno,0) ownid,COUNT(*) count from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "+
					sqljoin+"where m.status=3 "+sqlfilters+" group by "+groupcol+" order by "+ordercol+")a "+sqlorderby+"";  
		//	System.out.println("---OWNERSHIP QUERY--"+strsql);     
			ResultSet rs = stmt.executeQuery(strsql); 
			 
			String refname="", subparent = "Total",ownid="",ownids="",count="";   
			double amount = 0.0, granttotal = 0.0;       
			while(rs.next()) {  
				     refname  = rs.getString("refname");     
				     amount  = rs.getDouble("amount"); 
				     ownid  = rs.getString("ownid");  
				     count  = rs.getString("count");         
				     granttotal += amount; 
				     slno++; 
				     if(refname.equalsIgnoreCase("Direct")) {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+"::  :: "+count+" :: ::");
				     }else {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+"::  :: "+count+" :: :: ");   
				    	 Ownershipdet(conn,sqlselect,colname,sqljoin, ownid,ownids,sqlfilters, groupcol,ordercol, sqlorderby) ;     
				     }		    	
			}
			slno++;   
			revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: :: :: ");   
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public void groupbyWastetype(Connection conn, String sqlselect, String colname, String sqljoin, String sqlfilters, String groupcol, String ordercol, String sqlorderby) {     
		Statement stmt;      
		try {
			stmt = conn.createStatement();   
			String strsql="select a.* from(select "+sqlselect+""+colname+" refname,sum(coalesce(d.nettotal,0)) amount, coalesce(ds.doc_no,0) waseteid from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "+
					sqljoin+"where m.status=3 "+sqlfilters+" group by "+groupcol+" order by "+ordercol+")a "+sqlorderby+"";  
		//	System.out.println("---WASTETYPE QUERY---"+strsql);     
			ResultSet rs = stmt.executeQuery(strsql); 
			 
			String refname="", salid="", subparent = "Total",skipid="",waseteid="",ownid="",clientid="",own="",cnttype="",ownids="",bill="";   
			double amount = 0.0, granttotal = 0.0;       
			while(rs.next()) {  
				     refname  = rs.getString("refname");     
				     amount  = rs.getDouble("amount"); 
				     waseteid  = rs.getString("waseteid");         
				     granttotal += amount; 
				     slno++; 
				     if(refname.equalsIgnoreCase("Direct")) {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: :: :: ");
				     }else {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: :: :: ");   
				    	 groupbyAccount(conn,  cnttype,  salid,skipid,waseteid,ownid,ownids,clientid,own,bill,sqlfilters, ordercol);
				     }
			}
			slno++;   
			revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: :: :: ");   
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public void groupbySkipsize(Connection conn, String sqlselect, String colname, String sqljoin, String sqlfilters, String groupcol, String ordercol, String sqlorderby) {     
		Statement stmt;      
		try {
			stmt = conn.createStatement();   
			String strsql="select a.* from(select "+sqlselect+""+colname+" refname,sum(coalesce(d.nettotal,0)) amount, coalesce(sk.doc_no,0) skipid,COUNT(*) count from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "+
					sqljoin+"where m.status=3 "+sqlfilters+" group by "+groupcol+" order by "+ordercol+")a "+sqlorderby+"";  
			//System.out.println("---SKIPSIZE QUERY---"+strsql);     
			ResultSet rs = stmt.executeQuery(strsql); 
			 
			String refname="", salid="", waseteid="",subparent = "Total",skipid="",ownid="",own="",clientid="",ownids="",count="";   
			double amount = 0.0, granttotal = 0.0;       
			while(rs.next()) {  
				     refname  = rs.getString("refname");     
				     amount  = rs.getDouble("amount"); 
				     skipid  = rs.getString("skipid");         
				     count  = rs.getString("count");         
					 granttotal += amount; 
				     slno++; 
				     if(refname.equalsIgnoreCase("Direct")) {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: "+count+" :: :: ");
				     }else {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: "+count+" :: ::  ");   
				    	groupbyContractType(conn,  salid, skipid,waseteid,ownid,ownids,clientid,own,sqlfilters, ordercol);   
				     }
			}
			slno++;   
			revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: :: :: ");   
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public void groupbySalesman(Connection conn, String sqlselect, String colname, String sqljoin, String sqlfilters, String groupcol, String ordercol, String sqlorderby) {     
		Statement stmt;      
		try {
			stmt = conn.createStatement();   
			String strsql="select a.* from(select "+sqlselect+""+colname+" refname,sum(coalesce(d.nettotal,0)) amount, coalesce(sm.doc_no,0) salid from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "+
					sqljoin+"where m.status=3 "+sqlfilters+" group by "+groupcol+" order by "+ordercol+")a "+sqlorderby+"";  
			//System.out.println("---SALESMAN QUERY---"+strsql);     
			ResultSet rs = stmt.executeQuery(strsql); 
			 
			String refname="", salid="",skipid="", waseteid="",subparent = "Total",ownid="",own="",clientid="",ownids="";   
			double amount = 0.0, granttotal = 0.0;       
			while(rs.next()) {  
				     refname  = rs.getString("refname");     
				     amount  = rs.getDouble("amount"); 
				     salid  = rs.getString("salid"); 
				     granttotal += amount; 
				     slno++; 
				     if(refname.equalsIgnoreCase("Direct")) {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: :: :: ");
				     }else {
				    	 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: :: :: ");   
				    	 groupbyContractType(conn,  salid,skipid,waseteid,ownid,ownids, clientid,own,sqlfilters, ordercol);   
				     }
			}
			slno++;   
			revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: :: :: ");   
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void groupbyContractType(Connection conn, String salid,String skipid, String waseteid, String ownid,String ownids,String clientid,String own,String sqlfilters, String ordercol) {         
		Statement stmt;    
		try {
			stmt = conn.createStatement(); 
			String sqltest="";
			int parentchk = 0, superparent = 0;  
			if(!salid.equals("0") && !salid.equals("")) {  
				sqltest = " and c.sal_id = '"+salid+"' ";   
				parentchk = 1;   
			}else if(!skipid.equals("0") && !skipid.equals("")) {  
				sqltest = " and sd.skiptype = '"+skipid+"' ";   
				parentchk = 1;
			}else if(!waseteid.equals("0") && !waseteid.equals("")) {  
				sqltest = " and sd.wastetype = '"+waseteid+"' ";   
				parentchk = 1;
			}else {
				
			}
	
			String strsql="select case when c.billingmethod=1 then 'Monthly' when c.billingmethod=2 then 'Yearly' when c.billingmethod=3 then 'Adhoc' else 'Direct' end as refname,"
					+ "sum(coalesce(d.nettotal,0)) amount, coalesce(c.billingmethod,0) billingmethod,coalesce(sd.skiptype,0) skipid,coalesce(c.sal_id,0) salid ,coalesce(sd.wastetype,0) waseteid from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno "
					+ "left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no " 
					+ "where m.status=3 "+sqlfilters+""+sqltest+" group by c.billingmethod order by "+ordercol+"";           
			//System.out.println("---CONTRACT TYPE QUERY---"+strsql);     
			ResultSet rs = stmt.executeQuery(strsql); 
			String refname="", cnttype="", bill="",subparent = "Total";   
			double amount = 0.0, granttotal = 0.0;    
			superparent = slno;
			while(rs.next()) {  
				     refname  = rs.getString("refname");     
				     amount  = rs.getDouble("amount"); 
				     cnttype  = rs.getString("billingmethod");     
				     granttotal += amount; 
				     slno++; 
				     if(refname.equalsIgnoreCase("Direct")) {
				    	 if(parentchk==0) {
				    		 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: :: :: ");
				    	 }else {
				    		 revarray.add(slno+"::"+superparent+"::"+refname+"::"+amount+":: :: :: :: ");     
				    	 }
				     }else {
				    	 if(parentchk==0) {   
				    		 revarray.add(slno+"::"+null+"::"+refname+"::"+amount+":: :: :: :: ");
				    	 }else {
				    		 revarray.add(slno+"::"+superparent+"::"+refname+"::"+amount+":: :: :: :: ");     
				    	 }
				    	 groupbyAccount(conn,  cnttype,  salid,skipid,waseteid,ownid,ownids,clientid,own,bill,sqlfilters, ordercol);
				     }
			}
			
			slno++;   
			revarray.add(slno+"::"+null+"::"+subparent+"::"+granttotal+":: :: :: :: ");   
		} catch (SQLException e) {
			e.printStackTrace();          
		}
	}
	public void groupbyAccount(Connection conn, String contracttype, String salid,String skipid,String waseteid,String ownid,String ownids,String clientid,String own,String bill,String sqlfilters, String ordercol) {         
		Statement stmt;
		try {  
			stmt = conn.createStatement();   
		    String sqltest="";
		    int parentchk = 0, superparent = 0;  
		  
		    if(!contracttype.equalsIgnoreCase("0") && !contracttype.equalsIgnoreCase("") && salid.equalsIgnoreCase("") && skipid.equalsIgnoreCase("")) {  
				sqltest = " and c.billingmethod = '"+contracttype+"' ";
				parentchk = 1;
				
			} else if(!contracttype.equalsIgnoreCase("0") && !contracttype.equalsIgnoreCase("") && !(salid.equalsIgnoreCase("") && !salid.equalsIgnoreCase("0"))) {  
				sqltest = " and c.billingmethod = '"+contracttype+"' and c.sal_id='"+salid+"' ";
				parentchk = 1;
				
			} else if(!contracttype.equalsIgnoreCase("0") && !contracttype.equalsIgnoreCase("") && !(skipid.equalsIgnoreCase("") && !skipid.equalsIgnoreCase("0"))) {  
				sqltest = " and c.billingmethod = '"+contracttype+"' and sd.skiptype='"+skipid+"' ";
				parentchk = 1;
				
			}else if(!waseteid.equalsIgnoreCase("") && !waseteid.equalsIgnoreCase("0")) {  
				sqltest = " and sd.wastetype='"+waseteid+"' ";
				parentchk = 1;
				
			}else if(!ownids.equalsIgnoreCase("") && !ownids.equalsIgnoreCase("0")) {  
				sqltest = " and sd.ownershipid='"+ownid+"' and sd.skiptype= '"+ownids+"'";
				parentchk = 1;
				
			}else if(!clientid.equalsIgnoreCase("") && !clientid.equalsIgnoreCase("0") && !own.equalsIgnoreCase("2")) {  
				sqltest = " and m.cldocno='"+clientid+"' and sd.ownershipid=1 ";
				parentchk = 1;
				
			}else if(own.equalsIgnoreCase("2")) {  
				sqltest = " and sd.ownershipid=2 ";
				parentchk = 1;
			
			}else if(!bill.equalsIgnoreCase("") && !bill.equalsIgnoreCase("0")) {  
				sqltest = " and c.billingmethod = '"+bill+"'";
				parentchk = 1;
				
			}else {
				
			}
	
			String strsql="select @i:=@i+1 id, a.* from(select md.groups, md.description refname, sum(coalesce(d.nettotal,0)) amount from sk_invm m "
					+ "inner join sk_invd d on m.doc_no=d.rdocno left join sk_srvcontrm c on c.tr_no=m.cnttrno left join sk_srvcontrdet sd on sd.rdocno=c.tr_no "
					+ "left join sk_invmode md on md.idno=d.idno where m.status=3 "+sqltest+""+sqlfilters+" group by d.idno order by "+ordercol+")a,(select @i:=0)b  order by groups"; 
		//	System.out.println("---ACCOUNT QUERY---"+strsql);         
			ResultSet rs = stmt.executeQuery(strsql);   
			 
			String refname="", groups="", groups1="", subparent = "Sub Total", subparent1 = "Grand Total";    
			double amount = 0.0, subtotal = 0.0, granttotal = 0.0; 
			superparent = slno;
			while(rs.next()) {
				     //parentid = slno;
				     refname  = rs.getString("refname");     
				     groups  = rs.getString("groups");
				     amount  = rs.getDouble("amount"); 
				     granttotal += amount; 
				     if(slno==0) {
				    	 slno++; 
				    	 parentid = slno;
				    	 superparent = slno;  
				    	 groups1  = rs.getString("groups");
				    	 if(parentchk==0) {
				    		 revarray.add(slno+"::"+null+"::"+groups+":: ::  :: :: :: ");  
				    	 }else {
				    		 revarray.add(slno+"::"+superparent+"::"+groups+":: :: :: :: :: ");     
				    	 }
				    	 slno++; 
				    	 revarray.add(slno+"::"+parentid+"::"+refname+"::"+amount+":: :: :: ::");  
				    	 subtotal += amount;   
				     }else if(groups.equalsIgnoreCase(groups1)) {   
				    	 revarray.add(slno+"::"+parentid+"::"+refname+"::"+amount+"::  :: :: :: ");  
				    	 subtotal += amount;   
				     }else {
				    	 
				    	 if(parentchk==0) {
				    		 revarray.add(slno+"::"+null+"::"+subparent+"::"+subtotal+":: :: :: :: ");
				    	 }else {
				    		 revarray.add(slno+"::"+superparent+"::"+subparent+"::"+subtotal+":: :: :: ::");    
				    	 }
				    	 slno++;  
				    	 parentid = slno;    
				    	 if(parentchk==0) {
				    		 revarray.add(slno+"::"+null+"::"+groups+":: :: :: :: :: ");  
				    	 }else {
				    		 revarray.add(slno+"::"+superparent+"::"+groups+":: :: :: :: :: ");     
				    	 }   
				    	 slno++; 
				    	 revarray.add(slno+"::"+parentid+"::"+refname+"::"+amount+":: :: :: :: ");    
				    	 subtotal = amount;  
				    	 }
				   
				     groups1 = groups;  
				     slno++;  
			}
			
			if(parentchk==0) {
	    		 revarray.add(slno+"::"+null+"::"+subparent+"::"+subtotal+":: :: :: :: ");
	    	 }else {
	    		 revarray.add(slno+"::"+superparent+"::"+subparent+"::"+subtotal+":: :: :: ::");    
	    	 }
			 slno++; 
		    	
			 if(parentchk==0) {
					revarray.add(slno+"::"+null+"::"+subparent1+"::"+granttotal+":: :: :: :: ");
	    	 }else {
	    			revarray.add(slno+"::"+superparent+"::"+subparent1+"::"+granttotal+":: :: :: ::");      
	    	 }
		//	 System.out.println("Array : "+revarray);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public JSONArray convertArrayToJSONRevenue(ArrayList<String> arrayList) throws Exception {    
		JSONArray jsonArray = new JSONArray();

        for (int i = 0; i < arrayList.size(); i++) {
        	       
        	 JSONObject obj = new JSONObject();
			
			String[] ratioArray=arrayList.get(i).split("::");
			
			obj.put("id",ratioArray[0]);
			obj.put("parentid",ratioArray[1]);
			obj.put("refname",ratioArray[2]);
			obj.put("amount",ratioArray[3]);
			obj.put("nooftrips",ratioArray[4]); 
			obj.put("count",ratioArray[5]); 
			obj.put("grouppp",ratioArray[6]); 
			jsonArray.add(obj);
		}
		return jsonArray;
		}
	public JSONArray getRevenueAnalysisDetails(String fromdate,String todate,String brhid,String id) throws SQLException{
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
			}
			if(!todate.equalsIgnoreCase("")){
				sqltodate=objcommon.changeStringtoSqlDate(todate);
			}
			
			if(sqlfromdate!=null && sqltodate!=null){
				sqlfilters+=" and m.fromdate between '"+sqlfromdate+"' and '"+sqltodate+"'";
			}
			
			if(!brhid.equalsIgnoreCase("") && !brhid.equalsIgnoreCase("a")){
				sqlfilters+=" and m.brhid="+brhid;
			}
			
			conn=objconn.getMyConnection();
			
			String strsql="select clgroup,coalesce(round(rate*executedtrip,2),0) srvhrg,coalesce(executedtrip,0) nooftrips ,tipfee,acc,invno, invdate, account,case when  a.contracttype=1 then 'Monthly' when  a.contracttype=2 then 'Yearly' when  a.contracttype=3 then 'Adhoc' else '' end as contracttype,sal_name,skipsize,wastetype,ownership, sum(a.amount)amount from(select  md.groups clgroup,d.rate,m.fromdate,m.status,d.rowno,m.doc_no,r2.name tipfee,ac.refname acc,m.voc_no invno,m.fromdate invdate, md.description account,c.billingmethod contracttype," + 
					"sm.sal_name,sk.name skipsize, ds.name wastetype, r1.name ownership, coalesce(d.nettotal,0) amount from sk_invm m inner join sk_invd d on m.doc_no=d.rdocno left join sk_invmode md on md.idno=d.idno left join sk_srvcontrm c on c.tr_no=m.cnttrno " + 
					"left join my_salm sm on sm.doc_no=c.sal_id left join sk_srvcontrdet sd on sd.rdocno=c.tr_no left join sk_skiptype sk on sk.doc_no=sd.skiptype left join sk_dumptype ds on ds.doc_no=sd.wastetype left join sk_enqrelated r1 on (r1.srno=sd.ownershipid and r1.type='SERVICEBY')"+
					"  left join sk_enqrelated r2 on (r2.srno=sd.tippingmethod and r2.type='TIPPINGFEEMETHOD') left join my_acbook ac on ac.cldocno=c.cldocno and ac.dtype='CRM' )a left join (select sum(tr.executedtrip) executedtrip ,t.invno invnoo from sk_tippingdet t left join  sk_triptotal tr on tr.srno=t.totsrno where  t.ddate between '"+sqlfromdate+"' and '"+sqltodate+"'  group by t.invno) t on a.doc_no=t.invnoo"   + 
					" where a.status=3 and a.fromdate between '"+sqlfromdate+"' and '"+sqltodate+"'  group by a.rowno order by a.doc_no,a.rowno";
			
			//System.out.println("---Details---"+strsql);    
			
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
