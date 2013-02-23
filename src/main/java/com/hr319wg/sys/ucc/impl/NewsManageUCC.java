package com.hr319wg.sys.ucc.impl;

import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.run.util.RunTools;
import com.hr319wg.sys.api.NewsQueryAPI;
import com.hr319wg.sys.pojo.bo.NewsContentBO;
import com.hr319wg.sys.pojo.bo.NewsParamBO;
import com.hr319wg.sys.pojo.bo.NewsScopeBO;
import com.hr319wg.sys.pojo.vo.AttFileVO;
import com.hr319wg.sys.pojo.vo.NewsEditVO;
import com.hr319wg.sys.service.NewsManageService;
import com.hr319wg.sys.ucc.INewsManageUCC;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.user.service.UserManageService;
import com.hr319wg.util.CommonFuns;
import java.util.List;

public class NewsManageUCC implements INewsManageUCC {
	private NewsManageService newsmanageservice;
	private UserManageService usermanageservice;
	private NewsQueryAPI newsqueryapi;

	public NewsQueryAPI getNewsqueryapi() {
		return this.newsqueryapi;
	}

	public void setNewsqueryapi(NewsQueryAPI Newsqueryapi) {
		this.newsqueryapi = Newsqueryapi;
	}

	public void NewsManageUCC() {
	}

	public UserManageService getUsermanageservice() {
		return this.usermanageservice;
	}

	public void setUsermanageservice(UserManageService usermanageservice) {
		this.usermanageservice = usermanageservice;
	}

	public NewsManageService getNewsmanageservice() {
		return this.newsmanageservice;
	}

	public void setNewsmanageservice(NewsManageService Newsmanageservice) {
		this.newsmanageservice = Newsmanageservice;
	}

	public List queryNewsParam(User user) throws SysException {
		return this.newsqueryapi.queryNewsParam(user);
	}

	public List queryNewsParam(User user, boolean isAll) throws SysException {
		return this.newsqueryapi.queryNewsParam(user, isAll);
	}

	public List queryNewsParamByOrgId(String OrgId, String ReaderType,
			String level) throws SysException {
		return this.newsqueryapi
				.queryNewsParamByOrgId(OrgId, ReaderType, level);
	}

	public List queryNewsParamByOrgId(String OrgId, String ReaderType,
			String level, boolean isAll) throws SysException {
		return this.newsqueryapi.queryNewsParamByOrgId(OrgId, ReaderType,
				level, isAll);
	}

	public String createNews(NewsEditVO vo, List attList, String AuthorId)
			throws RollbackableException {
		NewsParamBO parambo = new NewsParamBO();
		NewsContentBO NewsContent = new NewsContentBO();
		String[] NewsScopeIds = null;
		String RoleId = "";
		parambo.setNewTopic(vo.getTopic());
		parambo.setInfoLevel(vo.getInfoLevel());
		parambo.setStartDate(vo.getStartDate());
		parambo.setEndDate(vo.getEndDate());
		parambo.setNewEndDate(vo.getNewEndDate());
		parambo.setReaderType(vo.getReaderType());
		parambo.setNewsSource(vo.getNewsSource());
		parambo.setPublicFlag(vo.getPublicFlag());
		parambo.setExpress(vo.getExpress());
		parambo.setItemOrder(vo.getItemOrder());
		try {
			RoleId = findRoleId(AuthorId);
		} catch (Exception e) {
			throw new RollbackableException();
		}
		parambo.setAuthorId(AuthorId);
		parambo.setCreatorRoleId(RoleId);
		parambo.setSubmitDate(RunTools.getDate10());

		NewsContent.setNewContent(vo.getContent());
		NewsContent.setNewsFile(vo.getNewsFile());
		if (attList != null) {
			for (int i = 0; i < attList.size(); i++) {
				AttFileVO av = (AttFileVO) attList.get(i);
				if ("1".equals(av.getIndex())) {
					NewsContent.setAttTitle1(av.getAttTitle());
					NewsContent.setAttFile1(av.getAttFile());
				} else if ("2".equals(av.getIndex())) {
					NewsContent.setAttTitle2(av.getAttTitle());
					NewsContent.setAttFile2(av.getAttFile());
				} else if ("3".equals(av.getIndex())) {
					NewsContent.setAttTitle3(av.getAttTitle());
					NewsContent.setAttFile3(av.getAttFile());
				} else if ("4".equals(av.getIndex())) {
					NewsContent.setAttTitle4(av.getAttTitle());
					NewsContent.setAttFile4(av.getAttFile());
				} else if ("5".equals(av.getIndex())) {
					NewsContent.setAttTitle5(av.getAttTitle());
					NewsContent.setAttFile5(av.getAttFile());
				}
			}
		}

		if (vo.getScopeOrgIds() != null) {
			NewsScopeIds = vo.getScopeOrgIds().split("\\,");
		}
		this.newsmanageservice.createNews(parambo, NewsContent, NewsScopeIds);
		return NewsContent.getNewId();
	}

	public void deleteNewsByNewsId(String NewsId) {
	}

