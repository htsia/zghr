<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>



<x:saveState value="#{wage_depteditBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_depteditBB.pageInit}"/>

    <h:panelGrid align="center" width="98%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="帐套"/>
            <h:outputText value="#{wage_depteditBB.setName}"></h:outputText>

            <h:outputText value="*名称" />
            <h:inputText id="name" value="#{wage_depteditBB.wdb.name}" alt="名称|0" size="20" maxlength="20"/>

            <h:outputText value="汇总1" />
            <h:inputText id="highName" value="#{wage_depteditBB.wdb.highName}" alt="汇总1|1" size="20" maxlength="20"/>

            <h:outputText value="汇总2" />
            <h:inputText id="highName2" value="#{wage_depteditBB.wdb.highName2}" alt="汇总2|1" size="20" maxlength="20"/>

            <h:outputText value="汇总3" />
            <h:inputText id="highName3" value="#{wage_depteditBB.wdb.highName3}" alt="汇总3|1" size="20" maxlength="20"/>

            <h:outputText value="汇总4" />
            <h:inputText id="highName4" value="#{wage_depteditBB.wdb.highName4}" alt="汇总3|1" size="20" maxlength="20"/>

            <h:outputText value="汇总5" />
            <h:inputText id="highName5" value="#{wage_depteditBB.wdb.highName5}" alt="汇总4|1" size="20" maxlength="20"/>

            <h:outputText value="汇总6" />
            <h:inputText id="highName6" value="#{wage_depteditBB.wdb.highName6}" alt="汇总5|1" size="20" maxlength="20"/>

            <h:outputText value="参数1" />
            <h:inputText id="para1" value="#{wage_depteditBB.wdb.para1}" alt="参数1|1" size="20" maxlength="20"/>

            <h:outputText value="参数2" />
            <h:inputText id="para2" value="#{wage_depteditBB.wdb.para2}" alt="参数2|1" size="20" maxlength="20"/>

            <h:outputText value="薪资部门类型" />
            <h:panelGroup>
                <h:inputText id="a001758" value="#{wage_depteditBB.wdb.a001758}" code="" dict="yes" dict_num="2209" readonly="true" alt="薪资部门类型|1" size="20" maxlength="20"/>
                <c:verbatim><input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a001758')"></c:verbatim>
            </h:panelGroup>

            <h:outputText value="关联行政部门" />
            <h:panelGroup>
                <h:inputHidden id="orgIds" value="#{wage_depteditBB.wdb.linkOrgs}"></h:inputHidden>
                <h:inputText id="orgNames" readonly="true" value="#{wage_depteditBB.wdb.linkOrgNames}"></h:inputText>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpMutilOrgTwoControl(document.forms(0).all('form1:orgIds'),document.forms(0).all('form1:orgNames'),0,'');"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
        <h:outputText value="说明："/>
        <c:verbatim>&nbsp;&nbsp;&nbsp;&nbsp;薪资部门格式为:<% out.print(Constants.WAGE_DEPT_CODELEN);%>位编号+名称描述,编号仅仅表明顺序.</c:verbatim>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_depteditBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
