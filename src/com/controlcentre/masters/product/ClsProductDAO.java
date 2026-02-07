package com.controlcentre.masters.product;
import java.io.FileInputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.common.ClsCommon;
import com.connection.ClsConnection;

import net.sf.json.JSONArray;

public class ClsProductDAO {
	ClsProductBean proact= new ClsProductBean();
	ClsCommon ClsCommon=new ClsCommon();
	ClsConnection ClsConnection=new ClsConnection();
	
	
	public JSONArray alterProductSearch(HttpSession session,String chk) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		
			
		

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			//System.out.println("chk===="+chk);
			if(chk.equalsIgnoreCase("y")) {
			/*String sql="select m.part_no,m.productname name,m.psrno  from my_main m left join " + 
					" my_unitm u on m.munit=u.doc_no left join my_dept dt on m.deptid=dt.doc_no and dt.status=3 left join my_prodattrib at on(at.mpsrno=m.doc_no) left join  my_brand bd on m.brandid=bd.doc_no  " + 
					" inner join my_prddin i " + 
					" on(i.psrno=m.psrno and i.prdid=m.doc_no and i.specno=at.mspecno and i.brhid='"+session.getAttribute("BRANCHID").toString()+"' ) " + 
					" left join my_catm c on c.doc_no=m.catid left join my_scatm sc on m.scatid=sc.doc_no " + 
					" where m.status=3  group by m.psrno order by i.prdid,i.date";
			*/
				String sql="select m.part_no,m.productname name,m.psrno  from my_main m where m.status=3 ";
				
			//System.out.println("alterproductsrch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

			}
			else {
				return RESULTDATA;
			}
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray alterMainProductSearch(HttpSession session,String chk,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		
			
		

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			//System.out.println("chk===="+chk);
			if(chk.equalsIgnoreCase("y")) {
			String sql="select m.part_no,m.productname as name,m.psrno,ar.doc_no  from my_pralter ar left join my_main m on m.psrno=ar.altpsrno\r\n" + 
					" where m.status=3 and ar.rdocno="+docno;
			
			//System.out.println("alterproductsrch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

			}
			else {
				return RESULTDATA;
			}
		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		//System.out.println(RESULTDATA);
		return RESULTDATA;
	}
	
	
	
	
	public JSONArray ssedingLoad(HttpSession session,String psrno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

 
			String sql="select part_no,priority,if(discontinued=1,true,false) discontinued  FROM  my_prdsuperseding where psrno='"+psrno+"'   ";
 
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
 
	
	
	public JSONArray prdbranchLoad(HttpSession session,String chktype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			 
		 
        if(chktype.equalsIgnoreCase("2"))
        {
		 	String sql="select  BRANCHNAME branch,doc_no bdocno from my_brch where status=3";
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
        }
        
        else 
        {
        	String sql="select company branch,doc_no bdocno from my_comp where status=3";
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
        	
        	
        }

		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdbranchLoad(HttpSession session,String docno,String chktype) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select 1 as selects,b.BRANCHNAME branch,b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal from my_brch b left join my_desc d on(d.brhid=b.doc_no) where d.psrno='"+docno+"'";
			  if(chktype.equalsIgnoreCase("2"))
		        {
			String sql="select selects, branch,bdocno,discontinued,bin, minstock,maxstock,"
					+ "retailprice,wholesale,normal,reorderlevel,reorderqty from (select 1 as selects,b.BRANCHNAME branch,"
					+ "b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,"
					+ "d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal,d.reorderlevel,d.reorderqty from my_brch b left join my_desc d "
					+ "on(d.brhid=b.doc_no) where d.psrno='"+docno+"' union all "
					+ "select 0 as selects,b.BRANCHNAME branch,b.doc_no bdocno,0 as discontinued,'' as bin,"
					+ "0 as minstock,0 as maxstock,0 as retailprice,0 as wholesale,0 as normal,0 reorderlevel,0 reorderqty "
					+ " from my_brch b where b.doc_no not in(select brhid from my_desc where psrno='"+docno+"')) as a";
			
			//System.out.println("===prdbranchLoadwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww===2=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);
		        }
			  else
			  {
					String sql="select selects, branch,bdocno,discontinued,bin, minstock,maxstock,"
							+ "retailprice,wholesale,normal,reorderlevel,reorderqty from (select 1 as selects,b.COMPANY branch,"
							+ "b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,"
							+ "d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal,d.reorderlevel,d.reorderqty from my_comp b left join my_desc d "
							+ "on(d.cmpid=b.doc_no) where d.psrno='"+docno+"' union all "
							+ "select 0 as selects,b.COMPANY branch,b.doc_no bdocno,0 as discontinued,'' as bin,0 as minstock"
							+ ",0 as maxstock,0 as retailprice,0 as wholesale,0 as normal,0 reorderlevel,0 reorderqty "
							+ " from my_comp b where b.doc_no not in(select cmpid from my_desc where psrno='"+docno+"')) as a";
					
				//System.out.println("===prdbranchLoad===sadfffasddfffffffffffffffffffffffffffffffffffffffffffffffffffff1="+sql);
					ResultSet resultSet = stmt.executeQuery(sql);
					RESULTDATA=ClsCommon.convertToJSON(resultSet);  
				  
			  }


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	public JSONArray pmLoad(HttpSession session,String psrno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select 1 as selects,b.BRANCHNAME branch,b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal from my_brch b left join my_desc d on(d.brhid=b.doc_no) where d.psrno='"+docno+"'";
			
/*			String sql="select  p.catid,  p.price1, p.price2, p.price3, p.discount1, p.discount2, p.discount3, p.foc1, p.foc2, p.foc3,c.cat_name from my_descpr p "
					+ " left join my_clcatm c on p.catid=c.doc_no where psrno='"+psrno+"' ";*/
			
			String sql="select  convert(p.catid,char(100)) catid, convert(if(p.price1=0,'',p.price1),char(100)) price1,convert(if(p.price2=0,'',p.price2),char(100)) price2,convert(if(p.price3=0,'',p.price3),char(100)) price3, "
					+ " convert(if(p.discount1=0,'',p.discount1),char(100)) discount1,convert(if(p.discount2=0,'',p.discount2),char(100)) discount2,convert(if(p.discount3=0,'',p.discount3),char(100)) discount3, "
					+ " convert(if(p.foc1=0,'',p.foc1),char(100)) foc1, convert(if(p.foc2=0,'',p.foc2),char(100)) foc2,convert(if(p.foc3=0,'',p.foc3),char(100)) foc3, "
					+ " convert(if(p.qty1=0,'',p.qty1),char(100)) qty1,convert(if(p.qty2=0,'',p.qty2),char(100))  qty2,convert(if(p.qty3=0,'',p.qty3),char(100)) qty3,c.cat_name from my_descpr p left join my_clcatm c on p.catid=c.doc_no where psrno='"+psrno+"' and c.dtype='CRM' "
							+ "	union all select convert(doc_no,char(100)) catid,  '' price1, '' price2, '' price3, '' discount1,'' discount2, '' discount3, "
							+ "	'' foc1, '' foc2, '' foc3,'' qty1,'' qty2,'' qty3, cat_name from my_clcatm 	where doc_no not in(select catid from my_descpr where psrno='"+psrno+"' )   and dtype='CRM' ";
			
					
		// //System.out.println("==ss==ass=="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray pmLoad() throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select 1 as selects,b.BRANCHNAME branch,b.doc_no bdocno,d.discontinued,d.bin as bin,d.minStock as minstock,d.maxStock as maxstock,d.price1 as retailprice,d.price2 as wholesale,d.price3 as normal from my_brch b left join my_desc d on(d.brhid=b.doc_no) where d.psrno='"+docno+"'";
			
			String sql="select doc_no catid,cat_name,category from my_clcatm where status=3 and dtype='CRM' ";
					
	//System.out.println("==ss111111111111111111111111111==="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public JSONArray prduomLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select u.doc_no docno,m.doc_no as unitid,m.unit,fr,wt weight,volume volumn,thk thickness,leng len,width width from my_unit u left join my_unitm m on(u.unit=m.doc_no) where psrno='"+docno+"'";
			//System.out.println("===prduomLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray prdsuitLoad(HttpSession session,String docno) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			/*String sql="select coalesce(sb.doc_no,-1) brandid,case when s.sbrand_id=-1 then 'ALL' else sb.brand end as brand,coalesce(sm.doc_no,-1) as modelid"
					+ ",case when s.smodel_id=-1 then 'ALL' else sm.model end as model,case when s.syomfrm_id=-1 then 'ALL' else y1.yom end as  yomfrm"
					+ ",coalesce(y1.doc_no,-1) as yomfrmid,case when s.syomto_id=-1 then 'ALL' else y2.yom end as yomto,coalesce(y2.doc_no,-1) as yomtoid,"
					+ "case when s.spec1_id=-1 then 'ALL' else s1.spec end as spec1,coalesce(s1.doc_no,-1) spec1id,case when s.spec2_id=-1 then 'ALL' else s2.spec end  as spec2"
					+ ",coalesce(s2.doc_no,-1)  spec2id,case when s.spec3_id=-1 then 'ALL' else s3.spec end  as spec3,coalesce(s3.doc_no,-1) spec3id,"
					+ "case when s.submodelid=-1 then 'ALL' else sub.submodel end as submodel,coalesce(sub.doc_no,-1) as submodelid from my_prodsuit s left join my_sbrand sb  "
					+ "on(s.sbrand_id=sb.doc_no) left join my_smodel sm on(s.smodel_id=sm.doc_no) left join my_syom  y1 "
					+ "on(y1.doc_no=s.syomfrm_id) left join my_syom y2 on(y2.doc_no=s.syomto_id) left join my_suitspec1 s1 "
					+ "on(s1.doc_no=s.spec1_id) left join my_suitspec2 s2 on(s2.doc_no=s.spec2_id) left join my_suitspec3 s3 "
					+ "on(s3.doc_no=s.spec3_id) left join my_ssubmodel sub on(s.submodelid=sub.doc_no) where psrno='"+docno+"'";*/

			
			if(docno.equalsIgnoreCase(""))
			{
				docno="0";
			}
			
			String sql="select s.doc_no,sf.yom yomfrm,st.yom yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
					+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
					+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
					+ "(case when sp.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
					+ "(case when sp.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
					+ "(case when sp.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
					+ "(case when sp.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
					+ "(case when sp.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
					+ "(case when sp.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
					+ "s.sbrandid brandid,s.smodelid modelid,s.submodelid submodelid,s.esizeid,sp.bsize1id,sp.bsize2id,sp.bsize3id,"
					+ "sp.csize1id,sp.csize2id,sp.csize3id,sf.doc_no yomfrmid,st.doc_no yomtoid  "
					+ "from my_prodsuit sp left join  my_vehsuitmaster s on(s.doc_no=sp.vehsuitid)"
					+ " left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
					+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)" //and sm.modelid=s.smodelid
					+ "left join my_suitspec1 s11 on(s11.doc_no=sp.bsize1id)"
					+ "left join my_suitspec1 s12 on(s12.doc_no=sp.bsize2id)"
					+ "left join my_suitspec1 s13 on(s13.doc_no=sp.bsize3id)"
					+ "left join my_suitspec3 s31 on(s31.doc_no=sp.csize1id)"
					+ "left join my_suitspec3 s32 on(s32.doc_no=sp.csize2id)"
					+ "left join my_suitspec3 s33 on(s33.doc_no=sp.csize3id)"
					+ "left join my_syom sf on(sf.doc_no=sp.syomfrm_id)"
					+ "left join my_syom st on(st.doc_no=sp.syomto_id)"
					+ "where s.status=3 and sp.psrno in ("+docno+")";
			
			
		//	//System.out.println("===prdsuitLoad====="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray suitSpecload(HttpSession session,String stype,String spec1id,String spec2id,String spec3id) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			 String sql="";
			if(stype.equalsIgnoreCase("1")){
			
				 sql="select s.doc_no spec1id, spec spec1,brand,(case when s.modelid=-1 then 'ALL' else model end) as model,(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,s.brandid,s.modelid,s.submodelid from my_suitspec1 s left join my_sbrand b "
						+ "on(b.doc_no=s.brandid) left join my_smodel m on(m.doc_no=s.modelid) left join my_ssubmodel "
						+ "sm on(sm.doc_No=s.submodelid) where s.doc_no in("+spec1id+") and s.status=3";

			}
			
			if(stype.equalsIgnoreCase("2")){
				
				 sql="select s.doc_no spec1id, s.spec spec1,s1.doc_no spec2id, s1.spec spec2,brand,(case when s.modelid=-1 then 'ALL' else model end) as model,(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,s.brandid,s.modelid,s.submodelid from my_suitspec1 s left join my_sbrand b "
						+ "on(b.doc_no=s.brandid) left join my_smodel m on(m.doc_no=s.modelid) left join my_ssubmodel "
						+ "sm on(sm.doc_No=s.submodelid) left join my_suitspec2 s1 on(s1.submodelid=sm.doc_no) where s.doc_no in("+spec1id+") and s1.doc_no in("+spec2id+") and s.status=3";

			}
			
			if(stype.equalsIgnoreCase("3")){
				
				 sql="select s.doc_no spec1id, s.spec spec1,s1.doc_no spec2id, s1.spec spec2,s2.doc_no spec3id, s2.spec spec3,brand,(case when s.modelid=-1 then 'ALL' else model end) as model,(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,s.brandid,s.modelid,s.submodelid from my_suitspec1 s left join my_sbrand b "
						+ "on(b.doc_no=s.brandid) left join my_smodel m on(m.doc_no=s.modelid) left join my_ssubmodel "
						+ "sm on(sm.doc_No=s.submodelid) left join my_suitspec2 s1 on(s1.submodelid=sm.doc_no) left join my_suitspec3 s2 on(s2.submodelid=sm.doc_no) where s.doc_no in("+spec1id+") and s1.doc_no in("+spec2id+") and s2.doc_no in("+spec3id+") and s.status=3";

			}
			
//
		//	//System.out.println("==sql==suitSpecload=="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);

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


	public JSONArray unitSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
int method=0;
			String sqlss="select method from GL_PRDCONFIG where field_nme='multiqty' ";
			ResultSet rss=stmt.executeQuery(sqlss);
			if(rss.next())
			{
				method=rss.getInt("method");
			}
			
			String sql="select "+method+" method, doc_no,unit,unit_desc from my_unitm where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray deptSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select department, doc_no from my_dept where status<>7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray typeSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,type ptype from my_stype where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray typeFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,producttype ptype from my_ptype where status=3";
//System.out.println("typesearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray modelSearch(HttpSession session,String brandid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"'";
			String sql="select convert(doc_no,char(50)) as doc_no,model,brand from ( select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"' union all select '-1','ALL','') as a";
			/*//System.out.println("===modelSearch===="+sql);*/
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	public JSONArray subModelSearch(HttpSession session,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			//String sql="select m.doc_no,model,brand from my_smodel m left join my_sbrand b on(m.brandid=b.doc_no) where b.status=3 and m.status=3 and m.brandid='"+brandid+"'";
			String sql="select convert(doc_no,char(50)) as doc_no,submodel,model from ( select m.doc_no,submodel,model from my_ssubmodel m left join my_smodel mo on(m.modelid=mo.doc_no) where mo.status=3 and m.status=3 and m.modelid='"+modelid+"' union all select '-1','ALL','') as a";
		//	//System.out.println("===subModelSearch===="+sql);
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray brandSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,brand from (select doc_no,brand from my_sbrand where status=3 union all select '-1','ALL') as a ";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray brandFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select doc_no,brandname brand from my_brand where status=3";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray yomSearch(HttpSession session,String type,String yomfrm,String yomto,String suitrows) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();
			String sql="";
			String sqlappend="";
		if(!(yomfrm.equalsIgnoreCase("ALL")|| yomfrm.equalsIgnoreCase("") || yomfrm.equalsIgnoreCase("undefined") ) ){
				sqlappend=sqlappend+" and date_format(str_to_date(yom,'%Y'),'%Y')>="+yomfrm+" ";
			}
			
			if(!(yomto.equalsIgnoreCase("ALL") || yomto.equalsIgnoreCase("") || yomto.equalsIgnoreCase("undefined") )){
				sqlappend=sqlappend+" and date_format(str_to_date(yom,'%Y'),'%Y')<="+yomto+"";
			}
			
			if(Integer.parseInt(suitrows)<=0){
				if(type.equalsIgnoreCase("frm")){
					sql="select convert(doc_no,char(50)) as doc_no,yom from ( select doc_no,yom from my_syom where status=3 union all select '-1','ALL' union all select '-2','' ) as a order by yom ";
				
					////System.out.println("==sql==1=="+sql);
				
				}
				else if(type.equalsIgnoreCase("to")){
					sql="select convert(doc_no,char(50)) as doc_no,yom from ( select doc_no,yom from my_syom where status=3 and date_format(str_to_date(yom,'%Y'),'%Y')>="+yomfrm+" union all select '-1','ALL' union all select '-2','') as a where 1=1  order by yom ";/*date_format(str_to_date(yom,'%Y'),'%Y')>="+yomfrm+"*/
				
					////System.out.println("==sql==2=="+sql);
				}
			}
			else if(Integer.parseInt(suitrows)>0){
				
					sql="select convert(doc_no,char(50)) as doc_no,yom from ( select doc_no,yom from my_syom where status=3 "+sqlappend+" union all select '-1','ALL' union all select '-2','') as a where 1=1  order by yom ";
					////System.out.println("==sql==3=="+sql);
			}
			
			////System.out.println("==sql===="+sql);

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray suitSpec1Search(HttpSession session,String submodelid,String brandid,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select s.doc_no,spec from "
					+ "my_suitspec1 s left join my_sbrand sb on(sb.doc_no=s.brandid) left join my_smodel sm on(sm.doc_no=s.modelid) left join my_ssubmodel m on(m.doc_no=s.submodelid) where "
					+ "m.doc_no='"+submodelid+"' and sb.doc_no='"+brandid+"' and sm.doc_no='"+modelid+"'  and s.status=3 union all select '-1','ALL') as a";

			
		//	//System.out.println("=sql==="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	


	public JSONArray suitSpec2Search(HttpSession session,String submodelid,String brandid,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select s.doc_no,spec from "
					+ "my_suitspec2 s left join my_sbrand sb on(sb.doc_no=s.brandid) left join my_smodel sm on(sm.doc_no=s.modelid) left join my_ssubmodel m on(m.doc_no=s.submodelid) where "
					+ "m.doc_no='"+submodelid+"' and sb.doc_no='"+brandid+"' and sm.doc_no='"+modelid+"'  and s.status=3 union all select '-1','ALL') as a";

			//System.out.println("=sql==2="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}


	public JSONArray suitSpec3Search(HttpSession session,String submodelid,String brandid,String modelid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select convert(doc_no,char(50)) as doc_no,spec from ( select s.doc_no,spec from "
					+ "my_suitspec3 s left join my_sbrand sb on(sb.doc_no=s.brandid) left join my_smodel sm on(sm.doc_no=s.modelid) left join my_ssubmodel m on(m.doc_no=s.submodelid) where "
					+ "m.doc_no='"+submodelid+"' and sb.doc_no='"+brandid+"' and sm.doc_no='"+modelid+"'  and s.status=3 union all select '-1','ALL') as a";

		//	//System.out.println("=sql==3="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray catFormSearch(HttpSession session) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql="select category,doc_no  from my_catm where status <> 7";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray subCatFormSearch(HttpSession session,String catid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			String sql = "select subcategory,doc_no  from my_scatm where status <>7 and catid="+catid+"";

			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public int insert(java.sql.Date date,String pname,String pcode,String pbarcode,String ptype,String pbrand,String pcat,
			String psubcat,String unit,String dept,String mode,String dtype,ArrayList prodarray,ArrayList uomarray,ArrayList specMastersarray,ArrayList suitarray, 
			ArrayList specarray,HttpSession session,int comp_brach, ArrayList<String> pmgntarray, int cmbstar, int cmbmastertype,
			String arabicprdname,ArrayList ssarray,String desc1,ArrayList altrarray, String hsncode,ClsProductAction action,HttpServletRequest request) throws SQLException{
	    if(hsncode==null || hsncode.isEmpty() || hsncode.equalsIgnoreCase("")) {
            hsncode="0";
        }

		Connection conn=null;
		int pdocno=0,pdocno1=0;
		conn=ClsConnection.getMyConnection();
		try{
			
  
  
			conn.setAutoCommit(false);
			    Statement stmtac = conn.createStatement();
			    Statement stmtAccMaster1 = conn.createStatement();
			    Statement stmtac1 = conn.createStatement();
			    
			 String sqlconfig = "select method from gl_config where field_nme='alintercompConfig';";
			    ResultSet rssqlconfig = stmtac.executeQuery(sqlconfig);
			    int configmethod = 0;
			    if (rssqlconfig.next()) {
			    	configmethod = rssqlconfig.getInt("method");
			    }
if(configmethod==1) {
	  Statement stmtAcc = conn.createStatement();

      Properties prop = new Properties();
      String filePath = request.getSession().getServletContext().getRealPath("/com/login/login.properties");
      filePath = filePath.replace("\\", "\\\\");
      String db = "",dbcomp="";
      FileInputStream ip = new FileInputStream(filePath);
      prop.load(ip);
      String dbname = prop.getProperty("intercompdb");
      String multicompconfig = prop.getProperty("multicompany");
      JSONArray dbdata = new JSONArray();
      
      
      if (multicompconfig.equals("1") || multicompconfig.equalsIgnoreCase("1")) {
    	  
    	  Context initCtx = new InitialContext();
            
            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/carrental");
            
            if (ds.getConnection() != null) {
                java.sql.DatabaseMetaData metaData = conn.getMetaData();
                String url = metaData.getURL();
                
                String comp = url.substring(url.lastIndexOf("/") + 1);
             	 
             	  Statement stmtrowno = conn.createStatement();

		            String row="select coalesce(max(rowno)+1,1) intrcmprowno  from "+dbname+".my_intrcmpdocno";
		            ResultSet rsrowno = stmtrowno.executeQuery(row);
			        int intrcmprowno=0;
		            while (rsrowno.next()) {
		            	intrcmprowno=rsrowno.getInt("intrcmprowno");
		            }
		            Statement stmtrowno1 = conn.createStatement();

		            String sqluprow =" insert into "+dbname+".my_intrcmpdocno (comp1,comp2,comp3,comp4,comp5,comp6)values(1,1,1,1,1,1)";
		            int ss=stmtrowno1.executeUpdate(sqluprow); 
		        	
		 
		        String strsql = "select distinct dbname,compname,doc_no,compurl from " + dbname + ".my_intrcomp WHERE STATUS=3 group by  compname";
		           
		        ResultSet rsacc = stmtAcc.executeQuery(strsql);
		        while (rsacc.next()) {
		          db = rsacc.getString("dbname");
		          dbcomp = rsacc.getString("compname");
		          if (! (db.equalsIgnoreCase(""))) {

			CallableStatement stmt = conn.prepareCall("{CALL " + db + ".productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			stmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			stmt.setDate(1,date);
			stmt.setString(2,pname);
			stmt.setString(3,pcode);
			stmt.setString(4, pbarcode);
			stmt.setInt(5, Integer.parseInt(ptype.equalsIgnoreCase("")?"0":ptype));
			stmt.setInt(6, Integer.parseInt(pbrand.equalsIgnoreCase("")?"0":pbrand));
			stmt.setInt(7, Integer.parseInt(pcat.equalsIgnoreCase("")?"0":pcat));
			stmt.setInt(8, Integer.parseInt(psubcat.equalsIgnoreCase("")?"0":psubcat));
			stmt.setInt(9, Integer.parseInt(unit.equalsIgnoreCase("")?"0":unit));
			stmt.setInt(10, Integer.parseInt(dept.equalsIgnoreCase("")?"0":dept));
			stmt.setString(11, mode);
			stmt.setString(12, dtype);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			stmt.setInt(15, Integer.parseInt(hsncode.equalsIgnoreCase("")?"0":hsncode));
			int val = stmt.executeUpdate();
			pdocno1 =stmt.getInt("pdocno");
			 if(db.equalsIgnoreCase(comp)) {
           	  pdocno=pdocno1;
           	  
             } 
			if (pdocno1 > 0) {
				
				String sqls4="update " + db + ".my_main set prdname='"+arabicprdname+"',star='"+cmbstar+"',mtypeid='"+cmbmastertype+"',desc1='"+desc1+"',warranty='"+action.getWarranty()+"', warrantydays='"+action.getWarrantydays()+"' where doc_no='"+pdocno1+"'";
				//System.out.println("======sqls4=="+sqls4);
				
				stmt.executeUpdate(sqls4);
				
				
				int branchper=0;
				
				if(comp_brach==1)
				{
					String sqls="update " + db + ".my_main set comp_brch='C' where doc_no='"+pdocno1+"'";
					stmt.executeUpdate(sqls);
				}
				else if(comp_brach==2)
				{
					String sqls="update " + db + ".my_main set comp_brch='B' where doc_no='"+pdocno1+"'";
					stmt.executeUpdate(sqls);
				}
				
				
				if(pbarcode.equalsIgnoreCase("") || pbarcode==null)
				{
					String sqls="update " + db + ".my_main set barcode='"+pdocno+"' where doc_no='"+pdocno1+"'";
					stmt.executeUpdate(sqls);
				}
				
				Statement stmtuprowno = conn.createStatement();   
	              String sqluprowno="update "+dbname+".my_intrcmpdocno set " + db + "="+pdocno1+"  where rowno= '"+intrcmprowno+"' ";
	              stmtuprowno.executeUpdate(sqluprowno);
	             
				
				for(int i=0;i< prodarray.size();i++){
					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()))){

						if(comp_brach==2)
						{
						String sql="INSERT INTO " + db + ".my_desc(psrno, doc_no,brhid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
								+ " ('"+pdocno1+"','"+pdocno1+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"', "
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
								+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



						//System.out.println("branchper--->>>>Sql"+sql);
						branchper = stmt.executeUpdate (sql);
						}
						
						else if(comp_brach==1)
						{
							String sql="INSERT INTO " + db + ".my_desc(psrno,doc_no,cmpid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
									+ " ('"+pdocno1+"','"+pdocno1+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
									+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
									+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
									+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
									+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"' ,"
									+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
									+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



							//System.out.println("branchper--->>>>Sql"+sql);
							branchper = stmt.executeUpdate (sql);
						}
					 
					}

				}

				
				for(int i=0;i< ssarray.size();i++){
					String[] ssarr=((String) ssarray.get(i)).split("::");
					
					if(!((ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("0") || ssarr[0].trim().equalsIgnoreCase("") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].isEmpty()))){

					
					
				     String sql="INSERT INTO " + db + ".my_prdsuperseding(sr_no,psrno,part_no,priority,discontinued)VALUES"
						       + " ("+(i+1)+","
						       + " '"+pdocno1+"',"
						       + "'"+(ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].trim().equalsIgnoreCase("")|| ssarr[0].isEmpty()?0:ssarr[0].trim())+"',"
						       + "'"+(ssarr[1].trim().equalsIgnoreCase("undefined") || ssarr[1].trim().equalsIgnoreCase("NaN")|| ssarr[1].trim().equalsIgnoreCase("")|| ssarr[1].isEmpty()?0:ssarr[1].trim())+"',"
						       + "'"+(ssarr[2].trim().equalsIgnoreCase("undefined") || ssarr[2].trim().equalsIgnoreCase("NaN")|| ssarr[2].trim().equalsIgnoreCase("")|| ssarr[2].isEmpty()?0:ssarr[2].trim())+"' )";
			 	     int resultSet2 = stmt.executeUpdate(sql);
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
					}
					
			}
				
				
				for(int i=0;i< pmgntarray.size();i++){
					String[] pmgntarr=((String) pmgntarray.get(i)).split("::");
		
					
 
					 if((!(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().isEmpty())) 
					   || (!(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().isEmpty()))
					  ||  (!(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().isEmpty()))
					   ||  (!(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().isEmpty()))
					  ||  (!(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().isEmpty()))
					  ||  (!(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().isEmpty()))
					  ||  (!(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().isEmpty()))
					  ||  (!(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().isEmpty()))
					  ||  (!(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().isEmpty()))
					   ||  (!(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("") || pmgntarr[10].trim().equalsIgnoreCase("NaN")|| pmgntarr[10].trim().isEmpty()))
					   ||  (!(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("") || pmgntarr[11].trim().equalsIgnoreCase("NaN")|| pmgntarr[11].trim().isEmpty()))
					  ||  (!(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("") || pmgntarr[12].trim().equalsIgnoreCase("NaN")|| pmgntarr[12].trim().isEmpty()))){
					
 
			     String sql="INSERT INTO " + db + ".my_descpr(sr_no,psrno, catid,  price1, price2, price3, discount1, discount2, discount3, foc1, foc2, foc3,qty1,qty2,qty3)VALUES"
					       + " ("+(i+1)+","
					       + " '"+pdocno1+"',"
					       + "'"+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"',"
					       + "'"+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"',"
					       + "'"+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"',"
					       + "'"+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")||pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"',"
					       + "'"+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"',"
					       + "'"+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")||pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"',"
					       + "'"+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")||pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"',"
					       + "'"+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")||pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"',"
					       + "'"+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")||pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"',"
					       + "'"+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")||pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?0:pmgntarr[9].trim())+"',"
			               + "'"+(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("NaN")||pmgntarr[10].trim().equalsIgnoreCase("")|| pmgntarr[10].isEmpty()?0:pmgntarr[10].trim())+"',"
			               + "'"+(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("NaN")||pmgntarr[11].trim().equalsIgnoreCase("")|| pmgntarr[11].isEmpty()?0:pmgntarr[11].trim())+"',"
			               + "'"+(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("NaN")||pmgntarr[12].trim().equalsIgnoreCase("")|| pmgntarr[12].isEmpty()?0:pmgntarr[12].trim())+"')";
			    
				
		 	     int resultSet2 = stmt.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
					     
					}
			            	}
				
				int specMastersdesc = 0;

				String sqlcon="select  method from " + db + ".gl_config where field_nme='classification grid' ";
	    		//System.out.println("config-====="+sqlcon);
	    		ResultSet rsconfg = stmt.executeQuery(sqlcon);
	    		int method=0;
	    		while (rsconfg.next()) {
	             method=rsconfg.getInt("method");
	    			//System.out.println("method=="+method);
	    		}
	    		if(method==1) {
                for (int i = 0; i < specMastersarray.size(); i++) {
                    String[] specMastersarr = ((String) specMastersarray.get(i)).split("::");
                    if (!((specMastersarr[0].equalsIgnoreCase("undefined")
                            || specMastersarr[0].equalsIgnoreCase("")
                            || specMastersarr[0].trim().equalsIgnoreCase("NaN") || specMastersarr[0]
                                .isEmpty()))) {

                        String sql = "INSERT INTO " + db + ".my_prodspecp(psrno,name, description, sdoc_no)VALUES"
                                + " ('"
                                + pdocno1
                                + "',"
                                + "'"
                                + (specMastersarr[0].equalsIgnoreCase("undefined")
                                        || specMastersarr[0].equalsIgnoreCase("")
                                        || specMastersarr[0].trim().equalsIgnoreCase(
                                                "NaN") || specMastersarr[0].isEmpty() ? 0
                                        : specMastersarr[0].trim())
                                + "',"
                                + "'"
                                + (specMastersarr[1].equalsIgnoreCase("undefined")
                                        || specMastersarr[1].equalsIgnoreCase("")
                                        || specMastersarr[1].trim().equalsIgnoreCase(
                                                "NaN") || specMastersarr[1].isEmpty() ? 0
                                        : specMastersarr[1].trim())
                                + "',"
                                + "'"
                                + (specMastersarr[2].trim().equalsIgnoreCase("undefined")
                                        || specMastersarr[2].trim()
                                                .equalsIgnoreCase("")
                                        || specMastersarr[2].trim().equalsIgnoreCase(
                                                "NaN") || specMastersarr[2].isEmpty() ? 0
                                        : specMastersarr[2].trim())+ "')";
                                specMastersdesc = stmt.executeUpdate(sql);
                        }

                }
				
	    		}
				int unitdesc=0;

				for(int i=0;i< uomarray.size();i++){
					String[] uomarr=((String) uomarray.get(i)).split("::");
					if(!((uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()))){


						String sql="INSERT INTO " + db + ".my_unit(PSRNO, UNIT, FR, wt, VOLUME, thk, leng, width)VALUES"
								+ " ('"+pdocno1+"',"
								+ "'"+(uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()?0:uomarr[0].trim())+"',"
								+ "'"+(uomarr[1].trim().equalsIgnoreCase("undefined")  || uomarr[1].trim().equalsIgnoreCase("") || uomarr[1].trim().equalsIgnoreCase("NaN")|| uomarr[1].isEmpty()?0:uomarr[1].trim())+"',"
								+ "'"+(uomarr[2].trim().equalsIgnoreCase("undefined") || uomarr[2].trim().equalsIgnoreCase("") || uomarr[2].trim().equalsIgnoreCase("NaN")|| uomarr[2].isEmpty()?0:uomarr[2].trim())+"',"
								+ "'"+(uomarr[3].trim().equalsIgnoreCase("undefined") || uomarr[3].trim().equalsIgnoreCase("") || uomarr[3].trim().equalsIgnoreCase("NaN")|| uomarr[3].isEmpty()?0:uomarr[3].trim())+"',"
								+ "'"+(uomarr[4].trim().equalsIgnoreCase("undefined") || uomarr[4].trim().equalsIgnoreCase("") || uomarr[4].trim().equalsIgnoreCase("NaN")|| uomarr[4].isEmpty()?0:uomarr[4].trim())+"',"
								+ "'"+(uomarr[5].trim().equalsIgnoreCase("undefined") || uomarr[5].trim().equalsIgnoreCase("") || uomarr[5].trim().equalsIgnoreCase("NaN")|| uomarr[5].isEmpty()?0:uomarr[5].trim())+"',"
								+ "'"+(uomarr[6].trim().equalsIgnoreCase("undefined") || uomarr[6].trim().equalsIgnoreCase("") || uomarr[6].trim().equalsIgnoreCase("NaN")|| uomarr[6].isEmpty()?0:uomarr[6].trim())+"')";


					//	//System.out.println("uomarr--->>>>Sql"+sql);
						unitdesc = stmt.executeUpdate (sql);
					}

				}


				int specdesc=0;
				
				for(int i=0;i< specarray.size();i++){
					String[] specarr=((String) specarray.get(i)).split("::");
					if(!((specarr[0].equalsIgnoreCase("0"))|| (specarr[0].equalsIgnoreCase("")) ||(specarr[0].equalsIgnoreCase("undefined")))){


						String sql="INSERT INTO " + db + ".my_prodattrib(MPSRNO,MSPECNO,spec1, spec2, spec3, spec4, barcode)VALUES"
								+ " ('"+pdocno1+"','"+pdocno1+"',"
								+ "'"+(specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()?0:specarr[0].trim())+"',"
								+ "'"+(specarr[1].trim().equalsIgnoreCase("undefined")  || specarr[1].trim().equalsIgnoreCase("") || specarr[1].trim().equalsIgnoreCase("NaN")|| specarr[1].isEmpty()?0:specarr[1].trim())+"',"
								+ "'"+(specarr[2].trim().equalsIgnoreCase("undefined") || specarr[2].trim().equalsIgnoreCase("") || specarr[2].trim().equalsIgnoreCase("NaN")|| specarr[2].isEmpty()?0:specarr[2].trim())+"',"
								+ "'"+(specarr[3].trim().equalsIgnoreCase("undefined") || specarr[3].trim().equalsIgnoreCase("") || specarr[3].trim().equalsIgnoreCase("NaN")|| specarr[3].isEmpty()?0:specarr[3].trim())+"',"
								+ "'"+(specarr[4].trim().equalsIgnoreCase("undefined") || specarr[4].trim().equalsIgnoreCase("") || specarr[4].trim().equalsIgnoreCase("NaN")|| specarr[4].isEmpty()?0:specarr[4].trim())+"')";


						//System.out.println("specarr--->>>>Sql"+sql);
						specdesc = stmt.executeUpdate (sql);
					}

				}
	    	

				int suitdesc=0;
				String sqlcons="select  method from " + db + ".gl_prdconfig where field_nme='suit' ";
	    		//System.out.println("config-====="+sqlcons);
	    		ResultSet rsconfggs = stmt.executeQuery(sqlcons);
	    		int methodsuit=0;
	    		while (rsconfggs.next()) {
	    			methodsuit=rsconfggs.getInt("method");
	    			//System.out.println("methods=="+methodsuit);
	    		}
	    		if(methodsuit==1) {
/*				for(int i=0;i< suitarray.size();i++){
					String[] suitarr=((String) suitarray.get(i)).split("::");
					if(!((suitarr[0].equalsIgnoreCase("0"))||(suitarr[0].equalsIgnoreCase("undefined")))){


						String sql="INSERT INTO my_prodsuit(PSRNO, sbrand_id, smodel_id, syomfrm_id, syomto_id, spec1_id, spec2_id, spec3_id,submodelid)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
								+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
								+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
								+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
								+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
								+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
								+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
								+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"')";
						
						//System.out.println("suitarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}

				}*/
				
				
				for(int i=0;i< suitarray.size();i++){
					String[] suitarr=((String) suitarray.get(i)).split("::");
					if(!((suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()))){


						String sql="INSERT INTO " + db + ".my_prodsuit(PSRNO, vehsuitid,syomfrm_id,syomto_id,bsize1id,bsize2id,bsize3id,csize1id,csize2id,csize3id)VALUES"
								+ " ('"+pdocno1+"',"
								+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
								+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
								+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
								+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
								+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
								+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
								+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
								+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"',"
								+ "'"+(suitarr[8].trim().equalsIgnoreCase("undefined") || suitarr[8].trim().equalsIgnoreCase("") || suitarr[8].trim().equalsIgnoreCase("NaN")|| suitarr[8].isEmpty()?0:suitarr[8].trim())+"')";
							
						////System.out.println("suitarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}

				}
				
	    	}

				for(int i=0;i< altrarray.size();i++){
					String[] altrarr=((String) altrarray.get(i)).split("::");
					if(!((altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()))){


						String sql="INSERT INTO " + db + ".my_pralter(rdocno, altpsrno)VALUES"
								+ " ('"+pdocno1+"',"
								+ "'"+(altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()?0:altrarr[0].trim())+"')";
								
								
							
						////System.out.println("altrarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}
				}
				
				 
				
			}//pdocno>0 end
	      }//  //db check end
	   } //db name end
	} //dataconnection end
} //multicomp config end
}else {
	

	
	
	CallableStatement stmt = conn.prepareCall("{CALL productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


	stmt.registerOutParameter(16, java.sql.Types.VARCHAR);
	stmt.setDate(1,date);
	stmt.setString(2,pname);
	stmt.setString(3,pcode);
	stmt.setString(4, pbarcode);
	stmt.setInt(5, Integer.parseInt(ptype.equalsIgnoreCase("")?"0":ptype));
	stmt.setInt(6, Integer.parseInt(pbrand.equalsIgnoreCase("")?"0":pbrand));
	stmt.setInt(7, Integer.parseInt(pcat.equalsIgnoreCase("")?"0":pcat));
	stmt.setInt(8, Integer.parseInt(psubcat.equalsIgnoreCase("")?"0":psubcat));
	stmt.setInt(9, Integer.parseInt(unit.equalsIgnoreCase("")?"0":unit));
	stmt.setInt(10, Integer.parseInt(dept.equalsIgnoreCase("")?"0":dept));
	stmt.setString(11, mode);
	stmt.setString(12, dtype);
	stmt.setString(13, session.getAttribute("USERID").toString());
	stmt.setString(14, session.getAttribute("BRANCHID").toString());
	stmt.setInt(15, Integer.parseInt(hsncode.equalsIgnoreCase("")?"0":hsncode));
	int val = stmt.executeUpdate();
	pdocno=stmt.getInt("pdocno");


	if (pdocno > 0) {
		
		String sqls4="update my_main set prdname='"+arabicprdname+"',star='"+cmbstar+"',mtypeid='"+cmbmastertype+"',desc1='"+desc1+"',warranty='"+action.getWarranty()+"', warrantydays='"+action.getWarrantydays()+"' where doc_no='"+pdocno+"'";
		//System.out.println("======sqls4=="+sqls4);
		
		stmt.executeUpdate(sqls4);
		
		
		int branchper=0;
		
		if(comp_brach==1)
		{
			String sqls="update my_main set comp_brch='C' where doc_no='"+pdocno+"'";
			stmt.executeUpdate(sqls);
		}
		else if(comp_brach==2)
		{
			String sqls="update my_main set comp_brch='B' where doc_no='"+pdocno+"'";
			stmt.executeUpdate(sqls);
		}
		
		
		if(pbarcode.equalsIgnoreCase("") || pbarcode==null)
		{
			String sqls="update my_main set barcode='"+pdocno+"' where doc_no='"+pdocno+"'";
			stmt.executeUpdate(sqls);
		}
		
		
		
		for(int i=0;i< prodarray.size();i++){
			String[] prod=((String) prodarray.get(i)).split("::");
			if(!((prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()))){

				if(comp_brach==2)
				{
				String sql="INSERT INTO my_desc(psrno, doc_no,brhid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
						+ " ('"+pdocno+"','"+pdocno+"',"
						+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
						+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
						+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
						+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
						+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
						+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
						+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
						+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"', "
						+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
						+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



				//System.out.println("branchper--->>>>Sql"+sql);
				branchper = stmt.executeUpdate (sql);
				}
				
				else if(comp_brach==1)
				{
					String sql="INSERT INTO my_desc(psrno,doc_no,cmpid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
							+ " ('"+pdocno+"','"+pdocno+"',"
							+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
							+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
							+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
							+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
							+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
							+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
							+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
							+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"' ,"
							+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
							+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";



					//System.out.println("branchper--->>>>Sql"+sql);
					branchper = stmt.executeUpdate (sql);
				}
			 
			}

		}

		
		
		
		
		
		
		
		
		
		for(int i=0;i< ssarray.size();i++){
			String[] ssarr=((String) ssarray.get(i)).split("::");
			
			if(!((ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("0") || ssarr[0].trim().equalsIgnoreCase("") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].isEmpty()))){

			
			
		     String sql="INSERT INTO my_prdsuperseding(sr_no,psrno,part_no,priority,discontinued)VALUES"
				       + " ("+(i+1)+","
				       + " '"+pdocno+"',"
				       + "'"+(ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].trim().equalsIgnoreCase("")|| ssarr[0].isEmpty()?0:ssarr[0].trim())+"',"
				       + "'"+(ssarr[1].trim().equalsIgnoreCase("undefined") || ssarr[1].trim().equalsIgnoreCase("NaN")|| ssarr[1].trim().equalsIgnoreCase("")|| ssarr[1].isEmpty()?0:ssarr[1].trim())+"',"
				       + "'"+(ssarr[2].trim().equalsIgnoreCase("undefined") || ssarr[2].trim().equalsIgnoreCase("NaN")|| ssarr[2].trim().equalsIgnoreCase("")|| ssarr[2].isEmpty()?0:ssarr[2].trim())+"' )";
	 	     int resultSet2 = stmt.executeUpdate(sql);
			     if(resultSet2<=0)
					{
						conn.close();
						return 0;
						
					}
			}
			
			
								}
		
		
		
		
		for(int i=0;i< pmgntarray.size();i++){
			String[] pmgntarr=((String) pmgntarray.get(i)).split("::");

			

			 if((!(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().isEmpty())) 
			   || (!(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().isEmpty()))
			  ||  (!(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().isEmpty()))
			   ||  (!(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().isEmpty()))
			  ||  (!(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().isEmpty()))
			  ||  (!(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().isEmpty()))
			  ||  (!(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().isEmpty()))
			  ||  (!(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().isEmpty()))
			  ||  (!(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().isEmpty()))
			   ||  (!(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("") || pmgntarr[10].trim().equalsIgnoreCase("NaN")|| pmgntarr[10].trim().isEmpty()))
			   ||  (!(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("") || pmgntarr[11].trim().equalsIgnoreCase("NaN")|| pmgntarr[11].trim().isEmpty()))
			  ||  (!(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("") || pmgntarr[12].trim().equalsIgnoreCase("NaN")|| pmgntarr[12].trim().isEmpty()))){
			

	     String sql="INSERT INTO my_descpr(sr_no,psrno, catid,  price1, price2, price3, discount1, discount2, discount3, foc1, foc2, foc3,qty1,qty2,qty3)VALUES"
			       + " ("+(i+1)+","
			       + " '"+pdocno+"',"
			       + "'"+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"',"
			       + "'"+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"',"
			       + "'"+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"',"
			       + "'"+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")||pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"',"
			       + "'"+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"',"
			       + "'"+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")||pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"',"
			       + "'"+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")||pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"',"
			       + "'"+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")||pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"',"
			       + "'"+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")||pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"',"
			       + "'"+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")||pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?0:pmgntarr[9].trim())+"',"
	               + "'"+(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("NaN")||pmgntarr[10].trim().equalsIgnoreCase("")|| pmgntarr[10].isEmpty()?0:pmgntarr[10].trim())+"',"
	               + "'"+(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("NaN")||pmgntarr[11].trim().equalsIgnoreCase("")|| pmgntarr[11].isEmpty()?0:pmgntarr[11].trim())+"',"
	               + "'"+(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("NaN")||pmgntarr[12].trim().equalsIgnoreCase("")|| pmgntarr[12].isEmpty()?0:pmgntarr[12].trim())+"')";
	    
		
 	     int resultSet2 = stmt.executeUpdate(sql);
		     if(resultSet2<=0)
				{
					conn.close();
					return 0;
					
				}
			     
			}
	            	}
		
		int specMastersdesc = 0;

		String sqlcon="select  method from gl_config where field_nme='classification grid' ";
		//System.out.println("config-====="+sqlcon);
		ResultSet rsconfg = stmt.executeQuery(sqlcon);
		int method=0;
		while (rsconfg.next()) {
         method=rsconfg.getInt("method");
			//System.out.println("method=="+method);
		}
		if(method==1) {
        for (int i = 0; i < specMastersarray.size(); i++) {
            String[] specMastersarr = ((String) specMastersarray.get(i)).split("::");
            if (!((specMastersarr[0].equalsIgnoreCase("undefined")
                    || specMastersarr[0].equalsIgnoreCase("")
                    || specMastersarr[0].trim().equalsIgnoreCase("NaN") || specMastersarr[0]
                        .isEmpty()))) {

                String sql = "INSERT INTO my_prodspecp(psrno,name, description, sdoc_no)VALUES"
                        + " ('"
                        + pdocno
                        + "',"
                        + "'"
                        + (specMastersarr[0].equalsIgnoreCase("undefined")
                                || specMastersarr[0].equalsIgnoreCase("")
                                || specMastersarr[0].trim().equalsIgnoreCase(
                                        "NaN") || specMastersarr[0].isEmpty() ? 0
                                : specMastersarr[0].trim())
                        + "',"
                        + "'"
                        + (specMastersarr[1].equalsIgnoreCase("undefined")
                                || specMastersarr[1].equalsIgnoreCase("")
                                || specMastersarr[1].trim().equalsIgnoreCase(
                                        "NaN") || specMastersarr[1].isEmpty() ? 0
                                : specMastersarr[1].trim())
                        + "',"
                        + "'"
                        + (specMastersarr[2].trim().equalsIgnoreCase("undefined")
                                || specMastersarr[2].trim()
                                        .equalsIgnoreCase("")
                                || specMastersarr[2].trim().equalsIgnoreCase(
                                        "NaN") || specMastersarr[2].isEmpty() ? 0
                                : specMastersarr[2].trim())+ "')";
                        specMastersdesc = stmt.executeUpdate(sql);
                      //  System.out.println("sql-----------"+sql);
                }

        }
		
		}
		int unitdesc=0;

		for(int i=0;i< uomarray.size();i++){
			String[] uomarr=((String) uomarray.get(i)).split("::");
			if(!((uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()))){


				String sql="INSERT INTO my_unit(PSRNO, UNIT, FR, wt, VOLUME, thk, leng, width)VALUES"
						+ " ('"+pdocno+"',"
						+ "'"+(uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()?0:uomarr[0].trim())+"',"
						+ "'"+(uomarr[1].trim().equalsIgnoreCase("undefined")  || uomarr[1].trim().equalsIgnoreCase("") || uomarr[1].trim().equalsIgnoreCase("NaN")|| uomarr[1].isEmpty()?0:uomarr[1].trim())+"',"
						+ "'"+(uomarr[2].trim().equalsIgnoreCase("undefined") || uomarr[2].trim().equalsIgnoreCase("") || uomarr[2].trim().equalsIgnoreCase("NaN")|| uomarr[2].isEmpty()?0:uomarr[2].trim())+"',"
						+ "'"+(uomarr[3].trim().equalsIgnoreCase("undefined") || uomarr[3].trim().equalsIgnoreCase("") || uomarr[3].trim().equalsIgnoreCase("NaN")|| uomarr[3].isEmpty()?0:uomarr[3].trim())+"',"
						+ "'"+(uomarr[4].trim().equalsIgnoreCase("undefined") || uomarr[4].trim().equalsIgnoreCase("") || uomarr[4].trim().equalsIgnoreCase("NaN")|| uomarr[4].isEmpty()?0:uomarr[4].trim())+"',"
						+ "'"+(uomarr[5].trim().equalsIgnoreCase("undefined") || uomarr[5].trim().equalsIgnoreCase("") || uomarr[5].trim().equalsIgnoreCase("NaN")|| uomarr[5].isEmpty()?0:uomarr[5].trim())+"',"
						+ "'"+(uomarr[6].trim().equalsIgnoreCase("undefined") || uomarr[6].trim().equalsIgnoreCase("") || uomarr[6].trim().equalsIgnoreCase("NaN")|| uomarr[6].isEmpty()?0:uomarr[6].trim())+"')";


			//	//System.out.println("uomarr--->>>>Sql"+sql);
				unitdesc = stmt.executeUpdate (sql);
			}

		}


		int specdesc=0;
		
		for(int i=0;i< specarray.size();i++){
			String[] specarr=((String) specarray.get(i)).split("::");
			if(!((specarr[0].equalsIgnoreCase("0"))|| (specarr[0].equalsIgnoreCase("")) ||(specarr[0].equalsIgnoreCase("undefined")))){


				String sql="INSERT INTO my_prodattrib(MPSRNO,MSPECNO,spec1, spec2, spec3, spec4, barcode)VALUES"
						+ " ('"+pdocno+"','"+pdocno+"',"
						+ "'"+(specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()?0:specarr[0].trim())+"',"
						+ "'"+(specarr[1].trim().equalsIgnoreCase("undefined")  || specarr[1].trim().equalsIgnoreCase("") || specarr[1].trim().equalsIgnoreCase("NaN")|| specarr[1].isEmpty()?0:specarr[1].trim())+"',"
						+ "'"+(specarr[2].trim().equalsIgnoreCase("undefined") || specarr[2].trim().equalsIgnoreCase("") || specarr[2].trim().equalsIgnoreCase("NaN")|| specarr[2].isEmpty()?0:specarr[2].trim())+"',"
						+ "'"+(specarr[3].trim().equalsIgnoreCase("undefined") || specarr[3].trim().equalsIgnoreCase("") || specarr[3].trim().equalsIgnoreCase("NaN")|| specarr[3].isEmpty()?0:specarr[3].trim())+"',"
						+ "'"+(specarr[4].trim().equalsIgnoreCase("undefined") || specarr[4].trim().equalsIgnoreCase("") || specarr[4].trim().equalsIgnoreCase("NaN")|| specarr[4].isEmpty()?0:specarr[4].trim())+"')";


				//System.out.println("specarr--->>>>Sql"+sql);
				specdesc = stmt.executeUpdate (sql);
			}

		}
	

		int suitdesc=0;
		String sqlcons="select  method from gl_prdconfig where field_nme='suit' ";
		//System.out.println("config-====="+sqlcons);
		ResultSet rsconfggs = stmt.executeQuery(sqlcons);
		int methodsuit=0;
		while (rsconfggs.next()) {
			methodsuit=rsconfggs.getInt("method");
			//System.out.println("methods=="+methodsuit);
		}
		if(methodsuit==1) {
/*				for(int i=0;i< suitarray.size();i++){
			String[] suitarr=((String) suitarray.get(i)).split("::");
			if(!((suitarr[0].equalsIgnoreCase("0"))||(suitarr[0].equalsIgnoreCase("undefined")))){


				String sql="INSERT INTO my_prodsuit(PSRNO, sbrand_id, smodel_id, syomfrm_id, syomto_id, spec1_id, spec2_id, spec3_id,submodelid)VALUES"
						+ " ('"+pdocno+"',"
						+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
						+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
						+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
						+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
						+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
						+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
						+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
						+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"')";
				
				//System.out.println("suitarr--->>>>Sql"+sql);
				suitdesc = stmt.executeUpdate (sql);
			}

		}*/
		
		
		for(int i=0;i< suitarray.size();i++){
			String[] suitarr=((String) suitarray.get(i)).split("::");
			if(!((suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()))){


				String sql="INSERT INTO my_prodsuit(PSRNO, vehsuitid,syomfrm_id,syomto_id,bsize1id,bsize2id,bsize3id,csize1id,csize2id,csize3id)VALUES"
						+ " ('"+pdocno+"',"
						+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
						+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
						+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
						+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
						+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
						+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
						+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
						+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"',"
						+ "'"+(suitarr[8].trim().equalsIgnoreCase("undefined") || suitarr[8].trim().equalsIgnoreCase("") || suitarr[8].trim().equalsIgnoreCase("NaN")|| suitarr[8].isEmpty()?0:suitarr[8].trim())+"')";
					
				////System.out.println("suitarr--->>>>Sql"+sql);
				suitdesc = stmt.executeUpdate (sql);
			}

		}
		
	}

		for(int i=0;i< altrarray.size();i++){
			String[] altrarr=((String) altrarray.get(i)).split("::");
			if(!((altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()))){


				String sql="INSERT INTO my_pralter(rdocno, altpsrno)VALUES"
						+ " ('"+pdocno+"',"
						+ "'"+(altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()?0:altrarr[0].trim())+"')";
						
						
					
				////System.out.println("altrarr--->>>>Sql"+sql);
				suitdesc = stmt.executeUpdate (sql);
			}

		}

	}

	
	
	
	
}
			conn.commit();
		}
		catch(Exception e){
			pdocno=0;
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return pdocno;
	}

	public int update(int docno,java.sql.Date date,String pname,String pcode,String pbarcode,String ptype,String pbrand,String pcat,
			String psubcat,String unit,String dept,String mode,String dtype,ArrayList prodarray,ArrayList<String> uomarray, ArrayList specMastersarray,
			ArrayList<String> suitarray,ArrayList<String> specarray,HttpSession session, int comp_brach, ArrayList<String> pmgntarray,
			int cmbstar, int cmbmastertype, String arabicprdname,ArrayList<String> ssarray,String desc1,ArrayList altrarray, String hsncode,ClsProductAction action,HttpServletRequest request) throws SQLException{

		//System.out.println("====update===="+mode);
		if(hsncode==null || hsncode.isEmpty() || hsncode.equalsIgnoreCase("")) {
            hsncode="0";
        }
		Connection conn=null;
		int pdocno=0,pdocno1=0;
		conn=ClsConnection.getMyConnection();
		
		try{
			

			conn.setAutoCommit(false);

			 Statement stmtac = conn.createStatement();
			    Statement stmtAccMaster1 = conn.createStatement();
			    Statement stmtac1 = conn.createStatement();
			    Statement stmtAccMaster12 = conn.createStatement ();
				
			  
			  
			    String sqlconfig = "select method from gl_config where field_nme='alintercompConfig';";

			    ResultSet rssqlconfig = stmtac.executeQuery(sqlconfig);
			    int configmethod = 0;
			    if (rssqlconfig.next()) {
			      configmethod = rssqlconfig.getInt("method");
			    }

			    if (configmethod==1) {
			    	
			    	
			    	 Statement stmtAcc = conn.createStatement();
			    	 Statement stmtAcc1 = conn.createStatement();

				      Properties prop = new Properties();
				      String filePath = request.getSession().getServletContext().getRealPath("/com/login/login.properties");
				      filePath = filePath.replace("\\", "\\\\");
				      String db = "",dbcomp="";
				      FileInputStream ip = new FileInputStream(filePath);
				      prop.load(ip);
				      String dbname = prop.getProperty("intercompdb");
				      String multicompconfig = prop.getProperty("multicompany");
				      JSONArray dbdata = new JSONArray();
				      if (multicompconfig.equals("1") || multicompconfig.equalsIgnoreCase("1")) {
				    	  int docnorow=0;
				    	  docnorow=docno;
				    	  Context initCtx = new InitialContext();
				            
				            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/carrental");
				            
				            if (ds.getConnection() != null) {
				                java.sql.DatabaseMetaData metaData = conn.getMetaData();
				                String url = metaData.getURL();
				                
				                String comp = url.substring(url.lastIndexOf("/") + 1);
			                
				        String strsql = "select distinct dbname,compname,doc_no,compurl from " + dbname + ".my_intrcomp WHERE STATUS=3 group by  compname";
				        ResultSet rsacc = stmtAcc.executeQuery(strsql);
				        
				        while (rsacc.next()) {
				          db = rsacc.getString("dbname");
				          dbcomp = rsacc.getString("compname");

				          String sqlcode1=" select " + db + "  editdocno from  " + dbname + ".my_intrcmpdocno where "+comp+"="+docnorow;
							ResultSet rsacc11 = stmtAcc1.executeQuery(sqlcode1);
							int editdocno=0;  
							while (rsacc11.next()) {
								editdocno=rsacc11.getInt("editdocno");
								
						 }	
				          if (! (db.equalsIgnoreCase(""))) {
				        	
							 docno=editdocno;
			
						        
			CallableStatement stmt = conn.prepareCall("{CALL " + db + ".productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


			//System.out.println("CALL productDML('"+date+"','"+pname+"','"+pcode+"','"+pbarcode+"','"+ptype+"','"+pbrand+"','"+pcat+"','"+psubcat+"','"+unit+"','"+dept+"','"+mode+"','"+dtype+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"','"+hsncode+"')");

			stmt.setInt(16,docno);
			stmt.setDate(1,date);
			stmt.setString(2,pname);
			stmt.setString(3,pcode);
			stmt.setString(4, pbarcode);
			stmt.setInt(5, Integer.parseInt(ptype.equalsIgnoreCase("")?"0":ptype));
			stmt.setInt(6, Integer.parseInt(pbrand.equalsIgnoreCase("")?"0":pbrand));
			stmt.setInt(7, Integer.parseInt(pcat.equalsIgnoreCase("")?"0":pcat));
			stmt.setInt(8, Integer.parseInt(psubcat.equalsIgnoreCase("")?"0":psubcat));
			stmt.setInt(9, Integer.parseInt(unit.equalsIgnoreCase("")?"0":unit));
			stmt.setInt(10, Integer.parseInt(dept.equalsIgnoreCase("")?"0":dept));
			stmt.setString(11, mode);
			stmt.setString(12, dtype);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			stmt.setInt(15, Integer.parseInt(hsncode.equalsIgnoreCase("")?"0":hsncode));
			int val = stmt.executeUpdate();
			if(val<0) {
				return 0;
			}
			pdocno1=stmt.getInt("pdocno");
			
			 if(db.equalsIgnoreCase(comp)) {
           	  pdocno=pdocno1;
           	  
             } 
             
			if (pdocno1 > 0) {
				
				
				String sqls4="update  " + db + ".my_main set prdname='"+arabicprdname+"',star='"+cmbstar+"',mtypeid='"+cmbmastertype+"',desc1='"+desc1+"',warranty='"+action.getWarranty()+"', warrantydays='"+action.getWarrantydays()+"'  where doc_no='"+pdocno1+"'";
				//System.out.println("======sqls4=="+sqls4);
				
				stmt.executeUpdate(sqls4);
				
				int branchper=0;
				
				if(comp_brach==1)
				{
					String sqls="update  " + db + ".my_main set comp_brch='C' where doc_no='"+pdocno1+"'";
					stmt.executeUpdate(sqls);
				}
				else if(comp_brach==2)
				{
					String sqls="update  " + db + ".my_main set comp_brch='B' where doc_no='"+pdocno1+"'";
					stmt.executeUpdate(sqls);
				}
				
				
				if(pbarcode.equalsIgnoreCase("") || pbarcode==null)
				{
					String sqls="update  " + db + ".my_main set barcode='"+pdocno1+"' where doc_no='"+pdocno1+"'";
					stmt.executeUpdate(sqls);
				}
				
				
				
				for(int i=0;i< prodarray.size();i++){
					String[] prod=((String) prodarray.get(i)).split("::");
					if(!((prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()))){
						int   prods=0;
						String prodsql = "select count(*) as counts from  " + db + ".my_desc where psrno='"+pdocno1+"' ";
					        //System.out.println("my_desc check------"+prodsql);
					        ResultSet rsprod=stmt.executeQuery(prodsql);
					        if(rsprod.next()) {
					        	prods = rsprod.getInt("counts");
					            //System.out.println(prods);
					        }
					       String sql="";
						if(comp_brach==2)
						{
							 if(prods>0) {
						sql = "UPDATE  " + db + ".my_desc set "+
						              "doc_no='"+pdocno1+"',brhid='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"', "+
						              "bin='"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"', "+
						              "minStock='"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"', "+
						              "maxStock='"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"', "+
						              "PRICE1='"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"', "+
						              "PRICE2='"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"', "+
						              "PRICE3='"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"', "+
						              "discontinued='"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"', "+
						              "reorderlevel='"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"', "+
						              "reorderqty='"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"' where psrno="+pdocno1;
							 }else {
						
						sql="INSERT INTO  " + db + ".my_desc(psrno, doc_no,brhid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
								+ " ('"+pdocno1+"','"+pdocno1+"',"
								+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
								+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
								+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
								+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
								+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
								+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
								+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
								+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
								+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
								+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";

							 }
						//System.out.println("my_Desc brch2--->>>>Sql"+sql);
						branchper = stmt.executeUpdate (sql);
						}
						
						else if(comp_brach==1)
						{
							if(prods>0) {
						       sql = "UPDATE  " + db + ".my_desc set "+
                                    "doc_no='"+pdocno1+"',cmpid='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"', "+
                                    "bin='"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"', "+
                                    "minStock='"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"', "+
                                    "maxStock='"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"', "+
                                    "PRICE1='"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"', "+
                                    "PRICE2='"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"', "+
                                    "PRICE3='"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"', "+
                                    "discontinued='"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"', "+
                                    "reorderlevel='"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"', "+
                                    "reorderqty='"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"' where psrno="+pdocno1;
                      
							}else {
						    
							sql="INSERT INTO  " + db + ".my_desc(psrno,doc_no, cmpid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
									+ " ('"+pdocno1+"','"+pdocno1+"',"
									+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
									+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
   								    + "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
									+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
									+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
									+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
									+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
									+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
									+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
									+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";


							}
							//System.out.println("my_desc brch1--->>>>Sql"+sql);
							branchper = stmt.executeUpdate (sql);
						}
					 
					}
					

				}
				
				
				
 
				
				
				for(int i=0;i< ssarray.size();i++){
					String[] ssarr=((String) ssarray.get(i)).split("::");
					
					if(i==0)
					{
						String delsql="delete  from  " + db + ".my_prdsuperseding where psrno='"+pdocno1+"'";
						stmt.executeUpdate(delsql);
					}
					
					if(!((ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("0") || ssarr[0].trim().equalsIgnoreCase("") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].isEmpty()))){
				     String sql="INSERT INTO  " + db + ".my_prdsuperseding(sr_no,psrno,part_no,priority,discontinued)VALUES"
						       + " ("+(i+1)+","
						       + " '"+pdocno1+"',"
						       + "'"+(ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].trim().equalsIgnoreCase("")|| ssarr[0].isEmpty()?0:ssarr[0].trim())+"',"
						       + "'"+(ssarr[1].trim().equalsIgnoreCase("undefined") || ssarr[1].trim().equalsIgnoreCase("NaN")|| ssarr[1].trim().equalsIgnoreCase("")|| ssarr[1].isEmpty()?0:ssarr[1].trim())+"',"
						       + "'"+(ssarr[2].trim().equalsIgnoreCase("undefined") || ssarr[2].trim().equalsIgnoreCase("NaN")|| ssarr[2].trim().equalsIgnoreCase("")|| ssarr[2].isEmpty()?0:ssarr[2].trim())+"' )";
			 	     int resultSet2 = stmt.executeUpdate(sql);
					     if(resultSet2<=0)
							{
								conn.close();
								return 0;
								
							}
									}
					
					
								}
				
				
				
				for(int i=0;i< pmgntarray.size();i++){
					
					if(i==0)
					{
						String delsql="delete  from  " + db + ".my_descpr where psrno='"+pdocno1+"'";
						stmt.executeUpdate(delsql);
					}
					
					
					String[] pmgntarr=((String) pmgntarray.get(i)).split("::");
		
					
					 if((!(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().isEmpty())) 
							   || (!(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().isEmpty()))
							  ||  (!(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().isEmpty()))
							   ||  (!(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().isEmpty()))
							  ||  (!(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().isEmpty()))
							  ||  (!(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().isEmpty()))
							  ||  (!(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().isEmpty()))
							  ||  (!(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().isEmpty()))
							  ||  (!(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().isEmpty()))
							   ||  (!(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("") || pmgntarr[10].trim().equalsIgnoreCase("NaN")|| pmgntarr[10].trim().isEmpty()))
							   ||  (!(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("") || pmgntarr[11].trim().equalsIgnoreCase("NaN")|| pmgntarr[11].trim().isEmpty()))
							  ||  (!(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("") || pmgntarr[12].trim().equalsIgnoreCase("NaN")|| pmgntarr[12].trim().isEmpty()))){
					
 
			     String sql="INSERT INTO  " + db + ".my_descpr(sr_no,psrno, catid,  price1, price2, price3, discount1, discount2, discount3, foc1, foc2, foc3,qty1,qty2,qty3)VALUES"
					       + " ("+(i+1)+","
					       + " '"+pdocno1+"',"
					       + "'"+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"',"
					       + "'"+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"',"
					       + "'"+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"',"
					       + "'"+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")||pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"',"
					       + "'"+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"',"
					       + "'"+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")||pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"',"
					       + "'"+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")||pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"',"
					       + "'"+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")||pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"',"
					       + "'"+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")||pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"',"
					       + "'"+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")||pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?0:pmgntarr[9].trim())+"',"
			               + "'"+(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("NaN")||pmgntarr[10].trim().equalsIgnoreCase("")|| pmgntarr[10].isEmpty()?0:pmgntarr[10].trim())+"',"
			               + "'"+(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("NaN")||pmgntarr[11].trim().equalsIgnoreCase("")|| pmgntarr[11].isEmpty()?0:pmgntarr[11].trim())+"',"
			               + "'"+(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("NaN")||pmgntarr[12].trim().equalsIgnoreCase("")|| pmgntarr[12].isEmpty()?0:pmgntarr[12].trim())+"')";
			    
				
		 	     int resultSet2 = stmt.executeUpdate(sql);
				     if(resultSet2<=0)
						{
							conn.close();
							return 0;
							
						}
					     
					}
			            	}

				int unitdesc=0;

				for(int i=0;i< uomarray.size();i++){
					String[] uomarr=((String) uomarray.get(i)).trim().split("::");
					String sql="";
					
					if(!((uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()))){
					        int uomdocno=0;
					        if(!((uomarr[7].equalsIgnoreCase("undefined") || uomarr[7].equalsIgnoreCase("") || uomarr[7].trim().equalsIgnoreCase("NaN")|| uomarr[7].isEmpty()))) {
					            uomdocno=Integer.parseInt(uomarr[7]);
					        }
					        int uomp=0;
					        String uomsql = "select count(*) as counts from  " + db + ".my_unit where psrno='"+pdocno1+"' and doc_no="+uomdocno;
					        //System.out.println(uomsql);
					        ResultSet rsuom=stmt.executeQuery(uomsql);
					        if(rsuom.next()) {
					            uomp = rsuom.getInt("counts");
					            System.out.println(uomp);
					        }
					        if(uomp>0) {
					            sql = "UPDATE  " + db + ".my_unit set UNIT='"+(uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()?0:uomarr[0].trim())+"', "+ 
					            "FR='"+(uomarr[1].trim().equalsIgnoreCase("undefined")  || uomarr[1].trim().equalsIgnoreCase("") || uomarr[1].trim().equalsIgnoreCase("NaN")|| uomarr[1].isEmpty()?0:uomarr[1].trim())+"', "+
					            "wt='"+(uomarr[2].trim().equalsIgnoreCase("undefined") || uomarr[2].trim().equalsIgnoreCase("") || uomarr[2].trim().equalsIgnoreCase("NaN")|| uomarr[2].isEmpty()?0:uomarr[2].trim())+"', "+
					            "VOLUME='"+(uomarr[3].trim().equalsIgnoreCase("undefined") || uomarr[3].trim().equalsIgnoreCase("") || uomarr[3].trim().equalsIgnoreCase("NaN")|| uomarr[3].isEmpty()?0:uomarr[3].trim())+"', "+
					            "thk='"+(uomarr[4].trim().equalsIgnoreCase("undefined") || uomarr[4].trim().equalsIgnoreCase("") || uomarr[4].trim().equalsIgnoreCase("NaN")|| uomarr[4].isEmpty()?0:uomarr[4].trim())+"', "+
					            "leng='"+(uomarr[5].trim().equalsIgnoreCase("undefined") || uomarr[5].trim().equalsIgnoreCase("") || uomarr[5].trim().equalsIgnoreCase("NaN")|| uomarr[5].isEmpty()?0:uomarr[5].trim())+"', "+
					            "width='"+(uomarr[6].trim().equalsIgnoreCase("undefined") || uomarr[6].trim().equalsIgnoreCase("") || uomarr[6].trim().equalsIgnoreCase("NaN")|| uomarr[6].isEmpty()?0:uomarr[6].trim())+"' where psrno="+pdocno1+" and doc_no="+(uomarr[7].trim().equalsIgnoreCase("undefined")  || uomarr[7].trim().equalsIgnoreCase("") || uomarr[7].trim().equalsIgnoreCase("NaN")|| uomarr[7].isEmpty()?0:uomarr[7].trim());
					            
					        } else {
					            sql="INSERT INTO  " + db + ".my_unit(PSRNO, UNIT, FR, wt, VOLUME, thk, leng, width)VALUES"
		                                + " ('"+pdocno1+"',"
		                                + "'"+(uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()?0:uomarr[0].trim())+"',"
		                                + "'"+(uomarr[1].trim().equalsIgnoreCase("undefined")  || uomarr[1].trim().equalsIgnoreCase("") || uomarr[1].trim().equalsIgnoreCase("NaN")|| uomarr[1].isEmpty()?0:uomarr[1].trim())+"',"
		                                + "'"+(uomarr[2].trim().equalsIgnoreCase("undefined") || uomarr[2].trim().equalsIgnoreCase("") || uomarr[2].trim().equalsIgnoreCase("NaN")|| uomarr[2].isEmpty()?0:uomarr[2].trim())+"',"
		                                + "'"+(uomarr[3].trim().equalsIgnoreCase("undefined") || uomarr[3].trim().equalsIgnoreCase("") || uomarr[3].trim().equalsIgnoreCase("NaN")|| uomarr[3].isEmpty()?0:uomarr[3].trim())+"',"
		                                + "'"+(uomarr[4].trim().equalsIgnoreCase("undefined") || uomarr[4].trim().equalsIgnoreCase("") || uomarr[4].trim().equalsIgnoreCase("NaN")|| uomarr[4].isEmpty()?0:uomarr[4].trim())+"',"
		                                + "'"+(uomarr[5].trim().equalsIgnoreCase("undefined") || uomarr[5].trim().equalsIgnoreCase("") || uomarr[5].trim().equalsIgnoreCase("NaN")|| uomarr[5].isEmpty()?0:uomarr[5].trim())+"',"
		                                + "'"+(uomarr[6].trim().equalsIgnoreCase("undefined") || uomarr[6].trim().equalsIgnoreCase("") || uomarr[6].trim().equalsIgnoreCase("NaN")|| uomarr[6].isEmpty()?0:uomarr[6].trim())+"')";

					        }
					      //  System.out.println("MY_UNIT -----"+sql);
						unitdesc = stmt.executeUpdate(sql);
					}

				}
				
				
				String sqlcon="select  method from  " + db + ".gl_config where field_nme='classification grid' ";
	    		//System.out.println("config-====="+sqlcon);
	    		ResultSet rsconfg = stmt.executeQuery(sqlcon);
	    		int method=0;
	    		while (rsconfg.next()) {
	             method=rsconfg.getInt("method");
	    			//System.out.println("method=="+method);
	    		}
	    		if(method==1) {
              int specMastersdesc = 0;
                
                String sqlconf = "select * from  " + db + ".my_prodspecp where psrno ='"+pdocno1+"'";
                ResultSet test = stmt.executeQuery(sqlconf);
                //System.out.println("the result of the sql query is "+sqlconf+ "  "+ pdocno);
                if(test.next()) {
                    String sqldelete="delete from  " + db + ".my_prodspecp where psrno='"+docno+"'";
                    int update = stmt.executeUpdate(sqldelete);
                    //System.out.println("NO OF ROWS DELETED = "+update);
                }
                
                for (int i = 0; i < specMastersarray.size(); i++) {
                    String[] specMastersarr = ((String) specMastersarray.get(i)).trim().split(
                            "::");

                    if (!((specMastersarr[0].equalsIgnoreCase("undefined")
                            || specMastersarr[0].equalsIgnoreCase("")
                            || specMastersarr[0].trim().equalsIgnoreCase("NaN") || specMastersarr[0]
                                .isEmpty()))) {                 
                        /*if(x) {
                            String sql = "update my_prodspecp inner join my_prodspec on my_prodspecp.sdoc_no=my_prodspec.doc_no set my_prodspecp.psrno="
                                    + "'"
                                    + pdocno
                                    + "', my_prodspecp.description="
                                    + "'"
                                    + (specMastersarr[1].equalsIgnoreCase("undefined")
                                            || specMastersarr[1].equalsIgnoreCase("")
                                            || specMastersarr[1].trim().equalsIgnoreCase(
                                                    "NaN") || specMastersarr[1].isEmpty() ? 0
                                            : specMastersarr[1].trim())
                                    + "'where my_prodspecp.psrno='"+pdocno+"'";
                                    specMastersdesc = stmt.executeUpdate(sql);
                                    if(specMastersdesc<=0) {
                                        sql = "INSERT INTO my_prodspecp(psrno, name, description, sdoc_no)VALUES"
                                                + " ('"
                                                + pdocno
                                                + "',"
                                                + "'"
                                                + (specMastersarr[0].equalsIgnoreCase("undefined")
                                                        || specMastersarr[0].equalsIgnoreCase("")
                                                        || specMastersarr[0].trim().equalsIgnoreCase(
                                                                "NaN") || specMastersarr[0].isEmpty() ? 0
                                                        : specMastersarr[0].trim())
                                                + "',"
                                                + "'"
                                                + (specMastersarr[1].equalsIgnoreCase("undefined")
                                                        || specMastersarr[1].equalsIgnoreCase("")
                                                        || specMastersarr[1].trim().equalsIgnoreCase(
                                                                "NaN") || specMastersarr[1].isEmpty() ? 0
                                                        : specMastersarr[1].trim())
                                                + "',"
                                                + "'"
                                                + (specMastersarr[2].trim().equalsIgnoreCase("undefined")
                                                        || specMastersarr[2].trim()
                                                                .equalsIgnoreCase("")
                                                        || specMastersarr[2].trim().equalsIgnoreCase(
                                                                "NaN") || specMastersarr[2].isEmpty() ? 0
                                                        : specMastersarr[2].trim())+ "')";
                                                specMastersdesc = stmt.executeUpdate(sql);
                                    }
                                    ////System.out.println("sql======"+sql);
                        }else {
                        */
                                String sql = "INSERT INTO  " + db + ".my_prodspecp(psrno, name, description, sdoc_no)VALUES"
                                        + " ('"
                                        + pdocno1
                                        + "',"
                                        + "'"
                                        + (specMastersarr[0].equalsIgnoreCase("undefined")
                                                || specMastersarr[0].equalsIgnoreCase("")
                                                || specMastersarr[0].trim().equalsIgnoreCase(
                                                        "NaN") || specMastersarr[0].isEmpty() ? 0
                                                : specMastersarr[0].trim())
                                        + "',"
                                        + "'"
                                        + (specMastersarr[1].equalsIgnoreCase("undefined")
                                                || specMastersarr[1].equalsIgnoreCase("")
                                                || specMastersarr[1].trim().equalsIgnoreCase(
                                                        "NaN") || specMastersarr[1].isEmpty() ? 0
                                                : specMastersarr[1].trim())
                                        + "',"
                                        + "'"
                                        + (specMastersarr[2].trim().equalsIgnoreCase("undefined")
                                                || specMastersarr[2].trim()
                                                        .equalsIgnoreCase("")
                                                || specMastersarr[2].trim().equalsIgnoreCase(
                                                        "NaN") || specMastersarr[2].isEmpty() ? 0
                                                : specMastersarr[2].trim())+ "')";
                                        specMastersdesc = stmt.executeUpdate(sql);
                                        
                                        //System.out.println("sqlSPECMASTER======"+sql);
                    }
                }

	    }
				int specdesc=0;
				
	    			// grid loading is not written below portion will not work
				for(int i=0;i< specarray.size();i++){
					String[] specarr=((String) specarray.get(i)).split("::");
					String chksql="select count(*) as psrno from  " + db + ".my_prodattrib where MPSRNO='"+pdocno1+"' " ;
				//	System.out.println("chksql-====="+chksql);
		    		ResultSet rschksql = stmt.executeQuery(chksql);
		    		int psrno=0;
		    		while (rschksql.next()) {
		    			psrno=rschksql.getInt("MPSRNO");
		    			
		    		}
					if(!((specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()))){
	                  
						if(psrno>0) {
			    			
			    			String  sql = "UPDATE  " + db + ".my_prodattrib set "+
	                                 "MPSRNO='"+pdocno1+"',MSPECNO='"+pdocno+"', "
	                                 + "spec1='"+(specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()?0:specarr[0].trim())+"', "
	                                 + "spec2='"+(specarr[1].trim().equalsIgnoreCase("undefined")  || specarr[1].trim().equalsIgnoreCase("") || specarr[1].trim().equalsIgnoreCase("NaN")|| specarr[1].isEmpty()?0:specarr[1].trim())+"', "
	                                 + "spec3='"+(specarr[2].trim().equalsIgnoreCase("undefined") || specarr[2].trim().equalsIgnoreCase("") || specarr[2].trim().equalsIgnoreCase("NaN")|| specarr[2].isEmpty()?0:specarr[2].trim())+"', " 
                                     + " spec4='"+(specarr[3].trim().equalsIgnoreCase("undefined") || specarr[3].trim().equalsIgnoreCase("") || specarr[3].trim().equalsIgnoreCase("NaN")|| specarr[3].isEmpty()?0:specarr[3].trim())+"', "
	                                 + "barcode='"+(specarr[4].trim().equalsIgnoreCase("undefined") || specarr[4].trim().equalsIgnoreCase("") || specarr[4].trim().equalsIgnoreCase("NaN")|| specarr[4].isEmpty()?0:specarr[4].trim())+"' where mpsrno="+pdocno1; 
    
			    		//	System.out.println("my_prodattrib update--->>>>Sql"+sql);
							specdesc = stmt.executeUpdate (sql);
			    		}else {

						String sql="INSERT INTO  " + db + ".my_prodattrib(MPSRNO,MSPECNO, spec1, spec2, spec3, spec4, barcode)VALUES"
								+ " ('"+pdocno1+"','"+pdocno1+"',"
								+ "'"+(specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()?0:specarr[0].trim())+"',"
								+ "'"+(specarr[1].trim().equalsIgnoreCase("undefined")  || specarr[1].trim().equalsIgnoreCase("") || specarr[1].trim().equalsIgnoreCase("NaN")|| specarr[1].isEmpty()?0:specarr[1].trim())+"',"
								+ "'"+(specarr[2].trim().equalsIgnoreCase("undefined") || specarr[2].trim().equalsIgnoreCase("") || specarr[2].trim().equalsIgnoreCase("NaN")|| specarr[2].isEmpty()?0:specarr[2].trim())+"',"
								+ "'"+(specarr[3].trim().equalsIgnoreCase("undefined") || specarr[3].trim().equalsIgnoreCase("") || specarr[3].trim().equalsIgnoreCase("NaN")|| specarr[3].isEmpty()?0:specarr[3].trim())+"',"
								+ "'"+(specarr[4].trim().equalsIgnoreCase("undefined") || specarr[4].trim().equalsIgnoreCase("") || specarr[4].trim().equalsIgnoreCase("NaN")|| specarr[4].isEmpty()?0:specarr[4].trim())+"')";


					//System.out.println("specarr--->>>>Sql"+sql);
						specdesc = stmt.executeUpdate (sql);
					}
				}
			}

	    	
	    		
	    		
				int suitdesc=0;
				
				String sqlconns="select  method from  " + db + ".gl_prdconfig where field_nme='suit' ";
	    		//System.out.println("config-====="+sqlconns);
	    		ResultSet rsconfggs = stmt.executeQuery(sqlconns);
	    		int methodsuit=0;
	    		while (rsconfggs.next()) {
	    			methodsuit=rsconfggs.getInt("method");
	    			//System.out.println("methods=="+methodsuit);
	    		}
	    		if(methodsuit==1) {

				/*for(int i=0;i< suitarray.size();i++){
					String[] suitarr=((String) suitarray.get(i)).split("::");
					if(!((suitarr[0].equalsIgnoreCase("0"))||(suitarr[0].equalsIgnoreCase("undefined")))){


						String sql="INSERT INTO my_prodsuit(PSRNO, sbrand_id, smodel_id, syomfrm_id, syomto_id, spec1_id, spec2_id, spec3_id,submodelid)VALUES"
								+ " ('"+pdocno+"',"
								+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
								+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
								+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
								+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
								+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
								+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
								+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
								+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"')";
						
						//System.out.println("suitarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}

				}*/
				
				for(int i=0;i< suitarray.size()-1;i++){
				//	//System.out.println("==suitarray.size()==="+suitarray.size());
					String[] suitarr=((String) suitarray.get(i)).split("::");
					if(!((suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()))){


						String sql="INSERT INTO  " + db + ".my_prodsuit(PSRNO, vehsuitid,syomfrm_id,syomto_id,bsize1id,bsize2id,bsize3id,csize1id,csize2id,csize3id)VALUES"
								+ " ('"+pdocno1+"',"
								+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
								+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
								+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
								+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
								+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
								+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
								+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
								+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"',"
								+ "'"+(suitarr[8].trim().equalsIgnoreCase("undefined") || suitarr[8].trim().equalsIgnoreCase("") || suitarr[8].trim().equalsIgnoreCase("NaN")|| suitarr[8].isEmpty()?0:suitarr[8].trim())+"')";
						
					//	//System.out.println("suitarr--->>>>Sql"+sql);
						suitdesc = stmt.executeUpdate (sql);
					}

				}
	    		}

				for(int i=0;i< altrarray.size();i++){
					String[] altrarr=((String) altrarray.get(i)).split("::");
					String tstchk2=""+(altrarr[1].equalsIgnoreCase("undefined") || altrarr[1].equalsIgnoreCase("") || altrarr[1].trim().equalsIgnoreCase("NaN")|| altrarr[1].isEmpty()?0:altrarr[1].trim())+"";
					//System.out.println("my_pralter=======docno=string=="+tstchk2);
					if(!((altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()))){
					
						if(!((tstchk2.equalsIgnoreCase("undefined") || tstchk2.equalsIgnoreCase("") || tstchk2.trim().equalsIgnoreCase("NaN")|| tstchk2.isEmpty()))){
						int chkval=Integer.parseInt(tstchk2);
						//System.out.println("my_pralter=======docno=int=="+chkval);
								
			
								if(chkval>0) {
									String tstchkval=""+(altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()?0:altrarr[0].trim())+"";
								String sqltst="update  " + db + ".my_pralter set rdocno="+pdocno1+",altpsrno='"+tstchkval+"' where doc_no="+tstchk2+"";
								suitdesc = stmt.executeUpdate (sqltst);
								}
					    }
						else
						{
							//System.out.println("my_pralter=======docno=int==in else inert");
								String sql="INSERT INTO  " + db + ".my_pralter(rdocno, altpsrno)VALUES"
								+ " ('"+pdocno1+"',"
								+ "'"+(altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()?0:altrarr[0].trim())+"')";
								
								
							
						        //System.out.println("altrarr--->>>>Sql"+sql);
						        suitdesc = stmt.executeUpdate (sql);
						        //System.out.println("altrarr--->>>>suitdesc"+suitdesc);
					 }
					}			
				   }		
			     } //pdocno>0 end
			   } //db check end
			 }//db name end
			} //dsconnection end
		} //multicompany check end
				      }else {
				        	  
				        	  
				  			CallableStatement stmt = conn.prepareCall("{CALL productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");


							//System.out.println("CALL productDML('"+date+"','"+pname+"','"+pcode+"','"+pbarcode+"','"+ptype+"','"+pbrand+"','"+pcat+"','"+psubcat+"','"+unit+"','"+dept+"','"+mode+"','"+dtype+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"','"+hsncode+"')");

							stmt.setInt(16,docno);
							stmt.setDate(1,date);
							stmt.setString(2,pname);
							stmt.setString(3,pcode);
							stmt.setString(4, pbarcode);
							stmt.setInt(5, Integer.parseInt(ptype.equalsIgnoreCase("")?"0":ptype));
							stmt.setInt(6, Integer.parseInt(pbrand.equalsIgnoreCase("")?"0":pbrand));
							stmt.setInt(7, Integer.parseInt(pcat.equalsIgnoreCase("")?"0":pcat));
							stmt.setInt(8, Integer.parseInt(psubcat.equalsIgnoreCase("")?"0":psubcat));
							stmt.setInt(9, Integer.parseInt(unit.equalsIgnoreCase("")?"0":unit));
							stmt.setInt(10, Integer.parseInt(dept.equalsIgnoreCase("")?"0":dept));
							stmt.setString(11, mode);
							stmt.setString(12, dtype);
							stmt.setString(13, session.getAttribute("USERID").toString());
							stmt.setString(14, session.getAttribute("BRANCHID").toString());
							stmt.setInt(15, Integer.parseInt(hsncode.equalsIgnoreCase("")?"0":hsncode));
							int val = stmt.executeUpdate();
							if(val<0) {
								return 0;
							}
							pdocno=stmt.getInt("pdocno");


							if (pdocno > 0) {
								
								
								String sqls4="update my_main set prdname='"+arabicprdname+"',star='"+cmbstar+"',mtypeid='"+cmbmastertype+"',desc1='"+desc1+"',warranty='"+action.getWarranty()+"', warrantydays='"+action.getWarrantydays()+"'  where doc_no='"+pdocno+"'";
								//System.out.println("======sqls4=="+sqls4);
								
								stmt.executeUpdate(sqls4);
								
								int branchper=0;
								
								if(comp_brach==1)
								{
									String sqls="update my_main set comp_brch='C' where doc_no='"+pdocno+"'";
									stmt.executeUpdate(sqls);
								}
								else if(comp_brach==2)
								{
									String sqls="update my_main set comp_brch='B' where doc_no='"+pdocno+"'";
									stmt.executeUpdate(sqls);
								}
								
								
								if(pbarcode.equalsIgnoreCase("") || pbarcode==null)
								{
									String sqls="update my_main set barcode='"+pdocno+"' where doc_no='"+pdocno+"'";
									stmt.executeUpdate(sqls);
								}
								
								
								
								for(int i=0;i< prodarray.size();i++){
									String[] prod=((String) prodarray.get(i)).split("::");
									if(!((prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()))){
										int   prods=0;
										String prodsql = "select count(*) as counts from my_desc where psrno='"+pdocno+"' ";
									        //System.out.println("my_desc check------"+prodsql);
									        ResultSet rsprod=stmt.executeQuery(prodsql);
									        if(rsprod.next()) {
									        	prods = rsprod.getInt("counts");
									            //System.out.println(prods);
									        }
									       String sql="";
										if(comp_brach==2)
										{
											 if(prods>0) {
										sql = "UPDATE my_desc set "+
										              "doc_no='"+pdocno+"',brhid='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"', "+
										              "bin='"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"', "+
										              "minStock='"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"', "+
										              "maxStock='"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"', "+
										              "PRICE1='"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"', "+
										              "PRICE2='"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"', "+
										              "PRICE3='"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"', "+
										              "discontinued='"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"', "+
										              "reorderlevel='"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"', "+
										              "reorderqty='"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"' where psrno="+pdocno;
											 }else {
										
										sql="INSERT INTO my_desc(psrno, doc_no,brhid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
												+ " ('"+pdocno+"','"+pdocno+"',"
												+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
												+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
												+ "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
												+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
												+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
												+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
												+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
												+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
												+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
												+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";

											 }
										//System.out.println("my_Desc brch2--->>>>Sql"+sql);
										branchper = stmt.executeUpdate (sql);
										}
										
										else if(comp_brach==1)
										{
											if(prods>0) {
										       sql = "UPDATE my_desc set "+
				                                    "doc_no='"+pdocno+"',cmpid='"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"', "+
				                                    "bin='"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"', "+
				                                    "minStock='"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"', "+
				                                    "maxStock='"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"', "+
				                                    "PRICE1='"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"', "+
				                                    "PRICE2='"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"', "+
				                                    "PRICE3='"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"', "+
				                                    "discontinued='"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"', "+
				                                    "reorderlevel='"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"', "+
				                                    "reorderqty='"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"' where psrno="+pdocno;
				                      
											}else {
										    
											sql="INSERT INTO my_desc(psrno,doc_no, cmpid,bin, minStock, maxStock, PRICE1, PRICE2, PRICE3,discontinued,reorderlevel,reorderqty)VALUES"
													+ " ('"+pdocno+"','"+pdocno+"',"
													+ "'"+(prod[0].equalsIgnoreCase("undefined") || prod[0].equalsIgnoreCase("") || prod[0].trim().equalsIgnoreCase("NaN")|| prod[0].isEmpty()?0:prod[0].trim())+"',"
													+ "'"+(prod[3].trim().equalsIgnoreCase("undefined")  || prod[3].trim().equalsIgnoreCase("") || prod[3].trim().equalsIgnoreCase("NaN")|| prod[3].isEmpty()?0:prod[3].trim())+"',"
				   								    + "'"+(prod[4].trim().equalsIgnoreCase("undefined") || prod[4].trim().equalsIgnoreCase("") || prod[4].trim().equalsIgnoreCase("NaN")|| prod[4].isEmpty()?0:prod[4].trim())+"',"
													+ "'"+(prod[5].trim().equalsIgnoreCase("undefined") || prod[5].trim().equalsIgnoreCase("") || prod[5].trim().equalsIgnoreCase("NaN")|| prod[5].isEmpty()?0:prod[5].trim())+"',"
													+ "'"+(prod[6].trim().equalsIgnoreCase("undefined") || prod[6].trim().equalsIgnoreCase("") || prod[6].trim().equalsIgnoreCase("NaN")|| prod[6].isEmpty()?0:prod[6].trim())+"',"
													+ "'"+(prod[7].trim().equalsIgnoreCase("undefined") || prod[7].trim().equalsIgnoreCase("") || prod[7].trim().equalsIgnoreCase("NaN")|| prod[7].isEmpty()?0:prod[7].trim())+"',"
													+ "'"+(prod[8].trim().equalsIgnoreCase("undefined") || prod[8].trim().equalsIgnoreCase("") || prod[8].trim().equalsIgnoreCase("NaN")|| prod[8].isEmpty()?0:prod[8].trim())+"',"
													+ "'"+(prod[2].trim().equalsIgnoreCase("undefined") || prod[2].trim().equalsIgnoreCase("") || prod[2].trim().equalsIgnoreCase("NaN")|| prod[2].isEmpty()?0:prod[2].trim())+"',"
													+ "'"+(prod[9].trim().equalsIgnoreCase("undefined") || prod[9].trim().equalsIgnoreCase("") || prod[9].trim().equalsIgnoreCase("NaN")|| prod[9].isEmpty()?0:prod[9].trim())+"',"
													+ "'"+(prod[10].trim().equalsIgnoreCase("undefined") || prod[10].trim().equalsIgnoreCase("") || prod[10].trim().equalsIgnoreCase("NaN")|| prod[10].isEmpty()?0:prod[10].trim())+"')";


											}
											//System.out.println("my_desc brch1--->>>>Sql"+sql);
											branchper = stmt.executeUpdate (sql);
										}
									 
									}
									

								}
								
								
								
				 
								
								
								for(int i=0;i< ssarray.size();i++){
									String[] ssarr=((String) ssarray.get(i)).split("::");
									
									if(i==0)
									{
										String delsql="delete  from my_prdsuperseding where psrno='"+pdocno+"'";
										stmt.executeUpdate(delsql);
									}
									
									if(!((ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("0") || ssarr[0].trim().equalsIgnoreCase("") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].isEmpty()))){
								     String sql="INSERT INTO my_prdsuperseding(sr_no,psrno,part_no,priority,discontinued)VALUES"
										       + " ("+(i+1)+","
										       + " '"+pdocno+"',"
										       + "'"+(ssarr[0].trim().equalsIgnoreCase("undefined") || ssarr[0].trim().equalsIgnoreCase("NaN")|| ssarr[0].trim().equalsIgnoreCase("")|| ssarr[0].isEmpty()?0:ssarr[0].trim())+"',"
										       + "'"+(ssarr[1].trim().equalsIgnoreCase("undefined") || ssarr[1].trim().equalsIgnoreCase("NaN")|| ssarr[1].trim().equalsIgnoreCase("")|| ssarr[1].isEmpty()?0:ssarr[1].trim())+"',"
										       + "'"+(ssarr[2].trim().equalsIgnoreCase("undefined") || ssarr[2].trim().equalsIgnoreCase("NaN")|| ssarr[2].trim().equalsIgnoreCase("")|| ssarr[2].isEmpty()?0:ssarr[2].trim())+"' )";
							 	     int resultSet2 = stmt.executeUpdate(sql);
									     if(resultSet2<=0)
											{
												conn.close();
												return 0;
												
											}
													}
									
									
												}
								
								
								
								for(int i=0;i< pmgntarray.size();i++){
									
									if(i==0)
									{
										String delsql="delete  from my_descpr where psrno='"+pdocno+"'";
										stmt.executeUpdate(delsql);
									}
									
									
									String[] pmgntarr=((String) pmgntarray.get(i)).split("::");
						
									
									 if((!(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().isEmpty())) 
											   || (!(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().isEmpty()))
											  ||  (!(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("") || pmgntarr[3].trim().equalsIgnoreCase("NaN")|| pmgntarr[3].trim().isEmpty()))
											   ||  (!(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().isEmpty()))
											  ||  (!(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("") || pmgntarr[5].trim().equalsIgnoreCase("NaN")|| pmgntarr[5].trim().isEmpty()))
											  ||  (!(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("") || pmgntarr[6].trim().equalsIgnoreCase("NaN")|| pmgntarr[6].trim().isEmpty()))
											  ||  (!(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("") || pmgntarr[7].trim().equalsIgnoreCase("NaN")|| pmgntarr[7].trim().isEmpty()))
											  ||  (!(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("") || pmgntarr[8].trim().equalsIgnoreCase("NaN")|| pmgntarr[8].trim().isEmpty()))
											  ||  (!(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("") || pmgntarr[9].trim().equalsIgnoreCase("NaN")|| pmgntarr[9].trim().isEmpty()))
											   ||  (!(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("") || pmgntarr[10].trim().equalsIgnoreCase("NaN")|| pmgntarr[10].trim().isEmpty()))
											   ||  (!(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("") || pmgntarr[11].trim().equalsIgnoreCase("NaN")|| pmgntarr[11].trim().isEmpty()))
											  ||  (!(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("") || pmgntarr[12].trim().equalsIgnoreCase("NaN")|| pmgntarr[12].trim().isEmpty()))){
									
				 
							     String sql="INSERT INTO my_descpr(sr_no,psrno, catid,  price1, price2, price3, discount1, discount2, discount3, foc1, foc2, foc3,qty1,qty2,qty3)VALUES"
									       + " ("+(i+1)+","
									       + " '"+pdocno+"',"
									       + "'"+(pmgntarr[0].trim().equalsIgnoreCase("undefined") || pmgntarr[0].trim().equalsIgnoreCase("NaN")|| pmgntarr[0].trim().equalsIgnoreCase("")|| pmgntarr[0].isEmpty()?0:pmgntarr[0].trim())+"',"
									       + "'"+(pmgntarr[1].trim().equalsIgnoreCase("undefined") || pmgntarr[1].trim().equalsIgnoreCase("NaN")|| pmgntarr[1].trim().equalsIgnoreCase("")|| pmgntarr[1].isEmpty()?0:pmgntarr[1].trim())+"',"
									       + "'"+(pmgntarr[2].trim().equalsIgnoreCase("undefined") || pmgntarr[2].trim().equalsIgnoreCase("NaN")|| pmgntarr[2].trim().equalsIgnoreCase("")|| pmgntarr[2].isEmpty()?0:pmgntarr[2].trim())+"',"
									       + "'"+(pmgntarr[3].trim().equalsIgnoreCase("undefined") || pmgntarr[3].trim().equalsIgnoreCase("NaN")||pmgntarr[3].trim().equalsIgnoreCase("")|| pmgntarr[3].isEmpty()?0:pmgntarr[3].trim())+"',"
									       + "'"+(pmgntarr[4].trim().equalsIgnoreCase("undefined") || pmgntarr[4].trim().equalsIgnoreCase("NaN")|| pmgntarr[4].trim().equalsIgnoreCase("")|| pmgntarr[4].isEmpty()?0:pmgntarr[4].trim())+"',"
									       + "'"+(pmgntarr[5].trim().equalsIgnoreCase("undefined") || pmgntarr[5].trim().equalsIgnoreCase("NaN")||pmgntarr[5].trim().equalsIgnoreCase("")|| pmgntarr[5].isEmpty()?0:pmgntarr[5].trim())+"',"
									       + "'"+(pmgntarr[6].trim().equalsIgnoreCase("undefined") || pmgntarr[6].trim().equalsIgnoreCase("NaN")||pmgntarr[6].trim().equalsIgnoreCase("")|| pmgntarr[6].isEmpty()?0:pmgntarr[6].trim())+"',"
									       + "'"+(pmgntarr[7].trim().equalsIgnoreCase("undefined") || pmgntarr[7].trim().equalsIgnoreCase("NaN")||pmgntarr[7].trim().equalsIgnoreCase("")|| pmgntarr[7].isEmpty()?0:pmgntarr[7].trim())+"',"
									       + "'"+(pmgntarr[8].trim().equalsIgnoreCase("undefined") || pmgntarr[8].trim().equalsIgnoreCase("NaN")||pmgntarr[8].trim().equalsIgnoreCase("")|| pmgntarr[8].isEmpty()?0:pmgntarr[8].trim())+"',"
									       + "'"+(pmgntarr[9].trim().equalsIgnoreCase("undefined") || pmgntarr[9].trim().equalsIgnoreCase("NaN")||pmgntarr[9].trim().equalsIgnoreCase("")|| pmgntarr[9].isEmpty()?0:pmgntarr[9].trim())+"',"
							               + "'"+(pmgntarr[10].trim().equalsIgnoreCase("undefined") || pmgntarr[10].trim().equalsIgnoreCase("NaN")||pmgntarr[10].trim().equalsIgnoreCase("")|| pmgntarr[10].isEmpty()?0:pmgntarr[10].trim())+"',"
							               + "'"+(pmgntarr[11].trim().equalsIgnoreCase("undefined") || pmgntarr[11].trim().equalsIgnoreCase("NaN")||pmgntarr[11].trim().equalsIgnoreCase("")|| pmgntarr[11].isEmpty()?0:pmgntarr[11].trim())+"',"
							               + "'"+(pmgntarr[12].trim().equalsIgnoreCase("undefined") || pmgntarr[12].trim().equalsIgnoreCase("NaN")||pmgntarr[12].trim().equalsIgnoreCase("")|| pmgntarr[12].isEmpty()?0:pmgntarr[12].trim())+"')";
							    
								
						 	     int resultSet2 = stmt.executeUpdate(sql);
								     if(resultSet2<=0)
										{
											conn.close();
											return 0;
											
										}
									     
									}
							            	}

								int unitdesc=0;

								for(int i=0;i< uomarray.size();i++){
									String[] uomarr=((String) uomarray.get(i)).trim().split("::");
									String sql="";
									
									if(!((uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()))){
									        int uomdocno=0;
									        if(!((uomarr[7].equalsIgnoreCase("undefined") || uomarr[7].equalsIgnoreCase("") || uomarr[7].trim().equalsIgnoreCase("NaN")|| uomarr[7].isEmpty()))) {
									            uomdocno=Integer.parseInt(uomarr[7]);
									        }
									        int uomp=0;
									        String uomsql = "select count(*) as counts from my_unit where psrno='"+pdocno+"' and doc_no="+uomdocno;
									        //System.out.println(uomsql);
									        ResultSet rsuom=stmt.executeQuery(uomsql);
									        if(rsuom.next()) {
									            uomp = rsuom.getInt("counts");
									            //System.out.println(uomp);
									        }
									        if(uomp>0) {
									            sql = "UPDATE my_unit set UNIT='"+(uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()?0:uomarr[0].trim())+"', "+ 
									            "FR='"+(uomarr[1].trim().equalsIgnoreCase("undefined")  || uomarr[1].trim().equalsIgnoreCase("") || uomarr[1].trim().equalsIgnoreCase("NaN")|| uomarr[1].isEmpty()?0:uomarr[1].trim())+"', "+
									            "wt='"+(uomarr[2].trim().equalsIgnoreCase("undefined") || uomarr[2].trim().equalsIgnoreCase("") || uomarr[2].trim().equalsIgnoreCase("NaN")|| uomarr[2].isEmpty()?0:uomarr[2].trim())+"', "+
									            "VOLUME='"+(uomarr[3].trim().equalsIgnoreCase("undefined") || uomarr[3].trim().equalsIgnoreCase("") || uomarr[3].trim().equalsIgnoreCase("NaN")|| uomarr[3].isEmpty()?0:uomarr[3].trim())+"', "+
									            "thk='"+(uomarr[4].trim().equalsIgnoreCase("undefined") || uomarr[4].trim().equalsIgnoreCase("") || uomarr[4].trim().equalsIgnoreCase("NaN")|| uomarr[4].isEmpty()?0:uomarr[4].trim())+"', "+
									            "leng='"+(uomarr[5].trim().equalsIgnoreCase("undefined") || uomarr[5].trim().equalsIgnoreCase("") || uomarr[5].trim().equalsIgnoreCase("NaN")|| uomarr[5].isEmpty()?0:uomarr[5].trim())+"', "+
									            "width='"+(uomarr[6].trim().equalsIgnoreCase("undefined") || uomarr[6].trim().equalsIgnoreCase("") || uomarr[6].trim().equalsIgnoreCase("NaN")|| uomarr[6].isEmpty()?0:uomarr[6].trim())+"' where psrno="+pdocno+" and doc_no="+(uomarr[7].trim().equalsIgnoreCase("undefined")  || uomarr[7].trim().equalsIgnoreCase("") || uomarr[7].trim().equalsIgnoreCase("NaN")|| uomarr[7].isEmpty()?0:uomarr[7].trim());
									            
									        } else {
									            sql="INSERT INTO my_unit(PSRNO, UNIT, FR, wt, VOLUME, thk, leng, width)VALUES"
						                                + " ('"+pdocno+"',"
						                                + "'"+(uomarr[0].equalsIgnoreCase("undefined") || uomarr[0].equalsIgnoreCase("") || uomarr[0].trim().equalsIgnoreCase("NaN")|| uomarr[0].isEmpty()?0:uomarr[0].trim())+"',"
						                                + "'"+(uomarr[1].trim().equalsIgnoreCase("undefined")  || uomarr[1].trim().equalsIgnoreCase("") || uomarr[1].trim().equalsIgnoreCase("NaN")|| uomarr[1].isEmpty()?0:uomarr[1].trim())+"',"
						                                + "'"+(uomarr[2].trim().equalsIgnoreCase("undefined") || uomarr[2].trim().equalsIgnoreCase("") || uomarr[2].trim().equalsIgnoreCase("NaN")|| uomarr[2].isEmpty()?0:uomarr[2].trim())+"',"
						                                + "'"+(uomarr[3].trim().equalsIgnoreCase("undefined") || uomarr[3].trim().equalsIgnoreCase("") || uomarr[3].trim().equalsIgnoreCase("NaN")|| uomarr[3].isEmpty()?0:uomarr[3].trim())+"',"
						                                + "'"+(uomarr[4].trim().equalsIgnoreCase("undefined") || uomarr[4].trim().equalsIgnoreCase("") || uomarr[4].trim().equalsIgnoreCase("NaN")|| uomarr[4].isEmpty()?0:uomarr[4].trim())+"',"
						                                + "'"+(uomarr[5].trim().equalsIgnoreCase("undefined") || uomarr[5].trim().equalsIgnoreCase("") || uomarr[5].trim().equalsIgnoreCase("NaN")|| uomarr[5].isEmpty()?0:uomarr[5].trim())+"',"
						                                + "'"+(uomarr[6].trim().equalsIgnoreCase("undefined") || uomarr[6].trim().equalsIgnoreCase("") || uomarr[6].trim().equalsIgnoreCase("NaN")|| uomarr[6].isEmpty()?0:uomarr[6].trim())+"')";

									        }
										unitdesc = stmt.executeUpdate(sql);
									}

								}
								
								
								String sqlcon="select  method from gl_config where field_nme='classification grid' ";
					    		//System.out.println("config-====="+sqlcon);
					    		ResultSet rsconfg = stmt.executeQuery(sqlcon);
					    		int method=0;
					    		while (rsconfg.next()) {
					             method=rsconfg.getInt("method");
					    			//System.out.println("method=="+method);
					    		}
					    		if(method==1) {
				              int specMastersdesc = 0;
				                
				                String sqlconf = "select * from my_prodspecp where psrno ='"+pdocno+"'";
				                ResultSet test = stmt.executeQuery(sqlconf);
				                //System.out.println("the result of the sql query is "+test+ "  "+ pdocno);
				                boolean x = test.next();
				                if(x) {
				                    String sqldelete="delete from my_prodspecp where psrno='"+docno+"'";
				                    int update = stmt.executeUpdate(sqldelete);
				                    //System.out.println("NO OF ROWS DELETED = "+update);
				                }
				                
				                for (int i = 0; i < specMastersarray.size(); i++) {
				                    String[] specMastersarr = ((String) specMastersarray.get(i)).trim().split(
				                            "::");

				                    if (!((specMastersarr[0].equalsIgnoreCase("undefined")
				                            || specMastersarr[0].equalsIgnoreCase("")
				                            || specMastersarr[0].trim().equalsIgnoreCase("NaN") || specMastersarr[0]
				                                .isEmpty()))) {                 
				                        /*if(x) {
				                            String sql = "update my_prodspecp inner join my_prodspec on my_prodspecp.sdoc_no=my_prodspec.doc_no set my_prodspecp.psrno="
				                                    + "'"
				                                    + pdocno
				                                    + "', my_prodspecp.description="
				                                    + "'"
				                                    + (specMastersarr[1].equalsIgnoreCase("undefined")
				                                            || specMastersarr[1].equalsIgnoreCase("")
				                                            || specMastersarr[1].trim().equalsIgnoreCase(
				                                                    "NaN") || specMastersarr[1].isEmpty() ? 0
				                                            : specMastersarr[1].trim())
				                                    + "'where my_prodspecp.psrno='"+pdocno+"'";
				                                    specMastersdesc = stmt.executeUpdate(sql);
				                                    if(specMastersdesc<=0) {
				                                        sql = "INSERT INTO my_prodspecp(psrno, name, description, sdoc_no)VALUES"
				                                                + " ('"
				                                                + pdocno
				                                                + "',"
				                                                + "'"
				                                                + (specMastersarr[0].equalsIgnoreCase("undefined")
				                                                        || specMastersarr[0].equalsIgnoreCase("")
				                                                        || specMastersarr[0].trim().equalsIgnoreCase(
				                                                                "NaN") || specMastersarr[0].isEmpty() ? 0
				                                                        : specMastersarr[0].trim())
				                                                + "',"
				                                                + "'"
				                                                + (specMastersarr[1].equalsIgnoreCase("undefined")
				                                                        || specMastersarr[1].equalsIgnoreCase("")
				                                                        || specMastersarr[1].trim().equalsIgnoreCase(
				                                                                "NaN") || specMastersarr[1].isEmpty() ? 0
				                                                        : specMastersarr[1].trim())
				                                                + "',"
				                                                + "'"
				                                                + (specMastersarr[2].trim().equalsIgnoreCase("undefined")
				                                                        || specMastersarr[2].trim()
				                                                                .equalsIgnoreCase("")
				                                                        || specMastersarr[2].trim().equalsIgnoreCase(
				                                                                "NaN") || specMastersarr[2].isEmpty() ? 0
				                                                        : specMastersarr[2].trim())+ "')";
				                                                specMastersdesc = stmt.executeUpdate(sql);
				                                    }
				                                    //System.out.println("sql======"+sql);
				                        }else {
				                        */
				                                String sql = "INSERT INTO my_prodspecp(psrno, name, description, sdoc_no)VALUES"
				                                        + " ('"
				                                        + pdocno
				                                        + "',"
				                                        + "'"
				                                        + (specMastersarr[0].equalsIgnoreCase("undefined")
				                                                || specMastersarr[0].equalsIgnoreCase("")
				                                                || specMastersarr[0].trim().equalsIgnoreCase(
				                                                        "NaN") || specMastersarr[0].isEmpty() ? 0
				                                                : specMastersarr[0].trim())
				                                        + "',"
				                                        + "'"
				                                        + (specMastersarr[1].equalsIgnoreCase("undefined")
				                                                || specMastersarr[1].equalsIgnoreCase("")
				                                                || specMastersarr[1].trim().equalsIgnoreCase(
				                                                        "NaN") || specMastersarr[1].isEmpty() ? 0
				                                                : specMastersarr[1].trim())
				                                        + "',"
				                                        + "'"
				                                        + (specMastersarr[2].trim().equalsIgnoreCase("undefined")
				                                                || specMastersarr[2].trim()
				                                                        .equalsIgnoreCase("")
				                                                || specMastersarr[2].trim().equalsIgnoreCase(
				                                                        "NaN") || specMastersarr[2].isEmpty() ? 0
				                                                : specMastersarr[2].trim())+ "')";
				                                        specMastersdesc = stmt.executeUpdate(sql);
				                                        
				                                        //System.out.println("sql======"+sql);
				                    }
				                }

					    }
								int specdesc=0;
								
					    			// grid loading is not written below portion will not work
								for(int i=0;i< specarray.size();i++){
									String[] specarr=((String) specarray.get(i)).split("::");
									String chksql="select count(*) as psrno from my_prodattrib where MPSRNO='"+pdocno+"' " ;
								//	System.out.println("chksql-====="+chksql);
						    		ResultSet rschksql = stmt.executeQuery(chksql);
						    		int psrno=0;
						    		while (rschksql.next()) {
						    			psrno=rschksql.getInt("MPSRNO");
						    			
						    		}
									if(!((specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()))){
					                  
										if(psrno>0) {
							    			
							    			String  sql = "UPDATE my_prodattrib set "+
					                                 "MPSRNO='"+pdocno+"',MSPECNO='"+pdocno+"', "
					                                 + "spec1='"+(specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()?0:specarr[0].trim())+"', "
					                                 + "spec2='"+(specarr[1].trim().equalsIgnoreCase("undefined")  || specarr[1].trim().equalsIgnoreCase("") || specarr[1].trim().equalsIgnoreCase("NaN")|| specarr[1].isEmpty()?0:specarr[1].trim())+"', "
					                                 + "spec3='"+(specarr[2].trim().equalsIgnoreCase("undefined") || specarr[2].trim().equalsIgnoreCase("") || specarr[2].trim().equalsIgnoreCase("NaN")|| specarr[2].isEmpty()?0:specarr[2].trim())+"', " 
				                                     + " spec4='"+(specarr[3].trim().equalsIgnoreCase("undefined") || specarr[3].trim().equalsIgnoreCase("") || specarr[3].trim().equalsIgnoreCase("NaN")|| specarr[3].isEmpty()?0:specarr[3].trim())+"', "
					                                 + "barcode='"+(specarr[4].trim().equalsIgnoreCase("undefined") || specarr[4].trim().equalsIgnoreCase("") || specarr[4].trim().equalsIgnoreCase("NaN")|| specarr[4].isEmpty()?0:specarr[4].trim())+"' where mpsrno="+pdocno; 
				    
							    		//	System.out.println("my_prodattrib update--->>>>Sql"+sql);
											specdesc = stmt.executeUpdate (sql);
							    		}else {

										String sql="INSERT INTO my_prodattrib(MPSRNO,MSPECNO, spec1, spec2, spec3, spec4, barcode)VALUES"
												+ " ('"+pdocno+"','"+pdocno+"',"
												+ "'"+(specarr[0].equalsIgnoreCase("undefined") || specarr[0].equalsIgnoreCase("") || specarr[0].trim().equalsIgnoreCase("NaN")|| specarr[0].isEmpty()?0:specarr[0].trim())+"',"
												+ "'"+(specarr[1].trim().equalsIgnoreCase("undefined")  || specarr[1].trim().equalsIgnoreCase("") || specarr[1].trim().equalsIgnoreCase("NaN")|| specarr[1].isEmpty()?0:specarr[1].trim())+"',"
												+ "'"+(specarr[2].trim().equalsIgnoreCase("undefined") || specarr[2].trim().equalsIgnoreCase("") || specarr[2].trim().equalsIgnoreCase("NaN")|| specarr[2].isEmpty()?0:specarr[2].trim())+"',"
												+ "'"+(specarr[3].trim().equalsIgnoreCase("undefined") || specarr[3].trim().equalsIgnoreCase("") || specarr[3].trim().equalsIgnoreCase("NaN")|| specarr[3].isEmpty()?0:specarr[3].trim())+"',"
												+ "'"+(specarr[4].trim().equalsIgnoreCase("undefined") || specarr[4].trim().equalsIgnoreCase("") || specarr[4].trim().equalsIgnoreCase("NaN")|| specarr[4].isEmpty()?0:specarr[4].trim())+"')";


									//System.out.println("specarr--->>>>Sql"+sql);
										specdesc = stmt.executeUpdate (sql);
									}
								}
							}

					    	
					    		
					    		
								int suitdesc=0;
								
								String sqlconns="select  method from gl_prdconfig where field_nme='suit' ";
					    		//System.out.println("config-====="+sqlconns);
					    		ResultSet rsconfggs = stmt.executeQuery(sqlconns);
					    		int methodsuit=0;
					    		while (rsconfggs.next()) {
					    			methodsuit=rsconfggs.getInt("method");
					    			//System.out.println("methods=="+methodsuit);
					    		}
					    		if(methodsuit==1) {

								/*for(int i=0;i< suitarray.size();i++){
									String[] suitarr=((String) suitarray.get(i)).split("::");
									if(!((suitarr[0].equalsIgnoreCase("0"))||(suitarr[0].equalsIgnoreCase("undefined")))){


										String sql="INSERT INTO my_prodsuit(PSRNO, sbrand_id, smodel_id, syomfrm_id, syomto_id, spec1_id, spec2_id, spec3_id,submodelid)VALUES"
												+ " ('"+pdocno+"',"
												+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
												+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
												+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
												+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
												+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
												+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
												+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
												+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"')";
										
										//System.out.println("suitarr--->>>>Sql"+sql);
										suitdesc = stmt.executeUpdate (sql);
									}

								}*/
								
								for(int i=0;i< suitarray.size()-1;i++){
								//	//System.out.println("==suitarray.size()==="+suitarray.size());
									String[] suitarr=((String) suitarray.get(i)).split("::");
									if(!((suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()))){


										String sql="INSERT INTO my_prodsuit(PSRNO, vehsuitid,syomfrm_id,syomto_id,bsize1id,bsize2id,bsize3id,csize1id,csize2id,csize3id)VALUES"
												+ " ('"+pdocno+"',"
												+ "'"+(suitarr[0].equalsIgnoreCase("undefined") || suitarr[0].equalsIgnoreCase("") || suitarr[0].trim().equalsIgnoreCase("NaN")|| suitarr[0].isEmpty()?0:suitarr[0].trim())+"',"
												+ "'"+(suitarr[1].trim().equalsIgnoreCase("undefined")  || suitarr[1].trim().equalsIgnoreCase("") || suitarr[1].trim().equalsIgnoreCase("NaN")|| suitarr[1].isEmpty()?0:suitarr[1].trim())+"',"
												+ "'"+(suitarr[2].trim().equalsIgnoreCase("undefined") || suitarr[2].trim().equalsIgnoreCase("") || suitarr[2].trim().equalsIgnoreCase("NaN")|| suitarr[2].isEmpty()?0:suitarr[2].trim())+"',"
												+ "'"+(suitarr[3].trim().equalsIgnoreCase("undefined") || suitarr[3].trim().equalsIgnoreCase("") || suitarr[3].trim().equalsIgnoreCase("NaN")|| suitarr[3].isEmpty()?0:suitarr[3].trim())+"',"
												+ "'"+(suitarr[4].trim().equalsIgnoreCase("undefined") || suitarr[4].trim().equalsIgnoreCase("") || suitarr[4].trim().equalsIgnoreCase("NaN")|| suitarr[4].isEmpty()?0:suitarr[4].trim())+"',"
												+ "'"+(suitarr[5].trim().equalsIgnoreCase("undefined") || suitarr[5].trim().equalsIgnoreCase("") || suitarr[5].trim().equalsIgnoreCase("NaN")|| suitarr[5].isEmpty()?0:suitarr[5].trim())+"',"
												+ "'"+(suitarr[6].trim().equalsIgnoreCase("undefined") || suitarr[6].trim().equalsIgnoreCase("") || suitarr[6].trim().equalsIgnoreCase("NaN")|| suitarr[6].isEmpty()?0:suitarr[6].trim())+"',"
												+ "'"+(suitarr[7].trim().equalsIgnoreCase("undefined") || suitarr[7].trim().equalsIgnoreCase("") || suitarr[7].trim().equalsIgnoreCase("NaN")|| suitarr[7].isEmpty()?0:suitarr[7].trim())+"',"
												+ "'"+(suitarr[8].trim().equalsIgnoreCase("undefined") || suitarr[8].trim().equalsIgnoreCase("") || suitarr[8].trim().equalsIgnoreCase("NaN")|| suitarr[8].isEmpty()?0:suitarr[8].trim())+"')";
										
									//	//System.out.println("suitarr--->>>>Sql"+sql);
										suitdesc = stmt.executeUpdate (sql);
									}

								}
					    		}

								for(int i=0;i< altrarray.size();i++){
									String[] altrarr=((String) altrarray.get(i)).split("::");
									String tstchk2=""+(altrarr[1].equalsIgnoreCase("undefined") || altrarr[1].equalsIgnoreCase("") || altrarr[1].trim().equalsIgnoreCase("NaN")|| altrarr[1].isEmpty()?0:altrarr[1].trim())+"";
									//System.out.println("my_pralter=======docno=string=="+tstchk2);
									if(!((altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()))){
									
										if(!((tstchk2.equalsIgnoreCase("undefined") || tstchk2.equalsIgnoreCase("") || tstchk2.trim().equalsIgnoreCase("NaN")|| tstchk2.isEmpty()))){
										int chkval=Integer.parseInt(tstchk2);
										//System.out.println("my_pralter=======docno=int=="+chkval);
												
							
												if(chkval>0) {
													String tstchkval=""+(altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()?0:altrarr[0].trim())+"";
												String sqltst="update my_pralter set rdocno="+pdocno+",altpsrno='"+tstchkval+"' where doc_no="+tstchk2+"";
												suitdesc = stmt.executeUpdate (sqltst);
												}
									    }
										else
										{
											//System.out.println("my_pralter=======docno=int==in else inert");
												String sql="INSERT INTO my_pralter(rdocno, altpsrno)VALUES"
												+ " ('"+pdocno+"',"
												+ "'"+(altrarr[0].equalsIgnoreCase("undefined") || altrarr[0].equalsIgnoreCase("") || altrarr[0].trim().equalsIgnoreCase("NaN")|| altrarr[0].isEmpty()?0:altrarr[0].trim())+"')";
												
												
											
										        //System.out.println("altrarr--->>>>Sql"+sql);
										        suitdesc = stmt.executeUpdate (sql);
										        //System.out.println("altrarr--->>>>suitdesc"+suitdesc);
										}
													
												
									}
								}

							}

				        	  
				          }

			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return pdocno;
	}


	public int delete(int docno,java.sql.Date date,String pname,String pcode,String pbarcode,String ptype,String pbrand,String pcat,
			String psubcat,String unit,String dept,String mode,String dtype,ArrayList prodarray,ArrayList uomarray,ArrayList suitarray,ArrayList specarray,HttpSession session, String hsncode,HttpServletRequest request) throws SQLException{



		Connection conn=null;
		int pdocno=0,pdocno1=0;
		
		int method=0;
		conn=ClsConnection.getMyConnection();
		try{
			
			Statement stmt1=conn.createStatement();

			
			
			 Statement stmtac = conn.createStatement();
			  
			  
			    String sqlconfig = "select method from gl_config where field_nme='alintercompConfig';";

			    ResultSet rssqlconfig = stmtac.executeQuery(sqlconfig);
			    int configmethod = 0;
			    if (rssqlconfig.next()) {
			      configmethod = rssqlconfig.getInt("method");
			    }

			    if (configmethod==1) {
			    	
			    	
			    	 Statement stmtAcc = conn.createStatement();
			    	 Statement stmtAcc1 = conn.createStatement();

				      Properties prop = new Properties();
				      String filePath = request.getSession().getServletContext().getRealPath("/com/login/login.properties");
				      filePath = filePath.replace("\\", "\\\\");
				      String db = "",dbcomp="";
				      FileInputStream ip = new FileInputStream(filePath);
				      prop.load(ip);
				      String dbname = prop.getProperty("intercompdb");
				      String multicompconfig = prop.getProperty("multicompany");
				      JSONArray dbdata = new JSONArray();
				      if (multicompconfig.equals("1") || multicompconfig.equalsIgnoreCase("1")) {
				    	  int docnorow=0;
				    	  docnorow=docno;
				    	  Context initCtx = new InitialContext();
				            
				            DataSource ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/carrental");
				            
				            if (ds.getConnection() != null) {
				                java.sql.DatabaseMetaData metaData = conn.getMetaData();
				                String url = metaData.getURL();
				                
				                String comp = url.substring(url.lastIndexOf("/") + 1);
			                
				        String strsql = "select distinct dbname,compname,doc_no,compurl from " + dbname + ".my_intrcomp WHERE STATUS=3 group by  compname";
				        ResultSet rsacc = stmtAcc.executeQuery(strsql);
				        
				        while (rsacc.next()) {
				          db = rsacc.getString("dbname");
				          dbcomp = rsacc.getString("compname");

				          String sqlcode1=" select " + db + "  editdocno from  " + dbname + ".my_intrcmpdocno where "+comp+"="+docnorow;
							ResultSet rsacc11 = stmtAcc1.executeQuery(sqlcode1);
							int editdocno=0;  
							while (rsacc11.next()) {
								editdocno=rsacc11.getInt("editdocno");
								
						 }			
				          if (! (db.equalsIgnoreCase(""))) {
				        	
							 docno=editdocno;	    
			
			
			String chk=" select (sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty))) qty from " + db + ".my_prddin where prdid='"+docno+"'  group by prdid  "
			           +" having (sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty)))>0 ";
			ResultSet rs=stmt1.executeQuery(chk); 
			if(rs.next())
			{
				method=1;
			}
			
			if(method>0)
			{
				pdocno=-5;
				return  pdocno;
			}
			
			conn.setAutoCommit(false);
			
			if(ptype.equalsIgnoreCase("undefined") || ptype.equalsIgnoreCase("") || ptype.trim().equalsIgnoreCase("NaN")|| ptype.isEmpty()) ptype+=0;
            if(pbrand.equalsIgnoreCase("undefined") || pbrand.equalsIgnoreCase("") || pbrand.trim().equalsIgnoreCase("NaN")|| pbrand.isEmpty()) pbrand+=0;
            if(pcat.equalsIgnoreCase("undefined") || pcat.equalsIgnoreCase("") || pcat.trim().equalsIgnoreCase("NaN")|| pcat.isEmpty()) pcat+=0;
            if(psubcat.equalsIgnoreCase("undefined") || psubcat.equalsIgnoreCase("") || psubcat.trim().equalsIgnoreCase("NaN")|| psubcat.isEmpty()) psubcat+=0;
            if(unit.equalsIgnoreCase("undefined") || unit.equalsIgnoreCase("") || unit.trim().equalsIgnoreCase("NaN")|| unit.isEmpty()) unit+=0;
            if(dept.equalsIgnoreCase("undefined") || dept.equalsIgnoreCase("") || dept.trim().equalsIgnoreCase("NaN")|| dept.isEmpty()) dept+=0;
            if(hsncode.equalsIgnoreCase("undefined") || hsncode.equalsIgnoreCase("") || hsncode.trim().equalsIgnoreCase("NaN")|| hsncode.isEmpty()) hsncode+=0;

            
            
            
            CallableStatement stmt = conn.prepareCall("{CALL " + db + ".productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			
            //System.out.println("CALL productDML('"+date+"','"+pname+"','"+pcode+"','"+pbarcode+"','"+ptype+"','"+pbrand+"','"+pcat+"','"+psubcat+"','"+unit+"','"+dept+"','"+mode+"','"+dtype+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"')");
			
            stmt.setInt(16,docno);
			stmt.setDate(1,date);
			stmt.setString(2,pname);
			stmt.setString(3,pcode);
			stmt.setString(4, pbarcode);
			stmt.setInt(5, Integer.parseInt(ptype));
			stmt.setInt(6, Integer.parseInt(pbrand));
			stmt.setInt(7, Integer.parseInt(pcat));
			stmt.setInt(8, Integer.parseInt(psubcat));
			stmt.setInt(9, Integer.parseInt(unit));
			stmt.setInt(10, Integer.parseInt(dept));
			stmt.setString(11, mode);
			stmt.setString(12, dtype);
			stmt.setString(13, session.getAttribute("USERID").toString());
			stmt.setString(14, session.getAttribute("BRANCHID").toString());
			stmt.setInt(15, Integer.parseInt(hsncode));
			
			int val = stmt.executeUpdate();
			
			pdocno1=stmt.getInt("pdocno");
			 if(db.equalsIgnoreCase(comp)) {
          	  pdocno=pdocno1;
          	  
            } 

			 }
			} 
		 }
	}
				          }else {
				        	  
				        	  
				        	  
				        	  String chk=" select (sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty))) qty from my_prddin where prdid='"+docno+"'  group by prdid  "
							           +" having (sum(op_qty)-(sum(out_qty)+sum(rsv_qty)+sum(del_qty)))>0 ";
							ResultSet rs=stmt1.executeQuery(chk); 
							if(rs.next())
							{
								method=1;
							}
							
							if(method>0)
							{
								pdocno=-5;
								return  pdocno;
							}
							
							conn.setAutoCommit(false);
							
							if(ptype.equalsIgnoreCase("undefined") || ptype.equalsIgnoreCase("") || ptype.trim().equalsIgnoreCase("NaN")|| ptype.isEmpty()) ptype+=0;
				            if(pbrand.equalsIgnoreCase("undefined") || pbrand.equalsIgnoreCase("") || pbrand.trim().equalsIgnoreCase("NaN")|| pbrand.isEmpty()) pbrand+=0;
				            if(pcat.equalsIgnoreCase("undefined") || pcat.equalsIgnoreCase("") || pcat.trim().equalsIgnoreCase("NaN")|| pcat.isEmpty()) pcat+=0;
				            if(psubcat.equalsIgnoreCase("undefined") || psubcat.equalsIgnoreCase("") || psubcat.trim().equalsIgnoreCase("NaN")|| psubcat.isEmpty()) psubcat+=0;
				            if(unit.equalsIgnoreCase("undefined") || unit.equalsIgnoreCase("") || unit.trim().equalsIgnoreCase("NaN")|| unit.isEmpty()) unit+=0;
				            if(dept.equalsIgnoreCase("undefined") || dept.equalsIgnoreCase("") || dept.trim().equalsIgnoreCase("NaN")|| dept.isEmpty()) dept+=0;
				            if(hsncode.equalsIgnoreCase("undefined") || hsncode.equalsIgnoreCase("") || hsncode.trim().equalsIgnoreCase("NaN")|| hsncode.isEmpty()) hsncode+=0;

				            
				            
				            
				            CallableStatement stmt = conn.prepareCall("{CALL productDML(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
							
				            //System.out.println("CALL productDML('"+date+"','"+pname+"','"+pcode+"','"+pbarcode+"','"+ptype+"','"+pbrand+"','"+pcat+"','"+psubcat+"','"+unit+"','"+dept+"','"+mode+"','"+dtype+"','"+session.getAttribute("USERID").toString()+"','"+session.getAttribute("BRANCHID").toString()+"')");
							
				            stmt.setInt(16,docno);
							stmt.setDate(1,date);
							stmt.setString(2,pname);
							stmt.setString(3,pcode);
							stmt.setString(4, pbarcode);
							stmt.setInt(5, Integer.parseInt(ptype));
							stmt.setInt(6, Integer.parseInt(pbrand));
							stmt.setInt(7, Integer.parseInt(pcat));
							stmt.setInt(8, Integer.parseInt(psubcat));
							stmt.setInt(9, Integer.parseInt(unit));
							stmt.setInt(10, Integer.parseInt(dept));
							stmt.setString(11, mode);
							stmt.setString(12, dtype);
							stmt.setString(13, session.getAttribute("USERID").toString());
							stmt.setString(14, session.getAttribute("BRANCHID").toString());
							stmt.setInt(15, Integer.parseInt(hsncode));
							
							int val = stmt.executeUpdate();
							
							pdocno=stmt.getInt("pdocno");

				          }
			conn.commit();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}

		return pdocno;
	}

	public  JSONArray mainSrearch(HttpSession session,String name,String code,String brand,String cat,String subcat) throws SQLException { 

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

		String brnchid=session.getAttribute("BRANCHID").toString();
		String sqltest="";

		if(!(code.equalsIgnoreCase(""))){
			sqltest=sqltest+" and part_no like '%"+code+"%'";
		}
		if(!(name.equalsIgnoreCase(""))){
			sqltest=sqltest+" and productname like '%"+name+"%'";
		}
		if(!(brand.equalsIgnoreCase(""))){
			sqltest=sqltest+" and b.brand like '%"+brand+"%'";
		}
		if(!(cat.equalsIgnoreCase(""))){
			sqltest=sqltest+" and c.category like '%"+cat+"%' ";
		}
		if(!(subcat.equalsIgnoreCase(""))){
			sqltest=sqltest+" and s.subcategory like '%"+subcat+"%'";
		}


		Connection conn=null;  

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			String str1Sql=("select m.doc_no docno,part_no as productcode,productname ,b.brandname brand,c.category,s.subcategory "
					+ "from my_main m left join my_ptype t on(m.typeid=t.doc_no) left join "
					+ "my_brand b on(m.brandid=b.doc_no) left join my_catm c on(m.catid=c.doc_no)"
					+ " left join my_scatm s on(m.scatid=s.doc_no) left join my_unitm u "
					+ "on(m.munit=u.doc_no) left join my_dept d on(m.deptid=d.doc_no) where 1=1 " +sqltest+" and m.status=3 order by m.doc_no");

			//System.out.println("=====mainSrearch====="+str1Sql);
			ResultSet resultSet = stmt.executeQuery (str1Sql); 

			RESULTDATA=ClsCommon.convertToJSON(resultSet);
			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}
		////System.out.println(RESULTDATA);
		return RESULTDATA;
	}


	public  ClsProductBean getViewDetails(HttpSession session,int docno) throws SQLException { 


		Connection conn=null;  

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement ();
			
			int method=0;
			String sqlconf="select coalesce(method,0) method from gl_config where field_nme='hs code'";
			//System.out.println("config-====="+sqlconf);
			ResultSet rsconfg = stmt.executeQuery(sqlconf);
			
			while (rsconfg.next()) {
				method=rsconfg.getInt("method");
				//System.out.println("method=="+method);
			}
			String str1Sql="";
			if(method==1) {
		        str1Sql=("select  m.date prddate,m.desc1,coalesce(m.prdname,'') prdname,m.mtypeid,m.lbrchg,m.fixingprice ,m.stdprice, m.star,m.warranty,m.warrantydays,if(m.comp_brch='C',1,2) comp_brch, m.barcode,m.doc_no sdocno,part_no as procode,"
					+ " s.subcategory as subcat,s.doc_no as scatdocno,coalesce(h.hs_code,'') as hsncode,h.doc_no as hsndocno,c.category as catm,c.doc_no as catdocno,u.unit,u.doc_no as udocno,productname sname,b.brandname sbrand,b.doc_no as bdocno,t.producttype as stype,t.doc_no as tdocno,d.department sdept,d.doc_no as dedocno "
					+ "from my_main m left join my_ptype t on(m.typeid=t.doc_no) left join "
					+ "my_brand b on(m.brandid=b.doc_no) left join my_catm c on(m.catid=c.doc_no)"+" left join my_hsncode h on(m.hsn_code=h.doc_no)"
					+ " left join my_scatm s on(m.scatid=s.doc_no) left join my_unitm u "
					+ "on(m.munit=u.doc_no) left join my_dept d on(m.deptid=d.doc_no)  where m.doc_No="+docno+" order by m.doc_no");
			}else {
				  str1Sql=("select  m.date prddate,m.desc1,coalesce(m.prdname,'') prdname,m.mtypeid,m.lbrchg,m.fixingprice ,m.stdprice, m.star,m.warranty,m.warrantydays,if(m.comp_brch='C',1,2) comp_brch, m.barcode,m.doc_no sdocno,part_no as procode,"
							+ " s.subcategory as subcat,s.doc_no as scatdocno,c.category as catm,c.doc_no as catdocno,u.unit,u.doc_no as udocno,productname sname,b.brandname sbrand,b.doc_no as bdocno,t.producttype as stype,t.doc_no as tdocno,d.department sdept,d.doc_no as dedocno "
							+ "from my_main m left join my_ptype t on(m.typeid=t.doc_no) left join "
							+ "my_brand b on(m.brandid=b.doc_no) left join my_catm c on(m.catid=c.doc_no)"
							+ " left join my_scatm s on(m.scatid=s.doc_no) left join my_unitm u "
							+ "on(m.munit=u.doc_no) left join my_dept d on(m.deptid=d.doc_no)  where m.doc_No="+docno+" order by m.doc_no");
				
			}
		
			//System.out.println("=====getViewDetails====="+str1Sql);
			ResultSet rs = stmt.executeQuery (str1Sql); 

			while(rs.next()){
				
			 Double stdcost=0.00;
			 Double fixcost=0.00;
			 Double lbrcost=0.00;
			  
 
			 
			 stdcost=rs.getDouble("stdprice") ;
			 fixcost=rs.getDouble("fixingprice") ;
			 lbrcost=rs.getDouble("lbrchg") ;
			  DecimalFormat f = new DecimalFormat("##.00");
			 //System.out.println("=====stdcost====="+stdcost);
			 if(stdcost>0)
			 {
				 proact.setStdcostname("Standard Cost :");
				 
				 
 				 
				proact.setStdcostprice(f.format(stdcost)+""); 
				// proact.setStdcostprice(stdcost+""); 
				  
				 
				  
			 }
			 if(fixcost>0)
			 {
				 proact.setFixname("Selling Price :");
				proact.setFixprices(f.format(fixcost)+""); 
				// proact.setFixprices(fixcost+""); 
			 }

			 if(lbrcost>0)
			 {
				 proact.setLbrcostname("Labour Charge :");
			   proact.setLbrcosts(f.format(lbrcost)+""); 
				 
				 
				 //proact.setLbrcosts(lbrcost+""); 
			 }

			 proact.setDate(rs.getString("prddate"));
			 proact.setDesc1(rs.getString("desc1"));
		 
			 proact.setTxtarbicprdname(rs.getString("prdname"));
			 
			    proact.setWarranty(rs.getString("warranty"));
			    proact.setWarrantydays(rs.getInt("warrantydays"));
				proact.setCmbmastertype(rs.getInt("mtypeid"));
				proact.setCmbstar(rs.getInt("star"));
				proact.setTxtproducttype(rs.getString("stype"));
				proact.setCmbproducttype(rs.getString("tdocno"));
				proact.setTxtbrand(rs.getString("sbrand"));
				proact.setCmbbrand(rs.getString("bdocno"));
				proact.setTxtproductname(rs.getString("sname"));
				proact.setTxtproductcode(rs.getString("procode"));
				proact.setTxtunit(rs.getString("unit"));
				proact.setCmbunit(rs.getString("udocno"));
				proact.setTxtbarcode(rs.getString("barcode"));
				proact.setTextdept(rs.getString("sdept"));
				proact.setCmbdept(rs.getString("dedocno"));
				proact.setTxtcategory(rs.getString("catm"));
				proact.setCmbcategory(rs.getString("catdocno"));
				proact.setTxtsubcategory(rs.getString("subcat"));
				proact.setCmbsubcategory(rs.getString("scatdocno"));
				
				
				proact.setComorbranch(rs.getInt("comp_brch"));
				if(method==1) {
					proact.setCmbhsn(rs.getString("hsndocno"));
					proact.setTxthsn(rs.getString("hsncode"));
					
				}else {
					proact.setCmbhsn("");
					proact.setTxthsn("");
				}
				
				
				
			}

			stmt.close();
			conn.close();
		}
		catch(Exception e){
			e.printStackTrace();
			conn.close();
		}

		return proact;
	}
	
	
	public JSONArray suitSearch(HttpSession session,String yomfrm,String yomto,String suitid,String chkbed,String chkbed2,String chkbed3,
			String chkcab,String chkcab2,String chkcab3,String rba,String rbb,String rca,String rcb,String typeid) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;
		String sql="",sqlbed="",sqlcab="",sqlappnd="";
		try {
			
/*			
			//System.out.println("======rba======"+rba);
			//System.out.println("======rbb======"+rbb);
			//System.out.println("======rca======"+rca);
			//System.out.println("======rcb======"+rcb);
			*/
			////System.out.println("suitid=="+suitid+"==chkbed==="+chkbed+"==chkcab=="+chkcab+"==rba==="+rba+"==rbb==="+rbb+"===rca=="+rca+"==rcb==="+rcb+"===typeid=="+typeid);
			
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

			if(typeid.equalsIgnoreCase("0")){
				sql="select s.doc_no,s.yom_frm yomfrm,s.yom_to yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
						+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
						+ "s.sbrandid brandid,s.smodelid modelid,s.submodelid submodelid,if(s.esizeid='-2',0,s.esizeid)  esizeid, "
						+ " if(s.bsize1id='-2',0,s.bsize1id)  bsize1id, if(s.bsize2id='-2',0,s.bsize2id) bsize2id, if(s.bsize3id='-2',0,s.bsize3id) bsize3id,"
						+ "  if(s.csize1id='-2',0,s.csize1id) csize1id,if(s.csize2id='-2',0,s.csize2id) csize2id,if(s.csize3id='-2',0,s.csize3id) csize3id, "
						+ "if(s.yom_frmid='-2',0,s.yom_frmid) yomfrmid,if(s.yom_toid='-2',0,s.yom_toid)  yomtoid  "
						+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
						+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)" //and sm.modelid=s.smodelid
						+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
						+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
						+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
						+ "where s.status=3 ";
			//	//System.out.println("===1sql====="+sql);
			}
			
			else if(typeid.equalsIgnoreCase("1")){
				
				if(chkbed.equalsIgnoreCase("1")){
					
					if(rba.equalsIgnoreCase("1")){
						sqlbed=" and s.bsize1id=-1 and s.bsize2id=-1 and s.bsize3id=-1";
					}
					if(rbb.equalsIgnoreCase("1")){
						sqlbed=" and s.bsize1id=0 and s.bsize2id=0 and s.bsize3id=0";
					}
				}
				
				else if(chkcab.equalsIgnoreCase("1")){
					
					if(rca.equalsIgnoreCase("1")){
						sqlcab=" and s.csize1id=-1 and s.csize2id=-1 and s.csize3id=-1";
					}
					if(rcb.equalsIgnoreCase("1")){
						sqlcab=" and s.csize1id=0 and s.csize2id=0 and s.csize3id=0";
					}
				}
				
				/*sqlappnd=" and s.doc_no in("+suitid+") "+sqlbed+" "+sqlcab+"";*/
				sqlappnd=" and s.doc_no in("+suitid+")";
				
				sql="select s.doc_no,s.yom_frm yomfrm,s.yom_to yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
						+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
						+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
						+ "(case when "+chkbed.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s11.spec,'') end) as bsize1,"
						+ "(case when "+chkbed2.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s12.spec,'') end) as bsize2,"
						+ "(case when "+chkbed3.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s13.spec,'') end) as bsize3,"
						+ "(case when "+chkcab.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s31.spec,'') end) as csize1,"
						+ "(case when "+chkcab2.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s32.spec,'') end) as csize2,"
						+ "(case when "+chkcab3.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then 'ALL' else '' end) else coalesce(s33.spec,'') end) as csize3,"
						+ "s.sbrandid brandid,s.smodelid modelid,s.submodelid submodelid,s.esizeid, "
						+ "(case when "+chkbed.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s11.doc_no,0) end) as bsize1id,"
						+ "(case when "+chkbed2.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s12.doc_no,0) end) as bsize2id,"
						+ "(case when "+chkbed3.equalsIgnoreCase("1")+" then (case when "+rba.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s13.doc_no,0) end) as bsize3id,"
						+ "(case when "+chkcab.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then  -1 else 0 end) else coalesce(s31.doc_no,0) end) as csize1id,"
						+ "(case when "+chkcab2.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s32.doc_no,0) end) as csize2id,"
						+ "(case when "+chkcab3.equalsIgnoreCase("1")+" then (case when "+rca.equalsIgnoreCase("1")+" then -1 else 0 end) else coalesce(s33.doc_no,0) end) as csize3id,"
						+ "s.yom_frmid yomfrmid,s.yom_toid yomtoid  "
						+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
						+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)" //and sm.modelid=s.smodelid
						+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
						+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
						+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
						+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
						+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
						+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
						+ "where s.status=3 "+sqlappnd+" ";
				
				
				////System.out.println("===2sql====="+sql);
				
			}
			
	 

	/*and date_format(str_to_date(s.yom_frm,'%Y'),'%Y')>="+yomfrm+" and date_format(str_to_date(yom_to,'%Y'),'%Y')<="+yomto+"*/
	
		//	//System.out.println("=sql==suitSearch="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}
	
	
	public JSONArray suitSearchLoad(HttpSession session,String doc_no) throws SQLException {


		JSONArray RESULTDATA=new JSONArray();

		Connection conn = null;

		try {
			conn = ClsConnection.getMyConnection();
			Statement stmt = conn.createStatement();

	String sql="select s.doc_no,s.yom_frm yomfrm,s.yom_to yomto,s.doc_no,brand,(case when s.smodelid=-1 then 'ALL' else model end) as model,"
				+ "(case when s.submodelid=-1 then 'ALL' else submodel end) as submodel,"
				+ "(case when s.esizeid=-1 then 'ALL' else coalesce(s2.spec,'') end) as esize,"
				+ "(case when s.bsize1id=-1 then 'ALL' else coalesce(s11.spec,'') end) as bsize1,"
				+ "(case when s.bsize2id=-1 then 'ALL' else coalesce(s12.spec,'') end) as bsize2,"
				+ "(case when s.bsize3id=-1 then 'ALL' else coalesce(s13.spec,'') end) as bsize3,"
				+ "(case when s.csize1id=-1 then 'ALL' else coalesce(s31.spec,'') end) as csize1,"
				+ "(case when s.csize2id=-1 then 'ALL' else coalesce(s32.spec,'') end) as csize2,"
				+ "(case when s.csize3id=-1 then 'ALL' else coalesce(s33.spec,'') end) as csize3,"
				+ "s.sbrandid brandid,s.smodelid modelid,s.submodelid submodelid,s.esizeid,s.bsize1id,s.bsize2id,s.bsize3id,"
				+ "s.csize1id,s.csize2id,s.csize3id,s.yom_frmid yomfrmid,s.yom_toid yomtoid  "
				+ "from my_vehsuitmaster s left join my_sbrand b on(b.doc_no=s.sbrandid) left join my_smodel m on(m.doc_no=s.smodelid)"
				+ "left join my_ssubmodel sm on(sm.doc_No=s.submodelid and sm.modelid=s.smodelid) left join my_suitspec2 s2 on(s2.doc_no=s.esizeid)" // and sm.modelid=s.smodelid
				+ "left join my_suitspec1 s11 on(s11.doc_no=s.bsize1id)"
				+ "left join my_suitspec1 s12 on(s12.doc_no=s.bsize2id)"
				+ "left join my_suitspec1 s13 on(s13.doc_no=s.bsize3id)"
				+ "left join my_suitspec3 s31 on(s31.doc_no=s.csize1id)"
				+ "left join my_suitspec3 s32 on(s32.doc_no=s.csize2id)"
				+ "left join my_suitspec3 s33 on(s33.doc_no=s.csize3id)"
				+ "where s.status=3 and s.doc_no in ("+doc_no+")";

			
		//	//System.out.println("=sql==suitSearch="+sql);
			
			ResultSet resultSet = stmt.executeQuery(sql);
			RESULTDATA=ClsCommon.convertToJSON(resultSet);


		}catch(Exception e){
			e.printStackTrace();

		}finally{
			conn.close();
		}
		return RESULTDATA;
	}

	public JSONArray specMastersGridLoad(HttpSession session, String docno, String deptid, String id)
            throws SQLException {

	    //System.out.println("DEPTID====="+deptid);
        JSONArray RESULTDATA = new JSONArray();
        if(!id.equalsIgnoreCase("1")) {
            //System.out.println("ENtered EXIT");
            return RESULTDATA;
        }
        //System.out.println("DEPTID2====="+deptid);

        Connection conn = null;
        if(docno.equalsIgnoreCase("")) {
            docno="0";
        }
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String sql ="";
            ResultSet resultSet = null;
            int method=0;
        	String sqlcon="select coalesce(method,0) method from gl_config where field_nme='classification grid'";
    		//System.out.println("config-====="+sqlcon);
    		ResultSet rsconfg = stmt.executeQuery(sqlcon);
    		
    		while (rsconfg.next()) {
             method=rsconfg.getInt("method");
    			//System.out.println("method=="+method);
    		}
    		if(method==1) {
            if(Integer.parseInt(docno)>0) {
            	
            	
        		
                sql = "select * from my_prodspecp where psrno='"+docno+"'";
                //System.out.println("THIS IS TEST SQL "+sql);
                ResultSet test =stmt.executeQuery(sql);
                if(test.next()) { 
                                       
//                    sql = "SELECT sdoc_no, NAME, IF(description IN(SELECT m.description FROM my_prodclassificationmaster m INNER JOIN my_deptlink d ON m.doc_no = d.classid " + 
//                            " INNER JOIN my_prodclassificationsetup s ON(m.csdoc_no=s.doc_no) WHERE d.status<>7 AND d.deptid='"+deptid+"' " + 
//                            ") , description ,'') description FROM my_prodspecp WHERE psrno='"+docno+"' AND sdoc_no IN  " + 
//                            "(SELECT s.doc_no FROM my_prodclassificationmaster m INNER JOIN my_deptlink d ON m.doc_no = d.classid " + 
//                            "INNER JOIN my_prodclassificationsetup s ON (m.csdoc_no=s.doc_no) WHERE d.status<>7 AND d.deptid='"+deptid+"' GROUP BY s.`doc_no`) " + 
//                            "UNION " + 
//                            "SELECT * FROM (SELECT s.doc_no,s.name,'' description FROM my_prodclassificationmaster m INNER JOIN my_deptlink d ON m.doc_no = d.classid " + 
//                            "INNER JOIN my_prodclassificationsetup s ON (m.csdoc_no=s.doc_no) WHERE d.status<>7 AND d.deptid='"+deptid+"') p WHERE doc_no NOT IN (SELECT sdoc_no FROM my_prodspecp WHERE psrno='"+docno+"')";
                    
                    sql = "SELECT s.doc_no sdoc_no,s.name, COALESCE(ps.description,'') description  FROM my_prodclassificationmaster m INNER JOIN my_deptlink d ON m.doc_no = d.classid" + 
                            " INNER JOIN my_prodclassificationsetup s ON (m.csdoc_no=s.doc_no) LEFT JOIN my_prodspecp ps ON ps.sdoc_no=s.doc_no AND ps.psrno='"+docno+"' WHERE d.status<>7 AND  s.status<>7 AND d.deptid='"+deptid+"' GROUP BY s.doc_no;";
               
                } else { 
                    
                    sql ="SELECT s.doc_no sdoc_no,s.name name FROM my_prodclassificationsetup s" + 
                            " JOIN my_prodclassificationmaster m ON s.doc_no = m.csdoc_no" + 
                            " JOIN my_deptlink d ON d.classid = m.doc_no JOIN my_dept t ON d.deptid = t.doc_no" + 
                            " WHERE d.status<>7 and s.status<>7 and d.deptid ='"+deptid+"' GROUP BY s.doc_no"; 
                    }
                    if(!stmt.execute(sql)) {
                        sql ="SELECT s.doc_no sdoc_no,s.name name FROM my_prodclassificationsetup s" + 
                                " JOIN my_prodclassificationmaster m ON s.doc_no = m.csdoc_no" + 
                                " JOIN my_deptlink d ON d.classid = m.doc_no JOIN my_dept t ON d.deptid = t.doc_no" + 
                                " WHERE d.status<>7 and s.status<>7 and d.deptid ='"+deptid+"' GROUP BY s.doc_no"; 
                }
            resultSet = stmt.executeQuery(sql);
            //System.out.println("Sql query specMastersgridLoad"+sql);
            } else {
         
                // Loads when adding 
                sql ="SELECT s.doc_no sdoc_no,s.name name FROM my_prodclassificationsetup s" + 
                        " JOIN my_prodclassificationmaster m ON s.doc_no = m.csdoc_no" + 
                        " JOIN my_deptlink d ON d.classid = m.doc_no JOIN my_dept t ON d.deptid = t.doc_no" + 
                        " WHERE d.status<>7 and s.status<>7 and d.deptid ='"+deptid+"' GROUP BY s.doc_no"; 
                //System.out.println(sql);
                resultSet = stmt.executeQuery(sql);
            }
    		}else {
    			return  RESULTDATA;
    		}
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }
	
	public JSONArray specMastersGridLoadDetachDept(HttpSession session, String docno, String deptid,String id)
            throws SQLException {

        JSONArray RESULTDATA = new JSONArray();
        
        if(!id.equalsIgnoreCase("1")) {
            return RESULTDATA;
        }
        
        Connection conn = null;
        if(docno.equalsIgnoreCase("")) {
            docno="0";
        }
        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String sql ="";
            ResultSet resultSet = null;
        	int method=0;
        	String sqlcon="select coalesce(method,0) method from gl_config where field_nme='classification grid'";
    		//System.out.println("config-====="+sqlcon);
    		ResultSet rsconfg = stmt.executeQuery(sqlcon);
    		
    		while (rsconfg.next()) {
             method=rsconfg.getInt("method");
    			//System.out.println("method=="+method);
    		}
    		
    		if(method==1) {
            if(Integer.parseInt(docno)>0) {
            	
            
                sql = "select * from my_prodspecp where psrno='"+docno+"'";
                //System.out.println("THIS IS TEST SQL "+sql);
                ResultSet test =stmt.executeQuery(sql);
                if(test.next()) { 

                    sql = "SELECT s.doc_no sdoc_no,s.name, COALESCE(ps.description,'') description  FROM my_prodclassificationmaster m INNER JOIN my_prodclassificationsetup s ON (m.csdoc_no=s.doc_no) LEFT JOIN my_prodspecp ps ON ps.sdoc_no=s.doc_no AND ps.psrno="+docno+" WHERE s.status<>7 GROUP BY s.doc_no";
               
                } else { 
                    
                    sql ="SELECT s.doc_no sdoc_no,s.name name FROM my_prodclassificationsetup s" + 
                            " JOIN my_prodclassificationmaster m ON s.doc_no = m.csdoc_no" + 
                            " " + 
                            " WHERE s.status<>7  GROUP BY s.doc_no"; 
                    }
                    if(!stmt.execute(sql)) {
                        sql ="SELECT s.doc_no sdoc_no,s.name name FROM my_prodclassificationsetup s" + 
                                " JOIN my_prodclassificationmaster m ON s.doc_no = m.csdoc_no" + 
                                " " + 
                                " WHERE s.status<>7 GROUP BY s.doc_no"; 
                }
            resultSet = stmt.executeQuery(sql);
            //System.out.println("Sql query specMastersgridLoad"+sql);
            } else {
                // Loads when adding 
                sql ="SELECT s.doc_no sdoc_no,s.name NAME FROM my_prodclassificationsetup s JOIN my_prodclassificationmaster m ON s.doc_no = m.csdoc_no WHERE s.status<>7 GROUP BY s.doc_no"; 
                //System.out.println(sql);
                resultSet = stmt.executeQuery(sql);
            }
            }else {
            	return RESULTDATA;
            }
            
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }
    
    public JSONArray specMastersSearch(HttpSession session, String sdocno, String deptid) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();
        //System.out.println("DEPTID"+deptid);
        //System.out.println("sdocno"+sdocno);
        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String sql = "select s.name,m.description from my_prodclassificationmaster m inner join my_deptlink d on m.doc_no = d.classid inner join my_prodclassificationsetup s on(m.csdoc_no=s.doc_no) where d.status<>7 and s.doc_no='"+sdocno+"' and d.deptid='"+deptid+"'";
            ResultSet resultSet = stmt.executeQuery(sql);
            //System.out.println(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            
            //System.out.println("SEARCH DATA  ------"+RESULTDATA);
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }
    
    
    public JSONArray specMastersSearchDetachDept(HttpSession session, String sdocno, String deptid) throws SQLException {

        JSONArray RESULTDATA = new JSONArray();
        //System.out.println("DEPTID"+deptid);
        //System.out.println("sdocno"+sdocno);
        Connection conn = null;

        try {
            conn = ClsConnection.getMyConnection();
            Statement stmt = conn.createStatement();
            String sql = "select s.name,m.description from my_prodclassificationmaster m inner join my_prodclassificationsetup s on(m.csdoc_no=s.doc_no) where s.status=3 and m.status=3 and s.doc_no='"+sdocno+"'";
            ResultSet resultSet = stmt.executeQuery(sql);
            //System.out.println(sql);
            RESULTDATA = ClsCommon.convertToJSON(resultSet);
            
            //System.out.println("SEARCH DATA DETACHS ------"+RESULTDATA);
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            conn.close();
        }
        return RESULTDATA;
    }


}