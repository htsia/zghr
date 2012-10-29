package com.hr319wg.eva.service;

import com.hr319wg.eva.dao.EvaGradeDAO;
import com.hr319wg.eva.dao.EvaKeyItemDAO;
import com.hr319wg.eva.dao.EvaObjectsDAO;
import com.hr319wg.eva.dao.EvaPlanDAO;
import com.hr319wg.eva.dao.EvaScoreDAO;
import com.hr319wg.eva.dao.EvaTaskEstimateDAO;
import com.hr319wg.eva.dao.jobEstimateDAO;
import com.hr319wg.eva.pojo.bo.*;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.Constants;
import com.hr319wg.eva.pojo.vo.EvaMastersVO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.pojo.vo.CellVO;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Vector;


public class EvaScoreService {
    private ActivePageAPI activeapi;
    private EvaScoreDAO scoredao;
    private jobEstimateDAO jobestimatdao;
    private EvaTaskEstimateDAO taskdao;
    private EvaObjectsDAO evaobjectdao;
    private EvaGradeDAO evagradedao;
    private EvaPlanDAO evaplandao;
    private EvaKeyItemDAO evakeydao;

    public EvaKeyItemDAO getEvakeydao() {
        return evakeydao;
    }

    public void setEvakeydao(EvaKeyItemDAO evakeydao) {
        this.evakeydao = evakeydao;
    }

    public EvaPlanDAO getEvaplandao() {
        return evaplandao;
    }

    public void setEvaplandao(EvaPlanDAO evaplandao) {
        this.evaplandao = evaplandao;
    }

    public boolean isHaveTheTypeMasterByPlanId(String planId, String masterType) throws SysException {
        String sql = "select count(*) from eva_masters where MASTER_TYPE='" + masterType + "' and object_id in(select eva_objects.object_id from eva_objects where plan_id='" + planId + "')";
        return this.activeapi.queryForInt(sql) > 0;
    }

    public List getThePersonTypeByPlanId(String planId) throws SysException {
        String selTypeSql = "select distinct(master_type) from eva_masters where object_id in(select eva_objects.object_id from eva_objects where plan_id='" + planId + "') ";
        CellVO[] cv = new CellVO[1];
        cv[0] = new CellVO();
        cv[0].setItemId("master_type");
        Vector rs = activeapi.getDataListBySql(cv, selTypeSql);
        List list = new ArrayList();
        for (int i = 0; i < rs.size(); i++) {
            CellVO row[] = (CellVO[]) rs.get(i);
            list.add(row[0].getValue());
        }
        return list;
    }

