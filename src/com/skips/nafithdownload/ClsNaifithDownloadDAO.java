package com.skips.nafithdownload;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.common.ClsCommon;
import com.connection.ClsConnection;
import com.google.common.collect.Iterators;

public class ClsNaifithDownloadDAO {
	ClsConnection objconn=new ClsConnection();
	ClsCommon objcommon=new ClsCommon();
	public JSONArray getNafithData(String docno) throws SQLException{
		JSONArray data=new JSONArray();
		if(docno.equalsIgnoreCase("") || docno==null || docno.equalsIgnoreCase("0")){
			return data;
		}
		Connection conn=null;
		try{
			conn=objconn.getMyConnection();
			String strsql="select TRIM(TRAILING '.0' FROM trip) trip,plate,indatetime,outdatetime,displocation,actualweight,entry from gl_nafith where rdocno="+docno;
			ResultSet rs=conn.createStatement().executeQuery(strsql);
			data=objcommon.convertToJSON(rs);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return data;
	}
	public  JSONArray getUsernames(String id) throws SQLException {
		JSONArray RESULTDATA=new JSONArray();
		if(!id.equalsIgnoreCase("1")){
			return RESULTDATA;
		}
		Connection conn = null;
		try {
			conn = objconn.getMyConnection();
			Statement stmt = conn.createStatement ();
			ResultSet resultSet = stmt.executeQuery ("SELECT username,0 iscaptcha FROM gl_nafithid where status=3");
			RESULTDATA=objcommon.convertToJSON(resultSet);
//			System.out.println("=====RESULTDATA"+RESULTDATA);

		}
		catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		finally{
			conn.close();
		}
		return RESULTDATA;
	}
	public boolean downloadNafith(String username, String password, String url,
			Connection conn,HttpSession session) {
		// TODO Auto-generated method stub
		System.out.println("Inside DAO"+username+"::"+password+"::"+url);
		int errorstatus=0;
		try{
			java.util.logging.Logger.getLogger("com.gargoylesoftware.htmlunit").setLevel(java.util.logging.Level.OFF);
			java.util.logging.Logger.getLogger("org.apache.http").setLevel(java.util.logging.Level.OFF);
			String chromepath="";
			Statement stmt=conn.createStatement();
			ResultSet rsgetchromepath=stmt.executeQuery("select chromedriverpath from my_comp where doc_no=1");
			while(rsgetchromepath.next()){
				chromepath=rsgetchromepath.getString("chromedriverpath");
			}
			ResultSet rsexcelpath= conn.createStatement().executeQuery("Select imgPath from my_comp");
			String excelpath="";
			while(rsexcelpath.next()) {
				excelpath=(rsexcelpath.getString("imgPath")+"\\NAFITHEXCEL");
			}
			
			HashMap<String, Object> chromePrefs = new HashMap<String, Object>();
			chromePrefs.put("profile.default_content_settings.popups", 0);
			chromePrefs.put("download.default_directory", excelpath);
			 
			ChromeOptions options = new ChromeOptions();
			options.addArguments("start-maximized");
	        /*options.addArguments("disable-infobars");
	        options.addArguments("--disable-extensions");*/
			options.setExperimentalOption("prefs", chromePrefs);
			DesiredCapabilities cap = DesiredCapabilities.chrome();
			cap.setCapability(CapabilityType.ACCEPT_SSL_CERTS, true);
			cap.setCapability(ChromeOptions.CAPABILITY, options);
			System.setProperty("webdriver.chrome.driver",chromepath); 
			WebDriver driver = new ChromeDriver(cap);
			Thread.sleep(10000);
			driver.get(url);
			String defaultwindow = driver.getWindowHandle();
			
			//Logging in
			driver.findElement(By.xpath("//*[@id='text-3']/div/div/a[6]")).click();
			Thread.sleep(3000);
			driver.findElement(By.xpath("//*[@id='loginForm:username']")).sendKeys(username);
			driver.findElement(By.xpath("//*[@id='loginForm:password']")).sendKeys(password);
			Thread.sleep(2000);
			//Captcha
			/*new WebDriverWait(driver, 10).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt(By.xpath("//iframe[starts-with(@name, 'a-') and starts-with(@src, 'https://www.google.com/recaptcha')]")));
	        new WebDriverWait(driver, 20).until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.rc-anchor-content"))).click();
	      
			Thread.sleep(3000);
	        driver.switchTo().defaultContent();
			driver.findElement(By.xpath("//*[@id='Button_cust']")).click();
			Thread.sleep(2000);*/
/*			System.out.println("Before Click on Search");
			//*[@id="HTMLSnippet_widget_HTMLSnippet_2"]/div/div[2]/div
			new WebDriverWait(driver, 20).until(ExpectedConditions.presenceOfElementLocated(By.xpath("//*[@id='HTMLSnippet_widget_HTMLSnippet_2']/div/div[2]/div"))).click();
		    System.out.println("After Click on search");*/  
			/*Thread.sleep(4000);
			//*[@id="HTMLSnippet_widget_HTMLSnippet_2"]/div/div[2]/div/a[1]
			WebElement elmsearch1 = driver.findElement(By.xpath("//*[@id='HTMLSnippet_widget_HTMLSnippet_6']/div/div[2]/div/a[1]"));
			JavascriptExecutor executor = (JavascriptExecutor)driver;
			executor.executeScript("arguments[0].click();", elmsearch1);
			//driver.findElement(By.xpath("//*[@id='HTMLSnippet_widget_HTMLSnippet_7']/div/div[2]/div/a[2]")).click();
			Thread.sleep(2000);
			*/
			//Thread.sleep(3000);
			int searchbarpresent=0;
			do{
				searchbarpresent=driver.findElements(By.xpath("//*[@id='HTMLSnippet_widget_HTMLSnippet_2']/div/div[2]/div")).size();
				System.out.println("Searchbar:"+searchbarpresent);
				if(searchbarpresent<=0){
					Thread.sleep(2000);
				}
				else{
					//driver.findElement(By.xpath("//*[@id='HTMLSnippet_widget_HTMLSnippet_2']/div/div[2]/div")).click();
					driver.findElement(By.xpath("//*[@id='HTMLSnippet_widget_HTMLSnippet_2']/div/div[2]/div")).click();
					Thread.sleep(1000);
					break;
				}
			}while(searchbarpresent<=0);
			
			browserSteps(conn,"NFT",driver);
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	public void browserSteps(Connection conn, String type, WebDriver driver) {
		// TODO Auto-generated method stub
		try{
			Statement stmt=conn.createStatement();
			String strsql="select scrollsize,looping,doc_no,type,path,event,coalesce(value,'') value,coalesce(sleep,'') sleep from gl_browsersteps where type='"+type+"' and status=3 and coalesce(path,'')<>'' order by seqno";
			ResultSet rs=stmt.executeQuery(strsql);
			while(rs.next()){
				System.out.println("Inside Path:"+rs.getInt("doc_no")+"::"+rs.getString("path"));
				String path=rs.getString("path");
				String event=rs.getString("event");
				
				ArrayList<String> alltabs=new ArrayList<>(driver.getWindowHandles());
				System.out.println(alltabs.toString());
				driver.switchTo().window(alltabs.get(alltabs.size()-1));
				if(rs.getInt("scrollsize")>0){
					int scrollsize=rs.getInt("scrollsize");
					JavascriptExecutor js = (JavascriptExecutor) driver;
					js.executeScript("window.scrollBy(0,"+scrollsize+")");
				}
				if(rs.getInt("looping")==1){
					int loopsize=0;
					do{
						loopsize=driver.findElements(By.xpath(path)).size();
						System.out.println("Loop Size:"+loopsize);
						if(loopsize<=0){
							Thread.sleep(Long.parseLong(rs.getString("sleep")));
						}
						else{
							driver.findElement(By.xpath(path)).click();
							break;
						}
					}while(loopsize<=0);
				}
				if(event.equalsIgnoreCase("typing")){
					driver.findElement(By.xpath(path)).sendKeys(rs.getString("value"));
				}
				else if(event.equalsIgnoreCase("click")){
					WebElement element = driver.findElement(By.xpath(path));
					JavascriptExecutor executor = (JavascriptExecutor)driver;
					executor.executeScript("arguments[0].click();", element);
					
				}
				if(!rs.getString("sleep").trim().equalsIgnoreCase("")){
					Thread.sleep(Long.parseLong(rs.getString("sleep")));
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	public String downloadExcel(Connection conn,HttpSession session,String exceldocno) throws SQLException{
		int errorstatus=0;
		try  
		{  
			Statement stmt=conn.createStatement();
			String username="";
			String strgetusername="select username from gl_nafithm where doc_no="+exceldocno;
			ResultSet rsgetusername=stmt.executeQuery(strgetusername);
			while(rsgetusername.next()){
				username=rsgetusername.getString("username");
			}
			String strgetfilename="select path from my_fileattach where doc_no="+exceldocno+" and dtype='NFT'";
			ResultSet rsgetfilename=stmt.executeQuery(strgetfilename);
			String filepath="";
			while(rsgetfilename.next()){
				filepath=rsgetfilename.getString("path").replace("\\", "\\\\");
			}
			System.out.println(filepath);
			File file = new File(filepath);   //creating a new file instance  
			FileInputStream fis = new FileInputStream(file);   //obtaining bytes from the file  
			//creating Workbook instance that refers to .xlsx file  
			XSSFWorkbook wb = new XSSFWorkbook(fis);   
			XSSFSheet sheet = wb.getSheetAt(0);     //creating a Sheet object to retrieve object  
			Iterator<Row> itr = sheet.iterator();//iterating over excel file
			System.out.println("Physical Rows:"+sheet.getPhysicalNumberOfRows());
			session.setAttribute("TOTALITEMCOUNT", sheet.getLastRowNum()-2);
			ArrayList<String> excelarray=new ArrayList<>();
			while (itr.hasNext()){  
				//System.out.println("Inside Row Iterator");
				Row row = itr.next(); 
				//System.out.println(row.toString());
				if(row.getRowNum()>=2){
					
					Iterator<Cell> cellIterator = row.cellIterator();   //iterating over each column  
					String trip="",plate="",indatetime="",outdatetime="",location="",weight="",entry="";
					while (cellIterator.hasNext()){  
						//System.out.println("Inside Cell Iterator");
						Cell cell = cellIterator.next();
						switch (cell.getCellType()){  
							case Cell.CELL_TYPE_STRING:    //field that represents string cell type  
								if(cell.getColumnIndex()==0){
									trip=cell.getStringCellValue();
								}
								else if(cell.getColumnIndex()==1){
									plate=cell.getStringCellValue();
								}
								else if(cell.getColumnIndex()==2){
									indatetime=cell.getStringCellValue();
								}
								else if(cell.getColumnIndex()==3){
									outdatetime=cell.getStringCellValue();
								}
								else if(cell.getColumnIndex()==4){
									location=cell.getStringCellValue();
								}
								else if(cell.getColumnIndex()==5){
									weight=cell.getStringCellValue();
								}
								else if(cell.getColumnIndex()==6){
									entry=cell.getStringCellValue();
								}
								break;
							case Cell.CELL_TYPE_NUMERIC:    //field that represents number cell type  
								if(cell.getColumnIndex()==0){
									trip=(cell.getNumericCellValue())+"";
								}
								else if(cell.getColumnIndex()==1){
									plate=(cell.getNumericCellValue())+"";
								}
								else if(cell.getColumnIndex()==2){
									indatetime=(cell.getNumericCellValue())+"";
								}
								else if(cell.getColumnIndex()==3){
									outdatetime=(cell.getNumericCellValue())+"";
								}
								else if(cell.getColumnIndex()==4){
									location=(cell.getNumericCellValue())+"";
								}
								else if(cell.getColumnIndex()==5){
									weight=(cell.getNumericCellValue())+"";
								}
								else if(cell.getColumnIndex()==6){
									entry=(cell.getNumericCellValue())+"";
								}  
								break;  
							default:  
						}
						
					}  
					
					/*java.sql.Date sqlindatetime=null,sqloutdatetime=null;
					SimpleDateFormat exceldateformat = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss a");
					java.util.Date date = exceldateformat.parse(indatetime);
					sqlindatetime = new java.sql.Date(date.getTime());
					date = exceldateformat.parse(outdatetime);
					sqloutdatetime = new java.sql.Date(date.getTime());*/
					
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss aa");
					DateFormat outputformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date indate= df.parse(indatetime);
					String sqlindatetime=outputformat.format(indate);
					
					Date outdate= df.parse(outdatetime);
					String sqloutdatetime=outputformat.format(outdate);
					
					excelarray.add(trip+"::"+plate+"::"+sqlindatetime+"::"+sqloutdatetime+"::"+location+"::"+weight+"::"+entry);
					
				}
				
			}
			for(int i=0;i<excelarray.size();i++){
				String temp[]=excelarray.get(i).split("::");
				String trip=temp[0].trim();
				String plate=temp[1].trim();
				String indatetime=temp[2].trim();
				String outdatetime=temp[3].trim();
				String location=temp[4].trim();
				String weight=temp[5].trim();
				String entry=temp[6].trim();
				ResultSet rstrip=stmt.executeQuery("select count(*) itemcount from gl_nafith where trip='"+trip+"'");
				int tripcount=0;
				while(rstrip.next()){
					tripcount=rstrip.getInt("itemcount");
				}
				if(tripcount==0){
					String strinsert="insert into gl_nafith(rdocno,trip,plate,indatetime,outdatetime,displocation,actualweight,entry)values("+exceldocno+",'"+trip+"','"+plate+"','"+indatetime+"','"+outdatetime+"','"+location+"',"+weight+",'"+entry+"')"; 
					int insert=stmt.executeUpdate(strinsert);
					if(insert<=0){
						errorstatus=1;
					}
				}
				
			}
		}  
		catch(Exception e)  
		{  
			errorstatus=1;
			e.printStackTrace();  
		} 
		if(errorstatus==1){
			return 0+"";
		}
		return exceldocno+"";
	}
}
