<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function confirmDel() {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm('确定要删除吗？'))
                    return true;
            }
            return false;
        }
    </script>
<x:saveState value="#{wage_noteBB}"/>
<h:form id="form1">
     <h:inputHidden value="#{wage_noteBB.pageInit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="薪酬管理 -> 员工薪资变动"/>
       </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" align="center">
        <h:outputText value=" 发薪单位：#{wage_noteBB.unitName}"/>
        <h:panelGrid columns="2" width="100%" >
            <h:panelGrid columns="5" align="left">
                <h:outputText value="开始时间"/>
                <h:panelGroup>
                    <h:inputText id="startDate" value="#{wage_noteBB.startdate}"/>
                    <h:commandButton type="button" styleClass="button_date"
                                     onclick="PopUpCalendarDialog(form1.all('form1:startdate'))"/>
                </h:panelGroup>

                <h:outputText value="结束时间"/>
                <h:panelGroup>
                    <h:inputText id="endDate" value="#{wage_noteBB.enddate}"/>
                    <h:commandButton type="button" styleClass="button_date"
                                     onclick="PopUpCalendarDialog(form1.all('form1:enddate'))"/>
                </h:panelGroup>

                <h:commandButton value="查询" styleClass="button01" action="#{wage_noteBB.list}" id="doQuery"/>
            </h:panelGrid>

            <h:panelGrid columns="3" align="right">
                <h:commandButton value="导出到Excel" styleClass="button01" action="#{wage_noteBB.exportFile}"/>
                <h:commandButton value="新增" styleClass="button01" action="#{wage_noteBB.create}"/>
                <h:commandButton value="删除" styleClass="button01" action="#{wage_noteBB.delete}"
                                 onclick="return confirmDel();"/>
            </h:panelGrid>
        </h:panelGrid>

        <h:dataTable value="#{wage_noteBB.noteList}" var="list"
                     headerClass="td_top"  id="dateList"
                     columnClasses="td_middle_center,td_middle_center, td_middle_center,td_middle,td_middle,td_middle_center, td_middle_center, td_middle_center"
                     styleClass="table03" width="100%">
            <h:column>
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll"
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <div align="center"> <input type="checkbox" name="selectItem"
                    value="</c:verbatim><h:outputText value="#{list.noteId}"/><c:verbatim>"></div></c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="变动日期"/></c:facet>
                <h:outputText value="#{list.date}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="人员"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
                <h:outputText value="#{list.personDept}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="变动事由"/></c:facet>
                <h:outputText value="#{list.cause}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="变动依据"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="相关帐套"/></c:facet>
                <h:outputText value="#{list.linkSet}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作类型"/></c:facet>
                <h:outputText value="#{list.operType}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton styleClass="button01" action="#{wage_noteBB.find}" value="修改">
                    <x:updateActionListener property="#{wage_noteBB.note.noteId}" value="#{list.noteId}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
