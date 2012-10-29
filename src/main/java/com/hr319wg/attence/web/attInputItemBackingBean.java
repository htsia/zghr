package com.hr319wg.attence.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.wage.ucc.IWageDeptUCC;
import com.hr319wg.wage.ucc.IWageSetUCC;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.attence.pojo.bo.AttItemPowerBO;

import javax.faces.model.SelectItem;
import javax.faces.event.ValueChangeEvent;
import java.util.List;
import java.util.ArrayList;

/**
 * 设置发薪单位
 *
 */
public class attInputItemBackingBean extends BaseBackingBean {
    private String setID;
    private String personID;
    private String setName;
    private String initEdit;
    private String initBaseEdit;   // 基数项目初试
    private String personName;
    private List personList=new ArrayList();  // 保险管理权限人员
    private List powerList=null;    // 项目权限

    private AttItemPowerBO wbo=new AttItemPowerBO();
    private IWageDeptUCC wagedeptucc;
    private IWageSetUCC wagesetucc;
    private WageAPI wageapi;
    private List itemList=new ArrayList();
    private QueryAPI queryapi;

    public QueryAPI getQueryapi() {
        return queryapi;
    }
    public void setQueryapi(QueryAPI queryapi) {
        this.queryapi = queryapi;
    }

    public List getItemList(){
        return itemList;
    }
    public void setItemList(List li){
        itemList=li;
    }

    public String save(){
        try{
            if (!wagedeptucc.CheckAttPowerHaveSet(wbo.getPersonID(), wbo.getItemID(),wbo.getSetID())){
                this.wagedeptucc.SaveAttPowerItem(this.wbo);
            }
        }
        catch(Exception e){

        }
        return "success";
    }

    public String getPersonName(){
        return personName;
    }
    public void setPersonName(String name){
        personName=name;
    }

    public String getInitEdit(){
    	if(itemList!=null){
    		itemList=new ArrayList();
    	}
        try{
            if (super.getRequestParameter("setID")!=null){
                wbo.setSetID(super.getRequestParameter("setID"));
                this.setName=wagesetucc.findSetBySetId(wbo.getSetID()).getName();
                wbo.setPersonID(super.getRequestParameter("personID"));
                this.personName= SysCacheTool.findPersonById(wbo.getPersonID()).getName();
                 SelectItem si0=new SelectItem();
                 si0.setLabel("请选择项目");
                 si0.setValue("-1");
                 itemList.add(si0);

                 CellVO[]cvs=queryapi.getCellVO(Constants.DEFAULT_ATTENCE_PAYOFF);
                 WageSetBO setbo=this.wagesetucc.findSetBySetId(super.getRequestParameter("setID"));
                 if (cvs != null) {
                    for(int i=0;i<cvs.length;i++){
                        if ("A815".equals(cvs[i].getSetId()) && setbo.getAllField().indexOf(cvs[i].getItemId())>=0){
                            SelectItem si=new SelectItem();
                            si.setLabel(cvs[i].getItemName());
                            si.setValue(cvs[i].getItemId());
                            itemList.add(si);
                        }
                    }
                }

            }
        }
        catch(Exception e){

        }

        return initEdit;
    }
    public void setInitEdit(String init){
        initEdit=init;
    }

    public AttItemPowerBO getWbo(){
        return wbo;
    }
    public void  getWbo(AttItemPowerBO bo){
        wbo=bo;
    }


    public void delete(){
        try{
           wagedeptucc.DeleteAttPowerItemByID(this.wbo.getPowerID());
        }
        catch(Exception e){

        }
    }

    public void deleteBase(){
        try{
           wagedeptucc.DeleteInsBasePowerItemByID(this.wbo.getPowerID());
        }
        catch(Exception e){

        }
    }


    public WageAPI getWageapi(){
        return this.wageapi;
    }
    public void setWageapi(WageAPI api){
        this.wageapi=api;
    }

    public String getSetID(){
        return this.setID;
    }
    public void setSetID(String id){
        this.setID=id;
    }

    public String getSetName(){
        return this.setName;
    }
    public void setSetName(String id){
        this.setName=id;
    }

    public String getPersonID(){
        return this.personID;
    }
    public void setPersonID(String id){
        this.personID=id;
    }

    public List getPersonList(){
    	if(personList!=null){
            personList=new ArrayList();		
    	}
            try{
                String pids[]=wageapi.getAttUser(this.setID);

                for(int i=0;i<pids.length;i++){
                    if (i==0) this.personID=pids[0];
                    SelectItem si=new  SelectItem();
                    si.setLabel(SysCacheTool.findPersonById(pids[i]).getName());
                    si.setValue(pids[i]);
                    personList.add(si);
                }
            }
            catch(Exception e){

            }
        return personList;
    }
    public void setPersonList(List li){
        personList=li;
    }


    public List getPowerList(){
        try{
            if (this.personID!=null){
                powerList=wagedeptucc.getAllAttItemPowerByPerson(this.personID,this.setID);
                for(int i=0;i<powerList.size();i++){
                    AttItemPowerBO wdp=(AttItemPowerBO) powerList.get(i);
                    wdp.setItemName(CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,wdp.getItemID()));
                }
            }
            else{
               powerList=new ArrayList();
            }
        }
        catch(SysException e){
            e.printStackTrace();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return powerList;
    }
    public void setPowerList(List li){
        powerList=li;
    }



    public String getPageInit() {
        try{
            if (super.getRequestParameter("setID")!=null){
                this.setID=super.getRequestParameter("setID");
                this.setName=wagesetucc.findSetBySetId(this.setID).getName();
            }
        }
        catch(Exception e){

        }
        return pageInit;
    }


    public void changePerson(ValueChangeEvent event){
       this.personID=event.getNewValue().toString();
    }

    public IWageDeptUCC getWagedeptucc() {
        return wagedeptucc;
    }
    public void setWagedeptucc(IWageDeptUCC ucc) {
        this.wagedeptucc = ucc;
    }

    public IWageSetUCC getWagesetucc() {
        return wagesetucc;
    }
    public void setWagesetucc(IWageSetUCC ucc) {
        this.wagesetucc = ucc;
    }

}
