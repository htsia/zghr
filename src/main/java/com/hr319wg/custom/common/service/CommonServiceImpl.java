package com.hr319wg.custom.common.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.custom.dao.CommonDAO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.SequenceGenerator;

public class CommonServiceImpl implements ICommonService{

	private CommonDAO commonDAO;
	private JdbcTemplate jdbcTemplate;
	private ActivePageAPI pageAPI;
	public CommonDAO getCommonDAO() {
		return commonDAO;
	}
	public void setCommonDAO(CommonDAO commonDAO) {
		this.commonDAO = commonDAO;
	}
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	public ActivePageAPI getPageAPI() {
		return pageAPI;
	}
	public void setPageAPI(ActivePageAPI pageAPI) {
		this.pageAPI = pageAPI;
	}

	/**
	 * mode 0更新 1新增
	 */
	public void batchUpdateEmpUploadFile(String setID, String mode, String[]fields, List<Map> list)
			throws SysException {
		InfoSetBO set = SysCacheTool.findInfoSet(setID);
		for(Map map : list){
			//单记录子集
			if(set.getSet_rsType().equals(InfoSetBO.RS_TYPE_SINGLE)){
				String sql="update "+setID+" set ";
				for(int i=0;i<fields.length;i++){
					sql+=fields[i]+"='"+(map.get(fields[i])==null?"":map.get(fields[i]))+"',";
				}
				sql=sql.substring(0, sql.length()-1);
				sql+=" where id='"+map.get("id")+"'";
				this.jdbcTemplate.execute(sql.toString());
			}else{
				boolean insert=false;
				//更新
				if("0".equals(mode)){
					//存在当前记录
					String sql="select subid from "+setID+" where "+setID+"000 ='00901' and id='"+map.get("id")+"'";
					String subid=this.pageAPI.queryForString(sql.toString());
					if(subid!=null){
						sql="update "+setID+" set ";
						for(int i=0;i<fields.length;i++){
							sql+=fields[i]+"='"+(map.get(fields[i])==null?"":map.get(fields[i]))+"',";
						}
						sql=sql.substring(0, sql.length()-1);
						sql+=" where subid='"+subid+"'";
						this.jdbcTemplate.execute(sql.toString());
					}else{
						insert=true;
					}
				}else if("1".equals(mode) || insert){
					String sql="update "+setID+" set "+setID+"000 ='00900' where id='"+map.get("id")+"'";
					this.jdbcTemplate.execute(sql);
					sql="insert into "+setID+"(subid,id,"+setID+"000";
					for(int i=0;i<fields.length;i++){
						sql+=","+fields[i];
					}
					sql+=") values ('"+SequenceGenerator.getKeyId(setID)+"','"+map.get("id")+"','00901'";
					for(int i=0;i<fields.length;i++){
						sql+=",'"+(map.get(fields[i])==null?"":map.get(fields[i]))+"'";
					}
					sql+=")";
					this.jdbcTemplate.execute(sql);
				}
			}
		}
	}
	
	public String getChangeInfo(TableVO table, List showItems, String unitId, String filter) {
		String fields = "ws.set_id||'-'||A001.ID||'-'||B730.subid AS ID,A001735,A001705";
		CellVO[] cvs = new CellVO[showItems.size() + 4];
		cvs[0] = new CellVO();
		CommonFuns.copyProperties(cvs[0], SysCacheTool.findInfoItem("A001", "ID"));
		cvs[1] = new CellVO();
		CommonFuns.copyProperties(cvs[1], SysCacheTool.findInfoItem("A001", "A001735"));
		cvs[2] = new CellVO();
		CommonFuns.copyProperties(cvs[2], SysCacheTool.findInfoItem("A001", "A001705"));
		for (int i = 0; i < showItems.size(); i++) {
			InfoItemBO ib = (InfoItemBO) showItems.get(i);
			cvs[(i + 3)] = new CellVO();
			CommonFuns.copyProperties(cvs[(i + 3)], ib);
			if (fields.equals("")) {
				fields = ib.getSetId() + "." + ib.getItemId();
			} else {
				fields = fields + "," + ib.getSetId() + "." + ib.getItemId();
			}
		}
		cvs[(showItems.size() + 3)] = new CellVO();
		cvs[(showItems.size() + 3)].setItemId("set_name");
		cvs[(showItems.size() + 3)].setItemName("薪资账套");
		fields = fields + ",set_name";
		table.setHeader(cvs);
		String sql = "select " + fields + " from B730 left join A001 on B730.B730700=A001.ID left join wage_set_pers_r w on A001.id=w.id left join wage_set ws on w.A815700=ws.set_id where isnull(no_use,0)<>'1' and orguid='"
				+ unitId + "' and " + filter + " order by B730701 desc";
		return sql;
	}
	
	public void updateInfoItem(InfoItemBO item) throws SysException {
		this.commonDAO.saveOrUpdateBo(item);
		if("A815".equals(item.getSetId())){
			String sql="select name from sysobjects where xtype='U' and name like 'A815_SET_%'";
			List list = this.jdbcTemplate.queryForList(sql);
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					Map m =(Map)list.get(i);
					sql="alter table "+m.get("name")+" modify "+item.getItemId()+" varchar2("+item.getItemDataLength()+")";
					this.jdbcTemplate.execute(sql);
				}
			}
			sql="alter table wage_set_pers_r modify "+item.getItemId()+" varchar2("+item.getItemDataLength()+")";
			this.jdbcTemplate.execute(sql);
			sql="alter table wage_set_pers_r_bak modify "+item.getItemId()+" varchar2("+item.getItemDataLength()+")";
			this.jdbcTemplate.execute(sql);
		}
	}
	
	public List getRptList(String userID) throws SysException {
		return this.commonDAO.getRptList(userID);
	}

	public List getWageMinusList(String setID) throws SysException {
		List list=null;
		String sql="select s.para_value from sys_parameter s where s.para_key='WAGE_FIELD_SHIFA'";
		String field=this.pageAPI.queryForString(sql);
		if(field!=null && !"".equals(field)){
			sql="select a.a001735 pCode,a001001 name,b.b001005 deptName,"+field+" wage from a001 a,b001 b,a815_set_"+setID+" s where a.a001705=b.orguid and a.id=s.id and "+field+"<=0 order by b.b001003,a.a001001";
			list =this.jdbcTemplate.queryForList(sql);
			if(list==null){
				list=new ArrayList();
			}
		}else{
			list=new ArrayList();
		}
		return list;
	}
	
	public void deleteAdvice(String ID) throws SysException {
		String sql="delete from self_advise a where a.adv_id='"+ID+"'";
		this.jdbcTemplate.execute(sql);
	}
}
