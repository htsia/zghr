package com.hr319wg.post.ucc.impl;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.pojo.vo.PostVO;
import com.hr319wg.post.service.PostService;
import com.hr319wg.post.ucc.IPostUCC;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.SysAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.RecordVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.service.ActivePageService;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

public class PostUCC2
extends PostUCC
{
	 private PostService postservice;
	  private ActivePageService activepageservice;
	  private QueryAPI queryapi;
	  private SysAPI sysapi;
	public String queryPostList(TableVO table, String postName, String superId, int pageNum, int rowNum, String cancel, User user, String qid) throws SysException {
		StringBuffer where = new StringBuffer();
		if ((postName != null) && (!("".equals(postName)))) {
			where.append(" and C001.C001005 LIKE '%").append(postName).append("%'");
		}

		if ((superId != null) && (!("".equals(superId))))
			if ("SQL SERVER".equals(Constants.DB_TYPE)) {
				where.append(" and C001.C001701 like dbo.getOrgTree('").append(superId).append("')+'%'");
			}
			else
				where.append(" and C001.C001701 like getOrgTree('").append(superId).append("')||'%'");


		if ((cancel != null) && (!("".equals(cancel)))) {
			where.append(" and C001.C001730 = '").append(cancel).append("'");
		}

		CellVO[] c1 = this.queryapi.queryInfoItem(qid);
		table.setHeader(c1);
		table.setSetType("C");
		Hashtable hash = this.queryapi.getQuerySqlHash(user, qid);
		String select = CommonFuns.filterNull((String)hash.get("SQL_SELECT_PART"));
		String from = CommonFuns.filterNull((String)hash.get("SQL_FROM_PART"));
		String condition = CommonFuns.filterNull((String)hash.get("SQL_WHERE_PART"));
		String scale = CommonFuns.filterNull((String)hash.get("SQL_SCALE_PART"));
		String order = CommonFuns.filterNull((String)hash.get("SQL_ORDER_PART"));
		StringBuffer sql = new StringBuffer();
		if ((!("".equals(select))) && (!("".equals(from)))) {
			sql.append("SELECT ").append(select).append(" FROM ").append(from);
			if ((!("".equals(condition))) || (!("".equals(scale))) || ((where != null) && (where.length() > 0)))
				sql.append(" WHERE 1=1 ");

			if (!("".equals(condition)))
				sql.append(" and ").append(condition);

			if (!("".equals(scale)))
				sql.append(" and ").append(scale);

			if ((where != null) && (where.length() > 0))
				sql.append(where);
//崔海亮，修改oracle 11.2 下的报错问题
//			if (!("".equals(order)))
//				sql.append(" order by ").append(order);
//			else
//				sql.append(" order by ").append("C001.C001002");

		}

		this.activepageservice.querySql(table, sql.toString(), user, pageNum, rowNum, true);
		return sql.toString();
	}
	public PostService getPostservice() {
		return postservice;
	}
	public void setPostservice(PostService postservice) {
		this.postservice = postservice;
	}
	public ActivePageService getActivepageservice() {
		return activepageservice;
	}
	public void setActivepageservice(ActivePageService activepageservice) {
		this.activepageservice = activepageservice;
	}
	public QueryAPI getQueryapi() {
		return queryapi;
	}
	public void setQueryapi(QueryAPI queryapi) {
		this.queryapi = queryapi;
	}
	public SysAPI getSysapi() {
		return sysapi;
	}
	public void setSysapi(SysAPI sysapi) {
		this.sysapi = sysapi;
	}

	
}