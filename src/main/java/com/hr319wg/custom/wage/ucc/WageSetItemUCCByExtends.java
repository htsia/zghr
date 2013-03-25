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
 * 解决问题：复制帐套时，如果是里面有私有公式，则复制该公式
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
			//如果是公式项目，且该公式是私有公式，需要复制该公式
			WageFormulaBO wfbo = (WageFormulaBO) this.getWagesetitemservice().getWfdao().findBoById(WageFormulaBO.class, item.getLinkId());
			if("0".equals(wfbo.getUsualFlag()) ){//私有
				WageFormulaBO newWfbo = new WageFormulaBO();
				BeanUtils.copyProperties(wfbo, newWfbo);
				newWfbo.setSetId(item.getSetId());//新帐套ID
				newWfbo.setUnitId(desWageSetBO.getUnitId());//新单位ID
				String newWfboId =this.getWagesetitemservice().getWfdao().createBo(newWfbo);//复制
				item.setLinkId(newWfboId);//改关联公式为复制过的
				this.getWagesetitemservice().createItem(item);
			}
		}else{
			//其它
			this.getWagesetitemservice().createItem(item);
		}

	}

}