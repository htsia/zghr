package com.hr319wg.eva.dao;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;

import java.util.Hashtable;
import java.util.List;

public class EvaKeyItemDAO extends BaseDAO {
   public List getAllChildType(String type) throws SysException{
       String hsql="select bo from EvaKeyItemSetBO bo where bo.parentID='"+type+"'";
       return this.hibernatetemplate.find(hsql);
   }
    public List getKeyItemList(String superID,String orgID)throws SysException{
        String hsql="select bo from EvaKeyItemBO bo where bo.setID='"+superID+"' and (bo.orguid='-1' or bo.orguid='"+orgID+"') order by bo.showSEQ";
        return this.hibernatetemplate.find(hsql);
    }
    public List getKeyItemListBySetId(String superId)throws SysException{
    	String hsql="select bo from EvaKeyItemBO bo where bo.setID='"+superId+"'";
        return this.hibernatetemplate.find(hsql);
    }
    //----------- 模板目录 -------------------------------
    public List getAllChildTemplateSet(String type) throws SysException{
        String hsql="select bo from EvaTemplateSetBO bo where bo.parentID='"+type+"'";
        return this.hibernatetemplate.find(hsql);
    }

    public List getAllTemplate(String set,String orguid) throws SysException{
        String hsql="select bo from EvaTemplateBO bo where  (bo.orguid='-1'  or bo.orguid='"+orguid+"')";
        if (set!=null && !"".equals(set)){
            hsql+=" and bo.setID='"+set+"'";
        }
        return this.hibernatetemplate.find(hsql);
    }
    public List getAllTemplateByTemplateIds(String templateIds)throws SysException{
    	String hql="select bo from EvaTemplateBO bo where bo.templateID in("+templateIds+") order by bo.templateName";
    	return this.hibernatetemplate.find(hql);
    }
   
    public List getAllOwnTemplate(String set,String orguid) throws SysException{
        String hsql="select bo from EvaTemplateBO bo where bo.setID='"+set+"' and  bo.createOrguid='"+orguid+"'";
        return this.hibernatetemplate.find(hsql);
    }

    //----------------模板项目-------------------
    public List getAllChildItemSet(String set) throws SysException{
        String hsql="select bo from TemplateItemSetBO bo where bo.parentID='"+set+"'";
        return this.hibernatetemplate.find(hsql);
    }
    public List getAllChildItem(String set) throws SysException{
        String hsql="select bo from TemplateItemBO bo where bo.setID='"+set+"'";
        return this.hibernatetemplate.find(hsql);
    }
    public List getAllItemByTemplateID(String templateID) throws SysException{
        String hsql="select bo from TemplateItemBO bo where bo.templateID='"+templateID+"'";
        return this.hibernatetemplate.find(hsql);
    }
    
    public List getAllTemplateItemBOByKeyItemId(String linkId)throws SysException{
    	String hql="select bo from TemplateItemBO bo where bo.linkID='"+linkId+"'";
    	return this.hibernatetemplate.find(hql);
    }

}
