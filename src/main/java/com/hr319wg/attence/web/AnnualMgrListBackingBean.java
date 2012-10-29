package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttAnnualExcludeBO;
import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.pojo.vo.AttPersonAnnualQryVO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AnnualMgrListBackingBean extends BaseBackingBean {
	private static String namevalues;
	private String initEdit;
	private String personNames="";
	private String causeValues;
	private String okNumber="100";
	private String recID;
	private String recIDs;
	private List lists;
	private List lists1;
	private PageVO mypage = new PageVO();
	private PageVO mypage1 = new PageVO();
	private String superName;
	private String superId = super.getUserInfo().getOrgId();
	private String pageInit;
	private String pageInit1;
	private String recID1;

    private IAttAnnualUCC attAnnualUcc;
    private String personValue;

    public String getPersonValue() {
        return personValue;
    }

    public void setPersonValue(String personValue) {
        this.personValue = personValue;
    }

    public IAttAnnualUCC getAttAnnualUcc() {
        return attAnnualUcc;
    }

    public void setAttAnnualUcc(IAttAnnualUCC attAnnualUcc) {
        this.attAnnualUcc = attAnnualUcc;
    }


	public String first() {
		mypage.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuery();
		return "";
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String first1() {
		mypage1.setCurrentPage(1);
		doQuery1();
		return "";
	}

	public String pre1() {
		if (mypage1.getCurrentPage() > 1) {
			mypage1.setCurrentPage(mypage1.getCurrentPage() - 1);
		}
		doQuery1();
		return "";
	}

	public String next1() {
		if (mypage1.getCurrentPage() < mypage1.getTotalPage()) {
			mypage1.setCurrentPage(mypage1.getCurrentPage() + 1);
		}
		doQuery1();
		return "";
	}

	public String last1() {
		mypage1.setCurrentPage(mypage1.getTotalPage());
		doQuery1();
		return "";
	}
	
	public PageVO getMypage1() {
		return mypage1;
	}

	public void setMypage1(PageVO mypage1) {
		this.mypage1 = mypage1;
	}


	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.superId);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getPageInit() {
		if (super.getRequestParameter("recID") != null
				&& !super.getRequestParameter("recID").equals("")) {
			recID = super.getRequestParameter("recID");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getPageInit1() {
		if (super.getRequestParameter("recID") != null
				&& !super.getRequestParameter("recID").equals("")) {
			recID1 = super.getRequestParameter("recID");
		}
		doQuery1();
		return pageInit1;
	}

	public void setPageInit1(String pageInit1) {
		this.pageInit1 = pageInit1;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getRecID() {
		return recID;
	}

	public void setRecID(String recID) {
		this.recID = recID;
	}

	public String getOkNumber() {
		return okNumber;
	}

	public void setOkNumber(String okNumber) {
		this.okNumber = okNumber;
	}

	public String getInitEdit() {
		try{
			personNames="";
		if (super.getRequestParameter("name") != null
				&& !super.getRequestParameter("name").equals("") && super.getRequestParameter("recID") != null && !super.getRequestParameter("recID").equals("")) {
		String name = super.getRequestParameter("name");
		recIDs=super.getRequestParameter("recID");
		namevalues=name;
		String[] names=name.split(",");
		if(names!=null){
			  for(int i=1;i<names.length;i++){
				  String personname=SysCacheTool.findPersonById(names[i]).getName();
				  if(i==1){
					  personNames+=personname;
				  }else{
					  personNames+=","+personname;
				  }
			  }
		}
	   }
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getPersonNames() {
		return personNames;
	}

	public void setPersonNames(String personNames) {
		this.personNames = personNames;
	}

	public String getCauseValues() {
		return causeValues;
	}

	public void setCauseValues(String causeValues) {
		this.causeValues = causeValues;
	}

	public String getRecIDs() {
		return recIDs;
	}

	public void setRecIDs(String recIDs) {
		this.recIDs = recIDs;
	}

	public String doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			lists = attAnnualUcc.getAllAttAnnualItemBO(mypage, recID,personValue);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttAnnualItemBO attannualitembo = (AttAnnualItemBO) lists
							.get(i);
					attannualitembo.setPersonName(SysCacheTool.findPersonById(attannualitembo.getPersonID()).getName());
					lists.set(i, attannualitembo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}

	public String initializationMethod() {
		try{
		List lists=attAnnualUcc.getAttAnnualItemBO(recID);
		if(lists!=null && lists.size()>0){
			super.showMessageDetail("已经进行过初始化操作！");
			return "";
		}else{
			String name=attAnnualUcc.caleAttAnnualItemBO(superId,recID);
			if(!"".equals(name)){
				super.showMessageDetail(name);
			}
		}

		}catch(Exception e){
			
		}
		return "";
	}

	public String clearMethod() {
        try{
            attAnnualUcc.deleteAttAnnualDetailBOByRecID(recID);
            attAnnualUcc.deleteAttAnnualItemBOByRecID(recID);
            attAnnualUcc.deleteAttAnnualExcludeBO();
        }catch(SysException e){
            e.printStackTrace();
        }
		return "";
	}

	
public String confirmMethod(){
	try{
   if(namevalues!=null && !"".equals(namevalues)){
	   String[] names=namevalues.split(",");
	   for(int i=1;i<names.length;i++){
		   AttAnnualExcludeBO attannualexcludebo=new AttAnnualExcludeBO();
		   attannualexcludebo.setRecId(recIDs);
		   attannualexcludebo.setPersonId(names[i]);
		   attannualexcludebo.setMode("1");
		   attannualexcludebo.setCause(causeValues);
		   attAnnualUcc.saveAttAnnualExcludeBO(attannualexcludebo);
		   attAnnualUcc.deleteEqualsAttAnnualItemBO(recIDs,names[i]);
	   }
   }
	}catch(Exception e){
		e.printStackTrace();
	}
	return "success";
}

public String getRecID1() {
	return recID1;
}

public void setRecID1(String recID1) {
	this.recID1 = recID1;
}

public List getLists1() {
	return lists1;
}

public void setLists1(List lists1) {
	this.lists1 = lists1;
}

public String doQuery1(){
	try{
		if (mypage1.getCurrentPage() == 0) {
			mypage1.setCurrentPage(1);
		}
		lists1 = attAnnualUcc.getAllAttAnnualExcludeBO(mypage1,recID1);
		if (lists1 != null && lists1.size() > 0) {
			for (int i = 0; i < lists1.size(); i++) {
				AttAnnualExcludeBO attannualexcludebo = (AttAnnualExcludeBO) lists1
						.get(i);
				attannualexcludebo.setPersonName(SysCacheTool.findPersonById(attannualexcludebo.getPersonId()).getName());
				if(attannualexcludebo.getMode()!=null && !"".equals(attannualexcludebo.getMode())){
					if("1".equals(attannualexcludebo.getMode())){
						attannualexcludebo.setModeName("手工排除");
					}else{
						attannualexcludebo.setModeName("自动排除");
					}
				}
				lists1.set(i,attannualexcludebo);
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	return "";
}
 //实时数据查询
   private String queryInit;
   private List queryVoList;

    public String qryFirst() {
		mypage.setCurrentPage(1);
		queryVO();
		return "";
	}

	public String gryPre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryVO();
		return "";
	}

	public String gryNext() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryVO();
		return "";
	}

	public String gryLast() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryVO();
		return "";
	}
    public void queryVO(){
       try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
            queryVoList=new ArrayList();
			List list = attAnnualUcc.getAllAttAnnualItemBO(mypage, recID,personValue);
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					AttAnnualItemBO bo = (AttAnnualItemBO) list.get(i);
                    AttPersonAnnualQryVO vo=new AttPersonAnnualQryVO();
					vo.setPersonName(SysCacheTool.findPersonById(bo.getPersonID()).getName());
                    if(bo.getCriticalDate()!=null&&!bo.getCriticalDate().equals("")){
                       vo.setCanLeaveDay(bo.getCriticalAnnDay());
                       vo.setHaveLeaveDay(bo.getCalcAnnDay());
                       vo.setAvaLeaveDay(bo.getCriticalAvaDay());
                       vo.setCriticalDate(bo.getCriticalDate());
                    }else{
                       vo.setCanLeaveDay(bo.getAnnDay());
                       vo.setHaveLeaveDay(bo.getUseDay());
                       vo.setAvaLeaveDay(bo.getAvaDay());
                    }
                    vo.setEnterDate(bo.getEnterDate());
                    vo.setWorkDate(bo.getWorkDate());
                   queryVoList.add(vo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
    }
    public String getQueryInit() {
        if (super.getRequestParameter("recID") != null
				&& !super.getRequestParameter("recID").equals("")) {
			recID = super.getRequestParameter("recID");
		}
		queryVO();
        return queryInit;
    }

    public void setQueryInit(String queryInit) {
        this.queryInit = queryInit;
    }

    public List getQueryVoList() {
        return queryVoList;
    }

    public void setQueryVoList(List queryVoList) {
        this.queryVoList = queryVoList;
    }
}
