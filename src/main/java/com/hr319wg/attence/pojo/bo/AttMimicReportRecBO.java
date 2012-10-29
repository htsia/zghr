package com.hr319wg.attence.pojo.bo;

public class AttMimicReportRecBO {
    public static final String  APPROVING="0";
    public static final String  APPROVED="1";
    public static final String  REFUSED="2";

	private String mimicReportNO; // ��ʾ
	private String personID; // �����
	private String personName;
	private String orgID;
	private String mrYear; // �ⶨ�ݼ���� �磺2011
	private String mrMonth; // �ⶨ�ݼ�ʱ�� �磺2011-01,2011-02
	private String applyDate; // ����ʱ��
	private String dest; // Ŀ�ĵ�
	private String lastDate; //Ӧ�������ݼ٣��죩
	private String deptAuditResult; // �������
	private String deptAuditOper; // ����������
	private String deptAuditDate; // ��������ʱ��
	private String deptAuditCause; // ��������˵��
	private String deptAuditCausevalue;
	private String leaderAuditResult; // �����쵼���
	private String leaderAuditOper; // ����������
	private String leaderAuditDate; // ������������
	private String leaderAuditCause; // ��������˵��
	private String leaderAuditCausevalue;
	private String hrAuditResult; // HR������Դ����Ա���
	private String hrAuditOper; // HR������Դ����Ա������
	private String hrAuditDate; // HR������Դ����Ա����ʱ��
	private String hrAuditCause; // HR������Դ����Ա����˵��
	private String hrAuditResultvalue;
	private String hrDeptAuditResult; // HR������Դ�������
	private String hrDeptAuditOper; // HR������Դ����������
	private String hrDeptAuditDate; // HR������Դ��������ʱ��
	private String hrDeptAuditCause; // HR������Դ��������˵��
	private String hrDeptAuditCausevalue;
	private String hrLeaderAuditResult; // HR������Դ�����쵼���
	private String hrLeaderAuditOper; // HR������Դ����������
	private String hrLeaderAuditDate; // HR������Դ������������
	private String hrLeaderAuditCause; // HR������Դ��������˵��
	private String hrLeaderAuditCausevalue;
	private String manAuditResult; // �ܾ������
	private String manAuditOper; // �ܾ���������
	private String manAuditDate; // �ܾ�������ʱ��
	private String manAuditCause; // �ܾ�������˵��
	private String manAuditResultvalue;
	private String statusValue; //����״ֵ̬ 0���� 1����ͨ�� 2�˻�
	private String flagvalue;

    private String statusDes;

    public String getStatusDes() {
        if(APPROVING.equals(statusValue)){
             statusDes="����";
        }else if(APPROVED.equals(statusValue)){
             statusDes="��׼";
        }else if(REFUSED.equals(statusValue)){
             statusDes="�˻�";
        }else{
             statusDes="�ⶨ";
        }
        return statusDes;
    }

    public void setStatusDes(String statusDes) {
        this.statusDes = statusDes;
    }

    public String getMimicReportNO() {
		return mimicReportNO;
	}
	public void setMimicReportNO(String mimicReportNO) {
		this.mimicReportNO = mimicReportNO;
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
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}
	public String getMrYear() {
		return mrYear;
	}
	public void setMrYear(String mrYear) {
		this.mrYear = mrYear;
	}
	public String getMrMonth() {
		return mrMonth;
	}
	public void setMrMonth(String mrMonth) {
		this.mrMonth = mrMonth;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getDest() {
		return dest;
	}
	public void setDest(String dest) {
		this.dest = dest;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
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
	public String getLeaderAuditCausevalue() {
		return leaderAuditCausevalue;
	}
	public void setLeaderAuditCausevalue(String leaderAuditCausevalue) {
		this.leaderAuditCausevalue = leaderAuditCausevalue;
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
	public String getHrAuditResultvalue() {
		return hrAuditResultvalue;
	}
	public void setHrAuditResultvalue(String hrAuditResultvalue) {
		this.hrAuditResultvalue = hrAuditResultvalue;
	}
	public String getHrDeptAuditResult() {
		return hrDeptAuditResult;
	}
	public void setHrDeptAuditResult(String hrDeptAuditResult) {
		this.hrDeptAuditResult = hrDeptAuditResult;
	}
	public String getHrDeptAuditOper() {
		return hrDeptAuditOper;
	}
	public void setHrDeptAuditOper(String hrDeptAuditOper) {
		this.hrDeptAuditOper = hrDeptAuditOper;
	}
	public String getHrDeptAuditDate() {
		return hrDeptAuditDate;
	}
	public void setHrDeptAuditDate(String hrDeptAuditDate) {
		this.hrDeptAuditDate = hrDeptAuditDate;
	}
	public String getHrDeptAuditCause() {
		return hrDeptAuditCause;
	}
	public void setHrDeptAuditCause(String hrDeptAuditCause) {
		this.hrDeptAuditCause = hrDeptAuditCause;
	}
	public String getHrDeptAuditCausevalue() {
		return hrDeptAuditCausevalue;
	}
	public void setHrDeptAuditCausevalue(String hrDeptAuditCausevalue) {
		this.hrDeptAuditCausevalue = hrDeptAuditCausevalue;
	}
	public String getHrLeaderAuditResult() {
		return hrLeaderAuditResult;
	}
	public void setHrLeaderAuditResult(String hrLeaderAuditResult) {
		this.hrLeaderAuditResult = hrLeaderAuditResult;
	}
	public String getHrLeaderAuditOper() {
		return hrLeaderAuditOper;
	}
	public void setHrLeaderAuditOper(String hrLeaderAuditOper) {
		this.hrLeaderAuditOper = hrLeaderAuditOper;
	}
	public String getHrLeaderAuditDate() {
		return hrLeaderAuditDate;
	}
	public void setHrLeaderAuditDate(String hrLeaderAuditDate) {
		this.hrLeaderAuditDate = hrLeaderAuditDate;
	}
	public String getHrLeaderAuditCause() {
		return hrLeaderAuditCause;
	}
	public void setHrLeaderAuditCause(String hrLeaderAuditCause) {
		this.hrLeaderAuditCause = hrLeaderAuditCause;
	}
	public String getHrLeaderAuditCausevalue() {
		return hrLeaderAuditCausevalue;
	}
	public void setHrLeaderAuditCausevalue(String hrLeaderAuditCausevalue) {
		this.hrLeaderAuditCausevalue = hrLeaderAuditCausevalue;
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
	public String getStatusValue() {
		return statusValue;
	}
	public void setStatusValue(String statusValue) {
		this.statusValue = statusValue;
	}
	public String getFlagvalue() {
		return flagvalue;
	}
	public void setFlagvalue(String flagvalue) {
		this.flagvalue = flagvalue;
	}
	
}
