package com.hr319wg.wage.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.faces.model.SelectItem;
import javax.servlet.http.HttpServletRequest;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.dao.CodeSetDAO;
import com.hr319wg.sys.pojo.bo.CodeSetBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageStandardBO;
import com.hr319wg.wage.pojo.bo.WageStdItemBO;
import com.hr319wg.wage.pojo.bo.WageStdValueBO;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.hr319wg.wage.pojo.vo.WageStandardVO;
import com.hr319wg.wage.ucc.IWageStandardUCC;

public class WageStandardBackingBean extends BaseBackingBean
{
  private WageStandardBO standard = new WageStandardBO();
  private List stdList;
  private IWageStandardUCC wagestandarducc;
  private WageStandardVO stdVO;
  private String unitName;
  private String unitId;
  private boolean operRight = false;
  private String beginView;
  private List filterFields;
  private String hCode;
  private String vCode;
  private List codeSet;
  
  public String gethCode() {
	return hCode;
}

public void sethCode(String hCode) {
	this.hCode = hCode;
}

public String getvCode() {
	return vCode;
}

public void setvCode(String vCode) {
	this.vCode = vCode;
}

public List getCodeSet() {
	  if (this.codeSet == null) {
	      this.codeSet = new ArrayList();
	      SelectItem si0 = new SelectItem();
	      si0.setValue("-1");
	      si0.setLabel("--请选择--");
	      this.codeSet.add(si0);
		try {
			CodeSetDAO setDao = (CodeSetDAO)SysContext.getBean("sys_CodeSetDAO");
			List<CodeSetBO> setList1 = setDao.queryCodeSets(true);
		  	if(setList1!=null){
		  		for(CodeSetBO set : setList1){
		  			if(super.getUserInfo().getOrgId().equals(set.getCreateUnit()) || "1".equals(set.getPublicFlag())){
		  				SelectItem si = new SelectItem();
		  	            si.setValue(set.getSetId());
		  	            si.setLabel(set.getSetName());
		  	            this.codeSet.add(si);
		  			}
		  		}
		  	}
		} catch (SysException e) {
			e.printStackTrace();
		}
	  }
	    return this.codeSet;
}

public void setCodeSet(List codeSet) {
	this.codeSet = codeSet;
}

  private boolean canEdit = true;

  public boolean isCanEdit()
  {
    return this.canEdit;
  }

  public void setCanEdit(boolean canEdit) {
    this.canEdit = canEdit;
  }

