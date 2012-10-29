package com.hr319wg.attence.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.hr319wg.attence.pojo.bo.AttOverTimeLogBO;
import com.hr319wg.attence.pojo.bo.AttOverTimeRecBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttOverTimeUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class SeePersonAddWorkListBackingBean extends BaseBackingBean {
	private PageVO mypage = new PageVO();
	private String beginTime;
    private String endTime;
	private String name;
	private List lists1=new ArrayList();
	private String pageInit;
	private String superId;
    private IAttOverTimeUCC attOverTimeUcc;
    private String superFurloughNo;
    private String personValue;
    private String postName;

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getPersonValue() {
        return personValue;
    }

    public void setPersonValue(String personValue) {
        this.personValue = personValue;
    }

    public String getSuperFurloughNo() {
        return superFurloughNo;
    }

    public void setSuperFurloughNo(String superFurloughNo) {
        this.superFurloughNo = superFurloughNo;
    }

    public String deleteOverTimeLog(){
        try{
            AttOverTimeRecBO rec=attOverTimeUcc.findAttOverTimeRecBOBySuperId(superFurloughNo);
            if(rec!=null){
                attOverTimeUcc.deleteAttOverTimeRecBO(rec.getOverTimeNO());
            }
            attOverTimeUcc.deleteAttOverTimeLogBO(superFurloughNo);
        }catch(Exception e){
            e.printStackTrace();
        }
        return "";
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public IAttOverTimeUCC getAttOverTimeUcc() {
        return attOverTimeUcc;
    }

    public void setAttOverTimeUcc(IAttOverTimeUCC attOverTimeUcc) {
        this.attOverTimeUcc = attOverTimeUcc;
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

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getPageInit() {
		if(super.getRequestParameter("superId") != null){
			superId=super.getRequestParameter("superId");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public List getLists1() {
		return lists1;
	}

	public void setLists1(List lists1) {
		this.lists1 = lists1;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String doQuery(){
		try{
		    lists1=new ArrayList();
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			List lists=attOverTimeUcc.getAllAttOverTimeLogBO(mypage,superId,beginTime,endTime,personValue,postName);
			if(lists!=null && lists.size()>0){
				for(int i=0;i<lists.size();i++){
					AttOverTimeLogBO attovertimelogbo=(AttOverTimeLogBO)lists.get(i);
					PersonBO pbo= SysCacheTool.findPersonById(attovertimelogbo.getPersonID());
					String personname=pbo.getName();
					String seqname=pbo.getPersonCode();
					attovertimelogbo.setPersonName(personname);
					attovertimelogbo.setSeqName(seqname);
					if (attovertimelogbo.getTypeStatus() != null
							&& !"".equals(attovertimelogbo.getTypeStatus())) {
						if ("1".equals(attovertimelogbo.getTypeStatus())) {
							attovertimelogbo.setTypeStatusName("工作日延时");
						} else if ("2".equals(attovertimelogbo.getTypeStatus())) {
							attovertimelogbo.setTypeStatusName("双休日");
						} else if ("3".equals(attovertimelogbo.getTypeStatus())) {
							attovertimelogbo.setTypeStatusName("节假日");
						}
					}
					lists1.add(attovertimelogbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String queryPerson(){
		doQuery();
		return "";
	}
	
}
