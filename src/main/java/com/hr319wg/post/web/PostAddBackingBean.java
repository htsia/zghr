package com.hr319wg.post.web;

import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.pojo.vo.PostVO;
import com.hr319wg.post.ucc.IPostUCC;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class PostAddBackingBean extends BaseBackingBean
{
  private PostVO postvo = new PostVO();
  private IPostUCC postucc;
  private PostBO[] postlist;
  private String wageClass;
  private String wageXL;

  public String getWageClass() {
	return wageClass;
}

public void setWageClass(String wageClass) {
	this.wageClass = wageClass;
}

public String getWageXL() {
	return wageXL;
}

public void setWageXL(String wageXL) {
	this.wageXL = wageXL;
}

public PostVO getPostvo()
  {
    if (this.postvo != null) {
      if ((this.postvo.getUpdateDate() == null) || ("".equals(this.postvo.getUpdateDate().trim()))) {
        this.postvo.setUpdateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
      }
      if ((this.postvo.getWorkOut() == null) || ("".equals(this.postvo.getWorkOut().trim()))) {
        this.postvo.setWorkOut("1");
      }
    }
    return this.postvo;
  }

  public void setPostvo(PostVO postvo) {
    this.postvo = postvo;
  }
  public IPostUCC getPostucc() {
    return this.postucc;
  }

  public void setPostucc(IPostUCC postucc) {
    this.postucc = postucc;
  }
  public PostBO[] getPostlist() {
    return this.postlist;
  }

  public void setPostlist(PostBO[] postlist) {
    this.postlist = postlist;
  }
  public String queryPost() {
    try {
      if (this.postvo != null) {
        this.postlist = this.postucc.queryPost(this.postvo.getPostClass(), "00901");
        this.postlist = ((PostBO[])(PostBO[])CodeUtil.codeInterpret(this.postlist, "orgId,postClass", "OU,CODE"));
      }
      getServletRequest().setAttribute("flag", "show");
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }

  public String savePost() {
    try {
      User user = getUserInfo();
      String[] tmpIds = getServletRequest().getParameterValues("chk");
      String postId = "";
      if (this.postvo != null) {
        String tmpId = "";
        if ((tmpIds != null) && (tmpIds.length > 0)) {
          tmpId = tmpIds[0];
        }
        this.postvo.setPostTemp("00900");
        if ((this.postvo.getPostCode() == null) || ("".equals(this.postvo.getPostCode()))) {
          String id = this.postucc.buildPostCode(this.postvo.getOrgId());
          this.postvo.setPostCode(id);
        }
        postId = this.postucc.createPost(this.postvo, tmpId, user);
        ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi"); 
        String sql = "update c001 set C001203 ='"+this.wageClass+"',C001205='"+this.wageXL+"' where postid='"+postId+"'";
        api.executeSql(sql);
      }

      SysCache.setMap(new String[] { postId }, 1, 7);
      showMessageDetail("岗位增加成功！");
      getServletRequest().setAttribute("P_POSTID", postId);
    } catch (Exception e) {
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    return "edit";
  }
}