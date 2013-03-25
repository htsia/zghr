package com.hr319wg.sys.ucc;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.pojo.bo.CodeRelation;
import com.hr319wg.sys.pojo.bo.CodeSetBO;

public abstract interface ICodeSetUCC {
	public abstract void createCodeSet(CodeSetBO paramCodeSetBO)
			throws SysException;

	public abstract List queryCodeSets() throws SysException;

	public abstract List queryCodeSets(boolean paramBoolean, String moudleID, String orgID)
			throws SysException;

	public abstract void updateCodeSet(CodeSetBO paramCodeSetBO)
			throws SysException;

	public abstract void makeStatus(String[] paramArrayOfString,
			boolean paramBoolean) throws SysException;

	public abstract CodeSetBO queryCodeSet(String paramString)
			throws SysException;

	public abstract void deleteCodeSets(String[] paramArrayOfString)
			throws SysException;

	public abstract String getNewSetId() throws SysException;

	public abstract String checkUsing(String[] paramArrayOfString)
			throws SysException;

	public abstract List getCodeRelationList(String paramString1,
			String paramString2) throws SysException;

	public abstract void saveCodeRelation(CodeRelation paramCodeRelation)
			throws SysException;

	public abstract void deleteCodeRelation(String paramString)
			throws SysException;

	public abstract CodeRelation findCodeRelation(String paramString)
			throws SysException;

	public abstract void executeAll(String paramString1, String paramString2,
			String paramString3) throws SysException;

	public abstract void executeSingleItemByOrg(String paramString1,
			String paramString2) throws SysException;

	public abstract void executeSingleItem(String paramString1,
			String paramString2) throws SysException;

	public abstract String getCodeSource(String paramString)
			throws SysException;
}

/*
 * Location: E:\desk1\lib3\ Qualified Name: com.hr319wg.sys.ucc.ICodeSetUCC
 * JD-Core Version: 0.6.0
 */