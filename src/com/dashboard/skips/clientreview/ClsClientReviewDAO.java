package com.dashboard.skips.clientreview;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsClientReviewDAO {   
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon =new ClsCommon();
	
	
		
	public JSONArray accountsStatement(String branch,String fromdate,String todate,String accdocno,String check) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
        java.sql.Date sqlFromDate = null;
        java.sql.Date sqlToDate = null;
        if(!(check.equalsIgnoreCase("1"))){
        	return RESULTDATA;
        }
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				if(!(fromdate.equalsIgnoreCase("undefined")) && !(fromdate.equalsIgnoreCase("")) && !(fromdate.equalsIgnoreCase("0"))){
					sqlFromDate = objcommon.changeStringtoSqlDate(fromdate);
                }
				
				if(!(todate.equalsIgnoreCase("undefined")) && !(todate.equalsIgnoreCase("")) && !(todate.equalsIgnoreCase("0"))){
					sqlToDate = objcommon.changeStringtoSqlDate(todate);
				}
				
				if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
	    			sql+=" and t.brhId="+branch+"";
	    		}
            		
				joins=objcommon.getFinanceVocTablesJoins(conn);
				casestatement=objcommon.getFinanceVocTablesCase(conn);
				
				sql = "select b.*,coalesce(round(@i:=@i+nettotal,2),0) balance from ( select a.trdate, a.brhid, a.transtype, a.description, a.ref_detail, a.tr_no, a.curId, a.currency, a.dramount, a.dr, a.cr, a.ldramount,"  
					    + "a.debit, a.credit, a.rate, a.account, a.accountname, a.grpno, a.alevel, a.acno,round((a.debit+(a.credit)*-1),2) nettotal,"+casestatement+"b.branchname from (select date(t.trdate) trdate,t.brhid,transno,transtype,t.tr_des description,t.ref_detail,t.tr_no,t.curId,c.code currency, dramount,CONVERT(if(dramount>0,round((dramount*1),2),''),CHAR(50)) dr,"
						+ "CONVERT(if(dramount<0,round((dramount*-1),2),''),CHAR(50)) cr,ldramount,CONVERT(if(ldramount>0,round((ldramount*1),2),''),CHAR(50)) debit,CONVERT(if(ldramount<0,round((ldramount*-1),2),''),CHAR(50)) credit,"
						+ "round((t.rate),2) rate, h.account,h.description accountname,h.grpno,h.alevel,h.doc_no acno from my_head h inner join (select t.brhid,t.date trdate,t.ref_detail,t.description tr_des, t.acno,2 srno,"
						+ "t.tr_no,t.curId, t.dramount ,t.ldramount, t.rate,t.doc_no transNo,t.dtype transType from my_jvtran t where  t.status=3 and date between "
						+ "'"+sqlFromDate+"' and  '"+sqlToDate+"' and trtype!=1 "+sql+" and t.acno= "+accdocno+" and t.yrid=0 union all select t.brhid,DATE_ADD('"+sqlFromDate+"',INTERVAL -1 DAY) trdate,"
						+ "'' ref_detail,'Opening Bal.' tr_des,t.acno,1 srno,0 tr_no,t.curId, sum(t.dramount),sum(t.ldramount) ldramount,t.rate,0 transNo,'OPN' transType "
						+ "from my_jvtran t where t.status=3 and ((t.trtype=1 and t.date <= '"+sqlFromDate+"' and t.dtype='OPN') or (t.date< '"+sqlFromDate+"')) "+sql+" "
						+ "and t.acno= "+accdocno+" group by t.acno,t.curId )t on h.doc_no=t.acno left join my_curr c on c.doc_no=t.curId order by acno,"
						+ "trdate,transNo,t.curId,transType) a left join my_brch b on b.doc_no=a.brhid"+joins+" order by trdate,TRANSNO) b,(select @i:=0) as i";
			//	System.out.println("============"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }
	
	
	public JSONArray contractview(String cldocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
        
      
       
        
		try {
				conn = objconn.getMyConnection();
				Statement stmtAccountStatement2 = conn.createStatement();
				String sql = "";String joins="";String casestatement="";
				
				
				sql = "select doc_no docno,startdt,enddt,s.site,case when(m.status=3 and now() between m.startdt and m.enddt) then 'Active' ELSE 'Inactive' end as status from sk_srvcontrm m left join sk_srvcsited s on s.tr_no=m.tr_no where m.cldocno='"+cldocno+"'";
				//System.out.println("============"+sql);
				ResultSet resultSet = stmtAccountStatement2.executeQuery(sql);
				RESULTDATA=objcommon.convertToJSON(resultSet);
				
				stmtAccountStatement2.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
        return RESULTDATA;
    }

	
	
	  public JSONArray clientListGridLoading() throws SQLException {
			JSONArray RESULTDATA=new JSONArray();
			Connection conn = null;  
			
			  try {
				    conn = objconn.getMyConnection();
				    Statement stmtCRM = conn.createStatement ();
			    
				  // System.out.println("grid query===="+"SELECT cl.codeno code,cl.acno acno,cl.cldocno,category,h.description accgroup,cl.period2 crmaxdays,cl.per_tel tel,ar.area area,cl.bnkcity city,cn.country_name country,cl.refname,cl.per_mob,sal_name,concat(coalesce(cl.address,''),'  ',coalesce(cl.address2,'')) as address,cl.mail1,period crdprd,credit crdlmt,tinno trnnumber ,sc.name grpcmpname,cc.cntrcount,case when cc.cntrcount >0 then 'ACTIVE' Else 'INACTIVE' end as 'status' FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no left join my_head h on h.doc_no=cat.acc_group and h.dtype='CRM' left join my_area ar on ar.doc_no=cl.area_id left join my_acountry cn on cn.doc_no=cl.bnkcountryid left join sk_clgroup sc on sc.docno=cl.grpcmp left join (select count(*) cntrcount,m.cldocno from sk_srvcontrm m where m.status=3 and now() between startdt and enddt group by m.cldocno) cc on cc.cldocno=cl.cldocno  where cl.dtype='CRM' and cl.status=3");
				    
				    ResultSet resultSet = stmtCRM.executeQuery ("SELECT cl.codeno code,cl.acno acno,cl.cldocno,cl.brhid,category,h.description accgroup,cl.period2 crmaxdays,cl.per_tel tel,ar.area area,cl.bnkcity city,cn.country_name country,cl.refname,cl.per_mob,sal_name,concat(coalesce(cl.address,''),'  ',coalesce(cl.address2,'')) as address,cl.mail1,period crdprd,credit crdlmt,tinno trnnumber ,sc.name grpcmpname,coalesce(cc.cntrcount,0) cntrcount ,case when cc.cntrcount >0 then 'ACTIVE' Else 'INACTIVE' end as 'status' FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no left join my_head h on h.doc_no=cat.acc_group and h.dtype='CRM' left join my_area ar on ar.doc_no=cl.area_id left join my_acountry cn on cn.doc_no=cl.bnkcountryid left join sk_clgroup sc on sc.docno=cl.grpcmp left join (select count(*) cntrcount,m.cldocno from sk_srvcontrm m where m.status=3 and now() between startdt and enddt group by m.cldocno) cc on cc.cldocno=cl.cldocno  where cl.dtype='CRM' and cl.status=3 ");
				    //System.out.println("SELECT cl.codeno code,cl.acno acno,cl.cldocno,cl.brhid,category,h.description accgroup,cl.period2 crmaxdays,cl.per_tel tel,ar.area area,cl.bnkcity city,cn.country_name country,cl.refname,cl.per_mob,sal_name,concat(coalesce(cl.address,''),'  ',coalesce(cl.address2,'')) as address,cl.mail1,period crdprd,credit crdlmt,tinno trnnumber ,sc.name grpcmpname,coalesce(cc.cntrcount,0) cntrcount ,case when cc.cntrcount >0 then 'ACTIVE' Else 'INACTIVE' end as 'status' FROM my_acbook CL left JOIN my_clcatm cat ON cl.catid=cat.doc_no and cat.dtype='CRM' left join my_salm s on cl.sal_id=s.doc_no left join my_head h on h.doc_no=cat.acc_group and h.dtype='CRM' left join my_area ar on ar.doc_no=cl.area_id left join my_acountry cn on cn.doc_no=cl.bnkcountryid left join sk_clgroup sc on sc.docno=cl.grpcmp left join (select count(*) cntrcount,m.cldocno from sk_srvcontrm m where m.status=3 and now() between startdt and enddt group by m.cldocno) cc on cc.cldocno=cl.cldocno  where cl.dtype='CRM' and cl.status=3 and curdate() between startdt and enddt");
				    RESULTDATA=objcommon.convertToJSON(resultSet);
				    
				    stmtCRM.close();
				    conn.close();
			  }catch(Exception e){
				  e.printStackTrace();
				  conn.close();
			  }finally{
				  conn.close();
			  }
			  return RESULTDATA;
			}
	  public  ClsClientReviewBean getPrint(HttpServletRequest request,String atype,int acno,String branch,String uptodate,int level1from,int level1to,int level2from,
				int level2to,int level3from,int level3to,int level4from,int level4to,int level5from) throws SQLException {
				
		  ClsClientReviewBean bean = new ClsClientReviewBean();     

			Connection conn = null;
			
	        java.sql.Date sqlUpToDate = null;
	        
		try {
			conn = objconn.getMyConnection();
			Statement stmtClient = conn.createStatement();
			String sql = "";
			
			if(!(uptodate.equalsIgnoreCase("undefined")) && !(uptodate.equalsIgnoreCase("")) && !(uptodate.equalsIgnoreCase("0"))){
	        	sqlUpToDate = objcommon.changeStringtoSqlDate(uptodate);
	        }
			
			sql="select 'Outstanding Statement' vouchername,(DATE_FORMAT('"+sqlUpToDate+"','%D %M  %Y ')) vouchername1,bk.address accountaddress,bk.per_mob accountmob,"
				+ "coalesce(bk.period,0) minperiod,coalesce(bk.period2,0) maxperiod,coalesce(bk.credit,0) creditlimit,j.acno,t.account,t.description,c.company,c.address,"
				+ "c.tel,c.fax,b.branchname,b.pbno,b.stcno,b.cstno,l.loc_name location,cd.code from my_acbook bk left join my_jvtran j on  bk.acno=j.acno  left join my_head t "
			    + "on j.acno=t.doc_no left join my_brch b on j.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no left join my_comp c on b.cmpid=c.doc_no left join my_curr cd "
				+ "on cd.doc_no=j.curId where j.acno="+acno+" and j.yrid=0 and j.status=3 group by acno";
			
			ResultSet resultSet = stmtClient.executeQuery(sql);
			
			while(resultSet.next()){
				bean.setLblcompname(resultSet.getString("company"));
				bean.setLblcompaddress(resultSet.getString("address"));
				bean.setLblprintname(resultSet.getString("vouchername"));
				bean.setLblprintname1(resultSet.getString("vouchername1"));
				bean.setLblcomptel(resultSet.getString("tel"));
				bean.setLblcompfax(resultSet.getString("fax"));
				bean.setLblbranch(resultSet.getString("branchname"));
				bean.setLbllocation(resultSet.getString("location"));
				bean.setLblcstno(resultSet.getString("cstno"));
				bean.setLblpan(resultSet.getString("pbno"));
				bean.setLblservicetax(resultSet.getString("stcno"));
				
				bean.setLblaccountname(resultSet.getString("description"));
				bean.setLblaccountaddress(resultSet.getString("accountaddress"));
				bean.setLblaccountmobileno(resultSet.getString("accountmob"));
				bean.setLblcreditperiodmin(resultSet.getString("minperiod"));
				bean.setLblcreditperiodmax(resultSet.getString("maxperiod"));
				bean.setLblcreditlimit(resultSet.getString("creditlimit"));
				bean.setLblcurrencycode(resultSet.getString("code"));
			}
			
			stmtClient.close();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
			conn.close();
		} finally{
			conn.close();
		}
		return bean;
	  }
}
