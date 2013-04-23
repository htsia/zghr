package com.hr319wg.custom.util;

import java.util.List;
import java.util.Map;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class QuartzUtil extends QuartzJobBean{
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}


	/* (non-Javadoc)
	 * @see org.springframework.scheduling.quartz.QuartzJobBean#executeInternal(org.quartz.JobExecutionContext)
	 */
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		//����ʱ��
		this.jdbcTemplate.execute("BEGIN proc_calc_age(); END;");
	}
	
	/**
	 * ��װ��������
	 * @param titles
	 * @param list
	 * @param content
	 * @param changetype 1:����2����ְ3����λ�춯
	 */
	private void setEmailContent(String[]titles, List list, StringBuffer content, int changetype){ 
		String[]changetypes={"��Ա����","��Ա��ְ","��λ�䶯"};
		content.append("<div style='font-size:14px;font-weight:bold;margin:20px 0 5px 0;'>"+changetypes[changetype]+"</div><table width='800' border='1'  cellpadding='0' cellspacing='0' bordercolor='gray'><tr>");
		for(int i=0;i<titles.length;i++){
			content.append("<td align='center' width='100'>"+titles[i]+"</td>");			
		}
 		content.append("</tr>");
 		for(int i=0;i<list.size();i++){
 			content.append("<tr>");
 			Map m = (Map)list.get(i);
 			for(int j=0;j<titles.length;j++){
 				content.append("<td align='center'>"+((m.get(titles[j])==null || "null".equals(m.get(titles[j])))?"":m.get(titles[j]))+"</td>"); 				
 			}
 			content.append("</tr>");
 		}
 		content.append("</table>");
	}
}
