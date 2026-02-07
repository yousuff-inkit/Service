package com.dashboard.cargo.quotationfollowup;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.common.ClsCommon;
import com.connection.ClsConnection;
 




import net.sf.json.JSONArray;

public class ClsQuotationFollowupDAO {

	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	 public JSONArray currencySearch() throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				ResultSet resultSet = stmtCRM.executeQuery ("select doc_no curid,code currency,round(c_rate,4) rate from my_curr where status=3");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	 public JSONArray unitSearch() throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
//	        System.out.println("=====================aaaa-----");
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				ResultSet resultSet = stmtCRM.executeQuery ("select doc_no,unit from my_unitm where status=3");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	 public JSONArray billSearch() throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
//	        System.out.println("=====================aaaa-----");
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				ResultSet resultSet = stmtCRM.executeQuery ("select 1 doc_no, 'ACTUAL' as bill union all select 2 doc_no ,'QUOTED' as bill");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	 public JSONArray serviceTypeSearch(String mode,String smode,String ship) throws SQLException {
	        JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
//	        System.out.println("=====================aaaa-----");
			try {
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sqltest="";
				if(!mode.equalsIgnoreCase("")){
					sqltest+=" and modeid="+mode;
				}
				if((!smode.equalsIgnoreCase("")) && (!mode.equalsIgnoreCase("3"))){
					sqltest+=" and smodeid="+smode;
				}
				if(!ship.equalsIgnoreCase("")){
					sqltest+=" and shipid="+ship;
				}
				String sqls="select doc_no,srvtype from cr_srvtype where status=3"+sqltest;
				/*String sqls="select doc_no,srvtype from cr_srvtype where status=3 ";*/
				System.out.println("=====================sservice-----"+sqls);
				ResultSet resultSet = stmtCRM.executeQuery (sqls);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	 public JSONArray estmDataLoad(String docno,String id,String load) throws SQLException {   
		 JSONArray RESULTDATA=new JSONArray();
	        Connection conn = null;
	        String sqltest="",sqltest2="";
	        if(!id.equalsIgnoreCase("1")){
	        	return RESULTDATA;
	        }
	        if(load.equalsIgnoreCase("1")){
	    		sqltest+=" and (d.qty-d.out_qty)!=0";
	    		sqltest2+=" convert((d.qty-d.out_qty),char(50)) qty,convert((d.qty-d.out_qty),char(50)) qty1, ";
	    	} 
	        if(load.equalsIgnoreCase("2")){
	        	
	        	sqltest2+=" convert((d.qty),char(50)) qty,convert((d.qty),char(50)) qty1, ";
	        }
			try {
				String sqlcond="";
				conn = ClsConnection.getMyConnection();
				Statement stmtCRM = conn.createStatement();
				String sql="select convert(round(d.costprice,2)/round(d.qty,2),char(50)) unitsm,convert(d.out_qty,char(50)) out_qty,d.doc_no,1 status,s.srvtype sertype,d.typeid srvdocno,cr.code currency,d.curid,convert(d.rate,char(50)) rate,convert(d.price,char(50)) price,"
						+ " "+sqltest2+"d.uom unitid,u.unit uom,convert(d.total,char(50)) total,convert(d.btotal,char(50))  basetotal,d.billing,"
						+" d.vndid,ac.refname vendor,convert(round(d.costprice,2),char(50)) costprice,convert(round(d.margin,2),char(50)) margin,convert(round(d.marginper,2),char(50)) marginper,s.seqno from cr_qotd d left join cr_srvtype s on d.typeid=s.doc_no left join my_curr cr on cr.doc_no=d.curid"
						+" left join my_unitm u on u.doc_no=d.uom left join my_acbook ac on ac.cldocno=d.vndid and ac.dtype='VND' where d.rdocno="+docno+" "+sqltest+" group by d.doc_no";
				System.out.println("==estmsql=="+sql);   
				ResultSet resultSet = stmtCRM.executeQuery (sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	public JSONArray listsearch(String branch,String fromdate,String todate,String status,String reqdocno,String load) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        java.sql.Date sqlfromdate = null;
     	java.sql.Date sqltodate = null;   
     	Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();  
				 Statement stmt = conn.createStatement ();     //and mm.clstatus=0 and mm.jobno=0 and 
		 			 
				 if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0"))){
			     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
			     	}
			     if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0"))){
			     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
			     	}
			     String sqltest="";
			     if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
			    		sqltest+=" and mm.brhid='"+branch+"'";
			 		}
			     if((!(reqdocno.equalsIgnoreCase("NA")) )&&(!(reqdocno.equalsIgnoreCase("")))){
			    		sqltest+=" and mm.doc_no='"+reqdocno+"'";
			 		}
			     if(load.equalsIgnoreCase("1")){
			    		sqltest+=" and (dd.qty-dd.out_qty)!=0";
			    	}   
	/*			String sql=" select eqd.doc_no enqdetdocno, mm.doc_no,mm.voc_no,mm.date,eq.voc_no enqno,ac.refname client,bv.fdate, mm.brhid,mm.remarks desc1"
						+ " ,eqd.pol,eqd.pod ,md.modename mode "
						+ "  from cr_qotm mm left join cr_enqm eq on eq.doc_no=mm.rrefno left join cr_enqd eqd on eqd.rdocno=eq.doc_no "
						+ "  left join cr_qotd dd on dd.rdocno=mm.doc_no"
						+ "    left join my_acbook ac on ac.cldocno=mm.cldocno and ac.dtype='CRM' left join cr_mode md on md.doc_no=eqd.modeid  "
				 		+ " left join (select max(b.doc_no) doc_no,rdocno from cr_caqf b where rrefno=1 group by  rdocno) "
	        			+ "  b on(b.rdocno=mm.doc_no) left join  cr_caqf bv on b.doc_no=bv.doc_no     "
	        			+ "  where   mm.status=3 and  mm.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqltest+"   "
	        					+ " and  mm.clstatus=0 and  (eqd.qty-eqd.out_qty)>0  group by eqd.doc_no  ";
				
				*/
				
		         
//				String sql="  select  eqd.doc_no enqdetdocno, mm.doc_no,mm.voc_no,sl.sal_name salesman,mm.date,eq.voc_no enqno,ac.refname client, "
//						+ "   bv.fdate, mm.brhid,mm.remarks desc1 ,eqd.pol,eqd.pod ,md.modename mode,eqd.qty,eqd.out_qty from cr_qotm mm "
//						+ "  left join cr_qotd dd on dd.rdocno=mm.doc_no "
//						+ "  left join cr_enqm eq on eq.doc_no=mm.rrefno left join cr_enqd eqd on eqd.rdocno=eq.doc_no  and dd.refdocno=eqd.doc_no "
//						+ "    left join my_acbook ac on ac.cldocno=mm.cldocno and ac.dtype='crm' left join my_salm sl on ac.sal_id=sl.doc_no "
//						+ "    left join cr_mode md on md.doc_no=eqd.modeid "
//						+ "   left join (select max(b.doc_no) doc_no,rdocno from cr_caqf b where rrefno=1 group by  rdocno) "
//						+ "   b on(b.rdocno=eqd.doc_no) left join  cr_caqf bv on b.doc_no=bv.doc_no "
//						+ "   where   mm.status=3 and  mm.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqltest+"   "
//						+ "     and  eqd.clstatus=0 and  (eqd.qty-eqd.out_qty)>0   group by eqd.doc_no ";

				/*String sql=" select  mm.confirm_refno as confrefno,mm.confirm_no as confno,mm.confirm_date as confdate,eqd.doc_no enqdetdocno, mm.doc_no,mm.voc_no,sl.sal_name salesman,mm.date,eq.voc_no enqno,ac.refname client, "
						+ " bv.fdate, mm.brhid,mm.remarks desc1 ,eqd.pol,eqd.pod ,md.modename mode,eqd.qty,eqd.out_qty "
						+ " from cr_enqm eq left join cr_enqd eqd on eqd.rdocno=eq.doc_no "
						+ " left join  cr_qotm mm  on eq.doc_no=mm.rrefno left join cr_qotd dd on dd.rdocno=mm.doc_no and dd.refdocno=eqd.doc_no "
						+ " left join my_acbook ac on ac.cldocno=mm.cldocno and ac.dtype='crm' left join my_salm sl on ac.sal_id=sl.doc_no "
						+ " left join cr_mode md on md.doc_no=eqd.modeid "
						+ " left join (select max(b.doc_no) doc_no,rdocno from cr_caqf b where rrefno=1 group by  rdocno) "
						+ " b on(b.rdocno=eqd.doc_no) left join  cr_caqf bv on b.doc_no=bv.doc_no "
						+ " where   mm.status=3 and  mm.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqltest+"   "
						+ " and  eqd.clstatus=0  and mm.confirm=1 group by eqd.doc_no ";*/
			    
			   String sql=" select  dd.doc_no as qotdoc,eqd.modeid,eqd.smodeid,eqd.shipid,mm.confirm_refno as confrefno,mm.confirm_no as confno,mm.confirm_date as confdate,eqd.doc_no enqdetdocno, mm.doc_no,mm.voc_no,sl.sal_name salesman,mm.date,eq.voc_no enqno,ac.refname client, "
							+ " bv.fdate, mm.brhid,mm.remarks desc1 ,eqd.pol,eqd.pod ,md.modename mode,sum(dd.qty) qty,sum(dd.out_qty) out_qty "
							+ " from cr_enqm eq left join cr_enqd eqd on eqd.rdocno=eq.doc_no "
							+ " left join  cr_qotm mm  on eq.doc_no=mm.rrefno left join cr_qotd dd on dd.rdocno=mm.doc_no and dd.refdocno=eqd.doc_no "
							+ " left join my_acbook ac on ac.cldocno=mm.cldocno and ac.dtype='crm' left join my_salm sl on ac.sal_id=sl.doc_no "
							+ " left join cr_mode md on md.doc_no=eqd.modeid "
							+ " left join (select max(b.doc_no) doc_no,rdocno from cr_caqf b where rrefno=1 group by  rdocno) "
							+ " b on(b.rdocno=eqd.doc_no) left join  cr_caqf bv on b.doc_no=bv.doc_no "
							+ " where   mm.status=3 and  mm.date between '"+sqlfromdate+"' and '"+sqltodate+"'  "+sqltest+"   "
							+ " and  eqd.clstatus=0  and mm.confirm=1 group by dd.refdocno ";
			 System.out.println("-----qtnfup grid------"+sql);  
			 
            		   ResultSet resultSet = stmt.executeQuery(sql);
            		   RESULTDATA=ClsCommon.convertToJSON(resultSet);
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
	
	
	
	
	
	
	public   JSONArray Details(String rdocno) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmt = conn.createStatement ();
			
            		String sql=" select m.date detdate,m.remarks remk,m.fdate,u.user_name user from cr_caqf m "
            				+ " inner join my_user u on u.doc_no=m.userid where m.rdocno='"+rdocno+"' and  m.rrefno=1         group by m.doc_no ";
///System.out.println("=======sql=="+sql);
            		ResultSet resultSet = stmt.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
            		 stmt.close();
     				conn.close();
            
            	
          

		}
		catch(Exception e){
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
	
	
	
}
