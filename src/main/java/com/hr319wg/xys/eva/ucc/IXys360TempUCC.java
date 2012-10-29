package com.hr319wg.xys.eva.ucc;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempItemBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempLibBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempSetBO;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: ÏÂÎç2:37
 * To change this template use File | Settings | File Templates.
 */
public interface IXys360TempUCC {
    public List getXys360TempLibBO(String superId)throws SysException;
    public Xys360TempLibBO findXys360TempLibBO(String libId)throws SysException;
    public void saveXys360TempLibBO(Xys360TempLibBO bo)throws SysException;
    public void deleteXys360TempLibBO(String libId)throws SysException;

    public List getXys360TempBOByLibId(String libId)throws SysException;
    public List getAllXys360TempBO()throws SysException;
    public Xys360TempBO findXys360TempBO(String tempId)throws SysException;
    public void saveXys360TempBO(Xys360TempBO bo)throws SysException;
    public void deleteXys360TempBO(String tempId)throws SysException;

    public List getXys360TempSetBOByTempId(String tempId)throws SysException;
    public Xys360TempSetBO findXys360TempSetBOById(String setId)throws SysException;
    public void saveXys360TempSetBO(Xys360TempSetBO bo)throws SysException;
    public void deleteXys360TempSetBO(String setId)throws SysException;

    public List getXys360TempItemBOBySetId(String setId)throws SysException;
    public Xys360TempItemBO findXys360TempItemBOById(String itemId)throws SysException;
    public void saveXys360TempItemBO(Xys360TempItemBO bo)throws SysException;
    public void deleteXys360TempItemBO(String itemId)throws SysException;
    public List getXys360TempItemBOByTempId(String tempId)throws SysException;
    
    public void deleteAll(List list)throws SysException;
}
