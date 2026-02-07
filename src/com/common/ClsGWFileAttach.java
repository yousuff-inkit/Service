package com.common;


import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileOutputStream;  
  
import java.net.InetAddress;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;  

import com.connection.ClsConnection;
import com.opensymphony.xwork2.ActionSupport;  
  
@SuppressWarnings("serial")  
public class ClsGWFileAttach extends ActionSupport {
	ClsConnection ClsConnection=new ClsConnection();
	
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
    	HttpServletRequest request=ServletActionContext.getRequest();
		HttpSession session=request.getSession();
		Map<String, String[]> requestParams = request.getParameterMap();
    	String destfilename=request.getParameter("destfilename");
    	String srno="";
    	Connection conn = ClsConnection.getMyConnection();
		Statement stmt = conn.createStatement();
		String code="GW";
		
    	String fname=destfilename;
    	String fname2=fname;

    	String path ="";
		Statement stmt1 = conn.createStatement();
		String strSql1 = "select imgPath from my_comp";

		ResultSet rs1 = stmt1.executeQuery(strSql1);
		while(rs1.next ()) {
			path=rs1.getString("imgPath");
		}
		
		// ServletContext context = request.getServletContext();
/*    	File dir = new File(path+ "/attachment/"+dirname);
   	 	dir.mkdirs();
*/
   	 	try {  
            File deletesourcefile=new File((path+"/icons/"+destfilename).replaceAll("//","////"));
            //deletesourcefile.setExecutable(true);
            deletesourcefile.delete();
   	 		File f = this.getFile();  
            if(this.getFileFileName().endsWith(".exe")){  
                message="not done";  
                return ERROR;  
            } 
            
            int dotindex=getFileFileName().lastIndexOf(".");
            String efile=getFileFileName().substring(dotindex+1);
            //fname=fname+'.'+efile;

            FileInputStream inputStream = new FileInputStream(f);  
            FileOutputStream outputStream = new FileOutputStream((path+"/icons/"+destfilename).replaceAll("//","////"));
            byte[] buf = new byte[3072];  
            int length = 0;  
            
            while ((length = inputStream.read(buf)) != -1) {
                outputStream.write(buf, 0, length);  
            }  
			
            inputStream.close();  
            outputStream.flush();
            //File newfile=new File((path+"/WebContent/icons/"+destfilename).replaceAll("//","////"));
            /*File source=new File((path +"/attachment/"+dirname+"/"+ fname).replace("//","////"));
            File dest=new File((path+"/WebContent/icons/"+destfilename).replaceAll("//","////"));
            Files.move(source.toPath(), dest.toPath(), StandardCopyOption.REPLACE_EXISTING);
            */
            this.setMessage(path+fname);
            stmt.close();
            conn.close();
        
        } catch (Exception e) {  
            e.printStackTrace();  
            message = "!!!!";
            conn.close();
            
        }  
        return SUCCESS;  
    }
    
    public  JSONArray reGridload(String docno,String dtype) throws SQLException {
        JSONArray RESULTDATA=new JSONArray();
        ClsCommon clcom=new ClsCommon();
		     try {
		       Connection conn = ClsConnection.getMyConnection();
		       Statement cpstmt = conn.createStatement();
		        String  cpsql="select sr_no,a.dtype extension,descpt description,filename,replace(path,'\\\\',';') path,coalesce(at.type_name,'') as type from my_fileattach a left join my_attach_type at on(at.doc_no=ref_id) where a.status=3 and a.doc_no="+docno+" and a.dtype='"+dtype+"' order by sr_no";
		       
		       
		       //System.out.println("====cpsql===="+cpsql);
		       
		       ResultSet resultSet = cpstmt.executeQuery(cpsql);
		       RESULTDATA=clcom.convertToJSON(resultSet);
		       cpstmt.close();
		       conn.close();
		     }
		     catch(Exception e){
		      e.printStackTrace();
		     }
           return RESULTDATA;
       }
    
    public  JSONObject reload(String docno) throws SQLException {
        JSONObject obj = new JSONObject();
        String data="";
		     try {
		    	 Connection conn = ClsConnection.getMyConnection();
		       Statement cpstmt = conn.createStatement();
		       String  cpsql="select sr_no,dtype extension,descpt description,filename,replace(path,'\\\\',';') path from my_fileattach where status = 3 and doc_no="+docno+" order by sr_no desc limit 1 ";
		       
//		       Thread.sleep(10000);
		       ResultSet resultSet = cpstmt.executeQuery(cpsql);
		       while (resultSet.next()) {
					int total_rows = resultSet.getMetaData().getColumnCount();
					for (int i = 0; i < total_rows; i++) {
						obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), ((resultSet.getObject(i + 1)==null) ? "NA" : resultSet.getObject(i + 1).toString()));
					}

					}
		       data=obj.toString();
		       cpstmt.close();
		       conn.close();
		     }
		     catch(Exception e){
		      e.printStackTrace();
		     }
           return obj;
       }
}
