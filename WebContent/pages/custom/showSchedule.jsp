<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@page import="com.hr319wg.common.Constants"%>
<%@page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>日程查看</title>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
<script type="text/javascript" language="javascript" src="/js/check.js"></script>
<%
	User user = (User)session.getAttribute(Constants.USER_INFO);
	String sql="select w.activity,w.work_date from att_work_calendar w where w.person_id='"+user.getUserId()+"' order by w.seq";
	JdbcTemplate jdbcTemplate=(JdbcTemplate)SysContext.getBean("jdbcTemplate");
	List list=jdbcTemplate.queryForList(sql);
	if(list==null){
		list=new ArrayList();
	}
%>
</head>
<body bgcolor="aliceblue">
	<table  width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td class="td_title" style="font-size:15px;"><img src="/images/tips.gif">日程查看</td>
        </tr>
    </table>
	<table width="98%" border="0" align="center" id="dataList"
		class="table03">
		<tr>
			<td class="td_top" style="font-size:14px;">日程安排</td>
			<td class="td_top" style="font-size:14px;">日期</td>
		</tr>
		<%
			for(int i=0;i<list.size();i++){
				Map m=(Map)list.get(i);
				%>
				<tr>
					<td class="td_middle"><%=m.get("activity") %></td>
					<td class="td_middle"><%=m.get("work_date") %></td>
				</tr>
				<%
			}
		%>
	</table>
</body>
</html>