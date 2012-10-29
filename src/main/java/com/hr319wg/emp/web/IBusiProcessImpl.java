package com.hr319wg.emp.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.portal.IBusiProcess;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;

/**
 * 岗位变动影响工资
 * @author 郝威
 *
 */
public class IBusiProcessImpl implements IBusiProcess {

	@Override
	public void initWageAdjustDetailBO(WageAdjustDetailBO arg0)
			throws SysException {
//		薪级(A223200) 用户 否 代码 1 启用    
//		 薪档(A223201) 用户 否 代码 2 启用    
//		 标准工资(A223202) 用户 否 小数 3 启用
//		 职务补贴(A223207) 用户 否 小数 4 启用    
//		 浮动工资(A223203) 用户 否 小数 5 启用    
//		 午餐补贴(A223208) 用户 否 代码 8 启用    
//		 变动时间(A223204) 用户 否 八位日期 10 启用    
//		 变动原因(A223205) 用户 否 字符 11 启用    
//		 备注(A223206) 
//		String field = bo.getFieldId();
//		CommonDAO dao = (CommonDAO)SysContext.getBean("commondao");
//		if("A223200".equals(field)){//薪级
//			JdbcTemplate jdbc = (JdbcTemplate) SysContext.getBean("jdbcTemplate");
//			EmpPostChangeBO postBO = (EmpPostChangeBO) dao.findBoById(EmpPostChangeBO.class, bo.getPostChangeId());
//			String sql = "select c001203 xj from c001 where postid='"+postBO.getNewPost()+"'";
//			List post = jdbc.queryForList(sql);
//			Map m = (Map)post.get(0);
//			if(m.get("xj")!=null){
//				bo.setNewValue(m.get("xj").toString());				
//			}else{
//				bo.setNewValue(bo.getOldValue());								
//			}
//		}else if("A223201".equals(field)){//薪档
//			bo.setNewValue(bo.getOldValue());
//		}else if("A223203".equals(field)){//浮动
//			bo.setNewValue(bo.getOldValue());
//		}else if("A223204".equals(field)){//时间
//			bo.setNewValue(CommonFuns.getSysDate("yyyy-MM-dd"));
//		}else if("A223207".equals(field)){//职务
//			bo.setNewValue(bo.getOldValue());
//		}else if("A223208".equals(field)){//午餐
//			bo.setNewValue(bo.getOldValue());
//		}
//	}
	}
}
