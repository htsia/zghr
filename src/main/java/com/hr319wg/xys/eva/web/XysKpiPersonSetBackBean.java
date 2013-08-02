package com.hr319wg.xys.eva.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysKpiObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiObjLibBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.vo.KPIImportVO;
import com.hr319wg.xys.eva.pojo.vo.KPIItemVO;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC;
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import org.apache.myfaces.custom.fileupload.UploadedFile;

import java.util.ArrayList;
import java.util.List;


public class XysKpiPersonSetBackBean extends BaseBackingBean {
	private IXysKpiDeptUCC xysKpiDeptUCC;
	private IXysKpiPersonUCC xysKpiPersonUCC;
	private String initIndex;
	private String superId;
	private String planId;
	private String pageInit;
	private String superName;
	private PageVO mypage = new PageVO();
	private List objList;
	private String objId;
	private String queryValue;

	public String loadPost(){
		try{
			this.xysKpiPersonUCC.loadPersonKpiObjByPlanId(planId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String getQueryValue() {
		return queryValue;
	}

	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}

	public String deleteObj() {
		try {
			xysKpiPersonUCC.deleteXysKpiPersonObjBO(objId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String refuseObj() {
		try {
			XysKpiPersonObjBO obj = this.xysKpiPersonUCC
					.findXysKpiPersonObjBOById(objId);
			obj.setKeyStatus("F");
			xysKpiPersonUCC.saveXysKpiPersonObjBO(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public IXysKpiDeptUCC getXysKpiDeptUCC() {
		return xysKpiDeptUCC;
	}

	public void setXysKpiDeptUCC(IXysKpiDeptUCC xysKpiDeptUCC) {
		this.xysKpiDeptUCC = xysKpiDeptUCC;
	}

	public IXysKpiPersonUCC getXysKpiPersonUCC() {
		return xysKpiPersonUCC;
	}

	public void setXysKpiPersonUCC(IXysKpiPersonUCC xysKpiPersonUCC) {
		this.xysKpiPersonUCC = xysKpiPersonUCC;
	}

	public String getInitIndex() {
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		return initIndex;
	}

	public void setInitIndex(String initIndex) {
		this.initIndex = initIndex;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
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

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if (superId == null || superId.equals("")) {
				superId = super.getUserInfo().getOrgId();
			}

			if (queryValue != null && !queryValue.equals("")) {
				String where = " and bo.personId in(select po.personId from PersonBO po "
						+ "where po.name like '%"
						+ queryValue
						+ "%' or po.shortName like '%"
						+ queryValue
						+ "%' or po.personCode like '%" + queryValue + "%')";
				objList = xysKpiPersonUCC.getXysKpiPersonObjBOByQueryValue(
						mypage, planId, where);
			} else {
				objList = xysKpiPersonUCC.getXysKpiPersonObjBO(mypage, planId,
						superId);
			}
			if (objList != null && objList.size() > 0) {
				for (int i = 0; i < objList.size(); i++) {
					XysKpiPersonObjBO obj = (XysKpiPersonObjBO) objList.get(i);
					PersonBO pbo = SysCacheTool.findPersonById(obj
							.getPersonId());
					obj.setPersonName(pbo.getName());
					obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
							.getName());
					obj.setPostName(PostTool.getPostName(pbo.getPostId()));
					objList.set(i, obj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
    	String act=super.getRequestParameter("act");
    	if("init".equals(act)){
    		planId = null;
    		superId = null;
    	}
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
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

	public List getObjList() {
		return objList;
	}

	public void setObjList(List objList) {
		this.objList = objList;
	}

	public String getObjId() {
		return objId;
	}

	public void setObjId(String objId) {
		this.objId = objId;
	}

	// 指标导入
	private String initUpload;
	private UploadedFile excelFile;

	public String getInitUpload() {
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		return initUpload;
	}

	public void setInitUpload(String initUpload) {
		this.initUpload = initUpload;
	}

	public String uploadFile() {
		try {
			String fileName = excelFile.getName();
			String type = fileName.substring(fileName.indexOf(".") + 1);
			if (type.equals("xls")) {
				Workbook wb = Workbook.getWorkbook(excelFile.getInputStream());
				Sheet sheet = wb.getSheet(0);
				int rows = sheet.getRows();
				List superNameList = new ArrayList();
				List itemVoList = new ArrayList();
				KPIItemVO itemVo = null;
				for (int i = 1; i < rows; i++) {// 便利excel封装 KPIItemVO
					Cell[] cell = sheet.getRow(i);
					PersonBO pbo = SysCacheTool.findPersonByCode(CommonFuns
							.filterNull(cell[0].getContents().trim()));
					if (pbo != null) {
						String pId = pbo.getPersonId();
						if (pId != null) {
							String superName = cell[1].getContents().trim()
									.replaceAll("%", "");
							if (superName != null && !superName.equals("")) {
								if (!superNameList.contains(pId + "-"
										+ superName)) {
									superNameList.add(pId + "-" + superName);
								}
								itemVo = new KPIItemVO();
								itemVo.setPersonId(pId);
								itemVo.setSuperName(superName);
								itemVo.setItemName(CommonFuns.filterNull(
										cell[2].getContents().trim())
										.replaceAll("%", ""));
								itemVo.setItemGrade(CommonFuns.filterNull(
										cell[7].getContents().trim())
										.replaceAll("%", ""));
								itemVo.setAimValue(CommonFuns.filterNull(
										cell[4].getContents().trim())
										.replaceAll("%", ""));
								itemVo.setDataSource(CommonFuns.filterNull(
										cell[6].getContents().trim())
										.replaceAll("%", ""));
								itemVo.setWeight(CommonFuns.filterNull(
										cell[3].getContents().trim())
										.replaceAll("%", ""));
								itemVo.setHiScore(CommonFuns.filterNull(
										cell[5].getContents().trim())
										.replaceAll("%", ""));
								itemVo.setLowScore("0");
								itemVoList.add(itemVo);
							}
						}
					}
				}
				List importList = new ArrayList();
				if (superNameList != null && superNameList.size() > 0) {
					int superNameSize = superNameList.size();
					int itemVoListSize = itemVoList.size();
					for (int i = 0; i < superNameSize; i++) {
						String superNameVar = (String) superNameList.get(i);
						String ids[] = superNameVar.split("-");
						KPIImportVO vo = new KPIImportVO();
						PersonBO pbo = SysCacheTool.findPersonById(ids[0]);
						vo.setPersonId(pbo.getPersonId());
						vo.setSuperName(ids[1]);
						List vlist = new ArrayList();
						if (itemVoList != null && itemVoListSize > 0) {
							for (int j = 0; j < itemVoListSize; j++) {
								KPIItemVO itemV = (KPIItemVO) itemVoList.get(j);
								if ((itemV.getPersonId() + "-" + itemV
										.getSuperName()).equals(superNameVar)) {
									vlist.add(itemV);
								}
							}
						}

						vo.setItemList(vlist);
						importList.add(vo);
					}
				}
				if (importList != null && importList.size() > 0) {
					for (int i = 0; i < importList.size(); i++) {
						KPIImportVO vo = (KPIImportVO) importList.get(i);
						XysKpiPersonObjBO obj = xysKpiPersonUCC
								.findEqualsXysKpiPersonObjBO(planId,
										vo.getPersonId());
						if (obj == null) { // 如果是空保存打分主体
							obj = new XysKpiPersonObjBO();
							PersonBO pbo=SysCacheTool.findPersonById(vo.getPersonId());
							obj.setPersonId(vo.getPersonId());
							obj.setPlanId(planId);
							obj.setKeyStatus("3");// 新增
							obj.setPostId(pbo.getPostId());
							xysKpiPersonUCC.saveXysKpiPersonObjBO(obj);
						}
						XysKpiObjLibBO lib = new XysKpiObjLibBO(); // 保存目录
						lib.setObjId(obj.getObjId());
						lib.setObjLibName(vo.getSuperName());
						xysKpiDeptUCC.saveXysKpiObjLibBO(lib);

						List list = vo.getItemList();// 保存指标项
						if (list != null && list.size() > 0) {
							for (int j = 0; j < list.size(); j++) {
								KPIItemVO ivo = (KPIItemVO) list.get(j);
								XysKpiObjKeyBO key = new XysKpiObjKeyBO();
								key.setObjLibId(lib.getObjLibId());
								key.setObjId(obj.getObjId());
								key.setWeight(ivo.getWeight());
								key.setAimValue(ivo.getAimValue());
								key.setDataSource(ivo.getDataSource());
								key.setGradeStd(ivo.getItemGrade());
								key.setHiValue(ivo.getHiScore());
								key.setKeyName(ivo.getItemName());
								key.setLowValue(ivo.getLowScore());
								if (key.getWeight() != null
										&& !key.getWeight().equals("")) {
									xysKpiDeptUCC.saveXysKpiObjKeyBO(key);
								}
							}
						}
					}
				}
				wb.close();
			} else {
				super.showMessageDetail("只允许上传Excel（.xls）文档！");
				return "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public UploadedFile getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	// 增加部门考核岗位
	private String postIds;

	public String addPost() {
		try {
			if (postIds != null && !postIds.equals("")) {
				String ids[] = postIds.split(",");
				for (int i = 0; i < ids.length; i++) {
					if (ids[i] != null && !ids[i].equals("")) {
						List pids = xysKpiDeptUCC.getPersonIdsByPostId(ids[i]);
						if (pids != null && pids.size() > 0) {
							for (int j = 0; j < pids.size(); j++) {
								String pid = (String) pids.get(j);
								XysKpiPersonObjBO obj = xysKpiPersonUCC
										.findEqualsXysKpiPersonObjBO(planId,
												pid);
								if (obj == null) {
									obj = new XysKpiPersonObjBO();
									PersonBO pbo=SysCacheTool.findPersonById(pid);
									obj.setPersonId(pid);
									obj.setPlanId(planId);
									obj.setKeyStatus("1");// 新增
									obj.setPostId(pbo.getPostId());
									xysKpiPersonUCC.saveXysKpiPersonObjBO(obj);
								}
							}
						}
					}
				}
			}
			postIds = "";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getPostIds() {
		return postIds;
	}

	public void setPostIds(String postIds) {
		this.postIds = postIds;
	}

}
