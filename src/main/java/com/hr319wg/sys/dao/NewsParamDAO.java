package com.hr319wg.sys.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.run.util.RunTools;
import com.hr319wg.sys.pojo.bo.NewsParamBO;
import com.hr319wg.util.CommonFuns;

public class NewsParamDAO extends BaseDAO {
	private NewsParamBO parambo;

	public List queryPublicNews() {
		String strHQL = "from NewsParamBO bp where bp.publicFlag = '1' order by bp.submitDate desc";
		return this.hibernatetemplate.find(strHQL);
	}

	public List queryByCreatorRoleId(String RoleId) {
		String strHQL = "from NewsParamBO bp where bp.creatorRoleId = ? order by bp.submitDate desc";
		String[] obj = new String[1];
		obj[0] = RoleId;
		List list = this.hibernatetemplate.find(strHQL, obj);
		return list;
	}

	public List queryByNewsIdListAndReaderType(String Id, String ReaderType,
			String level) {
		return queryByNewsIdListAndReaderType(Id, ReaderType, level, false);
	}

	public List queryByNewsIdListAndReaderType(String Id, String ReaderType, String level, boolean orNotWork) {
		String date=CommonFuns.getSysDate("yyyy-MM-dd");
		String hql = "from NewsParamBO bo where bo.newId in (" + Id + ")";
	    if(!orNotWork){
	    	hql+=" and bo.startDate<='"+date+"' and bo.endDate>='"+date+"' and isnull(bo.newEndDate,'"+date+"')>='"+date+"'";
	    }else{
	    	hql+=" and (bo.endDate<'"+date+"' or isnull(bo.newEndDate,'"+date+"')<'"+date+"')";	    	
	    }
		hql+=" order by bo.startDate desc";
		return this.hibernatetemplate.find(hql);
	}

	public List queryNewsParamAndNewsScopeByTreeIdAndReaderType(String TreeId,
			String ReaderType) {
		return null;
	}
}