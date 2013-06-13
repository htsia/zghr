<%@page import="com.hr319wg.util.CommonFuns"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<%
	JdbcTemplate jdbc=(JdbcTemplate)SysContext.getBean("jdbcTemplate");
	String sql="select id,a001077 from a001 where a001077 is not null and id not in (select r.person_id from sys_role_user_r r where r.role_id<>'08')";
	List list=jdbc.queryForList(sql);
	if(list!=null){
		for(int i=0;i<list.size();i++){
			Map m=(Map)list.get(i);
			sql="update sys_user_info s set s.login_pwd='"+CommonFuns.md5(m.get("a001077").toString())+"' where s.person_id='"+m.get("id")+"'";
			jdbc.execute(sql);
		}
	}
%>
</body>
</html>