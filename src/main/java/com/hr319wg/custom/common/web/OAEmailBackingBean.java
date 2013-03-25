package com.hr319wg.custom.common.web;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class OAEmailBackingBean extends BaseBackingBean{

	private String userID1;
	private String userID2;
	private String userID3;
	private String name1;
	private String name2;
	private String name3;
	private String oa1;
	private String oa2;
	private String oa3;
	private String url;
	private String soa;
	private boolean onoff;
	private String selectedUserID;	
	private String pageInit;
	private IWageDataService dataService;
	private JdbcTemplate jdbcTemplate;
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSoa() {
		return soa;
	}
	public void setSoa(String soa) {
		this.soa = soa;
	}
	public boolean isOnoff() {
		return onoff;
	}
	public void setOnoff(boolean onoff) {
		this.onoff = onoff;
	}
	public String getSelectedUserID() {
		return selectedUserID;
	}
	public void setSelectedUserID(String selectedUserID) {
		this.selectedUserID = selectedUserID;
	}
	public String getName1() {
		return name1;
	}
	public void setName1(String name1) {
		this.name1 = name1;
	}
	public String getName2() {
		return name2;
	}
	public void setName2(String name2) {
		this.name2 = name2;
	}
	public String getName3() {
		return name3;
	}
	public void setName3(String name3) {
		this.name3 = name3;
	}
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public IWageDataService getDataService() {
		return dataService;
	}
	public void setDataService(IWageDataService dataService) {
		this.dataService = dataService;
	}
	public String getUserID1() {
		return userID1;
	}
	public void setUserID1(String userID1) {
		this.userID1 = userID1;
	}
	public String getUserID2() {
		return userID2;
	}
	public void setUserID2(String userID2) {
		this.userID2 = userID2;
	}
	public String getUserID3() {
		return userID3;
	}
	public void setUserID3(String userID3) {
		this.userID3 = userID3;
	}
	public String getOa1() {
		return oa1;
	}
	public void setOa1(String oa1) {
		this.oa1 = oa1;
	}
	public String getOa2() {
		return oa2;
	}
	public void setOa2(String oa2) {
		this.oa2 = oa2;
	}
	public String getOa3() {
		return oa3;
	}
	public void setOa3(String oa3) {
		this.oa3 = oa3;
	}
	public String getPageInit() {
		this.selectedUserID=null;
		String act = super.getRequestParameter("act");
		if("init".equals(act)){
			String sql = "select a1.id userid1,a1.a001001 name1,a1.a001230 oa1," +
					"a2.id userid2,a2.a001001 name2,a2.a001230 oa2," +
					"a3.id userid3,a3.a001001 name3,a3.a001230 oa3,url,soa,onoff from sys_oa_email m left join a001 a1 on m.userid1=a1.id left join a001 a2 on m.userid2=a2.id left join a001 a3 on m.userid3=a3.id";
			List list = this.jdbcTemplate.queryForList(sql);
			if(list!=null && list.size()>0){
				Map m = (Map)list.get(0);
				this.userID1=String.valueOf(m.get("userid1"));
				this.name1=String.valueOf(m.get("name1"));
				this.oa1=m.get("oa1")==null?"":String.valueOf(m.get("oa1"));
				
				this.userID2=String.valueOf(m.get("userid2"));
				this.name2=String.valueOf(m.get("name2"));
				this.oa2=m.get("oa2")==null?"":String.valueOf(m.get("oa2"));
				
				this.userID3=String.valueOf(m.get("userid3"));
				this.name3=String.valueOf(m.get("name3"));
				this.oa3=m.get("oa3")==null?"":String.valueOf(m.get("oa3"));
				
				this.url=String.valueOf(m.get("url"));
				this.soa=String.valueOf(m.get("soa"));
				this.onoff="1".equals(m.get("onoff"))?true:false;
			}
		}
		return pageInit;
	}
	
	public void selPerson(){
		String[]sels=this.selectedUserID.split(",");
		String index=sels[0];
		String userID=sels[1];
		String sql="select a001230,a001001 from a001 where id='"+userID+"'";
		List list = this.jdbcTemplate.queryForList(sql);
		if(list!=null && list.size()>0){
			Map m = (Map)list.get(0);
			String name = String.valueOf(m.get("a001001"));
			String oa = m.get("a001230")==null?"":String.valueOf(m.get("a001230"));
			if("1".equals(index)){
				this.userID1=userID;
				this.name1=name;
				this.oa1=oa;
			}else if("2".equals(index)){
				this.userID2=userID;
				this.name2=name;
				this.oa2=oa;
			}else if("3".equals(index)){
				this.userID3=userID;
				this.name3=name;
				this.oa3=oa;
			}
		}
	} 
	
	public void save(){
		try {
			this.dataService.setOAEmail(userID1, userID2, userID3, url, soa, onoff?"1":"0");
			super.showMessageDetail("保存完成");
		} catch (SysException e) {
			super.showMessageDetail("保存失败");
			e.printStackTrace();
		}
	}
}
