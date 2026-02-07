package com.common;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

public class ClsVocno {
	
	   public String checkvocno(Connection conn,String formdetailcode,String brhid,Date vocdate) throws SQLException{
		   //System.out.println("-------------inside ClsVocno---------------");
			String menuvocno="";
			String menuvocnos="";
			String brch="";
			String tblval="";
			String tblname="";
			String  pattern="";
			String maxvalue="";
			try{
				
				
			Statement stmtchkvocno=conn.createStatement();
		
			/* CONFIG USED TO FIND WHETHER THE METHOD IS 5*/
			
			String docyr="SELECT method config FROM GL_CONFIG where field_nme ='Yeardocno'"; 
			//System.out.println("config chk-----"+docyr);  
			ResultSet rsdocyr=stmtchkvocno.executeQuery(docyr);
			int config=0;
			while(rsdocyr.next()){
				config=rsdocyr.getInt("config");
			}
			
			/*CONFORMS CONFIG =5*/

			if(config==5) {
				
				/* FOR BB VALUE IN MY_MENU VOC_NO WE TAKING THE BRCODE & FROM THE FORMS DATE YY IS TAKEN */
				
				String strbr="SELECT brcode from my_brch where doc_no="+brhid+" ";
				//System.out.println("brch query-----"+strbr); 
				ResultSet rsbr=stmtchkvocno.executeQuery(strbr);
				while(rsbr.next()){
					brch=rsbr.getString("brcode");
				} 
				
				/* TAKING VOC_NO AND TBL_NAME FROM MY_MENU*/
				
			String strtbl="SELECT voc_no,tbl_name FROM MY_MENU where doc_type='"+formdetailcode+"' ";
			//System.out.println("MY_MENU query-----"+strtbl); 
			ResultSet rsstrtbl=stmtchkvocno.executeQuery(strtbl);
			while(rsstrtbl.next()){
				tblval=rsstrtbl.getString("voc_no");
				tblname=rsstrtbl.getString("tbl_name");
			} 
			
			
		       /* FINDING FIRST & LAST INDEX OF THE NUMBERS*/
			
		        String input = tblval;
		        int length = input.length();
		        int startIndex =0;
		        Pattern patterne = Pattern.compile("\\d+"); // Matches one or more digits
		        Matcher matcher = patterne.matcher(input);

		        if (matcher.find()) {
		             startIndex = matcher.start()+1; // Get the starting index of the matched number
		            
		           // System.out.println("Starting index of the number: " + startIndex);
		         //   System.out.println("length of the number: " + length);
		        }else {
		        	
		        }
		        
		        /* GETTING MAX_VOC NO FROM THE DOCUMENTS TABLE  */
			      
		        
		        /*IF DTYPE EQUALS "CRV" , "CPV","BPV","BRV" THEN DTYPE ALSO CHECKED IN WHERE CONDITION*/
		        
		        
		        String 	sqltest="",notype="";
		        if(formdetailcode.equalsIgnoreCase("CRV") ||formdetailcode.equalsIgnoreCase("CPV") ||
		        		formdetailcode.equalsIgnoreCase("BRV") ||formdetailcode.equalsIgnoreCase("BPV") ||formdetailcode.equalsIgnoreCase("JVT") || 
		        		formdetailcode.equalsIgnoreCase("DNO") ||formdetailcode.equalsIgnoreCase("CNO") 
		        		|| formdetailcode.equalsIgnoreCase("PC") ||  formdetailcode.equalsIgnoreCase("UCP")  ||  formdetailcode.equalsIgnoreCase("UCR")
		        		 ||  formdetailcode.equalsIgnoreCase("SEC")  ||  formdetailcode.equalsIgnoreCase("BGT")
		        		 ||  formdetailcode.equalsIgnoreCase("TCN")  ||  formdetailcode.equalsIgnoreCase("TDN")) {
		        	
		        	sqltest=sqltest+" and  dtype= '"+formdetailcode+"'";
		        	 
		        }

		       
		        if(formdetailcode.equalsIgnoreCase("CRV") ||formdetailcode.equalsIgnoreCase("CPV") ||
		        		formdetailcode.equalsIgnoreCase("BRV") ||formdetailcode.equalsIgnoreCase("BPV") ||formdetailcode.equalsIgnoreCase("JVT") || 
		        		formdetailcode.equalsIgnoreCase("DNO") ||formdetailcode.equalsIgnoreCase("CNO") 
		        		|| formdetailcode.equalsIgnoreCase("PC") || formdetailcode.equalsIgnoreCase("COT")
		        		 ||  formdetailcode.equalsIgnoreCase("UCP")  ||  formdetailcode.equalsIgnoreCase("UCR")
		        		 ||  formdetailcode.equalsIgnoreCase("SEC")  ||  formdetailcode.equalsIgnoreCase("BGT") 
		        		 ||  formdetailcode.equalsIgnoreCase("TCN") ||  formdetailcode.equalsIgnoreCase("TDN")) {
		        	
		            notype="doc_no";  
		        }else if (formdetailcode.equalsIgnoreCase("RRV") ||formdetailcode.equalsIgnoreCase("RRP")){
		        	notype="srno";   
		        }else {
		        notype="voc_no";   
		        }
		        String  maxval="select CONCAT(SUBSTRING('"+tblval+"' FROM "+1+" FOR "+startIndex+"-1),LPAD(coalesce(max(SUBSTRING("+notype+" FROM "+startIndex+" FOR "+length+"))+1,1),("+length+"-"+startIndex+")+1,0)) maxval from "+tblname+" where brhid="+brch+" and year(date)='"+vocdate+"' "+sqltest+" ";
		      //System.out.println("maxval------"+maxval);
		       ResultSet rsmaxval=stmtchkvocno.executeQuery(maxval);
		      	while(rsmaxval.next()){
					maxvalue=rsmaxval.getString("maxval");
					
					     
				} 
		        
		   
		       SimpleDateFormat dateFormat = new SimpleDateFormat("yy");
		        String currentYear = dateFormat.format(vocdate);
		       
		        /*REPLACING BB AND YY USING BRCH AND VOCDATE*/
		        
		        menuvocnos=maxvalue;
		        
		        menuvocnos=maxvalue.replaceAll("BB", brch).replaceAll("YY", currentYear);
		        
		     //   System.out.println("Modified pattern: " + menuvocnos);
		      
			}
			}
			catch(Exception e){
                                e.printStackTrace();
				conn.close();
				return menuvocnos;
			}
			return menuvocnos;
		}
	    
	    

}
