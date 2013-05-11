package com.hr319wg.wage.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.wage.pojo.bo.WageAdjustBO;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;
import com.hr319wg.wage.pojo.bo.WageAdjustRuleBO;
import com.hr319wg.wage.pojo.vo.AdjustVO;
import java.util.List;

public abstract interface IWageAdjustUCC {
	public abstract List getAdjustList(PageVO pagevo, boolean isAppro,
			User user, String orgID, String name, String time, String time2)
			throws SysException;

	public abstract void saveWageAdjustBO(WageAdjustBO paramWageAdjustBO)
			throws SysException;

	public abstract WageAdjustBO getWageAdjustBO(String paramString)
			throws SysException;

	public abstract AdjustVO getAdjustVO(String paramString)
			throws SysException;

	public abstract AdjustVO descriptAdjustVO(AdjustVO paramAdjustVO)
			throws SysException;

	public abstract void deleteAdjust(String paramString) throws SysException;

	public abstract void saveWageAdjustDetailBO(
			WageAdjustDetailBO paramWageAdjustDetailBO) throws SysException;

	public abstract WageAdjustRuleBO getWageAdjustRuleBO(String paramString)
			throws SysException;

	public abstract void saveWageAdjustRuleBO(
			WageAdjustRuleBO paramWageAdjustRuleBO) throws SysException;

	public abstract void deleteWageAdjustDetailBO(String paramString)
			throws SysException;

	public abstract WageAdjustDetailBO getWageAdjustDetailBO(String paramString)
			throws SysException;

	public abstract List getAdjustDetail(String paramString)
			throws SysException;

	public abstract String ValidateAdjust(User paramUser, String paramString)
			throws SysException;

	public abstract WageAdjustBO getWageAdjustBOByLinkID(String paramString)
			throws SysException;

	public abstract String getAdjustMemo(String paramString)
			throws SysException;

	public abstract String getAdjustMemoByLinkID(String paramString)
			throws SysException;

	public abstract void createAdjustDetail(String paramString1,
			String paramString2, String[] paramArrayOfString)
			throws SysException;
}

/*
 * Location: E:\desk1\lib3\ Qualified Name: com.hr319wg.wage.ucc.IWageAdjustUCC
 * JD-Core Version: 0.6.0
 */