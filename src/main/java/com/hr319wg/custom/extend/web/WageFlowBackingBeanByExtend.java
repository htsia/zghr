package com.hr319wg.custom.extend.web;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.wage.util.WageTools;
import com.hr319wg.wage.web.WageFlowBackingBean;

public class WageFlowBackingBeanByExtend extends WageFlowBackingBean {

	public String submitEndDialog() {
		try {
			if (WageTools.addWageOperCount()) {
				if (WageTools.hasWageOper(this.getDate().getSetId())) {
					super.showMessageDetail("本帐套正在发放中,不能重复发放。");
				} else {
					WageTools.addWageOper(this.getDate().getSetId());
					this.getWagecomputeucc().payoffSalary(this.getDate().getSetId(),this.getDate().getDateId());
					super.showMessageDetail("发放成功");
				}
			} else
				super.showMessageDetail("在线薪资计算、发放人数过多，请稍候发放。");
		} catch (SysException e) {
			super.showMessageDetail("错误：" + e.getMessage());
			String str = "";
			return str;
		} finally {
			WageTools.reduceWageOperCount();
			WageTools.reduceWageOper(this.getDate().getSetId());
		}

		//添加工资发放记录
		try {
			JdbcTemplate jdbc = (JdbcTemplate)SysContext.getBean("jdbcTemplate");
			String sql="select w.ID,A815701,A815473,A815211,A815200,A815406,A815267,A815321,A815308,A815202,A815209,A815208,A815219,A815708,A815713,A815235,A815234,A815218,A815201,A815379,A815203,A815221,A815223,A815291,A815334,A815224,A815204,A815205,A815314,A815206,A815207,A815710,A815714,A815720,A815721,A815486,A815216,A815711,A815715,A815716,A815717,A815718,A815736,A815739,A815741,A815755,A815756,A815758,A815748,A815750,A815751,A815752,A815753,A815754,A815735,A815737,A815738,a.a001001 username,s.code_item_id type_no,s.code_item_name type_name,b.orguid dept_no,b.b001005 dept_name from a815 w,a001 a,b001 b,sys_code_item s where w.id=a.id and a.a001705=b.orguid and a.a001054=s.code_item_id and w.A815701 like '"+this.getDate().getDate().substring(0, 7)+"%'";
			List list = jdbc.queryForList(sql); 
			if(list!=null && list.size()>0){
				for(int i=0;i<list.size();i++){
					StringBuffer b = new StringBuffer("insert into a815 ");
					Map m=(Map) list.get(i);
					b.append("select ");
					b.append(m.get("ID")+",'");
					b.append(m.get("A815701")+"',");
					b.append(m.get("A815473")+",");
					b.append(m.get("A815211")+",");
					b.append(m.get("A815200")+",");
					b.append(m.get("A815406")+",");
					b.append(m.get("A815267")+",");
					b.append(m.get("A815321")+",");
					b.append(m.get("A815308")+",");
					b.append(m.get("A815202")+",");
					b.append(m.get("A815209")+",");
					b.append(m.get("A815208")+",");
					b.append(m.get("A815219")+",");
					b.append(m.get("A815708")+",");
					b.append(m.get("A815713")+",");
					b.append(m.get("A815235")+",");
					b.append(m.get("A815234")+",");
					b.append(m.get("A815218")+",");
					b.append(m.get("A815201")+",");
					b.append(m.get("A815379")+",");
					b.append(m.get("A815203")+",");
					b.append(m.get("A815221")+",");
					b.append(m.get("A815223")+",");
					b.append(m.get("A815291")+",");
					b.append(m.get("A815334")+",");
					b.append(m.get("A815224")+",");
					b.append(m.get("A815204")+",");
					b.append(m.get("A815205")+",");
					b.append(m.get("A815314")+",");
					b.append(m.get("A815206")+",");
					b.append(m.get("A815207")+",");
					b.append(m.get("A815710")+",");
					b.append(m.get("A815714")+",");
					b.append(m.get("A815720")+",");
					b.append(m.get("A815721")+",");
					b.append(m.get("A815486")+",");
					b.append(m.get("A815216")+",");
					b.append(m.get("A815711")+",");
					b.append(m.get("A815715")+",");
					b.append(m.get("A815716")+",");
					b.append(m.get("A815717")+",");
					b.append(m.get("A815718")+",");
					b.append(m.get("A815736")+",");
					b.append(m.get("A815739")+",");
					b.append(m.get("A815741")+",");
					b.append(m.get("A815755")+",");
					b.append(m.get("A815756")+",");
					b.append(m.get("A815758")+",");
					b.append(m.get("A815748")+",");
					b.append(m.get("A815750")+",");
					b.append(m.get("A815751")+",");
					b.append(m.get("A815752")+",");
					b.append(m.get("A815753")+",");
					b.append(m.get("A815754")+",");
					b.append(m.get("A815735")+",");
					b.append(m.get("A815737")+",");
					b.append(m.get("A815738")+",");
					b.append("'"+m.get("username")+"',");
					b.append("'"+m.get("type_no")+"',");
					b.append("'"+m.get("type_name")+"',");
					b.append("'"+m.get("dept_no")+"',");
					b.append("'"+m.get("dept_name")+"'");
					SqlUtil.updateData(b.toString());
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		
		return "success";
	}
}
