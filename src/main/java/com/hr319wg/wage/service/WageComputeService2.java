package com.hr319wg.wage.service;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.exception.SysMessage;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.bo.WFDefineBO;
import com.hr319wg.sys.pojo.bo.WFNodeBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.RecordVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.pojo.vo.WFTransaction;
import com.hr319wg.sys.service.IWFFunction;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.ListMap;
import com.hr319wg.util.SequenceGenerator;
import com.hr319wg.wage.dao.ChildFeeCalcDAO;
import com.hr319wg.wage.dao.WageAgeCalcDAO;
import com.hr319wg.wage.dao.WageApplyDAO;
import com.hr319wg.wage.dao.WageAuditInputDAO;
import com.hr319wg.wage.dao.WageComputeHisDAO;
import com.hr319wg.wage.dao.WageDateDAO;
import com.hr319wg.wage.dao.WageDeptSumItemDAO;
import com.hr319wg.wage.dao.WageErrorReportDAO;
import com.hr319wg.wage.dao.WageFormulaDAO;
import com.hr319wg.wage.dao.WageItemSetDAO;
import com.hr319wg.wage.dao.WageOrgSumItemDAO;
import com.hr319wg.wage.dao.WageSetDAO;
import com.hr319wg.wage.dao.WageSetDeptChangeDAO;
import com.hr319wg.wage.dao.WageSetInitDAO;
import com.hr319wg.wage.dao.WageSetItemDAO;
import com.hr319wg.wage.dao.WageStandardDAO;
import com.hr319wg.wage.dao.WageStdItemDAO;
import com.hr319wg.wage.pojo.bo.WageAgeCalcBO;
import com.hr319wg.wage.pojo.bo.WageApplyBO;
import com.hr319wg.wage.pojo.bo.WageAuditInputBO;
import com.hr319wg.wage.pojo.bo.WageChangeRecordBO;
import com.hr319wg.wage.pojo.bo.WageComputeHisBO;
import com.hr319wg.wage.pojo.bo.WageCostFieldBO;
import com.hr319wg.wage.pojo.bo.WageDateBO;
import com.hr319wg.wage.pojo.bo.WageDeptSumItemBO;
import com.hr319wg.wage.pojo.bo.WageErrReportBO;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;
import com.hr319wg.wage.pojo.bo.WageOrgInsuraceBO;
import com.hr319wg.wage.pojo.bo.WageOrgSumItemBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.pojo.bo.WageSetPersonDeptBO;
import com.hr319wg.wage.pojo.bo.WageStandardBO;
import com.hr319wg.wage.pojo.bo.WageStdItemBO;
import com.hr319wg.wage.pojo.bo.WageTmpPersonLogBO;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.hr319wg.wage.util.WageFormulaTools;
import com.hr319wg.wage.util.WageFunctionTools;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import java.util.Set;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 工资计算类，本文件暂时没有使用，实际使用的是不加2的class
 * @author chl
 *
 */
