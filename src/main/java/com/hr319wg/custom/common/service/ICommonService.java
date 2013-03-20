package com.hr319wg.custom.common.service;

import java.util.List;
import java.util.Map;

import com.hr319wg.common.exception.SysException;

public interface ICommonService {

	public void batchUpdateEmpUploadFile(String setID, String mode, String[]fields, List<Map> list) throws SysException;
}
