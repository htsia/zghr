package com.hr319wg.custom.wage.ucc;

import java.util.List;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.BeanUtilsBean2;
import org.springframework.beans.BeanUtils;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.ucc.IWageSetItemUCC;
import com.hr319wg.wage.ucc.impl.WageSetItemUCC;

/**
 * ������⣺��������ʱ�������������˽�й�ʽ�����Ƹù�ʽ
 * @author chl
 *
 */
public class WageSetItemUCCByExtends extends WageSetItemUCC
implements IWageSetItemUCC
{
	public void copyset(String des, String source)
	{
		try {
			WageSetBO wageSetBO = (WageSetBO) this.getWagesetservice().getWagesetdao().findBoById(WageSetBO.class,des);
			List li = queryItemBySetId(source);
			for (int i = 0; i < li.size(); ++i) {
				WageSetItemBO ws = (WageSetItemBO)li.get(i);
				WageSetItemBO newWs = new WageSetItemBO();
				
				BeanUtils.copyProperties(ws, newWs);
				newWs.setSetId(des);
				newWs.setItemId(null);
				createCopyedItem(wageSetBO,newWs);
			}
		}
		catch (Exception e) {
		}
	}

	public void createCopyedItem(WageSetBO desWageSetBO ,WageSetItemBO item) throws SysException {
		this.getWagesetitemservice().createItem(item);
		if ((item.gettype().equals("2")) && (!("".equals(item.getDefaultValue())))) {//
			this.getWagesetpersonservice().updateInputItemValue(item.getSetId(), item.getField(), item.getDefaultValue());
			this.getWagecomputeservice().updateInputItemValue(item.getSetId(), item.getField(), item.getDefaultValue());
		}
		else if(item.gettype().equals("1") ){
			//����ǹ�ʽ��Ŀ���Ҹù�ʽ��˽�й�ʽ����Ҫ���Ƹù�ʽ
			WageFormulaBO wfbo = (WageFormulaBO) this.getWagesetitemservice().getWfdao().findBoById(WageFormulaBO.class, item.getLinkId());
			if("0".equals(wfbo.getUsualFlag()) ){//˽��
				WageFormulaBO newWfbo = new WageFormulaBO();
				BeanUtils.copyProperties(wfbo, newWfbo);
				newWfbo.setSetId(item.getSetId());//������ID
				newWfbo.setUnitId(desWageSetBO.getUnitId());//�µ�λID
				String newWfboId =this.getWagesetitemservice().getWfdao().createBo(newWfbo);//����
				item.setLinkId(newWfboId);//�Ĺ�����ʽΪ���ƹ���
				this.getWagesetitemservice().createItem(item);
			}
		}else{
			//����
			this.getWagesetitemservice().createItem(item);
		}

	}

}