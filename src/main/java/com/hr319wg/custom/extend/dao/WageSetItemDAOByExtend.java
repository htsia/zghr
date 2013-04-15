package com.hr319wg.custom.extend.dao;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.RollbackableException;
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
	
	public List querySetItemByType(String setId, String type,
			boolean orderByName) throws SysException {
		try {
			String order = "";
			if ("1".equals(type) || "2".equals(type)) {
				order = " order by si.countSeq+0";
			} else if (orderByName) {
				order = " order by ifbo.itemName ";
			}

			List list = this.hibernatetemplate.find("select si from WageSetItemBO si,InfoItemBO ifbo where si.field=ifbo.itemId and si.setId=? and si.type=? "+ order, new String[] { setId, type });

			if ((list != null) && (list.size() > 0)) {
				for (int i = 0; i < list.size(); i++)
					this.hibernatetemplate.evict(list.get(i));
			}
			return list;
		} catch (Exception e) {
			throw new RollbackableException("", "²éÑ¯Ê§°Ü", e, getClass());
		}
	}

}
