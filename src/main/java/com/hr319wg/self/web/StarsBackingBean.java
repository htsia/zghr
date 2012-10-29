package com.hr319wg.self.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.self.pojo.bo.StarsBO;
import com.hr319wg.self.ucc.IStarsUCC;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.AttFileVO;
import com.hr319wg.util.CodeUtil;

public class StarsBackingBean extends BaseBackingBean
{

	private IStarsUCC starsucc;
	private String photoFile;
	private String story;
	private String perCode;
	private String name;
	private String dept;
	private String unit;
	private String post;
	private List starsPerList;
	private boolean haveAtt;
	private List attList;

	public String getPost() {
		return post;
	}
	
	public void setPost(String post) {
		this.post = post;
	}
	public StarsBackingBean()
	{
		haveAtt = false;
	}

	public boolean isHaveAtt()
	{
		return haveAtt;
	}

	public void setHaveAtt(boolean b)
	{
		haveAtt = b;
	}

	public List getAttList()
	{
		if (attList == null)
			attList = new ArrayList();
		return attList;
	}

	public void setAttList(List li)
	{
		attList = li;
	}

	public List getStarsPerList()
	{
		try
		{
			List list = starsucc.getALL(super.getUserInfo().getOrgId());
			starsPerList = new ArrayList();
			for (int i = 0; i < list.size(); i++)
			{
				StarsBO sb = (StarsBO)list.get(i);
				SelectItem si = new SelectItem();
				PersonBO pb = SysCacheTool.findPersonById(sb.getPersID());
				String title = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getOrgId()) + "  " + pb.getName();
				si.setLabel(title);
				si.setValue(sb.getItemID());
				starsPerList.add(si);
			}

		}
		catch (Exception e)
		{
			starsPerList = new ArrayList();
		}
		return starsPerList;
	}

	public void setStarsPerList(List list)
	{
		starsPerList = list;
	}

	public String getPageInit()
	{
		try
		{
			if (super.getRequestParameter("ID") != null && !"-1".equals(super.getRequestParameter("ID")))
			{
				String id = super.getRequestParameter("ID");
				StarsBO sb = starsucc.getStarsBO(id);
				photoFile = sb.getPhotoFile();
				story = sb.getStory();
				PersonBO pb = SysCacheTool.findPersonById(sb.getPersID());
				perCode = pb.getPersonCode();
				name = pb.getName();
				super.getHttpSession().setAttribute("Name", name);
				dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId());
				unit = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getOrgId());
				post = CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId());
				if (sb.getAtt1FileName() != null || sb.getAtt2FileName() != null || sb.getAtt3FileName() != null || sb.getAtt4FileName() != null || sb.getAtt5FileName() != null)
					haveAtt = true;
				else
					haveAtt = false;
				attList = new ArrayList();
				if (sb.getAtt1FileName() != null && sb.getAtt1FileName() != null)
				{
					AttFileVO vo1 = new AttFileVO();
					vo1.setIndex("1");
					vo1.setAttFile(sb.getAtt1FileName());
					vo1.setAttTitle(sb.getAtt1Title());
					vo1.setUpdated(false);
					attList.add(vo1);
				}
				if (sb.getAtt2FileName() != null && sb.getAtt2FileName() != null)
				{
					AttFileVO vo2 = new AttFileVO();
					vo2.setIndex("3");
					vo2.setAttFile(sb.getAtt2FileName());
					vo2.setAttTitle(sb.getAtt2Title());
					vo2.setUpdated(false);
					attList.add(vo2);
				}
				if (sb.getAtt3FileName() != null && sb.getAtt3FileName() != null)
				{
					AttFileVO vo3 = new AttFileVO();
					vo3.setIndex("3");
					vo3.setAttFile(sb.getAtt3FileName());
					vo3.setAttTitle(sb.getAtt3Title());
					vo3.setUpdated(false);
					attList.add(vo3);
				}
				if (sb.getAtt4FileName() != null && sb.getAtt4FileName() != null)
				{
					AttFileVO vo4 = new AttFileVO();
					vo4.setIndex("4");
					vo4.setAttFile(sb.getAtt4FileName());
					vo4.setAttTitle(sb.getAtt4Title());
					vo4.setUpdated(false);
					attList.add(vo4);
				}
				if (sb.getAtt5FileName() != null && sb.getAtt5FileName() != null)
				{
					AttFileVO vo5 = new AttFileVO();
					vo5.setIndex("5");
					vo5.setAttFile(sb.getAtt5FileName());
					vo5.setAttTitle(sb.getAtt5Title());
					vo5.setUpdated(false);
					attList.add(vo5);
				}
				super.getHttpSession().setAttribute("attList", attList);
			} else
			{
				photoFile = "/pages/self/starsImage/no_pic.gif";
				story = "暂时没有信息";
				perCode = "";
				name = "";
				dept = "";
				unit = "";
				post = "";
			}
		}
		catch (Exception e) { }
		return "";
	}

	public String getUnit()
	{
		return unit;
	}

	public void setUnit(String st)
	{
		unit = st;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String st)
	{
		name = st;
	}

	public String getPerCode()
	{
		return perCode;
	}

	public void setPerCode(String st)
	{
		perCode = st;
	}

	public String getDept()
	{
		return dept;
	}

	public void setDept(String st)
	{
		story = dept;
	}

	public String getStory()
	{
		return story;
	}

	public void setStory(String st)
	{
		story = st;
	}

	public String getPhotoFile()
	{
		return photoFile;
	}

	public void setPhotoFile(String file)
	{
		photoFile = file;
	}

	public IStarsUCC getStarsucc()
	{
		return starsucc;
	}

	public void setStarsucc(IStarsUCC ucc)
	{
		starsucc = ucc;
	}
}
