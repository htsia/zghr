package com.hr319wg.custom.common.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.custom.pojo.bo.SetFileBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.TableVO;

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
	
	public void saveType(String userIDs, String newType) throws SysException;
}
