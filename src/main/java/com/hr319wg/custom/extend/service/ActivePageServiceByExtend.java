package com.hr319wg.custom.extend.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.service.ActivePageService;
import com.hr319wg.util.CommonFuns;

public class ActivePageServiceByExtend extends ActivePageService {
	public TableVO queryPageInfo(String infoSetId, String pkValue,
			String fkValue, User user, String where, String sort)
			throws SysException {
		TableVO table = new TableVO();

		InfoSetBO set = SysCacheTool.findInfoSet(infoSetId);
		CommonFuns.copyProperties(table, set);
		table.setSetType(set.getSet_bType());

		if (InfoSetBO.SET_PROPERTY_VIEW.equals(table.getSetProperty())) {
			table.setPermission(2);
		} else if (user != null) {
			String id = "";
			if (InfoSetBO.RS_TYPE_MANY.equals(table.getSet_rsType()))
				id = fkValue;
			else {
				id = pkValue;
			}
			this.getPmsapi().checkTable(user, table, id);
		}

		InfoItemBO[] items = this.queryInfoItem(infoSetId, pkValue);
		if(user!=null){
			List itemList= this.getPmsapi().queryUserInfoItems(user, Arrays.asList(items), 2);
			items=(InfoItemBO[]) itemList.toArray(new InfoItemBO[0]);
		}
		CellVO[] cells = new CellVO[items.length];
		CommonFuns.copyArrayObject(CellVO.class, cells, items);

		if (user != null) {
			this.getPmsapi().checkData(user, cells);
		}

		table.setHeader(cells);
		table.setRowData(this.getActivepagedao().queryRecords(table, pkValue, fkValue, null, where, sort));
		return table;
	}

	private InfoItemBO[] queryInfoItem(String setId, String pkValue) {
		List items = new ArrayList();
		List bos = SysCacheTool.queryInfoItemBySetId(setId);
		if (bos != null) {
			for (int i = 0; i < bos.size(); i++) {
				InfoItemBO bo = (InfoItemBO) bos.get(i);
				InfoSetBO setBO= SysCacheTool.findInfoSet(setId);
				if ((InfoItemBO.STATUS_OPEN.equals(bo.getItemStatus()) && !InfoItemBO.DATA_TYPE_FILE.equals(bo.getItemDataType())) || (pkValue!=null && !InfoSetBO.RS_TYPE_SINGLE.equals(setBO.getSet_rsType()))) {
					items.add(bo);
				}
			}
		}
		if ((items != null) && (items.size() > 0)) {
			return (InfoItemBO[]) items.toArray(new InfoItemBO[0]);
		}
		return null;
	}
}
