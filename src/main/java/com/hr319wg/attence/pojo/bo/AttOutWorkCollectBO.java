package com.hr319wg.attence.pojo.bo;

public class AttOutWorkCollectBO {
	private String outWorkCollectNo; // ��ʾ
	private String outWorkNo;
	private String personID; // ������
	private String caclDate; // ����ʱ��
	private String beginTime; //���ʼʱ��
	private String endTime; //�������ʱ��
	private String flID; // ��������
	private String statusValue; 
	private String superFlId; //�������ͣ�1 ���� 2���� 3 ����

    private String lastDate;
    private String reason;
    private String dest;

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

    public String getOutWorkCollectNo() {
		return outWorkCollectNo;
	}
	public void setOutWorkCollectNo(String outWorkCollectNo) {
		this.outWorkCollectNo = outWorkCollectNo;
	}
	public String getOutWorkNo() {
		return outWorkNo;
	}
	public void setOutWorkNo(String outWorkNo) {
		this.outWorkNo = outWorkNo;
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
	
	
}
