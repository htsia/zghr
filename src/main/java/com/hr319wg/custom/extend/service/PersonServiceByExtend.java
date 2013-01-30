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
		List li = SysCacheTool.queryInfoItemBySetId("B730");
		List<InfoItemBO> itemList=new ArrayList<InfoItemBO>();
		int size=0;
		for (int i = 0; i < li.size(); i++) {
			InfoItemBO ib = (InfoItemBO) li.get(i);
			if("1".equals(ib.getItemStatus())){
				itemList.add(ib);
				size++;
			}
		}
		CellVO[] cvs = new CellVO[size+1];
		cvs[0] = new CellVO();
		CommonFuns.copyProperties(cvs[0], SysCacheTool.findInfoItem("A001", "ID"));
		for (int i = 0; i < size; i++) {
			InfoItemBO ib = itemList.get(i);
			if("1".equals(ib.getItemStatus())){
				cvs[(i + 1)] = new CellVO();
				CommonFuns.copyProperties(cvs[(i + 1)], ib);
				fields += "," + ib.getItemId();
			}
		}
		table.setHeader(cvs);

		String sql = "select " + fields
				+ " from B730, A001 where B730700=ID and orguid in (select orguid from b001 where B001003 like getorgtree('"+ unitId + "')||'%') ";
		if ("SQL SERVER".equals(Constants.DB_TYPE)) {
			sql = "select " + fields
					+ " from B730 , A001 where B730700=ID and orguid in (select orguid from b001 where B001003 like dbo.getorgtree('"+ unitId + "')+'%') ";
		}
		if ((filter != null) && (!"".equals(filter))) {
			sql += "and " + filter;
		}
		sql += " order by isnull(B730701,' ') desc";
		return sql;
	}
}
