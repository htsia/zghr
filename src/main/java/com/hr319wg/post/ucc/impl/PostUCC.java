package com.hr319wg.post.ucc.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

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

public class PostUCC implements IPostUCC {
	private PostService postservice;
	private ActivePageService activepageservice;
	private QueryAPI queryapi;
	private SysAPI sysapi;

	public PostService getPostservice() {
		return this.postservice;
	}

	public void setPostservice(PostService postservice) {
		this.postservice = postservice;
	}

	public ActivePageService getActivepageservice() {
		return this.activepageservice;
	}

	public void setActivepageservice(ActivePageService activepageservice) {
		this.activepageservice = activepageservice;
	}

	public QueryAPI getQueryapi() {
		return this.queryapi;
	}

	public SysAPI getSysapi() {
		return this.sysapi;
	}

	public void setSysapi(SysAPI sysapi) {
		this.sysapi = sysapi;
	}

	public void setQueryapi(QueryAPI queryapi) {
		this.queryapi = queryapi;
	}

	public PostBO[] queryPost(String sql) throws SysException {
		try {
			return this.postservice.queryPost(sql);
		} catch (Exception e) {
			throw new SysException("", "≤È—Ø ß∞‹", e, PostUCC.class);
		}
	}

	public TableVO findNewPage(String setId) throws SysException {
		try {
			return this.activepageservice.findNewPageInfo(setId, null);
		} catch (Exception e) {
			throw new SysException("", "≤È—Ø ß∞‹", e, PostUCC.class);
		}
	}

	public TableVO queryPage(String setId, String fkValue) throws SysException {
		try {
			return this.activepageservice.queryPageInfo(setId, null, fkValue);
		} catch (Exception e) {
			throw new SysException("", "≤È—Ø ß∞‹", e, PostUCC.class);
		}
	}

	public String addPageInfo(String setId, String pkValue, String fkValue, String infoItem, String itemValue) throws SysException {
		try {
			return this.activepageservice.addPageInfo(setId, null, pkValue, fkValue, false, infoItem, itemValue);
		} catch (Exception e) {
			throw new SysException("", "≤È—Ø ß∞‹", e, PostUCC.class);
		}
	}

	public void updatePageInfo(String setId, String pkValue, String fkValue, String infoItem, String itemValue) throws SysException {
		try {
			this.activepageservice.updatePageInfo(setId, null, pkValue, fkValue, false, null, null, infoItem, itemValue);
		} catch (Exception e) {
			throw new SysException("", "≤È—Ø ß∞‹", e, PostUCC.class);
		}
	}

	public PostBO[] queryPost(String postType, String template) throws SysException {
		try {
			return this.postservice.queryPost(postType, template);
		} catch (Exception e) {
			throw new SysException("", "≤È—Ø ß∞‹", e, PostUCC.class);
		}
	}

	public String createPost(PostVO postvo, String tempId, User user) throws SysException {
		try {
			if (postvo == null) {
				return null;
			}
			String treeId = "";
			OrgBO org = SysCacheTool.findOrgById(postvo.getOrgId());
			if (org != null) {
				treeId = org.getTreeId();
			}

			String[] infoItems = { "C001001", "C001005", "C001010", "C001015", "C001020", "C001030", "C001035", "C001701", "C001730", "C001003", "C001735", "C001025" };
			String[] itemValues = { CommonFuns.filterNull(postvo.getPostClass()), CommonFuns.filterNull(postvo.getName()), CommonFuns.filterNull(postvo.getOrgId()), CommonFuns.filterNull(postvo.getSuperId()), CommonFuns.filterNull(postvo.getPostLevel()), CommonFuns.filterNull(postvo.getUpdateDate()), CommonFuns.filterNull(postvo.getPostOrder()), CommonFuns.filterNull(treeId), CommonFuns.filterNull(postvo.getPostTemp()), CommonFuns.filterNull(postvo.getPostCode()), CommonFuns.filterNull(postvo.getWorkOut()), CommonFuns.filterNull(postvo.getPostType()) };

			String postId = this.activepageservice.addPageInfo("C001", user, null, null, false, infoItems, itemValues);

			InfoSetBO[] setList = this.sysapi.queryCascadeInfoSet("C001");
			if (setList != null) {
				int count = setList.length;
				for (int i = 0; i < count; i++) {
					if (!InfoSetBO.RS_TYPE_MANY.equalsIgnoreCase(setList[i].getSet_rsType())) {
						TableVO tmp = this.activepageservice.findNewPageInfo(setList[i].getSetId(), user);
						Hashtable tmphash = tmp.getRowData()[0].cellArray2Hash();
						((CellVO) tmphash.get(setList[i].getSetPk())).setValue(postId);
						this.activepageservice.addPageInfo(tmp, user, "");
					}
				}

				if ((tempId != null) && (!"".equals(tempId))) {
					List listSql = new ArrayList();
					for (int j = 0; j < count; j++) {
						if (InfoSetBO.RS_TYPE_MANY.equalsIgnoreCase(setList[j].getSet_rsType())) {
							TableVO tmp = this.activepageservice.queryPageInfo(setList[j].getSetId(), null, tempId, user);
							RecordVO[] r = tmp.getRowData();
							if ((r != null) && (r.length > 0)) {
								String[] subid = SequenceGenerator.getKeyId(setList[j].getSetId(), r.length);
								for (int n = 0; n < r.length; n++) {
									String sql = PostTool.getAddSql(setList[j].getSetId(), r[n].getCell(), postId, subid[n]);
									if ((sql != null) && (!"".equals(sql)))
										listSql.add(sql);
								}
							}
						} else {
							TableVO tmp = this.activepageservice.queryPageInfo(setList[j].getSetId(), tempId, null, user);
							RecordVO[] r = tmp.getRowData();
							if ((r != null) && (r.length > 0)) {
								String sql = PostTool.getUpdateSql(setList[j].getSetId(), r[0].getCell(), postId);
								listSql.add(sql);
							}
						}
					}
					if ((listSql != null) && (listSql.size() > 0)) {
						this.activepageservice.batchExecuteSql((String[]) (String[]) listSql.toArray(new String[0]));
					}
				}
			}
			return postId;
		} catch (Exception e) {
			throw new RollbackableException("", "‘ˆº”∏⁄Œª ß∞‹", e, getClass());
		}
	}

