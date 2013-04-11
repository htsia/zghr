package com.hr319wg.custom.extend.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.faces.model.SelectItem;
import javax.servlet.http.HttpServletRequest;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.dao.CodeSetDAO;
import com.hr319wg.sys.pojo.bo.CodeSetBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.wage.pojo.bo.WageStandardBO;
import com.hr319wg.wage.pojo.bo.WageStdItemBO;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.hr319wg.wage.pojo.vo.WageStandardVO;
import com.hr319wg.wage.web.WageStandardBackingBean;

public class WageStandardBackingBeanByExtend extends WageStandardBackingBean {

	private WageStandardVO stdVO;
	private String hCode;
	private String vCode;
	private List codeSet;

	public String gethCode() {
		return hCode;
	}

	public void sethCode(String hCode) {
		this.hCode = hCode;
	}

	public String getvCode() {
		return vCode;
	}

	public void setvCode(String vCode) {
		this.vCode = vCode;
	}

	public List getCodeSet() {
		this.codeSet = new ArrayList();
		SelectItem si0 = new SelectItem();
		si0.setValue("-1");
		si0.setLabel("--请选择--");
		this.codeSet.add(si0);
		try {
			CodeSetDAO setDao = (CodeSetDAO) SysContext.getBean("sys_CodeSetDAO");
			List<CodeSetBO> list1 = setDao.queryCodeSets(true, "wage", super.getUserInfo().getOrgId());
			if(list1!=null){
				for(CodeSetBO set : list1){
					SelectItem si = new SelectItem();
					si.setValue(set.getSetId());
					si.setLabel(set.getSetName());
					this.codeSet.add(si);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return this.codeSet;
	}

	public void setCodeSet(List codeSet) {
		this.codeSet = codeSet;
	}
	
	public String getPageInit() {
	    String act = super.getServletRequest().getParameter("act");
	    String persId = super.getUserInfo().getUserId();
	    PersonBO person = SysCacheTool.findPersonById(persId);
	    String userUnitId = person.getGongZiGX();
	    if ("list".equals(act)) {
	      this.setUnitId(super.getServletRequest().getParameter("unitId"));

	      WageUnitBO userUnit = SysCacheTool.findWageUnit(userUnitId);
	      if (userUnit == null) {
	        super.showMessageDetail("错误：用户没有发薪单位");
	        return "";
	      }

	      this.setOperRight(this.getUnitId().equals(userUnit.getUnitId()));

	      if (this.getStandard() == null){
	    	  this.setStandard(new WageStandardBO());
	      }
	      this.getStandard().setUnitId(this.getUnitId());
	      this.setStdList(queryStdList(this.getUnitId()));
	      super.getHttpSession().removeAttribute("stdVO");
	      this.setUnitName(CodeUtil.interpertCode("WAGE", this.getUnitId()));
	    }
	    return this.pageInit;
	  }
	private List queryStdList(String unitId) {
	    List list = new ArrayList();
	    try {
	      List issueStd = this.getWagestandarducc().queryIssueStandard();
	      if (issueStd != null) {
	        int count = issueStd.size();
	        for (int i = 0; i < count; i++) {
	          WageStandardBO tmp = (WageStandardBO)issueStd.get(i);
	          tmp.setPublicFlag(CodeUtil.interpertCode("", tmp.getPublicFlag()));
	          Object[] obj = new Object[3];
	          obj[0] = tmp;
	          if (!unitId.equals(tmp.getUnitId())) {
	            obj[1] = "disabled";
	            obj[2] = new Boolean(false);
	          } else {
	            obj[1] = "";
	            obj[2] = new Boolean(true);
	          }
	          list.add(obj);
	        }
	      }
	      List unitStd = this.getWagestandarducc().queryStandardByUnitId(unitId);
	      if (unitStd != null) {
	        int count = unitStd.size();
	        for (int i = 0; i < count; i++) {
	          WageStandardBO tmp = (WageStandardBO)unitStd.get(i);
	          if ("00900".equals(tmp.getPublicFlag())) {
	            tmp.setPublicFlag(CodeUtil.interpertCode("", tmp.getPublicFlag()));
	            Object[] obj = new Object[3];
	            obj[0] = tmp;
	            obj[1] = "";
	            obj[2] = new Boolean(true);
	            list.add(obj);
	          }
	        }
	      }
	      return list;
	    }
	    catch (SysException e) {
	      super.showMessageDetail("错误:" + e.getMessage());
	    }
	    return list;
	  }
	public String step1_create() {
		WageStandardBO std = new WageStandardBO();
		std.setUnitId(this.getStandard().getUnitId());
		this.setStandard(std);
		this.setCanEdit(true);
		super.getServletRequest().removeAttribute("act");
		return step1_setItem();
	}
	
	public String step1_setItem()
	  {
	    String stdId = this.getStandard().getStdId();
	    this.stdVO = ((WageStandardVO)super.getHttpSession().getAttribute("stdVO"));
	    try {
	      if ((stdId != null) && (!"".equals(stdId)) && (this.stdVO == null)) {
	        this.stdVO = new WageStandardVO();
	        ArrayList h_list = (ArrayList)this.getWagestandarducc().queryStdItemByType(stdId, "0");
	        this.stdVO.setH_item(h_list);
	        if(h_list!=null && h_list.size()>0){
	        	WageStdItemBO std = (WageStdItemBO)h_list.get(0);
	        	String codeSet=std.getCodeSetId();
	        	CodeSetBO set= SysCacheTool.findCodeSet(codeSet);
	        	if(set.getCreateUnit()!=null || "1".equals(set.getPublicFlag())){
	        		this.hCode=codeSet;
	        	}
	        }
	        
	        ArrayList v_list = (ArrayList)this.getWagestandarducc().queryStdItemByType(stdId, "1");
	        this.stdVO.setV_item(v_list);
	        if(v_list!=null && v_list.size()>0){
	        	WageStdItemBO std = (WageStdItemBO)v_list.get(0);
	        	String codeSet=std.getCodeSetId();
	        	CodeSetBO set= SysCacheTool.findCodeSet(codeSet);
	        	if(set.getCreateUnit()!=null || "1".equals(set.getPublicFlag())){
	        		this.vCode=codeSet;
	        	}
	        }
	        
	        ArrayList r_list = (ArrayList)this.getWagestandarducc().queryStdItemByType(stdId, "2");
	        this.stdVO.setR_item(r_list);

	        WageStdItemBO bo = (WageStdItemBO)r_list.get(0);
	        InfoItemBO infoitem = SysCacheTool.findInfoItem(bo.getTable(), bo.getField());
	        this.getStandard().setName(infoitem.getItemName());
	        List vList= this.stdVO.getV_item();
	        
	        
	        super.getHttpSession().setAttribute("stdVO", this.stdVO);
	      } else if (this.stdVO == null) {
	        this.stdVO = new WageStandardVO();
	        super.getHttpSession().setAttribute("stdVO", this.stdVO);
	      }
	    }
	    catch (SysException e) {
	      super.showMessageDetail("错误:" + e.getMessage());
	    }
	    super.getServletRequest().removeAttribute("act");
	    this.setCanEdit(true);
	    return "editItem";
	  }
	
	
	public String step2_setCode()
	  {
	    this.stdVO = ((WageStandardVO)super.getHttpSession().getAttribute("stdVO"));
	    HttpServletRequest request = super.getServletRequest();
	    String[] vItemIds = request.getParameterValues("VItemIds");
	    String[] hItemIds = request.getParameterValues("HItemIds");
	    String[] rItemIds = request.getParameterValues("RItemIds");
	    this.stdVO.setR_item(handleItem(rItemIds, "2", this.stdVO.getR_item()));
	    if (vItemIds != null) {
	      this.stdVO.setV_item(handleItem(vItemIds, "1", this.stdVO.getV_item()));
	    }
	    if (hItemIds != null) {
	    	this.stdVO.setH_item(handleItem(hItemIds, "0", this.stdVO.getH_item()));
	    }
	    super.getHttpSession().setAttribute("stdVO", this.stdVO);
	    return "editCode";
	  }

	private ArrayList handleItem(String[] item, String type, ArrayList list) {
	    ArrayList newList = new ArrayList();
	    if ((item != null) && (item.length > 0)) {
	      Hashtable hash = new Hashtable();
	      if ((list != null) && (list.size() > 0)) {
	        int size = list.size();
	        for (int i = 0; i < size; i++) {
	          WageStdItemBO stm = (WageStdItemBO)list.get(i);
	          if("1".equals(type) && "-1".equals(this.vCode)){
	        	  InfoItemBO infoitem = SysCacheTool.findInfoItem(stm.getField().substring(0, 4), stm.getField());
	        	  stm.setCodeSetId(infoitem.getItemCodeSet());
	          }else if("1".equals(type) && this.vCode!=null && !"-1".equals(this.vCode)){
	        	  stm.setCodeSetId(this.vCode);
	          }
	          if("0".equals(type) && "-1".equals(this.hCode)){
	        	  InfoItemBO infoitem = SysCacheTool.findInfoItem(stm.getField().substring(0, 4), stm.getField());
	        	  stm.setCodeSetId(infoitem.getItemCodeSet());
	          }else if("0".equals(type) && this.hCode!=null && !"-1".equals(this.hCode)){
	        	  stm.setCodeSetId(this.hCode);
	          }
	          hash.put(stm.getField(), stm);
	        }
	      }
	      for (int i = 0; i < item.length; i++) {
	        InfoItemBO infoitem = SysCacheTool.findInfoItem(item[i].substring(0, 4), item[i]);
	        if (hash.containsKey(infoitem.getItemId())) {
	          newList.add(hash.get(infoitem.getItemId()));
	        } else {
	          WageStdItemBO stditem = new WageStdItemBO();
	          stditem.setType(type);
	          stditem.setTable(item[i].substring(0, 4));
	          stditem.setField(infoitem.getItemId());
	          stditem.setDataType(infoitem.getItemDataType());
	          stditem.setCodeSetId(infoitem.getItemCodeSet());
	          if("1".equals(type) && this.vCode!=null && !"-1".equals(this.vCode)){
	        	  stditem.setCodeSetId(this.vCode);
	          }
	          if("0".equals(type) && this.hCode!=null && !"-1".equals(this.hCode)){
	        	  stditem.setCodeSetId(this.hCode);
	          }
	          
	          newList.add(stditem);

	          if (type.equals("2"))
	            this.getStandard().setName(infoitem.getItemName() + "标准");
	        }
	      }
	      hash.clear();
	      hash = null;
	    }
	    return newList;
	  }
	
}
