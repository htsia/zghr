<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%
    try {
        String itemId = request.getParameter("itemId");
        IXysKpiDeptUCC ucc=(IXysKpiDeptUCC)SysContext.getBean("xysKpiDeptUCC");
        XysKpiObjKeyBO bo=ucc.findXysKpiObjKeyBOById(itemId);
        out.println(bo.getHiValue()+","+CommonFuns.filterNullToZero(bo.getLowValue()));
    } catch (Exception e) {
    	e.printStackTrace();
    }
%>
