package com.hr319wg.emp.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;

public class PersonSortBackingBean extends BaseBackingBean {
	private String pageInit;
	private IPersonUCC personucc;
	private boolean onlyShowInService = true;

	public boolean isOnlyShowInService() {
		return this.onlyShowInService;
	}

	public void setOnlyShowInService(boolean onlyShowInService) {
		this.onlyShowInService = onlyShowInService;
	}

	public String getPageInit() {
		try {
			if ((getServletRequest().getParameter("superId") != null) && (!"".equals(getServletRequest().getParameter("superId")))) {
				PersonBO[] personlist = this.personucc.queryPersonBySuper(getServletRequest().getParameter("superId"), "00900", this.onlyShowInService);
				getServletRequest().setAttribute("sort_personlist", personlist);
			}
		} catch (Exception e) {
			e.printStackTrace();
			this.msg.setMainMsg(e, getClass());
		}
		return this.pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public IPersonUCC getPersonucc() {
		return this.personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}

	public String saveSort() {
		try {
			String[] orgids = getServletRequest().getParameterValues("showItem");
			if ((orgids != null) && (orgids.length > 0)) {
				PersonBO[] orgs = new PersonBO[orgids.length];
				for (int i = 0; i < orgs.length; i++) {
					PersonBO bo = SysCacheTool.findPersonById(orgids[i]);
					StringBuffer sort= new StringBuffer(bo.getDeptTreeId());
					int len=32-sort.length()-String.valueOf(i).length();
					for(int j=0;j<len;j++){
						sort.append("0");
					}
					sort.append(i);
					bo.setEmployOrder(sort.toString());
					orgs[i] = bo;
				}
				this.personucc.updatePersonSort(super.getUserInfo(), orgs);
				SysCache.setMap(orgids, 3, 6);
			}
			showMessageDetail("人员排序成功！");
		} catch (Exception e) {
			e.printStackTrace();
			showMessageDetail("错误:" + e.getMessage());
		}
		return null;
	}
}