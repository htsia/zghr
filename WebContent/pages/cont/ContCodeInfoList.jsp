<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doAdd(){
            window.showModalDialog("/cont/CondCodeAdd.jsf", null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doModify(id){
            window.showModalDialog("/cont/CondCodeAdd.jsf?CodeID="+id, null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doShowUse(id){
            window.showModalDialog("/cont/CondCodeUse.jsf?Orguid="+id, null, "dialogWidth:400px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{cont_codeinfoBB}"/>
<h:form id="form1">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" ��ͬ���� ->  ��ͬ��Ź���"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" align="center" width="98%" >
       <h:panelGrid columns="2" align="right">
         <h:commandButton styleClass="button01" value="����" onclick="doAdd();"></h:commandButton>
       </h:panelGrid>
        
        <h:dataTable value="#{cont_codeinfoBB.dataList}" var="list" align="center"  id="dateList"
                         headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                         styleClass="table03" width="90%" >
                <h:column>
                    <c:facet name="header"><h:outputText value="�������"/></c:facet>
                    <h:outputText value="#{list.code}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="��������"/></c:facet>
                    <h:outputText value="#{list.name}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����һ����"/></c:facet>
                    <h:outputText value="#{list.low1}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����һ����"/></c:facet>
                    <h:outputText value="#{list.high1}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="���ζ�����"/></c:facet>
                    <h:outputText value="#{list.low2}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="���ζ�����"/></c:facet>
                    <h:outputText value="#{list.high2}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����������"/></c:facet>
                    <h:outputText value="#{list.low3}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="����������"/></c:facet>
                    <h:outputText value="#{list.high3}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����"/></c:facet>
                        <h:commandButton value="�޸�" styleClass="button01" onclick="doModify('#{list.orguid}')" />
                        <h:commandButton value="ɾ��" styleClass="button01" action="#{cont_codeinfoBB.delete}">
                          <x:updateActionListener property="#{cont_codeinfoBB.orguid}" value="#{list.orguid}"/>
                        </h:commandButton>
                        <h:commandButton value="���ʹ�ò�ѯ" styleClass="button01" onclick="doShowUse('#{list.orguid}')" />
                </h:column>
            </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
