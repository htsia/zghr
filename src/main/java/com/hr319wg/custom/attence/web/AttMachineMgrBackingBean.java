package com.hr319wg.custom.attence.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.attence.pojo.bo.AttMachineBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.custom.util.ZKEMDetailService;

public class AttMachineMgrBackingBean extends BaseBackingBean {
	private PageVO mypage = new PageVO();
	private String pageInit;
	private String EditInit;
	private String machineType;
	private String operMachineID;
	private String operStatus;
	private AttMachineBO bo;
	private List<AttMachineBO> list;
	private Map detailMap=new HashMap();
	private int currPage;
	private int totalPage;
	private int totalNum;
	private String operMachineIP;
	private String selectedMachineIPs;
	private IAttBusiService attBusiService;
	private Map countInfoMap;

	public Map getDetailMap() {
		return detailMap;
	}

	public void setDetailMap(Map detailMap) {
		this.detailMap = detailMap;
	}

	public Map getCountInfoMap() {
		return countInfoMap;
	}

	public void setCountInfoMap(Map countInfoMap) {
		this.countInfoMap = countInfoMap;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}

	public String getOperMachineIP() {
		return operMachineIP;
	}

	public void setOperMachineIP(String operMachineIP) {
		this.operMachineIP = operMachineIP;
	}

	public String getSelectedMachineIPs() {
		return selectedMachineIPs;
	}

	public void setSelectedMachineIPs(String selectedMachineIPs) {
		this.selectedMachineIPs = selectedMachineIPs;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getOperStatus() {
		return operStatus;
	}

	public void setOperStatus(String operStatus) {
		this.operStatus = operStatus;
	}

	public String getMachineType() {
		return machineType;
	}

	public void setMachineType(String machineType) {
		this.machineType = machineType;
	}

	public String getOperMachineID() {
		return operMachineID;
	}

	public void setOperMachineID(String operMachineID) {
		this.operMachineID = operMachineID;
	}

	public String first() {
		mypage.setCurrentPage(1);
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return "";
	}
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	public AttMachineBO getBo() {
		return bo;
	}
	public void setBo(AttMachineBO bo) {
		this.bo = bo;
	}

	public List<AttMachineBO> getList() {
		return list;
	}

	public void setList(List<AttMachineBO> list) {
		this.list = list;
	}

	public String getPageInit() {
		this.operMachineIP=null;
		this.selectedMachineIPs=null;
		String machineType1 = super.getRequestParameter("machineType");
		if(machineType1!=null && !"".equals(machineType1)){
			this.machineType="1";
		}
		doQuery();		
		return pageInit;
	}
	
	public String getEditInit() {
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			bo = new AttMachineBO();
			this.operStatus=null;
		}
		String machineID = super.getRequestParameter("machineID");
		if(machineID!=null){
			try {
				bo = (AttMachineBO)this.attBusiService.findBOById(AttMachineBO.class, machineID);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		return EditInit;
	}
	public void setEditInit(String editInit) {
		EditInit = editInit;
	}
	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}
	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}
	
