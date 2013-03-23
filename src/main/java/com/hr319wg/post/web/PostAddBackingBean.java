package com.hr319wg.post.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.pojo.vo.PostVO;
import com.hr319wg.post.ucc.IPostUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class PostAddBackingBean extends BaseBackingBean
{
  private PostVO postvo = new PostVO();
  private IPostUCC postucc;
  private IOrgUCC orgucc;
  private PostBO[] postlist;
  private String wageClass;
  private String wageXL;
  private String pageInit;
  private TableVO tableVO;

	public TableVO getTableVO() {
		return tableVO;
	}

	public void setTableVO(TableVO tableVO) {
		this.tableVO = tableVO;
	}

	public String getPageInit() {
		try {
			this.tableVO = this.orgucc.queryPageInfo("C001", "-1", "", null);
			getHttpSession().setAttribute("OBJECT_DETAIL", this.tableVO);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return pageInit;
	}

	public IOrgUCC getOrgucc() {
		return orgucc;
	}

	public void setOrgucc(IOrgUCC orgucc) {
		this.orgucc = orgucc;
	}

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
	
	  public String saveOne() {
	    try {
	      User user = getUserInfo();
	      String postId = "";
	      Map dataMap = getServletRequest().getParameterMap();
	        this.postvo.setPostTemp("00900");
	        String name=((String[])dataMap.get("C001005"))[0];
	        String org=((String[])dataMap.get("C001010"))[0];
	        String type=((String[])dataMap.get("C001001"))[0];
	        String date=((String[])dataMap.get("C001030"))[0];
	        String workout=((String[])dataMap.get("C001735"))[0];
	        String code=((String[])dataMap.get("C001003"))[0];
	        this.postvo.setName(name);
	        this.postvo.setOrgId(org);
	        this.postvo.setPostClass(type);
	        this.postvo.setUpdateDate(date);
	        this.postvo.setWorkOut(workout);
	        if (code==null || "".equals(code)) {
	        	String id = this.postucc.buildPostCode(org);
	        	this.postvo.setPostCode(id);
	        }
	        postId = this.postucc.createPost(this.postvo, null, user);
	        List keys=new ArrayList();
	        Iterator set = dataMap.keySet().iterator();
	        while(set.hasNext()){
	        	String k=set.next().toString();
	        	if(k.indexOf("C001")!=-1){
	        		InfoItemBO bo= SysCacheTool.findInfoItem("C001", k);
	        		if(bo!=null && "1".equals(bo.getItemStatus())){
	        			keys.add(k);        			
	        		}
	        	}
	        }
	        String sql="update c001 set ";
	        for(int i=0;i<keys.size();i++){
	        	sql+=keys.get(i)+"="+"case when "+keys.get(i)+" is null then '"+((String[])dataMap.get(keys.get(i)))[0]+"' else "+keys.get(i)+" end ";
	        	if(i+1!=keys.size()){
	        		sql+=",";
	        	}
	        }
	        
	        sql+=" where postid='"+postId+"'";
	        JdbcTemplate jdbcTemplate = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
	        jdbcTemplate.execute(sql);
	      SysCache.setMap(new String[] { postId }, 3, 7);
	      showMessageDetail("岗位增加成功");
	      getServletRequest().setAttribute("P_POSTID", postId);
	    } catch (Exception e) {
	      e.printStackTrace();
	      this.msg.setMainMsg(e, getClass());
	    }
	    return "edit";
	  }
}