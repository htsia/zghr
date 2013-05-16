package com.hr319wg.custom.extend.web;

import java.util.List;
import java.util.Vector;

import com.hr319wg.common.exception.RollbackableException;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.custom.common.service.ICommonService;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.dao.ParameterDAO;
import com.hr319wg.sys.pojo.bo.ParameterBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.wage.pojo.bo.WageComputeHisBO;
import com.hr319wg.wage.util.WageTools;
import com.hr319wg.wage.web.WageComputeBackingBean;

public class WageComputeBackingBeanByExtend extends WageComputeBackingBean {
	private String minusInit;
	private boolean showMinus;
	private ICommonService commonService;
	private ParameterDAO parameterDAO;
	
	public ParameterDAO getParameterDAO() {
		return parameterDAO;
	}

	public void setParameterDAO(ParameterDAO parameterDAO) {
		this.parameterDAO = parameterDAO;
	}

	public ICommonService getCommonService() {
		return commonService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}
	
	public String getPageInit() {
	    if (!"isPostBack".equals(this.pageInit)) {
	      this.setOrderByName(true);
	      this.setReadOnlyItem(false);
	      try {
	        this.setReportList(this.getUserreportucc().queryUserRptToWebInWage(super.getUserInfo().getUserId(), "0648", this.getSetId()));
	      }
	      catch (SysException ee) {
	      }
	      this.pageInit = "isPostBack";
	    }

	    super.getHttpSession().removeAttribute("activeSql2");
	    super.getHttpSession().removeAttribute("rowNum2");
	    super.getHttpSession().removeAttribute("pageNum2");
	    super.getHttpSession().removeAttribute("OBJECT2");

	    String pageFlag = super.getServletRequest().getParameter("pageFlag");
	    if ("1".equals(pageFlag)) {
	      turnPageQuery(null, null, 0, 0);
	    }
	    return this.pageInit;
	  }

	public String getMinusInit() {
		try {
			List list =this.commonService.getWageMinusList(this.getSetId());
			if(list.size()==0){
				this.showMinus=false;
				super.getServletRequest().getSession().removeAttribute("minusList");
			}else{
				this.showMinus=true;
				super.getServletRequest().getSession().setAttribute("minusList", list);				
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return minusInit;
	}

	public void setMinusInit(String minusInit) {
		this.minusInit = minusInit;
	}

	public boolean isShowMinus() {
		return showMinus;
	}

	public void setShowMinus(boolean showMinus) {
		this.showMinus = showMinus;
	}

	public String turnPageQuery(TableVO table, String sql, int pageNum, int rowNum) {
	    try {
	      if (pageNum == 0)
	        pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
	      if (pageNum == 0)
	        pageNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("pageNum")));
	      if (pageNum == 0)
	        pageNum = 1;
	      if (rowNum == 0)
	        rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("rowNum")));
	      if (rowNum == 0)
	        rowNum = Integer.parseInt(CommonFuns.filterNullToZero((String)super.getHttpSession().getAttribute("rowNum")));
	      if (rowNum == 0)
	        rowNum = 500;
	      if (table == null)
	        table = (TableVO)super.getHttpSession().getAttribute("OBJECT");
	      if (sql == null) {
	        sql = (String)super.getHttpSession().getAttribute("activeSql");
	      }

	      if(sql.indexOf("A001242")==-1){
	    	  CellVO[]cells= table.getHeader();
	    	  CellVO[]cells2= new CellVO[table.getHeader().length+1];
	    	  for(int i=0;i<cells.length;i++){
	    		  cells2[i]=cells[i];
	    	  }
	    	  CellVO c=new CellVO();
	    	  CommonFuns.copyProperties(c, SysCacheTool.findInfoItem("A001", "A001242"));
	    	  cells2[table.getHeader().length]=c;
	    	  
	    	  String[]sql2=sql.split("FROM");
	    	  sql=sql2[0]+",A001242 FROM "+sql2[1];
	    	  table.setHeader(cells2);
	      }
	      
