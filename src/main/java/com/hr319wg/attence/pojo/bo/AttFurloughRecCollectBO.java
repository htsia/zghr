package com.hr319wg.attence.pojo.bo;

public class AttFurloughRecCollectBO {
	private String furloughCollectNO; // ��ʾ
	private String furloughNO;
	private String personID; // �����
	private String personName;
	private String personSeq;
	private String orgName;
	private String deptName;
	private String caclDate; // ����ʱ��
	private String beginTime; // �ٿ�ʼʱ��
	private String endTime; // �ٽ���ʱ��
	private String flID; // ��������
	private String flName;
	private String statusValue; 
	private String superFlId; //������ͣ�1 ��� 2���� 3 ����
	private String flIdProcess;//�������
	private String flIdProcessName;
	private String flIdStatus;//�Ƿ��ύ���֤������  0 �� 1 ��
	private String flIdStatusName;
    private String lastDate;
    private String reason;

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getLastDate() {
        return lastDate;
    }

    public void setLastDate(String lastDate) {
        this.lastDate = lastDate;
    }

	public String getFurloughCollectNO() {
		return furloughCollectNO;
	}
	public void setFurloughCollectNO(String furloughCollectNO) {
		this.furloughCollectNO = furloughCollectNO;
	}
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
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getPersonSeq() {
		return personSeq;
	}
	public void setPersonSeq(String personSeq) {
		this.personSeq = personSeq;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getCaclDate() {
		return caclDate;
	}
	public void setCaclDate(String caclDate) {
		this.caclDate = caclDate;
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
	public String getFlName() {
		return flName;
	}
	public void setFlName(String flName) {
		this.flName = flName;
	}
	public String getStatusValue() {
		return statusValue;
	}
	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}
	public String getSuperFlId() {
		return superFlId;
	}
	public void setSuperFlId(String superFlId) {
		this.superFlId = superFlId;
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
	
}