  public List getFilterFields()
  {
    if (this.filterFields == null) {
      this.filterFields = new ArrayList();
      SelectItem si0 = new SelectItem();
      si0.setValue("-1");
      si0.setLabel("选择项目");
      this.filterFields.add(si0);
      List list = SysCacheTool.queryInfoItemBySetId("A796");
      for (int i = 0; i < list.size(); i++) {
        InfoItemBO ib = (InfoItemBO)list.get(i);
        if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(ib.getItemProperty())) {
          SelectItem si = new SelectItem();
          si.setValue(ib.getItemId());
          si.setLabel(ib.getItemNameEx());
          this.filterFields.add(si);
        }
      }
    }
    return this.filterFields;
  }
  public void setFilterFields(List list) {
    this.filterFields = list;
  }

  public String getPageInit() {
    String act = super.getServletRequest().getParameter("act");
    String persId = super.getUserInfo().getUserId();
    PersonBO person = SysCacheTool.findPersonById(persId);
    String userUnitId = person.getGongZiGX();
    if ("list".equals(act)) {
      this.unitId = super.getServletRequest().getParameter("unitId");

      WageUnitBO paraUnit = SysCacheTool.findWageUnit(this.unitId);

      WageUnitBO userUnit = SysCacheTool.findWageUnit(userUnitId);
      if (userUnit == null) {
        super.showMessageDetail("错误：用户没有发薪单位");
        return "";
      }
      if (("00901".equals(userUnit.getManageFlag())) && 
        (paraUnit.getTreeId().length() <= userUnit.getTreeId().length() - 3)) {
        this.unitId = userUnit.getUnitId();
      }

      this.operRight = this.unitId.equals(userUnit.getUnitId());

      if (this.standard == null) this.standard = new WageStandardBO();
      this.standard.setUnitId(this.unitId);
      this.stdList = queryStdList(this.unitId);
      super.getHttpSession().removeAttribute("stdVO");
      this.unitName = CodeUtil.interpertCode("WAGE", this.unitId);
    }
    return this.pageInit;
  }

  public WageStandardBO getStandard() {
    return this.standard;
  }
  public void setStandard(WageStandardBO standard) {
    this.standard = standard;
  }

  public boolean isOperRight() {
    return this.operRight;
  }

  public void setOperRight(boolean operRight) {
    this.operRight = operRight;
  }

  public String getUnitName() {
    return this.unitName;
  }

  public void setUnitName(String unitName) {
    this.unitName = unitName;
  }

  public List getStdList() {
    return this.stdList;
  }

  public void setStdList(List stdList) {
    this.stdList = stdList;
  }

  public IWageStandardUCC getWagestandarducc() {
    return this.wagestandarducc;
  }

  public void setWagestandarducc(IWageStandardUCC wagestandarducc) {
    this.wagestandarducc = wagestandarducc;
  }

  private List queryStdList(String unitId) {
    List list = new ArrayList();
    try {
      List issueStd = this.wagestandarducc.queryIssueStandard();
      if (issueStd != null) {
        int count = issueStd.size();
        for (int i = 0; i < count; i++) {
          WageStandardBO tmp = (WageStandardBO)issueStd.get(i);
          tmp.setPublicFlag(CodeUtil.interpertCode("", tmp.getPublicFlag()));
          Object[] obj = new Object[3];
          obj[0] = tmp;
          if (!unitId.equals(tmp.getUnitId())) {
            obj[1] = "disabled";
            obj[2] = new Boolean(false);
          } else {
            obj[1] = "";
            obj[2] = new Boolean(true);
          }
          list.add(obj);
        }
      }
      List unitStd = this.wagestandarducc.queryStandardByUnitId(unitId);
      if (unitStd != null) {
        int count = unitStd.size();
        for (int i = 0; i < count; i++) {
          WageStandardBO tmp = (WageStandardBO)unitStd.get(i);
          if ("00900".equals(tmp.getPublicFlag())) {
            tmp.setPublicFlag(CodeUtil.interpertCode("", tmp.getPublicFlag()));
            Object[] obj = new Object[3];
            obj[0] = tmp;
            obj[1] = "";
            obj[2] = new Boolean(true);
            list.add(obj);
          }
        }
      }
      return list;
    }
    catch (SysException e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    return list;
  }

  public String list()
  {
    super.getHttpSession().removeAttribute("stdVO");

    this.stdList = queryStdList(this.unitId);
    return "list";
  }

  public String delete()
  {
    try
    {
      String[] id = super.getServletRequest().getParameterValues("selectItem");
      if ((id != null) && (id.length > 0)) {
        this.wagestandarducc.batchDeleteStandard(id);
        super.showMessageDetail("删除标准表成功");
      }
    }
    catch (Exception e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    return list();
  }

  public String issueStandard()
  {
    try
    {
      String[] id = super.getServletRequest().getParameterValues("selectItem");
      if ((id != null) && (id.length > 0)) {
        this.wagestandarducc.updateFlagIssue(id);
        super.showMessageDetail("公共标准表已发布");
      }
    }
    catch (Exception e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    return list();
  }

  public String banStandard()
  {
    try
    {
      String[] id = super.getServletRequest().getParameterValues("selectItem");
      if ((id != null) && (id.length > 0)) {
        this.wagestandarducc.updateFlagBan(id);
        super.showMessageDetail("公共标准表已撤销");
      }
    }
    catch (Exception e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    return list();
  }

  public String step1_create()
  {
    WageStandardBO std = new WageStandardBO();
    std.setUnitId(this.standard.getUnitId());
    this.standard = std;
    return step1_setItem();
  }

  public String step1_setItem()
  {
    String stdId = this.standard.getStdId();
    this.stdVO = ((WageStandardVO)super.getHttpSession().getAttribute("stdVO"));
    try {
      if ((stdId != null) && (!"".equals(stdId)) && (this.stdVO == null)) {
        this.stdVO = new WageStandardVO();
        ArrayList h_list = (ArrayList)this.wagestandarducc.queryStdItemByType(stdId, "0");
        this.stdVO.setH_item(h_list);
        if(h_list!=null && h_list.size()>0){
        	WageStdItemBO std = (WageStdItemBO)h_list.get(0);
        	String codeSet=std.getCodeSetId();
        	CodeSetBO set= SysCacheTool.findCodeSet(codeSet);
        	if(set.getCreateUnit()!=null){
        		this.hCode=codeSet;
        	}
        }
        
        ArrayList v_list = (ArrayList)this.wagestandarducc.queryStdItemByType(stdId, "1");
        this.stdVO.setV_item(v_list);
        if(v_list!=null && v_list.size()>0){
        	WageStdItemBO std = (WageStdItemBO)v_list.get(0);
        	String codeSet=std.getCodeSetId();
        	CodeSetBO set= SysCacheTool.findCodeSet(codeSet);
        	if(set.getCreateUnit()!=null){
        		this.vCode=codeSet;
        	}
        }
        
        ArrayList r_list = (ArrayList)this.wagestandarducc.queryStdItemByType(stdId, "2");
        this.stdVO.setR_item(r_list);

        WageStdItemBO bo = (WageStdItemBO)r_list.get(0);
        InfoItemBO infoitem = SysCacheTool.findInfoItem(bo.getTable(), bo.getField());
        this.standard.setName(infoitem.getItemName());
        List vList= this.stdVO.getV_item();
        
        
        super.getHttpSession().setAttribute("stdVO", this.stdVO);
      } else if (this.stdVO == null) {
        this.stdVO = new WageStandardVO();
        super.getHttpSession().setAttribute("stdVO", this.stdVO);
      }
    }
    catch (SysException e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }

    return "editItem";
  }

  public String step2_setCode()
  {
    this.stdVO = ((WageStandardVO)super.getHttpSession().getAttribute("stdVO"));
    HttpServletRequest request = super.getServletRequest();
    String[] vItemIds = request.getParameterValues("VItemIds");
    String[] hItemIds = request.getParameterValues("HItemIds");
    String[] rItemIds = request.getParameterValues("RItemIds");
    this.stdVO.setR_item(handleItem(rItemIds, "2", this.stdVO.getR_item()));
    if (vItemIds != null) {
      this.stdVO.setV_item(handleItem(vItemIds, "1", this.stdVO.getV_item()));
    }
    if (hItemIds != null) {
    	this.stdVO.setH_item(handleItem(hItemIds, "0", this.stdVO.getH_item()));
    }
    super.getHttpSession().setAttribute("stdVO", this.stdVO);
    return "editCode";
  }

  private ArrayList handleItem(String[] item, String type, ArrayList list) {
    ArrayList newList = new ArrayList();
    if ((item != null) && (item.length > 0)) {
      for (int i = 0; i < item.length; i++) {
        InfoItemBO infoitem = SysCacheTool.findInfoItem(item[i].substring(0, 4), item[i]);
          WageStdItemBO stditem = new WageStdItemBO();
          stditem.setType(type);
          stditem.setTable(item[i].substring(0, 4));
          stditem.setField(infoitem.getItemId());
          stditem.setDataType(infoitem.getItemDataType());
          stditem.setCodeSetId(infoitem.getItemCodeSet());
          
          if("1".equals(type) && this.vCode!=null && !"-1".equals(this.vCode)){
        	  stditem.setCodeSetId(this.vCode);
          }
          if("0".equals(type) && this.hCode!=null && !"-1".equals(this.hCode)){
        	  stditem.setCodeSetId(this.hCode);
          }
          
          newList.add(stditem);
          
          if (type.equals("2"))
            this.standard.setName(infoitem.getItemName() + "标准");
         }
    }
    return newList;
  }

  public String step3_setValue()
  {
    this.stdVO = ((WageStandardVO)super.getHttpSession().getAttribute("stdVO"));
    ArrayList h_item = this.stdVO.getH_item();
    ArrayList v_item = this.stdVO.getV_item();
    Hashtable rs_value = this.stdVO.getRs_value();

    int count = h_item.size();
    for (int i = 0; i < count; i++) {
      WageStdItemBO item = (WageStdItemBO)h_item.get(i);
      String[] tmp = super.getServletRequest().getParameterValues("h_" + item.getField());
      if ((tmp != null) && (tmp.length != 0)) {
        item.setCodeValue(CommonFuns.StrArray2String(filterCodeNode(tmp), ","));
        h_item.set(i, item);
      }
    }
    count = v_item.size();
    for (int i = 0; i < count; i++) {
      WageStdItemBO item = (WageStdItemBO)v_item.get(i);
      String[] tmp = super.getServletRequest().getParameterValues("v_" + item.getField());
      if ((tmp != null) && (tmp.length != 0)) {
        item.setCodeValue(CommonFuns.StrArray2String(filterCodeNode(tmp), ","));
        v_item.set(i, item);
      }
    }
    if (rs_value.size() == 0)
    {
      String stdId = this.standard.getStdId();
      if ((stdId != null) && (!"".equals(stdId))) {
        try {
          List value = this.wagestandarducc.queryStdValueByStdId(stdId);
          if (value != null) {
            count = value.size();
            for (int i = 0; i < count; i++) {
              WageStdValueBO tmp = (WageStdValueBO)value.get(i);
              rs_value.put(CommonFuns.filterNull(tmp.gethValue()) + "|" + CommonFuns.filterNull(tmp.getvValue()), tmp);
            }
          }
        }
        catch (SysException e) {
          super.showMessageDetail("错误:" + e.getMessage());
        }
      }
      super.getHttpSession().setAttribute("stdVO", this.stdVO);
    }
    return "editValue";
  }

  private String[] filterCodeNode(String[] tmp) {
    return tmp;
  }

  public String step4_setName()
  {
    this.stdVO = ((WageStandardVO)super.getHttpSession().getAttribute("stdVO"));
    Hashtable rs_value = this.stdVO.getRs_value();
    ArrayList HColName = this.stdVO.getHColName();
    ArrayList VRowName = this.stdVO.getVRowName();
    int cols = HColName.size();
    int rows = VRowName.size();
    if (cols == 0) cols = 1;
    if (rows == 0) rows = 1;
    rs_value.clear();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        String hname = HColName.size() > j ? (String)HColName.get(j) : "";
        String vname = VRowName.size() > i ? (String)VRowName.get(i) : "";
        String key = CommonFuns.filterNull(hname) + "|" + CommonFuns.filterNull(vname);
        String cellValue = CommonFuns.filterNull(super.getServletRequest().getParameter(key));
        WageStdValueBO vobj = new WageStdValueBO();
        vobj.sethValue(hname);
        vobj.setvValue(vname);
        vobj.setCellValue(cellValue);
        rs_value.put(key, vobj);
      }
    }
    super.getHttpSession().setAttribute("stdVO", this.stdVO);
    try {
      String stdId = this.standard.getStdId();
      if ((stdId != null) && (!"".equals(stdId))) {
        this.standard = this.wagestandarducc.findStandardByStdId(stdId);
        if ((this.standard.getSaveAsField() != null) && (!"".equals(this.standard.getSaveAsField())))
          this.standard.setSaveAsFieldDes(CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, this.standard.getSaveAsField()));
      }
    }
    catch (SysException e)
    {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    return "editName";
  }

  public String save()
  {
    try
    {
      this.standard.setName(this.standard.getName().trim());

      this.stdVO = ((WageStandardVO)super.getHttpSession().getAttribute("stdVO"));
      List r_stdItem = this.stdVO.getStdItem();
      List r_stdvalue = this.stdVO.getStdValue();
      this.standard.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      String stdId = this.standard.getStdId();
      if ("-1".equals(this.standard.getFilterField())) {
        this.standard.setFilterField("");
        this.standard.setFilterOper("");
        this.standard.setFilterValue("");
      }
      if ((stdId == null) || ("".equals(stdId))) {
        this.wagestandarducc.createStandard(this.standard, r_stdItem, r_stdvalue);
        super.showMessageDetail("新建标准表成功");
      } else {
        this.wagestandarducc.updateStandard(this.standard, r_stdItem, r_stdvalue);
        super.showMessageDetail("保存标准表成功");
      }
    }
    catch (SysException e)
    {
      super.showMessageDetail("错误:" + e.getMessage());
      return null;
    }
    return list();
  }

  public String getBeginView() {
    if (super.getRequestParameter("StandardID") != null) {
      this.standard.setStdId(super.getRequestParameter("StandardID"));
      view();
    }
    return this.beginView;
  }

  public void setBeginView(String view)
  {
    this.beginView = view;
  }

  public String send() {
    return "";
  }
  public String saveCopy() {
    try {
      this.wagestandarducc.saveCopy(this.standard.getStdId());
    }
    catch (Exception e)
    {
    }
    return list();
  }
  public String view() {
    WageStandardVO stdVO = new WageStandardVO();
    String stdId = this.standard.getStdId();
    try {
      this.standard = this.wagestandarducc.findStandardByStdId(stdId);
      stdVO.setStandardName(this.standard.getName());
      ArrayList h_list = (ArrayList)this.wagestandarducc.queryStdItemByType(stdId, "0");
      stdVO.setH_item(h_list);
      ArrayList v_list = (ArrayList)this.wagestandarducc.queryStdItemByType(stdId, "1");
      stdVO.setV_item(v_list);
      ArrayList r_list = (ArrayList)this.wagestandarducc.queryStdItemByType(stdId, "2");
      stdVO.setR_item(r_list);
      List value = this.wagestandarducc.queryStdValueByStdId(stdId);
      Hashtable rs_value = stdVO.getRs_value();
      if (value != null) {
        int count = value.size();
        for (int i = 0; i < count; i++) {
          WageStdValueBO tmp = (WageStdValueBO)value.get(i);
          rs_value.put(CommonFuns.filterNull(tmp.gethValue()) + "|" + CommonFuns.filterNull(tmp.getvValue()), tmp);
        }
      }
      super.getHttpSession().setAttribute("stdVO", stdVO);
      super.getServletRequest().setAttribute("act", "view");
      this.canEdit = false;
    }
    catch (SysException e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    return "editValue";
  }

  public String getUnitId()
  {
    return this.unitId;
  }

  public void setUnitId(String unitId) {
    this.unitId = unitId;
  }
}