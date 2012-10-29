<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.hr319wg.common.web.SysContext" %>
<%@page import="com.hr319wg.xys.workflow.service.ActivitiToolsService" %> 
<%@page import="java.util.*" %> 
<%@page import="org.activiti.engine.impl.pvm.process.ActivityImpl" %>
<%
	String processInstanceId=request.getParameter("processInstanceId");
    ActivitiToolsService tools=(ActivitiToolsService)SysContext.getBean("activitiToolService");
    boolean isFinish=tools.checkProcessIsFinish(processInstanceId);
    Map map=null;
    ActivityImpl coordinateObj=null;
    String processDefinitionId=null;
    if(!isFinish){
     map=tools.getProcessImgMap(processInstanceId);
     coordinateObj=(ActivityImpl)map.get("coordinateObj");
     processDefinitionId=(String)map.get("processDefinitionId");
    }else{
    	processDefinitionId=tools.getProcessDefinitionId(processInstanceId);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
<head>  
    <title></title>  
</head>  
<body>  
    <div>  
        <img src="showImg.jsp?processDefinitionId=<%=processDefinitionId%>" style="position:absolute; left:0px; top:0px;">  
        <!-- 给执行的节点加框 --> 
        <%
          if(!isFinish){
        %> 
        <div style="position:absolute; border:2px solid red;left:<%=coordinateObj.getX()-1 %>px;top:<%=coordinateObj.getY()-1 %>px;width:<%=coordinateObj.getWidth()%>px;height:<%=coordinateObj.getHeight()%>px;"></div>  
        <%
          }
        %>
    </div>  
  
</body>  
</html>  
