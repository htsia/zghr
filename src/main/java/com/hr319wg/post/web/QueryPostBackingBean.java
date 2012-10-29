package com.hr319wg.post.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.ucc.IPostUCC;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class QueryPostBackingBean extends BaseBackingBean {
	private String name;
	private String org;
	private PostBO[] postList;
	private String flag = "1";
	private IPostUCC postucc;
	private UserAPI pmsapi;
	private String initByDept;

	public String getInitByDept() {
		if (super.getRequestParameter("superId") != null) {
			this.org = super.getRequestParameter("superId");
			queryPost();
		}
		return this.initByDept;
	}

	public void setInitByDept(String initByDept) {
		this.initByDept = initByDept;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOrg() {
		String superId = getServletRequest().getParameter("superId");
		if ((superId != null) && (!"".equals(superId.trim()))) {
			this.org = superId;
		}
		return this.org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public PostBO[] getPostList() {
		return this.postList;
	}

	public void setPostList(PostBO[] postList) {
		this.postList = postList;
	}

	public IPostUCC getPostucc() {
		return this.postucc;
	}

	public void setPostucc(IPostUCC postucc) {
		this.postucc = postucc;
	}

	public UserAPI getPmsapi() {
		return this.pmsapi;
	}

	public void setPmsapi(UserAPI pmsapi) {
		this.pmsapi = pmsapi;
	}

	public String getFlag() {
		String boolFlag = getServletRequest().getParameter("form1:flag");
		if (!"2".equals(boolFlag))
			;
		return this.flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String queryPost() {
		StringBuffer sql = new StringBuffer();
		sql.append("");
		if ((this.name != null) && (!"".equals(this.name))) {
			sql.append(" and p.name like '%" + this.name + "%'");
		}
		if ((this.org != null) && (!"".equals(this.org))) {
			OrgBO o = SysCacheTool.findOrgById(this.org);
			if (o != null)
				sql.append(" and p.orgTreeId like '" + o.getTreeId() + "%'");
		} else {
			User user = getUserInfo();
			String sqlP = this.pmsapi.getScaleConditionByType(user,
					"p.orgTreeId", "", "", "C", false, false);
			sql.append(" and ").append(sqlP);
		}

		sql.append(" and p.postTemp = '00900'");

		if ((sql != null) && (!"".equals(sql.toString()))) {
			try {
				this.postList = this.postucc.queryPost(sql.toString());
			} catch (SysException e) {
				super.showMessageDetail("记录数超过500条");
				return null;
			}
			if (this.postList != null) {
				for (int i = 0; i < this.postList.length; i++) {
					PostBO bo = this.postList[i];
					if (bo != null) {
						bo.setOrgId(OrgTool.getOrgByDeptName(bo.getOrgId()));
					}
				}
			}
			try {
				this.postList = ((PostBO[]) (PostBO[]) CodeUtil.codeInterpret(
						this.postList, "postClass", "CODE"));
			} catch (SysException e) {
				this.msg.setMainMsg(e, getClass());
			}
		}
		return null;
	}
}