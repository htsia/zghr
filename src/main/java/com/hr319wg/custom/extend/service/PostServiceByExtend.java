package com.hr319wg.custom.extend.service;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.post.service.PostService;

public class PostServiceByExtend extends PostService {

	public void CalcWeave(String superID) throws SysException {
		this.getApi().executeSql("BEGIN proc_calc_postweave('"+superID+"'); END;");
	}
}