	public void deleteNewsByNewsIdArray(String[] NewsIdArray)
			throws RollbackableException {
		this.newsmanageservice.deleteNewsByNewsIdArray(NewsIdArray);
	}

	public void updateNews(NewsEditVO vo, List attList, String AuthorId)
			throws RollbackableException {
		NewsParamBO parambo = new NewsParamBO();
		NewsContentBO contentbo = new NewsContentBO();
		String scopeOrgIds = null;
		String[] NewsScope = null;
		String RoleId = "";

		parambo.setNewId(vo.getNewId());
		parambo.setNewTopic(vo.getTopic());
		parambo.setStartDate(vo.getStartDate());
		parambo.setEndDate(vo.getEndDate());
		parambo.setNewEndDate(vo.getNewEndDate());
		parambo.setReaderType(vo.getReaderType());
		parambo.setInfoLevel(vo.getInfoLevel());
		parambo.setNewsSource(CommonFuns.filterNull(vo.getNewsSource()));
		parambo.setPublicFlag(vo.getPublicFlag());
		parambo.setExpress(vo.getExpress());
		parambo.setItemOrder(vo.getItemOrder());
		try {
			RoleId = findRoleId(AuthorId);
		} catch (Exception e) {
			throw new RollbackableException();
		}

		parambo.setAuthorId(AuthorId);
		parambo.setCreatorRoleId(RoleId);

		parambo.setSubmitDate(RunTools.getDate10());

		contentbo.setNewId(vo.getNewId());
		contentbo.setNewContent(vo.getContent());
		contentbo.setNewsFile(vo.getNewsFile());
		if (attList != null) {
			for (int i = 0; i < attList.size(); i++) {
				AttFileVO av = (AttFileVO) attList.get(i);
				if ("1".equals(av.getIndex())) {
					contentbo.setAttTitle1(av.getAttTitle());
					contentbo.setAttFile1(av.getAttFile());
				} else if ("2".equals(av.getIndex())) {
					contentbo.setAttTitle2(av.getAttTitle());
					contentbo.setAttFile2(av.getAttFile());
				} else if ("3".equals(av.getIndex())) {
					contentbo.setAttTitle3(av.getAttTitle());
					contentbo.setAttFile3(av.getAttFile());
				} else if ("4".equals(av.getIndex())) {
					contentbo.setAttTitle4(av.getAttTitle());
					contentbo.setAttFile4(av.getAttFile());
				} else if ("5".equals(av.getIndex())) {
					contentbo.setAttTitle5(av.getAttTitle());
					contentbo.setAttFile5(av.getAttFile());
				}
			}
		}

		scopeOrgIds = vo.getScopeOrgIds();
		if ((scopeOrgIds != null) || (scopeOrgIds.length() > 0)) {
			NewsScope = scopeOrgIds.split("\\,");
		}
		this.newsmanageservice.updateNewsParam(parambo);
		this.newsmanageservice.updateNewsContent(contentbo);
		this.newsmanageservice
				.updateNewsScopeByNewsId(vo.getNewId(), NewsScope);
	}

	public void updateNewsParam(NewsParamBO bo) {
	}

	public void updateNewsContent(NewsContentBO bo) {
	}

	public void updateNewsScopeByNewsId(String NewsId, String[] NewsScope) {
	}

	public List queryNewsParamAndScopeByCreatorRoleId(String RoleId)
			throws SysException {
		return this.newsmanageservice
				.queryNewsParamAndScopeByCreatorRoleId(RoleId);
	}

	public String findNewsContent(String NewsId) throws SysException {
		return this.newsmanageservice.findNewsContentByNewsId(NewsId);
	}

	public NewsContentBO findContentBOByNewsId(String NewsId)
			throws SysException {
		return this.newsmanageservice.findContentBOByNewsId(NewsId);
	}

	public List findNewsContentFile(String NewsId) throws SysException {
		return this.newsmanageservice.findNewsContentFile(NewsId);
	}

	public NewsParamBO findNewsParamByNewsId(String NewsId) throws SysException {
		return this.newsmanageservice.findNewsPamamByNewsId(NewsId);
	}

	public String[] findNewsScopeByNewsId(String NewsId) throws SysException {
		String[] ret = null;

		List listbo = this.newsmanageservice.findNewsScopeByNewsId(NewsId);
		if (listbo != null) {
			ret = new String[listbo.size()];
			for (int i = 0; i < listbo.size(); i++) {
				NewsScopeBO bo = (NewsScopeBO) listbo.get(i);
				ret[i] = bo.getOrgId();
			}
		}
		return ret;
	}

	public String findRoleId(String UserId) throws SysException {
		String RoleId = "";
		try {
			List tlist = this.usermanageservice.queryUserRole(UserId);
			if (tlist != null) {
				RoleInfoBO rbo = (RoleInfoBO) tlist.get(0);
				if (rbo != null)
					RoleId = rbo.getRoleId();
			}
		} catch (Exception e) {
			throw new RollbackableException();
		}
		return RoleId;
	}
}