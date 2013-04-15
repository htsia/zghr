package com.hr319wg.custom.extend.service;

import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.post.service.PostService;

public class PostServiceByExtend extends PostService {

	public void CalcWeave(String superID) throws SysException {
		this.getApi().executeSql("BEGIN proc_calc_postweave('" + superID + "'); END;");
	}

	public boolean checkWeaveInfo(String postID) throws SysException {
		if ((postID != null) && (!"".equals(postID))) {
			String sql="select s.para_value from sys_parameter s where s.para_key='CHECK_POST_WEAVE'";
			String chk=this.getApi().queryForString(sql);
			if("1".equals(chk)){
				sql = "select c001735 from c001 where postid='" + postID + "'";
				String C001735 = this.getApi().queryForString(sql);
				if ((C001735 != null) && (!"".equals(C001735))) {
					int iC001735 = Integer.parseInt(C001735);
					int now = this.getApi().queryForInt("select count(*) as weave from a001  where a001715 ='" + postID + "' and a001054 in ("+ Constants.IN_SERVICE_TYPE + ") ");
					now++;
					if (now > iC001735){
						return false;
					}
				}
			}
		}
		return true;
	}
}
