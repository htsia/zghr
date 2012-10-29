<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function foradd() {
            window.showModalDialog("/wage/set/BankEdit.jsf?moduleID="+document.all("form1:moduleID").value+"&setID="+document.all("form1:setID").value, null, "dialogWidth:450px; dialogHeight:440px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModify(bankid) {
            window.showModalDialog("/wage/set/BankEdit.jsf?moduleID="+document.all("form1:moduleID").value+"&setID="+document.all("form1:setID").value+"&bankID="+bankid, null, "dialogWidth:450px; dialogHeight:440px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doModifyDate(bankid){
            window.showModalDialog("/wage/set/BankItemList.jsf?moduleID="+document.all("form1:moduleID").value+"&setID="+document.all("form1:setID").value+"&bankID="+bankid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wage_banklistBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_banklistBB.pageInit}"/>
    <h:inputHidden id="setID" value="#{wage_banklistBB.setid}"/>
    <h:inputHidden id="moduleID" value="#{wage_banklistBB.moduleID}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 薪酬管理 ->  银行格式设置"/>
        </h:panelGroup>
    </h:panelGrid>


    <h:panelGrid  width="95%" border="0" cellpadding="0" cellspacing="6" columns="1">
        <h:panelGrid  width="100%" columns="2" align="center">
            <h:panelGroup>
                <h:outputText value="所属帐套："></h:outputText>
                <h:selectOneMenu value="#{wage_banklistBB.setid}" onchange="submit()" valueChangeListener="#{wage_banklistBB.changeSet}">
                    <c:selectItems value="#{wage_banklistBB.setList}"></c:selectItems>
                </h:selectOneMenu>
            </h:panelGroup>
            <h:panelGrid align="right" columns="1" cellspacing="2" width="30%">
                <h:commandButton styleClass="button01" value="新建" onclick="foradd()" rendered="#{wage_banklistBB.operRight}"/>
            </h:panelGrid>
        </h:panelGrid>

    <h:dataTable value="#{wage_banklistBB.bankList}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="名称"/></c:facet>
            <h:outputText value="#{list.bankName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="描述"/></c:facet>
            <h:outputText value="#{list.description}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="所属帐套"/></c:facet>
            <h:outputText value="#{list.wagesetname}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="文件格式"/></c:facet>
            <h:outputText value="#{list.fileSuffix}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="删除" styleClass="button01" rendered="true"
                                 action="#{wage_banklistBB.delete}" onclick="return confirm('确认删除？')">
                    <x:updateActionListener property="#{wage_banklistBB.wcbo.bankID}" value="#{list.bankID}"/>
                </h:commandButton>
                <h:commandButton value="修改定义" onclick="forModify('#{list.bankID}')"
                                 styleClass="button01" rendered="true">
                </h:commandButton>
                <h:commandButton value="修改数据格式" onclick="doModifyDate('#{list.bankID}');" type="button"  styleClass="button01" >
                </h:commandButton>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
