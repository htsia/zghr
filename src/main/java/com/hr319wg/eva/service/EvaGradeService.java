package com.hr319wg.eva.service;

import com.hr319wg.eva.dao.EvaGradeDAO;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.common.exception.SysException;

import java.util.Hashtable;
import java.util.List;

/**
 * 考核计划Service
 *
 * 对考核计划的增删改查处理.
 */
public class EvaGradeService {
    private EvaGradeDAO evagradedao;

    public EvaGradeBO getGradeByID(String id) throws SysException {
        return (EvaGradeBO)evagradedao.findBoById(EvaGradeBO.class,id);
    }
    public List getAllGradeItem(String id) throws SysException {
        return  evagradedao.getAllGradeItem(id);
    }
    public Hashtable getAllGradeItemForHash(String id)throws SysException{
    	Hashtable ht=new Hashtable();
    	List list=this.getAllGradeItem(id);
    	if(list!=null&&list.size()>0){
    		for(int i=0;i<list.size();i++){
	    		EvaGradeItemBO bo=(EvaGradeItemBO)list.get(i);
	    		ht.put(bo.getItemID(), bo);
    		}
    	}
    	return ht;
    }
    public List getAllGrade() throws SysException {
        return evagradedao.getAllGrade();
    }

    public void SaveGradeType(EvaGradeBO bo) throws SysException {
        evagradedao.saveOrUpdateBo(bo);
    }
    public void DeleteGradeType(EvaGradeBO bo) throws SysException {
        evagradedao.deleteBo(EvaGradeBO.class,bo.getGradeID());
    }

    public void SaveGradeItem(EvaGradeItemBO bo) throws SysException {
        evagradedao.saveOrUpdateBo(bo);
    }
    public void DeleteGradeItem(EvaGradeItemBO bo) throws SysException {
        evagradedao.deleteBo(EvaGradeItemBO.class,bo.getItemID());
    }
    public EvaGradeItemBO getGradeItem(String id)  throws SysException {
        return (EvaGradeItemBO)evagradedao.findBoById(EvaGradeItemBO.class,id);
    }

    public EvaGradeDAO getEvagradedao() {
        return evagradedao;
    }
    public void setEvagradedao(EvaGradeDAO dao) {
        this.evagradedao = dao;
    }
}
