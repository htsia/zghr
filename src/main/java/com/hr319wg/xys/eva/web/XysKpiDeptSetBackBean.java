package com.hr319wg.xys.eva.web;

import java.util.ArrayList;
import java.util.List;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiKeyLibBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiObjLibBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.vo.KPIImportVO;
import com.hr319wg.xys.eva.pojo.vo.KPIItemVO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiKeyUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC;

/**
 * Created by IntelliJ IDEA. User: Administrator Date: 12-6-12 Time: 下午2:01 To
 * change this template use File | Settings | File Templates.
 */
public class XysKpiDeptSetBackBean extends BaseBackingBean {
	private IXysKpiDeptUCC xysKpiDeptUCC;
	private String initIndex;
	private String superId;
	private String planId;
	private String pageInit;
	private String superName;
	private PageVO mypage = new PageVO();
	private List objList;
	private String objId;

	public String deleteObj() {
		try {
			xysKpiDeptUCC.deleteXysKpiDeptObjBO(objId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String refuseObj() {
		try {
			XysKpiDeptObjBO obj = this.xysKpiDeptUCC
					.findXysKpiDeptObjBOById(objId);
			obj.setKeyStatus("F");
			xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getObjId() {
		return objId;
	}

	public void setObjId(String objId) {
		this.objId = objId;
	}

	public IXysKpiDeptUCC getXysKpiDeptUCC() {
		return xysKpiDeptUCC;
	}

	public void setXysKpiDeptUCC(IXysKpiDeptUCC xysKpiDeptUCC) {
		this.xysKpiDeptUCC = xysKpiDeptUCC;
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
			objList = xysKpiDeptUCC.getXysKpiDeptObjBO(mypage, planId, superId);
			if (objList != null && objList.size() > 0) {
				for (int i = 0; i < objList.size(); i++) {
					XysKpiDeptObjBO obj = (XysKpiDeptObjBO) objList.get(i);
					PersonBO pbo = SysCacheTool.findPersonById(obj
							.getPersonId());
					obj.setPersonName(pbo.getName());
					obj.setDeptName(SysCacheTool.findOrgById(obj.getDeptId())
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
				System.out.println("==============开始导入！===================");
				Workbook wb = Workbook.getWorkbook(excelFile.getInputStream());
				Sheet sheet = wb.getSheet(0);
				int rows = sheet.getRows();
				System.out.println("行数：" + rows);
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
							String superName = cell[1].getContents().trim();
							if (!superNameList.contains(pId + "-" + superName)) {
								superNameList.add(pId + "-" + superName);
							}
							itemVo = new KPIItemVO();
							itemVo.setPersonId(pId);
							itemVo.setSuperName(superName);
							itemVo.setItemName(CommonFuns.filterNull(cell[2]
									.getContents().trim()));
							itemVo.setItemGrade(CommonFuns.filterNull(cell[7]
									.getContents().trim()));
							itemVo.setAimValue(CommonFuns.filterNull(cell[4]
									.getContents().trim()));
							itemVo.setDataSource(CommonFuns.filterNull(cell[6]
									.getContents().trim()));
							itemVo.setWeight(CommonFuns.filterNull(
									cell[3].getContents().trim()).replaceAll(
									"%", ""));
							itemVo.setHiScore(CommonFuns.filterNull(
									cell[5].getContents().trim()).replaceAll(
									"%", ""));
							itemVo.setLowScore("0");
							itemVoList.add(itemVo);
						}
					}
				}
				List importList = new ArrayList();
				if (superNameList != null && superNameList.size() > 0) {
					int superNameSize = superNameList.size();
					int itemVoListSize = itemVoList.size();
					for (int i = 0; i < superNameSize; i++) {
						String superNameVar = (String) superNameList.get(i);
						System.out.println(superNameVar);
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
						XysKpiDeptObjBO obj = xysKpiDeptUCC
								.findEqualsXysKpiDeptObjBO(planId,
										vo.getPersonId());
						if (obj == null) { // 如果是空保存打分主体
							String deptId = xysKpiDeptUCC
									.getAuditDeptIdByPersonId(vo.getPersonId());// 返回被考核部门
							PersonBO pbo=SysCacheTool.findPersonById(vo.getPersonId());
							obj = new XysKpiDeptObjBO();
							obj.setPersonId(vo.getPersonId());
							obj.setPlanId(planId);
							obj.setKeyStatus("3");// 导入默认是审批
							obj.setDeptId(deptId);
							obj.setPostId(pbo.getPostId());
							xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);
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
				System.out.println("==============导入成功！===================");
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
								XysKpiDeptObjBO obj = xysKpiDeptUCC
										.findEqualsXysKpiDeptObjBO(planId, pid);
								if (obj == null) {
									String deptId = xysKpiDeptUCC
											.getAuditDeptIdByPersonId(pid);// 返回被考核部门
									PersonBO pbo=SysCacheTool.findPersonById(pid);
									obj = new XysKpiDeptObjBO();
									obj.setPersonId(pid);
									obj.setPlanId(planId);
									obj.setKeyStatus("1");// 新增
									obj.setDeptId(deptId);
									obj.setPostId(pbo.getPostId());
									xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);

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

	// 指标设置
	private String initLib;
	private String initLibEdit;
	private XysKpiObjLibBO libB0 = new XysKpiObjLibBO();
	private String initKeyList;
	private String libId;
	private List keyList;
	private String initKey;
	private XysKpiObjKeyBO keyBo = new XysKpiObjKeyBO();
	private String keyId;
	private String method;
	private boolean disabled;
	private IXysKpiPersonUCC xysKpiPersonUCC;
	private IXysKpiKeyUCC xysKpiKeyUCC;
	private IXysEvaPlanUCC xysEvaPlanUCC;
	
	
	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}

	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
	}

	public IXysKpiKeyUCC getXysKpiKeyUCC() {
		return xysKpiKeyUCC;
	}

	public void setXysKpiKeyUCC(IXysKpiKeyUCC xysKpiKeyUCC) {
		this.xysKpiKeyUCC = xysKpiKeyUCC;
	}

	public String loadStrLib(){
		try{
			XysKpiDeptObjBO bo=this.xysKpiDeptUCC.findXysKpiDeptObjBOById(objId);
			if(bo!=null){//部门kpi
				PersonBO pbo=SysCacheTool.findPersonById(bo.getPersonId());
				List libList=this.xysKpiKeyUCC.getXysKpiKeyLibBOByPostId(pbo.getPostId());
				if(libList!=null&&libList.size()>0){
					for(int i=0;i<libList.size();i++){
						XysKpiKeyLibBO lib=(XysKpiKeyLibBO)libList.get(i);
						XysKpiObjLibBO olib=new XysKpiObjLibBO();
						olib.setObjId(objId);
						olib.setObjLibName(lib.getLibName());
						this.xysKpiDeptUCC.saveXysKpiObjLibBO(olib);
						List keyList=this.xysKpiKeyUCC.getXysKpiKeyBOByLibId(lib.getLibId());
						if(keyList!=null&&keyList.size()>0){
							for(int j=0;j<keyList.size();j++){
								XysKpiKeyBO key=(XysKpiKeyBO)keyList.get(j);
								XysKpiObjKeyBO okey=new XysKpiObjKeyBO();
								okey.setKeyName(key.getKeyName());
								okey.setAimValue(key.getAimValue());
								okey.setDataSource(key.getDataSource());
								okey.setGradeStd(key.getGradeStd());
								okey.setHiValue(key.getHiValue());
								okey.setLowValue(key.getLowValue());
								okey.setObjLibId(olib.getObjLibId());
								xysKpiDeptUCC.saveXysKpiObjKeyBO(okey);
							}
						}
					}
				}
			}else{//个人KPI
				XysKpiPersonObjBO ppo=this.xysKpiPersonUCC.findXysKpiPersonObjBOById(objId);
				PersonBO pbo=SysCacheTool.findPersonById(ppo.getPersonId());
				List libList=this.xysKpiKeyUCC.getXysKpiKeyLibBOByPostId(pbo.getPostId());
				if(libList!=null&&libList.size()>0){
					for(int i=0;i<libList.size();i++){
						XysKpiKeyLibBO lib=(XysKpiKeyLibBO)libList.get(i);
						XysKpiObjLibBO olib=new XysKpiObjLibBO();
						olib.setObjId(objId);
						olib.setObjLibName(lib.getLibName());
						this.xysKpiDeptUCC.saveXysKpiObjLibBO(olib);
						List keyList=this.xysKpiKeyUCC.getXysKpiKeyBOByLibId(lib.getLibId());
						if(keyList!=null&&keyList.size()>0){
							for(int j=0;j<keyList.size();j++){
								XysKpiKeyBO key=(XysKpiKeyBO)keyList.get(j);
								XysKpiObjKeyBO okey=new XysKpiObjKeyBO();
								okey.setKeyName(key.getKeyName());
								okey.setAimValue(key.getAimValue());
								okey.setDataSource(key.getDataSource());
								okey.setGradeStd(key.getGradeStd());
								okey.setHiValue(key.getHiValue());
								okey.setLowValue(key.getLowValue());
								okey.setObjLibId(olib.getObjLibId());
								okey.setObjId(objId);
								xysKpiDeptUCC.saveXysKpiObjKeyBO(okey);
							}
						}
					}
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String loadBeforeLib(){
		try{
			List planList=this.xysEvaPlanUCC.getXysEvaPlanBO(null, super.getUserInfo().getOrgId(),null);
			if(planList!=null&&planList.size()>2){
				XysEvaPlanBO plan=(XysEvaPlanBO)planList.get(1);
				XysKpiDeptObjBO bo=this.xysKpiDeptUCC.findXysKpiDeptObjBOById(objId);
				if(bo!=null){//部门KPI
					XysKpiDeptObjBO probo=this.xysKpiDeptUCC.findEqualsXysKpiDeptObjBO(plan.getPlanId(), bo.getPersonId());
					List liblist=this.xysKpiDeptUCC.getXysKpiObjLibBOByObjId(probo.getObjId());
					if(liblist!=null&&liblist.size()>0){
						for(int i=0;i<liblist.size();i++){
							XysKpiObjLibBO lib=(XysKpiObjLibBO)liblist.get(i);
							XysKpiObjLibBO lib2=new XysKpiObjLibBO();
							lib2.setObjLibName(lib.getObjLibName());
							lib2.setObjId(objId);
							xysKpiDeptUCC.saveXysKpiObjLibBO(lib2);
							List keyList=this.xysKpiDeptUCC.getXysKpiObjKeyBOByLibId(lib.getObjLibId());
							if(keyList!=null&&keyList.size()>0){
								for(int j=0;j<keyList.size();j++){
									XysKpiObjKeyBO key=(XysKpiObjKeyBO)keyList.get(j);
									XysKpiObjKeyBO key2=new XysKpiObjKeyBO();
									key2.setAimValue(key.getAimValue());
									key2.setDataSource(key.getDataSource());
									key2.setGradeStd(key.getGradeStd());
									key2.setHiValue(key.getHiValue());
									key2.setKeyName(key.getKeyName());
									key2.setLowValue(key.getLowValue());
									key2.setObjId(objId);
									key2.setObjLibId(lib2.getObjLibId());
									xysKpiDeptUCC.saveXysKpiObjKeyBO(key2);
								}
							}
						}
					}
				}else{//个人KPI
					XysKpiPersonObjBO ppo=this.xysKpiPersonUCC.findXysKpiPersonObjBOById(objId);
					XysKpiPersonObjBO probo=this.xysKpiPersonUCC.findEqualsXysKpiPersonObjBO(plan.getPlanId(), ppo.getPersonId());
					List liblist=this.xysKpiDeptUCC.getXysKpiObjLibBOByObjId(probo.getObjId());
					if(liblist!=null&&liblist.size()>0){
						for(int i=0;i<liblist.size();i++){
							XysKpiObjLibBO lib=(XysKpiObjLibBO)liblist.get(i);
							XysKpiObjLibBO lib2=new XysKpiObjLibBO();
							lib2.setObjLibName(lib.getObjLibName());
							lib2.setObjId(objId);
							xysKpiDeptUCC.saveXysKpiObjLibBO(lib2);
							List keyList=this.xysKpiDeptUCC.getXysKpiObjKeyBOByLibId(lib.getObjLibId());
							if(keyList!=null&&keyList.size()>0){
								for(int j=0;j<keyList.size();j++){
									XysKpiObjKeyBO key=(XysKpiObjKeyBO)keyList.get(j);
									XysKpiObjKeyBO key2=new XysKpiObjKeyBO();
									key2.setAimValue(key.getAimValue());
									key2.setDataSource(key.getDataSource());
									key2.setGradeStd(key.getGradeStd());
									key2.setHiValue(key.getHiValue());
									key2.setKeyName(key.getKeyName());
									key2.setLowValue(key.getLowValue());
									key2.setObjId(objId);
									key2.setObjLibId(lib2.getObjLibId());
									xysKpiDeptUCC.saveXysKpiObjKeyBO(key2);
								}
							}
						}
					}
				}
			}else{
				super.showMessageDetail("没有上年度计划内容无法加载！");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public boolean getDisabled() {
		return disabled;
	}

	public IXysKpiPersonUCC getXysKpiPersonUCC() {
		return xysKpiPersonUCC;
	}

	public void setXysKpiPersonUCC(IXysKpiPersonUCC xysKpiPersonUCC) {
		this.xysKpiPersonUCC = xysKpiPersonUCC;
	}

	public void setDisabled(boolean disabled) {
		this.disabled = disabled;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getKeyId() {
		return keyId;
	}

	public void setKeyId(String keyId) {
		this.keyId = keyId;
	}

	public String deleteKey() {
		try {
			xysKpiDeptUCC.deleteXysKpiObjKeyBO(keyId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String saveKey() {
		try {
			if (keyBo.getHiValue() == null || keyBo.getHiValue().equals("")) {
				keyBo.setHiValue("100");
			}
			if (keyBo.getLowValue() == null || keyBo.getLowValue().equals("")) {
				keyBo.setLowValue("0");
			}
			XysKpiObjLibBO lib = xysKpiDeptUCC.findXysKpiObjLibBOById(libId);
			List list = xysKpiDeptUCC.getXysKpiObjKeyBOByObjId(lib.getObjId());
			double weight = 0;
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					XysKpiObjKeyBO bo = (XysKpiObjKeyBO) list.get(i);
					if (method.equals("add")
							|| (method.equals("update") && !bo.getObjKeyId()
									.equals(keyBo.getObjKeyId()))) {
						weight += Double.parseDouble(CommonFuns
								.filterNullToZero(bo.getWeight()));
					}
				}
			}
			weight += Double.parseDouble(CommonFuns.filterNullToZero(keyBo
					.getWeight()));
			if (weight > 100) {
				super.showMessageDetail("权重和不能超过100");
				return "";
			} else {
				keyBo.setObjLibId(libId);
				keyBo.setObjId(lib.getObjId());
				xysKpiDeptUCC.saveXysKpiObjKeyBO(keyBo);
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
				method = "add";
			} else if (super.getRequestParameter("keyId") != null) {
				keyId = super.getRequestParameter("keyId");
				keyBo = xysKpiDeptUCC.findXysKpiObjKeyBOById(keyId);
				libId = keyBo.getObjLibId();
				method = "update";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initKey;
	}

	public void setInitKey(String initKey) {
		this.initKey = initKey;
	}

	public XysKpiObjKeyBO getKeyBo() {
		return keyBo;
	}

	public void setKeyBo(XysKpiObjKeyBO keyBo) {
		this.keyBo = keyBo;
	}

	public String saveLib() {
		try {
			libB0.setObjId(objId);
			xysKpiDeptUCC.saveXysKpiObjLibBO(libB0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String getInitLibEdit() {
		try {
			if (super.getRequestParameter("libId") != null) {
				libId = super.getRequestParameter("libId");
				libB0 = xysKpiDeptUCC.findXysKpiObjLibBOById(libId);
				objId = libB0.getObjId();
			} else if (super.getRequestParameter("objId") != null) {
				objId = super.getRequestParameter("objId");
				libB0.initRow();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initLibEdit;
	}

	public void setInitLibEdit(String initLibEdit) {
		this.initLibEdit = initLibEdit;
	}

	public XysKpiObjLibBO getLibB0() {
		return libB0;
	}

	public void setLibB0(XysKpiObjLibBO libB0) {
		this.libB0 = libB0;
	}

	public String deleteLib() {
		try {
			List list = xysKpiDeptUCC.getXysKpiObjKeyBOByLibId(libId);
			if (list != null && list.size() > 0) {
				super.showMessageDetail("该指标包含子指标无法删除！");
			} else {
				xysKpiDeptUCC.deleteXysKpiObjLibBO(libId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getInitLib() {
		try {
			if (super.getRequestParameter("objId") != null) {
				objId = super.getRequestParameter("objId");
				XysKpiDeptObjBO obj = xysKpiDeptUCC
						.findXysKpiDeptObjBOById(objId);
				XysKpiPersonObjBO obj2 = xysKpiPersonUCC
						.findXysKpiPersonObjBOById(objId);
				if (obj != null) {
					if (obj.getKeyStatus().equals("3")) {
						disabled = true;
					} else {
						disabled = false;
					}
				}
				if (obj2 != null) {
					if (obj2.getKeyStatus().equals("3")) {
						disabled = true;
					} else {
						disabled = false;
					}
				}
				super.getHttpSession().setAttribute("objId", objId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initLib;
	}

	public void setInitLib(String initLib) {
		this.initLib = initLib;
	}

	public void queryKey() {
		try {
			XysKpiObjLibBO lib = this.xysKpiDeptUCC
					.findXysKpiObjLibBOById(libId);
			if (lib != null) {
				XysKpiDeptObjBO obj = xysKpiDeptUCC.findXysKpiDeptObjBOById(lib
						.getObjId());
				XysKpiPersonObjBO obj2 = xysKpiPersonUCC
						.findXysKpiPersonObjBOById(lib.getObjId());
				if (obj != null) {
					if (obj.getKeyStatus().equals("3")) {
						disabled = true;
					} else {
						disabled = false;
					}
				}
				if (obj2 != null) {
					if (obj2.getKeyStatus().equals("3")) {
						disabled = true;
					} else {
						disabled = false;
					}
				}
			}

			keyList = xysKpiDeptUCC.getXysKpiObjKeyBOByLibId(libId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getInitKeyList() {
		if (super.getRequestParameter("libId") != null) {
			libId = super.getRequestParameter("libId");
		}
		queryKey();
		return initKeyList;
	}

	public void setInitKeyList(String initKeyList) {
		this.initKeyList = initKeyList;
	}

	public String getLibId() {
		return libId;
	}

	public void setLibId(String libId) {
		this.libId = libId;
	}

	public List getKeyList() {
		return keyList;
	}

	public void setKeyList(List keyList) {
		this.keyList = keyList;
	}
}
