package com.hr319wg.sys.check;

import java.util.Map;

import com.hr319wg.common.Constants;
import com.hr319wg.custom.util.IDCardUtil;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CommonFuns;

public class A001Check extends AbstractCheck {
	public String doCheck(Map dataMap, String setId) {
		String info = "";
		try {
			String LoginName = CommonFuns.filterNull((String) dataMap.get("LoginName"));
			String orgId = CommonFuns.filterNull((String) dataMap.get("A001701"));
			String deptId = CommonFuns.filterNull((String) dataMap.get("A001705"));
			String A001735 = CommonFuns.filterNull((String) dataMap.get("A001735"));
			String A001077 = CommonFuns.filterNull((String) dataMap.get("A001077"));
			String A001011 = CommonFuns.filterNull((String) dataMap.get("A001011"));
			String A001007 = CommonFuns.filterNull((String) dataMap.get("A001007"));
			String id = CommonFuns.filterNull((String) dataMap.get("ID"));
			String perType = CommonFuns.filterNull((String) dataMap.get("A001054"));

			if (!"".equals(LoginName)) {
				int count = 0;
				if ((id != null) && (!"".equals(id))) {
					count = this.api.queryForInt("select count(*) from sys_user_info where login_name='" + LoginName + "' and person_id<>'" + id + "'");
				} else {
					count = this.api.queryForInt("select count(*) from sys_user_info where login_name='" + LoginName + "'");
				}
				if (count > 0) {
					info = info + "��¼���ظ���\n";
				}
			}

			String partyDate = CommonFuns.filterNull((String) dataMap.get("A001718"));
			String party = CommonFuns.filterNull((String) dataMap.get("A001009"));
			if ((partyDate != null) && (partyDate.length() > 4)) {
				partyDate = partyDate.substring(0, 4);
				if ((party != null) && (party.length() > 4)) {
					party = party.substring(4);
					if ((partyDate.equals(CommonFuns.getSysDate("yyyy"))) && (!party.equals("02"))) {
						info = info + "�μӵ���ʱ��Ϊ���꣬��ʱ������òӦ��ΪԤ����Ա��\n";
					}
				}
			}

			if ((party != null) && (party.length() > 4)) {
				party = party.substring(4);
				if (((party.equals("12")) || (party.equals("13"))) && (!"".equals(partyDate.trim()))) {
					info = info + "������òΪȺ�ڻ��޵��ɣ��μӵ���ʱ��ز��\n";
				}
			}

			String birthDate = CommonFuns.filterNull((String) dataMap.get("A001011"));
			if ((birthDate != null) && (birthDate.length() > 4)) {
				int birth = Integer.parseInt(birthDate.substring(0, 4));
				if ((partyDate != null) && (partyDate.length() > 4)) {
					int partyYear = Integer.parseInt(partyDate.substring(0, 4));
					if (partyYear - birth < 10) {
						info = info + "�μӵ���ʱ�������ڳ�������10�꣡\n";
					}
				}
			}

			String workDate = CommonFuns.filterNull((String) dataMap.get("A001041"));
			if ((birthDate != null) && (birthDate.length() > 4) && ("1".equals(Constants.EMP_CHECK_WORKDATE))) {
				int birth = Integer.parseInt(birthDate.substring(0, 4));
				if ((workDate != null) && (workDate.length() > 4)) {
					int workYear = Integer.parseInt(workDate.substring(0, 4));
					if (workYear - birth < 10) {
						info = info + "�μӹ���ʱ�������ڳ�������10�꣡\n";
					}
				}

			}

			String sysDate = CommonFuns.filterNull((String) dataMap.get("A001044"));
			if ((workDate != null) && (!"".equals(workDate)) && (sysDate != null) && (!"".equals(sysDate)) && ("1".equals(Constants.EMP_CHECK_WORKDATE)) && (CommonFuns.betweenDaysSix(workDate, sysDate) < 0)) {
				info = info + "���뱾��λʱ�������ڵ��ڲμӹ���ʱ�䣡\n";
			}

			String unitDate = CommonFuns.filterNull((String) dataMap.get("A001781"));
			if ((workDate != null) && (!"".equals(workDate)) && (unitDate != null) && (!"".equals(unitDate)) && ("1".equals(Constants.EMP_CHECK_WORKDATE)) && (CommonFuns.betweenDaysSix(workDate, unitDate) < 0)) {
				info = info + "���뱾ϵͳʱ�������ڵ��ڲμӹ���ʱ�䣡\n";
			}

			InfoItemBO ib = SysCacheTool.findInfoItem("", "A001735");
			if ((ib != null) && ("1".equals(ib.getItemIsunique())) && (!"".equals(A001735.trim())) && (!"".equals(A001735))) {
				int count = 0;
				if ((id != null) && (!"".equals(id))) {
					count = this.api.queryForInt("SELECT COUNT(A001735) FROM A001 WHERE A001735 = '" + A001735 + "' AND ID <> '" + id + "'");
				} else {
					count = this.api.queryForInt("SELECT COUNT(A001735) FROM A001 WHERE A001735 = '" + A001735 + "'");
				}
				if (count > 0) {
					info = info + "Ա������ظ���\n";
				}

			}

			if (A001077 != null && !"".equals(A001077)) {
				if ("1".equals(Constants.EMP_CHECK_18ID)) {
					boolean pass = IDCardUtil.validateCard(A001077);
					if (!pass) {
						info = info + "���������֤����!\n";
					}
				}

				if ((id == null) || ((!id.startsWith("@")) && (!id.startsWith("#")))) {
					ib = SysCacheTool.findInfoItem("", "A001077");
					if ((ib != null) && ("1".equals(ib.getItemIsunique()))) {
						int count = 0;
						if ((id != null) && (!"".equals(id))) {
							count = this.api.queryForInt("SELECT COUNT(A001077) FROM A001 WHERE A001077 = '" + A001077 + "'  AND ID <> '" + id + "' AND ID NOT like '@%' AND ID NOT LIKE '#%'");
						} else {
							count = this.api.queryForInt("SELECT COUNT(A001077) FROM A001 WHERE A001077 = '" + A001077 + "'");
						}
						if (count > 0) {
							info = info + "���֤�ظ���\n";
						}
					}
				}
			}
		} catch (Exception e) {
		}
		return info;
	}
}