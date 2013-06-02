package com.hr319wg.custom.common.web;

import java.util.List;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.custom.pojo.bo.ReportBO;

public class UploadReportBackingBean extends BaseBackingBean {

	private String pageInit;
	private String editInit;
	private ICommonService commonService;
	private UploadedFile myFile;
	private String operID;
	private List<ReportBO> list;
	private PageVO mypage = new PageVO();
	private ReportBO bo;
	private UploadedFile rptFile;

	public UploadedFile getRptFile() {
		return rptFile;
	}

	public void setRptFile(UploadedFile rptFile) {
		this.rptFile = rptFile;
	}

	public void setEditInit(String editInit) {
		this.editInit = editInit;
	}

	public ReportBO getBo() {
		return bo;
	}

	public void setBo(ReportBO bo) {
		this.bo = bo;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public List<ReportBO> getList() {
		return list;
	}

	public void setList(List<ReportBO> list) {
		this.list = list;
	}

	public String getOperID() {
		return operID;
	}

	public void setOperID(String operID) {
		this.operID = operID;
	}

	public UploadedFile getMyFile() {
		return myFile;
	}

	public void setMyFile(UploadedFile myFile) {
		this.myFile = myFile;
	}

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}

	public String first() {
		mypage.setCurrentPage(1);
		return null;
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return null;
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return null;
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return null;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}

			this.list = this.commonService.getReportBO(mypage, null);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public void delete() {
		try {
			this.commonService.deleteReport(this.operID);
		} catch (SysException e) {
			e.printStackTrace();
		}
	}

	public String getEditInit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			this.bo = new ReportBO();
		}
		String rptID = super.getRequestParameter("rptID");
		if (rptID != null && !"".equals(rptID)) {
			try {
				this.bo = (ReportBO) this.commonService.getObjBO(ReportBO.class, rptID);
			} catch (SysException e) {
				e.printStackTrace();
			}
		}
		return editInit;
	}

	public String save() {
		String path = super.getServletContext().getRealPath("/");
		try {
			this.commonService.saveReport(myFile, path, this.bo);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
