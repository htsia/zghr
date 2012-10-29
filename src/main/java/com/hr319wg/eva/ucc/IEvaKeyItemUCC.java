package com.hr319wg.eva.ucc;

import com.hr319wg.eva.pojo.bo.*;
import com.hr319wg.common.exception.SysException;

import java.util.Hashtable;
import java.util.List;

/**
 * 考核计划UCC-接口类
 */

public interface IEvaKeyItemUCC {
    public List getAllChildType(String type) throws SysException;
    public EvaKeyItemSetBO findItemkeySetBO(String itemID) throws SysException;
    public void saveItemkeySetBO(EvaKeyItemSetBO bo) throws SysException;
    public void deleteItemkeySetBO(String itemId) throws SysException;
    public List getKeyItemListBySetId(String superId)throws SysException;

    public List getKeyItemList(String superID,String orgID)throws SysException;
    public EvaKeyItemBO getEvaKeyItemBO(String itemID)throws SysException;
    public void saveEvaKeyItemBO(EvaKeyItemBO bo)throws SysException;
    public void deleteEvaKeyItemBO(String itemID)throws SysException;
    public EvaTemplateSetBO findTemplateSetBO(String itemID) throws SysException;
    public void saveTemplateSetBO(EvaTemplateSetBO bo) throws SysException;
    public void deleteTemplateSetBO(String itemId) throws SysException;
    public List getAllChildTemplateSet(String type) throws SysException;

    public List getAllTemplate(String set,String orguid) throws SysException;
    public List getAllOwnTemplate(String set,String orguid) throws SysException;    
    public EvaTemplateBO findTemplateBO(String itemID) throws SysException;
    public void saveTemplateBO(EvaTemplateBO bo) throws SysException;
    public void deleteTemplateBO(String itemId) throws SysException;

    public List getAllChildItemSet(String set) throws SysException;
    public TemplateItemSetBO findTemplateItemSetBO(String itemID) throws SysException;
    public void saveTemplateItemSetBO(TemplateItemSetBO bo) throws SysException;
    public void deleteTemplateItemSetBO(String itemId) throws SysException;
    
    public TemplateItemBO findTemplateItemBO(String itemID) throws SysException;
    public void saveTemplateItemBO(TemplateItemBO bo) throws SysException;
    public void deleteTemplateItemBO(String itemId) throws SysException;
    public List getAllChildItem(String set) throws SysException;
    public List getAllItemByTemplateID(String templateID) throws SysException;
    public List getAllTemplateItemBOByKeyItemId(String linkId)throws SysException;
    
    public Hashtable getAllChildItemForHash(String set)throws SysException;
    public Hashtable getAllKeyItemBOByTemlateId(String templateId)throws SysException;
    public List getAllTemplateByTemplateIds(String templateIds)throws SysException;
}
