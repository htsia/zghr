package com.hr319wg.custom.extend.service;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.emp.service.PersonService;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PersonServiceByExtend extends PersonService {

	public String getChangeInfo(TableVO table, String unitId, String filter) {
		String fields = "A001.ID||'|'||B730.subid as ID";
		if ("SQL SERVER".equals(Constants.DB_TYPE)) {
			fields = "A001.ID+'|'+B730.subid as ID";
		}
		List<InfoItemBO> itemList = new ArrayList<InfoItemBO>();
		List<InfoItemBO> li = SysCacheTool.queryInfoItemBySetId("B730");
		for (InfoItemBO item : li) {
			if ("1".endsWith(item.getItemStatus())) {
				itemList.add(item);
			}
		}
		CellVO[] cvs = new CellVO[itemList.size() + 1];
		cvs[0] = new CellVO();
		CommonFuns.copyProperties(cvs[0], SysCacheTool.findInfoItem("A001", "ID"));
		for (int i = 0; i < itemList.size(); i++) {
			InfoItemBO ib = (InfoItemBO) itemList.get(i);
			cvs[i+1]=new CellVO(); 
			CommonFuns.copyProperties(cvs[i + 1], ib);
			fields += "," + ib.getItemId();
		}
		table.setHeader(cvs);

		String sql = "select " + fields + " from B730 left join A001 on B730.B730700=A001.ID where orguid in (select orguid from b001 where B001003 like getorgtree('" + unitId + "')||'%') ";
		if ("SQL SERVER".equals(Constants.DB_TYPE)) {
			sql = "select " + fields + " from B730 left join A001 on B730.B730700=A001.ID where orguid in (select orguid from b001 where B001003 like dbo.getorgtree('" + unitId + "')+'%') ";
		}
		if (filter != null && !"".equals(filter)) {
			sql = sql + "and " + filter;
		}
		sql = sql + " order by B730701 desc";
		return sql;
	}
}
