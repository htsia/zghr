package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-12
 * Time: ����1:18
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiDeptObjBO {
    private String objId;
    private String personId;
    private String planId;
    private String score;
    private String keyStatus; //ָ��״̬��1����2����3��׼F�˻أ�
    private String deptId;
    private String gradeStatus;//��ʼ���ʱ���ɵļ������ʶ��(0���Դ��1���ܴ��)
    private String scoreLeader;
    private String scorePreLeader;
    private String scoreOtherLeader;
    private String scoreError;//�����Ƿ��쳣��0��1�ǣ�
    private String gradeItem;//���˵ȼ�
    private String scoreSort;
    private String postId;

    private String postName;
    private String personName;
    private String deptName;
    private String planName;
    private String year;
    private String allCount;//������
    private String signCount;//�������
    private String noSignCount;//δ�������
    private String selfGrade;//1��������2������
    
    
    public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getScoreSort() {
		return scoreSort;
	}

	public void setScoreSort(String scoreSort) {
		this.scoreSort = scoreSort;
	}

	public String getGradeItem() {
		return gradeItem;
	}

	public void setGradeItem(String gradeItem) {
		this.gradeItem = gradeItem;
	}

	public String getScoreLeader() {
		return scoreLeader;
	}

	public void setScoreLeader(String scoreLeader) {
		this.scoreLeader = scoreLeader;
	}

	public String getScorePreLeader() {
		return scorePreLeader;
	}

	public void setScorePreLeader(String scorePreLeader) {
		this.scorePreLeader = scorePreLeader;
	}

	public String getScoreOtherLeader() {
		return scoreOtherLeader;
	}

	public void setScoreOtherLeader(String scoreOtherLeader) {
		this.scoreOtherLeader = scoreOtherLeader;
	}

	public String getScoreError() {
		return scoreError;
	}

	public void setScoreError(String scoreError) {
		this.scoreError = scoreError;
	}

	public String getSelfGrade() {
		return selfGrade;
	}

	public void setSelfGrade(String selfGrade) {
		this.selfGrade = selfGrade;
	}
    
    public String getGradeStatus() {
		return gradeStatus;
	}

	public void setGradeStatus(String gradeStatus) {
		this.gradeStatus = gradeStatus;
	}

	public String getAllCount() {
		return allCount;
	}

	public void setAllCount(String allCount) {
		this.allCount = allCount;
	}

	public String getSignCount() {
		return signCount;
	}

	public void setSignCount(String signCount) {
		this.signCount = signCount;
	}

	public String getNoSignCount() {
		return noSignCount;
	}

	public void setNoSignCount(String noSignCount) {
		this.noSignCount = noSignCount;
	}

	public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getObjId() {
        return objId;
    }

    public void setObjId(String objId) {
        this.objId = objId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getKeyStatus() {
        return keyStatus;
    }

    public void setKeyStatus(String keyStatus) {
        this.keyStatus = keyStatus;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }
}
