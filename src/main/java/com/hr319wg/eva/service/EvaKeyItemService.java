package com.hr319wg.eva.service;

import com.hr319wg.eva.dao.EvaGradeDAO;
import com.hr319wg.eva.dao.EvaKeyItemDAO;
import com.hr319wg.eva.pojo.bo.*;
import com.hr319wg.common.exception.SysException;

import java.util.Hashtable;
import java.util.List;

public class EvaKeyItemService {
    private EvaKeyItemDAO evakeydao;

    public List getAllChildType(String type) throws SysException{
        return  evakeydao.getAllChildType(type);
    }
    public EvaKeyItemSetBO findItemkeySetBO(String itemID) throws SysException{
         return (EvaKeyItemSetBO)evakeydao.findBoById(EvaKeyItemSetBO.class,itemID);
    }
    public void saveItemkeySetBO(EvaKeyItemSetBO bo) throws SysException{
        evakeydao.saveOrUpdateBo(bo);
    }
    public void deleteItemkeySetBO(String itemId) throws SysException{
        evakeydao.deleteBo(EvaKeyItemSetBO.class,itemId);
    }
    public List getKeyItemListBySetId(String superId)throws SysException{
    	return this.evakeydao.getKeyItemListBySetId(superId);
    }

    //------------------------------------------
    public EvaKeyItemBO getEvaKeyItemBO(String itemID)throws SysException{
         return (EvaKeyItemBO)evakeydao.findBoById(EvaKeyItemBO.class,itemID);
    }
    public void deleteEvaKeyItemBO(String itemID)throws SysException{
         evakeydao.deleteBo(EvaKeyItemBO.class,itemID);
    }
    public void saveEvaKeyItemBO(EvaKeyItemBO bo)throws SysException{
         evakeydao.saveOrUpdateBo(bo);
    }
    public List getKeyItemList(String superID,String orgID)throws SysException{
        return evakeydao.getKeyItemList( superID, orgID);
    }

    //---------------------- 模板目录----------------------
    public EvaTemplateSetBO findTemplateSetBO(String itemID) throws SysException{
         return (EvaTemplateSetBO)evakeydao.findBoById(EvaTemplateSetBO.class,itemID);
    }
    public void saveTemplateSetBO(EvaTemplateSetBO bo) throws SysException{
        evakeydao.saveOrUpdateBo(bo);
    }
    public void deleteTemplateSetBO(String itemId) throws SysException{
        evakeydao.deleteBo(EvaTemplateSetBO.class,itemId);
    }
    public List getAllChildTemplateSet(String type) throws SysException{
        return evakeydao.getAllChildTemplateSet(type);
    }

    //----------------模板----------------
    public List getAllTemplate(String set,String orguid) throws SysException{
        return  evakeydao.getAllTemplate(set,orguid);
    }
    public EvaTemplateBO findTemplateBO(String itemID) throws SysException{
         return (EvaTemplateBO)evakeydao.findBoById(EvaTemplateBO.class,itemID);
    }
    public void saveTemplateBO(EvaTemplateBO bo) throws SysException{
        evakeydao.saveOrUpdateBo(bo);
    }
    public void deleteTemplateBO(String itemId) throws SysException{
        evakeydao.deleteBo(EvaTemplateBO.class,itemId);
    }
    public List getAllOwnTemplate(String set,String orguid) throws SysException{
        return evakeydao.getAllOwnTemplate(set,orguid);
    }

    //----------------模板项目-------------------
    public List getAllChildItemSet(String set) throws SysException{
        return evakeydao.getAllChildItemSet(set);
    }
    public Hashtable getAllChildItemForHash(String set)throws SysException{
    	Hashtable ht=new Hashtable();
    	List setList=this.evakeydao.getAllChildItemSet(set);
    	if(setList!=null&&setList.size()>0){
    		for(int i=0;i<setList.size();i++){
    			TemplateItemSetBO bo=(TemplateItemSetBO)setList.get(i);
    			List itemList=evakeydao.getAllChildItem(bo.getSetID());
    			ht.put(bo.getSetID(), itemList);
    		}
    	}
    	return ht;
    }
    public Hashtable getAllKeyItemBOByTemlateId(String templateId)throws SysException{
    	Hashtable ht=new Hashtable();
    	List list=this.evakeydao.getAllItemByTemplateID(templateId);
    	if(list!=null&&list.size()>0){
    		for(int i=0;i<list.size();i++){
    			TemplateItemBO bo=(TemplateItemBO)list.get(i);
    			EvaKeyItemBO bo1=this.getEvaKeyItemBO(bo.getLinkID());
    			ht.put(bo.getItemID(), bo1);
    		}
    	}
    	return ht;
    }
    public TemplateItemSetBO findTemplateItemSetBO(String itemID) throws SysException{
         return (TemplateItemSetBO)evakeydao.findBoById(TemplateItemSetBO.class,itemID);
    }
    public void saveTemplateItemSetBO(TemplateItemSetBO bo) throws SysException{
        evakeydao.saveOrUpdateBo(bo);
    }
    public void deleteTemplateItemSetBO(String itemId) throws SysException{
        evakeydao.deleteBo(TemplateItemSetBO.class,itemId);
    }
    public List getAllChildItem(String set) throws SysException{
        return evakeydao.getAllChildItem(set);
    }
    public TemplateItemBO findTemplateItemBO(String itemID) throws SysException{
         return (TemplateItemBO)evakeydao.findBoById(TemplateItemBO.class,itemID);
    }
    public void saveTemplateItemBO(TemplateItemBO bo) throws SysException{
        evakeydao.saveOrUpdateBo(bo);
    }
    public void deleteTemplateItemBO(String itemId) throws SysException{
        evakeydao.deleteBo(TemplateItemBO.class,itemId);
    }
    public List getAllItemByTemplateID(String templateID) throws SysException{
        return  evakeydao.getAllItemByTemplateID(templateID);
    }
    public List getAllTemplateItemBOByKeyItemId(String linkId)throws SysException{
    	return this.evakeydao.getAllTemplateItemBOByKeyItemId(linkId);
    }
    public List getAllTemplateByTemplateIds(String templateIds)throws SysException{
    	return this.evakeydao.getAllTemplateByTemplateIds(templateIds);
    }
    public EvaKeyItemDAO getEvakeydao() {
        return evakeydao;
    }
    public void setEvakeydao(EvaKeyItemDAO dao) {
        this.evakeydao = dao;
    }
}
