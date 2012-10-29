package com.hr319wg.attence.util;

import java.text.ParseException;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.hr319wg.attence.dao.AttDurationDAO;
import com.hr319wg.attence.service.AttDataCaclService;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.util.CommonFuns;

public class CommonDataUtil extends QuartzJobBean{
	private AttDurationDAO attenceSetDAO;
	private ActivePageAPI activePageAPI;
	private AttDataCaclService attDataCaclService;

	public AttDataCaclService getAttDataCaclService() {
		return attDataCaclService;
	}

	public void setAttDataCaclService(AttDataCaclService attDataCaclService) {
		this.attDataCaclService = attDataCaclService;
	}

	public ActivePageAPI getActivePageAPI() {
		return activePageAPI;
	}

	public void setActivePageAPI(ActivePageAPI activePageAPI) {
		this.activePageAPI = activePageAPI;
	}

	public AttDurationDAO getAttenceSetDAO() {
		return attenceSetDAO;
	}

	public void setAttenceSetDAO(AttDurationDAO attenceSetDAO) {
		this.attenceSetDAO = attenceSetDAO;
	}


	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		try {
			this.activePageAPI.executeSql("BEGIN proc_calc_age(); END;");
		} catch (SysException e) {
			e.printStackTrace();
		}
		try {
			doSelfSign();
		} catch (SysException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	public void doSelfSign() throws SysException, ParseException{
		//处理签到数据
		this.attDataCaclService.calcAttData(null, CommonFuns.getSysDate("yyyy-MM-01"), CommonFuns.getSysDate("yyyy-MM-dd"), CommonFuns.getSysDate("yyyy"), CommonFuns.getSysDate("MM"));
	}
}
