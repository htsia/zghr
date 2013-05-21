package com.hr319wg.custom.extend.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.emp.pojo.bo.ChangeInfoBO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.pojo.vo.PersonChangeVO;
import com.hr319wg.emp.web.PersonDismissBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class PersonDismissBackingBeanByExtend extends PersonDismissBackingBean {

	public String saveDispatch() {
		try {
			String msg="";
			String ids = getServletRequest().getParameter("pids");

			PersonChangeVO personchangevo = new PersonChangeVO();
			personchangevo.setChangeType(PersonChangeVO.CHANGE_TYPE_OUT);
			personchangevo.setChangeDate(CommonFuns.getSysDate("yyyy-MM-dd"));
			ChangeInfoBO changeinfo = new ChangeInfoBO();
			OrgBO orgbo = OrgTool.getOrgByDept(this.getChgs());
			changeinfo.setToOrgId(orgbo.getOrgId());
			changeinfo.setToDepId(this.getChgs());
			changeinfo.setToPostId(this.getPosts());
			changeinfo.setToPostLevel(this.getPostLevel());
			changeinfo.setFromOperator(super.getUserInfo().getUserId());
			personchangevo.setTractPerson(super.getUserInfo().getName());
			personchangevo.setTractDate(CommonFuns.getSysDate("yyyy-MM-dd"));

			String[] idArray = ids.split(",");
			List idList=new ArrayList();
			for(int i=0;i<idArray.length;i++){
				PersonBO p=SysCacheTool.findPersonById(idArray[i]);
				if(p!=null){
					OrgBO superOrg = OrgTool.getOrgByDept(this.getChgs());
					if (superOrg != null) {
						String superOrgID = superOrg.getOrgId();
						if(!superOrgID.equals(p.getOrgId())){
							idList.add(idArray[i]);
						}else{
							msg+=p.getName()+",";
						}
					}
				}
			}
			idArray=(String[]) idList.toArray(new String[0]);
			String[] pid = new String[1];

			for (int i = 0; i < idArray.length; i++) {
				pid[0] = idArray[i];
				changeinfo.setPersonId(idArray[i]);
				changeinfo.setFromOrgId(SysCacheTool.findPersonById(idArray[i]).getOrgId());
				this.getPersonucc().chgDismiss(personchangevo, changeinfo, pid);
			}
			if ("1".equals(Constants.EMP_TRANSFER_WAGE_LINK)) {
				for (int i = 0; i < idArray.length; i++) {
					changeinfo.setPersonId(idArray[i]);
					changeinfo.setFromOrgId(SysCacheTool.findPersonById(idArray[i]).getOrgId());
					this.getWagesetpersonucc().transferLink(super.getUserInfo(), changeinfo);
				}
			}
			if(!"".equals(msg)){
				msg=msg.substring(0, msg.length()-1);
				msg="调动完成，其中:"+msg+"不允许在本单位内调动!";
			}else{
				msg="调动完成!";
			}
			getServletRequest().setAttribute("message", msg);
			SysCache.setMap(ids.split(","), 3, 6);
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
			getServletRequest().setAttribute("flag", "1");
			return "close";
		}
		return "close";
	}
}
