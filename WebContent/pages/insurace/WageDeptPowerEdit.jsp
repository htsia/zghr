<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript">
           function doCheck(){
               if (document.all('form1:dept').value=="-1"){
                   alert("请选择部门！");
                   return false;
               }
               return true;
           }
    </script>
<x:saveState value="#{ins_deptpowerBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{ins_deptpowerBB.pageInit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="帐套"/>
            <h:outputText value="#{ins_deptpowerBB.setName}"></h:outputText>

            <h:outputText value="姓名" />
            <h:outputText id="name" value="#{ins_deptpowerBB.personName}"/>

            <h:outputText value="有权限部门" />
            <h:selectOneMenu id="dept" value="#{ins_deptpowerBB.wbo.deptID}">
                <c:selectItems value="#{ins_deptpowerBB.deptList}"></c:selectItems>
            </h:selectOneMenu>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{ins_deptpowerBB.save}"
                             onclick="return doCheck();"/>
            <h:commandButton type="button" styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
