package com.hr319wg.attence.pojo.bo;

public class AttEvcctionRecBO {
	private String evcctionNO; // ��ʾ
	private String personID; // �����
	private String personName;
	private String orgID;
	private String applyDate; // ����ʱ��
	private String beginTime; // �ٿ�ʼʱ��
	private String endTime; // �ٽ���ʱ��
	private String reason; // ����
	private String dest; // Ŀ�ĵ�
	private String deptAuditResult; // �������
	private String deptAuditOper; // ����������
	private String deptAuditDate; // ��������ʱ��
	private String deptAuditCause; // ��������˵��
	private String deptAuditCausevalue;
	private String leaderAuditResult; // �쵼���
	private String leaderAuditOper; // ������
	private String leaderAuditDate; // ��������
	private String leaderAuditCause; // ����˵��
	private String leaderAuditCausevalue;
	private String hrAuditResult; // HR���
	private String hrAuditOper; // HR������
	private String hrAuditDate; // HR����ʱ��
	private String hrAuditCause; // HR����˵��
	private String hrAuditResultvalue;
	private String hileaderAuditResult; // �ܼ����
	private String hileaderAuditOper; // �ܼ�������
	private String hileaderAuditDate; // �ܼ�����ʱ��
	private String hileaderAuditCause; // �ܼ�����˵��
	private String hileaderAuditResultvalue;
	private String manAuditResult; // �ܾ������
	private String manAuditOper; // �ܾ���������
	private String manAuditDate; // �ܾ�������ʱ��
	private String manAuditCause; // �ܾ�������˵��
	private String manAuditResultvalue;
	private String lastDate; //��������
	private String statusValue; //����״ֵ̬ 0���� 1����ͨ�� 2�˻�
	private String flagvalue;
	private String superFurloughNo; //ԭʼ��ټ�¼IDֵ
	private String superFlId; //������ͣ�1 ��� 2���� 3 ����
	private String superFlIdName;
	private String evcctionCollectNo;
    private String personGroupID;
    private String personGroupIDName;
    private String evcctionType;
    private String evcctionTypeName;
    private String statusValueName;
    
	public String getEvcctionNO() {
		return evcctionNO;
	}

	public void setEvcctionNO(String evcctionNO) {
		this.evcctionNO = evcctionNO;
	}

	public String getPersonID() {
		return personID;
	}

