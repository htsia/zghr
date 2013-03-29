package com.hr319wg.emp.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;
import javax.servlet.ServletContext;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.myfaces.custom.fileupload.UploadedFile;
import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.util.IDCardUtil;
import com.hr319wg.emp.ucc.IDataUploadUCC;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.SysImportSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.ucc.IInfoSetUCC;
import com.hr319wg.sys.ucc.ISetshowItemsUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;

public class DataAddBackingBean extends BaseBackingBean {
	private IInfoSetUCC infosetucc;
	private IDataUploadUCC datauploaducc;
	private ISetshowItemsUCC showitemucc;
	private String mode;
	private String pageInit;
	private String codeType = "1";
	private UploadedFile excelFile;
	private List perSetItemList;
	private int fieldSize;
	private List selitem;
	private String errorFileUrl = "";

	private boolean showError = false;
	private String configname;
	private String configID;
	private String[]uploadField;
	private List uploadFileList;
	private JdbcTemplate jdbcTemplate;

	public String[] getUploadField() {
		return uploadField;
	}

	public void setUploadField(String[] uploadField) {
		this.uploadField = uploadField;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List getUploadFileList() {
		return uploadFileList;
	}

	public void setUploadFileList(List uploadFileList) {
		this.uploadFileList = uploadFileList;
	}

	public int getFieldSize() {
		return fieldSize;
	}

	public void setFieldSize(int fieldSize) {
		this.fieldSize = fieldSize;
	}

	public ISetshowItemsUCC getShowitemucc() {
		return this.showitemucc;
	}

	public void setShowitemucc(ISetshowItemsUCC showitemucc) {
		this.showitemucc = showitemucc;
	}

	public String getCodeType() {
		return this.codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	public List getSelitem() {
		if (this.selitem == null) {
			this.selitem = new ArrayList();
			SelectItem s = new SelectItem();
			s.setLabel("--ѡ��Ԥ��������--");
			s.setValue("");
			this.selitem.add(s);
			try {
				List ltemp = this.showitemucc.getImportSet(super.getUserInfo().getUserId(), "AddPerson");
				for (int i = 0; i < ltemp.size(); i++) {
					SysImportSetBO ws = (SysImportSetBO) ltemp.get(i);
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
			} catch (Exception e) {
			}
		}
		return this.selitem;
	}

	public void setSelitem(List li) {
		this.selitem = li;
	}

	public String getConfigname() {
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
			String[] inputField = super.getServletRequest().getParameterValues("form1:rsItem");
			String fl = "";
			for (int i = 0; i < inputField.length; i++) {
				if (i == 0)
					fl = inputField[i];
				else
					fl = fl + "," + inputField[i];
			}
			SysImportSetBO wb = null;
			if ((this.configID == null) || ("".equals(this.configID))) {
				wb = new SysImportSetBO();
				wb.setSetid("AddPerson");
				wb.setUserid(super.getUserInfo().getUserId());
			} else {
				wb = this.showitemucc.getImportSet(this.configID);
			}
			wb.setItemName(this.configname);
			wb.setSetcontent(fl);
			this.showitemucc.saveImportSet(wb);
			this.configID = wb.getItemID();
			this.selitem = null;
		} catch (Exception e) {
			super.showMessageDetail("����ʧ��:" + e.getMessage());
		}
		super.showMessageDetail("����ɹ�!");
	}

	public void deleteconfig() {
		try {
			this.showitemucc.deleteImportSet(this.configID);
			this.selitem = null;
			this.configID = null;
			this.configname = "";
		} catch (Exception e) {
		}
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

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public UploadedFile getExcelFile() {
		return this.excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public String getMode() {
		return this.mode;
	}

	public void setMode(String md) {
		this.mode = md;
	}

	public String getPageInit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			List fieldList=new ArrayList();
			SelectItem si=new SelectItem("A001001", CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"A001001"));
			fieldList.add(si);
			si=new SelectItem("A001054", CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"A001054"));
			fieldList.add(si);
			si=new SelectItem("A001705", CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"A001705"));
			fieldList.add(si);
			si=new SelectItem("A001077", CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"A001077"));
			fieldList.add(si);
			si=new SelectItem("A001725", CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"A001725"));
			fieldList.add(si);
			si=new SelectItem("B730702", CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"B730702"));
			fieldList.add(si);
			si=new SelectItem("B730701", CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"B730701"));
			fieldList.add(si);
			Map map = new HashMap();
			map.put("A001001", null);
			map.put("A001054", null);
			map.put("A001701", null);
			map.put("A001705", null);
			map.put("A001077", null);
			map.put("A001725", null);
			List<InfoItemBO> list=SysCacheTool.queryInfoItemBySetId("A001");
			for(InfoItemBO bo : list){
				if("1".equals(bo.getItemMust()) && !map.containsKey(bo.getItemId())){
					SelectItem si1=new SelectItem(bo.getItemId(), bo.getItemName());
					fieldList.add(si1);
				}
			}
			this.fieldSize=fieldList.size();
			super.getServletRequest().getSession().setAttribute("fieldList", fieldList);
		}
		return this.pageInit;
	}
	
	public List getPerSetItemList() {
		if (this.perSetItemList != null)
			return this.perSetItemList;
		try {
			this.perSetItemList = new ArrayList();
			InfoItemBO[] bo = this.datauploaducc.querySetItem("A001");
			if ((bo != null) && (bo.length > 0))
				for (int i = 0; i < bo.length; i++) {
					if (("A001001".equals(bo[i].getItemId()))
							|| ("A001743".equals(bo[i].getItemId()))
							|| ("A001077".equals(bo[i].getItemId()))
							|| ("A001705".equals(bo[i].getItemId()))) {
						continue;
					}
					SelectItem item = new SelectItem();
					item.setLabel(bo[i].getItemName());
					item.setValue(bo[i].getItemId());
					this.perSetItemList.add(item);
				}
		} catch (Exception e) {
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
			ServletContext context = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
			String path = context.getRealPath("/") + File.separator + "file" + File.separator + "emp";
			String dir = path + File.separator;
			InfoItemBO[] bo = null;
			bo = this.datauploaducc.querySetItem("A001");
			TableVO table = new TableVO();
			CellVO[] tmpcells = new CellVO[bo.length];
			CommonFuns.copyArrayObject(CellVO.class, tmpcells, bo);
			CellVO[] cells = new CellVO[tmpcells.length + 2];
			cells[0] = new CellVO();
			cells[0].setItemId("ID");
			cells[0].setItemDataType("8");
			cells[0].setItemName("Ա�����");

			cells[1] = new CellVO();
			cells[1].setItemId("A001001");
			cells[1].setItemDataType("3");
			cells[1].setItemName("����");

			for (int i = 2; i < cells.length; i++) {
				cells[i] = new CellVO();
				CommonFuns.copyProperties(cells[i], tmpcells[(i - 2)]);
			}
			table.setHeader(cells);

//			String fileName = FileUtil.exportFile(dir, table, true);
//			String url = super.getServletRequest().getContextPath()
//					+ "/file/emp/" + fileName;
//			super.getServletRequest().setAttribute("downurl", url);
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "download";
	}

	public String uploadFile() {
		this.showError=false;
	    this.uploadField = super.getServletRequest().getParameterValues("rsItem");
	    
		InfoItemBO[] cols = (InfoItemBO[])SysCacheTool.queryObject(4, null, uploadField);
		InfoItemBO B730702=SysCacheTool.findInfoItem("B730", "B730702");
		InfoItemBO B730701=SysCacheTool.findInfoItem("B730", "B730701");
		cols[5]=B730702;
		cols[6]=B730701;
		
		try {
			Workbook wb = Workbook.getWorkbook(this.excelFile.getInputStream());
			Sheet st=wb.getSheet(0);
			int row=st.getRows();
			if(row<=1){
				super.showMessageDetail("�ϴ��ļ�������û������");			
				return null;
			}
			int fieldLen=this.uploadField.length;
			int col=st.getColumns();
			if(col<fieldLen){
				super.showMessageDetail("�ϴ��ļ�������û���㹻����");				
				return null;
			}
			List showList=new ArrayList();
			this.uploadFileList=new ArrayList();
			Long d=new Date().getTime();
			String path=super.getRealPath("/")+"file\\emp\\"+d+".txt";
			BufferedWriter bw = new BufferedWriter(new FileWriter(path));
			for(int i=1;i<row;i++){
				boolean pass=true;
				Map uploadMap=new HashMap();
				Map showMap=new HashMap();
				String name=st.getCell(1, i).getContents().trim();
				if(name==null || "".equals(name)){
					break;
				}
				
//				for_begin
				for(int j=0;j<cols.length;j++){
					InfoItemBO item=cols[j];
					String setID=item.getItemCodeSet();
					String fieldID=item.getItemId();
					String colDataType = item.getItemDataType();
					String value=st.getCell(j, i).getContents().trim();
					String upValue=null;
					String showValue=null;
					if(InfoItemBO.DATA_TYPE_CODE.equals(colDataType)) {
	                    if ("0".equals(this.codeType)){  // �������ѯ
	                        CodeItemBO tmp = SysCacheTool.findCodeItem(setID, value);
	                        if (tmp == null) {
	                        	FileUtil.addErrorFormatLabel(bw, i+1, j, "����["+value+"]������");
	                        	pass=false;
	        					this.showError=true;
	                        } else {
	                        	upValue=value;
	                        	showValue=tmp.getItemName();
	                        }
	                    }else{   // ��������ѯ
	                       List<CodeItemBO> itemList = SysCacheTool.queryCodeItemBySetId(setID);
	                       if (itemList!=null){
	                           for(CodeItemBO codeItem : itemList){
	                        	   if(codeItem.getItemName().equals(value)){
	                        		   upValue=codeItem.getItemId();
	   	                        	   showValue=value;
	                        		   break;
	                        	   }
	                           }
	                       }
	                       if (upValue==null){
	                    	   FileUtil.addErrorFormatLabel(bw, i+1, j, "����["+value+"]�����ڶ�Ӧ����");
	                    	   pass=false;
	       					this.showError=true;
	                       }
	                    }
	                } else if (InfoItemBO.DATA_TYPE_ORG.equals(colDataType)) {
	                    OrgBO obj = SysCacheTool.findOrgByCode(value);
	                    if (obj == null) {
	                        FileUtil.addErrorFormatLabel(bw, i+1, j, "����["+value+"]������");
	                        pass=false;
	    					this.showError=true;
	                    } else {
	                    	upValue=obj.getOrgId();
	                    	showValue=obj.getName();
	                    }
	                } else if (InfoItemBO.DATA_TYPE_POST.equals(colDataType)) {
	                    PostBO obj = SysCacheTool.findPostByCode(value.trim());
	                    if (obj == null) {
	                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "��λ������");
	                    	pass=false;
	    					this.showError=true;
	                    } else {
	                    	upValue=obj.getPostId();
	                    	showValue=obj.getName();
	                    }
	                } else if (InfoItemBO.DATA_TYPE_INT.equals(colDataType)) {
	                    try {
	                        String tempStr = value.trim();
	                        if (tempStr.indexOf(".") > 0) {
	                            String str = tempStr.substring(0, tempStr.indexOf("."));
	                            Long.parseLong(str);
	                            upValue = str;
	                            showValue=str;
	                        } else {
	                            Long.parseLong(tempStr);
	                            upValue = tempStr;
	                            showValue=tempStr;
	                        }
	                    } catch (NumberFormatException e) {
	                    	pass=false;
	    					this.showError=true;
	                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "���ݸ�ʽ����������");
	                    }
	                } else if (InfoItemBO.DATA_TYPE_FLOAT.equals(colDataType)) {
	                    try {
	                        Double.parseDouble(value.trim());
	                        // ��С����ʽ����
	                        String v = CommonFuns.formateItem(colDataType, item.getItemPrecision(), value.trim());
	                        upValue = v;
                            showValue=v;
	                    } catch (NumberFormatException e) {
	                    	pass=false;
	    					this.showError=true;
	                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "���ݸ�ʽ������С��");
	                    }
	                } else if (InfoItemBO.DATA_TYPE_DATE6.equals(colDataType)) {
	                	if (value.length() == 7) {
	                    	SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM");
	                    	try {
	                    		fmt.parse(value);
							} catch (Exception e) {
								pass=false;
								this.showError=true;
		                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "���ݸ�ʽ���󣬲�����λ����");
							}
	                    	upValue = value;
                            showValue=value;
	                    } else {
	                    	pass=false;
	    					this.showError=true;
	                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "���ݸ�ʽ���󣬲�����λ����");
	                    }
	                } else if (InfoItemBO.DATA_TYPE_DATE.equals(colDataType)) {
	                	if (value.length() == 10) {
	                    	SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
	                    	try {
	                    		fmt.parse(value);
							} catch (Exception e) {
								pass=false;
								this.showError=true;
		                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "���ݸ�ʽ���󣬲��ǰ�λ����");
							}
	                    	upValue = value;
                            showValue=value;
	                    } else {
	                    	pass=false;
	    					this.showError=true;
	                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "���ݸ�ʽ���󣬲��ǰ�λ����");
	                    }
	                }else if("A001077".equals(fieldID)){
	                	boolean ispass= IDCardUtil.validateCard(value);
	                	if(ispass){
	                		String sql="select count(*) from a001 where a001077='"+value+"'";
	                		int result=this.jdbcTemplate.queryForInt(sql);
	                		if(result>0){
	                			pass=false;
		    					this.showError=true;
		                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "���֤�ظ�");
	                		}else{
	                			upValue = value;
	                			showValue=value;	                			
	                		}
	                	}else{
	                		pass=false;
	    					this.showError=true;
	                    	FileUtil.addErrorFormatLabel(bw, i+1, j, "���֤���Ϸ�");
	                	}
	                }else{
	                	upValue = value;
                        showValue=value;
	                }
					uploadMap.put(fieldID, upValue);
					showMap.put(fieldID, showValue);
	            } 
//				for_end
				
				if(pass){
					showList.add(showMap);
					this.uploadFileList.add(uploadMap);
				}
			}
			if(this.showError){
				this.errorFileUrl=super.getServletRequest().getContextPath()+"\\file\\emp\\"+d+".txt";
			}
			super.getHttpSession().setAttribute("fileValue", showList);
	        super.getHttpSession().setAttribute("field", cols);
			bw.close();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return "perInfoList";
	}

	public String saveFile() {
		try {
			this.datauploaducc.batchAddPerson(this.uploadField, this.uploadFileList, super.getUserInfo());
			super.getHttpSession().removeAttribute("fileValue");
			super.getHttpSession().removeAttribute("field");
			super.showMessageDetail("����ɹ�");
			return "upload";
		} catch (SysException e) {
			super.showMessageDetail("����" + e.getMessage());
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
		}
		return null;
	}
}