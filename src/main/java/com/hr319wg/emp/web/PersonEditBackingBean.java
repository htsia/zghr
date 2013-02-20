package com.hr319wg.emp.web;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.ccp.pojo.bo.PartyBO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.util.CommonProcEmp;
import com.hr319wg.emp.pojo.vo.IntroLetter;
import com.hr319wg.emp.ucc.IEmpChangeUCC;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.emp.util.PersonTool;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class PersonEditBackingBean extends BaseBackingBean {
	private String table;
	private String list;
	private IOrgUCC orgucc;
	private IPersonUCC personucc;
	private WageAPI wageapi;
	private IEmpChangeUCC empchangeucc;

	public IEmpChangeUCC getEmpchangeucc() {
		return this.empchangeucc;
	}

	public void setEmpchangeucc(IEmpChangeUCC empchangeucc) {
		this.empchangeucc = empchangeucc;
	}

	public String getTable() {
		String tableId = getServletRequest().getParameter("tableId");
		if ((tableId == null) || ("".equals(tableId.trim())))
			tableId = "OBJECT_DETAIL";
		try {
			String setId = getServletRequest().getParameter("setId");
			String fk = getServletRequest().getParameter("fk");
			String pk = getServletRequest().getParameter("pk");
			String flag = getServletRequest().getParameter("flag");

			if ("2".equals(flag)) {
				User user = getUserInfo();
				TableVO table = (TableVO) getHttpSession()
						.getAttribute(tableId);
				if (((fk == null) || ("".equals(fk)))
						&& ((pk == null) || ("".equals(pk)))) {
					if ("A001".equals(setId)) {
						table = this.orgucc.findNewPage(setId, user);
					}
				} else {
					InfoSetBO infoSet = SysCacheTool.findInfoSet(setId);
					if (infoSet != null) {
						if (InfoSetBO.RS_TYPE_SINGLE.equals(infoSet
								.getSet_rsType()))
							table = this.orgucc.queryPageInfo(setId, fk, "",
									user);
						else {
							table = this.orgucc.queryPageInfo(setId, pk, fk,
									user);
						}
					}
				}
				getHttpSession().setAttribute(tableId, table);
			}
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId);
			this.msg.setMainMsg(e, getClass());
		}
		return this.table;
	}

	public void setTable(String table) {
		this.table = table;
	}

	public String getList() {
		return this.list;
	}

	public void setList(String list) {
		this.list = list;
	}

	public IOrgUCC getOrgucc() {
		return this.orgucc;
	}

	public void setOrgucc(IOrgUCC orgucc) {
		this.orgucc = orgucc;
	}

	public IPersonUCC getPersonucc() {
		return this.personucc;
	}

	public void setPersonucc(IPersonUCC personucc) {
		this.personucc = personucc;
	}

	public WageAPI getWageapi() {
		return this.wageapi;
	}

	public void setWageapi(WageAPI wageapi) {
		this.wageapi = wageapi;
	}

	public String saveOne() {
		boolean isEmpty = false;
		String tableId = getServletRequest().getParameter("tableId");
		if ((tableId == null) || ("".equals(tableId.trim())))
			tableId = "OBJECT_DETAIL";
		try {
			User user = getUserInfo();

			TableVO table = (TableVO) getHttpSession().getAttribute(tableId);
			Map dataMap = getServletRequest().getParameterMap();
			Map ee = new HashMap();
			ee.putAll(dataMap);
			if ("A001".equals(table.getSetId())) {
				String[] partyId = (String[]) (String[]) ee.get("A001708");
				if (partyId != null) {
					PartyBO bo = SysCacheTool.findParty(partyId[0]);
					if (bo != null) {
						ee.put("A001740", new String[] { CommonFuns
								.filterNull(bo.getTreeId()) });
					}
				}

			}

			Iterator it = ee.keySet().iterator();
			Map imageMap = new HashMap();
			while (it.hasNext()) {
				String itemId = (String) it.next();
				InfoItemBO item = SysCacheTool.findInfoItem(null, itemId);
				if ((item != null) && ("14".equals(item.getItemDataType()))) {
					byte[] b = (byte[]) (byte[]) getHttpSession().getAttribute(
							itemId);
					imageMap.put(itemId, b);
					getHttpSession().removeAttribute(itemId);
				}
			}
			if ("A001".equals(table.getSetId())) {
				String[] perNames = (String[]) (String[]) ee.get("A001001");
				if (perNames != null) {
					if ((perNames[0] == null) || ("".equals(perNames[0]))) {
						showMessageDetail("人员姓名为空，不能保存!");
						isEmpty = true;
						return null;
					}
				} else {
					isEmpty = true;
					showMessageDetail("人员姓名为空，不能保存!");
					return null;
				}
			}
			if (imageMap.isEmpty())
				this.orgucc.updatePageInfo(table, ee, user);
			else {
				this.orgucc.updatePageInfo(table, ee, user, imageMap);
			}

			String pkvalue = getServletRequest().getParameter("pk");
			if ((pkvalue != null) && (!"".equals(pkvalue))) {
				SysCache.setPerson(pkvalue, 3);
			}
			table = this.orgucc.queryPageInfo(
					getServletRequest().getParameter("setId"),
					getServletRequest().getParameter("pk"), getServletRequest()
							.getParameter("fk"), user);
			showMessageDetail("保存成功!");
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute("images");
			getHttpSession().removeAttribute(tableId);
			this.msg.setMainMsg(e, getClass());
		}
		return null;
	}

	public String addMany() {
		String tableId = getServletRequest().getParameter("tableId");
		if ((tableId == null) || ("".equals(tableId.trim())))
			tableId = "OBJECT_DETAIL";
		try {
			User user = getUserInfo();
			String setId = getServletRequest().getParameter("setId");
			String fk = getServletRequest().getParameter("fk");
			String pk = getServletRequest().getParameter("pk");
			String flag = getServletRequest().getParameter("flag");

			TableVO table = this.orgucc.findNewPage(setId, user);

			if ("false".equals(super.getRequestParameter("isCheckRight"))) {
				table.setPermission(3);
				if ((table.getRowData() != null)
						&& (table.getRowData().length > 0)) {
					for (int i = 0; i < table.getRowData()[0].getCell().length; i++) {
						table.getRowData()[0].getCell()[i].setPermission(3);
					}
				}
			}
			getHttpSession().setAttribute(tableId, table);
			getServletRequest().setAttribute("flag", flag);
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId);
			this.msg.setMainMsg(e, getClass());
		}
		return "info";
	}

	public String updateMany() {
		String tableId = getServletRequest().getParameter("tableId");
		if ((tableId == null) || ("".equals(tableId.trim())))
			tableId = "OBJECT_DETAIL";
		try {
			User user = getUserInfo();
			String setId = getServletRequest().getParameter("setId");
			String fk = getServletRequest().getParameter("fk");
			String pk = getServletRequest().getParameter("pk");
			String flag = getServletRequest().getParameter("flag");

			TableVO table = this.orgucc.queryPageInfo(setId, pk, fk, user);

			if ("false".equals(super.getRequestParameter("isCheckRight"))) {
				table.setPermission(3);
				if ((table.getRowData() != null)
						&& (table.getRowData().length > 0)) {
					for (int i = 0; i < table.getRowData()[0].getCell().length; i++) {
						table.getRowData()[0].getCell()[i].setPermission(3);
					}
				}
			}

			getHttpSession().setAttribute(tableId, table);
			getServletRequest().setAttribute("flag", flag);
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId);
			this.msg.setMainMsg(e, getClass());
		}
		return "info";
	}

	public String setCurrent() {
		try {
			String setId = getServletRequest().getParameter("setId");
			String pk = getServletRequest().getParameter("curID");
			this.personucc.setCurrent(setId, pk);
		} catch (Exception e) {
		}

		return "";
	}

	public String delMany() {
		String tableId = getServletRequest().getParameter("tableId");
		if ((tableId == null) || ("".equals(tableId.trim())))
			tableId = "OBJECT_DETAIL";
		try {
			User user = getUserInfo();
			String[] delId = getServletRequest().getParameterValues("chk");
			String setId = getServletRequest().getParameter("setId");
			String fk = getServletRequest().getParameter("fk");
			String pk = getServletRequest().getParameter("pk");
			String flag = getServletRequest().getParameter("flag");

			TableVO table = (TableVO) getHttpSession().getAttribute(tableId);
			if ("A016".equals(setId)) {
				int count = this.personucc.queryA016Count(fk);
				if (count == 1) {
					showMessageDetail("增减员子集必须有一条记录!");
					return null;
				}
			}
			
			this.orgucc.delPageInfo(table, delId, user);
			
			CommonProcEmp proc=(CommonProcEmp)SysContext.getBean("common_proemp");
			proc.deleteEmp(setId, fk, pk);

			SysCache.setPerson(fk, 3);
			table = this.orgucc.queryPageInfo(setId, pk, fk, user);
			
			getHttpSession().setAttribute(tableId, table);
			showMessageDetail("删除成功!");
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId);
			this.msg.setMainMsg(e, getClass());
		}
		return null;
	}

	public String saveManyAdd() {
		String tableId = getServletRequest().getParameter("tableId");
		if ((tableId == null) || ("".equals(tableId.trim())))
			tableId = "OBJECT_DETAIL";
		try {
			User user = getUserInfo();
			String setId = getServletRequest().getParameter("setId");
			String fk = getServletRequest().getParameter("fk");
			String pk = getServletRequest().getParameter("pk");
			String flag = getServletRequest().getParameter("flag");

			TableVO table = (TableVO) getHttpSession().getAttribute(tableId);
			Map dataMap = getServletRequest().getParameterMap();
			Map ee = new HashMap();
			ee.putAll(dataMap);

			Iterator it = ee.keySet().iterator();
			Map imageMap = new HashMap();
			while (it.hasNext()) {
				String itemId = (String) it.next();
				InfoItemBO item = SysCacheTool.findInfoItem(null, itemId);
				if ((item != null) && ("14".equals(item.getItemDataType()))) {
					byte[] b = (byte[]) (byte[]) getHttpSession().getAttribute(
							itemId);
					imageMap.put(itemId, b);
					getHttpSession().removeAttribute(itemId);
				}
			}
			String subID=null;
			if (imageMap.isEmpty())
				subID=this.orgucc.addPageInfo(table, ee, user);
			else {
				this.orgucc.addPageInfo(table, ee, user, imageMap);
			}
			
//			if("A010".equals(setId)){
//				setA010ZhiCheng(fk, pk, "0");
//			}
			
			CommonProcEmp proc=(CommonProcEmp)SysContext.getBean("common_proemp");
			proc.addEmp(setId, fk, subID);
			
			table = this.orgucc.queryPageInfo(setId, "", fk, user);
			getHttpSession().setAttribute(tableId, table);

			if ((fk != null) && (!"".equals(fk))) {
				SysCache.setPerson(fk, 3);
			}
			
			showMessageDetail("保存成功!");
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId);
			this.msg.setMainMsg(e, getClass());
		}
		return "list";
	}

	public String saveManyUpdate() {
		String tableId = getServletRequest().getParameter("tableId");
		if ((tableId == null) || ("".equals(tableId.trim())))
			tableId = "OBJECT_DETAIL";
		try {
			User user = getUserInfo();
			String setId = getServletRequest().getParameter("setId");
			String fk = getServletRequest().getParameter("fk");
			String pk = getServletRequest().getParameter("pk");

			TableVO table = (TableVO) getHttpSession().getAttribute(tableId);
			Map dataMap = getServletRequest().getParameterMap();

			Map ee = new HashMap();
			ee.putAll(dataMap);

			Iterator it = ee.keySet().iterator();
			Map imageMap = new HashMap();
			while (it.hasNext()) {
				String itemId = (String) it.next();
				InfoItemBO item = SysCacheTool.findInfoItem(null, itemId);
				if ((item != null) && ("14".equals(item.getItemDataType()))) {
					byte[] b = (byte[]) (byte[]) getHttpSession().getAttribute(
							itemId);
					imageMap.put(itemId, b);
					getHttpSession().removeAttribute(itemId);
				}
			}
			if (imageMap.isEmpty())
				this.orgucc.updatePageInfo(table, ee, user);
			else {
				this.orgucc.updatePageInfo(table, ee, user, imageMap);
			}
//			if("A010".equals(setId)){
//				setA010ZhiCheng(fk, pk, "1");
//			}
			
			CommonProcEmp proc=(CommonProcEmp)SysContext.getBean("common_proemp");
			proc.addEmp(setId, fk, pk);
			
			table = this.orgucc.queryPageInfo(setId, "", fk, user);
			getHttpSession().setAttribute(tableId, table);

			if ((fk != null) && (!"".equals(fk))) {
				SysCache.setPerson(fk, 3);
			}
			showMessageDetail("保存成功!");
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId);
			this.msg.setMainMsg(e, getClass());
		}
		return "list";
	}

	private void setA010ZhiCheng(String fk, String pk, String type) throws SysException{
		JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
		String sql = "select subid,a010206,a010207 from a010 where subid= ";
		if("0".equals(type)){
			sql+="(select max(cast(subid as int)) from a010)";
		}else{
			sql+="'"+pk+"'";
		}
		
		List list = jdbc.queryForList(sql);
		if(list!=null && list.size()>0){
			Map m = (Map)list.get(0);
			if("0".equals(type)){
				pk = m.get("subid").toString();
			}
			if(m.get("a010206")!=null && "00901".equals(m.get("a010206").toString())){
				sql = "update a010 set a010206=null where subid<>'"+pk+"' and id='"+fk+"'";
				jdbc.execute(sql);
			}
			if(m.get("a010207")!=null && "00901".equals(m.get("a010207").toString())){
				sql = "update a010 set a010207=null where subid<>'"+pk+"' and id='"+fk+"'";
				jdbc.execute(sql);
			}
		}
	}
	
	public String back() {
		String tableId = getServletRequest().getParameter("tableId");
		if ((tableId == null) || ("".equals(tableId.trim())))
			tableId = "OBJECT_DETAIL";
		try {
			User user = getUserInfo();
			String setId = getServletRequest().getParameter("setId");
			String fk = getServletRequest().getParameter("fk");
			String pk = getServletRequest().getParameter("pk");

			TableVO table = (TableVO) getHttpSession().getAttribute(tableId);
			table = this.orgucc.queryPageInfo(setId, "", fk, user);
			getHttpSession().setAttribute(tableId, table);
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().removeAttribute(tableId);
			this.msg.setMainMsg(e, getClass());
		}
		return "list";
	}

	public void printIntroLetter() {
		try {
			String perId = getServletRequest().getParameter("perFlagId");
			if ((perId != null) && (!"".equals(perId.trim()))) {
				IntroLetter il = this.empchangeucc.findIntroLetter(perId);
				Hashtable ht = PersonTool.introLetter(il);
				String path = ((ServletContext) FacesContext
						.getCurrentInstance().getExternalContext().getContext())
						.getRealPath("/");
				String file = PersonTool.filefillCardForIntroLetter(perId, ht,
						path, "");
				showExportFileWindow(file);
			}
		} catch (Exception e) {
			this.msg.setMainMsg(e, getClass());
		}
	}
}