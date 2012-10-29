<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doAdd(){
            if (document.all("form1:personID").value==""){
                alert("没有选择人员!")
                return false;
            }
            else{
                window.showModalDialog("/wage/set/WageInputPowerEdit.jsf?personID="+document.all("form1:personID").value+"&setID="+document.all("form1:setId").value, null, "dialogWidth:430px; dialogHeight:260px;center:center;resizable:no;status:no;scroll:no;");
                disPlayProcessBar();
                return true;
            }
        }
        function doAddView()  {
            if (document.all("form1:personID").value==""){
                alert("没有选择人员!")
                return false;
            }
            else{
                window.showModalDialog("/wage/set/WageViewPowerEdit.jsf?personID="+document.all("form1:personID").value+"&setID="+document.all("form1:setId").value, null, "dialogWidth:330px; dialogHeight:260px;center:center;resizable:no;status:no;scroll:no;");
                return true;
            }
        }
        function reFresh(){
            disPlayProcessBar();
            document.all('form1').submit();
        }
    </script>

<x:saveState value="#{wage_inputBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{wage_inputBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_inputBB.setID}"/>

    <h:panelGrid columns="1" cellspacing="2" width="98%"  align="center" >
        <h:panelGrid columns="1">
            <h:outputText escape="false" value="<strong>薪资账套：</strong>#{wage_inputBB.setName}"/>

            <h:panelGroup>
                <h:outputText value="请选择用户"></h:outputText>
                <h:selectOneMenu id="personID" value="#{wage_inputBB.personID}" onchange="reFresh();" valueChangeListener="#{wage_inputBB.changePerson}">
                    <c:selectItems value="#{wage_inputBB.personList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton value="增加录入权限" styleClass="button01" onclick="doAdd()"></h:commandButton>
                <h:commandButton value="增加查看权限" styleClass="button01" onclick="doAddView()"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:dataTable value="#{wage_inputBB.personPowerList}" var="list" align="center"   id="dateList"
                 headerClass="td_top" columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="100%" >
        <h:column>
            <c:facet name="header"><h:outputText value="有权限项目名称"/></c:facet>
            <h:outputText value="#{list.itemName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="删除" action="#{wage_inputPowerBB.delete}"   styleClass="button01" onclick="return confirm('确认删除？')">
                <x:updateActionListener property="#{wage_inputPowerBB.wbo.powerID}" value="#{list.powerID}"></x:updateActionListener>
            </h:commandButton>
        </h:column>
    </h:dataTable>
        <h:outputText escape="false" value="<font color=red>注意:不设置时代表对全部录入项目有权限</font>"></h:outputText>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
