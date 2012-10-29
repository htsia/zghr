package com.hr319wg.attence.web;

import java.util.List;

import com.hr319wg.attence.pojo.bo.AttEvcctionRecBO;
import com.hr319wg.attence.pojo.bo.AttEvcctionRecCollectBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttEvcctionStateUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AttEvcctionStateSearchBackingBean extends BaseBackingBean {
	private IAttEvcctionStateUCC attEvcctionStateUcc;
	private PageVO mypage = new PageVO();
	private List persBos;
	private String pageInit;
	private String superId;
    private String beginTime;
    private String endTime;
    private String evcctionCollectNo;
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

    public String deleteEvcction(){
        try{
              AttEvcctionRecBO record=this.attEvcctionStateUcc.findAttEvcctionRecBOBySuperId(evcctionCollectNo);
              if(record!=null){
                        attEvcctionStateUcc.deleteAttEvcctionRecBO(record.getEvcctionNO());
              }
              attEvcctionStateUcc.deleteAttEvcctionRecCollectBO(evcctionCollectNo);
        }catch(Exception e){
              e.printStackTrace();
        }
        return "";
    }

    public String getEvcctionCollectNo() {
        return evcctionCollectNo;
    }

    public void setEvcctionCollectNo(String evcctionCollectNo) {
        this.evcctionCollectNo = evcctionCollectNo;
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

    public String getSuperId() {
		return superId;
	}


	public void setSuperId(String superId) {
		this.superId = superId;
	}


	public String getPageInit() {
		if (super.getRequestParameter("superId") != null && !"".equals(super.getRequestParameter("superId"))) {
			superId = super.getRequestParameter("superId");
		}
		seePersonAddWorkMessage();
		return pageInit;
	}


	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}


	public List getPersBos() {
		return persBos;
	}


	public void setPersBos(List persBos) {
		this.persBos = persBos;
	}


	public String seePersonAddWorkMessage() {
		try{
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			persBos = attEvcctionStateUcc.getAllAttEvcctionRecCollectBO(mypage,superId,beginTime,endTime,personValue,postName);
			if (persBos != null && persBos.size() > 0) {
				for (int i = 0; i < persBos.size(); i++) {
					AttEvcctionRecCollectBO attevcctionreccollectbo=(AttEvcctionRecCollectBO)persBos.get(i);
					attevcctionreccollectbo.setPersonName(SysCacheTool.findPersonById(attevcctionreccollectbo.getPersonID()).getName());
					AttEvcctionRecBO attevcctionrecbo=attEvcctionStateUcc.findAttEvcctionRecBOBySuperId(attevcctionreccollectbo.getEvcctionNo());
                     if(attevcctionrecbo!=null){
                        attevcctionreccollectbo.setLastDate(attevcctionrecbo.getLastDate());
						attevcctionreccollectbo.setReason(attevcctionrecbo.getReason());
						attevcctionreccollectbo.setDest(attevcctionrecbo.getDest());
                     }
					persBos.set(i, attevcctionreccollectbo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	
	public String first() {
		mypage.setCurrentPage(1);
		seePersonAddWorkMessage();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		seePersonAddWorkMessage();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		seePersonAddWorkMessage();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		seePersonAddWorkMessage();
		return "";
	}
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

    public IAttEvcctionStateUCC getAttEvcctionStateUcc() {
        return attEvcctionStateUcc;
    }

    public void setAttEvcctionStateUcc(IAttEvcctionStateUCC attEvcctionStateUcc) {
        this.attEvcctionStateUcc = attEvcctionStateUcc;
    }
}
