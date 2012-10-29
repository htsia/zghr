package com.hr319wg.xys.eva.web;

import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupBO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupPostBO;
import com.hr319wg.xys.eva.ucc.IXysEvaGroupUCC;

public class EvaGroupMgrBackBean extends BaseBackingBean {
	//ÆÀÉóÍÅ
	private IXysEvaGroupUCC  xysEvaGroupUcc;
	private String pageInit;
	private PageVO mypage = new PageVO();
	private List groupList;
	private String groupId;
	private String initEdit;
	private EvaGroupBO group=new EvaGroupBO();
	
	public String save(){
		try{
			group.setCreateOrg(super.getUserInfo().getOrgId());
			xysEvaGroupUcc.saveEvaGroupBO(group);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getInitEdit() {
		try{
			if(super.getRequestParameter("superId")!=null){
				group.initRow();
			}else if(super.getRequestParameter("groupId")!=null){
				groupId=super.getRequestParameter("groupId");
				group=this.xysEvaGroupUcc.findEvaGroupBOById(groupId);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}
	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	public EvaGroupBO getGroup() {
		return group;
	}
	public void setGroup(EvaGroupBO group) {
		this.group = group;
	}
	public String delete(){
		try{
			List list=xysEvaGroupUcc.getEvaGroupPostBO(null, groupId);
			this.xysEvaGroupUcc.deleteAll(list);
			xysEvaGroupUcc.deleteEvaGroupBO(groupId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public IXysEvaGroupUCC getXysEvaGroupUcc() {
		return xysEvaGroupUcc;
	}
	public void setXysEvaGroupUcc(IXysEvaGroupUCC xysEvaGroupUcc) {
		this.xysEvaGroupUcc = xysEvaGroupUcc;
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
    		groupList=this.xysEvaGroupUcc.getEvaGroupBO(mypage, super.getUserInfo().getOrgId());
    		if(groupList!=null&&groupList.size()>0){
    			for(int i=0;i<groupList.size();i++){
    				EvaGroupBO group=(EvaGroupBO)groupList.get(i);
    				group.setCreateOrg(SysCacheTool.findOrgById(group.getCreateOrg()).getName());
    				groupList.set(i,group);
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
	public List getGroupList() {
		return groupList;
	}
	public void setGroupList(List groupList) {
		this.groupList = groupList;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	//¸ÚÎ»Î¬»¤
	private String initPost;
	private List postList;
	private String itemId;
	private String postIds;
	private String itemIds;
	
	public String getItemIds() {
		return itemIds;
	}
	public void setItemIds(String itemIds) {
		this.itemIds = itemIds;
	}
	public void deleteAll(){
		try{
			if(itemIds!=null&&!itemIds.equals("")){
				String[] ids=itemIds.split(",");
				for(int i=0;i<ids.length;i++){
					this.xysEvaGroupUcc.deleteEvaGroupPostBO(ids[i]);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String addPost(){
		try{
			if(postIds!=null&&!postIds.equals("")){
				String[] ids=postIds.split(",");
				for(int i=0;i<ids.length;i++){
					EvaGroupPostBO post=this.xysEvaGroupUcc.findEqualsEvaGroupPostBO(groupId,ids[i]);
					if(post==null){
						post=new EvaGroupPostBO();
						post.setGroupId(groupId);
						post.setPostId(ids[i]);
						this.xysEvaGroupUcc.saveEvaGroupPostBO(post);
					}
				}
			}
		}catch(Exception e){
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
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public void deletePost(){
		try{
			this.xysEvaGroupUcc.deleteEvaGroupPostBO(itemId);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String first1() {
        mypage.setCurrentPage(1);
        queryPost();
        return "";
    }

    public String pre1() {
        if (mypage.getCurrentPage() > 1) {
            mypage.setCurrentPage(mypage.getCurrentPage() - 1);
        }
        queryPost();
        return "";
    }

    public String next1() {
        if (mypage.getCurrentPage() < mypage.getTotalPage()) {
            mypage.setCurrentPage(mypage.getCurrentPage() + 1);
        }
        queryPost();
        return "";
    }

    public String last1() {
        mypage.setCurrentPage(mypage.getTotalPage());
        queryPost();
        return "";
    }
    public void queryPost(){
    	try{
    		if(mypage.getCurrentPage()==0){
                mypage.setCurrentPage(1);
            }
    		postList=this.xysEvaGroupUcc.getEvaGroupPostBO(mypage, groupId);
    		if(postList!=null&&postList.size()>0){
    			for(int i=0;i<postList.size();i++){
    				EvaGroupPostBO post=(EvaGroupPostBO)postList.get(i);
    				PostBO pbo=SysCacheTool.findPost(post.getPostId());
    				post.setPostId(pbo.getName());
    				post.setDeptName(SysCacheTool.findOrgById(pbo.getOrgId()).getName());
    				postList.set(i,post);
    			}
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }
	public String getInitPost() {
		if(super.getRequestParameter("groupId")!=null){
			groupId=super.getRequestParameter("groupId");
		}
		queryPost();
		return initPost;
	}
	public void setInitPost(String initPost) {
		this.initPost = initPost;
	}
	public List getPostList() {
		return postList;
	}
	public void setPostList(List postList) {
		this.postList = postList;
	}
	
}
