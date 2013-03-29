package com.hr319wg.emp.ucc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.sys.pojo.bo.InfoItemBO;

public abstract interface IDataUploadUCC {
	public abstract InfoItemBO[] querySetItem(String paramString)
			throws SysException;

	public abstract void batchAddPerson(String[]field, List<Map> list, User paramUser) throws SysException;

	public abstract void updateInfoByCode(String paramString,
			String[] paramArrayOfString, HashMap paramHashMap)
			throws SysException;

	public abstract void insertInfoByCode(String paramString,
			String[] paramArrayOfString, HashMap paramHashMap)
			throws SysException;

	public abstract void saveOrUpdateInfoByCode(String paramString1,
			String[] paramArrayOfString, HashMap paramHashMap,
			String paramString2, String paramString3) throws SysException;

	public abstract void updateCurSign(String paramString1,
			String paramString2, String[] paramArrayOfString,
			String paramString3) throws SysException;
}
