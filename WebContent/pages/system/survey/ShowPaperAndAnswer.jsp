<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.ucc.impl.SurveyUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.self.pojo.bo.SurveyResultBO" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim> <base target="_self"></c:verbatim>
<x:saveState value="#{sys_surveyBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{sys_surveyBB.initBrow}"></h:inputHidden>
    <h:inputHidden value="#{sys_surveyBB.currentID}"></h:inputHidden>
<c:verbatim> 	
	<table  width="100%" height="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" >
		 <tr>
		  <td align="right" >
              <img alt="ä¯ÀÀÎÊ¾í" src="/images/tips.gif">
              <%=LanguageSupport.getResource( "XTGL-1394", "  ä¯ÀÀÎÊ¾í")%>
</c:verbatim>
              <h:selectOneMenu id="personID" value="#{sys_surveyBB.personID}" style="width:200px">
	            <c:selectItems value="#{sys_surveyBB.surveyPersonList}"/>
	          </h:selectOneMenu>
	         <h:commandButton value="²éÑ¯" action="#{sys_surveyBB.doBrow}" styleClass="button01" />
	         <h:commandButton value="¹Ø±Õ" onclick="window.close()" type="button" styleClass="button01" />
<c:verbatim>
          </td>
        </tr>

        <tr>
         <td>
          	<jsp:include page="/pages/common/ShowSurveyooo.jsp"></jsp:include>
         </td>
   		</tr>
       </table>
</c:verbatim>      
</h:form>   
