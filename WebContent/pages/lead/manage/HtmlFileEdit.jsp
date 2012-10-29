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
                alert("��ѡ��ʱ�䣡")
                return false;
            }

            if (document.all("form1:resId").value==""){
                alert("��ѡ�����ͣ�")
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
            <h:commandButton styleClass="button01" value="����" action="#{htmlBackingBean.save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="����"/>
            <h:selectOneMenu id="resId" value="#{htmlBackingBean.htmlFileBO.resId}">
                <c:selectItems value="#{htmlBackingBean.resList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="ʱ��"/>
             <h:panelGroup>
                <h:inputText id="archivesDate" readonly="true" value="#{htmlBackingBean.htmlFileBO.archivesDate}" />
                <h:commandButton type="button" styleClass="button_select" onclick="return popDate('#{htmlBackingBean.htmlFileBO.resFre}');" />
            </h:panelGroup>


            <h:outputText value="����"/>
            <h:panelGroup>
                <x:inputFileUpload styleClass="input" id="excelFile" value="#{htmlBackingBean.excelFile}"  storage="file" size="30" />
            </h:panelGroup>

            <h:outputText value="����(ZIP�ļ�)"/>
            <h:panelGroup>
                <x:inputFileUpload styleClass="input" id="zipFile" value="#{htmlBackingBean.zipFile}"  storage="file" size="30" />
            </h:panelGroup>

        </h:panelGrid>

    </h:panelGrid>
</h:form>
