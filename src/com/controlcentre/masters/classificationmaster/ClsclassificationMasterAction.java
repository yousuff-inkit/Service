package com.controlcentre.masters.classificationmaster;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;

import com.opensymphony.xwork2.ActionSupport;

public class ClsclassificationMasterAction extends ActionSupport {
    ClsCommon ClsCommon = new ClsCommon();
    ClsclassificationMasterDAO pDAO = new ClsclassificationMasterDAO();
    ClsclassificationMasterBean bean;
    
    private String hidname;
    private String desc;
    private int csmname;
    private String csmdate;
    private int docno;
    private String mode;
    private String deleted;
    private String msg;
    private String formdetail;
    private String formdetailcode;

    
    
    public String getHidname() {
        return hidname;
    }

    public void setHidname(String hidname) {
        this.hidname = hidname;
    }
    
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

    public String getCsmdate() {
        return csmdate;
    }

    public void setCsmdate(String csmdate) {
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
    
    
    public String saveclassificationMasterAction() throws ParseException, SQLException {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpSession session = request.getSession();

        session.getAttribute("BranchName");

        String mode = getMode();

        java.sql.Date sqlStartDate = null;
        if ((mode.equalsIgnoreCase("A")) || (mode.equalsIgnoreCase("E"))) {
            System.out.println("DATE IS = "+getCsmdate());
            sqlStartDate = ClsCommon.changeStringtoSqlDate(getCsmdate());
        }
        if (mode.equalsIgnoreCase("A")) {
            System.out.println(getDesc()+"=>desc");
            System.out.println(getCsmname()+"=>csdocno");
            System.out.println(sqlStartDate+"=>date");
            System.out.println(getMode()+"=>mode");
            System.out.println(getFormdetailcode()+"=>formdetail");
            int val = pDAO.insertClassificationMaster(getDesc(), getCsmname(), sqlStartDate, session, getMode(), getFormdetailcode());
            if (val > 0.0) {
                setCsmdate(sqlStartDate + "");
                setDesc(getDesc());
                setCsmname(getCsmname());
                setMode(getMode());
                setDocno(val);
                setMsg("Successfully Saved");
                return "success";
            } else if (val == -1) {
                setCsmdate(sqlStartDate + "");
                setDesc(getDesc());
                setCsmname(getCsmname());
                setMode(getMode());
                setMsg("desc Already Exists");
                return "fail";
            } else {
                setCsmdate(sqlStartDate + "");
                setDesc(getDesc());
                setCsmname(getCsmname());
                setMode(getMode());
                setDocno(val);

                setMsg("Not Saved");
                return "fail";
            }
        }

        else if (mode.equalsIgnoreCase("E")) {
            System.out.println("docno = "+getDocno());
            int Status = pDAO.editclassificationMaster(getDesc(), getCsmname(), getDocno(),
                    sqlStartDate, getMode(), session,
                    getFormdetailcode());
            if (Status > 0) {
                setCsmdate(sqlStartDate + "");
                setCsmname(getCsmname());
                setDesc(getDesc());
                setDocno(getDocno());
                setMode(getMode());

                setMsg("Updated Successfully");
                return "success";
            } else if (Status == -1) {
                setCsmdate(sqlStartDate + "");
                setDesc(getDesc());
                setCsmname(getCsmname());
                setDocno(getDocno());
                setMsg("desc Already Exists");
                return "fail";
            } else {
                setCsmdate(sqlStartDate + "");
                setDesc(getDesc());
                setCsmname(getCsmname());
                setDocno(getDocno());

                setMode(getMode());
                setMsg("Not Updated");
                return "fail";
            }
        } else if (mode.equalsIgnoreCase("D")) {
            int Status = pDAO.deleteClassificationMaster(getDesc(), getCsmname(), getDocno(),
                    sqlStartDate, getMode(), session,
                    getFormdetailcode());
            if (Status > 0) {
                setDesc(getDesc());
                setCsmname(getCsmname());
                setDocno(getDocno());
                setCsmdate(sqlStartDate + "");

                setDeleted("DELETED");
                setMsg("Successfully Deleted");
                return "success";
            } else if (Status == -2) {
                setCsmdate(sqlStartDate + "");
                setDesc(getDesc());
                setCsmname(getCsmname());
                setDocno(getDocno());

                setMsg("References Present in Other Documents");
                return "fail";
            } else {
                setCsmdate(sqlStartDate + "");
                setDesc(getDesc());
                setCsmname(getCsmname());
                setDocno(getDocno());

                setMsg("Not Deleted");
                return "fail";
            }
        }
        return "fail";
    }

   
}
