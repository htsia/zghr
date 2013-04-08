package com.hr319wg.sys.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.faces.model.SelectItem;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.pojo.bo.CodeSetBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.ucc.ICodeSetUCC;
import com.hr319wg.sys.ucc.IInfoItemUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class InfoItemEditBackingBean extends BaseBackingBean {
	private IInfoItemUCC infoitemucc;
	private ICodeSetUCC codesetucc;
	private boolean showOnlyUser = false;
	private String jy1006bh;
	private String jy1006name;
	private String codeByOrg;
	private String gb14946;
	private boolean showOnlyOpen = true;
	private String itemId;
	private String setId;
	private String setName;
	private String itemName;
	private String itemDesc;
	private String itemDataType;
	private String itemDataLength = "20";
	private String itemIsSelect;
	private String itemPrecision;
	private String itemMax;
	private String itemMin;
	private String itemNotNull = "0";

	private String itemSequence = "99";

	private String itemStatus = "1";
	private String itemDefaultValue;
	private String itemFormula;
	private String itemCodeSet;
	private String itemSelf = "1";

	private String itemProperty = "4";
	private String itemIssue;
	private String itemClass;
	private List codeSetList;
	private boolean editStatus;
	private String set_sType;
	private String canInport;
	private String modiInWage;
	private String itemMust;
	private String initEdit;
	private ICommonService commonService;
	
	public String getItemClass() {
		return itemClass;
	}

	public void setItemClass(String itemClass) {
		this.itemClass = itemClass;
	}

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public String getCodeByOrg() {
		return this.codeByOrg;
	}

	public void setCodeByOrg(String codeByOrg) {
		this.codeByOrg = codeByOrg;
	}

	public String getGb14946() {
		return this.gb14946;
	}

	public void setGb14946(String gb14946) {
		this.gb14946 = gb14946;
	}

	public String getJy1006bh() {
		return this.jy1006bh;
	}

	public void setJy1006bh(String jy1006bh) {
		this.jy1006bh = jy1006bh;
	}

	public String getJy1006name() {
		return this.jy1006name;
	}

	public void setJy1006name(String jy1006name) {
		this.jy1006name = jy1006name;
	}

	public boolean isShowOnlyUser() {
		return this.showOnlyUser;
	}

	public void setShowOnlyUser(boolean showOnlyUser) {
		this.showOnlyUser = showOnlyUser;
	}

	public boolean isShowOnlyOpen() {
		return this.showOnlyOpen;
	}

	public void setShowOnlyOpen(boolean showOnlyOpen) {
		this.showOnlyOpen = showOnlyOpen;
	}

	public String getCanInport() {
		return this.canInport;
	}

	public void setCanInport(String inport) {
		this.canInport = inport;
	}

	public String getModiInWage() {
		return this.modiInWage;
	}

	public void setModiInWage(String inport) {
		this.modiInWage = inport;
	}

	public String getItemMust() {
		return this.itemMust;
	}

	public void setItemMust(String itemMust) {
		this.itemMust = itemMust;
	}

	public String getSet_sType() {
		return this.set_sType;
	}

	public void setSet_sType(String set_sType) {
		this.set_sType = set_sType;
	}

	public List getCodeSetList() {
		this.codeSetList = new ArrayList();

		SelectItem im = new SelectItem();
		im.setLabel("");
		im.setValue("-1");
		this.codeSetList.add(im);
		try {
			List list = this.codesetucc.queryCodeSets();
			for (int i = 0; i < list.size(); i++) {
				CodeSetBO cs = (CodeSetBO) list.get(i);
				SelectItem item = new SelectItem();
				item.setLabel(cs.getSetNameEx());
				item.setValue(cs.getSetId());
				this.codeSetList.add(item);
			}
		} catch (Exception e) {
		}
		return this.codeSetList;
	}

	public ICodeSetUCC getCodesetucc() {
		return this.codesetucc;
	}

	public void setCodesetucc(ICodeSetUCC codesetucc) {
		this.codesetucc = codesetucc;
	}

	public void setCodeSetList(List codeSetList) {
		this.codeSetList = codeSetList;
	}

	public String getSetName() {
		return this.setName;
	}

	public void setSetName(String setName) {
		this.setName = setName;
	}

	public String getItemId() {
		return this.itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getSetId() {
		return this.setId;
	}

	public void setSetId(String setId) {
		this.setId = setId;
	}

	public String getItemName() {
		return this.itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemDesc() {
		return this.itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public String getItemDataType() {
		return this.itemDataType;
	}

	public void setItemDataType(String itemDataType) {
		this.itemDataType = itemDataType;
	}

	public String getItemDataLength() {
		return this.itemDataLength;
	}

	public void setItemDataLength(String itemDataLength) {
		this.itemDataLength = itemDataLength;
	}

	public String getItemIsSelect() {
		return this.itemIsSelect;
	}

	public void setItemIsSelect(String itemIsSelect) {
		this.itemIsSelect = itemIsSelect;
	}

	public String getItemPrecision() {
		return this.itemPrecision;
	}

	public void setItemPrecision(String itemPrecision) {
		this.itemPrecision = itemPrecision;
	}

	public String getItemMax() {
		return this.itemMax;
	}

	public void setItemMax(String itemMax) {
		this.itemMax = itemMax;
	}

	public String getItemMin() {
		return this.itemMin;
	}

	public void setItemMin(String itemMin) {
		this.itemMin = itemMin;
	}

	public String getItemNotNull() {
		return this.itemNotNull;
	}

	public void setItemNotNull(String itemNotNull) {
		this.itemNotNull = itemNotNull;
	}

	public String getItemSequence() {
		return this.itemSequence;
	}

	public void setItemSequence(String itemSequence) {
		this.itemSequence = itemSequence;
	}

	public String getItemStatus() {
		return this.itemStatus;
	}

	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}

	public String getItemDefaultValue() {
		return this.itemDefaultValue;
	}

	public void setItemDefaultValue(String itemDefaultValue) {
		this.itemDefaultValue = itemDefaultValue;
	}

	public String getItemFormula() {
		return this.itemFormula;
	}

	public void setItemFormula(String itemFormula) {
		this.itemFormula = itemFormula;
	}

	public String getItemCodeSet() {
		return this.itemCodeSet;
	}

	public void setItemCodeSet(String itemCodeSet) {
		this.itemCodeSet = itemCodeSet;
	}

	public String getItemSelf() {
		return this.itemSelf;
	}

	public void setItemSelf(String itemSelf) {
		this.itemSelf = itemSelf;
	}

	public String getItemProperty() {
		return this.itemProperty;
	}

	public void setItemProperty(String itemProperty) {
		this.itemProperty = itemProperty;
	}

	public String getItemIssue() {
		return this.itemIssue;
	}

	public void setItemIssue(String itemIssue) {
		this.itemIssue = itemIssue;
	}

	public IInfoItemUCC getInfoitemucc() {
		return this.infoitemucc;
	}

	public void setInfoitemucc(IInfoItemUCC infoitemucc) {
		this.infoitemucc = infoitemucc;
	}

	public boolean isEditStatus() {
		return this.editStatus;
	}

	public void setEditStatus(boolean editStatus) {
		this.editStatus = editStatus;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("itemId") != null) {
				this.setId = super.getRequestParameter("setId");
				this.setName = CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, this.setId);
				this.itemId = super.getRequestParameter("itemId");
				findInfoItem();
				this.editStatus = true;
			} else if (super.getRequestParameter("setId") != null) {
				this.setId = super.getRequestParameter("setId");
				this.setName = CodeUtil.interpertCode(CodeUtil.TYPE_INFOSET, this.setId);
				this.editStatus = false;
			}
		} catch (Exception e) {
		}
		return this.initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getPageInit() {
		try {
			HttpServletRequest request = super.getServletRequest();
			String[] v = request.getParameterValues("formInfoItemEdit:pageInit");
			if (v == null) {
				this.pageInit = "";
			} else {
				this.pageInit = v[0];
				this.pageInit = CommonFuns.filterNull(this.pageInit);
			}
			if (!this.pageInit.equals("isPostBack")) {
				findInfoItem();
			}
			this.pageInit = "isPostBack";
		} catch (Exception e) {
			e.printStackTrace();
		}

		return this.pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public void findInfoItem() throws SysException, SysException {
		if ((this.setId != null) && (!this.setId.equals("")) && (this.itemId != null) && (!this.itemId.equals(""))) {
			InfoItemBO cItem = null;
			cItem = this.infoitemucc.findInfoItem(this.setId, this.itemId);
			CommonFuns.copyProperties(this, cItem);
		}
	}

	public String saveInfoItem() {
		try {
			if ("-1".equals(this.itemCodeSet)) {
				if ("6".equals(this.itemDataType)) {
					showMessageDetail("请选择有效的代码集!");
					return "";
				}

				this.itemCodeSet = "";
			}

			InfoItemBO ci = new InfoItemBO();
			CommonFuns.copyProperties(ci, this);

			if ("7".equals(this.itemDataType))
				ci.setItemCodeSet("OU");
			else if ("12".equals(this.itemDataType))
				ci.setItemCodeSet("PA");
			else if ("11".equals(this.itemDataType))
				ci.setItemCodeSet("PO");
			else if ("8".equals(this.itemDataType))
				ci.setItemCodeSet("PE");
			else if ("13".equals(this.itemDataType)) {
				ci.setItemCodeSet("WA");
			}
			if (!this.editStatus) {
				String newItemId = this.infoitemucc.getNewItemId(this.setId);
				if (newItemId.equals("")) {
					showMessageDetail("已经到达了所允许建立指标项的最大数，详细请与系统管理员联系!");
					return "";
				}

				HttpSession session = super.getHttpSession();
				User user = (User) session.getAttribute("USER_INFO");

				ci.setItemId(newItemId);
				this.infoitemucc.createInfoItem(ci, user.getUserId());

				List list = new ArrayList();
				list.add(ci);
				SysCache.updateInfoItemBySetId(ci.getSetId());

				Hashtable hash = user.getPmsInfoItem();
				hash.put(ci.getItemId(), "3");
				showMessageDetail("添加成功!");
			} else {
				this.commonService.updateInfoItem(ci);
				List list = new ArrayList();
				list.add(ci);
				SysCache.setMap(list, 3, 4);
				SysCache.updateInfoItemBySetId(ci.getSetId());
				showMessageDetail("修改成功!");
			}
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "itemlist";
	}
}