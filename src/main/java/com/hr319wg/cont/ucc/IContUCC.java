package com.hr319wg.cont.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.cont.pojo.bo.ContBO;
import com.hr319wg.cont.pojo.bo.ContSignBO;
import com.hr319wg.sys.pojo.vo.TableVO;
import java.util.List;

public abstract interface IContUCC {
	public abstract void batchAddFollowCont(List<ContSignBO> list)
			throws SysException;

	public abstract ContBO[] queryAll(String paramString1, String paramString2,
			String paramString3, PageVO paramPageVO) throws SysException;

	public abstract ContBO[] queryAllByApproveOrgId(String paramString1,
			String paramString2, String paramString3, PageVO paramPageVO,
			String paramString4) throws SysException;

	public abstract ContBO[] queryAllByApproveOrgId(String paramString1,
			String paramString2, String paramString3, PageVO paramPageVO)
			throws SysException;

	public abstract ContBO[] queryAllByPersonId(String paramString1,
			String paramString2) throws SysException;

	public abstract ContBO[] queryAllByTemplateId(String paramString1,
			String paramString2) throws SysException;

	public abstract String createCont(ContBO paramContBO) throws SysException;

	public abstract void updateCont(String paramString, ContBO paramContBO)
			throws SysException;

	public abstract void deleteCont(String paramString) throws SysException;

	public abstract ContBO findContById(String paramString) throws SysException;

	public abstract List makeLink(String[] paramArrayOfString,
			String paramString) throws SysException;

	public abstract String getDismissPerson(TableVO paramTableVO,
			User paramUser, String paramString1, String paramString2)
			throws SysException;

	public abstract String getMaxContNo() throws SysException;

	public abstract String getMaxContNo(String paramString) throws SysException;

	public abstract String findContPostBObyId(String paramString)
			throws SysException;

	public abstract String findC019(String paramString) throws SysException;

	public abstract TableVO getContSheet(String paramString1,
			String paramString2) throws SysException;

	public abstract void changeContMaster(String paramString)
			throws SysException;
}