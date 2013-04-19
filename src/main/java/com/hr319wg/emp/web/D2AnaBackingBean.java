package com.hr319wg.emp.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.D2AnaBO;
import com.hr319wg.emp.pojo.bo.D2AnaItemBO;
import com.hr319wg.emp.ucc.ID2AnaUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.pojo.bo.QueryBO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.configuration.LanguageSupport;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class D2AnaBackingBean extends BaseBackingBean
{
  private ID2AnaUCC d2anaucc;
  private ActivePageAPI api;
  private QueryAPI queryapi;
  private IQueryUCC queryucc;
  private List hitems;
  private String hitem;
  private List vitems;
  private String vitem;
  private String orgId;
  private String orgName;
  private String showDetail;
  private String title;
  private String seqName;
  private String degreeImage;
  private String ageImage;
  private String itemTitle;
  private String codeTitle;
  private D2AnaBO andbo = new D2AnaBO();

  private D2AnaItemBO anditembo = new D2AnaItemBO();

  private boolean numField = true;
  private List allItems;
  private String codeSetID;
  public String editDetail;
  private String initList;
  private String currentID;
  private String detailID;
  private List conList;
  private String qryID;
  private boolean showH = false;
  private boolean showV = false;
  private String initShow;

  public String getDegreeImage()
  {
    try
    {
      super.getHttpSession().setAttribute("degreeImage", this.d2anaucc.genAnaImage("SYS_002", Constants.ORG_BENBU));
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    return this.degreeImage;
  }

  public void setDegreeImage(String degreeImage) {
    this.degreeImage = degreeImage;
  }

  public String getAgeImage()
  {
    try
    {
      super.getHttpSession().setAttribute("ageImage", this.d2anaucc.genAnaImage("SYS_001", Constants.ORG_BENBU));
    }
    catch (Exception e) {
      e.printStackTrace();
    }

    return this.ageImage;
  }
  public void setAgeImage(String ageImage) {
    this.ageImage = ageImage;
  }

  public String getOrgName()
  {
    return this.orgName;
  }
  public void setOrgName(String orgName) {
    this.orgName = orgName;
  }

  public String getTitle() {
    this.title = (LanguageSupport.getResource("RYGL-0300", "员工管理") + "->" + LanguageSupport.getResource("RYGL-0393", "二维分析"));
    return this.title;
  }
  public void setTitle(String title) {
    this.title = title;
  }

  public String getSeqName()
  {
    this.seqName = LanguageSupport.getResource("XTGL-1157", "顺序");
    return this.seqName;
  }
  public void setSeqName(String seqName) {
    this.seqName = seqName;
  }

  public String getItemTitle()
  {
    this.itemTitle = LanguageSupport.getResource("JGGL-1058", "名称");
    return this.itemTitle;
  }
  public void setItemTitle(String itemTitle) {
    this.itemTitle = itemTitle;
  }

  public String getCodeTitle()
  {
    this.codeTitle = LanguageSupport.getResource("RYGL-2252", "代码值");
    return this.codeTitle;
  }
  public void setCodeTitle(String codeTitle) {
    this.codeTitle = codeTitle;
  }

  public D2AnaBO getAndbo()
  {
    return this.andbo;
  }
  public void setAndbo(D2AnaBO andbo) {
    this.andbo = andbo;
  }

  public D2AnaItemBO getAnditembo()
  {
    return this.anditembo;
  }

  public void setAnditembo(D2AnaItemBO anditembo) {
    this.anditembo = anditembo;
  }

  public boolean isNumField()
  {
    return this.numField;
  }
  public void setNumField(boolean numField) {
    this.numField = numField;
  }

  public List getAllItems()
  {
    return this.allItems;
  }
  public void setAllItems(List allItems) {
    this.allItems = allItems;
  }

  public String getCodeSetID()
  {
    return this.codeSetID;
  }
  public void setCodeSetID(String codeSetID) {
    this.codeSetID = codeSetID;
  }

  public String getEditDetail()
  {
    try
    {
      if (super.getRequestParameter("detailID") != null) {
        this.anditembo = this.d2anaucc.getD2AnaItemBO(super.getRequestParameter("detailID"));
        this.currentID = this.anditembo.getAnaID();
      }
      else if (super.getRequestParameter("currentID") != null) {
        this.currentID = super.getRequestParameter("currentID");
        this.anditembo = new D2AnaItemBO();
      }
      this.anditembo.setCodeDes(CodeUtil.interpertCode(CodeUtil.TYPE_CODE, this.anditembo.getCodevalues()));
      D2AnaBO bo = this.d2anaucc.getD2AnaBO(this.currentID);
      InfoItemBO ib = SysCacheTool.findInfoItem("", bo.getAndField());
      this.codeSetID = ib.getItemCodeSet();
    }
    catch (Exception e)
    {
    }
    return this.editDetail;
  }

  public void setEditDetail(String editDetail) {
    this.editDetail = editDetail;
  }

  private void refreshDetail()
  {
    try {
      this.allItems = this.d2anaucc.getItemDetailList(this.currentID);
      for (int i = 0; i < this.allItems.size(); i++) {
        D2AnaItemBO db = (D2AnaItemBO)this.allItems.get(i);
        db.setCodeDes(CodeUtil.interpertCode(db.getCodevalues()));
      }
    }
    catch (Exception e) {
    }
  }

  public String getInitList() {
    try {
      if (super.getRequestParameter("currentID") != null) {
        this.currentID = super.getRequestParameter("currentID");
        D2AnaBO bo = this.d2anaucc.getD2AnaBO(this.currentID);
        if ((bo != null) && (bo.getAndField() != null)) {
          InfoItemBO ib = SysCacheTool.findInfoItem("", bo.getAndField());
          if ("6".equals(ib.getItemDataType())) {
            this.numField = false;
          }
          else {
            this.numField = true;
          }
        }
      }
      refreshDetail();
    }
    catch (Exception e)
    {
    }
    return this.initList;
  }
  public void setInitList(String initList) {
    this.initList = initList;
  }

  public String getCurrentID()
  {
    return this.currentID;
  }
  public void setCurrentID(String currentID) {
    this.currentID = currentID;
  }

  public String getDetailID()
  {
    return this.detailID;
  }

  public void setDetailID(String detailID) {
    this.detailID = detailID;
  }

  public String save()
  {
    try {
      this.d2anaucc.saveD2AnaBO(this.andbo);
    }
    catch (Exception e) {
    }
    return "success";
  }
  public String Delete() {
    try {
      this.d2anaucc.DeleteItem(this.currentID);
    }
    catch (Exception e) {
      super.showMessageDetail(e.getMessage());
    }
    return "";
  }
  public String saveDetail() {
    try {
      if (this.anditembo.getAnaID() == null) {
        this.anditembo.setAnaID(this.currentID);
      }
      this.d2anaucc.saveD2AnaItemBO(this.anditembo);
      this.anditembo.initPara();
    }
    catch (Exception e) {
    }
    return "success";
  }
  public String DeleteDetail() {
    try {
      this.d2anaucc.deteleD2AnaItemBO(this.detailID);
      refreshDetail();
    }
    catch (Exception e) {
      super.showMessageDetail(e.getMessage());
    }
    return "";
  }

  public List getConList() {
    return this.conList;
  }
  public void setConList(List conList) {
    this.conList = conList;
  }

  public String getQryID()
  {
    return this.qryID;
  }
  public void setQryID(String qryID) {
    this.qryID = qryID;
  }

  public IQueryUCC getQueryucc()
  {
    return this.queryucc;
  }
  public void setQueryucc(IQueryUCC queryucc) {
    this.queryucc = queryucc;
  }

  public String getOrgId()
  {
    try {
      if ((this.orgId == null) || ("".equals(this.orgId))) {
        UserAPI api = (UserAPI)SysContext.getBean("user_pmsAPI");
        OrgBO[] os = (OrgBO[])(OrgBO[])api.getOptTreeRoot("0", (User)getHttpSession().getAttribute("USER_INFO"));
        if ((os != null) && (os.length > 0) && 
          (os[0] != null))
          this.orgId = os[0].getOrgId();
      }
    }
    catch (Exception e)
    {
      this.msg.setMainMsg(e, getClass());
    }
    return this.orgId;
  }
  public void setOrgId(String orgId) {
    this.orgId = orgId;
  }

  public boolean isShowH() {
    return this.showH;
  }
  public void setShowH(boolean showH) {
    this.showH = showH;
  }

  public boolean isShowV() {
    return this.showV;
  }
  public void setShowV(boolean showV) {
    this.showV = showV;
  }

  public List getHitems()
  {
    return this.hitems;
  }

  public void setHitems(List hitems) {
    this.hitems = hitems;
  }

  public String getHitem() {
    return this.hitem;
  }

  public void setHitem(String hitem) {
    this.hitem = hitem;
  }

  public List getVitems() {
    return this.vitems;
  }

  public void setVitems(List vitems) {
    this.vitems = vitems;
  }

  public String getVitem() {
    return this.vitem;
  }

  public void setVitem(String vitem) {
    this.vitem = vitem;
  }

  public String getShowDetail() {
    try {
      if (super.getRequestParameter("pk") != null) {
        String pk = super.getRequestParameter("pk");
        String cellID = super.getRequestParameter("cellID");
        String[] IDs = cellID.split(",");
        String cellDes = super.getRequestParameter("cellDes");
        String filter = super.getRequestParameter("addInfo");

        HashMap hm = new HashMap();

        D2AnaItemBO hanaboitem = this.d2anaucc.getD2AnaItemBO(IDs[0]);
        D2AnaBO hanabo = hanaboitem == null ? null : this.d2anaucc.getD2AnaBO(hanaboitem.getAnaID());

        D2AnaItemBO vanaboitem = this.d2anaucc.getD2AnaItemBO(IDs[1]);
        D2AnaBO vanabo = vanaboitem == null ? null : this.d2anaucc.getD2AnaBO(vanaboitem.getAnaID());

        InfoItemBO hitembo = hanabo == null ? null : SysCacheTool.findInfoItem("", hanabo.getAndField());
        if ((hitembo != null) && (hm.get(hitembo.getSetId()) == null)) {
          hm.put(hitembo.getSetId(), hitembo.getSetId());
        }

        InfoItemBO vitembo = vanabo == null ? null : SysCacheTool.findInfoItem("", vanabo.getAndField());
        if ((vitembo != null) && (hm.get(vitembo.getSetId()) == null)) {
          hm.put(vitembo.getSetId(), vitembo.getSetId());
        }

        TableVO table = new TableVO();
        String select = "A001.ID as ID,A001701,A001705,A001001";
        if (hitembo != null) {
          select = select + "," + hitembo.getItemId();
        }
        if (vitembo != null) {
          select = select + "," + vitembo.getItemId();
        }
        String sql = "";
        String[] cellarray = select.split(",");
        CellVO[] header = new CellVO[cellarray.length];
        for (int i = 0; i < cellarray.length; i++) {
          header[i] = new CellVO();
          if (cellarray[i].startsWith("A001.ID")) {
            CommonFuns.copyProperties(header[i], SysCacheTool.findInfoItem("A001", "ID"));
          }
          else {
            CommonFuns.copyProperties(header[i], SysCacheTool.findInfoItem("", cellarray[i]));
          }
        }
        table.setHeader(header);

        String from = "A001";
        Iterator it = hm.keySet().iterator();
        while (it.hasNext()) {
          String st = it.next().toString();
          if (!"A001".equals(st)) {
            InfoSetBO setbo = SysCacheTool.findInfoSet(st);
            if ("2".equals(setbo.getSet_rsType())) {
              from = from + " left join " + st + " on A001.id=" + st + ".id and " + st + "000='00901'";
            }
            else {
              from = from + " left join " + st + " on A001.id=" + st + ".id ";
            }
          }
        }
        String where = " A001738 like'" + cellDes + "%'";
        if (vanaboitem != null) {
          where = where + " and " + vanaboitem.getWhere(vitembo.getItemId(), vitembo.getItemCodeSet());
        }
        if (hanaboitem != null) {
          where = where + " and " + hanaboitem.getWhere(hitembo.getItemId(), hitembo.getItemCodeSet());
        }
        if (!"".equals(filter)) {
          Hashtable hash = this.queryapi.getQuerySqlHash(super.getUserInfo(), filter, "");
          String condition = CommonFuns.filterNull((String)hash.get("SQL_WHERE_PART"));
          String confrom = CommonFuns.filterNull((String)hash.get("SQL_FROM_PART"));
          where = where + " and A001.id in (select A001.id from " + confrom + " where " + condition + ")";
        }

        sql = "select " + select + " from " + from + " where " + where;
        turnPageQuery(table, sql, 0, 0);
      }
      String pageFlag = super.getServletRequest().getParameter("pageFlag");
      if ("1".equals(pageFlag)) {
        turnPageQuery(null, null, 0, 0);
      }
    }
    catch (Exception e)
    {
    }
    return this.showDetail;
  }
  public void setShowDetail(String str) {
    this.showDetail = str;
  }
  public String turnPageQuery(TableVO table, String sql, int pageNum, int rowNum) {
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
      this.api.querySql(table, sql, null, pageNum, rowNum, true);
      super.getHttpSession().setAttribute("activeSql", sql);
      super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
      super.getHttpSession().setAttribute("OBJECT", table);
    } catch (Exception e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return null;
  }

  public String getInitShow()
  {
    try {
      if (super.getRequestParameter("orgId") != null) {
        this.orgId = super.getRequestParameter("orgId");
        this.orgName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.orgId);
        this.hitem = super.getRequestParameter("hitem");
        this.vitem = super.getRequestParameter("vitem");
        super.getHttpSession().removeAttribute("ShowTable");
        TableVO table = new TableVO();
        this.d2anaucc.doStatic(table, this.hitem, this.vitem, this.orgId, false, false, super.getUserInfo(), null);
        super.getHttpSession().setAttribute("ShowTable", table);
      }
    }
    catch (Exception e)
    {
    }
    return this.initShow;
  }
  public void setInitShow(String initShow) {
    this.initShow = initShow;
  }

  public String getPageInit()
  {
    try {
      if (super.getRequestParameter("Init") != null) {
        super.getHttpSession().removeAttribute("ShowTable");
        List list = this.d2anaucc.getItemList();

        this.hitems = new ArrayList();
        SelectItem si = new SelectItem();
        si.setLabel("==选择横向指标==");
        si.setValue("-1");
        this.hitems.add(si);
        for (int i = 0; i < list.size(); i++) {
          D2AnaBO db = (D2AnaBO)list.get(i);
          si = new SelectItem();
          si.setLabel(db.getAndName());
          si.setValue(db.getAnaID());
          this.hitems.add(si);
        }

        this.vitems = new ArrayList();
        si = new SelectItem();
        si.setLabel("==选择纵向指标==");
        si.setValue("-1");
        this.vitems.add(si);
        for (int i = 0; i < list.size(); i++) {
          D2AnaBO db = (D2AnaBO)list.get(i);
          si = new SelectItem();
          si.setLabel(db.getAndName());
          si.setValue(db.getAnaID());
          this.vitems.add(si);
        }
        this.conList = new ArrayList();
        SelectItem si0 = new SelectItem();
        si0.setLabel("--选择过滤条件--");
        si0.setValue("");
        this.conList.add(si0);

        QueryBO[] temp = this.queryucc.queryQuery("QA" + super.getUserInfo().getUserId());
        if(temp==null){
        	temp=new QueryBO[]{};
        }
        for (int i = 0; i < temp.length; i++) {
          SelectItem si1 = new SelectItem();
          si1.setLabel(temp[i].getName());
          si1.setValue(temp[i].getQryId());
          this.conList.add(si1);
        }
        temp = this.queryucc.queryQuery("QAPUBLIC");
        if(temp==null){
        	temp=new QueryBO[]{};
        }
        for (int i = 0; i < temp.length; i++) {
          SelectItem si1 = new SelectItem();
          si1.setLabel(temp[i].getName() + "(公共)");
          si1.setValue(temp[i].getQryId());
          this.conList.add(si1);
        }
      }
    }
    catch (Exception e)
    {
    	e.printStackTrace();
    }
    return "";
  }

  public String doStatic() {
    try {
      super.getHttpSession().removeAttribute("ShowTable");
      TableVO table = new TableVO();
      this.d2anaucc.doStatic(table, this.hitem, this.vitem, this.orgId, this.showH, this.showV, super.getUserInfo(), this.qryID);
      super.getHttpSession().setAttribute("ShowTable", table);
    }
    catch (Exception e) {
      e.printStackTrace();
      super.showMessageDetail("错误：" + e.getMessage());
    }
    return "";
  }
  public ID2AnaUCC getD2anaucc() {
    return this.d2anaucc;
  }
  public void setD2anaucc(ID2AnaUCC d2anaucc) {
    this.d2anaucc = d2anaucc;
  }

  public ActivePageAPI getApi() {
    return this.api;
  }
  public void setApi(ActivePageAPI api) {
    this.api = api;
  }

  public QueryAPI getQueryapi() {
    return this.queryapi;
  }
  public void setQueryapi(QueryAPI queryapi) {
    this.queryapi = queryapi;
  }
}