package com.hr319wg.sys.web;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.myfaces.custom.fileupload.UploadedFile;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;
import org.springframework.jdbc.support.lob.OracleLobHandler;
import org.springframework.jdbc.support.nativejdbc.SimpleNativeJdbcExtractor;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.NewsContentBO;
import com.hr319wg.sys.pojo.bo.NewsParamBO;
import com.hr319wg.sys.pojo.vo.AttFileVO;
import com.hr319wg.sys.pojo.vo.NewsEditVO;
import com.hr319wg.sys.ucc.INewsManageUCC;
import com.hr319wg.user.pojo.bo.SelfLevelBO;
import com.hr319wg.user.ucc.ISelfLevelUCC;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.FileUtil;

public class NewsEditBackingBean extends BaseBackingBean {
	private INewsManageUCC newsmanageucc;
	private String newsId;
	private NewsParamBO newsParamBO;
	private NewsEditVO vo = new NewsEditVO();
	private String myscope;
	private String idforEdit = null;
	private String initPage;
	private String AuthorId = "";
	private UploadedFile excelFile;
	private String title;
	private String index;
	private List attList;
	private ISelfLevelUCC selflevelUCC;
	private List levelList;
	private String[] inputList;
	private UploadedFile blobFile;

	public List getLevelList() {
		try {
			this.levelList = new ArrayList();
			List list = this.selflevelUCC.getAlllevel();
			for (int i = 0; i < list.size(); ++i) {
				SelfLevelBO sb = (SelfLevelBO) list.get(i);
				SelectItem si = new SelectItem();
				si.setLabel(sb.getItemName() + "-"
						+ CommonFuns.filterNull(sb.getItemDes()));
				si.setValue(sb.getItemName());
				this.levelList.add(si);
			}
		} catch (Exception e) {
			this.levelList = new ArrayList();
		}
		return this.levelList;
	}

	public void setLevelList(List list) {
		this.levelList = list;
	}

	public ISelfLevelUCC getSelflevelUCC() {
		return this.selflevelUCC;
	}

	public void setSelflevelUCC(ISelfLevelUCC ucc) {
		this.selflevelUCC = ucc;
	}

	public String[] getInputList() {
		return this.inputList;
	}

	public void setInputList(String[] list) {
		this.inputList = list;
	}

	public List getAttList() {
		if (this.attList == null)
			this.attList = new ArrayList();

		return this.attList;
	}

	public void setAttList(List li) {
		this.attList = li;
	}

	public String getIndex() {
		return this.index;
	}

	public void setIndex(String tt) {
		this.index = tt;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String tt) {
		this.title = tt;
	}

