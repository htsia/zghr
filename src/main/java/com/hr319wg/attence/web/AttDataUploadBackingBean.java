package com.hr319wg.attence.web;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.IdentityHashMap;
import java.util.Iterator;
import java.util.List;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;
import javax.servlet.ServletContext;

import com.hr319wg.util.FileUtil;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import com.hr319wg.attence.pojo.bo.AttFileImportBO;
import com.hr319wg.attence.pojo.bo.AttFileImportItemBO;
import com.hr319wg.attence.pojo.bo.AttenceLogBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.ucc.IDataUploadUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.bo.SysImportSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.ucc.IInfoSetUCC;
import com.hr319wg.sys.ucc.ISetshowItemsUCC;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;
import org.apache.myfaces.custom.fileupload.UploadedFile;

public class AttDataUploadBackingBean extends BaseBackingBean {
	private String initEdit;
	List attencelogboss=new ArrayList();
	private String superId = super.getUserInfo().getOrgId();
	private PageVO mypage = new PageVO();
	private List lists = new ArrayList();
	private String atttype;
	private IAttenceSetUCC attenceSetUCC;
	private IInfoSetUCC infosetucc;
	private IDataUploadUCC datauploaducc;
	private String mode;
	private String setID;
	private String date;
	private String field;
	private List modelist;
	private String moduleid;
	private String initBySet;
	private String secondKey;
	private String secondKeyName;
	private ISetshowItemsUCC showitemucc;
	private UploadedFile excelFile;
	private List orgSetList;
	private String orgSelSet;
	private List orgSetItemList;
	private List perSetList;
	private String perSelSet;
	private List perSetItemList;
	private List selitem;
	private String errorFileUrl;
	private boolean showError;
	private String configname;
	private String configID;
	
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public AttDataUploadBackingBean()
	{
		secondKey = "A001999";
		secondKeyName = "旧系统员工编号";
		errorFileUrl = "";
		showError = false;
	}

	public String getSecondKey()
	{
		return secondKey;
	}

	public void setSecondKey(String d)
	{
		secondKey = d;
	}

	public String getSecondKeyName()
	{
		return secondKeyName;
	}

	public void setSecondKeyName(String d)
	{
		secondKeyName = d;
	}

	public String getField()
	{
		return field;
	}

	public void setField(String d)
	{
		field = d;
	}

	public String getDate()
	{
		return date;
	}

	public void setDate(String d)
	{
		date = d;
	}

	public String getModuleid()
	{
		return moduleid;
	}

	public void setModuleid(String id)
	{
		moduleid = id;
	}

	public String getSetID()
	{
		return setID;
	}

	public void setSetID(String id)
	{
		setID = id;
	}

	public String getPageInit()
	{
		if (super.getRequestParameter("moduleid") != null)
		{
			moduleid = super.getRequestParameter("moduleid");
			perSetList = null;
		}
		return pageInit;
	}

	public String getInitBySet()
	{
		if(lists!=null){
			lists=new ArrayList();
		}
		if (super.getRequestParameter("setID") != null)
		{
			setID = super.getRequestParameter("setID");
			if ("A810".equals(setID))
			{
				secondKey = "A001736";
				secondKeyName = "考勤卡号";
			}
			date = super.getRequestParameter("TimeValue");
			field = super.getRequestParameter("TimeField");
			perSetList = null;
		}
		return initBySet;
	}

	public void setInitBySet(String set)
	{
		initBySet = set;
	}

	public List getSelitem()
	{
		if (selitem == null)
		{
			selitem = new ArrayList();
			SelectItem s = new SelectItem();
			s.setLabel("--选择预定义配置--");
			s.setValue("");
			selitem.add(s);
			try
			{
				List ltemp = showitemucc.getImportSet(super.getUserInfo().getUserId(), setID);
				for (int i = 0; i < ltemp.size(); i++)
				{
					SysImportSetBO ws = (SysImportSetBO)ltemp.get(i);
					SelectItem si = new SelectItem();
					si.setLabel(ws.getItemName());
					String fl[] = ws.getSetcontent().split(",");
					String content = ws.getItemID();
					for (int j = 0; j < fl.length; j++)
					{
						InfoItemBO ii = SysCacheTool.findInfoItem("", fl[j]);
						content = content + "|" + fl[j] + "," + ii.getItemName();
					}

					si.setValue(content);
					selitem.add(si);
				}

			}
			catch (Exception e) { }
		}
		return selitem;
	}

	public void setSelitem(List li)
	{
		selitem = li;
	}

	public IInfoSetUCC getInfosetucc()
	{
		return infosetucc;
	}

	public void setInfosetucc(IInfoSetUCC ucc)
	{
		infosetucc = ucc;
	}

