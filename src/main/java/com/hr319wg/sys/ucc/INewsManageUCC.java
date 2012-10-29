package com.hr319wg.sys.ucc;

import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.sys.pojo.bo.NewsContentBO;
import com.hr319wg.sys.pojo.bo.NewsParamBO;
import com.hr319wg.sys.pojo.vo.NewsEditVO;
import java.util.List;

public abstract interface INewsManageUCC {
	public abstract List queryNewsParam(User paramUser) throws SysException;

	public abstract List queryNewsParam(User paramUser, boolean paramBoolean)
			throws SysException;

	public abstract List queryNewsParamByOrgId(String paramString1,
			String paramString2, String paramString3) throws SysException;

	public abstract List queryNewsParamByOrgId(String paramString1,
			String paramString2, String paramString3, boolean paramBoolean)
			throws SysException;

	public abstract List queryNewsParamAndScopeByCreatorRoleId(
			String paramString) throws SysException;

	public abstract NewsContentBO findContentBOByNewsId(String paramString)
			throws SysException;

	public abstract String createNews(NewsEditVO paramNewsEditVO, List paramList,
			String paramString) throws RollbackableException;

	public abstract void deleteNewsByNewsId(String paramString)
			throws RollbackableException;

	public abstract void deleteNewsByNewsIdArray(String[] paramArrayOfString)
			throws RollbackableException;

	public abstract void updateNews(NewsEditVO paramNewsEditVO, List paramList,
			String paramString) throws RollbackableException;

	public abstract void updateNewsParam(NewsParamBO paramNewsParamBO)
			throws RollbackableException;

	public abstract void updateNewsContent(NewsContentBO paramNewsContentBO)
			throws RollbackableException;

	public abstract void updateNewsScopeByNewsId(String paramString,
			String[] paramArrayOfString) throws RollbackableException;

	public abstract String findNewsContent(String paramString)
			throws SysException;

	public abstract List findNewsContentFile(String paramString)
			throws SysException;

	public abstract NewsParamBO findNewsParamByNewsId(String paramString)
			throws SysException;

	public abstract String[] findNewsScopeByNewsId(String paramString)
			throws SysException;

	public abstract String findRoleId(String paramString) throws SysException;
}
