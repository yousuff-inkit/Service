package com.dashboard.skips.replacementrequest;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsReplacementRequestDAO {
    ClsConnection objconn=new ClsConnection();     
    ClsCommon objcommon=new ClsCommon();
    Connection conn;  
    
    public JSONArray replaceReqLoad(HttpSession session, int id, String fromdate, String todate, String cldocno, String frmdtchk) throws SQLException{
        JSONArray RESULTDATA1=new JSONArray();
        if(id==0) {
            return RESULTDATA1;   
        }
        Connection conn=null;
        try {
            conn = objconn.getMyConnection();
            Statement stmt = conn.createStatement(); 
            java.sql.Date sqlfromdate = null;
            java.sql.Date sqltodate = null;
            String sqltest="";
            String sqltestu="";
            if(!fromdate.equalsIgnoreCase("undefined") && !fromdate.equalsIgnoreCase("")) {
                sqlfromdate=objcommon.changeStringtoSqlDate(fromdate);  
            }
            if(!todate.equalsIgnoreCase("undefined") && !todate.equalsIgnoreCase("")) {
                sqltodate=objcommon.changeStringtoSqlDate(todate);         
            }
            if(frmdtchk.equalsIgnoreCase("1")) {  
                sqltest+=" and sc.date between '"+sqlfromdate+"' and '"+sqltodate+"'";             
                sqltestu+=" and rr.date between '"+sqlfromdate+"' and '"+sqltodate+"'";             
            }else {
                sqltest+=" and sc.date<='"+sqltodate+"'";            
                sqltestu+=" and rr.date<='"+sqltodate+"'";            
            } 
            
            if(!cldocno.equalsIgnoreCase("undefined") && !cldocno.equalsIgnoreCase("") && !cldocno.equalsIgnoreCase("0") && !cldocno.equalsIgnoreCase("null")) {  
                sqltest+=" and cm.cldocno='"+cldocno+"'";                        
                sqltestu+=" and cm.cldocno='"+cldocno+"'";                        
            }
            
            String sql="SELECT ac.refname,CASE WHEN sc.status=1 THEN 'Normal Schedule' ELSE '' END AS skipstatus,sk.name skipsize,d.skiptype skiptypeid,"
                    + " dl.skipid,dl.doc_no delid,dm.name wastetype,d.wastetype wastetypeid,cm.brhid,sc.doc_no,DATE_FORMAT(sc.date,'%d.%m.%Y') DATE,sc.time,"
                    + "days,s.name skipno,cm.doc_no contrno,d.srno,d.site, sc.remarks,'' cuser,'' cremarks FROM sk_srvcontrsch sc LEFT JOIN sk_srvcontrdel dl ON dl.doc_no=sc.delid"
                    + " LEFT JOIN sk_skipm s ON s.doc_no=dl.skipid LEFT JOIN sk_srvcontrm cm ON cm.tr_no=sc.rdocno LEFT JOIN my_acbook ac "
                    + "ON ac.cldocno = cm.cldocno AND ac.dtype='crm' LEFT JOIN sk_srvcontrdet d ON d.rdocno=sc.rdocno AND d.srno=sc.srno LEFT JOIN sk_dumptype "
                    + "dm ON dm.doc_no=d.wastetype LEFT JOIN sk_skiptype sk ON sk.doc_no=d.skiptype  WHERE cm.status=3 and sc.calldate is not null and sc.calltime is not null AND sc.status=1"+sqltest+""
                    + "UNION ALL SELECT ac.refname,CASE WHEN rr.status=3 THEN 'Replacement Request' WHEN rr.status=7 THEN 'Replacement Cancelled' END AS skipstatus, sk.name skipsize, d.skiptype skiptypeid, dl.skipid, dl.doc_no delid, "
                    + "dm.name wastetype, d.wastetype wastetypeid, cm.brhid ,rr.doc_no,DATE_FORMAT(rr.date,'%d.%m.%Y') DATE,rr.time,'' days,"
                    + "s.name skipno,cm.doc_no contrno,d.srno,d.site, rr.remarks, mu.USER_ID cuser, rr.cancelremarks cremarks FROM sk_replacereq rr LEFT JOIN sk_srvcontrdel dl ON dl.doc_no=rr.delid "
                    + "LEFT JOIN sk_skipm s ON s.doc_no=dl.skipid LEFT JOIN sk_srvcontrm cm ON cm.tr_no=rr.cnttrno LEFT JOIN my_acbook ac ON ac.cldocno = cm.cldocno "
                    + "AND ac.dtype='crm' LEFT JOIN sk_srvcontrdet d ON d.rdocno=rr.cnttrno AND d.srno=rr.srno LEFT JOIN sk_dumptype dm ON "
                    + "dm.doc_no=d.wastetype LEFT JOIN sk_skiptype sk ON sk.doc_no=d.skiptype left join my_user mu on rr.canceluserid=mu.DOC_NO WHERE cm.status=3 "+sqltestu+"";
            //System.out.println("===sql===="+sql);                                          
            ResultSet resultSet1 = stmt.executeQuery(sql);  
            RESULTDATA1=objcommon.convertToJSON(resultSet1);

        }
        catch(Exception e){
            e.printStackTrace();
        }
        finally{
            conn.close();
        }
        return RESULTDATA1;
    }
    public JSONArray contractDetailsSearch(String client, String site) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    if(!client.equalsIgnoreCase("") && !client.equalsIgnoreCase("0")) {
		    	sqltest+=" and ac.refname='"+client+"'";
		    }
		    if(!site.equalsIgnoreCase("") && !site.equalsIgnoreCase("0")) {
		    	sqltest+=" and d.site='"+site+"'";
		    }

		    sql = "select d.hold,d.nos,d.skiptype,d.srno sr_no,d.wastetype wasteid,m.tr_no,m.doc_no,ac.refname,s.site,st.name skipsize,dt.name wastetype,d.siteid,m.cldocno from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_dumptype dt on dt.doc_no=d.wastetype left join sk_skiptype st on st.doc_no=d.skiptype left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join sk_srvcsited s on s.rowno=d.siteid where m.status=3 and curdate() between m.startdt and m.enddt and d.collectionid=2 "+sqltest+"  group by m.tr_no order by m.tr_no";
		    //System.out.println("contractDetailsSearch9==="+sql);     
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);  
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
    public JSONArray siteSearch(String client, String cntdocno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    if(!client.equalsIgnoreCase("") && !client.equalsIgnoreCase("0")) {
		    	sqltest=" and ac.refname='"+client+"'";
		    }
		    if(!cntdocno.equalsIgnoreCase("") && !cntdocno.equalsIgnoreCase("0")) {
		    	sqltest=" and m.tr_no='"+cntdocno+"'";
		    }
		    
		    sql = "select d.srno sr_no,d.wastetype wasteid,m.tr_no,m.doc_no,ac.refname,s.site,st.name skipsize,dt.name wastetype,d.siteid,m.cldocno from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_dumptype dt on dt.doc_no=d.wastetype left join sk_skiptype st on st.doc_no=d.skiptype left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join sk_srvcsited s on s.rowno=d.siteid where m.status=3 and curdate() between m.startdt and m.enddt "+sqltest+" group by d.site order by d.site";
		    //System.out.println("siteSearch==="+sql);     
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
    public JSONArray clientSearch(String site, String cntdocno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    if(!cntdocno.equalsIgnoreCase("") && !cntdocno.equalsIgnoreCase("0")) {
		    	sqltest=" and m.tr_no='"+cntdocno+"'";
		    }
		    if(!site.equalsIgnoreCase("") && !site.equalsIgnoreCase("0")) {
		    	sqltest=" and d.site='"+site+"'";
		    }
		    
		    sql = "select d.srno sr_no,d.wastetype wasteid,m.tr_no,m.doc_no,ac.refname,s.site,st.name skipsize,dt.name wastetype,d.siteid,m.cldocno from sk_srvcontrm m left join sk_srvcontrdet d on d.rdocno=m.tr_no left join sk_dumptype dt on dt.doc_no=d.wastetype left join sk_skiptype st on st.doc_no=d.skiptype left join my_acbook ac on ac.cldocno=m.cldocno and ac.dtype='crm' left join sk_srvcsited s on s.rowno=d.siteid where m.status=3 and curdate() between m.startdt and m.enddt "+sqltest+" group by ac.refname order by ac.refname";
		    //System.out.println("clientSearch==="+sql);     
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
    public JSONArray skipnoSearch(String delsrno,String cnttrno,String cntsrno,String type) throws SQLException {         
		JSONArray RESULTDATA=new JSONArray();
		Connection conn = null;
	    if(type.equalsIgnoreCase("0")) {
	    	return RESULTDATA;   
	    }
		try {
		    conn = objconn.getMyConnection();
		    Statement stmt = conn.createStatement ();  
		    String sql = "",sqltest="";
		    if(type.equalsIgnoreCase("1")) {
		    	sql="select m.name,m.doc_no from sk_srvcontrdel l left join sk_skipm m on l.skipid=m.doc_no where l.slno='"+delsrno+"' and l.rdocno='"+cnttrno+"' and l.srno='"+cntsrno+"'";                
		    }else if(type.equalsIgnoreCase("2")) {   
		    	sql="select name,doc_no from sk_skipm where skipstatus=1";                    
		    }else {}        
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmt.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);
		    stmt.close();   
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
	   return RESULTDATA;
   }
    public JSONArray wastetypeSearch(int id) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql="select name, doc_no from sk_dumptype where status=3";  
		    //System.out.println("sql==="+sql);  
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);  
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
    public JSONArray skiptypeSearch(int id) throws SQLException {  
		JSONArray RESULTDATA=new JSONArray();
		/*if(id!=1) {
			return RESULTDATA;   
		}*/
		Connection conn = null;
	    
		  try {
		    conn = objconn.getMyConnection();
		    Statement stmtsalik = conn.createStatement ();  
		    String sql = "",sqltest="";
		    
		    sql="select name, doc_no from sk_skiptype where status=3";  
		   // System.out.println("sql7==="+sql);  
			ResultSet resultSet = stmtsalik.executeQuery(sql);
		    RESULTDATA=objcommon.convertToJSON(resultSet);  
		    stmtsalik.close();
		    conn.close();
		
		  }
		  catch(Exception e){
			  e.printStackTrace();
			  conn.close();
		  }
		  return RESULTDATA;
		}
    public int getTotalTrips(String date, String enddate, String noofvisit, String serviceterm, String days) throws SQLException {   
		 int totaltrips = 0;  
		 Connection conn = null; 
			try {
				java.sql.Date xdate=null;
				java.sql.Date fdate=null;
				java.sql.Date endsdate=null;
	            String day="",dates="";
				int xsrno=0;
				date.trim();
				 
				if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0"))){
					xdate = objcommon.changeStringtoSqlDate(date);
					fdate = objcommon.changeStringtoSqlDate(date);  
				}

				enddate.trim();
				if(!(enddate.equalsIgnoreCase("undefined"))&&!(enddate.equalsIgnoreCase(""))&&!(enddate.equalsIgnoreCase("0"))){
					endsdate = objcommon.changeStringtoSqlDate(enddate);
				}

				String xsql="";

				conn = objconn.getMyConnection();
				Statement stmt = conn.createStatement();  
				Statement stmt2 = conn.createStatement();  
	            int duelen=0;
	            //System.out.println("serviceterm="+serviceterm);
	            String type=serviceterm.equalsIgnoreCase("DAILY")?" Day ":serviceterm.equalsIgnoreCase("MONTHLY")?" Month ":serviceterm.equalsIgnoreCase("WEEKLY")?" Week ":" Day "; 
				String strsql1="SELECT TIMESTAMPDIFF("+type+", '"+fdate+"', '"+endsdate+"') duelen";   
				//System.out.println("strsql1==="+strsql1);   
				ResultSet rs1 = stmt.executeQuery(strsql1);  
				while(rs1.next()) {
					duelen=rs1.getInt("duelen");
				}
				if(serviceterm.equalsIgnoreCase("ALTERNATIVE")) {
					duelen=duelen/2; 
					xsql=2 + type;
				}else {
					xsql=1 + type;
				}
				//System.out.println(days+"=days===serviceterm="+serviceterm); 
				//System.out.println("noofvisit="+noofvisit);
				int t2=0,a1=0,a2=1,a3=0;
				t2=Integer.parseInt(noofvisit);  
				do							
				{	
					if (Integer.parseInt(noofvisit)>0 && xsrno>duelen) break;

					 
					if(xsrno>duelen) break; 
					
					if(serviceterm.equalsIgnoreCase("DAILY")) {                
						//System.out.println("=IN 1=");  
						int t1=1;    
						String sqltst="";   
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							xdate=rs.getDate("date");  
							while(!(xdate==null) || !(endsdate.after(xdate))){ 
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date";        
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
								}
								if(t1 <= t2) {      
									totaltrips++;
									t1++;  
								}else { 
									t1 = 1;
									break;
								}
							}
						}
						rs.close();
						break;   
					}else if(serviceterm.equalsIgnoreCase("MONTHLY")) {     
						//System.out.println("=IN 2=");   
						int t1=0,t3=0,m1=0,m2=0;   
						String sqltst="";   
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							t1++;
							xdate=rs.getDate("date");  
							if(!(xdate==null) || !(endsdate.after(xdate))){
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, month('"+xdate+"') m1";        
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									m1 = rs2.getInt("m1");
								}
								if((m1 == m2) && (t1 <= t2)) {      
									totaltrips++;
								}else if(m1 != m2) {
									t1 = 1;
									totaltrips++;
								}else { 
								}
								m2=m1;
							}
						}
						rs.close();
						break;
					}else if(serviceterm.equalsIgnoreCase("WEEKLY")) {      
						//System.out.println("=IN 3=");      
						int t1=0,t3=0,m1=0,m2=0,w1=0,w2=2;                 
						String sqltst="";   
						String sql="SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE";   
					    //System.out.println("sql="+sql);      
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							t1++;
							xdate=rs.getDate("date");  
							if(!(xdate==null) || !(endsdate.after(xdate))){
								String sql1="Select DAYNAME('"+xdate+"') day, date_format('"+xdate+"','%d.%m.%Y') date, DAYOFWEEK('"+xdate+"') w1";           
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									w1 = rs2.getInt("w1");     
								}
								if(w1 == w2) {   
									t1 = 1;
									totaltrips++;
								}else if((w1 != w2) && (t1 <= t2)) {   
									totaltrips++;
								}else { 
									 
								}
							}
						}
						rs.close();
						break;
					}else if(serviceterm.equalsIgnoreCase("Daily (Except Holiday)")) {                
						//System.out.println("=IN 1=");  
						int t1=1,t3=1,d1=0;      
						String sqltst="";   
						String sql="select date, dayname(date) dayname from(SELECT  * FROM (SELECT  DATE_ADD('"+fdate+"',INTERVAL n4.num*1000+n3.num*100+n2.num*10+n1.num DAY ) AS DATE FROM  ( SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 ) AS n1,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n2,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n3,(SELECT 0 AS num UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) AS n4) AS a WHERE DATE >= '"+fdate+"' AND DATE <= '"+endsdate+"' "+sqltst+" ORDER BY DATE)a where dayname(date)!='Sunday'";   
					    //System.out.println("sql="+sql);        
		                ResultSet rs = stmt.executeQuery(sql);
						while(rs.next()) {
							xdate=rs.getDate("date");  
							while(!(xdate==null) || !(endsdate.after(xdate))){ 
								String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, DAYOFWEEK('"+xdate+"') d1";         
								//System.out.println("sql1="+sql1);    
				                ResultSet rs2 = stmt2.executeQuery(sql1);
								if(rs2.next()) {
									day = rs2.getString("day"); 
									dates = rs2.getString("date");  
									d1 = rs2.getInt("d1"); 
								}
								if(t1 <= t2) { 
									if(t3 == 1) {
										totaltrips++;
										t1++;
									}else if(d1 != 1) {
										totaltrips++;
										t1++;
									}else {
										t1++;
									}
								}else { 
									t1 = 1;
									break;
								}
							}
						}
						rs.close();
						break;   
					}else if(serviceterm.equalsIgnoreCase("ALTERNATIVE")){     
						//System.out.println("=IN 4="); 
						while(!(xdate==null) || !(endsdate.after(xdate))){
							//System.out.println("=a2="+a2);   
							String sql1="Select DAYNAME('"+xdate+"') day,date_format('"+xdate+"','%d.%m.%Y') date, month('"+xdate+"') a1";       
							//System.out.println("sql1="+sql1);    
			                ResultSet rs2 = stmt2.executeQuery(sql1);
							if(rs2.next()) {
								day=rs2.getString("day"); 
								dates=rs2.getString("date"); 
								a1 = rs2.getInt("a1");     
							}
							if((a1 == a3) && (a2 <= t2)) {         
								totaltrips++;
							}else if(a1 != a3) {  
								a2=1;   
								totaltrips++;
							}else {
								a2=1;   
								break;
							}
							a2++; 
							a3 = a1; 
						}
						String sql="Select coalesce(DATE_ADD(date(concat(year('"+xdate+"'),'-',month('"+xdate+"'),'-',day('"+xdate+"'))),INTERVAL "+xsql+" ),date(concat(year('"+xdate+"'),'-',MONTH('"+xdate+"')+"+Integer.parseInt(noofvisit)+",'-',day('"+xdate+"')))) fdate";
						//System.out.println("sql="+sql);          
		                ResultSet rs = stmt.executeQuery(sql);
						if(rs.next()) xdate=rs.getDate("fdate");     
						rs.close(); 
					}
					xsrno++;
				}while(true); 
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				conn.close();
			}
			return totaltrips;
    } 
}