	public UploadedFile getExcelFile() {
		return this.excelFile;
	}

	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}

	public String uploadFile() {
		try {
			if (this.attList.size() >= 5) {
				super.showMessageDetail("最多只能有5个附件！");
				return "";
			}

			ServletContext context = (ServletContext) FacesContext
					.getCurrentInstance().getExternalContext().getContext();
			String path = context.getRealPath("/") + File.separator + "file"
					+ File.separator + "news";
			String fileName = FileUtil.createFile(this.excelFile, path);
			AttFileVO avo = new AttFileVO();
			int index = this.attList.size() + 1;
			avo.setIndex(String.valueOf(index));
			avo.setUpdated(true);
			avo.setPhysicsfile(path + File.separator + fileName);
			avo.setAttFile("/file/news/" + fileName);
			avo.setAttTitle(this.title);
			this.attList.add(avo);
		} catch (SysException e) {
		}
		return "";
	}

	public String deleteAtt() {
		if ((this.index == null) || ("".equals(this.index)))
			return "";

		this.attList.remove(Integer.parseInt(this.index) - 1);
		for (int i = 0; i < this.attList.size(); ++i) {
			AttFileVO av = (AttFileVO) this.attList.get(i);
			av.setIndex(String.valueOf(i + 1));
		}
		return "";
	}

	public String getInitPage() {
		User user = super.getUserInfo();
		this.AuthorId = user.getUserId();
		HttpServletRequest req = (HttpServletRequest) FacesContext
				.getCurrentInstance().getExternalContext().getRequest();
		if (req.getAttribute("idforEdit") != null) {
			this.idforEdit = req.getAttribute("idforEdit").toString();
			try {
				this.newsParamBO = this.newsmanageucc
						.findNewsParamByNewsId(this.idforEdit);
				this.vo.setTopic(this.newsParamBO.getNewTopic());
				this.vo.setStartDate(this.newsParamBO.getStartDate());
				this.vo.setEndDate(this.newsParamBO.getEndDate());
				this.vo.setReaderType(this.newsParamBO.getReaderType());
				this.vo.setNewId(this.idforEdit);
				this.vo.setNewsSource(this.newsParamBO.getNewsSource());
				this.vo.setPublicFlag(this.newsParamBO.getPublicFlag());
				this.vo.setExpress(this.newsParamBO.getExpress());

				if (this.newsParamBO.getInfoLevel() != null) {
					this.vo.setInfoLevel(this.newsParamBO.getInfoLevel());
					this.inputList = this.newsParamBO.getInfoLevel().split(",");
				}
				NewsContentBO contentbo = this.newsmanageucc
						.findContentBOByNewsId(this.idforEdit);
				if (contentbo != null) {
					this.vo.setContent(contentbo.getNewContent());
					this.vo.setNewsFile(contentbo.getNewsFile());
				}

				this.attList = this.newsmanageucc
						.findNewsContentFile(this.idforEdit);

				String[] scope = this.newsmanageucc
						.findNewsScopeByNewsId(this.idforEdit);
				String scopeNames = "";
				String scopeIds = "";
				OrgBO org = null;
				if (scope != null)
					for (int i = 0; i < scope.length; ++i) {
						scopeIds = scopeIds + scope[i] + ",";
						org = SysCacheTool.findOrgById(scope[i]);
						if (org != null)
							scopeNames = scopeNames + org.getName() + ",";
					}

				this.vo.setScopeOrgNames(scopeNames);
				this.vo.setScopeOrgIds(scopeIds);
			} catch (Exception e) {
				this.msg.setMainMsg(e, NewsEditBackingBean.class);
			}
		}
		return this.initPage;
	}

	public void setInitPage(String initPage) {
		this.initPage = initPage;
	}

	public String saveNews() {
		this.vo.setReaderType("01");
		if ((this.vo.getTopic() == null) || (this.vo.getTopic().length() > 99)) {
			this.fm.setSeverity(FacesMessage.SEVERITY_INFO);
			this.fm.setDetail("新闻标题 不能超过50个汉字！");
			FacesContext.getCurrentInstance().addMessage(null, this.fm);
			return "";
		}
		if ((this.vo.getScopeOrgNames() == null)
				|| (this.vo.getScopeOrgIds() == null)
				|| (this.vo.getScopeOrgNames().length() < 1)
				|| (this.vo.getScopeOrgIds().length() < 1)) {
			this.fm.setSeverity(FacesMessage.SEVERITY_INFO);
			this.fm.setDetail("新闻范围不能为空！" + this.vo.getScopeOrgIds().length());
			FacesContext.getCurrentInstance().addMessage(null, this.fm);
			return "";
		}
		if ((this.inputList == null) || (this.inputList.length == 0)) {
			this.fm.setSeverity(FacesMessage.SEVERITY_INFO);
			this.fm.setDetail("必须设置可以查看本新闻的自助权限级别!");
			FacesContext.getCurrentInstance().addMessage(null, this.fm);
			return "";
		}

		String power = "";
		for (int j = 0; j < this.inputList.length; ++j)
			if ("".equals(power)) {
				power = this.inputList[j];
			} else
				power = power + "," + this.inputList[j];

		this.vo.setInfoLevel(power);
		try {
			if (this.blobFile != null) {
				ServletContext context = (ServletContext) FacesContext
						.getCurrentInstance().getExternalContext().getContext();
				String path = context.getRealPath("/") + File.separator
						+ "file" + File.separator + "news";
				String fileName = FileUtil.createFile(this.blobFile, path);
				this.vo.setNewsFile(fileName);
			}
			String newsID = null;
			if ((this.idforEdit == null) || (this.idforEdit.length() == 0)) {
				newsID=this.newsmanageucc.createNews(this.vo, this.attList,
						this.AuthorId);
			} else{
				this.newsmanageucc.updateNews(this.vo, this.attList,
						this.AuthorId);
				newsID=this.vo.getNewId();
			}

		} catch (Exception e) {
			this.msg.setMainMsg(e, NewsEditBackingBean.class);
		}
		return "sys_newslist";
	}

	public NewsEditVO getVo() {
		return this.vo;
	}

	public UploadedFile getBlobFile() {
		return this.blobFile;
	}

	public void setBlobFile(UploadedFile id) {
		this.blobFile = id;
	}

	public String getContent() {
		return null;
	}

	public String[] getScope() {
		return null;
	}

	public NewsParamBO getNewsParamBO() {
		return this.newsParamBO;
	}

	public void setNewsParamBO(NewsParamBO newsParamBO) {
		this.newsParamBO = newsParamBO;
	}

	public void setVo(NewsEditVO vo) {
		this.vo = vo;
	}

	public String getNewsId() {
		return this.newsId;
	}

	public void setNewsId(String bulletinId) {
		this.newsId = bulletinId;
	}

	public INewsManageUCC getNewsmanageucc() {
		return this.newsmanageucc;
	}

	public void setNewsmanageucc(INewsManageUCC newsmanageucc) {
		this.newsmanageucc = newsmanageucc;
	}

	public String getMyscope() {
		return this.myscope;
	}

	public void setMyscope(String myscope) {
		this.myscope = myscope;
	}
}