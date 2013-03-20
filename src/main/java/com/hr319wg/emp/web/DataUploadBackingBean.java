package com.hr319wg.emp.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;
import javax.servlet.ServletContext;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IDataUploadUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.bo.SysImportSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.ucc.IInfoSetUCC;
import com.hr319wg.sys.ucc.ISetshowItemsUCC;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;

public class DataUploadBackingBean extends BaseBackingBean
{
  private IInfoSetUCC infosetucc;
  private IDataUploadUCC datauploaducc;
  private String mode;
  private String setID;
  private String date;
  private String field;
  private String codeType = "1";
  private List modelist;
  private String moduleid;
  private String initBySet;
  private String secondKey = "A001999";
  private String secondKeyName = "旧系统员工编号";
  private ISetshowItemsUCC showitemucc;
  private UploadedFile excelFile;
  private List orgSetList;
  private String orgSelSet;
  private List orgSetItemList;
  private List perSetList;
  private String perSelSet;
  private List perSetItemList;
  private List selitem;
  private String errorFileUrl = "";

  private boolean showError = false;
  private String configname;
  private String configID;
  private String[]inputField;
  private List uploadValueList;
  private ICommonService commonService;

  public List getUploadValueList() {
	return uploadValueList;
}
public void setUploadValueList(List uploadValueList) {
	this.uploadValueList = uploadValueList;
}
public ICommonService getCommonService() {
	return commonService;
}
public void setCommonService(ICommonService commonService) {
	this.commonService = commonService;
}
public String[] getInputField() {
	return inputField;
}
public void setInputField(String[] inputField) {
	this.inputField = inputField;
}

public String getCodeType()
  {
    return this.codeType;
  }
  public void setCodeType(String codeType) {
    this.codeType = codeType;
  }

  public String getSecondKey()
  {
    return this.secondKey;
  }
  public void setSecondKey(String d) {
    this.secondKey = d;
  }

  public String getSecondKeyName() {
    return this.secondKeyName;
  }
  public void setSecondKeyName(String d) {
    this.secondKeyName = d;
  }

  public String getField() {
    return this.field;
  }
  public void setField(String d) {
    this.field = d;
  }

  public String getDate() {
    return this.date;
  }
  public void setDate(String d) {
    this.date = d;
  }

  public String getModuleid() {
    return this.moduleid;
  }
  public void setModuleid(String id) {
    this.moduleid = id;
  }

  public String getSetID() {
    return this.setID;
  }
  public void setSetID(String id) {
    this.setID = id;
  }

  public String getPageInit() {
    if (super.getRequestParameter("moduleid") != null) {
      this.moduleid = super.getRequestParameter("moduleid");
      this.perSetList = null;
    }
    return this.pageInit;
  }

  public String getInitBySet() {
    if (super.getRequestParameter("setID") != null) {
      this.setID = super.getRequestParameter("setID");
      if ("A810".equals(this.setID)) {
        this.secondKey = "A001736";
        this.secondKeyName = "考勤卡号";
      }
      this.date = super.getRequestParameter("TimeValue");
      this.field = super.getRequestParameter("TimeField");
      this.perSetList = null;
    }
    return this.initBySet;
  }
  public void setInitBySet(String set) {
    this.initBySet = set;
  }

  public List getSelitem()
  {
    if (this.selitem == null) {
      this.selitem = new ArrayList();
      SelectItem s = new SelectItem();
      s.setLabel("--选择预定义配置--");
      s.setValue("");
      this.selitem.add(s);
      try {
        if (this.perSelSet != null) this.setID = this.perSelSet;
        List ltemp = this.showitemucc.getImportSet(super.getUserInfo().getUserId(), this.setID);
        for (int i = 0; i < ltemp.size(); i++) {
          SysImportSetBO ws = (SysImportSetBO)ltemp.get(i);
          SelectItem si = new SelectItem();
          si.setLabel(ws.getItemName());
          String[] fl = ws.getSetcontent().split(",");
          String content = ws.getItemID();
          for (int j = 0; j < fl.length; j++) {
            InfoItemBO ii = SysCacheTool.findInfoItem("", fl[j]);
            content = content + "|" + fl[j] + "," + ii.getItemName();
          }
          si.setValue(content);
          this.selitem.add(si);
        }
      }
      catch (Exception e)
      {
      }
    }
    return this.selitem;
  }
  public void setSelitem(List li) {
    this.selitem = li;
  }

