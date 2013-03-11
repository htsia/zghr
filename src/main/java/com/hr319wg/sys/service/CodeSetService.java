package com.hr319wg.sys.service;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.dao.CodeItemDAO;
import com.hr319wg.sys.dao.CodeSetDAO;
import com.hr319wg.sys.pojo.bo.CodeRelation;
import com.hr319wg.sys.pojo.bo.CodeSetBO;

public class CodeSetService {
	private CodeSetDAO codesetdao;
	private CodeItemDAO codeitemdao;

	public CodeSetDAO getCodesetdao() {
		return this.codesetdao;
	}

	public void setCodesetdao(CodeSetDAO codesetdao) {
		this.codesetdao = codesetdao;
	}

	public CodeItemDAO getCodeitemdao() {
		return this.codeitemdao;
	}

	public void setCodeitemdao(CodeItemDAO codeitemdao) {
		this.codeitemdao = codeitemdao;
	}

	public void createCodeSet(CodeSetBO codeSet) throws SysException {
		this.codesetdao.createBo(codeSet);
	}

	public void updateCodeSet(CodeSetBO codeSet) throws SysException {
		this.codesetdao.updateBo(codeSet.getSetId(), codeSet);
	}

	public void deleteCodeSet(String codeSetID) throws SysException {
		this.codesetdao.deleteBo(CodeSetBO.class, codeSetID);
		this.codeitemdao.deleteCodeItems(codeSetID);
	}

	public void makeStatus(boolean status, String codeSetID)
			throws SysException {
		if (status)
			this.codesetdao.makeStatus(codeSetID, CodeSetBO.STATUS_OPEN);
		else
			this.codesetdao.makeStatus(codeSetID, CodeSetBO.STATUS_BAN);
	}

	public CodeSetBO queryCodeSet(String codeSetID) throws SysException {
		return (CodeSetBO) this.codesetdao.findBoById(CodeSetBO.class,
				codeSetID);
	}

	public List queryCodeSets() throws SysException {
		return this.codesetdao.queryCodeSets();
	}

	public List queryCodeSets(boolean orderByName, String moudleID, String orgID) throws SysException {
		return this.codesetdao.queryCodeSets(orderByName, moudleID, orgID);
	}

	public String getNewSetId() throws SysException {
		return this.codesetdao.getNewSetId();
	}

	public String checkUsing(String[] setIds) throws SysException {
		return this.codesetdao.checkUsing(setIds);
	}

	public List getCodeRelationList(String sourceField, String desField)
			throws SysException {
		return this.codesetdao.getCodeRelationList(sourceField, desField);
	}

	public void saveCodeRelation(CodeRelation cr) throws SysException {
		this.codesetdao.saveOrUpdateBo(cr);
	}

	public CodeRelation findCodeRelation(String item) throws SysException {
		return (CodeRelation) this.codesetdao.findBoById(CodeRelation.class,
				item);
	}

	public void deleteCodeRelation(String itemId) throws SysException {
		this.codesetdao.deleteBo(CodeRelation.class, itemId);
	}

	public List getCodeRelationListByResult(String setID) throws SysException {
		return this.codesetdao.getCodeRelationListByResult(setID);
	}

	public List getCodeRelationListBySource(String setID) throws SysException {
		return this.codesetdao.getCodeRelationListBySource(setID);
	}

	public List getCodeRelationList() throws SysException {
		return this.codesetdao.getCodeRelationList();
	}
}