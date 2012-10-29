<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXys360UCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%
    try {
        String itemId = request.getParameter("itemId");
        IXys360UCC ucc=(IXys360UCC)SysContext.getBean("xys360UCC");
        Xys360ObjKeyBO bo=ucc.findXys360ObjKeyBOById(itemId);
        out.println(bo.getHiValue()+","+CommonFuns.filterNullToZero(bo.getLowValue()));
    } catch (Exception e) {
    	e.printStackTrace();
    }
%>
