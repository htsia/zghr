package com.hr319wg.attence.web;

import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttFileImportBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AttImportRuleBackingBean extends BaseBackingBean {
	private static String status = "1";
	private IAttenceSetUCC attenceSetUCC;
	private String superId = super.getUserInfo().getOrgId();
	private String superName;
	private String pageInit;
	private PageVO mypage = new PageVO();
	private List lists;
	private String initEdit;
	private String atttype;
	private String atttype1;
	private String atttype2;
	private String atttype3;
	private String atttype4;
	private AttFileImportBO bo = new AttFileImportBO();
	private String importID;

	public String first() {
		mypage.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuery();
		return "";
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.superId);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			lists = attenceSetUCC.getAttFileImportBO(mypage, superId);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttFileImportBO attfileimportBO = (AttFileImportBO) lists
							.get(i);
					OrgBO b = SysCacheTool.findOrgById(this.superId);
					if (b != null) {
						attfileimportBO.setCreateOrgName(b.getName());
					}
					if (!"".equals(attfileimportBO.getFileFormat())) {
						if ("1".equals(attfileimportBO.getFileFormat())) {
							attfileimportBO.setFileFormatName("文本文件(*.TXT)");
						} else if("2".equals(attfileimportBO.getFileFormat())){
							attfileimportBO.setFileFormatName("EXCEL(*.CVS)");
						}else{
							attfileimportBO.setFileFormatName("EXCEL(*.XLS)");
						}
					}
					if (!"".equals(attfileimportBO.getTxtMode())) {
						if ("1".equals(attfileimportBO.getTxtMode())) {
							attfileimportBO.setTxtModeName("符号分割");
						} else {
							attfileimportBO.setTxtModeName("规定位置");
						}
					}
					
					if("TAB".equals(attfileimportBO.getSpiltChar())){
						attfileimportBO.setSpiltChar("制表符");
					}
					
					if (!"".equals(attfileimportBO.getCreateOrg())) {
						OrgBO b1 = SysCacheTool.findOrgById(attfileimportBO
								.getCreateOrg());
						if (b1 != null) {
							if (superId.equals(attfileimportBO.getCreateOrg())) {
								attfileimportBO.setCreateOrgName1(b1.getName());
								attfileimportBO.setStatus1(this.status);
							} else {
								attfileimportBO.setCreateOrgName1(b1.getName());
							}
						}
					}
					
					if(attfileimportBO.getTimeFormat()!=null && !"".equals(attfileimportBO.getTimeFormat())){
						if("0".equals(attfileimportBO.getTimeFormat())){
							attfileimportBO.setTimeFormatName("默认(yyyy-MM-dd hh:mm:ss)");
						}else if("1".equals(attfileimportBO.getTimeFormat())){
							attfileimportBO.setTimeFormatName("12小时制(yyyy-MM-dd AM/PM hh:mm:ss)");
						}
					}
					lists.set(i, attfileimportBO);

				}
			}
			if (superId != null) {
				String org = "-1";
				List lists1 = attenceSetUCC.getAttFileImportBO(mypage, org);
				if (lists1 != null && lists1.size() > 0) {
					for (int i = 0; i < lists1.size(); i++) {
						AttFileImportBO attfileimportBO1 = (AttFileImportBO) lists1
								.get(i);

						attfileimportBO1.setCreateOrgName("全集团");

						if (!"".equals(attfileimportBO1.getFileFormat())) {
							if ("1".equals(attfileimportBO1.getFileFormat())) {
								attfileimportBO1.setFileFormatName("文本文件(*.TXT)");
							} else if("2".equals(attfileimportBO1.getFileFormat())){
								attfileimportBO1.setFileFormatName("EXCEL(*.CVS)");
							}else{
								attfileimportBO1.setFileFormatName("EXCEL(*.XLS)");
							}
						}
						if (!"".equals(attfileimportBO1.getTxtMode())) {
							if ("1".equals(attfileimportBO1.getTxtMode())) {
								attfileimportBO1.setTxtModeName("符号分割");
							} else {
								attfileimportBO1.setTxtModeName("规定位置");
							}
						}

						if("TAB".equals(attfileimportBO1.getSpiltChar())){
							attfileimportBO1.setSpiltChar("制表符");
						}
						
						if (!"".equals(attfileimportBO1.getCreateOrg())) {
							OrgBO b1 = SysCacheTool
									.findOrgById(attfileimportBO1
											.getCreateOrg());
							if (b1 != null) {
								if (superId.equals(attfileimportBO1
										.getCreateOrg())) {
									attfileimportBO1.setCreateOrgName1(b1
											.getName());
									attfileimportBO1.setStatus1(this.status);
								} else {
									attfileimportBO1.setCreateOrgName1(b1
											.getName());
								}
							}
						}
						
						if(attfileimportBO1.getTimeFormat()!=null && !"".equals(attfileimportBO1.getTimeFormat())){
							if("0".equals(attfileimportBO1.getTimeFormat())){
								attfileimportBO1.setTimeFormatName("默认(yyyy-MM-dd hh:mm:ss)");
							}else if("1".equals(attfileimportBO1.getTimeFormat())){
								attfileimportBO1.setTimeFormatName("12小时制(yyyy-MM-dd AM/PM hh:mm:ss)");
							}
						}
						lists1.set(i, attfileimportBO1);
					}

					lists.addAll(lists1);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public AttFileImportBO getBo() {
		return bo;
	}

	public void setBo(AttFileImportBO bo) {
		this.bo = bo;
	}

	public String save() {
		bo.setCreateOrg(superId);
		bo.setOrgID(atttype);
		bo.setFileFormat(atttype1);
		bo.setTxtMode(atttype2);
		bo.setSpiltChar(atttype3);
		bo.setTimeFormat(atttype4);
		try {
			attenceSetUCC.saveorupdateAttFileImportBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";

	}

	public String delete() {
		try {
			if (importID != null) {
				attenceSetUCC.deleteAttFileImportBO(importID);
			}
		} catch (Exception e) {
			super.showMessageDetail("删除失败！");
		}
		return "";
	}

	public String getImportID() {
		return importID;
	}

	public void setImportID(String importID) {
		this.importID = importID;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("importID") != null
					&& !super.getRequestParameter("importID").equals("")
					&& super.getRequestParameter("oid") != null
					&& !super.getRequestParameter("oid").equals("")) {
				String importID = super.getRequestParameter("importID");
				String oid = super.getRequestParameter("oid");
				bo = attenceSetUCC.findAttFileImportBObyId(importID);
				if(!"-1".equals(bo.getCreateOrg())){
					atttype=bo.getCreateOrg();
					superId=bo.getCreateOrg();
					OrgBO b1 = SysCacheTool.findOrgById(bo.getCreateOrg());
					superName=b1.getName();
				}else{
					atttype="-1";
				}
				atttype1=bo.getFileFormat();
				atttype2=bo.getTxtMode();
				if("TAB".equals(bo.getSpiltChar())){
					atttype3="TAB";
				}else{
					atttype3=bo.getSpiltChar();
				}
				atttype4=bo.getTimeFormat();
			} else if (super.getRequestParameter("okID") != null) {
				bo.setImportID(null);
				bo.setImportName("");
				bo.setCreateOrg("");
				bo.setOrgID("");
				bo.setSpiltChar("");
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}

	public String getAtttype1() {
		return atttype1;
	}

	public void setAtttype1(String atttype1) {
		this.atttype1 = atttype1;
	}

	public String getAtttype2() {
		return atttype2;
	}

	public void setAtttype2(String atttype2) {
		this.atttype2 = atttype2;
	}

	public String getAtttype3() {
		return atttype3;
	}

	public void setAtttype3(String atttype3) {
		this.atttype3 = atttype3;
	}

	public String getAtttype4() {
		return atttype4;
	}

	public void setAtttype4(String atttype4) {
		this.atttype4 = atttype4;
	}

	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}

	public void changeStatus1(ValueChangeEvent event) {
		this.atttype1 = event.getNewValue().toString();
	}

	public void changeStatus2(ValueChangeEvent event) {
		this.atttype2 = event.getNewValue().toString();
	}
	
	public void changeStatus3(ValueChangeEvent event) {
		this.atttype3 = event.getNewValue().toString();
	}
	
	public void changeStatus4(ValueChangeEvent event) {
		this.atttype4 = event.getNewValue().toString();
	}
}
