<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function setModiPower(setID){
            window.showModalDialog("/wage/set/SetPowerEdit.jsf?setID=" + setID, "", "dialogWidth:500px; dialogHeight:400px; status:0;");
            return false;
        }
        function setPostLink(setID){
            window.showModalDialog("/wage/set/PostLink.jsf?setID=" + setID, "", "dialogWidth:400px; dialogHeight:500px; status:0;");
            return false;
        }
        function doOrgInsuracer(setID){
            window.showModalDialog("/wage/set/OrgInsSet.jsf?setID=" + setID, "", "dialogWidth:400px; dialogHeight:300px; status:0;");
            return false;
        }
        function doTry(setID){
            window.showModalDialog("/wage/payoff/ComputePersonListTry.jsf?setID=" + setID, "", "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px; status:0;");
            return false;
        }
        function modifySet(setid){
           window.showModalDialog("/wage/set/SetEdit.jsf?setID=" + setid, "", "dialogWidth:800px; dialogHeight:600px; status:0;");
           return true;
        }

        function addSet(){
           window.showModalDialog("/wage/set/SetEdit.jsf?unitID=" + document.all('form1:unitId').value, "", "dialogWidth:800px; dialogHeight:600px; status:0;");
           return true;
        }
        function queryPersonNotInSet(){
            var unitId = form1.all("form1:unitId").value;
            var arg = "&unitId=" + unitId;
            window.open("/wage/set/PersonNotInSetQuery.jsf?act=qryPersNotInSet&" + arg, "��ѯδ����������Ա", "left=10,top=50,height=600,width=1000,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
        }
        function confirmDel() {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm('ȷ��Ҫɾ����������ɾ�����������׵Ĺ�ʽ���Ա������н���'))
                    return true;
            }
            return false;
        }
        // ����н�ʲ���
        function doOpenWageDept(setId){
            window.showModalDialog("/wage/set/SetWageDeptList.jsf?setID=" + setId, "", "dialogWidth:"+screen.width*2/3+"px; dialogHeight:"+screen.height*2/3+"px; status:0;");
            return false;
        }
        function doOpenDeptPower(setId){
            window.showModalDialog("/wage/set/SetWageDeptPower.jsf?setID=" + setId, "", "dialogWidth:500px; dialogHeight:400px; status:0;");
            return false;
        }
        function doOpenGroupPayoffPower(setId){
            window.showModalDialog("/wage/set/SetGroupDeptPower.jsf?setID=" + setId, "", "dialogWidth:500px; dialogHeight:400px; status:0;");
            return false;
        }
        function doOpenInputPower(setId){
            window.showModalDialog("/wage/set/SetInputPower.jsf?setID=" + setId, "", "dialogWidth:500px; dialogHeight:400px; status:0;");
            return false;
        }
        function doWageDeptSum(setId){
            //alert(setId);
            window.showModalDialog("/wage/base/SetWageDeptItem.jsf?setID=" + setId, "", "dialogWidth:"+screen.width*2/3+"px; dialogHeight:"+screen.height*2/3+"px; status:0;");
            return false;
        }
    </script>


