package com.hr319wg.eva.web;

import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.common.web.BaseBackingBean;
import java.util.List;

public class EvaGradeBackingBean extends BaseBackingBean {
    private IEvaGradeUCC gradeUCC;
    private String initType;
    private String initItem;
    private String currentDic;
    private String superID;
    private String initItemEdit;
    private EvaGradeBO gradebo=new EvaGradeBO();
    private EvaGradeItemBO gradeitembo=new EvaGradeItemBO();
    private List itemList;

    public void setItemList(List list){
        itemList=list;
    }
    public List getItemList(){
        return itemList;
    }
    
    public String getSuperID(){
        return superID;
    }
    public void setSuperID(String dic){
        superID=dic;
    }

    public String getInitItemEdit(){
        try{
            if (super.getRequestParameter("superID")!=null){
                superID=super.getRequestParameter("superID");
            }
            if (super.getRequestParameter("itemID")!=null){
                String itemID=super.getRequestParameter("itemID");
                gradeitembo=gradeUCC.getGradeItem(itemID);
                superID=gradeitembo.getGradeID();
            }
        }
        catch(Exception e){

        }
        return initItemEdit;
    }
    public void setInitItemEdit(String edit){
        initItemEdit=edit;
    }

    public String getInitItem(){
        try{
            if (super.getRequestParameter("superID")!=null){
                superID=super.getRequestParameter("superID");
            }
            itemList=gradeUCC.getAllGradeItem(superID);
        }
        catch(Exception e){

        }
        return initItem;
    }
    public void setInitItem(String dic){
        initItem=dic;
    }

    public String getCurrentDic(){
        return currentDic;
    }
    public void setCurrentDic(String dic){
        currentDic=dic;
    }


    public  EvaGradeBO getGradebo(){
        return gradebo;
    }
    public void setGradebo(EvaGradeBO bo){
        gradebo=bo;
    }
    
    public  EvaGradeItemBO getGradeitembo(){
        return gradeitembo;
    }
    public void setGradeitembo(EvaGradeItemBO bo){
        gradeitembo=bo;
    }

    public String getInitType(){
        try{
            if (super.getRequestParameter("TypeID")!=null){
                String id=super.getRequestParameter("TypeID");
                gradebo=gradeUCC.getGradeByID(id);
            }
        }
        catch(Exception e){
            
        }
        return initType;
    }
    public void setInitType(String type){
        initType=type;
    }
    public String SaveType(){
        try{
            gradeUCC.SaveGradeType(gradebo);
        }
        catch(Exception e){

        }
        return "success";
    }

    public String DeleteType(){
        try{
            this.gradebo.setGradeID(this.currentDic);
            gradeUCC.DeleteGradeType(this.gradebo);
        }
        catch(Exception e){

        }
        return "";
    }

    public String SaveItem(){
        try{
            gradeitembo.setGradeID(this.superID);
            gradeUCC.SaveGradeItem(this.gradeitembo);
            gradeitembo.InitPara();
        }
        catch(Exception e){

        }
        return "success";
    }
    public String DeleteItem(){
        try{
            gradeUCC.DeleteGradeItem(this.gradeitembo);
        }
        catch(Exception e){

        }
        return "";
    }

    public  IEvaGradeUCC getGradeUCC(){
        return gradeUCC;
    }
    public void setGradeUCC(IEvaGradeUCC ucc){
        gradeUCC=ucc;
    }

}
