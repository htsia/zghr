package com.hr319wg.emp.ucc.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.hr319wg.ccp.pojo.bo.PartyBO;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.emp.pojo.vo.PersonChangeVO;
import com.hr319wg.emp.pojo.vo.PersonVO;
import com.hr319wg.emp.ucc.IDataUploadUCC;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.api.SysAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class DataUploadImpl implements IDataUploadUCC {
	private SysAPI sysapi;
	private ActivePageAPI activepageapi;
	private IPersonUCC personucc;

	public IPersonUCC getPersonucc() {
		return this.personucc;
	}

	public void setPersonucc(IPersonUCC sysapi) {
		this.personucc = sysapi;
	}

	public SysAPI getSysapi() {
		return this.sysapi;
	}

	public void setSysapi(SysAPI sysapi) {
		this.sysapi = sysapi;
	}

	public ActivePageAPI getActivepageapi() {
		return this.activepageapi;
	}

	public void setActivepageapi(ActivePageAPI activepageapi) {
		this.activepageapi = activepageapi;
	}

	public InfoItemBO[] querySetItem(String setId) throws SysException {
		try {
			return this.sysapi.queryInportInfoItem(setId);
		} catch (Exception e) {
			throw new RollbackableException("E1400005", "查询指标项错误", e, getClass());
		}
	}

	public void batchAddPerson(String[]field, List<Map> list, User user)
			throws SysException {
		for(Map m : list){
			String A001001=String.valueOf(m.get("A001001"));
			String A001054=String.valueOf(m.get("A001054"));
			String A001705=String.valueOf(m.get("A001705"));
			String A001077=String.valueOf(m.get("A001077"));
			String A001725=String.valueOf(m.get("A001725"));
			String B730702=String.valueOf(m.get("B730702"));
			String B730701=String.valueOf(m.get("B730701"));
			String A001044=String.valueOf(m.get("A001044"));
			if(m.get("A001044")==null){
				A001044=CommonFuns.getSysDate("yyyy-MM-dd");
			}
			PersonVO vo = new PersonVO();
			OrgBO org = OrgTool.getOrgByDept(A001705);
			vo.setPersonCode(this.personucc.getNextPersonCode(org.getOrgId()));
			vo.setName(A001001);
			vo.setPersonType(A001054);
			vo.setIdNum(A001077);
			vo.setDeptId(A001705);
			vo.setStatus(A001725);
			vo.setUnitTime(A001044);
			PersonChangeVO perchangevo = new PersonChangeVO();
			perchangevo.setChangeType(B730702);
			perchangevo.setChangeDate(B730701);
			String pid = this.personucc.createPerson(vo, perchangevo, user, null);
			String sql=null;
			if(!"014511".equals(A001725) && !"014512".equals(A001725)){
				sql = "delete from emp_probation where person_id='"+pid+"'";
				this.activepageapi.executeSql(sql);
			}
			if("014512".equals(A001725)){
				sql = "select normail_type from org_probation where orguid='"+user.getOrgId()+"'";
				String jianxi = this.activepageapi.queryForString(sql);
				if(jianxi==null || "".equals(jianxi)){
					jianxi = Constants.DEFAULT_PROBATION;
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	            Calendar cd = new GregorianCalendar();
	            try {
					cd.setTime(sdf.parse(vo.getUnitTime()));
				} catch (ParseException e) {
					e.printStackTrace();
				}
	            cd.add(2, Integer.parseInt(jianxi));
	            String planDate =sdf.format(cd.getTime());
				sql = "update emp_probation set status='5',plan_passdate='"+planDate+"' where person_id='"+pid+"'";
				this.activepageapi.executeSql(sql);
			}
			if (field.length > 7) {
				sql = "update a001 set ";
				String set = "";
				for (int i = 7; i < field.length; i++) {
					set += field[i] + "='" +(m.get(field[i])==null?"":m.get(field[i]))+ "',";
				}
				set=set.substring(0, set.length()-1);
				sql = sql + set + " where id='" + pid + "'";
				this.activepageapi.executeSql(sql);
			}
		}
	}

	public void saveOrUpdateInfoByCode(String setId, String[] itemId,
			HashMap value, String timeValue, String timeField)
			throws SysException {
		try {
			if ((setId != null) && (!setId.equals("")) && (itemId != null)
					&& (itemId.length > 0)) {
				if (setId.substring(1).equals("001")) {
					throw new RollbackableException("不能导入基本集记录");
				}
				String[] batchsql = null;
				InfoSetBO bo = SysCacheTool.findInfoSet(setId);
				if (bo != null) {
					Iterator iterator = value.values().iterator();
					Iterator key = value.keySet().iterator();
					int col = 0;
					String fkval = "";
					if (bo.getSet_rsType().equals(InfoSetBO.RS_TYPE_SINGLE)) {
						batchsql = new String[value.size()];
						while ((iterator.hasNext()) && (key.hasNext())) {
							StringBuffer sql = new StringBuffer();
							StringBuffer val = new StringBuffer();
							fkval = (String) key.next();
							String[] data = (String[]) (String[]) iterator
									.next();
							for (int i = 0; i < data.length; i++) {
								if (data[i] == null)
									sql.append(",").append(itemId[i])
											.append(" = null");
								else {
									sql.append(",").append(itemId[i])
											.append(" = '").append(data[i])
											.append("'");
								}
							}
							sql.insert(0, bo.getSetPk() + " = '" + fkval + "'");
							sql.insert(0, "update " + setId + " set ");
							sql.append(" where ID='").append(fkval).append("'");
							batchsql[col] = sql.toString();
							col += 1;
						}
					}
					batchsql = new String[value.size()];
					while ((iterator.hasNext()) && (key.hasNext())) {
						StringBuffer sql = new StringBuffer();
						StringBuffer val = new StringBuffer();

						fkval = ((String) key.next()).split("\\|")[0];

						String countSql = "select count(*) from " + setId
								+ " where id='" + fkval + "' and " + timeField
								+ "='" + timeValue + "'";
						String[] data = (String[]) (String[]) iterator.next();
						if (this.activepageapi.queryForInt(countSql) < 1) {
							for (int i = 0; i < data.length; i++) {
								sql.append(",").append(itemId[i]);
								if (data[i] == null)
									val.append(",null");
								else {
									val.append(",'").append(data[i])
											.append("'");
								}
							}
							sql.insert(0, bo.getSetPk() + "," + bo.getSetFk()
									+ "," + bo.getSetId() + "000," + timeField);
							sql.insert(0, "(").append(")");
							sql.insert(0, "insert into " + setId);
							String pk = SequenceGenerator.getKeyId(setId);
							val.insert(0, "'" + pk + "','" + fkval + "'"
									+ ",'00900','" + timeValue + "'");
							val.insert(0, " values (").append(")");
							batchsql[col] = (sql.toString() + val.toString());
						} else {
							for (int i = 0; i < data.length; i++) {
								if (data[i] == null)
									sql.append(",").append(itemId[i])
											.append(" = null");
								else {
									sql.append(",").append(itemId[i])
											.append(" = '").append(data[i])
											.append("'");
								}
							}
							sql.insert(0, "ID='" + fkval + "' ");
							sql.insert(0, "update " + setId + " set ");
							sql.append(" where ID='")
									.append(fkval)
									.append("' and " + timeField + "='"
											+ timeValue + "'");
							batchsql[col] = sql.toString();
						}
						col += 1;
					}
				}

				this.activepageapi.batchExecuteSql(batchsql);
			}
		} catch (Exception e) {
			throw new RollbackableException("E140004", "导入失败", e, getClass());
		}
	}

	public void insertInfoByCode(String setId, String[] itemId, HashMap value)
			throws SysException {
		try {
			if ((setId != null) && (!setId.equals("")) && (itemId != null)
					&& (itemId.length > 0)) {
				if (setId.substring(1).equals("001")) {
					throw new RollbackableException("不能导入基本集记录");
				}
				String[] batchsql = new String[value.size()];
				InfoSetBO bo = SysCacheTool.findInfoSet(setId);
				if (bo != null) {
					Iterator iterator = value.values().iterator();
					Iterator key = value.keySet().iterator();
					int col = 0;
					String fkval = "";
					if (bo.getSet_rsType().equals(InfoSetBO.RS_TYPE_SINGLE)) {
						while ((iterator.hasNext()) && (key.hasNext())) {
							StringBuffer sql = new StringBuffer();
							StringBuffer val = new StringBuffer();
							if (bo.getSet_bType()
									.equals(InfoSetBO.SET_TYPE_ORG)) {
								OrgBO pbo = SysCacheTool
										.findOrgByCode((String) key.next());
								fkval = pbo.getOrgId();
							} else if (bo.getSet_bType().equals(
									InfoSetBO.SET_TYPE_PARTY)) {
								PartyBO pbo = SysCacheTool
										.findParty((String) key.next());
								fkval = pbo.getPartyId();
							} else if (bo.getSet_bType().equals(
									InfoSetBO.SET_TYPE_PERSON)) {
								fkval = ((String) key.next()).split("\\|")[0];
							} else if (bo.getSet_bType().equals(
									InfoSetBO.SET_TYPE_POST)) {
								PostBO pbo = SysCacheTool.findPost((String) key
										.next());
								fkval = pbo.getPostId();
							}

							String[] data = (String[]) (String[]) iterator
									.next();
							for (int i = 0; i < data.length; i++) {
								if (data[i] == null)
									sql.append(",").append(itemId[i])
											.append(" = ").append(data[i]);
								else {
									sql.append(",").append(itemId[i])
											.append(" = '").append(data[i])
											.append("'");
								}
							}
							sql.insert(0, bo.getSetPk() + " = '" + fkval + "'");
							sql.insert(0, "update " + setId + " set ");
							sql.append(" where ID='").append(fkval).append("'");
							batchsql[col] = sql.toString();
							col += 1;
						}
					}
					while ((iterator.hasNext()) && (key.hasNext())) {
						StringBuffer sql = new StringBuffer();
						StringBuffer val = new StringBuffer();
						if (bo.getSet_bType().equals(InfoSetBO.SET_TYPE_ORG)) {
							fkval = ((String) key.next()).split("\\|")[0];
						} else if (bo.getSet_bType().equals(
								InfoSetBO.SET_TYPE_PARTY)) {
							PartyBO pbo = SysCacheTool.findParty((String) key
									.next());
							fkval = pbo.getPartyId();
						} else if (bo.getSet_bType().equals(
								InfoSetBO.SET_TYPE_PERSON)) {
							fkval = ((String) key.next()).split("\\|")[0];
						} else if (bo.getSet_bType().equals(
								InfoSetBO.SET_TYPE_POST)) {
							PostBO pbo = SysCacheTool.findPost((String) key
									.next());
							fkval = pbo.getPostId();
						}

						String[] data = (String[]) (String[]) iterator.next();
						for (int i = 0; i < data.length; i++) {
							sql.append(",").append(itemId[i]);
							if (data[i] == null)
								val.append(",").append(data[i]);
							else {
								val.append(",'").append(data[i]).append("'");
							}
						}
						sql.insert(0, bo.getSetPk() + "," + bo.getSetFk())
								.insert(0, "(").append(")");
						sql.insert(0, "insert into " + setId);
						String pk = SequenceGenerator.getKeyId(setId);
						val.insert(0, "'" + pk + "','" + fkval + "'")
								.insert(0, " values (").append(")");
						batchsql[col] = (sql.toString() + val.toString());
						col += 1;
					}
				}

				this.activepageapi.batchExecuteSql(batchsql);
			}
		} catch (Exception e) {
			throw new RollbackableException("E140004", "导入失败", e, getClass());
		}
	}

	public void updateInfoByCode(String setId, String[] itemId, HashMap value)
			throws SysException {
		try {
			if ((setId != null) && (!setId.equals("")) && (itemId != null)
					&& (itemId.length > 0)) {
				String[] batchsql = new String[value.size()];
				InfoSetBO bo = SysCacheTool.findInfoSet(setId);
				if (bo != null) {
					Iterator iterator = value.values().iterator();
					Iterator key = value.keySet().iterator();
					int col = 0;
					String fkval = "";
					if (bo.getSet_rsType().equals(InfoSetBO.RS_TYPE_SINGLE)) {
						while ((iterator.hasNext()) && (key.hasNext())) {
							StringBuffer sql = new StringBuffer();
							if (bo.getSet_bType()
									.equals(InfoSetBO.SET_TYPE_ORG))
								fkval = ((String) key.next()).split("\\|")[0];
							else if (bo.getSet_bType().equals(
									InfoSetBO.SET_TYPE_PARTY))
								fkval = ((String) key.next()).split("\\|")[0];
							else if (bo.getSet_bType().equals(
									InfoSetBO.SET_TYPE_PERSON))
								fkval = ((String) key.next()).split("\\|")[0];
							else if (bo.getSet_bType().equals(
									InfoSetBO.SET_TYPE_POST)) {
								fkval = ((String) key.next()).split("\\|")[0];
							}

							String[] data = (String[]) (String[]) iterator
									.next();
							for (int i = 0; i < data.length; i++) {
								if (data[i] == null)
									sql.append(",").append(itemId[i])
											.append(" = ").append(data[i]);
								else {
									sql.append(",").append(itemId[i])
											.append(" = '").append(data[i])
											.append("'");
								}
							}
							sql.insert(0, bo.getSetPk() + " = '" + fkval + "'");
							sql.insert(0, "update " + setId + " set ");
							sql.append(" where " + bo.getSetPk() + "='")
									.append(fkval).append("'");
							batchsql[col] = sql.toString();
							col += 1;
						}
					}
					while ((iterator.hasNext()) && (key.hasNext())) {
						StringBuffer sql = new StringBuffer("");
						if (bo.getSet_bType().equals(InfoSetBO.SET_TYPE_ORG)) {
							fkval = ((String) key.next()).split("\\|")[0];
						} else if (bo.getSet_bType().equals(
								InfoSetBO.SET_TYPE_PARTY)) {
							fkval = ((String) key.next()).split("\\|")[0];
						} else if (bo.getSet_bType().equals(
								InfoSetBO.SET_TYPE_PERSON)) {
							fkval = ((String) key.next()).split("\\|")[0];
						} else if (bo.getSet_bType().equals(
								InfoSetBO.SET_TYPE_POST)) {
							PostBO pbo = SysCacheTool.findPost((String) key
									.next());
							fkval = pbo.getPostId();
						}

						String[] data = (String[]) (String[]) iterator.next();
						for (int i = 0; i < data.length; i++) {
							if (sql.length() == 0) {
								sql.append(itemId[i]);
							} else {
								sql.append(",").append(itemId[i]);
							}
							if (data[i] == null)
								sql.append("=").append(data[i]);
							else {
								sql.append("='").append(data[i]).append("'");
							}
						}
						sql.insert(0, "update " + setId + " set ");
						sql.append(" where ").append(bo.getSetFk())
								.append("='").append(fkval).append("'");
						sql.append(" and ").append(bo.getSetId())
								.append("000='00901'");
						batchsql[col] = sql.toString();
						col += 1;
					}
				}

				this.activepageapi.batchExecuteSql(batchsql);
			}
		} catch (Exception e) {
			throw new RollbackableException("E140004", "导入失败", e, getClass());
		}
	}

	public void updateCurSign(String setId, String fk, String[] perId,
			String order) throws SysException {
		if ((setId != null) && (!setId.equals("")) && (perId != null)
				&& (perId.length > 0) && (fk != null) && (!fk.equals(""))) {
			this.activepageapi.batchHandleCurStatus(setId, perId, fk);
		}
	}
}