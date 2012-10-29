package com.hr319wg.common.web;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.ucc.IAttachmentUCC;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;

public class UploadPhotoBackingBean extends BaseBackingBean
{
  private String field;
  private String pk;
  private String deleteDes;
  private String deleteInit;
  private UploadedFile myFile;
  private IPersonUCC personucc;
  private IAttachmentUCC attachucc;
  private boolean canEdit = true;

  public boolean isCanEdit() {
    return this.canEdit;
  }
  public void setCanEdit(boolean canEdit) {
    this.canEdit = canEdit;
  }

  public String getDeleteDes() {
    return this.deleteDes;
  }
  public void setDeleteDes(String deleteDes) {
    this.deleteDes = deleteDes;
  }

  public String getDeleteInit() {
    if (super.getRequestParameter("itemID") != null) {
      this.field = super.getRequestParameter("itemID");
      this.pk = super.getRequestParameter("pk");
      InfoItemBO item = SysCacheTool.findInfoItem("", this.field);
      InfoSetBO set = SysCacheTool.findInfoSet(item.getSetId());
      if (InfoSetBO.SET_TYPE_PERSON.equals(set.getSet_bType())) {
        PersonBO pb = SysCacheTool.findPersonById(this.pk);
        this.deleteDes = ("将要删除" + pb.getName() + item.getItemNameEx());
      }
      else {
        OrgBO pb = SysCacheTool.findOrgById(this.pk);
        this.deleteDes = ("将要删除" + pb.getName() + item.getItemNameEx());
      }
    }

    return this.deleteInit;
  }
  public void setDeleteInit(String deleteInit) {
    this.deleteInit = deleteInit;
  }

  public String deletePhoto() {
    try {
      if ((this.pk != null) && (!"".equals(this.pk)) && (this.field != null) && (!"".equals(this.field))) {
        this.attachucc.deleteAttField(this.pk, this.field);
      }
    }
    catch (Exception e)
    {
    }
    SysCache.personCodeMap.clear();
    SysCache.personMap.clear();
    return "success";
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public String getField()
  {
    return this.field;
  }
  public void setField(String field) {
    this.field = field;
  }

  public String getPk() {
    return this.pk;
  }
  public void setPk(String pk) {
    this.pk = pk;
  }

  public String getPageInit() {
    if (super.getRequestParameter("field") != null) {
      this.field = super.getRequestParameter("field");
      this.pk = super.getRequestParameter("pk");
      super.getHttpSession().setAttribute("imgID", super.getRequestParameter("imgID"));
      if ("true".equals(super.getRequestParameter("ReadOnly"))) {
        this.canEdit = false;
      }
      InfoItemBO itembo = SysCacheTool.findInfoItem("", this.field);
      if (itembo != null) {
        super.getHttpSession().setAttribute("height", itembo.getItemMax());
        super.getHttpSession().setAttribute("width", itembo.getItemMin());
      }
      else {
        super.getHttpSession().setAttribute("height", "");
        super.getHttpSession().setAttribute("width", "");
      }
    }
    return this.pageInit;
  }

  public IAttachmentUCC getAttachucc() {
    return this.attachucc;
  }
  public void setAttachucc(IAttachmentUCC ucc) {
    this.attachucc = ucc;
  }

  public UploadedFile getMyFile() {
    return this.myFile;
  }
  public void setMyFile(UploadedFile myFile) {
    this.myFile = myFile;
  }

  public String upload() {
    try {
      if (this.myFile != null) {
        byte[] content = this.myFile.getBytes();
        if (super.getHttpSession().getAttribute("imgID") != null) {
          this.attachucc.deleteAttachment((String)super.getHttpSession().getAttribute("imgID"));
        }
        String id = this.personucc.setAllPhotoField(this.field, this.pk, content);

        super.getHttpSession().setAttribute("imgID", id);
      }
    } catch (Exception e) {
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    return "success";
  }
}