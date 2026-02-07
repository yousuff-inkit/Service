package com.inkit.enquiry;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import com.common.ClsCommon;
import com.connection.ClsConnection;

public class ClsEnquiryDAO {
	
	ClsConnection ClsConnection=new ClsConnection();
	ClsCommon ClsCommon=new ClsCommon();
	
	public JSONArray areaDetailsSearch(String areas,String cities,String countries,String regions,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    		conn = ClsConnection.getMyConnection();
	    		Statement stmt = conn.createStatement();
			
	    	    String sql = null;
	    	    String sql1 = "";
				
	    	    if(!((areas.equalsIgnoreCase("")) || (areas.equalsIgnoreCase("0")))){
	                sql1=sql1+" and a.area like '%"+areas+"%'";
	            }
	            if(!((cities.equalsIgnoreCase("")) || (cities.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and c.city_name like '%"+cities+"%'";
	            }
	            if(!((countries.equalsIgnoreCase("")) || (countries.equalsIgnoreCase("0")))){
	                sql1=sql1+" and ac.country_name like '%"+countries+"%'";
	            }
	            if(!((regions.equalsIgnoreCase("")) || (regions.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and r.reg_name like '%"+regions+"%'";
	            }
				
				sql = "select a.doc_no as areadocno,a.area as area,c.city_name as city_name,ac.country_name as country_name,r.reg_name as region_name from my_area a inner join my_acity c on(a.city_id=c.doc_no) inner join my_acountry ac on(ac.doc_no=c.country_id) inner join my_aregion r on(r.doc_no=ac.reg_id) where a.status=3 and c.status=3 and ac.status=3 and r.status=3"+sql1;
				
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmt.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmt.close();
					conn.close();
					return RESULTDATA1;
				}
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray inspectorDetailsSearch(String inspectorname,String specdocno,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    		conn = ClsConnection.getMyConnection();
	    		Statement stmt = conn.createStatement();
			
	    	    String sql = null;
	    	    String sql1 = "";
				
	            if(!((inspectorname.equalsIgnoreCase("")) || (inspectorname.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and m.ins_name like '%"+inspectorname+"%'";
	            }
				
				sql = "select m.doc_no as inspdocno ,m.ins_name as insp from is_inspm m left join is_inspspecfn s on m.doc_no=s.inspdoc_no where m.status=3 and s.comodityId in ('"+specdocno+"') "+sql1;
				
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				else{
					stmt.close();
					conn.close();
					return RESULTDATA;
				}
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray frequencySearch(HttpSession session) throws SQLException {
		
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
            	
				String sql= ("select doc_no as frequencyid,frqncy_name as frequency from is_frequency where status=3" );

				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
		} catch(Exception e){
			e.printStackTrace();
		} finally{
  				stmt.close();
  				conn.close();
  		}
        return RESULTDATA;
	}
	
	public JSONArray clientDetailsSearch(String clientname,String clientdet,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA1=new JSONArray();
	
	    try {
	    		conn = ClsConnection.getMyConnection();
	    		Statement stmt = conn.createStatement();
			
	    	    String sql = null;
	    	    String sql1 = "";
				
	            if(!((clientname.equalsIgnoreCase("")) || (clientname.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and refname like '%"+clientname+"%'";
	            }
	            if(!((clientdet.equalsIgnoreCase("")) || (clientdet.equalsIgnoreCase("0")))){
	                sql1=sql1+" and com_mob like '%"+clientdet+"%'";
	            }
				
				sql = "select refname as clientname,com_mob as clientdet,doc_no as clientid,curid as clientcur_id from my_acbook where status=3 and dtype='CRM'"+sql1;
				
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet1 = stmt.executeQuery(sql);
					RESULTDATA1=ClsCommon.convertToJSON(resultSet1);
				}
				else{
					stmt.close();
					conn.close();
					return RESULTDATA1;
				}
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA1;
	}
	
	public JSONArray contactPersonDetailsSearch(String clientdocno,String contactpersonsname,String contactpersonsmobile,String contactpersonsdocno,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    		conn = ClsConnection.getMyConnection();
	    		Statement stmt = conn.createStatement();
			
	    	    String sql = null;
	    	    String sql1 = "";
				
	            if(!((contactpersonsname.equalsIgnoreCase("")) || (contactpersonsname.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and cperson like '%"+contactpersonsname+"%'";
	            }
	            if(!((contactpersonsmobile.equalsIgnoreCase("")) || (contactpersonsmobile.equalsIgnoreCase("0")))){
	                sql1=sql1+" and c.tel like '%"+contactpersonsmobile+"%'";
	            }
	            if(!((contactpersonsdocno.equalsIgnoreCase("")) || (contactpersonsdocno.equalsIgnoreCase("0")))){
	                sql1=sql1+" and row_no like '%"+contactpersonsdocno+"%'";
	            }
				
				sql = "select cperson,c.tel as tel,ar.area,row_no as cprowno,c.mob,c.email from my_crmcontact c left join my_acbook a on (a.doc_no=c.cldocno) left join my_area ar on(c.area_id=ar.doc_no) where a.status=3 and a.dtype='CRM' and c.dtype='CRM' and c.cldocno="+clientdocno+" and a.doc_no="+clientdocno+""+sql1;
				
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				else{
					stmt.close();
					conn.close();
					return RESULTDATA;
				}
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public   JSONArray jobdetGridLoad(int enqdocno) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		Connection conn =null;
		Statement stmt =null;
  			
		try {
				conn = ClsConnection.getMyConnection();
				stmt = conn.createStatement ();
				
				String sql= ("select ser_id serviceid, comodity_id as comodityid, trade_id tradeid, area_id as areaid, qty, descrptn as description, stdate as startdate, endate as enddate, freq_id as frequencyid,c.description as commodity,s.service as services,t.trade as discipline,a.area area,f.frqncy_name as frequency from is_enqjobdet"
						+ " jd left join is_comm c on(jd.comodity_id=c.doc_no) left join is_trade t on(jd.trade_id=t.doc_no) left join is_service s on(jd.ser_id=s.doc_no) left join my_area"
						+ " a on(jd.area_id=a.doc_no) left join is_frequency f on(f.doc_no=freq_id)where jd.enq_id="+enqdocno+"");
System.out.println("jobgrid=="+sql);
				ResultSet resultSet = stmt.executeQuery(sql) ;
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
			stmt.close();
  			conn.close();
		} catch(Exception e){
			e.printStackTrace();
		} finally {
  				stmt.close();
  				conn.close();
  			}
        return RESULTDATA;
	}
	
	public JSONArray projectOwnerDetailsSearch(String projectsownername,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    		conn = ClsConnection.getMyConnection();
	    		Statement stmt = conn.createStatement();
			
	    	    String sql = null;
	    	    String sql1 = "";
				
	            if(!((projectsownername.equalsIgnoreCase("")) || (projectsownername.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and owner like '%"+projectsownername+"%'";
	            }
				
				sql = "SELECT owner,doc_no as ownerid FROM is_prjowner i where dtype='IPO'"+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				else{
					stmt.close();
					conn.close();
					return RESULTDATA;
				}
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray projectVendorDetailsSearch(String projectsvendorname,String chk) throws SQLException {
	    Connection conn=null;
	    JSONArray RESULTDATA=new JSONArray();
	
	    try {
	    		conn = ClsConnection.getMyConnection();
	    		Statement stmt = conn.createStatement();
			
	    	    String sql = null;
	    	    String sql1 = "";
				
	            if(!((projectsvendorname.equalsIgnoreCase("")) || (projectsvendorname.equalsIgnoreCase("0")))){
	            	sql1=sql1+" and owner like '%"+projectsvendorname+"%'";
	            }
				
				sql = "SELECT owner as vendor,doc_no as vendorid FROM is_prjowner where dtype='IVN'"+sql1;
				
				if(chk.equalsIgnoreCase("1")){
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
				}
				else{
					stmt.close();
					conn.close();
					return RESULTDATA;
				}
				stmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
			conn.close();
		}finally{
			conn.close();
		}
	    return RESULTDATA;
	}
	
	public JSONArray comodityDetailsSearch(String docno,String service,String discipline,String comodities,String chk) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();


		Connection conn =null;
		Statement stmt =null;
		try {
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
			String sql = null;
			String sql1 = "";
			
    	    if(!((docno.equalsIgnoreCase("")) || (docno.equalsIgnoreCase("0")))){
                sql1=sql1+" and c.doc_no='"+docno+"'";
            }
            if(!((service.equalsIgnoreCase("")) || (service.equalsIgnoreCase("0")))){
            	sql1=sql1+" and service like '%"+service+"%'";
            }
            if(!((discipline.equalsIgnoreCase("")) || (discipline.equalsIgnoreCase("0")))){
                sql1=sql1+" and trade like '%"+discipline+"%'";
            }
            if(!((comodities.equalsIgnoreCase("")) || (comodities.equalsIgnoreCase("0")))){
            	sql1=sql1+" and description like '%"+comodities+"%'";
            }

            sql = "select c.doc_no as doc_no,description as comodity,trade as discipline,service,serid,tradeid from is_comm c inner join is_trade t on(t.doc_no=c.tradeId) inner join is_service s on(s.doc_no=c.serId) where 1=1"+sql1;
			
			if(chk.equalsIgnoreCase("1")){
				ResultSet resultSet1 = stmt.executeQuery(sql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet1);
			}
			else{
				stmt.close();
				conn.close();
				return RESULTDATA;
			}
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		finally{
			stmt.close();
			conn.close();
		}
		return RESULTDATA;
	}
	
	public   JSONArray guidlineGridLoad(String estatusid) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
       
        Connection conn =null;
		Statement stmt =null;
		
		try {
		 conn = ClsConnection.getMyConnection();
		 stmt = conn.createStatement ();
		 
				if((estatusid=="")||(estatusid==null)||(estatusid.equals(""))){
					estatusid="1";
				}
				
				//type_id-->1 for IENQ
            	
				ResultSet resultSet = stmt.executeQuery ("SELECT p.description as description,status_id,mandatory as flag FROM is_pstatus i inner join is_pgline p on(p.status_id=i.doc_no) where p.status_id='"+estatusid+"' and p.status=3 and p.type_id=1 order by flag desc");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
		stmt.close();
  		conn.close();		
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
				stmt.close();
				conn.close();
			}
        return RESULTDATA;
    }
	
	public JSONArray processGridLoad(String edocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
		Statement stmt =null;
		
		try {
		 
			conn = ClsConnection.getMyConnection();
			stmt = conn.createStatement ();
		 
				if(edocno=="")edocno="0";
		            
				ResultSet resultSet = stmt.executeQuery ("select u.user_id as user,s.status,procstatus_id as status_id,d.date as date,d.remarks as remarks from is_pstatus s inner join is_enqprocessdet d on(statusid=procstatus_id) left join my_user u on(u.doc_no=d.user_id)  where enq_id="+edocno+" and type='IENQ'");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				
				stmt.close();
				conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
				stmt.close();
				conn.close();
			}
        return RESULTDATA;
    }
	
	 public   JSONArray InspCostGridload(int enq_id) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();
		   
	    	 Connection conn =null;
	 		Statement cpstmt =null;
	 		try {
	 		 conn = ClsConnection.getMyConnection();
	 		cpstmt = conn.createStatement ();
					
					String  cpsql="";
					
	            	
					  cpsql=("select ins_name as field_name,ed.insp_id as costfield_id,Nhr as nh, Hhr as hh, Thr as th, Mday8Hr e8h, Mday10Hr t10h, Hmday8Hr h8h, Hmday10Hr as h10h, Mn22x8Hr as e22dx8h , Mn22x10Hr as  t22dx10h, Hmn22x8Hr  as e22hx8h, Hmn22x10Hr as  t22hx10h, "
							+ "otabv8Hr as ot8, otabv10Hr as ot10, Hotabv8Hr as hot8, Hotabv10Hr as hot10, Magepkm as magekm, Magepmi as magemi, peridum as perdium, lodging, carchg as carexp, trainchg as trainexp, buschg as busexp, taxichg as taxiexp, flightchg as flightexp, mealschg as mealsexp,"
							+ " tollchg as tollexp, fuelchg as fuelexp, othrchg as otherexp from is_enqinspd ed left join is_inspm im on(im.doc_no=ed.insp_id)"
							+ " left join is_insprated id on(id.inspdoc_no=insp_id) where ed.enq_id="+enq_id+"");
					  
					
					  /*cpsql=("(select ins_name as field_name,CONVERT(ed.insp_id,char(15)) as cefield_id,round(mc.c_rate*Nhr,2) as nh, round(mc.c_rate*Hhr,2) as hh, round(mc.c_rate*Thr,2) as th,round(mc.c_rate* Mday8Hr,2) e8h,round( mc.c_rate*Mday10Hr,2) t10h, "
							+ "round(mc.c_rate*Hmday8Hr,2) h8h,round(mc.c_rate*Hmday10Hr,2) as h10h, round(mc.c_rate*Mn22x8Hr,2) as e22dx8h ,round(mc.c_rate*Mn22x10Hr,2) as  t22dx10h,round(mc.c_rate*Hmn22x8Hr,2)  as e22hx8h,"
							+ "round(mc.c_rate*Hmn22x10Hr,2) as  t22hx10h,round(mc.c_rate*otabv8Hr,2) as ot8,round(mc.c_rate*otabv10Hr,2) as ot10,round(mc.c_rate*Hotabv8Hr,2) as hot8,round(mc.c_rate*Hotabv10Hr,2) as hot10,"
							+ "round(mc.c_rate*Magepkm,2) as magekm,round(mc.c_rate*Magepmi,2) as magemi,round(mc.c_rate*peridum,2) as perdium, round(mc.c_rate*lodging,2) as lodging,round(mc.c_rate*carchg,2) as carexp,round(mc.c_rate*trainchg,2) as trainexp,"
							+ "round(mc.c_rate*buschg,2) as busexp,round(mc.c_rate*taxichg,2) as taxiexp,round(mc.c_rate*flightchg,2) as flightexp,round(mc.c_rate*mealschg,2) as mealsexp,round(mc.c_rate*tollchg,2) as tollexp,"
							+ "round(mc.c_rate*fuelchg,2) as fuelexp,round(mc.c_rate*othrchg,2) as otherexp from is_enqinspd ed left join is_inspm im on(im.doc_no=ed.insp_id)"
							+ " left join is_insprated id on(id.inspdoc_no=insp_id) left join is_enqmaster e on(e.doc_no=ed.enq_id)"
							+ " left join my_curr mc on(mc.doc_no=e.clientcur_id) where ed.enq_id="+enq_id+")");*/
					
					ResultSet resultSet = cpstmt.executeQuery (cpsql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
					
			}
			catch(Exception e){
				e.printStackTrace();
			}
	 		finally{
	 			cpstmt.close();
  				conn.close();
  			}
			//System.out.println(RESULTDATA);
	        return RESULTDATA;
	    }
	 
	 public   JSONArray CEGridload(int enq_id,int estatusid) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();
		   
	    	 Connection conn =null;
	 		Statement cpstmt =null;
	 		try {
	 		 conn = ClsConnection.getMyConnection();
	 		cpstmt = conn.createStatement ();
					
					String  cpsql="";
	            
	            		if(estatusid==5){
	            			
	            	
					  cpsql=("(select ins_name as field_name,CONVERT(ed.insp_id,char(15)) as cefield_id,round(mc.c_rate*Nhr,2) as nh, round(mc.c_rate*Hhr,2) as hh, round(mc.c_rate*Thr,2) as th,round(mc.c_rate* Mday8Hr,2) e8h,round( mc.c_rate*Mday10Hr,2) t10h, "
							+ "round(mc.c_rate*Hmday8Hr,2) h8h,round(mc.c_rate*Hmday10Hr,2) as h10h, round(mc.c_rate*Mn22x8Hr,2) as e22dx8h ,round(mc.c_rate*Mn22x10Hr,2) as  t22dx10h,round(mc.c_rate*Hmn22x8Hr,2)  as e22hx8h,"
							+ "round(mc.c_rate*Hmn22x10Hr,2) as  t22hx10h,round(mc.c_rate*otabv8Hr,2) as ot8,round(mc.c_rate*otabv10Hr,2) as ot10,round(mc.c_rate*Hotabv8Hr,2) as hot8,round(mc.c_rate*Hotabv10Hr,2) as hot10,"
							+ "round(mc.c_rate*Magepkm,2) as magekm,round(mc.c_rate*Magepmi,2) as magemi,round(mc.c_rate*peridum,2) as perdium, round(mc.c_rate*lodging,2) as lodging,round(mc.c_rate*carchg,2) as carexp,round(mc.c_rate*trainchg,2) as trainexp,"
							+ "round(mc.c_rate*buschg,2) as busexp,round(mc.c_rate*taxichg,2) as taxiexp,round(mc.c_rate*flightchg,2) as flightexp,round(mc.c_rate*mealschg,2) as mealsexp,round(mc.c_rate*tollchg,2) as tollexp,"
							+ "round(mc.c_rate*fuelchg,2) as fuelexp,round(mc.c_rate*othrchg,2) as otherexp from is_enqinspd ed left join is_inspm im on(im.doc_no=ed.insp_id)"
							+ " left join is_insprated id on(id.inspdoc_no=insp_id) left join is_enqmaster e on(e.doc_no=ed.enq_id)"
							+ " left join my_curr mc on(mc.doc_no=e.clientcur_id) where ed.enq_id="+enq_id+") union all (select field_name as field_name,costfield_code as cefield_id,0.0 as nh,"
							+ " 0.0 as hh, 0.0 as th, 0.0 e8h, 0.0 t10h, 0.0 h8h, 0.0 as h10h, 0.0 as e22dx8h ,"
							+ " 0.0 as  t22dx10h, 0.0  as e22hx8h, 0.0 as  t22hx10h,0.0 as ot8, 0.0 as ot10,"
							+ " 0.0 as hot8, 0.0 as hot10, 0.0 as magekm, 0.0 as magemi, 0.0 as perdium,0.0 lodging,"
							+ " 0.0 as carexp, 0.0 as trainexp, 0.0 as busexp, 0.0 as taxiexp, 0.0 as flightexp,"
							+ " 0.0 as mealsexp, 0.0 as tollexp, 0.0 as fuelexp, 0.0 as otherexp from "
							+ " is_costfield where status=3)");
					
					  ResultSet resultSet = cpstmt.executeQuery (cpsql);
						RESULTDATA=ClsCommon.convertToJSON(resultSet);
						
	            		}
	            		if(estatusid==4){
	            			
	            			cpsql=("(select ins_name as field_name,CONVERT(ed.insp_id,char(15)) as cefield_id,round(mc.c_rate*Nhr,2) as nh, round(mc.c_rate*Hhr,2) as hh, round(mc.c_rate*Thr,2) as th,round(mc.c_rate* Mday8Hr,2) e8h,round( mc.c_rate*Mday10Hr,2) t10h, "
	    							+ "round(mc.c_rate*Hmday8Hr,2) h8h,round(mc.c_rate*Hmday10Hr,2) as h10h, round(mc.c_rate*Mn22x8Hr,2) as e22dx8h ,round(mc.c_rate*Mn22x10Hr,2) as  t22dx10h,round(mc.c_rate*Hmn22x8Hr,2)  as e22hx8h,"
	    							+ "round(mc.c_rate*Hmn22x10Hr,2) as  t22hx10h,round(mc.c_rate*otabv8Hr,2) as ot8,round(mc.c_rate*otabv10Hr,2) as ot10,round(mc.c_rate*Hotabv8Hr,2) as hot8,round(mc.c_rate*Hotabv10Hr,2) as hot10,"
	    							+ "round(mc.c_rate*Magepkm,2) as magekm,round(mc.c_rate*Magepmi,2) as magemi,round(mc.c_rate*peridum,2) as perdium, round(mc.c_rate*lodging,2) as lodging,round(mc.c_rate*carchg,2) as carexp,round(mc.c_rate*trainchg,2) as trainexp,"
	    							+ "round(mc.c_rate*buschg,2) as busexp,round(mc.c_rate*taxichg,2) as taxiexp,round(mc.c_rate*flightchg,2) as flightexp,round(mc.c_rate*mealschg,2) as mealsexp,round(mc.c_rate*tollchg,2) as tollexp,"
	    							+ "round(mc.c_rate*fuelchg,2) as fuelexp,round(mc.c_rate*othrchg,2) as otherexp from is_enqinspd ed left join is_inspm im on(im.doc_no=ed.insp_id)"
	    							+ " left join is_insprated id on(id.inspdoc_no=insp_id) left join is_enqmaster e on(e.doc_no=ed.enq_id)"
	    							+ " left join my_curr mc on(mc.doc_no=e.clientcur_id) where ed.enq_id="+enq_id+")");
	            			
	            			ResultSet resultSet = cpstmt.executeQuery (cpsql);
	    					RESULTDATA=ClsCommon.convertToJSON(resultSet);
	    					
	            		}
	            	
	            		
	            		/*cpsql=("select ins_name as field_name,CONVERT(ed.insp_id,char(15)) as cefield_id from is_enqinspd ed left join is_inspm im on(im.doc_no=ed.enq_id) where ed.enq_id="+enq_id+""
	            				+ " union all (select field_name as field_name,costfield_code as cefield_id from  is_costfield )");
	            		*/
	            	
			}
			catch(Exception e){
				e.printStackTrace();
			}
	 		finally{
	 			cpstmt.close();
  				conn.close();
  			}
	        return RESULTDATA;
	    }
	
	public JSONArray inspGridLoad(String edocno) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        
        Connection conn =null;
 		Statement stmt =null;
 		try {
 		 conn = ClsConnection.getMyConnection();
 		stmt = conn.createStatement ();
 		
				if(edocno=="")edocno="0";
            	
				System.out.println("select m.ins_name inspname,m.doc_no as insp_id,priority from is_enqinspd inner join is_inspm m on(m.doc_no=insp_id) where enq_id='"+edocno+"'");
				
				ResultSet resultSet = stmt.executeQuery ("select m.ins_name inspname,m.doc_no as insp_id,priority from is_enqinspd inner join is_inspm m on(m.doc_no=insp_id) where enq_id='"+edocno+"'");
				RESULTDATA=ClsCommon.convertToJSON(resultSet);
				System.out.println(RESULTDATA);
				
		}
		catch(Exception e){
			e.printStackTrace();
		}
 		finally{
 			stmt.close();
			conn.close();
			}
        return RESULTDATA;
    }
	
	public   JSONArray mainSrearch(HttpSession session,String sclname,String smob,String dcno,String refno,int check) throws SQLException {

        JSONArray RESULTDATA=new JSONArray();
    	    	
        String brnchid=session.getAttribute("BRANCHID").toString();

    	String sqltest="";
    	
    	if(!(sclname.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and refname like '"+sclname+"%'";
    	}
    	if(!(smob.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and com_mob like '"+smob+"'";
    	}
    	if(!(dcno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and e.doc_no like '"+dcno+"%'";
    	}
    	if(!(refno.equalsIgnoreCase(""))){
    		sqltest=sqltest+" and e.refno='"+refno+"%'";
    	}
 
    	Connection conn =null;
  		Statement stmtEnq =null;
  		
  		try {
  		 
  				conn = ClsConnection.getMyConnection();
  				stmtEnq = conn.createStatement();
  			
  				if(check>0){
				
  					String str1Sql=("select e.client_id cldocno,e.refno as refno,e.doc_no as edocno,if(e.client_id>0,RefName,e.name) as clname,com_mob from is_enqmaster e left join my_acbook a on(a.cldocno=client_id and a.dtype='CRM') where e.status=3 order by e.doc_no");

  					ResultSet resultSet = stmtEnq.executeQuery (str1Sql);
  					RESULTDATA=ClsCommon.convertToJSON(resultSet);
  				
  				}
		}
		catch(Exception e){
			e.printStackTrace();
		}
  		finally{
  			stmtEnq.close();
			conn.close();
			}
        return RESULTDATA;
    }
		
	
	public int insert(java.sql.Date enqDate,String refno,int clientid,int cpid,String time,String restime,int prjownerid,int vendorid,int subvendorid,int clientcur_id,ArrayList jobdetgridList,String mode,String formcode,HttpSession session,String address,String salesman,String salid,String mob,String tel,String clientname,String email ,String cperson) throws SQLException{
		
		Connection conn=null;
		CallableStatement stmtEnq=null;
		int  docno=0;
		int jobresultSet=0;
		int rateresultSet=0;
		int ratermresultSet=0;
		
		try {
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			
			stmtEnq = conn.prepareCall("{CALL  EenquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtEnq.registerOutParameter(14, java.sql.Types.INTEGER);
		      // main
			stmtEnq.setDate(1,enqDate);
			stmtEnq.setString(2,refno);
			stmtEnq.setInt(3,clientid);
			stmtEnq.setString(4,time);
			stmtEnq.setString(5,restime);
			stmtEnq.setInt(6,prjownerid==0?clientid:prjownerid);
			stmtEnq.setInt(7,vendorid);
			stmtEnq.setInt(8,subvendorid);
			stmtEnq.setInt(9,clientcur_id);
			stmtEnq.setInt(10,Integer.parseInt(session.getAttribute("BRANCHID").toString().trim()));
			stmtEnq.setString(11,mode);
			stmtEnq.setString(12,formcode);
			stmtEnq.setInt(13,Integer.parseInt(session.getAttribute("USERID").toString().trim()));
			stmtEnq.setInt(15,cpid);
			stmtEnq.setString(16,address);
			stmtEnq.setString(17,salesman);
			stmtEnq.setString(18,salid);
			stmtEnq.setString(19,mob);
			stmtEnq.setString(20,tel);
			stmtEnq.setString(21,clientname);
			stmtEnq.setString(22,email);
			stmtEnq.setString(23,cperson);
			stmtEnq.executeQuery();
		     
			docno=stmtEnq.getInt("docNo");
		     
		     if(docno>0) {
		    	 
				   for(int i=0;i< jobdetgridList.size() ;i++){
						  String[] jobdetgridarray=((String) jobdetgridList.get(i)).split("::");
						  
						   String sql="";
						   int j=1;
						   System.out.println(ClsCommon.changetstmptoSqlDate(jobdetgridarray[6].trim()));
						   sql="INSERT INTO is_enqjobdet(enq_id, ser_id, comodity_id, trade_id, area_id, qty, descrptn, stdate, endate, freq_id) values('"+docno+"',"
								      + "'"+(jobdetgridarray[0].trim().equalsIgnoreCase("undefined")||jobdetgridarray[0]==null  || jobdetgridarray[0].trim().equalsIgnoreCase("") || jobdetgridarray[0].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[0].isEmpty()?0:jobdetgridarray[0].trim())+"',"
									  + "'"+(jobdetgridarray[1].trim().equalsIgnoreCase("undefined")||jobdetgridarray[1]==null  || jobdetgridarray[1].trim().equalsIgnoreCase("") || jobdetgridarray[1].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[1].isEmpty()?0:jobdetgridarray[1].trim())+"',"
									  + "'"+(jobdetgridarray[2].trim().equalsIgnoreCase("undefined")||jobdetgridarray[2]==null  || jobdetgridarray[2].trim().equalsIgnoreCase("") || jobdetgridarray[2].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[2].isEmpty()?0:jobdetgridarray[2].trim())+"',"
									  + "'"+(jobdetgridarray[3].trim().equalsIgnoreCase("undefined")||jobdetgridarray[3]==null  || jobdetgridarray[3].trim().equalsIgnoreCase("") || jobdetgridarray[3].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[3].isEmpty()?0:jobdetgridarray[3].trim())+"',"
									  + "'"+(jobdetgridarray[4].trim().equalsIgnoreCase("undefined")||jobdetgridarray[4]==null  || jobdetgridarray[4].trim().equalsIgnoreCase("") || jobdetgridarray[4].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[4].isEmpty()?0:jobdetgridarray[4].trim())+"',"
									  + "'"+(jobdetgridarray[5].trim().equalsIgnoreCase("undefined")||jobdetgridarray[5]==null  || jobdetgridarray[5].trim().equalsIgnoreCase("") || jobdetgridarray[5].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[4].isEmpty()?0:jobdetgridarray[5].trim())+"',"
									  + "'"+(jobdetgridarray[6].trim().equalsIgnoreCase("undefined")||jobdetgridarray[6]==null  || jobdetgridarray[6].trim().equalsIgnoreCase("") || jobdetgridarray[6].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[6].isEmpty()?0:ClsCommon.changetstmptoSqlDate(jobdetgridarray[6].trim()))+"',"
									  + "'"+(jobdetgridarray[7].trim().equalsIgnoreCase("undefined")||jobdetgridarray[7]==null  || jobdetgridarray[7].trim().equalsIgnoreCase("") || jobdetgridarray[7].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[7].isEmpty()?0:ClsCommon.changetstmptoSqlDate(jobdetgridarray[7].trim()))+"',"
									  + "'"+(jobdetgridarray[8].trim().equalsIgnoreCase("undefined")||jobdetgridarray[8]==null  || jobdetgridarray[8].trim().equalsIgnoreCase("") || jobdetgridarray[8].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[8].isEmpty()?0:jobdetgridarray[8].trim())+"')";
									  System.out.println("==tclsql===+"+sql);
									  
									  jobresultSet = stmtEnq.executeUpdate (sql);
									  j=j+1;
									  if(jobresultSet<=0)
									     {
									    	 return 0; 
									     }
						   
						   
				   }
			   }
		     conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			
			stmtEnq.close();
			conn.close();
			
		}
		return docno;
	}
	
	
public int update(String edocno,java.sql.Date enqDate,String refno,int clientid,int cpid,String time,String restime,int prjownerid,int vendorid,int subvendorid,int clientcur_id,ArrayList jobdetgridList,String mode,String formcode,HttpSession session,String address,String salesman,String salid,String mob,String tel,String clientname,String email,String cperson ) throws SQLException{
		
		Connection conn=null;
		CallableStatement stmtEnq=null;
		int  docno=0;
		int jobresultSet=0;
		int rateresultSet=0;
		int ratermresultSet=0;
		
		try {
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			
			stmtEnq = conn.prepareCall("{CALL  EenquiryDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
			stmtEnq.setInt(14, Integer.parseInt(edocno));
		      // main
			stmtEnq.setDate(1,enqDate);
			stmtEnq.setString(2,refno);
			stmtEnq.setInt(3,clientid);
			stmtEnq.setString(4,time);
			stmtEnq.setString(5,restime);
			stmtEnq.setInt(6,prjownerid);
			stmtEnq.setInt(7,vendorid);
			stmtEnq.setInt(8,subvendorid);
			stmtEnq.setInt(9,clientcur_id);
			stmtEnq.setInt(10,Integer.parseInt(session.getAttribute("BRANCHID").toString().trim()));
			stmtEnq.setString(11,mode);
			stmtEnq.setString(12,formcode);
			stmtEnq.setInt(13,Integer.parseInt(session.getAttribute("USERID").toString().trim()));
			stmtEnq.setInt(15,cpid);
			stmtEnq.setString(16,address);
			stmtEnq.setString(17,salesman);
			stmtEnq.setString(18,salid);
			stmtEnq.setString(19,mob);
			stmtEnq.setString(20,tel);
			stmtEnq.setString(21,clientname);
			stmtEnq.setString(22,email);
			stmtEnq.setString(23,cperson);
			stmtEnq.executeQuery();
		     
			docno=stmtEnq.getInt("docNo");
		     
		    if(docno>0) {

				   for(int i=0;i< jobdetgridList.size() ;i++){
						  String[] jobdetgridarray=((String) jobdetgridList.get(i)).split("::");
						  
						   String sql="";
						   int j=1;

						   sql="INSERT INTO is_enqjobdet(enq_id, ser_id, comodity_id, trade_id, area_id, qty, descrptn, stdate, endate, freq_id) values('"+docno+"',"
								      + "'"+(jobdetgridarray[0].trim().equalsIgnoreCase("undefined")||jobdetgridarray[0]==null  || jobdetgridarray[0].trim().equalsIgnoreCase("") || jobdetgridarray[0].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[0].isEmpty()?0:jobdetgridarray[0].trim())+"',"
									  + "'"+(jobdetgridarray[1].trim().equalsIgnoreCase("undefined")||jobdetgridarray[1]==null  || jobdetgridarray[1].trim().equalsIgnoreCase("") || jobdetgridarray[1].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[1].isEmpty()?0:jobdetgridarray[1].trim())+"',"
									  + "'"+(jobdetgridarray[2].trim().equalsIgnoreCase("undefined")||jobdetgridarray[2]==null  || jobdetgridarray[2].trim().equalsIgnoreCase("") || jobdetgridarray[2].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[2].isEmpty()?0:jobdetgridarray[2].trim())+"',"
									  + "'"+(jobdetgridarray[3].trim().equalsIgnoreCase("undefined")||jobdetgridarray[3]==null  || jobdetgridarray[3].trim().equalsIgnoreCase("") || jobdetgridarray[3].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[3].isEmpty()?0:jobdetgridarray[3].trim())+"',"
									  + "'"+(jobdetgridarray[4].trim().equalsIgnoreCase("undefined")||jobdetgridarray[4]==null  || jobdetgridarray[4].trim().equalsIgnoreCase("") || jobdetgridarray[4].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[4].isEmpty()?0:jobdetgridarray[4].trim())+"',"
									  + "'"+(jobdetgridarray[5].trim().equalsIgnoreCase("undefined")||jobdetgridarray[5]==null  || jobdetgridarray[5].trim().equalsIgnoreCase("") || jobdetgridarray[5].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[4].isEmpty()?0:jobdetgridarray[5].trim())+"',"
									  + "'"+(jobdetgridarray[6].trim().equalsIgnoreCase("undefined")||jobdetgridarray[6]==null  || jobdetgridarray[6].trim().equalsIgnoreCase("") || jobdetgridarray[6].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[6].isEmpty()?0:ClsCommon.changetstmptoSqlDate(jobdetgridarray[6].trim()))+"',"
									  + "'"+(jobdetgridarray[7].trim().equalsIgnoreCase("undefined")||jobdetgridarray[7]==null  || jobdetgridarray[7].trim().equalsIgnoreCase("") || jobdetgridarray[7].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[7].isEmpty()?0:ClsCommon.changetstmptoSqlDate(jobdetgridarray[7].trim()))+"',"
									  + "'"+(jobdetgridarray[8].trim().equalsIgnoreCase("undefined")||jobdetgridarray[8]==null  || jobdetgridarray[8].trim().equalsIgnoreCase("") || jobdetgridarray[8].trim().equalsIgnoreCase("NaN")|| jobdetgridarray[8].isEmpty()?0:jobdetgridarray[8].trim())+"')";
									  
									  jobresultSet = stmtEnq.executeUpdate (sql);
									  j=j+1;
									  if(jobresultSet<=0) {
									    	 return 0; 
									  }
				   }
			   }
		     conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			stmtEnq.close();
			conn.close();
		}
		return docno;
	}
	
	public int delete(String docno,HttpSession session) throws SQLException{
		
		int result=0;
        Connection conn=null;
        Statement cpstmt =null;
        int tranentry=0;
		
        try {
			
			conn=ClsConnection.getMyConnection();
			conn.setAutoCommit(false);
			cpstmt = conn.createStatement ();
			
			String sql="update is_enqmaster set status=7 where doc_no="+docno+" and curdtype='IENQ'";
			int resultSet = cpstmt.executeUpdate(sql);
			
			if(resultSet>0) {
				result=1;
				conn.commit();
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
			cpstmt.close();
		}
		return result;
	}
	
	 public   JSONArray specGridload(int docno) throws SQLException {

	    	JSONArray RESULTDATA=new JSONArray();
		   
	    	Connection conn =null;
	 		Statement cpstmt =null;
	 		try {
	 		    conn = ClsConnection.getMyConnection();
	 		    cpstmt = conn.createStatement ();
	            	
				String  cpsql=("select c.doc_no as doc_no,description as commodity,trade as discipline,service,sp.serid as serid,sp.tradeid as tradeid from is_inspspecfn sp left join  is_comm c on(sp.comodityid=c.doc_no) left join is_trade t on(t.doc_no=c.tradeId) left join is_service s on(s.doc_no=c.serId) where inspdoc_no="+docno+"");

				ResultSet resultSet = cpstmt.executeQuery (cpsql);
				RESULTDATA=ClsCommon.convertToJSON(resultSet);	
			}
			catch(Exception e){
				e.printStackTrace();
			}
	 		finally{
	 			cpstmt.close();
				conn.close();
				}
	        return RESULTDATA;
	    }
	 
		 
	public  ClsEnquiryBean getViewDetails(HttpSession session,String docNo) throws SQLException {
			ClsEnquiryBean clsEnqBean = new ClsEnquiryBean();

			Connection conn =null;
	 		Statement stmtCPV0 =null;
	 		
	 		try {
	 		 
	 			conn = ClsConnection.getMyConnection();
	 			stmtCPV0 = conn.createStatement ();
			
				String strSql = ("select e.address,if(e.cperson_id>0,crm.mob,e.mob) as mob,if(e.cperson_id>0,crm.tel,e.tel) as tel,if(e.cperson_id>0,crm.email,e.email) as email,if(e.cperson_id>0,crm.cperson,e.cperson) as cperson,if(e.salid>0,sm.sal_name,e.salname) as salname,e.salid,e.refno as enqrefno,time,restime,if(e.client_id>0,RefName,e.name) as clientname,if(e.client_id>0,ac.com_mob,e.name) as clientdet,coalesce(own.owner,RefName) as owner,vnd.owner as vendor,"
							  + "svnd.owner as svendor,e.date as enq_date,ac.cldocno as cldocno,own.doc_no as ownerid,vnd.doc_no as vndrid,svnd.doc_no as svndrid,CONCAT(crm.tel) as cperdet,crm.row_no as cpid,ac.curid as curid,mc.c_rate as crate from is_enqmaster e left join my_acbook ac on(e.client_id=ac.cldocno and ac.dtype='CRM')"
							  + " left join my_salm sm on e.salid=sm.doc_no left join is_prjowner own on(e.prjowner_id=own.doc_no and own.dtype='IPO') left join is_prjowner vnd on(e.prjvendor_id=vnd.doc_no and vnd.dtype='IVN')"
							  + " left join is_prjowner svnd on(e.subvendor_id=svnd.doc_no and svnd.dtype='IVN') left join my_crmcontact crm on(e.cperson_id=crm.row_no and crm.dtype='CRM') left join my_area a on(crm.area_id=a.doc_no) left join my_curr mc on(ac.curid=mc.doc_no) where  e.doc_no="+docNo+" and  e.status=3 ");
				
				ResultSet resultSet = stmtCPV0.executeQuery(strSql);
	
				while (resultSet.next()) {
					
					clsEnqBean.setDocno(docNo);
					clsEnqBean.setTxtrefno(resultSet.getString("enqrefno"));
					clsEnqBean.setJqxIenqDate(resultSet.getString("enq_date"));
					clsEnqBean.setHidjqxIenqDate(resultSet.getString("enq_date"));
					clsEnqBean.setJqxTime(resultSet.getString("time"));
					clsEnqBean.setHidjqxTime(resultSet.getString("time"));
					clsEnqBean.setJqxResponseTime(resultSet.getString("restime"));
					clsEnqBean.setHidjqxResponseTime(resultSet.getString("restime"));
					clsEnqBean.setTxtclientname(resultSet.getString("clientname"));
					clsEnqBean.setTxtclientdet(resultSet.getString("clientdet"));
					clsEnqBean.setTxtcontactperson(resultSet.getString("cperson"));
					clsEnqBean.setTxtprojectowner(resultSet.getString("owner"));
					clsEnqBean.setTxtvendor(resultSet.getString("vendor"));
					clsEnqBean.setTxtsubsupplier(resultSet.getString("svendor"));
					clsEnqBean.setClientid(resultSet.getInt("cldocno"));
					clsEnqBean.setProjectownerid(resultSet.getInt("ownerid"));
					clsEnqBean.setVendorid(resultSet.getInt("vndrid"));
					clsEnqBean.setSubvendorid(resultSet.getInt("svndrid"));	
					clsEnqBean.setCptrno(resultSet.getInt("cpid"));
					clsEnqBean.setClientcurid(resultSet.getInt("curid"));
					clsEnqBean.setClientcurrate(resultSet.getDouble("crate"));
					
					
					clsEnqBean.setTxtaddress(resultSet.getString("address"));
					clsEnqBean.setTxtsalesman(resultSet.getString("salname"));
					clsEnqBean.setTxtsalesmandocno(resultSet.getString("salid"));
					clsEnqBean.setTxtmobile(resultSet.getString("mob"));
					clsEnqBean.setTxttelno(resultSet.getString("tel"));
					clsEnqBean.setTxtemail(resultSet.getString("email"));
				}
			}
			catch(Exception e){
			e.printStackTrace();
			}
	 		finally{
	 			stmtCPV0.close();
				conn.close();
				}
			
			return clsEnqBean;
			}
		 
		 
		 public String ceGridInsert(String edocno,ArrayList cegridList,int estatusid) throws SQLException{
			 
			 	Connection conn=null;
			 	Statement  stmtEnq=null;
			 	
				int  docno=0;
				int jobresultSet=0;
				int rateresultSet=0;
				int ratermresultSet=0;
				String delsql="";
				int val=0;
					
				try{
				
					conn=ClsConnection.getMyConnection();
					conn.setAutoCommit(false);
					
					stmtEnq=conn.createStatement();
					Statement stmtdel = conn.createStatement ();
				  
					delsql="delete from is_costestimate where enq_id='"+edocno+"' and status_id='"+estatusid+"'";

					val= stmtdel.executeUpdate(delsql);
				  
					for(int i=0;i< cegridList.size() ;i++){
						
						String[] cegridarray=((String) cegridList.get(i)).split("::");
					 
						String sql="";
						int j=1;
						
						sql="INSERT INTO is_costestimate( enq_id,status_id, Nhr, Hhr, Thr, Mday8Hr, Mday10Hr, Hmday8Hr, Hmday10Hr, Mn22x8Hr, Mn22x10Hr, Hmn22x8Hr, Hmn22x10Hr, otabv8Hr, otabv10Hr, Hotabv8Hr, Hotabv10Hr, Magepkm, Magepmi, peridum, lodging, carchg, trainchg, buschg, taxichg, flightchg, mealschg, tollchg, fuelchg, othrchg,costfield_id) values('"+edocno+"',"+estatusid+","							              
							   			  + "'"+(cegridarray[0].trim().equalsIgnoreCase("undefined")||cegridarray[0]==null  || cegridarray[0].trim().equalsIgnoreCase("") || cegridarray[0].trim().equalsIgnoreCase("NaN")|| cegridarray[0].isEmpty()?0:cegridarray[0].trim())+"',"
										  + "'"+(cegridarray[1].trim().equalsIgnoreCase("undefined")||cegridarray[1]==null  || cegridarray[1].trim().equalsIgnoreCase("") || cegridarray[1].trim().equalsIgnoreCase("NaN")|| cegridarray[1].isEmpty()?0:cegridarray[1].trim())+"',"
										  + "'"+(cegridarray[2].trim().equalsIgnoreCase("undefined")||cegridarray[2]==null  || cegridarray[2].trim().equalsIgnoreCase("") || cegridarray[2].trim().equalsIgnoreCase("NaN")|| cegridarray[2].isEmpty()?0:cegridarray[2].trim())+"',"
										  + "'"+(cegridarray[3].trim().equalsIgnoreCase("undefined")||cegridarray[3]==null  || cegridarray[3].trim().equalsIgnoreCase("") || cegridarray[3].trim().equalsIgnoreCase("NaN")|| cegridarray[3].isEmpty()?0:cegridarray[3].trim())+"',"
										  + "'"+(cegridarray[4].trim().equalsIgnoreCase("undefined")||cegridarray[4]==null  || cegridarray[4].trim().equalsIgnoreCase("") || cegridarray[4].trim().equalsIgnoreCase("NaN")|| cegridarray[4].isEmpty()?0:cegridarray[4].trim())+"',"
										  + "'"+(cegridarray[5].trim().equalsIgnoreCase("undefined")||cegridarray[5]==null  || cegridarray[5].trim().equalsIgnoreCase("") || cegridarray[5].trim().equalsIgnoreCase("NaN")|| cegridarray[5].isEmpty()?0:cegridarray[5].trim())+"',"
										  + "'"+(cegridarray[6].trim().equalsIgnoreCase("undefined")||cegridarray[6]==null  || cegridarray[6].trim().equalsIgnoreCase("") || cegridarray[6].trim().equalsIgnoreCase("NaN")|| cegridarray[6].isEmpty()?0:cegridarray[6].trim())+"',"
										  + "'"+(cegridarray[7].trim().equalsIgnoreCase("undefined")||cegridarray[7]==null  || cegridarray[7].trim().equalsIgnoreCase("") || cegridarray[7].trim().equalsIgnoreCase("NaN")|| cegridarray[7].isEmpty()?0:cegridarray[7].trim())+"',"
										  + "'"+(cegridarray[8].trim().equalsIgnoreCase("undefined")||cegridarray[8]==null  || cegridarray[8].trim().equalsIgnoreCase("") || cegridarray[8].trim().equalsIgnoreCase("NaN")|| cegridarray[8].isEmpty()?0:cegridarray[8].trim())+"',"
										  + "'"+(cegridarray[9].trim().equalsIgnoreCase("undefined")||cegridarray[9]==null  || cegridarray[9].trim().equalsIgnoreCase("") || cegridarray[9].trim().equalsIgnoreCase("NaN")|| cegridarray[9].isEmpty()?0:cegridarray[9].trim())+"',"
										  + "'"+(cegridarray[10].trim().equalsIgnoreCase("undefined")||cegridarray[10]==null  || cegridarray[10].trim().equalsIgnoreCase("") || cegridarray[10].trim().equalsIgnoreCase("NaN")|| cegridarray[10].isEmpty()?0:cegridarray[10].trim())+"',"
										  + "'"+(cegridarray[11].trim().equalsIgnoreCase("undefined")||cegridarray[11]==null  || cegridarray[11].trim().equalsIgnoreCase("") || cegridarray[11].trim().equalsIgnoreCase("NaN")|| cegridarray[11].isEmpty()?0:cegridarray[11].trim())+"',"
										  + "'"+(cegridarray[12].trim().equalsIgnoreCase("undefined")||cegridarray[12]==null  || cegridarray[12].trim().equalsIgnoreCase("") || cegridarray[12].trim().equalsIgnoreCase("NaN")|| cegridarray[12].isEmpty()?0:cegridarray[12].trim())+"',"
										  + "'"+(cegridarray[13].trim().equalsIgnoreCase("undefined")||cegridarray[13]==null  || cegridarray[13].trim().equalsIgnoreCase("") || cegridarray[13].trim().equalsIgnoreCase("NaN")|| cegridarray[13].isEmpty()?0:cegridarray[13].trim())+"',"
										  + "'"+(cegridarray[14].trim().equalsIgnoreCase("undefined")||cegridarray[14]==null  || cegridarray[14].trim().equalsIgnoreCase("") || cegridarray[14].trim().equalsIgnoreCase("NaN")|| cegridarray[14].isEmpty()?0:cegridarray[14].trim())+"',"
								          + "'"+(cegridarray[15].trim().equalsIgnoreCase("undefined")||cegridarray[15]==null  || cegridarray[15].trim().equalsIgnoreCase("") || cegridarray[15].trim().equalsIgnoreCase("NaN")|| cegridarray[15].isEmpty()?0:cegridarray[15].trim())+"',"
								          + "'"+(cegridarray[16].trim().equalsIgnoreCase("undefined")||cegridarray[16]==null  || cegridarray[16].trim().equalsIgnoreCase("") || cegridarray[16].trim().equalsIgnoreCase("NaN")|| cegridarray[16].isEmpty()?0:cegridarray[16].trim())+"',"
								          + "'"+(cegridarray[17].trim().equalsIgnoreCase("undefined")||cegridarray[17]==null  || cegridarray[17].trim().equalsIgnoreCase("") || cegridarray[17].trim().equalsIgnoreCase("NaN")|| cegridarray[17].isEmpty()?0:cegridarray[17].trim())+"',"
								          + "'"+(cegridarray[18].trim().equalsIgnoreCase("undefined")||cegridarray[18]==null  || cegridarray[18].trim().equalsIgnoreCase("") || cegridarray[18].trim().equalsIgnoreCase("NaN")|| cegridarray[18].isEmpty()?0:cegridarray[18].trim())+"',"
								          + "'"+(cegridarray[19].trim().equalsIgnoreCase("undefined")||cegridarray[19]==null  || cegridarray[19].trim().equalsIgnoreCase("") || cegridarray[19].trim().equalsIgnoreCase("NaN")|| cegridarray[19].isEmpty()?0:cegridarray[19].trim())+"',"
								          + "'"+(cegridarray[20].trim().equalsIgnoreCase("undefined")||cegridarray[20]==null  || cegridarray[20].trim().equalsIgnoreCase("") || cegridarray[20].trim().equalsIgnoreCase("NaN")|| cegridarray[20].isEmpty()?0:cegridarray[20].trim())+"',"
								          + "'"+(cegridarray[21].trim().equalsIgnoreCase("undefined")||cegridarray[21]==null  || cegridarray[21].trim().equalsIgnoreCase("") || cegridarray[21].trim().equalsIgnoreCase("NaN")|| cegridarray[21].isEmpty()?0:cegridarray[21].trim())+"',"
								          + "'"+(cegridarray[22].trim().equalsIgnoreCase("undefined")||cegridarray[22]==null  || cegridarray[22].trim().equalsIgnoreCase("") || cegridarray[22].trim().equalsIgnoreCase("NaN")|| cegridarray[22].isEmpty()?0:cegridarray[22].trim())+"',"
								          + "'"+(cegridarray[23].trim().equalsIgnoreCase("undefined")||cegridarray[23]==null  || cegridarray[23].trim().equalsIgnoreCase("") || cegridarray[23].trim().equalsIgnoreCase("NaN")|| cegridarray[23].isEmpty()?0:cegridarray[23].trim())+"',"
								          + "'"+(cegridarray[24].trim().equalsIgnoreCase("undefined")||cegridarray[24]==null  || cegridarray[24].trim().equalsIgnoreCase("") || cegridarray[24].trim().equalsIgnoreCase("NaN")|| cegridarray[24].isEmpty()?0:cegridarray[24].trim())+"',"
								          + "'"+(cegridarray[25].trim().equalsIgnoreCase("undefined")||cegridarray[25]==null  || cegridarray[25].trim().equalsIgnoreCase("") || cegridarray[25].trim().equalsIgnoreCase("NaN")|| cegridarray[25].isEmpty()?0:cegridarray[25].trim())+"',"
								          + "'"+(cegridarray[26].trim().equalsIgnoreCase("undefined")||cegridarray[26]==null  || cegridarray[26].trim().equalsIgnoreCase("") || cegridarray[26].trim().equalsIgnoreCase("NaN")|| cegridarray[26].isEmpty()?0:cegridarray[26].trim())+"',"
								          + "'"+(cegridarray[27].trim().equalsIgnoreCase("undefined")||cegridarray[27]==null  || cegridarray[27].trim().equalsIgnoreCase("") || cegridarray[27].trim().equalsIgnoreCase("NaN")|| cegridarray[27].isEmpty()?0:cegridarray[27].trim())+"',"
								          + "'"+(cegridarray[28].trim().equalsIgnoreCase("undefined")||cegridarray[28]==null  || cegridarray[28].trim().equalsIgnoreCase("") || cegridarray[28].trim().equalsIgnoreCase("NaN")|| cegridarray[28].isEmpty()?0:cegridarray[28].trim())+"')";
								        
						ratermresultSet = stmtEnq.executeUpdate (sql);
						j=j+1;
								  
						if(ratermresultSet<=0) {
								   return "0"; 
						} else {
									conn.commit();
						}
					   
			          }
					}
					catch(Exception e){
						e.printStackTrace();
					}
					finally{
						stmtEnq.close();
						conn.close();
					}
				return edocno;
			 
		 		}
		 
		 public JSONArray salesManDetailsSearch(HttpSession session,String slname,String mob,int id) throws SQLException {

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

				String sqltest="";

				if(!(slname.equalsIgnoreCase("undefined"))&&!(slname.equalsIgnoreCase(""))&&!(slname.equalsIgnoreCase("0"))){
					sqltest=sqltest+" and sal_name like '%"+slname+"%'";
				}
				if(!(mob.equalsIgnoreCase("undefined"))&&!(mob.equalsIgnoreCase(""))&&!(mob.equalsIgnoreCase("0"))){
					sqltest=sqltest+" and mob_no like '%"+mob+"%'";
				}


				Connection conn = null;
				try {
					conn = ClsConnection.getMyConnection();
					Statement stmt = conn.createStatement ();

					if(id>0){
						//String sql= ("select sal_name,mob_no,doc_no from my_salm where status=3 " +sqltest);
						
						String consql="",chksalmanid="",flag="0";
						
						String checksaleman="select sal_name,doc_no,mob_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" ";
						ResultSet chksalman=stmt.executeQuery(checksaleman);
						while(chksalman.next()){
									chksalmanid=chksalman.getString("salesuserlink");
									flag="1";
						}	
						if(flag.equalsIgnoreCase("1")){
							consql="select sal_name,doc_no,mob_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" "+sqltest;
						}
						else if(flag.equalsIgnoreCase("0")){
								consql="select sal_name,doc_no,mob_no,salesuserlink from my_salm where status=3 and salesuserlink="+session.getAttribute("USERID")+" "+sqltest 
									+"union select sal_name,doc_no,mob_no,salesuserlink from my_salm "+sqltest ;
							}
						//ResultSet rsconfg = stmt.executeQuery(consql);
						
						System.out.println("*******salesManDetailsSearch*********"+consql);	
						
						ResultSet resultSet = stmt.executeQuery(consql);

						RESULTDATA=ClsCommon.convertToJSON(resultSet);
					
						stmt.close();
						conn.close();
					}
				} catch(Exception e){
					conn.close();
					e.printStackTrace();
				}
				return RESULTDATA;
			}
			
		 
}

