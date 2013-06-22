package com.hr319wg.wage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

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

public class WageAdjustService{
  private WageAdjustDAO adjustdao;
  private ActivePageAPI activeapi;
  private WageSetPersonService wagesetpersonservice;
  private WageAPI wageapi;
  private JdbcTemplate jdbcTemplate;

  public JdbcTemplate getJdbcTemplate() {
	return jdbcTemplate;
  }

  public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
	this.jdbcTemplate = jdbcTemplate;
  }

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

  public List getAdjustList(PageVO pagevo, boolean isAppro, User user, String orgID, String name, String time, String time2) throws SysException {
    return this.adjustdao.getAdjustList(pagevo, isAppro, user, orgID, name, time, time2);
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

	public String ValidateAdjust(User user, String itemIDs) throws SysException {
		String message="";
		String[] itemID2 = itemIDs.split(",");
		//循环每个提醒
		for (int k = 0; k < itemID2.length; k++) {
			WageAdjustBO adjust = getWageAdjustBO(itemID2[k]);
			PersonBO p=SysCacheTool.findPersonById(adjust.getPersonID());
			if (adjust != null && p!=null) {
				String sql="select a815700 from wage_set_pers_r where id='"+adjust.getPersonID()+"' union select a815700 from wage_set_pers_r_bak where id='"+adjust.getPersonID()+"'";
				List wageSetList=this.jdbcTemplate.queryForList(sql);
				if(wageSetList!=null && wageSetList.size()>1){
					sql="select wm_concat(w.set_name) from (select a815700 from wage_set_pers_r where id='"+adjust.getPersonID()+"' union select a815700 from wage_set_pers_r_bak where id='"+adjust.getPersonID()+"') a,wage_set w where a.a815700=w.set_id";
					message+=p.getName()+",所在帐套"+this.activeapi.queryForString(sql)+"\\n";
					continue;
				}
				//处理关联项目_begin
				List itemList = getAdjustDetail(itemID2[k]);
				List<WageAdjustDetailBO> wageList = new ArrayList<WageAdjustDetailBO>();
				
				List setList = new ArrayList();
				for (int i = 0; i < itemList.size(); i++) {
					WageAdjustDetailBO bo = (WageAdjustDetailBO) itemList.get(i);
					String setId = SysCacheTool.findInfoItem("",bo.getFieldID()).getSetId();
					if (!setList.contains(setId)) {
						if(!"A815".equals(setId)){
							setList.add(setId);							
						}else{
							wageList.add(bo);
						}
					}
				}
				for (int i = 0; i < setList.size(); i++) {
					String setId = (String) setList.get(i);
					List items = new ArrayList();
					for (int j = 0; j < itemList.size(); j++) {
						WageAdjustDetailBO bo = (WageAdjustDetailBO) itemList.get(j);
						String setid = SysCacheTool.findInfoItem("",bo.getFieldID()).getSetId();
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
								WageAdjustDetailBO bo = (WageAdjustDetailBO) items.get(m);
								infoItems[m] = bo.getFieldID();
								if ((bo.getNewValue() != null) && (!"".equals(bo.getNewValue()))){
									itemValues[m] = bo.getNewValue();
								}else {
									itemValues[m] = "";
								}
							}
							this.activeapi.addPageInfo(setId, user, null, adjust.getPersonID(), true, infoItems, itemValues);
						}
					} else {
						if ((!setbo.getSet_rsType().equals("1")) || (items.size() <= 0)){
							continue;
						}
						String[] infoItems = new String[items.size()];
						String[] itemValues = new String[items.size()];
						for (int m = 0; m < items.size(); m++) {
							WageAdjustDetailBO bo = (WageAdjustDetailBO) items.get(m);
							infoItems[m] = bo.getFieldID();
							itemValues[m] = bo.getNewValue();
						}
						this.activeapi.updatePageInfo(setId, user, adjust.getPersonID(), null, false, null, null, infoItems, itemValues);
					}
				}//处理关联项目_end
				
				//处理A815关联
				if(wageList.size()>0){
					String updateSql="";
					String updateSql2="";
					String wageSet=String.valueOf(wageSetList.get(0));
					for(WageAdjustDetailBO bo : wageList){
						String fieldID=bo.getFieldID();
						updateSql+=fieldID+"='"+(bo.getNewValue()==null?"0":bo.getNewValue())+"',";
						sql="select count(*) from wage_set_item w where w.set_id='"+wageSet+"' and w.item_field='"+fieldID+"' and w.item_type='2'";
						if(this.jdbcTemplate.queryForInt(sql)==1){//是否录入项
							updateSql2+=fieldID+"='"+(bo.getNewValue()==null?"0":bo.getNewValue())+"',";
						}
					}
					if(updateSql.length()>0){
						updateSql=updateSql.substring(0, updateSql.length()-1);						
					}
					if(updateSql2.length()>0){
						updateSql2=updateSql2.substring(0, updateSql2.length()-1);						
					}
					sql="select a815700 from wage_set_pers_r where id='"+p.getPersonId()+"'";
					wageSet=this.activeapi.queryForString(sql);
					if(wageSet!=null){//未暂停工资
						if(updateSql2.length()>0){
							sql="update wage_set_pers_r set "+updateSql2 +" where id='"+p.getPersonId()+"'";
							this.jdbcTemplate.execute(sql);							
						}
						if(this.activeapi.isDBTable("A815_SET_"+wageSet) && updateSql.length()>0){
							sql="update A815_SET_"+wageSet+" set "+updateSql +" where id='"+p.getPersonId()+"'";
							this.jdbcTemplate.execute(sql);						
						}
					}else{
						if(updateSql2.length()>0){
							sql="update wage_set_pers_r_bak set "+updateSql2 +" where id='"+p.getPersonId()+"'";
							this.jdbcTemplate.execute(sql);
						}
					}
				}
				adjust.setStatus(WageAdjustBO.STATUS_ADJUST);
				adjust.setAdjustDate(CommonFuns.getSysDate("yyyy-MM-dd"));
				saveWageAdjustBO(adjust);
				saveWageNoteBO(adjust.getPersonID(), itemID2[k]);
			}
		}
		return message;
	}
}