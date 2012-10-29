package com.hr319wg.attence.util;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;

public class CommonDataUtil extends QuartzJobBean{
	private ActivePageAPI activePageAPI;

	public ActivePageAPI getActivePageAPI() {
		return activePageAPI;
	}

	public void setActivePageAPI(ActivePageAPI activePageAPI) {
		this.activePageAPI = activePageAPI;
	}

	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		try {
			this.activePageAPI.executeSql("BEGIN proc_calc_age(); END;");
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
}
