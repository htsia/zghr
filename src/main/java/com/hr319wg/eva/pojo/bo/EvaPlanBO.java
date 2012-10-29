package com.hr319wg.eva.pojo.bo;


public class EvaPlanBO {
    // 0 ��� 1 ���� 2 ��׼ 3ִ�� 4 �������5 ���������׼6����7�˻�
    public final static String EVA_PLANSTATUS_SCRIPT = "0";
    public final static String EVA_PLANSTATUS_APPROVING = "1";
    public final static String EVA_PLANSTATUS_APPROVED = "2";
    public final static String EVA_PLANSTATUS_EXECUTE = "3";
    public final static String EVA_PLANSTATUS_AppovResult="4";
    public final static String EVA_PLANSTATUS_FINISH= "6";
    public final static String EVA_PLANSTATUS_AppovResultED="5";
    public final static String EVA_PLANSTATUS_MODFIY="7";
    
    // 0 ���� 1 ������������
    public final static String EVA_PRUVIEW_PERSON = "0";    
    public final static String EVA_PRUVIEW_GROUP = "1";
    //0������ģ��1��λ����ģ��2���񿼺�
    public final static String EVA_MODEL_TABLE="0";
    public final static String EVA_MODEL_POST="1";
    public final static String EVA_MODEL_TASK="2";
    public final static String EVA_MODEL_ELECTION="3";
    
    //���˿�������0����1����2�Ŷ�
    public final static String OBJCT_TYPE_PERSON="0";
    public final static String OBJCT_TYPE_DEPT="1";
    public final static String OBJCT_TYPE_TEAM="2";
    
    //�������λ��0����1һλС��2��λС��
    public final static String EVA_CACL_PERS_INT="0";
    public final static String EVA_CACL_PERS_ONEDEC="1";
    public final static String EVA_CACL_PERS_TWODEC="2";
    public final static String EVA_CACL_PERS_THREEDEC="3";
    
    //Ȩ�ر���λ��0����1һλС��2��λС��
    public final static String EVA_Level_PERS_INT="0";
    public final static String EVA_Level_PERS_ONEDEC="1";
    public final static String EVA_Level_PERS_TWODEC="2";
    public final static String EVA_Level_PERS_THREEDEC="3";

    private String planId;//  �ƻ�ID
	private String planName;   //�ƻ�����
	private String orgId;  //  �������ID
	private String orgName; //      �����������
    private String planDate;
    private String beginDate;
	private String endDate;    //������ֹ����
    private String description;
    private String templates;
    private String templatesDes;
    private String createPersonId;
    private String createPersonName;
    private String createDate;
    private String aduitPersonId;
    private String aduitDate;
    private String aduitContent;
    private String aduitResult;
    private String status;
    private String statusDes;
    private String planType;
    private String evaMethod;
    private String pruview;
    private String planGrade;
    private String planGradeName;
    private String evaModel;
    private String resultAuditExplain;
    private String resultAuditResult;
    private String resultAuditPerson;
    private String resultAuditDate;
	private String evaModelDes;
	private String evaFile;
	private String haveEvaFile;
	private String evaFileBull;
	private String planObjectType;
	private String objectTypeDes;
	private String hasSendBull;
	private String scorePers;
	private String levelPers;
	private String scorePersDes;
	private String levelPersDes;
	private String allowMark;//0���ܴ��1���
	private String isVirtual;
	private String notShowPercent;
	private String notShowHr;
	private String gradeString;

    private String showWorkSum;//�Ƿ�¼���ܽ�0��,1��
    private String caclMode; //����ģʽ��0Ĭ�ϼ���ģʽ,1���ü���ģʽ

    public String getCaclMode() {
        return caclMode;
    }

    public void setCaclMode(String caclMode) {
        this.caclMode = caclMode;
    }

    public String getShowWorkSum() {
        return showWorkSum;
    }

    public void setShowWorkSum(String showWorkSum) {
        this.showWorkSum = showWorkSum;
    }

