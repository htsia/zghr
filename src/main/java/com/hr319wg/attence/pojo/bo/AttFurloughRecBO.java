package com.hr319wg.attence.pojo.bo;

public class AttFurloughRecBO {
	private String furloughNO; // ��ʾ
	private String personID; // �����
	private String personName;
	private String orgID;
	private String applyDate; // ����ʱ��
	private String beginTime; // �ٿ�ʼʱ��
	private String endTime; // �ٽ���ʱ��
	private String flID; // ��������
	private String flName;
	private String reason; // ����
	
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
	
	private String  zjAuditResult; // �ܼ����
	private String zjAuditOper; // �ܼ�������
	private String zjAuditDate; // �ܼ�����ʱ��
	private String zjAuditCause; // �ܼ�����˵��
	private String zjAuditResultvalue;
	
	private String  zjlAuditResult; // �ܾ������
	private String zjlAuditOper; // �ܾ���������
	private String zjlAuditDate; // �ܾ�������ʱ��
	private String zjlAuditCause; // �ܾ�������˵��
	private String zjlAuditResultvalue;
	
	
	
	private String lastDate; //�������
	//����״ֵ̬��
	//0����  ֻ��������ʼ�ڵ�
	//1��׼
	//2�˻�
	//3����ͨ��  ֻ�����ڽ����ڵ�  ���ڱ�ʾ�������ͨ�� 
	private String statusValue; 
	private String flagvalue;
	private String superFurloughNo; //ԭʼ��ټ�¼IDֵ
	private String superFlId; //������ͣ�1 ��� 2���� 3 ����
	private String superFlIdName;
	private String flagValues; //0 ��ʾ��ʷ��¼ 1��ʾ�鿴����
	private String furloughCollectNO;
	private String flIdProcess;//�������
	private String flIdProcessName;
	private String flIdStatus;//�Ƿ��ύ���֤������  0 �� 1 ��
	private String flIdStatusName;
    private String statusValueName;
    
	public String getFurloughNO() {
		return furloughNO;
	}

	public void setFurloughNO(String furloughNO) {
		this.furloughNO = furloughNO;
	}

	public String getPersonID() {
		return personID;
	}

	public void setPersonID(String personID) {
		this.personID = personID;
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

	public String getFlID() {
		return flID;
	}

	public void setFlID(String flID) {
		this.flID = flID;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
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

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getFlagvalue() {
		return flagvalue;
	}

	public void setFlagvalue(String flagvalue) {
		this.flagvalue = flagvalue;
	}

	public String getFlName() {
		return flName;
	}

	public void setFlName(String flName) {
		this.flName = flName;
	}

	public String getDeptAuditCausevalue() {
		return deptAuditCausevalue;
	}

	public void setDeptAuditCausevalue(String deptAuditCausevalue) {
		this.deptAuditCausevalue = deptAuditCausevalue;
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

	public String getFlagValues() {
		return flagValues;
	}

	public void setFlagValues(String flagValues) {
		this.flagValues = flagValues;
	}

	public String getFurloughCollectNO() {
		return furloughCollectNO;
	}

	public void setFurloughCollectNO(String furloughCollectNO) {
		this.furloughCollectNO = furloughCollectNO;
	}

	public String getFlIdProcess() {
		return flIdProcess;
	}

	public void setFlIdProcess(String flIdProcess) {
		this.flIdProcess = flIdProcess;
	}

	public String getFlIdStatus() {
		return flIdStatus;
	}

	public void setFlIdStatus(String flIdStatus) {
		this.flIdStatus = flIdStatus;
	}

	public String getFlIdProcessName() {
		return flIdProcessName;
	}

	public void setFlIdProcessName(String flIdProcessName) {
		this.flIdProcessName = flIdProcessName;
	}

	public String getFlIdStatusName() {
		return flIdStatusName;
	}

	public void setFlIdStatusName(String flIdStatusName) {
		this.flIdStatusName = flIdStatusName;
	}

	public String getZjAuditResult() {
		return zjAuditResult;
	}

	public void setZjAuditResult(String zjAuditResult) {
		this.zjAuditResult = zjAuditResult;
	}

	public String getZjAuditOper() {
		return zjAuditOper;
	}

	public void setZjAuditOper(String zjAuditOper) {
		this.zjAuditOper = zjAuditOper;
	}

	public String getZjAuditDate() {
		return zjAuditDate;
	}

	public void setZjAuditDate(String zjAuditDate) {
		this.zjAuditDate = zjAuditDate;
	}

	public String getZjAuditCause() {
		return zjAuditCause;
	}

	public void setZjAuditCause(String zjAuditCause) {
		this.zjAuditCause = zjAuditCause;
	}

	public String getZjAuditResultvalue() {
		return zjAuditResultvalue;
	}

	public void setZjAuditResultvalue(String zjAuditResultvalue) {
		this.zjAuditResultvalue = zjAuditResultvalue;
	}

	public String getZjlAuditResult() {
		return zjlAuditResult;
	}

	public void setZjlAuditResult(String zjlAuditResult) {
		this.zjlAuditResult = zjlAuditResult;
	}

	public String getZjlAuditOper() {
		return zjlAuditOper;
	}

	public void setZjlAuditOper(String zjlAuditOper) {
		this.zjlAuditOper = zjlAuditOper;
	}

	public String getZjlAuditDate() {
		return zjlAuditDate;
	}

	public void setZjlAuditDate(String zjlAuditDate) {
		this.zjlAuditDate = zjlAuditDate;
	}

	public String getZjlAuditCause() {
		return zjlAuditCause;
	}

	public void setZjlAuditCause(String zjlAuditCause) {
		this.zjlAuditCause = zjlAuditCause;
	}

	public String getZjlAuditResultvalue() {
		return zjlAuditResultvalue;
	}

	public void setZjlAuditResultvalue(String zjlAuditResultvalue) {
		this.zjlAuditResultvalue = zjlAuditResultvalue;
	}

	public String getStatusValueName() {
		return statusValueName;
	}

	public void setStatusValueName(String statusValueName) {
		this.statusValueName = statusValueName;
	}




}