<x:saveState value="#{wage_setBB}"/>
<x:saveState value="#{wage_setItemBB}"/>
<x:saveState value="#{wage_setPersonBB}"/>
<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{wage_setBB.pageInit}"/>
    <h:inputHidden id="unitId" value="#{wage_setBB.wageset.unitId}"/>
    <c:verbatim>
        <table height=97% width=98% align="center" >
        <tr><td height=8>
   </c:verbatim>         
        <h:panelGrid align="center" columns="3" width="100%">
            <h:outputText escape="fasle" value="<strong>��н��λ��</strong>#{wage_setBB.unitName}"/>

            <h:panelGroup>
            <h:selectBooleanCheckbox value="#{wage_setBB.showOnlyUse}" onclick="submit();" valueChangeListener="#{wage_OrderInputBB.changeOrder}"></h:selectBooleanCheckbox>
            <h:outputText value="����ʾ����"></h:outputText>
            </h:panelGroup>

            <h:panelGrid align="right" columns="3" cellspacing="2">
                <h:commandButton styleClass="button01" value="�½�����" onclick="return addSet();" rendered="#{wage_setBB.oper063102}"/>
                <h:commandButton styleClass="button01" value="ɾ������" rendered="#{wage_setBB.oper063102}"
                                 action="#{wage_setBB.delete}"
                                 onclick="return confirmDel();"/>
                <h:commandButton styleClass="button01" value="��ѯδ����������Ա" rendered="#{wage_setBB.oper063102}"
                                 type="button" onclick="queryPersonNotInSet()"/>
            </h:panelGrid>
        </h:panelGrid>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <h:dataTable value="#{wage_setBB.setlist}" var="list"     id="setlist"
                     headerClass="td_top"  width="100%"
                     styleClass="table03"  columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle_center,td_middle_center">
            <h:column rendered="#{wage_setBB.oper063102}">
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll"
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>ȫѡ
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem"
                    value="</c:verbatim><h:outputText value="#{list.setId}"/><c:verbatim>">
            </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:graphicImage value="/images/maininterface/menu/pause.gif" rendered="#{list.noUse=='1'}"/><h:outputText value="#{list.setId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��������"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:panelGrid align="center" columns="1" cellspacing="2">
                    <h:panelGroup>
                        <h:commandButton styleClass="button01" onclick="return modifySet('#{list.setId}')"  value="�޸�����" rendered="#{wage_setBB.oper063102}">
                        </h:commandButton>

                        <h:commandButton styleClass="button01" type="button" action="#{wage_setBB.findtoPower}" onclick="setModiPower('#{list.setId}')" value="����Ȩ��" rendered="#{wage_setBB.oper063103}">
                        </h:commandButton>

                        <c:verbatim>&nbsp;</c:verbatim>
                        <h:commandButton styleClass="button01" action="#{wage_setItemBB.list}" value="����н����" rendered="#{wage_setBB.oper063104}">
                            <x:updateActionListener property="#{wage_setItemBB.item.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{wage_setItemBB.setName}" value="#{list.name}"/>
                            <x:updateActionListener property="#{wage_setItemBB.unitId}" value="#{wage_setBB.wageset.unitId}" />
                        </h:commandButton>
                        <c:verbatim>&nbsp;</c:verbatim>
                        <h:commandButton styleClass="button01" action="#{wage_setInitBB.list}" value="���ó�ʼ��" rendered="#{wage_setBB.oper063105}">
                            <x:updateActionListener property="#{wage_setInitBB.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{wage_setInitBB.setName}" value="#{list.name}"/>
                            <x:updateActionListener property="#{wage_setInitBB.unitId}" value="#{wage_setBB.wageset.unitId}"/>
                        </h:commandButton>
                    </h:panelGroup>

                    <h:panelGroup>
                        <h:commandButton styleClass="button01" action="#{wage_setPersonBB.list}" value="������Ա" rendered="#{wage_setBB.oper063106}">
                            <x:updateActionListener property="#{wage_setPersonBB.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{wage_setPersonBB.setName}" value="#{list.name}"/>
                            <x:updateActionListener property="#{wage_setPersonBB.unitId}" value="#{wage_setBB.wageset.unitId}"/>
                        </h:commandButton>
                        <c:verbatim>&nbsp;</c:verbatim>
                        <h:commandButton  styleClass="button01" type="button" value="����н�ʲ���" onclick="return doOpenWageDept('#{list.setId}');" rendered="#{wage_setBB.oper063107}"/>
                        <h:commandButton  styleClass="button01" type="button" value="н�ʲ���Ȩ��" rendered="#{wage_setBB.oper063108}" onclick="return doOpenDeptPower('#{list.setId}');" />
                    </h:panelGroup>

                    <h:panelGroup>
                        <h:commandButton  styleClass="button01" type="button" value="���Ż�������" onclick="return doWageDeptSum('#{list.setId}');" rendered="#{wage_setBB.oper063109}"/>
                        <h:commandButton  styleClass="button01" type="button" value="¼��Ȩ������" rendered="#{wage_setBB.oper063110}" onclick="return doOpenInputPower('#{list.setId}');" />
                        <h:commandButton  styleClass="button01" type="button" value="���ŷ���Ȩ��" rendered="#{wage_setBB.oper063111}" onclick="return doOpenGroupPayoffPower('#{list.setId}');" />
                    </h:panelGroup>

                    <h:panelGroup>
                        <h:commandButton  styleClass="button01" type="button" value="���յ�λ�ɷ�����"  rendered="#{wage_setBB.oper063112}" onclick="return doOrgInsuracer('#{list.setId}');" />
                        <h:commandButton  styleClass="button01" type="button" value="������λ����"  rendered="#{wage_setBB.oper063113}" onclick="return setPostLink('#{list.setId}');" />
                    </h:panelGroup>

                    <h:panelGroup>
                        <h:commandButton  styleClass="button01" value="��ʼ����"  rendered="#{(list.tryStatus=='0' || list.tryStatus=='' || list.tryStatus==null) && wage_setBB.canTestSet}" action="#{wage_setBB.beginTry}">
                            <x:updateActionListener property="#{wage_setBB.setMB}" value="#{list.setId}"/>
                         </h:commandButton>

                        <h:commandButton  styleClass="button01" value="������" onclick="return doTry('#{list.setId}');" type="button" rendered="#{list.tryStatus=='1' && wage_setBB.canTestSet}"  />
                        <h:commandButton  styleClass="button01" value="ȡ������"  rendered="#{list.tryStatus=='1' && wage_setBB.canTestSet}" onclick="if (confirm('ȷ��Ҫȡ����?')) return true;else return false;" action="#{wage_setBB.cancelTry }">
                           <x:updateActionListener property="#{wage_setBB.setMB}" value="#{list.setId}"/>
                        </h:commandButton>
                    </h:panelGroup>

                </h:panelGrid>
            </h:column>
        </h:dataTable>
<c:verbatim>
        </div>
        </td></tr>
        </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:setlist");
</script>

