package com.hr319wg.qry.util;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Hashtable;

import com.hr319wg.ccp.pojo.bo.PartyBO;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.pojo.bo.QueryBO;
import com.hr319wg.qry.pojo.bo.QueryConditionBO;
import com.hr319wg.qry.pojo.bo.QueryItemBO;
import com.hr319wg.qry.pojo.vo.StaticVO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class QueryUtil
{
  private StringBuffer parseSelect(String[] ids)
    throws SysException
  {
    try
    {
      StringBuffer sb = new StringBuffer();
      if ((ids == null) || (ids.length <= 0))
        return sb;
      for (int i = 0; i < ids.length; i++) {
        if (sb.indexOf(ids[i]) < 0)
          sb.append(ids[i]).append(",");
      }
      return sb.deleteCharAt(sb.length() - 1); } catch (Exception e) {
    	  throw new SysException("组合sql语句错误", "根据指标集id拼select语句", e, getClass());
    }
  }

  public StringBuffer parseOrder(QueryItemBO[] bos) throws SysException
  {
    try {
      StringBuffer sb = new StringBuffer();
      if (bos == null) return sb;
      ArrayList list = new ArrayList();
      for (int i = 0; i < bos.length; i++) list.add(null);
      for (int i = 0; i < bos.length; i++) {
        if (bos[i].getOrderFlag() != null)
          list.add(bos[i].getOrderSeq(), bos[i]);
      }
      for (int i = 0; i < list.size(); i++) {
        QueryItemBO b = (QueryItemBO)list.get(i);
        if ((b != null) && ("0".equals(b.getOrderFlag())))
          sb.append(b.getItemId()).append(" ASC, ");
        else if ((b != null) && ("1".equals(b.getOrderFlag()))) {
          sb.append(b.getItemId()).append(" DESC, ");
        }
      }
      if (sb.length() > 0)
        sb.delete(sb.length() - 2, sb.length());
      return sb; } catch (Exception e) {
    	  throw new SysException("组合sql语句错误", "拼装排序字段错误", e, getClass());
    }
  }

  public StringBuffer parseStaticSelect(QueryBO bo) throws SysException
  {
    try {
      StringBuffer sb = new StringBuffer();
      if (bo == null) {
        return null;
      }
      String scaleTable = getScaleTable(bo.getSetType(), bo.getUnitType());
      String pk = getSetPk(bo.getSetType());

      sb.append("select ");
      if ("checked".equals(bo.getCount()))
        sb.append("count(").append(scaleTable).append(".").append(pk).append(") as count ,");
      if ("checked".equals(bo.getMax())) {
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sb.append("max(").append(bo.getStaticItemId()).append("+0) as max,");
        }
        else {
          sb.append("max(cast(").append(bo.getStaticItemId()).append(" as float)) as max,");
        }
      }
      if ("checked".equals(bo.getSum())) {
        if ("ORACLE".equals(Constants.DB_TYPE)) {
          sb.append("sum(").append(bo.getStaticItemId()).append("+0) as sum,");
        }
        else
          sb.append("sum(cast(").append(bo.getStaticItemId()).append(" as float)) as sum,");
      }
      if ("checked".equals(bo.getMin()))
        sb.append("min(").append(bo.getStaticItemId()).append("+0) as min,");
      if ("checked".equals(bo.getAvg()))
        sb.append("round(avg(").append(bo.getStaticItemId()).append("+0),2) as avg,");
      sb.delete(sb.length() - 1, sb.length());

      return sb; } catch (Exception e) {
    	  throw new SysException("组合sql语句错误", "拼装查询部分错误", e, getClass());
    }
  }

  public Hashtable buildQuerySql(User user, QueryItemBO[] bos, StaticVO staticvo, QueryBO bo) throws SysException
  {
    try
    {
      Hashtable ht = new Hashtable();
      String scaleField = getScaleField(bo.getSetType(), bo.getUnitType());
      String scaleTable = getScaleTable(bo.getSetType(), bo.getUnitType());
      String pk = getSetPk(bo.getSetType());
      StringBuffer scaleCondition = new StringBuffer();

      String scale = "";

      if (user != null) {
        UserAPI api = (UserAPI)SysContext.getBean("user_pmsAPI");
        boolean flag = false;
        if ("PARTY".equals(bo.getUnitType()))
          flag = true;
        boolean isOper = false;
        if ("2".equals(bo.getOperFlag()))
          isOper = true;
        scale = api.getScaleConditionByType(user, scaleField, getCardeField(bo.getSetType(), bo.getUnitType()), getPerTypeField(bo.getSetType(), bo.getUnitType()), bo.getSetType(), isOper, flag);
      }

      if (!"".equals(CommonFuns.filterNull(bo.getOrgIds()))) {
        String[] oIds = bo.getOrgIds().split(",");
        scaleCondition.append(" (");
        for (int i = 0; i < oIds.length; i++)
        {
          String treeId;
          if ("ORG".equals(bo.getUnitType())) {
            OrgBO o = SysCacheTool.findOrgById(oIds[i]);
            treeId = ((OrgBO)CommonFuns.filterNull(OrgBO.class, o)).getTreeId();
          } else {
            PartyBO p = SysCacheTool.findParty(oIds[i]);
            treeId = ((PartyBO)CommonFuns.filterNull(PartyBO.class, p)).getTreeId();
          }
          scaleCondition.append(scaleField).append(" like '").append(treeId).append("%' or ");
        }
        if (oIds.length > 0) {
          scaleCondition.delete(scaleCondition.length() - 3, scaleCondition.length());
          scaleCondition.append(") ");
        } else {
          scaleCondition.delete(0, scaleCondition.length());
        }

      }

      if ((CommonFuns.filterNull(scale).length() > 0) && (scaleCondition.length() > 0))
        scaleCondition.insert(0, scale + " and ");
      else
        scaleCondition.insert(0, scale);
      ht.put("SQL_SCALE_PART", scaleCondition.toString());

      String showitem = "";
      for (int i = 0; i < bos.length; i++) {
        if (!"1".equals(bos[i].getHide())) {
          if ("".equals(showitem)) {
            showitem = bos[i].getItemId();
          }
          else
            showitem = showitem + "," + bos[i].getItemId();
        }
      }
      String[] ids = showitem.split(",");
      StringBuffer select = parseSelect(ids);
      select.insert(0, scaleTable + "." + pk + ", ");

      if (ht != null) {
        ht.put("SQL_SELECT_PART", select.toString());
      }
      select.insert(0, "select ");

      String condition = null;
      String from = null;
      StringBuffer conditionPart = new StringBuffer();

      Criteria c = new Criteria();
      if (staticvo.getStatics() != null) {
        c.init(staticvo.getStatics().getGroup(), bo.getSetType(), "");
        if (staticvo.getCondi() != null) {
          for (int i = 0; i < staticvo.getCondi().length; i++) {
            QueryConditionBO b = staticvo.getCondi()[i];
            Method m = Criteria.class.getMethod(b.getOperator(), new Class[] { String.class, String.class, String.class, String.class });
            m.invoke(c, new Object[] { b.getGroupId(), b.getItemId(), b.getText(), b.getValue() });
          }
        }
        String condi = CommonFuns.filterNull(c.getCondition()).trim();

        conditionPart.append(condi);
        if ((bo.getAddedCondition() != null) && (!"".equals(bo.getAddedCondition()))) {
          if (conditionPart.length() > 0)
            conditionPart.append(" and (").append(bo.getAddedCondition()).append(") ");
          else
            conditionPart.append(" (").append(bo.getAddedCondition()).append(") ");
        }
        condition = c.addDefaultCondition(conditionPart.toString());
        conditionPart = new StringBuffer(condition);

        from = c.getJoinTable(ids, scaleTable, bo.getHistorySet());
      } else if ((bo.getAddedCondition() != null) && (!"".equals(bo.getAddedCondition()))) {
        conditionPart = new StringBuffer(bo.getAddedCondition());
      }

      StringBuffer order = parseOrder(bos);
      if ((order == null) || (order.length() == 0)) {
        order.append(getDefaultOrder(bo.getSetType()));
      }
      if (order.indexOf("A001701") >= 0) {
        from = from + " left join B001 bbbb1 on A001.A001701=bbbb1.orguid";
        String tmp = order.toString();
        order.delete(0, order.length());
        order.append(tmp.replaceAll("A001701", "bbbb1.B001715"));
      }
      if (order.indexOf("A001705") >= 0) {
        from = from + " left join B001 bbbb2 on A001.A001705=bbbb2.orguid";
        String tmp = order.toString();
        order.delete(0, order.length());
        order.append(tmp.replaceAll("A001705", "bbbb2.B001715"));
      }

      if (ht != null) {
        ht.put("SQL_WHERE_PART", CommonFuns.filterNull(condition));
        ht.put("SQL_FROM_PART", CommonFuns.filterNull(from));
      }

      select.append(" from ").append(from);

      if ((scaleCondition.length() > 0) && (conditionPart.toString().trim().length() > 0))
        conditionPart.append(" and (").append(scaleCondition).append(") ");
      else {
        conditionPart.append(scaleCondition);
      }

      if (conditionPart.length() > 0) {
        select.append(" where ").append(conditionPart);
      }

      select.append(" order by ").append(order);
      if (ht != null)
        ht.put("SQL_ORDER_PART", order.toString());
      ht.put("SQL_FULL", select.toString());
      CommonFuns.DebugLog(select.toString());
      return ht;
    } catch (SysException ex) {
      throw ex; } catch (Exception e) {
    	  throw new RollbackableException("无法生成sql", "", e, getClass());
    }
  }

  private String getDefaultOrder(String setType)
  {
    if ("A".equals(setType))
      return "A001.A001003";
    if ("B".equals(setType))
      return "B001.B001715";
    if ("C".equals(setType))
      return "C001.C001002";
    if ("D".equals(setType))
      return "D001.D001715";
    return "";
  }

  public String[] buildStaticSql(User user, StaticVO[] staticvos, QueryBO bo) throws SysException
  {
    try {
      String scaleField = getScaleField(bo.getSetType(), bo.getUnitType());
      String scaleTable = getScaleTable(bo.getSetType(), bo.getUnitType());

      StringBuffer scaleCondition = new StringBuffer();
      String[] staticSql = new String[staticvos.length];

      String scale = "";
      if (user != null) {
        UserAPI api = (UserAPI)SysContext.getBean("user_pmsAPI");
        boolean flag = false;
        if ("PARTY".equals(bo.getUnitType()))
          flag = true;
        scale = api.getScaleConditionByType(user, scaleField, getCardeField(bo.getSetType(), bo.getUnitType()), getPerTypeField(bo.getSetType(), bo.getUnitType()), bo.getSetType(), false, flag);
      }

      if (!"".equals(CommonFuns.filterNull(bo.getOrgIds()))) {
        scaleCondition.append(" (");
        String[] oIds = bo.getOrgIds().split(",");
        for (int i = 0; i < oIds.length; i++)
        {
          String treeId;
          if ("ORG".equals(bo.getUnitType())) {
            OrgBO o = SysCacheTool.findOrgById(oIds[i]);
            treeId = ((OrgBO)CommonFuns.filterNull(OrgBO.class, o)).getTreeId();
          } else {
            PartyBO p = SysCacheTool.findParty(oIds[i]);
            treeId = ((PartyBO)CommonFuns.filterNull(PartyBO.class, p)).getTreeId();
          }
          scaleCondition.append(scaleField).append(" like '").append(treeId).append("%' or ");
        }
        if (oIds.length > 0) {
          scaleCondition.delete(scaleCondition.length() - 3, scaleCondition.length());
          scaleCondition.append(") ");
        } else {
          scaleCondition.delete(0, scaleCondition.length());
        }
      }

      if ((CommonFuns.filterNull(scale).length() > 0) && (scaleCondition.length() > 0))
        scaleCondition.insert(0, scale + " and ");
      else {
        scaleCondition.insert(0, scale);
      }

      StringBuffer select = parseStaticSelect(bo);

      String condition = null;
      String from = null;

      StaticCriteria criteria = new StaticCriteria();
      for (int pos = 0; pos < staticvos.length; pos++) {
        StaticVO staticvo = staticvos[pos];
        if (staticvo.getStatics() != null)
        {
          if (pos == 0)
            criteria.newBaseStatic();
          if (pos == 1)
            criteria.endBaseStatic();
          if (pos > 0) {
            criteria.newSubStatic();
          }
          criteria.init(staticvo.getStatics().getGroup(), bo.getSetType(), "");

          if (staticvo.getCondi() != null) {
            for (int i = 0; i < staticvo.getCondi().length; i++) {
              QueryConditionBO b = staticvo.getCondi()[i];
              Method m = StaticCriteria.class.getMethod(b.getOperator(), new Class[] { String.class, String.class, String.class, String.class });
              m.invoke(criteria, new Object[] { b.getGroupId(), b.getItemId(), b.getText(), b.getValue() });
            }
          }
          condition = criteria.addDefaultCondition(criteria.getCondition());
          from = criteria.getJoinTable(new String[] { bo.getStaticItemId() }, scaleTable);
        }

        StringBuffer bufferedStaticSql = new StringBuffer();
        bufferedStaticSql.append(select).append(" from ").append(from);

        StringBuffer conditionPart = new StringBuffer();

        if (scaleCondition.length() > 0) {
          conditionPart.append(" (").append(scaleCondition).append(") ");
        }

        if ((condition != null) && (!"".equals(condition))) {
          if ((conditionPart.length() > 0) && (!condition.trim().startsWith("group by")))
            conditionPart.append(" and ").append(condition);
          else {
            conditionPart.append(" ").append(condition);
          }
        }

        if ((conditionPart.length() > 0) && (!conditionPart.toString().trim().startsWith("group by")))
          bufferedStaticSql.append(" where ").append(conditionPart);
        else {
          bufferedStaticSql.append(" ").append(conditionPart);
        }
        if (bufferedStaticSql.indexOf("group by") != -1) {
          String sql = bufferedStaticSql.toString().trim();
          String groupField = sql.substring(sql.length() - 7, sql.length());
          bufferedStaticSql.insert(6, " " + groupField + " as allvalue,");
        }

        CommonFuns.DebugLog(bufferedStaticSql.toString());
        staticSql[pos] = bufferedStaticSql.toString();
      }
      return staticSql; } catch (Exception e) {
    	  throw new RollbackableException("无法执行统计", "", e, getClass());
    }
  }

  public String getSetPk(String setType)
  {
    if ("A".equals(setType))
      return "ID";
    if ("B".equals(setType))
      return "ORGUID";
    if ("C".equals(setType))
      return "POSTID";
    if ("D".equals(setType)) {
      return "PARTYID";
    }
    return "ID";
  }

  public String getScaleTable(String setType, String unitType) {
    if (("A".equals(setType)) && ("ORG".equals(unitType)))
      return "A001";
    if (("A".equals(setType)) && ("PARTY".equals(unitType)))
      return "A001";
    if (("A".equals(setType)) && ("WAGE".equals(unitType)))
      return "A815";
    if ("B".equals(setType))
      return "B001";
    if ("C".equals(setType))
      return "C001";
    if ("D".equals(setType)) {
      return "D001";
    }
    return "A001";
  }

  public String getScaleField(String setType, String unitType) {
    if (("A".equals(setType)) && ("ORG".equals(unitType)))
      return "A001738";
    if (("A".equals(setType)) && ("PARTY".equals(unitType)))
      return "A001740";
    if (("A".equals(setType)) && ("WAGE".equals(unitType)))
      return "A815700";
    if ("B".equals(setType))
      return "B001003";
    if ("C".equals(setType))
      return "C001701";
    if ("D".equals(setType)) {
      return "D001003";
    }
    return "A001738";
  }

  public String getCardeField(String setType, String unitType) {
    return null;
  }

  public String getPerTypeField(String setType, String unitType) {
    if (("A".equals(setType)) && ("ORG".equals(unitType))) {
      return "A001054";
    }
    return null;
  }
}