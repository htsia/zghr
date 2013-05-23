package com.hr319wg.custom.common.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.myfaces.custom.fileupload.UploadedFile;
import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.custom.dao.CommonDAO;
import com.hr319wg.custom.emp.pojo.bo.EmpQueryItemBO;
import com.hr319wg.custom.pojo.bo.SetFileBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.pojo.bo.QueryBO;
import com.hr319wg.qry.pojo.bo.QueryItemBO;
import com.hr319wg.qry.pojo.vo.QueryVO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.qry.util.QueryUtil;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;
import com.hr319wg.util.SequenceGenerator;

public class CommonServiceImpl implements ICommonService {

	private CommonDAO commonDAO;
	private JdbcTemplate jdbcTemplate;
	private ActivePageAPI pageAPI;
	private QueryAPI queryAPI;

	public QueryAPI getQueryAPI() {
		return queryAPI;
	}

	public void setQueryAPI(QueryAPI queryAPI) {
		this.queryAPI = queryAPI;
	}

	public CommonDAO getCommonDAO() {
		return commonDAO;
	}

	public void setCommonDAO(CommonDAO commonDAO) {
		this.commonDAO = commonDAO;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public ActivePageAPI getPageAPI() {
		return pageAPI;
	}

	public void setPageAPI(ActivePageAPI pageAPI) {
		this.pageAPI = pageAPI;
	}

	/**
	 * mode 0更新 1新增
	 */
	public void batchUpdateEmpUploadFile(String setID, String mode, String[] fields, List<Map> list) throws SysException {
		InfoSetBO set = SysCacheTool.findInfoSet(setID);
		for (Map map : list) {
			// 单记录子集
			if (set.getSet_rsType().equals(InfoSetBO.RS_TYPE_SINGLE)) {
				String sql = "update " + setID + " set ";
				for (int i = 0; i < fields.length; i++) {
					sql += fields[i] + "='" + (map.get(fields[i]) == null ? "" : map.get(fields[i])) + "',";
				}
				sql = sql.substring(0, sql.length() - 1);
				sql += " where id='" + map.get("id") + "'";
				this.jdbcTemplate.execute(sql.toString());
			} else {
				boolean insert = false;
				// 更新
				if ("0".equals(mode)) {
					// 存在当前记录
					String sql = "select subid from " + setID + " where " + setID + "000 ='00901' and id='" + map.get("id") + "'";
					String subid = this.pageAPI.queryForString(sql.toString());
					if (subid != null) {
						sql = "update " + setID + " set ";
						for (int i = 0; i < fields.length; i++) {
							sql += fields[i] + "='" + (map.get(fields[i]) == null ? "" : map.get(fields[i])) + "',";
						}
						sql = sql.substring(0, sql.length() - 1);
						sql += " where subid='" + subid + "'";
						this.jdbcTemplate.execute(sql.toString());
					} else {
						insert = true;
					}
				} else if ("1".equals(mode) || insert) {
					String sql = "update " + setID + " set " + setID + "000 ='00900' where id='" + map.get("id") + "'";
					this.jdbcTemplate.execute(sql);
					sql = "insert into " + setID + "(subid,id," + setID + "000";
					for (int i = 0; i < fields.length; i++) {
						sql += "," + fields[i];
					}
					sql += ") values ('" + SequenceGenerator.getKeyId(setID) + "','" + map.get("id") + "','00901'";
					for (int i = 0; i < fields.length; i++) {
						sql += ",'" + (map.get(fields[i]) == null ? "" : map.get(fields[i])) + "'";
					}
					sql += ")";
					this.jdbcTemplate.execute(sql);
				}
			}
		}
	}

	public String getChangeInfo(TableVO table, List showItems, String unitId, String filter) {
		String fields = "ws.set_id||'-'||A001.ID||'-'||B730.subid AS ID,A001735,A001705";
		CellVO[] cvs = new CellVO[showItems.size() + 4];
		cvs[0] = new CellVO();
		CommonFuns.copyProperties(cvs[0], SysCacheTool.findInfoItem("A001", "ID"));
		cvs[1] = new CellVO();
		CommonFuns.copyProperties(cvs[1], SysCacheTool.findInfoItem("A001", "A001735"));
		cvs[2] = new CellVO();
		CommonFuns.copyProperties(cvs[2], SysCacheTool.findInfoItem("A001", "A001705"));
		for (int i = 0; i < showItems.size(); i++) {
			InfoItemBO ib = (InfoItemBO) showItems.get(i);
			cvs[(i + 3)] = new CellVO();
			CommonFuns.copyProperties(cvs[(i + 3)], ib);
			if (fields.equals("")) {
				fields = ib.getSetId() + "." + ib.getItemId();
			} else {
				fields = fields + "," + ib.getSetId() + "." + ib.getItemId();
			}
		}
		cvs[(showItems.size() + 3)] = new CellVO();
		cvs[(showItems.size() + 3)].setItemId("set_name");
		cvs[(showItems.size() + 3)].setItemName("薪资账套");
		fields = fields + ",set_name";
		table.setHeader(cvs);
		String sql = "select " + fields + " from B730 left join A001 on B730.B730700=A001.ID left join wage_set_pers_r w on A001.id=w.id left join wage_set ws on w.A815700=ws.set_id where isnull(no_use,0)<>'1' and orguid='" + unitId + "' and " + filter + " order by B730701 desc";
		return sql;
	}

	public void updateInfoItem(InfoItemBO item) throws SysException {
		this.commonDAO.saveOrUpdateBo(item);
		if ("A815".equals(item.getSetId())) {
			String sql = "select name from sysobjects where xtype='U' and name like 'A815_SET_%'";
			List list = this.jdbcTemplate.queryForList(sql);
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					Map m = (Map) list.get(i);
					sql = "alter table " + m.get("name") + " modify " + item.getItemId() + " varchar2(" + item.getItemDataLength() + ")";
					this.jdbcTemplate.execute(sql);
				}
			}
			sql = "alter table wage_set_pers_r modify " + item.getItemId() + " varchar2(" + item.getItemDataLength() + ")";
			this.jdbcTemplate.execute(sql);
			sql = "alter table wage_set_pers_r_bak modify " + item.getItemId() + " varchar2(" + item.getItemDataLength() + ")";
			this.jdbcTemplate.execute(sql);
		}
	}

	public List getRptList(String userID) throws SysException {
		return this.commonDAO.getRptList(userID);
	}

	public List getWageMinusList(String setID) throws SysException {
		List list = null;
		String sql = "select s.para_value from sys_parameter s where s.para_key='WAGE_FIELD_SHIFA'";
		String field = this.pageAPI.queryForString(sql);
		if (field != null && !"".equals(field)) {
			sql = "select a.a001735 pCode,a001001 name,b.b001005 deptName," + field + " wage from a001 a,b001 b,a815_set_" + setID + " s where a.a001705=b.orguid and a.id=s.id and " + field + "<=0 order by b.b001003,a.a001001";
			list = this.jdbcTemplate.queryForList(sql);
			if (list == null) {
				list = new ArrayList();
			}
		} else {
			list = new ArrayList();
		}
		return list;
	}

	public void deleteAdvice(String ID) throws SysException {
		String sql = "delete from self_advise a where a.adv_id='" + ID + "'";
		this.jdbcTemplate.execute(sql);
	}

	public SetFileBO getSetFile(String setID, String itemID, String personID) throws SysException {
		List<SetFileBO> list = this.commonDAO.getSetFile(setID, itemID, personID);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	public String saveUpdateFile(UploadedFile file, String path, String pk, String setID, String itemID) throws SysException, IOException {
		String webpath = "file\\setFile\\" + setID;
		File dir = new File(path + webpath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		String name = file.getName();
		String extname = name.substring(name.lastIndexOf("."));
		String realname = CommonFuns.getUUID() + extname;
		webpath += "\\" + realname;
		FileUtil.createFile(file.getBytes(), path + webpath);
		SetFileBO bo = new SetFileBO();
		bo.setFilename(file.getName().substring(0, file.getName().lastIndexOf(".")));
		bo.setFilepath(webpath);
		bo.setPersonID(pk);
		bo.setSetID(setID);
		bo.setItemID(itemID);
		this.commonDAO.saveOrUpdateBo(bo);
		return webpath;
	}

	public void deleteSetFile(String ID) throws SysException {
		this.commonDAO.deleteBo(SetFileBO.class, ID);
	}

	public void saveTempData(String setID, String payoffDate) throws SysException {
		String table = "A815_SET_" + setID;
		// 删除临时数据
		String sql = "delete from a815 where a815701 = '" + payoffDate + "' and tempflag='1' and id in (select id from " + table + ")";
		this.jdbcTemplate.execute(sql);
		// 清空当前状态
		sql = "update a815 set a815000='00900' where a815000='00901' and id in (select id from " + table + ")";
		this.jdbcTemplate.execute(sql);
		// 插入临时数据
		List<InfoItemBO> list = SysCacheTool.queryInfoItemBySetId("A815");
		String item = "";
		for (InfoItemBO bo : list) {
			if (!"SUBID".equals(bo.getItemId())) {
				item += bo.getItemId() + ",";
			}
		}
		sql = "select max(cast(subid as int)) from a815";
		int currSubID = this.jdbcTemplate.queryForInt(sql);
		sql = "insert into a815 (SUBID," + item + "tempflag) select " + currSubID + "+rownum," + item + "1 from " + table;
		this.jdbcTemplate.execute(sql);
		sql = "update sys_sequence s set s.cur_value=(select max(cast(subid as int)) from a815) where s.seq_name='A815'";
		this.jdbcTemplate.execute(sql);
	}

	public List getEmpQueryItem(String userID) throws SysException {
		return this.commonDAO.getEmpQueryItem(userID);
	}

	public void saveQueryItem(String userID, String[] showItems, String[] orderItems) throws SysException {
		String sql = "delete from emp_query_item where person_id='" + userID + "'";
		this.jdbcTemplate.execute(sql);
		String showItem = "";
		for (int i = 0; i < showItems.length; i++) {
			showItem += showItems[i] + ",";
		}
		String orderItem = "";
		if (orderItems != null && orderItems.length > 0) {
			for (int i = 0; i < orderItems.length; i++) {
				orderItem += orderItems[i] + ",";
			}
		}
		EmpQueryItemBO bo = new EmpQueryItemBO();
		bo.setShowItem(showItem);
		bo.setOrderItem(orderItem);
		bo.setPersonID(userID);
		this.commonDAO.saveOrUpdateBo(bo);
	}

	public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, User user, String qryID, String addCondition, CellVO[] itemCells, List<EmpQueryItemBO> queryItemList, IQueryUCC queryucc) throws SysException {
		try {
			StringBuffer where = new StringBuffer();

			name = CommonFuns.filterNull(name).trim();
			if ((name != null) && (!"".equals(name.trim()))) {
				String namecon = "1=0";
				String[] namestr = name.split(",");
				for (int i = 0; i < namestr.length; i++) {
					if (!"".equals(namestr[i])) {
						namecon = namecon + " or A001.A001001 LIKE '%" + namestr[i] + "%' or A001.A001735 like '%" + namestr[i] + "%' or A001002 like '%" + namestr[i] + "%' or A001999 like '%" + namestr[i] + "%'";
					}
				}
				namecon = " and (" + namecon + ")";
				where.append(namecon);
			}
			if ((perType != null) && (!"".equals(perType.trim()))) {
				String[] pers = perType.split(",");
				where.append(" and ").append(CommonFuns.splitInSql(pers, "A001.A001054"));
			}

			if ((superId != null) && (!"".equals(superId.trim()))) {
				OrgBO bo = SysCacheTool.findOrgById(superId);
				if (bo != null) {
					if (OrgBO.GROUPTYPE.equals(bo.getorgType())) {
						where.append(" and A001.A001706='" + bo.getOrgId() + "'");
					} else {
						where.append(" and A001.A001738 LIKE '" + bo.getTreeId() + "%'");
					}
				}
			}

			String cancel1 = "";
			if (!"".equals(cancel)) {
				cancel1 = "A001730 = '" + cancel + "'";
			}

			table.setHeader(itemCells);
			table.setSetType("A");

			QueryVO vo = queryucc.findQueryVO(qryID);
			if (CommonFuns.filterNull(vo.getAddedCondition()).length() > 0 && CommonFuns.filterNull(addCondition).length() > 0) {
				vo.setAddedCondition(CommonFuns.filterNull(vo.getAddedCondition()) + " and " + CommonFuns.filterNull(addCondition));
			} else {
				vo.setAddedCondition(CommonFuns.filterNull(vo.getAddedCondition()) + CommonFuns.filterNull(addCondition));
			}
			if ("156".equals(qryID) && queryItemList != null && queryItemList.size() == 1) {
				List<QueryItemBO> listItem = new ArrayList<QueryItemBO>();
				String[] showItems = queryItemList.get(0).getShowItem().split(",");
				String[] orderItems = queryItemList.get(0).getOrderItem() != null ? queryItemList.get(0).getOrderItem().split(",") : new String[] {};
				List<CellVO> cellList = new ArrayList<CellVO>();
				InfoItemBO IDItem = SysCacheTool.findInfoItem("A001", "ID");
				CellVO IDCell = new CellVO();
				CommonFuns.copyProperties(IDCell, IDItem);
				cellList.add(IDCell);
				for (int i = 0; i < showItems.length; i++) {
					QueryItemBO item = new QueryItemBO();
					item.setQryId("156");
					item.setDefaultFlag(0);
					item.setShowId(0);
					item.setShowHistory(0);
					item.setItemId(showItems[i]);
					item.setSetId(showItems[i].substring(0, 4));
					for (int j = 0; j < orderItems.length; j++) {
						if (orderItems[j].startsWith(showItems[i])) {
							String orderFlag = orderItems[j].substring(8, 9);
							item.setOrderFlag(orderFlag);
							break;
						}
					}
					listItem.add(item);
					InfoItemBO infoItem = SysCacheTool.findInfoItem(showItems[i].substring(0, 4), showItems[i]);
					CellVO cell = new CellVO();
					CommonFuns.copyProperties(cell, infoItem);
					cellList.add(cell);
				}
				CellVO[] cells = cellList.toArray(new CellVO[0]);
				table.setHeader(cells);
				QueryItemBO[] items = listItem.toArray(new QueryItemBO[0]);
				vo.setItem(items);
			}

			QueryUtil qu = new QueryUtil();
			QueryBO bo = new QueryBO();
			CommonFuns.copyProperties(bo, vo);

			Hashtable hash = qu.buildQuerySql(user, vo.getItem(), vo.getStatics()[0], bo);
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
				if ((addCondition != null) && (!"".equals(addCondition))) {
					sql.append(" and ").append(addCondition);
				}
				if ("A001.A001003".equals(order)) {
					sql.append(" order by ").append("A001.deptempsort");
				} else {
					sql.append(" order by ").append(order);
				}
			}
			this.queryAPI.querySql(table, sql.toString(), user, pageNum, rowNum, true);
			return sql.toString();
		} catch (Exception e) {
			throw new SysException("", "查询失败", e, getClass());
		}
	}

	public String getAdjustInfo(TableVO table, String orgID, String filter) throws SysException {
		String fields = "ID";
		List li = SysCacheTool.queryInfoItemBySetId("B733");
		CellVO[] cvs = new CellVO[li.size() + 1];
		cvs[0] = new CellVO();
		CommonFuns.copyProperties(cvs[0], SysCacheTool.findInfoItem("A001", "ID"));
		for (int i = 0; i < li.size(); i++) {
			InfoItemBO ib = (InfoItemBO) li.get(i);
			cvs[(i + 1)] = new CellVO();
			CommonFuns.copyProperties(cvs[(i + 1)], ib);
			fields = fields + "," + ib.getItemId();
		}
		table.setHeader(cvs);

		OrgBO org = SysCacheTool.findOrgById(orgID);

		String sql = "select " + fields + " from B733 left join A001 on B733.B733001=A001.ID where A001.a001738 like '" + org.getOrgSort() + "%' ";
		if (filter != null && !"".equals(filter)) {
			sql = sql + "and " + filter;
		}
		sql = sql + " order by B733702 desc";
		return sql;
	}

	public void batchUpdateInsMonth(String setID, String payoffDate) throws SysException {
		payoffDate=payoffDate.substring(0, 7);
		String sql = "update a243 set a243000=case when a243200='" + payoffDate + "' then '00901' else '00900' end where id in (select id from a815_set_" + setID + ")";
		this.jdbcTemplate.execute(sql);
	}
}
