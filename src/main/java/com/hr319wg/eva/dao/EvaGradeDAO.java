package com.hr319wg.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;

import java.util.List;

/**
 * ���˼ƻ�DAO
 * ��ע�ڿ��˼ƻ���(eva_plan)�����ݿ������װ.
 */
public class EvaGradeDAO extends BaseDAO {
    public List getAllGrade() throws SysException {
        String hsql="select bo from EvaGradeBO bo";
        return this.hibernatetemplate.find(hsql);
    }

    public List getAllGradeItem(String id) throws SysException {
        String hsql="select bo from EvaGradeItemBO bo where bo.gradeID='"+id+"' order by bo.showSeq";
        return this.hibernatetemplate.find(hsql);
    }
   

}
