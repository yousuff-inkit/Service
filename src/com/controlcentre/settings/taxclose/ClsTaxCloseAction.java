package com.controlcentre.settings.taxclose;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

public class ClsTaxCloseAction {
    ClsCommon ClsCommon=new ClsCommon();
    ClsTaxCloseDAO dao=new ClsTaxCloseDAO();

    private int docno;
    private int vocno;
    private String date;
    private String hiddate;
    private String dateupto;
    private String hiddateupto;
    private String tclosedate;
    private String hidmclosedate;
    private int userid;
    private int brchName;
    private int status;
    private String msg;
    private String mode;
    private String deleted;
    private String formdetailcode;
    
    
    
    
    

    public String getFormdetailcode() {
        return formdetailcode;
    }

    public void setFormdetailcode(String formdetailcode) {
        this.formdetailcode = formdetailcode;
    }

    public int getVocno() {
        return vocno;
    }

    public void setVocno(int vocno) {
        this.vocno = vocno;
    }

    public int getBrchName() {
        return brchName;
    }

    public void setBrchName(int brchName) {
        this.brchName = brchName;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }

    public int getDocno() {
        return docno;
    }

    public void setDocno(int docno) {
        this.docno = docno;
    }

    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }

    public String getHiddate() {
        return hiddate;
    }

    public void setHiddate(String hiddate) {
        this.hiddate = hiddate;
    }

    public String getDateupto() {
        return dateupto;
    }
    
    public void setDateupto(String dateupto) {
        this.dateupto = dateupto;
    }
    
    public String getHiddateupto() {
        return hiddateupto;
    }

    public void setHiddateupto(String hiddateupto) {
        this.hiddateupto = hiddateupto;
    }
    public String getTclosedate() {
        return tclosedate;
    }
    public void setTclosedate(String tclosedate) {
        this.tclosedate = tclosedate;
    }

    public String getHidmclosedate() {
        return hidmclosedate;
    }


    public void setHidmclosedate(String hidmclosedate) {
        this.hidmclosedate = hidmclosedate;
    }

    public int getUserid() {
        return userid;
    }


    public void setUserid(int userid) {
        this.userid = userid;
    }
 


    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMode() {
        return mode;
    }

    public void setMode(String mode) {
        this.mode = mode;
    }


    
    
    public void setData(int val,java.sql.Date date,java.sql.Date dateupto,java.sql.Date tclosedate,String msg){
       System.out.println("val on setData :"+val);
        setDocno(val);
        if(date!=null){
            setDate(date.toString());   
        }
        if(dateupto!=null){
            setDateupto(dateupto.toString());   
        }
        if(tclosedate!=null){
            setTclosedate(tclosedate.toString());   
        }
        setMsg(msg);
    }
    
    public String saveAction() throws SQLException {
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        String mode=getMode();
        java.sql.Date date=null,dateupto=null,tclosedate=null;
        if(getDate()!=null){
            date=ClsCommon.changeStringtoSqlDate(getDate());
        }
        if(getDateupto()!=null){
            dateupto=ClsCommon.changeStringtoSqlDate(getDateupto());
        }
        if(getTclosedate()!=null){
            tclosedate=ClsCommon.changeStringtoSqlDate(getTclosedate());
        }
        
        
        if(mode.equalsIgnoreCase("A")){
            System.out.println("Branch id :"+getBrchName());
            int val=dao.insert(date,dateupto,tclosedate,session,getBrchName(),mode,getDocno(),getFormdetailcode());
            if(val>0){
                System.out.println("Inside :"+val);
                setData(val,date,dateupto,tclosedate,"Successfully Saved");
                return "success";
            }
            else{
                setData(val,date,dateupto,tclosedate,"Not Saved");
                return "fail";
            }
        }else if(mode.equalsIgnoreCase("D")){
            System.out.println("Doc no : "+getDocno());
            System.out.println("VOC no : "+getVocno());
            System.out.println("Branch no : "+getBrchName());
            System.out.println("Date upto befor :"+dateupto);
            boolean delete=dao.delete(date,dateupto,tclosedate,session,getBrchName(),mode,getDocno(),getVocno(),getFormdetailcode());
            System.out.println("Date upto :"+dateupto);
            if(delete){
                setData(getDocno(),date, dateupto, tclosedate, "Successfully Deleted");
                return "success";
            }else{
                setData(getDocno(),date, dateupto, tclosedate, "Not Deleted");
                return "fail";
            }
                
        }
        return "fail";
    }
    
}
