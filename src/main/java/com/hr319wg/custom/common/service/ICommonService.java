package com.hr319wg.custom.common.service;

import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.custom.emp.pojo.bo.EmpQueryItemBO;
import com.hr319wg.custom.pojo.bo.SetFileBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public interface ICommonService {

	public void batchUpdateEmpUploadFile(String setID, String mode, String[]fields, List<Map> list) throws SysException;
	
	public String getChangeInfo(TableVO table, List showItems, String unitId, String filter);
	
	public void updateInfoItem(InfoItemBO item) throws SysException;

	public List getRptList(String userID) throws SysException;

	public List getWageMinusList(String setID) throws SysException;
	
	public void deleteAdvice(String ID) throws SysException;
	
	public SetFileBO getSetFile(String setID, String itemID, String personID) throws SysException;
	
	public String saveUpdateFile(UploadedFile file, String path, String pk, String setID, String itemID) throws SysException, IOException;

	public void deleteSetFile(String ID) throws SysException;
	
	public void saveTempData(String setID, String payoffDate) throws SysException;

	public List getEmpQueryItem(String userID) throws SysException;

	public void saveQueryItem(String userID, String[]showItems, String[]orderItems) throws SysException;
	
	public String queryPersonList(TableVO table, String name, String perType, String superId, int pageNum, int rowNum, String cancel, User user, String qryID, String addCondition, List<EmpQueryItemBO> queryItemList, IQueryUCC queryUCC) throws SysException;
}
