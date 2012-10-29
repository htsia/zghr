package com.hr319wg.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.pojo.bo.*;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.util.CommonFuns;

import javax.faces.model.SelectItem;
import java.util.List;
import java.util.ArrayList;

public class templateBackingBean extends BaseBackingBean {
    private IEvaKeyItemUCC itemkeyUCC;
    private String unitName;
    private String setID;
    private EvaTemplateSetBO setbo=new EvaTemplateSetBO();
    private String initset;

    //-----------------------项目----------------
    private String initList;
    private List itemList;
    private String itemID;
    private String editItem;
    private EvaTemplateBO templateBO=new EvaTemplateBO();
    private List orgList;

    //------------------------------内容----------------
    private String templateID;
    private String initItemSet;
    private String initContent;
    private String itemSet;
    private String initItemList;
    private String initItemEdit;
    private List evaitems;
    private TemplateItemSetBO itemsetbo=new TemplateItemSetBO();
    
    public String copyTemplate(){
    	 try{
    		 EvaTemplateBO tbo=itemkeyUCC.findTemplateBO(itemID);
    		 EvaTemplateBO newtbo=new EvaTemplateBO();
    		 newtbo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
    		 newtbo.setCreateOrguid(tbo.getCreateOrguid());
    		 newtbo.setCurscore(tbo.getCurscore());
    		 newtbo.setIsUse(tbo.getIsUse());
    		 newtbo.setLevel(tbo.getLevel());
    		 newtbo.setOrguid(tbo.getOrguid());
    		 newtbo.setSetID(tbo.getSetID());
    		 newtbo.setSetName(tbo.getSetName());
    		 newtbo.setShowSEQ(tbo.getShowSEQ());
    		 newtbo.setTemplateName(tbo.getTemplateName());
    		 newtbo.setTotalscore(tbo.getTotalscore());
    		 itemkeyUCC.saveTemplateBO(newtbo);
    		 List itemSetList=itemkeyUCC.getAllChildItemSet(itemID);
    		 if(itemSetList!=null&&itemSetList.size()>0){
    			 for(int i=0;i<itemSetList.size();i++){
	    			 TemplateItemSetBO temsetbo=(TemplateItemSetBO)itemSetList.get(i);
	    			 TemplateItemSetBO newSetbo=new TemplateItemSetBO();
	    			 newSetbo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
	    			 newSetbo.setParentID(newtbo.getTemplateID());
	    			 newSetbo.setSetName(temsetbo.getSetName());
	    			 newSetbo.setShowSEQ(temsetbo.getShowSEQ());
	    			 itemkeyUCC.saveTemplateItemSetBO(newSetbo);
	    			 List itemList=itemkeyUCC.getAllChildItem(temsetbo.getSetID());
	    			 if(itemList!=null&&itemList.size()>0){
	    				 for(int j=0;j<itemList.size();j++){
	    					 TemplateItemBO titembo=(TemplateItemBO)itemList.get(j);
	    					 TemplateItemBO newItembo=new TemplateItemBO();
	    					 newItembo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
	    					 newItembo.setItemName(titembo.getItemName());
	    					 newItembo.setLinkID(titembo.getLinkID());
	    					 newItembo.setScore(titembo.getScore());
	    					 newItembo.setSetID(newSetbo.getSetID());
	    					 newItembo.setShowSEQ(titembo.getShowSEQ());
	    					 newItembo.setTemplateID(newtbo.getTemplateID());
	    					 itemkeyUCC.saveTemplateItemBO(newItembo);
	    				 }
	    			 }
    			 }
    			 
    		 }
    		 super.showMessageDetail("复制成功！");
         }
         catch(Exception e){
             e.printStackTrace();
         }
    	return "";
    }

    public TemplateItemBO getTempitembo() {
        return tempitembo;
    }

    public void setTempitembo(TemplateItemBO tempitembo) {
        this.tempitembo = tempitembo;
    }

    private TemplateItemBO tempitembo=new TemplateItemBO();

