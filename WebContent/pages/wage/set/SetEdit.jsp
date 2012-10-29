<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    
    <script type="text/javascript">
        function forSel(){
            PopUpMutilCodeDlgNoSubmit('form1:filterValues', 'form1:filterDes', document.all("form1:filterField").value,'');
        }
        function forSel2(){
            PopUpMutilCodeDlgNoSubmit('form1:filterValues2', 'form1:filterDes2', document.all("form1:filterField2").value,'');
        }
        function forSel3(){
            PopUpMutilCodeDlgNoSubmit('form1:filterValues3', 'form1:filterDes3', document.all("form1:filterField3").value,'');
        }

        function forCopyPersonItem(){
            reval=window.showModalDialog("/wage/set/SetWageSet.jsf?UnitID="+document.all('form1:unitId').value+"&SetID="+document.all('form1:setId').value, null, "dialogWidth:300px; dialogHeight:150px;center:center;resizable:yes;status:yes;scroll:yes;");
            if (reval != null && reval!="") {
                form1.all("form1:copySet").value = reval;
                return true;
            } else {
                return false;
            }

        }

        function selectDeptInfoItem() {
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;

            retval = window.showModalDialog("/pages/wage/base/DeptInfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                rs = retval.split("|");
                //debugger;
                document.all("form1:deptItem").value = rs[0];
                return true;
            }
            return false;
        }

        function selectInfoItem() {
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;

            retval = window.showModalDialog("/pages/wage/base/WageBaseItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                rs = retval.split("|");
                //debugger;
                document.all("form1:infoItem").value = rs[0];
                return true;
            }
            return false;
        }

    </script>