    private String getGardeItemByScore(String gradeId, double score) throws SysException {
        List list = evagradedao.getAllGradeItem(gradeId);
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                EvaGradeItemBO bo = (EvaGradeItemBO) list.get(i);
                double hi = Double.parseDouble(bo.getHighValue());
                double low = Double.parseDouble(bo.getLowValue());
                if (score >= low && score < hi) {
                    return bo.getItemID();
                }
            }
        }
        return "";
    }

    /**
     * 虚拟计划计算
     * @param planId
     * @throws SysException
     */
    public void caclVirtualPlan(String planId) throws SysException {
        List mixList = evaplandao.getAllEvaPlanMixBOByPlanId(planId);
        if (mixList != null && mixList.size() > 0) {
            EvaPlanMixBO bo1 = (EvaPlanMixBO) mixList.get(0);
            EvaPlanBO planbo = (EvaPlanBO) evaplandao.findBoById(EvaPlanBO.class, bo1.getMixPlan());
            NumberFormat nf = NumberFormat.getInstance();
            if (planbo.getScorePers() != null && !planbo.getScorePers().equals("")) {
                int intPers = Integer.parseInt(planbo.getScorePers());
                nf.setMaximumFractionDigits(intPers);
            } else {
                nf.setMaximumFractionDigits(2);
            }
            if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE) || planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)) {
                List objList = evaobjectdao.getObjectsByPlanId(null, bo1.getMixPlan());
                if (objList != null && objList.size() > 0) {
                    for (int i = 0; i < objList.size(); i++) {
                        EvaObjectsBO obj = (EvaObjectsBO) objList.get(i);
                        double score = 0;
                        if (obj.getScore() != null && !obj.getScore().equals("")) {
                            score = Double.parseDouble(obj.getScore()) * Double.parseDouble(bo1.getPurview()) / 100;
                        }
                        for (int j = 1; j < mixList.size(); j++) {
                            EvaPlanMixBO mix = (EvaPlanMixBO) mixList.get(j);
                            EvaPlanBO planbo2 = (EvaPlanBO) evaplandao.findBoById(EvaPlanBO.class, mix.getMixPlan());
                            if (planbo2.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE) || planbo2.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)) {
                                EvaObjectsBO obj2 = evaobjectdao.getEvaObjectsBOByPlanIdAndPersonId(mix.getMixPlan(), obj.getPersonID());
                                if (obj2 != null && obj2.getScore() != null && !obj2.getScore().equals("")) {
                                    score += Double.parseDouble(obj2.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            } else if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)) {
                                EvaJobEstimateBO job = jobestimatdao.findSelfJobEstimate(mix.getMixPlan(), obj.getPersonID());
                                if (job != null && job.getScore() != null && !job.getScore().equals("")) {
                                    score += Double.parseDouble(job.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            } else if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)) {
                                EvaTaskMasterBO mask = taskdao.findEvaTaskMasterBOByPid(mix.getMixPlan(), obj.getPersonID());
                                if (mask != null && mask.getScore() != null && !mask.getScore().equals("")) {
                                    score += Double.parseDouble(mask.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            }
                        }
                        obj.setSumScore(nf.format(score));
                        obj.setSumGrade(getGardeItemByScore(planbo.getPlanGrade(), score));
                        evaobjectdao.saveOrUpdateBo(obj);
                    }
                    List objList2 = evaobjectdao.getObjectsBOByPlanIdForSumSort(bo1.getMixPlan());
                    if (objList2 != null && objList2.size() > 0) {
                        for (int i = 0; i < objList2.size(); i++) {
                            EvaObjectsBO obj = (EvaObjectsBO) objList2.get(i);
                            obj.setSumSort(String.valueOf(i + 1));
                            evaobjectdao.saveOrUpdateBo(obj);
                        }
                    }
                }
            } else if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)) {
                List jobList = jobestimatdao.findJOBEstimateByPlanID(bo1.getMixPlan());
                if (jobList != null && jobList.size() > 0) {
                    for (int i = 0; i < jobList.size(); i++) {
                        EvaJobEstimateBO job = (EvaJobEstimateBO) jobList.get(i);
                        double score = 0;
                        if (job.getScore() != null && !job.getScore().equals("")) {
                            score = Double.parseDouble(job.getScore()) * Double.parseDouble(bo1.getPurview()) / 100;
                        }
                        for (int j = 1; j < mixList.size(); j++) {
                            EvaPlanMixBO mix = (EvaPlanMixBO) mixList.get(j);
                            EvaPlanBO planbo2 = (EvaPlanBO) evaplandao.findBoById(EvaPlanBO.class, mix.getMixPlan());
                            if (planbo2.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE) || planbo2.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)) {
                                EvaObjectsBO obj2 = evaobjectdao.getEvaObjectsBOByPlanIdAndPersonId(mix.getMixPlan(), job.getPersonID());
                                if (obj2 != null && obj2.getScore() != null && !obj2.getScore().equals("")) {
                                    score += Double.parseDouble(obj2.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            } else if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)) {
                                EvaJobEstimateBO job2 = jobestimatdao.findSelfJobEstimate(mix.getMixPlan(), job.getPersonID());
                                if (job2 != null && job2.getScore() != null && !job2.getScore().equals("")) {
                                    score += Double.parseDouble(job2.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            } else if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)) {
                                EvaTaskMasterBO mask = taskdao.findEvaTaskMasterBOByPid(mix.getMixPlan(), job.getPersonID());
                                if (mask != null && mask.getScore() != null && !mask.getScore().equals("")) {
                                    score += Double.parseDouble(mask.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            }
                        }
                        job.setSumScore(nf.format(score));
                        job.setSumGrade(getGardeItemByScore(planbo.getPlanGrade(), score));
                        jobestimatdao.saveOrUpdateBo(job);
                    }
                    List jobList2 = jobestimatdao.findEvaJobEstimateBOForSumSort(bo1.getMixPlan());
                    if (jobList2 != null && jobList2.size() > 0) {
                        for (int i = 0; i < jobList2.size(); i++) {
                            EvaJobEstimateBO job = (EvaJobEstimateBO) jobList2.get(i);
                            job.setSumSort(String.valueOf(i + 1));
                            jobestimatdao.saveOrUpdateBo(job);
                        }
                    }
                }
            } else if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)) {
                List taskList = taskdao.getAllEvaTaskMasterBO(bo1.getMixPlan());
                if (taskList != null && taskList.size() > 0) {
                    for (int i = 0; i < taskList.size(); i++) {
                        EvaTaskMasterBO task = (EvaTaskMasterBO) taskList.get(i);
                        double score = 0;
                        if (task.getScore() != null && !task.getScore().equals("")) {
                            score = Double.parseDouble(task.getScore()) * Double.parseDouble(bo1.getPurview()) / 100;
                        }
                        for (int j = 1; j < mixList.size(); j++) {
                            EvaPlanMixBO mix = (EvaPlanMixBO) mixList.get(j);
                            EvaPlanBO planbo2 = (EvaPlanBO) evaplandao.findBoById(EvaPlanBO.class, mix.getMixPlan());
                            if (planbo2.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE) || planbo2.getEvaModel().equals(EvaPlanBO.EVA_MODEL_ELECTION)) {
                                EvaObjectsBO obj2 = evaobjectdao.getEvaObjectsBOByPlanIdAndPersonId(mix.getMixPlan(), task.getPersonId());
                                if (obj2 != null && obj2.getScore() != null && !obj2.getScore().equals("")) {
                                    score += Double.parseDouble(obj2.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            } else if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_POST)) {
                                EvaJobEstimateBO job2 = jobestimatdao.findSelfJobEstimate(mix.getMixPlan(), task.getPersonId());
                                if (job2 != null && job2.getScore() != null && !job2.getScore().equals("")) {
                                    score += Double.parseDouble(job2.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            } else if (planbo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TASK)) {
                                EvaTaskMasterBO mask = taskdao.findEvaTaskMasterBOByPid(mix.getMixPlan(), task.getPersonId());
                                if (mask != null && mask.getScore() != null && !mask.getScore().equals("")) {
                                    score += Double.parseDouble(mask.getScore()) * Double.parseDouble(mix.getPurview()) / 100;
                                }
                            }
                        }
                        task.setSumScore(nf.format(score));
                        task.setSumGrade(getGardeItemByScore(planbo.getPlanGrade(), score));
                        taskdao.saveOrUpdateBo(task);
                    }
                    List taskList2 = taskdao.getAllEvaTaskMasterBOForSumSort(bo1.getMixPlan());
                    if (taskList2 != null && taskList2.size() > 0) {
                        for (int i = 0; i < taskList2.size(); i++) {
                            EvaTaskMasterBO task = (EvaTaskMasterBO) taskList2.get(i);
                            task.setSumSort(String.valueOf(i + 1));
                            taskdao.saveOrUpdateBo(task);
                        }
                    }
                }
            }
        }
    }

    public EvaGradeDAO getEvagradedao() {
        return evagradedao;
    }

    public void setEvagradedao(EvaGradeDAO evagradedao) {
        this.evagradedao = evagradedao;
    }

    public EvaObjectsDAO getEvaobjectdao() {
        return evaobjectdao;
    }

    public void setEvaobjectdao(EvaObjectsDAO evaobjectdao) {
        this.evaobjectdao = evaobjectdao;
    }

    public EvaTaskEstimateDAO getTaskdao() {
        return taskdao;
    }

    public void setTaskdao(EvaTaskEstimateDAO taskdao) {
        this.taskdao = taskdao;
    }

    public jobEstimateDAO getJobestimatdao() {
        return jobestimatdao;
    }

    public void setJobestimatdao(jobEstimateDAO jobestimatdao) {
        this.jobestimatdao = jobestimatdao;
    }

    public ActivePageAPI getActiveapi() {
        return activeapi;
    }

    public void setActiveapi(ActivePageAPI activeapi) {
        this.activeapi = activeapi;
    }

    public List getEvaCaclScoresBOByObjectId(String objectId)
            throws SysException {
        return this.scoredao.getEvaCaclScoresBOByObjectId(objectId);
    }

    public Hashtable getEvaCaclScoresBOByObjectIds(String[] objIds) throws SysException {
        return this.scoredao.getEvaCaclScoresBOByObjectIds(objIds);
    }

    public EvaCaclScoresBO findEvaCaclScoresBOById(String scoreId)
            throws SysException {
        return (EvaCaclScoresBO) this.scoredao.findBoById(
                EvaCaclScoresBO.class, scoreId);
    }

    public EvaCaclScoresBO findEvaCaclScoresBOByItemIdAndObjectId(
            String objectId, String itemId) throws SysException {
        return this.scoredao.findEvaCaclScoresBOByItemIdAndObjectId(objectId,
                itemId);
    }

    public void saveEvaCaclScoresBO(EvaCaclScoresBO bo) throws SysException {
        this.scoredao.saveOrUpdateBo(bo);
    }

    public void deleteEvaCaclScoresBO(String scoreId) throws SysException {
        this.scoredao.deleteBo(EvaCaclScoresBO.class, scoreId);
    }

    public List getScoreInfo(String masterID, String objectID)
            throws SysException {
        return scoredao.getScoreInfo(masterID, objectID);
    }

    public void saveScore(EvaScoreBO bo) throws SysException {
        scoredao.saveOrUpdateBo(bo);
    }

    public void deleteAllScore(String masterID, String objectID)
            throws SysException {
        String sql = "delete from eva_masters where object_id='" + objectID
                + "' and  master_id='" + masterID + "'";
        activeapi.executeSql(sql);
    }

    public void caclTheMasterScoreForObject(String objectId, String masterId)
            throws SysException {
        String[] sql = new String[5];
        sql[0] = "update eva_scores set purview=(select score from eva_template_item where eva_scores.item_id=eva_template_item.item_id) where object_id='"
                + objectId + "' and master_id='" + masterId + "'";
        sql[1] = "update eva_scores set temp_total_score=(select total_score from eva_template where eva_template.template_id=(select eva_objects.template_id from eva_objects where eva_objects.object_id='"
                + objectId
                + "')) where object_id='"
                + objectId
                + "' and master_id='" + masterId + "'";
        sql[2] = "update eva_scores set key_hi_score=(select high_value from eva_keyitem where item_id=(select link_id from eva_template_item where eva_scores.item_id=eva_template_item.item_id)) where object_id='"
                + objectId + "' and master_id='" + masterId + "'";
        if ("ORACLE".equals(Constants.DB_TYPE)) {
            sql[3] = "update eva_scores set calcscore=0.01*isnull(score,'0')*isnull(purview,'0')*isnull(temp_total_score,'0')/isnull(key_hi_score,'1') where object_id='"
                    + objectId + "' and master_id='" + masterId + "'";
            sql[4] = "update eva_masters set score=(select round(sum(calcscore),3) from EVA_SCORES where EVA_SCORES.master_id=eva_masters.master_id) where  object_id='"
                    + objectId + "' and master_id='" + masterId + "'";
        } else if ("MYSQL".equals(Constants.DB_TYPE)) {
            sql[3] = "update eva_scores set calcscore=0.01*ifnull(score,0)*ifnull(purview,0)*ifnull(temp_total_score,0)/ifnull(key_hi_score,1) where object_id='"
                    + objectId + "' and master_id='" + masterId + "'";
            sql[4] = "update eva_masters set score=(select sum(calcscore) from EVA_SCORES where EVA_SCORES.master_id=eva_masters.master_id) where  object_id='"
                    + objectId + "' and master_id='" + masterId + "'";
        } else {
            sql[3] = "update eva_scores set calcscore=0.01*cast(isnull(score,'0') as float)*cast(isnull(purview,'0') as float)*cast(isnull(temp_total_score,'0') as float)/cast(isnull(key_hi_score,'1') as float) where object_id='"
                    + objectId + "' and master_id='" + masterId + "'";
            sql[4] = "update eva_masters set score=(select round(sum(cast(calcscore as float)),3) from EVA_SCORES where EVA_SCORES.master_id=eva_masters.master_id) where object_id='"
                    + objectId + "' and master_id='" + masterId + "'";
        }
        activeapi.batchExecuteSql(sql);
        EvaMasterBO master = (EvaMasterBO) this.scoredao.findBoById(
                EvaMasterBO.class, masterId);
        EvaObjectsBO obj = (EvaObjectsBO) this.scoredao.findBoById(
                EvaObjectsBO.class, objectId);
        EvaPlanBO planbo = (EvaPlanBO) this.scoredao.findBoById(
                EvaPlanBO.class, obj.getPlanID());
        if (planbo.getPlanGrade() != null && !planbo.getPlanGrade().equals("")) {
            double score = Double.parseDouble(master.getScore());
            List gradeList = evagradedao.getAllGradeItem(planbo.getPlanGrade());
            double allScore = Double.parseDouble(((EvaTemplateBO) this.scoredao
                    .findBoById(EvaTemplateBO.class, obj.getTemplateID()))
                    .getTotalscore());
            boolean isAllScore = false;
            if (score == allScore) {
                isAllScore = true;
            }
            for (int m = 0; m < gradeList.size(); m++) {
                EvaGradeItemBO itembo = (EvaGradeItemBO) gradeList.get(m);
                double low = Double.parseDouble(itembo.getLowValue());
                double hi = Double.parseDouble(itembo.getHighValue());
                if (hi == allScore && isAllScore == true) {
                    master.setGradeId(itembo.getItemID());
                    evaobjectdao.saveOrUpdateBo(master);
                    break;
                }
                if (score >= low && score < hi) {
                    master.setGradeId(itembo.getItemID());
                    evaobjectdao.saveOrUpdateBo(master);
                    break;
                }
            }
        }
    }

    private void insertCaculatekeyItemScore(String planId) throws SysException {
        List objList = evaobjectdao.getObjectsByPlanId(null, planId);
        if (objList != null && objList.size() > 0) {
            for (int i = 0; i < objList.size(); i++) {
                EvaObjectsBO obj = (EvaObjectsBO) objList.get(i);
                EvaTemplateBO temp = (EvaTemplateBO) this.scoredao.findBoById(
                        EvaTemplateBO.class, obj.getTemplateID());
                List caclScoreList = this.getEvaCaclScoresBOByObjectId(obj
                        .getObjectID());
                if (caclScoreList != null && caclScoreList.size() > 0) {
                    for (int j = 0; j < caclScoreList.size(); j++) {
                        EvaCaclScoresBO bo = (EvaCaclScoresBO) caclScoreList
                                .get(j);
                        EvaKeyItemBO keybo = (EvaKeyItemBO) this.scoredao
                                .findBoById(EvaKeyItemBO.class, bo.getItemId());
                        String sql = "";
                        if ("SQL SERVER".equals(Constants.DB_TYPE)) {
                            sql = "update eva_cacl_scores set score=dbo."
                                    + keybo.getItemFun()
                                    + "(),temp_total_score='"
                                    + temp.getTotalscore() + "',key_hi_score='"
                                    + keybo.getHighValue()
                                    + "' where object_id='" + bo.getObjectId()
                                    + "' and item_id='" + bo.getItemId() + "'";
                        } else {
                            sql = "update eva_cacl_scores set score="
                                    + keybo.getItemFun()
                                    + "(),temp_total_score='"
                                    + temp.getTotalscore() + "',key_hi_score='"
                                    + keybo.getHighValue()
                                    + "' where object_id='" + bo.getObjectId()
                                    + "' and item_id='" + bo.getItemId() + "'";
                        }
                        activeapi.executeSql(sql);
                    }
                }
            }
        }
    }

    private boolean isHaveMarkForMaster(String objId, String masterType)
            throws SysException {
        String sql = "select count(*) from eva_masters where IS_MARK='1' and object_id='"
                + objId + "' and MASTER_TYPE='" + masterType + "'";
        return activeapi.queryForInt(sql) > 0;
    }

    private int returnCountDistctScoreForOjbct(String objId, String masterType) throws SysException {
        String sql = "select count(distinct(score)) from eva_masters where is_mark='1' and object_id='"
                + objId + "' and MASTER_TYPE='" + masterType + "'";
        return activeapi.queryForInt(sql);
    }

    public void calc(String planID) throws SysException {
        EvaPlanBO bo = (EvaPlanBO) scoredao.findBoById(EvaPlanBO.class, planID);
        List caclCtrList = this.evaplandao.getAllEvaCaclControlBOByPlanId(planID); //查询所有打分配置bo
        Hashtable ctrHash = new Hashtable();
        if (caclCtrList != null && caclCtrList.size() > 0) {
            for (int i = 0; i < caclCtrList.size(); i++) {
                EvaCaclControlBO cbo = (EvaCaclControlBO) caclCtrList.get(i);
                ctrHash.put(cbo.getMasterType() + cbo.getTemplateId(), cbo);
            }
        }
        NumberFormat nf = NumberFormat.getInstance();
        if (bo.getScorePers() != null && !bo.getScorePers().equals("")) {
            int intPers = Integer.parseInt(bo.getScorePers());
            nf.setMaximumFractionDigits(intPers);
        } else {
            nf.setMaximumFractionDigits(2);
        }
        if (bo.getPruview().equals(EvaPlanBO.EVA_PRUVIEW_GROUP)
                && bo.getEvaModel().equals(EvaPlanBO.EVA_MODEL_TABLE)) {// 如果是层次权重看看打分情况
            NumberFormat nf1 = NumberFormat.getInstance();
            if (bo.getLevelPers() != null && !bo.getLevelPers().equals("")) {
                int levelPers = Integer.parseInt(bo.getLevelPers());
                nf1.setMaximumFractionDigits(levelPers);
            } else {
                nf1.setMaximumFractionDigits(2);
            }
            List objectList = evaobjectdao.getObjectsByPlanId(null, planID);
            if (objectList != null && objectList.size() > 0) {
                for (int i = 0; i < objectList.size(); i++) {
                    EvaObjectsBO obj = (EvaObjectsBO) objectList.get(i);
                    List levelList = evaobjectdao.getAllLevelPurviewByObjectId(obj.getObjectID());
                    if (levelList != null && levelList.size() > 0) {
                        for (int j = 0; j < levelList.size(); j++) {
                            EvaLevelPurview level = (EvaLevelPurview) levelList
                                    .get(j);
                            boolean haveLeastOneScore = this.isHaveMarkForMaster(obj
                                    .getObjectID(), level.getMasterType()); //至少有一个打分true false 一个也没有计算结果肯定是0
                            int countDistinctMark = this.returnCountDistctScoreForOjbct(obj.getObjectID(), level.getMasterType());//返回该层次一共打出几种分值少于3种默认不进行舍分操作
                            if (haveLeastOneScore == true) {
                                if (countDistinctMark >= 3 && (bo.getCaclMode() != null && bo.getCaclMode().equals("1"))) {//计划为去掉最高分低分模式时同时countDistinctMark>=3时执行舍入计算
                                    EvaCaclControlBO ctrbo = (EvaCaclControlBO) ctrHash.get(level.getMasterType() + obj.getTemplateID());
                                    if (ctrbo != null) {
                                        if (ctrbo.getCaclMode().equals("0")) {//为默认计算模式：全部计算
                                            double purview = Double.parseDouble(level.getPurview());
                                            int count = 0;
                                            List masterList = evaobjectdao.getMastersByMasterType(obj.getObjectID(), level.getMasterType());
                                            if (masterList != null && masterList.size() > 0) {
                                                for (int m = 0; m < masterList.size(); m++) {
                                                    EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                    if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                        count++;
                                                    }
                                                }
                                            }
                                            double perPurview = 0;
                                            if (count != 0) {
                                                perPurview = purview / count;
                                            }
                                            if (masterList != null && masterList.size() > 0) {
                                                for (int m = 0; m < masterList.size(); m++) {
                                                    EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                    if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                        masterbo.setPurview(nf1.format(perPurview));
                                                    } else {
                                                        masterbo.setPurview("0");
                                                    }
                                                    scoredao.saveOrUpdateBo(masterbo);
                                                }
                                            }
                                        }else{// 去掉最高分和最低分
                                            if(ctrbo.getSelScoreMode().equals("0")){  //全部保留
                                                double purview = Double.parseDouble(level.getPurview());
                                                int count = 0;
                                                List masterList = evaobjectdao.getMastersByMasterType(obj.getObjectID(), level.getMasterType());
                                                if (masterList != null && masterList.size() > 0) {
                                                    for (int m = 0; m < masterList.size(); m++) {
                                                        EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                        if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                            count++;
                                                        }
                                                    }
                                                }
                                                double perPurview = 0;
                                                if (count != 0) {
                                                    perPurview = purview / count;
                                                }
                                                if (masterList != null && masterList.size() > 0) {
                                                    for (int m = 0; m < masterList.size(); m++) {
                                                        EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                        if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                            masterbo.setPurview(nf1.format(perPurview));
                                                        } else {
                                                            masterbo.setPurview("0");
                                                        }
                                                        scoredao.saveOrUpdateBo(masterbo);
                                                    }
                                                }
                                            }else if(ctrbo.getSelScoreMode().equals("1")){//保留其他
                                                double purview = Double.parseDouble(level.getPurview());
                                                int count = 0;
                                                double minValue=0;
                                                double maxValue=0;
                                                String minMaster=null;
                                                String maxMaster=null;
                                                List masterList = evaobjectdao.getMastersByMasterType(obj.getObjectID(), level.getMasterType());
                                                if (masterList != null && masterList.size() > 0) {
                                                    for (int m = 0; m < masterList.size(); m++) {
                                                        EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                        if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                             if(null==minMaster&&null==maxMaster){
                                                                minValue=Double.parseDouble(masterbo.getScore());
                                                                maxValue=Double.parseDouble(masterbo.getScore());
                                                                minMaster=masterbo.getMasterID();
                                                                maxMaster=masterbo.getMasterID();
                                                             }else{
                                                                 if(Double.parseDouble(masterbo.getScore())<=minValue){
                                                                     minMaster=masterbo.getMasterID();
                                                                 }
                                                                 if(Double.parseDouble(masterbo.getScore())>=maxValue){
                                                                    maxMaster=masterbo.getMasterID();
                                                                 }
                                                             }
                                                        }

                                                    }
                                                }
                                                masterList = evaobjectdao.getMastersByMasterType(obj.getObjectID(), level.getMasterType());
                                                if(masterList!=null&&masterList.size()>0){
                                                   for (int m = 0; m < masterList.size(); m++) {
                                                        EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                        if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")&&
                                                                !masterbo.getMasterID().equals(minMaster)&&!masterbo.getMasterID().equals(maxMaster)) {
                                                            masterbo.setIsCacl("1");
                                                            evaobjectdao.saveOrUpdateBo(masterbo);
                                                              count++;
                                                        }else{
                                                            masterbo.setIsCacl("0");
                                                            evaobjectdao.saveOrUpdateBo(masterbo);
                                                        }

                                                    }
                                                }
                                                double perPurview = 0;
                                                if (count != 0) {
                                                    perPurview = purview / count;
                                                }
                                                if (masterList != null && masterList.size() > 0) {
                                                    for (int m = 0; m < masterList.size(); m++) {
                                                        EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                        if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")&&!masterbo.getMasterID().equals(minMaster)&&!masterbo.getMasterID().equals(maxMaster)) {
                                                            masterbo.setPurview(nf1.format(perPurview));
                                                        } else {
                                                            masterbo.setPurview("0");
                                                        }
                                                        scoredao.saveOrUpdateBo(masterbo);
                                                    }
                                                }
                                            }else{//全部舍去
                                                double purview = Double.parseDouble(level.getPurview());
                                                int count = 0;
                                                double minValue=0;
                                                double maxValue=0;
                                                String minMaster=null;
                                                String maxMaster=null;
                                                List masterList = evaobjectdao.getMastersByMasterType(obj.getObjectID(), level.getMasterType());
                                                if (masterList != null && masterList.size() > 0) {
                                                    for (int m = 0; m < masterList.size(); m++) {
                                                        EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                        if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                             if(null==minMaster&&null==maxMaster){
                                                                minValue=Double.parseDouble(masterbo.getScore());
                                                                maxValue=Double.parseDouble(masterbo.getScore());
                                                             }else{
                                                                 if(Double.parseDouble(masterbo.getScore())<=minValue){
                                                                     minValue=Double.parseDouble(masterbo.getScore());
                                                                 }
                                                                 if(Double.parseDouble(masterbo.getScore())>=maxValue){
                                                                   maxValue=Double.parseDouble(masterbo.getScore());
                                                                 }
                                                             }
                                                        }

                                                    }
                                                }
                                                masterList = evaobjectdao.getMastersByMasterType(obj.getObjectID(), level.getMasterType());
                                                if(masterList!=null&&masterList.size()>0){
                                                   for (int m = 0; m < masterList.size(); m++) {
                                                        EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                        if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                              double masterScore=Double.parseDouble(masterbo.getScore());
                                                              if(masterScore!=minValue&&masterScore!=maxValue){
                                                                 masterbo.setIsCacl("1");
                                                                  evaobjectdao.saveOrUpdateBo(masterbo);
                                                                count++;
                                                              }else{
                                                                  masterbo.setIsCacl("0");
                                                                  evaobjectdao.saveOrUpdateBo(masterbo);
                                                              }
                                                        }else{
                                                              masterbo.setIsCacl("0");
                                                              evaobjectdao.saveOrUpdateBo(masterbo);
                                                        }

                                                    }
                                                }
                                                double perPurview = 0;
                                                if (count != 0) {
                                                    perPurview = purview / count;
                                                }
                                                if (masterList != null && masterList.size() > 0) {
                                                    for (int m = 0; m < masterList.size(); m++) {
                                                        EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                                        if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                             double masterScore=Double.parseDouble(masterbo.getScore());
                                                              if(masterScore!=minValue&&masterScore!=maxValue){
                                                                 masterbo.setPurview(nf1.format(perPurview));
                                                              }else{
                                                                   masterbo.setPurview("0");
                                                              }
                                                        } else {
                                                            masterbo.setPurview("0");
                                                        }
                                                        scoredao.saveOrUpdateBo(masterbo);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    double purview = Double.parseDouble(level.getPurview());
                                    int count = 0;
                                    List masterList = evaobjectdao.getMastersByMasterType(obj.getObjectID(), level.getMasterType());
                                    if (masterList != null && masterList.size() > 0) {
                                        for (int m = 0; m < masterList.size(); m++) {
                                            EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                            if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                count++;
                                            }
                                        }
                                    }
                                    double perPurview = 0;
                                    if (count != 0) {
                                        perPurview = purview / count;
                                    }
                                    if (masterList != null && masterList.size() > 0) {
                                        for (int m = 0; m < masterList.size(); m++) {
                                            EvaMasterBO masterbo = (EvaMasterBO) masterList.get(m);
                                            if (masterbo.getIsMark() != null && masterbo.getIsMark().equals("1")) {
                                                masterbo.setPurview(nf1.format(perPurview));
                                            } else {
                                                masterbo.setPurview("0");
                                            }
                                            scoredao.saveOrUpdateBo(masterbo);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if (bo.getEvaModel().trim().equals(EvaPlanBO.EVA_MODEL_TABLE)) {
            //拷贝考核客体
            String insertObjSql = "insert into eva_graders(object_id,person_id) select eva_objects.object_id,eva_objects.person_id from eva_objects where plan_id='" + planID + "' and eva_objects.object_id not in(select eva_graders.object_id from eva_graders)";
            activeapi.executeSql(insertObjSql);

            //将考核人员类型插入Eva_Plan表
            String selTypeSql = "select distinct(master_type) from eva_masters where object_id in(select eva_objects.object_id from eva_objects where plan_id='" + planID + "') ";
            CellVO[] cv = new CellVO[1];
            cv[0] = new CellVO();
            cv[0].setItemId("master_type");
            Vector rs = activeapi.getDataListBySql(cv, selTypeSql);
            String types[] = new String[rs.size()];
            String typesStr = "";
            for (int i = 0; i < rs.size(); i++) {
                CellVO row[] = (CellVO[]) rs.get(i);
                types[i] = row[0].getValue();
                if (typesStr.equals("")) {
                    typesStr += row[0].getValue();
                } else {
                    typesStr += "," + row[0].getValue();
                }
            }
            String updateTypeStr = "update eva_plan set gradeString='" + typesStr + "' where plan_id='" + planID + "'";
            activeapi.executeSql(updateTypeStr);
            //插入计算型指标
            insertCaculatekeyItemScore(planID);

            //计算
            String[] sql = new String[6];
            sql[0] = "update eva_scores set purview=(select score from eva_template_item where eva_scores.item_id=eva_template_item.item_id) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                    + planID + "')";
            sql[1] = "update eva_scores set temp_total_score=(select total_score from eva_template where template_id=(select template_id from eva_template_item where eva_scores.item_id=eva_template_item.item_id)) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                    + planID + "')";
            sql[2] = "update eva_scores set key_hi_score=(select high_value from eva_keyitem where item_id=(select link_id from eva_template_item where eva_scores.item_id=eva_template_item.item_id)) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                    + planID + "')";
            if ("ORACLE".equals(Constants.DB_TYPE)) {
                sql[3] = "update eva_scores set calcscore=0.01*isnull(score,'0')*isnull(purview,'0')*isnull(temp_total_score,'0')/isnull(key_hi_score,'1') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
                sql[4] = "update eva_masters set score=(select round(sum(calcscore),3) from EVA_SCORES where EVA_SCORES.master_id=eva_masters.master_id) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
                sql[5] = "update EVA_OBJECTS set score=(select sum(0.01*isnull(score,'0')*isnull(purview,'0')) from eva_masters where eva_masters.object_id=EVA_OBJECTS.object_id) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
            } else if ("MYSQL".equals(Constants.DB_TYPE)) {
                sql[3] = "update eva_scores set calcscore=0.01*ifnull(score,0)*ifnull(purview,0)*ifnull(temp_total_score,0)/ifnull(key_hi_score,1) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
                sql[4] = "update eva_masters set score=(select sum(calcscore) from EVA_SCORES where EVA_SCORES.master_id=eva_masters.master_id) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
                sql[5] = "update EVA_OBJECTS set score=((select format(sum(0.01*ifnull(score,0)*ifnull(purview,0)),2) from eva_masters where eva_masters.object_id=EVA_OBJECTS.object_id)+ifnull((select format(sum(0.01*ifnull(eva_cacl_scores.score,0)*ifnull(eva_cacl_scores.purview,0)*ifnull(eva_cacl_scores.temp_total_score,0)/ifnull(key_hi_score ,0)),2) from eva_cacl_scores where eva_cacl_scores.object_id=EVA_OBJECTS.object_id),0)) where  plan_id='"
                        + planID + "'";
            } else {
                sql[3] = "update eva_scores set calcscore=0.01*cast(isnull(score,'0') as float)*cast(isnull(purview,'0') as float)*cast(isnull(temp_total_score,'0') as float)/cast(isnull(key_hi_score,'1') as float) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
                sql[4] = "update eva_masters set score=(select round(sum(cast(calcscore as float)),3) from EVA_SCORES where EVA_SCORES.master_id=eva_masters.master_id) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
                sql[5] = "update EVA_OBJECTS set score=((select sum(0.01*cast(isnull(score,'0') as float)*cast(isnull(purview,'0') as float)) from eva_masters where eva_masters.object_id=EVA_OBJECTS.object_id)+isnull((select sum(0.01*cast(isnull(eva_cacl_scores.score,'0') as float)*cast(isnull(eva_cacl_scores.purview,'0') as float)*cast(isnull(eva_cacl_scores.temp_total_score,'0') as float)/cast(isnull(eva_cacl_scores.key_hi_score,'0') as float)) from eva_cacl_scores where eva_cacl_scores.object_id=EVA_OBJECTS.object_id),'0')) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
            }
            activeapi.batchExecuteSql(sql);
            if ("ORACLE".equals(Constants.DB_TYPE)) {
                String sql6 = "update EVA_OBJECTS set score=score+isnull((select sum(0.01*isnull(eva_cacl_scores.score,'0')*isnull(eva_cacl_scores.purview,'0')*isnull(eva_cacl_scores.temp_total_score,'0')/isnull(eva_cacl_scores.key_hi_score,'0')) from eva_cacl_scores where eva_cacl_scores.object_id=EVA_OBJECTS.object_id),'0') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
                activeapi.executeSql(sql6);
            }

            //层次分析计算
            for (int m = 0; m < types.length; m++) {
                if ("ORACLE".equals(Constants.DB_TYPE)) {
                    String update[] = new String[2];
                    update[0] = "update eva_graders set s" + (m + 1) + "=(select sum(0.01*isnull(score,'0')*isnull(purview,'0')) from eva_masters where eva_masters.object_id=eva_graders.object_id and eva_masters.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                            + planID + "')";
                    if (bo.getPruview().equals(EvaPlanBO.EVA_PRUVIEW_GROUP)) {
                        update[1] = "update eva_graders set f" + (m + 1) + "=(select isnull(Evalevel_purview.purview,'0') from Evalevel_purview where Evalevel_purview.object_id=eva_graders.object_id and Evalevel_purview.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                                + planID + "')";
                    } else {
                        update[1] = "update eva_graders set f" + (m + 1) + "=(select sum(isnull(purview,'0')) from eva_masters where eva_masters.object_id=eva_graders.object_id and eva_masters.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                                + planID + "')";
                    }
                    activeapi.batchExecuteSql(update);
                } else if ("MYSQL".equals(Constants.DB_TYPE)) {
                    String update[] = new String[2];
                    update[0] = "update eva_graders set s" + (m + 1) + "=(select sum(0.01*ifnull(score,0)*ifnull(purview,0)) from eva_masters where eva_masters.object_id=eva_graders.object_id and eva_masters.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                            + planID + "')";
                    if (bo.getPruview().equals(EvaPlanBO.EVA_PRUVIEW_GROUP)) {
                        update[1] = "update eva_graders set f" + (m + 1) + "=(select ifnull(Evalevel_purview.purview,0) from Evalevel_purview where Evalevel_purview.object_id=eva_graders.object_id and Evalevel_purview.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                                + planID + "')";
                    } else {
                        update[1] = "update eva_graders set f" + (m + 1) + "=(select sum(ifnull(purview,0)) from eva_masters where eva_masters.object_id=eva_graders.object_id and eva_masters.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                                + planID + "')";
                    }
                    activeapi.batchExecuteSql(update);
                } else {
                    String update[] = new String[2];
                    update[0] = "update eva_graders set s" + (m + 1) + "=(select sum(0.01*cast(isnull(score,'0') as float)*cast(isnull(purview,'0') as float)) from eva_masters where eva_masters.object_id=eva_graders.object_id and eva_masters.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                            + planID + "')";
                    if (bo.getPruview().equals(EvaPlanBO.EVA_PRUVIEW_GROUP)) {
                        update[1] = "update eva_graders set f" + (m + 1) + "=(select isnull(Evalevel_purview.purview,'0') from Evalevel_purview where Evalevel_purview.object_id=eva_graders.object_id and Evalevel_purview.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                                + planID + "')";
                    } else {
                        update[1] = "update eva_graders set f" + (m + 1) + "=(select sum(cast(isnull(purview,'0') as float)) from eva_masters where eva_masters.object_id=eva_graders.object_id and eva_masters.master_type='" + types[m] + "') where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                                + planID + "')";
                    }
                    activeapi.batchExecuteSql(update);
                }
            }
            String updateAll = "";
            if ("ORACLE".equals(Constants.DB_TYPE)) {
                updateAll = "update eva_graders set s=(select isnull(score,'0') from EVA_OBJECTS where EVA_OBJECTS.object_id=eva_graders.object_id),f=(select sum(isnull(purview,'0')) from eva_masters where eva_masters.object_id=eva_graders.object_id) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
            } else if ("MYSQL".equals(Constants.DB_TYPE)) {
                updateAll = "update eva_graders set s=(select ifnull(score,0) from EVA_OBJECTS where EVA_OBJECTS.object_id=eva_graders.object_id),f=(select sum(ifnull(purview,0)) from eva_masters where eva_masters.object_id=eva_graders.object_id) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
            } else {
                updateAll = "update eva_graders set s=(select isnull(score,'0') from EVA_OBJECTS where EVA_OBJECTS.object_id=eva_graders.object_id),f=(select sum(cast(isnull(purview,'0') as float)) from eva_masters where eva_masters.object_id=eva_graders.object_id) where object_id in (select object_id from EVA_OBJECTS where plan_id='"
                        + planID + "')";
            }
            activeapi.executeSql(updateAll);

            List list = evaobjectdao.getObjectsByPlanId(null, planID);
            List gradeList = evagradedao.getAllGradeItem(bo.getPlanGrade());
            Hashtable ht = new Hashtable();
            if (bo.getTemplates() != null && !bo.getTemplates().equals("")) {
                String tempIds = bo.getTemplates();
                String tempIds2 = "'1'";
                String[] ids = tempIds.split(",");
                for (int i = 0; i < ids.length; i++) {
                    tempIds2 += ",'" + ids[i] + "'";
                }
                List tempList = evakeydao.getAllTemplateByTemplateIds(tempIds2);
                if (tempList != null && tempList.size() > 0) {
                    for (int i = 0; i < tempList.size(); i++) {
                        EvaTemplateBO tebo = (EvaTemplateBO) tempList.get(i);
                        ht.put(tebo.getTemplateID(), tebo);
                    }
                }
            }
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    EvaObjectsBO obj = (EvaObjectsBO) list.get(i);
                    if (obj.getScore() != null && !obj.getScore().equals("")) {
                        double objscore = Double.parseDouble(obj.getScore());
                        double allScore = Double
                                .parseDouble(((EvaTemplateBO) ht.get(obj
                                        .getTemplateID()))
                                        .getTotalscore());
                        boolean isAllScore = false;
                        if (objscore == allScore) {
                            isAllScore = true;
                        }
                        for (int m = 0; m < gradeList.size(); m++) {
                            EvaGradeItemBO itembo = (EvaGradeItemBO) gradeList
                                    .get(m);
                            double low = Double.parseDouble(itembo
                                    .getLowValue());
                            double hi = Double.parseDouble(itembo
                                    .getHighValue());
                            if (hi == allScore && isAllScore == true) {
                                obj.setGradeItem(itembo.getItemID());
                                obj.setSortId(String.valueOf(i + 1));
                                evaobjectdao.saveOrUpdateBo(obj);
                                break;
                            }
                            if (objscore >= low && objscore < hi) {
                                obj.setGradeItem(itembo.getItemID());
                                obj.setSortId(String.valueOf(i + 1));
                                evaobjectdao.saveOrUpdateBo(obj);
                                break;
                            }
                        }
                    }
                }
            }
        } else if (bo.getEvaModel().trim().equals(EvaPlanBO.EVA_MODEL_POST)) {
            List resultList = jobestimatdao.findJOBEstimateByPlanID(planID);
            if (resultList != null && resultList.size() > 0) {
                for (int i = 0; i < resultList.size(); i++) {
                    EvaJobEstimateBO bo1 = (EvaJobEstimateBO) resultList.get(i);
                    double finalScore = 0;
                    String itemid = bo1.getItemID();
                    List list2 = jobestimatdao
                            .findEvaJobContentByItemID(itemid);
                    for (int j = 0; j < list2.size(); j++) {
                        EvaJobContentBO bo2 = (EvaJobContentBO) list2.get(j);
                        double scoreseq = 0;
                        double leadscore = 0;
                        if (bo2.getLeadScore() != null
                                && !bo2.getLeadScore().equals("")) {
                            leadscore = Double.parseDouble(bo2.getLeadScore());
                        } else {
                            leadscore = 0;
                        }
                        double preview = Double.parseDouble(bo2.getPreview());
                        scoreseq = leadscore * preview / 100;
                        String quanzhong = bo1.getSeqQZ(bo2.getSeq());
                        String qz = quanzhong.substring(0,
                                quanzhong.length() - 1);
                        double quanz = Double.parseDouble(qz);
                        finalScore += scoreseq * quanz / 100;
                    }
                    List gradeList = evagradedao.getAllGradeItem(bo
                            .getPlanGrade());
                    for (int m = 0; m < gradeList.size(); m++) {
                        EvaGradeItemBO itembo = (EvaGradeItemBO) gradeList
                                .get(m);
                        double low = Double.parseDouble(itembo.getLowValue());
                        double hi = Double.parseDouble(itembo.getHighValue());
                        if (finalScore >= low && finalScore < hi) {
                            bo1.setGradeItem(itembo.getItemID());
                        }
                    }
                    bo1.setScore(nf.format(finalScore));
                    jobestimatdao.saveOrUpdateBo(bo1);
                }
                List jobList2 = jobestimatdao.findEvaJobEstimateBOForSumSort(bo.getPlanId());
                if (jobList2 != null && jobList2.size() > 0) {
                    for (int i = 0; i < jobList2.size(); i++) {
                        EvaJobEstimateBO job = (EvaJobEstimateBO) jobList2.get(i);
                        job.setSumSort(String.valueOf(i + 1));
                        jobestimatdao.saveOrUpdateBo(job);
                    }
                }
            }
        } else {
            List masterlist = taskdao.getAllEvaTaskMasterBO(bo.getPlanId());
            if (masterlist != null && masterlist.size() > 0) {
                for (int i = 0; i < masterlist.size(); i++) {
                    EvaTaskMasterBO taskbo = (EvaTaskMasterBO) masterlist
                            .get(i);
                    double finalScore = 0;
                    List list2 = taskdao.findEvaTaskEstimateBOByMasterId(taskbo
                            .getMasterId());
                    if (list2 != null && list2.size() > 0) {
                        for (int j = 0; j < list2.size(); j++) {
                            EvaTaskEstimateBO estimatebo = (EvaTaskEstimateBO) list2
                                    .get(j);
                            if (estimatebo.getPurview() != null
                                    && estimatebo.getScore() != null
                                    && !"".equals(estimatebo.getPurview())
                                    && !"".equals(estimatebo.getScore())) {
                                double qz = Double.parseDouble(estimatebo
                                        .getPurview());
                                double score = Double.parseDouble(estimatebo
                                        .getScore());
                                finalScore += qz * score / 100;
                            }
                        }
                    }
                    List gradeList = evagradedao.getAllGradeItem(bo
                            .getPlanGrade());
                    for (int m = 0; m < gradeList.size(); m++) {
                        EvaGradeItemBO itembo = (EvaGradeItemBO) gradeList
                                .get(m);
                        double low = Double.parseDouble(itembo.getLowValue());
                        double hi = Double.parseDouble(itembo.getHighValue());
                        if (finalScore >= low && finalScore < hi) {
                            taskbo.setGradeItem(itembo.getItemID());
                        }
                    }
                    taskbo.setScore(nf.format(finalScore));
                    taskdao.saveOrUpdateBo(taskbo);
                }
                List taskList2 = taskdao.getAllEvaTaskMasterBOForSumSort(bo.getPlanId());
                if (taskList2 != null && taskList2.size() > 0) {
                    for (int i = 0; i < taskList2.size(); i++) {
                        EvaTaskMasterBO task = (EvaTaskMasterBO) taskList2.get(i);
                        task.setSumSort(String.valueOf(i + 1));
                        taskdao.saveOrUpdateBo(task);
                    }
                }
            }
        }
    }

    public List getPersonType() throws SysException {
        return scoredao.getPersonType();
    }

    public List getAllObjectByObjectId(String objectid) throws SysException {
        return scoredao.getAllObjectByObjectId(objectid);
    }

    public List getAllScoreByObjectIdAndItemId(String objectid, String itemid)
            throws SysException {
        return scoredao.getAllScoreByObjectIdAndItemId(objectid, itemid);
    }

    public List getAllEvaScoreBOByObjIdAndMasterId(String objId, String masterId)
            throws SysException {
        return this.scoredao.getAllEvaScoreBOByObjIdAndMasterId(objId, masterId);
    }

    public EvaScoreBO findEvaScoreBOByObjIdMasterIdAndItemId(String objId, String masterId, String itemId) throws SysException {
        return this.scoredao.findEvaScoreBOByObjIdMasterIdAndItemId(objId, masterId, itemId);
    }

    public Hashtable getEvaScoreBOByPlanIdAndPersonIdForHash(String personId, String[] objId) throws SysException {
        Hashtable ht = new Hashtable();
        List list = scoredao.getEvaScoreBOByPlanIdAndPersonId(personId, objId);
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                EvaScoreBO bo = (EvaScoreBO) list.get(i);
                ht.put(bo.getObjectID() + bo.getMasterID() + bo.getItemID(), bo);
            }
        }
        return ht;
    }

    public Hashtable getEvaScoreBOForItemHash(String[] objId, String temid) throws SysException {
        Hashtable ht = new Hashtable();
        List list = this.evakeydao.getAllItemByTemplateID(temid);
        List scoreList = this.scoredao.getAllScoreByObjectIdsAndTemId(objId, temid);
        for (int i = 0; i < objId.length; i++) {
            for (int j = 0; j < list.size(); j++) {
                List result = new ArrayList();
                TemplateItemBO bo = (TemplateItemBO) list.get(j);
                if (scoreList != null && scoreList.size() > 0) {
                    for (int m = 0; m < scoreList.size(); m++) {
                        EvaScoreBO scorebo = (EvaScoreBO) scoreList.get(m);
                        if (scorebo.getObjectID().equals(objId[i]) && scorebo.getItemID().equals(bo.getItemID())) {
                            result.add(scorebo);
                        }
                    }
                }
                ht.put(objId[i] + bo.getItemID(), result);
            }
        }
        return ht;
    }

    public List getAllEvaMastersVOByPlanId(String planId) throws SysException {
        String sql = "select distinct master_type,template_id from v_evamasters where plan_id='" + planId + "'";
        CellVO[] cv = new CellVO[2];
        cv[0] = new CellVO();
        cv[0].setItemId("master_type");

        cv[1] = new CellVO();
        cv[1].setItemId("template_id");

        Vector rs = activeapi.getDataListBySql(cv, sql);
        List list = new ArrayList();
        for (int i = 0; i < rs.size(); i++) {
            CellVO row[] = (CellVO[]) rs.get(i);
            EvaMastersVO vo = new EvaMastersVO();
            vo.setMasterType(row[0].getValue());
            vo.setTemplateId(row[1].getValue());
            list.add(vo);
        }
        return list;
    }


    public EvaScoreDAO getScoredao() {
        return scoredao;
    }

    public void setScoredao(EvaScoreDAO scoredao) {
        this.scoredao = scoredao;
    }

}
