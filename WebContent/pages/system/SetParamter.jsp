<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<h:form id="form1">
    <x:saveState value="#{sys_parameterBB}"></x:saveState>
    <h:inputHidden value="#{sys_parameterBB.initSet}"/>
    <c:verbatim>
    <table width="98%"  border="0" align="center" cellspacing="0" cellpadding="0">
        <tr>
		    <td class="td_title" height=8>
                <img src="/images/tips.gif">参数设置
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
                        <c:facet name="header"><h:outputText value="序号"/></c:facet>
                        <h:outputText value="#{index+1}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="参数内容"/></c:facet>
                        <h:outputText value="#{list.description}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="参数值"/></c:facet>
                        <h:outputText value="允许" rendered="#{list.value=='true'}"></h:outputText>
                        <h:outputText value="不允许" rendered="#{list.value=='false'}"></h:outputText>
                        <h:outputText value="开启" rendered="#{list.value=='1'}"></h:outputText>
                        <h:outputText value="关闭" rendered="#{list.value=='0'}"></h:outputText>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="操作"/></c:facet>
                        <h:commandButton value="允许" rendered="#{list.value=='false'}" styleClass="button01" action="#{sys_parameterBB.configOK}">
                            <x:updateActionListener property="#{sys_parameterBB.paraKey}" value="#{list.key}"></x:updateActionListener>
                        </h:commandButton>
                        <h:commandButton value="不允许" rendered="#{list.value=='true'}" styleClass="button01" action="#{sys_parameterBB.configNO}">
                            <x:updateActionListener property="#{sys_parameterBB.paraKey}" value="#{list.key}"></x:updateActionListener>
                        </h:commandButton>
                        <h:commandButton value="开启" rendered="#{list.value=='0'}" styleClass="button01" action="#{sys_parameterBB.configOK}">
                            <x:updateActionListener property="#{sys_parameterBB.paraKey}" value="#{list.key}"></x:updateActionListener>
                        </h:commandButton>
                        <h:commandButton value="关闭" rendered="#{list.value=='1'}" styleClass="button01" action="#{sys_parameterBB.configNO}">
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