	public IDataUploadUCC getDatauploaducc()
	{
		return datauploaducc;
	}

	public void setDatauploaducc(IDataUploadUCC datauploaducc)
	{
		this.datauploaducc = datauploaducc;
	}

	public ISetshowItemsUCC getShowitemucc()
	{
		return showitemucc;
	}

	public void setShowitemucc(ISetshowItemsUCC ucc)
	{
		showitemucc = ucc;
	}

	public UploadedFile getExcelFile()
	{
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile)
	{
		this.excelFile = excelFile;
	}

	public List getOrgSetList()
	{
		if (orgSetList != null)
			return orgSetList;
		try
		{
			orgSetList = new ArrayList();
			List list = infosetucc.getAllInportOrgSet();
			for (int i = 0; i < list.size(); i++)
			{
				SelectItem item = new SelectItem();
				InfoSetBO bo = (InfoSetBO)list.get(i);
				item.setLabel(bo.getSetNameEx());
				item.setValue(bo.getSetId());
				orgSetList.add(item);
			}

		}
		catch (Exception e)
		{
			msg.setMainMsg(e, getClass());
		}
		return orgSetList;
	}

	public void setOrgSetList(List orgSetList)
	{
		this.orgSetList = orgSetList;
	}

	public String getOrgSelSet()
	{
		return orgSelSet;
	}

	public void setOrgSelSet(String orgSelSet)
	{
		this.orgSelSet = orgSelSet;
	}

	public List getOrgSetItemList()
	{
		if (orgSetItemList != null)
			return orgSetItemList;
		try
		{
			String val = orgSelSet;
			InfoItemBO bo[] = datauploaducc.querySetItem(val);
			if (bo != null && bo.length > 0)
			{
				orgSetItemList = new ArrayList();
				for (int i = 0; i < bo.length; i++)
				{
					SelectItem item = new SelectItem();
					item.setLabel(bo[i].getItemName());
					item.setValue(bo[i].getItemId());
					orgSetItemList.add(item);
				}

			}
		}
		catch (Exception e)
		{
			msg.setMainMsg(e, getClass());
		}
		return orgSetItemList;
	}

	public void setOrgSetItemList(List orgSetItemList)
	{
		this.orgSetItemList = orgSetItemList;
	}

	public List getPerSetList()
	{
		if (perSetList != null)
			return perSetList;
		try
		{
			perSetList = new ArrayList();
			if (setID == null || "".equals(setID))
			{
				List list = infosetucc.getAllInportPersonSet();
				for (int i = 0; i < list.size(); i++)
				{
					InfoSetBO bo = (InfoSetBO)list.get(i);
					if (moduleid == null || !"BXGL".equals(moduleid) || "2001010402".equals(bo.getSet_sType()))
					{
						SelectItem item = new SelectItem();
						item.setLabel(bo.getSetNameEx());
						item.setValue(bo.getSetId());
						perSetList.add(item);
						if (i == 0)
							perSelSet = bo.getSetId();
					}
				}

			} else
			{
				InfoSetBO bo = SysCacheTool.findInfoSet(setID);
				SelectItem item = new SelectItem();
				item.setLabel(bo.getSetNameEx());
				item.setValue(bo.getSetId());
				perSetList.add(item);
				perSelSet = bo.getSetId();
			}
		}
		catch (Exception e)
		{
			msg.setMainMsg(e, getClass());
		}
		return perSetList;
	}

	public void setPerSetList(List perSetList)
	{
		this.perSetList = perSetList;
	}

	public String getPerSelSet()
	{
		return perSelSet;
	}

	public void setPerSelSet(String set)
	{
		perSelSet = set;
	}
	
