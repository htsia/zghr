package com.hr319wg.wage.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import org.apache.myfaces.custom.fileupload.UploadedFile;
import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.inputTemplateBO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.ucc.IInputTemplateUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;
import com.hr319wg.util.ListMap;
import com.hr319wg.wage.pojo.bo.WageDateBO;
import com.hr319wg.wage.pojo.bo.WageImportSetBO;
import com.hr319wg.wage.pojo.bo.WageInputitemPowerBO;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.ucc.IWageDateUCC;
import com.hr319wg.wage.ucc.IWageDeptUCC;
import com.hr319wg.wage.ucc.IWageImportSetUCC;
import com.hr319wg.wage.ucc.IWageItemPowerUCC;
import com.hr319wg.wage.ucc.IWagePersonQueryUCC;
import com.hr319wg.wage.ucc.IWageSetItemUCC;
import com.hr319wg.wage.ucc.IWageSetPersonUCC;
import com.hr319wg.wage.util.WageTools;

public class WageSetInputItemBackingBean extends BaseBackingBean
{
	private boolean operRight;
	private String setId;
	private String setName;
	private String unitId;
	private IWageDateUCC wagedateucc;
	private String unitName;
	private String dateId;
	private String payoffDate;
	private Object[] personlist;
	private List inputList;
	private List selitem;
	private String configname;
	private String[] inputField;
	private boolean isPublic = false;
	private List templateList;
	private String[] persId;
	private IWageSetPersonUCC wagesetpersonucc;
	private IWageSetItemUCC wagesetitemucc;
	private IWagePersonQueryUCC wagepersonqueryucc;
	private IWageImportSetUCC wageimportsetucc;
	private IWageDeptUCC wagedeptucc;
	private IWageItemPowerUCC wagepowerucc;
	private UploadedFile excelFile;
	private String errorFileUrl = "";
	private boolean showError = false;
	private String isTry;
	private String template;
	private IInputTemplateUCC inputtemp;
	private String initSingleEdit;
	private boolean showOnlyCheck = true;
	private String turnPage;
	private JdbcTemplate jdbcTemplate;
	private IWageDataService dataService;
  
	public IWageDataService getDataService() {
		return dataService;
	}

