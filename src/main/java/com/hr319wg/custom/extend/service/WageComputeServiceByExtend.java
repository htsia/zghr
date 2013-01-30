package com.hr319wg.custom.extend.service;

import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.wage.service.WageComputeService;

public class WageComputeServiceByExtend extends WageComputeService {

	public void createTmpTable(String setId, String dateId, String payoffdate,
			String unitId) throws SysException {
		String tablename = this.getTmp_table() + setId;
		String drop = "drop table " + tablename;

		if (this.getApi().isDBTable(tablename)) {
			this.getApi().executeSql(drop.toUpperCase());
		}

		String field = "";
		List list = SysCacheTool.queryInfoItemBySetId("A815");
		int count = list.size();
		for (int i = 0; i < count; i++) {
			String itemId = ((InfoItemBO) list.get(i)).getItemId();
			if ("A815700".equals(itemId)) {
				itemId = "'" + setId + "' as " + itemId;
				field += itemId + ",";
			} else if ("A815702".equals(itemId)) {
				itemId = "'" + dateId + "' as " + itemId;
				field += itemId + ",";
			} else if ("A815705".equals(itemId)) {
				itemId = "'" + unitId + "' as " + itemId;
				field += itemId + ",";
			} else if ("A815701".equals(itemId)) {
				itemId = "'" + payoffdate + "' as " + itemId;
				field += itemId + ",";
			} else if ("A815000".equals(itemId)) {
				itemId = "'00901' as " + itemId;
				field += itemId + ",";
			} else if (!itemId.contains("A815")) {
				field += itemId + ",";
			} else {
				field += " 0 " + itemId + ",";
			}
		}
		field = field.substring(0, field.length() - 1);
		String sql = "";
		if ("ORACLE".equals(Constants.DB_TYPE)) {
			sql = "create table " + tablename + " as select " + field
					+ " from " + "wage_set_pers_r" + " where ";
		} else {
			sql = "select " + field + " into " + tablename + " from "
					+ "wage_set_pers_r" + " where ";
		}
		sql = sql + "A815700='" + setId + "'";
		try {
			this.getApi().executeSql(sql);
			sql = "alter table " + tablename + "  add constraint PK_"
					+ tablename + " primary key (ID)";
			this.getApi().executeSql(sql);
			sql = "update " + tablename + " set A815757='00900'";
		} catch (Exception e) {
			throw new RollbackableException("", "创建薪资发放临时表出错", e, getClass());
		}
	}

}