<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setBB.initAddset}" />
    <h:inputHidden value="#{wage_setBB.wageset.unitId}" id="unitId"/>
    <h:inputHidden value="#{wage_setBB.wageset.setId}" id="setId"/>
    <h:inputHidden value="#{wage_setBB.copySet}" id="copySet"/>
    <h:panelGrid align="center" width="90%" columns="1">
        <h:outputText escape="false" value="<font color='blue'><strong>基本信息</strong></font>"></h:outputText>
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="账套名称"/>
            <h:inputText id="name" value="#{wage_setBB.wageset.name}" alt="账套名称|0" size="40" maxlength="40"/>

            <h:outputText value="账套描述"/>
            <h:inputTextarea id="desc" value="#{wage_setBB.wageset.desc}" cols="60" rows="5"/>

            <h:outputText value="显示顺序"/>
            <h:inputText id="seq" value="#{wage_setBB.wageset.showseq}" alt="显示顺序|0" size="40" maxlength="40"/>

            <h:outputText value="薪资部门参数1" />
            <h:selectOneMenu id="para1" value="#{wage_setBB.wageset.paraToField1}" >
               <c:selectItems value="#{wage_setBB.b732cessList}"/>
            </h:selectOneMenu>

            <h:outputText value="薪资部门参数2" />
            <h:selectOneMenu id="para2" value="#{wage_setBB.wageset.paraToField2}" >
               <c:selectItems value="#{wage_setBB.b732cessList}"/>
            </h:selectOneMenu>
          </h:panelGrid>

        <h:outputText escape="false" value="<font color='blue'><strong>含税所得税率表</strong></font>"></h:outputText>
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
        <h:outputText value="关联第一税率表" />
        <h:selectOneMenu id="setCess" value="#{wage_setBB.wageset.cessID}" >
        <c:selectItems value="#{wage_setBB.cessList}"/>
        </h:selectOneMenu>

        <h:outputText value="计税精度" />
        <h:selectOneMenu id="setCessPrec" value="#{wage_setBB.wageset.cessprec}" >
        <c:selectItem itemLabel="分" itemValue="2"/>
        <c:selectItem itemLabel="角" itemValue="1"/>
        <c:selectItem itemLabel="元" itemValue="0"/>
        </h:selectOneMenu>

        <h:outputText value="保留算法" />
        <h:selectOneMenu id="recMethod" value="#{wage_setBB.wageset.recMethod}" >
        <c:selectItem itemLabel="截取" itemValue="1"/>
        <c:selectItem itemLabel="四舍五入" itemValue="2"/>
        </h:selectOneMenu>

        <h:outputText value="计算范围" />
        <h:panelGroup>
        <h:selectOneMenu style="width:120px;" id="filterField" value="#{wage_setBB.wageset.filterField}">
        <f:selectItems value="#{wage_setBB.filterList}"/>
        </h:selectOneMenu>
        <h:outputText value="等于"></h:outputText>
        <h:inputText id="filterDes" readonly="true" style="width:330px" value="#{wage_setBB.wageset.filterDes}"></h:inputText>
        <h:inputHidden id="filterValues" value="#{wage_setBB.wageset.filterValues}"></h:inputHidden>
        <h:commandButton id="source" type="button" styleClass="button01" value="选择"  onclick="forSel();"/>
        </h:panelGroup>

        <h:outputText value="关联第二税率表" />
        <h:selectOneMenu id="setCess2" value="#{wage_setBB.wageset.cessID2}" >
        <c:selectItems value="#{wage_setBB.cessList}"/>
        </h:selectOneMenu>

        <h:outputText value="计税精度" />
        <h:selectOneMenu id="setCessPrec2" value="#{wage_setBB.wageset.cessprec2}" >
        <c:selectItem itemLabel="分" itemValue="2"/>
        <c:selectItem itemLabel="角" itemValue="1"/>
        <c:selectItem itemLabel="元" itemValue="0"/>
        </h:selectOneMenu>

        <h:outputText value="保留算法" />
        <h:selectOneMenu id="recMethod2" value="#{wage_setBB.wageset.recMethod2}" >
        <c:selectItem itemLabel="截取" itemValue="1"/>
        <c:selectItem itemLabel="四舍五入" itemValue="2"/>
        </h:selectOneMenu>

        <h:outputText value="计算范围" />
        <h:panelGroup>
        <h:selectOneMenu style="width:120px;" id="filterField2" value="#{wage_setBB.wageset.filterField2}">
        <f:selectItems value="#{wage_setBB.filterList}"/>
        </h:selectOneMenu>
        <h:outputText value="等于"></h:outputText>
        <h:inputText id="filterDes2" readonly="true" style="width:330px" value="#{wage_setBB.wageset.filterDes2}"></h:inputText>
        <h:inputHidden id="filterValues2" value="#{wage_setBB.wageset.filterValues2}"></h:inputHidden>
        <h:commandButton id="source2" type="button" styleClass="button01" value="选择"  onclick="forSel2();"/>
        </h:panelGroup>


        <h:outputText value="关联第三税率表" />
        <h:selectOneMenu id="setCess3" value="#{wage_setBB.wageset.cessID3}" >
        <c:selectItems value="#{wage_setBB.cessList}"/>
        </h:selectOneMenu>

        <h:outputText value="计税精度" />
        <h:selectOneMenu id="setCessPrec3" value="#{wage_setBB.wageset.cessprec3}" >
        <c:selectItem itemLabel="分" itemValue="2"/>
        <c:selectItem itemLabel="角" itemValue="1"/>
        <c:selectItem itemLabel="元" itemValue="0"/>
        </h:selectOneMenu>

        <h:outputText value="保留算法" />
        <h:selectOneMenu id="recMethod3" value="#{wage_setBB.wageset.recMethod3}" >
        <c:selectItem itemLabel="截取" itemValue="1"/>
        <c:selectItem itemLabel="四舍五入" itemValue="2"/>
        </h:selectOneMenu>

        <h:outputText value="计算范围" />
        <h:panelGroup>
        <h:selectOneMenu style="width:120px;" id="filterField3" value="#{wage_setBB.wageset.filterField3}">
        <f:selectItems value="#{wage_setBB.filterList}"/>
        </h:selectOneMenu>
        <h:outputText value="等于"></h:outputText>
        <h:inputText id="filterDes3" readonly="true" style="width:330px" value="#{wage_setBB.wageset.filterDes3}"></h:inputText>
        <h:inputHidden id="filterValues3" value="#{wage_setBB.wageset.filterValues3}"></h:inputHidden>
        <h:commandButton id="source3" type="button" styleClass="button01" value="选择"  onclick="forSel3();"/>
        </h:panelGroup>
        </h:panelGrid>

        <h:outputText escape="false" value="<font color='blue'><strong>不含税所得税率表</strong></font>"></h:outputText>
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
        <h:outputText value="关联税率表" />
        <h:selectOneMenu id="setActCess" value="#{wage_setBB.wageset.actCessID}" >
        <c:selectItems value="#{wage_setBB.actcessList}"/>
        </h:selectOneMenu>
        </h:panelGrid>


        <h:outputText escape="false" value="<font color='blue'><strong>其他信息</strong></font>"></h:outputText>
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03" >
            <h:outputText value="汇总数据到上级"/>
            <h:selectOneRadio value="#{wage_setBB.wageset.bothParent}" id="bothParent" alt="汇总数据到上级|0" >
                <c:selectItem itemValue="1" itemLabel="是"/>
                <c:selectItem itemValue="0" itemLabel="否"/>
            </h:selectOneRadio>

            <h:outputText value="使用流程"/>
            <h:selectOneRadio value="#{wage_setBB.wageset.flowFlag}" id="flowFlag" alt="使用流程|0" >
                <c:selectItem itemValue="00901" itemLabel="是"/>
                <c:selectItem itemValue="00900" itemLabel="否"/>
            </h:selectOneRadio>

        <h:outputText value="集团统一发放"/>
        <h:selectOneRadio value="#{wage_setBB.wageset.groupPayoff}" id="groupPayoff" alt="集团统一发放|0">
        <c:selectItem itemValue="00901" itemLabel="是"/>
        <c:selectItem itemValue="00900" itemLabel="否"/>
        </h:selectOneRadio>

        <h:outputText value="是否停止使用"/>
        <h:selectOneRadio value="#{wage_setBB.wageset.noUse}" id="noUse" alt="是否停止使用|0">
        <c:selectItem itemValue="1" itemLabel="是"/>
        <c:selectItem itemValue="0" itemLabel="否"/>
        </h:selectOneRadio>

        <h:outputText value="启用年金计算"/>
        <h:selectOneRadio value="#{wage_setBB.wageset.annuCalc}" id="annuCalc" alt="启用年金计算|0">
        <c:selectItem itemValue="1" itemLabel="是"/>
        <c:selectItem itemValue="0" itemLabel="否"/>
        </h:selectOneRadio>

        <h:outputText value="是否合并计税"/>
        <h:selectOneRadio value="#{wage_setBB.wageset.mergeTax}" id="mergeTax" alt="是否合并计税|0">
        <c:selectItem itemValue="1" itemLabel="是"/>
        <c:selectItem itemValue="0" itemLabel="否"/>
        </h:selectOneRadio>

        <h:outputText value="复制以下帐套定义" rendered="#{wage_setBB.canCopyset}"/>
        <h:selectOneMenu id="setMB" value="#{wage_setBB.setMB}" rendered="#{wage_setBB.canCopyset}">
        <c:selectItems value="#{wage_setBB.selitem}"/>
        </h:selectOneMenu>

        <h:outputText value="帐套涉及的人员信息"></h:outputText>
        <h:panelGrid width="98%" align="center">
        <h:panelGrid width="98%" align="right">
            <h:inputHidden id="infoItem" value="#{wage_setBB.infoItem}"></h:inputHidden>
            <h:panelGroup>
               <h:commandButton value="增加"  action="#{wage_setBB.addfield}" onclick="return selectInfoItem();" styleClass="button01"></h:commandButton>
               <h:commandButton styleClass="button01" value="复制定义"
                                 action="#{wage_setBB.saveCopyPersonItem}" onclick="return forCopyPersonItem()"/>

            </h:panelGroup>
        </h:panelGrid>

        <h:dataTable value="#{wage_setBB.baseFields}" var="list" align="center"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="90%" >
            <h:column>
                <c:facet name="header"><h:outputText value="顺序"/></c:facet>
                <h:outputText value="#{list.itemSequence}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="信息集"/></c:facet>
                <h:outputText value="#{list.setId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="信息项"/></c:facet>
                <h:outputText value="#{list.itemName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                 <h:commandButton styleClass="button01" value="删除" action="#{wage_setBB.delfield}">
                     <x:updateActionListener property="#{wage_setBB.infoItem}" value="#{list.itemId}"/>
                 </h:commandButton>
                 <h:commandButton styleClass="button01" value="上移" action="#{wage_setBB.movePre}">
                     <x:updateActionListener property="#{wage_setBB.infoItem}" value="#{list.itemId}"/>
                 </h:commandButton>
                 <h:commandButton styleClass="button01" value="下移" action="#{wage_setBB.moveNext}">
                     <x:updateActionListener property="#{wage_setBB.infoItem}" value="#{list.itemId}"/>
                 </h:commandButton>
            </h:column>

        </h:dataTable>
        </h:panelGrid>

        <h:outputText value="帐套涉及的部门信息"></h:outputText>
        <h:panelGrid width="98%" align="center">
        <h:panelGrid width="98%" align="right">
            <h:inputHidden id="deptItem" value="#{wage_setBB.deptItem}"></h:inputHidden>
            <h:panelGroup>
               <h:commandButton value="增加"  action="#{wage_setBB.adddeptfield}" onclick="return selectDeptInfoItem();" styleClass="button01"></h:commandButton>
                <h:commandButton styleClass="button01" value="复制定义"
                                  action="#{wage_setBB.saveCopyDeptItem}" onclick="return forCopyPersonItem()"/>
            </h:panelGroup>
        </h:panelGrid>

        <h:dataTable value="#{wage_setBB.orgsumFields}" var="list" align="center"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="90%" >
            <h:column>
                <c:facet name="header"><h:outputText value="顺序"/></c:facet>
                <h:outputText value="#{list.itemSequence}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="信息集"/></c:facet>
                <h:outputText value="#{list.setId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="信息项"/></c:facet>
                <h:outputText value="#{list.itemName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                 <h:commandButton styleClass="button01" value="删除" action="#{wage_setBB.deldeptfield}">
                     <x:updateActionListener property="#{wage_setBB.deptItem}" value="#{list.itemId}"/>
                 </h:commandButton>
                 <h:commandButton styleClass="button01" value="上移" action="#{wage_setBB.deptmovePre}">
                     <x:updateActionListener property="#{wage_setBB.deptItem}" value="#{list.itemId}"/>
                 </h:commandButton>
                 <h:commandButton styleClass="button01" value="下移" action="#{wage_setBB.deptmoveNext}">
                     <x:updateActionListener property="#{wage_setBB.deptItem}" value="#{list.itemId}"/>
                 </h:commandButton>
            </h:column>

        </h:dataTable>
        </h:panelGrid>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_setBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

<c:verbatim escape="false">
    <script type="text/javascript">
        var flow = "";
        if (form1.all("form1:flowFlag")[1].checked) {
            flow = form1.all("form1:flowFlag")[1].value;
        } else if (form1.all("form1:flowFlag")[2].checked) {
            flow = form1.all("form1:flowFlag")[2].value;
        }
    </script>
</c:verbatim>
