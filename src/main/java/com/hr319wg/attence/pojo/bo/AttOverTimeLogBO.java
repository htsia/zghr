package com.hr319wg.attence.pojo.bo;

public class AttOverTimeLogBO {
	private String overTimeLogNO; // ��ʾ
	private String personID; // �Ӱ���
	private String personName;
	private String seqName;
	private String orgID;
	private String applyDate; // ����ʱ��
	private String beginTime; // ��ʼʱ��
	private String endTime; // ����ʱ��
	private String lastDate; //�Ӱ�����
	private String process; //0  δ����  1  ȷ�ϼӰ�  2 ȷ�ϷǼӰ�
	private String typeStatus; //1 ��ʱ�Ӱ� 2 ˫���ռӰ� 3�ڼ��ռӰ�
	private String typeStatusName;
	public String getOverTimeLogNO() {
		return overTimeLogNO;
	}
	public void setOverTimeLogNO(String overTimeLogNO) {
		this.overTimeLogNO = overTimeLogNO;
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
	public String getSeqName() {
		return seqName;
	}
	public void setSeqName(String seqName) {
		this.seqName = seqName;
	}
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
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
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getTypeStatus() {
		return typeStatus;
	}
	public void setTypeStatus(String typeStatus) {
		this.typeStatus = typeStatus;
	}
	public String getTypeStatusName() {
		return typeStatusName;
	}
	public void setTypeStatusName(String typeStatusName) {
		this.typeStatusName = typeStatusName;
	}
	
}
