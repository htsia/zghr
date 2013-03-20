package com.hr319wg.custom.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.custom.dao.CommonDAO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
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
}
