package com.hr319wg.xys.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyLibBO;
import com.hr319wg.xys.eva.pojo.vo.KPIImportVO;
import com.hr319wg.xys.eva.pojo.vo.KPIItemVO;
import com.hr319wg.xys.eva.ucc.IRelSetUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiKeyUCC;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import org.apache.myfaces.custom.fileupload.UploadedFile;

import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;
import java.io.File;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-9
 * Time: 下午5:27
 * To change this template use File | Settings | File Templates.
 */
public class XysKpiLibSetBackBean extends BaseBackingBean {
    private IRelSetUCC relSetUCC;
    private String pageInit;
    private String superId;
    private String superName;
    private PageVO mypage = new PageVO();
    private List postList;

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

    public void doQuery() {
        try {
            if (mypage.getCurrentPage() == 0) {
                mypage.setCurrentPage(1);
            }
            postList = relSetUCC.getAllPostBOByOrgId(mypage, superId);
            if (postList != null && postList.size() > 0) {
                for (int i = 0; i < postList.size(); i++) {
                    PostBO bo = (PostBO) postList.get(i);
                    bo.setOrgId(SysCacheTool.findOrgById(bo.getOrgId()).getName());
                    bo.setSuperId(PostTool.getPostName(bo.getSuperId()));
                    bo.setPostType(CodeUtil.interpertCode(bo.getPostType()));
                    bo.setPostLevel(CodeUtil.interpertCode(bo.getPostLevel()));
                    postList.set(i, bo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public IRelSetUCC getRelSetUCC() {
        return relSetUCC;
    }

    public void setRelSetUCC(IRelSetUCC relSetUCC) {
        this.relSetUCC = relSetUCC;
    }

    public String getPageInit() {
        if (super.getRequestParameter("superId") != null) {
            superId = super.getRequestParameter("superId");
        }
        doQuery();
        return pageInit;
    }

    public void setPageInit(String pageInit) {
        this.pageInit = pageInit;
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }

    public String getSuperName() {
        if (superId != null && !superId.equals("")) {
            superName = SysCacheTool.findOrgById(superId).getName();
        }
        return superName;
    }

    public void setSuperName(String superName) {
        this.superName = superName;
    }

    public PageVO getMypage() {
        return mypage;
    }

    public void setMypage(PageVO mypage) {
        this.mypage = mypage;
    }

    public List getPostList() {
        return postList;
    }

    public void setPostList(List postList) {
        this.postList = postList;
    }

    //指标库维护
    private String libId;
    private String initLib;
    private String postId;
    private String initLibEdit;
    private XysKpiKeyLibBO libBo = new XysKpiKeyLibBO();

    public String deleteLib() {
        try {
            xysKpiKeyUCC.deleteXysKpiKeyLibBO(libId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public XysKpiKeyLibBO getLibBo() {
        return libBo;
    }

    public void setLibBo(XysKpiKeyLibBO libBo) {
        this.libBo = libBo;
    }

    public String saveLib() {
        try {
            libBo.setPostId(postId);
            this.xysKpiKeyUCC.saveXysKpiKeyLibBO(libBo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitLibEdit() {
        try {
            if (super.getRequestParameter("postId") != null) {
                postId = super.getRequestParameter("postId");
                libBo.initRow();
            } else if (super.getRequestParameter("libId") != null) {
                libId = super.getRequestParameter("libId");
                libBo = this.xysKpiKeyUCC.findXysKpiKeyLibBOById(libId);
                postId = libBo.getPostId();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return initLibEdit;
    }

    public void setInitLibEdit(String initLibEdit) {
        this.initLibEdit = initLibEdit;
    }

    public String getLibId() {
        return libId;
    }

    public void setLibId(String libId) {
        this.libId = libId;
    }

    public String getInitLib() {
        if (super.getRequestParameter("postId") != null) {
            postId = super.getRequestParameter("postId");
            super.getHttpSession().setAttribute("postId", postId);
        }
        return initLib;
    }

    public void setInitLib(String initLib) {
        this.initLib = initLib;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    //指标维护
    private String initKeyList;
    private List keyList;
    private IXysKpiKeyUCC xysKpiKeyUCC;
    private String keyId;
    private String initKey;
    private XysKpiKeyBO keyBo = new XysKpiKeyBO();
    private String editType;

    public String getEditType() {
        return editType;
    }

    public void setEditType(String editType) {
        this.editType = editType;
    }

    public String saveKey() {
        try {
            XysKpiKeyLibBO lib = xysKpiKeyUCC.findXysKpiKeyLibBOById(libId);
            List list = xysKpiKeyUCC.getXysKpiKeyBOByPostId(lib.getPostId());
            double allWeight = 0;
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    XysKpiKeyBO bo = (XysKpiKeyBO) list.get(i);
                    if (editType.equals("add") || (editType.equals("update") && !bo.getKeyId().equals(keyBo.getKeyId()))) {
                        if (bo.getWeight() != null && !bo.getWeight().equals("")) {
                            allWeight += Double.parseDouble(bo.getWeight());
                        }
                    }
                }
            }
            double weight = Double.parseDouble(CommonFuns.filterNullToZero(keyBo.getWeight()));
            if (weight + allWeight > 100) {
                super.showMessageDetail("权重和不能超过100");
                return "";
            } else {
                keyBo.setLibId(libId);
                xysKpiKeyUCC.saveXysKpiKeyBO(keyBo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitKey() {
        try {
            if (super.getRequestParameter("libId") != null) {
                libId = super.getRequestParameter("libId");
                keyBo.initRow();
                editType = "add";
            } else if (super.getRequestParameter("keyId") != null) {
                keyId = super.getRequestParameter("keyId");
                keyBo = xysKpiKeyUCC.findXysKpiKeyBOById(keyId);
                libId = keyBo.getLibId();
                editType = "update";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return initKey;
    }

    public void setInitKey(String initKey) {
        this.initKey = initKey;
    }

    public XysKpiKeyBO getKeyBo() {
        return keyBo;
    }

    public void setKeyBo(XysKpiKeyBO keyBo) {
        this.keyBo = keyBo;
    }

    public String deleteKey() {
        try {
            xysKpiKeyUCC.deleteXysKpiKeyBO(keyId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getKeyId() {
        return keyId;
    }

    public void setKeyId(String keyId) {
        this.keyId = keyId;
    }

    public IXysKpiKeyUCC getXysKpiKeyUCC() {
        return xysKpiKeyUCC;
    }

    public void setXysKpiKeyUCC(IXysKpiKeyUCC xysKpiKeyUCC) {
        this.xysKpiKeyUCC = xysKpiKeyUCC;
    }

    public void queryKeyList() {
        try {
            keyList = xysKpiKeyUCC.getXysKpiKeyBOByLibId(libId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getInitKeyList() {
        if (super.getRequestParameter("libId") != null) {
            libId = super.getRequestParameter("libId");
        }
        queryKeyList();
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


}
