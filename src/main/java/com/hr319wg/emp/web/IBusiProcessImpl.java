package com.hr319wg.emp.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.portal.IBusiProcess;
import com.hr319wg.wage.pojo.bo.WageAdjustDetailBO;

/**
 * ��λ�䶯Ӱ�칤��
 * @author ����
 *
 */
public class IBusiProcessImpl implements IBusiProcess {

	@Override
	public void initWageAdjustDetailBO(WageAdjustDetailBO arg0)
			throws SysException {
//		н��(A223200) �û� �� ���� 1 ����    
//		 н��(A223201) �û� �� ���� 2 ����    
//		 ��׼����(A223202) �û� �� С�� 3 ����
//		 ְ����(A223207) �û� �� С�� 4 ����    
//		 ��������(A223203) �û� �� С�� 5 ����    
//		 ��Ͳ���(A223208) �û� �� ���� 8 ����    
//		 �䶯ʱ��(A223204) �û� �� ��λ���� 10 ����    
//		 �䶯ԭ��(A223205) �û� �� �ַ� 11 ����    
//		 ��ע(A223206) 
//		String field = bo.getFieldId();
//		CommonDAO dao = (CommonDAO)SysContext.getBean("commondao");
//		if("A223200".equals(field)){//н��
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
//		}else if("A223201".equals(field)){//н��
//			bo.setNewValue(bo.getOldValue());
//		}else if("A223203".equals(field)){//����
//			bo.setNewValue(bo.getOldValue());
//		}else if("A223204".equals(field)){//ʱ��
//			bo.setNewValue(CommonFuns.getSysDate("yyyy-MM-dd"));
//		}else if("A223207".equals(field)){//ְ��
//			bo.setNewValue(bo.getOldValue());
//		}else if("A223208".equals(field)){//���
//			bo.setNewValue(bo.getOldValue());
//		}
//	}
	}
}
