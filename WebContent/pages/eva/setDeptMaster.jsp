<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function addMaster(){
        window.showModalDialog("/eva/addDeptMaster.jsf?objectID="+document.all('form1:objectID').value, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>
<x:saveState value="#{evaDeptSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaDeptSetBB.initmaster}"></h:inputHidden>
    <h:inputHidden id="objectID" value="#{evaDeptSetBB.objectID}"></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td height=8>
        </td></tr>

        <tr><td height=8 align="left">
    </c:verbatim>
            <h:outputText value="考核客体:#{evaDeptSetBB.deptName}"></h:outputText>
    <c:verbatim>
        </td></tr>

        <tr><td height=8 align="right">
    </c:verbatim>
           <h:commandButton value="增加" styleClass="button01" onclick="return addMaster();"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <h:dataTable value="#{evaDeptSetBB.masterPersonList}" var="list" width="100%" id="dateList"
                        styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                    <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.masterID}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="姓名"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personName}"/>
                    </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="部门"/>
                </f:facet>
                <h:outputText escape="false" value="#{list.deptName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="权重"/>
                </f:facet>
                <h:outputText escape="false" value="#{list.purview}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="操作"/>
                </f:facet>
                
                <h:commandButton value="删除" styleClass="button01" action="#{evaDeptSetBB.deleteMaster}">
                     <x:updateActionListener property="#{evaDeptSetBB.masterID}" value="#{list.masterID}"/>
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
