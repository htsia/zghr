package com.hr319wg.emp.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.ConPostBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.pojo.vo.ConPostVO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class ConPostListBackingBean extends BaseBackingBean {
	private String superId;
	private List personList;
	private IPersonUCC personucc;

	public String getPageInit() {
		try {
			if (super.getRequestParameter("superId") != null) {
				this.superId = super.getRequestParameter("superId");
			}
			List list = this.personucc.findAllConPostPerson(this.superId);
			this.personList = new ArrayList();
			for (int i = 0; (list != null) && (i < list.size()); i++) {
				ConPostBO cb = (ConPostBO) list.get(i);
				ConPostVO cv = new ConPostVO();
				cv.setConPostID(cb.getConPostID());
				cv.setPersonID(cb.getPersonID());
				PersonBO pb = SysCacheTool.findPersonById(cb.getPersonID());
				if (pb == null) {
					continue;
				}
				cv.setPersonName(pb.getName());
				cv.setPersonCode(pb.getPersonCode());
				cv.setMainOrguid(cb.getMainOrguid());
				cv.setMainOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
						cb.getMainOrguid()));
				if (cb.getConOrguid1() != null) {
					cv.setConOrguid1(cb.getConOrguid1());
					cv.setConOrguid1Name(CodeUtil.interpertCode(
							CodeUtil.TYPE_ORG, cb.getConOrguid1()));
					pb = SysCacheTool.findPersonById("@" + cb.getPersonID());
					if (pb != null) {
						cv.setConDeptid1(pb.getDeptId());
						cv.setConDeptid1Name(CodeUtil.interpertCode(
								CodeUtil.TYPE_ORG, pb.getDeptId()));
					}
				}
				if (cb.getConOrguid2() != null) {
					cv.setConOrguid2(cb.getConOrguid2());
					cv.setConOrguid2Name(CodeUtil.interpertCode(
							CodeUtil.TYPE_ORG, cb.getConOrguid2()));
					pb = SysCacheTool.findPersonById("@@" + cb.getPersonID());
					if (pb != null) {
						cv.setConDeptid2(pb.getDeptId());
						cv.setConDeptid2Name(CodeUtil.interpertCode(
								CodeUtil.TYPE_ORG, pb.getDeptId()));
					}
				}
				if(cb.getConPostID1()!=null && !"".equals(cb.getConPostID1())){
					cv.setConPostID1(cb.getConPostID1());
					cv.setConPostID1Name(SysCacheTool.findPost(cb.getConPostID1()).getName());
					pb = SysCacheTool.findPersonById("@" + cb.getPersonID());
					if (pb != null) {
						cv.setConPostID1(pb.getPostId());
						cv.setConPostID1Name(SysCacheTool.findPost(pb.getPostId()).getName());
					}
				}
				if(cb.getConPostID2()!=null && !"".equals(cb.getConPostID2())){
					cv.setConPostID2(cb.getConPostID2());
					cv.setConPostID2Name(SysCacheTool.findPost(cb.getConPostID2()).getName());
					pb = SysCacheTool.findPersonById("@@" + cb.getPersonID());
					if (pb != null) {
						cv.setConPostID2(pb.getPostId());
						cv.setConPostID2Name(SysCacheTool.findPost(pb.getPostId()).getName());
					}
				}
				this.personList.add(cv);
			}
		} catch (Exception e) {
		}
		return this.pageInit;
	}

	public IPersonUCC getPersonucc() {
		return this.personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}

	public List getPersonList() {
		return this.personList;
	}

	public void setPersonList(List list) {
		this.personList = list;
	}

	public String getSuperId() {
		return this.superId;
	}

	public void setSuperId(String id) {
		this.superId = id;
	}
}