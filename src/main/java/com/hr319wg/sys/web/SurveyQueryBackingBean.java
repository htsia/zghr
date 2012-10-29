package com.hr319wg.sys.web;

import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class SurveyQueryBackingBean extends BaseBackingBean {
	private UserAPI userapi;
	private QueryAPI queryapi;
	private IQueryUCC queryucc;

	private String searchStr;
	private String paperId;
	
	public String getPaperId() {
		return paperId;
	}

	public void setPaperId(String paperId) {
		this.paperId = paperId;
	}

	public QueryAPI getQueryapi() {
		return queryapi;
	}
	
	public void setQueryapi(QueryAPI queryapi) {
		this.queryapi = queryapi;
	}

	public UserAPI getUserapi() {
		return userapi;
	}

	public void setUserapi(UserAPI userapi) {
		this.userapi = userapi;
	}

	public IQueryUCC getQueryucc() {
		return queryucc;
	}

	public void setQueryucc(IQueryUCC queryucc) {
		this.queryucc = queryucc;
	}

	public String getSearchStr() {
		return searchStr;
	}

	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}

	public String getResultInit() {
		String pageFlag = super.getServletRequest().getParameter("pageFlag");
		if ("1".equals(pageFlag)) {
			turnPageQuery(null, null, 0, 0);
		}

		String act = super.getRequestParameter("act");
		if ("resultinit".equals(act)) {
			clearPageParameter();
			resultQuery();
		}
		return null;
	}
	
	public String getPageInit(){
		String pageFlag = super.getServletRequest().getParameter("pageFlag");
		if ("1".equals(pageFlag)) {
			turnPageQuery(null, null, 0, 0);
		}

		String act = super.getRequestParameter("act");
		if ("init".equals(act)) {
			clearPageParameter();
			String unitId = super.getServletRequest().getParameter("unitId");
			if (unitId != null) {
				OrgBO org = SysCacheTool.findOrgById(unitId);
				if (!"-1".equals(org.getSuperId())) {
					unitId = org.getOrgId();
				} else {
					unitId = null;
				}
			}
			detailQuery(unitId);
		}
		return null;
	}

	public void queryBySearchStr(){
		detailQuery(null);
	}
	
	private void resultQuery() {
		try {
			String paperId=super.getServletRequest().getParameter("paperID");
			// 查询语句
			String sql = "select q.title,'共' || sum(case when (a.answer_code='A' or a.answer_code='B' or a.answer_code='C') and d.select_result='1' then 1 else 0 end) || '人比例:' || " +
					"round(sum(case when (a.answer_code='A' or a.answer_code='B' or a.answer_code='C') and d.select_result='1' then 1 else 0 end)*100/(count(*)/5),2) || '%' y,'共' || " +
					"sum(case when (a.answer_code='D' or a.answer_code='E') and d.select_result='1' then 1 else 0 end) || '人比例:' || " +
					"round(sum(case when (a.answer_code='D' or a.answer_code='E') and d.select_result='1' then 1 else 0 end)*100/(count(*)/5),2) || '%' n " +
					"from self_survey_question q left join self_question_answer a on q.question_id=a.question_id left join self_survey_detail d on d.answer_id=a.answer_id " +
					"where q.paper_id='"+paperId+"' and q.ques_type=0 group by q.title,q.show_seq order by q.show_seq";
			
			TableVO table = new TableVO();
			CellVO[] col=new CellVO[3]; 
		    col[0] = new CellVO();
	        col[0].setItemId("title"); 
	        col[0].setItemName("标题"); 
	        col[1] = new CellVO();
	        col[1].setItemId("y"); 
	        col[1].setItemName("满意"); 
		    col[2] = new CellVO();
		    col[2].setItemId("n"); 
	        col[2].setItemName("不满意");
			table.setHeader(col); 
			turnPageQuery(table, sql, 1, 0);
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("错误：" + e.getMessage());
		}
	}
	
	private void detailQuery(String unitId) {
		try {
			if(this.paperId==null){
				this.paperId=super.getServletRequest().getParameter("paperID");				
			}
			// 查询语句
			String sql = "select b1.b001005,s.code_item_name,b2.b001005 b0010052,a001735,a001001,q.title,a1.answer_name,r.answer_date " +
					"from self_survey_question q left join self_question_answer a1 on q.question_id=a1.question_id left join " +
					"self_survey_detail d on d.answer_id=a1.answer_id and d.select_result='1' left join " +
					"self_survey_result r on q.paper_id=r.paper_id and d.person_id=r.person_id left join " +
					"a001 a on d.person_id=a.id left join b001 b1 on a.a001701=b1.orguid left join " +
					"sys_code_item s on a.A001239=s.code_item_id left join b001 b2 on a.A001705=b2.orguid " +
					"where a.id is not null and q.paper_id='"+this.paperId+"' ";
			String searchStr1="%";
			if(this.searchStr!=null && !"".equals(this.searchStr)){
				searchStr1=this.searchStr;
			}
			sql+=" and (a001001 like '%"+searchStr1+"%' or a001735 like '%"+searchStr1+"%' ) ";
			if(unitId!=null && !"".equals(unitId)){
				sql+=" and (A001701= '"+unitId+"' or A001239 = '"+unitId+"' or A001705= '"+unitId+"' or A001704= '"+unitId+"' or A001703= '"+unitId+"') ";
			}
		    sql += " order by a.a001701,A001239,a.a001705,q.show_seq";
		    
			TableVO table = new TableVO();
			CellVO[] col=new CellVO[8]; 
		    col[0] = new CellVO();
	        col[0].setItemId("b001005"); 
	        col[0].setItemName("所在单位"); 
	        col[1] = new CellVO();
	        col[1].setItemId("code_item_name"); 
	        col[1].setItemName("二级部门"); 
		    col[2] = new CellVO();
		    col[2].setItemId("b0010052"); 
	        col[2].setItemName("所在部门");
	        col[3] = new CellVO();
	        col[3].setItemId("a001735"); 
	        col[3].setItemName("员工编号");
	        col[4] = new CellVO();
	        col[4].setItemId("a001001"); 
	        col[4].setItemName("姓名");
	        col[5] = new CellVO();
	        col[5].setItemId("title"); 
	        col[5].setItemName("标题");
	        col[6] = new CellVO();
	        col[6].setItemId("answer_name"); 
	        col[6].setItemName("选项");
	        col[7] = new CellVO();
	        col[7].setItemId("answer_date"); 
	        col[7].setItemName("投票时间");
	        
			table.setHeader(col); 
			turnPageQuery(table, sql, 1, 0);
			
		} catch (Exception e) {
			e.printStackTrace();
			super.showMessageDetail("错误：" + e.getMessage());
		}
	}

	private void clearPageParameter() {
		super.getHttpSession().removeAttribute("OBJECT");
		super.getHttpSession().removeAttribute("activeSql");
		super.getHttpSession().removeAttribute("pageNum");
	}

	public String turnPageQuery(TableVO table, String sql, int pageNum,
			int rowNum) {
		try {
			if (pageNum == 0)
				pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super
						.getRequestParameter("pageNum")));
			if (pageNum == 0)
				pageNum = Integer.parseInt(CommonFuns
						.filterNullToZero((String) super.getHttpSession()
								.getAttribute("pageNum")));
			if (pageNum == 0)
				pageNum = 1;
			if (rowNum == 0)
				rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super
						.getRequestParameter("rowNum")));
			if (rowNum == 0)
				rowNum = Integer.parseInt(CommonFuns
						.filterNullToZero((String) super.getHttpSession()
								.getAttribute("rowNum")));
			if (rowNum == 0)
				rowNum = Constants.ACTIVE_PAGE_SIZE;
			if (table == null)
				table = (TableVO) super.getHttpSession().getAttribute("OBJECT");
			if (sql == null)
				sql = (String) super.getHttpSession().getAttribute("activeSql");
			table = this.queryucc.executeQuery(super.getUserInfo(),
					table.getHeader(), sql, true, pageNum, rowNum);
			super.getHttpSession().setAttribute("activeSql", sql);
			super.getHttpSession().setAttribute("rowNum",
					String.valueOf(rowNum));
			super.getHttpSession().setAttribute("pageNum",
					String.valueOf(pageNum));
			super.getHttpSession().setAttribute("OBJECT", table);
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return null;
	}
}