    public String getGradeString() {
		return gradeString;
	}
	public void setGradeString(String gradeString) {
		this.gradeString = gradeString;
	}
	public String getNotShowPercent() {
		return notShowPercent;
	}
	public void setNotShowPercent(String notShowPercent) {
		this.notShowPercent = notShowPercent;
	}
	public String getNotShowHr() {
		return notShowHr;
	}
	public void setNotShowHr(String notShowHr) {
		this.notShowHr = notShowHr;
	}
	public String getIsVirtual() {
		return isVirtual;
	}
	public void setIsVirtual(String isVirtual) {
		this.isVirtual = isVirtual;
	}
	public String getAllowMark() {
		return allowMark;
	}
	public void setAllowMark(String allowMark) {
		this.allowMark = allowMark;
	}
	public String getScorePersDes() {
		if(scorePers!=null){
			if(scorePers.equals(EVA_CACL_PERS_INT)){
				scorePersDes="����";
			}else if(scorePers.equals(EVA_CACL_PERS_ONEDEC)){
				scorePersDes="һλС��";
			}else if(scorePers.equals(EVA_CACL_PERS_TWODEC)){
				scorePersDes="��λС��";
			}else if(scorePers.equals(EVA_CACL_PERS_THREEDEC)){
				scorePersDes="��λС��";
			}
		}
		return scorePersDes;
	}
	public void setScorePersDes(String scorePersDes) {
		this.scorePersDes = scorePersDes;
	}
	public String getLevelPersDes() {
		if(levelPers!=null){
			if(levelPers.equals(EVA_Level_PERS_INT)){
				levelPersDes="����";
			}else if(levelPers.equals(EVA_Level_PERS_ONEDEC)){
				levelPersDes="һλС��";
			}else if(levelPers.equals(EVA_Level_PERS_TWODEC)){
				levelPersDes="��λС��";
			}else if(levelPers.equals(EVA_Level_PERS_THREEDEC)){
				levelPersDes="��λС��";
			}
		}
		return levelPersDes;
	}
	public void setLevelPersDes(String levelPersDes) {
		this.levelPersDes = levelPersDes;
	}
	public String getScorePers() {
		return scorePers;
	}
	public void setScorePers(String scorePers) {
		this.scorePers = scorePers;
	}
	public String getLevelPers() {
		return levelPers;
	}
	public void setLevelPers(String levelPers) {
		this.levelPers = levelPers;
	}
	public String getObjectTypeDes() {
		if(planObjectType!=null&&!"".equals(planObjectType)){
			if(planObjectType.equals(OBJCT_TYPE_PERSON)){
				objectTypeDes="����";
			}else if(planObjectType.equals(OBJCT_TYPE_DEPT)){
				objectTypeDes="����";
			}else if(planObjectType.equals(OBJCT_TYPE_TEAM)){
				objectTypeDes="�Ŷ�";
			}
		}
		return objectTypeDes;
	}
	public void setObjectTypeDes(String objectTypeDes) {
		this.objectTypeDes = objectTypeDes;
	}
	public String getHasSendBull() {
		if(evaFileBull!=null&&!evaFileBull.equals("")){
			hasSendBull="1";
		}else{
			hasSendBull="0";
		}
		return hasSendBull;
	}
	public void setHasSendBull(String hasSendBull) {
		this.hasSendBull = hasSendBull;
	}
	public String getEvaFileBull() {
		return evaFileBull;
	}
	public void setEvaFileBull(String evaFileBull) {
		this.evaFileBull = evaFileBull;
	}
	public String getPlanObjectType() {
		return planObjectType;
	}
	public void setPlanObjectType(String planObjectType) {
		this.planObjectType = planObjectType;
	}
	public String getHaveEvaFile() {
		if(evaFile!=null&&!evaFile.equals("")){
			haveEvaFile="1";
		}else{
			haveEvaFile="0";
		}
		return haveEvaFile;
	}
	public void setHaveEvaFile(String haveEvaFile) {
		this.haveEvaFile = haveEvaFile;
	}
	public String getEvaFile() {
		return evaFile;
	}
	public void setEvaFile(String evaFile) {
		this.evaFile = evaFile;
	}
	public String getEvaModelDes() {
		if(this.evaModel.trim().equals(EvaPlanBO.EVA_MODEL_POST)){
			return "��λ����";
		}else if(this.evaModel.trim().equals(EvaPlanBO.EVA_MODEL_TABLE)){
			return "������";
		}else if(this.evaModel.trim().equals(EvaPlanBO.EVA_MODEL_TASK)){
			return "���񿼺�";
		}else if(this.evaModel.trim().equals(EvaPlanBO.EVA_MODEL_ELECTION)){
			return "ͶƱ";
		}else{
			return "";
		}
	}
	public void setEvaModelDes(String evaModelDes) {
		this.evaModelDes = evaModelDes;
	}
	public String getResultAuditExplain() {
		return resultAuditExplain;
	}
	public void setResultAuditExplain(String resultAuditExplain) {
		this.resultAuditExplain = resultAuditExplain;
	}
	public String getResultAuditResult() {
		return resultAuditResult;
	}
	public void setResultAuditResult(String resultAuditResult) {
		this.resultAuditResult = resultAuditResult;
	}
	public String getResultAuditPerson() {
		return resultAuditPerson;
	}
	public void setResultAuditPerson(String resultAuditPerson) {
		this.resultAuditPerson = resultAuditPerson;
	}
	public String getResultAuditDate() {
		return resultAuditDate;
	}
	public void setResultAuditDate(String resultAuditDate) {
		this.resultAuditDate = resultAuditDate;
	}
	public String getEvaModel() {
		return evaModel;
	}
	public void setEvaModel(String evaModel) {
		this.evaModel = evaModel;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String property1) {
		this.planId = property1;
	}
    
