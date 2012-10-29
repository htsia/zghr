package com.hr319wg.attence.web;

import com.hr319wg.attence.pojo.bo.AttRestOfWeekBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
public class FeastWorkMgrBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private String superId;
	private boolean isMon = false;
	private boolean isTues = false;
	private boolean isWed = false;
	private boolean isThur = false;
	private boolean isFri = false;
	private boolean isSat = false;
	private boolean isSun = false;
	private boolean isExist = false;

	public boolean getIsExist() {
		return isExist;
	}

	public void setIsExist(boolean isExist) {
		this.isExist = isExist;
	}

	public boolean getIsMon() {
		return isMon;
	}

	public void setIsMon(boolean isMon) {
		this.isMon = isMon;
	}

	public boolean getIsTues() {
		return isTues;
	}

	public void setIsTues(boolean isTues) {
		this.isTues = isTues;
	}

	public boolean getIsWed() {
		return isWed;
	}

	public void setIsWed(boolean isWed) {
		this.isWed = isWed;
	}

	public boolean getIsThur() {
		return isThur;
	}

	public void setIsThur(boolean isThur) {
		this.isThur = isThur;
	}

	public boolean getIsFri() {
		return isFri;
	}

	public void setIsFri(boolean isFri) {
		this.isFri = isFri;
	}

	public boolean getIsSat() {
		return isSat;
	}

	public void setIsSat(boolean isSat) {
		this.isSat = isSat;
	}

	public boolean getIsSun() {
		return isSun;
	}

	public void setIsSun(boolean isSun) {
		this.isSun = isSun;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getPageInit() {
		try {
			if (super.getRequestParameter("superId") != null) {
				superId = super.getRequestParameter("superId");
			}

			String superId1 = super.getUserInfo().getOrgId();
			if (superId.equals(superId1)) {
				doQuery();
			} else {
				isExist = false;
				isMon = false;
				isTues = false;
				isWed = false;
				isThur = false;
				isFri = false;
				isSat = false;
				isSun = false;
				isExist = false;
			}
		} catch (Exception e) {

		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}



	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	private void doQuery() {
		AttRestOfWeekBO attRestOfWeekBO = null;
		try {
			attRestOfWeekBO = attenceSetUCC.findAttRestOfWeekBObyId(superId);
			if (attRestOfWeekBO != null) {
				if ("0".equals(attRestOfWeekBO.getMon())) {
					isMon = true;
				} else {
					isMon = false;
				}
				if ("0".equals(attRestOfWeekBO.getTues())) {
					isTues = true;
				} else {
					isTues = false;
				}
				if ("0".equals(attRestOfWeekBO.getWed())) {
					isWed = true;
				} else {
					isWed = false;
				}
				if ("0".equals(attRestOfWeekBO.getThur())) {
					isThur = true;
				} else {
					isThur = false;
				}
				if ("0".equals(attRestOfWeekBO.getFri())) {
					isFri = true;
				} else {
					isFri = false;
				}
				if ("0".equals(attRestOfWeekBO.getSat())) {
					isSat = true;
				} else {
					isSat = false;
				}
				if ("0".equals(attRestOfWeekBO.getSun())) {
					isSun = true;
				} else {
					isSun = false;
				}
				attRestOfWeekBO = null;
			} else {
				AttRestOfWeekBO attRestOfWeekBO2 = new AttRestOfWeekBO();
				attRestOfWeekBO2.setOrgId(superId);
				attRestOfWeekBO2.setMon("1");
				attRestOfWeekBO2.setTues("1");
				attRestOfWeekBO2.setWed("1");
				attRestOfWeekBO2.setThur("1");
				attRestOfWeekBO2.setFri("1");
				attRestOfWeekBO2.setSat("1");
				attRestOfWeekBO2.setSun("1");
				attenceSetUCC.saveAttRestOfWeek(attRestOfWeekBO2);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		isExist = true;
	}

	public void save() {
		AttRestOfWeekBO attRestOfWeekBO1 = null;
		try {
			attRestOfWeekBO1 = attenceSetUCC.findAttRestOfWeekBObyId(superId);
			if (attRestOfWeekBO1 != null) {
				if (isMon == true) {
					attRestOfWeekBO1.setMon("0");
				} else {
					attRestOfWeekBO1.setMon("1");
				}
				if (isTues == true) {
					attRestOfWeekBO1.setTues("0");
				} else {
					attRestOfWeekBO1.setTues("1");
				}
				if (isWed == true) {
					attRestOfWeekBO1.setWed("0");
				} else {
					attRestOfWeekBO1.setWed("1");
				}
				if (isThur == true) {
					attRestOfWeekBO1.setThur("0");
				} else {
					attRestOfWeekBO1.setThur("1");
				}
				if (isFri == true) {
					attRestOfWeekBO1.setFri("0");
				} else {
					attRestOfWeekBO1.setFri("1");
				}
				if (isSat == true) {
					attRestOfWeekBO1.setSat("0");
				} else {
					attRestOfWeekBO1.setSat("1");
				}
				if (isSun == true) {
					attRestOfWeekBO1.setSun("0");
				} else {
					attRestOfWeekBO1.setSun("1");
				}

				attenceSetUCC.saveorupdateAttRestOfWeek(attRestOfWeekBO1);
				super.showMessageDetail("公休日，设置成功！");
			}
		} catch (SysException e) {
			e.printStackTrace();
		}

	}

	public void resave() {
		doQuery();
	}	
}
