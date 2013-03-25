package com.hr319wg.custom.extend.dao;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.wage.dao.WageSetItemDAO;

public class WageSetItemDAOByExtend extends WageSetItemDAO {

	public List querySetItemBySetId(String setId) throws SysException {
		List list = this.hibernatetemplate.find("from WageSetItemBO si where si.setId=? order by cast(isnull(si.showSeq,0) as int)",setId);
		if (list == null){
			list = new ArrayList();
		}
		return list;
	}
}
