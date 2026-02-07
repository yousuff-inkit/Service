package com.dashboard;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.connection.*;

public class ClsDashBoardNewDAO {

ClsConnection objconn= new ClsConnection();     

	public JSONObject getChartCountData(String widgetname,Connection conn){      
		JSONObject data=new JSONObject();
		try{
				Statement stmt=conn.createStatement();
				ArrayList<String> daysarray=new ArrayList<>();
				ArrayList<String> chartenqarray = new ArrayList<>();
				ArrayList<String> chartsjobarray = new ArrayList<>();   
				ArrayList<String> chartamcarray = new ArrayList<>();   
			    
			    String lblname="",sqltest="",strjoin="",sqlselect="",sqltest1=""; 
			       
			    if(widgetname.equalsIgnoreCase("enqsch")){
					sqltest1+=" and m.enqstatus=0 and m.sh_empid=0 ";  
					sqlselect="coalesce(round(datediff(curdate(),m.date),0),0)";  
				}else if(widgetname.equalsIgnoreCase("schenq")){
					sqltest1+=" and m.enqstatus=0 and m.sh_empid!=0 ";
					sqlselect="coalesce(round(datediff(curdate(),m.date),0),0)"; 
				}else if(widgetname.equalsIgnoreCase("sur")){
					sqltest1+=" and m.enqstatus=1 ";
					strjoin=" left join cm_surveym sm on (sm.refDocNo=m.doc_no and sm.ref_type='enq') left join gl_beqs bs on (bs.rdocno=m.doc_no and bs.process='sur') ";
					sqlselect="if(sm.entrydate is null and bs.entrydate is null,coalesce(round(datediff(curdate(),m.date),0),0),coalesce(if(sm.entrydate is null,round(datediff(curdate(),bs.entrydate),0),round(datediff(curdate(),sm.entrydate),0)),0))"; 
				}else if(widgetname.equalsIgnoreCase("est")){
					sqltest1+=" and m.enqstatus=2 ";
					strjoin=" left join cm_prjestm pm on (pm.reftrno=m.doc_no and pm.ref_type='enq') ";
					sqlselect="coalesce(round(datediff(curdate(),pm.entrydate),0),0)";    
				}else if(widgetname.equalsIgnoreCase("quot")){
					sqltest1+=" and m.enqstatus=3 ";   
					strjoin=" left join cm_srvqotm qm on (qm.refDocNo=m.doc_no and qm.ref_type='enq') ";
					sqlselect="coalesce(round(datediff(curdate(),qm.entrydate),0),0)";         
				}else if(widgetname.equalsIgnoreCase("totalenq")){          
					sqltest1+=" and m.enqstatus<=3 ";
					sqlselect="coalesce(round(datediff(curdate(),m.date),0),0)";   
				}else{} 
			    
			    int monthindex=1;
			    
				while(monthindex<=11){    
					if(monthindex==1) {
						lblname="0-10";
						sqltest=" and "+sqlselect+" between 0 and 10";       
					}else if(monthindex==2) {
						lblname="10-20"; 
						sqltest=" and "+sqlselect+" between 10 and 20";
					}else if(monthindex==3) {
						lblname="20-30"; 
						sqltest=" and "+sqlselect+" between 20 and 30";
					}else if(monthindex==4) {
						lblname="30-40"; 
						sqltest=" and "+sqlselect+" between 30 and 40";
					}else if(monthindex==5) {
						lblname="40-50"; 
						sqltest=" and "+sqlselect+" between 40 and 50";
					}else if(monthindex==6) {
						lblname="50-60"; 
						sqltest=" and "+sqlselect+" between 50 and 60";
					}else if(monthindex==7) {
						lblname="60-70"; 
						sqltest=" and "+sqlselect+" between 60 and 70";
					}else if(monthindex==8) {
						lblname="70-80"; 
						sqltest=" and "+sqlselect+" between 70 and 80";
					}else if(monthindex==9) {
						lblname="80-90"; 
						sqltest=" and "+sqlselect+" between 80 and 90";
					}else if(monthindex==10) {
						lblname="90-100"; 
						sqltest=" and "+sqlselect+" between 90 and 100";
					}else if(monthindex==11) {  
						lblname="100 and above"; 
						sqltest=" and "+sqlselect+">=100";              
					}else {}
				     
					String strchartcount="select (select count(*) val from gl_enqm m "+strjoin+" where m.status=3 "+sqltest+" "+sqltest1+") chartenqcount,(select count(*) val from gl_enqm  m "+strjoin+" where m.status=3 and m.contrmode='sjob' "+sqltest+" "+sqltest1+") chartsjobcount,(select count(*) val from gl_enqm  m "+strjoin+" where m.status=3 and m.contrmode='amc' "+sqltest+" "+sqltest1+") chartamccount";
					//System.out.println(strchartcount);      
					int chartenqcount=0,chartsjobcount=0,chartamccount=0;         
					ResultSet rschartcount=stmt.executeQuery(strchartcount);
					while(rschartcount.next()){
						chartenqcount=rschartcount.getInt("chartenqcount");
						chartsjobcount=rschartcount.getInt("chartsjobcount");
						chartamccount=rschartcount.getInt("chartamccount");   
					}
					daysarray.add(lblname+"");
					chartenqarray.add(chartenqcount+"");
					chartsjobarray.add(chartsjobcount+"");
					chartamcarray.add(chartamccount+""); 
					monthindex++;      
			    }	
				data.put("labels", daysarray);     
				data.put("chartenqcount", chartenqarray);          
				data.put("chartsjobcount",chartsjobarray);
				data.put("chartamccount",chartamcarray);
				//data.put("chartcounttitle", "Enquiry details of "+daysarray.get(0)+" - "+daysarray.get(daysarray.size()-1));      
	//			System.out.println(data);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return data;
	}
	
}
