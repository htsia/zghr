package com.hr319wg.attence.pojo.bo;

public class AttEvcctionRecCollectBO {
	private String evcctionCollectNo; // ��ʾ
	private String evcctionNo;
	private String personID; // ������
	private String personName;
	private String caclDate; // ����ʱ��
	private String beginTime; //���ʼʱ��
	private String endTime; //�������ʱ��
	private String lastDate; //��������
	private String reason; // ����
	private String dest; // Ŀ�ĵ�
	private String flID; // ��������
	private String statusValue; 
	private String superFlId; //�������ͣ�1 ���� 2���� 3 ����

	public String getEvcctionCollectNo() {
		return evcctionCollectNo;
	}
	public void setEvcctionCollectNo(String evcctionCollectNo) {
		this.evcctionCollectNo = evcctionCollectNo;
	}
	public String getEvcctionNo() {
		return evcctionNo;
	}
	public void setEvcctionNo(String evcctionNo) {
		this.evcctionNo = evcctionNo;
	}
	public String getPersonID() {
		return personID;
	}
	public void setPersonID(String personID) {
		this.personID = personID;
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
	public String getPersonName() {
		return personName;
	}
	public void setPersonName(String personName) {
		this.personName = personName;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
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
	
}
