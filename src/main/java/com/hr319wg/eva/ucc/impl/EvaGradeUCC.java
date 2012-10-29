package com.hr319wg.eva.ucc.impl;

import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.service.EvaGradeService;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.common.exception.SysException;

import java.util.Hashtable;
import java.util.List;

/**
 * ���˼ƻ�UCC-�ӿ���
 * �漰�����˼ƻ�������߼�����ӿ�.
 */
public class EvaGradeUCC implements IEvaGradeUCC {
    private EvaGradeService evagradeservice;

    public EvaGradeBO getGradeByID(String id) throws SysException {
        return evagradeservice.getGradeByID(id);
    }
    public List getAllGrade() throws SysException {
        return evagradeservice.getAllGrade();
    }
    public void SaveGradeType(EvaGradeBO bo) throws SysException {
         evagradeservice.SaveGradeType(bo);
    }
    public void DeleteGradeType(EvaGradeBO bo) throws SysException {
         evagradeservice.DeleteGradeType(bo);
    }

    public List getAllGradeItem(String id) throws SysException {
        return evagradeservice.getAllGradeItem(id);
    }
    public void SaveGradeItem(EvaGradeItemBO bo) throws SysException {
        evagradeservice.SaveGradeItem(bo);
    }
    public void DeleteGradeItem(EvaGradeItemBO bo) throws SysException {
         evagradeservice.DeleteGradeItem(bo);
    }
    public EvaGradeItemBO getGradeItem(String id)  throws SysException {
          return evagradeservice.getGradeItem(id);
    }
    public EvaGradeService getEvagradeservice() {
        return evagradeservice;
    }
    public void setEvagradeservice(EvaGradeService service) {
        this.evagradeservice = service;
    }
    public Hashtable getAllGradeItemForHash(String id)throws SysException{
    	return this.evagradeservice.getAllGradeItemForHash(id);
    }
}
