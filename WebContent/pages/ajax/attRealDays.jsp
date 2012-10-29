<%@page import="com.hr319wg.custom.attence.util.AttConstants"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.hr319wg.xys.workflow.service.SelPersonsToolService"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page
	import="com.hr319wg.custom.attence.service.IAttBusiService"%>
<%
    String beginTime = request.getParameter("beginTime");
    String endTime = request.getParameter("endTime");
    IAttBusiService attBusiService = (IAttBusiService) SysContext.getBean("attBusiServiceImpl");
    User user=(User)session.getAttribute("USER_INFO");
    String userId=user.getUserId();
    double realDays=attBusiService.getRealDays(userId, beginTime, endTime);
    
 	// Ϊ�������ò���
    SelPersonsToolService selPersonsTool = (SelPersonsToolService) SysContext.getBean("selPersonTool");
 	try{
		int leaderType = selPersonsTool.getLeaderType(user.getUserId());
		Map map = new HashMap();
		map.put("proposerId", user.getUserId());
		map.put("currPersonId", user.getUserId());
		map.put("leaderType", leaderType);
		map.put("leaveDays", realDays);
		
		String postLevel = selPersonsTool.getPostLevel(user.getUserId());// ��λ����
		String keyId = AttConstants.getAttFlowKey(postLevel);// ����KEY
		String userNames = selPersonsTool.getAllApprUserNames(user.getUserId(), keyId, map);
	    out.println(realDays+","+userNames);
 	}catch(Exception e){
 		out.print(-1);
 	}
%>