    public String getInitItemEdit() {
        try{
            if (super.getRequestParameter("SetID")!=null){
                this.setID=super.getRequestParameter("SetID");
            }
            if (super.getRequestParameter("templateID")!=null){
                this.templateID=super.getRequestParameter("templateID");
            }
            if (super.getRequestParameter("itemID")!=null){
                tempitembo=this.itemkeyUCC.findTemplateItemBO(super.getRequestParameter("itemID"));
            }
        }
        catch(Exception e){

        }
        return initItemEdit;
    }
    public void setInitItemEdit(String initItemEdit) {
        this.initItemEdit = initItemEdit;
    }
    public String SaveItem(){
        try{
            if (this.tempitembo.getTemplateID()==null){
                this.tempitembo.setTemplateID(this.templateID);
            }
            if (this.tempitembo.getSetID()==null){
                this.tempitembo.setSetID(this.setID);
            }
            if (this.tempitembo.getCreateDate()==null){
                this.tempitembo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            }

            this.itemkeyUCC.saveTemplateItemBO(this.tempitembo);
        }
        catch(Exception e){
            
        }
        return "success";
    }
    public String deleteItem(){
        try{
            this.itemkeyUCC.deleteTemplateBO(this.itemID);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return "";
    }
    public String deleteItem1(){
    	try{
            this.itemkeyUCC.deleteTemplateItemBO(this.itemID);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public List getEvaitems() {
        try{
            evaitems=this.itemkeyUCC.getAllChildItem(itemSet);
            for (int i=0;i<evaitems.size();i++){
                TemplateItemBO tb=(TemplateItemBO)evaitems.get(i);
                if (tb.getLinkID()!=null && !"".equals(tb.getLinkID())){
                   EvaKeyItemBO eb=this.itemkeyUCC.getEvaKeyItemBO(tb.getLinkID());
                   if (eb!=null){
                       tb.setItemName(eb.getItemName());
                   }
                }
            }
        }
        catch(Exception e){

        }
        return evaitems;
    }
    public void setEvaitems(List evaitems) {
        this.evaitems = evaitems;
    }

    public String getItemSet() {
        return itemSet;
    }
    public void setItemSet(String itemSet) {
        this.itemSet = itemSet;
    }

    public String getInitItemList() {
        if (super.getRequestParameter("SetID")!=null){
            itemSet=super.getRequestParameter("SetID");
        }
        if (super.getRequestParameter("templateID")!=null){
            this.templateID=super.getRequestParameter("templateID");
        }

        return initItemList;
    }
    public void setInitItemList(String initItemList) {
        this.initItemList = initItemList;
    }

    public TemplateItemSetBO getItemsetbo() {
        return itemsetbo;
    }

    public void setItemsetbo(TemplateItemSetBO itemsetbo) {
        this.itemsetbo = itemsetbo;
    }



    public String getInitItemSet() {
        try{
            if (super.getRequestParameter("itemSet")!=null){
                itemsetbo=this.itemkeyUCC.findTemplateItemSetBO(super.getRequestParameter("itemSet"));
            }
            if (super.getRequestParameter("templateID")!=null){
                templateID=super.getRequestParameter("templateID");
            }
        }
        catch(Exception e){

        }
        return initItemSet;
    }
    public void setInitItemSet(String templateID) {
        this.initItemSet = templateID;
    }

    public String getInitContent() {
        if (super.getRequestParameter("templateID")!=null){
            templateID=super.getRequestParameter("templateID");
        }
        return initContent;
    }
    public void setInitContent(String initContent) {
        this.initContent = initContent;
    }

    public String getTemplateID() {
        return templateID;
    }
    public void setTemplateID(String templateID) {
        this.templateID = templateID;
    }


    public EvaTemplateBO getTemplateBO() {
        return templateBO;
    }
    public void setTemplateBO(EvaTemplateBO itemkeyBO) {
        this.templateBO = itemkeyBO;
    }

    public List getOrgList(){
        if (orgList==null){
            orgList=new ArrayList();
            if (RoleInfoBO.ORGTYPE_ALL.equals(super.getUserInfo().getprocessUnit())){
                SelectItem si=new SelectItem();
                si.setLabel("全集团");
                si.setValue("-1");
                orgList.add(si);
            }

            SelectItem si1=new SelectItem();
            si1.setLabel(super.getUserInfo().getOrgName());
            si1.setValue(super.getUserInfo().getOrgId());
            orgList.add(si1);
        }
        return orgList;
    }
    public void setOrgList(List li){
       orgList=li;
    }

    public String getEditItem() {
        try{
            if (super.getRequestParameter("itemID")!=null){
                this.templateBO=this.itemkeyUCC.findTemplateBO(super.getRequestParameter("itemID"));
            }
            else  if (super.getRequestParameter("setID")!=null){
                templateBO.setSetID(super.getRequestParameter("setID"));
            }
            EvaTemplateSetBO bo=itemkeyUCC.findTemplateSetBO(templateBO.getSetID());
            if (setbo!=null){
                templateBO.setSetName(bo.getSetName());
            }
        }
        catch(Exception e){

        }
        return editItem;
    }
    public void setEditItem(String editItem) {
        this.editItem = editItem;
    }

    public String getItemID() {
        return itemID;
    }

    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getInitList(){
        try{
            if (super.getRequestParameter("setID")!=null){
                this.setID=super.getRequestParameter("setID");
            }
            itemList=itemkeyUCC.getAllOwnTemplate(setID,super.getUserInfo().getOrgId());
        }
        catch(Exception e){

        }
        return initList;
    }
    public void setInitList(String init){
        initList=init;
    }

    public List getItemList() {
        return itemList;
    }

    public void setItemList(List itemList) {
        this.itemList = itemList;
    }

    public String saveItem(){
        try{
            if (this.templateBO.getCreateOrguid()==null){
                this.templateBO.setCreateOrguid(super.getUserInfo().getOrgId());
            }
            if (this.templateBO.getCreateDate()==null){
                this.templateBO.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            }

            itemkeyUCC.saveTemplateBO(this.templateBO);
        }
        catch(Exception e){

        }
        return "success";
    }
    
    public String getSetID() {
        return setID;
    }
    public void setSetID(String setID) {
        this.setID = setID;
    }

    public String getUnitName(){
        unitName=super.getUserInfo().getOrgName();
        return unitName;
    }
    public void setUnitName(String name){
        unitName=name;
    }

    public EvaTemplateSetBO getSetbo() {
        return setbo;
    }
    public void setSetbo(EvaTemplateSetBO setbo) {
        this.setbo = setbo;
    }

    public String getInitset() {
        try{
            if (super.getRequestParameter("setID")!=null){
                setbo=itemkeyUCC.findTemplateSetBO(super.getRequestParameter("setID"));
            }
        }
        catch(Exception e){

        }
        return initset;
    }
    public void setInitset(String initset) {
        this.initset = initset;
    }


    public String SaveSet(){
        try{
            if (setbo.getParentID()==null || "".equals(setbo.getParentID())){
                setbo.setParentID("-1");
             }
            itemkeyUCC.saveTemplateSetBO(setbo);
        }
        catch(Exception e){

        }
        return "success";
    }
    public String SaveItemSet(){
        try{
            if (this.itemsetbo.getParentID()==null || "".equals(this.itemsetbo.getParentID())){
                this.itemsetbo.setParentID(this.templateID);
            }
            if (this.itemsetbo.getCreateDate()==null){
                this.itemsetbo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
            }
            itemkeyUCC.saveTemplateItemSetBO(this.itemsetbo);
        }
        catch(Exception e){

        }
        return "success";
    }

    public void deleteSet(){
        try{
            itemkeyUCC.deleteTemplateSetBO(this.setID);
        }
        catch(Exception e){

        }
    }
    public void deleteItemSet(){
        try{
            itemkeyUCC.deleteTemplateItemSetBO(this.itemID);
        }
        catch(Exception e){

        }
    }

    public IEvaKeyItemUCC getItemkeyUCC(){
        return itemkeyUCC;
    }
    public void setItemkeyUCC(IEvaKeyItemUCC ucc){
        itemkeyUCC=ucc;
    }

}
