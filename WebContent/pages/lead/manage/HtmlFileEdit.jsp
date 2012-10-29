<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function popDate(flag) {
            if (flag=="05"){
                PopUpCalendarDlg_OnlyYear("form1:archivesDate");
            }
            else if (flag=="02"){
                PopUpCalendarDlg_OnlyMonth("form1:archivesDate");
             }
             else{
                 PopUpCalendarDialog("form1:archivesDate");
             }
             return false;
        }
        function doCheck(){
            if (document.all("form1:archivesDate").value==""){
                alert("请选择时间！")
                return false;
            }

            if (document.all("form1:resId").value==""){
                alert("请选择类型！")
                return false;
            }
            return true;
        }

    </script>

<x:saveState value="#{htmlBackingBean}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden id="pageInit" value="#{htmlBackingBean.beginEdit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{htmlBackingBean.save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="类型"/>
            <h:selectOneMenu id="resId" value="#{htmlBackingBean.htmlFileBO.resId}">
                <c:selectItems value="#{htmlBackingBean.resList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="时间"/>
             <h:panelGroup>
                <h:inputText id="archivesDate" readonly="true" value="#{htmlBackingBean.htmlFileBO.archivesDate}" />
                <h:commandButton type="button" styleClass="button_select" onclick="return popDate('#{htmlBackingBean.htmlFileBO.resFre}');" />
            </h:panelGroup>


            <h:outputText value="内容"/>
            <h:panelGroup>
                <x:inputFileUpload styleClass="input" id="excelFile" value="#{htmlBackingBean.excelFile}"  storage="file" size="30" />
            </h:panelGroup>

            <h:outputText value="附件(ZIP文件)"/>
            <h:panelGroup>
                <x:inputFileUpload styleClass="input" id="zipFile" value="#{htmlBackingBean.zipFile}"  storage="file" size="30" />
            </h:panelGroup>

        </h:panelGrid>

    </h:panelGrid>
</h:form>
