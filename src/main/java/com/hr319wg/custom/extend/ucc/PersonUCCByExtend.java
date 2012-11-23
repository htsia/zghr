package com.hr319wg.custom.extend.ucc;

import java.util.ArrayList;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.emp.ucc.impl.PersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PersonUCCByExtend extends PersonUCC {

	@Override
	public String queryInsChangePersonList(TableVO table, String name, String superId, int pageNum, int rowNum, User user) throws SysException {
		StringBuffer where = new StringBuffer();
	    if ((superId != null) && (!"".equals(superId))) {
	      where.append(" and B731.orguid ='").append(superId).append("'");
	    }

	    ArrayList liitems = SysCacheTool.queryInfoItemBySetId("B731");
	    for (int i = 0; i < liitems.size(); i++) {
	      InfoItemBO ib = (InfoItemBO)liitems.get(i);
	      if (ib.getItemId().toLowerCase().equals("orguid")) {
	        InfoItemBO ia = SysCacheTool.findInfoItem("A001", "ID");
	        liitems.set(i, ia);
	      }
	    }
	    CellVO[] c1 = new CellVO[liitems.size()];
	    for (int i = 0; i < liitems.size(); i++) {
	      c1[i] = new CellVO();
	      CommonFuns.copyProperties(c1[i], liitems.get(i));
	    }
	    table.setHeader(c1);
	    table.setSetType("A");
	    StringBuffer sql = new StringBuffer("");
	    sql.append("select ");
	    for (int i = 0; i < liitems.size(); i++) {
	      InfoItemBO b = (InfoItemBO)liitems.get(i);
	      sql.append(b.getItemId());
	      if (i == liitems.size() - 1) continue; sql.append(",");
	    }
	    sql.append(" from B731 left join A001 on B731.B731700=A001.ID");
	    OrgBO org = SysCacheTool.findOrgById(superId);
	    if(org!=null && !"-1".equals(org.getSuperId())){
	    	sql.append(" where B731.orguid ='").append(superId).append("'");	    	
	    }
	    if ((name != null) && (!name.equals(""))) {
	      sql.append(" and ( A001.A001001 like '%").append(name).append("%' or A001.A001735 like '%").append(name).append("%' or A001.A001002 like '%").append(name.toLowerCase()).append("%')");
	    }
	    sql.append(" order by B731.B731701 desc");
	    getActivepageservice().querySql(table, sql.toString(), user, pageNum, rowNum, true);
	    return sql.toString();
	}
	
}
