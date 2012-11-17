package com.hr319wg.wage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.portal.IBusiProcess;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.dao.WageAdjustDAO;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;
import com.hr319wg.wage.pojo.bo.WageAdjustRuleBO;
import com.hr319wg.wage.pojo.bo.WageNoteBO;
import com.hr319wg.wage.pojo.vo.AdjustVO;

public class WageAdjustService
{
  private WageAdjustDAO adjustdao;
  private ActivePageAPI activeapi;
  private WageSetPersonService wagesetpersonservice;
  private WageAPI wageapi;

  public WageSetPersonService getWagesetpersonservice()
  {
    return this.wagesetpersonservice;
  }

  public void setWagesetpersonservice(WageSetPersonService wagesetpersonservice) {
    this.wagesetpersonservice = wagesetpersonservice;
  }

  public WageAPI getWageapi()
  {
    return this.wageapi;
  }

  public void setWageapi(WageAPI wageapi) {
    this.wageapi = wageapi;
  }

  public ActivePageAPI getActiveapi()
  {
    return this.activeapi;
  }
  public void setActiveapi(ActivePageAPI activeapi) {
    this.activeapi = activeapi;
  }

  public WageAdjustDAO getAdjustdao() {
    return this.adjustdao;
  }
  public void setAdjustdao(WageAdjustDAO adjustdao) {
    this.adjustdao = adjustdao;
  }

