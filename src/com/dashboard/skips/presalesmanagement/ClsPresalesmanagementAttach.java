package com.dashboard.skips.presalesmanagement;


import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileOutputStream;  
  
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;  

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;  
  
@SuppressWarnings("serial")  
public class ClsPresalesmanagementAttach extends ActionSupport {

	ClsCommon objcommon=new ClsCommon();
	ClsConnection objconn=new ClsConnection();
	private File file;  
    private String fileFileName;  
    private String fileFileContentType;  
    private String formdetailcode;
    
    
    public String getFormdetailcode() {
		return formdetailcode;
	}

	public void setFormdetailcode(String formdetailcode) {
		this.formdetailcode = formdetailcode;
	}

	private String message = "";  
      
    public String getMessage() {  
        return message;  
    }  
  
    public void setMessage(String message) {  
        this.message = message;  
    }  
  
    public File getFile() {  
        return file;  
    }  
  
    public void setFile(File file) {  
        this.file = file;  
    }  
  
    public String getFileFileName() {  
        return fileFileName;  
    }  
  
    public void setFileFileName(String fileFileName) {  
        this.fileFileName = fileFileName;  
    }  
  
    public String getFileFileContentType() {  
        return fileFileContentType;  
    }  
  
    public void setFileFileContentType(String fileFileContentType) {  
        this.fileFileContentType = fileFileContentType;  
    }  
  
