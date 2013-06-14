package com.hr319wg.custom.common.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.emp.pojo.bo.EmpQueryItemBO;
import com.hr319wg.custom.pojo.bo.ReportBO;
import com.hr319wg.custom.pojo.bo.SetFileBO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;

public interface ICommonService {

	public void batchUpdateEmpUploadFile(String setID, String mode, String[] fields, List<Map> list) throws SysException;

	public String getChangeInfo(TableVO table, List showItems, String unitId, String filter);

	public void updateInfoItem(InfoItemBO item) throws SysException;

	public List getRptList(String userID) throws SysException;

	public List getWageMinusList(String setID) throws SysException;

	public void deleteAdvice(String ID) throws SysException;

	public SetFileBO getSetFile(String setID, String itemID, String personID) throws SysException;

	public String saveUpdateFile(UploadedFile file, String path, String pk, String setID, String itemID) throws SysException, IOException;

	public void deleteSetFile(String ID) throws SysException;

	public void saveTempData(String setID, String payoffDate) throws SysException;

	public void batchUpdateInsMonth(String setID, String payoffDate) throws SysException;

	public List getEmpQueryItem(String userID) throws SysException;

	public void saveQueryItem(String userID, String[] showItems, String[] orderItems) throws SysException;

	public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, User user, String qryID, String addCondition, CellVO[] itemCells, List<EmpQueryItemBO> queryItemList, IQueryUCC queryUCC, String hisSet) throws SysException;

	public String getAdjustInfo(TableVO table, String orgID, String filter) throws SysException;

	public void saveReport(UploadedFile file, String path, ReportBO bo) throws Exception;

	public void deleteReport(String ID) throws SysException;
	
	public List getReportBO(User user, String typeID) throws SysException;
	
	public List getAllReportBO(PageVO myPage, String typeID) throws SysException;

	public Object getObjBO(Class c, String ID) throws SysException;
	
	public void saveRptScope(String itemID, String scopeType, String userID, String roleID) throws SysException;
	
	public List getAllConPostBO(String orgID) throws SysException;
	
	public void saveConPost(User user, String personID, String orgID, String postID) throws SysException;
	
	public void updateCancelConPost(String conPostID, String personID) throws SysException;
}
