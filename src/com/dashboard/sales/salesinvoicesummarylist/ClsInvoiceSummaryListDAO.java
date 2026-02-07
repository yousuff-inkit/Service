package com.dashboard.sales.salesinvoicesummarylist;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsInvoiceSummaryListDAO {
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	
	public  JSONArray accountsDetailsFrom(String date,String accountno, String accountname,String mob,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
        Connection conn = null;
        java.sql.Date sqlDate=null;
        date.trim();
        String sqltest="";
                  /*   if(!(date.equalsIgnoreCase("undefined"))&&!(date.equalsIgnoreCase(""))&&!(date.equalsIgnoreCase("0")))
                     {
                      sqlDate = ClsCommon.changeStringtoSqlDate(date);
                     }*/
                     
                     if(!(accountno.equalsIgnoreCase("0")) && !(accountno.equalsIgnoreCase(""))){
                         sqltest=sqltest+" and a.refname like '%"+accountno+"%'";
                     }
                     if(!(accountname.equalsIgnoreCase("0")) && !(accountname.equalsIgnoreCase(""))){
                      sqltest=sqltest+" and a.refname like '%"+accountname+"%'";
                     }
                     if(!(mob.equalsIgnoreCase("0")) && !(mob.equalsIgnoreCase(""))){
                       sqltest=sqltest+" and if(a.per_mob=0,a.per_tel,a.per_mob) like '%"+mob+"%'";
                     }
		  try {
		     conn = ClsConnection.getMyConnection();
		     if(chk.equalsIgnoreCase("1"))
		     {
		    Statement stmt = conn.createStatement ();
		      
		   
		    String  sql= "select a.doc_no,a.refname as account,a.refname description,if(a.per_mob=0,a.per_tel,a.per_mob) mobile from my_acbook a where dtype='CRM' "+sqltest;
		 
		    
		   System.out.println("-----sql---+"+sql);
		    
		    ResultSet resultSet = stmt.executeQuery(sql);
		    RESULTDATA=ClsCommon.convertToJSON(resultSet);
		    
		    stmt.close();
		     }
		    conn.close();
		  }
		  catch(Exception e){
		   e.printStackTrace();
		   conn.close();
		  }
        return RESULTDATA;
    }
	
	public JSONArray docnoSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql1="";
		

			String sql="select mm.doc_no,h.description name , mm.voc_no,b.BRANCHNAME  branch from my_invm mm "
					+ " left join my_invd d on d.rdocno=mm.doc_no left join my_main m on m.doc_no=d.prdId "
					+ " left join my_unitm u on d.unitid=u.doc_no left join my_brch b on b.doc_no=mm.brhid left join my_head h on h.doc_no=mm.acno"
					+ "  where 1=1 group by mm.doc_no ";
			//System.out.println("==productSearch==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public   JSONArray saleslistsearchsumm(String branch,String fromdate,String todate,String status,String acno,String invdocnomaster,String load) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	if(!(load.equalsIgnoreCase("yes")))
		{
			return RESULTDATA;
		}
        java.sql.Date sqlfromdate = null;
     	if(!(fromdate.equalsIgnoreCase("undefined"))&&!(fromdate.equalsIgnoreCase(""))&&!(fromdate.equalsIgnoreCase("0")))
     	{
     		sqlfromdate=ClsCommon.changeStringtoSqlDate(fromdate);
     		
     	}
     	else{
     
     	}

        java.sql.Date sqltodate = null;
     	if(!(todate.equalsIgnoreCase("undefined"))&&!(todate.equalsIgnoreCase(""))&&!(todate.equalsIgnoreCase("0")))
     	{
     		sqltodate=ClsCommon.changeStringtoSqlDate(todate);
     		
     	}
     	else{
     
     	}

        String sqltest="";
    	if(!((branch.equalsIgnoreCase("a")) || (branch.equalsIgnoreCase("NA")))){
    		sqltest+=" and mm.brhid='"+branch+"'";
 		}
    	
  
    	if((!(acno.equalsIgnoreCase("NA")) )&&(!(acno.equalsIgnoreCase("")))){
    		sqltest+=" and mm.cldocno='"+acno+"'";
 		}
    	
    	if((!(invdocnomaster.equalsIgnoreCase("NA")) )&&(!(invdocnomaster.equalsIgnoreCase("")))){
    		sqltest+=" and mm.doc_no='"+invdocnomaster+"'";
 		}
    	
    	
    	
    	
    	if(status.equalsIgnoreCase("All"))
    	{
    		sqltest+=" and  mm.status=3 ";	
    	}
    		
    	else if(status.equalsIgnoreCase("PED"))
     	{
     		
     		sqltest+=" and mm.status=3 and d.out_qty=0 ";
     		 
  		
      	}

    	/*String sql1="",sql2="",sql3="",sql4="",sql5="",sql6="",sql7="",sql8="",sql9="",sql10="",sql11="",sql12="",sql13="",sqlfinal="";
		sqlfinal=sql1+sql2+sql3+sql4+sql5+sql6+sql7+sql8+sql9+sql10+sql11+sql12+sql13;
		String sqljoin =  "left join my_ptype pt on(m.typeid=pt.doc_no) "
				+ "left join my_brand bd on(m.brandid=bd.doc_no) "
				+ "left join my_dept dep on(dep.doc_no=m.deptid) "
				+ "left join my_catm cat on(m.catid=cat.doc_no)"
				+ "left join my_scatm sc on(m.scatid=sc.doc_no)";*/
    	
     	Connection conn = null;
        
		try {
				 conn = ClsConnection.getMyConnection();
				Statement stmtVeh = conn.createStatement ();   
				
				String sql=" select 'View' butview,mm.doc_no,a.per_mob,cl.cat_name category,sa.sal_name salesman ,sf.sal_name salesperson,mm.tr_no,mm.voc_no,mm.date, case when mm.ref_type='DIR' then 'Direct'  when mm.ref_type='DEL' then 'Delivery Note' "
						+ " when mm.ref_type='JOR' then 'Job Order' when mm.ref_type='SOR' then 'Sales Order'  else 'Direct' end as 'dtype', "
						+ " if(paymode=2,'CREDIT','CASH') paymode, h.account,h.description acname,sum(d.nettotal) nettotal,sum(d.taxamount)  taxamount, "
						+ " sum(d.nettotal+coalesce(d.taxamount,0)) totalamount "
						+ " from my_invm mm  left join my_invd d  on d.rdocno=mm.doc_no left join  my_jvtran j on j.tr_no=mm.tr_no and mm.acno=j.acno left join my_head h on h.doc_no=mm.acno "
						+ " left join my_acbook a on a.cldocno=mm.cldocno and a.dtype='CRM' left join my_salm sa on sa.doc_no=a.sal_id "
						+ " left join my_salm sf on sf.doc_no=mm.sal_id left join my_clcatm cl on cl.doc_no=a.catid"
						+ " where mm.dispatch=0 and"
						+ " mm.DATE between  '"+sqlfromdate+"' and  '"+sqltodate+"'  "+sqltest+" group by mm.doc_no ";
				
            	 System.out.println("-----saleslistsearch------"+sql);	
            		ResultSet resultSet = stmtVeh.executeQuery(sql);
            		 RESULTDATA=ClsCommon.convertToJSON(resultSet);
     				stmtVeh.close();
     				
            
            	conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
        return RESULTDATA;
    }
}
