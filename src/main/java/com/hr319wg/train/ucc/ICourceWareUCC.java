package com.hr319wg.train.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.train.pojo.bo.CourceWareItemBO;
import com.hr319wg.train.pojo.bo.CourceWareTypeBO;
import java.util.List;

public abstract interface ICourceWareUCC {
	public abstract List getAllValidItemInfo(String paramString)
			throws SysException;

	public abstract List getAllItemInfo(String paramString) throws SysException;

	public abstract List getAllFileInfoByType(String paramString)
			throws SysException;

	public abstract List getAllFileInfoByType(String superID,
			User user) throws SysException;

	public abstract List getAllChildType(String paramString)
			throws SysException;

	public abstract void DeleteType(String paramString) throws SysException;

	public abstract void DeleteItem(String paramString) throws SysException;

	public abstract CourceWareTypeBO getTypeBO(String paramString)
			throws SysException;

	public abstract CourceWareItemBO getItemBO(String paramString)
			throws SysException;

	public abstract void saveType(CourceWareTypeBO paramCourceWareTypeBO)
			throws SysException;

	public abstract void saveItem(CourceWareItemBO paramCourceWareItemBO)
			throws SysException;

	public abstract boolean checkHaveChild(String paramString)
			throws SysException;

	public abstract List getAllPrivateCourceItem(String paramString)
			throws SysException;
}