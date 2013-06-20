<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function add() {
        window.showModalDialog("/xys/eva/StudentGradeEdit.jsf?planId=" + document.all("form1:planId").value, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
   
    function modify(id) {
        window.showModalDialog("/xys/eva/StudentGradeEdit.jsf?scoreId="+id, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
   
    
</script>
<x:saveState value="#{regStrudentGradeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{regStrudentGradeBB.initInput}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{regStrudentGradeBB.superId}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{regStrudentGradeBB.planId}"></h:inputHidden>
    <c:verbatim>
        <table height=98% width=98% align="center">
        <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
        <h:panelGrid align="left">
            <h:panelGroup>
                <h:outputText value="姓名或员工编号:"></h:outputText>
                <h:inputText value="#{regStrudentGradeBB.queryValue}"/>
                <h:commandButton value="查询" action="#{regStrudentGradeBB.queryScoere}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{regStrudentGradeBB.mypage.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="页数:#{regStrudentGradeBB.mypage.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="每页有#{regStrudentGradeBB.mypage.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="当前为第#{regStrudentGradeBB.mypage.currentPage}页"></h:outputText>
                <h:commandButton value="首页" action="#{regStrudentGradeBB.first1}" styleClass="button01"></h:commandButton>
                <h:commandButton value="上页" action="#{regStrudentGradeBB.pre1}" styleClass="button01"></h:commandButton>
                <h:commandButton value="下页" action="#{regStrudentGradeBB.next1}" styleClass="button01"></h:commandButton>
                <h:commandButton value="尾页" action="#{regStrudentGradeBB.last1}" styleClass="button01"></h:commandButton>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="增加"  styleClass="button01" onclick="add()"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
        </td></tr>
        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
    <h:dataTable value="#{regStrudentGradeBB.personList}" var="list" align="center" id="dateList"
                 headerClass="td_top"
                 columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%">
        
        
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="评价一得分"/></c:facet>
            <h:outputText value="#{list.score}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="评价二得分"/></c:facet>
            <h:outputText value="#{list.score2}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="平均分"/></c:facet>
            <h:outputText value="#{list.avgScore}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.scoreId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" action="#{regStrudentGradeBB.delete}" onclick="return confirm('确定要删除选中计划吗？');"
                            styleClass="button01">
                  <x:updateActionListener property="#{regStrudentGradeBB.scoreId}" value="#{list.scoreId}"/>
            </h:commandButton>
        </h:column>
    </h:dataTable>
    <c:verbatim>
        </div>
        </td></tr>
        </table>
       
    </c:verbatim>

</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>
