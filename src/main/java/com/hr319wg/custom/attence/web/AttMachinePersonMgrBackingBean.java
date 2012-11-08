package com.hr319wg.custom.attence.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttFingerBO;
import com.hr319wg.custom.attence.pojo.bo.AttMachineBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.util.CommonUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;

public class AttMachinePersonMgrBackingBean extends BaseBackingBean {
	private PageVO pagevo = new PageVO();
	private String pageInit;
	private String pageManyInit;
	private String EditInit;
	private String setPwdInit;
	private String operUserID;
	private String selectPersonNames;
	private String orgID;
	private String IPStr;
	private String pwd;
	private String nameStr;
	private String personType;
	private String personTypeValue;
	private boolean collected=true;
	private boolean uncollected=true;
	private boolean hasPwd=true;
	private boolean notHasPwd=true;
	private List<AttFingerBO> list;
	private IAttBusiService attBusiService;
	private UserAPI userapi;
	
	public String getPageManyInit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			this.operUserID=null;
			this.selectPersonNames=null;
			this.IPStr=null;			
		}
		return pageManyInit;
	}

	public String getSelectPersonNames() {
		return selectPersonNames;
	}

	public void setSelectPersonNames(String selectPersonNames) {
		this.selectPersonNames = selectPersonNames;
	}

	public boolean isHasPwd() {
		return hasPwd;
	}

	public void setHasPwd(boolean hasPwd) {
		this.hasPwd = hasPwd;
	}

	public boolean isNotHasPwd() {
		return notHasPwd;
	}

	public void setNotHasPwd(boolean notHasPwd) {
		this.notHasPwd = notHasPwd;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}

	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}

	public List<AttFingerBO> getList() {
		return list;
	}

	public String getIPStr() {
		return IPStr;
	}

	public void setIPStr(String iPStr) {
		IPStr = iPStr;
	}

	public void setList(List<AttFingerBO> list) {
		this.list = list;
	}

	public UserAPI getUserapi() {
		return userapi;
	}

	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}


	public String first() {
		pagevo.setCurrentPage(1);
		return "";
	}

	public String pre() {
		if (pagevo.getCurrentPage() > 1) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() - 1);
		}
		return "";
	}

	public String next() {
		if (pagevo.getCurrentPage() < pagevo.getTotalPage()) {
			pagevo.setCurrentPage(pagevo.getCurrentPage() + 1);
		}
		return "";
	}

	public String last() {
		pagevo.setCurrentPage(pagevo.getTotalPage());
		return "";
	}

	public PageVO getPagevo() {
		return pagevo;
	}
	public void setPagevo(PageVO pagevo) {
		this.pagevo = pagevo;
	}
	public String getOperUserID() {
		return operUserID;
	}
	public void setOperUserID(String operUserID) {
		this.operUserID = operUserID;
	}
	public String getOrgID() {
		return orgID;
	}
	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}
	public String getNameStr() {
		return nameStr;
	}
	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}
	public String getPersonType() {
		return personType;
	}
	public void setPersonType(String personType) {
		this.personType = personType;
	}
	public String getPersonTypeValue() {
		return personTypeValue;
	}
	public void setPersonTypeValue(String personTypeValue) {
		this.personTypeValue = personTypeValue;
	}
	public boolean isCollected() {
		return collected;
	}
	public void setCollected(boolean collected) {
		this.collected = collected;
	}
	public boolean isUncollected() {
		return uncollected;
	}
	public void setUncollected(boolean uncollected) {
		this.uncollected = uncollected;
	}
	public void doCollected(ValueChangeEvent event) {
		collected = event.getNewValue().toString().equals("true");
	}
	public void doUncollected(ValueChangeEvent event) {
		uncollected = event.getNewValue().toString().equals("true");
	}
	public void doHasPwd(ValueChangeEvent event) {
		hasPwd = event.getNewValue().toString().equals("true");
	}
	public void doNotHasPwd(ValueChangeEvent event) {
		notHasPwd = event.getNewValue().toString().equals("true");
	}

	public String getPageInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr=null;
			this.personType=null;
			this.collected=true;
			this.uncollected=true;
			this.hasPwd=true;
			this.notHasPwd=true;
			this.operUserID=null;
		}
		String orgID1 = super.getRequestParameter("orgID");
		if(orgID1!=null && !"".equals(orgID1)){
			this.orgID=orgID1;
		}
		doQuery();
		return null;
	}
	public String getEditInit() {
		return EditInit;
	}
	public void setEditInit(String editInit) {
		EditInit = editInit;
	}
	public String getSetPwdInit() {
		String userID1 = super.getRequestParameter("userID");
		if(userID1!=null && !"".equals(userID1)){
			this.operUserID = userID1;
		}
		return setPwdInit;
	}
	
	public void doQuery(){
		if(this.personType==null || "".equals(this.personType)){
			try {
				this.personType=CommonUtil.getAllPersonTypes(super.getUserInfo());
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		if (pagevo.getCurrentPage() == 0) {
			pagevo.setCurrentPage(1);
		}
		try {
			List list1 = this.attBusiService.getAllFingerBO(pagevo, orgID, nameStr, personType, collected, uncollected, hasPwd, notHasPwd);
			if(list1==null){
				list1 = new ArrayList();
			}
			list = new ArrayList();
			for(int i=0;i<list1.size();i++){
				Object[]obj = (Object[])list1.get(i);
				AttFingerBO bo = (AttFingerBO)obj[0];
				PersonBO p = SysCacheTool.findPersonById(bo.getID());
				bo.setName(p.getName());
				bo.setSex(CodeUtil.interpertCode(p.getSex()));
				bo.setPersonCode(p.getPersonCode());
				bo.setPersonTypeName(CodeUtil.interpertCode(p.getPersonType()));
			    bo.setSecDeptName(CodeUtil.interpertCode(obj[1].toString()));
				bo.setDeptName(CodeUtil.interpertCode(CodeUtil.TYPE_ORG, p.getDeptId()));
				int count = 0;
				if(bo.getFinger0()!=null && !"".equals(bo.getFinger0())){
					count++;
				}
				if(bo.getFinger1()!=null && !"".equals(bo.getFinger1())){
					count++;
				}
				if(bo.getFinger2()!=null && !"".equals(bo.getFinger2())){
					count++;
				}
				if(bo.getFinger3()!=null && !"".equals(bo.getFinger2())){
					count++;
				}
				if(bo.getFinger4()!=null && !"".equals(bo.getFinger4())){
					count++;
				}
				if(bo.getFinger5()!=null && !"".equals(bo.getFinger5())){
					count++;
				}
				if(bo.getFinger6()!=null && !"".equals(bo.getFinger6())){
					count++;
				}
				if(bo.getFinger7()!=null && !"".equals(bo.getFinger7())){
					count++;
				}
				if(bo.getFinger8()!=null && !"".equals(bo.getFinger8())){
					count++;
				}
				if(bo.getFinger9()!=null && !"".equals(bo.getFinger9())){
					count++;
				}
				bo.setFingerCount(count+"");
				list.add(bo);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//上传指纹信息
	public void upload(){
		try {
			if(this.operUserID!=null){
				List<AttMachineBO> mList = this.attBusiService.getMasterMachine();
				if(mList.size()==1){
					String err = this.attBusiService.uploadInfoToZKEM(mList, this.operUserID);
					if(err!=null && err.length()>0){
						super.showMessageDetail(err);
					}else{
						super.showMessageDetail("上传完成");
					}
				}else{
					super.showMessageDetail("请设置主考勤机");
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//采集指纹信息
	public void collect(){
		try {
			int count = this.attBusiService.getMasterMachineCount();
			if(count==1){
				List list = this.attBusiService.getMasterMachineIPs("0");
				Map map = (Map)list.get(0);
				if(this.operUserID==null){
					String err = this.attBusiService.batchDownloadInfoFromZKEM(map.get("machine_ip").toString());
					if(err!=null && err.length()>0){
						super.showMessageDetail(err);
					}else{
						super.showMessageDetail("采集完成");
					}
				}else{
					PersonBO p = SysCacheTool.findPersonById(this.operUserID);
					String err = this.attBusiService.downloadInfoFromZKEMByPersonCode(map.get("machine_ip").toString(), p.getPersonCode());
					this.operUserID=null;
					if(err!=null && err.length()>0){
						super.showMessageDetail(err);
					}else{
						super.showMessageDetail("采集完成");
					}
				}
			}else{
				super.showMessageDetail("请设置主考勤机");
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
//	分发用户信息包括指纹
	public String issue(){
		try {
			List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.IPStr);
			String err = this.attBusiService.uploadInfoToZKEM(mList, operUserID);
			if(!"".equals(err)){
				super.showMessageDetail(err);
			}else{
				super.showMessageDetail("分发完成");
			}
		} catch (SysException e) {
			super.showMessageDetail("分发失败");
			e.printStackTrace();
		}
		return null;
	}
//	//分发用户信息包括指纹
//	public String issue(){
//		try {
//			if(this.operUserID==null){//分发所有用户信息
//				List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.IPStr);
//				if(mList!=null){
//					try {
//						ZKEMService.setOperUserID(null);
//						String msg1 = ZKEMService.init();
//						if(msg1!=null){
//							super.showMessageDetail(msg1);
//						}else{
//							List<ZKEMService> list = new ArrayList<ZKEMService>();
//							//创建线程
//							for(AttMachineBO bo : mList){
//								ZKEMService z = new ZKEMService();
//								z.setIP(bo.getMachineIP());
//								z.setMachineName(bo.getMachineName());
//								list.add(z);
//							}
//							//启动线程
//							for(ZKEMService z : list){
//								z.start();
//							}
//							//跟踪线程
//							Map msgMap = new HashMap();
//							boolean isEnd=false;
//							while(!isEnd){
//								int i=0;
//								for(ZKEMService z : list){
//									boolean alive = z.isAlive();
//									if(!alive){
//										if(!"".equals(z.getErrMsg()) || !"".equals(z.getErrUser())){
//											if(!msgMap.containsKey(z)){
//												msgMap.put(z, z.getErrMsg());																
//											}
//										}
//										i++;
//										if(i==list.size()){
//											isEnd=true;
//										}
//									}
//								}
//							}
//							if(msg!=null && msgMap.size()>0){
//								String msg2 ="以下考勤机：";
//								Iterator it = msgMap.keySet().iterator();
//								while(it.hasNext()){
//									msg2 += msgMap.get(it.next());
//									if(it.hasNext()){
//										msg2+=",";
//									}
//								}
//								msg2+="连接失败";
//								super.showMessageDetail(msg2);
//							}else{
//								super.showMessageDetail("分发完成");
//							}
//							//else-end
//						}
//					} catch (SysException e) {
//						e.printStackTrace();
//					}
//				}
//			}else{//分发单个用户信息
//				PersonBO p = SysCacheTool.findPersonById(this.operUserID);
//				@SuppressWarnings("unchecked")
//				List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.IPStr);
//				if(mList!=null){
//					try {
//						ZKEMService.setOperUserID(this.operUserID);
//						String msg1 = ZKEMService.init();
//						if(msg1!=null){
//							super.showMessageDetail(msg1);
//						}else{
//							List<ZKEMService> list = new ArrayList<ZKEMService>();
//							//创建线程
//							for(AttMachineBO bo : mList){
//								ZKEMService z = new ZKEMService();
//								z.setIP(bo.getMachineIP());
//								z.setMachineName(bo.getMachineName());
//								list.add(z);
//							}
//							//启动线程
//							for(ZKEMService z : list){
//								z.start();
//							}
//							//跟踪线程
//							Map msgMap = new HashMap();
//							boolean isEnd=false;
//							while(!isEnd){
//								int i=0;
//								for(ZKEMService z : list){
//									boolean alive = z.isAlive();
//									if(!alive){
//										if(!"".equals(z.getErrMsg()) || !"".equals(z.getErrUser())){
//											msgMap.put(z, z.getErrMsg());				
//										}
//										i++;
//										if(i==list.size()){
//											isEnd=true;
//										}
//									}
//								}
//							}
//							if(msg!=null && msgMap.size()>0){
//								String msg2 ="以下考勤机：";
//								Iterator it = msgMap.keySet().iterator();
//								while(it.hasNext()){
//									msg2 += msgMap.get(it.next());
//									if(it.hasNext()){
//										msg2+=",";
//									}
//								}
//								msg2+="连接失败";
//								super.showMessageDetail(msg2);
//							}else{
//								super.showMessageDetail("分发完成");
//							}
//							//else-end
//						}
//					} catch (SysException e) {
//						e.printStackTrace();
//					}
//				}
//				ZKEMService.setOperUserID(null);
//				this.operUserID=null;
//			}
//		} catch (SysException e) {
//			e.printStackTrace();
//		}
//		return null;
//	}
	
	//设置管理员
	public void setManger(){
		try {
			AttFingerBO bo = (AttFingerBO)this.attBusiService.findBOById(AttFingerBO.class, this.operUserID);
			bo.setPrivilege("3");
			this.attBusiService.saveOrUpdateBO(bo);
			super.showMessageDetail("设置完成");
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//取消管理员
	public void cancelManger(){
		try {
			AttFingerBO bo = (AttFingerBO)this.attBusiService.findBOById(AttFingerBO.class, this.operUserID);
			bo.setPrivilege("0");
			this.attBusiService.saveOrUpdateBO(bo);
			super.showMessageDetail("取消完成");
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//设置密码
	public String setPwd(){
		try {
			AttFingerBO bo = (AttFingerBO)this.attBusiService.findBOById(AttFingerBO.class, this.operUserID);
			bo.setPassword(this.pwd);
			this.attBusiService.saveOrUpdateBO(bo);
			return "success";
		} catch (SysException e) {
			e.printStackTrace();
		}
		return EditInit;
	}
	public void selPerson(){
		if(this.operUserID!=null && !"".equals(this.operUserID)){
			String[]userIDs=this.operUserID.split(",");
			for(int i=0;i<userIDs.length;i++){
				PersonBO p = SysCacheTool.findPersonById(userIDs[i]);
				this.selectPersonNames+=p.getName();
				if(i!=userIDs.length){
					this.selectPersonNames+=",";
				}
			}
		}
	}
}
