package com.hr319wg.cont.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Vector;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.cont.dao.ContDAO;
import com.hr319wg.cont.pojo.bo.ContBO;
import com.hr319wg.cont.pojo.bo.ContSignBO;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.service.ActivePageService;
import com.hr319wg.util.CommonFuns;

public class ContService
{
  private ContDAO contdao;
  private QueryAPI queryapi;
  private ActivePageService activepageservice;

  public ActivePageService getActivepageservice()
  {
    return this.activepageservice;
  }
  public void setActivepageservice(ActivePageService activepageservice) {
    this.activepageservice = activepageservice;
  }

  public QueryAPI getQueryapi() {
    return this.queryapi;
  }
  public void setQueryapi(QueryAPI api) {
    this.queryapi = api;
  }

  public ContDAO getContdao() {
    return this.contdao;
  }
  public void setContdao(ContDAO contdao) {
    this.contdao = contdao;
  }
  public ContBO[] queryAll(String createOrgId, String personName, String approveStatus, PageVO vo) throws SysException {
    return this.contdao.queryAll(createOrgId, personName, approveStatus, vo);
  }
  public ContBO[] queryAllByApproveOrgId(String approveOrgId, String personName, String approveStatus, PageVO vo, String contOper) throws SysException {
    return this.contdao.queryAllByApproveOrgId(approveOrgId, personName, approveStatus, vo, contOper);
  }
  public ContBO[] queryAllByApproveOrgId(String approveOrgId, String personName, String approveStatus, PageVO vo) throws SysException {
    return this.contdao.queryAllByApproveOrgId(approveOrgId, personName, approveStatus, vo);
  }
  public ContBO[] queryAllByPersonId(String createOrgId, String personId) throws SysException {
    return this.contdao.queryAllByPersonId(createOrgId, personId);
  }
  public ContBO[] queryAllByTemplateId(String createOrgId, String templateId) throws SysException {
    return this.contdao.queryAllByTemplateId(createOrgId, templateId);
  }
  public String createCont(ContBO bo) throws SysException {
    return this.contdao.createBo(bo);
  }
  public void updateCont(String contId, ContBO bo) throws SysException {
    this.contdao.updateBo(contId, bo);
  }
  public void deleteCont(String contId) throws SysException {
    this.contdao.deleteBo(ContBO.class, contId);
  }
  public ContBO findContById(String contId) throws SysException {
    return (ContBO)this.contdao.findBoById(ContBO.class, contId);
  }

  public String getDismissPerson(TableVO table, User user, String orgid, String selectNewPersonIds) throws SysException {
    String qryID = "156";
    CellVO[] c1 = this.queryapi.queryInfoItem(qryID);

    table.setHeader(c1);
    table.setSetType("A");

    Hashtable hash = this.queryapi.getQuerySqlHash(user, qryID, "");
    String select = CommonFuns.filterNull((String)hash.get("SQL_SELECT_PART"));
    String from = CommonFuns.filterNull((String)hash.get("SQL_FROM_PART"));
    String condition = CommonFuns.filterNull((String)hash.get("SQL_WHERE_PART"));
    String order = CommonFuns.filterNull((String)hash.get("SQL_ORDER_PART"));
    StringBuffer sql = new StringBuffer();
    sql.append("SELECT ").append(select).append(" FROM ").append(from);
    sql.append(" WHERE 1=1 ");
    if (!"".equals(condition)) {
      sql.append(" and ").append(condition);
    }
    sql.append(" and a001.id in (select person_id from  emp_chginfo where from_branch_org='" + orgid + "' and (cont_old_end='0' or cont_old_end is null)) ");
    sql.append(" and a001.id in (select person_id from cont_person) ");
    if ((selectNewPersonIds != null) && (!"".equals(selectNewPersonIds))) {
      sql.append("and " + CommonFuns.splitInSql(selectNewPersonIds.split(","), "a001.id"));
    }
    if (!"".equals(order))
      sql.append(" order by ").append(order);
    else {
      sql.append(" order by ").append("A001.A001746");
    }
    this.activepageservice.querySql(table, sql.toString(), user, 1, Constants.COMMON_PAGE_SIZE, false);
    return sql.toString();
  }