public class WageComputeService2
  implements IWFFunction
{
  private WageAPI wageapi;
  private ActivePageAPI api;
  private WageDateDAO wagedatedao;
  private WageSetItemDAO wagesetitemdao;
  private WageStdItemDAO wagestditemdao;
  private WageFormulaDAO wageformuladao;
  private WageOrgSumItemDAO wageorgitemsetdao;
  private WageItemSetDAO wageitemsetdao;
  private WageDeptSumItemDAO wagedeptsumdao;
  private WageSetDAO wagesetdao;
  private WageSetInitDAO wagesetinitdao;
  private WageStandardDAO wagestandarddao;
  private WageComputeHisDAO wagehisdao;
  private WageSetDeptChangeDAO wagesetdeptchange;
  private WageErrorReportDAO wageerrdao;
  private WageAuditInputDAO auditinputdao;
  private WageSetService setservice;
  private WageUnitService unitservice;
  private WageAgeCalcDAO wageagedao;
  private WageApplyDAO wageapplydao;
  private ChildFeeCalcDAO childcalcdao;
  private String tmp_table = "A815_SET_";
  private String try_table = "A815_TRY_";

  public WageApplyDAO getWageapplydao()
  {
    return this.wageapplydao;
  }

  public void setWageapplydao(WageApplyDAO wageapplydao) {
    this.wageapplydao = wageapplydao;
  }

  public ChildFeeCalcDAO getChildcalcdao()
  {
    return this.childcalcdao;
  }

  public void setChildcalcdao(ChildFeeCalcDAO childcalcdao) {
    this.childcalcdao = childcalcdao;
  }

  public WageAgeCalcDAO getWageagedao()
  {
    return this.wageagedao;
  }
  public void setWageagedao(WageAgeCalcDAO wageagedao) {
    this.wageagedao = wageagedao;
  }

  public WageAuditInputDAO getAuditinputdao()
  {
    return this.auditinputdao;
  }
  public void setAuditinputdao(WageAuditInputDAO auditinputdao) {
    this.auditinputdao = auditinputdao;
  }

  public WageComputeHisDAO getWagehisdao() {
    return this.wagehisdao;
  }
  public void setWagehisdao(WageComputeHisDAO dao) {
    this.wagehisdao = dao;
  }

  public WageUnitService getUnitservice() {
    return this.unitservice;
  }
  public void setUnitservice(WageUnitService service) {
    this.unitservice = service;
  }

  public WageSetService getSetservice() {
    return this.setservice;
  }
  public void setSetservice(WageSetService service) {
    this.setservice = service;
  }

  public WageErrorReportDAO getWageerrdao() {
    return this.wageerrdao;
  }
  public void setWageerrdao(WageErrorReportDAO dao) {
    this.wageerrdao = dao;
  }

  public WageSetDeptChangeDAO getWagesetdeptchange() {
    return this.wagesetdeptchange;
  }
  public void setWagesetdeptchange(WageSetDeptChangeDAO dao) {
    this.wagesetdeptchange = dao;
  }

  public List getComputeHisList(String dateID)
    throws SysException
  {
    return this.wagehisdao.getComputeHisList(dateID);
  }
  public void saveComputeHis(WageComputeHisBO bo) throws SysException {
    this.wagehisdao.saveOrUpdateBo(bo);
  }

  public void DeleteError(String dateID, String pids) throws SysException {
    String sql = "delete from WAGE_AUDIT_ERROR where date_id='" + dateID + "' and person_id in ('" + pids.replaceAll(",", "','") + "')";
    this.api.executeSql(sql);
  }
  public WageErrReportBO getErrorBO(String dateID, String pid) throws SysException {
    return this.wageerrdao.getErrorBO(dateID, pid);
  }
  public List getAllError(String dateID, boolean onlyNotAnswer) throws SysException {
    return this.wageerrdao.getAllError(dateID, onlyNotAnswer);
  }
  public void SaveWageErrReport(WageErrReportBO bo) throws SysException {
    this.wageerrdao.saveOrUpdateBo(bo);
  }
  public WageErrReportBO findWageErrReport(String itemID) throws SysException {
    return (WageErrReportBO)this.wageerrdao.findBoById(WageErrReportBO.class, itemID);
  }
  public String getA815708ByDateID(String dateid, String pid) throws SysException {
    String sql = "select set_id from wage_payoff where payoff_id='" + dateid + "'";
    String setId = this.api.queryForString(sql);
    sql = "select A815708 from a815_set_" + setId + " where id='" + pid + "'";
    return this.api.queryForString(sql);
  }

  public String getA815708(String setId, String pid) throws SysException {
    String sql = "select A815708 from a815_set_" + setId + " where id='" + pid + "'";
    return this.api.queryForString(sql);
  }
  public String getTmp_table() {
    return this.tmp_table;
  }
  public String getTry_table() {
    return this.try_table;
  }

  public WageDeptSumItemDAO getWagedeptsumdao() {
    return this.wagedeptsumdao;
  }
  public void setWagedeptsumdao(WageDeptSumItemDAO wageitemsetdao) {
    this.wagedeptsumdao = wageitemsetdao;
  }

  public WageAPI getWageapi() {
    return this.wageapi;
  }
  public void setWageapi(WageAPI api) {
    this.wageapi = api;
  }

  public WageStandardDAO getWagestandarddao() {
    return this.wagestandarddao;
  }
  public void setWagestandarddao(WageStandardDAO dao) {
    this.wagestandarddao = dao;
  }

  public ActivePageAPI getApi() {
    return this.api;
  }
  public void setApi(ActivePageAPI api) {
    this.api = api;
  }

  public WageSetInitDAO getWagesetinitdao() {
    return this.wagesetinitdao;
  }
  public void setWagesetinitdao(WageSetInitDAO wd) {
    this.wagesetinitdao = wd;
  }

  public WageSetDAO getWagesetdao() {
    return this.wagesetdao;
  }
  public void setWagesetdao(WageSetDAO wd) {
    this.wagesetdao = wd;
  }

  public WageOrgSumItemDAO getwageorgitemsetdao() {
    return this.wageorgitemsetdao;
  }
  public void setwageorgitemsetdao(WageOrgSumItemDAO wd) {
    this.wageorgitemsetdao = wd;
  }

  public WageDateDAO getWagedatedao() {
    return this.wagedatedao;
  }
  public void setWagedatedao(WageDateDAO wagedatedao) {
    this.wagedatedao = wagedatedao;
  }

  public WageSetItemDAO getWagesetitemdao() {
    return this.wagesetitemdao;
  }
  public void setWagesetitemdao(WageSetItemDAO wagesetitemdao) {
    this.wagesetitemdao = wagesetitemdao;
  }

  public WageStdItemDAO getWagestditemdao() {
    return this.wagestditemdao;
  }
  public void setWagestditemdao(WageStdItemDAO wagestditemdao) {
    this.wagestditemdao = wagestditemdao;
  }

  public WageFormulaDAO getWageformuladao() {
    return this.wageformuladao;
  }
  public void setWageformuladao(WageFormulaDAO wageformuladao) {
    this.wageformuladao = wageformuladao;
  }

  public WageItemSetDAO getWageitemsetdao() {
    return this.wageitemsetdao;
  }
  public void setWageitemsetdao(WageItemSetDAO wageitemsetdao) {
    this.wageitemsetdao = wageitemsetdao;
  }

  public void deletePersonfromTmpTable(String setId, String dateId, String payoffdate, String unitId, String ids) throws SysException {
    String tablename = this.tmp_table + setId;
    String sql = "delete from " + tablename + " where " + CommonFuns.splitInSql(ids.split(","), "ID");
    try {
      this.api.executeSql(sql);
    } catch (Exception e) {
      throw new RollbackableException("", "删除人员出错", e, getClass());
    }
  }

  public void addTmpPersonLog(String dateId, String ids)
    throws SysException
  {
    if ((ids == null) || ("".equals(ids))) return;
    String sql = "delete from WAGE_TEMP_PERSON where PAYOFF_ID='" + dateId + "' and " + CommonFuns.splitInSql(ids.split(","), "PERS_ID");
    String[] idArray = ids.split(",");
    for (int i = 0; i < idArray.length; i++) {
      WageTmpPersonLogBO wb = new WageTmpPersonLogBO();
      wb.setPayoffID(dateId);
      wb.setPersonID(idArray[i]);
      this.wagesetdao.saveOrUpdateBo(wb);
    }
  }

  public List getTmpPersonLog(String dateId) throws SysException {
    return this.wagesetdao.getTmpPersonLog(dateId);
  }
  public void addPersonToTmpTable(String setId, String dateId, String payoffdate, String unitId, String ids) throws SysException {
    String tablename = this.tmp_table + setId;
    String field1 = "ID,subid,A815700,A815702,A815705,A815701,A815000";
    String field2 = "ID,'0' as subid,'" + setId + "' as A815700,'" + dateId + "' as A815702,'" + unitId + "' as A815705,'" + payoffdate + "' as A815701,'00901' as A815000 ";
    String sql = "insert into " + tablename + "(" + field1 + ")  select " + field2 + " from A001 where " + CommonFuns.splitInSql(ids.split(","), "ID");
    try {
      this.api.executeSql(sql);
    } catch (Exception e) {
      throw new RollbackableException("", "增加人员出错", e, getClass());
    }
  }

  public void createTmpTable(String setId, String dateId, String payoffdate, String unitId)
    throws SysException
  {
    String tablename = this.tmp_table + setId;
    String drop = "drop table " + tablename;

    if (this.api.isDBTable(tablename)) {
      this.api.executeSql(drop.toUpperCase());
    }

    String field = "";
    List list = SysCacheTool.queryInfoItemBySetId("A815");
    int count = list.size();
    for (int i = 0; i < count; i++) {
      String itemId = ((InfoItemBO)list.get(i)).getItemId();
      if ("A815700".equals(itemId))
        itemId = "'" + setId + "' as " + itemId;
      else if ("A815702".equals(itemId))
        itemId = "'" + dateId + "' as " + itemId;
      else if ("A815705".equals(itemId))
        itemId = "'" + unitId + "' as " + itemId;
      else if ("A815701".equals(itemId))
        itemId = "'" + payoffdate + "' as " + itemId;
      else if ("A815000".equals(itemId)) {
        itemId = "'00901' as " + itemId;
      }
      field = field + itemId + ",";
    }
    field = field.substring(0, field.length() - 1);
    String sql = "";
    if ("ORACLE".equals(Constants.DB_TYPE)) {
      sql = "create table " + tablename + " as select " + field + " from " + "wage_set_pers_r" + " where ";
    }
    else {
      sql = "select " + field + " into " + tablename + " from " + "wage_set_pers_r" + " where ";
    }
    sql = sql + "A815700='" + setId + "'";
    try {
      this.api.executeSql(sql);

      sql = "alter table " + tablename + "  add constraint PK_" + tablename + " primary key (ID)";
      this.api.executeSql(sql);

      sql = "update " + tablename + " set A815757='00900'";
    } catch (Exception e) {
      throw new RollbackableException("", "创建薪资发放临时表出错", e, getClass());
    }
  }

  public void dropGatherData(String setId) throws SysException
  {
    String sql = "delete from B732 where B732001 like 'TRY_" + setId + "'";
    try {
      this.api.executeSql(sql);
    } catch (Exception e) {
    }
  }

  public void dropTryTmpTable(String setId) throws SysException {
    String tablename = this.try_table + setId;
    String drop = "drop table " + tablename;
    try {
      this.api.executeSql(drop.toUpperCase()); } catch (Exception e) {
    }
  }

  public void createTryTmpTable(String setId) throws SysException {
    String tablename = this.try_table + setId;
    String drop = "drop table " + tablename;
    try {
      this.api.executeSql(drop.toUpperCase());
    }
    catch (Exception e) {
    }
    finally {
      String field = "";
      List list = SysCacheTool.queryInfoItemBySetId("A815");
      int count = list.size();
      for (int i = 0; i < count; i++) {
        String itemId = ((InfoItemBO)list.get(i)).getItemId();
        if ("A815700".equals(itemId))
          itemId = "'" + setId + "' as " + itemId;
        else if ("A815000".equals(itemId)) {
          itemId = "'00901' as " + itemId;
        }
        field = field + itemId + ",";
      }
      field = field.substring(0, field.length() - 1);
      String sql = "create table " + tablename + " as select " + field + " from " + "wage_set_pers_r" + " where ";
      sql = sql + "A815700='" + setId + "'";
      try {
        this.api.executeSql(sql);
        sql = "alter table " + tablename + "  add constraint PK_" + tablename + " primary key (ID)";
        this.api.executeSql(sql);
      } catch (Exception e) {
        throw new RollbackableException("", "创建薪资发放临时表出错", e, getClass());
      }
    }
  }

  public void deleteTmpTable(String setId, String dateId)
    throws SysException
  {
    String tablename = this.tmp_table + setId;
    if (!isDBTable(tablename));
    String drop = "drop table " + tablename;
    this.api.executeSql(drop.toUpperCase());
  }

  public boolean isDBTable(String tableName)
    throws SysException
  {
    return this.api.isDBTable(tableName);
  }

  public void batchAddPerson2TmpTable(String setId, String[] personId)
    throws SysException
  {
    if ((setId == null) || (personId == null) || (personId.length == 0)) return;
    String tablename = this.tmp_table + setId;
    if (isDBTable(tablename)) {
      List sqlList = new ArrayList();
      String delsql = "delete from " + tablename + " where " + "A815700" + "='" + setId + "' and " + CommonFuns.splitInSql(personId, "ID");
      sqlList.add(delsql);

      String field = "";
      List itemlist = SysCacheTool.queryInfoItemBySetId("A815");
      int count = itemlist.size();
      for (int i = 0; i < count; i++) {
        String itemId = ((InfoItemBO)itemlist.get(i)).getItemId();
        field = field + itemId + ",";
      }
      field = field.substring(0, field.length() - 1);
      String addsql = "insert into " + tablename + "(" + field + ") select " + field + " from " + "wage_set_pers_r" + " where " + "A815700" + "='" + setId + "' and " + CommonFuns.splitInSql(personId, "ID");
      sqlList.add(addsql);

      String qrySql = "select st.set_id as set_id,dt.payoff_id as payoff_id, dt.payoff_date as payoff_date,st.unit_id as unit_id from wage_set st,wage_payoff dt where st.set_id=dt.set_Id and st.set_id='" + setId + "' and dt.payoff_status<'" + "5" + "'";
      CellVO[] header = new CellVO[4];
      header[0] = new CellVO();
      header[0].setItemId("set_id");

      header[1] = new CellVO();
      header[1].setItemId("payoff_id");

      header[2] = new CellVO();
      header[2].setItemId("payoff_date");

      header[3] = new CellVO();
      header[3].setItemId("unit_id");
      Vector vt = this.api.getDataListBySql(header, qrySql);

      String upsql = "";
      if ((vt != null) && (vt.size() > 0)) {
        CellVO[] row = (CellVO[])(CellVO[])vt.get(0);
        upsql = "update " + tablename + " set A815700='" + row[0].getValue() + "',A815702='" + row[1].getValue() + "',A815701='" + row[2].getValue() + "',A815705='" + row[3].getValue() + "'";
        sqlList.add(upsql);
      }

      upsql = "update " + tablename + "  set A815001=(select A001743 from A001 where A001.id=" + tablename + ".id)";
      sqlList.add(upsql);
      this.api.batchExecuteSql((String[])(String[])sqlList.toArray(new String[sqlList.size()]));
    }
  }

  public void batchDeletePerson2TmpTable(String setId, String[] personId)
    throws SysException
  {
    try
    {
      if ((setId == null) || (personId == null) || (personId.length == 0)) return;
      String tablename = this.tmp_table + setId;
      if (isDBTable(tablename)) {
        String sql = "delete from " + tablename + " where " + "A815700" + "='" + setId + "' and " + CommonFuns.splitInSql(personId, "ID");
        this.api.executeSql(sql.toUpperCase());
      }
    } catch (Exception e) {
      throw new RollbackableException("", "批量删除临时表中人员失败", e, getClass());
    }
  }

  public void updateDeptInfo(String dateId, String[] deptId, String Field, ListMap value)
    throws SysException
  {
    try
    {
      if ((dateId == null) || ("".equals(dateId)) || (deptId == null) || (deptId.length == 0) || (Field == null) || ("".equals(Field)) || (value == null) || (value.size() == 0))
      {
        return;
      }
      int count = deptId.length;
      String[] bsql = new String[count];
      for (int i = 0; i < count; i++) {
        bsql[i] = ("update B732 set " + Field + "='" + ((String[])(String[])value.get(deptId[i]))[0] + "' where B732001='" + dateId + "' and B732700='" + deptId[i] + "'");
      }
      this.api.batchExecuteSql(bsql);
    } catch (Exception e) {
      throw new RollbackableException("", "修改输入项值失败", e, getClass());
    }
  }

  public void updateInputItemByPersoId(String setId, String[] personId, String[] itemId, ListMap value)
    throws SysException
  {
    updateInputItemByPersoId(false, setId, personId, itemId, value);
  }
  public void updateInputItemByPersoId(boolean isTry, String setId, String[] personId, String[] itemId, ListMap value) throws SysException {
    try {
      if ((setId == null) || ("".equals(setId)) || (personId == null) || (personId.length == 0) || (itemId == null) || (itemId.length == 0) || (value == null) || (value.size() == 0))
      {
        return;
      }String tablename = this.tmp_table + setId;
      if (isTry) {
        tablename = this.try_table + setId;
      }
      if (isDBTable(tablename)) {
        int count = personId.length;
        int count1 = itemId.length;
        String sql = "update " + tablename + " set ## where " + "A815700" + "='" + setId + "' and " + "ID" + "='@@'";
        String[] bsql = new String[count];
        for (int i = 0; i < count; i++) {
          String pid = personId[i];
          String str = "";
          for (int j = 0; j < count1; j++) {
            String[] rs1 = (String[])(String[])value.get(pid);
            if ((rs1 == null) && (rs1.length == 0)) break;
            InfoItemBO itemBO = SysCacheTool.findInfoItem(itemId[j].substring(0, 4), itemId[j]);
            if (j == count1 - 1) {
              if ("3".equals(itemBO.getItemDataType()))
                str = str + itemId[j] + "='" + CommonFuns.filterNull(rs1[j]) + "'";
              else {
                str = str + itemId[j] + "='" + CommonFuns.filterNullToZero(rs1[j]) + "'";
              }
            }
            else if ("3".equals(itemBO.getItemDataType()))
              str = str + itemId[j] + "='" + CommonFuns.filterNull(rs1[j]) + "',";
            else {
              str = str + itemId[j] + "='" + CommonFuns.filterNullToZero(rs1[j]) + "',";
            }
          }

          String stmp = new String(sql);
          stmp = stmp.replaceAll("@@", pid.split("\\|")[0]);
          stmp = stmp.replaceAll("##", str);
          bsql[i] = stmp.toUpperCase();
        }
        this.api.batchExecuteSql(bsql);
      }
    } catch (Exception e) {
      throw new RollbackableException("", "修改人员输入项值失败", e, getClass());
    }
  }

  public void batchAddPieceByPersoId(String[] personId, String[] itemId, ListMap value, String dateID, String PayOffDate) throws SysException {
    try {
      if ((dateID == null) || (personId == null) || (personId.length == 0) || (itemId == null) || (itemId.length == 0) || (value == null) || (value.size() == 0))
      {
        return;
      }

      String[] bsql = new String[personId.length];

      String field = "ID,SUBID,A002000,A002001,A002002";
      for (int i = 0; i < itemId.length; i++) {
        field = field + "," + itemId[i];
      }
      for (int i = 0; i < personId.length; i++) {
        String pid = personId[i];
        String str = "insert into A002(" + field + ") values('" + pid + "','" + SequenceGenerator.getKeyId("A002") + "','" + "00900" + "','" + dateID + "','" + PayOffDate + "'";
        String[] rs1 = (String[])(String[])value.get(pid);
        for (int j = 0; j < itemId.length; j++) {
          str = str + ",'" + rs1[j] + "'";
        }
        str = str + ")";
        bsql[i] = str;
      }
      this.api.batchExecuteSql(bsql);
    } catch (Exception e) {
      throw new RollbackableException("", "增加输入项值失败", e, getClass());
    }
  }

  public void updateInsurceBasePersoId(String[] personId, String[] itemId, ListMap value)
    throws SysException
  {
    try
    {
      String sql = "";
      if ((personId == null) || (personId.length == 0) || (itemId == null) || (itemId.length == 0) || (value == null) || (value.size() == 0))
      {
        return;
      }
      for (int i = 0; i < personId.length; i++) {
        String pid = personId[i];
        String str = "";
        String[] rs1 = (String[])(String[])value.get(pid);
        if ((rs1 == null) && (rs1.length == 0)) break;
        for (int j = 0; j < itemId.length; j++) {
          String table = itemId[j].substring(0, 3);
          sql = "select count(*) from " + table + " where id='" + pid + "' and " + table + "000='00901'";
          if (this.api.queryForInt(sql) > 0) {
            sql = " update " + table + " set " + itemId[j] + "='" + rs1[j] + "' where id='" + pid + "' and " + table + "000='00901'";
          }
          else {
            sql = " update " + table + " set " + table + "000='00900' where id='" + pid + "'";
            this.api.executeSql(sql);
            sql = " insert into " + table + "(id,subid," + table + "000," + itemId[j] + ") values('" + pid + "','" + SequenceGenerator.getKeyId(table) + "','00901','" + rs1[j] + "')";
          }
          this.api.executeSql(sql);
        }
      }

      sql = " update A755 set A755701='" + CommonFuns.getSysDate("yyyy-MM") + "',A755705=A755715 where A755000='00901' and " + CommonFuns.splitInSql(personId, "ID");
      this.api.executeSql(sql);

      sql = " update A760 set A760701='" + CommonFuns.getSysDate("yyyy-MM") + "',A760705=A760710 where A760000='00901' and " + CommonFuns.splitInSql(personId, "ID");
      this.api.executeSql(sql);

      sql = " update A765 set A765701='" + CommonFuns.getSysDate("yyyy-MM") + "' where A765000='00901' and " + CommonFuns.splitInSql(personId, "ID");
      this.api.executeSql(sql);

      sql = " update A770 set A770701='" + CommonFuns.getSysDate("yyyy-MM") + "',A770705=A770710 where A760000='00901' and " + CommonFuns.splitInSql(personId, "ID");
      this.api.executeSql(sql);

      sql = " update A775 set A775701='" + CommonFuns.getSysDate("yyyy-MM") + "' where A775000='00901' and " + CommonFuns.splitInSql(personId, "ID");
      this.api.executeSql(sql);

      sql = " update A780 set A780701='" + CommonFuns.getSysDate("yyyy-MM") + "',A780705=A780708 where A780000='00901' and " + CommonFuns.splitInSql(personId, "ID");
      this.api.executeSql(sql);
    }
    catch (Exception e) {
      throw new RollbackableException("", "修改人员排序输入项值失败", e, getClass());
    }
  }

  public void recordDeptChange(String operID, String setID, String personID, String oldvalue, String newvalue)
    throws SysException
  {
    WageSetPersonDeptBO wb = new WageSetPersonDeptBO();
    wb.setSetId(setID);
    wb.setPersonId(personID);
    wb.setOperId(operID);
    wb.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
    wb.setOlddept(oldvalue);
    wb.setNewdept(newvalue);
    this.wagesetdeptchange.saveOrUpdateBo(wb);
  }
  public void recordDeptChange(String operID, String setID, String[] personID, HashMap olddept, HashMap newdept) throws SysException {
    if (personID == null) return;
    for (int i = 0; i < personID.length; i++) {
      String oldvalue = CommonFuns.filterNull((String)olddept.get(personID[i]));
      String newvalue = CommonFuns.filterNull((String)newdept.get(personID[i]));
      if (((!"".equals(oldvalue)) || (!"".equals(newvalue))) && (!oldvalue.equals(newvalue))) {
        WageSetPersonDeptBO wb = new WageSetPersonDeptBO();
        wb.setSetId(setID);
        wb.setPersonId(personID[i]);
        wb.setOperId(operID);
        wb.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
        wb.setOlddept(oldvalue);
        wb.setNewdept(newvalue);
        this.wagesetdeptchange.saveOrUpdateBo(wb);
      }
    }
  }

  public void updateOrderItemByPersoId(String[] personId, String[] itemId, ListMap value) throws SysException {
    try {
      if ((personId == null) || (personId.length == 0) || (itemId == null) || (itemId.length == 0) || (value == null) || (value.size() == 0))
      {
        return;
      }String tablename = "A001";
      int count = personId.length;
      int count1 = itemId.length;
      String sql = "update " + tablename + " set ## where " + "ID" + "='@@'";
      String[] bsql = new String[count];
      for (int i = 0; i < count; i++) {
        String pid = personId[i];
        String str = "";
        for (int j = 0; j < count1; j++) {
          String[] rs1 = (String[])(String[])value.get(pid);
          if ((rs1 == null) && (rs1.length == 0)) break;
          InfoItemBO itemBO = SysCacheTool.findInfoItem(itemId[j].substring(0, 4), itemId[j]);
          if (j == count1 - 1) {
            if ((!"2".equals(itemBO.getItemDataType())) && (!"1".equals(itemBO.getItemDataType())))
            {
              str = str + itemId[j] + "='" + CommonFuns.filterNull(rs1[j]) + "'";
            }
            else str = str + itemId[j] + "='" + CommonFuns.filterNullToZero(rs1[j]) + "'";

          }
          else if ((!"2".equals(itemBO.getItemDataType())) && (!"1".equals(itemBO.getItemDataType())))
          {
            str = str + itemId[j] + "='" + CommonFuns.filterNull(rs1[j]) + "',";
          }
          else str = str + itemId[j] + "='" + CommonFuns.filterNullToZero(rs1[j]) + "',";

        }

        String stmp = new String(sql);
        stmp = stmp.replaceAll("@@", pid);
        stmp = stmp.replaceAll("##", str);
        bsql[i] = stmp.toUpperCase();
      }
      this.api.batchExecuteSql(bsql);

      for (int i = 0; i < count; i++)
        SysCache.setPerson(personId[i], 3);
    }
    catch (Exception e) {
      throw new RollbackableException("", "修改人员排序输入项值失败", e, getClass());
    }
  }

  public void updateInputItemValue(String setId, String itemId, String value)
    throws SysException
  {
    try
    {
      if ((setId == null) || ("".equals(setId)) || (itemId == null) || (value == null))
        return;
      String tablename = this.tmp_table + setId;
      if (isDBTable(tablename)) {
        String sql = "update " + tablename + " set " + itemId + "='" + value + "' where " + "A815700" + "='" + setId + "'";
        this.api.executeSql(sql);
      }
    } catch (Exception e) {
      throw new RollbackableException("", "修改人员输入项值失败", e, getClass());
    }
  }

  public void clearInputItemToZero(String setId, String[] itemId)
    throws SysException
  {
    try
    {
      if ((setId == null) || ("".equals(setId)) || (itemId == null) || (itemId.length == 0))
        return;
      String tablename = "A815_SET_" + setId;
      if (isDBTable(tablename)) {
        int count = itemId.length;
        StringBuffer sb = new StringBuffer("");
        sb.append("update ").append(tablename).append(" set ");
        for (int i = 0; i < count; i++) {
          if (i == count - 1)
            sb.append(itemId[i]).append("='0'");
          else {
            sb.append(itemId[i]).append("='0'").append(",");
          }
        }
        sb.append(" where ").append("A815700").append("='").append(setId).append("'");
        this.api.executeSql(sb.toString());
      }
    } catch (Exception e) {
      throw new RollbackableException("", "清空输入项值失败", e, getClass());
    }
  }

  private void adjustDataFormat(String set) throws SysException {
    String fun = "";
    String fun1 = "";

    if ("ORACLE".equals(Constants.DB_TYPE)) {
      fun = "FormateMoney";
    }
    else {
      fun = "dbo.FormateMoney";
    }

    if ("ORACLE".equals(Constants.DB_TYPE)) {
      fun1 = "FormateMoneyOne";
    }
    else {
      fun1 = "dbo.FormateMoneyOne";
    }

    List list = this.wagesetitemdao.querySetItemBySetId(set);

    if (list.size() > 0) {
      String sql = "update A815_set_" + set + " set ";
      boolean have = false;
      String setSql = "";
      for (int i = 0; i < list.size(); i++) {
        WageSetItemBO wb = (WageSetItemBO)list.get(i);
        if ((!"2".equals(wb.gettype())) && (!"0".equals(wb.gettype()))) {
          InfoItemBO ib = SysCacheTool.findInfoItem("", wb.getField());
          if (("2".equals(ib.getItemPrecision())) && ("2".equals(ib.getItemDataType()))) {
            have = true;
            if ("".equals(setSql)) {
              setSql = setSql + wb.getField() + "=" + fun + "(" + wb.getField() + ")";
            }
            else {
              setSql = setSql + "," + wb.getField() + "=" + fun + "(" + wb.getField() + ")";
            }
          }
          else if (("1".equals(ib.getItemPrecision())) && ("2".equals(ib.getItemDataType()))) {
            have = true;
            if ("".equals(setSql)) {
              setSql = setSql + wb.getField() + "=" + fun1 + "(" + wb.getField() + ")";
            }
            else {
              setSql = setSql + "," + wb.getField() + "=" + fun1 + "(" + wb.getField() + ")";
            }
          }

          if ("A815713".equals(ib.getItemId())) {
            InfoItemBO A815714 = SysCacheTool.findInfoItem("", "A815714");
            if (("2".equals(A815714.getItemPrecision())) && ("2".equals(A815714.getItemDataType()))) {
              have = true;
              if ("".equals(setSql)) {
                setSql = setSql + "A815714=" + fun + "(A815714)";
              }
              else {
                setSql = setSql + ",A815714=" + fun + "(A815714)";
              }
            }
            else if (("1".equals(A815714.getItemPrecision())) && ("2".equals(A815714.getItemDataType()))) {
              have = true;
              if ("".equals(setSql)) {
                setSql = setSql + "A815714=" + fun1 + "(A815714)";
              }
              else {
                setSql = setSql + ",A815714=" + fun1 + "(A815714)";
              }
            }
          }
          else if ("A815755".equals(ib.getItemId())) {
            InfoItemBO A815756 = SysCacheTool.findInfoItem("", "A815756");
            if (("2".equals(A815756.getItemPrecision())) && ("2".equals(A815756.getItemDataType()))) {
              have = true;
              if ("".equals(setSql)) {
                setSql = setSql + "A815756=" + fun + "(A815756)";
              }
              else {
                setSql = setSql + ",A815756=" + fun + "(A815756)";
              }
            }
            else if (("1".equals(A815756.getItemPrecision())) && ("2".equals(A815756.getItemDataType()))) {
              have = true;
              if ("".equals(setSql)) {
                setSql = setSql + "A815756=" + fun1 + "(A815756)";
              }
              else
                setSql = setSql + ",A815756=" + fun1 + "(A815756)";
            }
          }
        }
      }
      if (have)
        this.api.executeSql(sql + setSql);
    }
  }

  public Vector computePerson(String setId, String dateId, String[] personId, String payoffDate, String unitId)
    throws SysException
  {
    return computePerson(false, setId, dateId, personId, payoffDate, unitId);
  }

  public void computeAnnu(boolean isTry, String setId, String dateId, String[] personId, String payoffDate, String unitId)
    throws SysException
  {
    WageSetBO wb = this.wagesetdao.findSetBySetId(setId);
    if ((wb.getAnnuCalc() == null) || (!"1".equals(wb.getAnnuCalc()))) return;

    String sql = "update A815_SET_" + setId + " set A815742='0',A815743='0',A815744='0',A815745='0',A815746='0',A815747='0' ";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    this.api.executeSql(sql);

    String[] sqlList = new String[10];
    sql = "update A815_SET_" + setId + " set A815742=(select A785726 from A785 where A785.id=A815_SET_" + setId + ".id and A785000='00901') where id in (select id from A785 where A785000='00901' and A785726 is not null)";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    sqlList[0] = sql;

    sql = "update A815_SET_" + setId + " set A815745=(select A785727 from A785 where A785.id=A815_SET_" + setId + ".id and A785000='00901')  where id in (select id from A785 where A785000='00901' and A785727 is not null)";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    sqlList[1] = sql;

    sql = "update A815_SET_" + setId + " set A815744=A815710+A815713+A815742";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    sqlList[2] = sql;

    sql = this.wageapi.TaxCount(setId, wb.getCessID(), "A815_SET_" + setId, "A815743", "A815744", wb.getFilterField(), wb.getFilterValues());
    sqlList[3] = sql;

    sql = "update A815_SET_" + setId + " set A815743=A815743-A815714 ";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    sqlList[4] = sql;

    sql = "update A815_SET_" + setId + " set A815744=A815742-A815743 ";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    sqlList[5] = sql;

    sql = "update A815_SET_" + setId + " set A815747=A815710+A815713+A815745";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    sqlList[6] = sql;

    sql = this.wageapi.TaxCount(setId, wb.getCessID(), "A815_SET_" + setId, "A815746", "A815747", wb.getFilterField(), wb.getFilterValues());
    sqlList[7] = sql;

    sql = "update A815_SET_" + setId + " set A815746=A815746-A815714 ";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    sqlList[8] = sql;

    sql = "update A815_SET_" + setId + " set A815747=A815745-A815746 ";
    if (personId != null) {
      sql = sql + "where " + CommonFuns.splitInSql(personId, "ID");
    }
    sqlList[9] = sql;

    this.api.batchExecuteSql(sqlList);
  }

  public Vector computePerson(boolean isTry, String setId, String dateId, String[] personId, String payoffDate, String unitId)
    throws SysException
  {
    this.wagesetdao.initProcess(setId);
    try
    {
      batchHandleStandardItem(isTry, setId, personId, payoffDate);
    } catch (SysException e) {
      throw new RollbackableException("", "计算标准项出错；" + e.getSysMsg().getMessage(), e, getClass());
    }

    Vector vt = null;
    try {
      vt = batchHandleFormulaItem(isTry, setId, dateId, personId, payoffDate, unitId, false);
    }
    catch (RollbackableException be) {
      throw be;
    } catch (SysException e) {
      throw new RollbackableException("", "计算公式项出错；" + e.getSysMsg().getMessage(), e, getClass());
    }

    try
    {
      computeAnnu(isTry, setId, dateId, personId, payoffDate, unitId);
    } catch (SysException e) {
      throw new RollbackableException("", "计算年金出错；" + e.getSysMsg().getMessage(), e, getClass());
    }

    try
    {
      if ("1".equals(Constants.WAGE_DATA_FORMAT))
        adjustDataFormat(setId);
    }
    catch (SysException e) {
      throw new RollbackableException("", "调整格式出错；" + e.getSysMsg().getMessage(), e, getClass());
    }

    String sql = "update wage_payoff set cacl_date='" + CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss") + "' where payoff_id='" + dateId + "'";
    this.api.executeSql(sql);
    return vt;
  }

  public void HandleWageDept(WageDeptSumItemBO wb, String[] allField, String tempTable, String setId, String dateId, String unitId)
  {
    try
    {
      if ((setId == null) || ("".equals(setId))) return;
      if ((dateId == null) || ("".equals(dateId))) return;
      String inputField = wb.getFieldID();

      String sql = "select count(*) from B732 where B732001='" + dateId + "'";
      if (this.api.queryForInt(sql) == 0) {
        String[] dp = this.wageapi.getDeptList(setId);
        String[] sqllist = new String[dp.length];
        WageDateBO wd = (WageDateBO)this.wagedatedao.findBoById(WageDateBO.class, dateId);
        for (int i = 0; i < dp.length; i++) {
          sqllist[i] = ("insert into B732(orguid,Subid,B732001,B732002,B732700) values('" + unitId + "','" + CommonFuns.filterNull(SequenceGenerator.getKeyId("B732")) + "','" + dateId + "','" + wd.getDate() + "','" + dp[i] + "')");
        }
        this.api.batchExecuteSql(sqllist);
      }

      String menthod = "";
      if (WageDeptSumItemBO.OPERATER_COUNT.equals(wb.getOperateType())) {
        menthod = " count(*) ";
        inputField = "reccount";
      }
      else {
        menthod = " sum(" + inputField + ") ";
      }
      sql = "select count(*) from syscolumns where TBLNAME='" + tempTable + "' and Name='" + inputField + "'";
      if ("SQL SERVER".equals(Constants.DB_TYPE)) {
        sql = "select count(*) from syscolumns where id=object_id('" + tempTable + "') and Name='" + inputField + "'";
      }
      if ((WageDeptSumItemBO.OPERATER_COUNT.equals(wb.getOperateType())) || (this.api.queryForInt(sql) > 0)) {
        sql = "select A001.A001743," + menthod + " as " + inputField + " from " + tempTable + " left join A001 on " + tempTable + ".id=A001.id where " + wb.getWhere() + " group by A001.A001743";
      }
      else {
        String wagetable = "A815_set_" + setId;
        if (dateId.startsWith("TRY_")) {
          wagetable = "A815_try_" + setId;
        }
        sql = "select A001.A001743," + menthod + " as " + inputField + " from " + wagetable + " left join A001 on " + wagetable + ".id=A001.id  where " + wb.getWhere() + " group by A001.A001743";
      }
      CellVO[] cells = new CellVO[2];
      cells[0] = new CellVO();
      CommonFuns.copyProperties(cells[0], SysCacheTool.findInfoItem("", "A001743"));
      cells[1] = new CellVO();
      if (!"reccount".equals(inputField)) {
        CommonFuns.copyProperties(cells[1], SysCacheTool.findInfoItem("", inputField));
      }
      else {
        cells[1].setItemId(inputField);
      }
      Vector rs = this.api.getDataListBySql(cells, sql);

      boolean bUse = false;
      for (int i = 0; i < allField.length; i++) {
        if (allField[i].toLowerCase().equals(wb.getSumFieldID().toLowerCase())) {
          bUse = true;
          break;
        }
      }

      if ((rs != null) && (rs.size() > 0))
      {
        sql = "update b732 set " + wb.getSumFieldID() + "='0' where B732001='" + dateId + "'";
        this.api.executeSql(sql);
        if (bUse) {
          sql = "update " + tempTable + " set " + wb.getSumFieldID() + "='0'";
          this.api.executeSql(sql);
        }

        int count = rs.size();
        String[] UpdateSql = new String[count];
        String[] UpdateTemp = new String[count];
        for (int i = 0; i < count; i++) {
          CellVO[] tmp = (CellVO[])(CellVO[])rs.get(i);
          if (tmp != null) {
            UpdateSql[i] = ("update b732 set " + wb.getSumFieldID() + "='" + tmp[1].getValue() + "' where B732001='" + dateId + "' and B732700='" + tmp[0].getValue() + "'");
            if (bUse)
              UpdateTemp[i] = ("update " + tempTable + " set " + wb.getSumFieldID() + "='" + tmp[1].getValue() + "' where id in (select id from a001 where a001.a001743='" + tmp[0].getValue() + "')");
          }
        }
        this.api.batchExecuteSql(UpdateSql);
        if (bUse)
          this.api.batchExecuteSql(UpdateTemp);
      }
    }
    catch (Exception e)
    {
    }
  }

  public void batchHandleWageDept(String[] allField, String setId, String tempTable, String dateId, String unitId) throws SysException
  {
    try
    {
      List li = this.wagedeptsumdao.queryDeptSumItem(setId);
      if (li != null)
        for (int i = 0; i < li.size(); i++) {
          WageDeptSumItemBO wb = (WageDeptSumItemBO)li.get(i);
          HandleWageDept(wb, allField, tempTable, setId, dateId, unitId);
        }
    }
    catch (SysException e)
    {
      throw new RollbackableException("", "汇总项目出错；" + e.getSysMsg().getMessage(), e, getClass());
    }
  }

  public void batchHandleStandardItem(String setId, String[] personId, String payoffDate)
    throws SysException
  {
    batchHandleStandardItem(false, setId, personId, payoffDate);
  }

  public void batchHandleStandardItem(boolean isTry, String setId, String[] personId, String payoffDate) throws SysException {
    List setStdItemList = this.wagesetitemdao.querySetItemByType(setId, "0");//要查表的工资项目信息
    if ((setStdItemList != null) && (setStdItemList.size() > 0)) {//有元素才计算
      List stdItemList = new ArrayList(); //当前帐套中的所有工资项目
      HashMap stdValue = new HashMap();//记录要查表的项目是根据哪两个其它项目查出来的
      List sqlList = new ArrayList();

      HashMap numberList = new HashMap();//进一步把stdValue转换成对象

      StringBuffer select = new StringBuffer(" select A001.ID ");//查询本帐套人员的SQL
      StringBuffer from = new StringBuffer(" from wage_set_pers_r left join A001 ");
      from.append(" on wage_set_pers_r.ID=A001.ID");

      StringBuffer where = new StringBuffer(" where 1=1 ");
      where.append(" and wage_set_pers_r.A815700='" + setId + "'");
      if (personId != null) {
        where.append(" and ").append(CommonFuns.splitInSql(personId, "A001.ID"));
      }

      int count = setStdItemList.size();

      for (int i = 0; i < count; i++) {//循环处理要查表的工资项目
        WageSetItemBO setStdItem = (WageSetItemBO)setStdItemList.get(i);
        String stdId = setStdItem.getLinkId();

        WageStandardBO wsbo = (WageStandardBO)this.wagestandarddao.findBoById(WageStandardBO.class, stdId);

        if ((wsbo.getApplyMonth() != null) && (!"".equals(wsbo.getApplyMonth())) && (wsbo.getApplyMonth().indexOf("-1") < 0) && (payoffDate != null) && (payoffDate.length() >= 7))
        {
          String month = payoffDate.substring(5, 7);
          if (wsbo.getApplyMonth().indexOf(month) < 0)
          {
            continue;
          }
        }
        if ((wsbo.getFilterField() != null) && (!"".equals(wsbo.getFilterField())) && (!"-1".equals(wsbo.getFilterField()))) {
          if (from.indexOf("A796") < 0) {
            from.append(" left join A796 B on B.id=A001.id");
          }
          if (select.indexOf(wsbo.getFilterField()) < 0) {
            select.append(",").append(wsbo.getFilterField());
          }

        }

        List tmp = this.wagestditemdao.queryStdItemByStdId(stdId);
        String r_item = "";
        String h_item = "";
        String v_item = "";
        int len = tmp.size();
        for (int k = 0; k < len; k++) {
          WageStdItemBO stdItem = (WageStdItemBO)tmp.get(k);
          if ("2".equals(stdItem.getType())) {
            r_item = stdItem.getField();
          } else if ("0".equals(stdItem.getType())) {
            h_item = h_item + stdItem.getField() + ",";
            InfoItemBO itembo = SysCacheTool.findInfoItem("", stdItem.getField());
            if ((("2".equals(itembo.getItemDataType())) || ("1".equals(itembo.getItemDataType()))) && 
              (numberList.get(itembo.getItemId()) == null)) {
              numberList.put(itembo.getItemId(), itembo);
            }
          }
          else if ("1".equals(stdItem.getType())) {
            v_item = v_item + stdItem.getField() + ",";
            InfoItemBO itembo = SysCacheTool.findInfoItem("", stdItem.getField());
            if ((("2".equals(itembo.getItemDataType())) || ("1".equals(itembo.getItemDataType()))) && 
              (numberList.get(itembo.getItemId()) == null)) {
              numberList.put(itembo.getItemId(), itembo);
            }
          }

          stdItemList.add(stdItem);
        }
        stdValue.put(r_item, stdId + "|" + h_item + "|" + v_item);
      }
      int size = stdItemList.size();

      for (int j = 0; j < size; j++) {
        WageStdItemBO stdItem = (WageStdItemBO)stdItemList.get(j);
        if (select.indexOf(stdItem.getField()) < 0) {
          select.append("," + stdItem.getField());
          InfoSetBO infoset = SysCacheTool.findInfoSet(stdItem.getTable());

          if ("A815".equals(infoset.getSetId()))
            continue;
          if (from.indexOf(stdItem.getTable()) < 0) {
            if (InfoSetBO.RS_TYPE_MANY.equals(infoset.getSet_rsType())) {
              from.append(" left join (select ID," + stdItem.getField() + " from " + stdItem.getTable() + " where " + stdItem.getTable() + "000='" + "00901" + "') A" + j);
              from.append(" on A" + j + ".ID=A001.ID");
            }
            else if (!"A001".equals(stdItem.getTable())) {
              from.append(" left join ").append(stdItem.getTable());
              from.append(" on  " + stdItem.getTable() + ".ID=A001.ID");
            }

          }
          else if (InfoSetBO.RS_TYPE_MANY.equals(infoset.getSet_rsType())) {
            int index = from.indexOf("from " + stdItem.getTable());
            from.insert(index, "," + stdItem.getField() + " ");
          }

        }

      }

      String stdCountTable = "HR319#" + setId + CommonFuns.getSysDate("yyyyMMddHHss");
      StringBuffer createTableSql = new StringBuffer();
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        createTableSql.append("create table ").append(stdCountTable).append(" as ");
        createTableSql.append(select.toString()).append(from.toString()).append(where.toString());
      }
      else {
        createTableSql.append("select * into ").append(stdCountTable).append(" from (");
        createTableSql.append(select.toString()).append(from.toString()).append(where.toString());
        createTableSql.append(") aaa");
      }
      sqlList.add(createTableSql.toString());

      if ("SQL SERVER".equals(Constants.DB_TYPE)) {
        sqlList.add("alter table " + stdCountTable + " alter column ID nvarchar(200) not null");
      }
      String indexSql = "alter table " + stdCountTable + "  add constraint PK_" + stdCountTable + " primary key (ID)";
      sqlList.add(indexSql);
      sqlList.add("alter table " + stdCountTable + " add changed int");

      if (numberList.size() > 0) {
        Iterator it = numberList.keySet().iterator();
        while (it.hasNext()) {
          sqlList.add("update " + stdCountTable + " set changed=0");
          String ky = it.next().toString();
          InfoItemBO ib = (InfoItemBO)numberList.get(ky);
          if (ib.getItemCodeSet() != null) {
            List codeList = SysCacheTool.queryCodeItemBySetId(ib.getItemCodeSet());
            for (int k = 0; k < codeList.size(); k++) {
              CodeItemBO cb = (CodeItemBO)codeList.get(k);
              String codeSql = "";
              if ("SQL SERVER".equals(Constants.DB_TYPE)) {
                if ((cb.getHighValue() != null) && (!"".equals(cb.getHighValue()))) {
                  codeSql = "update " + stdCountTable + " set changed=1," + ib.getItemId() + "='" + cb.getItemId() + "' where changed=0 and cast(" + ib.getItemId() + " as numeric(20,2))>=" + cb.getLowValue() + " and cast(" + ib.getItemId() + " as numeric(20,2))<" + cb.getHighValue();
                }
                else {
                  codeSql = "update " + stdCountTable + " set changed=1," + ib.getItemId() + "='" + cb.getItemId() + "' where changed=0 and cast(" + ib.getItemId() + " as numeric(20,2))>=" + cb.getLowValue();
                }

              }
              else if ((cb.getHighValue() != null) && (!"".equals(cb.getHighValue()))) {
                codeSql = "update " + stdCountTable + " set changed=1," + ib.getItemId() + "='" + cb.getItemId() + "' where changed=0 and 0.0+" + ib.getItemId() + ">=" + cb.getLowValue() + " and 0.0+" + ib.getItemId() + "<" + cb.getHighValue();
              }
              else {
                codeSql = "update " + stdCountTable + " set changed=1," + ib.getItemId() + "='" + cb.getItemId() + "' where changed=0 and 0.0+" + ib.getItemId() + ">=" + cb.getLowValue();
              }

              sqlList.add(codeSql);
            }
          }
        }
      }

      String field = "";
      Iterator iterator = stdValue.keySet().iterator();
      while (iterator.hasNext()) {
        String key = (String)iterator.next();
        field = field + key + ",";
        String value = (String)stdValue.get(key);
        String[] rs = value.split("\\|");
        String stdId = rs[0];

        String h_item = rs[1];
        String v_item = rs[2];
        WageStandardBO wsbo = (WageStandardBO)this.wagestandarddao.findBoById(WageStandardBO.class, stdId);
        if ((h_item != null) && (h_item.length() > 0)) {
          h_item = h_item.substring(0, h_item.length() - 1);
          h_item = h_item.replaceAll(",", " || ',' || tmp.");
          h_item = stdCountTable + "." + h_item;
        }
        if ((v_item != null) && (v_item.length() > 0)) {
          v_item = v_item.substring(0, v_item.length() - 1);
          v_item = v_item.replaceAll(",", " || ',' || tmp.");
          v_item = stdCountTable + "." + v_item;
        }
        StringBuffer sb = new StringBuffer();
        sb.append(" select wage_standard_value.cell_value from wage_standard_value");
        sb.append(" where wage_standard_value.std_id='" + stdId + "'");
        if ((h_item != null) && (h_item.length() > 0)) {
          sb.append(" and " + h_item + " = wage_standard_value.hcode_value ");
        }
        if ((v_item != null) && (v_item.length() > 0)) {
          sb.append(" and " + v_item + " = wage_standard_value.vcode_value ");
        }

        StringBuffer tmpsql = new StringBuffer("update ").append(stdCountTable).append("  set ").append(key).append("=(").append(sb).append(") where exists (").append(sb).append(")");
        if ((wsbo.getFilterField() != null) && (!"".equals(wsbo.getFilterField()))) {
          tmpsql.append(" and " + wsbo.getFilterSql());
        }
        sqlList.add(tmpsql.toString());

        if ((wsbo.getSaveAsField() != null) && (!"".equals(wsbo.getSaveAsField()))) {
          InfoItemBO iib = SysCacheTool.findInfoItem("", wsbo.getSaveAsField());
          InfoSetBO isb = SysCacheTool.findInfoSet(iib.getSetId());
          if (InfoSetBO.RS_TYPE_SINGLE.equals(isb.getSet_rsType())) {
            String write = "update " + isb.getSetId() + "  set " + iib.getItemId() + "=(select " + key + " from " + stdCountTable + " bbb  where " + isb.getSetId() + ".id=bbb.id) where id in (select id from " + stdCountTable + ")";
            sqlList.add(write);
          }
          else {
            String write = "update " + isb.getSetId() + "  set " + iib.getItemId() + "=(select " + key + " from " + stdCountTable + " bbb  where " + isb.getSetId() + ".id=bbb.id) where id in (select id from " + stdCountTable + ") and " + isb.getSetId() + "000='00901'";
            sqlList.add(write);
          }
        }
      }
      String clearDataSql = "update " + stdCountTable + " set " + field;
      clearDataSql = clearDataSql.replaceAll(",", "='0.0',");
      clearDataSql = clearDataSql.substring(0, clearDataSql.length() - 1);
      sqlList.add(1, clearDataSql);

      String tmpTable = this.tmp_table + setId;
      if (isTry) {
        tmpTable = this.try_table + setId;
      }
      StringBuffer updateCountTable = new StringBuffer();
      field = field.substring(0, field.length() - 1);
      String idStr = CommonFuns.splitInSql(personId, tmpTable + "." + "ID");

      if ("ORACLE".equals(Constants.DB_TYPE)) {
        updateCountTable.append("update ").append(tmpTable).append(" set (").append(field).append(") =");
        updateCountTable.append("(").append("select " + field + " from " + stdCountTable + " where " + tmpTable + ".ID=" + stdCountTable + ".ID").append(")");
        if (personId != null)
          updateCountTable.append(" where (").append(idStr).append(")");
        else
          updateCountTable.append(" where exists ").append("(").append("select " + field + " from " + stdCountTable + " where " + tmpTable + ".ID=" + stdCountTable + ".ID").append(")");
      }
      else
      {
        String[] fs = field.split(",");
        String set = "";
        for (int i = 0; i < fs.length; i++) {
          if ("".equals(set)) {
            set = fs[i] + "=" + stdCountTable + "." + fs[i];
          }
          else {
            set = set + "," + fs[i] + "=" + stdCountTable + "." + fs[i];
          }
        }
        updateCountTable.append(" update ").append(tmpTable).append(" set ").append(set);
        updateCountTable.append(" from  ").append(stdCountTable);
        updateCountTable.append(" where " + tmpTable + ".ID=" + stdCountTable + ".ID");
        if (personId != null)
          updateCountTable.append(" and (").append(idStr).append(")");
        else {
          updateCountTable.append(" and exists ").append("(").append("select " + field + " from " + stdCountTable + " where " + tmpTable + ".ID=" + stdCountTable + ".ID").append(")");
        }
      }
      sqlList.add(updateCountTable.toString());

      String rlaTable = "wage_set_pers_r";
      StringBuffer updateRlatTable = new StringBuffer();
      updateRlatTable.delete(0, updateRlatTable.length());
      idStr = CommonFuns.splitInSql(personId, rlaTable + "." + "ID");
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        updateRlatTable.append("update ").append(rlaTable).append(" set (").append(field).append(") =");
        updateRlatTable.append("(").append("select " + field + " from " + stdCountTable + " where " + rlaTable + ".ID=" + stdCountTable + ".ID ").append(")");
        if (personId != null)
          updateRlatTable.append(" where (" + rlaTable + "." + "A815700" + "='" + setId + "' and " + idStr + ")");
        else
          updateRlatTable.append(" where(" + rlaTable + "." + "A815700" + "='" + setId + "')");
      }
      else
      {
        String[] fs = field.split(",");
        String set = "";
        for (int i = 0; i < fs.length; i++) {
          if ("".equals(set)) {
            set = fs[i] + "=" + stdCountTable + "." + fs[i];
          }
          else {
            set = set + "," + fs[i] + "=" + stdCountTable + "." + fs[i];
          }
        }

        updateRlatTable.append(" update ").append(rlaTable).append(" set ").append(set);
        updateRlatTable.append(" from ").append(stdCountTable);
        updateRlatTable.append(" where " + rlaTable + ".ID=" + stdCountTable + ".ID ");
        if (personId != null)
          updateRlatTable.append(" and (" + rlaTable + "." + "A815700" + "='" + setId + "' and " + idStr + ")");
        else {
          updateRlatTable.append(" and(" + rlaTable + "." + "A815700" + "='" + setId + "')");
        }
      }
      sqlList.add(updateRlatTable.toString());

      String dropsql = "drop table " + stdCountTable;
      int index = 0;
      try {
        for (; index < sqlList.size(); index++)
          this.api.executeSql((String)sqlList.get(index));
      }
      catch (SysException e) {
        throw new RollbackableException("计算标准表出错");
      } finally {
        if (this.api.isDBTable(stdCountTable))
          this.api.executeSql(dropsql);
      }
    }
  }

  public Vector batchHandleFormulaItem(String setId, String dateId, String[] personId, String payoffDate, String unitId)
    throws SysException
  {
    return batchHandleFormulaItem(setId, dateId, personId, payoffDate, unitId, false);
  }
  public Vector batchHandleFormulaItem(String setId, String dateId, String[] personId, String payoffDate, String unitId, boolean isInit) throws SysException {
    return batchHandleFormulaItem(false, setId, dateId, personId, payoffDate, unitId, isInit);
  }

  public void preProcess(boolean isTry, String setId) throws SysException {
    try {
      String clearsql = "delete from a815_set_" + setId + " where id not in (select id from a001)";
      if (isTry) {
        clearsql = "delete from a815_try_" + setId + " where id not in (select id from a001)";
      }
      this.wageapi.executeSql(clearsql);

      List liinput = this.wagesetitemdao.querySetItemByType(setId, "2", true);
      String inputField = "";
      for (int i = 0; i < liinput.size(); i++) {
        WageSetItemBO item = (WageSetItemBO)liinput.get(i);
        if ("".equals(inputField)) {
          inputField = item.getField();
        }
        else {
          inputField = inputField + "," + item.getField();
        }
      }
      if (!"".equals(inputField)) {
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          clearsql = "update wage_set_pers_r a set (" + inputField + ")= (select " + inputField + " from a815_set_" + setId + " b where a.id=b.id) where a815700='" + setId + "'";
          if (isTry)
            clearsql = "update wage_set_pers_r a set (" + inputField + ")= (select " + inputField + " from a815_try_" + setId + " b where a.id=b.id) where a815700='" + setId + "'";
        }
        else
        {
          String set = "";
          String[] fields = inputField.split(",");
          for (int i = 0; i < fields.length; i++) {
            if ("".equals(set)) {
              set = fields[i] + "=b." + fields[i];
            }
            else {
              set = set + "," + fields[i] + "=b." + fields[i];
            }
          }
          clearsql = "update wage_set_pers_r set " + set + "  from wage_set_pers_r a,a815_set_" + setId + " b where a.id=b.id and a.a815700='" + setId + "'";
          if (isTry) {
            clearsql = "update wage_set_pers_r set " + set + "  from wage_set_pers_r a,a815_try_" + setId + " b where a.id=b.id and a.a815700='" + setId + "'";
          }
        }
        this.wageapi.executeSql(clearsql);
      }
    }
    catch (Exception e)
    {
    }
  }

  public Vector batchHandleFormulaItem(boolean isTry, String setId, String dateId, String[] personId, String payoffDate, String unitId, boolean isInit) throws SysException
  {
    try {
      String maxItem = this.wageapi.getMaxforDepSum(setId);

      List formualList = null;
      if (!isInit) {
        formualList = this.wagesetitemdao.queryFormulaBySetId(setId);
      }
      else {
        formualList = this.wagesetinitdao.getFormularBySetId(setId);
      }

      boolean computeTax = false;
      WageSetBO sb = this.wagesetdao.findSetBySetId(setId);
      if (((sb.getCessID() != null) && (!"".equals(sb.getCessID()))) || ((sb.getCessID2() != null) && (!"".equals(sb.getCessID2()))))
      {
        computeTax = true;
      }

      if ((formualList != null) && (formualList.size() > 0)) {
        HashMap expressHash = new HashMap();
        List flaCountOrder = new ArrayList();
        List fieldList = new ArrayList();
        List sqlList = new ArrayList();
        List FNamelist = new ArrayList();

        if ("".equals(maxItem)) {
          sqlList.add("DeptSum");
          FNamelist.add("部门汇总");
        }
        if (computeTax) {
          fieldList.add("_A815.A815996");
          fieldList.add("_A815.A815997");
        }
        int count = formualList.size();
        WageFormulaTools fCommonFuns = new WageFormulaTools();
        Hashtable consttable = fCommonFuns.queryConstTable();
        boolean calcYearTax = false;
        for (int i = 0; i < count; i++) {
          WageFormulaBO formula = (WageFormulaBO)formualList.get(i);
          try
          {
            String express = fCommonFuns.formulaConstSet(formula.getExpress(), consttable);

            express = express.replaceAll("~", "'");
            formula.setExpress(express);
            expressHash.put(formula.getRsField(), formula);
            flaCountOrder.add(formula.getRsField());

            Vector fld = fCommonFuns.queryInfoItems(express);
            fieldList.addAll(fld);
            if ((formula.getRsField().equals("A815713")) || (formula.getRsField().equals("A815711"))) {
              fieldList.add("_A815.A815714");
            }
            if (formula.getRsField().equals("A815711")) {
              fieldList.add("_A815.A815710");
            }
            if (formula.getRsField().equals("A815755")) {
              fieldList.add("_A815.A815756");
              calcYearTax = true;
            }
          } catch (Exception e) {
            throw new RollbackableException("", "计算公式'" + formula.getName() + "'时出错；", e, getClass());
          }
        }

        if (calcYearTax) {
          boolean have = false;
          for (int i = 0; i < fieldList.size(); i++) {
            if (((String)fieldList.get(i)).equals("_A815.A815713")) {
              have = true;
              break;
            }
          }
          if (!have) {
            fieldList.add("_A815.A815713");
          }

        }

        count = fieldList.size();
        StringBuffer select = new StringBuffer(" select A001.ID ");
        StringBuffer from = new StringBuffer(" from  (select * from wage_set_pers_r").append(" where wage_set_pers_r.A815700='" + setId + "') ");
        from.append("wage_set_pers_r");
        from.append(" left join A001 on wage_set_pers_r.ID=A001.ID");

        StringBuffer where = new StringBuffer(" where ");
        if (personId != null)
          where.append(CommonFuns.splitInSql(personId, "A001.ID"));
        else {
          where.append(" 1=1 ");
        }

        String[] allField = new String[count];
        for (int i = 0; i < count; i++) {
          try {
            String[] tmp = ((String)fieldList.get(i)).split("\\.");
            String infoSetId = tmp[0].substring(1);
            String field = tmp[1];

            if ((infoSetId.equals("A815PREV")) && 
              (!field.endsWith("PREV"))) {
              field = field + "PREV";
            }

            allField[i] = field;
            if (select.indexOf(field + ",") < 0) {
              InfoItemBO ibo = SysCacheTool.findInfoItem("", field.replaceAll("PREV", ""));
              if ("6".equals(ibo.getItemDataType())) {
                select.append(",isnull(" + field + ",'0') as " + field);
              }
              else {
                select.append(",isnull(" + field + ",'0.0') as " + field);
              }
              InfoSetBO infoset = null;
              if (infoSetId.equals("A815PREV"))
                infoset = SysCacheTool.findInfoSet("A815");
              else {
                infoset = SysCacheTool.findInfoSet(infoSetId);
              }
              if (!"A815".equals(infoSetId))
              {
                if (from.indexOf(infoSetId) < 0) {
                  if (InfoSetBO.RS_TYPE_MANY.equals(infoset.getSet_rsType())) {
                    if (infoSetId.equals("A815PREV")) {
                      String lastdateid = this.wageapi.getLastDateID(setId, dateId);
                      from.append(" left join (select wage_pers_rela_history.pers_id as ID," + field.substring(0, 7) + " as " + field + " from A815 left join wage_pers_rela_history on A815.id=replace(wage_pers_rela_history.pers_id,'@','') and payoff_id='" + lastdateid + "' where a815702='" + lastdateid + "') A" + i);
                      from.append(" on A" + i + ".ID=A001.ID");
                    }
                    else if (infoSetId.equals("B732")) {
                      from.append(" left join (select A001.ID," + field.substring(0, 7) + " as " + field + "  from BBBB left join a001 on BBBB.id=a001.id left join B732 on a001743=b732700 and B732001='" + dateId + "') A" + i);
                      from.append(" on A" + i + ".ID=A001.ID");
                    }
                    else if (infoSetId.equals("B026")) {
                      from.append(" left join (select A001.ID," + field.substring(0, 7) + " as " + field + "  from CCCC left join a001 on CCCC.id=a001.id left join B026 on a001701=orguid and B026701=substr(a815701,1,7)) A" + i);
                      from.append(" on A" + i + ".ID=A001.ID");
                    }
                    else if (infoSetId.equals("C018")) {
                      from.append(" left join (select A001.ID," + field.substring(0, 7) + " as " + field + " from DDDD left join a001 on DDDD.id=a001.id left join C018 on C018.postid=A001.A001715 and C018000='00901') A" + i);
                      from.append(" on A" + i + ".ID=A001.ID");
                    }
                    else if (infoSetId.equals("A003")) {
                      from.append(" left join (select ID," + field.substring(0, 7) + " as " + field + "  from A003 where A003001='" + dateId + "') A" + i);
                      from.append(" on A" + i + ".ID=A001.ID");
                    }
                    else {
                      from.append(" left join (select ID," + field + " from " + infoSetId + " where " + infoSetId + "000='" + "00901" + "') A" + i);
                      from.append(" on A" + i + ".ID=A001.ID");
                    }
                  }
                  else if (!"A001".equals(infoSetId)) {
                    from.append(" left join ").append(infoSetId);
                    from.append(" on " + infoSetId + ".ID=A001.ID");
                  }

                }
                else if (InfoSetBO.RS_TYPE_MANY.equals(infoset.getSet_rsType()))
                  if (infoSetId.equals("A815PREV")) {
                    int index = from.indexOf("from A815");
                    from.insert(index, "," + field.substring(0, 7) + " as " + field + " ");
                  }
                  else if (infoSetId.equals("B732")) {
                    int index = from.indexOf("from BBBB ");
                    from.insert(index, "," + field + " ");
                  }
                  else if (infoSetId.equals("B026")) {
                    int index = from.indexOf("from CCCC ");
                    from.insert(index, "," + field + " ");
                  }
                  else if (infoSetId.equals("C018")) {
                    int index = from.indexOf("from DDDD ");
                    from.insert(index, "," + field + " ");
                  }
                  else {
                    int index = from.indexOf("from " + infoSetId);
                    from.insert(index, "," + field + " ");
                  }
              }
            }
          }
          catch (Exception e)
          {
            throw new RollbackableException("", "计算公式项'" + allField[i] + "'时出错；", e, getClass());
          }
        }
        String flaCountTable = "hr319#_" + setId + "_" + CommonFuns.getSysDate("MMddHHss");
        flaCountTable = flaCountTable.toUpperCase();
        StringBuffer sql = new StringBuffer();
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sql.append("create table ").append(flaCountTable).append(" as ").append(select.toString()).append(from.toString()).append(where.toString());
        }
        else
        {
          sql.append("select * into ").append(flaCountTable).append(" from  ( ").append(select.toString()).append(from.toString()).append(where.toString()).append(" ) aaa");
        }

        String createSql = "";
        if (isTry) {
          createSql = sql.toString().replaceAll("BBBB", "A815_TRY_" + setId).replaceAll("CCCC", "A815_TRY_" + setId).replaceAll("DDDD", "A815_TRY_" + setId);
        }
        else {
          createSql = sql.toString().replaceAll("BBBB", "A815_SET_" + setId).replaceAll("CCCC", "A815_SET_" + setId).replaceAll("DDDD", "A815_SET_" + setId);
        }

        if (isDBTable(flaCountTable)) {
          this.api.executeSql("drop table " + flaCountTable);
        }
        this.api.executeSql(createSql);
        CommonFuns.DebugLog(createSql);

        String pkName = "PK_" + flaCountTable + "_ID";
        if (pkName.length() > 30) {
          pkName = "PK_" + flaCountTable.substring(0, 23) + "_ID";
        }
        if ("SQL SERVER".equals(Constants.DB_TYPE)) {
          this.api.executeSql("alter table " + flaCountTable + " alter column ID nvarchar(100) not null");
          if (this.api.queryForInt("select count(*) from syscolumns where id=object_id('" + flaCountTable + "') and name='A815714'") > 0) {
            this.api.executeSql("alter table " + flaCountTable + " alter column A815714 nvarchar(100)  null");
          }
        }
        this.api.executeSql("alter table " + flaCountTable + "  add constraint " + pkName + " primary key (ID)");

        if (calcYearTax) {
          if ("ORACLE".equals(Constants.DB_TYPE)) {
            this.api.executeSql("alter table " + flaCountTable + " add YEARBASE number(20,2)");
          }
          else {
            this.api.executeSql("alter table " + flaCountTable + " add YEARBASE NUMERIC(20,2)");
          }
        }

        if (select.indexOf("A810702") >= 0) {
          String tmpsql = "select ID from " + flaCountTable + " where id like '#%'";
          CellVO[] header = new CellVO[1];
          header[0] = new CellVO();
          header[0].setItemId("ID");

          Vector vt = this.api.getDataListBySql(header, tmpsql);
          if ((vt.size() > 0) && ("SQL SERVER".equals(Constants.DB_TYPE))) {
            this.api.executeSql("alter table " + flaCountTable + " alter column A810702 nvarchar(100)  null");
          }
          for (int i = 0; i < vt.size(); i++) {
            CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
            String id = row[0].getValue().replaceAll("#", "");

            tmpsql = "update " + flaCountTable + " set A810702=(select isnull(A810791,isnull(A810702,'0.0')) from A810 where id='" + id + "' and A810000='00901') where id='#" + id + "'";
            this.api.executeSql(tmpsql);

            tmpsql = "update " + flaCountTable + " set A810702=(select isnull(A810792,isnull(A810702,'0.0')) from A810 where id='" + id + "' and A810000='00901') where id='" + id + "'";
            this.api.executeSql(tmpsql);
          }
          this.api.executeSql("update " + flaCountTable + " set A810702='0.00' where A810702 is null or A810702=''");
        }

        if (computeTax)
        {
          String taxAddTable = "hr319#_" + CommonFuns.getRandomNum(6);
          if (this.api.isDBTable(taxAddTable)) {
            this.api.executeSql("drop table " + taxAddTable);
          }
          FNamelist.add("生成多次交税临时表");
          if ("SQL SERVER".equals(Constants.DB_TYPE)) {
            sqlList.add("select ID, sum(cast(A815714 as NUMERIC(20,2))) taxSum,sum(cast(A815713 as NUMERIC(20,2))) wageSum  into " + taxAddTable + " from A815  where  id in (select id from " + flaCountTable + ") and A815701 like '" + payoffDate.substring(0, 7) + "%' group by ID");
          }
          else {
            sqlList.add("create table " + taxAddTable + " as select ID, sum(A815714) as taxSum,sum(A815713) as wageSum   from A815  where  id in (select id from " + flaCountTable + ") and A815701 like '" + payoffDate.substring(0, 7) + "%' group by ID");
          }

          String tmpSql = "update " + flaCountTable + "  set A815997=(select taxSum from " + taxAddTable + " where " + taxAddTable + ".ID = " + flaCountTable + ".ID) where id in (select id from " + taxAddTable + ")";
          FNamelist.add("多次交税");
          sqlList.add(tmpSql);

          tmpSql = "update " + flaCountTable + "  set A815996=(select wageSum from " + taxAddTable + " where " + taxAddTable + ".ID = " + flaCountTable + ".ID) where id in (select id from " + taxAddTable + ")";
          FNamelist.add("多次交税");
          sqlList.add(tmpSql);

          FNamelist.add("删除多次交税临时表");
          sqlList.add("drop table " + taxAddTable);

          tmpSql = "update " + flaCountTable + "  set A815996='0.0' where A815996 is null or A815996=''";
          sqlList.add(tmpSql);
          FNamelist.add("多次交税");

          tmpSql = "update " + flaCountTable + "  set A815997='0.0' where A815997 is null or A815997=''";
          sqlList.add(tmpSql);
          FNamelist.add("多次交税");
        }

        int size = flaCountOrder.size();

        String clearSql = "update " + flaCountTable + " set ";
        for (int i = 0; i < size; i++) {
          clearSql = clearSql + (String)flaCountOrder.get(i) + "='0.0',";
        }
        clearSql = clearSql.substring(0, clearSql.length() - 1);
        sqlList.add(clearSql);
        FNamelist.add("清除结果");

        String idStr = CommonFuns.splitInSql(personId, "ID");
        String resStr = "";

        WageFunctionTools functionTool = new WageFunctionTools();

        WageFormulaTools formulaTool = new WageFormulaTools();
        boolean haveA815713 = false;
        for (int i = 0; i < size; i++) {
          String rsField = flaCountOrder.get(i).toString();
          WageFormulaBO formula = (WageFormulaBO)expressHash.get(rsField);

          if ((formula.getApplyMonth() != null) && (!"".equals(formula.getApplyMonth())) && (formula.getApplyMonth().indexOf("-1") < 0) && (payoffDate != null) && (payoffDate.length() >= 7))
          {
            String month = payoffDate.substring(5, 7);
            if (formula.getApplyMonth().indexOf(month) < 0) {
              continue;
            }
          }
          String express = formula.getExpress();
          express = functionTool.preProcess(express, setId, payoffDate);
          resStr = "_{1}[a-z]{1}[0-9]{3}\\.{1}";
          Pattern p = Pattern.compile(resStr, 2);
          Matcher m = p.matcher(express);
          express = m.replaceAll("");

          resStr = "_{1}[a-z]{1}[0-9]{3}P{1}R{1}E{1}V{1}\\.{1}";
          p = Pattern.compile(resStr, 2);
          m = p.matcher(express);
          express = m.replaceAll("");

          String field = formula.getRsField();

          if (express.indexOf("if") != -1) {
            if (personId != null) {
              List proTemp = formulaTool.dealIfElse(express, idStr, flaCountTable);
              sqlList.addAll(proTemp);
              List proTempName = new ArrayList();
              for (int j = 0; j < proTemp.size(); j++) {
                proTempName.add(formula.getName());
              }
              FNamelist.addAll(proTempName);
            } else {
              List proTemp = formulaTool.dealIfElse(express, null, flaCountTable);
              sqlList.addAll(proTemp);
              List proTempName = new ArrayList();
              for (int j = 0; j < proTemp.size(); j++) {
                proTempName.add(formula.getName());
              }
              FNamelist.addAll(proTempName);
            }
          } else {
            express = express.replaceAll(";", "");
            express = formulaTool.transExpress(express);
            String updateSql = "update " + flaCountTable + " set " + express;
            if (personId != null) {
              updateSql = updateSql + " where " + idStr;
            }
            sqlList.add(updateSql);
            FNamelist.add(formula.getName());
          }

          String sbTmp = "";
          if ("ORACLE".equals(Constants.DB_TYPE)) {
            sbTmp = "update " + flaCountTable + " set " + field + "=concat('0'," + field + ") where " + field + " like '.%'";
          }
          else {
            sbTmp = "update " + flaCountTable + " set " + field + "='0'+" + field + " where " + field + " like '.%'";
          }
          sqlList.add(sbTmp);
          FNamelist.add(formula.getName());

          if (rsField.equals(maxItem)) {
            sqlList.add("DeptSum");
            FNamelist.add("部门汇总");
          }

          if (rsField.equals("A815713")) {
            haveA815713 = true;
            WageSetBO setbo = this.wagesetdao.findSetBySetId(setId);
            if ("1".equals(setbo.getMergeTax())) {
              if ("ORACLE".equals(Constants.DB_TYPE)) {
                sqlList.add("update " + flaCountTable + " set A815713=A815713+A815996 ");
              }
              else {
                sqlList.add("update " + flaCountTable + " set A815713=cast(A815713 as numeric(18,2))+cast(A815996 as numeric(18,2)) ");
              }
              FNamelist.add("合并计税");
            }
            if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
              String taxSql = this.wageapi.TaxCount(setId, setbo.getCessID(), flaCountTable, "A815713", setbo.getFilterField(), setbo.getFilterValues());
              if (!"".equals(taxSql)) {
                sqlList.add(taxSql);
                FNamelist.add("第一税率表计算");
                if ("ORACLE".equals(Constants.DB_TYPE)) {
                  sqlList.add("update " + flaCountTable + " set A815714=round((0+A815714)/2,2) where id in (select id from a796 where A796712='00901')");
                }
                else {
                  sqlList.add("update " + flaCountTable + " set A815714=round(cast(A815714 as numeric(20,2))/2,2) where id in (select id from a796 where A796712='00901')");
                }
                FNamelist.add("第一税率表残疾人减半");
              }
            }

            if ((setbo.getCessID2() != null) && (!"".equals(setbo.getCessID2()))) {
              String taxSql = this.wageapi.TaxCount(setId, setbo.getCessID2(), flaCountTable, "A815713", setbo.getFilterField2(), setbo.getFilterValues2());
              if (!"".equals(taxSql)) {
                sqlList.add(taxSql);
                FNamelist.add("第二税率表计算");

                if ("ORACLE".equals(Constants.DB_TYPE)) {
                  sqlList.add("update " + flaCountTable + " set A815714=round((0+A815714)/2,2) where id in (select id from a796 where A796712='00901')");
                }
                else {
                  sqlList.add("update " + flaCountTable + " set A815714=round(cast(A815714 as numeric(20,2))/2,2) where id in (select id from a796 where A796712='00901')");
                }
                FNamelist.add("第二税率表残疾人减半");
              }
            }
            if ((setbo.getCessID3() != null) && (!"".equals(setbo.getCessID3()))) {
              String taxSql = this.wageapi.TaxCount(setId, setbo.getCessID3(), flaCountTable, "A815713", setbo.getFilterField3(), setbo.getFilterValues3());
              if (!"".equals(taxSql)) {
                sqlList.add(taxSql);
                FNamelist.add("第三税率表计算");

                if ("ORACLE".equals(Constants.DB_TYPE)) {
                  sqlList.add("update " + flaCountTable + " set A815714=round((0+A815714)/2,2) where id in (select id from a796 where A796712='00901')");
                }
                else {
                  sqlList.add("update " + flaCountTable + " set A815714=round(cast(A815714 as numeric(20,2))/2,2) where id in (select id from a796 where A796712='00901')");
                }
                FNamelist.add("第三税率表残疾人减半");
              }
            }

            if ("1".equals(setbo.getMergeTax())) {
              if ("ORACLE".equals(Constants.DB_TYPE)) {
                sqlList.add("update " + flaCountTable + " set A815714=A815714-A815997");
              }
              else {
                sqlList.add("update " + flaCountTable + " set A815714=cast(A815714 as numeric(18,2))-cast(A815997 as numeric(18,2))");
              }
              FNamelist.add("合并计税");
            }

          }

          if (rsField.equals("A815755")) {
            WageSetBO setbo = this.wagesetdao.findSetBySetId(setId);
            if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
              String[] taxSql = this.wageapi.yearTaxCount(setId, setbo.getCessID(), flaCountTable);
              if (taxSql != null) {
                sqlList.add(taxSql[0]);
                FNamelist.add("年终奖计税计算");

                sqlList.add(taxSql[1]);
                FNamelist.add("年终奖计税计算");
              }

            }

          }

          if (rsField.equals("A815711")) {
            WageSetBO setbo = this.wagesetdao.findSetBySetId(setId);
            if (haveA815713) {
              if ("ORACLE".equals(Constants.DB_TYPE)) {
                sqlList.add("update " + flaCountTable + " set A815712=0+A815713-A815714+A815711 where A815711>0");
              }
              else {
                sqlList.add("update " + flaCountTable + " set A815712=cast(A815713 as NUMERIC(18,2))-cast(A815714 as NUMERIC(18,2))+cast(A815711 as NUMERIC(18,2)) where cast(A815711 as NUMERIC(18,2))>0 ");
              }
              FNamelist.add("计算实发");

              if ((setbo.getActCessID() != null) && (!"".equals(setbo.getActCessID()))) {
                String resql = this.wageapi.RerserveTaxCount(setId, setbo.getActCessID(), setbo.getCessID(), flaCountTable, "A815712");
                if ((resql != null) && (!"".equals(resql))) {
                  sqlList.add(resql);
                  FNamelist.add("反算应发计算");
                }
              }
              if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
                String taxSql = this.wageapi.TaxCount(setId, setbo.getCessID(), flaCountTable, "A815708", setbo.getFilterField(), setbo.getFilterValues());
                if (!"".equals(taxSql)) {
                  if ("ORACLE".equals(Constants.DB_TYPE)) {
                    taxSql = taxSql + " where A815711>0";
                  }
                  else {
                    taxSql = taxSql + " where cast(A815711 as NUMERIC(18,2))>0";
                  }
                  sqlList.add(taxSql);
                  FNamelist.add("第一税率表计算");
                }
              }
              if ("ORACLE".equals(Constants.DB_TYPE)) {
                sqlList.add("update " + flaCountTable + " set A815710=0+A815708-A815713 where A815711>0");
              }
              else {
                sqlList.add("update " + flaCountTable + " set A815710=cast(A815708 as NUMERIC(18,2))-cast(A815713 as NUMERIC(18,2)) where cast(A815711 as NUMERIC(18,2))>0");
              }
              FNamelist.add("计算不含税所得反算应发");
            }
            else {
              if ((setbo.getActCessID() != null) && (!"".equals(setbo.getActCessID()))) {
                String resql = this.wageapi.RerserveTaxCount(setId, setbo.getActCessID(), setbo.getCessID(), flaCountTable, "A815711");
                if ((resql != null) && (!"".equals(resql))) {
                  sqlList.add(resql);
                  FNamelist.add("反算应发计算");
                }
              }
              if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
                String taxSql = this.wageapi.TaxCount(setId, setbo.getCessID(), flaCountTable, "A815708", setbo.getFilterField(), setbo.getFilterValues());
                if (!"".equals(taxSql)) {
                  sqlList.add(taxSql);
                  FNamelist.add("第一税率表计算");
                }
              }
            }
          }
        }

        String tmpTable = this.tmp_table + setId;
        if (isTry) {
          tmpTable = this.try_table + setId;
        }

        String field = "";
        for (int i = 0; i < size; i++) {
          field = field + (String)flaCountOrder.get(i) + ",";
        }
        idStr = CommonFuns.splitInSql(personId, tmpTable + "." + "ID");
        field = field.substring(0, field.length() - 1);

        if ((field.indexOf("A815714") < 0) && ((field.indexOf("A815713") >= 0) || (field.indexOf("A815711") >= 0))) {
          field = field + ",A815714";
        }
        if ((field.indexOf("A815710") < 0) && (field.indexOf("A815711") >= 0)) {
          field = field + ",A815710";
        }
        if ((field.indexOf("A815756") < 0) && (field.indexOf("A815755") >= 0)) {
          field = field + ",A815756";
        }

        String updateData = "";
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          updateData = "update " + tmpTable + " set (" + field + ") =(select " + field + " from " + flaCountTable + " where " + flaCountTable + ".id=" + tmpTable + ".id ) ";
          if (personId != null)
            updateData = updateData + " where (" + idStr + ")";
          else
            updateData = updateData + " where exists (select " + field + " from " + flaCountTable + " where " + flaCountTable + ".id=" + tmpTable + ".id)";
        }
        else
        {
          updateData = "update " + tmpTable + " set ";
          String[] fs = field.split(",");
          String set = "";
          for (int j = 0; j < fs.length; j++) {
            if (j == 0) {
              set = fs[j] + "=aaa." + fs[j];
            }
            else {
              set = set + "," + fs[j] + "=aaa." + fs[j];
            }
          }
          updateData = updateData + set;
          updateData = updateData + " from " + flaCountTable + " aaa ";
          updateData = updateData + " where aaa.id=" + tmpTable + ".id ";
          if (personId != null)
            updateData = updateData + " and (" + idStr + ")";
          else {
            updateData = updateData + " and exists (select " + field + " from " + flaCountTable + " where " + flaCountTable + ".id=" + tmpTable + ".id)";
          }
        }

        sqlList.add(updateData);
        FNamelist.add("更新结果");

        String dropsql = "drop table " + flaCountTable;

        String tempsql = "";
        for (int j = 0; j < sqlList.size(); j++) {
          try {
            tempsql = (String)sqlList.get(j);

            if ("DeptSum".equals(tempsql))
            {
              batchHandleWageDept(allField, setId, flaCountTable, dateId, unitId);
            }
            else
              this.api.update(tempsql);
          }
          catch (SysException e)
          {
            String err = "批量处理公式[" + (String)FNamelist.get(j) + "]失败,SQL:" + tempsql + ",原因:" + e.getSysMsg().getMessage();
            System.out.println(err);
            throw new RollbackableException("", err, e, getClass());
          }

        }

        this.api.executeSql(dropsql);
      }
    } catch (RollbackableException be) {
      throw be;
    } catch (Exception e) {
      throw new RollbackableException("", "未知错误；" + e.getMessage(), e, getClass());
    }
    return null;
  }

  public void batchUpdatePersonWageDetail(String setId, String dateId, String payoffUnitId, String payoffDate)
    throws SysException
  {
    String curSQL = "";
    try {
      String[] sqlList = new String[9];

      String rlatable = "A795";
      List rlaItem = SysCacheTool.queryInfoItemBySetId(rlatable);
      String rlaField = "'" + payoffUnitId + "' as PERS_UNIT_ID,'" + dateId + "' as PAYOFF_ID,'" + payoffDate + "' as PAYOFF_DATE,'" + setId + "' as SET_ID,A001.A001715 as POST_ID,";
      String field = "PERS_UNIT_ID,PAYOFF_ID,PAYOFF_DATE,SET_ID,POST_ID,";
      if ((rlaItem != null) && (rlaItem.size() > 0)) {
        int count = rlaItem.size();
        for (int i = 0; i < count; i++) {
          String itemId = ((InfoItemBO)rlaItem.get(i)).getItemId();
          if ("ID".equals(itemId)) {
            itemId = rlatable + "." + itemId + " as pers_id";
            field = field + "pers_id,";
          } else {
            field = field + itemId + ",";
            itemId = rlatable + "." + itemId;
          }
          rlaField = rlaField + itemId + ",";
        }
        field = field.substring(0, field.length() - 1);
        rlaField = rlaField.substring(0, rlaField.length() - 1);
      }

      String tmpTable = this.tmp_table + setId;

      String pkName = "PK_" + tmpTable;
      try {
        this.api.executeSql("ALTER TABLE " + tmpTable + " drop CONSTRAINT " + pkName);
      }
      catch (Exception e) {
        CommonFuns.RecordLog("去除主键约束失败:" + e.getMessage());
      }

      sqlList[0] = (" update " + tmpTable + " set A815001=(select A001743 from a001 b where b.id=" + tmpTable + ".id)");

      sqlList[1] = (" update " + tmpTable + " set id=replace(id,'@','')");
      sqlList[2] = (" update " + tmpTable + " set id=replace(id,'#','')");
      sqlList[3] = (" update " + tmpTable + " set id=replace(id,'!','')");

      StringBuffer sb = new StringBuffer();
      sb.append("insert into WAGE_PERS_RELA_HISTORY (" + field + ") ");
      sb.append("select ").append(rlaField).append(" from ").append(rlatable).append(",A001,WAGE_SET_PERS_R ").append(" where " + rlatable + ".ID= WAGE_SET_PERS_R.id and A001.id=WAGE_SET_PERS_R.id and WAGE_SET_PERS_R.A815700='" + setId + "' ");

      sqlList[4] = sb.toString();

      String payofftable = "A815";
      InfoSetBO infoset = SysCacheTool.findInfoSet(payofftable);
      String pk = infoset.getSetPk();

      StringBuffer upsb = new StringBuffer();
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        upsb.append("update ").append(tmpTable);
        upsb.append(" set ").append(pk).append("=getKey('" + payofftable + "'),");
        upsb.append("A815700").append("='").append(setId).append("',");
        upsb.append("A815701").append("='").append(payoffDate).append("',");
        upsb.append("A815702").append("='").append(dateId).append("',");
        upsb.append("A815705").append("='").append(payoffUnitId).append("'");
        sqlList[5] = upsb.toString();
      }
      else {
        String cur = this.api.queryForString("select cur_value+1 from sys_sequence where seq_name = 'A815'");
        String count = this.api.queryForString("select count(*) from " + tmpTable);
        this.api.executeSql("update sys_sequence set cur_value=cur_value+" + count + " where seq_name = 'A815'");
        this.api.executeSql("alter table " + tmpTable + " add  NEW_SUBID int IDENTITY(" + cur + ", 1)");
        upsb.append("update ").append(tmpTable).append(" set subid=new_subid");
        sqlList[5] = upsb.toString();
      }

      List rsItem = SysCacheTool.queryInfoItemBySetId(payofftable);
      field = "";
      if ((rsItem != null) && (rsItem.size() > 0)) {
        int count = rsItem.size();
        for (int i = 0; i < count; i++) {
          String itemId = ((InfoItemBO)rsItem.get(i)).getItemId();
          field = field + itemId + ",";
        }
        field = field.substring(0, field.length() - 1);
      }

      sqlList[6] = ("update A815 set A815000 ='00900'  where  id in  (select ID from " + tmpTable + ")");

      sqlList[7] = ("update  " + tmpTable + "  set A815000 ='" + "00901" + "'");

      StringBuffer vsb = new StringBuffer();
      vsb.append("insert into ").append(payofftable).append("(" + field + ")");
      vsb.append(" select " + field + " from ").append(tmpTable);
      sqlList[8] = vsb.toString();

      for (int i = 0; i < sqlList.length; i++) {
        curSQL = sqlList[i];
        this.api.executeSql(curSQL);
      }

      String sql = "update a815 set A815002=(select A001758 from a001 where a001.id=a815.id) where a815702='" + dateId + "'";
      this.api.executeSql(sql);
    } catch (Exception e) {
      e.printStackTrace();
      CommonFuns.RecordLog("执行SQL出错:" + curSQL);
      throw new RollbackableException("", e.getMessage(), e, getClass());
    }
  }

  private HashMap handleOrgMapItem(String unitId, String setId, String wagesetItems)
    throws SysException
  {
    List mapList = this.wageitemsetdao.queryItem(unitId, 1);
    if ((mapList == null) || (mapList.size() == 0)) return null;

    HashMap orgMap = new HashMap();
    int count = mapList.size();
    String destTable = "";
    for (int i = 0; i < count; i++) {
      WageCostFieldBO field = (WageCostFieldBO)mapList.get(i);
      String key = field.getCostType();
      String value = field.getCostField();
      destTable = value.substring(0, 4);
      if (wagesetItems.indexOf(key) >= 0)
        orgMap.put(value, field.getSql());
    }
    HashMap rsHash = new HashMap();
    HashMap totalMap = new HashMap();

    rsHash.put("destTable", destTable);
    Iterator iterator = orgMap.keySet().iterator();
    StringBuffer sb = new StringBuffer();
    String destField = "";
    while (iterator.hasNext()) {
      String key = (String)iterator.next();
      String value = (String)orgMap.get(key);
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        sb.append("sum(").append(value).append(")").append(" as ").append(key).append(",");
      }
      else {
        sb.append("sum(cast(").append(value).append(" as NUMERIC(18,2)))").append(" as ").append(key).append(",");
      }
      destField = destField + key + ",";
    }
    rsHash.put("sumStr", sb.toString());
    rsHash.put("destField", destField);
    return rsHash;
  }
  private HashMap handleMapItem(String unitId, String setId, int mapType) throws SysException {
    List setItem = this.wagesetitemdao.querySetItemBySetId(setId);
    String wagesetItems = "";
    for (int i = 0; i < setItem.size(); i++) {
      WageSetItemBO itembo = (WageSetItemBO)setItem.get(i);
      if ("".equals(wagesetItems)) {
        wagesetItems = itembo.getField();
      }
      else {
        wagesetItems = wagesetItems + "," + itembo.getField();
      }
    }
    if (mapType == 1) {
      return handleOrgMapItem(unitId, setId, wagesetItems);
    }

    List mapList = this.wageitemsetdao.queryItem(unitId, mapType);
    if ((mapList == null) || (mapList.size() == 0)) return null;

    List wageItemList = this.wageitemsetdao.queryItem(unitId, 3);
    if ((wageItemList == null) || (wageItemList.size() == 0)) return null;

    HashMap rsHash = new HashMap();
    HashMap totalMap = new HashMap();
    HashMap costMap = new HashMap();
    String destTable = "";
    try {
      int count = mapList.size();
      for (int i = 0; i < count; i++) {
        WageCostFieldBO field = (WageCostFieldBO)mapList.get(i);
        String key = field.getCostType();
        String value = field.getCostField();
        destTable = value.substring(0, 4);
        if (wagesetItems.indexOf(key) >= 0) {
          costMap.put(key, value);
          if (mapType == 3) {
            CodeItemBO codeItem = SysCacheTool.findCodeItem(null, key);
            String superId = codeItem.getItemSuper();
            if ((!"-1".equals(superId)) && (superId != null) && (superId.trim().length() > 0)) {
              String subStr = CommonFuns.filterNull((String)totalMap.get(superId));
              subStr = subStr + "isnull(" + value + ",'0.0')+";
              totalMap.put(superId, subStr);
            }
          }
          else {
            String subStr = CommonFuns.filterNull((String)totalMap.get(key));
            subStr = subStr + "isnull(" + value + ",'0.0')+";
            totalMap.put(key, subStr);
          }
        }
      }
      rsHash.put("destTable", destTable);

      HashMap wageItemHash = new HashMap();
      if (mapType == 3) {
        count = wageItemList.size();
        for (int i = 0; i < count; i++) {
          WageCostFieldBO field = (WageCostFieldBO)wageItemList.get(i);

          String key = field.getCostType();
          String filed = field.getCostField();
          InfoItemBO item = SysCacheTool.findInfoItem(filed.substring(0, 4), filed);
          if ("3".equals(item.getItemDataType())) {
            continue;
          }
          if ((key != null) && (!"".equals(key))) {
            String value = CommonFuns.filterNull((String)wageItemHash.get(key));
            value = value + filed + "+";
            wageItemHash.put(key, value);
          }
        }
      }

      Iterator iterator = costMap.keySet().iterator();
      StringBuffer sb = new StringBuffer();
      String destField = "";
      String sourceField = "";
      while (iterator.hasNext()) {
        String key = (String)iterator.next();
        String value = "";
        String field = (String)costMap.get(key);
        if (mapType == 3) {
          value = (String)wageItemHash.get(key);
        }
        else {
          value = key;
        }
        if ((value != null) && (value.length() > 0)) {
          if (mapType == 3) {
            value = value.substring(0, value.length() - 1);
          }
          if ("ORACLE".equals(Constants.DB_TYPE)) {
            sb.append("sum(").append(value).append(")").append(" as ").append(field).append(",");
          }
          else {
            sb.append("sum(cast(").append(value).append(" as NUMERIC(18,2)))").append(" as ").append(field).append(",");
          }
          destField = destField + field + ",";
          sourceField = sourceField + value + ",";
        }
      }
      rsHash.put("destField", destField);
      rsHash.put("sumStr", sb.toString());
      rsHash.put("sourceField", sourceField);

      iterator = totalMap.keySet().iterator();
      String sumsql = "update " + destTable + " set ";
      boolean flag = false;
      while (iterator.hasNext()) {
        String key = (String)iterator.next();
        if (key != null) {
          String field = (String)costMap.get(key);
          if (field != null) {
            String value = (String)totalMap.get(key);
            if ((value != null) && (value.trim().length() > 0)) {
              sumsql = sumsql + field + "=" + value.substring(0, value.length() - 1) + ",";
              flag = true;
            }
          }
        }
      }
      if (flag) {
        sumsql = sumsql.substring(0, sumsql.length() - 1);
        rsHash.put("totalSql", sumsql);
      } else {
        rsHash.put("totalSql", "");
      }
    } catch (Exception e) {
      throw new RollbackableException("", "薪资发放错误", e, getClass());
    }
    return rsHash;
  }

  public void totalCost2Person(String unitId, String dateId, String year_month, String setId)
    throws SysException
  {
    HashMap hash = handleMapItem(unitId, setId, 2);
    if ((hash == null) || (hash.size() == 0)) return;

    String destTable = "A028";
    String oriTable = "A815";
    String sumStr = (String)hash.get("sumStr");
    String sourceStr = (String)hash.get("sourceField");
    String tmpTable = "hr319#_" + String.valueOf(new Random().nextInt(10000));

    if ((sumStr != null) && (sumStr.trim().length() > 0)) {
      sumStr = sumStr.substring(0, sumStr.length() - 1);
      sourceStr = sourceStr.substring(0, sourceStr.length() - 1);

      StringBuffer sb = new StringBuffer();
      String destField = "subid,ID,A028001," + CommonFuns.filterNull((String)hash.get("destField"));
      destField = destField.substring(0, destField.length() - 1);

      if ("ORACLE".equals(Constants.DB_TYPE)) {
        sb.append("select getKey('" + destTable + "') as subid,id,'" + year_month + "' as A028001,");
        sb.append(sumStr);
      }
      else {
        sb.append("select '1234567890' as subid,id,'" + year_month + "' as A028001,");
        sb.append(sumStr);
        sb.append(" into " + tmpTable);
      }

      sb.append(" from A815");
      sb.append(" where ").append("substring(a815701,1,7)='" + year_month + "'");
      sb.append(" and id in (select PERS_ID from WAGE_PERS_RELA_HISTORY where payoff_id='" + dateId + "')");
      sb.append(" group by A815.ID");

      String[] sql = new String[2];
      sql[0] = (" delete from " + destTable + "  where A028001='" + year_month + "'");
      int tmp473_472 = 0;
      String[] tmp473_470 = sql; tmp473_470[tmp473_472] = (tmp473_470[tmp473_472] + " and EXISTS (select pers_ID from WAGE_PERS_RELA_HISTORY his where " + destTable + ".id=his.pers_id and his.payoff_id='" + dateId + "')");

      String[] field = sourceStr.split(",");
      for (int i = 0; i < field.length; i++) {
        this.api.executeSql("update A815 set " + field[i] + "='0.00' where (" + field[i] + " is null or " + field[i] + "='') and A815702='" + dateId + "'");
      }

      if ("ORACLE".equals(Constants.DB_TYPE)) {
        sql[1] = ("insert into " + destTable + " (" + destField + ") " + sb.toString());
        this.api.batchExecuteSql(sql);
      }
      else {
        if (this.api.queryForInt("select count(*) from sysobjects where name='" + tmpTable + "'") > 0) {
          this.api.executeSql("drop table " + tmpTable);
        }
        this.api.executeSql(sb.toString());
        String cur = this.api.queryForString("select cur_value+1 from sys_sequence where seq_name = 'A028'");
        String count = this.api.queryForString("select count(*) from " + tmpTable);
        this.api.executeSql("update sys_sequence set cur_value=cur_value+" + count + " where seq_name = 'A028'");
        this.api.executeSql("alter table " + tmpTable + " add  NEW_SUBID int IDENTITY(" + cur + ", 1)");
        this.api.executeSql("update " + tmpTable + " set subid=new_subid");
        sql[1] = ("insert into " + destTable + " (" + destField + ") " + "select " + destField + " from " + tmpTable);
        this.api.batchExecuteSql(sql);
        this.api.executeSql("drop table " + tmpTable);
      }

      InfoSetBO infoset = SysCacheTool.findInfoSet(destTable);
      String totalSql = (String)hash.get("totalSql");
      if ((totalSql != null) && (totalSql.trim().length() > 0)) {
        totalSql = totalSql + " where " + destTable + "001='" + year_month + "'";
        totalSql = totalSql + " and EXISTS (select pers_ID from WAGE_PERS_RELA_HISTORY his where " + destTable + ".id=his.pers_id and his.payoff_id='" + dateId + "')";
        this.api.executeSql(totalSql);
      }
    }
  }

  public void GatherPiece(String setId, String dateId, String payOffDate, String unitId)
    throws SysException
  {
    List li = this.wageitemsetdao.queryItem(unitId, 5);
    String field = "id";
    String resultField = "id,subid,a003000,A003001,A003002";
    CellVO[] cv = null;
    String sql = "";
    Vector rs = null;
    if (li.size() > 0)
    {
      cv = new CellVO[li.size() + 1];
      cv[0] = new CellVO();
      cv[0].setItemId("id");
      for (int i = 0; i < li.size(); i++) {
        WageCostFieldBO wb = (WageCostFieldBO)li.get(i);
        field = field + ",sum(" + wb.getCostType() + ") as " + wb.getCostType();
        resultField = resultField + "," + wb.getCostField();
        cv[(i + 1)] = new CellVO();
        cv[(i + 1)].setItemId(wb.getCostType());
      }
      sql = "select " + field + " from a002  where a002001='" + dateId + "' group by id";
      rs = this.api.getDataListBySql(cv, sql);

      sql = "delete from a003 where A003001='" + dateId + "'";
      this.api.update(sql);
      if (rs.size() > 0) {
        String[] batchSql = new String[rs.size()];
        for (int i = 0; i < rs.size(); i++) {
          CellVO[] rsCV = (CellVO[])(CellVO[])rs.get(i);
          batchSql[i] = ("insert into a003(" + resultField + ") values('" + rsCV[0].getValue() + "','" + SequenceGenerator.getKeyId("A003") + "','" + "00900" + "','" + dateId + "','" + payOffDate + "'");
          for (int j = 0; j < li.size(); j++)
          {
            int tmp463_461 = i;
            String[] tmp463_459 = batchSql; tmp463_459[tmp463_461] = (tmp463_459[tmp463_461] + ",'" + rsCV[(j + 1)].getValue() + "'");
          }
          int tmp512_510 = i;
          String[] tmp512_508 = batchSql; tmp512_508[tmp512_510] = (tmp512_508[tmp512_510] + ")");
        }
        this.api.batchExecuteSql(batchSql);
      }

    }

    field = "A001743";
    resultField = "orguid,subid,b734000,b734001,b734002,b734003";
    li = this.wageitemsetdao.queryItem(unitId, 6);
    if (li.size() > 0) {
      cv = new CellVO[li.size() + 1];
      cv[0] = new CellVO();
      cv[0].setItemId("A001743");
      for (int i = 0; i < li.size(); i++) {
        WageCostFieldBO wb = (WageCostFieldBO)li.get(i);
        field = field + ",sum(" + wb.getCostType() + ") as " + wb.getCostType();
        resultField = resultField + "," + wb.getCostField();
        cv[(i + 1)] = new CellVO();
        cv[(i + 1)].setItemId(wb.getCostType());
      }
      sql = "select " + field + " from a002 left join a001 on a002.id=a001.id  where a002001='" + dateId + "' group by a001743";
      rs = this.api.getDataListBySql(cv, sql);

      WageSetBO wsbo = this.wagesetdao.findSetBySetId(setId);
      sql = "delete from b734 where b734001='" + dateId + "'";
      this.api.update(sql);
      if (rs.size() > 0) {
        String[] batchSql = new String[rs.size()];
        for (int i = 0; i < rs.size(); i++) {
          CellVO[] rsCV = (CellVO[])(CellVO[])rs.get(i);
          batchSql[i] = ("insert into b734(" + resultField + ") values('" + wsbo.getUnitId() + "','" + SequenceGenerator.getKeyId("B734") + "','" + "00900" + "','" + dateId + "','" + payOffDate + "'");
          for (int j = 0; j < rsCV.length; j++)
          {
            int tmp999_997 = i;
            String[] tmp999_995 = batchSql; tmp999_995[tmp999_997] = (tmp999_995[tmp999_997] + ",'" + rsCV[j].getValue() + "'");
          }
          int tmp1046_1044 = i;
          String[] tmp1046_1042 = batchSql; tmp1046_1042[tmp1046_1044] = (tmp1046_1042[tmp1046_1044] + ")");
        }
        this.api.batchExecuteSql(batchSql);
      }
    }
  }

  public void GatherCalcByChild(String unitId, String year_month)
    throws SysException
  {
    if ((year_month == null) || ("".equals(year_month))) return;
    if (year_month.length() > 7) year_month = year_month.substring(0, 7);

    String sql = "select count(*) from  b028 where orguid='" + unitId + "' and b028001='" + year_month + "'";
    if (this.api.queryForInt(sql) == 0) {
      String subid = SequenceGenerator.getKeyId("B028");
      sql = "insert into b028(orguid,subid,b028000,b028001,b028003) values('" + unitId + "','" + subid + "','00900','" + year_month + "','child')";
      this.api.executeSql(sql);
    }

    List list = this.wageitemsetdao.queryItem(unitId, 1);
    for (int i = 0; i < list.size(); i++) {
      WageCostFieldBO wb = (WageCostFieldBO)list.get(i);
      if ((wb.getCostField() != null) && (!"".equals(wb.getCostField()))) {
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sql = "update B028 set " + wb.getCostField() + "=(select sum(" + wb.getCostField() + ") from b028 where orguid in (select orguid from b001 where b001002='" + unitId + "') and b028001='" + year_month + "') where B028001='" + year_month + "' and orguid='" + unitId + "'";
        }
        else {
          sql = "update B028 set " + wb.getCostField() + "=(select round(sum(cast(" + wb.getCostField() + " as  NUMERIC(18,2))),2) from b028 where orguid in (select orguid from b001 where b001002='" + unitId + "') and b028001='" + year_month + "') where B028001='" + year_month + "' and orguid='" + unitId + "'";
        }
        CommonFuns.DebugLog(sql);
        this.api.executeSql(sql);
      }
      if ((wb.getCountfield() != null) && (!"".equals(wb.getCountfield()))) {
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sql = "update B028 set " + wb.getCountfield() + "=(select sum(" + wb.getCountfield() + ") from b028 where orguid in (select orguid from b001 where b001002='" + unitId + "') and b028001='" + year_month + "') where B028001='" + year_month + "' and orguid='" + unitId + "'";
        }
        else {
          sql = "update B028 set " + wb.getCountfield() + "=(select round(sum(cast(" + wb.getCountfield() + " as NUMERIC(18,2))),2) from b028 where orguid in (select orguid from b001 where b001002='" + unitId + "') and b028001='" + year_month + "') where B028001='" + year_month + "' and orguid='" + unitId + "'";
        }
        CommonFuns.DebugLog(sql);
        this.api.executeSql(sql);
      }
      if ((wb.getAvgfield() != null) && (!"".equals(wb.getAvgfield()))) {
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sql = "update B028 set " + wb.getAvgfield() + "=case when " + wb.getCountfield() + ">0 then round(" + wb.getCostField() + "/" + wb.getCountfield() + ",2) else 0 end where B028001='" + year_month + "' and orguid='" + unitId + "'";
        }
        else {
          sql = "update B028 set " + wb.getAvgfield() + "=case when cast(" + wb.getCountfield() + " as float)>0 then round(cast(" + wb.getCostField() + " as NUMERIC(18,2))/cast(" + wb.getCountfield() + " as NUMERIC(18,2)),2) else 0 end where  B028001='" + year_month + "' and orguid='" + unitId + "'";
        }
        CommonFuns.DebugLog(sql);
        this.api.executeSql(sql);
      }

    }

    sql = "select count(*) from  b721 where orguid='" + unitId + "' and b721702='" + year_month + "'";
    if (this.api.queryForInt(sql) == 0) {
      String subid = SequenceGenerator.getKeyId("B721");
      sql = "insert into b721(orguid,subid,b721000,b721702) values('" + unitId + "','" + subid + "','00900','" + year_month + "')";
      this.api.executeSql(sql);
    }
    List wolist = this.wageorgitemsetdao.queryOrgSumItem();
    if (wolist != null)
      for (int i = 0; i < wolist.size(); i++) {
        WageOrgSumItemBO wo = (WageOrgSumItemBO)wolist.get(i);
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sql = "update b721 set " + wo.getItemId() + "=(select sum(" + wo.getItemId() + ") from b721 where orguid in (select orguid from b001 where b001002='" + unitId + "') and b721702='" + year_month + "') where b721702='" + year_month + "' and orguid='" + unitId + "'";
        }
        else {
          sql = "update b721 set " + wo.getItemId() + "=(select round(sum(cast(" + wo.getItemId() + " as NUMERIC(18,2))),2) from b721 where orguid in (select orguid from b001 where b001002='" + unitId + "') and b721702='" + year_month + "') where b721702='" + year_month + "' and orguid='" + unitId + "'";
        }
        CommonFuns.DebugLog(sql);
        this.api.executeSql(sql);
      }
  }

  public void GatherCalc(String unitId, String dateId, String year_month, String setId, String[] orgId)
    throws SysException
  {
    String debug = "unitId=" + unitId + ", dateId=" + dateId + ", year_month=" + year_month + ", setId=" + setId + ",orgId=";
    if (orgId != null) {
      for (int i = 0; i < orgId.length; i++) {
        debug = debug + " " + orgId[i];
      }
    }
    CommonFuns.DebugLog(debug);
    String[] sql = new String[2];
    String destTable = "B028";

    String oriTable = this.tmp_table + setId;
    try {
      WageDateBO wb = (WageDateBO)this.wagedatedao.findBoById(WageDateBO.class, dateId);

      HashMap hash = handleMapItem(unitId, setId, 1);
      if ((hash == null) || (hash.size() == 0)) return;

      String sumStr = (String)hash.get("sumStr");
      if ((sumStr != null) && (sumStr.trim().length() > 0)) {
        sumStr = sumStr.substring(0, sumStr.length() - 1);

        StringBuffer sb = new StringBuffer();
        String destField = "subid,orguid,B028001,B028003," + CommonFuns.filterNull((String)hash.get("destField"));
        destField = destField.substring(0, destField.length() - 1);
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sb.append("select getKey('").append(destTable).append("') as subid,A795701 as orguid,year_month as B028001,'" + setId + "' as B028003,");
        }
        else {
          sb.append("select '' as subid,A795701 as orguid,year_month as B028001,'" + setId + "' as B028003,");
        }
        sb.append(sumStr);
        if ("5".equals(wb.getStatus())) {
          sb.append(" from ").append("A795,(select * from a815 where a815702='").append(dateId).append("') ").append(oriTable).append(",wage_payoff,A001");
        }
        else {
          sb.append(" from ").append("A795,").append(oriTable).append(",wage_payoff,A001");
        }
        sb.append(" where ").append(oriTable).append(".ID=A795.ID And A795.ID=A001.ID");
        sb.append(" and wage_payoff.PAYOFF_ID=").append(oriTable).append(".A815702");
        sb.append(" and ").append("wage_payoff.year_month='").append(year_month).append("'");
        sb.append(" and ").append(CommonFuns.splitInSql(orgId, "A795.A795701"));
        sb.append(" group by A795701,YEAR_MONTH");

        InfoSetBO infoset = SysCacheTool.findInfoSet(destTable);
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sql[0] = ("delete from " + destTable + " where (B028003='" + setId + "' or B028003 is null or B028003='') and B028001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
          sql[1] = ("insert into " + destTable + " (" + destField + ") " + sb.toString());
          this.api.batchExecuteSql(sql);
        }
        else {
          String[] sqlseq = new String[4];
          if (this.api.queryForInt("select count(*) from sysobjects where name='A" + dateId + "'") > 0) {
            this.api.executeSql("drop table A" + dateId);
          }
          sqlseq[0] = ("select " + destField + " into A" + dateId + " from " + destTable + " where 1=0");
          sqlseq[1] = ("alter table A" + dateId + " drop  column SUBID");
          String cur = this.api.queryForString("select cur_value+1 from sys_sequence where seq_name = '" + destTable + "'");
          String count = this.api.queryForString("select count(*) from (" + sb.toString() + ") aaaa");
          this.api.executeSql("update sys_sequence set cur_value=cur_value+" + count + " where seq_name = '" + destTable + "'");

          sqlseq[2] = ("alter table A" + dateId + " add  SUBID int IDENTITY(" + cur + ", 1)");
          sqlseq[3] = ("insert into A" + dateId + " (" + destField.replaceAll("subid,", "") + ")" + sb.toString().replaceAll("'' as subid,", ""));
          this.api.batchExecuteSql(sqlseq);

          sql[0] = ("delete from " + destTable + " where (B028003='" + setId + "' or B028003 is null or B028003='') and B028001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
          sql[1] = ("insert into " + destTable + " (" + destField + ") select " + destField + " from A" + dateId);
          this.api.batchExecuteSql(sql);
          this.api.executeSql("drop table A" + dateId);
        }

        String totalSql = (String)hash.get("totalSql");
        if ((totalSql != null) && (totalSql.trim().length() > 0)) {
          totalSql = totalSql + " where " + destTable + "001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk());
          this.api.executeSql(totalSql);
        }

        sql[0] = ("update " + destTable + " set " + destTable + "000='00900' where " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
        sql[1] = ("update " + destTable + " set " + destTable + "000='00901' where B028003='" + setId + "' and B028001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
        this.api.batchExecuteSql(sql);

        List wageItemList = this.wageitemsetdao.queryItem(unitId, 1);
        for (int i = 0; i < wageItemList.size(); i++) {
          WageCostFieldBO wo = (WageCostFieldBO)wageItemList.get(i);
          if ((wo.getCountfield() != null) && (!"".equals(wo.getCountfield()))) {
            if ("5".equals(wb.getStatus())) {
              sql[0] = ("update " + destTable + " set " + wo.getCountfield() + "=(select count(*) from (select * from a815 where a815702='" + dateId + "') A815_set_" + setId + " left join a001 on A815_set_" + setId + ".id=a001.id where " + wo.getWhere() + ") where B028003='" + setId + "' and B028001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
            }
            else {
              sql[0] = ("update " + destTable + " set " + wo.getCountfield() + "=(select count(*) from A815_set_" + setId + " left join a001 on A815_set_" + setId + ".id=a001.id where " + wo.getWhere() + " ) where B028003='" + setId + "' and B028001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
            }
            CommonFuns.DebugLog(sql[0]);
            this.api.executeSql(sql[0]);
          }

        }

        for (int i = 0; i < wageItemList.size(); i++) {
          WageCostFieldBO wo = (WageCostFieldBO)wageItemList.get(i);
          if ((wo.getAvgfield() != null) && (!"".equals(wo.getAvgfield()))) {
            if ("ORACLE".equals(Constants.DB_TYPE)) {
              sql[0] = ("update " + destTable + " set " + wo.getAvgfield() + "=case when " + wo.getCountfield() + ">0 then round(" + wo.getCostField() + "/" + wo.getCountfield() + ",2) else 0 end where B028003='" + setId + "' and B028001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
            }
            else {
              sql[0] = ("update " + destTable + " set " + wo.getAvgfield() + "=case when cast(" + wo.getCountfield() + " as float)>0 then round(cast(" + wo.getCostField() + " as NUMERIC(18,2))/cast(" + wo.getCountfield() + " as NUMERIC(18,2)),2) else 0 end where B028003='" + setId + "' and B028001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
            }
            CommonFuns.DebugLog(sql[0]);
            this.api.executeSql(sql[0]);
          }
        }

      }

      destTable = "B721";

      StringBuffer sb = new StringBuffer();
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        sb.append(" select getKey('").append(destTable).append("') as subid,A795701 as orguid,'00901' as B721000,year_month as B721702,'" + setId + "' as B721703 ");
      }
      else {
        sb.append(" select A795701 as orguid,'00901' as B721000,year_month as B721702,'" + setId + "' as B721703 ");
      }
      if ("5".equals(wb.getStatus())) {
        sb.append(" from ").append("A795,(select * from a815 where a815702='").append(dateId).append("') ").append(oriTable).append(",wage_payoff");
      }
      else {
        sb.append(" from ").append("A795,").append(oriTable).append(",wage_payoff");
      }
      sb.append(" where ").append(oriTable).append(".ID=A795.ID ");
      sb.append(" and wage_payoff.PAYOFF_ID=").append(oriTable).append(".A815702");
      sb.append(" and ").append("wage_payoff.year_month='").append(year_month).append("'");
      sb.append(" and ").append(CommonFuns.splitInSql(orgId, "A795.A795701"));
      sb.append(" group by A795701,YEAR_MONTH");

      InfoSetBO infoset = SysCacheTool.findInfoSet(destTable);
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        sql[0] = ("delete from " + destTable + " where (B721703='" + setId + "' or B721703 is null or B721703='') and B721702='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
        sql[1] = ("insert into " + destTable + " (subid,ORGUID,B721000,B721702,B721703) " + sb.toString());
        this.api.batchExecuteSql(sql);
      }
      else {
        String[] sqlseq = new String[4];
        if (this.api.queryForInt("select count(*) from sysobjects where name='A" + dateId + "'") > 0) {
          this.api.executeSql("drop table A" + dateId);
        }
        sqlseq[0] = ("select subid,ORGUID,B721000,B721702,B721703 into A" + dateId + " from B721 where 1=0");
        sqlseq[1] = ("alter table A" + dateId + " drop  column SUBID");
        String cur = this.api.queryForString("select cur_value+1 from sys_sequence where seq_name = 'B721'");
        String count = this.api.queryForString("select count(*) from (" + sb.toString() + ") aaaa");
        this.api.executeSql("update sys_sequence set cur_value=cur_value+" + count + " where seq_name = 'B721'");

        sqlseq[2] = ("alter table A" + dateId + " add  SUBID int IDENTITY(" + cur + ", 1)");
        sqlseq[3] = ("insert into A" + dateId + " (ORGUID,B721000,B721702,B721703) " + sb.toString());
        this.api.batchExecuteSql(sqlseq);
        sql[0] = ("delete from " + destTable + " where (B721703='" + setId + "' or B721703 is null or B721703='') and B721702='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
        sql[1] = ("insert into " + destTable + " (subid,ORGUID,B721000,B721702,B721703) select subid,ORGUID,B721000,B721702,B721703 from A" + dateId);
        this.api.batchExecuteSql(sql);
        this.api.executeSql("drop table A" + dateId);
      }

      List wolist = this.wageorgitemsetdao.queryOrgSumItem();
      if (wolist != null) {
        for (int i = 0; i < wolist.size(); i++) {
          WageOrgSumItemBO wo = (WageOrgSumItemBO)wolist.get(i);
          String sqlcom = "update " + destTable + " set " + wo.getItemId() + "=(";
          sqlcom = sqlcom + wo.getSql() + " and d.a001701='" + unitId + "') where B721703='" + setId + "' and B721702='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk());
          sqlcom = sqlcom.replaceAll("\\$C\\$", setId);
          if ("5".equals(wb.getStatus())) {
            sqlcom = sqlcom.replaceAll(" join  A815_set_" + setId, " join (select * from a815 where a815702='" + dateId + "')");
          }
          CommonFuns.DebugLog(sqlcom);
          this.api.executeSql(sqlcom);
        }

        sql[0] = ("update " + destTable + " set " + destTable + "000='00900' where " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
        sql[1] = ("update " + destTable + " set " + destTable + "000='00901' where B721703='" + setId + "' and B721702='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
        this.api.batchExecuteSql(sql);
      }

      WageOrgInsuraceBO orgins = this.setservice.findOrgInsBO(setId);
      if (orgins != null)
      {
        WageSetBO setbo = this.setservice.findSetBySetId(setId);
        WageUnitBO unit = this.unitservice.findUnitByID(setbo.getUnitId());
        orgins.setHouseRate(unit.getHousing_unit());
        orgins.setEndowmentRate(unit.getEndowment_unit());
        orgins.setUnemployRate(unit.getUnemployment_unit());
        orgins.setProcreateRate(unit.getProcreate_unit());
        orgins.setAnnuityRate(unit.getAnnuity_Unit());
        orgins.setCompoRate(unit.getCompo_unit());
        orgins.setMedicareRate(unit.getMedicare_unit());

        String last = CommonFuns.minusMonth(year_month, 1);

        String updateSql = "";
        if ((orgins.getHouseRate() != null) && (!"".equals(orgins.getHouseRate())) && (orgins.getHouseBase() != null) && (!"".equals(orgins.getHouseBase()))) {
          if ("1".equals(orgins.getHouseLast())) {
            updateSql = "update b028 set B028110=(select round(" + orgins.getHouseBase() + "*" + orgins.getHouseRate() + "/100,2) from b028 where orguid='" + unitId + "' and b028001='" + last + "') where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          else {
            updateSql = "update b028 set B028110=round(" + orgins.getHouseBase() + "*" + orgins.getHouseRate() + "/100,2) where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          CommonFuns.DebugLog(updateSql);
          this.api.executeSql(updateSql);
        }

        if ((orgins.getCompoRate() != null) && (!"".equals(orgins.getCompoRate())) && (orgins.getCompoBase() != null) && (!"".equals(orgins.getCompoBase()))) {
          if ("1".equals(orgins.getCompoLast())) {
            updateSql = "update b028 set B028070=(select round(" + orgins.getCompoBase() + "*" + orgins.getCompoRate() + "/100,2) from b028 where orguid='" + unitId + "' and b028001='" + last + "') where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          else {
            updateSql = "update b028 set B028070=round(" + orgins.getCompoBase() + "*" + orgins.getCompoRate() + "/100,2)  where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          CommonFuns.DebugLog(updateSql);
          this.api.executeSql(updateSql);
        }

        if ((orgins.getMedicareRate() != null) && (!"".equals(orgins.getMedicareRate())) && (orgins.getMedicareBase() != null) && (!"".equals(orgins.getMedicareBase()))) {
          if ("1".equals(orgins.getMedicareLast())) {
            updateSql = "update b028 set B028105=(select round(" + orgins.getMedicareBase() + "*" + orgins.getMedicareRate() + "/100,2) from b028 where orguid='" + unitId + "' and b028001='" + last + "') where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          else {
            updateSql = "update b028 set B028105=round(" + orgins.getMedicareBase() + "*" + orgins.getMedicareRate() + "/100,2) where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          CommonFuns.DebugLog(updateSql);
          this.api.executeSql(updateSql);
        }

        if ((orgins.getEndowmentRate() != null) && (!"".equals(orgins.getEndowmentRate())) && (orgins.getEndowmentBase() != null) && (!"".equals(orgins.getEndowmentBase()))) {
          if ("1".equals(orgins.getHouseLast())) {
            updateSql = "update b028 set B028035=(select round(" + orgins.getEndowmentBase() + "*" + orgins.getEndowmentRate() + "/100,2) from b028 where orguid='" + unitId + "' and b028001='" + last + "') where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          else {
            updateSql = "update b028 set B028035=round(" + orgins.getEndowmentBase() + "*" + orgins.getEndowmentRate() + "/100,2)  where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          CommonFuns.DebugLog(updateSql);
          this.api.executeSql(updateSql);
        }

        if ((orgins.getUnemployRate() != null) && (!"".equals(orgins.getUnemployRate())) && (orgins.getUnemployBase() != null) && (!"".equals(orgins.getUnemployBase()))) {
          if ("1".equals(orgins.getHouseLast())) {
            updateSql = "update b028 set B028100=(select round(" + orgins.getUnemployBase() + "*" + orgins.getUnemployRate() + "/100,2) from b028 where orguid='" + unitId + "' and b028001='" + last + "') where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          else {
            updateSql = "update b028 set B028100=round(" + orgins.getUnemployBase() + "*" + orgins.getUnemployRate() + "/100,2) where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          CommonFuns.DebugLog(updateSql);
          this.api.executeSql(updateSql);
        }

        if ((orgins.getAnnuityRate() != null) && (!"".equals(orgins.getAnnuityRate())) && (orgins.getAnnuityBase() != null) && (!"".equals(orgins.getAnnuityBase()))) {
          if ("1".equals(orgins.getHouseLast())) {
            updateSql = "update b028 set B028080=(select round(" + orgins.getAnnuityBase() + "*" + orgins.getAnnuityRate() + "/100,2) from b028 where orguid='" + unitId + "' and b028001='" + last + "') where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          else {
            updateSql = "update b028 set B028080=round(" + orgins.getAnnuityBase() + "*" + orgins.getAnnuityRate() + "/100,2)  where orguid='" + unitId + "' and b028001='" + year_month + "'";
          }
          CommonFuns.DebugLog(updateSql);
          this.api.executeSql(updateSql);
        }

      }

      if ((Constants.MONTHPLAN_FINISH != null) && (!"".equals(Constants.MONTHPLAN_FINISH))) {
        String[] paras = Constants.MONTHPLAN_FINISH.split(",");
        String[] batchSql = new String[paras.length];
        for (int i = 0; i < batchSql.length; i++) {
          String[] values = paras[i].split("=");
          if ("ORACLE".equals(Constants.DB_TYPE)) {
            batchSql[i] = ("update b026 set " + values[0] + "= (select sum(" + values[1] + ") from b028 where orguid='" + unitId + "' and B028001='" + year_month + "') where orguid='" + unitId + "' and B026701='" + year_month + "'");
          }
          else {
            batchSql[i] = ("update b026 set " + values[0] + "= (select sum(cast(" + values[1] + " as float)) from b028 where orguid='" + unitId + "' and B028001='" + year_month + "') where orguid='" + unitId + "' and B026701='" + year_month + "'");
          }
        }
        this.api.batchExecuteSql(batchSql);
      }
    } catch (Exception e) {
      throw new RollbackableException("", "GatherCalc错误" + e.getMessage(), e, getClass());
    }
  }

  public void totalCost2Org(String unitId, String dateId, String year_month, String setId, String[] orgId)
    throws SysException
  {
    try
    {
      HashMap hash = handleMapItem(unitId, setId, 1);
      if ((hash == null) || (hash.size() == 0)) return;
      String destTable = "B028";
      String oriTable = "A815";
      String sumStr = (String)hash.get("sumStr");
      if ((sumStr != null) && (sumStr.trim().length() > 0)) {
        sumStr = sumStr.substring(0, sumStr.length() - 1);

        StringBuffer sb = new StringBuffer();
        String destField = "subid,orguid,B028001," + CommonFuns.filterNull((String)hash.get("destField"));
        destField = destField.substring(0, destField.length() - 1);
        sb.append("select getKey('").append(destTable).append("') as subid,A795701 as orguid,year_month as B028001,");
        sb.append(sumStr);
        sb.append(" from ").append("WAGE_PERS_RELA_HISTORY,A815,wage_payoff");
        sb.append(" where WAGE_PERS_RELA_HISTORY.PERS_ID=A815.ID ");
        sb.append(" and WAGE_PERS_RELA_HISTORY.PAYOFF_ID=A815.A815702  ");
        sb.append(" and wage_payoff.PAYOFF_ID=A815.A815702");
        sb.append(" and ").append("wage_payoff.year_month='").append(year_month).append("'");
        sb.append(" and ").append(CommonFuns.splitInSql(orgId, "WAGE_PERS_RELA_HISTORY.A795701"));
        sb.append(" group by A795701,YEAR_MONTH");

        InfoSetBO infoset = SysCacheTool.findInfoSet(destTable);
        String[] sql = new String[2];
        sql[0] = ("delete from " + destTable + " where B028001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
        sql[1] = ("insert into " + destTable + " (" + destField + ") " + sb.toString());
        this.api.batchExecuteSql(sql);
        String totalSql = (String)hash.get("totalSql");
        if ((totalSql != null) && (totalSql.trim().length() > 0)) {
          totalSql = totalSql + " where " + destTable + "001='" + year_month + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk());
          this.api.executeSql(totalSql);
        }

        String[] adjustSql = new String[3];
        String year = year_month.substring(0, 4);
        String queryTotalSql = "select sum(B028115) from " + destTable + " ori where B028001 like '" + year + "%' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()) + " and dest.orguid=ori.orguid and dest.B025705='" + year + "'" + " group by ori.orguid";

        adjustSql[0] = ("update B025 dest set dest.B025730=(" + queryTotalSql + " ) where  exists (" + queryTotalSql + ")");
        adjustSql[1] = ("update B025 set B025740=B025725-B025730,B025735=round(B025730/B025725*100,3) where  B025705='" + year + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));

        adjustSql[2] = ("update B025 set B025735=concat('0',B025735) where B025735 like '.%' and B025705='" + year + "' and " + CommonFuns.splitInSql(orgId, infoset.getSetFk()));
        this.api.batchExecuteSql(adjustSql);
      }
    } catch (Exception e) {
      throw new RollbackableException("", "薪资发放错误", e, getClass());
    }
  }

  public void totalCost2Post(String unitId, String dateId, String year_month, String setId, String[] postId)
    throws SysException
  {
    HashMap hash = handleMapItem(unitId, setId, 3);
    if ((hash == null) || (hash.size() == 0)) return;
    String destTable = "C028";
    String oriTable = "A815";

    String sumStr = (String)hash.get("sumStr");
    if ((sumStr != null) && (sumStr.trim().length() > 0)) {
      sumStr = sumStr.substring(0, sumStr.length() - 1);

      StringBuffer sb = new StringBuffer();
      String destField = "subid,postId,C028001," + CommonFuns.filterNull((String)hash.get("destField"));
      destField = destField.substring(0, destField.length() - 1);
      sb.append("select getKey('").append(destTable).append("') as subid,post_id as postId,wage_payoff.year_month as C028001,");
      sb.append(sumStr);
      sb.append(" from ").append("WAGE_PERS_RELA_HISTORY,A815,wage_payoff");
      sb.append(" where WAGE_PERS_RELA_HISTORY.PERS_ID=A815.ID ");
      sb.append(" and WAGE_PERS_RELA_HISTORY.PAYOFF_ID=A815.A815702 and ").append("wage_payoff.PAYOFF_ID=A815.A815702");
      sb.append(" and wage_payoff.year_month='").append(year_month).append("'");
      sb.append(" and ").append(CommonFuns.splitInSql(postId, "WAGE_PERS_RELA_HISTORY.post_id"));
      sb.append(" group by WAGE_PERS_RELA_HISTORY.post_id,wage_payoff.YEAR_MONTH");

      InfoSetBO infoset = SysCacheTool.findInfoSet(destTable);
      String[] sql = new String[2];
      sql[0] = ("delete from " + destTable + " where C028001='" + year_month + "' and " + CommonFuns.splitInSql(postId, infoset.getSetFk()));
      sql[1] = ("insert into " + destTable + " (" + destField + ") " + sb.toString());
      this.api.batchExecuteSql(sql);

      String totalSql = (String)hash.get("totalSql");
      if ((totalSql != null) && (totalSql.trim().length() > 0)) {
        totalSql = totalSql + " where " + destTable + "001='" + year_month + "' and " + CommonFuns.splitInSql(postId, infoset.getSetFk());
        this.api.executeSql(totalSql);
      }
      this.api.batchHandleCurStatus(destTable, postId, infoset.getSetFk());
    }
  }

  public void adjustTotalPlan(String yearMonth, String payoffdate, String dateId, String setId, String payoffunitId, String[] manyHeadPersId) throws SysException
  {
    try {
      if ((manyHeadPersId == null) || (manyHeadPersId.length == 0)) return;

      String sumstr = "A815708";

      String sql = "select ID,sum(" + sumstr + ") as num from A815 where " + CommonFuns.splitInSql(manyHeadPersId, "ID") + " and A815702='" + dateId + "' group by ID";
      CellVO[] cells = new CellVO[2];
      cells[0] = new CellVO();
      cells[0].setItemId("ID");
      cells[1] = new CellVO();
      cells[1].setItemId("num");
      Vector rs = this.api.getDataListBySql(cells, sql);
      if ((rs != null) && (rs.size() > 0)) {
        int count = rs.size();
        double total = 0.0D;
        HashMap hash = new HashMap();
        for (int i = 0; i < count; i++) {
          CellVO[] tmp = (CellVO[])(CellVO[])rs.elementAt(i);
          String num = CommonFuns.filterNullToZero(tmp[1].getValue());
          total += Double.parseDouble(num);
          String pId = tmp[0].getValue();
          PersonBO pe = SysCacheTool.findPersonById(pId);
          String gzunit = pe.getGongZiGX();
          if (gzunit != null) {
            double value = Double.parseDouble(CommonFuns.filterNullToZero((String)hash.get(gzunit)));
            value += Double.parseDouble(num);
            hash.put(gzunit, String.valueOf(value));
          }
        }

        List sqlList = new ArrayList();
        if (total != 0.0D)
        {
          String update = "update B025 set B025745=B025745-" + total + ",";
          update = update + "B025750=B025750||'" + payoffdate + " 减少 多头发放调整项 " + total + "元<br>'";
          update = update + " where orguid='" + payoffunitId + "' and B025705='" + yearMonth.substring(0, 4) + "'";

          sqlList.add(update);
          if (hash.size() > 0) {
            Iterator iterator = hash.keySet().iterator();
            while (iterator.hasNext()) {
              String unit = (String)iterator.next();
              String value = CommonFuns.filterNullToZero((String)hash.get(unit));
              if (Double.parseDouble(value) != 0.0D)
              {
                String tmpsql = "update B025 set B025745=B025745+" + value + "," + "B025750=B025750||'" + payoffdate + " 增加 多头发放调整项 " + value + "元<br>'" + " where orguid='" + unit + "' and B025705='" + yearMonth.substring(0, 4) + "'";

                sqlList.add(tmpsql);
              }
            }
          }

          if (sqlList.size() > 0)
            this.api.batchExecuteSql((String[])(String[])sqlList.toArray(new String[1]));
        }
      }
    }
    catch (Exception e)
    {
      throw new RollbackableException("", "薪资发放错误", e, getClass());
    }
  }

  public void auditInputOK(String dateId, String author, String operID) throws SysException {
    String sql = "delete from WAGE_PAYOFF_AUINPUT where PAYOFF_ID='" + dateId + "' and APPROVER_ID='" + author + "' and INPUT_ID='" + operID + "'";
    this.api.executeSql(sql);
    WageAuditInputBO wib = new WageAuditInputBO();
    wib.setDateId(dateId);
    wib.setApproveId(author);
    wib.setInputId(operID);
    wib.setStatus("1");
    this.auditinputdao.saveOrUpdateBo(wib);
  }
  public void auditInputNO(String dateId, String author, String operID) throws SysException {
    String sql = "delete from WAGE_PAYOFF_AUINPUT where PAYOFF_ID='" + dateId + "' and APPROVER_ID='" + author + "' and INPUT_ID='" + operID + "'";
    this.api.executeSql(sql);
    WageAuditInputBO wib = new WageAuditInputBO();
    wib.setDateId(dateId);
    wib.setApproveId(author);
    wib.setInputId(operID);
    wib.setStatus("0");
    this.auditinputdao.saveOrUpdateBo(wib);
  }
  public List getMyAudit(String dateid, String author) throws SysException {
    return this.auditinputdao.getMyAudit(dateid, author);
  }
  public List getCalcList(String setId) throws SysException {
    return this.wageagedao.getCalcList(setId);
  }
  public void saveWageAgeCalcBO(WageAgeCalcBO bo) throws SysException {
    this.wageagedao.saveOrUpdateBo(bo);
  }
  public String execAgeCalc(String setId, String baseTime) throws SysException {
    return this.wageagedao.execAgeCalc(setId, baseTime);
  }
  public String execChildFeeCalc(String orgId, String baseTime) throws SysException {
    return this.childcalcdao.execChildFeeCalc(orgId, baseTime);
  }
  public List getChildFeeList(PageVO page, String orgID) throws SysException {
    return this.childcalcdao.getChildFeeList(page, orgID);
  }

  public Hashtable getApplyInfo(String dateID) throws SysException
  {
    return this.wageapplydao.getApplyInfo(dateID);
  }
  public Hashtable getInputAuditInfo(String dateID) throws SysException {
    return this.wageapplydao.getInputAuditInfo(dateID);
  }

  public void saveWageApplyBO(WageApplyBO bo) throws SysException {
    this.wageapplydao.saveOrUpdateBo(bo);
  }
  public void clearWageApplyBO(String dateID) throws SysException {
    this.wageapi.executeSql("delete from WAGE_APPLY_INFO where DATE_ID='" + dateID + "'");
  }
  public boolean haveApply(String dateID, String personID) throws SysException {
    String sql = "select count(*) from WAGE_APPLY_INFO where DATE_ID='" + dateID + "' and PERSON_ID='" + personID + "'";
    return this.wageapi.queryForInt(sql) > 0;
  }

  public boolean canApply(String dateID) throws SysException {
    String sql = "select distinct(user_id) as pid from wage_dept_power where set_id=(select set_id from wage_payoff where payoff_id='" + dateID + "') and user_id in (select person_id from sys_role_user_r where role_id in (select role_id from sys_role_operate where operate_id='064806'))";
    CellVO[] head = new CellVO[1];
    head[0] = new CellVO();
    head[0].setItemId("pid");
    Vector vt = this.wageapi.getDataListBySql(head, sql);
    if ((vt == null) || (vt.size() == 0)) return true;
    Hashtable ht = getApplyInfo(dateID);
    String disagree = "";
    for (int i = 0; i < vt.size(); i++) {
      CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
      if (ht.get(row[0].getValue().toString()) == null) {
        disagree = disagree + " " + CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, row[0].getValue());
        break;
      }
    }
    return "".equals(disagree);
  }
  public boolean inputAllAudit(String dateID) throws SysException {
    String sql = "select distinct(user_id) as pid from wage_dept_power where set_id=(select set_id from wage_payoff where payoff_id='" + dateID + "') and user_id in (select person_id from sys_role_user_r where role_id in (select role_id from sys_role_operate where operate_id='064803'))";
    CellVO[] head = new CellVO[1];
    head[0] = new CellVO();
    head[0].setItemId("pid");
    Vector vt = this.wageapi.getDataListBySql(head, sql);
    if ((vt == null) || (vt.size() == 0)) return true;
    Hashtable ht = getInputAuditInfo(dateID);
    String disagree = "";
    for (int i = 0; i < vt.size(); i++) {
      CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
      if (ht.get(row[0].getValue().toString()) == null) {
        disagree = disagree + " " + CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, row[0].getValue());
        break;
      }
    }
    return "".equals(disagree);
  }

  public String getInputPersonDes(String dateID) throws SysException {
    String sql = "select distinct(user_id) as pid from wage_dept_power where set_id=(select set_id from wage_payoff where payoff_id='" + dateID + "') and user_id in (select person_id from sys_role_user_r where role_id in (select role_id from sys_role_operate where operate_id='064803'))";
    CellVO[] head = new CellVO[1];
    head[0] = new CellVO();
    head[0].setItemId("pid");
    Vector vt = this.wageapi.getDataListBySql(head, sql);
    if ((vt == null) || (vt.size() == 0)) return "";
    Hashtable ht = getInputAuditInfo(dateID);
    String agree = "";
    String disagree = "";
    for (int i = 0; i < vt.size(); i++) {
      CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
      if (ht.get(row[0].getValue().toString()) != null) {
        agree = agree + " " + CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, row[0].getValue());
      }
      else {
        disagree = disagree + " " + CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, row[0].getValue());
      }
    }
    return "录入已审核:[" + agree + " ] 录入未审核:[" + disagree + " ]";
  }
  public String getApplyPersonDes(String dateID) throws SysException {
    String sql = "select distinct(user_id) as pid from wage_dept_power where set_id=(select set_id from wage_payoff where payoff_id='" + dateID + "') and user_id in (select person_id from sys_role_user_r where role_id in (select role_id from sys_role_operate where operate_id='064806'))";
    CellVO[] head = new CellVO[1];
    head[0] = new CellVO();
    head[0].setItemId("pid");
    Vector vt = this.wageapi.getDataListBySql(head, sql);
    if ((vt == null) || (vt.size() == 0)) return "";
    Hashtable ht = getApplyInfo(dateID);
    String agree = "";
    String disagree = "";
    for (int i = 0; i < vt.size(); i++) {
      CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
      if (ht.get(row[0].getValue().toString()) != null) {
        agree = agree + " " + CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, row[0].getValue());
      }
      else {
        disagree = disagree + " " + CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, row[0].getValue());
      }
    }
    return "同意审核:[" + agree + " ] 不同意审核:[" + disagree + " ]";
  }

  public int getApplyPersonCount(String dateID)
    throws SysException
  {
    String sql = "select count(distinct user_id) from wage_dept_power where set_id=(select set_id from wage_payoff where payoff_id='" + dateID + "') and user_id in (select person_id from sys_role_user_r where role_id in (select role_id from sys_role_operate where operate_id='064806'))";
    return this.wageapi.queryForInt(sql);
  }

  public int getInputPersonCount(String dateID) throws SysException {
    String sql = "select count(distinct user_id) from wage_dept_power where set_id=(select set_id from wage_payoff where payoff_id='" + dateID + "') and user_id in (select person_id from sys_role_user_r where role_id in (select role_id from sys_role_operate where operate_id='064803'))";
    return this.wageapi.queryForInt(sql);
  }

  public List generateTaxReport(User user, String dateId, String[] deptList, boolean split, String groupLevel) throws SysException
  {
    int len = Integer.parseInt(Constants.WAGE_DEPT_CODELEN);
    List result = new ArrayList();
    WageDateBO datebo = (WageDateBO)this.wagedatedao.findBoById(WageDateBO.class, dateId);
    WageSetBO setbo = this.wagesetdao.findSetBySetId(datebo.getSetId());
    if ((setbo.getCessID() != null) && (!"".equals(setbo.getCessID()))) {
      String sql = "select tax_begin from wage_cesstype where cess_id='" + setbo.getCessID() + "'";

      String tax_begin = this.api.queryForString(sql);

      String flaCountTable = "A" + dateId.substring(3).toUpperCase();

      if (isDBTable(flaCountTable)) {
        this.api.executeSql("drop table " + flaCountTable);
      }
      String select = "select A001.id as id,A001743 as dept_name,' ' as HIGH_NAME,' ' as HIGH_NAME2,case when A815713+0>" + tax_begin + " then A815713+0-" + tax_begin + " else 0.00 end as A815713,A815714+0.00 as A815714,A815708+0.00 as A815708,A815758+0.00 as TaxFree,0 as rate,0 as deduction from A815_SET_" + setbo.getSetId() + " left join A001 on A815_SET_" + setbo.getSetId() + ".id=A001.id";
      if ("SQL SERVER".equals(Constants.DB_TYPE)) {
        select = "select A001.id as id,A001743 as dept_name,' ' as HIGH_NAME,' ' as HIGH_NAME2,case when cast(A815713 as numeric(20,2))>" + tax_begin + " then cast(A815713 as numeric(20,2))-" + tax_begin + " else 0.00 end as A815713,cast(A815714 as numeric(20,2)) as A815714 ,cast(A815708 as numeric(20,2)) as A815708,cast(A815758 as numeric(20,2)) as TaxFree,0 as rate,0 as deduction from A815_SET_" + setbo.getSetId() + " left join A001 on A815_SET_" + setbo.getSetId() + ".id=A001.id";
      }

      String deptpower = "select count(*) from wage_dept_power left join wage_dept on dept_id=wage_dept.item_id where wage_dept.set_id='" + setbo.getSetId() + "' and user_id='" + user.getUserId() + "'";
      if (this.api.queryForInt(deptpower) > 0) {
        sql = sql + " and A001743 in (select dept_name from wage_dept_power left join wage_dept on dept_id=wage_dept.item_id where wage_dept.set_id='" + setbo.getSetId() + "' and user_id='" + user.getUserId() + "')";
      }

      StringBuffer createsql = new StringBuffer();
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        createsql.append("create table ").append(flaCountTable).append(" as ").append(select);
      }
      else
      {
        createsql.append("select * into ").append(flaCountTable).append(" from  ( ").append(select).append(" ) aaa");
      }

      this.api.executeSql(createsql.toString());
      if ("ORACLE".equals(Constants.DB_TYPE)) {
        this.api.executeSql("alter table " + flaCountTable + " modify HIGH_NAME VARCHAR2(80)");
        this.api.executeSql("alter table " + flaCountTable + " modify HIGH_NAME2 VARCHAR2(80)");
      }
      else {
        this.api.executeSql("alter table " + flaCountTable + " alter column HIGH_NAME NVARCHAR(80)");
        this.api.executeSql("alter table " + flaCountTable + " alter column HIGH_NAME2 NVARCHAR(80)");
        this.api.executeSql("alter table " + flaCountTable + " alter column TaxFree numeric(20,2)");
      }
      sql = "update " + flaCountTable + " set HIGH_NAME=(select HIGH_NAME from wage_dept where dept_name=" + flaCountTable + ".dept_name and set_id='" + setbo.getSetId() + "'),HIGH_NAME2=(select HIGH_NAME2 from wage_dept where dept_name=" + flaCountTable + ".dept_name and set_id='" + setbo.getSetId() + "')";
      this.api.executeSql(sql);

      CellVO[] cv = new CellVO[4];
      cv[0] = new CellVO();
      cv[0].setItemId("low");
      cv[1] = new CellVO();
      cv[1].setItemId("high");
      cv[2] = new CellVO();
      cv[2].setItemId("rate");
      cv[3] = new CellVO();
      cv[3].setItemId("deduction");

      sql = "select low,high,rate,deduction from wage_cesstable where cess_id='" + setbo.getCessID() + "' order by show_seq";
      Vector rs = this.api.getDataListBySql(cv, sql);
      if (rs.size() > 0) {
        for (int i = 0; i < rs.size(); i++) {
          CellVO[] row = (CellVO[])(CellVO[])rs.get(i);
          if (i == rs.size() - 1) {
            sql = "update " + flaCountTable + " set rate=" + row[2].getValue() + ", deduction=" + row[3].getValue() + " where A815713>" + row[0].getValue();
          }
          else {
            sql = "update " + flaCountTable + " set rate=" + row[2].getValue() + ", deduction=" + row[3].getValue() + " where A815713>" + row[0].getValue() + " and A815713<=" + row[1].getValue();
          }
          this.api.executeSql(sql);
        }

      }

      if (!split) {
        sql = "select count(*) as num,sum(A815713) as A815713,sum(A815714) as A815714,sum(A815708) as A815708,sum(TaxFree) as TaxFree,rate,sum(deduction) as deduction from " + flaCountTable;
        if ((deptList != null) && (deptList.length > 0)) {
          sql = sql + " where " + CommonFuns.splitInSql(deptList, groupLevel);
        }
        sql = sql + " group by rate order by rate";

        TableVO table = new TableVO();
        table.setTag(datebo.getYearMonth());
        table.setSetName("");
        cv = new CellVO[7];
        cv[0] = new CellVO();
        cv[0].setItemId("num");
        cv[1] = new CellVO();
        cv[1].setItemId("A815713");
        cv[2] = new CellVO();
        cv[2].setItemId("A815714");
        cv[3] = new CellVO();
        cv[3].setItemId("rate");
        cv[4] = new CellVO();
        cv[4].setItemId("deduction");
        cv[5] = new CellVO();
        cv[5].setItemId("A815708");
        cv[6] = new CellVO();
        cv[6].setItemId("TaxFree");

        table.setHeader(cv);
        rs = this.api.getDataListBySql(cv, sql);
        RecordVO[] datas = new RecordVO[rs.size()];
        for (int i = 0; i < rs.size(); i++) {
          datas[i] = new RecordVO();
          datas[i].setCell((CellVO[])(CellVO[])rs.get(i));
        }
        table.setRowData(datas);
        result.add(table);
      }
      else {
        for (int j = 0; j < deptList.length; j++) {
          sql = "select count(*) as num,sum(A815713) as A815713,sum(A815714) as A815714,sum(A815708) as A815708,sum(TaxFree) as TaxFree,rate,sum(deduction) as deduction from " + flaCountTable;
          if ((deptList != null) && (deptList.length > 0)) {
            sql = sql + " where " + groupLevel + "='" + deptList[j] + "'";
          }
          sql = sql + " group by rate order by rate";

          TableVO table = new TableVO();
          table.setTag(datebo.getYearMonth());
          table.setSetName(deptList[j].substring(len));
          cv = new CellVO[7];
          cv[0] = new CellVO();
          cv[0].setItemId("num");
          cv[1] = new CellVO();
          cv[1].setItemId("A815713");
          cv[2] = new CellVO();
          cv[2].setItemId("A815714");
          cv[3] = new CellVO();
          cv[3].setItemId("rate");
          cv[4] = new CellVO();
          cv[4].setItemId("deduction");
          cv[5] = new CellVO();
          cv[5].setItemId("A815708");
          cv[6] = new CellVO();
          cv[6].setItemId("TaxFree");

          table.setHeader(cv);
          rs = this.api.getDataListBySql(cv, sql);
          RecordVO[] datas = new RecordVO[rs.size()];
          for (int i = 0; i < rs.size(); i++) {
            datas[i] = new RecordVO();
            datas[i].setCell((CellVO[])(CellVO[])rs.get(i));
          }
          table.setRowData(datas);
          result.add(table);
        }
      }

      this.api.executeSql("drop table " + flaCountTable);
    }
    return result;
  }
  public boolean judgeFlow(WFTransaction wt, WFDefineBO wfdefine) throws SysException {
    return true;
  }
  public void whenStart(WFTransaction wt) throws SysException {
  }
  public void whenEnd(WFTransaction wt) throws SysException {
  }
  public void whenCreateNextNode(WFTransaction wt, WFNodeBO node) throws SysException {
    if (("0648".equals(wt.getOperID())) && ("0654".equals(node.getOperID()))) {
      WageDateBO wd = (WageDateBO)this.wagedatedao.findBoById(WageDateBO.class, wt.getLinkID());
      wd.setStatus("2");
      this.wagedatedao.saveOrUpdateBo(wd);
    }
  }

  public void recordChange(String setId, String payoffDate) throws SysException {
    String sql = "delete from WAGE_CHANGE_NOTE where SET_ID='" + setId + "' and PAY_MONTH='" + payoffDate + "'";
    this.api.executeSql(sql);

    String lastMonth = CommonFuns.minusMonth(payoffDate, 1);
    String lastid = this.api.queryForString("select payoff_id from wage_payoff where year_month='" + lastMonth + "' and set_id='" + setId + "'");
    if ((lastid != null) && (!"".equals(lastid)) && (Constants.WAGE_CHANGE_ITEMS != null) && (!"".equals(Constants.WAGE_CHANGE_ITEMS))) {
      String[] items = Constants.WAGE_CHANGE_ITEMS.split(",");
      for (int i = 0; i < items.length; i++) {
        sql = "select person_id,new_value,old_value from (select a815_set_" + setId + ".id as PERSON_ID,a815_set_" + setId + "." + items[i] + " as NEW_VALUE, a815." + items[i] + " as OLD_VALUE from a815_set_" + setId + " left join a815 on a815_set_" + setId + ".id=a815.id and a815.a815702='" + lastid + "' ) aaa where isnull(old_value,'0')<>isnull(new_value,'0') and person_id not in (select person_id from wage_set_per_change where set_id='" + setId + "' and addorminus='1' and change_date like '" + payoffDate + "%')";
        CellVO[] head = new CellVO[3];
        head[0] = new CellVO();
        head[0].setItemId("person_id");
        head[1] = new CellVO();
        head[1].setItemId("new_value");
        head[2] = new CellVO();
        head[2].setItemId("old_value");
        Vector vt = this.api.getDataListBySql(head, sql);
        for (int j = 0; j < vt.size(); j++) {
          CellVO[] row = (CellVO[])(CellVO[])vt.get(j);
          WageChangeRecordBO recordbo = new WageChangeRecordBO();
          recordbo.setSetID(setId);
          recordbo.setPayoffMonth(payoffDate);
          recordbo.setFieldID(items[i]);
          recordbo.setPersonID(row[0].getValue());
          recordbo.setNewValue(row[1].getValue());
          recordbo.setOldValue(row[2].getValue());
          this.wagedatedao.saveOrUpdateBo(recordbo);
        }
      }
    }
  }
}