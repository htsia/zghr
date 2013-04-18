package com.hr319wg.custom.extend.ucc;

import java.util.Hashtable;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.post.ucc.impl.PostUCC;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PostUCCByExtend extends PostUCC{

	public String queryPostList(TableVO table, String postName, String superId, int pageNum, int rowNum, String cancel, User user, String qid) throws SysException {
	    StringBuffer where = new StringBuffer();
	    if ((postName != null) && (!"".equals(postName))) {
	      where.append(" and C001.C001005 LIKE '%").append(postName).append("%'");
	    }

	    if ((superId != null) && (!"".equals(superId))) {
	      if ("SQL SERVER".equals(Constants.DB_TYPE)) {
	        where.append(" and C001.C001701 like dbo.getOrgTree('").append(superId).append("')+'%'");
	      }
	      else {
	        where.append(" and C001.C001701 like getOrgTree('").append(superId).append("')||'%'");
	      }
	    }
	    if ((cancel != null) && (!"".equals(cancel))) {
	      where.append(" and C001.C001730 = '").append(cancel).append("'");
	    }

	    CellVO[] c1 = this.getQueryapi().queryInfoItem(qid);
	    table.setHeader(c1);
	    table.setSetType("C");
	    Hashtable hash = this.getQueryapi().getQuerySqlHash(user, qid);
	    String select = CommonFuns.filterNull((String)hash.get("SQL_SELECT_PART"));
	    String from = CommonFuns.filterNull((String)hash.get("SQL_FROM_PART"));
	    String condition = CommonFuns.filterNull((String)hash.get("SQL_WHERE_PART"));
	    String scale = CommonFuns.filterNull((String)hash.get("SQL_SCALE_PART"));
	    String order = CommonFuns.filterNull((String)hash.get("SQL_ORDER_PART"));
	    StringBuffer sql = new StringBuffer();
	    if ((!"".equals(select)) && (!"".equals(from))) {
	      sql.append("SELECT ").append(select).append(" FROM B001,").append(from);
	      if ((!"".equals(condition)) || (!"".equals(scale)) || ((where != null) && (where.length() > 0))) {
	        sql.append(" WHERE C001.C001010=B001.ORGUID ");
	      }
	      if (!"".equals(condition)) {
	        sql.append(" and ").append(condition);
	      }
	      if (!"".equals(scale)) {
	        sql.append(" and ").append(scale);
	      }
	      if ((where != null) && (where.length() > 0)) {
	        sql.append(where);
	      }
	      if (!"".equals(order))
	        sql.append(" order by B001.B001715,").append(order);
	      else {
	        sql.append(" order by ").append("B001.B001715,C001.C001002");
	      }
	    }

	    this.getActivepageservice().querySql(table, sql.toString(), user, pageNum, rowNum, true);
	    return sql.toString();
	  }
}
