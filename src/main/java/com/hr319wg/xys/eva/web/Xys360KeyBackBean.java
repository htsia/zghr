package com.hr319wg.xys.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.xys.eva.pojo.bo.Xys360KeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360KeyLibBO;
import com.hr319wg.xys.eva.ucc.IXys360KeyUCC;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-2
 * Time: 下午5:13
 * To change this template use File | Settings | File Templates.
 */
public class Xys360KeyBackBean extends BaseBackingBean{
    private IXys360KeyUCC xys360KeyUCC;
    private String libId;
    private String initLib;
    private Xys360KeyLibBO libBo=new Xys360KeyLibBO();

    public IXys360KeyUCC getXys360KeyUCC() {
        return xys360KeyUCC;
    }

    public void setXys360KeyUCC(IXys360KeyUCC xys360KeyUCC) {
        this.xys360KeyUCC = xys360KeyUCC;
    }

    public String getLibId() {
        return libId;
    }

    public void setLibId(String libId) {
        this.libId = libId;
    }

    public String deleteLib(){
        try{
             List list=xys360KeyUCC.getXys360KeyBOByLib(null,libId);
             if(list!=null&&list.size()>0){
                 super.showMessageDetail("该指标库使用中无法删除！");
             }else{
                 xys360KeyUCC.deleteXys360KeyLibBO(libId);
             }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public String saveLib(){
        try{
             if(libBo.getSuperId()==null||libBo.getSuperId().equals("")){
                   libBo.setSuperId("-1");
             }
             xys360KeyUCC.saveXys360KeyLibBO(libBo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitLib() {
        try{
            if(super.getRequestParameter("libId")!=null){
                libId=super.getRequestParameter("libId");
                libBo=xys360KeyUCC.findXys360KeyLibBOById(libId);
                if(libBo.getSuperId()!=null&&!libBo.getSuperId().equals("")&&!libBo.getSuperId().equals("-1")){
                    Xys360KeyLibBO superbo=xys360KeyUCC.findXys360KeyLibBOById(libId);
                    libBo.setSuperName(superbo.getLibName());
                }
            }else if(super.getRequestParameter("superId")!=null){
                libBo.initRow();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return initLib;
    }

    public void setInitLib(String initLib) {
        this.initLib = initLib;
    }

    public Xys360KeyLibBO getLibBo() {
        return libBo;
    }

    public void setLibBo(Xys360KeyLibBO libBo) {
        this.libBo = libBo;
    }
    //指标管理
    private String initKeyList;
    private List keyList;
    private PageVO mypage=new PageVO();
    private String keyId;

    public String getKeyId() {
        return keyId;
    }

    public void setKeyId(String keyId) {
        this.keyId = keyId;
    }

    public String deleteKey(){
        try{
            xys360KeyUCC.deleteXys360KeyBO(keyId);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }
    public String first() {
        mypage.setCurrentPage(1);
        doQuery();
        return "";
    }

    public String pre() {
        if (mypage.getCurrentPage() > 1) {
            mypage.setCurrentPage(mypage.getCurrentPage() - 1);
        }
        doQuery();
        return "";
    }

    public String next() {
        if (mypage.getCurrentPage() < mypage.getTotalPage()) {
            mypage.setCurrentPage(mypage.getCurrentPage() + 1);
        }
        doQuery();
        return "";
    }

    public String last() {
        mypage.setCurrentPage(mypage.getTotalPage());
        doQuery();
        return "";
    }
    public void doQuery(){
        try{
            if(mypage.getCurrentPage()==0){
                mypage.setCurrentPage(1);
            }
            keyList=xys360KeyUCC.getXys360KeyBOByLib(mypage,libId);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public String getInitKeyList() {
        if(super.getRequestParameter("libId")!=null){
            libId=super.getRequestParameter("libId");
        }
        doQuery();
        return initKeyList;
    }

    public void setInitKeyList(String initKeyList) {
        this.initKeyList = initKeyList;
    }

    public List getKeyList() {
        return keyList;
    }

    public void setKeyList(List keyList) {
        this.keyList = keyList;
    }
    public PageVO getMypage() {
        return mypage;
    }

    public void setMypage(PageVO mypage) {
        this.mypage = mypage;
    }
    //指标增加
    private String initKey;
    private Xys360KeyBO keyBo=new Xys360KeyBO();

    public String saveKey(){
        try{
           keyBo.setLibId(libId);
           xys360KeyUCC.saveXys360KeyBO(keyBo);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitKey() {
        try{
            if(super.getRequestParameter("libId")!=null){
               libId=super.getRequestParameter("libId");
               keyBo.initRow();
            }else if(super.getRequestParameter("keyId")!=null){
               keyId=super.getRequestParameter("keyId");
               keyBo=xys360KeyUCC.findXys360KeyBOById(keyId);
               libId=keyBo.getLibId();
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return initKey;
    }

    public void setInitKey(String initKey) {
        this.initKey = initKey;
    }

    public Xys360KeyBO getKeyBo() {
        return keyBo;
    }

    public void setKeyBo(Xys360KeyBO keyBo) {
        this.keyBo = keyBo;
    }



}