    public String getTemplatesDes() {
        return templatesDes;
    }
    public void setTemplatesDes(String templatesDes) {
        this.templatesDes = templatesDes;
    }

	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String property1) {
		this.planName = property1;
	}

	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String property1) {
		this.orgId = property1;
	}

	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String property1) {
		this.orgName = property1;
	}

	public String getPlanDate() {
		return planDate;
	}

	public void setPlanDate(String date) {
		this.planDate = date;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String property1) {
		this.beginDate = property1;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String property1) {
		this.endDate = property1;
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String des) {
		this.description = des;
	}

	public String getTemplates() {
		return templates;
	}
	public void setTemplates(String ids) {
		this.templates = ids;
	}

	public String getCreatePersonId() {
		return createPersonId;
	}
	public void setCreatePersonId(String id) {
		this.createPersonId = id;
	}

    public String getCreatePersonName() {
        return createPersonName;
    }
    public void setCreatePersonName(String id) {
        this.createPersonName = id;
    }

	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String date) {
		this.createDate = date;
	}

	public String getAduitPersonId() {
		return aduitPersonId;
	}
	public void setAduitPersonId(String id) {
		this.aduitPersonId = id;
	}

    public String getAduitDate() {
        return aduitDate;
    }
    public void setAduitDate(String id) {
        this.aduitDate = id;
    }

    public String getAduitResult() {
        return aduitResult;
    }
    public void setAduitResult(String id) {
        this.aduitResult = id;
    }

    public String getEvaMethod() {
        return evaMethod;
    }
    public void setEvaMethod(String id) {
        this.evaMethod = id;
    }

    public String getPruview() {
        return pruview;
    }
    public void setPruview(String id) {
        this.pruview = id;
    }

    public String getAduitContent() {
        return aduitContent;
    }
    public void setAduitContent(String id) {
        this.aduitContent = id;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String id) {
        this.status = id;
    }

    public String getStatusDes() {
        statusDes="";
        if (EVA_PLANSTATUS_SCRIPT.equals(this.status)){
            statusDes="���";
        }
        else if (EVA_PLANSTATUS_APPROVING.equals(this.status)){
            statusDes="����";
        }
        else if (EVA_PLANSTATUS_APPROVED.equals(this.status)){
            statusDes="��׼";
        }
        else if (EVA_PLANSTATUS_EXECUTE.equals(this.status)){
            statusDes="ִ��";
        }
        else if (EVA_PLANSTATUS_AppovResult.equals(this.status)){
            statusDes="�������";
        }
        else if (EVA_PLANSTATUS_FINISH.equals(this.status)){
            statusDes="����";
        }else if(EVA_PLANSTATUS_AppovResultED.equals(this.status)){
        	statusDes="��׼���";
        }else if(EVA_PLANSTATUS_MODFIY.equals(this.status)){
        	statusDes="�˻��޸�";
        }
        return statusDes;
    }
    public void setStatusDes(String id) {
        this.statusDes = id;
    }

    public String getPlanType() {
        return planType;
    }
    public void setPlanType(String id) {
        this.planType = id;
    }
	public String getPlanGrade() {
		return planGrade;
	}
	public void setPlanGrade(String planGrade) {
		this.planGrade = planGrade;
	}
	public String getPlanGradeName() {
		return planGradeName;
	}
	public void setPlanGradeName(String planGradeName) {
		this.planGradeName = planGradeName;
	}
    

}
