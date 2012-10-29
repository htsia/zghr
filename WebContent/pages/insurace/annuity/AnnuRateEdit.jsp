<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function selectUnit(){
           PopUpOrgDlg('form1:orgId',2,'');
           forsubmit(document.forms(0));
           document.forms(0).submit();
        }
        function forSelSource() {
            PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:sourceField").value,'');
            return false;
        }

        function doCheck() {
            if (document.all("form1:name").value==""){
                alert("请录入名称!");
                return false;
            }
            if (document.all("form1:desc").value==""){
                alert("请录入描述!");
                return false;
            }
            if (document.all("form1:fileExtent").value==""){
                alert("请选择文件格式!");
                return false;
            }
            //debugger;
            if (!(document.all("form1:showTitle")[1].checked || document.all("form1:showTitle")[2].checked)){
                alert("请选择是否显示标题!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{wage_unitBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_unitBB.initAnnu}"/>

    <h:panelGrid align="center" width="380">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:panelGroup>
                <h:inputText id="orgId" value="#{wage_unitBB.orgID}" readonly = "true"
                                  size="30" styleClass="input" code="" dict="yes" dict_num="OU" />
                <h:commandButton onclick="return selectUnit();" styleClass="button01" value="选择机构" action="#{wage_unitBB.selectUnit}"/>
            </h:panelGroup>

            <h:commandButton styleClass="button01" value="保存" action="#{wage_unitBB.saveAnnu}"
                             onclick="return doCheck();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="个人缴费比例(%)"/>
            <h:inputText id="annuity_Person" value="#{wage_unitBB.unit.annuity_Person}" />

            <h:outputText value="单位进入个人帐户比例(%)"/>
            <h:inputText id="annuity_Unit_Person" value="#{wage_unitBB.unit.annuity_Unit_Person}"/>

            <h:outputText value="单位进入公共帐户比例(%)"/>
            <h:inputText id="annuity_Unit" value="#{wage_unitBB.unit.annuity_Unit}"/>

        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