  public IInfoSetUCC getInfosetucc() {
    return this.infosetucc;
  }
  public void setInfosetucc(IInfoSetUCC ucc) {
    this.infosetucc = ucc;
  }

  public IDataUploadUCC getDatauploaducc() {
    return this.datauploaducc;
  }
  public void setDatauploaducc(IDataUploadUCC datauploaducc) {
    this.datauploaducc = datauploaducc;
  }

  public ISetshowItemsUCC getShowitemucc() {
    return this.showitemucc;
  }
  public void setShowitemucc(ISetshowItemsUCC ucc) {
    this.showitemucc = ucc;
  }

  public UploadedFile getExcelFile() {
    return this.excelFile;
  }
  public void setExcelFile(UploadedFile excelFile) {
    this.excelFile = excelFile;
  }

  public List getOrgSetList() {
    if (this.orgSetList != null) return this.orgSetList; try
    {
      this.orgSetList = new ArrayList();
      List list = this.infosetucc.getAllInportOrgSet();
      for (int i = 0; i < list.size(); i++) {
        SelectItem item = new SelectItem();
        InfoSetBO bo = (InfoSetBO)list.get(i);
        item.setLabel(bo.getSetNameEx());
        item.setValue(bo.getSetId());
        this.orgSetList.add(item);
      }
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return this.orgSetList;
  }

  public void setOrgSetList(List orgSetList) {
    this.orgSetList = orgSetList;
  }

  public String getOrgSelSet() {
    return this.orgSelSet;
  }
  public void setOrgSelSet(String orgSelSet) {
    this.orgSelSet = orgSelSet;
  }

  public List getOrgSetItemList() {
    if (this.orgSetItemList != null) return this.orgSetItemList; try
    {
      String val = this.orgSelSet;
      InfoItemBO[] bo = this.datauploaducc.querySetItem(val);
      if ((bo != null) && (bo.length > 0)) {
        this.orgSetItemList = new ArrayList();
        for (int i = 0; i < bo.length; i++) {
          SelectItem item = new SelectItem();
          item.setLabel(bo[i].getItemName());
          item.setValue(bo[i].getItemId());
          this.orgSetItemList.add(item);
        }
      }
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return this.orgSetItemList;
  }
  public void setOrgSetItemList(List orgSetItemList) {
    this.orgSetItemList = orgSetItemList;
  }

  public List getPerSetList() {
    if (this.perSetList != null) return this.perSetList; try
    {
      this.perSetList = new ArrayList();
      if ((this.setID == null) || ("".equals(this.setID))) {
        List list = this.infosetucc.getAllInportPersonSet();
        for (int i = 0; i < list.size(); i++) {
          InfoSetBO bo = (InfoSetBO)list.get(i);
          if ((this.moduleid != null) && 
            ("BXGL".equals(this.moduleid)) && (!"2001010402".equals(bo.getSet_sType())))
            continue;
          SelectItem item = new SelectItem();
          item.setLabel(bo.getSetNameEx());
          item.setValue(bo.getSetId());
          this.perSetList.add(item);
          if (i != 0) continue; this.perSelSet = bo.getSetId();
        }
      }
      else {
        InfoSetBO bo = SysCacheTool.findInfoSet(this.setID);
        SelectItem item = new SelectItem();
        item.setLabel(bo.getSetNameEx());
        item.setValue(bo.getSetId());
        this.perSetList.add(item);
        this.perSelSet = bo.getSetId();
      }
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return this.perSetList;
  }

  public void setPerSetList(List perSetList) {
    this.perSetList = perSetList;
  }

  public String getPerSelSet() {
    return this.perSelSet;
  }
  public void setPerSelSet(String set) {
    this.perSelSet = set;
  }

  public String getMode() {
    return this.mode;
  }
  public void setMode(String md) {
    this.mode = md;
  }

  public List getModelist() {
    this.modelist = new ArrayList();
    SelectItem si = new SelectItem();
    if (this.perSelSet != null) {
        InfoSetBO ib = SysCacheTool.findInfoSet(this.perSelSet);
        if (InfoSetBO.RS_TYPE_MANY.equals(ib.getSet_rsType())) {
          si.setLabel("新增");
          si.setValue("1");
          this.modelist.add(si);
        }
      }
    si = new SelectItem();
    si.setLabel("更新");
    si.setValue("0");
    this.modelist.add(si);
    return this.modelist;
  }
  public void setModelist(List list) {
    this.modelist = list;
  }
  public List getPerSetItemList() {
    if (this.perSetItemList != null) return this.perSetItemList; try
    {
      this.perSetItemList = new ArrayList();
      if ((this.perSelSet != null) && (!"".equals(this.perSelSet)))
        if ((this.setID == null) || ("".equals(this.setID))) {
          InfoItemBO[] bo = this.datauploaducc.querySetItem(this.perSelSet);
          if ((bo != null) && (bo.length > 0))
            for (int i = 0; i < bo.length; i++) {
              SelectItem item = new SelectItem();
              item.setLabel(bo[i].getItemName());
              item.setValue(bo[i].getItemId());
              this.perSetItemList.add(item);
            }
        }
        else
        {
          List list = SysCacheTool.queryInfoItemBySetId(this.setID);
          for (int i = 0; i < list.size(); i++) {
            InfoItemBO bo = (InfoItemBO)list.get(i);
            if ((InfoItemBO.PROPERTY_CONTROL_HIDE.equals(bo.getItemProperty())) || 
              (bo.getItemId().equals(getField())) || 
              (!"1".equals(bo.getItemStatus()))) continue;
            SelectItem item = new SelectItem();
            item.setLabel(bo.getItemName());
            item.setValue(bo.getItemId());
            this.perSetItemList.add(item);
          }
        }
    }
    catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return this.perSetItemList;
  }
  public void setPerSetItemList(List perSetItemList) {
    this.perSetItemList = perSetItemList;
  }

  public String getErrorFileUrl() {
    return this.errorFileUrl;
  }
  public void setErrorFileUrl(String errorFileUrl) {
    this.errorFileUrl = errorFileUrl;
  }

  public boolean isShowError() {
    return this.showError;
  }
  public void setShowError(boolean showError) {
    this.showError = showError;
  }

  public String downLoadFile() {
    try {
      ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
      String path = context.getRealPath("/") + File.separator + "file" + File.separator + "emp";
      String dir = path + File.separator;
      InfoItemBO[] bo = null;
      if ((this.orgSelSet != null) && (!this.orgSelSet.equals(""))) {
        bo = this.datauploaducc.querySetItem(this.orgSelSet);
      }
      if ((this.perSelSet != null) && (!this.perSelSet.equals(""))) {
        bo = this.datauploaducc.querySetItem(this.perSelSet);
      }
      TableVO table = new TableVO();
      CellVO[] tmpcells = new CellVO[bo.length];
      CommonFuns.copyArrayObject(CellVO.class, tmpcells, bo);
      if ((this.orgSelSet != null) && (!this.orgSelSet.equals(""))) {
        CellVO[] cells = new CellVO[tmpcells.length + 2];
        cells[0] = new CellVO();
        cells[0].setItemId("PARTYID");
        cells[0].setItemDataType("12");
        cells[0].setItemName("党组织编码");
        cells[1] = new CellVO();
        cells[1].setItemId("D001001");
        cells[1].setItemDataType("3");
        cells[1].setItemName("党组织名称");
        for (int i = 2; i < cells.length; i++) {
          cells[i] = new CellVO();
          CommonFuns.copyProperties(cells[i], tmpcells[(i - 2)]);
        }
        table.setHeader(cells);
      }

      if ((this.perSelSet != null) && (!this.perSelSet.equals(""))) {
        CellVO[] cells = new CellVO[tmpcells.length + 2];
        cells[0] = new CellVO();
        cells[0].setItemId("ID");
        cells[0].setItemDataType("8");
        cells[0].setItemName("员工编号");

        cells[1] = new CellVO();
        cells[1].setItemId("A001001");
        cells[1].setItemDataType("3");
        cells[1].setItemName("姓名");

        for (int i = 2; i < cells.length; i++) {
          cells[i] = new CellVO();
          CommonFuns.copyProperties(cells[i], tmpcells[(i - 2)]);
        }
        table.setHeader(cells);
      }
//      String fileName = FileUtil.exportFile(dir, table, true);
//      String url = super.getServletRequest().getContextPath() + "/file/emp/" + fileName;
//      super.getServletRequest().setAttribute("downurl", url);
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return "download";
  }

  public String getConfigname()
  {
    return this.configname;
  }
  public void setConfigname(String setId) {
    this.configname = setId;
  }
  public String getConfigID() {
    return this.configID;
  }
  public void setConfigID(String setId) {
    this.configID = setId;
  }

  public void saveconfig() {
    try {
      if ((this.setID == null) || ("".equals(this.setID))) {
        this.setID = this.perSelSet;
      }
      String[] inputField = super.getServletRequest().getParameterValues("rsItem");
      String fl = "";

      String[] userold = super.getServletRequest().getParameterValues("form1:useold");
      if ((userold != null) && (userold[0].equals("true"))) {
        fl = this.secondKey + ",A001001";
      }
      else {
        String[] userid = super.getServletRequest().getParameterValues("form1:useid");
        if ((userid != null) && (userid[0].equals("true"))) {
          fl = "A001077,A001001";
        }
        else {
          fl = "A001735,A001001";
        }
      }

      for (int i = 0; i < inputField.length; i++) {
        fl = fl + "," + inputField[i];
      }
      SysImportSetBO wb = null;
      if ((this.configID == null) || ("".equals(this.configID))) {
        wb = new SysImportSetBO();
        wb.setSetid(this.setID);
        wb.setUserid(super.getUserInfo().getUserId());
      }
      else {
        wb = this.showitemucc.getImportSet(this.configID);
      }
      wb.setItemName(this.configname);
      wb.setSetcontent(fl);
      this.showitemucc.saveImportSet(wb);
      this.configID = wb.getItemID();
      this.selitem = null;
    }
    catch (Exception e) {
      super.showMessageDetail("保存失败:" + e.getMessage());
    }
    super.showMessageDetail("保存成功!");
  }
  public void deleteconfig() {
    try {
      this.showitemucc.deleteImportSet(this.configID);
      this.selitem = null;
      this.configID = null;
    }
    catch (Exception e)
    {
    }
  }

  //批量导入
  public String uploadFile() {
	this.showError=false;
    this.inputField = super.getServletRequest().getParameterValues("rsItem");
	InfoItemBO[] cols = (InfoItemBO[])SysCacheTool.queryObject(4, null, this.inputField);
	try {
		Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
		Sheet st=wb.getSheet(0);
		int row=st.getRows();
		if(row<=1){
			super.showMessageDetail("上传文件工作薄没有内容");			
			return null;
		}
		int fieldLen=this.inputField.length;
		int col=st.getColumns();
		if(col<fieldLen+2){
			super.showMessageDetail("上传文件工作薄没有足够的列");				
			return null;
		}
		List list=new ArrayList();
		this.uploadValueList=new ArrayList();
		Long d=new Date().getTime();
		String path=super.getRealPath("/")+"file\\emp\\"+d+".txt";
		BufferedWriter bw = new BufferedWriter(new FileWriter(path));
		for(int i=1;i<row;i++){
			boolean pass=true;
			Map m=new HashMap();
			Map m1=new HashMap();
			String pCode = st.getCell(0, i).getContents().trim();
			String name=st.getCell(1, i).getContents().trim();
			if(pCode==null || "".equals(pCode)){
				break;
			}				
			PersonBO p = SysCacheTool.findPersonByCode(pCode.trim());
			if(p==null){
				FileUtil.addErrorFormatLabel(bw, i+1, 0, "人员编号"+pCode+"不存在");
				pass=false;
				this.showError=true;
			}else{
				if(!p.getName().equals(name)){
					FileUtil.addErrorFormatLabel(bw, i+1, 1, "姓名不匹配,系统中为"+p.getName()+"此处为"+name);
					pass=false;
					this.showError=true;
				}else{
					m.put("id", p.getPersonId());
					m1.put("id", p.getPersonId());
				}
			}
			
//			for_begin
			for(int j=0;j<cols.length;j++){
				InfoItemBO item=cols[j];
				String setID=item.getItemCodeSet();
				String fieldID=item.getItemId();
				String colDataType = item.getItemDataType();
				String value=st.getCell(j+2, i).getContents().trim();
				String newCode=null;
				if (InfoItemBO.DATA_TYPE_CODE.equals(colDataType)) {
                    if ("0".equals(this.codeType)){  // 按代码查询
                        CodeItemBO tmp = SysCacheTool.findCodeItem(setID, value);
                        if (tmp == null) {
                        	FileUtil.addErrorFormatLabel(bw, i+1, j+2, "代码["+value+"]不存在");
                        	pass=false;
        					this.showError=true;
                        } else {
                        	newCode=tmp.getItemId();
                        }
                    }else{   // 按描述查询
                       List<CodeItemBO> itemList = SysCacheTool.queryCodeItemBySetId(setID);
                       if (itemList!=null){
                           for(CodeItemBO codeItem : itemList){
                        	   if(codeItem.getItemName().equals(value)){
                        		   newCode=codeItem.getItemId();
                        		   break;
                        	   }
                           }
                       }
                       if (newCode==null){
                    	   FileUtil.addErrorFormatLabel(bw, i+1, j+2, "描述["+value+"]不存在对应代码");
                    	   pass=false;
       					this.showError=true;
                       }
                    }
                } else if (InfoItemBO.DATA_TYPE_ORG.equals(colDataType)) {
                    OrgBO obj = SysCacheTool.findOrgByCode(value);
                    if (obj == null) {
                        FileUtil.addErrorFormatLabel(bw, i+1, j+2, "机构["+value+"]不存在");
                        pass=false;
    					this.showError=true;
                    } else {
                    	newCode=obj.getOrgId();
                    }
                } else if (InfoItemBO.DATA_TYPE_POST.equals(colDataType)) {
                    PostBO obj = SysCacheTool.findPostByCode(value.trim());
                    if (obj == null) {
                    	FileUtil.addErrorFormatLabel(bw, i+1, j+2, "岗位不存在");
                    	pass=false;
    					this.showError=true;
                    } else {
                    	newCode=obj.getPostId();
                    }
                } else if (InfoItemBO.DATA_TYPE_INT.equals(colDataType)) {
                    try {
                        String tempStr = value.trim();
                        if (tempStr.indexOf(".") > 0) {
                            String str = tempStr.substring(0, tempStr.indexOf("."));
                            Long.parseLong(str);
                            newCode = str;
                        } else {
                            Long.parseLong(tempStr);
                            newCode = tempStr;
                        }
                    } catch (NumberFormatException e) {
                    	pass=false;
    					this.showError=true;
                    	FileUtil.addErrorFormatLabel(bw, i+1, j+2, "数据格式错误不是整数");
                    }
                } else if (InfoItemBO.DATA_TYPE_FLOAT.equals(colDataType)) {
                    try {
                        Double.parseDouble(value.trim());
                        // 对小数格式处理
                        newCode = CommonFuns.formateItem(colDataType, item.getItemPrecision(), value.trim());
                    } catch (NumberFormatException e) {
                    	pass=false;
    					this.showError=true;
                    	FileUtil.addErrorFormatLabel(bw, i+1, j+2, "数据格式错误不是小数");
                    }
                } else if (InfoItemBO.DATA_TYPE_DATE6.equals(colDataType)) {
                	if (value.length() == 7) {
                    	SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM");
                    	try {
                    		fmt.parse(value);
						} catch (Exception e) {
							pass=false;
							this.showError=true;
	                    	FileUtil.addErrorFormatLabel(bw, i+1, j+2, "数据格式错误，不是六位日期");
						}
                    	newCode=value;
                    } else {
                    	pass=false;
    					this.showError=true;
                    	FileUtil.addErrorFormatLabel(bw, i+1, j+2, "数据格式错误，不是六位日期");
                    }
                } else if (InfoItemBO.DATA_TYPE_DATE.equals(colDataType)) {
                	if (value.length() == 10) {
                    	SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
                    	try {
                    		fmt.parse(value);
						} catch (Exception e) {
							pass=false;
							this.showError=true;
	                    	FileUtil.addErrorFormatLabel(bw, i+1, j+2, "数据格式错误，不是八位日期");
						}
                    	newCode=value;
                    } else {
                    	pass=false;
    					this.showError=true;
                    	FileUtil.addErrorFormatLabel(bw, i+1, j+2, "数据格式错误，不是八位日期");
                    }
                }else{
                	newCode=value;
                }
				m.put(fieldID, value);
				m1.put(fieldID, newCode);
            } 
//			for_end
			
			if(pass){
				list.add(m);
				this.uploadValueList.add(m1);
			}
		}
		if(this.showError){
			this.errorFileUrl=super.getServletRequest().getContextPath()+"\\file\\emp\\"+d+".txt";
		}
		super.getHttpSession().setAttribute("fileValue", list);
        super.getHttpSession().setAttribute("field", this.inputField);
		bw.close();
	} catch (Exception e1) {
		e1.printStackTrace();
	}
    return "perInfoList";
  }

  //保存导入
  public String saveFile() {
		try {
			this.commonService.batchUpdateEmpUploadFile(this.perSelSet, this.mode, this.inputField, this.uploadValueList);
			super.getHttpSession().removeAttribute("fileValue");
	        super.getHttpSession().removeAttribute("field");
			super.showMessageDetail("导入完成");
		} catch (SysException e) {
			super.showMessageDetail("导入失败");
			e.printStackTrace();
		}
		return "upload";
  }
  
  public String saveFileBySet()
  {
    HashMap hash = (HashMap)super.getHttpSession().getAttribute("fileValue");
    String[] itemId = (String[])(String[])super.getHttpSession().getAttribute("field");
    Iterator key = hash.keySet().iterator();
    int i = 0;
    String[] persId = (String[])(String[])hash.keySet().toArray(new String[0]);
    try {
      String set = "";
      if ((this.orgSelSet != null) && (!this.orgSelSet.equals("")))
        set = this.orgSelSet;
      else {
        set = this.perSelSet;
      }

      if ((set != null) && (!set.equals(""))) {
        this.datauploaducc.saveOrUpdateInfoByCode(this.setID, itemId, hash, this.date, this.field);
      }
      super.getHttpSession().removeAttribute("fileValue");
      super.getHttpSession().removeAttribute("field");
      super.showMessageDetail("保存成功");
      return "upload";
    } catch (SysException e) {
      super.showMessageDetail("错误：" + e.getMessage());
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public void selChanged(ValueChangeEvent event) {
    try {
      if (!"".equals(event.getNewValue())) {
        this.perSelSet = event.getNewValue().toString();

        InfoItemBO[] bo = this.datauploaducc.querySetItem(this.perSelSet);
        if ((bo != null) && (bo.length > 0)) {
          this.perSetItemList = new ArrayList();
          for (int i = 0; i < bo.length; i++) {
            SelectItem item = new SelectItem();
            item.setLabel(bo[i].getItemName());
            item.setValue(bo[i].getItemId());
            this.perSetItemList.add(item);
          }
        }
        this.selitem = null;
        getSelitem();
      }
    } catch (Exception e) {
      super.showMessageDetail("错误：" + e.getMessage());
    }
  }
}