    @SuppressWarnings("deprecation")  
    @Override  
    public String execute() throws Exception { 
    	System.out.println(" ======ATTACH ACTION====== ");
    	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
//		System.out.println(" = =========== "+requestParams);
		//session.getAttribute("Code")==null?"Default":session.getAttribute("Code").toString();
    	String code = request.getParameter("formdetailcode")==null?"":request.getParameter("formdetailcode").toString();
    	String doc = request.getParameter("doc")==null || request.getParameter("doc").trim().equals("")?"0":request.getParameter("doc").toString();
    	String srno = request.getParameter("srno")==null || request.getParameter("srno").trim().equals("")?"0":request.getParameter("srno").toString();
    	int cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").trim().equals("")?0:Integer.parseInt(request.getParameter("cldocno").trim().toString());
    	int qotno=request.getParameter("quotno")==null || request.getParameter("quotno").trim().equals("")?0:Integer.parseInt(request.getParameter("quotno").trim().toString());
    	int qottrno=request.getParameter("qottrno")==null || request.getParameter("qottrno").trim().equals("")?0:Integer.parseInt(request.getParameter("qottrno").trim().toString());
    	int brhid = request.getParameter("brhid")==null || request.getParameter("brhid").trim().equals("")?0:Integer.parseInt(request.getParameter("brhid").trim().toString());
    	String attachdesc = request.getParameter("attachdesc")==null?"":request.getParameter("attachdesc").toString();
    	String fname = code+'-'+doc+'-'+srno;  
    	String fname2 = fname;
//    	System.out.println("CODE==="+code);
	//	System.out.println("Code"+getFormdetailcode());
		String dirname =getFormdetailcode()==null?"Default":getFormdetailcode();
//    	System.out.println(dirname);
    	String path ="";
    	Connection conn = objconn.getMyConnection();
		Statement stmt = conn.createStatement ();
		String strSql = "select imgPath from my_comp where doc_no="+session.getAttribute("COMPANYID");
//		System.out.println(strSql);    
		ResultSet rs = stmt.executeQuery(strSql);
		String path1="";
		while(rs.next ()) {
			path1=rs.getString("imgPath");
//			System.out.println("IMGPATH:"+path);
		}
		path=path1.replace("\\", "/");
		
		String strSql2 = "select cldocno from sk_srvqotm where tr_no='"+qottrno+"'";
		ResultSet rs5 = stmt.executeQuery(strSql2);
		while(rs5.next ()) {
			cldocno=rs5.getInt("cldocno");
		}
		
		//System.out.println(" = =====IN EXECUTE======1 ");
    	//ServletContext context = ((HttpSession) request).getServletContext();
    	
    	//ServletContext context = request.getServletContext();    
    	//String path = context.getRealPath("/");
    	//System.out.println(" = =====IN EXECUTE======2 ");
    	File dir = new File(path+ "/attachment/"+dirname);
   	 	dir.mkdirs();
   	 	
        //
   	 	
//        System.out.println("path==============="+path);
        try {  
            conn.setAutoCommit(false);
            File f = this.getFile();  
           // System.out.println("FILE==="+getFileFileName());
            if(this.getFileFileName().endsWith(".exe")){  
                message="not done";  
                return ERROR;  
            } 
          /*  String aa[]=getFileFileName().split(".");
//            System.out.println(aa);*/
            int dotindex=getFileFileName().lastIndexOf(".");
            String efile=getFileFileName().substring(dotindex+1);
//            System.out.println("EEEE"+efile);
            fname=fname+'.'+efile;
            FileInputStream inputStream = new FileInputStream(f);  
            
            FileOutputStream outputStream = new FileOutputStream(path + "/attachment/"+dirname+ "/"+ fname);
          // System.out.println("path==============="+path+"========="+outputStream);
            byte[] buf = new byte[1024];  
            int length = 0,val=0;  
            while ((length = inputStream.read(buf)) != -1) {  
                outputStream.write(buf, 0, length);  
            }  
            Statement stmtupdate=conn.createStatement();
            int checkcrm = 0;
            String path2="", filename2="";  
            if(cldocno!=0) {
            	String sql1="select if(upper(replace(descpt,' ',''))=upper('"+attachdesc+"'),1,0) desc1 ,path,filename from my_fileattach where dtype='crm' and doc_no='"+cldocno+"' order by rowno desc limit 1";   
                //System.out.println("sql7--->>>"+sql1);     
    			 ResultSet rs3 = stmt.executeQuery(sql1);  
    			 while(rs3.next()){
    				  checkcrm = rs3.getInt("desc1");
    				  path2 = rs3.getString("path");
    				  filename2 =rs3.getString("filename");
    			 }
            }
            if(checkcrm==1) {
            	 String strupdate="update sk_checklistdet set attach='"+filename2+"',path='"+path2+"' where rowno="+srno ; 
                 //System.out.println("E9===="+strupdate);
                 val=stmtupdate.executeUpdate(strupdate);
            }else {
            	 String strupdate="update sk_checklistdet set attach='"+fname+"',path='"+path + "/attachment/"+dirname+ "/"+ fname+"' where rowno="+srno ; 
                 //System.out.println("E9===="+strupdate);
                 val=stmtupdate.executeUpdate(strupdate);
            }
            int fileVal=0;
            //System.out.println("CL DOCNO :"+qotno+"Before else :"+val);

            if(val<=0){
                //System.out.println("On else :"+val);
            	return ERROR;
            }else {
            	 String strenq="select sum(if(d.attach!='',0,1)) chlist from sk_checklist s left join sk_checklistdet d on d.checksrno=s.srno and d.qotno='"+qottrno+"' where s.mandatory=1";   
				 //System.out.println("strenq--->>>"+strenq);     
				 ResultSet rs1 = stmt.executeQuery(strenq);  
				 while(rs1.next()){
					 int tempval = rs1.getInt("chlist");
					 if(tempval == 0){
						 String upsql1="update gl_enqm set presalesstatus=3,returned=0 where doc_no='"+doc+"'";              
						 //System.out.println("upsql1--->>>"+upsql1);   
						 val = stmtupdate.executeUpdate(upsql1);    
					 }    
				 }
            	
            	
            	 if(qotno>0 || cldocno>0) {
            		 if(brhid==0) {
            			 brhid = Integer.parseInt(session.getAttribute("BRANCHID").toString());   
            		 }
                     //System.out.println("Val :"+val);

            		 int filesrno = 1; 
            		 
            		 System.out.println(attachdesc+"==<>=="+cldocno);   
            		 
            		 if((attachdesc.equalsIgnoreCase("Trade License")||attachdesc.equalsIgnoreCase("ID Proof")||attachdesc.equalsIgnoreCase("Vat Certificate")) && cldocno>0) {
            			 String selsql = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no='"+cldocno+"' and dtype='CRM'";
                		 ResultSet rs2 = stmtupdate.executeQuery(selsql);  
                		 if(rs2.next()) {
                			 filesrno = rs2.getInt("srno");
                		 }
                		 
                		 String strinsert="insert into my_fileattach(dtype,doc_no,brhid,sr_no,date,user,path, filename, descpt, ref_id)values('CRM',"+cldocno+",'"+brhid+"',"+
    			                   " "+filesrno+",CURDATE(),'"+session.getAttribute("USERID").toString()+"','"+path + "/attachment/"+dirname+ "/"+ fname+"','"+fname2+"','"+attachdesc+"',2)";
    					 //System.out.println("Insert Attach"+strinsert);   
                		 fileVal = stmtupdate.executeUpdate(strinsert);  
                		 //System.out.println("file Val :"+fileVal);
                		 if(fileVal<=0) {
                             return ERROR;

                		 }
            		 }else {
            			 String selsql = "select coalesce(max(sr_no)+1,1) srno from my_fileattach where doc_no='"+qotno+"' and dtype='QOT'";
                		 ResultSet rs2 = stmtupdate.executeQuery(selsql);  
                		 if(rs2.next()) {
                			 filesrno = rs2.getInt("srno");
                		 }
                		 
                		 String strinsert="insert into my_fileattach(dtype,doc_no,brhid,sr_no,date,user,path, filename, descpt, ref_id)values('QOT',"+qotno+",'"+brhid+"',"+
    			                   " "+filesrno+",CURDATE(),'"+session.getAttribute("USERID").toString()+"','"+path + "/attachment/"+dirname+ "/"+ fname+"','"+fname2+"','"+attachdesc+"',2)";
    					 //System.out.println("Insert Attach"+strinsert);   
                		 fileVal = stmtupdate.executeUpdate(strinsert);  
                		 //System.out.println("file Val :"+fileVal);
                		 if(fileVal<=0) {
                             return ERROR;

                		 }
            		 }
            	 }
            }
            if(val>0 && fileVal >0) {
                conn.commit();
            }
            inputStream.close();  
            outputStream.flush();  
            this.setMessage(path+fname);
            stmt.close();
            stmtupdate.close();
            conn.close();
        } catch (Exception e) {  
            e.printStackTrace();  
            message = "!!!!";
            conn.close();
        }  
        finally{
        	conn.close();
        }
        return SUCCESS;  
    }  
}
