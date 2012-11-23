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
	    String fields = " ws.set_id||'-'||A001.ID||'-'||B730.subid AS ID,A001735,A001705 ";
	    CellVO[] cvs = new CellVO[showItems.size() + 4];
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
	    cvs[(showItems.size() + 3)] = new CellVO();
	    cvs[(showItems.size() + 3)].setItemId("set_name");
	    cvs[(showItems.size() + 3)].setItemName("Ð½×ÊÕËÌ×");
	    fields = fields + ",set_name";
	    table.setHeader(cvs);

	    String sql = "select " + fields + " from B730, A001,wage_set_pers_r w, wage_set ws where B730.B730700=A001.ID and B730.B730200 is null and A001.id=w.id and w.A815700=ws.set_id and no_use<>'1' and orguid='" + unitId + "' ";
	    if ((filter != null) && (!"".equals(filter))) {
	      sql += " and " + filter;
	    }
	    sql = sql + " order by B730701 desc";
	    return sql;
	  }
}