			table = this.getWagepersonqueryucc().queryPersonBySql(table, sql, pageNum, rowNum);
			table.setTag(this.getSetId());
			super.getHttpSession().setAttribute("activeSql", sql);
			super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
			super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
			super.getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			super.showMessageDetail("turnPageQuery错误：" + e.getMessage());
		}
		return null;
	}
	
	//选择计算
	public String computePart()
	  {
	    String[] pid = super.getServletRequest().getParameterValues("chk");
	    try {
	      if (WageTools.addWageOperCount())
	      {
	        this.getWagecomputeucc().preProcess(false, this.getSetId());
	        Vector vec = this.getWagecomputeucc().batchComputePartPerson(this.getSetId(), this.getDateId(), pid, this.getPayoffDate(), this.getUnitId());
	        String msg = "";
	        if ((vec != null) && (vec.size() > 0)) {
	          msg = "以下人员对应数据项有误：";
	          for (int i = 0; i < vec.size(); i++) {
	            String perId = ((String)vec.get(i)).split(",")[0];
	            String itemId = ((String)vec.get(i)).split(",")[1];
	            msg = msg + SysCacheTool.findPersonById(perId).getName() + "[" + SysCacheTool.interpertCode("INFOITEM", itemId) + "];";
	          }
	        }
	        initNegative();

	        if (!msg.equals(""))
	          super.showMessageDetail(msg);
	        else
	          super.showMessageDetail("计算成功");
	      } else {
	        super.showMessageDetail("在线薪资计算、发放人数过多，请稍候计算。");
	      }
	    } catch (SysException e) {
	      super.showMessageDetail("计算失败：请检查薪资项或者人员数据！" + e.getSysMsg().getMessage());
	    } catch (Exception e) {
	      super.showMessageDetail("计算失败：请检查薪资项或者人员数据！");
	    } finally {
	      WageTools.reduceWageOperCount();
	    }
	    turnPageQuery(null, null, 0, 0);
	    saveTempData();
	    return "personlist";
	  }

	  //全部计算
	  public String computeAll() {
	    try {
	      if (WageTools.addWageOperCount())
	      {
	        this.getWagecomputeucc().preProcess(false, this.getSetId());

	        Vector vec = this.getWagecomputeucc().batchComputeAllPerson(this.getSetId(), this.getDateId(), this.getPayoffDate(), this.getUnitId());
	        String msg = "";
	        if ((vec != null) && (vec.size() > 0)) {
	          msg = "以下人员对应数据项有误：";
	          for (int i = 0; i < vec.size(); i++) {
	            String perId = ((String)vec.get(i)).split(",")[0];
	            String itemId = ((String)vec.get(i)).split(",")[1];
	            msg = msg + SysCacheTool.findPersonById(perId).getName() + "[" + SysCacheTool.interpertCode("INFOITEM", itemId) + "];";
	          }
	        }
	        else
	        {
	          this.getWagecomputeucc().GatherCalc(this.getSetId(), this.getDateId(), this.getUnitId());
	          if ("1".equals(this.getWagesetucc().findSetBySetId(this.getSetId()).getBothParent())) {
	            OrgBO me = SysCacheTool.findOrgById(this.getUnitId());
	            OrgBO parent = SysCacheTool.findOrgById(me.getSuperId());
	            if (parent != null) {
	              this.getWagecomputeucc().GatherCalcByChild(parent.getOrgId(), this.getPayoffDate());
	            }

	          }

	          this.getWagecomputeucc().recordChange(this.getSetId(), this.getPayoffDate().substring(0, 7));
	        }

	        WageComputeHisBO hisbo = new WageComputeHisBO();
	        hisbo.setDateID(this.getDateId());
	        hisbo.setOperID(super.getUserInfo().getUserId());
	        hisbo.setComputeDate(CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss"));
	        hisbo.setLoginIP(super.getServletRequest().getRemoteAddr());
	        this.getWagecomputeucc().saveComputeHis(hisbo);
	        initNegative();
	        if (!msg.equals(""))
	          super.showMessageDetail(msg);
	        else
	          super.showMessageDetail("计算成功");
	      } else {
	        super.showMessageDetail("在线薪资计算、发放人数过多，请稍候计算。");
	      }
	    } catch (RollbackableException be) {
	      String msg = CommonFuns.filterNull(be.getMessage()).replaceAll("\n", "").replaceAll("\r", "");
	      super.showMessageDetail(msg);
	    } catch (SysException e) {
	      String msg = CommonFuns.filterNull(e.getMessage()).replaceAll("\n", "").replaceAll("\r", "");
	      super.showMessageDetail("计算失败：请检查薪资项或者人员数据！" + msg);
	    } catch (Exception e) {
	      String msg = CommonFuns.filterNull(e.getMessage()).replaceAll("\n", "").replaceAll("\r", "");
	      super.showMessageDetail("计算失败：请检查薪资项或者人员数据！" + msg);
	    } finally {
	      WageTools.reduceWageOperCount();
	    }
	    turnPageQuery(null, null, 0, 0);
	    saveTempData();
	    return "personList";
	  }
	  
	  private void initNegative() {
	    try {
	      String[] pids = this.getWagepersonqueryucc().getNegativePerson(false, this.getSetId());
	      if ((pids != null) && (pids.length > 0))
	        this.setHaveNegative(true);
	    }
	    catch (Exception e)
	    {
	    	this.setHaveNegative(false);
	    }
	  }
	  
	  private void saveTempData(){
		  ParameterBO temp=this.parameterDAO.getParameter("WAGE_FOR_STATISTIC");
		  if(temp!=null && "1".equals(temp.getValue())){
			  try {
				this.commonService.saveTempData(this.getSetId(), this.getPayoffDate());
			} catch (SysException e) {
				e.printStackTrace();
			}
		  }
	  }
}