	public void setPersonID(String personID) {
		this.personID = personID;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getDest() {
		return dest;
	}

	public void setDest(String dest) {
		this.dest = dest;
	}

	public String getDeptAuditResult() {
		return deptAuditResult;
	}

	public void setDeptAuditResult(String deptAuditResult) {
		this.deptAuditResult = deptAuditResult;
	}

	public String getDeptAuditOper() {
		return deptAuditOper;
	}

	public void setDeptAuditOper(String deptAuditOper) {
		this.deptAuditOper = deptAuditOper;
	}

	public String getDeptAuditDate() {
		return deptAuditDate;
	}

	public void setDeptAuditDate(String deptAuditDate) {
		this.deptAuditDate = deptAuditDate;
	}

	public String getDeptAuditCause() {
		return deptAuditCause;
	}

	public void setDeptAuditCause(String deptAuditCause) {
		this.deptAuditCause = deptAuditCause;
	}

	public String getDeptAuditCausevalue() {
		return deptAuditCausevalue;
	}

	public void setDeptAuditCausevalue(String deptAuditCausevalue) {
		this.deptAuditCausevalue = deptAuditCausevalue;
	}

	public String getLeaderAuditResult() {
		return leaderAuditResult;
	}

	public void setLeaderAuditResult(String leaderAuditResult) {
		this.leaderAuditResult = leaderAuditResult;
	}

	public String getLeaderAuditOper() {
		return leaderAuditOper;
	}

	public void setLeaderAuditOper(String leaderAuditOper) {
		this.leaderAuditOper = leaderAuditOper;
	}

	public String getLeaderAuditDate() {
		return leaderAuditDate;
	}

	public void setLeaderAuditDate(String leaderAuditDate) {
		this.leaderAuditDate = leaderAuditDate;
	}

	public String getLeaderAuditCause() {
		return leaderAuditCause;
	}

	public void setLeaderAuditCause(String leaderAuditCause) {
		this.leaderAuditCause = leaderAuditCause;
	}

	public String getHrAuditResult() {
		return hrAuditResult;
	}

	public void setHrAuditResult(String hrAuditResult) {
		this.hrAuditResult = hrAuditResult;
	}

	public String getHrAuditOper() {
		return hrAuditOper;
	}

	public void setHrAuditOper(String hrAuditOper) {
		this.hrAuditOper = hrAuditOper;
	}

	public String getHrAuditDate() {
		return hrAuditDate;
	}

	public void setHrAuditDate(String hrAuditDate) {
		this.hrAuditDate = hrAuditDate;
	}

	public String getHrAuditCause() {
		return hrAuditCause;
	}

	public void setHrAuditCause(String hrAuditCause) {
		this.hrAuditCause = hrAuditCause;
	}

	public String getFlagvalue() {
		return flagvalue;
	}

	public void setFlagvalue(String flagvalue) {
		this.flagvalue = flagvalue;
	}

	public String getLeaderAuditCausevalue() {
		return leaderAuditCausevalue;
	}

	public void setLeaderAuditCausevalue(String leaderAuditCausevalue) {
		this.leaderAuditCausevalue = leaderAuditCausevalue;
	}

	public String getHrAuditResultvalue() {
		return hrAuditResultvalue;
	}

	public void setHrAuditResultvalue(String hrAuditResultvalue) {
		this.hrAuditResultvalue = hrAuditResultvalue;
	}

	public String getHileaderAuditResult() {
		return hileaderAuditResult;
	}

	public void setHileaderAuditResult(String hileaderAuditResult) {
		this.hileaderAuditResult = hileaderAuditResult;
	}

	public String getHileaderAuditOper() {
		return hileaderAuditOper;
	}

	public void setHileaderAuditOper(String hileaderAuditOper) {
		this.hileaderAuditOper = hileaderAuditOper;
	}

	public String getHileaderAuditDate() {
		return hileaderAuditDate;
	}

	public void setHileaderAuditDate(String hileaderAuditDate) {
		this.hileaderAuditDate = hileaderAuditDate;
	}

	public String getHileaderAuditCause() {
		return hileaderAuditCause;
	}

	public void setHileaderAuditCause(String hileaderAuditCause) {
		this.hileaderAuditCause = hileaderAuditCause;
	}

	public String getHileaderAuditResultvalue() {
		return hileaderAuditResultvalue;
	}

	public void setHileaderAuditResultvalue(String hileaderAuditResultvalue) {
		this.hileaderAuditResultvalue = hileaderAuditResultvalue;
	}

	public String getManAuditResult() {
		return manAuditResult;
	}

	public void setManAuditResult(String manAuditResult) {
		this.manAuditResult = manAuditResult;
	}

	public String getManAuditOper() {
		return manAuditOper;
	}

	public void setManAuditOper(String manAuditOper) {
		this.manAuditOper = manAuditOper;
	}

	public String getManAuditDate() {
		return manAuditDate;
	}

	public void setManAuditDate(String manAuditDate) {
		this.manAuditDate = manAuditDate;
	}

	public String getManAuditCause() {
		return manAuditCause;
	}

	public void setManAuditCause(String manAuditCause) {
		this.manAuditCause = manAuditCause;
	}

	public String getManAuditResultvalue() {
		return manAuditResultvalue;
	}

	public void setManAuditResultvalue(String manAuditResultvalue) {
		this.manAuditResultvalue = manAuditResultvalue;
	}

	public String getLastDate() {
		return lastDate;
	}

	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}

	public String getStatusValue() {
		return statusValue;
	}

	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getSuperFurloughNo() {
		return superFurloughNo;
	}

	public void setSuperFurloughNo(String superFurloughNo) {
		this.superFurloughNo = superFurloughNo;
	}

	public String getSuperFlId() {
		return superFlId;
	}

	public void setSuperFlId(String superFlId) {
		this.superFlId = superFlId;
	}

	public String getSuperFlIdName() {
		return superFlIdName;
	}

	public void setSuperFlIdName(String superFlIdName) {
		this.superFlIdName = superFlIdName;
	}

	public String getEvcctionCollectNo() {
		return evcctionCollectNo;
	}

	public void setEvcctionCollectNo(String evcctionCollectNo) {
		this.evcctionCollectNo = evcctionCollectNo;
	}

	public String getPersonGroupID() {
		return personGroupID;
	}

	public void setPersonGroupID(String personGroupID) {
		this.personGroupID = personGroupID;
	}

	public String getPersonGroupIDName() {
		return personGroupIDName;
	}

	public void setPersonGroupIDName(String personGroupIDName) {
		this.personGroupIDName = personGroupIDName;
	}

	public String getEvcctionType() {
		return evcctionType;
	}

	public void setEvcctionType(String evcctionType) {
		this.evcctionType = evcctionType;
	}

	public String getEvcctionTypeName() {
		return evcctionTypeName;
	}

	public void setEvcctionTypeName(String evcctionTypeName) {
		this.evcctionTypeName = evcctionTypeName;
	}

	public String getStatusValueName() {
		return statusValueName;
	}

	public void setStatusValueName(String statusValueName) {
		this.statusValueName = statusValueName;
	}



}
