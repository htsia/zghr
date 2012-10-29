package com.hr319wg.attence.dao;

import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.PageVO;

public class FileImportDAO extends BaseDAO {
	public List findAttExistRestBO(String personId,String date) throws SysException{
		String hsql = "select bo from AttExistRestBO bo where  bo.personId='"+personId+"' and bo.attenceDay='"+date+"' and bo.record='00901' order by bo.beginMonthValue desc";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List getAllAttPersonArrangeItemBO(String arrangeId,String createDay) throws SysException{
		String hsql = "select bo from AttPersonArrangeItemBO bo where  bo.arrangeId='"+arrangeId+"' and bo.createDay='"+createDay+"' and bo.linkClass<>'1'";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List getAllAttPersonArrangeItemBO(String arrangeId,String createDay,String deptId) throws SysException{
		String hsql = "select bo from AttPersonArrangeItemBO bo where  bo.arrangeId='"+arrangeId+"' and bo.createDay='"+createDay+"' and bo.linkClass<>'1' and bo.personId in (select vo.id from AttClassGroupVO vo where vo.deptId='"+deptId+"')";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List getAllAttPersonArrangeItemBO1(String arrangeId,String createDay) throws SysException{
		String hsql = "select bo from AttPersonArrangeItemBO bo where  bo.arrangeId='"+arrangeId+"' and bo.createDay='"+createDay+"' and bo.linkClass='1'";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List getAllAttPersonArrangeItemBO1(String arrangeId,String createDay,String deptId) throws SysException{
		String hsql = "select bo from AttPersonArrangeItemBO bo where  bo.arrangeId='"+arrangeId+"' and bo.createDay='"+createDay+"' and bo.linkClass='1' and bo.personId in (select vo.id from AttClassGroupVO vo where vo.deptId='"+deptId+"')";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List findGroupValues(String orgId) throws SysException{
		String hsql = "select bo from AttClassGroupBO bo where  bo.orgID='"+orgId+"' and bo.groupType='4'";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List findAttPersonArrangeBO(String orgId) throws SysException{
		String hsql = "select bo from AttPersonArrangeBO bo where  bo.orgId='"+orgId+"'";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List getAllAttPersonArrangeBO(PageVO mypage,String superId) throws SysException{
		String hsql = "select bo from AttPersonArrangeBO bo where bo.orgId='"+superId+"'";
		String countsql = "select count(bo) from AttPersonArrangeBO bo where bo.orgId='"+superId+"'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List findAttenceStandBO2(String orgId) throws SysException{
		String hsql = "select bo from AttenceStandBO bo where bo.record='00901' and bo.orguid='"+orgId+"' order by bo.attenceDate desc";
		return this.hibernatetemplate.find(hsql);

	} 
	
	public List findAttenceStandBO1(String orgId) throws SysException{
		String hsql = "select bo from AttenceStandBO bo where bo.orguid='"+orgId+"' order by bo.attenceDate desc";
		return this.hibernatetemplate.find(hsql);

	} 
	
	public List findAttenceWaterBO1(String orgId,String date) throws SysException{
		String hsql = "select bo from AttenceWaterBO bo where bo.orguid='"+orgId+"' and bo.attenceDate='"+date+"' order by bo.attenceDate desc";
		return this.hibernatetemplate.find(hsql);

	} 
	
	public List findAttenceWaterBO2(String orgId,String date) throws SysException{
		String hsql = "select bo from AttenceWaterBO bo where bo.orguid='"+orgId+"' and bo.attenceDate='"+date+"' and bo.record='00901'";
		return this.hibernatetemplate.find(hsql);

	} 
	
	public List findAttenceWaterBO3(String orgId,String date) throws SysException{
		String hsql = "select bo from AttenceWaterBO bo where bo.orguid in (select vo.deptId from AttClassGroupVO vo where  vo.orgId='"+orgId+"') and bo.attenceDate='"+date+"' and bo.record='00901'";
		return this.hibernatetemplate.find(hsql);

	} 
	
	public List findAttenceWeekWaterBO1(String orgId,String date,String weekdate) throws SysException{
		String hsql = "select bo from AttenceWeekWaterBO bo where bo.orguid='"+orgId+"' and bo.attenceDate='"+date+"' and bo.attenceWeekDate='"+weekdate+"' order by bo.attenceDate desc";
		return this.hibernatetemplate.find(hsql);

	} 
	
	public List findAttenceStandBO(String subId,String orgId) throws SysException{
		String hsql = "select bo from AttenceStandBO bo where bo.subID='"+subId+"' and bo.orguid='"+orgId+"'";
		return this.hibernatetemplate.find(hsql);
   
	} 
	
	public List findAttenceWaterBO(String subId,String orgId) throws SysException{
		String hsql = "select bo from AttenceWaterBO bo where bo.subID='"+subId+"' and bo.orguid='"+orgId+"'";
		return this.hibernatetemplate.find(hsql);
   
	} 
	
	public List findAttenceWeekWaterBO(String subId,String orgId) throws SysException{
		String hsql = "select bo from AttenceWeekWaterBO bo where bo.subID='"+subId+"' and bo.orguid='"+orgId+"'";
		return this.hibernatetemplate.find(hsql);
   
	} 
	
	public List getAllAttenceStandBO(PageVO mypage) throws SysException{
		String hsql = "select bo from AttenceStandBO bo where bo.record='00901'";
		String countsql = "select count(bo) from AttenceStandBO bo where bo.record='00901'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttenceStandBO(PageVO mypage,String orgId) throws SysException{
		String hsql = "select bo from AttenceStandBO bo where bo.record='00901' and bo.orguid='"+orgId+"'";
		String countsql = "select count(bo) from AttenceStandBO bo where bo.record='00901' and bo.orguid='"+orgId+"'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttenceWaterBO(PageVO mypage,String date) throws SysException{
		String hsql = "select bo from AttenceWaterBO bo where  bo.record='00901'";
		String countsql = "select count(bo) from AttenceWaterBO bo where  bo.record='00901'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttenceWaterBO(PageVO mypage,String date,String orgId) throws SysException{
		String hsql = "select bo from AttenceWaterBO bo where  bo.record='00901' and bo.orguid='"+orgId+"'";
		String countsql = "select count(bo) from AttenceWaterBO bo where  bo.record='00901' and bo.orguid='"+orgId+"'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttenceWeekWaterBO(PageVO mypage,String date) throws SysException{
		String hsql = "select bo from AttenceWeekWaterBO bo where  bo.record='00901'";
		String countsql = "select count(bo) from AttenceWeekWaterBO bo where  bo.record='00901'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttenceWeekWaterBO(PageVO mypage,String date,String orgId) throws SysException{
		String hsql = "select bo from AttenceWeekWaterBO bo where  bo.record='00901' and bo.orguid='"+orgId+"'";
		String countsql = "select count(bo) from AttenceWeekWaterBO bo where  bo.record='00901' and bo.orguid='"+orgId+"'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getInfoItemBO(String setId) throws SysException{
		String hsql = "select bo from InfoItemBO bo where bo.setId='"+setId+"' and bo.itemId<>'ID' and bo.itemId<>'SUBID' ";
		hsql+=" and bo.itemId<>'A811000' and bo.itemId<>'A811700' and bo.itemId<>'A811701' and bo.itemId<>'A811702' and bo.itemId<>'A811703'";
		return this.hibernatetemplate.find(hsql);
   
	}
	

	

	
	public List getAttFileImportBO(PageVO pagevo,String orgid) throws SysException{
		String hsql = "select bo from AttFileImportBO bo where bo.orgID='"+orgid+"'";
		return this.hibernatetemplate.find(hsql);
   
	}
	
	public List getAttFileImportItemBO(String itemID) throws SysException{
		String hsql = "select bo from AttFileImportItemBO bo where bo.importID='"+itemID+"'";
		return this.hibernatetemplate.find(hsql);
   
	} 
	

	public List getAttImportAll(PageVO mypage) throws SysException{
		String hsql = "select bo from AttImportLogBO bo where 1=1 order by bo.logID desc";
		String countsql = "select count(bo) from AttImportLogBO bo where 1=1";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttPersonClassManagerBO(PageVO mypage,String orgId,String superId) throws SysException{
		String hsql = "select bo from AttPersonClassManagerBO bo where bo.orgId='"+orgId+"' and bo.deptId='"+superId+"'";
		String countsql = "select count(bo) from AttPersonClassManagerBO bo where bo.orgId='"+orgId+"' and bo.deptId='"+superId+"'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List findAttPersonClassManagerBO(String orgId,String superId) throws SysException{
		String hsql = "select bo from AttPersonClassManagerBO bo where  bo.orgId='"+orgId+"' and bo.deptId='"+superId+"'";
		return this.hibernatetemplate.find(hsql);
	}
	
	public List getAllAttManagerArrangeBO(PageVO mypage,String superId) throws SysException{
		String hsql = "select bo from AttManagerArrangeBO bo where bo.orgId='"+superId+"'";
		String countsql = "select count(bo) from AttManagerArrangeBO bo where bo.orgId='"+superId+"'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List findAttManagerArrangeBO(String orgId) throws SysException{
		String hsql = "select bo from AttManagerArrangeBO bo where  bo.orgId='"+orgId+"'";
		return this.hibernatetemplate.find(hsql);
	}
	
	public List getAllAttManagerArgumentBO(PageVO mypage,String superId) throws SysException{
		String hsql = "select bo from AttManagerArgumentBO bo where bo.orgId in (select vo.deptId from AttClassGroupVO vo where  vo.orgId='"+superId+"')";
		String countsql = "select count(bo) from AttManagerArgumentBO bo where bo.orgId in (select vo.deptId from AttClassGroupVO vo where  vo.orgId='"+superId+"')";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttManagerArgumentBO(String superId) throws SysException{
		String hsql = "select bo from AttManagerArgumentBO bo where bo.orgId in (select vo.deptId from AttClassGroupVO vo where  vo.orgId='"+superId+"')";		
		return this.hibernatetemplate.find(hsql);
	}
	
	public List getAllAttManagerArgumentBO1(String deptId) throws SysException{
		String hsql = "select bo from AttManagerArgumentBO bo where bo.orgId='"+deptId+"'";		
		return this.hibernatetemplate.find(hsql);
	}
	
	public List getAllAttPersonArrangeItemBO2(String arrangeId,String deptId) throws SysException{
		String hsql = "select bo from AttPersonArrangeItemBO bo where  bo.arrangeId='"+arrangeId+"' and bo.personId in (select vo.id from AttClassGroupVO vo where vo.deptId='"+deptId+"')";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List findAttManagerArgumentBO(String deptId) throws SysException{
		String hsql = "select bo from AttManagerArgumentBO bo where bo.orgId='"+deptId+"'";
		return this.hibernatetemplate.find(hsql);
	}
	
	public List findCountAttPersonArrangeItemBO1(String arrangeId,String day,String orgId) throws SysException{
		String hsql = "select xo from AttClassGroupVO xo where xo.id in (select bo.personId from AttPersonArrangeItemBO bo where  bo.arrangeId='"+arrangeId+"' and bo.createDay='"+day+"' and bo.linkClass<>'1' and bo.personId in (select vo.id from AttClassGroupVO vo where vo.deptId='"+orgId+"'))";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List findCountAttPersonArrangeItemBO2(String arrangeId,String day,String orgId) throws SysException{
		String hsql = "select xo from AttClassGroupVO xo where xo.id in (select bo.personId from AttPersonArrangeItemBO bo where  bo.arrangeId='"+arrangeId+"' and bo.createDay='"+day+"' and bo.linkClass='1' and bo.personId in (select vo.id from AttClassGroupVO vo where vo.deptId='"+orgId+"'))";
		return this.hibernatetemplate.find(hsql);
	} 
	
	public List getAllAttTimeOffRecBO(PageVO mypage,String overTimeNO) throws SysException{
		String hsql = "select bo from AttTimeOffRecBO bo where bo.overTimeNO='"+overTimeNO+"'";
		String countsql = "select count(bo) from AttTimeOffRecBO bo where bo.overTimeNO='"+overTimeNO+"'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttTimeOffRecBO(String overTimeNO) throws SysException{
		String hsql = "select bo from AttTimeOffRecBO bo where bo.overTimeNO='"+overTimeNO+"'";
		return this.hibernatetemplate.find(hsql);
	}
	
	public List getAllAttAnnualDetailAuditBO(PageVO mypage,String furloughNO) throws SysException{
		String hsql = "select bo from AttAnnualDetailAuditBO bo where bo.furloughno='"+furloughNO+"'";
		String countsql = "select count(bo) from AttAnnualDetailAuditBO bo where bo.furloughno='"+furloughNO+"'";		
		return this.pageQuery(mypage, countsql, hsql);
	}
	
	public List getAllAttAnnualDetailAuditBO(String furloughNO) throws SysException{
		String hsql = "select bo from AttAnnualDetailAuditBO bo where bo.furloughno='"+furloughNO+"'";	
		return this.hibernatetemplate.find(hsql);
	}
}
