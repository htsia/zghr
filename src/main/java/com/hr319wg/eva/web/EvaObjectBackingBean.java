package com.hr319wg.eva.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaCaclScoresBO;
import com.hr319wg.eva.pojo.bo.EvaDefaultLevelBO;
import com.hr319wg.eva.pojo.bo.EvaKeyItemBO;
import com.hr319wg.eva.pojo.bo.EvaLevelPurview;
import com.hr319wg.eva.pojo.bo.EvaMasterBO;
import com.hr319wg.eva.pojo.bo.EvaObjectsBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaScoreBO;
import com.hr319wg.eva.pojo.bo.EvaTempMasterBO;
import com.hr319wg.eva.pojo.bo.EvaTemplateBO;
import com.hr319wg.eva.pojo.bo.TemplateItemBO;
import com.hr319wg.eva.pojo.vo.EvaObjectsVO;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.ucc.IEvaObjectsUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.eva.ucc.IEvaScoreUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class EvaObjectBackingBean extends BaseBackingBean {
    private IEvaKeyItemUCC itemkeyUCC;
    private IEvaObjectsUCC objectUCC;
    private IEvaScoreUCC scoreUCC;
    private IEvaPlanUCC evaplanucc;

    private String planID;
    private String orgId;
    private String orgName;
    private String condiValue;
    private String personType;
    private String personTypeDes;
    private PageVO pagevo = new PageVO();
    private List personList;
    private String initAdd; // 设置客体
    private String personIds;
    private String personNames;
    private String objectID;
    private List templates;
    private String templateId;
    private String isPurview;
    private String queryValue;
    private String planMode;

    private String initmaster; // 设置主体
    private String addmaster; // 设置主体
    private EvaObjectsVO objectvo = new EvaObjectsVO();
    private EvaMasterBO masterbo = new EvaMasterBO();
    private EvaTempMasterBO tempmasterbo = new EvaTempMasterBO();
    private String masterID;
    private List masterPersonList;
    private List tempMasterPersonList = new ArrayList();
    private String initPage;// 设置临时主体
    private String saveTempMaster;// 设置临时主体
    private String purview;
    private String initEdit;
    private HashMap map = new HashMap();
    private String planId;
    private String planName;
    private String planModelDes;

    //层次权重
    private String initLevelPurview;
    private List levelPurviewList;
    private String personName;
    private String addLevelPurview;
    private EvaLevelPurview levelPurviewbo = new EvaLevelPurview();
    private String levelId;
    private String initDefaultLevelPurview;
    private List defaultPurviewList;
    private String addDefaultLevelPurview;
    private EvaDefaultLevelBO defaultbo = new EvaDefaultLevelBO();
    private String method;

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getPlanMode() {
        return planMode;
    }

    public void setPlanMode(String planMode) {
        this.planMode = planMode;
    }

    public String getQueryValue() {
        return queryValue;
    }

    public void setQueryValue(String queryValue) {
        this.queryValue = queryValue;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getPersonIds() {
        return personIds;
    }

    public void setPersonIds(String personIds) {
        this.personIds = personIds;
    }

    public String getPersonNames() {
        return personNames;
    }

    public void setPersonNames(String personNames) {
        this.personNames = personNames;
    }

    public String getPlanModelDes() {
        return planModelDes;
    }

    public void setPlanModelDes(String planModelDes) {
        this.planModelDes = planModelDes;
    }

    public String getAddDefaultLevelPurview() {
        try {
            if (super.getRequestParameter("planid") != null) {
                planId = super.getRequestParameter("planid");
                method = super.getRequestParameter("method");
            } else if (super.getRequestParameter("levelId") != null) {
                levelId = super.getRequestParameter("levelId");
                defaultbo = objectUCC.findDefaultLevelById(levelId);
                planId = defaultbo.getPlanId();
                method = super.getRequestParameter("method");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return addDefaultLevelPurview;
    }

    public void setAddDefaultLevelPurview(String addDefaultLevelPurview) {
        this.addDefaultLevelPurview = addDefaultLevelPurview;
    }

    public String saveDefaultLevelPurview() {
        try {
            List list = objectUCC.getDefaultLevelByPlanId(planId);
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    EvaDefaultLevelBO bo = (EvaDefaultLevelBO) list.get(i);
                    if (bo.getMasterType().equals(defaultbo.getMasterType()) && method.equals("add")) {
                        super.showMessageDetail("已设置该考核层次权重");
                        return "";
                    }
                }
            }
            if (method.equals("modify")) {
                defaultbo.setLevelId(levelId);
            } else {
                defaultbo.setLevelId(null);
            }
            defaultbo.setPlanId(planId);
            objectUCC.saveEvaDefaultLevel(defaultbo);
            queryDefultPurviewList();
        } catch (SysException e) {
            e.printStackTrace();
        }
        return "success";
    }

    public EvaDefaultLevelBO getDefaultbo() {
        return defaultbo;
    }

    public void setDefaultbo(EvaDefaultLevelBO defaultbo) {
        this.defaultbo = defaultbo;
    }

    public String getInitDefaultLevelPurview() {
        try {
            if (super.getRequestParameter("planid") != null) {
                planId = super.getRequestParameter("planid");
                planName = evaplanucc.findPlanById(planId).getPlanName();
                super.getHttpSession().setAttribute("defalutplanid", planId);
            }
            queryDefultPurviewList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return initDefaultLevelPurview;
    }

    public void queryDefultPurviewList() {
        try {
            planId = (String) super.getHttpSession().getAttribute("defalutplanid");
            defaultPurviewList = objectUCC.getDefaultLevelByPlanId(planId);
            if (defaultPurviewList != null && defaultPurviewList.size() > 0) {
                for (int i = 0; i < defaultPurviewList.size(); i++) {
                    EvaDefaultLevelBO bo = (EvaDefaultLevelBO) defaultPurviewList.get(i);
                    bo.setMasterType(CodeUtil.interpertCode(bo.getMasterType()));
                    defaultPurviewList.set(i, bo);
                }
            } else {
                defaultPurviewList = new ArrayList();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setInitDefaultLevelPurview(String initDefaultLevelPurview) {
        this.initDefaultLevelPurview = initDefaultLevelPurview;
    }

    public List getDefaultPurviewList() {
        return defaultPurviewList;
    }

    public void setDefaultPurviewList(List defaultPurviewList) {
        this.defaultPurviewList = defaultPurviewList;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String deleteLevalPurview() {
        try {
            objectUCC.deleteEvaLevelPurview(levelId);
            queryDefultPurviewList();
        } catch (SysException e) {
            e.printStackTrace();
        }
        return "";
    }

    public String deleteDefaultLevalPurview() {
        try {
            objectUCC.deleteEvaDefaultLevel(levelId);
        } catch (SysException e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getLevelId() {
        return levelId;
    }

    public void setLevelId(String levelId) {
        this.levelId = levelId;
    }

    public String saveLevelPurview() {
        try {
            List list = objectUCC.getAllLevelPurviewByObjectId(objectID);
            String method1 = (String) super.getHttpSession().getAttribute("method");
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    EvaLevelPurview bo = (EvaLevelPurview) list.get(i);
                    if (bo.getMasterType().equals(levelPurviewbo.getMasterType()) && method1.equals("add")) {
                        super.showMessageDetail("已设置该考核层次权重");
                        return "";
                    }
                }
            }
            String levelId1 = (String) super.getHttpSession().getAttribute("levelId");
            if (method1.equals("modify")) {
                levelPurviewbo.setLevelId(levelId1);
            } else {
                levelPurviewbo.setLevelId(null);
            }
            levelPurviewbo.setObjectId(objectID);
            objectUCC.saveEvaLevelPurview(levelPurviewbo);
        } catch (SysException e) {
            e.printStackTrace();
        }
        return "success";
    }

    public EvaLevelPurview getLevelPurviewbo() {
        return levelPurviewbo;
    }

    public void setLevelPurviewbo(EvaLevelPurview levelPurviewbo) {
        this.levelPurviewbo = levelPurviewbo;
    }

    public String getAddLevelPurview() {
        try {
            if (super.getRequestParameter("objectID") != null) {
                objectID = super.getRequestParameter("objectID");
                method = super.getRequestParameter("method");
                super.getHttpSession().setAttribute("method", method);
            } else if (super.getRequestParameter("levelId") != null) {
                levelId = super.getRequestParameter("levelId");
                levelPurviewbo = objectUCC.findEvaLevelPurviewById(levelId);
                objectID = levelPurviewbo.getObjectId();
                method = super.getRequestParameter("method");
                super.getHttpSession().setAttribute("method", method);
                super.getHttpSession().setAttribute("levelId", levelId);
            }
            if (super.getRequestParameter("deptId") != null) {
                orgId = super.getRequestParameter("deptId");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return addLevelPurview;
    }

    public void setAddLevelPurview(String addLevelPurview) {
        this.addLevelPurview = addLevelPurview;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public List getLevelPurviewList() {
        return levelPurviewList;
    }

    public void setLevelPurviewList(List levelPurviewList) {
        this.levelPurviewList = levelPurviewList;
    }

    public String getInitLevelPurview() {
        if (super.getRequestParameter("superId") != null) {
            orgId = super.getRequestParameter("superId");
        }
        if (super.getRequestParameter("objectID") != null) {
            objectID = super.getRequestParameter("objectID");
            super.getHttpSession().setAttribute("objectID", objectID);

            try {
                levelPurviewList = objectUCC.getAllLevelPurviewByObjectId(objectID);
                EvaObjectsBO objectbo = objectUCC.findEvaObjectBOById(objectID);
                personName = CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, objectbo.getPersonID());
                if (levelPurviewList != null && levelPurviewList.size() > 0) {
                    for (int i = 0; i < levelPurviewList.size(); i++) {
                        EvaLevelPurview bo = (EvaLevelPurview) levelPurviewList.get(i);
                        bo.setMasterType(CodeUtil.interpertCode(bo.getMasterType()));
                        levelPurviewList.set(i, bo);
                    }
                } else {
                    levelPurviewList = new ArrayList();
                }
            } catch (SysException e) {
                e.printStackTrace();
            }
        } else {
            objectID = (String) super.getHttpSession().getAttribute("objectID");
            try {
                levelPurviewList = objectUCC.getAllLevelPurviewByObjectId(objectID);
                EvaObjectsBO objectbo = objectUCC.findEvaObjectBOById(objectID);
                personName = CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, objectbo.getPersonID());
                if (levelPurviewList != null && levelPurviewList.size() > 0) {
                    for (int i = 0; i < levelPurviewList.size(); i++) {
                        EvaLevelPurview bo = (EvaLevelPurview) levelPurviewList.get(i);
                        bo.setMasterType(CodeUtil.interpertCode(bo.getMasterType()));
                        levelPurviewList.set(i, bo);
                    }
                } else {
                    levelPurviewList = new ArrayList();
                }
            } catch (SysException e) {
                e.printStackTrace();
            }
        }
        return initLevelPurview;
    }

    public void setInitLevelPurview(String initLevelPurview) {
        this.initLevelPurview = initLevelPurview;
    }

    public IEvaPlanUCC getEvaplanucc() {
        return evaplanucc;
    }

    public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
        this.evaplanucc = evaplanucc;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public HashMap getMap() {
        return map;
    }

    public void setMap(HashMap map) {
        this.map = map;
    }

    public void setInitEdit(String initEdit) {
        this.initEdit = initEdit;
    }

    public String getPurview() {
        return purview;
    }

    public void setPurview(String purview) {
        this.purview = purview;
    }

    public String getInitEdit() {
        if (super.getRequestParameter("objectID") != null) {
            objectID = super.getRequestParameter("objectID");
        }
        if (super.getRequestParameter("masterID") != null) {
            masterID = super.getRequestParameter("masterID");
        }
        return initEdit;
    }

    public String getSaveTempMaster() {
        try {
            tempmasterbo = objectUCC.getEvaTempMasterBO(masterID);
            masterbo.setObjectID(objectID);
            masterbo.setPersonID(tempmasterbo.getMasterName());
            masterbo.setPurview(purview);
            objectUCC.insertEvaMasterBO(masterbo);
            EvaObjectsVO vo = objectUCC.findEvaObject(objectID);
            List list = this.itemkeyUCC.getAllItemByTemplateID(vo.getTemplateID());
            for (int i = 0; i < list.size(); i++) {
                TemplateItemBO itembo = (TemplateItemBO) list.get(i);
                EvaKeyItemBO keybo = this.itemkeyUCC.getEvaKeyItemBO(itembo.getLinkID());
                if (!keybo.equals("2")) {
                    EvaScoreBO score = new EvaScoreBO();
                    score.setMasterID(this.masterbo.getMasterID());
                    score.setObjectID(this.objectID);
                    score.setItemID(itembo.getItemID());
                    this.scoreUCC.saveScore(score);
                }
            }
            masterbo.initPara();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "success";
    }

    public void setSaveTempMaster(String saveTempMaster) {
        this.saveTempMaster = saveTempMaster;
    }

    public String getInitPage() {
        if (super.getRequestParameter("objectID") != null) {
            objectID = super.getRequestParameter("objectID");
        }
        if (super.getRequestParameter("superId") != null) {
            orgId = super.getRequestParameter("superId");
        }
        queryTempMaster();
        return initPage;
    }

    public void queryTempMaster() {
        try {
            EvaObjectsBO obo = objectUCC.findEvaObjectBOById(objectID);
            planId = obo.getPlanID();
            tempMasterPersonList = objectUCC.getTempMasters(planId);

            for (int i = 0; i < tempMasterPersonList.size(); i++) {
                EvaTempMasterBO bo = (EvaTempMasterBO) tempMasterPersonList.get(i);
                map.put(String.valueOf(i), bo);
                bo.setMasterPName(SysCacheTool.findPersonById(bo.getMasterName()).getName());
                EvaMasterBO masterbo = objectUCC.getEvaMasterBOBymasterId(objectID, bo.getMasterName());
                if (masterbo != null && bo.getMasterName().equals(masterbo.getPersonID())) {
                    map.remove(String.valueOf(i));
                }
            }
            tempMasterPersonList.clear();
            for (int j = 0; j <= map.size(); j++) {
                if (map.get(String.valueOf(j)) != null) {
                    tempMasterPersonList.add(map.get(String.valueOf(j)));
                }
            }
        } catch (SysException e) {
            e.printStackTrace();
        }
    }

    public EvaTempMasterBO getTempmasterbo() {
        return tempmasterbo;
    }

    public void setTempmasterbo(EvaTempMasterBO tempmasterbo) {
        this.tempmasterbo = tempmasterbo;
    }

    public List getTempMasterPersonList() {
        return tempMasterPersonList;
    }

    public void setTempMasterPersonList(List tempMasterPersonList) {
        this.tempMasterPersonList = tempMasterPersonList;
    }

    public void setInitPage(String initPage) {
        this.initPage = initPage;
    }

    public String deletePersons() {
        try {
            String id = super.getRequestParameter("form1:personStr");
            if (id != null) {
                String[] ids = id.split(",");
                for (int i = 0; i < ids.length; i++) {
                    if (ids[i] != null && !ids[i].equals("")) {
                        objectUCC.deleteEvaObject(ids[i]);
                    }
                }
            }
        } catch (Exception e) {

        }
        return "";
    }

    public String getMasterID() {
        return masterID;
    }

    public void setMasterID(String masterID) {
        this.masterID = masterID;
    }

    public String bathDelMaster() {
        try {
            String ids = super.getRequestParameter("form1:masterStr");
            if (ids != null && !ids.equals("")) {
                String id[] = ids.split(",");
                for (int i = 0; i < id.length; i++) {
                    if (id[i] != null && !id[i].equals("")) {
                        EvaMasterBO mbo = objectUCC.findEvaMasterBOById(id[i]);
                        objectUCC.deleteEvaMasterBO(id[i]);
                        scoreUCC.deleteAllScore(id[i], this.objectID);
                        String planId = objectUCC.findEvaObjectBOById(objectID).getPlanID();
                        EvaPlanBO bo = this.evaplanucc.findPlanById(planId);
                        if (bo.getPruview().equals(EvaPlanBO.EVA_PRUVIEW_GROUP)) {
                            double purview = 0;
                            EvaLevelPurview pubo = objectUCC.getLevelPurviewByObjectIdAndType(objectID, mbo.getMasterType());
                            if (pubo != null && pubo.getPurview() != null && !pubo.getPurview().equals("")) {
                                purview = Double.parseDouble(pubo.getPurview());
                            }
                            List list = objectUCC.getMastersByMasterType(objectID, mbo.getMasterType());
                            if (list != null && list.size() > 0) {
                                NumberFormat nf1 = NumberFormat.getInstance();
                                if (bo.getLevelPers() != null && !bo.getLevelPers().equals("")) {
                                    int levelPers = Integer.parseInt(bo.getLevelPers());
                                    nf1.setMaximumFractionDigits(levelPers);
                                } else {
                                    nf1.setMaximumFractionDigits(2);
                                }
                                String pur = nf1.format(purview / list.size());
                                for (int m = 0; m < list.size(); m++) {
                                    EvaMasterBO embo = (EvaMasterBO) list.get(m);
                                    embo.setPurview(pur);
                                    objectUCC.saveEvaMasterBO(embo);
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String deleteMaster() {
        try {
            EvaMasterBO mbo = objectUCC.findEvaMasterBOById(masterID);
            objectUCC.deleteEvaMasterBO(this.masterID);
            scoreUCC.deleteAllScore(this.masterID, this.objectID);
            String planId = objectUCC.findEvaObjectBOById(objectID).getPlanID();
            EvaPlanBO bo = this.evaplanucc.findPlanById(planId);
            if (bo.getPruview().equals(EvaPlanBO.EVA_PRUVIEW_GROUP)) {
                double purview = 0;
                EvaLevelPurview pubo = objectUCC.getLevelPurviewByObjectIdAndType(objectID, mbo.getMasterType());
                if (pubo != null && pubo.getPurview() != null && !pubo.getPurview().equals("")) {
                    purview = Double.parseDouble(pubo.getPurview());
                }
                List list = objectUCC.getMastersByMasterType(objectID, mbo.getMasterType());
                if (list != null && list.size() > 0) {
                    NumberFormat nf1 = NumberFormat.getInstance();
                    if (bo.getLevelPers() != null && !bo.getLevelPers().equals("")) {
                        int levelPers = Integer.parseInt(bo.getLevelPers());
                        nf1.setMaximumFractionDigits(levelPers);
                    } else {
                        nf1.setMaximumFractionDigits(2);
                    }
                    String pur = nf1.format(purview / list.size());
                    for (int i = 0; i < list.size(); i++) {
                        EvaMasterBO embo = (EvaMasterBO) list.get(i);
                        embo.setPurview(pur);
                        objectUCC.saveEvaMasterBO(embo);
                    }
                }
            }
            queryMaster();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public EvaMasterBO getMasterbo() {
        return masterbo;
    }

    public void setMasterbo(EvaMasterBO masterbo) {
        this.masterbo = masterbo;
    }

    public String getAddmaster() {
        if (super.getRequestParameter("objectID") != null) {
            objectID = super.getRequestParameter("objectID");
            masterbo.setPersonID("");
            masterbo.setPersonName("");
        }
        if (super.getRequestParameter("deptId") != null) {
            orgId = super.getRequestParameter("deptId");
        }
        isPurview = (String) super.getHttpSession().getAttribute("isPurview");
        return addmaster;
    }

    public void setAddmaster(String addmaster) {
        this.addmaster = addmaster;
    }

    public String selPerson() {
        PersonBO[] pbos = (PersonBO[]) super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
        String personId = "";
        String personName = "";
        if (pbos != null && pbos.length > 0) {
            for (int i = 0; i < pbos.length; i++) {
                if (personId.equals("")) {
                    personId += pbos[i].getPersonId();
                } else {
                    personId += "," + pbos[i].getPersonId();
                }
                if (personName.equals("")) {
                    personName += pbos[i].getName();
                } else {
                    personName += "," + pbos[i].getName();
                }
            }
            masterbo.setPersonID(personId);
            masterbo.setPersonName(personName);
        } else {
            super.showMessageDetail("请选择考核人员！");
        }
        return "";
    }

    public String savemaster() {
        try {
            String pids[] = masterbo.getPersonID().split(",");
            EvaObjectsVO vo = objectUCC.findEvaObject(objectID);
            EvaPlanBO pb = evaplanucc.findPlanById(vo.getPlanID());
            NumberFormat nf = NumberFormat.getInstance();
            String pers = pb.getLevelPers();
            if (pers != null && !pers.equals("")) {
                nf.setMaximumFractionDigits(Integer.parseInt(pers));
            } else {
                nf.setMaximumFractionDigits(2);
            }
            List list = this.itemkeyUCC.getAllItemByTemplateID(vo.getTemplateID());
            Hashtable ht = this.itemkeyUCC.getAllKeyItemBOByTemlateId(vo.getTemplateID());
            for (int m = 0; m < pids.length; m++) {
                if (pids[m] != null && !pids[m].equals("")) {
                    List mastierlist = objectUCC.getMasterIdByOIdandPid(this.objectID, pids[m]);
                    if (mastierlist == null || mastierlist.size() == 0) {
                        EvaMasterBO msbo = new EvaMasterBO();
                        msbo.setObjectID(this.objectID);
                        msbo.setPersonID(pids[m]);
                        msbo.setMasterType(masterbo.getMasterType());
                        isPurview = (String) super.getHttpSession().getAttribute("isPurview");
                        if (isPurview != null && isPurview.equals("1")) {
                            List result = objectUCC.getMastersByMasterType(objectID, masterbo.getMasterType());
                            String allpur;
                            EvaLevelPurview levelbo = objectUCC.getLevelPurviewByObjectIdAndType(objectID, masterbo.getMasterType());
                            if (levelbo != null) {
                                if (levelbo.getPurview() != null && !levelbo.getPurview().equals("")) {
                                    allpur = levelbo.getPurview();
                                } else {
                                    allpur = "0";
                                }
                            } else {
                                allpur = "0";
                            }
                            double allcount = Double.parseDouble(allpur);
                            if (result != null && result.size() > 0) {
                                msbo.setPurview(new Double(nf.format(allcount / (result.size() + 1))).toString());
                                for (int i = 0; i < result.size(); i++) {
                                    EvaMasterBO masterbo1 = (EvaMasterBO) result.get(i);
                                    masterbo1.setPurview(new Double(nf.format(allcount / (result.size() + 1))).toString());
                                    objectUCC.updateMasterbo(masterbo1);
                                }
                            } else {
                                msbo.setPurview(allpur);
                            }
                            objectUCC.saveEvaMasterBO(msbo);
                            String mode = pb.getEvaModel();
                            if (mode.equals(EvaPlanBO.EVA_MODEL_TABLE)) {
                                for (int i = 0; i < list.size(); i++) {
                                    TemplateItemBO itembo = (TemplateItemBO) list.get(i);
                                    EvaKeyItemBO keybo = (EvaKeyItemBO) ht.get(itembo.getItemID());
                                    if (!keybo.getItemType().equals("2")) {
                                        EvaScoreBO score = new EvaScoreBO();
                                        score.setMasterID(msbo.getMasterID());
                                        score.setObjectID(this.objectID);
                                        score.setItemID(itembo.getItemID());
                                        this.scoreUCC.saveScore(score);
                                    }
                                }
                            } else if (mode.equals(EvaPlanBO.EVA_MODEL_ELECTION)) {
                                EvaScoreBO score = new EvaScoreBO();
                                score.setMasterID(msbo.getMasterID());
                                score.setObjectID(vo.getObjectID());
                                this.scoreUCC.saveScore(score);
                            }
                        } else {
                            msbo.setPurview(masterbo.getPurview());
                            objectUCC.saveEvaMasterBO(msbo);
                            String mode = pb.getEvaModel();
                            if (mode.equals(EvaPlanBO.EVA_MODEL_TABLE)) {
                                for (int i = 0; i < list.size(); i++) {
                                    TemplateItemBO itembo = (TemplateItemBO) list.get(i);
                                    EvaKeyItemBO keybo = (EvaKeyItemBO) ht.get(itembo.getItemID());
                                    if (!keybo.getItemType().equals("2")) {
                                        EvaScoreBO score = new EvaScoreBO();
                                        score.setMasterID(msbo.getMasterID());
                                        score.setObjectID(this.objectID);
                                        score.setItemID(itembo.getItemID());
                                        this.scoreUCC.saveScore(score);
                                    }
                                }
                            } else if (mode.equals(EvaPlanBO.EVA_MODEL_ELECTION)) {
                                EvaScoreBO score = new EvaScoreBO();
                                score.setMasterID(msbo.getMasterID());
                                score.setObjectID(vo.getObjectID());
                                this.scoreUCC.saveScore(score);
                            }
                        }
                    }
                }
            }
            masterbo.initPara();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public List getMasterPersonList() {
        return masterPersonList;
    }

    public void setMasterPersonList(List masterPersonList) {
        this.masterPersonList = masterPersonList;
    }

    public EvaObjectsVO getObjectvo() {
        return objectvo;
    }

    public void setObjectvo(EvaObjectsVO objectbo) {
        this.objectvo = objectbo;
    }

    public String getObjectID() {
        return objectID;
    }

    public void setObjectID(String objectID) {
        this.objectID = objectID;
    }

    public void queryMaster() {
        try {
            masterPersonList = objectUCC.getMasters(objectID, queryValue);
            for (int i = 0; i < masterPersonList.size(); i++) {
                EvaMasterBO ebo = (EvaMasterBO) masterPersonList.get(i);
                PersonBO pb = SysCacheTool.findPersonById(ebo.getPersonID());
                if (pb != null) {
                    ebo.setPersonName(pb.getName());
                    ebo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG,
                            pb.getDeptId()));
                }
                ebo.setMasterType(CodeUtil.interpertCode(ebo.getMasterType()));
                masterPersonList.set(i, ebo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getInitmaster() {
        try {
            if (super.getRequestParameter("superId") != null) {
                orgId = super.getRequestParameter("superId");
            }
            if (super.getRequestParameter("objectID") != null) {
                objectID = super.getRequestParameter("objectID");
                super.getHttpSession().setAttribute("objectID", objectID);
                objectvo = objectUCC.findEvaObject(objectID);
                if (objectvo != null) {
                    objectvo.setPersonName(CodeUtil.interpertCode(
                            CodeUtil.TYPE_PERSON, objectvo.getPersonID()));
                    if (objectvo.getTemplateID() != null && !objectvo.getTemplateID().equals("")) {
                        EvaTemplateBO tempbo = itemkeyUCC.findTemplateBO(objectvo
                                .getTemplateID());
                        objectvo.setTemplatename(tempbo.getTemplateName());

                    }
                }
                queryMaster();
            } else {
                objectID = (String) super.getHttpSession().getAttribute(
                        "objectID");
                objectvo = objectUCC.findEvaObject(objectID);
                if (objectvo != null) {
                    objectvo.setPersonName(CodeUtil.interpertCode(
                            CodeUtil.TYPE_PERSON, objectvo.getPersonID()));
                    if (objectvo.getTemplateID() != null && !objectvo.getTemplateID().equals("")) {
                        EvaTemplateBO tempbo = itemkeyUCC.findTemplateBO(objectvo.getTemplateID());
                        objectvo.setTemplatename(tempbo.getTemplateName());
                    }
                }
                queryMaster();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return initmaster;
    }

    public void setInitmaster(String initmaster) {
        this.initmaster = initmaster;
    }

    public List getTemplates() {
        return templates;
    }

    public void setTemplates(List templates) {
        this.templates = templates;
    }

    public String selPerson2() {
        PersonBO[] pbos = (PersonBO[]) super.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
        personIds = "";
        personNames = "";
        if (pbos != null && pbos.length > 0) {
            for (int i = 0; i < pbos.length; i++) {
                if (personIds.equals("")) {
                    personIds += pbos[i].getPersonId();
                } else {
                    personIds += "," + pbos[i].getPersonId();
                }
                if (personNames.equals("")) {
                    personNames += pbos[i].getName();
                } else {
                    personNames += "," + pbos[i].getName();
                }
            }
        } else {
            super.showMessageDetail("请选择考核客体！");
        }
        return "";
    }

    public String saveAddPerson() {
        try {
            String tempid = templateId;
            String id = personIds;
            if (id != null) {
                List list = objectUCC.getDefaultLevelByPlanId(this.planID);
                String[] ids = id.split(",");
                for (int i = 0; i < ids.length; i++) {
                    EvaObjectsBO bo = objectUCC.getEvaObjectsBOByPlanIdAndPersonId(planID, ids[i]);
                    if (ids[i] != null && !ids[i].equals("")) {
                        if (null == bo) {
                            bo = new EvaObjectsBO();
                            bo.setPersonID(ids[i]);
                            if (planMode.equals(EvaPlanBO.EVA_MODEL_TABLE)) {
                                bo.setTemplateID(tempid);
                            }
                            bo.setPlanID(this.planID);
                            objectUCC.savaEvaObject(bo);
                            if (planMode.equals(EvaPlanBO.EVA_MODEL_TABLE)) {
                                List itemList = itemkeyUCC.getAllItemByTemplateID(tempid);
                                if (itemList != null && itemList.size() > 0) {
                                    for (int j = 0; j < itemList.size(); j++) {
                                        TemplateItemBO itembo = (TemplateItemBO) itemList.get(j);
                                        EvaKeyItemBO keybo = itemkeyUCC.getEvaKeyItemBO(itembo.getLinkID());
                                        if (keybo.getItemType().equals("2")) {
                                            EvaCaclScoresBO cacl = new EvaCaclScoresBO();
                                            cacl.setObjectId(bo.getObjectID());
                                            cacl.setPurview(itembo.getScore());
                                            cacl.setItemId(itembo.getLinkID());
                                            scoreUCC.saveEvaCaclScoresBO(cacl);
                                        }
                                    }
                                }
                            }

                            if (list != null && list.size() > 0) {
                                for (int j = 0; j < list.size(); j++) {
                                    EvaDefaultLevelBO defaultbo = (EvaDefaultLevelBO) list.get(j);
                                    EvaLevelPurview levelbo = new EvaLevelPurview();
                                    levelbo.setMasterType(defaultbo.getMasterType());
                                    levelbo.setPurview(defaultbo.getPurview());
                                    levelbo.setObjectId(bo.getObjectID());
                                    objectUCC.saveEvaLevelPurview(levelbo);
                                }
                            }
                        }
                    }


                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitAdd() {
        try {
            if (super.getRequestParameter("planID") != null) {
                planID = super.getRequestParameter("planID");
                planMode = this.evaplanucc.findPlanById(planID).getEvaModel();
                personIds = "";
                personNames = "";
            }
            queryTemplate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return initAdd;
    }

    public void queryTemplate() {
        try {
            this.templates = new ArrayList();
            SelectItem si0 = new SelectItem();
            si0.setLabel("--请选择考核模板--");
            si0.setValue("-1");
            templates.add(si0);
            if (planID != null && !planID.equals("")) {
                EvaPlanBO planbo = evaplanucc.findPlanById(planID);
                if (planbo.getTemplates() != null && !planbo.getTemplates().equals("")) {
                    String ids[] = planbo.getTemplates().split(",");
                    String temIds = "";
                    for (int i = 0; i < ids.length; i++) {
                        if (ids[i] != null && !ids[i].equals("")) {
                            if (temIds.equals("")) {
                                temIds += "'" + ids[i] + "'";
                            } else {
                                temIds += ",'" + ids[i] + "'";
                            }
                        }
                    }
                    List list = itemkeyUCC.getAllTemplateByTemplateIds(temIds);
                    if (list != null && list.size() > 0) {
                        for (int i = 0; i < list.size(); i++) {
                            EvaTemplateBO bo = (EvaTemplateBO) list.get(i);
                            SelectItem si = new SelectItem();
                            si.setLabel(bo.getTemplateName());
                            si.setValue(bo.getTemplateID());
                            templates.add(si);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setInitAdd(String initAdd) {
        this.initAdd = initAdd;
    }

    public String getPlanID() {
        return planID;
    }

    public void setPlanID(String planID) {
        this.planID = planID;
    }

    public IEvaObjectsUCC getObjectUCC() {
        return objectUCC;
    }

    public void setObjectUCC(IEvaObjectsUCC objectUCC) {
        this.objectUCC = objectUCC;
    }

    public List getPersonList() {
        return personList;
    }

    public void setPersonList(List personList) {
        this.personList = personList;
    }

    public PageVO getPagevo() {
        return pagevo;
    }

    public void setPagevo(PageVO vo) {
        pagevo = vo;
    }

    public String first() {
        pagevo.setCurrentPage(1);
        doQuery();
        return "";
    }

    public String last() {
        pagevo.setCurrentPage(pagevo.getTotalPage());
        doQuery();
        return "";
    }

    public String pre() {
        if (pagevo.getCurrentPage() >= 2) {
            pagevo.setCurrentPage(pagevo.getCurrentPage() - 1);
            doQuery();
        }
        return "";
    }

    public String next() {
        if (pagevo.getCurrentPage() < pagevo.getTotalPage()) {
            pagevo.setCurrentPage(pagevo.getCurrentPage() + 1);
            doQuery();
        }
        return "";
    }

    public String doQuery() {
        try {
            String treeid = "";
            String limit = "";
            OrgBO org = SysCacheTool.findOrgById(this.orgId);
            if (org != null) {
                treeid = org.getTreeId();
            }
            planID = (String) super.getHttpSession().getAttribute("planId");
            String purMethod = evaplanucc.findPlanById(planID).getPruview();
            if (purMethod.equals(EvaPlanBO.EVA_PRUVIEW_GROUP)) {
                isPurview = "1";
                super.getHttpSession().setAttribute("isPurview", isPurview);
            } else {
                isPurview = "0";
                super.getHttpSession().setAttribute("isPurview", isPurview);
            }
            EvaPlanBO planbo = evaplanucc.findPlanById(planID);
            planName = planbo.getPlanName();
            planModelDes = planbo.getEvaModelDes();
            if (pagevo.getCurrentPage() == 0)
                pagevo.setCurrentPage(1);
            pagevo.setPageSize(30);
            List personList1 = this.objectUCC.getEvaObjects(this.pagevo,
                    planID, treeid, limit, condiValue);
            personList = new ArrayList();
            for (int i = 0; i < personList1.size(); i++) {
                EvaObjectsVO vo = (EvaObjectsVO) personList1.get(i);
                vo.setOrgid(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, vo
                        .getOrgid()));
                vo.setDeptid(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, vo
                        .getDeptid()));
                if (vo.getTemplateID() != null && !vo.getTemplateID().equals("")) {
                    EvaTemplateBO tempbo = itemkeyUCC.findTemplateBO(vo
                            .getTemplateID());
                    vo.setTemplatename(tempbo.getTemplateName());
                }
                List mList = objectUCC.getMasters(vo.getObjectID(), null);
                if (mList != null && mList.size() > 0) {
                    vo.setIsSetMaster("是");
                } else {
                    vo.setIsSetMaster("否");
                }
                personList.add(vo);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getCondiValue() {
        return condiValue;
    }

    public void setCondiValue(String condiValue) {
        this.condiValue = condiValue;
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType;
    }

    public String getPageInit() {
        if (super.getRequestParameter("orgId") != null) {
            orgId = super.getRequestParameter("orgId");
        }
        if (super.getRequestParameter("personType") != null) {
            personType = super.getRequestParameter("personType");
        }
        if (super.getRequestParameter("planID") != null) {
            planID = super.getRequestParameter("planID");
        }
        this.doQuery();
        return pageInit;
    }

    public String getPersonTypeDes() {
        if (personType == null || "".equals(personType)) {
            personTypeDes = "全部人员";
        } else {
            personTypeDes = "";
            String[] str = personType.split(",");
            for (int i = 0; i < str.length; i++) {
                personTypeDes += " " + CodeUtil.interpertCode("0135", str[i]);
            }
        }
        return personTypeDes;
    }

    public void setPersonTypeDes(String des) {
        personTypeDes = des;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        orgName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.orgId);
        return orgName;
    }

    public void setOrgName(String id) {
        this.orgName = id;
    }

    public IEvaKeyItemUCC getItemkeyUCC() {
        return itemkeyUCC;
    }

    public void setItemkeyUCC(IEvaKeyItemUCC ucc) {
        itemkeyUCC = ucc;
    }

    public IEvaScoreUCC getScoreUCC() {
        return scoreUCC;
    }

    public void setScoreUCC(IEvaScoreUCC scoreUCC) {
        this.scoreUCC = scoreUCC;
    }

    public String getIsPurview() {
        return isPurview;
    }

    public void setIsPurview(String isPurview) {
        this.isPurview = isPurview;
    }
}
