package com.hr319wg.attence.web;

import com.hr319wg.attence.pojo.bo.AttFurloughRecBO;
import com.hr319wg.attence.pojo.bo.AttFurloughRecCollectBO;
import com.hr319wg.attence.pojo.bo.AttfurloughBO;
import com.hr319wg.attence.ucc.IAttFurloughRecUCC;
import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;

import javax.faces.model.SelectItem;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-4
 * Time: ÏÂÎç4:43
 * To change this template use File | Settings | File Templates.
 */
public class AttFurloughRecMgrBackBean extends BaseBackingBean{
    private IAttFurloughRecUCC attFurloughRecUcc;
    private String pageInit;
    private String beginTime;
    private String endTime;
    private PageVO mypage=new PageVO();
    private List personList;
    private String superId=super.getUserInfo().getDeptId();
    private String superFurloughNo;
    private String  personValue;
    private List flIDList;
    private String flID;
    private String postName;

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String deleteFurloughRec(){
        try{
            AttFurloughRecCollectBO bo=attFurloughRecUcc.findAttFurloughRecCollectBOById(superFurloughNo);
            AttFurloughRecBO recbo=attFurloughRecUcc.findAttFurlouoghRecBOBySuperId(bo.getFurloughNO());
            if(recbo!=null){
                attFurloughRecUcc.deleteAttFurloughRecBO(recbo.getFurloughNO());
            }
            attFurloughRecUcc.deleteAttFurloughRecCollectBO(superFurloughNo);
        }catch(Exception e){
           e.printStackTrace();
        }
        return "";
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

            personList=attFurloughRecUcc.getAllAttFurloughRecCollectBO(mypage,superId,beginTime,endTime,personValue,flID,postName);
            if(personList!=null&&personList.size()>0){
                    for(int i=0;i<personList.size();i++){
                        AttFurloughRecCollectBO bo=(AttFurloughRecCollectBO)personList.get(i);
                        bo.setPersonID(SysCacheTool.findPersonById(bo.getPersonID()).getName());
                        AttFurloughRecBO recbo=attFurloughRecUcc.findAttFurlouoghRecBOBySuperId(bo.getFurloughNO());
                        AttfurloughBO fbo=attFurloughRecUcc.findAttfurloughBOById(bo.getFlID());
                        if(recbo!=null){
                            bo.setLastDate(recbo.getLastDate());
                            bo.setReason(recbo.getReason());
                        }
                        if(fbo!=null){
                            bo.setFlID(fbo.getFlName());
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

    public String getSuperFurloughNo() {
        return superFurloughNo;
    }

    public void setSuperFurloughNo(String superFurloughNo) {
        this.superFurloughNo = superFurloughNo;
    }

    public String getPersonValue() {
        return personValue;
    }

    public void setPersonValue(String personValue) {
        this.personValue = personValue;
    }

    public List getFlIDList() {
        try {
                flIDList=new ArrayList();
                SelectItem si0=new  SelectItem();
                si0.setLabel("È«²¿");
                si0.setValue("");
                flIDList.add(si0);
				List lists=attFurloughRecUcc.getAllAttfurloughBO();
				if(lists!=null && lists.size()>0){
					for(int i=0;i<lists.size();i++){
						AttfurloughBO attfurloughbo=(AttfurloughBO)lists.get(i);
						   if(!"06".equals(attfurloughbo.getFlID())){
							   SelectItem si=new  SelectItem();
				               si.setLabel(attfurloughbo.getFlName());
				               si.setValue(attfurloughbo.getFlID());
				               flIDList.add(si);
						   }
					}
				}
			} catch (Exception e) {
               e.printStackTrace();
			}
        return flIDList;
    }

    public void setFlIDList(List flIDList) {
        this.flIDList = flIDList;
    }

    public String getFlID() {
        return flID;
    }

    public void setFlID(String flID) {
        this.flID = flID;
    }

    public IAttFurloughRecUCC getAttFurloughRecUcc() {
        return attFurloughRecUcc;
    }

    public void setAttFurloughRecUcc(IAttFurloughRecUCC attFurloughRecUcc) {
        this.attFurloughRecUcc = attFurloughRecUcc;
    }
}
