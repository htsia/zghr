package com.hr319wg.xys.eva.web;

import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.XysEvaRoleBO;
import com.hr319wg.xys.eva.ucc.IRelSetUCC;
import com.hr319wg.xys.eva.ucc.IXys360TempUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaRoleUCC;

public class XysEvaRoleBackBean extends BaseBackingBean {
	private IXysEvaRoleUCC xysEvaRoleUcc;
	private IXys360TempUCC xys360TempUCC;
	private IRelSetUCC relSetUCC;
	private String pageInit;
    private PageVO mypage = new PageVO();
    private List roleList;
    private String roleId;
    private String templateId;
    
    
    public IRelSetUCC getRelSetUCC() {
		return relSetUCC;
	}
	public void setRelSetUCC(IRelSetUCC relSetUCC) {
		this.relSetUCC = relSetUCC;
	}
	public String selTemplate(){
    	try{
    		XysEvaRoleBO role=xysEvaRoleUcc.findXysEvaRoleBOById(roleId);
    		role.setTemplate360(templateId);
    		xysEvaRoleUcc.saveXysEvaRoleBO(role);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return "";
    }
    public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	public String deleteRole(){
    	try{
    		xysEvaRoleUcc.deleteXysEvaRoleBO(roleId);
    		List list=relSetUCC.getXysPostRoleRelBOByRoleId(roleId);
    		if(list!=null&&list.size()>0){
    			xysEvaRoleUcc.deletAll(list);
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return "";
    }
	public IXys360TempUCC getXys360TempUCC() {
		return xys360TempUCC;
	}
	public void setXys360TempUCC(IXys360TempUCC xys360TempUCC) {
		this.xys360TempUCC = xys360TempUCC;
	}
	public IXysEvaRoleUCC getXysEvaRoleUcc() {
		return xysEvaRoleUcc;
	}
	public void setXysEvaRoleUcc(IXysEvaRoleUCC xysEvaRoleUcc) {
		this.xysEvaRoleUcc = xysEvaRoleUcc;
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
    public void doQuery(){
    	try{
    		if(mypage.getCurrentPage()==0){
                mypage.setCurrentPage(1);
            }
    		roleList=xysEvaRoleUcc.getXysEvaRoleBOByOrgId(mypage,super.getUserInfo().getOrgId());
    		if(roleList!=null&&roleList.size()>0){
    			for(int i=0;i<roleList.size();i++){
    				XysEvaRoleBO role=(XysEvaRoleBO)roleList.get(i);
    				role.setCreateOrg(SysCacheTool.findOrgById(role.getCreateOrg()).getName());
    				role.setCreatePid(SysCacheTool.findPersonById(role.getCreatePid()).getName());
    				if(role.getTemplate360()!=null&&!role.getTemplate360().equals("")){
    					role.setTemplate360(this.xys360TempUCC.findXys360TempBO(role.getTemplate360()).getTempName());
    				}
    				roleList.set(i,role);
    			}
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }
	public String getPageInit() {
		 doQuery();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	
	public List getRoleList() {
		return roleList;
	}
	public void setRoleList(List roleList) {
		this.roleList = roleList;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
    
	//编辑角色
	private String initEdit;
	private XysEvaRoleBO roleBo=new XysEvaRoleBO();
	
	public String saveRole(){
		try{
			double setkpi=Double.parseDouble(CommonFuns.filterNullToZero(roleBo.getWeightKpi()));
			double set360=Double.parseDouble(CommonFuns.filterNullToZero(roleBo.getWeight360()));
			double setXspj=Double.parseDouble(CommonFuns.filterNullToZero(roleBo.getWeightXspj()));
			double weight=setkpi+set360+setXspj;
			if(weight==100){
				roleBo.setCreateOrg(super.getUserInfo().getOrgId());
				roleBo.setCreatePid(super.getUserInfo().getUserId());
				roleBo.setCreateTime(CommonFuns.getSysDate("yyyy-MM-dd"));
				xysEvaRoleUcc.saveXysEvaRoleBO(roleBo);
			}else{
				super.showMessageDetail("权重和必须为100，请重新设置权重！");
				return "";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getInitEdit() {
		try{
			if(super.getRequestParameter("superId")!=null){
				roleBo.initRow();
			}else if(super.getRequestParameter("roleId")!=null){
				roleId=super.getRequestParameter("roleId");
				roleBo=xysEvaRoleUcc.findXysEvaRoleBOById(roleId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}
	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	public XysEvaRoleBO getRoleBo() {
		return roleBo;
	}
	public void setRoleBo(XysEvaRoleBO roleBo) {
		this.roleBo = roleBo;
	}
    
}
