<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<h:form id="form1">
    <x:saveState value="#{sys_parameterBB}"></x:saveState>
    <h:inputHidden value="#{sys_parameterBB.initSet}"/>
    <c:verbatim>
    <table width="98%"  border="0" align="center" cellspacing="0" cellpadding="0">
        <tr>
		    <td class="td_title" height=8>
                <img src="/images/tips.gif">��������
            </td>
        </tr>

        <tr>
		    <td height=8>
            </td>
        </tr>

        <tr>
		    <td>
    </c:verbatim>
                <x:dataTable value="#{sys_parameterBB.paraList}" var="list" align="center"  id="dateList"   rowIndexVar="index"
                             headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                             styleClass="table03" width="400" >
                    <h:column>
                        <c:facet name="header"><h:outputText value="���"/></c:facet>
                        <h:outputText value="#{index+1}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="��������"/></c:facet>
                        <h:outputText value="#{list.description}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="����ֵ"/></c:facet>
                        <h:outputText value="����" rendered="#{list.value=='true'}"></h:outputText>
                        <h:outputText value="������" rendered="#{list.value=='false'}"></h:outputText>
                        <h:outputText value="����" rendered="#{list.value=='1'}"></h:outputText>
                        <h:outputText value="�ر�" rendered="#{list.value=='0'}"></h:outputText>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="����"/></c:facet>
                        <h:commandButton value="����" rendered="#{list.value=='false'}" styleClass="button01" action="#{sys_parameterBB.configOK}">
                            <x:updateActionListener property="#{sys_parameterBB.paraKey}" value="#{list.key}"></x:updateActionListener>
                        </h:commandButton>
                        <h:commandButton value="������" rendered="#{list.value=='true'}" styleClass="button01" action="#{sys_parameterBB.configNO}">
                            <x:updateActionListener property="#{sys_parameterBB.paraKey}" value="#{list.key}"></x:updateActionListener>
                        </h:commandButton>
                        <h:commandButton value="����" rendered="#{list.value=='0'}" styleClass="button01" action="#{sys_parameterBB.configOK}">
                            <x:updateActionListener property="#{sys_parameterBB.paraKey}" value="#{list.key}"></x:updateActionListener>
                        </h:commandButton>
                        <h:commandButton value="�ر�" rendered="#{list.value=='1'}" styleClass="button01" action="#{sys_parameterBB.configNO}">
                            <x:updateActionListener property="#{sys_parameterBB.paraKey}" value="#{list.key}"></x:updateActionListener>
                        </h:commandButton>
                    </h:column>

                </x:dataTable>
    <c:verbatim>
            </td>
        </tr>

    </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>