	public void querySql(TableVO table, String sql, User user, int pageNum, int rowNum) throws SysException {
		this.activepageservice.querySql(table, sql, user, pageNum, rowNum, true);
	}

	public String queryPostList(TableVO table, String postName, String superId, int pageNum, int rowNum, String cancel, User user) throws SysException {
		return queryPostList(table, postName, superId, pageNum, rowNum, cancel, user, Constants.DEFAULT_QUERY_POST);
	}

	public String queryPostList(TableVO table, String postName, String superId, int pageNum, int rowNum, String cancel, User user, String qid) throws SysException {
		StringBuffer where = new StringBuffer();
		if ((postName != null) && (!"".equals(postName))) {
			where.append(" and C001.C001005 LIKE '%").append(postName).append("%'");
		}

		if ((superId != null) && (!"".equals(superId))) {
			if ("SQL SERVER".equals(Constants.DB_TYPE)) {
				where.append(" and C001.C001701 like dbo.getOrgTree('").append(superId).append("')+'%'");
			} else {
				where.append(" and C001.C001701 like getOrgTree('").append(superId).append("')||'%'");
			}
		}
		if ((cancel != null) && (!"".equals(cancel))) {
			where.append(" and C001.C001730 = '").append(cancel).append("'");
		}

		CellVO[] c1 = this.queryapi.queryInfoItem(qid);
		table.setHeader(c1);
		table.setSetType("C");
		Hashtable hash = this.queryapi.getQuerySqlHash(user, qid);
		String select = CommonFuns.filterNull((String) hash.get("SQL_SELECT_PART"));
		String from = CommonFuns.filterNull((String) hash.get("SQL_FROM_PART"));
		String condition = CommonFuns.filterNull((String) hash.get("SQL_WHERE_PART"));
		String scale = CommonFuns.filterNull((String) hash.get("SQL_SCALE_PART"));
		String order = CommonFuns.filterNull((String) hash.get("SQL_ORDER_PART"));
		StringBuffer sql = new StringBuffer();
		if ((!"".equals(select)) && (!"".equals(from))) {
			sql.append("SELECT ").append(select).append(" FROM ").append(from);
			if ((!"".equals(condition)) || (!"".equals(scale)) || ((where != null) && (where.length() > 0))) {
				sql.append(" WHERE 1=1 ");
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
				sql.append(" order by ").append(order);
			else {
				sql.append(" order by ").append("C001.C001002");
			}
		}

		this.activepageservice.querySql(table, sql.toString(), user, pageNum, rowNum, true);
		return sql.toString();
	}

	public void deletePost(String[] ids, User user) throws SysException {
		if (ids != null) {
			List list = new ArrayList();
			for (int i = 0; i < ids.length; i++) {
				list.add("UPDATE A001 SET A001715 = '' WHERE A001715 ='" + ids[i] + "'");
			}
			if ((list != null) && (list.size() > 0)) {
				this.activepageservice.batchExecuteSql((String[]) (String[]) list.toArray(new String[0]));
			}
		}

		TableVO table = this.activepageservice.findNewPageInfo("C001", null);
		this.activepageservice.removePageInfo(table, ids, user);
	}

	public int queryPersonByPost(String id) throws SysException {
		return this.postservice.queryPersonByPost(id);
	}

	public TableVO queryPageInfo(String setId, String pkValue, String fkValue, User user, String where, String sort) throws SysException {
		try {
			return this.activepageservice.queryPageInfo(setId, pkValue, fkValue, user, where, sort);
		} catch (Exception e) {
			throw new SysException("", "≤È—Ø ß∞‹", e, PostUCC.class);
		}
	}

	public int queryPerNumPost(String postId) throws SysException {
		return this.postservice.queryPerNumPost(postId);
	}

	public String[] queryLowPost(String postId) throws SysException {
		return this.postservice.queryLowPost(postId);
	}

	public int queryPerNumLowPost(String sql1) throws SysException {
		return this.postservice.queryPerNumLowPost(sql1);
	}

	public String[] queryPersonNameByPost(String postId) throws SysException {
		return this.postservice.queryPersonNameByPost(postId);
	}

	public List queryPersonBOByPost(String postId) throws SysException {
		return this.postservice.queryPersonBOByPost(postId);
	}

	public int queryLowPostNumPost(String postId) throws SysException {
		return this.postservice.queryLowPostNumPost(postId);
	}

	public String buildPostCode(String code) throws SysException {
		if ((code == null) || ("".equals(code))) {
			return "";
		}
		String postCode = "";
		try {
			String tmpCode = this.activepageservice.queryForString("select max(C001003) FROM C001 where c001003 like '" + code + "%'");
			if (tmpCode!=null && !"".equals(tmpCode)){
				tmpCode=tmpCode.replace(code, "").replaceAll("0", "");
				DecimalFormat df = new DecimalFormat("00000");
				postCode=code+ df.format(Integer.valueOf(tmpCode)+1);
			}else{
				postCode = code + "00001";
			}
		} catch (Exception e) {
			postCode = code + "00001";
		}
		return postCode;
	}

	public int queryDirePersonNum(String postId) throws SysException {
		if ((postId != null) && (!"".equals(postId))) {
			String sql = "select count(ID) FROM A001 WHERE A001715 in (SELECT POSTID FROM C001 WHERE C001015 ='" + postId + "' and C001730='00900') AND A001730 = '00900'  AND A001753='00900'";
			return this.activepageservice.queryForInt(sql);
		}
		return 0;
	}

	public int queryInDirePersonNum(String postId) throws SysException {
		if ((postId != null) && (!"".equals(postId))) {
			String sql = "select count(A001.ID) from A001 inner join C001 a on A001.A001715=a.POSTID inner join C001 b on a.C001015=b.POSTID  where b.C001015='" + postId + "' and b.C001730='00900' and a.C001730='00900' and A001730 = '00900' AND A001753='00900'";

			return this.activepageservice.queryForInt(sql);
		}
		return 0;
	}

	public void setCurrent(String setId, String pk) throws SysException {
		this.postservice.setCurrent(setId, pk);
	}

	public List generateMap(String orguid) throws SysException {
		return this.postservice.generateMap(orguid);
	}

	public void CalcWeave(String superId) throws SysException {
		this.postservice.CalcWeave(superId);
	}

	public void CalcWeaveByPost(String postID) throws SysException {
		this.postservice.CalcWeave(postID);
	}

	public String[] queryInferior(String pid) throws SysException {
		return this.postservice.queryInferior(pid);
	}

	public void changePostSuper(String ids, String orgid) throws SysException {
		if ((ids != null) && (!"".equals(ids)) && (orgid != null) && (!"".equals(orgid))) {
			OrgBO oo = SysCacheTool.findOrgById(orgid);
			if (oo != null) {
				String sql = "update C001 set C001010='" + oo.getOrgId() + "',C001701='" + oo.getTreeId() + "' where postid in ('" + ids.replaceAll(",", "','") + "')";
				this.activepageservice.executeSql(sql);
				SysCache.setMap(ids.split(","), 2, 7);

				while (OrgBO.GROUPTYPE.equals(oo.getorgType())) {
					oo = SysCacheTool.findOrgById(oo.getSuperId());
				}
				sql = "update a001 set A001705='" + oo.getOrgId() + "',A001738='" + oo.getTreeId() + "' where A001715 in ('" + ids.replaceAll(",", "','") + "')";
				this.activepageservice.executeSql(sql);
			}
		}
	}
}