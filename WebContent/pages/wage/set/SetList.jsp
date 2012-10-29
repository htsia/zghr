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
            window.open("/wage/set/PersonNotInSetQuery.jsf?act=qryPersNotInSet&" + arg, "查询未分配账套人员", "left=10,top=50,height=600,width=1000,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
        }
        function confirmDel() {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm('确定要删除吗？这样将删除所属此账套的公式项、人员和所有薪资项！'))
                    return true;
            }
            return false;
        }
        // 管理薪资部门
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
            <h:outputText escape="fasle" value="<strong>发薪单位：</strong>#{wage_setBB.unitName}"/>

            <h:panelGroup>
            <h:selectBooleanCheckbox value="#{wage_setBB.showOnlyUse}" onclick="submit();" valueChangeListener="#{wage_OrderInputBB.changeOrder}"></h:selectBooleanCheckbox>
            <h:outputText value="仅显示启用"></h:outputText>
            </h:panelGroup>

            <h:panelGrid align="right" columns="3" cellspacing="2">
                <h:commandButton styleClass="button01" value="新建账套" onclick="return addSet();" rendered="#{wage_setBB.oper063102}"/>
                <h:commandButton styleClass="button01" value="删除账套" rendered="#{wage_setBB.oper063102}"
                                 action="#{wage_setBB.delete}"
                                 onclick="return confirmDel();"/>
                <h:commandButton styleClass="button01" value="查询未分配账套人员" rendered="#{wage_setBB.oper063102}"
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
                               onclick="selectAll(document.form1.chkAll,document.form1.selectItem)"/>全选
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem"
                    value="</c:verbatim><h:outputText value="#{list.setId}"/><c:verbatim>">
            </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="编号"/></c:facet>
                <h:graphicImage value="/images/maininterface/menu/pause.gif" rendered="#{list.noUse=='1'}"/><h:outputText value="#{list.setId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="账套名称"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="更新时间"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:panelGrid align="center" columns="1" cellspacing="2">
                    <h:panelGroup>
                        <h:commandButton styleClass="button01" onclick="return modifySet('#{list.setId}')"  value="修改属性" rendered="#{wage_setBB.oper063102}">
                        </h:commandButton>

                        <h:commandButton styleClass="button01" type="button" action="#{wage_setBB.findtoPower}" onclick="setModiPower('#{list.setId}')" value="设置权限" rendered="#{wage_setBB.oper063103}">
                        </h:commandButton>

                        <c:verbatim>&nbsp;</c:verbatim>
                        <h:commandButton styleClass="button01" action="#{wage_setItemBB.list}" value="设置薪资项" rendered="#{wage_setBB.oper063104}">
                            <x:updateActionListener property="#{wage_setItemBB.item.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{wage_setItemBB.setName}" value="#{list.name}"/>
                            <x:updateActionListener property="#{wage_setItemBB.unitId}" value="#{wage_setBB.wageset.unitId}" />
                        </h:commandButton>
                        <c:verbatim>&nbsp;</c:verbatim>
                        <h:commandButton styleClass="button01" action="#{wage_setInitBB.list}" value="设置初始化" rendered="#{wage_setBB.oper063105}">
                            <x:updateActionListener property="#{wage_setInitBB.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{wage_setInitBB.setName}" value="#{list.name}"/>
                            <x:updateActionListener property="#{wage_setInitBB.unitId}" value="#{wage_setBB.wageset.unitId}"/>
                        </h:commandButton>
                    </h:panelGroup>

                    <h:panelGroup>
                        <h:commandButton styleClass="button01" action="#{wage_setPersonBB.list}" value="设置人员" rendered="#{wage_setBB.oper063106}">
                            <x:updateActionListener property="#{wage_setPersonBB.setId}" value="#{list.setId}"/>
                            <x:updateActionListener property="#{wage_setPersonBB.setName}" value="#{list.name}"/>
                            <x:updateActionListener property="#{wage_setPersonBB.unitId}" value="#{wage_setBB.wageset.unitId}"/>
                        </h:commandButton>
                        <c:verbatim>&nbsp;</c:verbatim>
                        <h:commandButton  styleClass="button01" type="button" value="管理薪资部门" onclick="return doOpenWageDept('#{list.setId}');" rendered="#{wage_setBB.oper063107}"/>
                        <h:commandButton  styleClass="button01" type="button" value="薪资部门权限" rendered="#{wage_setBB.oper063108}" onclick="return doOpenDeptPower('#{list.setId}');" />
                    </h:panelGroup>

                    <h:panelGroup>
                        <h:commandButton  styleClass="button01" type="button" value="部门汇总设置" onclick="return doWageDeptSum('#{list.setId}');" rendered="#{wage_setBB.oper063109}"/>
                        <h:commandButton  styleClass="button01" type="button" value="录入权限设置" rendered="#{wage_setBB.oper063110}" onclick="return doOpenInputPower('#{list.setId}');" />
                        <h:commandButton  styleClass="button01" type="button" value="集团发放权限" rendered="#{wage_setBB.oper063111}" onclick="return doOpenGroupPayoffPower('#{list.setId}');" />
                    </h:panelGroup>

                    <h:panelGroup>
                        <h:commandButton  styleClass="button01" type="button" value="保险单位缴费设置"  rendered="#{wage_setBB.oper063112}" onclick="return doOrgInsuracer('#{list.setId}');" />
                        <h:commandButton  styleClass="button01" type="button" value="关联岗位设置"  rendered="#{wage_setBB.oper063113}" onclick="return setPostLink('#{list.setId}');" />
                    </h:panelGroup>

                    <h:panelGroup>
                        <h:commandButton  styleClass="button01" value="开始试算"  rendered="#{(list.tryStatus=='0' || list.tryStatus=='' || list.tryStatus==null) && wage_setBB.canTestSet}" action="#{wage_setBB.beginTry}">
                            <x:updateActionListener property="#{wage_setBB.setMB}" value="#{list.setId}"/>
                         </h:commandButton>

                        <h:commandButton  styleClass="button01" value="打开试算" onclick="return doTry('#{list.setId}');" type="button" rendered="#{list.tryStatus=='1' && wage_setBB.canTestSet}"  />
                        <h:commandButton  styleClass="button01" value="取消试算"  rendered="#{list.tryStatus=='1' && wage_setBB.canTestSet}" onclick="if (confirm('确定要取消吗?')) return true;else return false;" action="#{wage_setBB.cancelTry }">
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

