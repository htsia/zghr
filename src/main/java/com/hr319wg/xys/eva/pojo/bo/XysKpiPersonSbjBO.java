package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-13
 * Time: ����4:01
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiPersonSbjBO {
    private String sbjId;
    private String objId;
    private String personId;
    private String score;
    private String gradeItem;
    private String postId;
	private String evaType;
    
    private String isSign;//�Ƿ���
    private String personName;
    private String deptName;
    private String postName;
    
    
    public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getEvaType() {
		return evaType;
	}

	public void setEvaType(String evaType) {
		this.evaType = evaType;
	}

	public String getGradeItem() {
		return gradeItem;
	}

	public void setGradeItem(String gradeItem) {
		this.gradeItem = gradeItem;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
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

	public String getIsSign() {
		return isSign;
	}

	public void setIsSign(String isSign) {
		this.isSign = isSign;
	}

	public String getSbjId() {
        return sbjId;
    }

    public void setSbjId(String sbjId) {
        this.sbjId = sbjId;
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

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }
}