  public List getAdjustList(PageVO pagevo, boolean isAppro, boolean isNotAppro, User user) throws SysException {
    return this.adjustdao.getAdjustList(pagevo, isAppro, isNotAppro, user);
  }
  public AdjustVO getAdjustVO(String itemID) throws SysException {
    WageAdjustBO adjustbo = getWageAdjustBO(itemID);
    if (adjustbo == null) return null;
    AdjustVO vo = new AdjustVO();
    vo.setAdjustbo(adjustbo);
    vo.setItemList(getAdjustDetail(itemID));
    return vo;
  }
  public AdjustVO descriptAdjustVO(AdjustVO adjustvo) throws SysException {
    adjustvo.getAdjustbo().setPersonName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, adjustvo.getAdjustbo().getPersonID()));
    adjustvo.getAdjustbo().setOrgName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, adjustvo.getAdjustbo().getOrgID()));
    adjustvo.getAdjustbo().setAudit1OperName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, adjustvo.getAdjustbo().getAudit1Oper()));
    adjustvo.getAdjustbo().setAudit2OperName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, adjustvo.getAdjustbo().getAudit2Oper()));
    adjustvo.getAdjustbo().setAudit3OperName(CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, adjustvo.getAdjustbo().getAudit3Oper()));

    if ((adjustvo.getItemList() != null) && (adjustvo.getItemList().size() > 0)) {
      for (int i = 0; i < adjustvo.getItemList().size(); i++) {
        WageAdjustDetailBO wb = (WageAdjustDetailBO)adjustvo.getItemList().get(i);
        InfoItemBO ib = SysCacheTool.findInfoItem("", wb.getFieldID());
        wb.setFieldName(ib.getItemName());
        if ("6".equals(ib.getItemDataType())) {
          wb.setOldValue(CodeUtil.interpertCode(wb.getOldValue()));
          wb.setNewValue(CodeUtil.interpertCode(wb.getNewValue()));
        }
      }
    }
    return adjustvo;
  }
  public WageAdjustBO getWageAdjustBO(String itemID) throws SysException {
    return (WageAdjustBO)this.adjustdao.findBoById(WageAdjustBO.class, itemID);
  }
  public WageAdjustBO getWageAdjustBOByLinkID(String linkID) throws SysException {
    return this.adjustdao.getWageAdjustBOByLinkID(linkID);
  }
  public void deleteAdjust(String itemIDs) throws SysException {
    String[] sql = new String[2];
    sql[0] = ("delete from wage_adjust_detail where "+CommonFuns.splitInSql(itemIDs.split(","), "item_id"));
    sql[1] = ("delete from wage_adjust where "+CommonFuns.splitInSql(itemIDs.split(","), "item_id"));
    this.activeapi.batchExecuteSql(sql);
  }

  public void saveWageAdjustBO(WageAdjustBO bo) throws SysException {
    this.adjustdao.saveOrUpdateBo(bo);
  }

  public void saveWageAdjustDetailBO(WageAdjustDetailBO bo) throws SysException {
    this.adjustdao.saveOrUpdateBo(bo);
  }
  public WageAdjustRuleBO getWageAdjustRuleBO(String orgid) throws SysException {
    return (WageAdjustRuleBO)this.adjustdao.findBoById(WageAdjustRuleBO.class, orgid);
  }
  public void saveWageAdjustRuleBO(WageAdjustRuleBO bo) throws SysException {
    if (getWageAdjustRuleBO(bo.getOrgID()) != null) {
      this.adjustdao.saveOrUpdateBo(bo);
    }
    else
      this.adjustdao.createBo(bo);
  }

  public void deleteWageAdjustDetailBO(String adjustID) throws SysException {
    this.adjustdao.deleteBo(WageAdjustDetailBO.class, adjustID);
  }
  public WageAdjustDetailBO getWageAdjustDetailBO(String adjustID) throws SysException {
    return (WageAdjustDetailBO)this.adjustdao.findBoById(WageAdjustDetailBO.class, adjustID);
  }
  public List getAdjustDetail(String itemID) throws SysException {
    return this.adjustdao.getAdjustDetail(itemID);
  }
  public void createAdjustDetail(String personID, String itemID, String[] fields) throws SysException {
    String[] personids = new String[1];
    personids[0] = personID;
    HashMap hash = this.wagesetpersonservice.queryPersonBaseItem(personids, fields);
    for (int i = 0; i < fields.length; i++) {
      WageAdjustDetailBO bo = new WageAdjustDetailBO();
      bo.setItemID(itemID);
      bo.setFieldID(fields[i]);
      Iterator it;
      if ((hash != null) && (hash.size() > 0)) {
        for (it = hash.entrySet().iterator(); it.hasNext(); ) {
          Map.Entry entry = (Map.Entry)it.next();
          String[] para = entry.getKey().toString().split("\\|");
          if (fields[i].equals(para[1])) {
            bo.setOldValue(entry.getValue().toString());
            break;
          }
        }
      }
      if ((Constants.BUSI_PROCESS_NAME != null) && (!"".equals(Constants.BUSI_PROCESS_NAME))) {
        IBusiProcess busi = (IBusiProcess)SysContext.getBean(Constants.BUSI_PROCESS_NAME);
        if (busi != null) {
          busi.initWageAdjustDetailBO(bo);
        }
      }
      saveWageAdjustDetailBO(bo);
    }
  }

  public String getAdjustMemoByLinkID(String linkID) throws SysException
  {
    WageAdjustBO bo = getWageAdjustBOByLinkID(linkID);
    if (bo == null) return "";
    return getAdjustMemo(bo.getItemID());
  }
  public String getAdjustMemo(String itemID) throws SysException {
    List list = getAdjustDetail(itemID);
    String des = "";
    if ((list != null) && (list.size() > 0)) {
      for (int i = 0; i < list.size(); i++) {
        WageAdjustDetailBO wagebo = (WageAdjustDetailBO)list.get(i);
        InfoItemBO ib = SysCacheTool.findInfoItem("", wagebo.getFieldID());
        des = des + ib.getItemName() + ": 原值_" + CodeUtil.interpertCode(wagebo.getOldValue()) + " 新值_" + CodeUtil.interpertCode(wagebo.getNewValue()) + "  ";
      }
    }
    return des;
  }
  public void saveWageNoteBO(String pid, String itemID) throws SysException {
    WageNoteBO bo = new WageNoteBO();
    PersonBO pb = SysCacheTool.findPersonById(pid);
    bo.setPersonId(pb.getPersonId());
    bo.setPersonName(pb.getName());
    bo.setDate(CommonFuns.getSysDate("yyyy-MM-dd"));
    bo.setUnitId(pb.getOrgId());
    bo.setPersonDept(pb.getDeptId());
    bo.setLinkSet(this.wageapi.querySetByPersonID(pid));
    bo.setCause("薪酬调整");

    String des = getAdjustMemo(itemID);
    bo.setDesc(des);
    bo.setOperType(WageNoteBO.TYPE_POST_CHANGE);
    bo.setOperTime(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
    this.adjustdao.createBo(bo);
  }

  public void ValidateAdjust(User user, String itemIDs) throws SysException {
	  String[]itemID2=itemIDs.split(",");
	  for(int k=0;k<itemID2.length;k++){
		  WageAdjustBO adjust = getWageAdjustBO(itemID2[k]);
		    if (adjust != null) {
		      List itemList = getAdjustDetail(itemID2[k]);

		      List setList = new ArrayList();
		      for (int i = 0; i < itemList.size(); i++) {
		        WageAdjustDetailBO bo = (WageAdjustDetailBO)itemList.get(i);
		        String setId = SysCacheTool.findInfoItem("", bo.getFieldID()).getSetId();
		        if (!setList.contains(setId)) {
		          setList.add(setId);
		        }
		      }
		      for (int i = 0; i < setList.size(); i++) {
		        String setId = (String)setList.get(i);
		        List items = new ArrayList();
		        for (int j = 0; j < itemList.size(); j++) {
		          WageAdjustDetailBO bo = (WageAdjustDetailBO)itemList.get(j);
		          String setid = SysCacheTool.findInfoItem("", bo.getFieldID()).getSetId();
		          if ((setId.equals(setid)) && (!bo.getFieldID().equals(setId + "000"))) {
		            items.add(bo);
		          }
		        }
		        InfoSetBO setbo = SysCacheTool.findInfoSet(setId);
		        if (setbo.getSet_rsType().equals("2")) {
		          String[] infoItems = new String[items.size()];
		          String[] itemValues = new String[items.size()];
		          if (items.size() > 0) {
		            for (int m = 0; m < items.size(); m++) {
		              WageAdjustDetailBO bo = (WageAdjustDetailBO)items.get(m);
		              infoItems[m] = bo.getFieldID();
		              if ((bo.getNewValue() != null) && (!bo.getNewValue().equals("")))
		                itemValues[m] = bo.getNewValue();
		              else {
		                itemValues[m] = "";
		              }
		            }
		            this.activeapi.addPageInfo(setId, user, null, adjust.getPersonID(), true, infoItems, itemValues);
		          }
		        } else {
		          if ((!setbo.getSet_rsType().equals("1")) || 
		            (items.size() <= 0)) continue;
		          String[] infoItems = new String[items.size()];
		          String[] itemValues = new String[items.size()];
		          for (int m = 0; m < items.size(); m++) {
		            WageAdjustDetailBO bo = (WageAdjustDetailBO)items.get(m);
		            infoItems[m] = bo.getFieldID();
		            itemValues[m] = bo.getNewValue();
		          }
		          this.activeapi.updatePageInfo(setId, user, adjust.getPersonID(), null, false, null, null, infoItems, itemValues);
		        }
		      }
		      adjust.setStatus(WageAdjustBO.STATUS_ADJUST);
		      adjust.setAdjustDate(CommonFuns.getSysDate("yyyy-MM-dd"));
		      saveWageAdjustBO(adjust);
		      saveWageNoteBO(adjust.getPersonID(), itemID2[k]);
		    }
	  }
  }
}