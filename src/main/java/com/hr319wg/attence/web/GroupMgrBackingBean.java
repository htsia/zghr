package com.hr319wg.attence.web;


import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.ATTRearrangeBO;
import com.hr319wg.attence.pojo.bo.ATTRearrangeDateBO;
import com.hr319wg.attence.pojo.bo.AttClassBO;
import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class GroupMgrBackingBean extends BaseBackingBean {
	private IAttenceSetUCC attenceSetUCC;
	private AttClassGroupBO groupbo = new AttClassGroupBO();
	private String initset;
	private String status = "1";
	private String superName;
	private String superId = super.getUserInfo().getOrgId();
	private String className;
	private String groupID;
	private boolean isExist = true;
	private boolean isExist1 = true;
	
	public boolean getIsExist() {
		return isExist;
	}

	public void setExist(boolean isExist) {
		this.isExist = isExist;
	}
	public boolean getIsExist1() {
		return isExist1;
	}

	public void setExist1(boolean isExist1) {
		this.isExist1 = isExist1;
	}
	public String getGroupID() {
		return groupID;
	}

	public void setGroupID(String groupID) {
		this.groupID = groupID;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.superId);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public String getInitset() {
		try {
			if (super.getRequestParameter("TypeID") != null
					&& !super.getRequestParameter("TypeID").equals("")) {
				String id = super.getRequestParameter("TypeID");
				groupbo = attenceSetUCC.findAttClassGroupBObyId(id);
				if(groupbo!=null){
				status = groupbo.getGroupType();
				if (groupbo.getLinkClass() != null
						&& !"".equals(groupbo.getLinkClass())) {
					if(!"1".equals(groupbo.getLinkClass())){
						AttClassBO attClassBO = attenceSetUCC
								.findAttClassBObyId(groupbo.getLinkClass());
						className = attClassBO.getClassName();
						}else{
							className="休息";
						}
					isExist = true;
					isExist1 = true;
				} else {
					if(!"4".equals(groupbo.getGroupType())){
						isExist = false;
						isExist1 = true;
					}else{
						isExist = false;
						isExist1 = false;
					}
				}
				}
			}else if(super.getRequestParameter("okID") != null ){
				groupbo.setGroupNo(null);
				groupbo.setGroupName("");
				groupbo.setOrgID("");
				groupbo.setBeginDate("");
				groupbo.setGroupPeriod("");
				groupbo.setGroupType("");
				groupbo.setLinkClass("");
				
			}
		} catch (SysException e) {
		}
		return initset;
	}

	public void setInitset(String initset) {
		this.initset = initset;
	}

	public AttClassGroupBO getGroupbo() {
		return groupbo;
	}

	public void setGroupbo(AttClassGroupBO groupbo) {
		this.groupbo = groupbo;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String SaveSet() {
		if(groupbo.getLinkClass()!=null && !"".equals(groupbo.getLinkClass())){
		groupbo.setOrgID(this.superId);
		groupbo.setGroupType(this.status);
		try {
			attenceSetUCC.saveorupdateAttClassGroupBO(groupbo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		}else{
			super.showMessageDetail("请输入班次信息！");
			return "";
		}
		return "success";
	}

	public String SaveSet1() {
		if(groupbo.getGroupPeriod()==null || "".equals(groupbo.getGroupPeriod())){
			super.showMessageDetail("周期班周期数不能为空！");
			return "";
		}
		if(groupbo.getBeginDate()==null || "".equals(groupbo.getBeginDate())){
			super.showMessageDetail("倒班起点日期不能为空！");
			return "";
		}
		groupbo.setOrgID(this.superId);
		groupbo.setGroupType(this.status);
		try {
			attenceSetUCC.saveorupdateAttClassGroupBO(groupbo);						
			//倒班情况记录数目的确定
			List names=attenceSetUCC.getATTRearrangeBO(groupbo.getGroupNo());
			if(names!=null && names.size()>0){
				String num1 = groupbo.getGroupPeriod();
				int num2 = Integer.parseInt(num1);
				int[] nums =new int[names.size()];
				for(int m=0;m<names.size();m++){
					ATTRearrangeBO attrearrangeBO=(ATTRearrangeBO)names.get(m);
					String seqs=attrearrangeBO.getDaySeq();
					nums[m]=Integer.parseInt(seqs);
				}
				if(nums!=null && nums.length>0){
					for(int i=0;i<nums.length;i++){
				        for(int j=i+1;j<nums.length;j++){
				           if(nums[i] < nums[j]){
				              int tem = nums[i];
				              nums[i] = nums[j];
				              nums[j] = tem;
				           }
				        }
				     }
					if(nums[0]<num2){
						for (int n=nums[0]+1;n<=num2;n++) {
							ATTRearrangeBO bo = new ATTRearrangeBO();
							bo.setGroupNo(groupbo.getGroupNo());
							bo.setDaySeq(n+ "");
							attenceSetUCC.saveATTRearrangeBO(bo);
						 }
					}else{
						for(int h=num2+1;h<=nums[0];h++){
							String h1=h+"";
						List names1=attenceSetUCC.findATTRearrangeBO1(groupbo.getGroupNo(),h1);
						ATTRearrangeBO attrearrangeBO2=(ATTRearrangeBO)names1.get(0);
						attenceSetUCC.deleteATTRearrangeBO1(attrearrangeBO2.getRearrangeNo());
						}
				   }
				}
			}else{
			  String num = groupbo.getGroupPeriod();
			  if (num != null && !"".equals(num)) {
				int nums = Integer.parseInt(num);
				for (int j = 1; j <= nums; j++) {
					ATTRearrangeBO bo = new ATTRearrangeBO();
					bo.setGroupNo(groupbo.getGroupNo());
					bo.setDaySeq(j + "");
					attenceSetUCC.saveATTRearrangeBO(bo);
				 }
			   }
			}
			//记录日志
			if(groupbo!=null){
			ATTRearrangeDateBO rearrangeDateBO=new ATTRearrangeDateBO();
			rearrangeDateBO.setGroupNo(groupbo.getGroupNo());
			rearrangeDateBO.setBeginDate(groupbo.getBeginDate());
			attenceSetUCC.saveATTRearrangeDateBO(rearrangeDateBO);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String SaveSet2() {
		groupbo.setOrgID(this.superId);
		groupbo.setGroupType(this.status);
		try {
			attenceSetUCC.saveorupdateAttClassGroupBO(groupbo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public String DeleteType() {
		try {
			String  strs=attenceSetUCC.findCountAttClassGroupVO(this.groupID);
			if(!"0".equals(strs)){
              super.showMessageDetail("该班组下面有人，不能删除！");
              return "";
			}
			attenceSetUCC.deleteAttClassGroupBO(this.groupID);
			this.groupID="";
		} catch (Exception e) {

		}
		return "";
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void changeStatus(ValueChangeEvent event) {
		this.status = event.getNewValue().toString();
		if ("1".equals(this.status)) {
			isExist = true;
			isExist1 = true;
		}
		if ("2".equals(this.status)) {
			isExist = false;
			isExist1 = true;
		}
		if ("3".equals(this.status)) {
			isExist = true;
			isExist1 = true;
		}
		if ("4".equals(this.status)) {
			isExist = false;
			isExist1 = false;
		}
	}

}
