package com.hr319wg.sys.ucc.impl;

import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeRelation;
import com.hr319wg.sys.pojo.bo.CodeSetBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.service.CodeSetService;
import com.hr319wg.sys.ucc.ICodeSetUCC;

public class CodeSetUCC implements ICodeSetUCC {
	private CodeSetService codesetservice;
	private ActivePageAPI activeapi;

	public ActivePageAPI getActiveapi() {
		return this.activeapi;
	}

	public void setActiveapi(ActivePageAPI api) {
		this.activeapi = api;
	}

	public CodeSetService getCodesetservice() {
		return this.codesetservice;
	}

	public void setCodesetservice(CodeSetService codesetservice) {
		this.codesetservice = codesetservice;
	}

	public void createCodeSet(CodeSetBO codeSet) throws SysException {
		this.codesetservice.createCodeSet(codeSet);
	}

	public List queryCodeSets() throws SysException {
		return this.codesetservice.queryCodeSets();
	}

	public List queryCodeSets(boolean orderByName, String moudleID, String orgID)
			throws SysException {
		return this.codesetservice.queryCodeSets(orderByName, moudleID, orgID);
	}

	public void updateCodeSet(CodeSetBO codeSet) throws SysException {
		this.codesetservice.updateCodeSet(codeSet);
	}

	public void makeStatus(String[] codeSetIds, boolean status)
			throws SysException {
		for (int i = 0; i < codeSetIds.length; i++)
			this.codesetservice.makeStatus(status, codeSetIds[i]);
	}

	public CodeSetBO queryCodeSet(String codeSetID) throws SysException {
		return this.codesetservice.queryCodeSet(codeSetID);
	}

	public void deleteCodeSets(String[] codeSetIds) throws SysException {
		for (int i = 0; i < codeSetIds.length; i++)
			this.codesetservice.deleteCodeSet(codeSetIds[i]);
	}

	public String getNewSetId() throws SysException {
		return this.codesetservice.getNewSetId();
	}

	public String checkUsing(String[] setIds) throws SysException {
		return this.codesetservice.checkUsing(setIds);
	}

	public List getCodeRelationList(String sourceField, String desField)
			throws SysException {
		return this.codesetservice.getCodeRelationList(sourceField, desField);
	}

	public String getCodeSource(String desField) throws SysException {
		String sql = "select isnull(max(source_field),' ') from sys_code_relation where des_field='" + desField + "'";
		return this.activeapi.queryForString(sql).trim();
	}

	public void saveCodeRelation(CodeRelation cr) throws SysException {
		this.codesetservice.saveCodeRelation(cr);
	}

	public List getCodeRelationList() throws SysException {
		return this.codesetservice.getCodeRelationList();
	}

	public void deleteCodeRelation(String itemId) throws SysException {
		this.codesetservice.deleteCodeRelation(itemId);
	}

	public CodeRelation findCodeRelation(String item) throws SysException {
		return this.codesetservice.findCodeRelation(item);
	}

	public void executeAll(String sourceField, String desField, String orguid)
			throws SysException {
		List list = this.codesetservice.getCodeRelationList(sourceField,
				desField);
		for (int i = 0; i < list.size(); i++) {
			CodeRelation cr = (CodeRelation) list.get(i);

			InfoItemBO desbo = SysCacheTool.findInfoItem("", cr.getDesField());
			InfoSetBO dessetbo = SysCacheTool.findInfoSet(desbo.getSetId());

			String sql = "";
			if (InfoSetBO.SET_TYPE_PERSON.equals(dessetbo.getSet_bType())) {
				if ("ORACLE".equals(Constants.DB_TYPE)) {
					sql = cr.getSql() + " and id in (select id from a001 where A001728 like ( select B001003||'%' from b001 where orguid='" + orguid + "'))";
				} else {
					sql = cr.getSql() + " and id in (select id from a001 where A001728 like ( select B001003+'%' from b001 where orguid='" + orguid + "'))";
				}
			}
			this.activeapi.executeSql(sql);
		}
	}

	public void executeSingleItemByOrg(String item, String orguid)
			throws SysException {
		CodeRelation cr = findCodeRelation(item);

		InfoItemBO desbo = SysCacheTool.findInfoItem("", cr.getDesField());
		InfoSetBO dessetbo = SysCacheTool.findInfoSet(desbo.getSetId());

		String sql = "";
		if (InfoSetBO.SET_TYPE_PERSON.equals(dessetbo.getSet_bType())) {
			if ("ORACLE".equals(Constants.DB_TYPE)) {
				sql = cr.getSql()+ " and id in (select id from a001 where A001738 like ( select B001003||'%' from b001 where orguid='" + orguid + "'))";
			} else {
				sql = cr.getSql()+ " and id in (select id from a001 where A001738 like ( select B001003+'%' from b001 where orguid='" + orguid + "'))";
			}
		}

		this.activeapi.executeSql(sql);
	}

	public void executeSingleItem(String item, String pid) throws SysException {
		CodeRelation cr = findCodeRelation(item);
		String sql = cr.getSql() + " and id='" + pid + "'";
		this.activeapi.executeSql(sql);
	}

	public List getCodeRelationListByResult(String setID) throws SysException {
		return this.codesetservice.getCodeRelationListByResult(setID);
	}

	public List getCodeRelationListBySource(String setID) throws SysException {
		return this.codesetservice.getCodeRelationListBySource(setID);
	}
}