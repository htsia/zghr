<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doCheck() {
            if (document.all("form1:name").value==""){
                alert("��¼������!");
                return false;
            }
            if (document.all("form1:desc").value==""){
                alert("��¼������!");
                return false;
            }
            if (document.all("form1:fileExtent").value==""){
                alert("��ѡ���ļ���ʽ!");
                return false;
            }
            return true;
        }
    </script>
<x:saveState value="#{wage_wageItemSetBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_wageItemSetBB.editItem}"/>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="н����Ŀ����"/>
            <h:inputText id="name" value="#{wage_wageItemSetBB.costFieldBo.fieldNameEx}" />

            <h:outputText value="�ɱ�����" />
            <h:panelGroup>
                <h:inputText id="code" value="#{wage_wageItemSetBB.costFieldBo.costType}"
                             code="" dict="yes" dict_num="0280" readonly="true" alt="�����ɱ���|1" styleClass="input"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:code','','0')"/>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" onclick="return forsubmit(document.forms(0));" action="#{wage_wageItemSetBB.saveItem}" />
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
  <script type="text/javascript">
      interpret(form1);
  </script>