	public String getInitEdit() {
		if(attencelogboss!=null && !"".equals(attencelogboss)){
			attencelogboss=new ArrayList();
		}
		doSee();
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String doSee(){
		attencelogboss = (List)super.getHttpSession().getAttribute("attencelogbos");
		if(attencelogboss!=null && attencelogboss.size()>0){
           for(int i=0;i<attencelogboss.size();i++){
        	   AttenceLogBO attencelogbo=(AttenceLogBO)attencelogboss.get(i);
        	   attencelogboss.set(i, attencelogbo);
           }
		}
	  return "";	
	}
	
	public String getMode()
	{
		return mode;
	}

	public void setMode(String md)
	{
		mode = md;
	}

	public List getModelist()
	{
		modelist = new ArrayList();
		SelectItem si = new SelectItem();
		si.setLabel("更新");
		si.setValue("0");
		modelist.add(si);
		if (perSelSet != null)
		{
			InfoSetBO ib = SysCacheTool.findInfoSet(perSelSet);
			if (InfoSetBO.RS_TYPE_MANY.equals(ib.getSet_rsType()))
			{
				si = new SelectItem();
				si.setLabel("插入");
				si.setValue("1");
				modelist.add(si);
			}
		}
		return modelist;
	}

	public void setModelist(List list)
	{
		modelist = list;
	}

	public List getPerSetItemList()
	{
		if (perSetItemList != null)
			return perSetItemList;
		try
		{
			perSetItemList = new ArrayList();
			if (perSelSet != null && !"".equals(perSelSet))
				if (setID == null || "".equals(setID))
				{
					InfoItemBO bo[] = datauploaducc.querySetItem(perSelSet);
					if (bo != null && bo.length > 0)
					{
						for (int i = 0; i < bo.length; i++)
						{
							SelectItem item = new SelectItem();
							item.setLabel(bo[i].getItemName());
							item.setValue(bo[i].getItemId());
							perSetItemList.add(item);
						}

					}
				} else
				{
					List list = SysCacheTool.queryInfoItemBySetId(setID);
					for (int i = 0; i < list.size(); i++)
					{
						InfoItemBO bo = (InfoItemBO)list.get(i);
						if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(bo.getItemProperty()) && !bo.getItemId().equals(getField()))
						{
							SelectItem item = new SelectItem();
							item.setLabel(bo.getItemName());
							item.setValue(bo.getItemId());
							perSetItemList.add(item);
						}
					}

				}
		}
		catch (Exception e)
		{
			msg.setMainMsg(e, getClass());
		}
		return perSetItemList;
	}

	public void setPerSetItemList(List perSetItemList)
	{
		this.perSetItemList = perSetItemList;
	}

	public String getErrorFileUrl()
	{
		return errorFileUrl;
	}

	public void setErrorFileUrl(String errorFileUrl)
	{
		this.errorFileUrl = errorFileUrl;
	}

	public boolean isShowError()
	{
		return showError;
	}

	public void setShowError(boolean showError)
	{
		this.showError = showError;
	}

	public String downLoadFile()
	{
		try
		{
			ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
			String path = context.getRealPath("/") + File.separator + "file" + File.separator + "emp";
			String dir = path + File.separator;
			InfoItemBO bo[] = null;
			if (orgSelSet != null && !orgSelSet.equals(""))
				bo = datauploaducc.querySetItem(orgSelSet);
			if (perSelSet != null && !perSelSet.equals(""))
				bo = datauploaducc.querySetItem(perSelSet);
			TableVO table = new TableVO();
			CellVO tmpcells[] = new CellVO[bo.length];
			CommonFuns.copyArrayObject(com.hr319wg.sys.pojo.vo.CellVO.class, tmpcells, bo);
			if (orgSelSet != null && !orgSelSet.equals(""))
			{
				CellVO cells[] = new CellVO[tmpcells.length + 2];
				cells[0] = new CellVO();
				cells[0].setItemId("PARTYID");
				cells[0].setItemDataType("12");
				cells[0].setItemName("党组织编码");
				cells[1] = new CellVO();
				cells[1].setItemId("D001001");
				cells[1].setItemDataType("3");
				cells[1].setItemName("党组织名称");
				for (int i = 2; i < cells.length; i++)
				{
					cells[i] = new CellVO();
					CommonFuns.copyProperties(cells[i], tmpcells[i - 2]);
				}

				table.setHeader(cells);
			}
			if (perSelSet != null && !perSelSet.equals(""))
			{
				CellVO cells[] = new CellVO[tmpcells.length + 2];
				cells[0] = new CellVO();
				cells[0].setItemId("ID");
				cells[0].setItemDataType("8");
				cells[0].setItemName("员工编号");
				cells[1] = new CellVO();
				cells[1].setItemId("A001001");
				cells[1].setItemDataType("3");
				cells[1].setItemName("姓名");
				for (int i = 2; i < cells.length; i++)
				{
					cells[i] = new CellVO();
					CommonFuns.copyProperties(cells[i], tmpcells[i - 2]);
				}

				table.setHeader(cells);
			}
			FileUtil.exportFile(dir, table, true);
			String url = super.getServletRequest().getContextPath() + "/file/emp/result.xls";
			super.getServletRequest().setAttribute("downurl", url);
		}
		catch (Exception e)
		{
			msg.setMainMsg(e, getClass());
		}
		return "download";
	}

	public String getConfigname()
	{
		return configname;
	}

	public void setConfigname(String setId)
	{
		configname = setId;
	}

	public String getConfigID()
	{
		return configID;
	}

	public void setConfigID(String setId)
	{
		configID = setId;
	}

