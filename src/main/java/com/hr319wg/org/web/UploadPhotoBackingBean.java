package com.hr319wg.org.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.Constants;
import com.hr319wg.common.ucc.IAttachmentUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.FileUtil;

public class UploadPhotoBackingBean extends BaseBackingBean
{
  private String data;
  private String url;
  private String mode = "0";
  private String fileName;
  private UploadedFile myFile;
  private UploadedFile myziPFile;
  private IOrgUCC orgucc;
  private IPersonUCC personucc;
  private IAttachmentUCC attachucc;
  private List modeList;

  public String getFileName() {
	return fileName;
}
public void setFileName(String fileName) {
	this.fileName = fileName;
}
public String getUrl()
  {
    return this.url;
  }
  public void setUrl(String u) {
    this.url = u;
  }

  public String getMode() {
    return this.mode;
  }
  public void setMode(String mode) {
    this.mode = mode;
  }

  public List getModeList() {
    if (this.modeList == null) {
      this.modeList = new ArrayList();
      SelectItem si = new SelectItem();
      si.setLabel("人员编号");
      si.setValue("0");
      this.modeList.add(si);
      if ("1".equals(Constants.UPLOAD_PHOTO_BYNAME)) {
        SelectItem siname = new SelectItem();
        siname.setLabel("姓名");
        siname.setValue("1");
        this.modeList.add(siname);
      }
      if ("1".equals(Constants.UPLOAD_PHOTO_BYID)) {
        SelectItem siid = new SelectItem();
        siid.setLabel("身份证号");
        siid.setValue("2");
        this.modeList.add(siid);
      }
    }
    return this.modeList;
  }

  public void setModeList(List modeList) {
    this.modeList = modeList;
  }

  public IAttachmentUCC getAttachucc()
  {
    return this.attachucc;
  }
  public void setAttachucc(IAttachmentUCC ucc) {
    this.attachucc = ucc;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC ucc) {
    this.personucc = ucc;
  }

  public IOrgUCC getOrgucc() {
    return this.orgucc;
  }
  public void setOrgucc(IOrgUCC orgucc) {
    this.orgucc = orgucc;
  }

  public String getData() {
    return this.data;
  }
  public void setData(String data) {
    this.data = data;
  }

  public UploadedFile getMyFile() {
    return this.myFile;
  }
  public void setMyFile(UploadedFile myFile) {
    this.myFile = myFile;
  }

  public UploadedFile getMyziPFile() {
    return this.myziPFile;
  }
  public void setMyziPFile(UploadedFile myFile) {
    this.myziPFile = myFile;
  }

  public String upload() {
    try {
      if (this.myFile != null) {
        String itemId = getRequestParameter("imageItemId");
        getHttpSession().setAttribute(itemId, this.myFile.getBytes());

        ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
        String path = context.getRealPath("/") + File.separator + "file" + File.separator + "phototemp";
//        String fileName = FileUtil.parseFileName(this.myFile.getName());
        FileUtil.createFile(this.myFile.getBytes(), path + File.separator + this.fileName);

        InfoItemBO item = SysCacheTool.findInfoItem("", itemId);
        if (("1".equals(Constants.CHECK_PHOTO_SIZE)) && (item != null) && (item.getItemMax() != null) && (item.getItemMin() != null) && (!"".equals(item.getItemMax())) && (!"".equals(item.getItemMin()))) {
          File fi = new File(path + File.separator + fileName);
          BufferedImage bis = ImageIO.read(fi);
          if ((bis.getHeight() != Integer.parseInt(item.getItemMax())) || (bis.getWidth() != Integer.parseInt(item.getItemMin()))) {
            super.showMessageDetail("图片尺寸(宽:高)不是" + item.getItemMin() + ":" + item.getItemMax());
            getHttpSession().removeAttribute(itemId);
          }
        }

        String imgid = getRequestParameter("imageId");
        if ((imgid != null) && (!"".equals(imgid))) {
          String basepath = BaseBackingBean.getServletContext().getRealPath("/");
          this.attachucc.DeleteAttachFile(basepath, imgid);
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    SysCache.personCodeMap.clear();
    SysCache.personMap.clear();
    
    return null;
  }
  public String uploadToFile() {
    try {
      if (this.myFile != null) {
        ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
        String path = context.getRealPath("/") + File.separator + "file" + File.separator + "phototemp";
        String fileName = FileUtil.parseFileName(this.myFile.getName());
        FileUtil.createFile(this.myFile.getBytes(), path + File.separator + fileName);

        this.url = ("/file/phototemp/" + fileName);
      }
    }
    catch (Exception e)
    {
    }
    return "";
  }
  public String savePhoto() {
    ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
    String path = context.getRealPath("/") + File.separator + "file" + File.separator + "phototemp";
    try
    {
      Hashtable hash = (Hashtable)super.getHttpSession().getAttribute("uploadPhoto");
      Iterator key = hash.keySet().iterator();
      while (key.hasNext()) {
        String filename = (String)key.next();
        PersonBO p = (PersonBO)hash.get(filename);
        this.personucc.setPersonPhoto(p.getPersonId(), context.getRealPath("/") + File.separator + "file" + File.separator + "phototemp" + File.separator + filename);
      }
      super.showMessageDetail("保存成功!");
    }
    catch (Exception e) {
      super.showMessageDetail("保存失败!");
    }
    return "";
  }
  public String batchupload() {
    try {
      ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
      String path = context.getRealPath("/") + File.separator + "file" + File.separator + "phototemp";
      String fileName = FileUtil.createFile(this.myziPFile, path);

      List fileList = FileUtil.unZip(path + File.separator + fileName, path);
      Hashtable hash = new Hashtable();
      List errorDes = new ArrayList();
      for (int i = 0; i < fileList.size(); i++) {
        fileName = (String)fileList.get(i);
        String pid = fileName.replaceAll(".JPG", "").replaceAll(".jpg", "");
        PersonBO pb = null;
        if ("0".equals(this.mode)) {
          pb = SysCacheTool.findPersonByCode(pid);
          if (pb == null) {
            errorDes.add(pid + "找不到!");
          }
        }
        else if ("1".equals(this.mode)) {
          List list = SysCache.findPersonByNameAndOrg(pid, super.getUserInfo().getOrgId());
          if ((list == null) || (list.size() == 0)) {
            errorDes.add(pid + "找不到!");
          }
          else if (list.size() > 1) {
            errorDes.add(pid + "有重名!");
          }
          else {
            pb = (PersonBO)list.get(0);
          }
        }
        else if ("2".equals(this.mode)) {
          pb = SysCacheTool.findPersonByIDNum(pid);
          if (pb == null) {
            errorDes.add(pid + "找不到!");
          }
        }

        if (pb != null) {
          hash.put(fileName, pb);
        }
      }
      super.getHttpSession().setAttribute("uploadPhoto", hash);
      super.getHttpSession().setAttribute("errorDes", errorDes);
    }
    catch (Exception e)
    {
    }
    return "success";
  }
}