package com.hr319wg.cont.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.bo.AttachmentBO;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.ucc.IAttachmentUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.cont.pojo.bo.ContBO;
import com.hr319wg.cont.pojo.bo.ContPersonBO;
import com.hr319wg.cont.pojo.bo.ContSignBO;
import com.hr319wg.cont.pojo.bo.ContTemplateBO;
import com.hr319wg.cont.pojo.bo.ContTemplateClassBO;
import com.hr319wg.cont.ucc.IContPersonUCC;
import com.hr319wg.cont.ucc.IContSignUCC;
import com.hr319wg.cont.ucc.IContTemplateClassUCC;
import com.hr319wg.cont.ucc.IContTemplateUCC;
import com.hr319wg.cont.ucc.IContUCC;
import com.hr319wg.cont.util.ContTemplateItem;
import com.hr319wg.cont.util.RTFParser;
import com.hr319wg.cont.util.contTools;
import com.hr319wg.emp.pojo.bo.ChangeInfoBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.SysInProcessBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.RecordVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.ucc.ISysInProcessUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class ContFollowSignBackingBean extends BaseBackingBean
{
  private IContSignUCC ucc;
  private IContPersonUCC contpersonucc;
  private IContTemplateClassUCC ucc_templateClass;
  private IAttachmentUCC ucc_attachment;
  private IContTemplateUCC ucc_template;
  private IPersonUCC personucc;
  private IContUCC contucc;
  private ContSignBO[] bos;
  private ContTemplateClassBO[] bos_templateClass;
  private ContTemplateBO[] bos_template;
  private String newCount;
  private String selectPersonIds;
  private ContSignBO bo = new ContSignBO();

  private List item_templateClass = new ArrayList();
  private List item_template = new ArrayList();
  private String selectContIds;
  private String validDate;
  private String init_a;
  private String personNameQry;
  private String nameStrs;
  private PageVO pagevo = new PageVO();

  private boolean asPersonCode = true;
  private boolean asLogin = true;
  private boolean generateDoc = false;
  private ISysInProcessUCC linkucc;
  private UploadedFile excelFile;
  
  public UploadedFile getExcelFile() {
	return excelFile;
}
public void setExcelFile(UploadedFile excelFile) {
	this.excelFile = excelFile;
}
public ISysInProcessUCC getLinkucc()
  {
    return this.linkucc;
  }
  public void setLinkucc(ISysInProcessUCC ucc) {
    this.linkucc = ucc;
  }

  public String getNameStrs() {
    return this.nameStrs;
  }
  public void setNameStrs(String c) {
    this.nameStrs = c;
  }

  public String getSelectPersonIds() {
    return this.selectPersonIds;
  }
  public void setSelectPersonIds(String PersonIds) {
    this.selectPersonIds = PersonIds;
  }

  public String first() {
    this.pagevo.setCurrentPage(1);
    doQuery();
    return "";
  }
  public String last() {
    this.pagevo.setCurrentPage(this.pagevo.getTotalPage());
    doQuery();
    return "";
  }
  public String pre() {
    if (this.pagevo.getCurrentPage() >= 2) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() - 1);
      doQuery();
    }
    return "";
  }
  public String next() {
    if (this.pagevo.getCurrentPage() < this.pagevo.getTotalPage()) {
      this.pagevo.setCurrentPage(this.pagevo.getCurrentPage() + 1);
      doQuery();
    }
    return "";
  }

  public String getInit_a() {
    doQuery();
    return this.init_a;
  }

  public void setInit_a(String init_a) {
    this.init_a = init_a;
  }
  public String queryMultPerson() {
    try {
      getHttpSession().removeAttribute("cont_selPerObjs");
      User user = getUserInfo();
      TableVO table = new TableVO();
      String sql = this.personucc.queryPersonList(table, this.nameStrs, "", user.getOrgId(), 1, Constants.ACTIVE_PAGE_SIZE, "00900", user, Constants.DEFAULT_QUERY_CONTRACT);
      getHttpSession().setAttribute("cont_selPerObjs", table);

      selPerson();
    } catch (Exception e) {
      getHttpSession().removeAttribute("cont_selPerObjs");
    }
    return null;
  }

  public String getSelectContIds() {
    return this.selectContIds;
  }
  public void setSelectContIds(String selectContIds) {
    this.selectContIds = selectContIds;
  }

  public String getValidDate() {
    return this.validDate;
  }
  public void setValidDate(String validDate) {
    this.validDate = validDate;
  }

  public String getNewCount()
  {
    try {
      this.newCount = (this.contpersonucc.queryAllEndCount(super.getUserInfo().getOrgId()) + "");
    }
    catch (Exception e) {
      this.newCount = "0";
    }
    return this.newCount;
  }
  public void setNewCount(String newCount) {
    this.newCount = newCount;
  }
  public PageVO getPagevo() {
    return this.pagevo;
  }
  public void setPagevo(PageVO vo) {
    this.pagevo = vo;
  }

  public String getPersonNameQry() {
    return this.personNameQry;
  }
  public void setPersonNameQry(String personNameQry) {
    this.personNameQry = personNameQry;
  }

  public IContUCC getContucc() {
    return this.contucc;
  }
  public void setContucc(IContUCC uc) {
    this.contucc = uc;
  }

  public IContTemplateClassUCC getUcc_templateClass() {
    return this.ucc_templateClass;
  }
  public void setUcc_templateClass(IContTemplateClassUCC ucc_templateClass) {
    this.ucc_templateClass = ucc_templateClass;
  }

  public IAttachmentUCC getUcc_attachment() {
    return this.ucc_attachment;
  }
  public void setUcc_attachment(IAttachmentUCC ucc_attachment) {
    this.ucc_attachment = ucc_attachment;
  }

  public IContTemplateUCC getUcc_template() {
    return this.ucc_template;
  }
  public void setUcc_template(IContTemplateUCC ucc_template) {
    this.ucc_template = ucc_template;
  }

  public IContPersonUCC getContpersonucc() {
    return this.contpersonucc;
  }
  public void setContpersonucc(IContPersonUCC ucc) {
    this.contpersonucc = ucc;
  }

  public ContTemplateClassBO[] getBos_templateClass() {
    return this.bos_templateClass;
  }
  public void setBos_templateClass(ContTemplateClassBO[] bos_templateClass) {
    this.bos_templateClass = bos_templateClass;
  }

  public ContTemplateBO[] getBos_template() {
    return this.bos_template;
  }

  public void setBos_template(ContTemplateBO[] bos_template) {
    this.bos_template = bos_template;
  }

  public List getItem_templateClass() {
    if ((this.item_templateClass != null) && (this.item_templateClass.size() != 0) && (this.item_templateClass.size() != 1)) return this.item_templateClass;
    this.item_templateClass = doqueryTemplateClass();
    return this.item_templateClass;
  }

  public void setItem_templateClass(List item_templateClass) {
    this.item_templateClass = item_templateClass;
  }

  public List getItem_template() {
    if ((this.item_template != null) && (this.item_template.size() != 0) && (this.item_template.size() != 1)) return this.item_template;
    this.item_template = doQueryTemplate(this.bo.getTemplateClassId());
    return this.item_template;
  }
  public void setItem_template(List item_template) {
    this.item_template = item_template;
  }

  public boolean isGenerateDoc() {
    return this.generateDoc;
  }
  public void setGenerateDoc(boolean b) {
    this.generateDoc = b;
  }

  public IContSignUCC getUcc() {
    return this.ucc;
  }
  public void setUcc(IContSignUCC ucc) {
    this.ucc = ucc;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public ContSignBO[] getBos() {
    return this.bos;
  }
  public void setBos(ContSignBO[] bos) {
    this.bos = bos;
  }

  public ContSignBO getBo() {
    return this.bo;
  }
  public void setBo(ContSignBO bo) {
    this.bo = bo;
  }

  public String queryAll()
  {
    doQuery();
    return null;
  }

  public void doQuery() {
    try {
      if (this.pagevo.getCurrentPage() == 0) {
        this.pagevo.setCurrentPage(1);
      }
      this.bos = this.ucc.queryAll(super.getUserInfo().getOrgId(), this.personNameQry, "'022003'", this.pagevo);

      if (this.bos != null) {
        for (int i = 0; i < this.bos.length; i++) {
          PersonBO temp_personbo = SysCacheTool.findPersonById(this.bos[i].getPersonId());
          if (temp_personbo != null) {
            String sex = temp_personbo.getSex();
            String jobType = temp_personbo.getPersonType();
            this.bos[i].getContPersonBO().setPersonCode(temp_personbo.getPersonCode());
            this.bos[i].getContPersonBO().setPersonSex(CodeUtil.interpertCode("0100", sex));
            this.bos[i].getContPersonBO().setJobType(CodeUtil.interpertCode("0135", jobType));
            this.bos[i].getContPersonBO().setIdCard(temp_personbo.getIdCard());
          }
        }
        this.bos = ((ContSignBO[])(ContSignBO[])contTools.codeInterpret_cont(this.bos));
      }
    }
    catch (Exception ex) {
      this.msg.setMainMsg(ex, getClass());
    }
  }

  public String deleteSingle() {
    try {
      String contId = getServletRequest().getParameter("contId");
      if ((contId == null) || (contId.equals(""))) {
        throw new SysException("E0600002", "", null, getClass());
      }
      String attachmentId = getServletRequest().getParameter("attachmentId");
      if ((attachmentId == null) || (attachmentId.equals(""))) {
        throw new SysException("E0600002", "", null, getClass());
      }
      this.ucc.deleteCont(contId);
      this.ucc_attachment.deleteAttachment(attachmentId);
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
    }
    this.bos = null;
    return "";
  }

  public String deleteBatch() {
    String[] ids = getServletRequest().getParameterValues("selected_ids");
    try {
      if (ids != null)
        for (int i = 0; i < ids.length; i++) {
          String[] temp = CommonFuns.getStringArray(ids[i], ",");
          this.ucc.deleteCont(temp[0]);
          if (temp.length == 3)
            this.ucc_attachment.deleteAttachment(temp[2]);
        }
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
    }
    this.bos = null;
    return "";
  }

  public String toValid() {
    String[] ids = getServletRequest().getParameterValues("selected_ids");
    try {
      if (ids != null) {
        List messageList = new ArrayList();
        for (int i = 0; i < ids.length; i++) {
          String[] temp = CommonFuns.getStringArray(ids[i], ",");
          ContBO contbo = this.contucc.findContById(temp[0]);
          String personId = contbo.getContPersonBO().getPersonId();
          ContPersonBO contpersonbo = this.contpersonucc.findContPersonById(personId);
          this.contpersonucc.getAllInfo(contpersonbo);
          if ((!"1".equals(Constants.CONT_AUDIT_MODE)) && (!"2".equals(Constants.CONT_AUDIT_MODE)))
            continue;
          if (contbo.getApproveStatus().equals("201003")) {
            long flag = CommonFuns.betweenDays(CommonFuns.getSysDate("yyyy-MM-dd"), contbo.getUptoValidDate());
            if (flag > 0L)
            {
              contbo.setValidOverdue("过期");
              contbo.setApproveStatus("201001");
              contbo.setApproveDate("");
              contbo.setApproveOrgId("");
              contbo.setApprovePersonId("");
              contbo.setApproveRemark("");
              contbo.setUptoValidDate("");

              contpersonbo.setApproveStatus("201001");

              this.contucc.updateCont(contbo.getContId(), contbo);
              this.contpersonucc.updateContPerson(contpersonbo.getPersonId(), contpersonbo);
              messageList.add(contpersonbo.getPersonName());
            }
          }
          else {
            messageList.add(contpersonbo.getPersonName());
          }
        }

        if (messageList.size() != 0) {
          String message = "";
          for (int i = 0; i < messageList.size(); i++) {
            if (i == messageList.size() - 1)
              message = message + "[" + (i + 1) + "]" + (String)messageList.get(i);
            else {
              message = message + "[" + (i + 1) + "]" + (String)messageList.get(i) + "、";
            }
          }
          showMessageDetail("操作失败：以下人员的合同已过了截止时间或没有审批，请报审这些人员的合同：\\n");
        }
        else {
          this.ucc.makeLinkForContSign(ids, this.validDate);

          if (ids != null) {
            for (int i = 0; i < ids.length; i++) {
              ChangeInfoBO bo = this.personucc.getChangeInfoByPidToOrg(ids[i].split(",")[1], super.getUserInfo().getOrgId());
              if (bo != null) {
                bo.setCont_new_begin("1");
                this.personucc.saveOrUpdateChangeInfo(bo);
              }
            }
          }
        }
      }
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
    }
    this.bos = null;
    return "";
  }

  public void doClear()
  {
    this.bo = new ContSignBO();
    this.bos = null;
    this.bos_templateClass = null;
    this.bos_template = null;
    this.item_templateClass = new ArrayList();
    this.item_template = new ArrayList();

    getHttpSession().removeAttribute("cont_selPerObjs");
  }

  public String forwardList() {
    doClear();
    return "cont_followSignList_jsf";
  }

  public String forwardAdd() {
    this.bo = new ContSignBO();
    if ((this.bo.getCreateOrgId() == null) || ("".equals(this.bo.getCreateOrgId()))) {
      this.bo.setCreateOrgId(((User)getHttpSession().getAttribute("USER_INFO")).getOrgId());
    }
    if ((this.bo.getContClass() == null) || ("".equals(this.bo.getContClass()))) {
      this.bo.setContClass("022003");
    }
    if ((this.bo.getIsValid() == null) || ("".equals(this.bo.getIsValid()))) {
      this.bo.setIsValid("202001");
    }
    if ((this.bo.getContCreateDate() == null) || ("".equals(this.bo.getContCreateDate()))) {
      this.bo.setContCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
    }
    getHttpSession().removeAttribute("cont_selPerObjs");
    return "cont_followSignAdd_jsf";
  }

  public String selPerson()
  {
    try {
      ContSignBO tempbo = new ContSignBO();
      CommonFuns.copyProperties(tempbo, this.bo);
      CommonFuns.copyProperties(this.bo, contTools.codeToGBK_contSign(tempbo));

      if (getHttpSession().getAttribute("cont_selPerObjs") == null) {
        return "";
      }
      RecordVO[] selPerObjs = ((TableVO)getHttpSession().getAttribute("cont_selPerObjs")).getRowData();
      if ((selPerObjs == null) || (selPerObjs.length == 0)) {
        return "";
      }
      List new_list = new ArrayList();
      List messageList = new ArrayList();
      for (int i = 0; i < selPerObjs.length; i++) {
        String temp_personId = ((CellVO)selPerObjs[i].cellArray2Hash().get("ID")).getValue();
        if ((temp_personId == null) || (temp_personId.equals("")))
          continue;
        ContPersonBO cp = this.contpersonucc.findContPersonById(temp_personId);
        if ((cp == null) || (!"022006".equals(cp.getContClass())) || (!"202002".equals(cp.getIsValid()))) {
          PersonBO temp_bo_person = SysCacheTool.findPersonById(temp_personId);
          messageList.add(temp_bo_person.getName());
        }
        else if (this.ucc.findContByPersonId(temp_personId) != null) {
          PersonBO temp_bo_person = SysCacheTool.findPersonById(temp_personId);
          messageList.add(temp_bo_person.getName());
        }
        else {
          new_list.add(selPerObjs[i]);
        }
      }

      RecordVO[] new_selPerObjs = new RecordVO[new_list.size()];
      for (int i = 0; i < new_list.size(); i++) {
        new_selPerObjs[i] = ((RecordVO)new_list.get(i));
      }
      ((TableVO)getHttpSession().getAttribute("cont_selPerObjs")).setRowData(new_selPerObjs);
      if (messageList.size() > 0) {
        String message = "";
        for (int i = 0; (i < messageList.size()) && (i < 50); i++) {
          if (i == messageList.size() - 1)
            message = message + "[" + (i + 1) + "]" + (String)messageList.get(i);
          else {
            message = message + "[" + (i + 1) + "]" + (String)messageList.get(i) + "、";
          }
        }
        if (messageList.size() > 50) {
          message = message + "等等";
        }
        showMessageDetail("提示：只有已终止合同的人才能续签,以下人员不符合条件或已进行了操作,将不会列在查询结果中：\\n" + message);
      }
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
    }
    return "";
  }

  public String selectPerson() {
    try {
      if ((this.selectPersonIds == null) || (this.selectPersonIds.equals(""))) {
        throw new SysException("E0600002", "", null, getClass());
      }
      TableVO table = new TableVO();
      String sql = this.personucc.queryPersonList(table, this.selectPersonIds, 1, Constants.ACTIVE_PAGE_SIZE, super.getUserInfo(), null);
      getHttpSession().setAttribute("cont_selPerObjs", table);
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
    }
    return "";
  }

  public String delPerson()
  {
    try {
      String[] temp_dlePersonIds = getServletRequest().getParameterValues("chk");
      if (temp_dlePersonIds == null) return "";
      String dlePersonIds = "";
      for (int i = 0; i < temp_dlePersonIds.length; i++) {
        dlePersonIds = dlePersonIds + temp_dlePersonIds[i] + ",";
      }
      RecordVO[] old_selPerObjs = ((TableVO)getHttpSession().getAttribute("cont_selPerObjs")).getRowData();
      List new_list = new ArrayList();
      for (int i = 0; i < old_selPerObjs.length; i++) {
        String temp_personId = ((CellVO)old_selPerObjs[i].cellArray2Hash().get("ID")).getValue();
        if (dlePersonIds.indexOf(temp_personId) == -1) {
          new_list.add(old_selPerObjs[i]);
        }
      }
      RecordVO[] new_selPerObjs = new RecordVO[new_list.size()];
      for (int i = 0; i < new_list.size(); i++) {
        new_selPerObjs[i] = ((RecordVO)new_list.get(i));
      }
      ((TableVO)getHttpSession().getAttribute("cont_selPerObjs")).setRowData(new_selPerObjs);
    }
    catch (Exception ex) {
      this.msg.setMainMsg(ex, getClass());
    }
    return "";
  }

  public List doQueryTemplate(String templateClassId) {
    List temp_item_template = new ArrayList();
    SelectItem defaultSelect = new SelectItem();
    defaultSelect.setLabel("请选择");
    defaultSelect.setValue("");
    temp_item_template.add(defaultSelect);
    try
    {
      this.bos_template = this.ucc_template.queryAll(((User)getHttpSession().getAttribute("USER_INFO")).getOrgId(), templateClassId, "'201103'");
      if (this.bos_template == null) return temp_item_template;
      for (int i = 0; i < this.bos_template.length; i++) {
        SelectItem tmp = new SelectItem();
        tmp.setLabel(this.bos_template[i].getTemplateName());
        tmp.setValue(this.bos_template[i].getTemplateId());
        temp_item_template.add(tmp);
      }
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
      temp_item_template = new ArrayList();
    }
    return temp_item_template;
  }

  public List doqueryTemplateClass() {
    List temp_item_templateClass = new ArrayList();
    SelectItem defaultSelect = new SelectItem();
    defaultSelect.setLabel("请选择");
    defaultSelect.setValue("");
    temp_item_templateClass.add(defaultSelect);
    try {
      this.bos_templateClass = this.ucc_templateClass.queryAll(((User)getHttpSession().getAttribute("USER_INFO")).getOrgId());
      if (this.bos_templateClass == null) return temp_item_templateClass;
      for (int i = 0; i < this.bos_templateClass.length; i++) {
        SelectItem tmp = new SelectItem();
        tmp.setLabel(this.bos_templateClass[i].getTemplateClassName());
        tmp.setValue(this.bos_templateClass[i].getTemplateClassId());
        temp_item_templateClass.add(tmp);
      }
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
      temp_item_templateClass = new ArrayList();
    }
    return temp_item_templateClass;
  }

  public void templateClassChanged(ValueChangeEvent event) {
    String templateClassId = (String)event.getNewValue();
    this.item_template = doQueryTemplate(templateClassId);
  }

  public String save_add() {
    try {
      if (getHttpSession().getAttribute("cont_selPerObjs") == null) {
        super.showMessageDetail("没有选择人员!");
        return "";
      }
      RecordVO[] selPerObjs = ((TableVO)getHttpSession().getAttribute("cont_selPerObjs")).getRowData();
      if ((selPerObjs == null) || (selPerObjs.length == 0)) {
        super.showMessageDetail("没有选择人员!");
        return "";
      }
      for (int i = 0; i < selPerObjs.length; i++) {
        String temp_personId = ((CellVO)selPerObjs[i].cellArray2Hash().get("ID")).getValue();
        if ((temp_personId != null) && (!temp_personId.equals(""))) {
          PersonBO temp_bo_person = SysCacheTool.findPersonById(temp_personId);
          this.bo.setPersonId(temp_personId);
          this.bo.setPersonName(temp_bo_person.getName());
          this.bo.setContCode(this.ucc.getContCode(temp_personId));

          if (this.generateDoc) {
            String template_attachment_id = this.ucc_template.findContTemplateById(this.bo.getTemplateId()).getAttachmentId();
            byte[] fileContent = this.ucc_attachment.getFileContent(template_attachment_id);
            AttachmentBO tempAttachmentbo = this.ucc_attachment.findAttachmentById(template_attachment_id);

            this.bo.setPersonName(temp_bo_person.getName());

            ContSignBO newContSignbo = this.bo;

            ContPersonBO temp_bo_contPerson = contTools.personBOToContPersonBO(temp_bo_person);
            temp_bo_contPerson = (ContPersonBO)contTools.codeInterpret_person(temp_bo_contPerson);

            newContSignbo = (ContSignBO)contTools.codeInterpret_cont(newContSignbo);

            RTFParser parser = new RTFParser(ContTemplateItem.createHash(temp_bo_contPerson, newContSignbo));
            byte[] newFileContent = parser.returnNewContent(fileContent);
            String cont_attachment_id = this.ucc_attachment.createAttachment(newFileContent, tempAttachmentbo.getContentType(), "合同.rtf", tempAttachmentbo.getAttachmentSize(), "cont", "followSign");
            this.bo.setAttachmentId(cont_attachment_id);
          }
          else {
            this.bo.setAttachmentId(null);
          }

          this.bo.setApproveStatus(ContPersonBO.STATUS_INIT);
          this.ucc.createCont(this.bo);

          ContPersonBO cpb = this.contpersonucc.findContPersonById(temp_personId);
          cpb.setContClass(this.bo.getContClass());
          this.contpersonucc.updateContPerson(temp_personId, cpb);
        }
      }
    } catch (Exception ex) {
      this.msg.setMainMsg(ex, getClass());
      getHttpSession().removeAttribute("cont_selPerObjs");
      return "";
    }
    return forwardList();
  }

  public String save_edit() {
    try {
      if ((this.selectContIds == null) || (this.selectContIds.equals(""))) {
        super.showMessageDetail("请选择人员!");
        return "";
      }
      String[] temp = CommonFuns.getStringArray(this.selectContIds, ",");
      for (int i = 0; i < temp.length; i++) {
        ContSignBO tempContbo = this.ucc.findContById(temp[i]);
        if (tempContbo != null) {
          PersonBO tempPersonbo = SysCacheTool.findPersonById(tempContbo.getPersonId());

          this.bo.setContId(tempContbo.getContId());
          this.bo.setContCode(tempContbo.getContCode());
          this.bo.setPersonId(tempContbo.getPersonId());
          this.bo.setPersonName(tempContbo.getPersonName());
          this.bo.setAttachmentId(tempContbo.getAttachmentId());
          this.bo.setCreateOrgId(tempContbo.getCreateOrgId());
          this.bo.setIsValid(tempContbo.getIsValid());
          this.bo.setContCreateDate(tempContbo.getContCreateDate());
          this.bo.setMainContCode(tempContbo.getMainContCode());
          this.bo.setMainContValidDate(tempContbo.getMainContValidDate());
          ContSignBO newbo = this.bo;
          if (this.generateDoc) {
            String template_attachment_id = this.ucc_template.findContTemplateById(this.bo.getTemplateId()).getAttachmentId();
            byte[] fileContent = this.ucc_attachment.getFileContent(template_attachment_id);
            AttachmentBO tempAttachmentbo = this.ucc_attachment.findAttachmentById(template_attachment_id);

            ContPersonBO temp_bo_contPerson = contTools.personBOToContPersonBO(tempPersonbo);
            temp_bo_contPerson = (ContPersonBO)contTools.codeInterpret_person(temp_bo_contPerson);

            newbo = (ContSignBO)contTools.codeInterpret_cont(newbo);

            RTFParser parser = new RTFParser(ContTemplateItem.createHash(temp_bo_contPerson, newbo));
            byte[] newFileContent = parser.returnNewContent(fileContent);
            this.ucc_attachment.updateAttachment(this.bo.getAttachmentId(), newFileContent, tempAttachmentbo.getContentType(), "合同.rtf", tempAttachmentbo.getAttachmentSize(), "cont", "followSign");
          }
          this.ucc.updateCont(this.bo.getContId(), this.bo);
        }
      }
    } catch (Exception ex) {
      this.msg.setMainMsg(ex, getClass());
      return "";
    }
    return forwardList();
  }
  public String toApprove() {
    String[] ids = getServletRequest().getParameterValues("selected_ids");
    try {
      if (ids != null) {
        String msg = "";
        for (int i = 0; i < ids.length; i++) {
          String[] temp = CommonFuns.getStringArray(ids[i], ",");
          ContBO tempbo1 = this.contucc.findContById(temp[0]);
          String personId = tempbo1.getContPersonBO().getPersonId();
          ContPersonBO tempbo2 = this.contpersonucc.findContPersonById(personId);
          if (i == 0) {
            msg = CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, personId);
          }

          if ("201003".equals(tempbo1.getApproveStatus()))
          {
            continue;
          }
          tempbo1.setApproveStatus("201002");
          tempbo1.setOperator(super.getUserInfo().getUserId());

          tempbo2.setApproveStatus("201002");

          this.contucc.updateCont(temp[0], tempbo1);
          this.contpersonucc.updateContPerson(personId, tempbo2);
        }
        SysInProcessBO sb = new SysInProcessBO();

        sb.setSendPerson(super.getUserInfo().getUserId());
        sb.setSendDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
        sb.setHave_process("0");
        if ("1".equals(Constants.CONT_AUDIT_MODE)) {
          sb.setContent("续签合同,请审批");
          sb.setOrguid(super.getUserInfo().getOrgId());
          sb.setOperateID("0430");
        }
        else {
          sb.setContent(super.getUserInfo().getOrgName() + "续签合同,请审批");
          sb.setOrguid("-1");
          sb.setOperateID("0412");
        }
        this.linkucc.saveProcessBO(sb);
      }
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
    }
    this.bos = null;
    return "";
  }

  public String toCancelApprove() {
    String[] ids = getServletRequest().getParameterValues("selected_ids");
    try {
      if (ids != null)
        for (int i = 0; i < ids.length; i++) {
          String[] temp = CommonFuns.getStringArray(ids[i], ",");
          ContBO tempbo1 = this.contucc.findContById(temp[0]);
          String personId = tempbo1.getContPersonBO().getPersonId();
          ContPersonBO tempbo2 = this.contpersonucc.findContPersonById(personId);

          if (!tempbo1.getApproveStatus().equals("201002")) {
            throw new SysException("请选择合同审查状态是待审查状态的合同进行此操作", "[" + tempbo2.getPersonName() + "]", null, getClass());
          }

          tempbo1.setApproveStatus("201001");

          tempbo2.setApproveStatus("201001");

          this.contucc.updateCont(temp[0], tempbo1);
          this.contpersonucc.updateContPerson(personId, tempbo2);
        }
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
    }
    this.bos = null;
    return "";
  }

  public String findByIds()
  {
    String[] ids = getServletRequest().getParameterValues("selected_ids");
    if (ids == null) return forwardList();
    String id = "";
    String personIds = "";
    this.selectContIds = "";
    try
    {
      for (int i = 0; i < ids.length; i++) {
        String[] temp = CommonFuns.getStringArray(ids[i], ",");
        if (temp.length <= 3) {
          if (i == 0) id = temp[0];
          this.selectContIds = (this.selectContIds + temp[0] + ",");
          if (i != ids.length - 1)
            personIds = personIds + "'" + temp[1] + "',";
          else {
            personIds = personIds + "'" + temp[1] + "'";
          }
        }
      }

      ContSignBO tempbo = this.ucc.findContById(id);
      CommonFuns.copyProperties(this.bo, tempbo);
      this.ucc.makeTableVO(personIds);
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
      doClear();
      return "";
    }
    return "cont_followSignEdit_jsf";
  }

  public String findById() {
    try {
      String id = getServletRequest().getParameter("contId");
      if ((id == null) || (id.equals(""))) {
        throw new SysException("E0600002", "", null, getClass());
      }
      ContSignBO tempbo = this.ucc.findContById(id);
      CommonFuns.copyProperties(this.bo, tempbo);
      this.selectContIds = (tempbo.getContId() + ",");
      String personId = "'" + tempbo.getPersonId() + "'";
      this.ucc.makeTableVO(personId);
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
      doClear();
      return "";
    }
    return "cont_followSignEdit_jsf";
  }

  public boolean isAsLogin() {
    return this.asLogin;
  }
  public void setAsLogin(boolean b) {
    this.asLogin = b;
  }

  public boolean isAsPersonCode() {
    return this.asPersonCode;
  }
  public void setAsPersonCode(boolean b) {
    this.asPersonCode = b;
  }

  public String save_mainContCode() {
    try {
      String msg = "";
      if (this.bos == null) return forwardList();
      for (int i = 0; i < this.bos.length; i++)
      {
        PersonBO tempPersonbo = SysCacheTool.findPersonById(this.bos[i].getPersonId());
        if (!this.ucc.checkContCode(tempPersonbo.getPersonId(), tempPersonbo.getOrgId(), this.bos[i].getContCode())) {
          if ("".equals(msg)) {
            msg = tempPersonbo.getName();
          }
          else
            msg = msg + "," + tempPersonbo.getName();
        }
        else
        {
          if (this.bos[i].getTemplateId() != null)
          {
            String template_attachment_id = this.ucc_template.findContTemplateById(this.bos[i].getTemplateId()).getAttachmentId();
            if (template_attachment_id != null) {
              byte[] fileContent = this.ucc_attachment.getFileContent(template_attachment_id);
              AttachmentBO tempAttachmentbo = this.ucc_attachment.findAttachmentById(template_attachment_id);

              ContPersonBO temp_bo_contPerson = contTools.personBOToContPersonBO(tempPersonbo);
              temp_bo_contPerson = (ContPersonBO)contTools.codeInterpret_person(temp_bo_contPerson);

              ContSignBO newbo = new ContSignBO();
              CommonFuns.copyProperties(newbo, this.bos[i]);
              newbo = (ContSignBO)contTools.codeInterpret_cont(newbo);

              RTFParser parser = new RTFParser(ContTemplateItem.createHash(temp_bo_contPerson, newbo));
              byte[] newFileContent = parser.returnNewContent(fileContent);
              this.ucc_attachment.updateAttachment(this.bos[i].getAttachmentId(), newFileContent, tempAttachmentbo.getContentType(), "合同.rtf", tempAttachmentbo.getAttachmentSize(), "cont", "endSign");
            }
          }
          this.ucc.updateCont(this.bos[i].getContId(), this.bos[i]);
          if (this.asPersonCode) {
            this.personucc.updatePersonCodeDirect(this.bos[i].getPersonId(), this.bos[i].getContCode());
            SysCache.setPerson(this.bos[i].getPersonId(), 3);
          }
          if (this.asLogin)
            this.personucc.updatePersonLoginName(this.bos[i].getPersonId(), this.bos[i].getContCode());
        }
      }
      if (!"".equals(msg)) {
        super.showMessageDetail("以下人员的合同编号重复或不在规定的区段内：" + msg);
        return "";
      }
    }
    catch (Exception ex) {
      this.msg.setMainMsg(ex, getClass());
      return "";
    }
    return forwardList();
  }

  public String editMainContCode() {
    try {
      String[] ids = getServletRequest().getParameterValues("selected_ids");
      if (ids == null) return forwardList();
      this.bos = new ContSignBO[ids.length];
      for (int i = 0; i < ids.length; i++) {
        String[] temp = CommonFuns.getStringArray(ids[i], ",");
        if (temp.length <= 3) {
          String temp_contId = temp[0];
          ContSignBO tempbo = this.ucc.findContById(temp_contId);
          this.bos[i] = new ContSignBO();
          CommonFuns.copyProperties(this.bos[i], tempbo);
        }
      }
    }
    catch (Exception ex)
    {
      this.msg.setMainMsg(ex, getClass());
      doClear();
      return "";
    }
    return "cont_followSignEditMainContCode_jsf";
  }
  public void uploadFile(){
	  PageVO pageVo1=new PageVO();
	  pageVo1.setCurrentPage(1);
	  pageVo1.setPageSize(999999999);
		try {
			ContSignBO[]list= this.contpersonucc.queryAllEnd(super.getUserInfo().getOrgId(), null, pageVo1);
			if(list!=null){
				List<ContSignBO> contList = new ArrayList<ContSignBO>();
				Map m = new HashMap();
				Map contType = new HashMap();
				contType.put("无固定期限", "02151");
				contType.put("有固定期限", "02152");
				contType.put("以完成一定工作为期限", "02153");
				contType.put("见习期", "0215700456");
				contType.put("试用期", "0215700457");
				for(int i=0;i<list.length ;i++){
					m.put(list[i].getPersonId(), list[i]);
				}
				Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
				Sheet st=wb.getSheet(0);
				int stRow=st.getRows();
				boolean pass=true;
				
				for(int i=1;i<stRow;i++){
					ContSignBO bo = new ContSignBO();
					String pCode = st.getCell(0, i).getContents();
					if(pCode==null || "".equals(pCode)){
						break;
					}
					PersonBO p = SysCacheTool.findPersonByCode(pCode);
					if(p==null){
						super.showMessageDetail("第"+i+"行人员编号"+pCode+"不存在");
						pass=false;
						break;
					}
					if(!m.containsKey(p.getPersonId())){
						super.showMessageDetail("第"+i+"行人员编号"+pCode+"的合同还未到期");
						pass=false;		
						break;
					}
					bo.setPersonId(p.getPersonId());
					String type = st.getCell(2, i).getContents();
					if(!contType.containsKey(type)){
						super.showMessageDetail("第"+i+"行合同期限类型"+type+"不合法");
						pass=false;
						break;
					}
					bo.setContTermClass(String.valueOf(contType.get(type)));
					String start = st.getCell(3, i).getContents();
					if(start==null || "".equals(start)){
						super.showMessageDetail("第"+i+"行合同起始时间不能为空");
						pass=false;	
						break;
					}
					bo.setContStartDate(start.replaceAll("/", "-"));
					String end = st.getCell(4, i).getContents();
					if(end==null || "".equals(end)){
						super.showMessageDetail("第"+i+"行合同起始时间不能为空");
						pass=false;	
						break;
					}
					bo.setContEndDate(end.replaceAll("/", "-"));
					ContSignBO bo1=(ContSignBO)m.get(p.getPersonId());
					bo.setContCode(bo1.getContCode());
					bo.setPersonName(p.getName());
					bo.setContClass("022003");
					bo.setApproveStatus("201001");
					bo.setCreateOrgId(super.getUserInfo().getOrgId());
					bo.setIsValid("202001");
					bo.setContCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					contList.add(bo);
				}
				if(pass){
					this.contucc.batchAddFollowCont(contList);
				}
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}
}