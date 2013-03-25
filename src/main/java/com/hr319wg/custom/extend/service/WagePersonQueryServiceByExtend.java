package com.hr319wg.custom.extend.service;

import java.util.List;

import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.service.WagePersonQueryService;

public class WagePersonQueryServiceByExtend extends WagePersonQueryService{

	public String getChangeInfo(TableVO table, List showItems, String unitId, String filter)
	  {
	    String fields = "A001.ID as ID,A001735,A001705";
	    CellVO[] cvs = new CellVO[showItems.size() + 3];
	    cvs[0] = new CellVO();
	    CommonFuns.copyProperties(cvs[0], SysCacheTool.findInfoItem("A001", "ID"));
	    cvs[1] = new CellVO();
	    CommonFuns.copyProperties(cvs[1], SysCacheTool.findInfoItem("A001", "A001735"));
	    cvs[2] = new CellVO();
	    CommonFuns.copyProperties(cvs[2], SysCacheTool.findInfoItem("A001", "A001705"));
	    for (int i = 0; i < showItems.size(); i++) {
	      InfoItemBO ib = (InfoItemBO)showItems.get(i);
	      cvs[(i + 3)] = new CellVO();
	      CommonFuns.copyProperties(cvs[(i + 3)], ib);
	      if (fields.equals("")) {
	        fields = ib.getSetId() + "." + ib.getItemId();
	      }
	      else {
	        fields = fields + "," + ib.getSetId() + "." + ib.getItemId();
	      }
	    }
	    
	    table.setHeader(cvs);
	    String sql = "select " + fields + " from B730,A001 where B730.B730700=A001.ID and A001.ID not in (select id from wage_set_pers_r) and a001701='" + unitId + "' and "+filter+" order by B730701 desc";
	    return sql;
	  }
}
