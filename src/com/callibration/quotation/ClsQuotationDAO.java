package com.callibration.quotation;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsAmountToWords;
import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.sales.marketing.salesquotation.ClsSalesQuotationBean;

import net.sf.json.JSONArray;

public class ClsQuotationDAO {
	
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	ClsQuotationBean bean= new ClsQuotationBean();
	public int insert(java.sql.Date date,String refno,int clientid,String rrefno,String rreftype,String mode,String formcode,ArrayList prodarray,HttpSession session,
			HttpServletRequest request,String enqmasterdocno,String cpersonid,String client,String clientadrs,String mob,String tel,String cperson,String mail) throws SQLException{

		Connection conn=null;
		int sqdocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);
	 if(cpersonid.equalsIgnoreCase("") || cpersonid==null) {
		 cpersonid="0";
	 }
			 
 

			CallableStatement stmt = conn.prepareCall("{CALL cl_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			stmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(cpersonid));
			stmt.setString(5,rreftype);
			stmt.setString(6,rrefno);
			stmt.setString(7,mode);
			stmt.setString(8,formcode);
			stmt.setString(9, session.getAttribute("USERID").toString());
			stmt.setString(10, session.getAttribute("BRANCHID").toString());
			stmt.setString(11, session.getAttribute("COMPANYID").toString());
			stmt.setString(14,client);
			stmt.setString(15,clientadrs);
			stmt.setString(16,mob);
			stmt.setString(17,tel);
			stmt.setString(18,cperson);
			stmt.setString(19,mail);
			int val = stmt.executeUpdate();
			sqdocno=stmt.getInt("docNo");
			int vocno=stmt.getInt("vocNo");
			request.setAttribute("vdocNo", vocno);

			if(vocno<=0)
			{
				conn.close();
				return 0;
				
			}
		      
			System.out.println("===vocno====="+vocno+"=====dfsf"+prodarray.size());
			if(vocno>0){
				
				
				Statement st=conn.createStatement();
				
 
				 
				
				
				
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					
					System.out.println("=====sstewrtds========="+prodarray.get(i));
					
					
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")))){


				         String unitidss=""+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].trim().equalsIgnoreCase("")|| prod[1].isEmpty()?0:prod[1].trim())+"";
						    String prsros=""+(prod[0].trim().equalsIgnoreCase("undefined") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].trim().equalsIgnoreCase("")|| prod[0].isEmpty()?0:prod[0].trim())+"";
						     
					    	 
					         
							/*
							 * double fr=1; String
							 * slss=" select fr from my_unit where psrno="+prsros+" and unit='"
							 * +unitidss+"' ";
							 * 
							 * System.out.println("====slss==="+slss); ResultSet
							 * rv1=stmt.executeQuery(slss); if(rv1.next()) { fr=rv1.getDouble("fr"); }
							 */



						String sql="insert into cl_qotd(RDOCNO, SR_NO, equipmentname,prodspecid,prodpsrno,make,model,serials, BRDID, modelid,rate, qty, amount)VALUES"
								+ " ("+"'"+sqdocno+"','"+(i+1)+"',"								
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								//+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
								+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
								+ "'"+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].isEmpty()?0:prod[11].trim())+"')";
								
								
								

						System.out.println("branchper--->>>>Sql"+sql);
					int	prodet = stmt.executeUpdate (sql);

						if(prodet<=0)
						{
							conn.close();
							return 0;
							
						}
					      
                     


						
					}

				}




				

				

			}

          if(sqdocno>0)
          {

			conn.commit();
          }
		}
		catch(Exception e){
			e.printStackTrace();
			sqdocno=0;
		}
		finally{
			conn.close();
		}

		return sqdocno;
	}
	
	public int update(String voc_no,int doc_no,java.sql.Date date,String refno,int clientid,String rrefno,String rreftype,String mode,String formcode,ArrayList prodarray,HttpSession session,
			HttpServletRequest request,String enqmasterdocno,String cpersonid,String client,String clientadrs,String mob,String tel,String cperson,String mail) throws SQLException{

		Connection conn=null;
		int sqdocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);
			 if(cpersonid.equalsIgnoreCase("") || cpersonid==null) {
				 cpersonid="0";
			 }
					 
		 

					CallableStatement stmt = conn.prepareCall("{CALL cl_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

					stmt.setInt(12, doc_no);
					stmt.setInt(13, Integer.parseInt(voc_no));
					stmt.setDate(1,date);
					stmt.setString(2,refno);
					stmt.setInt(3, clientid);
					stmt.setInt(4, Integer.parseInt(cpersonid));
					stmt.setString(5,rreftype);
					stmt.setString(6,rrefno);
					stmt.setString(7,mode);
					stmt.setString(8,formcode);
					stmt.setString(9, session.getAttribute("USERID").toString());
					stmt.setString(10, session.getAttribute("BRANCHID").toString());
					stmt.setString(11, session.getAttribute("COMPANYID").toString());
					stmt.setString(14,client);
					stmt.setString(15,clientadrs);
					stmt.setString(16,mob);
					stmt.setString(17,tel);
					stmt.setString(18,cperson);
					stmt.setString(19,mail);
					int val = stmt.executeUpdate();
			
			sqdocno=doc_no;
			int vocno= Integer.parseInt(voc_no);
			request.setAttribute("vdocNo", vocno);


			if(val<=0)
			{
				conn.close();
				return 0;
				
			}
			
			
			if(sqdocno>0){
				Statement st=conn.createStatement();
				
				
				
    
                     
				
				
				
			
					
					
					String rownochk="0";    
				int	updateid=0;
				int prodet=0;
				for(int i=0;i< prodarray.size();i++){

					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("0"))||(prod[0].equalsIgnoreCase("undefined")) ||(prod[0].equalsIgnoreCase("null")))){

						System.out.println("======IN=======");
						if(i==0)
						{
						
					     String dql31="delete from cl_qotd where rdocno='"+sqdocno+"'";
			    	 	  stmt.executeUpdate(dql31);
			    	 	
						}
					


						
						String sql="insert into cl_qotd(RDOCNO, SR_NO, equipmentname,prodspecid,prodpsrno,make,model,serials, BRDID, modelid,rate, qty, amount)VALUES"
								+ " ("+"'"+sqdocno+"','"+(i+1)+"',"								
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[1].trim().equalsIgnoreCase("undefined") || prod[1].trim().equalsIgnoreCase("") || prod[1].trim().equalsIgnoreCase("NaN")|| prod[1].isEmpty()?0:prod[1].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined") || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								//+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
								+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"',"
								+ "'"+(prod[11].trim().equalsIgnoreCase("undefined") || prod[11].trim().equalsIgnoreCase("") || prod[11].trim().equalsIgnoreCase("NaN")|| prod[11].isEmpty()?0:prod[11].trim())+"')";
								
							
						System.out.println("branchper--->>>>Sql"+sql);
						prodet = stmt.executeUpdate (sql);
						if(prodet<=0)
						{
							conn.close();
							return 0;
							
						}

					

					}

				}


			
				

			
			}
				if(sqdocno>0)
				{
			  	conn.commit();		
					return sqdocno;
				}
				

			 
		}
		catch(Exception e){
			e.printStackTrace();
			sqdocno=0;
			 
		}
		finally{
			conn.close();
		}

		return sqdocno;
	}
	
	public int delete(String voc_no,int doc_no,java.sql.Date date,String refno,int clientid,String rrefno,String rreftype,String mode,String formcode,ArrayList prodarray,HttpSession session,
			HttpServletRequest request,String enqmasterdocno,String cpersonid,String client,String clientadrs,String mob,String tel,String cperson,String mail) throws SQLException{

		Connection conn=null;
		int sqdocno=0;
		conn=ClsConnection.getMyConnection();

		try{

			conn.setAutoCommit(false);
			CallableStatement stmt = conn.prepareCall("{CALL cl_QotDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");

			stmt.setInt(12, doc_no);
			stmt.setInt(13, Integer.parseInt(voc_no));
			stmt.setDate(1,date);
			stmt.setString(2,refno);
			stmt.setInt(3, clientid);
			stmt.setInt(4, Integer.parseInt(cpersonid));
			stmt.setString(5,rreftype);
			stmt.setString(6,rrefno);
			stmt.setString(7,mode);
			stmt.setString(8,formcode);
			stmt.setString(9, session.getAttribute("USERID").toString());
			stmt.setString(10, session.getAttribute("BRANCHID").toString());
			stmt.setString(11, session.getAttribute("COMPANYID").toString());
			stmt.setString(14,client);
			stmt.setString(15,clientadrs);
			stmt.setString(16,mob);
			stmt.setString(17,tel);
			stmt.setString(18,cperson);
			stmt.setString(19,mail);
			int val = stmt.executeUpdate();
		
			sqdocno=doc_no;
			int vocno=Integer.parseInt(voc_no);	
			request.setAttribute("vdocNo", vocno);
			


			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return sqdocno;
	}
	
	
	public JSONArray searchClient(HttpSession session,String clname,String mob,String Cl_clientsale) throws SQLException {

		//		System.out.println("==searchClient====");

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


		String brid=session.getAttribute("BRANCHID").toString();






		//System.out.println("name"+clname);

		String sqltest="";

		if(!(clname.equalsIgnoreCase(""))){
			sqltest=sqltest+" and refname like '%"+clname+"%'";
		}
		if(!(mob.equalsIgnoreCase(""))){
			sqltest=sqltest+" and per_mob like '%"+mob+"%'";
		}
		if(!(Cl_clientsale.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.sal_name like '%"+Cl_clientsale+"%'";
		}
		


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt1 = conn.createStatement ();
			String clsql= ("select sa.doc_no saldocno,sa.sal_name,a.catid,cl.cat_name,cl.pricegroup,a.per_tel pertel,a.cldocno,a.refname,trim(a.address) address,a.per_mob,trim(a.mail1) mail1  "
					+ "  from my_acbook a left join my_clcatm cl on cl.doc_no=a.catid  left join my_salm sa on sa.doc_no=a.sal_id  and a.dtype='CRM' where  a.dtype='CRM'  " +sqltest);
			//System.out.println("========"+clsql);
			ResultSet resultSet = stmt1.executeQuery(clsql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt1.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	public JSONArray contactpersonSearch(HttpSession session,int clientid) throws SQLException
	{

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




		Connection conn =null;
		Statement stmt =null;
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();


			String sql= ("select cperson,c.tel as tel,area,row_no as cprowno,email,c.mob from my_crmcontact c left join my_acbook a on(a.doc_no=c.cldocno)  where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientid+" and a.doc_no="+clientid+"" );
			System.out.println("-------contactpersonSearch----------"+sql);
			ResultSet resultSet = stmt.executeQuery(sql) ;
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmt.close();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;

	}
	
	public  JSONArray reqSearchMasters(HttpSession session,String docnoss,String refnosss,String datess,String aa,String clientid,String cmbreftype) throws SQLException {

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
		String brcid = session.getAttribute("BRANCHID").toString(); 

		String sqltest="";


		java.sql.Date  sqlStartDate = null;
		if(!(datess.equalsIgnoreCase("undefined"))&&!(datess.equalsIgnoreCase(""))&&!(datess.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(datess);
		}


		if((!(docnoss.equalsIgnoreCase(""))) && (!(docnoss.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and m.voc_no like '%"+docnoss+"%'";
		}
		if((!(refnosss.equalsIgnoreCase(""))) && (!(refnosss.equalsIgnoreCase("NA")))){
			sqltest=sqltest+" and m.refno like '%"+refnosss+"%'  ";
		}

		/*if((!(clientid.equalsIgnoreCase(""))) && (!(clientname.equalsIgnoreCase("NA")))){
      		sqltest=sqltest+" and ac.refname like '%"+clientname+"%'  ";
      	}*/


		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		}

		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtmain = conn.createStatement ();

			
			if(cmbreftype.equalsIgnoreCase("CEQ"))
			{
				String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.refno,m.voc_no,m.date,ac.refname as client,0 as chk from my_cusenqm m left join   my_acbook ac on(m.clientid=ac.doc_no and ac.dtype='CRM') left join my_cusenqd d on(d.rdocno=m.doc_no)  where   m.status=3 and m.clientid='"+clientid+"'  and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
				 
				System.out.println("====pySql===="+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);	
			}
			else if(cmbreftype.equalsIgnoreCase("RFQ"))
			{
				String pySql=("select * from (select sum(qty-d.out_qty) as qty,m.doc_no,m.refno,m.voc_no,m.date,0 as chk,h.description client from my_prfqm m   left join my_prfqd d on(d.rdocno=m.doc_no) left join my_head h on h.doc_no=m.acno  where d.clstatus=0 and m.status=3    and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
				 
				System.out.println("====pySql===="+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);
			}
			if(cmbreftype.equalsIgnoreCase("ENQ"))
			{
				String pySql=("select * from (select sum(d.qty) as qty,m.doc_no,m.voc_no,m.date,ac.refname as client,0 as chk from cl_enqm m left join   my_acbook ac on(m.cldocno=ac.doc_no and ac.dtype='CRM') left join cl_enqd d on(d.rdocno=m.doc_no)  where   qottrno=0 and m.status=3 and m.cldocno='"+clientid+"'  and m.brhid='"+brcid+"' "+sqltest+" group by m.doc_no) as a having qty>0" );
				 
				System.out.println("====pySql===="+pySql);
				ResultSet resultSet = stmtmain.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet);	
			} 

			stmtmain.close();
			conn.close();

		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	public   JSONArray enqgridreload(HttpSession session,String doc,String reftype,String dates) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();  
			Statement stmt1 = conn.createStatement ();  
			String pySql="";
			if(doc.equalsIgnoreCase(""))
			{
				doc="0";
			}
			System.out.println("----doc----"+doc);
			String cmbbilltype="1";
				
				 java.sql.Date masterdate = null;
					if(!(dates.equalsIgnoreCase("undefined"))&&!(dates.equalsIgnoreCase(""))&&!(dates.equalsIgnoreCase("0")))
			     	{
						masterdate=ClsCommon.changeStringtoSqlDate(dates);
			     		
			     	}
			     	else{
			     
			     	}
				
					pySql="select serial,brandname make,brdid makeid,catg model,catid modelid,specid prdspecno,psrno as prdpsrno,rdocno,psrno,qty,part_no,productid,productid as proid,productname,productname as instdesc from "
							+ "( select  cl.category catg,cl.doc_no catid,bd.doc_no brdid,d.prodspecid,bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,sum(qty)qty,m.part_no,m.part_no productid,m.productname,d.type as serial from cl_enqm ma left join "
							+ "cl_enqd d on(ma.doc_no=d.rdocno) left join my_acbook a on ma.cldocno=a.cldocno and a.dtype='CRM'  left join my_clcatm cl on cl.doc_no=a.catid left join my_main m on(d.prodpsrno=m.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
							+ "left join  my_brand bd on m.brandid=bd.doc_no where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+doc+") group by m.psrno having sum(qty)>0) as a ";
					
								
			 		/*	pySql="select serial,brandname make,brdid makeid,catg model,catid modelid,specid prdspecno,psrno as prdpsrno,rdocno,psrno,qty,part_no,productid,productid as proid,productname,productname as instdesc from "
					+ "( select  cl.category catg,cl.doc_no catid,bd.doc_no brdid,d.prodspecid,bd.brandname,at.mspecno as specid,d.rdocno,m.doc_no psrno,qty,m.part_no,m.part_no productid,m.productname,d.type as serial from cl_enqm ma left join "
					+ "cl_enqd d on(ma.doc_no=d.rdocno) left join my_acbook a on ma.cldocno=a.cldocno and a.dtype='CRM'  left join my_clcatm cl on cl.doc_no=a.catid left join my_main m on(d.prodpsrno=m.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) "
					+ "left join  my_brand bd on m.brandid=bd.doc_no where ma.status=3 and ma.brhid="+session.getAttribute("BRANCHID").toString()+" and ma.doc_no in("+doc+") ) as a ";*/

					
			 			System.out.println("----enqgridreload----"+pySql);

						ResultSet resultSet = stmt.executeQuery(pySql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet); 
					
					
			


			
			
			
			stmt.close();


		}
		catch(Exception e){
			e.printStackTrace();

		}
		finally{
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
}	
	
	public   JSONArray qotGridLoad(HttpSession session,String doc) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();  
			Statement stmt1 = conn.createStatement ();  
			String pySql="";
			if(doc.equalsIgnoreCase(""))
			{
				doc="0";
			}
			System.out.println("----doc----"+doc);
			
		
	 
				
				pySql="select RDOCNO,bd.doc_no BRDID,cl.doc_no as modelid,at.mspecno as prdspecno,m.doc_no as prdpsrno, qty, round(d.rate,2)rate, round(d.amount,2) as total,cl.category as model,bd.brandname make,productname as instdesc, serials as serial from cl_qotd d "
						+ "left join cl_qotm qm on d.rdocno=qm.doc_no   left join my_main m on(d.prodpsrno=m.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  "
						+ "left join my_acbook a on qm.cldocno=a.cldocno and a.dtype='CRM'  left join my_clcatm cl on cl.doc_no=a.catid where rdocno="+doc+" group by  d.prodpsrno,d.amount,d.serials having sum(qty)>0  order by d.rowno";


				System.out.println("----qotgridload----"+pySql);



				ResultSet resultSet = stmt.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			
			stmt.close();


		}
		catch(Exception e){
			e.printStackTrace();

		}
		finally{
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	public   JSONArray prodGridLoad(HttpSession session) throws SQLException {

		JSONArray RESULTDATA=new JSONArray();


		Connection conn = null;
		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();  
			Statement stmt1 = conn.createStatement ();  
			String pySql="";
			/*
			 * if(doc.equalsIgnoreCase("")) { doc="0"; }
			 * System.out.println("----doc----"+doc);
			 */
			
		
	 
				
				pySql="select  bd.doc_no makeid,c.doc_no modelid,c.category model,sc.doc_no scatid,sc.subcategory,bd.brandname make, at.mspecno as prodspecno, m.part_no,m.productname instdesc,m.doc_no prdpsrno,u.unit,m.munit,m.psrno from my_main m left join "  
						+ " my_unitm u on m.munit=u.doc_no left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no left join my_prodattrib at on(at.mpsrno=m.doc_no)  "
						+ "      left join  my_brand bd on m.brandid=bd.doc_no  " 
						+ "   where m.status=3";


				System.out.println("----prdsearchset----"+pySql);



				ResultSet resultSet = stmt.executeQuery(pySql);

				RESULTDATA=ClsCommon.convertToJSON(resultSet); 
			
			stmt.close();


		}
		catch(Exception e){
			e.printStackTrace();

		}
		finally{
			conn.close();
		}
		//	System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	public  JSONArray searchMaster(HttpSession session,String msdocno,String clnames,String enqno,String enqdate,String enqtype,String Cl_clientsale1,String Cl_mobnos) throws SQLException {


		System.out.println("==searchMaster==="+enqdate);

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

		//  System.out.println("8888888888"+clnames); 	
		String brid=session.getAttribute("BRANCHID").toString();



		java.sql.Date sqlStartDate=null;


		if(!(enqdate.equalsIgnoreCase("undefined"))&&!(enqdate.equalsIgnoreCase(""))&&!(enqdate.equalsIgnoreCase("0")))
		{
			sqlStartDate = ClsCommon.changeStringtoSqlDate(enqdate);
		}

		String sqltest="";
		if(!(msdocno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.voc_no like '%"+msdocno+"%'";
		}

		if(!(clnames.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.refname like '%"+clnames+"%'";
		}
		if(!(Cl_mobnos.equalsIgnoreCase(""))){
			sqltest=sqltest+" and ac.per_mob like '%"+Cl_mobnos+"%'";
		}

		
		
		if(!(enqtype.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.ref_type like '%"+enqtype+"%'";
		}

		if(!(enqno.equalsIgnoreCase(""))){
			sqltest=sqltest+" and m.rrefno like '%"+enqno+"%'";
		}

		if(!(sqlStartDate==null)){
			sqltest=sqltest+" and m.date='"+sqlStartDate+"'";
		} 

		if(!(Cl_clientsale1.equalsIgnoreCase(""))){
			sqltest=sqltest+" and sa.cperson like '%"+Cl_clientsale1+"%'";
		}

		 


		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmtenq1 = conn.createStatement (); 

			String clssql= ("select  sa.cperson,sa.tel as tel,sa.email cprsmail,sa.mob cprsmob,ac.per_mob,m.doc_no,m.voc_no,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,m.ref_type,rrefno from cl_qotm m  "
					+ "left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_crmcontact sa on sa.cldocno=ac.doc_no and   sa.dtype='CRM' where m.brhid="+brid+" and m.status <> 7 "+sqltest+"");
			System.out.println("====searchmaster===="+clssql);
			ResultSet resultSet = stmtenq1.executeQuery(clssql);

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmtenq1.close();
			conn.close();
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	public  ClsQuotationBean getViewDetails(int docno,String branchid) throws SQLException{


		Connection conn =null;
		try {
			conn= ClsConnection.getMyConnection();

			Statement stmt = conn.createStatement ();

			String sql= ("select m.doc_no,m.voc_no,coalesce(m.refno,'') refno,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,m.cldocno,coalesce(m.ref_type,'ENQ') as ref_type ,coalesce(rrefno,'') as rrefno,coalesce(sa.cldocno,0) as cpersonid,coalesce(sa.cperson,'') as cperson,coalesce(sa.email,'') cprsmail,coalesce(sa.mob,'') cprsmob from cl_qotm m left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_crmcontact sa on sa.cldocno=ac.doc_no and   sa.dtype='CRM' where m.doc_no="+docno+" and m.brhid="+branchid+"");

			System.out.println("==getViewDetails===="+sql);
			String dtype="";
			String sqot="";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()){
				
				
				
				
				
				bean.setHiddate(rs.getString("date"));
				bean.setMasterdoc_no(rs.getInt("doc_no"));
				bean.setDocno(rs.getString("voc_no"));
				bean.setTxtrefno(rs.getString("refno"));
				bean.setClientid(rs.getInt("cldocno"));
				bean.setEnqmasterdocno(rs.getString("rrefno"));
				
				
				bean.setCmbreftype(rs.getString("ref_type"));
				bean.setHidcmbreftype(rs.getString("ref_type"));
				bean.setTxtclientdet(rs.getString("cladd"));
				bean.setTxtcontact(rs.getString("cperson"));
				bean.setCpersonid(rs.getString("cpersonid"));
				bean.setTxtemail(rs.getString("cprsmail"));
				bean.setTxtmob(rs.getString("cprsmob"));
				dtype=rs.getString("ref_type");
				sqot=rs.getString("rrefno");
				

			}


			int i=0;
			String qotdoc="";
			if(dtype.equalsIgnoreCase("ENQ"))
			{
				Statement stmt1  = conn.createStatement ();	
				if(!(sqot.equalsIgnoreCase(""))) {
				String sqlss="select voc_no from  cl_enqm where doc_no in ("+sqot+")";
				//System.out.println("==sqlss==="+sqlss);

				ResultSet resultSet1= stmt1.executeQuery(sqlss);


				while (resultSet1.next()) {

					if(i==0)
					{
						qotdoc=resultSet1.getString("voc_no")+",";	
					}
					else
					{
						qotdoc=qotdoc+resultSet1.getString("voc_no")+",";
					}


					i++;



				}

				if(qotdoc.endsWith(","))
				{
					qotdoc = qotdoc.substring(0,qotdoc.length() - 1);
				}

				bean.setRrefno(qotdoc);

			}

			}


		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally
		{
			conn.close();
		}
			
		return bean;
	}
	
	 public    ClsQuotationBean getPrint(int docno, HttpServletRequest request) throws SQLException {
		 ClsQuotationBean bean = new ClsQuotationBean();
		  Connection conn = null;
		try {
				 conn = ClsConnection.getMyConnection();

				  ClsAmountToWords c = new ClsAmountToWords();

					HttpSession session=request.getSession();
				Statement stmtprint = conn.createStatement ();
				String brid=session.getAttribute("BRANCHID").toString();
/*				String resql=("select m.rdtype,if(m.rdtype!='DIR',m.rrefno,'') rrefno,if(m.rdtype='DIR','Direct',if(m.rdtype='CEQ','Sales Enquiry','Sales Quotation')) type,m.doc_no,m.voc_no,m.refno,"
						+ " DATE_FORMAT(m.date,'%d.%m.%Y') AS date,h.description descs,h.account,m.acno,m.curId,m.rate,m.amount,m.disstatus,m.disper, \r\n" + 
				" m.discount,m.roundVal,round(m.netAmount,2) netAmount,round(m.supplExp,2) supplExp,round(m.nettotal,2) nettotal,m.prddiscount,m.delterms,m.payterms,m.description,DATE_FORMAT(m.deldate,'%d.%m.%Y') deldate   \r\n" + 
				" from my_qotm m left join my_head h on h.doc_no=m.acno   where   m.doc_no='"+docno+"'");
				*/
				
				String resql=("select m.doc_no,m.voc_no,coalesce(m.refno,'') refno,m.date,m.dtype,m.brhid,ac.refname as name,ac.address as cladd,coalesce(ac.mail1,ac.mail2)clntmail,m.cldocno,coalesce(m.ref_type,'ENQ') as ref_type ,coalesce(rrefno,'') as rrefno,coalesce(sa.cldocno,0) as cpersonid,coalesce(sa.cperson,'') as cperson,coalesce(sa.email,'') cprsmail,coalesce(sa.mob,'') cprsmob,coalesce(sa.tel,'') cprstel from cl_qotm m left join my_acbook ac on(ac.doc_no=m.cldocno and ac.dtype='CRM') left join my_crmcontact sa on sa.cldocno=ac.doc_no and   sa.dtype='CRM' where m.doc_no="+docno+" and m.brhid="+brid+"");
				System.out.println("printqry==="+resql);
				
			 
				
				ResultSet pintrs = stmtprint.executeQuery(resql);
				
		 
			       while(pintrs.next()){
			    	
			    	    bean.setLbldoc(pintrs.getString("voc_no"));
			    	    bean.setLbldate(pintrs.getString("date"));
			    	    bean.setLblrefno(pintrs.getString("refno"));
			    	    bean.setLbltype(pintrs.getString("ref_type"));
			    	    bean.setLblclient(pintrs.getString("name"));  
			    	    bean.setLblclntmail(pintrs.getString("clntmail"));
			    	    bean.setLblcperson(pintrs.getString("cperson"));
			    	    bean.setAddress(pintrs.getString("cladd"));
			    	    bean.setMob(pintrs.getString("cprsmob"));
			    	    bean.setLblenqno(pintrs.getString("rrefno"));
			    	    bean.setLblcprsrtel(pintrs.getString("cprstel"));
			    	    bean.setLblddoc(pintrs.getString("doc_no"));
		/*	    	 
			    	    bean.setLblsubtotal(pintrs.getString("supplExp"));
			            
			    	    bean.setLblordervaluewords(c.convertAmountToWords(pintrs.getString("nettotal")));
			    	    bean.setLblordervalue(pintrs.getString("nettotal"));
			    	    */
			    	    
			    	  
			       }
				

				stmtprint.close();
				
				
				
				 Statement stmt10 = conn.createStatement ();
				    String  companysql="select b.tinno,b.branchname,c.company,c.address,c.tel,c.fax,l.loc_name location from cl_qotm r  "
				    		+ " left join my_brch b on r.brhid=b.doc_no left join my_locm l on l.brhid=b.doc_no "
				    		+ "left join my_comp c on b.cmpid=c.doc_no where r.doc_no="+docno+"  ";


			         ResultSet resultsetcompany = stmt10.executeQuery(companysql); 
				       
				       while(resultsetcompany.next()){
				    	   
				    	   bean.setLblbranch(resultsetcompany.getString("branchname"));
				    	   bean.setLblcompname(resultsetcompany.getString("company"));
				    	  
				    	   bean.setLblcompaddress(resultsetcompany.getString("address"));
				    	   bean.setLblcomptel(resultsetcompany.getString("tel"));
				    	  
				    	   bean.setLblcompfax(resultsetcompany.getString("fax"));
				    	   bean.setLbllocation(resultsetcompany.getString("location"));
				    	   bean.setLbltrno(resultsetcompany.getString("tinno"));
				    	  
				    	   
				    	   
				       } 
				     stmt10.close();
				       
				     double total=0;
				     double grndtotal=0;
				     double srvtotal=0;
				     Statement stmtgrid3 = conn.createStatement ();      
				     String	strSqldetail1="select sum(d.amount) nettotal,(sum(d.amount)/100)*5 vat,round(sum(d.amount)+((sum(d.amount)/100)*5),2) as total from cl_qotd d left join cl_qotm qm on d.rdocno=qm.doc_no   left join my_main m on(d.prodpsrno=m.doc_no) left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no left join my_acbook a on qm.cldocno=a.cldocno and a.dtype='CRM'  left join my_clcatm cl on cl.doc_no=a.catid where rdocno='"+docno+"' group by  d.rdocno;";
					 ResultSet rsdetail1=stmtgrid3.executeQuery(strSqldetail1);
				 
						if(rsdetail1.next()){
							
							total=rsdetail1.getDouble("total");
							bean.setLbltotal(total+"");
							bean.setLbltax(rsdetail1.getString("vat"));
							grndtotal+=total;
							 bean.setLblordervaluewords(c.convertAmountToWords(rsdetail1.getString("total")+""));
					    	 bean.setLblordervalue(rsdetail1.getString("total")+"");
						}
						
						
							
							
							
				   
					
					
					
					
					
					   
				   
					 
					
					
					
					
					 
				
				conn.close();



				
		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		return bean;
		
	
	}
	
	
}
