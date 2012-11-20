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
	
	//��ȡ����ʱ
	public List getAllClassWageBO(PageVO pageVo, String orgID, String personType, String nameStr, String operUserID, String inself) throws SysException;
	//��ȡ��������ʱ
	public List getAllClassWageBO() throws SysException;
	
	//��ӳ���ʱ��Ա
	public void addClassUser(String[]selectedUserIDs, String operUserID) throws SysException;
	//ɾ������ʱ��Ա
	public void deleteClassUser(String subID) throws SysException;
	//����
	public void calcClassWage() throws SysException;
	
	//���뵽����
	public void addToWageset() throws SysException;
	
	//������ڹ���Ա
	public void saveWageEmpPerson(UserBO user, String wage, String other) throws SysException;
	//������ڹ���Ա
	public void batchSaveWageEmpPerson(List<Map> list) throws SysException;
	//ɾ�����ڹ���Ա
	public void deleteWageEmpPerson(String userID) throws SysException;
	
	//�Ƿ���ӹ���Ա1�Ѿ����  0δ���
	public int getWageDataSetUserCount(String setID, String userID) throws SysException;
	//�Ƿ���ӹ�����������Ա1�Ѿ����  0δ���
	public int getWageDataOthersSetUserCount(String setID, String userID) throws SysException;
	
	public void deleteWageDataSetBOByID(String ID) throws SysException;
	
	//��ȡ��Ͻ������
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
	
	//�޸Ŀ۷��ⷿ��ů���ѽ��
	public void modifyUserMoney(String userID, String money, String yearMonth, String itemType) throws SysException;
	//����1��Ŀ�����ܶ�
	public String getWageDataOther1SumByID(String setID) throws SysException;
	
	//1�Ӱ�ѡ�2�����ﲹ����5���з�
	//��ȡ�Ӱ�ѡ������ﲹ����Ա
	public List getAllWageLitleUserBO(PageVO pageVo, String itemType, String orgID, String personType, String nameStr, String operUserID) throws SysException;
	
	//��ӼӰ�ѡ������ﲹ����Ա
	public void addWageLitleUser(String itemType,String selectedUserIDs, String operUserID) throws SysException;
	//��������Ӱ�ѡ������ﲹ����Ա
	public void batchAddWageLitleUser(String itemType,String selectedUserIDs,String money, String operUserID) throws SysException;
	//ɾ���Ӱ�ѡ������ﲹ����Ա
	public void deleteWageLitleUser(String itemType,String userID, String operType, String operUserID) throws SysException;
	//���¼Ӱ�ѡ������ﲹ����Ա
	public void updateWageLitleUser(String itemType,String money, String userID, String operUserID) throws SysException;
	//�鵵�Ӱ�ѡ������ﲹ����Ա
	public void updateWageLitle(String itemType,String yearMonth, String operUserID) throws SysException;
	
	/**
	 * ��˾������2����
	 * @throws SysException 
	 */
	public void updateWageData(String yearMonth, String userID, String orgID ,String itemType, String setID, String operType) throws SysException;
	
	/**
	 * ��������1��������1,������2��������2
	 * @throws SysException 
	 */
	public void updateWageDataOther1(String itemType, String yearMonth, String selectedItemIDs, String operUserID) throws SysException;
	
	/**
	 * ͬ���۷��ⷿ��ů��������
	 * @throws SysException 
	 */
	public void updateWageDataSigle(String yearMonth, String orgID ,String itemType, String userID, String operUserID) throws SysException;
	//���sigle����
	public void deleteWageDataSigle(String itemType, String userID, String operUserID) throws SysException;
	
	//����
	public List getWageSet(String operUserID);
	public List getAllWageSetBO(String itemType, String wageDate);
	
	
	//other��Ŀ�ܶ�
	public double getWageOtherItemSum(String itemType, String wageDate, String wageSetID);
	//litle��Ŀ�ܶ�
	public double getWageLitleItemSum(String itemType, String wageDate, String wageSetID);
	//others��Ŀ�ܶ�
	public double getWageOthersItemSum(String itemType, String wageDate);
	
	//other��Ŀ��ϸ
	public List getWageOtherItemDetail(String itemType, String itemId, String wageDate, String userID, String wageSetID) throws SysException;
	//litle��Ŀ��ϸ
	public List getWageLitleItemDetail(String itemType, String wageDate, String userID, String wageSetID) throws SysException;
	//others��Ŀ��ϸ
	public List getWageOthersItemDetail(String itemType, String wageDate);
	
	//other������Ŀ��ϸ
	public List getSelfWageOtherItemDetail(String itemType, String wageDate, String userID) throws SysException;
	//litle������Ŀ��ϸ
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
