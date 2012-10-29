package com.hr319wg.attence.web;

import com.hr319wg.attence.pojo.bo.AttOutWorkBO;
import com.hr319wg.attence.pojo.bo.AttOutWorkCollectBO;
import com.hr319wg.attence.ucc.IAttOutWorkUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;

import java.util.Hashtable;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-3
 * Time: ÏÂÎç2:01
 * To change this template use File | Settings | File Templates.
 */
public class AttOutWorkMgrBackBean  extends BaseBackingBean{
    private IAttOutWorkUCC attOutWorkUcc;
    private String pageInit;
    private String beginTime;
    private String endTime;
    private PageVO mypage=new PageVO();
    private List personList;
    private String superId;
    private String superFurloughNo;
    private String  personValue;
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

    public String  deleteOutWork(){
          try{
              AttOutWorkBO bo=this.attOutWorkUcc.findAttOutWorkBOBySuperId(superFurloughNo);
              if(bo!=null){
                   attOutWorkUcc.deleteAttOutWorkBO(bo.getOutWorkNo());
              }
              attOutWorkUcc.deleteAttOutWorkCollectBO(superFurloughNo);
          }catch(Exception e){
              e.printStackTrace();
          }
          return "";
    }

    public String getSuperFurloughNo() {
        return superFurloughNo;
    }

    public void setSuperFurloughNo(String superFurloughNo) {
        this.superFurloughNo = superFurloughNo;
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }

    public IAttOutWorkUCC getAttOutWorkUcc() {
        return attOutWorkUcc;
    }

    public void setAttOutWorkUcc(IAttOutWorkUCC attOutWorkUcc) {
        this.attOutWorkUcc = attOutWorkUcc;
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
              personList=attOutWorkUcc.getAllAttOutWorkCollectBO(mypage,superId,beginTime,endTime,personValue,postName);
              List list=attOutWorkUcc.getAllAttOutWorkBO(null,superId,beginTime,endTime);
              Hashtable boHash=new Hashtable();
              if(list!=null&&list.size()>0){
                  for(int i=0;i<list.size();i++){
                      AttOutWorkBO bo=(AttOutWorkBO)list.get(i);
                      if(bo.getSuperFurloughNo()!=null&&!bo.getSuperFurloughNo().equals("")){
                        boHash.put(bo.getSuperFurloughNo(),bo);
                      }
                  }
              }
              if(personList!=null&&personList.size()>0){
                   for(int i=0;i<personList.size();i++){
                         AttOutWorkCollectBO bo=(AttOutWorkCollectBO)personList.get(i);
                         bo.setPersonID(SysCacheTool.findPersonById(bo.getPersonID()).getName());
                         AttOutWorkBO work=(AttOutWorkBO)boHash.get(bo.getOutWorkNo());
                         if(work!=null){
                             bo.setLastDate(work.getLastDate());
                             bo.setDest(work.getDest());
                             bo.setReason(work.getReason());
                         }
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

    public List getPersonList() {
        return personList;
    }

    public void setPersonList(List personList) {
        this.personList = personList;
    }

    public PageVO getMypage() {
        return mypage;
    }

    public void setMypage(PageVO mypage) {
        this.mypage = mypage;
    }
}
