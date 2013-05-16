package com.hr319wg.qry.web;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.qry.pojo.bo.QueryBO;
import com.hr319wg.qry.ucc.IQueryUCC;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.util.CodeUtil;

public class QueryBackingBean extends BaseBackingBean {
	private IQueryUCC queryucc;
	private QueryBO[] queryBo;
	private QueryBO[] mainqueryBo;
	private String qryId = null;
	private String classId;
	private String qsType;
	private String publicFlag;
	private boolean hasQRight;
	private boolean hasSRight;

	public boolean isHasQRight() {
		return hasQRight;
	}

	public void setHasQRight(boolean hasQRight) {
		this.hasQRight = hasQRight;
	}

	public boolean isHasSRight() {
		return hasSRight;
	}

	public void setHasSRight(boolean hasSRight) {
		this.hasSRight = hasSRight;
	}

	public String getQsType() {
		return qsType;
	}

	public void setQsType(String qsType) {
		this.qsType = qsType;
	}

	public String getPublicFlag() {
		return publicFlag;
	}

	public void setPublicFlag(String publicFlag) {
		this.publicFlag = publicFlag;
	}

	public QueryBO[] getMainqueryBo() {
		try {
			QueryBO[] temp = this.queryucc.queryQuery("QA" + super.getUserInfo().getUserId());
			if (temp != null) {
				temp = (QueryBO[]) (QueryBO[]) CodeUtil.codeInterpret(temp, "createUser", "PE");
			} else {
				temp = new QueryBO[0];
				return temp;
			}
			if (temp.length > 5) {
				this.mainqueryBo = new QueryBO[5];
			} else {
				this.mainqueryBo = new QueryBO[temp.length];
			}
			for (int i = 0; (i < temp.length) && (i < 5); i++) {
				this.mainqueryBo[i] = temp[i];
			}
		} catch (Exception e) {
		}
		return this.mainqueryBo;
	}

	public void setMainqueryBo(QueryBO[] mainqueryBo) {
		this.mainqueryBo = mainqueryBo;
	}

	public String getClassId() {
		return this.classId;
	}

	public void setClassId(String id) {
		this.classId = id;
	}

	public String doQuery() {
		this.queryBo = getQueryBo();
		return null;
	}

	public IQueryUCC getQueryucc() {
		return this.queryucc;
	}

	public void setQueryucc(IQueryUCC queryucc) {
		this.queryucc = queryucc;
	}

	public QueryBO[] getQueryBo() {
		return this.queryBo;
	}

	public void setQueryBo(QueryBO[] queryBo) {
		this.queryBo = queryBo;
	}

	public String getQryId() {
		return this.qryId;
	}

	public void setQryId(String qryId) {
		this.qryId = qryId;
	}

	public String getPageInit() {
		try {
			this.hasQRight=false;
			this.hasSRight=false;
			String publicFlag1=super.getRequestParameter("publicFlag");
			if(publicFlag1!=null && !"".equals(publicFlag1)){
				this.publicFlag=publicFlag1;
			}
			String qsType1=super.getRequestParameter("qsType");
			if(qsType1!=null && !"".equals(qsType1)){
				this.qsType=qsType1;
			}
			if(super.getUserInfo().ischo()){
				this.hasQRight=true;
				this.hasSRight=true;
			}else{
				if("Q".equals(this.qsType)){//²éÑ¯
					if(UserAPI.checkButtonOperate(super.getUserInfo(), "131201") || "PRIVATE".equals(this.publicFlag)){
						this.hasQRight=true;
					}					
				}else{
					if(UserAPI.checkButtonOperate(super.getUserInfo(), "131301") || "PRIVATE".equals(this.publicFlag)){
						this.hasSRight=true;
					}										
				}
			}
			this.classId = getRequestParameter("classId");
			this.queryBo = this.queryucc.queryQuery(this.classId);
			if (this.queryBo != null) {
				this.queryBo = ((QueryBO[]) (QueryBO[]) CodeUtil.codeInterpret(this.queryBo, "createUser", "PE"));
			} else
				this.queryBo = new QueryBO[0];
		} catch (SysException e) {
			this.msg.setMainMsg(e, getClass());
		}
		return "";
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
}