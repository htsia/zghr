package com.hr319wg.custom.post.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class PostSortBackingBean extends BaseBackingBean{

	private String pageInit;
	private ICommonService commonService;

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public String getPageInit() {
		String orgID=super.getRequestParameter("orgID");
		try {
			if(orgID!=null && !"".equals(orgID)){
				List list = this.commonService.getPostList(orgID);
				if(list==null){
					list=new ArrayList();
				}
				super.getServletRequest().getSession().setAttribute("postList", list);				
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public void saveSort() {
		String[] orgids = getServletRequest().getParameterValues("showItem");
	    if (orgids != null && orgids.length > 0) {
	    	List list=new ArrayList();
	    	for (int i = 0; i < orgids.length; i++) {
	    		PostBO post=SysCacheTool.findPost(orgids[i]);
	    		post.setPostSort(i+"");
	    		list.add(post);
	    	}
	    	try {
				this.commonService.updatePostSort(list);
				super.getServletRequest().getSession().setAttribute("postList", list);		
				super.showMessageDetail("ÅÅÐòÍê³É");
			} catch (SysException e) {
				super.showMessageDetail("ÅÅÐòÊ§°Ü");
				e.printStackTrace();
			}
	    }
	}
}
