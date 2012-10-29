package com.hr319wg.eva.ucc;

import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.common.exception.SysException;

import java.util.Hashtable;
import java.util.List;

/**
 * 考核计划UCC-接口类
 */

public interface IEvaGradeUCC {
    public EvaGradeBO getGradeByID(String id) throws SysException ;
    public List getAllGrade() throws SysException ;
    public void SaveGradeType(EvaGradeBO bo) throws SysException;
    public void DeleteGradeType(EvaGradeBO bo) throws SysException;

    public List getAllGradeItem(String id) throws SysException;
    public void DeleteGradeItem(EvaGradeItemBO bo) throws SysException;
    public EvaGradeItemBO getGradeItem(String id)  throws SysException;
    public void SaveGradeItem(EvaGradeItemBO bo) throws SysException;
    public Hashtable getAllGradeItemForHash(String id)throws SysException;
}
