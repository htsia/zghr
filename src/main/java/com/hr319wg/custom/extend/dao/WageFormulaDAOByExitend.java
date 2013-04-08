package com.hr319wg.custom.extend.dao;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.dao.WageFormulaDAO;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;

public class WageFormulaDAOByExitend extends WageFormulaDAO {

	public List queryFormulaByUnitIdSetId(String unitId, String setid,
			boolean orderByName) throws SysException {
		try {
			String sql = "from WageFormulaBO f where (f.setId='" + setid + "' or  f.usualFlag='" + WageFormulaBO.PUBLIC + "') and f.formulaId not in (select a.linkId from WageSetItemBO a where a.setId='"+ setid + "' and a.type='1') order by ";
			if (orderByName) {
				sql += " f.name";
			} else {
				sql += " f.showque";
			}

			List list = this.hibernatetemplate.find(sql);
			if (list.isEmpty())
				return null;
			List rs = new ArrayList();
			for (int i = 0; i < list.size(); i++) {
				WageFormulaBO vo = new WageFormulaBO();
				CommonFuns.copyProperties(vo, list.get(i));
				rs.add(vo);
			}
			return rs;
		} catch (Exception e) {
			throw new RollbackableException("", "查询发薪单位下的公式失败", e, getClass());
		}
	}

}
