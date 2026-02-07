package com.controlcentre.masters.classificationmaster;

import java.sql.Date;

public class ClsclassificationMasterBean {

    private String desc;
    private int csmname;
    private Date csmdate;
    private int docno;
    private String mode;
    private String deleted;
    private String msg;
    private String formdetail;
    private String formdetailcode;
    
    public String getDesc() {
        return desc;
    }
    
    public void setDesc(String desc) {
        this.desc = desc;
    }
    
    public int getCsmname() {
        return csmname;
    }
    
    public void setCsmname(int csmname) {
        this.csmname = csmname;
    }
    
    public Date getCsmdate() {
        return csmdate;
    }
    
    public void setCsmdate(Date csmdate) {
        this.csmdate = csmdate;
    }
    
    public int getDocno() {
        return docno;
    }
    
    public void setDocno(int docno) {
        this.docno = docno;
    }
    
    public String getMode() {
        return mode;
    }
    
    public void setMode(String mode) {
        this.mode = mode;
    }
    
    public String getDeleted() {
        return deleted;
    }
    
    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }
    
    public String getMsg() {
        return msg;
    }
    
    public void setMsg(String msg) {
        this.msg = msg;
    }
    
    public String getFormdetail() {
        return formdetail;
    }
    
    public void setFormdetail(String formdetail) {
        this.formdetail = formdetail;
    }
    
    public String getFormdetailcode() {
        return formdetailcode;
    }
    
    public void setFormdetailcode(String formdetailcode) {
        this.formdetailcode = formdetailcode;
    }
}