	public void saveconfig()
	{
		try
		{
			String inputField[] = super.getServletRequest().getParameterValues("rsItem");
			String fl = "";
			String userold[] = super.getServletRequest().getParameterValues("form1:useold");
			if (userold != null && userold[0].equals("true"))
				fl = secondKey + ",A001001";
			else
				fl = "A001735,A001001";
			for (int i = 0; i < inputField.length; i++)
				fl = fl + "," + inputField[i];

			SysImportSetBO wb = null;
			if (configID == null || "".equals(configID))
			{
				wb = new SysImportSetBO();
				wb.setSetid(setID);
				wb.setUserid(super.getUserInfo().getUserId());
			} else
			{
				wb = showitemucc.getImportSet(configID);
			}
			wb.setItemName(configname);
			wb.setSetcontent(fl);
			showitemucc.saveImportSet(wb);
			configID = wb.getItemID();
			selitem = null;
		}
		catch (Exception e)
		{
			super.showMessageDetail("保存失败：" + e.getMessage());
		}
		super.showMessageDetail("保存成功！");
	}

	public void deleteconfig()
	{
		try
		{
			showitemucc.deleteImportSet(configID);
			selitem = null;
			configID = null;
		}
		catch (Exception e) { }
	}

	public String uploadFile()
	{
		String retval = null;
		try
		{
			Hashtable hashTable=new Hashtable();
			List listsss=new ArrayList();
			List lists=new ArrayList();
			ServletContext context = (ServletContext)FacesContext.getCurrentInstance().getExternalContext().getContext();
			String path = context.getRealPath("/") + File.separator + "file" + File.separator + "emp";
//			String fileName = FileUtil.createFile(excelFile.getBytes(), path, "csv");	
			String fileName = FileUtil.createFile(excelFile, path);
          //查看值
          //文件导入规则 查看值
            AttFileImportBO bo=null;
            if(atttype!=null && !"".equals(atttype)){
                bo=attenceSetUCC.findAttFileImportBObyId(atttype);
            }else{
            	super.showMessageDetail("你还没有定义任何文件导入规则！");
            	return "";
            }
            if(bo!=null){
            	String timeFormatValue="";
            	if(bo.getTimeFormat()!=null && !"".equals(bo.getTimeFormat())){
            		timeFormatValue=bo.getTimeFormat();
            	}else{
            		super.showMessageDetail("你还没有定义任何文件导入规则中时间处理类别！");
            		return "";
            	}
            	
            	String spiltName="";
            	if(bo.getSpiltChar()!=null && !"".equals(bo.getSpiltChar())){
            		spiltName=bo.getSpiltChar();
            	}else{
            		super.showMessageDetail("你还没有定义任何文件导入规则中分隔符！");
            		return "";
            	}
            	
            	List listssss = attenceSetUCC.getAttFileImportItemBO(bo.getImportID());
            	if(listssss!=null && listssss.size()>0){
            		for (int i = 0; i < listssss.size(); i++) {
    					AttFileImportItemBO attfileimportitembo = (AttFileImportItemBO) listssss.get(i);
                	    //文件导入规则指标项列表  查看值
            		}
            	}else{
            		super.showMessageDetail("你还没有定义任何文件导入规则指标项列表！");
            		return "";
            	}
            	
				if ("1".equals(bo.getFileFormat())) {
					if(!"TXT".equalsIgnoreCase(fileName.substring(fileName.length() - 3))){
						super.showMessageDetail("文件格式不一致，【上传文件为："+fileName.substring(fileName.length() - 3)+"】，而上传文件规则为：[TXT]。");
						return "";
					}
				} else if("2".equals(bo.getFileFormat())){
					if(!"CSV".equalsIgnoreCase(fileName.substring(fileName.length() - 3))){
						super.showMessageDetail("文件格式不一致，【上传文件为："+fileName.substring(fileName.length() - 3)+"】，而上传文件规则为：[CSV]。");
						return "";
					}
				}else if("3".equals(bo.getFileFormat())){
					if(!"XLS".equalsIgnoreCase(fileName.substring(fileName.length() - 3))){
						super.showMessageDetail("文件格式不一致，【上传文件为："+fileName.substring(fileName.length() - 3)+"】，而上传文件规则为：[XLS]。");
						return "";
					}
				}

        		//导入的文件为文本文件
				File f;
				BufferedReader br=null;
				f = new File(path + File.separator + fileName);
				//导入的文件为文本文件
				
            	if("TXT".equalsIgnoreCase(fileName.substring(fileName.length() - 3)) || "CSV".equalsIgnoreCase(fileName.substring(fileName.length() - 3))){
					if (!f.exists())
					{
						errorFileUrl = super.getServletRequest().getContextPath() + "/file/emp/ERROR_" +fileName.substring(0, fileName.length()-4)+".csv";
						showError = true;
					}else{
						br = new BufferedReader(new FileReader(f));
						String headerLine=null;
						while((headerLine = br.readLine())!=null){
							listsss.add(headerLine);
						}
					}					
            	}else if("XLS".equalsIgnoreCase(fileName.substring(fileName.length() - 3))){
            		//CSV
            	   //导入的XLS
            	   Workbook wb; 
            	   wb = Workbook.getWorkbook(f);
                   if (wb == null) {    
                       return "";    
                   } 
                   // 获得了Workbook对象之后，就可以通过它得到Sheet（工作表）对象了    
                   Sheet[] sheet = wb.getSheets();    
                   if (sheet != null && sheet.length > 0) {    
                	// 对每个工作表进行循环    
                       for (int i = 0; i < sheet.length; i++) {    
                           int sheetNumber = i + 1;
                           
                        // 得到当前行的所有单元格
                           int rowNum = sheet[i].getRows();  
                           for (int j = 0; j < rowNum; j++) {    
                               // 记录行号    
                               int lineNumber = j + 1;    
                              //正在读取第" + lineNumber+ "行数据
                              //得到当前行的所有单元格    
                               Cell[] cells = sheet[i].getRow(j);    
                               if (cells != null && cells.length > 0) {
                            	   String cellValuess="";
                                   // 对每个单元格进行循环    
                                   for (int k = 0; k < cells.length; k++) {    
                                       // 记录列号    
                                       int columeNumber = k + 1;    
                                       // 读取当前单元格的值    
                                       String cellValue = cells[k].getContents();    
                                     //第" + columeNumber+ "列数据:" + cellValue
                                       if(k>0){
                                    	   cellValuess+=","+cellValue; 
                                       }else{
                                           cellValuess=cellValue;  
                                       }
                                   }
                                   listsss.add(cellValuess);
                                   //导入的XLS
                               } 
                           }

                       }


                   }






            	}
            	
            	showError = false;
            	super.getHttpSession().removeAttribute("attencelogbos");
            	List attencelogbos=new ArrayList();
            	BufferedWriter bw=null;
				   bw = new BufferedWriter(new FileWriter(new File(path + File.separator + "ERROR_" +fileName.substring(0, fileName.length()-4)+".csv")));
				   int ssss=0;
				   String msg="";
				   String[] sss;   
				   int i=1;
				   int colInts=0;
				   while(i<listsss.size()){
                	  String str1 = (String) listsss.get(i);
					   String[] strvalues=null;
					   if(!"TAB".equals(spiltName)){
						   strvalues=str1.split(spiltName.trim());
					   }else{
						   strvalues=str1.split("\u0009"); 
					   }
					   
					   
					   
		              		for (int j = 0; j < listssss.size(); j++) {
		    					AttFileImportItemBO attfileimportitembo = (AttFileImportItemBO) listssss.get(j);
		    					int cols=Integer.parseInt(attfileimportitembo.getColNum());
		    					if(cols>=strvalues.length){
		    		            	super.showMessageDetail("你设置的接收字段位置大于文件中的最大行数：【"+cols+">="+strvalues.length+"】。");
		    		            	return "";
		    					}
		    					String  namevalues=strvalues[cols]+"%"+cols;
		    					System.out.println("计算 namevalues="+namevalues);
			                	  hashTable.put(attfileimportitembo.getItemType(),namevalues);
		            		}
		              		
		              		
	              			AttenceLogBO attencelogbo=new AttenceLogBO();
	              			String pk = SequenceGenerator.getKeyId("A808");
	              			attencelogbo.setSubID(pk);
	              			String record="00900";
	              			attencelogbo.setRecord(record);
		              		Iterator it=hashTable.keySet().iterator();
		              		String personID="";
		              		while(it.hasNext()){
		              			String keyValue=(String)it.next();
		              			String keyValues=(String)hashTable.get(keyValue);
		              			System.out.println("计算 keyValues="+keyValues);
		              			String[] keyValuess=keyValues.split("%");
		              			String keyValue1=keyValuess[0];
		              			colInts=Integer.parseInt(keyValuess[keyValuess.length-1]);
		              			
		              			//导入的数据值
	              			    if("1".equals(keyValue)){  //卡号
	              			    	personID=attenceSetUCC.findPersonID(keyValue1);
	              			    	//人员值
	              			    	if(personID!=null && !"".equals(personID)){
	              			    		attencelogbo.setPersonId(personID);
	              			    	}else{
	 								   msg="记录所对应的考勤卡号["+keyValue1+"]不存在！ ";
	 								  addErrorFormatLabel(bw,(i+1),colInts,msg);
	              			    		continue;
	              			    	}
		              			}else if("2".equals(keyValue)){ //时间
			              			//String[] strs=keyValue1.split(" ");
			              			if("0".equals(timeFormatValue)){
			              				String[] strs=keyValue1.split(" ");
				              			if(strs.length>1){
				              				attencelogbo.setCardDate(strs[0]);
				              				attencelogbo.setCardTime(strs[strs.length-1]);
				              			}else{
				              				super.showMessageDetail("文件规则中，时间字段位置和导入文件中时间位置，不一致！");
				              				return "";
				              			}
			              			}else if("1".equals(timeFormatValue)){
			              				System.out.println("计算 timeFormatValue="+keyValue1);
			              				String[] strs=keyValue1.split(" ");
				              			if(strs.length>2){
				              				if("AM".equalsIgnoreCase(strs[1])){
												SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
										        Date date1 = df.parse(strs[0].trim());
										        Calendar calendar = Calendar.getInstance();
										        calendar.setTime(date1);
										        String day1 = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
					              				attencelogbo.setCardDate(day1);
												SimpleDateFormat df1 = new SimpleDateFormat("HH:mm:ss");
												String datevalue=strs[strs.length-1].trim();
										        Date date2 = df1.parse(datevalue);
										        Calendar calendar1 = Calendar.getInstance();
										        calendar1.get(Calendar.HOUR_OF_DAY);  
										        calendar1.setTime(date2);
										        String day2 = new SimpleDateFormat("HH:mm:ss").format(calendar1.getTime());
					              				attencelogbo.setCardTime(day2);
				              				}else if("上午".equalsIgnoreCase(strs[1])){
												SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
										        Date date1 = df.parse(strs[0].trim());
										        Calendar calendar = Calendar.getInstance();
										        calendar.setTime(date1);
										        String day1 = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
					              				attencelogbo.setCardDate(day1);
												SimpleDateFormat df1 = new SimpleDateFormat("HH:mm:ss");
												String datevalue=strs[strs.length-1].trim();
										        Date date2 = df1.parse(datevalue);
										        Calendar calendar1 = Calendar.getInstance();
										        calendar1.get(Calendar.HOUR_OF_DAY);  
										        calendar1.setTime(date2);
										        String day2 = new SimpleDateFormat("HH:mm:ss").format(calendar1.getTime());
					              				attencelogbo.setCardTime(day2);
				              				}else if("PM".equalsIgnoreCase(strs[1])){
												SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
										        Date date1 = df.parse(strs[0].trim());
										        Calendar calendar = Calendar.getInstance();
										        calendar.setTime(date1);
										        String day1 = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
					              				attencelogbo.setCardDate(day1);
												SimpleDateFormat df1 = new SimpleDateFormat("HH:mm:ss");
												String datevalue=strs[strs.length-1].trim();
												String[] datevalues=datevalue.split(":");
												int h=Integer.parseInt(datevalues[0])+12;
												String datevalue1=h+":"+datevalues[1]+":"+datevalues[2];
										        Date date2 = df1.parse(datevalue1);
										        Calendar calendar1 = Calendar.getInstance();
										        calendar1.get(Calendar.HOUR_OF_DAY);  
										        calendar1.setTime(date2);
										        String day2 = new SimpleDateFormat("HH:mm:ss").format(calendar1.getTime());
					              				attencelogbo.setCardTime(day2);
				              				}else if("下午".equalsIgnoreCase(strs[1])){
												SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
										        Date date1 = df.parse(strs[0].trim());
										        Calendar calendar = Calendar.getInstance();
										        calendar.setTime(date1);
										        String day1 = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
					              				attencelogbo.setCardDate(day1);
												SimpleDateFormat df1 = new SimpleDateFormat("HH:mm:ss");
												String datevalue=strs[strs.length-1].trim();
												String[] datevalues=datevalue.split(":");
												int h=Integer.parseInt(datevalues[0])+12;
												String datevalue1=h+":"+datevalues[1]+":"+datevalues[2];
										        Date date2 = df1.parse(datevalue1);
										        Calendar calendar1 = Calendar.getInstance();
										        calendar1.get(Calendar.HOUR_OF_DAY);  
										        calendar1.setTime(date2);
										        String day2 = new SimpleDateFormat("HH:mm:ss").format(calendar1.getTime());
					              				attencelogbo.setCardTime(day2);
				              				}
				              			}else{
				              				super.showMessageDetail("文件规则中，时间字段位置和导入文件中时间位置，不一致！");
				              				return "";
				              			}
			              			}
		              			}else if("5".equals(keyValue)){  //员工编号
	              			    	personID=attenceSetUCC.findPersonNoToID(keyValue1);
	              			      //人员值
	              			    	if(personID!=null && !"".equals(personID)){
	              			    		attencelogbo.setPersonId(personID);
	              			    	}else{
	              			    	  msg="记录所对应的员工编号【"+keyValue1+"】不存在！ ";
	              			    	addErrorFormatLabel(bw,(i+1),colInts,msg);
	              			    		continue;
	              			    	}	              			    	
		              			}else if("6".equals(keyValue)){  //旧系统员工编号
	              			    	personID=attenceSetUCC.findPersonNoToIDS(keyValue1);
	              			      //人员值
	              			    	if(personID!=null && !"".equals(personID)){
	              			    		attencelogbo.setPersonId(personID);
	              			    	}else{
	              			    		 msg="记录所对应的旧系统员工编号【"+keyValue1+"】不存在！ ";
	              			    		addErrorFormatLabel(bw,(i+1),colInts,msg);
	              			    	continue;
	              			    	}	              			    	
		              			}
		              		    //3 考勤机号
	              			    //4 进出标志
		              		}
		              		
		              		if(personID!=null && !"".equals(personID)){
//			              		attenceSetUCC.saveAttenceLogBO(attencelogbo);
			              		AttClassGroupVO attclassgroupvo=attenceSetUCC.findAttClassGroupVObyId(personID);
			              		attencelogbo.setPersonName(attclassgroupvo.getName());
			              		attencelogbo.setPersonSeq(attclassgroupvo.getPersonSeq());
			              		attencelogbos.add(attencelogbo);
			              		i++;
		              		}else{
          			    		listsss.remove(i);
								   ssss+=1;
//								   addErrorFormatLabel(bw,(i+1),colInts,msg);
		              		}
		              			
		              		 
            	  
              }
				   super.getHttpSession().setAttribute("attencelogbos", attencelogbos);
				   if(ssss>0){
					   errorFileUrl = super.getServletRequest().getContextPath() + "/file/emp/ERROR_" +fileName.substring(0, fileName.length()-4)+".csv";
					   showError = true;
					   return "perInfoList";
				   }
				   ssss=0;
            }
		}
		catch (Exception e)
		{
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return "perInfoList";
	}

	public  boolean readExcelFileAttence(String absolutePath, String fileName, InfoItemBO cols[], String keyDataType, int keyCol, IdentityHashMap impRs, int startCol, int startRow, 
			boolean delFile)
		throws SysException
	{
		return readExcelFileAttence(absolutePath, fileName, cols, keyDataType, keyCol, impRs, startCol, startRow, delFile, -1, null);
	}

	public  boolean readExcelFileAttence(String absolutePath, String fileName, InfoItemBO cols[], String keyDataType, int keyCol, IdentityHashMap impRs, int startCol, int startRow, 
			boolean delFile, int nameCol, User user)
		throws SysException
	{
	       boolean flag=true;
		   for(int i=0;i<cols.length;i++){
			   InfoItemBO bo=(InfoItemBO)cols[i];
//			   System.out.println("InfoItemBO1="+bo.getItemName());
		   }
			File f;
			BufferedReader br=null;
			f = new File(absolutePath + File.separator + fileName);
			try {
				br = new BufferedReader(new FileReader(f));
				String headerLine=null;
				while((headerLine = br.readLine())!=null){
//					System.out.println("str="+headerLine+" ");
				}
			} catch (Exception e) {

			}
			
		   
		return flag;
	}
	
	private static void addErrorFormatLabel(BufferedWriter bw, int row, int col, String error)
	{
		try
		{
			bw.write(addCsvField("第 " + row + " 行，第 " + (col + 1) + " 列 " + error));
			bw.newLine();
			bw.flush();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}
	public static String addCsvField(String str)
	{
		if (str == null)
			return ",";
		StringBuffer sb;
		if (str.indexOf("\"") != -1)
			sb = new StringBuffer(str.replaceAll("\"", "\"\""));
		else
			sb = new StringBuffer(str);
		if (sb.length() > 14)
			sb.insert(0, '\t');
		return sb.append(",").toString();
	}
	public String saveFileBySet()
	{
		try{
		List attencelogboss;
		attencelogboss = (List)super.getHttpSession().getAttribute("attencelogbos");
		if(attencelogboss!=null && attencelogboss.size()>0){
	           for(int i=0;i<attencelogboss.size();i++){
	        	   AttenceLogBO attencelogbo=(AttenceLogBO)attencelogboss.get(i);
	        	   attenceSetUCC.saveAttenceLogBO(attencelogbo);
	           }
			super.showMessageDetail("保存成功！");
		}else{
			super.showMessageDetail("数据列表为空！");
			return "";
		}
   		super.getHttpSession().removeAttribute("attencelogbos");
		}catch(Exception e){
			super.showMessageDetail("错误：" + e.getMessage());
			msg.setMainMsg(e, getClass());
		}
		return "upload";
	}

	public String saveFile()
	{
		try{
		HashMap hash;
		String itemId[];
		String persId[];
		hash = (HashMap)super.getHttpSession().getAttribute("fileValue");
		itemId = (String[])(String[])super.getHttpSession().getAttribute("field");
		java.util.Iterator key = hash.keySet().iterator();
		int i = 0;
		persId = (String[])(String[])hash.keySet().toArray(new String[0]);
		String set = "";
		if (orgSelSet != null && !orgSelSet.equals(""))
			set = orgSelSet;
		else
			set = perSelSet;
		if (set != null && !set.equals(""))
			if ("0".equals(mode))
			{
				datauploaducc.updateInfoByCode(set, itemId, hash);
			} else
			{
				datauploaducc.insertInfoByCode(set, itemId, hash);
				InfoSetBO bo = SysCacheTool.findInfoSet(set);
				if (bo != null && bo.getSet_rsType().equals(InfoSetBO.RS_TYPE_MANY))
					datauploaducc.updateCurSign(set, bo.getSetFk(), persId, "");
			}
		super.getHttpSession().removeAttribute("fileValue");
		super.getHttpSession().removeAttribute("field");
		super.showMessageDetail("保存成功");
		}catch(Exception e){
			super.showMessageDetail("错误：" + e.getMessage());
			msg.setMainMsg(e, getClass());
		}
		return "upload";
	}

	public void selChanged(ValueChangeEvent event)
	{
		try
		{
			if (!"".equals(event.getNewValue()))
			{
				perSelSet = event.getNewValue().toString();
				InfoItemBO bo[] = datauploaducc.querySetItem(perSelSet);
				if (bo != null && bo.length > 0)
				{
					perSetItemList = new ArrayList();
					for (int i = 0; i < bo.length; i++)
					{
						SelectItem item = new SelectItem();
						item.setLabel(bo[i].getItemName());
						item.setValue(bo[i].getItemId());
						perSetItemList.add(item);
					}

				}
			}
		}
		catch (Exception e)
		{
			super.showMessageDetail("错误：" + e.getMessage());
		}
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public List getAttencelogboss() {
		return attencelogboss;
	}

	public void setAttencelogboss(List attencelogboss) {
		this.attencelogboss = attencelogboss;
	}

	public void doQuery() {
		//文件导入规则列表
		try{
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List listss = attenceSetUCC.getAttFileImportBO(mypage, superId);
			if (listss != null && listss.size() > 0) {
				for (int i = 0; i < listss.size(); i++) {
					AttFileImportBO attfileimportBO = (AttFileImportBO) listss
							.get(i);
					if (!"".equals(attfileimportBO.getFileFormat())) {
						if ("1".equals(attfileimportBO.getFileFormat())) {
							attfileimportBO.setFileFormatName("文本文件(*.TXT)");
						} else {
							attfileimportBO.setFileFormatName("EXCEL(*.XLS)");
						}
					}
					listss.set(i, attfileimportBO);

				}
			}
			
			if (superId != null) {
				String org = "-1";
				List lists1 = attenceSetUCC.getAttFileImportBO(mypage, org);
				if (lists1 != null && lists1.size() > 0) {
					for (int i = 0; i < lists1.size(); i++) {
						AttFileImportBO attfileimportBO1 = (AttFileImportBO) lists1
								.get(i);
						if (!"".equals(attfileimportBO1.getFileFormat())) {
							if ("1".equals(attfileimportBO1.getFileFormat())) {
								attfileimportBO1
										.setFileFormatName("文本文件(*.TXT)");
							} else {
								attfileimportBO1
										.setFileFormatName("EXCEL(*.XLS)");
							}
						}
						lists1.set(i, attfileimportBO1);
					}

					listss.addAll(lists1);
				}
			}
			
			if (listss != null && listss.size() > 0) {
				for (int i = 0; i < listss.size(); i++) {
					AttFileImportBO attfileimportBO = (AttFileImportBO) listss
							.get(i);
					SelectItem si = new SelectItem();
					si.setLabel(attfileimportBO.getImportName());
					si.setValue(attfileimportBO.getImportID());
					lists.add(si);
				}
			}
		}catch(Exception e){
			
		}
	}
	
	public List getLists() {
		doQuery();
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}
	
	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}
}
