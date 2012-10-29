package com.hr319wg.eva.web;

import com.hr319wg.eva.ucc.IEvaKeyItemUCC;
import com.hr319wg.eva.pojo.bo.EvaKeyItemSetBO;
import com.hr319wg.eva.pojo.bo.EvaKeyItemBO;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.user.pojo.bo.RoleInfoBO;

import javax.faces.model.SelectItem;
import java.util.List;
import java.util.ArrayList;
import java.util.regex.Pattern;


public class itemKeyBackingBean extends BaseBackingBean {
    private IEvaKeyItemUCC itemkeyUCC;
    private String unitName;
    private String setID;
    private EvaKeyItemSetBO setbo=new EvaKeyItemSetBO();
    private String initset;

    //-----------------------项目----------------
    private String initList;
    private List itemList;
    private String itemID;
    private String editItem;
    private EvaKeyItemBO itemkeyBO=new EvaKeyItemBO();
    private List orgList;


	public EvaKeyItemBO getItemkeyBO() {
        return itemkeyBO;
    }

    public void setItemkeyBO(EvaKeyItemBO itemkeyBO) {
        this.itemkeyBO = itemkeyBO;
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
                itemkeyBO=this.itemkeyUCC.getEvaKeyItemBO(super.getRequestParameter("itemID"));
                EvaKeyItemSetBO bo=itemkeyUCC.findItemkeySetBO(itemkeyBO.getSetID());
                if (bo!=null){
                    itemkeyBO.setSetName(bo.getSetName());
                }
            }
            else  if (super.getRequestParameter("setID")!=null){
                itemkeyBO.setSetID(super.getRequestParameter("setID"));
                EvaKeyItemSetBO bo=itemkeyUCC.findItemkeySetBO(itemkeyBO.getSetID());
                if (bo!=null){
                    itemkeyBO.setSetName(bo.getSetName());
                }
                itemkeyBO.initRow();
                itemkeyBO.setItemType("0");
            }
        }
        catch(Exception e){
        	e.printStackTrace();
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
            itemList=itemkeyUCC.getKeyItemList(setID,super.getUserInfo().getOrgId());
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
            itemkeyUCC.saveEvaKeyItemBO(this.itemkeyBO);
        }
        catch(Exception e){

        }
        return "success";
    }
    public String deleteItem(){
        try{
        	List list=itemkeyUCC.getAllTemplateItemBOByKeyItemId(itemID);
        	if(list!=null&&list.size()>0){
        		super.showMessageDetail("该指标正在使用不能删除！");
        	}else{
        		itemkeyUCC.deleteEvaKeyItemBO(itemID);
        	}
        }
        catch(Exception e){

        }
        return "";
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

    public EvaKeyItemSetBO getSetbo() {
        return setbo;
    }
    public void setSetbo(EvaKeyItemSetBO setbo) {
        this.setbo = setbo;
    }

    public String getInitset() {
        try{
            if (super.getRequestParameter("setID")!=null){
                setbo=itemkeyUCC.findItemkeySetBO(super.getRequestParameter("setID"));
            }else if(super.getRequestParameter("superId")!=null){
            	setbo.initRow();
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
            itemkeyUCC.saveItemkeySetBO(setbo);
        }
        catch(Exception e){

        }
        return "success";
    }

    public void deleteSet(){
        try{
        	List list=itemkeyUCC.getKeyItemListBySetId(this.setID);
        	if(list!=null&&list.size()>0){
        		super.showMessageDetail("该指标集有指标不能删除！");
        	}else{
        		itemkeyUCC.deleteItemkeySetBO(this.setID);
        	}
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
