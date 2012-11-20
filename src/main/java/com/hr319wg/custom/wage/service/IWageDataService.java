package com.hr319wg.custom.wage.service;

import java.util.List;
import java.util.Map;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.pojo.bo.UserBO;
import com.hr319wg.custom.wage.pojo.bo.WageDataSetBO;

public interface IWageDataService {

	public void setOAEmail(String userID1, String userID2, String userID3) throws SysException;
	
	public void saveOrUpdateObject(Object obj) throws SysException;
	
	public void setTotalMoney(String itemID) throws SysException;
	
	public Object findBOById(Class c, String id) throws SysException;
	
	//获取超课时
	public List getAllClassWageBO(PageVO pageVo, String orgID, String personType, String nameStr, String operUserID, String inself) throws SysException;
	//获取导出超课时
	public List getAllClassWageBO() throws SysException;
	
	//添加超课时人员
	public void addClassUser(String[]selectedUserIDs, String operUserID) throws SysException;
	//删除超课时人员
	public void deleteClassUser(String subID) throws SysException;
	//计算
	public void calcClassWage() throws SysException;
	
	//加入到帐套
	public void addToWageset() throws SysException;
	
	//保存短期工人员
	public void saveWageEmpPerson(UserBO user, String wage, String other) throws SysException;
	//保存短期工人员
	public void batchSaveWageEmpPerson(List<Map> list) throws SysException;
	//删除短期工人员
	public void deleteWageEmpPerson(String userID) throws SysException;
	
	//是否添加过人员1已经添加  0未添加
	public int getWageDataSetUserCount(String setID, String userID) throws SysException;
	//是否添加过工资杂项人员1已经添加  0未添加
	public int getWageDataOthersSetUserCount(String setID, String userID) throws SysException;
	
	public void deleteWageDataSetBOByID(String ID) throws SysException;
	
	//获取管辖的帐套
	public List getAllWagesetBOByUserID(String operUserID) throws SysException;
	
	public void deleteWageDataSetUserBOByID(String ID) throws SysException;
	
	public Object getObjectByID(Class c ,String ID) throws SysException;
	public List getAllWageEmpUserBO(PageVO pageVo, boolean hasWage, boolean noWage, boolean hasCash, boolean hasNoCash, String orgID, String personType, String nameStr) throws SysException;
	
	public List getAllWageDataSetBO(String yearMonth, String selectedItemIDs, String itemType) throws SysException;
	
	public List getAllWageDataSetBOByUserID(PageVO pageVo, String userID, String itemType, String beginDate, String endDate, String[]status, String operUserID) throws SysException;

	public List getAllWageDataSetUserBO(PageVO pageVo, WageDataSetBO item, String orgID, String personType, String nameStr, String inself, String operUserID) throws SysException;

	public List getAllWageDataSetUserBOByInfo(PageVO pageVo,String yearMonth, String selectedItemIDs, String orgID, String itemType, String personType, String nameStr, String operUserID) throws SysException;
	
	public List getAllWageDateSigleBO(PageVO pageVo, String orgID, String itemType, String isVerify, String yearMonth, String personType, String nameStr, boolean verifyFlag, String inself, String operUserID) throws SysException;
	
	public String getWageUserVerifyStatus(String datasetUserID, String yearMonth) throws SysException;
	
	//修改扣房租房补暖气费金额
	public void modifyUserMoney(String userID, String money, String yearMonth, String itemType) throws SysException;
	//其他1项目已用总额
	public String getWageDataOther1SumByID(String setID) throws SysException;
	
	//1加班费、2车公里补贴、5科研费
	//获取加班费、车公里补贴人员
	public List getAllWageLitleUserBO(PageVO pageVo, String itemType, String orgID, String personType, String nameStr, String operUserID) throws SysException;
	
	//添加加班费、车公里补贴人员
	public void addWageLitleUser(String itemType,String selectedUserIDs, String operUserID) throws SysException;
	//批量导入加班费、车公里补贴人员
	public void batchAddWageLitleUser(String itemType,String selectedUserIDs,String money, String operUserID) throws SysException;
	//删除加班费、车公里补贴人员
	public void deleteWageLitleUser(String itemType,String userID, String operType, String operUserID) throws SysException;
	//更新加班费、车公里补贴人员
	public void updateWageLitleUser(String itemType,String money, String userID, String operUserID) throws SysException;
	//归档加班费、车公里补贴人员
	public void updateWageLitle(String itemType,String yearMonth, String operUserID) throws SysException;
	
	/**
	 * 审核捐款其他2数据
	 * @throws SysException 
	 */
	public void updateWageData(String yearMonth, String userID, String orgID ,String itemType, String setID, String operType) throws SysException;
	
	/**
	 * 更新其他1、扣其他1,捐款、其他2、扣其他2
	 * @throws SysException 
	 */
	public void updateWageDataOther1(String itemType, String yearMonth, String selectedItemIDs, String operUserID) throws SysException;
	
	/**
	 * 同步扣房租房补暖气费数据
	 * @throws SysException 
	 */
	public void updateWageDataSigle(String yearMonth, String orgID ,String itemType, String userID, String operUserID) throws SysException;
	//清空sigle数据
	public void deleteWageDataSigle(String itemType, String userID, String operUserID) throws SysException;
	
	//帐套
	public List getWageSet(String operUserID);
	public List getAllWageSetBO(String itemType, String wageDate);
	
	
	//other项目总额
	public double getWageOtherItemSum(String itemType, String wageDate, String wageSetID);
	//litle项目总额
	public double getWageLitleItemSum(String itemType, String wageDate, String wageSetID);
	//others项目总额
	public double getWageOthersItemSum(String itemType, String wageDate);
	
	//other项目明细
	public List getWageOtherItemDetail(String itemType, String itemId, String wageDate, String userID, String wageSetID) throws SysException;
	//litle项目明细
	public List getWageLitleItemDetail(String itemType, String wageDate, String userID, String wageSetID) throws SysException;
	//others项目明细
	public List getWageOthersItemDetail(String itemType, String wageDate);
	
	//other个人项目明细
	public List getSelfWageOtherItemDetail(String itemType, String wageDate, String userID) throws SysException;
	//litle个人项目明细
	public double getSelfWageLitleItemDetail(String itemType, String userID) throws SysException;
	public double getWageSigleSum(String itemType);
	public List getWageSigleDetail(String itemType);
	
	public List getWageSetDetail(String setID);

	public List getAllWageOthersDataSetBOByUserID(PageVO pageVo, String operUserID, String beginDate, String endDate,boolean notReview,boolean Reviewed) throws SysException;
	public void deleteWageOthersDataSetBOByID(String ID) throws SysException;
	public void deleteWageOthersDataSetUserBOByID(String ID) throws SysException;
	public List getAllWageOthersDataSetUserBO(PageVO pageVo, String setID, String orgID, String personType, String nameStr, String operUserID) throws SysException;
	public List getAllWageOthersDataSetUserBOByInfo(PageVO pageVo,String yearMonth, String orgID, String personType, String nameStr) throws SysException;
	public List getItemList(String setId);

	public void confirm(String[]selectedItemIDs, String yearmonth, String operUserID) throws SysException;
	
	public void averageMoney(String setID, String money) throws SysException;
	public void modifyUserMoney1(String setID,String userID, String money) throws SysException;
}