	public void setDataService(IWageDataService dataService) {
		this.dataService = dataService;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public boolean isShowOnlyCheck() {
		return this.showOnlyCheck;
	}

	public void setShowOnlyCheck(boolean showOnlyCheck) {
		this.showOnlyCheck = showOnlyCheck;
	}

	  public String getInitSingleEdit()
	  {
	    try
	    {
	      if (super.getRequestParameter("setId") != null) {
	        this.setId = super.getRequestParameter("setId");
	        this.dateId = super.getRequestParameter("dateId");
	        String inputField = "";
	        List itemList = this.wagedeptucc.getAllItemPowerByPerson(super.getUserInfo().getUserId(), this.setId);
	        if ((itemList == null) || (itemList.size() == 0)) {
	          itemList = this.wagesetitemucc.queryInputItemBySetId(this.setId, true);
	          if (itemList != null) {
	            for (int i = 0; i < itemList.size(); i++) {
	              SelectItem item = new SelectItem();
	              WageSetItemBO setItem = (WageSetItemBO)itemList.get(i);
	              InfoItemBO ib = SysCacheTool.findInfoItem("", setItem.getField());
	              if (ib != null)
	                if ("".equals(inputField)) inputField = ib.getItemId(); else
	                  inputField = inputField + "," + ib.getItemId();
	            }
	          }
	        }
	        else
	        {
	          for (int i = 0; i < itemList.size(); i++) {
	            WageInputitemPowerBO wb = (WageInputitemPowerBO)itemList.get(i);
	            if ("".equals(inputField)) inputField = wb.getItemID(); else
	              inputField = inputField + "," + wb.getItemID();
	          }
	        }
	        HttpSession session = super.getHttpSession();
	        String[] fs = inputField.split(",");
	        session.setAttribute("field", fs);
	        String[] pids = super.getRequestParameter("perID").split(",");
	        session.setAttribute("persId", pids);
	        HashMap hash = this.wagesetpersonucc.queryPersonItemByItemId(this.setId, pids, fs);
	        super.getServletRequest().setAttribute("value", hash);
	      }
	    }
	    catch (Exception e)
	    {
	    }
	    return this.initSingleEdit;
	  }

	public void setInitSingleEdit(String initSingleEdit) {
		this.initSingleEdit = initSingleEdit;
	}

	public IInputTemplateUCC getInputtemp() {
		return this.inputtemp;
	}

	public void setInputtemp(IInputTemplateUCC value) {
		this.inputtemp = value;
	}

	public String getIsTry() {
		return this.isTry;
	}

	public void setIsTry(String is) {
		this.isTry = is;
	}

  public List getTemplateList() {
    if (this.templateList == null) {
      this.templateList = new ArrayList();
      SelectItem s3 = new SelectItem();
      s3.setLabel("--请选择录入模版--");
      s3.setValue("-1");
      this.templateList.add(s3);
      inputTemplateBO[] bos = this.inputtemp.getAllTemplateByWageSet(this.setId);
      if (bos != null) {
        for (int i = 0; i < bos.length; i++) {
          SelectItem s4 = new SelectItem();
          s4.setLabel(bos[i].getTempname());
          s4.setValue(bos[i].getTempid());
          this.templateList.add(s4);
        }
      }
    }
    return this.templateList;
  }

	public void setTemplateList(List temp) {
		this.templateList = temp;
	}

	public String getTemplate() {
		return this.template;
	}

	public void setTemplate(String setId) {
		this.template = setId;
	}

	public boolean getIsPublic() {
		return this.isPublic;
	}

	public void setIsPublic(boolean b) {
		this.isPublic = b;
	}

  private List getImportSetToWEB() {
    List li = new LinkedList();
    SelectItem s = new SelectItem();
    s.setLabel("--选择预定义配置--");
    s.setValue("");
    li.add(s);
    try {
      List ltemp = this.wageimportsetucc.queryAllSetByWageSet(this.setId);
      for (int i = 0; i < ltemp.size(); i++) {
        WageImportSetBO ws = (WageImportSetBO)ltemp.get(i);
        SelectItem si = new SelectItem();
        si.setLabel(ws.getsetname());
        String[] fl = ws.getsetcontent().split(",");
        String content = "";
        for (int j = 0; j < fl.length; j++) {
          InfoItemBO ii = SysCacheTool.findInfoItem("", fl[j]);
          if (ii != null)
            if (content.equals("")) content = fl[j] + "," + ii.getItemName(); else
              content = content + "|" + fl[j] + "," + ii.getItemName();
        }
        si.setValue(content);
        li.add(si);
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return li;
  }
  public List getSelitem() {
    this.selitem = getImportSetToWEB();
    return this.selitem;
  }
  public void setSelitem(List li) {
    this.selitem = li;
  }

  public boolean isOperRight() {
    return this.operRight;
  }
  public void setOperRight(boolean operRight) {
    this.operRight = operRight;
  }

  public String[] getInputField() {
    return this.inputField;
  }
  public void setInputField(String[] inputField) {
    this.inputField = inputField;
  }

  public String getSetId() {
    return this.setId;
  }

  public void setSetId(String setId) {
    this.setId = setId;
  }

  public String getConfigname() {
    return this.configname;
  }
  public void setConfigname(String setId) {
    this.configname = setId;
  }

  public String getSetName() {
    return this.setName;
  }
  public void setSetName(String setName) {
    this.setName = setName;
  }

  public String getUnitId() {
    return this.unitId;
  }
  public void setUnitId(String unitId) {
    this.unitId = unitId;
  }

  public String getUnitName() {
    return this.unitName;
  }
  public void setUnitName(String unitName) {
    this.unitName = unitName;
  }

  public String getPageInit() {
    this.unitId = super.getServletRequest().getParameter("unitId");
    if ((this.unitId == null) || ("".equals(this.unitId))) {
      this.unitId = SysCacheTool.findPersonById(super.getUserInfo().getUserId()).getGongZiGX();
    }
    this.unitName = SysCacheTool.interpertCode("WAGE", this.unitId);
    if ("TOMCAT".equals(CommonFuns.getAppType())) {
      this.setName = CommonFuns.getParaFromURL(super.getServletRequest().getQueryString(), "setName");
    }
    else {
      this.setName = CommonFuns.filterNull(super.getServletRequest().getParameter("setName"));
    }

    if (super.getServletRequest().getParameter("setId") != null) {
      this.setId = CommonFuns.filterNull(super.getServletRequest().getParameter("setId"));
    }
    if ((super.getServletRequest().getParameter("setId") == null) && (super.getServletRequest().getParameter("form1:setId") != null)) {
      this.setId = CommonFuns.filterNull(super.getServletRequest().getParameter("form1:setId"));
    }

    if (super.getRequestParameter("dateId") != null) {
      this.dateId = super.getRequestParameter("dateId");
    }
    String act = super.getServletRequest().getParameter("act");
    if ((act == null) || (act.equals(""))) {
      return this.pageInit;
    }
    if (super.getRequestParameter("isTry") != null) {
      this.isTry = super.getRequestParameter("isTry");
    }
    if (super.getRequestParameter("showOnlyCheck") != null) {
      this.showOnlyCheck = "true".equals(super.getRequestParameter("showOnlyCheck"));
    }

    super.getHttpSession().removeAttribute("persId");
    super.getHttpSession().removeAttribute("field");

    super.getHttpSession().removeAttribute("fileValue");
    this.inputField = null;
    this.persId = null;

    if (("attInput".equals(act)) || ("selectSetInput".equals(act)) || ("selectFinanceInput".equals(act))) {
      super.getHttpSession().removeAttribute("persId");
      super.getHttpSession().removeAttribute("field");
      String str = super.getServletRequest().getParameter("str");
      if ((str != null) && (str.trim().length() > 0)) {
        str = str.replaceAll("~", "#");
        this.persId = str.split(",");
        super.getHttpSession().setAttribute("persId", this.persId);
        personInputSelect();
      }
      this.inputField = null;
    }
    getInputListByAct(act);
    return this.pageInit;
  }

  public String getTurnPage()
  {
    String pageFlag = super.getServletRequest().getParameter("pageFlag");
    if ("1".equals(pageFlag)) {
      trunPageQuery(null, null, 0, 0);
    }
    boolean flag = true;
    try {
      List list = this.wagedateucc.queryDateBySetIdStatus(this.setId, "");
      WageDateBO date = new WageDateBO();
      if (list != null) {
        for (int i = 0; i < list.size(); i++) {
          date = (WageDateBO)list.get(i);
          if ((!date.getStatus().equals("1")) && (!date.getStatus().equals("2")) && (!date.getStatus().equals("3")))
            continue;
          this.operRight = false;
          flag = false;
          break;
        }
      }

      if (flag)
        this.operRight = true;
    }
    catch (SysException e)
    {
    }
    return "";
  }

  private void getInputListByAct(String act) {
    try {
      if ("clearSetInput".equals(act))
      {
        this.inputList = new ArrayList();
        List itemList = this.wagedeptucc.getAllItemPowerByPerson(super.getUserInfo().getUserId(), this.setId);
        if ((itemList == null) || (itemList.size() == 0)) {
          itemList = this.wagesetitemucc.queryInputItemBySetId(this.setId, true);
          if (itemList != null)
            for (int i = 0; i < itemList.size(); i++) {
              SelectItem item = new SelectItem();
              WageSetItemBO setItem = (WageSetItemBO)itemList.get(i);
              if ("1".equals(setItem.getCanClear())) {
                InfoItemBO ib = SysCacheTool.findInfoItem("", setItem.getField());
                String label = ib.getItemName();
                if ((ib.getItemDesc() != null) && (!"".equals(ib.getItemDesc()))) {
                  label = label + "(" + ib.getItemDesc() + ")";
                }
                item.setLabel(label);
                item.setValue(setItem.getField());
                this.inputList.add(item);
              }
            }
        }
        else {
          for (int i = 0; i < itemList.size(); i++) {
            WageInputitemPowerBO wb = (WageInputitemPowerBO)itemList.get(i);

            if ("1".equals(this.wagesetitemucc.querySetItemBySetIdAndField(this.setId, wb.getItemID()).getCanClear())) {
              SelectItem st = new SelectItem();
              st.setLabel(CodeUtil.interpertCode("INFOITEM", wb.getItemID()));
              st.setValue(wb.getItemID());
              this.inputList.add(st);
            }
          }
        }
      } else if ("selectSetInput".equals(act))
      {
        this.inputList = new ArrayList();
        List itemList = this.wagedeptucc.getAllItemPowerByPerson(super.getUserInfo().getUserId(), this.setId);
        if ((itemList == null) || (itemList.size() == 0)) {
          itemList = this.wagesetitemucc.queryInputItemBySetId(this.setId, true);
          if (itemList != null)
            for (int i = 0; i < itemList.size(); i++) {
              SelectItem item = new SelectItem();
              WageSetItemBO setItem = (WageSetItemBO)itemList.get(i);
              InfoItemBO ib = SysCacheTool.findInfoItem("", setItem.getField());
              String label = ib.getItemName();
              if ((ib.getItemDesc() != null) && (!"".equals(ib.getItemDesc()))) {
                label = label + "(" + ib.getItemDesc() + ")";
              }
              item.setLabel(label);
              item.setValue(setItem.getField());
              this.inputList.add(item);
            }
        }
        else
        {
          for (int i = 0; i < itemList.size(); i++) {
            WageInputitemPowerBO wb = (WageInputitemPowerBO)itemList.get(i);

            WageSetItemBO wsb = this.wagesetitemucc.querySetItemBySetIdAndField(this.setId, wb.getItemID());
            if ((wsb != null) && ("2".equals(wsb.gettype()))) {
              SelectItem st = new SelectItem();
              st.setLabel(CodeUtil.interpertCode("INFOITEM", wb.getItemID()));
              st.setValue(wb.getItemID());
              this.inputList.add(st);
            }
          }
        }
      } else if ("attInput".equals(act))
      {
        this.inputList = new ArrayList();
        String showField = "";
        String Source = this.wagepowerucc.getAttencePayoffFields(super.getUserInfo().getUserId(), this.setId);
        List li = this.wagesetitemucc.queryItemBySetId(this.setId);
        for (int i = 0; i < li.size(); i++) {
          WageSetItemBO item = (WageSetItemBO)li.get(i);
          if (Source.indexOf(item.getField()) >= 0) {
            if (showField.equals("")) showField = item.getField(); else
              showField = showField + "," + item.getField();
          }
        }
        if (!"".equals(showField)) {
          String[] showItem = showField.split(",");
          for (int i = 0; i < showItem.length; i++) {
            InfoItemBO wb = SysCacheTool.findInfoItem("", showItem[i]);
            SelectItem st = new SelectItem();
            st.setLabel(wb.getItemName());
            st.setValue(wb.getItemId());
            this.inputList.add(st);
          }
        }
      }
      else if ("all".equals(act)) {
        this.inputList = new ArrayList();
        ArrayList li = SysCacheTool.queryInfoItemBySetId("A815");
        for (int i = 0; i < li.size(); i++) {
          InfoItemBO ii = (InfoItemBO)li.get(i);
          if (ii.getItemProperty().equals("4")) {
            SelectItem item = new SelectItem();
            item.setValue(ii.getItemId());
            item.setLabel(ii.getItemName());
            this.inputList.add(item);
          }
        }
      } else if ("selectFinanceInput".equals(act)) {
        this.inputList = new ArrayList();
        String[] item = this.wagesetitemucc.queryFinanceItem(this.setId);
        if ((item != null) && (item.length > 0)) {
          int count = item.length;
          for (int i = 0; i < count; i++) {
            SelectItem sitem = new SelectItem();
            sitem.setLabel(SysCacheTool.interpertCode("INFOITEM", item[i]));
            sitem.setValue(item[i]);
            this.inputList.add(sitem);
          }
        }
      }
    } catch (SysException e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
  }

  public List getInputList() {
    return this.inputList;
  }

  public Object[] getPersonlist() {
    return this.personlist;
  }
  public void setPersonlist(Object[] personlist) {
    this.personlist = personlist;
  }

  public IWageSetPersonUCC getWagesetpersonucc() {
    return this.wagesetpersonucc;
  }
  public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
    this.wagesetpersonucc = wagesetpersonucc;
  }

  public IWageDeptUCC getWagedeptucc() {
    return this.wagedeptucc;
  }
  public void setWagedeptucc(IWageDeptUCC ucc) {
    this.wagedeptucc = ucc;
  }

  public IWageSetItemUCC getWagesetitemucc() {
    return this.wagesetitemucc;
  }
  public void setWagesetitemucc(IWageSetItemUCC wagesetitemucc) {
    this.wagesetitemucc = wagesetitemucc;
  }

  public UploadedFile getExcelFile() {
    return this.excelFile;
  }
  public void setExcelFile(UploadedFile excelFile) {
    this.excelFile = excelFile;
  }

  public String getErrorFileUrl() {
    return this.errorFileUrl;
  }
  public void setErrorFileUrl(String errorFileUrl) {
    this.errorFileUrl = errorFileUrl;
  }

  public boolean isShowError() {
    return this.showError;
  }

  public IWagePersonQueryUCC getWagepersonqueryucc() {
    return this.wagepersonqueryucc;
  }

  public void setWagepersonqueryucc(IWagePersonQueryUCC wagepersonqueryucc) {
    this.wagepersonqueryucc = wagepersonqueryucc;
  }

  public String list() {
    super.getHttpSession().removeAttribute("OBJECT");
    try {
      TableVO table = new TableVO();
      List list = this.wagesetitemucc.queryInputItemBySetId(this.setId);
      String[] item = null;
      if (list != null) {
        item = new String[list.size()];
        for (int i = 0; i < list.size(); i++)
          item[i] = ((WageSetItemBO)list.get(i)).getField();
      }
      else {
        item = new String[0];
      }
      String sql = this.wagepersonqueryucc.getSQLQueryPersonInputBySetId(this.setId, table, item);
      trunPageQuery(table, sql, 1, 0);
    } catch (Exception e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "inputList";
  }

  public String truePage() {
    trunPageQuery(null, null, 0, 0);
    return "inputList";
  }

  public String trunPageQuery(TableVO table, String sql, int pageNum, int rowNum) {
    try {
      if (pageNum == 0)
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
      if (pageNum == 0)
        pageNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("pageNum")));
      if (pageNum == 0)
        pageNum = 1;
      if (rowNum == 0)
        rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("rowNum")));
      if (rowNum == 0)
        rowNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("rowNum")));
      if (rowNum == 0)
        rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (table == null)
        table = (TableVO)super.getHttpSession().getAttribute("OBJECT");
      if (sql == null) {
        sql = (String)super.getHttpSession().getAttribute("activeSql");
      }
      table = this.wagepersonqueryucc.queryPersonBySql(table, sql, pageNum, rowNum);
      super.getHttpSession().setAttribute("activeSql", sql);
      super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
      super.getHttpSession().setAttribute("OBJECT", table);
    } catch (Exception e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return null;
  }

  public String clearZero()
  {
    try
    {
      this.wagesetpersonucc.clearInputItemToZero(this.setId, this.inputField);
      super.showMessageDetail("指定输入项清空成功");
    }
    catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "success";
  }

  public String personInputSelect()
  {
    try
    {
      this.persId = ((String[])(String[])super.getHttpSession().getAttribute("persId"));
      if (this.persId != null) {
        int count = this.persId.length;
        this.personlist = new PersonBO[count];
        for (int i = 0; i < count; i++) {
          this.personlist[i] = SysCacheTool.findPersonById(this.persId[i]);
        }
        String dict_num = "OU,OU,CODE,OU";
        String field = "orgId,deptId,postLevel,gongZiGX";
        this.personlist = ((PersonBO[])(PersonBO[])CodeUtil.codeInterpret(this.personlist, field, dict_num));
      }
      super.getHttpSession().setAttribute("persId", this.persId);
    }
    catch (Exception e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "personInputSelect";
  }

  public String queryPersonInput()
  {
    if ((!"-1".equals(this.template)) && (!"".equals(this.template))) {
      inputTemplateBO ib = this.inputtemp.getTemplate(this.template);
      this.inputField = ib.getFields().split(",");

      String powerStr = "";
      String inputFieldStr = "";
      try {
        List itemList = this.wagedeptucc.getAllItemPowerByPerson(super.getUserInfo().getUserId(), this.setId);
        for (int i = 0; i < itemList.size(); i++) {
          WageInputitemPowerBO setItem = (WageInputitemPowerBO)itemList.get(i);
          if ("".equals(powerStr)) {
            powerStr = setItem.getItemID();
          }
          else {
            powerStr = powerStr + "," + setItem.getItemID();
          }
        }
        for (int i = 0; i < this.inputField.length; i++) {
          if (("".equals(powerStr)) || (powerStr.indexOf(this.inputField[i]) >= 0)) {
            if ("".equals(inputFieldStr)) {
              inputFieldStr = this.inputField[i];
            }
            else {
              inputFieldStr = inputFieldStr + "," + this.inputField[i];
            }
          }
        }
        this.inputField = inputFieldStr.split(",");
      }
      catch (Exception e)
      {
      }
    }

    super.getHttpSession().setAttribute("field", this.inputField);
    this.persId = ((String[])(String[])super.getHttpSession().getAttribute("persId"));
    try {
      HashMap hash = this.wagesetpersonucc.queryPersonItemByItemId(this.setId, this.persId, this.inputField);
      super.getServletRequest().setAttribute("value", hash);
    } catch (SysException e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    return "inputEdit";
  }

  public String savePersonInput()
  {
    try
    {
      this.persId = ((String[])(String[])super.getHttpSession().getAttribute("persId"));
      this.inputField = ((String[])(String[])super.getHttpSession().getAttribute("field"));

      ListMap hash = new ListMap();
      int col = this.inputField.length;
      int row = this.persId.length;
      for (int i = 0; i < row; i++) {
        String[] value = new String[col];
        for (int j = 0; j < col; j++) {
          value[j] = CommonFuns.formateItem(SysCacheTool.findInfoItem("", this.inputField[j]), CommonFuns.filterNullToZero(super.getRequestParameter(this.persId[i] + "|" + this.inputField[j])));
        }
        hash.put(this.persId[i], value);
      }
      if ("true".equals(this.isTry)) {
        this.wagesetpersonucc.updateInputItemByPersoId(true, this.setId, this.persId, this.inputField, hash);
      }
      else {
        this.wagesetpersonucc.updateInputItemLog(super.getUserInfo(), this.dateId, this.setId, this.persId, this.inputField, hash);
        this.wagesetpersonucc.updateInputItemByPersoId(this.setId, this.persId, this.inputField, hash);
      }

      super.getHttpSession().removeAttribute("persId");
      super.getHttpSession().removeAttribute("field");
    } catch (SysException e) {
      super.showMessageDetail("错误:" + e.getMessage());
      return "";
    }
    return "success";
  }
  public String saveAddPersonInput() {
    try {
      this.persId = ((String[])(String[])super.getHttpSession().getAttribute("persId"));
      this.inputField = ((String[])(String[])super.getHttpSession().getAttribute("field"));

      ListMap hash = new ListMap();
      int col = this.inputField.length;
      int row = this.persId.length;
      for (int i = 0; i < row; i++) {
        String[] value = new String[col];
        for (int j = 0; j < col; j++) {
          value[j] = CommonFuns.filterNullToZero(super.getRequestParameter(this.persId[i] + "|" + this.inputField[j]));
        }
        hash.put(this.persId[i], value);
      }
      this.wagesetpersonucc.updateAddPersonInputItemByPersoId(this.setId, this.persId, this.inputField, hash);

      super.getHttpSession().removeAttribute("persId");
      super.getHttpSession().removeAttribute("field");
    } catch (SysException e) {
      super.showMessageDetail("错误:" + e.getMessage());
    }
    super.showMessageDetail("保存成功");
    return "success";
  }

  	//批量导入
	public String uploadFile() {
		this.showError=false;
		if (!WageTools.addUploadOperCount()) {
			super.showMessageDetail("在线上传人数过多");
			return null;
		}
		this.inputField = super.getServletRequest().getParameterValues("rsItem");
		InfoItemBO[] cols = (InfoItemBO[])SysCacheTool.queryObject(4, null, this.inputField);
		try {
			Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
			Sheet st=wb.getSheet(0);
			int row=st.getRows();
			if(row<=1){
				super.showMessageDetail("上传文件工作薄没有内容");				
				return null;
			}
			int fieldLen=this.inputField.length;
			int col=st.getColumns();
			if(col<fieldLen+2){
				super.showMessageDetail("上传文件工作薄没有足够的列");				
				return null;
			}
			List list=new ArrayList();
			Long d=new Date().getTime();
			String path=super.getRealPath("/")+"file\\wage\\upload\\"+d+".txt";
			BufferedWriter bw = new BufferedWriter(new FileWriter(path));
			for(int i=1;i<row;i++){
				boolean pass=true;
				Map m=new HashMap();
				String pCode = st.getCell(0, i).getContents().trim();
				if(pCode==null || "".equals(pCode)){
					break;
				}
				PersonBO p = SysCacheTool.findPersonByCode(pCode);
				if(p==null){
					FileUtil.addErrorFormatLabel(bw, i, 0, "人员编号"+pCode+"不存在");
					pass=false;
					this.showError=true;
				}else{
					String name=st.getCell(1, i).getContents().trim();
					if(!p.getName().equals(name)){
						FileUtil.addErrorFormatLabel(bw, i, 1, "姓名不匹配,系统中为"+p.getName()+"此处为"+name);
						pass=false;
						this.showError=true;
					}else{
						String sql="select count(*) from a815_set_"+this.setId +" where id='"+p.getPersonId()+"'";
						int r=this.jdbcTemplate.queryForInt(sql);
						if(r==0){
							FileUtil.addErrorFormatLabel(bw, i, 0, "人员编号为"+pCode+"姓名为"+p.getName()+"的员工不在此帐套中");
							pass=false;
							this.showError=true;
						}else{
							m.put("id", p.getPersonId());
						}
					}
				}
				for(int j=0;j<fieldLen;j++){
					String v=st.getCell(j+2, i).getContents().trim();
					double v1=0;
					if(v!=null && !"".equals(v) && !"null".equals(v)){
						try {
							v1=Double.valueOf(v);
							m.put(this.inputField[j], v1);
						} catch (Exception e) {
							FileUtil.addErrorFormatLabel(bw, i, j+1, "应为数字");
							pass=false;
							this.showError=true;
						}
					}else{
						m.put(this.inputField[j], v1);
					}
				}
				if(pass){
					list.add(m);
				}
			}
			if(this.showError){
				this.errorFileUrl=super.getServletRequest().getContextPath()+"\\file\\wage\\upload\\"+d+".txt";
			}
			super.getHttpSession().setAttribute("fileValue", list);
	        super.getHttpSession().setAttribute("field", this.inputField);
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			WageTools.reduceUploadOperCount();
	    }
		return "fileInfoList";
	}
  
	public String saveFile() {

		List list = (List) super.getHttpSession().getAttribute("fileValue");
		String[] itemId = (String[]) super.getHttpSession().getAttribute("field");
		try {
			this.dataService.updateWageSetInputDate(list, itemId, this.setId);
			this.showError=false;
			this.errorFileUrl=null;
			super.getHttpSession().removeAttribute("fileValue");
			super.getHttpSession().removeAttribute("field");
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return null;
	}
	
  public void deleteconfig() {
    try {
      this.wageimportsetucc.deleteConfig(this.configname);
    }
    catch (Exception e)
    {
    }
  }

  public void saveconfig()
  {
    try {
      this.inputField = super.getServletRequest().getParameterValues("rsItem");
      String fl = "";
      String[] userold = super.getServletRequest().getParameterValues("form1:useold");
      if ((userold != null) && (userold[0].equals("true"))) {
        fl = "A001999,A001001";
      }
      else {
        fl = "A001735,A001001";
      }
      for (int i = 0; i < this.inputField.length; i++) {
        fl = fl + "," + this.inputField[i];
      }
      List li = this.wageimportsetucc.querySetByName(this.configname);
      WageImportSetBO wb = null;
      if ((li == null) || (li.size() == 0)) {
        wb = new WageImportSetBO();
      }
      else {
        wb = (WageImportSetBO)li.get(0);
      }
      wb.setsetname(this.configname);
      wb.setsetcontent(fl);
      if (this.isPublic) {
        wb.setWagesetid(WageImportSetBO.IMPORT_PUBLIC);
      }
      else {
        wb.setWagesetid(this.setId);
      }
      this.wageimportsetucc.Save(wb);
    }
    catch (Exception e)
    {
    }
  }

  public IWageDateUCC getWagedateucc() {
    return this.wagedateucc;
  }
  public void setWagedateucc(IWageDateUCC wagedateucc) {
    this.wagedateucc = wagedateucc;
  }

  public IWageImportSetUCC getWageimportsetucc() {
    return this.wageimportsetucc;
  }
  public void setWageimportsetucc(IWageImportSetUCC wagedateucc) {
    this.wageimportsetucc = wagedateucc;
  }

  public IWageItemPowerUCC getWagepowerucc() {
    return this.wagepowerucc;
  }
  public void setWagepowerucc(IWageItemPowerUCC ucc) {
    this.wagepowerucc = ucc;
  }

  public void outputitem(ValueChangeEvent event) {
    if (event.getNewValue().toString().equals("true")) {
      getInputListByAct("selectSetInput");
    }
    else
      getInputListByAct("all");
  }

  public String getPayoffDate() {
    return this.payoffDate;
  }
  public void setPayoffDate(String payoffDate) {
    this.payoffDate = payoffDate;
  }

  public String getDateId() {
    return this.dateId;
  }
  public void setDateId(String dateId) {
    this.dateId = dateId;
  }
}