package com.hr319wg.sys.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.dao.NewsContentDAO;
import com.hr319wg.sys.dao.NewsParamDAO;
import com.hr319wg.sys.dao.NewsScopeDAO;
import com.hr319wg.sys.pojo.bo.NewsContentBO;
import com.hr319wg.sys.pojo.bo.NewsParamBO;
import com.hr319wg.sys.pojo.bo.NewsScopeBO;
import com.hr319wg.sys.pojo.vo.AttFileVO;

public class NewsManageService {
	private NewsParamDAO newsparamdao;
	private NewsContentDAO newscontentdao;
	private NewsScopeDAO newsscopedao;
	private NewsContentBO contentbo;
	private NewsScopeBO scopebo;

	public void createNews(NewsParamBO parambo, NewsContentBO newsContent,
			String[] NewsScope) throws RollbackableException {
		try {
			String newsId = this.newsparamdao.createBo(parambo);
			if ((newsId != null) && (newsId.length() > 0)) {
				newsContent.setNewId(newsId);
//				newsContent.setNewContent(null);
				this.newscontentdao.createBo(newsContent);
				for (int i = 0; i < NewsScope.length; i++) {
					this.scopebo = new NewsScopeBO();
					this.scopebo.setNewId(newsId);
					this.scopebo.setOrgId(NewsScope[i]);
					this.newsscopedao.createBo(this.scopebo);
				}
			}
		} catch (Exception e) {
			throw new RollbackableException("E1502001", "保存新闻失败！", e,
					NewsManageService.class);
		}
	}

	public void deleteNewsByNewsId(String NewsId) throws RollbackableException {
	}

	public void deleteNewsByNewsIdArray(String[] NewsIdArray)
			throws RollbackableException {
		String id = null;
		try {
			for (int i = 0; i < NewsIdArray.length; ++i) {
				id = NewsIdArray[i].trim();
				this.newscontentdao.deleteBo(NewsContentBO.class, id);
				this.newsparamdao.deleteBo(NewsParamBO.class, id);

				List bolist = this.newsscopedao.findByAnyString("NewsScopeBO",
						"newId", id, "");
				if (bolist != null)
					for (int j = 0; j < bolist.size(); ++j) {
						this.scopebo = ((NewsScopeBO) bolist.get(j));
						this.newsscopedao.deleteBo(NewsScopeBO.class,
								this.scopebo.getSerialId());
					}
			}
		} catch (Exception e) {
			throw new RollbackableException("E1502002", "根据新闻ID删除新闻失败！", e,
					NewsManageService.class);
		}
	}

	public void updateNewsParam(NewsParamBO parambo)
			throws RollbackableException {
		try {
			this.newsparamdao.saveOrUpdateBo(parambo);
		} catch (Exception e) {
			throw new RollbackableException("E1502003", "更新新闻参数信息失败！", e,
					NewsManageService.class);
		}
	}

	public void updateNewsContent(NewsContentBO bo)
			throws RollbackableException {
		try {
			bo.setNewContent(null);
			this.newscontentdao.saveOrUpdateBo(bo);
		} catch (Exception e) {
			throw new RollbackableException("E1502004", "更新新闻正文信息失败！", e,
					NewsManageService.class);
		}
	}

	public void updateNewsScopeByNewsId(String NewsId, String[] NewsScope)
			throws RollbackableException {
		if ((NewsId != null) || (NewsId.length() > 0)) {
			try {
				List bolist = this.newsscopedao.findByAnyString("NewsScopeBO",
						"newId", NewsId, "");
				if (bolist != null)
					for (int j = 0; j < bolist.size(); ++j) {
						this.scopebo = ((NewsScopeBO) bolist.get(j));
						this.newsscopedao.deleteBo(NewsScopeBO.class,
								this.scopebo.getSerialId());
					}

				for (int i = 0; i < NewsScope.length; ++i) {
					this.scopebo = new NewsScopeBO();
					this.scopebo.setNewId(NewsId);
					this.scopebo.setOrgId(NewsScope[i]);
					this.newsscopedao.saveOrUpdateBo(this.scopebo);
				}
			} catch (Exception e) {
				throw new RollbackableException("E1502005", "更新新闻机构范围失败！", e,
						NewsManageService.class);
			}
		}
	}

	public List queryNewsParamAndScopeByCreatorRoleId(String CreatorRoleId)
			throws SysException {
		List list_ret = new ArrayList();
		List scopebolist = null;
		String scopeOrgIds = null;
		String scopeOrgNames = null;
		NewsParamBO parambo = null;
		NewsScopeBO scopebo = new NewsScopeBO();
		HashMap map = null;
		String newId = null;
		String authorId = null;
		String submitDate = null;
		String Topic = null;
		String startDate = null;
		String endDate = null;
		String newEndDate = null;
		String readerType = null;
		try {
			List parambolist = this.newsparamdao
					.queryByCreatorRoleId(CreatorRoleId);
			if ((parambolist != null) || (parambolist.size() > 0))
				for (int i = 0; i < parambolist.size(); ++i) {
					parambo = (NewsParamBO) parambolist.get(i);
					newId = parambo.getNewId();
					authorId = parambo.getAuthorId();
					Topic = parambo.getNewTopic();
					submitDate = parambo.getSubmitDate();
					startDate = parambo.getStartDate();
					endDate = parambo.getEndDate();
					newEndDate = parambo.getNewEndDate();
					readerType = parambo.getReaderType();

					map = new HashMap();
					map.put("newId", newId);
					map.put("authorId", authorId);
					map.put("newTopic", Topic);
					map.put("submitDate", submitDate);
					map.put("startDate", startDate);
					map.put("endDate", endDate);
					map.put("newEndDate", newEndDate);

					scopebolist = this.newsscopedao.findByAnyString(
							"NewsScopeBO", "newId", newId, "");
					if ((scopebolist != null) || (scopebolist.size() > 0)) {
						scopeOrgIds = "";
						scopeOrgNames = "";
						OrgBO org = null;
						String tmpOrgName = "";
						for (int j = 0; j < scopebolist.size(); ++j) {
							scopebo = (NewsScopeBO) scopebolist.get(j);
							scopeOrgIds = scopebo.getOrgId();
							org = SysCacheTool.findOrgById(scopeOrgIds);
							if (org != null)
								tmpOrgName = org.getName();

							if ("".equals(scopeOrgNames)) {
								scopeOrgNames = tmpOrgName;
							} else
								scopeOrgNames = scopeOrgNames + ","
										+ tmpOrgName;
						}

						map.put("organScope", scopeOrgNames);

						if (readerType.equals("01")) {
							readerType = "全体人员";
						} else if (readerType.equals("02"))
							readerType = "HR人员";
					}
					list_ret.add(map);
				}
		} catch (Exception e) {
			throw new SysException("E1502006", "根据创建者ID查询新闻参数信息和机构范围失败！", e,
					NewsManageService.class);
		}

		return list_ret;
	}

