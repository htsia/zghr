<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.eva.ucc.impl.EvaKeyItemUCC" %>
<%@ page import="com.hr319wg.eva.pojo.bo.EvaKeyItemBO" %>

<%
    try {
        String itemId = request.getParameter("itemId");
        System.out.println(itemId);
        EvaKeyItemUCC ucc=(EvaKeyItemUCC)SysContext.getBean("eva_keyitemucc");
        EvaKeyItemBO bo=ucc.getEvaKeyItemBO(itemId);
        out.println(bo.getHighValue()+","+bo.getLowValue());
    } catch (Exception e) {
    	e.printStackTrace();
    }
%>
