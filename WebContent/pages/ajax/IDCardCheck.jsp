<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@page import="com.hr319wg.custom.util.IDCardUtil"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/html;charset=GBK");
    
    String card=request.getParameter("card");
    boolean pass= IDCardUtil.validateCard(card);
    int result=1;//0非法 1通过 2重复
    if(!pass){
    	result=0;
    }
    if(pass){
	    JdbcTemplate jdbc=(JdbcTemplate)SysContext.getBean("jdbcTemplate");
    	String sql="select count(a001077) from a001 where a001077='"+card+"'";
    	int count=jdbc.queryForInt(sql);
    	if(count>0){
    		result=2;
    	}
    }
    out.print(result);
%>
