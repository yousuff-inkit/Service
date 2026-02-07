package com.emailnew;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Properties;

import javax.activation.*;
import javax.mail.AuthenticationFailedException;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
 

public class EmailUtility {
	
	private void addRecipients(Message msg, Message.RecipientType type, String addresses) throws MessagingException {
	    if (addresses != null && !addresses.trim().isEmpty()) {
	        String[] addressArray = addresses.split("[,;]");
	        for (String addr : addressArray) {
	            String trimmed = addr.trim();
	            if (!trimmed.isEmpty()) {
	                try {
	                    msg.addRecipient(type, new InternetAddress(trimmed));
	                } catch (AddressException e) {
	                    System.err.println("Invalid email skipped: " + trimmed);
	                }
	            }
	        }
	    }
	}

	
	public  String sendEmailpdf(String host, String port,  
            final String userName, final String password,
            String recipient, String CC ,String subject, String message,String Filepath,String BCC,File attachfile){  
		
        Properties properties = new Properties();
        if(port.equalsIgnoreCase("465")){	
            
            properties.setProperty("mail.smtp.protocol", "smtps");
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", host);
            properties.put("mail.smtp.port", port);
            properties.put("mail.smtp.debug", "true");
            properties.put("mail.smtp.socketFactory.port", port);
            properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            properties.put("mail.smtp.socketFactory.fallback", "false");
            properties.put("mail.user", userName);
            properties.put("mail.password", password);
            //java.net.preferIPv4Stack=true;
            // creates a new session with an authenticator
           
    	}
    	if(port.equalsIgnoreCase("587")){	
    		/*
    		 * properties.put("mail.smtp.auth", "true");
    		 * properties.put("mail.smtp.starttls.enable", "true");
    		 * properties.put("mail.smtp.host", "smtp.gmail.com");
    		 * properties.put("mail.smtp.port", port);
    		 * 
    		 */
    		/*
    		 * mail.smtp.starttls.enable=true; mail.smtp.ssl.protocols=TLSv1.2;
    		 */
    		properties.put("mail.smtp.starttls.enable", "true");
    		
    		
    		 	properties.setProperty("mail.smtp.protocol", "TLSv1.2");
    		 	
    		 	
    		 	
    	        properties.put("mail.smtp.auth", "true");
    	        properties.put("mail.smtp.starttls.enable", "true");
    	        properties.put("mail.smtp.host", host);
    	        properties.put("mail.smtp.port", port);
    	        properties.put("mail.smtp.debug", "true");
    	        /*
    	         * was not working for progress mail
    	         * properties.put("mail.smtp.socketFactory.port", "465");
    	        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");*/
    	       // properties.put("mail.smtp.starttls.enable", "true");
    	        properties.put("mail.smtp.socketFactory.fallback", "false");
    	        properties.put("mail.user", userName);
    	        properties.put("mail.password", password);
    	}
    	else //port 25
    	{
    		 properties.put("mail.smtp.host", host);    // SMTP Host
    		 properties.put("mail.smtp.port", port);                             // SMTP Port
    		 properties.put("mail.smtp.auth", "true");                         // SMTP Authentication Enabled
    	                
    	      
    	}
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
 
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
//        		System.out.println("====recipient======"+recipient);
//        		System.out.println("====CC======"+CC);
//        		System.out.println("====BCC======"+BCC);
//        		System.out.println("==userName===="+userName); 
        try{		
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
       
        addRecipients(msg, Message.RecipientType.TO, recipient);
        addRecipients(msg, Message.RecipientType.CC, CC);
        addRecipients(msg, Message.RecipientType.BCC, BCC);
        
        if(!(subject.equals(""))){                        
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
        // creates message part
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
        // creates multi-part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        // adds attachments
        int i=0;  
        //System.out.println("Filepath===="+Filepath);  
        if(!Filepath.equalsIgnoreCase("")){                   
        java.util.List<java.io.File> files = new ArrayList<>();                      
        String[] urlarray = Filepath.split(",");          
        File saveFile = null;
    	for (i = 0; i < urlarray.length; i++) {     
    		String tranno=urlarray[i];	             
    		if(!(tranno.equalsIgnoreCase(""))){   
    			//System.out.println("tranno===="+tranno);            
    			saveFile=new File(tranno);       
    			files.add(saveFile);
    		 	//System.out.println("out test===="+files);  
    		}
    	} 
    	for(File s:files){      
    		//System.out.println("out test===="+s);  
    		MimeBodyPart attachPart = new MimeBodyPart();    
    		attachPart.attachFile(s); 
    		multipart.addBodyPart(attachPart); 
    	}         
        }
        MimeBodyPart attachPart = new MimeBodyPart();    
		if(attachfile!=null){
        	attachPart.attachFile(attachfile);     
    		multipart.addBodyPart(attachPart);  
        }
		
        msg.setContent(multipart);
        Transport.send(msg);
        } catch (AuthenticationFailedException authEx) {
            System.err.println("Authentication failed: " + authEx.getMessage());
            authEx.printStackTrace();
            return "fail";
        } catch (MessagingException msgEx) {
            System.err.println("Messaging exception: " + msgEx.getMessage());
            msgEx.printStackTrace();
            return "fail";
        } catch (Exception ex) {
            System.err.println("General exception: " + ex.getMessage());
            ex.printStackTrace();
            return "fail";
        }
        return "success";        
    }

	
	public  void sendEmailwithpdf(String host, String port,
            final String userName, final String password,
            String recipient,String subject, String message, File attachFile,String docnos)
                    throws AddressException, MessagingException, IOException {
        // sets SMTP server properties
		
	//	System.out.println("==recipient==="+recipient+"=CC=="+CC);
		
	System.out.println("-------------Email Process-----------------"+message);
	System.out.println("host=="+host+"==port=="+port+"==userName=="+userName+"==password=="+password+"==recipient=="+recipient);
		Session session=null;
		Properties properties = new Properties();
	if(port.equalsIgnoreCase("465")){	
       
        properties.setProperty("mail.smtp.protocol", "smtps");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", port);
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
       
	}
	if(port.equalsIgnoreCase("587")){	
		/*
		 * properties.put("mail.smtp.auth", "true");
		 * properties.put("mail.smtp.starttls.enable", "true");
		 * properties.put("mail.smtp.host", "smtp.gmail.com");
		 * properties.put("mail.smtp.port", port);
		 * 
		 */
		/*
		 * mail.smtp.starttls.enable=true; mail.smtp.ssl.protocols=TLSv1.2;
		 */
		properties.put("mail.smtp.starttls.enable", "true");
		
		
		 	properties.setProperty("mail.smtp.protocol", "TLSv1.2");
		 	
		 	
		 	
	        properties.put("mail.smtp.auth", "true");
	        properties.put("mail.smtp.starttls.enable", "true");
	        properties.put("mail.smtp.host", host);
	        properties.put("mail.smtp.port", port);
	        properties.put("mail.smtp.debug", "true");
	        /*
	         * was not working for progress mail
	         * properties.put("mail.smtp.socketFactory.port", "465");
	        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");*/
	       // properties.put("mail.smtp.starttls.enable", "true");
	        properties.put("mail.smtp.socketFactory.fallback", "false");
	        properties.put("mail.user", userName);
	        properties.put("mail.password", password);
	}
	else //port 25
	{
		 properties.put("mail.smtp.host", host);    // SMTP Host
		 properties.put("mail.smtp.port", port);                             // SMTP Port
		 properties.put("mail.smtp.auth", "true");                         // SMTP Authentication Enabled
	                
	      
	}
	 Authenticator auth = new Authenticator() {
         public PasswordAuthentication getPasswordAuthentication() {
             return new PasswordAuthentication(userName, password);
         }
     };
     session = Session.getInstance(properties, auth);
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
        		//System.out.println("====recipient======"+recipient);
        		//System.out.println("====CC======"+CC);
        		//System.out.println("====BCC======"+BCC);
        		System.out.println("==userName===="+userName);
        		
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        InternetAddress[] BccAddresses = { new InternetAddress(userName) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setRecipients(Message.RecipientType.BCC, BccAddresses);
        //msg.setRecipients(Message.RecipientType.BCC, toAddresses);
        
        
   
        
        
      /*  String[] cc = null;
        String[] bcc = null;
        if(CC.length() != 0){
            cc = CC.trim().split(",");
        } 
        if(BCC.length() != 0){
            bcc = BCC.trim().split(",");
        }


        if(!(CC.equals(""))){
        for(int i = 0; i < cc.length; i++) {
            if(!cc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
        }
        }
        
        if(!(BCC.equals(""))){
        for(int i = 0; i < bcc.length; i++) {
            if(!bcc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
        }
        }*/
        
        
        if(!(subject.equals(""))){
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
 
        // creates message part
        Multipart multipart = new MimeMultipart();
        docnos=docnos==null?"":docnos;
        //nou
        /*if(!(docnos.equalsIgnoreCase("")))
        {*/
                
        MimeBodyPart myattach = new MimeBodyPart();
        
        //System.out.println("-------------myattach--------------"+myattach);
        
        //String filename = "QOT"+docnos+".pdf";
     	/*		
     	 * String path= System.getProperty("user.home")+File.separator+"Downloads";*/
        
       DataSource source = new FileDataSource(attachFile);
       // System.out.println("-------------source--------------"+source);
       // DataSource source = new FileDataSource(attachFile+filename);
        myattach.setDataHandler(new DataHandler(source));
        //myattach.setFileName(filename);
        //multipart.addBodyPart(myattach);
	/*}*/
        
        //krish
        MimeBodyPart messageBodyPart = new MimeBodyPart();
     //   messageBodyPart.setText(message, "ISO-8859-1");  // first
        messageBodyPart.setContent(message, "text/html");
      // messageBodyPart.setHeader("content-Type", "text/html;charset=\"ISO-8859-1\""); // first

        multipart.addBodyPart(messageBodyPart);
       // multipart.addBodyPart(messageBodyPart);
 
        // adds attachments
       if (attachFile != null) {
            MimeBodyPart attachPart = new MimeBodyPart();
 
            try {
                attachPart.attachFile(attachFile);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
 
            multipart.addBodyPart(attachPart);
        }
       
        // sets the multi-part as e-mail's content*/
        msg.setContent(multipart);
        System.out.println("===== ======="+msg.getContent());
       // msg.setContent(message, "text/html");
        // sends the e-mail
       // System.out.println("=====dfghjkjhgfdfghjkl======="+msg);
        Transport.send(msg);
        
    }

	public  String sendEmail(String host, String port,  
            final String userName, final String password,
            String recipient, String CC ,String subject, String message,String Filepath,String BCC){  
		
        Properties properties = new Properties();
        properties.setProperty("mail.smtp.protocol", "smtps");                  
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.user", userName);
        properties.put("mail.password", password);
        //java.net.preferIPv4Stack=true;
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
 
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
//        		System.out.println("====recipient======"+recipient);
//        		System.out.println("====CC======"+CC);
//        		System.out.println("====BCC======"+BCC);
//        		System.out.println("==userName===="+userName); 
        try{		
        msg.setFrom(new InternetAddress(userName));
         //InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        //msg.setRecipients(Message.RecipientType.TO, toAddresses);
        String[] rcvr = null;  
        String[] cc = null;
        String[] bcc = null;
        
        if(recipient.length() != 0){
        	if(recipient.contains(",")){
        		rcvr = recipient.trim().split(",");  
        	} else if(recipient.contains(";")){
        		rcvr = recipient.trim().split(";");  
        	} else {
				rcvr = recipient.trim().split(";");  
			}
        	//rcvr = recipient.trim().split(",");  
        } 
        if(CC.length() != 0){
			if(CC.contains(",")){
        		cc = CC.trim().split(",");  
        	} else if(CC.contains(";")){
        		cc = CC.trim().split(";");  
        	} else {
				cc = CC.trim().split(";");  
			}
           
        } 
        if(BCC.length() != 0){
          //  bcc = BCC.trim().split(",");
		  if(BCC.contains(",")){
        		bcc = BCC.trim().split(",");  
        	} else if(BCC.contains(";")){
        		bcc = BCC.trim().split(";");  
        	} else {
				bcc = BCC.trim().split(";");  	
			}
           
        }
		if(!(recipient.equals(""))){
            for(int i = 0; i < rcvr.length; i++) {
                if(!rcvr[i].isEmpty())
                    msg.addRecipient(Message.RecipientType.TO, new InternetAddress(rcvr[i]));  
            }
        }

        if(!(CC.equals(""))){
        for(int i = 0; i < cc.length; i++) {
            if(!cc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.CC, new InternetAddress(cc[i]));
        }
        }
        
        if(!(BCC.equals(""))){
        for(int i = 0; i < bcc.length; i++) {
            if(!bcc[i].isEmpty())
                msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc[i]));
        }
        }      
        if(!(subject.equals(""))){                        
        msg.setSubject(subject);
        }
        msg.setSentDate(new Date());
        // creates message part
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setContent(message, "text/html");
        // creates multi-part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);
        // adds attachments
        int i=0;  
        //System.out.println("Filepath===="+Filepath);  
        if(!Filepath.equalsIgnoreCase("")){                   
        java.util.List<java.io.File> files = new ArrayList<>();                      
        String[] urlarray = Filepath.split(",");          
        File saveFile = null;
    	for (i = 0; i < urlarray.length; i++) {     
    		String tranno=urlarray[i];	             
    		if(!(tranno.equalsIgnoreCase(""))){   
    			//System.out.println("tranno===="+tranno);            
    			saveFile=new File(tranno);       
    			files.add(saveFile);
    		 	//System.out.println("out test===="+files);  
    		}
    	}        
    	for(File s:files){      
    		//System.out.println("out test===="+s);  
    		MimeBodyPart attachPart = new MimeBodyPart();    
    		attachPart.attachFile(s); 
    		multipart.addBodyPart(attachPart); 
    	}         
        }   
        msg.setContent(multipart);
        Transport.send(msg);
        }catch (Exception ex) {
        	ex.printStackTrace();
        	return "fail";
        }
        return "success";        
    }
}