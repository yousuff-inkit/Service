package com.controlcentre.settings.productsettings.productmaster;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.common.ClsCommon;
import com.opensymphony.xwork2.ActionSupport;
import com.operations.clientrelations.clientcategory.ClsClientCategoryBean;

public class ClsProductMasterAction extends ActionSupport {
	ClsCommon ClsCommon = new ClsCommon();
	ClsProductMasterDAO pDAO = new ClsProductMasterDAO();
	ClsProductMasterBean bean;
	
	private String hscode;
	private String description;
	private String hsndate;

	private int docno;
	private String mode;
	private String deleted;
	private String msg;
	private String formdetail;
	private String formdetailcode;
	private String ptmdate;
	private String ptmtype;
	private String brand;
	private String branddesc;
	private String date;
	private String unit;
	private String unitdesc;
	private String chkstatus;
	private Double unitfr;
	private String txtcategory;
	private String model;
	private String brandid;
	private String subcat;
	private String category;
	private String dept;
	private String msg1;
	
	public String getHscode() {
		return hscode;
	}

	public void setHscode(String hscode) {
		this.hscode = hscode;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getHsndate() {
		return hsndate;
	}

	public void setHsndate(String hsndate) {
		this.hsndate = hsndate;
	}

	public String getMsg1() {
		return msg1;
	}

	public void setMsg1(String msg1) {
		this.msg1 = msg1;
	}

	private String catid;

	public String getCatid() {
		return catid;
	}

	public void setCatid(String catid) {
		this.catid = catid;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
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

	public String getPtmdate() {
		return ptmdate;
	}

	public void setPtmdate(String ptmdate) {
		this.ptmdate = ptmdate;
	}

	public String getPtmtype() {
		return ptmtype;
	}

	public void setPtmtype(String ptmtype) {
		this.ptmtype = ptmtype;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getBranddesc() {
		return branddesc;
	}

	public void setBranddesc(String branddesc) {
		this.branddesc = branddesc;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getUnitdesc() {
		return unitdesc;
	}

	public void setUnitdesc(String unitdesc) {
		this.unitdesc = unitdesc;
	}

	public String getChkstatus() {
		return chkstatus;
	}

	public void setChkstatus(String chkstatus) {
		this.chkstatus = chkstatus;
	}

	public Double getUnitfr() {
		return unitfr;
	}

	public void setUnitfr(Double unitfr) {
		this.unitfr = unitfr;
	}

	public String getTxtcategory() {
		return txtcategory;
	}

	public void setTxtcategory(String txtcategory) {
		this.txtcategory = txtcategory;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getBrandid() {
		return brandid;
	}

	public void setBrandid(String brandid) {
		this.brandid = brandid;
	}

	public String getSubcat() {
		return subcat;
	}

	public void setSubcat(String subcat) {
		this.subcat = subcat;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String cmbtype;

	public String getCmbtype() {
		return cmbtype;
	}

	public String hidcmbtype;

	public void setHidcmbtype(String hidcmbtype) {
		this.hidcmbtype = hidcmbtype;
	}

	public String txtsubfamilyname;

	public String getSubfamilyname() {
		return txtsubfamilyname;
	}

	public void setSubfamilyname(String txtsubfamilyname) {
		this.txtsubfamilyname = txtsubfamilyname;
	}

	public String savetypeAction() throws SQLException {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String returns = "";
		try {
			java.sql.Date date = ClsCommon.changeStringtoSqlDate(getPtmdate());
			if (mode.equalsIgnoreCase("A")) {

				System.out.println("=== " + getPtmtype());
				int val = pDAO.insert(date, getFormdetail(),
						getFormdetailcode(), getPtmtype(), getMode());
				if (val > 0) {
					setDocno(val);
					setDate(date + "");
					setMsg("Successfully Saved");
					setChkstatus("0");
					returns = "success";

				}

				else if (val == -1) {

					// setBrand(getBrand());
					setDate(date + "");
					setChkstatus("1");
					setMsg("Type Already Exists");
					// request.setAttribute("SAVED", "Not Saved");
					// addActionError("Not Saved");
					return "fail";
				}

				else {

					setMsg("Not Saved");
					setDate(date + "");
					returns = "fail";
				}
			}

			else if (mode.equalsIgnoreCase("E")) {

				int val = pDAO.update(date, getFormdetail(),
						getFormdetailcode(), getPtmtype(), getMode(),
						getDocno());
				if (val > 0.0) {
					setDocno(val);
					setDate(date + "");
					setMsg("Updated Successfully");
					setChkstatus("0");
					returns = "success";

				} else if (val == -1) {

					// setBrand(getBrand());
					setChkstatus("2");
					setDate(date + "");
					setMsg("Type Already Exists");
					// request.setAttribute("SAVED", "Not Saved");
					// addActionError("Not Saved");
					return "fail";
				}

				else {

					setMsg("Not Updated");
					setDate(date + "");
					returns = "fail";
				}
			}

			else if (mode.equalsIgnoreCase("D")) {

				int val = pDAO.delete(date, getFormdetail(),
						getFormdetailcode(), getPtmtype(), getMode(),
						getDocno());
				if (val > 0.0) {
					/* setDocno(0); */
					setPtmtype(getPtmtype());
					setDate(date + "");
					setMsg("Successfully Deleted");
					setDeleted("DELETED");
					returns = "success";

				}

				else {
					setDate(date + "");
					setMsg("Not Deleted");

					returns = "fail";
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return returns;

	}

	public String savedeptAction() throws SQLException {

		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String returns = "";
		try {
			java.sql.Date date = ClsCommon.changeStringtoSqlDate(getDate());
			if (mode.equalsIgnoreCase("A")) {

				int val = pDAO.insertdept(date, getFormdetail(),
						getFormdetailcode(), getDept(), getMode());
				if (val > 0) {
					setDocno(val);
					setDate(date + "");
					setMsg("Successfully Saved");
					setChkstatus("0");
					returns = "success";

				} else if (val == -1) {

					// setBrand(getBrand());
					setChkstatus("1");
					setDate(date + "");
					setMsg("Department Already Exists");
					// request.setAttribute("SAVED", "Not Saved");
					// addActionError("Not Saved");
					return "fail";
				}

				else {

					setMsg("Not Saved");
					setDate(date + "");

					returns = "fail";
				}
			}

			else if (mode.equalsIgnoreCase("E")) {

				int val = pDAO.updatedept(date, getFormdetail(),
						getFormdetailcode(), getDept(), getMode(), getDocno());
				if (val > 0.0) {
					setDocno(val);
					setDate(date + "");
					setMsg("Updated Successfully");
					setChkstatus("0");
					returns = "success";

				} else if (val == -1) {

					// setBrand(getBrand());
					setChkstatus("2");
					setDate(date + "");
					setMsg("Department Already Exists");
					// request.setAttribute("SAVED", "Not Saved");
					// addActionError("Not Saved");
					return "fail";
				}

				else {

					setMsg("Not Updated");
					setDate(date + "");

					returns = "fail";
				}
			}

			else if (mode.equalsIgnoreCase("D")) {

				int val = pDAO.deletedept(date, getFormdetail(),
						getFormdetailcode(), getPtmtype(), getMode(),
						getDocno());
				if (val > 0.0) {
					/* setDocno(0); */
					setPtmtype("");
					setDate(date + "");
					setMsg("Successfully Deleted");
					setDeleted("DELETED");
					returns = "success";

				}

				else {

					setMsg("Not Deleted");
					setDate(date + "");

					returns = "fail";
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return returns;

	}

	public String savebrandAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		String mode = getMode();

		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		if (mode.equalsIgnoreCase("A")) {
			// System.out.println("date---"+sqlStartDate);
			int val = pDAO.insert(sqlStartDate, getBrand(), getBranddesc(),
					getMode(), session, getFormdetailcode());
			if (val > 0) {

				setBrand(getBrand());
				setDocno(val);
				setChkstatus("0");
				setDate(sqlStartDate + "");
				// session.setAttribute("SAVED", "SUCCESSFULLY SAVED");
				setMsg("Successfully Saved");
				addActionMessage("Saved Successfully");
				// System.out.println(session.getAttribute("SAVED"));
				return "success";
			} else if (val == -1) {

				setBrand(getBrand());
				setChkstatus("1");
				setDate(sqlStartDate + "");
				setMsg("Brand Already Exists");
				// request.setAttribute("SAVED", "Not Saved");
				// addActionError("Not Saved");
				return "fail";
			} else {

				setBrand(getBrand());
				setMsg("Not Saved");
				setDate(sqlStartDate + "");
				return "fail";
			}
		} else if (mode.equalsIgnoreCase("E")) {
			int Status = pDAO.edit(getDocno(), sqlStartDate, getBrand(),
					getBranddesc(), session, getFormdetailcode());
			if (Status > 0) {

				setBrand(getBrand());
				setDocno(getDocno());
				setChkstatus("0");
				setDate(sqlStartDate + "");
				setMsg("Updated Successfully");
				return "success";
			} else if (Status == -1) {

				setBrand(getBrand());
				setDocno(getDocno());
				setChkstatus("2");
				setDate(sqlStartDate + "");

				setMsg("Brand Already Exists");
				return "fail";

			} else {

				setBrand(getBrand());
				setDocno(getDocno());
				setMsg("Not Updated");
				setDate(sqlStartDate + "");
				return "fail";
			}
		} else if (mode.equalsIgnoreCase("D")) {
			int Status = pDAO.delete(getDocno(), session, getBrand(),
					getFormdetailcode());
			if (Status > 0) {

				setBrand(getBrand());
				setDocno(getDocno());
				setDeleted("DELETED");
				setChkstatus("0");
				setDate(sqlStartDate + "");
				setMsg("Successfully Deleted");
				return "success";
			} else if (Status == -2) {

				setBrand(getBrand());
				setDocno(getDocno());
				setDate(sqlStartDate + "");
				setMsg("References Present in Other Documents");
				return "fail";
			} else {

				setBrand(getBrand());
				setDocno(getDocno());
				setDate(sqlStartDate + "");
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}

	public String saveunitAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		session.getAttribute("BranchName");
		String mode = getMode();

		if (mode.equalsIgnoreCase("A")) {
			int val = pDAO.insert(getUnit(), getUnitdesc(), session, getMode(),
					getFormdetailcode());
			if (val > 0.0) {
				setUnit(getUnit());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setChkstatus("0");
				setDocno(val);
				setMsg("Successfully Saved");

				return "success";
			} else if (val == -1) {
				setUnit(getUnit());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				// System.out.println(val);
				// setDocno(val);
				setChkstatus("1");
				setMsg("Unit Already Exists");
				return "fail";
			} else {
				setUnit(getUnit());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				// System.out.println(val);
				setDocno(val);
				setMsg("Not Saved");
				return "fail";
			}
		}

		else if (mode.equalsIgnoreCase("E")) {
			int Status = pDAO.edit(getUnit().trim(), getDocno(), getUnitdesc(),
					getMode(), session, getFormdetailcode());
			if (Status > 0) {

				// System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
				session.getAttribute("BranchName");
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setChkstatus("0");
				setMsg("Updated Successfully");

				return "success";
			} else if (Status == -1) {
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setChkstatus("2");
				setMsg("Unit Already Exists");
				return "fail";
			} else {
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		} else if (mode.equalsIgnoreCase("D")) {
			// System.out.println(getDocno()+","+getUnit()+","+getUnitdesc());
			boolean Status = pDAO.delete(getUnit(), getDocno(), getUnitdesc(),
					getMode(), session, getFormdetailcode());
			if (Status) {
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			} else {
				setUnit(getUnit());
				setDocno(getDocno());
				setUnitdesc(getUnitdesc());
				setMsg("Not Deleted");

				return "fail";
			}
		}
		return "fail";
	}
	

	public String savehsncodeAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		session.getAttribute("BranchName");
		String mode = getMode();

		if (mode.equalsIgnoreCase("A")) {
			int val = pDAO.inserthsncode(getDocno(),getHscode(), getHsndate(), getDescription() ,session, getMode(),
					getFormdetailcode());
			if (val > 0.0) {
				setHscode(getHscode());
				setHsndate(getHsndate());
				setDescription(getDescription());
				setMode(getMode());
				setChkstatus("0");
				setDocno(val);
				setMsg("Successfully Saved");

				return "success";
			} else if (val == -1) {
				setHscode(getHscode());
				setHsndate(getHsndate());
				setDescription(getDescription());
				setMode(getMode());
				// System.out.println(val);
				// setDocno(val);
				setChkstatus("1");
				setMsg("HSN Already Exists");
				return "fail";
			} else {
				setHscode(getHscode());
				setHsndate(getHsndate());
				setDescription(getDescription());
				setMode(getMode());
				// System.out.println(val);
				setDocno(val);
				setMsg("Not Saved");
				return "fail";
			}
		}

		else if (mode.equalsIgnoreCase("E")) {
			int Status = pDAO.edithsncode(getHscode().trim(),getDescription(),getDocno(), getHsndate(),
					getMode(), session, getFormdetailcode());
			if (Status > 0) {

				// System.out.println("hhhhhhhhhhhhhhhhheeeeeeeeeee"+getMode()+","+getModeldate());
				session.getAttribute("BranchName");
				setHscode(getHscode());
				setHsndate(getHsndate());
				setDescription(getDescription());
				setDocno(getDocno());
				setMode(getMode());
				setChkstatus("0");
				setMsg("Updated Successfully");

				return "success";
			} else if (Status == -1) {
				setHscode(getHscode());
				setHsndate(getHsndate());
				setDescription(getDescription());
				setDocno(getDocno());
				setMode(getMode());
				setChkstatus("2");
				setMsg("HSN Already Exists");
				return "fail";
			} else {
				setHscode(getHscode());
				setHsndate(getHsndate());
				setDescription(getDescription());
				setDocno(getDocno());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		} else if (mode.equalsIgnoreCase("D")) {
			// System.out.println(getDocno()+","+getUnit()+","+getUnitdesc());
			boolean Status = pDAO.deletehsncode(getDescription(),getHscode(),getHsndate(), getDocno(), getMode(), session, getFormdetailcode());
			if (Status) {
				setHscode(getHscode());
				setHsndate(getHsndate());
				setDescription(getDescription());
				setDocno(getDocno());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			} else {
				setHscode(getHscode());
				setHsndate(getHsndate());
				setDescription(getDescription());
				setDocno(getDocno());
				setMsg("Not Deleted");

				return "fail";
			}
		}
		return "fail";
	}

	public String savecategoryAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		String mode = getMode();
		ClsClientCategoryBean clientcategorybean = new ClsClientCategoryBean();
		java.sql.Date sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		if (mode.equalsIgnoreCase("A")) {
			int val = pDAO.insert1(getFormdetailcode(), getTxtcategory(), mode,
					session, sqlStartDate);

			if (val > 0) {
				setDate(sqlStartDate + "");
				setDocno(val);
				setChkstatus("0");
				setMsg("Successfully Saved");
				return "success";
			} else if (val == -1) {
				setDate(sqlStartDate + "");
				setChkstatus("1");
				setMsg("Category Already Exists");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setMsg("Not Saved");
				return "fail";
			}
		} else if (mode.equalsIgnoreCase("E")) {
			int Status = pDAO.edit1(getFormdetailcode(), getDocno(),
					getTxtcategory(), mode, session, sqlStartDate);
			if (Status > 0) {

				setDate(sqlStartDate + "");
				setChkstatus("0");
				setMsg("Updated Successfully");
				return "success";
			} else if (Status == -1) {
				setDate(sqlStartDate + "");
				setChkstatus("2");
				setMsg("Category Already Exists");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setMsg("Not Updated");
				return "fail";
			}
		}

		else if (mode.equalsIgnoreCase("D")) {
			int Status = pDAO.delete1(getDocno(), getFormdetailcode(), mode,
					session);
			if (Status > 0) {
				setDate(sqlStartDate + "");
				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			} else if (Status == -2) {
				setDate(sqlStartDate + "");

				setBrand(getBrand());
				setDocno(getDocno());
				setMsg("");
				setMsg1("References Present in Other Documents");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}

	public String savemodelAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		session.getAttribute("BranchName");

		String mode = getMode();

		java.sql.Date sqlStartDate = null;
		if ((mode.equalsIgnoreCase("A")) || (mode.equalsIgnoreCase("E"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		}

		if (mode.equalsIgnoreCase("A")) {
			int val = pDAO.insert(getModel(), getBrand(), sqlStartDate,
					session, getMode(), getFormdetailcode());
			if (val > 0.0) {
				setModel(getModel());
				setChkstatus("0");
				setBrandid(getBrand());
				setMode(getMode());
				setDate(sqlStartDate + "");
				// System.out.println(val);
				setDocno(val);
				setMsg("Successfully Saved");
				return "success";
			} else if (val == -1) {
				setDate(sqlStartDate + "");
				setModel(getModel());
				setBrandid(getBrand());
				setMode(getMode());
				// System.out.println(val);
				// setDocno(val);
				setChkstatus("1");
				setMsg("Model Already Exists");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setModel(getModel());
				setBrandid(getBrand());
				setMode(getMode());
				// System.out.println(val);
				setDocno(val);
				setMsg("Not Saved");
				return "fail";
			}
		}

		else if (mode.equalsIgnoreCase("E")) {
			int Status = pDAO.edit(getModel(), getDocno(), sqlStartDate,
					getBrand(), getMode(), session, getFormdetailcode());
			if (Status > 0) {
				setDate(sqlStartDate + "");
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				setChkstatus("0");
				// System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Updated Successfully");

				return "success";
			} else if (Status == -1) {
				setDate(sqlStartDate + "");
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				// System.out.println("Action"+getBrandid());
				// setMode(getMode());
				setChkstatus("2");
				setMsg("Model Already Exists");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				// System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		} else if (mode.equalsIgnoreCase("D")) {
			// System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status = pDAO.delete(getModel(), getDocno(), sqlStartDate,
					getBrand(), getMode(), session, getFormdetailcode());
			if (Status > 0) {
				setDate(sqlStartDate + "");
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				setBrand(getBrand());
				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			} else if (Status == -2) {
				setDate(sqlStartDate + "");
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				setBrand(getBrand());
				setMsg("References Present in Other Documents");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setModel(getModel());
				setDocno(getDocno());
				setBrandid(getBrand());
				setBrand(getBrand());
				setMsg("Not Deleted");

				return "fail";
			}
		}
		return "fail";
	}

	public String savesubcategoryAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		session.getAttribute("BranchName");

		String mode = getMode();

		java.sql.Date sqlStartDate = null;
		if ((mode.equalsIgnoreCase("A")) || (mode.equalsIgnoreCase("E"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());

		}

		System.out.println("=======getCategory()======" + getCategory());

		if (mode.equalsIgnoreCase("A")) {
			int val = pDAO.insertSubCat(getSubcat(), getCategory(),
					sqlStartDate, session, getMode(), getFormdetailcode());
			if (val > 0.0) {
				setDate(sqlStartDate + "");
				setSubcat(getSubcat());
				setCatid(getCategory());
				setMode(getMode());
				setChkstatus("0");
				// System.out.println(val);
				setDocno(val);
				setMsg("Successfully Saved");
				return "success";
			} else if (val == -1) {
				setDate(sqlStartDate + "");
				setSubcat(getSubcat());
				setCatid(getCategory());
				setMode(getMode());
				// System.out.println(val);
				// setDocno(val);
				setChkstatus("1");
				setMsg("Subcategory Already Exists");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setSubcat(getSubcat());
				setCatid(getCategory());
				setMode(getMode());
				// System.out.println(val);
				setDocno(val);
				setMsg("Not Saved");
				return "fail";
			}
		}

		else if (mode.equalsIgnoreCase("E")) {
			int Status = pDAO.editSubCat(getSubcat(), getDocno(), sqlStartDate,
					getCategory(), getMode(), session, getFormdetailcode());
			if (Status > 0) {
				setDate(sqlStartDate + "");
				setSubcat(getSubcat());
				setCatid(getCategory());
				setDocno(getDocno());
				// System.out.println("Action"+getBrandid());
				setMode(getMode());
				setChkstatus("0");
				setMsg("Updated Successfully");

				return "success";
			} else if (Status == -1) {
				setDate(sqlStartDate + "");
				setSubcat(getSubcat());
				setCatid(getCategory());
				setDocno(getDocno());

				// System.out.println("Action"+getBrandid());
				// setMode(getMode());
				setChkstatus("2");
				setMsg("Model Already Exists");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setSubcat(getSubcat());
				setCatid(getCategory());
				setDocno(getDocno());

				// System.out.println("Action"+getBrandid());
				setMode(getMode());
				setMsg("Not Updated");

				return "fail";
			}
		} else if (mode.equalsIgnoreCase("D")) {
			// System.out.println(getDocno()+","+getBrandid()+","+getModeldate());
			int Status = pDAO.deleteSubCat(getSubcat(), getDocno(),
					sqlStartDate, getCategory(), getMode(), session,
					getFormdetailcode());
			if (Status > 0) {
				setSubcat(getSubcat());
				setCatid(getCategory());
				setDocno(getDocno());
				setDate(sqlStartDate + "");

				setDeleted("DELETED");
				setMsg("Successfully Deleted");

				return "success";
			} else if (Status == -2) {
				setDate(sqlStartDate + "");
				setSubcat(getSubcat());
				setCatid(getCategory());
				setDocno(getDocno());

				setMsg("References Present in Other Documents");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setSubcat(getSubcat());
				setCatid(getCategory());
				setDocno(getDocno());
				setMsg("Not Deleted");

				return "fail";
			}
		}
		return "fail";
	}

	public String savepsfmAction() throws ParseException, SQLException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		session.getAttribute("BranchName");

		String mode = getMode();

		java.sql.Date sqlStartDate = null;
		if ((mode.equalsIgnoreCase("A")) || (mode.equalsIgnoreCase("E"))) {
			sqlStartDate = ClsCommon.changeStringtoSqlDate(getDate());
		}
		if (mode.equalsIgnoreCase("A")) {
			int val = pDAO.insertSubFamily(getSubfamilyname(), getCmbtype(),
					sqlStartDate, session, getMode(), getFormdetailcode());
			if (val > 0.0) {
				setDate(sqlStartDate + "");
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setMode(getMode());
				setDocno(val);

				setChkstatus("0");
				setMsg("Successfully Saved");
				return "success";
			} else if (val == -1) {
				setDate(sqlStartDate + "");
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setMode(getMode());

				setChkstatus("1");
				setMsg("Model Already Exists");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setMode(getMode());
				setDocno(val);

				setMsg("Not Saved");
				return "fail";
			}
		}

		else if (mode.equalsIgnoreCase("E")) {
			int Status = pDAO.editSubFamily(getSubfamilyname(), getDocno(),
					sqlStartDate, getCmbtype(), getMode(), session,
					getFormdetailcode());
			if (Status > 0) {
				setDate(sqlStartDate + "");
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());
				setMode(getMode());

				setChkstatus("0");
				setMsg("Updated Successfully");
				return "success";
			} else if (Status == -1) {
				setDate(sqlStartDate + "");
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());

				setChkstatus("2");
				setMsg("Model Already Exists");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());

				setMode(getMode());
				setMsg("Not Updated");
				return "fail";
			}
		} else if (mode.equalsIgnoreCase("D")) {
			int Status = pDAO.deleteSubFamily(getSubfamilyname(), getDocno(),
					sqlStartDate, getCmbtype(), getMode(), session,
					getFormdetailcode());
			if (Status > 0) {
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());
				setDate(sqlStartDate + "");

				setDeleted("DELETED");
				setMsg("Successfully Deleted");
				return "success";
			} else if (Status == -2) {
				setDate(sqlStartDate + "");
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());

				setMsg("References Present in Other Documents");
				return "fail";
			} else {
				setDate(sqlStartDate + "");
				setSubfamilyname(getSubfamilyname());
				setHidcmbtype(getCmbtype());
				setDocno(getDocno());

				setMsg("Not Deleted");
				return "fail";
			}
		}
		return "fail";
	}

}
