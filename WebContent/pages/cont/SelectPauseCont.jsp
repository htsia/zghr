<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
<title></title>
</head>
<script type="text/javascript" language="javascript">
   function selectPauseCont() {
            var field = form1.all('selected_ids');
            if (checkMutilSelect(field)) {
                revalue = "";
                count = field.length;
                if (count != null) {
                    for (i = 0; i < count; i++)
                        if (field[i].checked) {
                            revalue += field[i].value + ",";
                        }
                } else {
                    revalue = field.value;
                }
                window.returnValue = revalue;
                window.close();
            } else {
                alert("��ѡ����Ա��");
                return false;
            }
        }
</script>
<body>

<base target="_self">
<h:panelGrid width="100%" border="0" cellspacing="0" cellpadding="0" >
   <h:outputText value="ѡ��Ҫ���лָ����к�ͬ��Ա��" styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_contSelectPauseContBB.init_a}"/>
<h:panelGrid  border="0"  align="center" columns="1" width="100%">
     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="2" >
        <c:verbatim escape="false">
            <input type="button"  class="button01" value="ȷ��" onclick="selectPauseCont()">
        </c:verbatim>
        <h:commandButton  value="ȡ��" styleClass="button01" onclick="javascript:window.close();"/>
     </h:panelGrid>
</h:panelGrid>
<center>
<x:dataTable value="#{cont_contSelectPauseContBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="100%" border="1">
             <h:column>
                   <c:facet name="header">
                   <c:verbatim escape="false">
                   <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                   </c:verbatim>
                   </c:facet>
                   <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                   <h:outputText value="#{list.contId}"/>
                   <c:verbatim>"></c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
                <h:outputText value="#{list.contPersonBO.personSex}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="���֤����"/></c:facet>
                <h:outputText value="#{list.contPersonBO.idCard}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�ù����"/></c:facet>
                <h:outputText value="#{list.contPersonBO.jobType}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��ֹ��ͬ���"/></c:facet>
                <h:outputText value="#{list.contCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ֹ��ͬ��ʼʱ��"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ֹ��ͬ����ʱ��"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>

</x:dataTable>
<br/>
</center>
</h:form>
</body>
</html>