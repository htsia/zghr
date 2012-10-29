package com.hr319wg.attence.web;

import com.hr319wg.attence.pojo.bo.AttRestStoreBO;
import com.hr319wg.attence.ucc.IAttRestChgUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-2-1
 * Time: ÏÂÎç2:47
 * To change this template use File | Settings | File Templates.
 */
public class AttRestStoreBackingBean extends BaseBackingBean{
    private IAttRestChgUCC attRestChgUCC;
    private String pageInit;
    private String beginTime;
    private String endTime;
    private PageVO mypage=new PageVO();
    private List personList;
    private String superId;
    private String  personValue;

    public IAttRestChgUCC getAttRestChgUCC() {
        return attRestChgUCC;
    }

    public void setAttRestChgUCC(IAttRestChgUCC attRestChgUCC) {
        this.attRestChgUCC = attRestChgUCC;
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

    public void doQuery(){
        try{
              if(mypage.getCurrentPage()==0){
                 mypage.setCurrentPage(1);
              }
              personList=attRestChgUCC.getAllAttRestStoreBO(mypage,beginTime,endTime,superId,personValue);
              if(personList!=null&&personList.size()>0){
                   for(int i=0;i<personList.size();i++){
                         AttRestStoreBO bo=(AttRestStoreBO)personList.get(i);
                         bo.setPersonId(SysCacheTool.findPersonById(bo.getPersonId()).getName());
                         personList.set(i,bo);
                   }
              }
        }catch(Exception e){
             e.printStackTrace();
        }
    }
    public String getPageInit() {
        if(super.getRequestParameter("superId")!=null){
           superId=super.getRequestParameter("superId");
        }
        doQuery();
        return pageInit;
    }

    public void setPageInit(String pageInit) {
        this.pageInit = pageInit;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public PageVO getMypage() {
        return mypage;
    }

    public void setMypage(PageVO mypage) {
        this.mypage = mypage;
    }

    public List getPersonList() {
        return personList;
    }

    public void setPersonList(List personList) {
        this.personList = personList;
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }

    public String getPersonValue() {
        return personValue;
    }

    public void setPersonValue(String personValue) {
        this.personValue = personValue;
    }
}
