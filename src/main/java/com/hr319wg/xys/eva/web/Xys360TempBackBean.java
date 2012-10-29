package com.hr319wg.xys.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.*;
import com.hr319wg.xys.eva.ucc.IXys360KeyUCC;
import com.hr319wg.xys.eva.ucc.IXys360TempUCC;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-10
 * Time: 下午2:50
 * To change this template use File | Settings | File Templates.
 */
public class Xys360TempBackBean extends BaseBackingBean {
    //模版库操作
    private IXys360TempUCC xys360TempUCC;
    private String libId;
    private String initLib;
    private Xys360TempLibBO libBo = new Xys360TempLibBO();

    public String saveLib() {
        try {
            if (libBo.getSuperId() == null || libBo.getSuperId().equals("")) {
                libBo.setSuperId("-1");
            }
            xys360TempUCC.saveXys360TempLibBO(libBo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitLib() {
        try {
            if (super.getRequestParameter("superId") != null) {
                libBo.initRow();
            } else if (super.getRequestParameter("libId") != null) {
                libId = super.getRequestParameter("libId");
                libBo = xys360TempUCC.findXys360TempLibBO(libId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return initLib;
    }

    public void setInitLib(String initLib) {
        this.initLib = initLib;
    }

    public Xys360TempLibBO getLibBo() {
        return libBo;
    }

    public void setLibBo(Xys360TempLibBO libBo) {
        this.libBo = libBo;
    }

    public String deleteLib() {
        try {
            List list = xys360TempUCC.getXys360TempLibBO(libId);
            List tList = xys360TempUCC.getXys360TempBOByLibId(libId);
            if ((list != null && list.size() > 0) || (tList != null && tList.size() > 0)) {
                super.showMessageDetail("模版库使用中无法进行删除操作！");
            } else {
                xys360TempUCC.deleteXys360TempLibBO(libId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public IXys360TempUCC getXys360TempUCC() {
        return xys360TempUCC;
    }

    public void setXys360TempUCC(IXys360TempUCC xys360TempUCC) {
        this.xys360TempUCC = xys360TempUCC;
    }

    public String getLibId() {
        return libId;
    }

    public void setLibId(String libId) {
        this.libId = libId;
    }

    //模版操作
    private String initTempList;
    private List tempList;
    private String tempId;
    private String initTemp;
    private Xys360TempBO tempBo = new Xys360TempBO();

    public String saveTemp() {
        try {
            tempBo.setTmpLibId(libId);
            xys360TempUCC.saveXys360TempBO(tempBo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitTemp() {
        try {
            if (super.getRequestParameter("libId") != null) {
                libId = super.getRequestParameter("libId");
                tempBo.initRow();
            } else if (super.getRequestParameter("tempId") != null) {
                tempId = super.getRequestParameter("tempId");
                tempBo = xys360TempUCC.findXys360TempBO(tempId);
                libId = tempBo.getTmpLibId();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return initTemp;
    }

    public void setInitTemp(String initTemp) {
        this.initTemp = initTemp;
    }

    public Xys360TempBO getTempBo() {
        return tempBo;
    }

    public void setTempBo(Xys360TempBO tempBo) {
        this.tempBo = tempBo;
    }

    public String deleteTemp() {
        try {
            xys360TempUCC.deleteXys360TempBO(tempId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getTempId() {
        return tempId;
    }

    public void setTempId(String tempId) {
        this.tempId = tempId;
    }

    public void doQuery() {
        try {
            tempList = xys360TempUCC.getXys360TempBOByLibId(libId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getInitTempList() {
        if (super.getRequestParameter("libId") != null) {
            libId = super.getRequestParameter("libId");
        }
        doQuery();
        return initTempList;
    }

    public void setInitTempList(String initTempList) {
        this.initTempList = initTempList;
    }

    public List getTempList() {
        return tempList;
    }

    public void setTempList(List tempList) {
        this.tempList = tempList;
    }

    //模版内容设置
    private String setId;
    private String initSet;
    private String initSetEdit;
    private Xys360TempSetBO setBO = new Xys360TempSetBO();
    private String initItemList;
    private List itemList;
    private String itemId;
    private String initItem;
    private Xys360TempItemBO itemBO=new Xys360TempItemBO();
    private String setType;
    private IXys360KeyUCC xys360KeyUCC;
    private String editType;

    public String getEditType() {
        return editType;
    }

    public void setEditType(String editType) {
        this.editType = editType;
    }

    public IXys360KeyUCC getXys360KeyUCC() {
        return xys360KeyUCC;
    }

    public void setXys360KeyUCC(IXys360KeyUCC xys360KeyUCC) {
        this.xys360KeyUCC = xys360KeyUCC;
    }

    public String getSetType() {
        return setType;
    }

    public void setSetType(String setType) {
        this.setType = setType;
    }

    public Xys360TempItemBO getItemBO() {
        return itemBO;
    }

    public void setItemBO(Xys360TempItemBO itemBO) {
        this.itemBO = itemBO;
    }
    public String saveItem(){
        try{
            Xys360KeyBO key=xys360KeyUCC.findXys360KeyBOById(itemBO.getKeyId());
            Xys360TempSetBO set=xys360TempUCC.findXys360TempSetBOById(setId);
            Xys360TempBO temp=xys360TempUCC.findXys360TempBO(set.getTempId());
            if(key!=null){
                double allWeight=0;
                List list=xys360TempUCC.getXys360TempItemBOByTempId(set.getTempId());
                if(list!=null&&list.size()>0){
                    for(int i=0;i<list.size();i++){
                        Xys360TempItemBO item=(Xys360TempItemBO)list.get(i);
                        if(editType.equals("add")||(editType.equals("update")&&!item.getKeyId().equals(itemBO.getKeyId()))){
                            allWeight+=Double.parseDouble(CommonFuns.filterNullToZero(item.getWeight()));
                        }
                    }
                }
                double weight=allWeight+Double.parseDouble(CommonFuns.filterNullToZero(itemBO.getWeight()));
                if(weight>100){
                    super.showMessageDetail("权重超过100%！");
                    return "";
                }

                itemBO.setItemDesc(key.getKeyDesc());
                itemBO.setItemName(key.getKeyName());
                itemBO.setKeyId(key.getKeyId());
                itemBO.setSetId(setId);
                xys360TempUCC.saveXys360TempItemBO(itemBO);
            }else{
                super.showMessageDetail("请选择指标项！");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "success";
    }
    public String getInitItem() {
        try{
             if(super.getRequestParameter("setId")!=null){
                 setId=super.getRequestParameter("setId");
                 itemBO.initRow();
                 editType="add";
             }else if(super.getRequestParameter("itemId")!=null){
                 itemId=super.getRequestParameter("itemId");
                 itemBO=xys360TempUCC.findXys360TempItemBOById(itemId);
                 setId=itemBO.getSetId();
                 editType="update";
             }
             setType=xys360TempUCC.findXys360TempSetBOById(setId).getSetType();
        }catch(Exception e){
             e.printStackTrace();
        }
        return initItem;
    }

    public void setInitItem(String initItem) {
        this.initItem = initItem;
    }

    public String deleteItem(){
        try{
            xys360TempUCC.deleteXys360TempItemBO(itemId);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }
    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public void queryItemList(){
        try{
             itemList=xys360TempUCC.getXys360TempItemBOBySetId(setId);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public String getInitItemList() {
        if(super.getRequestParameter("setId")!=null){
           setId=super.getRequestParameter("setId");
        }
        queryItemList();
        return initItemList;
    }

    public void setInitItemList(String initItemList) {
        this.initItemList = initItemList;
    }

    public List getItemList() {
        return itemList;
    }

    public void setItemList(List itemList) {
        this.itemList = itemList;
    }
    public String deleteSet(){
        try{
            List list=xys360TempUCC.getXys360TempItemBOBySetId(setId);
            if(list!=null&&list.size()>0){
                super.showMessageDetail("使用中无法删除！");
            }else{
                xys360TempUCC.deleteXys360TempSetBO(setId);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }
    public String saveSet(){
        try{
            setBO.setTempId(tempId);
            xys360TempUCC.saveXys360TempSetBO(setBO);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitSetEdit() {
        try {
            if (super.getRequestParameter("tempId") != null) {
                tempId = super.getRequestParameter("tempId");
                setBO.initRow();
            } else if (super.getRequestParameter("setId") != null) {
                setId = super.getRequestParameter("setId");
                setBO = xys360TempUCC.findXys360TempSetBOById(setId);
                tempId = setBO.getTempId();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return initSetEdit;
    }

    public void setInitSetEdit(String initSetEdit) {
        this.initSetEdit = initSetEdit;
    }

    public Xys360TempSetBO getSetBO() {
        return setBO;
    }

    public void setSetBO(Xys360TempSetBO setBO) {
        this.setBO = setBO;
    }

    public String getSetId() {
        return setId;
    }

    public void setSetId(String setId) {
        this.setId = setId;
    }

    public String getInitSet() {
        if (super.getRequestParameter("tempId") != null) {
            tempId = super.getRequestParameter("tempId");
            super.getHttpSession().setAttribute("tempId",tempId);
        }
        return initSet;
    }

    public void setInitSet(String initSet) {
        this.initSet = initSet;
    }
}
