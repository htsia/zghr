package com.hr319wg.custom.common.service;

import java.util.List;
import java.util.Map;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.TableVO;

public interface ICommonService {

	public void batchUpdateEmpUploadFile(String setID, String mode, String[]fields, List<Map> list) throws SysException;
	
	public String getChangeInfo(TableVO table, List showItems, String unitId, String filter);
	
	public void updateInfoItem(InfoItemBO item) throws SysException;
	
	public List getWageMinusList(String setID) throws SysException;
}