  public TableVO getContSheet(String superId, String where) throws SysException {
    TableVO table = new TableVO();
    CellVO[] header = new CellVO[24];

    header[0] = new CellVO();
    CommonFuns.copyProperties(header[0], SysCacheTool.findInfoItem("A001", "ID"));

    header[1] = new CellVO();
    header[1].setItemName("序号");
    header[1].setItemId("SEQ");

    header[2] = new CellVO();
    CommonFuns.copyProperties(header[2], SysCacheTool.findInfoItem("", "A001705"));

    header[3] = new CellVO();
    CommonFuns.copyProperties(header[3], SysCacheTool.findInfoItem("", "A001001"));

    header[4] = new CellVO();
    CommonFuns.copyProperties(header[4], SysCacheTool.findInfoItem("", "A001077"));

    header[5] = new CellVO();
    CommonFuns.copyProperties(header[5], SysCacheTool.findInfoItem("", "A001054"));

    header[6] = new CellVO();
    CommonFuns.copyProperties(header[6], SysCacheTool.findInfoItem("", "A001007"));

    header[7] = new CellVO();
    CommonFuns.copyProperties(header[7], SysCacheTool.findInfoItem("", "A001021"));

    header[8] = new CellVO();
    CommonFuns.copyProperties(header[8], SysCacheTool.findInfoItem("", "A001011"));

    header[9] = new CellVO();
    CommonFuns.copyProperties(header[9], SysCacheTool.findInfoItem("", "A080721"));

    header[10] = new CellVO();
    CommonFuns.copyProperties(header[10], SysCacheTool.findInfoItem("", "A080710"));

    header[11] = new CellVO();
    CommonFuns.copyProperties(header[11], SysCacheTool.findInfoItem("", "A080720"));

    header[12] = new CellVO();
    header[12].setItemName("期限");
    header[13] = new CellVO();
    header[13].setItemName("开始时间");
    header[14] = new CellVO();
    header[14].setItemName("终止时间");

    header[15] = new CellVO();
    header[15].setItemName("期限");
    header[16] = new CellVO();
    header[16].setItemName("开始时间");
    header[17] = new CellVO();
    header[17].setItemName("终止时间");

    header[18] = new CellVO();
    header[18].setItemName("期限");
    header[19] = new CellVO();
    header[19].setItemName("开始时间");
    header[20] = new CellVO();
    header[20].setItemName("终止时间");

    header[21] = new CellVO();
    header[21].setItemName("期限");
    header[22] = new CellVO();
    header[22].setItemName("开始时间");
    header[23] = new CellVO();
    header[23].setItemName("终止时间");

    table.setHeader(header);

    table.setFixCols("12");
    table.setFatherColNames("劳动合同,续签合同,续签合同,续签合同");
    table.setFatherColSpans("3,3,3,3");

    String sql = "select ' ' as SEQ,A001.ID as ID,(select B001005 from B001 where orguid=A001705) as A001705,A001077,A001001,(select code_item_name from sys_code_item where code_item_id=A001007) AS A001007,(select code_item_name from sys_code_item where code_item_id=A001054) AS A001054,(select code_item_name from sys_code_item where code_item_id=A001021) as A001021,A001011,A080710,A080720,A080721 from A001 left join A080 on A001.id=A080.id where (A001701='" + superId + "' or A001705='" + superId + "') ";
    if ((where != null) && (!"".equals(where))) {
      sql = sql + " and " + where;
    }
    this.activepageservice.querySql(table, sql, null, 0, 0, false);

    if ((table.getRowData() != null) && (table.getRowData().length > 0)) {
      Hashtable ht = new Hashtable();
      for (int i = 0; i < table.getRowData().length; i++) {
        CellVO[] row = table.getRowData()[i].getCell();
        row[1].setValue(String.valueOf(i + 1));
        ht.put(row[0].getValue(), String.valueOf(i));
      }

      sql = "select id,(select code_item_name from sys_code_item where code_item_id=A710705) as A710705,A710715,A710720 from A710 where A710708 in ('022001','022002','022003') and id in (select id from a001 where A001701='" + superId + "' or A001705='" + superId + "') order by id,A710715";
      CellVO[] contheader = new CellVO[4];
      contheader[0] = new CellVO();
      contheader[0].setItemId("ID");

      contheader[1] = new CellVO();
      contheader[1].setItemId("A710705");

      contheader[2] = new CellVO();
      contheader[2].setItemId("A710715");

      contheader[3] = new CellVO();
      contheader[3].setItemId("A710720");

      Vector vt = this.activepageservice.getDataListBySql(contheader, sql);
      if (vt.size() > 0) {
        String curID = ((CellVO[])(CellVO[])vt.get(0))[0].getValue();
        int curCont = 0;
        int index = 0;
        String indexString = (String)ht.get(curID);
        CellVO[] curRow = null;
        if (indexString != null) {
          curRow = table.getRowData()[java.lang.Integer.parseInt(indexString)].getCell();
        }

        for (int i = 0; i < vt.size(); i++) {
          CellVO[] row = (CellVO[])(CellVO[])vt.get(i);
          if (row[0].getValue().equals(curID)) {
            if ((curCont < 4) && (curRow != null)) {
              curRow[(12 + curCont * 3)].setValue(CommonFuns.filterNull(row[1].getValue()));
              curRow[(13 + curCont * 3)].setValue(CommonFuns.filterNull(row[2].getValue()));
              curRow[(14 + curCont * 3)].setValue(CommonFuns.filterNull(row[3].getValue()));
            }
            curCont++;
          }
          else {
            curID = ((CellVO[])(CellVO[])vt.get(i))[0].getValue();
            indexString = (String)ht.get(curID);
            if (indexString != null) {
              curRow = table.getRowData()[java.lang.Integer.parseInt(indexString)].getCell();
            }
            else {
              curRow = null;
            }
            if (curRow != null) {
              curRow[12].setValue(CommonFuns.filterNull(row[1].getValue()));
              curRow[13].setValue(CommonFuns.filterNull(row[2].getValue()));
              curRow[14].setValue(CommonFuns.filterNull(row[3].getValue()));
            }
            curCont = 1;
          }
        }
      }
    }
    return table;
  }
  
  public void batchAddFollowCont(List<ContSignBO> list) throws SysException {
		String sql =null;
		for(ContSignBO bo : list){
			this.contdao.saveOrUpdateBo(bo);
			sql="update cont_person set cont_class='022003' where person_id = '"+bo.getPersonId()+"'";
			this.queryapi.executeSql(sql);
		}
  }
}