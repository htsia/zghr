package com.hr319wg.eva.ucc.impl;

import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.service.EvaKeyItemService;
import com.hr319wg.eva.pojo.bo.*;
import com.hr319wg.common.exception.SysException;

import java.util.Hashtable;
import java.util.List;

/**
 * 考核计划UCC-接口类
 * 涉及到考核计划管理的逻辑处理接口.
 */
public class EvaKeyItemUCC implements IEvaKeyItemUCC {
    private EvaKeyItemService evakeyservice;

    public List getAllChildType(String type) throws SysException{
        return evakeyservice.getAllChildType(type);
    }
    public EvaKeyItemSetBO findItemkeySetBO(String itemID) throws SysException{
        return evakeyservice.findItemkeySetBO(itemID);
    }

    public void saveItemkeySetBO(EvaKeyItemSetBO bo) throws SysException{
        evakeyservice.saveItemkeySetBO(bo);
    }
    public void deleteItemkeySetBO(String itemId) throws SysException{
        evakeyservice.deleteItemkeySetBO(itemId);
    }

    public EvaKeyItemBO getEvaKeyItemBO(String itemID)throws SysException{
         return evakeyservice.getEvaKeyItemBO(itemID);
    }
    public void saveEvaKeyItemBO(EvaKeyItemBO bo)throws SysException{
        evakeyservice.saveEvaKeyItemBO(bo);
    }
    public void deleteEvaKeyItemBO(String itemID)throws SysException{
        evakeyservice.deleteEvaKeyItemBO(itemID);
    }
    public List getKeyItemList(String superID,String orgID)throws SysException{
        return evakeyservice.getKeyItemList(superID,orgID);
    }

    //---------------- 模板目录--------------
    public EvaTemplateSetBO findTemplateSetBO(String itemID) throws SysException{
         return evakeyservice.findTemplateSetBO(itemID);
    }
    public void saveTemplateSetBO(EvaTemplateSetBO bo) throws SysException{
        evakeyservice.saveTemplateSetBO(bo);
    }
    public void deleteTemplateSetBO(String itemId) throws SysException{
        evakeyservice.deleteTemplateSetBO(itemId);
    }
    public List getAllChildTemplateSet(String type) throws SysException{
        return evakeyservice.getAllChildTemplateSet(type);
    }

    //----------------模板----------------
    public List getAllTemplate(String set,String orguid) throws SysException{
        return  evakeyservice.getAllTemplate(set,orguid);
    }
    public List getAllOwnTemplate(String set,String orguid) throws SysException{
        return evakeyservice.getAllOwnTemplate(set,orguid);
    }
    public EvaTemplateBO findTemplateBO(String itemID) throws SysException{
         return evakeyservice.findTemplateBO(itemID);
    }
    public void saveTemplateBO(EvaTemplateBO bo) throws SysException{
        evakeyservice.saveTemplateBO(bo);
    }
    public void deleteTemplateBO(String itemId) throws SysException{
        evakeyservice.deleteTemplateBO(itemId);
    }

    //----------------模板项目-------------------
    public List getAllChildItemSet(String set) throws SysException{
        return evakeyservice.getAllChildItemSet(set);
    }
    public TemplateItemSetBO findTemplateItemSetBO(String itemID) throws SysException{
         return evakeyservice.findTemplateItemSetBO(itemID);
    }
    public void saveTemplateItemSetBO(TemplateItemSetBO bo) throws SysException{
        evakeyservice.saveTemplateItemSetBO(bo);
    }
    public void deleteTemplateItemSetBO(String itemId) throws SysException{
        evakeyservice.deleteTemplateItemSetBO(itemId);
    }

    public TemplateItemBO findTemplateItemBO(String itemID) throws SysException{
         return evakeyservice.findTemplateItemBO(itemID);
    }
    public void saveTemplateItemBO(TemplateItemBO bo) throws SysException{
        evakeyservice.saveTemplateItemBO(bo);
    }
    public void deleteTemplateItemBO(String itemId) throws SysException{
        evakeyservice.deleteTemplateItemBO(itemId);
    }
    public List getAllChildItem(String set) throws SysException{
        return evakeyservice.getAllChildItem(set);
    }
    public List getAllItemByTemplateID(String templateID) throws SysException{
        return evakeyservice.getAllItemByTemplateID(templateID);
    }
    public List getAllTemplateItemBOByKeyItemId(String linkId)throws SysException{
    	return this.evakeyservice.getAllTemplateItemBOByKeyItemId(linkId);
    }
    public List getKeyItemListBySetId(String superId)throws SysException{
    	return this.evakeyservice.getKeyItemListBySetId(superId);
    }
    public Hashtable getAllChildItemForHash(String set)throws SysException{
    	return this.evakeyservice.getAllChildItemForHash(set);
    }
    public Hashtable getAllKeyItemBOByTemlateId(String templateId)throws SysException{
    	return this.evakeyservice.getAllKeyItemBOByTemlateId(templateId);
    }
    public List getAllTemplateByTemplateIds(String templateIds)throws SysException{
    	return this.evakeyservice.getAllTemplateByTemplateIds(templateIds);
    }
    
    public EvaKeyItemService getEvakeyservice() {
        return evakeyservice;
    }
    public void setEvakeyservice(EvaKeyItemService service) {
        this.evakeyservice = service;
    }
}
