package com.hr319wg.xys.eva.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupBO;
import com.hr319wg.xys.eva.pojo.bo.EvaGroupPostBO;
import com.hr319wg.xys.eva.pojo.bo.EvaRelBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaRoleBO;
import com.hr319wg.xys.eva.pojo.bo.XysPostRoleRelBO;
import com.hr319wg.xys.eva.pojo.vo.PostVO;
import com.hr319wg.xys.eva.ucc.IRelSetUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaGroupUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaRoleUCC;

/**
 * Created by IntelliJ IDEA. User: Administrator Date: 12-5-25 Time: 下午11:09 To
 * change this template use File | Settings | File Templates.
 */
public class RelSetMgrBackBean extends BaseBackingBean {
	private IRelSetUCC relSetUCC;
	private String pageInit;
	private String superId;
	private String superName;
	private PageVO mypage = new PageVO();
	private List postList;
	private IXysEvaRoleUCC xysEvaRoleUcc;
	private String roleId;

	public String setRole() {
		try {
			if (postIds != null && !postIds.equals("1")) {
				String ids[] = postIds.split(",");
				for (int i = 0; i < ids.length; i++) {
					XysPostRoleRelBO role = relSetUCC
							.findXysPostRoleRelBOByPostId(ids[i]);
					if (role != null) {
						role.setRoleId(roleId);
					} else {
						role = new XysPostRoleRelBO();
						role.setPostId(ids[i]);
						role.setRoleId(roleId);
					}
					relSetUCC.saveXysPostRoleRelBO(role);
				}
			}
			roleId = "";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
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

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if (superId == null || superId.equals("")) {
				superId = super.getUserInfo().getOrgId();
			}
			List rolList = this.xysEvaRoleUcc.getXysEvaRoleBOByOrgId(null,null);
			Hashtable map = new Hashtable();
			if (rolList != null && rolList.size() > 0) {
				for (int i = 0; i < rolList.size(); i++) {
					XysEvaRoleBO bo = (XysEvaRoleBO) rolList.get(i);
					map.put(bo.getRoleId(), bo);
				}
			}
			postList = new ArrayList();
			List list = relSetUCC.getAllPostBOByOrgId(mypage, superId);
			Hashtable map1 = this.relSetUCC.getAllXysPostRoleRelBOForMap();
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					PostBO bo = (PostBO) list.get(i);
					XysPostRoleRelBO rel = (XysPostRoleRelBO) map1.get(bo
							.getPostId());
					List relList = relSetUCC.getAllEvaRelBOByPostId(bo
							.getPostId());
					PostVO vo = new PostVO();
					vo.setName(bo.getName());
					vo.setPostId(bo.getPostId());
					vo.setOrgId(SysCacheTool.findOrgById(bo.getOrgId())
							.getName());
					vo.setSuperId(PostTool.getPostName(bo.getSuperId()));
					vo.setPostType(CodeUtil.interpertCode(bo.getPostClass()));
					vo.setPostLevel(CodeUtil.interpertCode(bo.getPostLevel()));
					if (rel != null) {
						XysEvaRoleBO role = (XysEvaRoleBO) map.get(rel
								.getRoleId());
						vo.setRoleId(role.getRoleName());
					}
					if (relList != null && relList.size() > 0) {
						vo.setIsCtr("是");
					} else {
						vo.setIsCtr("<font color='red'>否</font>");
					}
					postList.add(vo);
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
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
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

	public List getPostList() {
		return postList;
	}

	public void setPostList(List postList) {
		this.postList = postList;
	}

	public IRelSetUCC getRelSetUCC() {
		return relSetUCC;
	}

	public void setRelSetUCC(IRelSetUCC relSetUCC) {
		this.relSetUCC = relSetUCC;
	}

	// 考核关系维护
	private String initEvaList;
	private String postId;
	private String relId;
	private List evaList;
	private String postName;
	private String relIds;
	
	
	public String getRelIds() {
		return relIds;
	}

	public void setRelIds(String relIds) {
		this.relIds = relIds;
	}
	public String deleteAllRel() {
		try {
			if(relIds!=null&&!relIds.equals("")){
				String ids[]=relIds.split(",");
				for(int i=0;i<ids.length;i++){
					relSetUCC.deleteEvaRelBO(CommonFuns.filterNull(ids[i]));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String deleteRel() {
		try {
			relSetUCC.deleteEvaRelBO(relId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	public void initRel() {
		try {
			PostBO bo = SysCacheTool.findPost(postId);
			List list = relSetUCC.getAllEvaRelBOByPostId(bo.getPostId());
			if (list == null || list.size() <= 0) {
				if (bo.getSuperId() != null && !bo.getSuperId().equals("")) {// 取得上级岗位
					String sId = bo.getSuperId();
					EvaRelBO rel = new EvaRelBO();
					rel.setEvaType(EvaRelBO.EVA_TYPE_LEADER);
					rel.setPostId(bo.getPostId());
					rel.setEvaPostId(sId);
					relSetUCC.saveEvaRelBO(rel);
					List tjList = relSetUCC.getBranchPostRelByPostId(sId);// 取得同级岗位
					if (tjList != null && tjList.size() > 0) {
						for (int j = 0; j < tjList.size(); j++) {
							PostBO post = (PostBO) tjList.get(j);
							EvaRelBO rel1 = new EvaRelBO();
							rel1.setEvaType(EvaRelBO.EVA_TYPE_VIS);
							rel1.setPostId(bo.getPostId());
							rel1.setEvaPostId(post.getPostId());
							relSetUCC.saveEvaRelBO(rel1);
						}
					}
				}

				List pList = relSetUCC.getAllSuperPostByPostId(bo.getPostId());// 取得其他上级岗位
				List cpList = pList;
				cpList.add(bo.getSuperId());
				if (pList != null && pList.size() > 0) {
					for (int m = 0; m < pList.size(); m++) {
						String pId = (String) pList.get(m);
						if (pId != null && !pId.equals("")) {
							EvaRelBO rel = relSetUCC.findEqualsEvaRelBO(
									bo.getPostId(), pId);// 判断是否加入该岗位
							if (rel == null) {
								rel = new EvaRelBO();
								rel.setEvaType(EvaRelBO.EVA_TYPE_LEADER);
								rel.setPostId(bo.getPostId());
								rel.setEvaPostId(pId);
								relSetUCC.saveEvaRelBO(rel);
							}
							List tjList = relSetUCC
									.getBranchPostRelByPostId(pId);
							if (tjList != null && tjList.size() > 0) {
								for (int j = 0; j < tjList.size(); j++) {
									PostBO post = (PostBO) tjList.get(j);
									List ptList = relSetUCC
											.getAllSuperPostByPostId(post
													.getPostId());
									List cptList = ptList;
									cptList.add(post.getSuperId());
									int twoFlag = 0;
									for (int n = 0; n < cptList.size(); n++) {
										String posts = (String) cptList.get(n);
										for (int ii = 0; ii < cpList.size(); ii++) {
											String cposts = (String) cpList
													.get(ii);
											if (cposts.equals(posts)) {
												twoFlag++;
												break;
											}
										}
										if (twoFlag >= 2) {
											break;
										}
									}
									EvaRelBO rel1 = relSetUCC
											.findEqualsEvaRelBO(bo.getPostId(),
													post.getPostId());
									if (rel1 == null && twoFlag == 2) {
										rel1 = new EvaRelBO();
										rel1.setEvaType(EvaRelBO.EVA_TYPE_VIS);
										rel1.setPostId(bo.getPostId());
										rel1.setEvaPostId(post.getPostId());
										relSetUCC.saveEvaRelBO(rel1);
									}
								}
							}

						}
					}
				}

				List xjList = relSetUCC
						.getBranchPostRelByPostId(bo.getPostId());
				if (xjList != null && xjList.size() > 0) {
					for (int j = 0; j < xjList.size(); j++) {
						PostBO post = (PostBO) xjList.get(j);
						EvaRelBO rel = new EvaRelBO();
						rel.setEvaType(EvaRelBO.EVA_TYPE_LOWER);
						rel.setPostId(bo.getPostId());
						rel.setEvaPostId(post.getPostId());
						relSetUCC.saveEvaRelBO(rel);
					}
				}
			}

		} catch (Exception e) {
			super.showMessageDetail("初始化出错！");
			e.printStackTrace();
		}
	}

	public void queryRelSet() {
		try {
			List list = relSetUCC.getAllEvaRelBOByPostId(postId);
			if (list == null || list.size() <= 0) {
				initRel();
			}
			evaList = relSetUCC.getAllEvaRelBOByPostId(postId);
			if (evaList != null && evaList.size() > 0) {
				for (int i = 0; i < evaList.size(); i++) {
					EvaRelBO bo = (EvaRelBO) evaList.get(i);
					PostBO post=SysCacheTool.findPost(bo.getEvaPostId());
					bo.setEvaPostId(post.getName());
					bo.setDeptName(SysCacheTool.findOrgById(post.getOrgId()).getName());
					evaList.set(i, bo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getInitEvaList() {
		if (super.getRequestParameter("postId") != null) {
			postId = super.getRequestParameter("postId");
			postName = PostTool.getPostName(postId);
		}
		queryRelSet();
		return initEvaList;
	}

	public void setInitEvaList(String initEvaList) {
		this.initEvaList = initEvaList;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getRelId() {
		return relId;
	}

	public void setRelId(String relId) {
		this.relId = relId;
	}

	public List getEvaList() {
		return evaList;
	}

	public void setEvaList(List evaList) {
		this.evaList = evaList;
	}

	// 编辑考核关系
	private String initEdit;
	private EvaRelBO relBO = new EvaRelBO();
	private String orgId;
	private String preEvaPost;

	public String getPreEvaPost() {
		return preEvaPost;
	}

	public void setPreEvaPost(String preEvaPost) {
		this.preEvaPost = preEvaPost;
	}

	public String getOrgId() {
		return super.getUserInfo().getOrgId();
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String saveRel() {
		try {
			if (preEvaPost.equals(relBO.getEvaPostId())) {
				relBO.setPostId(postId);
				relSetUCC.saveEvaRelBO(relBO);
			} else {
				EvaRelBO bo = this.relSetUCC.findEqualsEvaRelBO(postId,
						relBO.getEvaPostId());
				if (bo != null) {
					super.showMessageDetail("该岗位以设置无需重新设置");
					return "";
				} else {
					relBO.setPostId(postId);
					relSetUCC.saveEvaRelBO(relBO);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("relId") != null) {
				relId = super.getRequestParameter("relId");
				relBO = relSetUCC.findEvaRelBOById(relId);
				preEvaPost = relBO.getEvaPostId();
				postId = relBO.getPostId();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public EvaRelBO getRelBO() {
		return relBO;
	}

	public void setRelBO(EvaRelBO relBO) {
		this.relBO = relBO;
	}

	// 增加岗位
	private String initAdd;
	private String postIds;
	private String postNames;
	private String evaType;
	private IXysEvaGroupUCC  xysEvaGroupUcc;
	private List groupList;
	private String groupId;
	
	
	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public List getGroupList() {
		groupList=new ArrayList();
		SelectItem si=new SelectItem();
		si.setLabel("选择");
		si.setValue("-1");
		groupList.add(si);
		try {
			List list=this.xysEvaGroupUcc.getEvaGroupBO(null,super.getUserInfo().getOrgId());
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					EvaGroupBO bo=(EvaGroupBO)list.get(i);
					SelectItem si1=new SelectItem();
					si1.setLabel(bo.getGroupName());
					si1.setValue(bo.getGroupId());
					groupList.add(si1);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return groupList;
	}

	public void setGroupList(List groupList) {
		this.groupList = groupList;
	}

	public IXysEvaGroupUCC getXysEvaGroupUcc() {
		return xysEvaGroupUcc;
	}

	public void setXysEvaGroupUcc(IXysEvaGroupUCC xysEvaGroupUcc) {
		this.xysEvaGroupUcc = xysEvaGroupUcc;
	}

	public String saveAdd() {
		try {
			if (postIds != null && !postIds.equals("")) {
				String[] ids = postIds.split(",");
				for (int i = 0; i < ids.length; i++) {
					EvaRelBO bo = this.relSetUCC.findEqualsEvaRelBO(postId,
							ids[i]);
					if (bo == null) {
						bo = new EvaRelBO();
						bo.setEvaPostId(ids[i]);
						bo.setEvaType(evaType);
						bo.setPostId(postId);
						this.relSetUCC.saveEvaRelBO(bo);
					}
				}
			}
			if(groupId!=null&&!groupId.equals("")&&!groupId.equals("-1")){
				List list=this.xysEvaGroupUcc.getEvaGroupPostBO(null, groupId);
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaGroupPostBO po=(EvaGroupPostBO)list.get(i);
						EvaRelBO bo = this.relSetUCC.findEqualsEvaRelBO(postId,po.getPostId());
						if (bo == null) {
							bo = new EvaRelBO();
							bo.setEvaPostId(po.getPostId());
							bo.setEvaType(evaType);
							bo.setPostId(postId);
							this.relSetUCC.saveEvaRelBO(bo);
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String getEvaType() {
		return evaType;
	}

	public void setEvaType(String evaType) {
		this.evaType = evaType;
	}

	public String getInitAdd() {
		if (super.getRequestParameter("postId") != null) {
			postId = super.getRequestParameter("postId");
		}
		return initAdd;
	}

	public void setInitAdd(String initAdd) {
		this.initAdd = initAdd;
	}

	public String getPostIds() {
		return postIds;
	}

	public void setPostIds(String postIds) {
		this.postIds = postIds;
	}

	public String getPostNames() {
		return postNames;
	}

	public void setPostNames(String postNames) {
		this.postNames = postNames;
	}

}
