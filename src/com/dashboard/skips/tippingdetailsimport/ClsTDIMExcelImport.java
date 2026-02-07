package com.dashboard.skips.tippingdetailsimport;

import java.io.FileInputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.common.ClsCommon;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.connection.ClsConnection;

public class ClsTDIMExcelImport {

  public int ExcelImport(String docNo) throws SQLException {  
        	ClsConnection connDAO = new ClsConnection();
    	    Connection conn = null;
    		ClsCommon com=new ClsCommon();
    	//System.out.println("1======in clas======");
        try{
     	//System.out.println("===excel action=="+docNo);
        	conn=connDAO.getMyConnection();
			// conn.setAutoCommit(false);
			Statement stmt = conn.createStatement();
			String path="";   
			//System.out.println("1======in clas======2");   
			String strSql = "select path from my_fileattach where doc_no='"+docNo+"' and dtype='TDIM'"; 
			//System.out.println("1=====docno=="+strSql);  
			ResultSet rs = stmt.executeQuery(strSql);
			while(rs.next()) {
				path=rs.getString("path");
			}
			path = path.replace("\\", "//");
			
            FileInputStream input = new FileInputStream(path);
            POIFSFileSystem fs = new POIFSFileSystem( input );
            HSSFWorkbook wb = new HSSFWorkbook(fs);
           
            /* for xlsx
             * 
             * OPCPackage pkg = OPCPackage.open(input);
            XSSFWorkbook wb = new XSSFWorkbook(pkg);
            XSSFSheet sheet = wb.getSheetAt(0);*/
            HSSFSheet sheet = wb.getSheetAt(0);
            
        	//System.out.println("1======in clas======2"); 
        	//System.out.println("1======last row"+sheet.getLastRowNum());
            String sql5="truncate sk_tippingdetexcel";     
		 	 //System.out.println("sql5--->>>"+sql5);    
            stmt.executeUpdate(sql5);   
            Row row;
            int j=sheet.getLastRowNum();
            for(int i=1; i<=j; i++){
            	java.sql.Date sqlDODate = null;
            	CallableStatement stmtExcel=null; 
            	String dodatestr="";
                row = sheet.getRow(i);
                if(row.getCell(0)!=null){   
                row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                }
                if(row.getCell(1)!=null){
                row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                }
                if(row.getCell(2)!=null){
                row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                }
                if(row.getCell(3)!=null){
                row.getCell(3).setCellType(Cell.CELL_TYPE_NUMERIC);  
                }
                if(row.getCell(4)!=null){
                row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                }
                if(row.getCell(5)!=null){
                row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                }
                if(row.getCell(6)!=null){
                row.getCell(6).setCellType(Cell.CELL_TYPE_STRING); 
                } 
                if(row.getCell(7)!=null){
                    row.getCell(7).setCellType(Cell.CELL_TYPE_STRING); 
                } 
                if(row.getCell(8)!=null){
                    row.getCell(8).setCellType(Cell.CELL_TYPE_STRING); 
                } 
                if(row.getCell(9)!=null){  
                    row.getCell(9).setCellType(Cell.CELL_TYPE_STRING); 
                } 
                if(row.getCell(10)!=null){    
                    row.getCell(10).setCellType(Cell.CELL_TYPE_STRING); 
                } 
                String contno = row.getCell(0)==null?"0":row.getCell(0).getStringCellValue().trim()==""?"0":row.getCell(0).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                String oldcontno = row.getCell(1)==null?"0":row.getCell(1).getStringCellValue().trim()==""?"0":row.getCell(1).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                String dono=row.getCell(2)==null?"0":row.getCell(2).getStringCellValue().trim()==""?"0":row.getCell(2).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");       
                //String dodate=row.getCell(3)==null?"0":row.getCell(3).getStringCellValue()==""?"0":row.getCell(3).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                Date dodate=row.getCell(3).getDateCellValue();   
                String visitno = row.getCell(4)==null?"0":row.getCell(4).getStringCellValue().trim()==""?"0":row.getCell(4).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                String wastetype = row.getCell(5)==null?"":row.getCell(5).getStringCellValue().trim()==""?"":row.getCell(5).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                String skipsize = row.getCell(6)==null?"":row.getCell(6).getStringCellValue().trim()==""?"":row.getCell(6).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                String brhid = row.getCell(7)==null?"1":row.getCell(7).getStringCellValue().trim()==""?"1":row.getCell(7).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                String tipping = row.getCell(8)==null?"YES":row.getCell(8).getStringCellValue().trim()==""?"YES":row.getCell(8).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                String weight = row.getCell(9)==null?"0":row.getCell(9).getStringCellValue().trim()==""?"0":row.getCell(9).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " "); 
                String price = row.getCell(10)==null?"0":row.getCell(10).getStringCellValue().trim()==""?"0":row.getCell(10).getStringCellValue().replace("\"","'").replaceAll("'", "/").replaceAll("\\s+", " ");
                //System.out.println("contno=="+contno+"=oldcontno="+oldcontno+"=dono="+dono+"=dodate="+dodate+"=visitno="+visitno+"=wastetype="+wastetype+"=skipsize="+skipsize);   
                //System.out.println("dodate=="+dodate);    
                if(dodate!=null){ 
                	SimpleDateFormat format2 = new SimpleDateFormat("dd-MM-yyyy");     
                	dodatestr=format2.format(dodate); 
                	sqlDODate=com.changeStringtoSqlDate2(dodatestr);                   
                 }   
                //System.out.println("dodatestr=="+sqlDODate);      
                if(!(contno.equalsIgnoreCase("0") || contno.equalsIgnoreCase("")) || !(oldcontno.equalsIgnoreCase("0") || oldcontno.equalsIgnoreCase(""))){           
                stmtExcel = conn.prepareCall("INSERT INTO sk_tippingdetexcel(contno, oldcontno, dono, dodate, visitno, wastetype, skipsize, brhid, tipping, weight, price) VALUES(?,?,?,?,?,?,?,?,?,?,?)");        
                
                stmtExcel.setString(1,contno.trim().equalsIgnoreCase("")?"0":contno);          
                stmtExcel.setString(2,oldcontno); 
                stmtExcel.setString(3,dono); 
                stmtExcel.setDate(4,sqlDODate); 
                stmtExcel.setString(5,visitno.trim().equalsIgnoreCase("")?"1":visitno);     
                stmtExcel.setString(6,wastetype); 
                stmtExcel.setString(7,skipsize); 
                stmtExcel.setString(8,brhid);
                stmtExcel.setString(9,tipping);  
                stmtExcel.setString(10,weight.trim().equalsIgnoreCase("")?"0.0":weight);        
                stmtExcel.setString(11,price.trim().equalsIgnoreCase("")?"0.0":price);  
             //   System.out.println(stmtExcel);
                int val=stmtExcel.executeUpdate();                                
               }      
            } 
//            conn.commit();
            conn.close();
            input.close();
        }catch(Exception e){
		 	e.printStackTrace();
		 	conn.close();
		 	return 0;
	 }finally{
		 conn.close();
	 }
        return 1;
	}

}

