package com.hr319wg.attence.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;

import java.util.List;

public class AttItemPowerDAO extends BaseDAO {
    public List getAllAttItemPowerByPerson(String PersonID,String SetID) throws SysException {
        String sql="select bo from AttItemPowerBO bo where  bo.setID='"+SetID+"' and bo.personID='"+PersonID+"'";
        return this.hibernatetemplate.find(sql);
    }
}
