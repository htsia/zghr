package com.hr319wg.custom.wage.web;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.custom.util.SqlUtil;

public class TiancaiBackingBean extends BaseBackingBean {
	private PageVO mypage = new PageVO();
	private String userInit;
	private String userbdInit;
	private String deptInit;
	private String deptbdInit;
	private String nameStr;
	private String orgID;
	private List userList;
	private List userList1;
	private List userbdList;
	private List userbdList1;
	private List deptList;
	private List deptList1;
	private List deptbdList;
	private List deptbdList1;

	public List getDeptList() {
		return deptList;
	}

	public void setDeptList(List deptList) {
		this.deptList = deptList;
	}

	public List getDeptList1() {
		return deptList1;
	}

	public void setDeptList1(List deptList1) {
		this.deptList1 = deptList1;
	}

	public List getDeptbdList() {
		return deptbdList;
	}

	public void setDeptbdList(List deptbdList) {
		this.deptbdList = deptbdList;
	}

	public List getDeptbdList1() {
		return deptbdList1;
	}

	public void setDeptbdList1(List deptbdList1) {
		this.deptbdList1 = deptbdList1;
	}

	public String getUserbdInit() {
		if(this.mypage.getCurrentPage()==0){
			this.mypage.setCurrentPage(1);
		}
		if(this.userbdList==null){
			this.userbdList=new ArrayList();
		}
		
		if(this.userbdList.size()==0){
			String sql="select user_code,name,isnull((select code_item_name from sys_code_item where code_item_id=user_type),user_type) user_type,isnull((select b001005 from b001 where id=old_dept_id),old_dept_id) old_dept_id,isnull((select b001005 from b001 where id=new_dept_id),new_dept_id) new_dept_id,change_type,change_date from a001_bd order by change_date desc";
			ResultSet set = SqlUtil.getData(sql);
			if(set!=null){
				String[]cols={"user_code","name","user_type","old_dept_id","new_dept_id","change_type","change_date"};
				try {
					while(set.next()){
						Map m =new HashMap();
						for(int i=0;i<cols.length;i++){
							m.put(cols[i], set.getString(cols[i])==null?"":set.getString(cols[i]));
						}
						this.userbdList.add(m);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			this.mypage.setTotalRecord(this.userbdList.size());
			this.mypage.setTotalPage((this.userbdList.size()/100)+(this.userbdList.size()%100!=0?1:0));
		}
		
		
		this.userbdList1=new ArrayList();
		for(int i=(this.mypage.getCurrentPage()-1)*100;i<this.mypage.getCurrentPage()*100;i++){
			if(i==this.userbdList.size()){
				break;
			}
			this.userbdList1.add(this.userbdList.get(i));
		}
		return userbdInit;
	}

	public void setUserbdInit(String userbdInit) {
		this.userbdInit = userbdInit;
	}

	public String getDeptbdInit() {
		if(this.mypage.getCurrentPage()==0){
			this.mypage.setCurrentPage(1);
		}
		if(this.deptbdList==null){
			this.deptbdList=new ArrayList();
		}
		
		if(this.deptbdList.size()==0){
			String sql="select dept_name,dept_type,(select b001005 from b001 where id=old_mainDeptID) old_mainDeptID,(select b001005 from b001 where id=new_mainDeptID) new_mainDeptID,(select b001005 from b001 where id=appendToDeptID) appendToDeptID,change_type,change_date from b001_bd order by change_date desc";
			ResultSet set = SqlUtil.getData(sql);
			if(set!=null){
				String[]cols={"dept_name","dept_type","old_mainDeptID","new_mainDeptID","appendToDeptID","change_type","change_date"};
				try {
					while(set.next()){
						Map m =new HashMap();
						for(int i=0;i<cols.length;i++){
							m.put(cols[i], set.getString(cols[i])==null?"":set.getString(cols[i]));
						}
						this.deptbdList.add(m);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			this.mypage.setTotalRecord(this.deptbdList.size());
			this.mypage.setTotalPage((this.deptbdList.size()/100)+(this.deptbdList.size()%100!=0?1:0));
		}
		
		
		this.deptbdList1=new ArrayList();
		for(int i=(this.mypage.getCurrentPage()-1)*100;i<this.mypage.getCurrentPage()*100;i++){
			if(i==this.deptbdList.size()){
				break;
			}
			this.deptbdList1.add(this.deptbdList.get(i));
		}
		return deptbdInit;
	}

	public void setDeptbdInit(String deptbdInit) {
		this.deptbdInit = deptbdInit;
	}

	public List getUserbdList1() {
		return userbdList1;
	}

	public void setUserbdList1(List userbdList1) {
		this.userbdList1 = userbdList1;
	}

	
	public List getUserList1() {
		return userList1;
	}

	public void setUserList1(List userList1) {
		this.userList1 = userList1;
	}

	public List getUserList() {
		return userList;
	}

	public void setUserList(List userList) {
		this.userList = userList;
	}

	public List getUserbdList() {
		return userbdList;
	}

	public void setUserbdList(List userbdList) {
		this.userbdList = userbdList;
	}

	public String getUserInit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
			this.nameStr="";
		}
		try {
			doUserQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInit;
	}

	public void doUserQuery(){
		if(this.mypage.getCurrentPage()==0){
			this.mypage.setCurrentPage(1);
		}
		String act=super.getRequestParameter("act");
		String orgID=super.getRequestParameter("orgID");
		
		if((orgID!=null && !"".equals(orgID)) || "init".equals(act)){
			this.userList=new ArrayList();
			String sql="select (select b001005 from b001 where id=a001705) a001705,(select code_item_name from sys_code_item where code_item_id=a001054) a001054,a001245,a001735,a001001,a001002,a001241,(select code_item_name from sys_code_item where code_item_id=a001007) a001007,a001206,(select code_item_name from sys_code_item where code_item_id=a001021) a001021,a001230,a001011,a001077,a001044,a001225,a001041,a001215,a001229 from a001 a" +
					" where 1=1 ";
			ResultSet set=null;
			if(orgID!=null && !"".equals(orgID)){
				set = SqlUtil.getData("select b001003 from b001 where id='"+orgID+"'");
				try {
					if(set.next()){
						String tree=set.getString("b001003");
						sql+=" and a001705 in (select id from b001 where b001003 like '"+tree+"%')";
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			set = SqlUtil.getData(sql);
			if(set!=null){
				String[]cols={"a001705","a001054","a001245","a001735","a001001","a001002","a001241","a001007","a001206","a001021","a001230","a001011","a001077","a001044","a001225","a001041","a001215","a001229"};
				try {
					while(set.next()){
						Map m =new HashMap();
						for(int i=0;i<cols.length;i++){
							m.put(cols[i], set.getString(cols[i])==null?"":set.getString(cols[i]));
						}
						this.userList.add(m);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			this.mypage.setTotalRecord(this.userList.size());
			this.mypage.setTotalPage((this.userList.size()/100)+(this.userList.size()%100!=0?1:0));
		}
		
		if(this.userList==null){
			this.userList=new ArrayList();
		}
		this.userList1=new ArrayList();
		for(int i=(this.mypage.getCurrentPage()-1)*100;i<this.mypage.getCurrentPage()*100;i++){
			if(i==this.userList.size()){
				break;
			}
			this.userList1.add(this.userList.get(i));
		}
	}
	
	public void setUserInit(String userInit) {
		this.userInit = userInit;
	}

	public String getDeptInit() {
		String act=super.getRequestParameter("act");
		if("init".equals(act)){
			this.orgID=null;
		}
		try {
			doDeptQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return deptInit;
	}

	public void doDeptQuery(){
		if(this.mypage.getCurrentPage()==0){
			this.mypage.setCurrentPage(1);
		}
		String act=super.getRequestParameter("act");
		String orgID=super.getRequestParameter("orgID");
		
		if((orgID!=null && !"".equals(orgID)) || "init".equals(act)){
			this.deptList=new ArrayList();
			String sql="select (select b001005 from b001 where id=b1.b001002) b001002,b001005,(select code_item_name from sys_code_item where code_item_id=b001075) b001075,b001006 from b001 b1" +
					" where 1=1 ";
			ResultSet set=null;
			if(orgID!=null && !"".equals(orgID)){
				set = SqlUtil.getData("select b001003 from b001 where id='"+orgID+"'");
				try {
					if(set.next()){
						String tree=set.getString("b001003");
						sql+=" and id in (select id from b001 where b001003 like '"+tree+"%')";
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			set = SqlUtil.getData(sql);
			if(set!=null){
				String[]cols={"b001002","b001005","b001075","b001006"};
				try {
					while(set.next()){
						Map m =new HashMap();
						for(int i=0;i<cols.length;i++){
							m.put(cols[i], set.getString(cols[i])==null?"":set.getString(cols[i]));
						}
						this.deptList.add(m);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			this.mypage.setTotalRecord(this.deptList.size());
			this.mypage.setTotalPage((this.deptList.size()/100)+(this.deptList.size()%100!=0?1:0));
		}
		
		if(this.deptList==null){
			this.deptList=new ArrayList();
		}
		this.deptList1=new ArrayList();
		for(int i=(this.mypage.getCurrentPage()-1)*100;i<this.mypage.getCurrentPage()*100;i++){
			if(i==this.deptList.size()){
				break;
			}
			this.deptList1.add(this.deptList.get(i));
		}
	}
	
	public void setDeptInit(String deptInit) {
		this.deptInit = deptInit;
	}

	public String getOrgID() {
		return orgID;
	}

	public void setOrgID(String orgID) {
		this.orgID = orgID;
	}

	public String getNameStr() {
		return nameStr;
	}

	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public String first() {
		mypage.setCurrentPage(1);
		return null;
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		return null;
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		return null;
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		return null;
	}

	
}
