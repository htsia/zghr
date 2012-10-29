<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function foradd(){
            window.showModalDialog("/wage/set/TemplateEdit.jsf?setID="+document.all("form1:setID").value, null, "dialogWidth:580px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function formodify(tempid){
            window.showModalDialog("/wage/set/TemplateEdit.jsf?TemplateID="+tempid+"&setID="+document.all("form1:setID").value, null, "dialogWidth:580px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function confirmDel() {
            if (confirm('确定要删除吗？')) return true;
            return false;
        }
    </script>

<x:saveState value="#{wage_templateSetBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{wage_templateSetBB.pageInit}"/>
    <h:panelGrid align="center" border="0" cellpadding="0" cellspacing="0" width="98%" columns="3" styleClass="td_title">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" 薪酬管理 ->  录入模版设置"/>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText value="所属帐套："></h:outputText>
            <h:selectOneMenu id="setID" value="#{wage_templateSetBB.setid}" onchange="submit()" valueChangeListener="#{wage_templateSetBB.changeSet}">
                <c:selectItems value="#{wage_templateSetBB.setList}"></c:selectItems>
            </h:selectOneMenu>
        </h:panelGroup>

        <h:panelGrid align="right" columns="1" cellspacing="2">
                <h:commandButton styleClass="button01" value="新建" onclick="foradd()" rendered="#{wage_templateSetBB.operRight}"/>
        </h:panelGrid>

       </h:panelGrid>

       <c:verbatim><br></c:verbatim>

       <h:dataTable value="#{wage_templateSetBB.templateList}" var="list"   id="dateList"
                     headerClass="td_top"  width="95%" align="center"
                     styleClass="table03"  columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle_center,td_middle_center">
            <h:column>
                <c:facet name="header"><h:outputText value="名称"/></c:facet>
                <h:outputText value="#{list.tempname}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="内容"/></c:facet>
                <h:outputText value="#{list.fieldnames}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="所属帐套"/></c:facet>
                <h:outputText value="#{list.wagesetname}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:panelGrid align="center" columns="4" cellspacing="2">
                    <h:commandButton styleClass="button01"  value="修改" onclick="formodify('#{list.tempid}')">
                    </h:commandButton>
                    <h:commandButton styleClass="button01"  value="删除" onclick="return confirmDel();" action="#{wage_templateSetBB.delete}">
                      <x:updateActionListener property="#{wage_templateSetBB.templateid}" value="#{list.tempid}"/>
                    </h:commandButton>
                </h:panelGrid>
            </h:column>
        </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