	public List findNewsContentFile(String NewsId) throws SysException {
		List list = new ArrayList();
		NewsContentBO contentbo = (NewsContentBO) this.newscontentdao
				.findBoById(NewsContentBO.class, NewsId);
		if ((contentbo.getAttFile1() != null)
				&& (contentbo.getAttTitle1() != null)) {
			AttFileVO vo1 = new AttFileVO();
			vo1.setIndex("1");
			vo1.setAttFile(contentbo.getAttFile1());
			vo1.setAttTitle(contentbo.getAttTitle1());
			vo1.setUpdated(false);
			list.add(vo1);
		}
		if ((contentbo.getAttFile2() != null)
				&& (contentbo.getAttTitle2() != null)) {
			AttFileVO vo2 = new AttFileVO();
			vo2.setIndex("2");
			vo2.setAttFile(contentbo.getAttFile1());
			vo2.setAttTitle(contentbo.getAttTitle1());
			vo2.setUpdated(false);
			list.add(vo2);
		}
		if ((contentbo.getAttFile3() != null)
				&& (contentbo.getAttTitle3() != null)) {
			AttFileVO vo3 = new AttFileVO();
			vo3.setIndex("3");
			vo3.setAttFile(contentbo.getAttFile3());
			vo3.setAttTitle(contentbo.getAttTitle3());
			vo3.setUpdated(false);
			list.add(vo3);
		}
		if ((contentbo.getAttFile4() != null)
				&& (contentbo.getAttTitle4() != null)) {
			AttFileVO vo4 = new AttFileVO();
			vo4.setIndex("4");
			vo4.setAttFile(contentbo.getAttFile4());
			vo4.setAttTitle(contentbo.getAttTitle4());
			vo4.setUpdated(false);
			list.add(vo4);
		}
		if ((contentbo.getAttFile5() != null)
				&& (contentbo.getAttTitle5() != null)) {
			AttFileVO vo5 = new AttFileVO();
			vo5.setIndex("5");
			vo5.setAttFile(contentbo.getAttFile5());
			vo5.setAttTitle(contentbo.getAttTitle5());
			vo5.setUpdated(false);
			list.add(vo5);
		}
		return list;
	}

	public NewsContentBO findContentBOByNewsId(String NewsId)
			throws SysException {
		return ((NewsContentBO) this.newscontentdao.findBoById(
				NewsContentBO.class, NewsId));
	}

	public String findNewsContentByNewsId(String NewsId) throws SysException {
		String ret = null;
		NewsContentBO contentbo = null;
		try {
			if (this.newscontentdao.findBoById(NewsContentBO.class, NewsId) != null) {
				contentbo = (NewsContentBO) this.newscontentdao.findBoById(
						NewsContentBO.class, NewsId);
				ret = contentbo.getNewContent();
			}
		} catch (Exception e) {
			throw new SysException("E1502007", "根据新闻ID查询新闻正文失败！", e,
					NewsManageService.class);
		}
		return ret;
	}

	public NewsParamBO findNewsPamamByNewsId(String NewsId) throws SysException {
		try {
			return ((NewsParamBO) this.newsparamdao.findBoById(
					NewsParamBO.class, NewsId));
		} catch (Exception e) {
			throw new SysException("E1502008", "根据新闻ID查询新闻参数信息失败！", e,
					NewsManageService.class);
		}
	}

	public List findNewsScopeByNewsId(String NewsId) throws SysException {
		try {
			return this.newsscopedao.findByAnyString("NewsScopeBO", "newId",
					NewsId, "");
		} catch (Exception e) {
			throw new SysException("E1502009", "根据新闻ID查询新闻机构范围失败！", e,
					NewsManageService.class);
		}
	}

	public NewsContentDAO getNewscontentdao() {
		return this.newscontentdao;
	}

	public void setNewscontentdao(NewsContentDAO newscontentdao) {
		this.newscontentdao = newscontentdao;
	}

	public NewsParamDAO getNewsparamdao() {
		return this.newsparamdao;
	}

	public void setNewsparamdao(NewsParamDAO newsparamdao) {
		this.newsparamdao = newsparamdao;
	}

	public NewsScopeDAO getNewsscopedao() {
		return this.newsscopedao;
	}

	public void setNewsscopedao(NewsScopeDAO newsscopedao) {
		this.newsscopedao = newsscopedao;
	}

}