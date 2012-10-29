package com.hr319wg.attence.web;

import java.util.List;

import com.hr319wg.attence.pojo.bo.AttAnnualDetailBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRecordBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;

public class NetWorkHolidayBackingBean extends BaseBackingBean {
	private String itemID;
	private String initEdit;
	private String pageInit;
	private List lists;
	private List lists1;
	private String userid = super.getUserInfo().getUserId();
	private IAttAnnualUCC attAnnualUcc;
	private PageVO mypage = new PageVO();

    public IAttAnnualUCC getAttAnnualUcc() {
        return attAnnualUcc;
    }

    public void setAttAnnualUcc(IAttAnnualUCC attAnnualUcc) {
        this.attAnnualUcc = attAnnualUcc;
    }

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
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getInitEdit() {
		if (super.getRequestParameter("itemID") != null
				&& !super.getRequestParameter("itemID").equals("")) {
			itemID = super.getRequestParameter("itemID");
		}
		doQuery1();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public List getLists1() {
		return lists1;
	}

	public void setLists1(List lists1) {
		this.lists1 = lists1;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public String doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			lists = attAnnualUcc.getAttAnnualItemBOByPid(mypage,userid);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttAnnualItemBO attannualitembo = (AttAnnualItemBO) lists.get(i);
			        attannualitembo.setPersonName(SysCacheTool.findPersonById(attannualitembo.getPersonID()).getName());
			        AttAnnualRecordBO attannualrecordbo=attAnnualUcc.findAttAnnualRecordBOById(attannualitembo.getRecID());
			        attannualitembo.setYearValues(attannualrecordbo.getRecodeYear());
			        attannualitembo.setStatusValue(attannualrecordbo.getStatusValue());
			        lists.set(i, attannualitembo);
				}
			}		
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public String doQuery1() {
		try {
			lists1 = attAnnualUcc.getAllAttAnnualDetailBOByItemId(itemID);
			if (lists1 != null && lists1.size() > 0) {
				for (int i = 0; i < lists1.size(); i++) {
					AttAnnualDetailBO attannualdetailbo=(AttAnnualDetailBO)lists1.get(i);
					lists1.set(i, attannualdetailbo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
		}
	
}
