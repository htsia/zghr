<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doCopyDetp(){
            reval=window.showModalDialog("/wage/set/SetWageSet.jsf?UnitID="+document.getElementById('form1:unitId').value+"&SetID="+document.getElementById('form1:setId').value, null, "dialogWidth:320px; dialogHeight:150px;center:center;resizable:yes;status:yes;scroll:yes;");
            if (reval != null && reval!="") {
                form1.all("form1:curSetId").value = reval;
                return true;
            } else {
                return false;
            }
        }
        function doAdd(){
            window.showModalDialog("/wage/set/WageDeptEdit.jsf?setID="+document.getElementById("form1:setId").value+"&size="+document.getElementById("form1:listSize").value, null, "dialogWidth:330px; dialogHeight:480px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModify(id) {
            window.showModalDialog("/wage/set/WageDeptEdit.jsf?itemID="+id+"&setID="+document.getElementById("form1:setId").value, null, "dialogWidth:330px; dialogHeight:480px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wage_deptBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{wage_deptBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_deptBB.setID}"/>
    <h:inputHidden id="unitId" value="#{wage_deptBB.unitId}"/>
    <h:inputHidden id="curSetId" value="#{wage_deptBB.curSetId}"/>
    <h:inputHidden id="listSize" value="#{wage_deptBB.listSize}"/>

    <c:verbatim>
    <table height=96% width=98% align="center">
        <tr >
            <td height=8>
    </c:verbatim>
            <h:panelGrid columns="2" width="100%" styleClass="td_title">
                <h:outputText value="н�����ף�#{wage_deptBB.setName}"/>
                <h:panelGrid align="right" columns="2">
                    <h:commandButton value="���Ʋ��Ŷ���" styleClass="button01" onclick="return doCopyDetp();" action="#{wage_deptBB.copyDept}"></h:commandButton>
                    <h:commandButton value="����" styleClass="button01" onclick="doAdd()"></h:commandButton>
                </h:panelGrid>
            </h:panelGrid>
<c:verbatim>
            </td>
         </tr>

         <tr>
             <td height=8>
</c:verbatim>
                 <h:outputText escape="false" value="<strong>˵����</strong>"/>
                 <c:verbatim>н�ʲ��Ÿ�ʽΪ:<% out.print(Constants.WAGE_DEPT_CODELEN);%>λ���+��������,��Ž�������˳��.
             </td>
         </tr>
        
        <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                <h:dataTable value="#{wage_deptBB.list}" var="list" align="center" id="dateList"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                         styleClass="table03" width="100%" >
                <h:column>
                    <c:facet name="header"><h:outputText value="����"/></c:facet>
                    <h:outputText value="#{list.name}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����1"/></c:facet>
                    <h:outputText value="#{list.highName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����2"/></c:facet>
                    <h:outputText value="#{list.highName2}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����3"/></c:facet>
                    <h:outputText value="#{list.highName3}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����4"/></c:facet>
                    <h:outputText value="#{list.highName4}"/>
                </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="����5"/></c:facet>
                        <h:outputText value="#{list.highName5}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="����6"/></c:facet>
                        <h:outputText value="#{list.highName6}"/>
                    </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����1"/></c:facet>
                    <h:outputText value="#{list.para1}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="����2"/></c:facet>
                    <h:outputText value="#{list.para2}"/>
                </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="������������"/></c:facet>
                        <h:outputText value="#{list.linkOrgNames}"/>
                    </h:column>
				<h:column>
                        <c:facet name="header"><h:outputText value="����"/></c:facet>
                        <h:commandButton value="�޸�"   styleClass="button01" onclick="return forModify('#{list.itemID}');">
                        </h:commandButton>

                        <h:commandButton value="ɾ��" action="#{wage_depteditBB.delete}"   styleClass="button01" onclick="return confirm('ȷ��ɾ����')">
                            <x:updateActionListener property="#{wage_depteditBB.wdb.itemID}" value="#{list.itemID}"></x:updateActionListener>
                        </h:commandButton>

                        <h:commandButton value="����ͬ��"   styleClass="button01" action="#{wage_deptBB.updateData}">
                            <x:updateActionListener property="#{wage_deptBB.itemID}" value="#{list.itemID}"></x:updateActionListener>
                        </h:commandButton>

                    </h:column>
            </h:dataTable>
<c:verbatim>
            </div>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>