	public void doQuery(){
		try {
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			list = this.attBusiService.getAllMachineBO(mypage, this.machineType);
			if(list==null){
				list = new ArrayList();
			}
			for(AttMachineBO bo : list){
				Iterator it = detailMap.keySet().iterator();
				while(it.hasNext()){
					String ip = it.next().toString();
					if(bo.getMachineIP().equals(ip)){
						Map m = (Map)detailMap.get(ip);
						boolean isConn = Boolean.valueOf(m.get("isCon").toString());
						if(!isConn){
							bo.setStatus("连接失败");
							bo.setLog(null);
							bo.setManager(null);
							bo.setUser(null);
							bo.setFinger(null);
							bo.setPassword(null);
						}else{
							bo.setStatus("连接成功");
							bo.setLog(m.get("log").toString());
							bo.setManager(m.get("manager").toString());
							bo.setUser(m.get("user").toString());
							bo.setFinger(m.get("finger").toString());
							bo.setPassword(m.get("password").toString());
						}						
						break;
					}
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public void save(){
		String msg="保存成功";
		if(bo.getMachineID()==null){
			if("0".equals(bo.getMachineType())){
				try {
					List<AttMachineBO> masterList =this.attBusiService.getMasterMachine();
					if(masterList!=null && masterList.size()>0){
						AttMachineBO mBo = masterList.get(0);
						mBo.setMachineType("1");
						this.attBusiService.saveOrUpdateBO(mBo);
						msg+=",原主考勤机是"+mBo.getMachineName();
					}
					this.attBusiService.saveOrUpdateBO(bo);
					this.operStatus=msg;
					
				} catch (SysException e) {
					e.printStackTrace();
				}
			}else{
				try {
					this.attBusiService.saveOrUpdateBO(bo);
					this.operStatus=msg;
				} catch (SysException e) {
					e.printStackTrace();
				}
			}
		}else{
			if("0".equals(bo.getMachineType())){
				try {
					List<AttMachineBO> masterList =this.attBusiService.getMasterMachineExcludeSelf(bo.getMachineIP());
					if(masterList!=null && masterList.size()>0){
						AttMachineBO mBo = masterList.get(0);
						mBo.setMachineType("1");
						this.attBusiService.saveOrUpdateBO(mBo);
						msg+=",原主考勤机是"+mBo.getMachineName();
					}
					this.attBusiService.saveOrUpdateBO(bo);
					this.operStatus=msg;
				} catch (SysException e) {
					e.printStackTrace();
				}
			}else{
				try {
					this.attBusiService.saveOrUpdateBO(bo);
					this.operStatus=msg;
				} catch (SysException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public void delete(){
		if(this.operMachineID!=null){
			try {
				this.attBusiService.deleteBO(AttMachineBO.class, this.operMachineID);
				this.operMachineID=null;
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
	}

	public void first1() {
		this.currPage=1;
	}

	public void pre1() {
		if (this.currPage > 1) {
			this.currPage--;
		}
	}

	public void next1() {
		if (this.currPage < this.totalPage) {
			this.currPage++;
		}
	}

	public void last1() {
		this.currPage=this.totalPage;
	}
	
	//下载指定ip考勤机所有考勤记录
	public void downloadLog(){
		try {
			if(this.operMachineIP!=null){//读取单个考勤机打卡记录
				List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.operMachineIP);
				if(mList!=null && mList.size()>0){
					String msg = this.attBusiService.downloadLog(super.getUserInfo().getOrgId(), mList);
					super.showMessageDetail(msg);
				}			
			}else{
				@SuppressWarnings("unchecked")
				List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.selectedMachineIPs);
				if(mList!=null && mList.size()>0){
					String msg = this.attBusiService.downloadLog(super.getUserInfo().getOrgId(), mList);
					super.showMessageDetail(msg);
				}else{
					super.showMessageDetail("请添加考勤机");
				}				
				this.selectedMachineIPs=null;
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//清除指定ip考勤机所有用户信息包括指纹
	public void clearUserInfo(){
		try {
			if(this.operMachineIP!=null){//清除单个考勤机指纹信息
				List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.operMachineIP);
				if(mList!=null && mList.size()>0){
					String msg = this.attBusiService.clearData(mList, "5");
					if(msg!=null && !"".equals(msg)){
						super.showMessageDetail(msg);
					}else{
						super.showMessageDetail("清除完成");
					}
				}
			}else{
				List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.selectedMachineIPs);
				if(mList!=null && mList.size()>0){
					String msg = this.attBusiService.clearData(mList, "5");
					if(msg!=null && !"".equals(msg)){
						super.showMessageDetail(msg);
					}else{
						super.showMessageDetail("清除完成");
					}
				}else{
					super.showMessageDetail("请添加考勤机");
				}
				this.selectedMachineIPs=null;
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//清除指定ip考勤机所有考勤记录
	public void clearLog(){
		try {
			if(this.operMachineIP!=null){//清除单个考勤机打卡记录
				List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.operMachineIP);
				if(mList!=null && mList.size()>0){
					String msg = this.attBusiService.clearLog(mList);
					if(msg!=null && !"".equals(msg)){
						super.showMessageDetail(msg);
					}else{
						super.showMessageDetail("清除完成");
					}
				}
			}else{
				List<AttMachineBO> mList = this.attBusiService.getAllMachineBOByIPs(this.selectedMachineIPs);
				if(mList!=null && mList.size()>0){
					String msg = this.attBusiService.clearLog(mList);
					if(msg!=null && !"".equals(msg)){
						super.showMessageDetail(msg);
					}else{
						super.showMessageDetail("清除完成");
					}
				}else{
					super.showMessageDetail("请添加考勤机");
				}
				this.selectedMachineIPs=null;
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	//读取考勤机详细信息
	public void machineDetail(){
		try {
			String msg = ZKEMDetailService.init();
			if(msg!=null){
				super.showMessageDetail(msg);
			}else{
				String[]ips=this.selectedMachineIPs.split(",");
				List<ZKEMDetailService> list = new ArrayList<ZKEMDetailService>();
				//创建线程
				for(int i=0;i<ips.length;i++){
					ZKEMDetailService z = new ZKEMDetailService();
					z.setIP(ips[i]);
					list.add(z);
				}
				//启动线程
				for(ZKEMDetailService z : list){
					z.start();
				}
//				//跟踪线程
				boolean isEnd=false;
				while(!isEnd){
					int i=0;
					for(ZKEMDetailService z : list){
						boolean alive = z.isAlive();
						if(!alive){
							this.detailMap.put(z.getIP(), z.getMap());
							i++;
							if(i==list.size()){
								isEnd=true;
							}
						}
					}
				}
				//else-end
			}
		} catch (SysException e) {
			
			e.printStackTrace();
		}
	}
}
